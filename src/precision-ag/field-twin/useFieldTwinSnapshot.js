import { useEffect, useRef, useState } from 'react';
import { API_URL, authHeaders } from '../../precisionAgUtils';
import { fetchTerrainImageBlob } from '../terrain/useTerrainData';
import { boundsFromGeoJSON } from '../terrain/geojson';
import { validateTwinSnapshot, NO_BOUNDARY_ERROR } from './snapshotSchema';
import { readTwinSnapshotCache, writeTwinSnapshotCache } from './twinSnapshotCache';

/**
 * Flat DEM stand-in when CropMonitor elevation is unavailable.
 * Keeps TerrainMesh / canopy placement working without a forever "Loading…" overlay.
 */
export function buildFlatElevationFallback(snap, gridSize = 32) {
  const n = Math.max(8, Math.min(64, Number(gridSize) || 32));
  const bbox = snap?.terrain?.grid?.bbox
    || boundsFromGeoJSON(snap?.field?.boundary || snap?.terrain?.boundary);
  const origin = snap?.local_origin || {};
  const z = Number.isFinite(Number(origin.elevation))
    ? Number(origin.elevation)
    : (Number.isFinite(Number(snap?.field?.elevation)) ? Number(snap.field.elevation) : 0);
  const values = Array.from({ length: n }, () => Array.from({ length: n }, () => z));
  return {
    values,
    rows: n,
    cols: n,
    bbox: bbox || null,
    flat_fallback: true,
    provenance: 'modeled',
    note: 'DEM unavailable — showing a flat field surface.',
  };
}

/**
 * Load the authenticated twin snapshot + elevation grid + crop texture + NDVI grid.
 * After the snapshot resolves, elevation / NDVI / texture fetch concurrently
 * (Promise.allSettled) so one soft failure does not cancel the others.
 * @param {number|string|null} fieldId
 * @param {string} quality
 * @param {number|null} year  Season year for crop timeline (null = current year on server)
 */
