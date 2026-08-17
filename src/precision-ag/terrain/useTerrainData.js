import { useEffect, useState } from 'react';
import { API_URL, authHeaders } from '../../precisionAgUtils';

/**
 * Load authenticated terrain metadata + optional elevation JSON + point overlays.
 */
export function useTerrainData(fieldId, grid = 128) {
  const [meta, setMeta] = useState(null);
  const [elevation, setElevation] = useState(null);
  const [soil, setSoil] = useState([]);
  const [scouts, setScouts] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [progress, setProgress] = useState('');

  useEffect(() => {
    if (!fieldId) {
      setMeta(null);
      setElevation(null);
      setSoil([]);
      setScouts([]);
      return undefined;
    }
    const ctrl = new AbortController();
    let cancelled = false;

    (async () => {
      setLoading(true);
      setError(null);
      setProgress('Building terrain package (DEM + imagery)…');
      try {
        const headers = authHeaders();
        const metaUrl = `${API_URL}/api/fields/${fieldId}/terrain/metadata?grid=${grid}&include_radar=true`;
        const metaRes = await fetch(metaUrl, { headers, signal: ctrl.signal });
        if (!metaRes.ok) {
          const detail = await metaRes.text().catch(() => '');
          throw new Error(detail || `Terrain metadata failed (${metaRes.status})`);
        }
        const metaJson = await metaRes.json();
        if (cancelled) return;
        setMeta(metaJson);

        setProgress('Loading elevation grid…');
        const elevRes = await fetch(
          `${API_URL}/api/fields/${fieldId}/terrain/elevation?grid=${grid}&format=json`,
          { headers, signal: ctrl.signal },
        );
        if (elevRes.ok) {
          const elevJson = await elevRes.json();
          if (!cancelled) setElevation(elevJson);
        }

        setProgress('Loading soil & scouting points…');
        const [soilRes, scoutRes] = await Promise.all([
          fetch(`${API_URL}/api/fields/${fieldId}/soil-samples`, { headers, signal: ctrl.signal }),
          fetch(`${API_URL}/api/fields/${fieldId}/scouts`, { headers, signal: ctrl.signal }),
        ]);
        if (soilRes.ok) {
          const sj = await soilRes.json();
          const rows = Array.isArray(sj) ? sj : (sj.samples || sj.soil_samples || []);
          if (!cancelled) setSoil(rows);
        }
        if (scoutRes.ok) {
          const cj = await scoutRes.json();
          const rows = Array.isArray(cj) ? cj : (cj.scouts || cj.observations || []);
          if (!cancelled) setScouts(rows);
        }
        setProgress('');
      } catch (e) {
        if (e?.name === 'AbortError') return;
        if (!cancelled) setError(String(e.message || e));
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();

    return () => {
      cancelled = true;
      ctrl.abort();
    };
  }, [fieldId, grid]);

  return { meta, elevation, soil, scouts, loading, error, progress };
}

/** Authenticated image URL for MapLibre (blob URL). */
export async function fetchTerrainImageBlob(path, signal) {
  const r = await fetch(`${API_URL}${path}`, {
    headers: authHeaders(),
    signal,
  });
  if (!r.ok) throw new Error(`Image fetch failed (${r.status})`);
  const blob = await r.blob();
  return URL.createObjectURL(blob);
}

export function terrainAssetUrl(fieldId, kind, grid = 128, layer) {
  if (kind === 'texture') return `/api/fields/${fieldId}/terrain/texture?grid=${grid}`;
  if (kind === 'dem-rgb') return `/api/fields/${fieldId}/terrain/dem-rgb?grid=${grid}`;
  if (kind === 'overlay') return `/api/fields/${fieldId}/terrain/overlay/${layer}?grid=${grid}&format=png`;
  return null;
}