export function useFieldTwinSnapshot(fieldId, quality = 'medium', year = null, reloadKey = 0) {
  const [snapshot, setSnapshot] = useState(null);
  const [elevation, setElevation] = useState(null);
  const [elevationStatus, setElevationStatus] = useState('idle'); // idle|loading|ready|unavailable
  const [ndviGrid, setNdviGrid] = useState(null);
  const [ndwiGrid, setNdwiGrid] = useState(null);
  const [textureUrl, setTextureUrl] = useState(null);
  const [loading, setLoading] = useState(false);
  const [fromCache, setFromCache] = useState(false);
  const [error, setError] = useState(null);
  const [progress, setProgress] = useState('');
  const textureUrlRef = useRef(null);

  useEffect(() => {
    if (!fieldId) {
      setSnapshot(null);
      setElevation(null);
      setElevationStatus('idle');
      setNdviGrid(null);
      setNdwiGrid(null);
      setFromCache(false);
      setTextureUrl((prev) => {
        if (prev) {
          try { URL.revokeObjectURL(prev); } catch { /* */ }
        }
        textureUrlRef.current = null;
        return null;
      });
      return undefined;
    }
    const ctrl = new AbortController();
    let cancelled = false;
    let timedOut = false;
    // High quality can wait longer for DEM metadata; still fail closed so the UI
    // never sits on "Loading field twin snapshot…" forever if the API deadlocks.
    const timeoutMs = quality === 'high' ? 90000 : 60000;
    const timeoutId = setTimeout(() => {
      timedOut = true;
      ctrl.abort();
    }, timeoutMs);

    (async () => {
      setLoading(true);
      // Do not clear NO_BOUNDARY_ERROR here — clearing it unmounts BoundaryDrawMap
      // while Leaflet still owns DOM nodes and can white-screen the app.
      const cached = readTwinSnapshotCache(fieldId, year);
      let liveSnap = null;
      if (cached) {
        const shape = validateTwinSnapshot(cached);
        if (shape.ok || shape.error === NO_BOUNDARY_ERROR) {
          setSnapshot(cached);
          setFromCache(true);
          if (shape.error === NO_BOUNDARY_ERROR) setError(NO_BOUNDARY_ERROR);
          setProgress('Refreshing field twin…');
        } else {
          setProgress('Loading field twin snapshot…');
        }
      } else {
        setFromCache(false);
        setProgress('Loading field twin snapshot…');
      }
      setElevation(null);
      setElevationStatus('loading');
      try {
        const headers = authHeaders();
        const gridHint = quality === 'high' ? 128 : quality === 'low' ? 64 : 96;
        const yearParam = year != null && Number.isFinite(Number(year)) ? `&year=${Number(year)}` : '';
        const snapRes = await fetch(
          `${API_URL}/api/fields/${fieldId}/twin-snapshot?grid=${gridHint}&weather_days=21${yearParam}`,
          { headers, signal: ctrl.signal },
        );
        if (!snapRes.ok) {
          const detail = await snapRes.text().catch(() => '');
          throw new Error(detail || `Twin snapshot failed (${snapRes.status})`);
        }
        const snap = await snapRes.json();
        if (cancelled) return;

        const shape = validateTwinSnapshot(snap);
        if (!shape.ok) {
          // Keep field meta (name/address/lat/lon) so Field Twin can show an
          // inline boundary drawer without an extra fields round-trip.
          if (shape.error === NO_BOUNDARY_ERROR) {
            liveSnap = snap;
            setSnapshot(snap);
            writeTwinSnapshotCache(fieldId, year, snap);
            setFromCache(false);
            setElevationStatus('unavailable');
            setProgress('');
            setError(shape.error);
            return;
          }
          if (!cached) setSnapshot(null);
          throw new Error(shape.error);
        }

        liveSnap = snap;
        setSnapshot(snap);
        writeTwinSnapshotCache(fieldId, year, snap);
        setFromCache(false);
        setError(null);

        const elevPath = snap?.terrain?.assets?.elevation
          || `/api/fields/${fieldId}/terrain/elevation?grid=${gridHint}&format=json`;
        const isHistorical = Boolean(snap?.selection?.is_historical);
        const ndviPath = snap?.vegetation?.assets?.ndvi_json
          || snap?.terrain?.assets?.ndvi_json
          || `/api/fields/${fieldId}/terrain/overlay/ndvi?grid=${gridHint}&format=json`;
        const ndwiPath = snap?.vegetation?.assets?.ndwi_json
          || snap?.terrain?.assets?.ndwi_json
          || `/api/fields/${fieldId}/terrain/overlay/ndwi?grid=${gridHint}&format=json`;
        const texMatched = snap?.terrain?.texture?.year_matched !== false;
        const texPath = snap?.terrain?.assets?.texture
          || ((!isHistorical && texMatched)
            ? `/api/fields/${fieldId}/terrain/texture?grid=${gridHint}`
            : null);
        const shouldLoadNdvi = !isHistorical && snap?.vegetation?.available !== false;
        const shouldLoadNdwi = shouldLoadNdvi;
        const shouldLoadTexture = Boolean(texPath && (!isHistorical || texMatched));

        setProgress('Loading elevation, vegetation & imagery…');

        const loadElevation = async () => {
          // Always attempt elevation when we have a path — CropMonitor may lack
          // /terrain/* but the JWT proxy now returns Open-Meteo / screening DEM.
          if (!elevPath) return null;
          try {
            const elevRes = await fetch(`${API_URL}${elevPath}`, { headers, signal: ctrl.signal });
            if (elevRes.ok) {
              const json = await elevRes.json();
              if (json?.values?.length) return json;
            }
            console.warn('[field-twin] elevation HTTP', elevRes.status);
            return null;
          } catch (elevErr) {
            if (elevErr?.name === 'AbortError') throw elevErr;
            console.warn('[field-twin] elevation unavailable', elevErr);
            return null;
          }
        };

        const loadIndexJson = async (path, label) => {
          try {
            const res = await fetch(`${API_URL}${path}`, { headers, signal: ctrl.signal });
            if (res.ok) return res.json();
            return null;
          } catch (err) {
            if (err?.name === 'AbortError') throw err;
            console.warn(`[field-twin] ${label} grid unavailable`, err);
            return null;
          }
        };

        const loadNdvi = async () => {
          if (!shouldLoadNdvi) return null;
          return loadIndexJson(ndviPath, 'NDVI');
        };

        const loadNdwi = async () => {
          if (!shouldLoadNdwi) return null;
          return loadIndexJson(ndwiPath, 'NDWI');
        };

        const loadTexture = async () => {
          if (!shouldLoadTexture) return null;
          try {
            return await fetchTerrainImageBlob(texPath, ctrl.signal);
          } catch (texErr) {
            if (texErr?.name === 'AbortError') throw texErr;
            console.warn('[field-twin] texture unavailable', texErr);
            return null;
          }
        };

        const [elevSettled, ndviSettled, ndwiSettled, texSettled] = await Promise.allSettled([
          loadElevation(),
          loadNdvi(),
          loadNdwi(),
          loadTexture(),
        ]);

        if (cancelled) {
          if (texSettled.status === 'fulfilled' && typeof texSettled.value === 'string') {
            try { URL.revokeObjectURL(texSettled.value); } catch { /* */ }
          }
          return;
        }

        const aborted = [elevSettled, ndviSettled, ndwiSettled, texSettled].some(
          (s) => s.status === 'rejected' && s.reason?.name === 'AbortError',
        );
        if (aborted) {
          if (texSettled.status === 'fulfilled' && typeof texSettled.value === 'string') {
            try { URL.revokeObjectURL(texSettled.value); } catch { /* */ }
          }
          return;
        }

        if (elevSettled.status === 'fulfilled' && elevSettled.value?.values?.length) {
          setElevation(elevSettled.value);
          setElevationStatus('ready');
        } else {
          const flat = buildFlatElevationFallback(snap, Math.min(48, gridHint));
          setElevation(flat);
          setElevationStatus('unavailable');
        }

        if (!shouldLoadNdvi) {
          setNdviGrid(null);
        } else if (ndviSettled.status === 'fulfilled') {
          setNdviGrid(ndviSettled.value);
        } else {
          setNdviGrid(null);
        }

        if (!shouldLoadNdwi) {
          setNdwiGrid(null);
        } else if (ndwiSettled.status === 'fulfilled') {
          setNdwiGrid(ndwiSettled.value);
        } else {
          setNdwiGrid(null);
        }

        if (!shouldLoadTexture) {
          setTextureUrl((prev) => {
            if (prev) {
              try { URL.revokeObjectURL(prev); } catch { /* */ }
            }
            textureUrlRef.current = null;
            return null;
          });
        } else if (texSettled.status === 'fulfilled' && typeof texSettled.value === 'string') {
          const blobUrl = texSettled.value;
          setTextureUrl((prev) => {
            if (prev && prev !== blobUrl) {
              try { URL.revokeObjectURL(prev); } catch { /* */ }
            }
            textureUrlRef.current = blobUrl;
            return blobUrl;
          });
        } else {
          setTextureUrl((prev) => {
            if (prev) {
              try { URL.revokeObjectURL(prev); } catch { /* */ }
            }
            textureUrlRef.current = null;
            return null;
          });
        }

        setProgress('');
      } catch (e) {
        if (e?.name === 'AbortError') {
          if (timedOut && !cancelled) {
            setProgress('');
            const snapForFlat = liveSnap || cached;
            if (snapForFlat && validateTwinSnapshot(snapForFlat).ok) {
              setElevation(buildFlatElevationFallback(snapForFlat, 32));
              setElevationStatus('unavailable');
            } else {
              setElevationStatus('unavailable');
            }
            // Keep cached snapshot if live never arrived — farmer can still work.
            if (!liveSnap && !cached) {
              setError(
                'Field Twin timed out loading the snapshot. Try Quality: Medium and reload, or restart the local API.',
              );
            } else if (!liveSnap && cached) {
              setFromCache(true);
              setError(null);
            }
            setLoading(false);
          }
          return;
        }
        if (!cancelled) {
          setProgress('');
          const snapForFlat = liveSnap || cached;
          if (snapForFlat && validateTwinSnapshot(snapForFlat).ok) {
            setElevation(buildFlatElevationFallback(snapForFlat, 32));
            setElevationStatus('unavailable');
          } else {
            setElevationStatus('unavailable');
          }
          if (!liveSnap && cached) {
            setFromCache(true);
            setError(null);
          } else if (!liveSnap) {
            setError(String(e.message || e));
          }
        }
      } finally {
        clearTimeout(timeoutId);
        if (!cancelled) setLoading(false);
      }
    })();

    return () => {
      cancelled = true;
      clearTimeout(timeoutId);
      ctrl.abort();
      // Do not revoke textureUrlRef here while a newer effect may still publish
      // a replacement — only revoke orphaned URLs that never made it into state.
    };
  }, [fieldId, quality, year, reloadKey]);

  useEffect(() => () => {
    if (textureUrlRef.current) {
      try { URL.revokeObjectURL(textureUrlRef.current); } catch { /* */ }
      textureUrlRef.current = null;
    }
  }, []);

  return {
    snapshot,
    elevation,
    elevationStatus,
    ndviGrid,
    ndwiGrid,
    textureUrl,
    loading,
    fromCache,
    error,
    progress,
  };
}
