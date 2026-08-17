import React, { Suspense, lazy, useMemo, useState, useCallback, useEffect, useRef } from 'react';
import { Link } from 'react-router-dom';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, PerspectiveCamera, Html, ContactShadows } from '@react-three/drei';
import { useFieldTwinSnapshot } from './useFieldTwinSnapshot';
import { parseBoundary, boundsFromGeoJSON } from '../terrain/geojson';
import TerrainMesh from './TerrainMesh';
import CropCanopy from './CropCanopy';
import SoilCutaway, { filterLocatedSoilSamples } from './SoilCutaway';
import Atmosphere from './Atmosphere';
import Observations from './Observations';
import ScenarioHotspots from './ScenarioHotspots';
import TwinInspector from './TwinInspector';
import ScenarioStormFx from './ScenarioStormFx';
import FarmAmbience from './FarmAmbience';
import FieldWalkControls from './FieldWalkControls';
import FieldWalkStick from './FieldWalkStick';
import TwinScoreboard from './TwinScoreboard';
import { INDIA_SEASONS, monsoonPreset, canalIrrigatePreset } from './indiaSeason';
import {
  playbackPhaseLabel,
  SCENARIO_PLAYBACK_MS,
  RISK_MAP_AT,
  HOTSPOTS_AT,
  stormVisualIntensity,
  shouldShowScenarioHotspots,
} from './scenarioPlayback';
import { extractOuterRings, metersPerDegLon, sampleElevation } from './coords';
import { resolveCropStyle } from './cropCatalog';
import {
  detectTwinQuality,
  twinMaxDpr,
  twinShadowsEnabled,
  isGrowthEstimated,
  isTruckMode,
} from './twinQuality';
import { NO_BOUNDARY_ERROR } from './snapshotSchema';
import BoundaryDrawMap from './BoundaryDrawMap';
import { API_URL, authHeaders } from '../../precisionAgUtils';
import { useTerrainData } from '../terrain/useTerrainData';
import * as THREE from 'three';

const TerrainViewer = lazy(() => import('../terrain/TerrainViewer'));

/**
 * Silent MapLibre downgrade when WebGL / R3F cannot run.
 */
function MapLibreFallback({ fieldId, height = 460 }) {
  const isMobile = typeof window !== 'undefined' && window.innerWidth < 768;
  const gridSize = isMobile ? 96 : 128;
  const { meta, elevation, soil, scouts, loading, error } = useTerrainData(fieldId, gridSize);

  if (loading) {
    return (
      <div
        className="bg-white rounded-xl border border-gray-200 p-10 text-center font-mont text-sm text-gray-400 animate-pulse"
        data-testid="twin-maplibre-fallback-loading"
      >
        Loading terrain…
      </div>
    );
  }

  if (error || !meta) {
    return (
      <div
        className="bg-white rounded-xl border border-gray-200 p-6 font-mont text-sm text-gray-500"
        data-testid="twin-maplibre-fallback"
      >
        Terrain view unavailable for this field.
      </div>
    );
  }

  return (
    <div data-testid="twin-maplibre-fallback">
      <Suspense fallback={
        <div className="bg-white rounded-xl border border-gray-200 p-10 text-center font-mont text-sm text-gray-400 animate-pulse">
          Loading terrain…
        </div>
      }>
        <TerrainViewer
          fieldId={fieldId}
          meta={meta}
          elevation={elevation}
          soil={soil}
          scouts={scouts}
          height={height}
        />
      </Suspense>
    </div>
  );
}
function WalkHint({ enabled, mobile }) {
  if (!enabled) return null;
  return (
    <div className="absolute bottom-3 left-3 z-10 bg-black/60 text-white font-mont text-[11px] px-3 py-1.5 rounded-lg pointer-events-none max-w-[90%]">
      {mobile
        ? 'Walk field: on-screen stick · drag the view to look · tap Exit walk when done'
        : 'Walk field: WASD · drag to look · Esc exits'}
    </div>
  );
}

function SceneBody({
  snapshot,
  elevation,
  ndviGrid,
  ndwiGrid,
  textureUrl,
  quality,
  exaggeration,
  underground,
  showCrops,
  timeOfDay,
  hideCarpet = false,
  canopyOpacityScale = 1,
  viewPreset = 'overview',
  isScenarioSurface = false,
  surfaceTextureMeta = null,
  surfaceLayer = 'natural',
  scenarioHotspots = [],
  selectedHotspot = null,
  scenarioMeta = null,
  onSelectHotspot,
  onPick,
  onCropStats,
  stormPlayback = null,
  businessId = null,
  fieldId = null,
}) {
  const boundary = useMemo(
    () => parseBoundary(snapshot?.field?.boundary || snapshot?.terrain?.boundary),
    [snapshot],
  );
  const bbox = useMemo(() => {
    const fromGrid = snapshot?.terrain?.grid?.bbox;
    if (fromGrid?.length === 4) return fromGrid;
    return boundsFromGeoJSON(boundary);
  }, [snapshot, boundary]);

  const origin = snapshot?.local_origin;
  const windMph = snapshot?.weather?.current?.wind_mph
    ?? ((snapshot?.weather?.current?.wind_kmh ?? 10) * 0.621);
  const windDir = snapshot?.weather?.current?.wind_dir_deg ?? 180;

  const cropStyle = useMemo(() => {
    const cropKey = snapshot?.crop?.crop_key || 'default';
    const stage = snapshot?.crop?.growth?.stage;
    const indices = snapshot?.analysis?.data?.vegetation_indices || [];
    const ndvi = indices.find((i) => (i.index_type || '').toUpperCase() === 'NDVI');
    return resolveCropStyle(cropKey, stage, ndvi?.mean);
  }, [snapshot]);

  const elevMin = useMemo(() => {
    let min = Infinity;
    for (const row of elevation?.values || []) {
      for (const v of row || []) {
        if (v != null && v < min) min = v;
      }
    }
    return Number.isFinite(min) ? min : 0;
  }, [elevation]);

  const contactScale = useMemo(() => {
    if (!bbox) return 200;
    const [w, , e] = bbox;
    const widthM = Math.abs(e - w) * metersPerDegLon(origin?.latitude || 40);
    return Math.max(120, widthM * 1.4);
  }, [bbox, origin]);

  const fieldExtentM = useMemo(() => {
    if (!bbox || !origin?.latitude) return 80;
    const [w, s, e, n] = bbox;
    const widthM = Math.abs(e - w) * metersPerDegLon(origin.latitude);
    const depthM = Math.abs(n - s) * 111320;
    return Math.max(40, widthM, depthM);
  }, [bbox, origin]);

  if (!origin?.latitude || !bbox) {
    return (
      <Html center>
        <div className="font-mont text-sm text-white bg-black/50 px-4 py-2 rounded">
          Missing field boundary or origin
        </div>
      </Html>
    );
  }

  const stormPlaying = Boolean(stormPlayback?.active);
  const stormProgress = stormVisualIntensity(stormPlayback?.progress, stormPlaying);

  return (
    <>
      <Atmosphere
        weather={snapshot?.weather}
        timeOfDay={timeOfDay}
        stormActive={stormPlaying}
        stormProgress={stormProgress}
      />
      {/* Distant farm ground — soil/pasture tone, not deep forest green */}
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, -0.55, 0]} receiveShadow>
        <circleGeometry args={[2800, 64]} />
        <meshStandardMaterial color="#9a8f6e" roughness={1} metalness={0} />
      </mesh>
      <mesh rotation={[-Math.PI / 2, 0, 0]} position={[0, -0.52, 0]} receiveShadow>
        <ringGeometry args={[fieldExtentM * 0.55, fieldExtentM * 1.35, 64]} />
        <meshStandardMaterial color="#7d8f5a" roughness={1} metalness={0} />
      </mesh>
      <ContactShadows
        position={[0, -0.5, 0]}
        opacity={0.28}
        scale={contactScale}
        blur={2.4}
        far={40}
      />
      <TerrainMesh
        elevation={elevation}
        bbox={bbox}
        origin={origin}
        boundary={boundary}
        textureUrl={textureUrl}
        indexGrid={
          surfaceLayer === 'ndvi' ? ndviGrid
            : surfaceLayer === 'ndwi' ? ndwiGrid
              : null
        }
        indexKind={
          surfaceLayer === 'ndvi' || surfaceLayer === 'ndwi' ? surfaceLayer : null
        }
        soilMoistureLevel={
          ((Number(snapshot?.weather?.current?.precip_mm) > 1.3)
            || (Number(snapshot?.weather?.current?.precip_in) > 0.05))
            ? 'high'
            : (snapshot?.soil_moisture?.level || 'unknown')
        }
        exaggeration={exaggeration}
        cropTint={cropStyle.color}
        textureProvenance={surfaceTextureMeta?.provenance || null}
        textureLabel={surfaceTextureMeta?.label || null}
        textureNote={surfaceTextureMeta?.note || null}
        onPick={onPick}
      />
      {!underground && (
        <FarmAmbience
          boundary={boundary}
          origin={origin}
          bbox={bbox}
          elevation={elevation}
          exaggeration={exaggeration}
          flatFallback={Boolean(elevation?.flat_fallback)}
        />
      )}
      {showCrops && !underground && (
        <CropCanopy
          snapshot={snapshot}
          elevation={elevation}
          ndviGrid={ndviGrid}
          bbox={bbox}
          origin={origin}
          quality={quality}
          exaggeration={exaggeration}
          windMph={windMph}
          windDirDeg={windDir}
          hasImagery={!!textureUrl}
          hideCarpet={hideCarpet}
          opacityScale={canopyOpacityScale}
          viewPreset={viewPreset}
          onPick={onPick}
          onStats={onCropStats}
        />
      )}
      <SoilCutaway
        origin={origin}
        bbox={bbox}
        elevation={elevation}
        elevMin={elevMin}
        exaggeration={exaggeration}
        soilSamples={snapshot?.soil_samples?.samples || []}
        underground={underground}
        businessId={businessId}
        fieldId={fieldId}
        onPick={onPick}
      />
      <Observations
        scouts={snapshot?.scouts?.observations || []}
        origin={origin}
        elevation={elevation}
        bbox={bbox}
        elevMin={elevMin}
        exaggeration={exaggeration}
        onPick={onPick}
      />
      <ScenarioHotspots
        hotspots={scenarioHotspots}
        origin={origin}
        elevation={elevation}
        bbox={bbox}
        exaggeration={exaggeration}
        selectedHotspot={selectedHotspot}
        scenarioMeta={scenarioMeta}
        onSelectHotspot={onSelectHotspot}
        onPick={onPick}
      />
      <ScenarioStormFx
        active={stormPlaying}
        progress={stormPlayback?.progress ?? 0}
        rainfallMm={scenarioMeta?.rainfall_mm}
        irrigationMm={scenarioMeta?.irrigation_mm}
        extent={fieldExtentM}
      />
    </>
  );
}

function SceneControls({ enabled, extent, targetY, controlsRef }) {
  // When walkMode is on, orbit is fully disabled — FieldWalkControls owns the camera.
  // Damping must also turn off; otherwise update() keeps sliding the camera after keys release.
  return (
    <OrbitControls
      ref={controlsRef}
      makeDefault
      enabled={!enabled}
      enableDamping={!enabled}
      dampingFactor={0.08}
      target={[0, targetY, 0]}
      maxPolarAngle={Math.PI * 0.49}
      minPolarAngle={0.22}
      minDistance={Math.max(5, extent * 0.03)}
      maxDistance={extent * 2.4}
      panSpeed={0.85}
      rotateSpeed={0.65}
    />
  );
}

/**
 * Immersive Field Digital Twin — React Three Fiber scene.
 */
export default function FieldTwinViewer({
  fieldId,
  fieldName,
  businessId = null,
  height = 620,
  scenarioOverlayUrl = null,
  scenarioHotspots = [],
  selectedHotspot = null,
  onSelectHotspot,
  scenarioResult = null,
  onCompareScenario = null,
  onHotspotAction = null,
}) {
  const [quality, setQuality] = useState(() => detectTwinQuality({
    preferReducedMotion: typeof window !== 'undefined'
      && window.matchMedia?.('(prefers-reduced-motion: reduce)').matches,
  }));
  const [qualityManual, setQualityManual] = useState(false);
  const [truckMode, setTruckMode] = useState(() => isTruckMode());
  const [exaggeration, setExaggeration] = useState(3.2);
  const [underground, setUnderground] = useState(false);
  const [showCrops, setShowCrops] = useState(true);
  const [showAdvanced, setShowAdvanced] = useState(false);
  const [walkMode, setWalkMode] = useState(false);
  const [timeOfDay, setTimeOfDay] = useState('auto');
  const [pick, setPick] = useState(null);
  const [webglOk, setWebglOk] = useState(true);
  const [cropStats, setCropStats] = useState(null);
  const [viewEpoch, setViewEpoch] = useState(0);
  const [viewPreset, setViewPreset] = useState('canopy'); // overview | canopy — canopy first so plants read as crops, not a green carpet
  const [focusMode, setFocusMode] = useState(false);
  const [tipOpen, setTipOpen] = useState(false);
  const [preferredNdviApplied, setPreferredNdviApplied] = useState(false);
  const [selectedYear, setSelectedYear] = useState(null);
  const [confirmBusy, setConfirmBusy] = useState(false);
  const [confirmError, setConfirmError] = useState(null);
  const [snapshotReloadKey, setSnapshotReloadKey] = useState(0);
  const [draftBoundary, setDraftBoundary] = useState(null); // { geojson, center }
  const [boundarySaveBusy, setBoundarySaveBusy] = useState(false);
  const [boundarySaveError, setBoundarySaveError] = useState(null);
  const controlsRef = useRef(null);
  const walkStickRef = useRef({ x: 0, z: 0 });
  const previousSurfaceRef = useRef('ndvi');
  const playbackGenRef = useRef(0);
  const [replayKey, setReplayKey] = useState(0);
  const [playback, setPlayback] = useState({
    active: false,
    progress: 0,
  });
  const prefersReducedMotion = useMemo(
    () => typeof window !== 'undefined'
      && window.matchMedia?.('(prefers-reduced-motion: reduce)').matches,
    [],
  );

  const { snapshot, elevation, elevationStatus, ndviGrid, ndwiGrid, textureUrl, loading, fromCache, error, progress } = useFieldTwinSnapshot(
    fieldId,
    quality,
    selectedYear,
    snapshotReloadKey,
  );
  // natural | ndvi | ndwi | wetness | scenario
  const [surfaceLayer, setSurfaceLayer] = useState('natural');
  const [overlayUrl, setOverlayUrl] = useState(null);
  const [overlayError, setOverlayError] = useState(null);

  useEffect(() => {
    setSelectedYear(null);
    setConfirmError(null);
    setPreferredNdviApplied(false);
    setSurfaceLayer('natural');
    previousSurfaceRef.current = 'ndvi';
    setPlayback({ active: false, progress: 0 });
    setReplayKey(0);
    setDraftBoundary(null);
    setBoundarySaveError(null);
  }, [fieldId]);

  const handleDraftPolygon = useCallback((geojson, center) => {
    if (!geojson || !center) {
      setDraftBoundary(null);
      return;
    }
    setDraftBoundary({ geojson, center });
    setBoundarySaveError(null);
  }, []);

  const saveBoundaryAndReload = useCallback(async () => {
    if (!fieldId || !draftBoundary?.geojson || !draftBoundary?.center) return;
    const f = snapshot?.field || {};
    const biz = businessId || f.business_id;
    if (!biz) {
      setBoundarySaveError('Missing business id — cannot save boundary.');
      return;
    }
    setBoundarySaveBusy(true);
    setBoundarySaveError(null);
    try {
      const body = {
        business_id: Number(biz),
        name: f.name || fieldName || 'Field',
        address: f.address || null,
        latitude: Number(draftBoundary.center.lat),
        longitude: Number(draftBoundary.center.lng),
        field_size_hectares: f.field_size_hectares ?? null,
        crop_type: f.crop_type || null,
        planting_date: f.planting_date || null,
        boundary_geojson: JSON.stringify(draftBoundary.geojson),
        monitoring_interval_days: 5,
        alert_threshold_health: 50,
      };
      const res = await fetch(`${API_URL}/api/fields/${fieldId}`, {
        method: 'PUT',
        headers: { ...authHeaders(), 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      });
      if (!res.ok) {
        const detail = await res.text().catch(() => '');
        throw new Error(detail || `Save failed (${res.status})`);
      }
      setDraftBoundary(null);
      setSnapshotReloadKey((k) => k + 1);
    } catch (e) {
      setBoundarySaveError(String(e.message || e));
    } finally {
      setBoundarySaveBusy(false);
    }
  }, [fieldId, draftBoundary, snapshot, businessId, fieldName]);

  // Capability-based quality + resize (unless the user picks a preset manually).
  useEffect(() => {
    if (typeof window === 'undefined') return undefined;
    const apply = () => {
      setTruckMode(isTruckMode({ width: window.innerWidth }));
      if (!qualityManual) {
        setQuality(detectTwinQuality({
          width: window.innerWidth,
          preferReducedMotion: prefersReducedMotion,
        }));
      }
    };
    apply();
    window.addEventListener('resize', apply);
    return () => window.removeEventListener('resize', apply);
  }, [qualityManual, prefersReducedMotion]);

  useEffect(() => {
    // New season selection: reset preferred surface so historical years don't stick on NDVI.
    setPreferredNdviApplied(false);
  }, [selectedYear]);

  useEffect(() => {
    if (preferredNdviApplied || !snapshot || scenarioOverlayUrl) return;
    const isHistorical = Boolean(snapshot?.selection?.is_historical);
    // Historical seasons withhold current NDVI — auto-selecting it only shows a failed overlay.
    if (isHistorical || snapshot?.vegetation?.available === false
      || snapshot?.vegetation?.freshness === 'stale'
      || Number(snapshot?.vegetation?.age_days) > 14
      || Number(snapshot?.vegetation?.cloud_percent) >= 40) {
      setSurfaceLayer('natural');
      previousSurfaceRef.current = 'natural';
      setPreferredNdviApplied(true);
      return;
    }
    const hasNdvi = !!(
      snapshot?.availability?.vegetation_grid
      || snapshot?.terrain?.assets?.ndvi
      || snapshot?.vegetation?.assets?.ndvi_png
    );
    if (hasNdvi) {
      setSurfaceLayer('ndvi');
      previousSurfaceRef.current = 'ndvi';
      setPreferredNdviApplied(true);
    }
  }, [snapshot, preferredNdviApplied, scenarioOverlayUrl]);

  // Play the scenario as a short movie on the twin (weather → risk map → hotspots)
  useEffect(() => {
    if (!scenarioOverlayUrl) {
      playbackGenRef.current += 1;
      setPlayback({ active: false, progress: 0 });
      setSurfaceLayer((prev) => (
        prev === 'scenario' ? (previousSurfaceRef.current || 'natural') : prev
      ));
      return undefined;
    }

    if (prefersReducedMotion) {
      setSurfaceLayer((prev) => {
        if (prev !== 'scenario') previousSurfaceRef.current = prev;
        return 'scenario';
      });
      setPlayback({ active: false, progress: 1 });
      return undefined;
    }

    const token = playbackGenRef.current + 1;
    playbackGenRef.current = token;

    // Start on the current field surface (not risk map) so the movie has a before → after
    setSurfaceLayer((prev) => {
      if (prev !== 'scenario') previousSurfaceRef.current = prev;
      return prev === 'scenario' ? (previousSurfaceRef.current || 'ndvi') : prev;
    });
    setPlayback({ active: true, progress: 0 });

    const t0 = performance.now();
    let revealed = false;
    let lastUiProgress = -1;
    const id = window.setInterval(() => {
      if (playbackGenRef.current !== token) return;
      const p = Math.min(1, (performance.now() - t0) / SCENARIO_PLAYBACK_MS);

      // Reveal risk map once mid-movie (avoid thrashing every tick)
      if (!revealed && p >= RISK_MAP_AT) {
        revealed = true;
        setSurfaceLayer((prev) => {
          if (prev !== 'scenario') previousSurfaceRef.current = prev;
          return 'scenario';
        });
      }

      if (p >= 1) {
        window.clearInterval(id);
        setPlayback({ active: false, progress: 1 });
        setSurfaceLayer('scenario');
        return;
      }

      // Throttle React updates to ~4 Hz + phase boundaries (risk / hotspots)
      const crossedHotspots = lastUiProgress < HOTSPOTS_AT && p >= HOTSPOTS_AT;
      const crossedRisk = lastUiProgress < RISK_MAP_AT && p >= RISK_MAP_AT;
      if (!crossedHotspots && !crossedRisk && p - lastUiProgress < 0.25 && p < 0.98) return;
      lastUiProgress = p;
      setPlayback({ active: true, progress: p });
    }, 100);

    return () => {
      window.clearInterval(id);
    };
  }, [scenarioOverlayUrl, replayKey, prefersReducedMotion]);

  const replayScenario = useCallback(() => {
    if (!scenarioOverlayUrl) return;
    setReplayKey((n) => n + 1);
  }, [scenarioOverlayUrl]);

  useEffect(() => {
    if (!focusMode) return undefined;
    const onKey = (e) => {
      if (e.key === 'Escape') setFocusMode(false);
    };
    window.addEventListener('keydown', onKey);
    const prev = document.body.style.overflow;
    document.body.style.overflow = 'hidden';
    return () => {
      window.removeEventListener('keydown', onKey);
      document.body.style.overflow = prev;
    };
  }, [focusMode]);

  const overlayPaths = useMemo(() => {
    const assets = snapshot?.terrain?.assets || {};
    const veg = snapshot?.vegetation?.assets || {};
    const grid = snapshot?.rendering_hints?.preferred_grid || 96;
    const isHistorical = Boolean(snapshot?.selection?.is_historical);
    const vegOk = !isHistorical && snapshot?.vegetation?.available !== false;
    const fallback = (layer) => (
      fieldId ? `/api/fields/${fieldId}/terrain/overlay/${layer}?grid=${grid}&format=png` : null
    );
    return {
      // Prefer explicit vegetation assets; do not fall back to live overlays on historical seasons.
      ndvi: vegOk ? (veg.ndvi_png || assets.ndvi || fallback('ndvi')) : (veg.ndvi_png || null),
      ndwi: vegOk ? (veg.ndwi_png || assets.ndwi || fallback('ndwi')) : (veg.ndwi_png || null),
      wetness: snapshot?.water_risk?.overlay_url || assets.wetness_risk || fallback('wetness-risk'),
      historicalBlocked: isHistorical,
    };
  }, [snapshot, fieldId]);

  const canSelectNdvi = Boolean(overlayPaths.ndvi) || Boolean(ndviGrid?.values || ndviGrid?.grid?.values);
  const canSelectNdwi = Boolean(overlayPaths.ndwi) || Boolean(ndwiGrid?.values || ndwiGrid?.grid?.values);
  const canSelectWetness = Boolean(overlayPaths.wetness);

  // NDVI/NDWI paint from JSON grids on the DEM (clear cell look). PNG overlay
  // is only required for wetness / scenario — skip fetch so a PNG 404 doesn't
  // flash "Could not load this overlay" when the grid already works.
  const indexPaintReady = (
    (surfaceLayer === 'ndvi' && Boolean(ndviGrid?.values || ndviGrid?.grid?.values))
    || (surfaceLayer === 'ndwi' && Boolean(ndwiGrid?.values || ndwiGrid?.grid?.values))
  );

  useEffect(() => {
    if (!snapshot || surfaceLayer === 'natural' || surfaceLayer === 'scenario') {
      setOverlayUrl((prev) => {
        if (prev) {
          try { URL.revokeObjectURL(prev); } catch { /* */ }
        }
        return null;
      });
      if (surfaceLayer === 'natural' || surfaceLayer === 'scenario') setOverlayError(null);
      return undefined;
    }
    // NDVI/NDWI paint from JSON grids on the DEM — never fetch PNG (avoids false errors).
    if (surfaceLayer === 'ndvi' || surfaceLayer === 'ndwi') {
      setOverlayUrl((prev) => {
        if (prev) {
          try { URL.revokeObjectURL(prev); } catch { /* */ }
        }
        return null;
      });
      if (indexPaintReady) {
        setOverlayError(null);
      } else if (!loading) {
        const src = surfaceLayer === 'ndvi'
          ? (ndviGrid?.source || ndviGrid?.provenance)
          : (ndwiGrid?.source || ndwiGrid?.provenance);
        if (src === 'screening_estimated' || src === 'modeled') {
          setOverlayError(null);
        }
      }
      return undefined;
    }
    if (indexPaintReady) {
      setOverlayUrl((prev) => {
        if (prev) {
          try { URL.revokeObjectURL(prev); } catch { /* */ }
        }
        return null;
      });
      setOverlayError(null);
      return undefined;
    }
    const path = surfaceLayer === 'wetness'
      ? overlayPaths.wetness
      : surfaceLayer === 'ndvi'
        ? overlayPaths.ndvi
        : surfaceLayer === 'ndwi'
          ? overlayPaths.ndwi
          : null;
    if (!path) {
      setOverlayUrl((prev) => {
        if (prev) {
          try { URL.revokeObjectURL(prev); } catch { /* */ }
        }
        return null;
      });
      setOverlayError(
        overlayPaths.historicalBlocked && (surfaceLayer === 'ndvi' || surfaceLayer === 'ndwi')
          ? 'Historical season — current NDVI/NDWI overlays are withheld. Switch to Natural color or pick the current year.'
          : 'Overlay path unavailable for this field.',
      );
      // Auto-recover to natural so the twin stays usable.
      if (overlayPaths.historicalBlocked && (surfaceLayer === 'ndvi' || surfaceLayer === 'ndwi')) {
        setSurfaceLayer('natural');
      }
      return undefined;
    }
    let cancelled = false;
    let published = false;
    setOverlayError(null);
    (async () => {
      try {
        const { fetchTerrainImageBlob } = await import('../terrain/useTerrainData');
        const blob = await fetchTerrainImageBlob(path);
        if (cancelled) {
          try { URL.revokeObjectURL(blob); } catch { /* */ }
          return;
        }
        published = true;
        setOverlayUrl((prev) => {
          if (prev && prev !== blob) {
            try { URL.revokeObjectURL(prev); } catch { /* */ }
          }
          return blob;
        });
      } catch (e) {
        console.warn('[field-twin] overlay failed', surfaceLayer, e);
        if (!cancelled) {
          setOverlayError('Could not load this overlay — try again or switch back to Natural color.');
          setOverlayUrl((prev) => {
            if (prev) {
              try { URL.revokeObjectURL(prev); } catch { /* */ }
            }
            return null;
          });
        }
      }
    })();
    return () => {
      cancelled = true;
      if (!published) {
        /* in-flight blob revoked above when cancelled after resolve */
      }
    };
  }, [snapshot, surfaceLayer, overlayPaths, indexPaintReady]);

  const activeTexture = surfaceLayer === 'scenario' && scenarioOverlayUrl
    ? scenarioOverlayUrl
    : surfaceLayer === 'natural'
      ? textureUrl
      // While an index layer is selected, never silently fall back to natural RGB —
      // that made NDVI/NDWI look identical to Natural color.
      : (overlayUrl || null);
  const indexSurface = surfaceLayer === 'ndvi'
    || surfaceLayer === 'ndwi'
    || surfaceLayer === 'wetness'
    || surfaceLayer === 'scenario';
  const canopyOpacityScale = surfaceLayer === 'scenario'
    ? 0.18
    : (indexSurface
      // Index overlays must read clearly — dense canopy was hiding NDVI/NDWI.
      ? 0.12
      : playback.active
        ? Math.max(0.3, 0.9 - playback.progress * 0.5)
        : 1);
  const hotspotsVisible = shouldShowScenarioHotspots({
    hasOverlay: Boolean(scenarioOverlayUrl),
    hotspotCount: scenarioHotspots.length,
    active: playback.active,
    progress: playback.progress,
    surfaceLayer,
  });
  const canvasHeight = focusMode
    ? Math.max(520, (typeof window !== 'undefined' ? window.innerHeight : 800) - 120)
    : Math.max(height, typeof window !== 'undefined' && window.innerWidth >= 768 ? Math.min(720, Math.round(window.innerHeight * 0.62)) : height);

  const walkBbox = useMemo(() => {
    const fromGrid = snapshot?.terrain?.grid?.bbox;
    if (fromGrid?.length === 4) return fromGrid;
    return boundsFromGeoJSON(
      parseBoundary(snapshot?.field?.boundary || snapshot?.terrain?.boundary),
    );
  }, [snapshot]);

  const scenarioMeta = useMemo(() => {
    if (!scenarioResult) return null;
    // CropMonitor returns assumed inputs under `scenario`; older shapes used `inputs`
    const inputs = scenarioResult.scenario || scenarioResult.inputs || {};
    return {
      ...scenarioResult,
      rainfall_mm: inputs.rainfall_mm ?? scenarioResult.rainfall_mm,
      irrigation_mm: inputs.irrigation_mm ?? scenarioResult.irrigation_mm,
      duration_hours: inputs.duration_hours ?? scenarioResult.duration_hours,
    };
  }, [scenarioResult]);

  const surfaceTextureMeta = useMemo(() => {
    if (surfaceLayer === 'scenario') {
      return {
        label: 'Scenario water-risk surface',
        note: scenarioMeta?.accuracy_statement
          || 'Modeled relative ponding / access-risk overlay — screening-grade only.',
        provenance: 'modeled',
      };
    }
    if (surfaceLayer === 'ndvi') {
      return {
        label: 'NDVI surface (derived)',
        note: 'Sentinel-2 NDVI colormap draped on DEM — red = stressed, green = healthy.',
        provenance: 'derived',
      };
    }
    if (surfaceLayer === 'ndwi') {
      return {
        label: 'NDWI surface (derived)',
        note: 'Sentinel-2 NDWI colormap draped on DEM — brown = dry, blue = wetter canopy/soil.',
        provenance: 'derived',
      };
    }
    if (surfaceLayer === 'wetness') {
      return {
        label: 'Wetness-risk surface (derived)',
        note: 'Topographic wetness / screening overlay — not measured flood depth.',
        provenance: 'derived',
      };
    }
    return {
      label: null,
      note: null,
      provenance: null,
    };
  }, [surfaceLayer, scenarioMeta]);

  useEffect(() => {
    try {
      const c = document.createElement('canvas');
      const gl = c.getContext('webgl2') || c.getContext('webgl');
      if (!gl) setWebglOk(false);
    } catch {
      setWebglOk(false);
    }
  }, []);

  const onPick = useCallback((info) => setPick(info), []);
  const onCropStats = useCallback((stats) => setCropStats(stats), []);

  const confirmCropChoice = useCallback(async (choice) => {
    if (!fieldId || !snapshot) return;
    const seasonYear = snapshot.selection?.effective_year
      || selectedYear
      || new Date().getFullYear();
    const candidates = snapshot.crop?.candidates || {};
    setConfirmBusy(true);
    setConfirmError(null);
    try {
      const res = await fetch(`${API_URL}/api/fields/${fieldId}/crop-resolution`, {
        method: 'POST',
        headers: { ...authHeaders(), 'Content-Type': 'application/json' },
        body: JSON.stringify({
          season_year: seasonYear,
          choice,
          expected_recorded_crop: candidates.rotation?.crop
            || candidates.field_record?.crop
            || snapshot.crop?.recorded_crop_type
            || null,
        }),
      });
      if (res.status === 409) {
        const detail = await res.json().catch(() => ({}));
        const msg = detail?.detail?.message || detail?.detail || 'Crop data changed — reload and try again.';
        throw new Error(typeof msg === 'string' ? msg : 'Crop data changed — reload and try again.');
      }
      if (!res.ok) {
        const detail = await res.text().catch(() => '');
        throw new Error(detail || `Confirmation failed (${res.status})`);
      }
      setSelectedYear(seasonYear);
      setSnapshotReloadKey((k) => k + 1);
    } catch (err) {
      setConfirmError(String(err.message || err));
    } finally {
      setConfirmBusy(false);
    }
  }, [fieldId, snapshot, selectedYear]);

  const sceneFrame = useMemo(() => {
    const boundary = parseBoundary(snapshot?.field?.boundary || snapshot?.terrain?.boundary);
    const bbox = snapshot?.terrain?.grid?.bbox || boundsFromGeoJSON(boundary);
    const origin = snapshot?.local_origin;
    if (!bbox || !origin?.latitude || !origin?.longitude) {
      return { extent: 80, targetY: 0, relief: 10 };
    }

    const [w, s, e, n] = bbox;
    const widthM = Math.abs(e - w) * metersPerDegLon(origin.latitude);
    const depthM = Math.abs(n - s) * 111320;
    const extent = Math.max(60, widthM, depthM);

    let min = Infinity;
    let max = -Infinity;
    for (const row of elevation?.values || []) {
      for (const value of row || []) {
        if (value == null || !Number.isFinite(value)) continue;
        min = Math.min(min, value);
        max = Math.max(max, value);
      }
    }
    if (!Number.isFinite(min)) min = 0;
    if (!Number.isFinite(max)) max = min;

    const centerElevation = sampleElevation(
      elevation?.values,
      bbox,
      origin.longitude,
      origin.latitude,
    );
    const targetY = Math.max(0, ((centerElevation ?? min) - min) * exaggeration);
    return {
      extent,
      targetY,
      relief: Math.max(2, (max - min) * exaggeration),
    };
  }, [snapshot, elevation, exaggeration]);

  // Overview: higher + farther so the parcel reads as a farm field, not a forest tunnel.
  // Flat DEM fallback: pull in closer so procedural plants aren't tiny dots on a green slab.
  const camPos = useMemo(() => {
    const { extent, targetY, relief } = sceneFrame;
    const flat = Boolean(elevation?.flat_fallback);
    if (walkMode) {
      return [0, targetY + 1.7, Math.max(5, extent * 0.08)];
    }
    if (underground) {
      return [extent * 0.4, Math.max(3, relief * 0.35), extent * 0.5];
    }
    if (viewPreset === 'canopy') {
      const dist = Math.max(flat ? 14 : 22, extent * (flat ? 0.28 : 0.42));
      return [
        dist * 0.85,
        Math.max(flat ? 6 : 12, targetY + Math.max(relief * 0.55, extent * (flat ? 0.1 : 0.18))),
        dist * 1.05,
      ];
    }
    const dist = Math.max(flat ? 28 : 40, extent * (flat ? 0.5 : 0.68));
    return [
      dist * 0.65,
      Math.max(flat ? 14 : 22, targetY + Math.max(relief * 0.85, extent * (flat ? 0.26 : 0.38))),
      dist * 0.82,
    ];
  }, [walkMode, underground, sceneFrame, viewPreset, elevation?.flat_fallback]);

  const controlTargetY = underground
    ? -0.45
    : sceneFrame.targetY + (walkMode ? 1.25 : Math.min(4, sceneFrame.relief * 0.15));

  const hasPolygon = extractOuterRings(
    snapshot?.field?.boundary || snapshot?.terrain?.boundary,
  ).length > 0;

  const exitWalkMode = useCallback(() => setWalkMode(false), []);

  const resetView = useCallback(() => {
    setWalkMode(false);
    setUnderground(false);
    setViewPreset('canopy');
    setViewEpoch((n) => n + 1);
  }, []);

  if (!webglOk) {
    return <MapLibreFallback fieldId={fieldId} height={height} />;
  }

  const locatedSoilCount = filterLocatedSoilSamples(snapshot?.soil_samples?.samples || []).length;
  const hasLocatedSoil = locatedSoilCount > 0;
  const growthEstimated = isGrowthEstimated(snapshot?.crop?.growth);
  const vegUnusable = Boolean(
    snapshot
    && (
      snapshot.vegetation?.freshness === 'stale'
      || Number(snapshot.vegetation?.age_days) > 14
      || Number(snapshot.vegetation?.cloud_percent) >= 40
    ),
  );
  const cropConfirmed = Boolean(snapshot?.crop?.confirmed);
  const screeningDem = Boolean(
    snapshot?.availability?.screening_dem
    || ['open_meteo_elevation', 'screening_bowl', 'screening_local'].includes(elevation?.source)
    || String(snapshot?.terrain?.source || '').toLowerCase().includes('screening')
    || String(snapshot?.terrain?.source || '').toLowerCase().includes('open_meteo'),
  );

  return (
    <div className={focusMode ? 'fixed inset-0 z-[10050] bg-[#0f1410] p-3 flex flex-col gap-2' : 'space-y-3'}>
      {!focusMode && (
        <div className="bg-[#F7F3EA] border border-[#E5DFD0] rounded-xl px-4 py-2 font-mont text-xs text-gray-700 flex items-start justify-between gap-3">
          <div>
            {truckMode ? (
              <>
                Pinch/drag the field · tap a hotspot for scout / work order.
                Use monsoon vs canal/borewell what-ifs before you drive. Walk with the on-screen stick.
              </>
            ) : (
              <>
                Drag to orbit · scroll to zoom · click the field for details.
                Use <strong>Walk field</strong> (WASD or stick) to stand in the crop.
                Run monsoon vs canal/borewell what-ifs to compare water risk (rough model, not a schedule).
              </>
            )}
            {tipOpen && (
              <span className="block mt-1 text-gray-600">
                Canopy follows the recorded / confirmed crop (grower or rotation — no USDA crop map).
                Heights are boosted in overview so the crop is readable — not measured plant stature.
                Soil profile shows GPS-located lab cores only — never invented geology.
                Water need uses weather-model millimetres (not a soil probe). Yellow = modeled · blue = satellite-derived · purple = recorded.
              </span>
            )}
          </div>
          <button
            type="button"
            onClick={() => setTipOpen((v) => !v)}
            className="shrink-0 text-[10px] font-semibold uppercase tracking-wide text-gray-500 hover:text-gray-800"
          >
            {tipOpen ? 'Less' : 'More'}
          </button>
        </div>
      )}

      <div className={`bg-white rounded-xl border border-gray-200 p-3 flex flex-wrap gap-3 items-end ${focusMode ? 'shrink-0' : ''}`}>
        {showAdvanced && (
        <>
        <div className="flex flex-col gap-1">
          <label className="text-[10px] font-mont font-semibold text-gray-500 uppercase">Quality</label>
          <select
            value={quality}
            onChange={(e) => {
              setQualityManual(true);
              setQuality(e.target.value);
            }}
            className="border border-gray-300 rounded-lg text-sm font-mont px-2 py-1.5"
          >
            <option value="high">High</option>
            <option value="medium">Medium</option>
            <option value="low">Low</option>
          </select>
        </div>
        <div className="flex flex-col gap-1 min-w-[140px]">
          <label className="text-[10px] font-mont font-semibold text-gray-500 uppercase">
            Relief {exaggeration.toFixed(1)}×
          </label>
          <input
            type="range"
            min={1}
            max={6}
            step={0.1}
            value={exaggeration}
            onChange={(e) => setExaggeration(Number(e.target.value))}
          />
        </div>
        </>
        )}
        <button
          type="button"
          onClick={() => setShowAdvanced((v) => !v)}
          className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border border-gray-200 text-gray-600 bg-white"
        >
          {showAdvanced ? 'Hide advanced' : 'Advanced'}
        </button>
        <div className="flex flex-col gap-1">
          <label className="text-[10px] font-mont font-semibold text-gray-500 uppercase">Time</label>
          <select
            value={timeOfDay}
            onChange={(e) => setTimeOfDay(e.target.value)}
            className="border border-gray-300 rounded-lg text-sm font-mont px-2 py-1.5"
          >
            <option value="auto">Day</option>
            <option value="noon">Noon</option>
            <option value="dusk">Dusk</option>
            <option value="night">Night</option>
          </select>
        </div>
        <div className="flex flex-col gap-1">
          <label className="text-[10px] font-mont font-semibold text-gray-500 uppercase">Surface</label>
          <select
            value={surfaceLayer}
            onChange={(e) => setSurfaceLayer(e.target.value)}
            disabled={playback.active}
            className="border border-gray-300 rounded-lg text-sm font-mont px-2 py-1.5"
            title={playback.active
              ? 'Surface changes are locked while the scenario plays'
              : 'Natural color vs derived index overlays'}
          >
            <option value="natural">Natural color</option>
            <option
              value="ndvi"
              disabled={!canSelectNdvi}
              title={
                canSelectNdvi
                  ? undefined
                  : (snapshot?.selection?.is_historical
                    ? 'NDVI withheld for historical seasons'
                    : 'NDVI overlay unavailable')
              }
            >
              NDVI{snapshot?.selection?.is_historical ? ' (current season only)' : ''}
            </option>
            <option
              value="ndwi"
              disabled={!canSelectNdwi}
              title={
                canSelectNdwi
                  ? undefined
                  : (snapshot?.selection?.is_historical
                    ? 'NDWI withheld for historical seasons'
                    : 'NDWI overlay unavailable')
              }
            >
              NDWI{snapshot?.selection?.is_historical ? ' (current season only)' : ''}
            </option>
            <option value="wetness" disabled={!canSelectWetness}>
              Wetness risk
            </option>
            <option
              value="scenario"
              disabled={!scenarioOverlayUrl}
              title={scenarioOverlayUrl ? undefined : 'Run Simulate water below first'}
            >
              Scenario risk{scenarioOverlayUrl ? '' : ' (run simulator)'}
            </option>
          </select>
        </div>
        <button
          type="button"
          onClick={() => {
            setViewPreset((v) => (v === 'overview' ? 'canopy' : 'overview'));
            setWalkMode(false);
            setUnderground(false);
            setViewEpoch((n) => n + 1);
          }}
          className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border"
          style={{
            background: viewPreset === 'canopy' ? '#0F766E' : 'white',
            color: viewPreset === 'canopy' ? 'white' : '#4B5563',
            borderColor: viewPreset === 'canopy' ? '#0F766E' : '#E5E7EB',
          }}
          title="Toggle between whole-field overview and close canopy view"
          aria-pressed={viewPreset === 'canopy'}
        >
          {viewPreset === 'canopy' ? 'Canopy view' : 'Overview'}
        </button>
        <button
          type="button"
          onClick={(e) => {
            setWalkMode((v) => !v);
            setUnderground(false);
            setViewEpoch((n) => n + 1);
            // Blur so WASD/Space aren't eaten by the focused button after click.
            e.currentTarget.blur();
          }}
          className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border"
          style={{
            background: walkMode ? '#0F766E' : 'white',
            color: walkMode ? 'white' : '#4B5563',
            borderColor: walkMode ? '#0F766E' : '#E5E7EB',
          }}
          title="Walk the field at eye height (WASD or on-screen stick). Esc exits."
          aria-pressed={walkMode}
        >
          {walkMode ? 'Exit walk' : 'Walk field'}
        </button>
        <button
          type="button"
          onClick={() => { setUnderground((v) => !v); if (!underground) setWalkMode(false); setViewEpoch((n) => n + 1); }}
          className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border"
          style={{
            background: underground ? '#92400E' : 'white',
            color: underground ? 'white' : '#4B5563',
            borderColor: underground ? '#92400E' : '#E5E7EB',
          }}
          title="Measured soil cores only — no invented geology"
          aria-pressed={underground}
        >
          {underground ? 'Soil profile on' : 'Soil profile'}
        </button>
        <button
          type="button"
          onClick={() => {
            if (!snapshot?.crop?.confirmed) return;
            setShowCrops((v) => {
              if (v) setCropStats(null);
              return !v;
            });
          }}
          disabled={!snapshot?.crop?.confirmed}
          className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border disabled:opacity-50"
          style={{
            background: showCrops && snapshot?.crop?.confirmed ? '#3D6B34' : 'white',
            color: showCrops && snapshot?.crop?.confirmed ? 'white' : '#4B5563',
            borderColor: showCrops && snapshot?.crop?.confirmed ? '#3D6B34' : '#E5E7EB',
          }}
          title={snapshot?.crop?.confirmed ? undefined : 'Confirm crop before canopy'}
        >
          {!snapshot?.crop?.confirmed ? 'Canopy locked' : (showCrops ? 'Canopy on' : 'Canopy off')}
        </button>
        <button
          type="button"
          onClick={() => setFocusMode((v) => !v)}
          className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border"
          style={{
            background: focusMode ? '#1E3A5F' : 'white',
            color: focusMode ? 'white' : '#4B5563',
            borderColor: focusMode ? '#1E3A5F' : '#E5E7EB',
          }}
          title="Expand the twin over the page (Esc to exit)"
        >
          {focusMode ? 'Exit focus' : 'Focus view'}
        </button>
        <button
          type="button"
          onClick={resetView}
          className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border border-gray-200 text-gray-600 bg-white hover:bg-gray-50"
        >
          Reset view
        </button>
      </div>

      {loading && !snapshot && (
        <div className="bg-white rounded-xl border border-gray-200 p-8 text-center font-mont text-sm text-gray-500 animate-pulse">
          {progress || 'Building field twin…'}
        </div>
      )}
      {loading && snapshot && (
        <div className="bg-sky-50 border border-sky-100 text-sky-900 rounded-lg px-3 py-1.5 font-mont text-[11px]">
          {fromCache ? 'Refreshing live twin — showing last good view' : (progress || 'Updating…')}
        </div>
      )}
      {!loading && fromCache && snapshot && !error && (
        <div className="bg-amber-50 border border-amber-100 text-amber-950 rounded-lg px-3 py-1.5 font-mont text-[11px]">
          Showing cached twin — live refresh failed or timed out. Numbers may be stale.
        </div>
      )}
      {snapshot && !error && vegUnusable && (
        <div className="bg-amber-100 border border-amber-300 text-amber-950 rounded-lg px-3 py-2 font-mont text-[12px]" data-testid="twin-stale-imagery">
          Satellite is {snapshot.vegetation?.age_days != null ? `${snapshot.vegetation.age_days} days old` : 'stale or cloudy'}.
          Pretty green is hidden. Do not spray from this map — walk the crop or wait for a clearer scene.
        </div>
      )}
      {snapshot && !error && screeningDem && (
        <div className="bg-stone-100 border border-stone-200 text-stone-800 rounded-lg px-3 py-1.5 font-mont text-[11px]" data-testid="twin-screening-dem">
          Heights are screening DEM (Open-Meteo / modeled), not Crop Monitor survey lidar. Ponding paths are relative.
        </div>
      )}
      {error && !loading && (
        error === NO_BOUNDARY_ERROR ? (
          <div
            className="bg-amber-50 border border-amber-200 text-amber-950 rounded-xl p-5 font-mont text-sm space-y-3"
            data-testid="twin-boundary-required"
          >
            <div>
              <div className="font-semibold text-amber-900 mb-1">Boundary required for Field Twin</div>
              <p className="text-amber-900/90 leading-relaxed">{error}</p>
              {(snapshot?.field?.name || fieldName || snapshot?.field?.address) && (
                <p className="mt-2 text-amber-900/80 text-xs">
                  {snapshot?.field?.name || fieldName || 'Field'}
                  {snapshot?.field?.address ? ` · ${snapshot.field.address}` : ''}
                </p>
              )}
            </div>

            {(() => {
              const lat = snapshot?.field?.latitude ?? snapshot?.local_origin?.latitude;
              const lon = snapshot?.field?.longitude ?? snapshot?.local_origin?.longitude;
              const address = snapshot?.field?.address || null;
              const canDrawHere = (
                (Number.isFinite(Number(lat)) && Number.isFinite(Number(lon)))
                || Boolean(address && String(address).trim())
              );
              if (!canDrawHere) {
                return businessId && fieldId ? (
                  <Link
                    to={`/precision-ag/analyses?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(fieldId)}`}
                    className="inline-flex items-center px-3 py-2 rounded-lg bg-[#1E3A5F] text-white text-xs font-semibold hover:bg-[#162d4a]"
                  >
                    Open Field Detail to draw boundary
                  </Link>
                ) : null;
              }
              return (
                <div className="space-y-3">
                  <BoundaryDrawMap
                    lat={lat}
                    lon={lon}
                    address={address}
                    height={Math.min(420, Math.max(280, (height || 620) - 160))}
                    onPolygon={handleDraftPolygon}
                  />
                  {boundarySaveError ? (
                    <p className="text-red-700 text-xs">{boundarySaveError}</p>
                  ) : null}
                  <div className="flex flex-wrap items-center gap-2">
                    <button
                      type="button"
                      data-testid="twin-boundary-save"
                      disabled={!draftBoundary || boundarySaveBusy}
                      onClick={saveBoundaryAndReload}
                      className="inline-flex items-center px-3 py-2 rounded-lg bg-[#1E3A5F] text-white text-xs font-semibold hover:bg-[#162d4a] disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      {boundarySaveBusy ? 'Saving…' : 'Save boundary'}
                    </button>
                    {businessId && fieldId ? (
                      <Link
                        to={`/precision-ag/analyses?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(fieldId)}`}
                        className="inline-flex items-center px-3 py-2 rounded-lg border border-amber-300 text-amber-950 text-xs font-semibold hover:bg-amber-100/60"
                      >
                        Open Field Detail instead
                      </Link>
                    ) : null}
                  </div>
                </div>
              );
            })()}
          </div>
        ) : (
          <div className="bg-red-50 border border-red-200 text-red-800 rounded-xl p-4 font-mont text-sm">
            {error}
          </div>
        )
      )}

      {snapshot && !error && !focusMode && !truckMode && (
        <TwinScoreboard
          snapshot={snapshot}
          scenarioMeta={scenarioMeta}
          fieldId={fieldId}
          businessId={businessId}
          truckMode={truckMode}
          refreshing={loading && fromCache}
          onWalkField={() => {
            setWalkMode(true);
            setUnderground(false);
            setViewEpoch((n) => n + 1);
          }}
          onRunRainOnly={() => {
            const seasonId = snapshot?.selection?.india_season?.id;
            const p = monsoonPreset(seasonId);
            onCompareScenario?.({
              ...p,
              infiltration_class: snapshot?.infiltration?.infiltration_class || p.infiltration_class,
            });
          }}
          onRunMonsoon={() => {
            onCompareScenario?.({
              rainfall_mm: 80,
              irrigation_mm: 0,
              duration_hours: 6,
              infiltration_class: snapshot?.infiltration?.infiltration_class || 'moderate',
              antecedent: 'wet',
              label: 'monsoon_burst',
            });
          }}
          onRunIrrigate={() => {
            const p = canalIrrigatePreset();
            onCompareScenario?.({
              ...p,
              infiltration_class: snapshot?.infiltration?.infiltration_class || p.infiltration_class,
            });
          }}
          onScoutWorstHotspot={() => {
            const list = scenarioHotspots || [];
            if (!list.length) return;
            const ranked = [...list].sort((a, b) => Number(b.risk || 0) - Number(a.risk || 0));
            const worst = ranked[0];
            onSelectHotspot?.(worst);
            setPick({
              kind: 'scenario_hotspot',
              label: `Water-risk hotspot #${worst.index ?? 1}`,
              provenance: 'modeled',
              confidence: scenarioMeta?.confidence?.grade || 'screening',
              risk: worst.risk,
              band: worst.band,
              latitude: worst.latitude,
              longitude: worst.longitude,
              rainfall_mm: scenarioMeta?.rainfall_mm,
              irrigation_mm: scenarioMeta?.irrigation_mm,
              duration_hours: scenarioMeta?.duration_hours,
              access_risk: scenarioMeta?.summary?.access_risk,
              note: scenarioMeta?.accuracy_statement
                || 'Modeled relative water-risk hotspot — screening-grade only, verify on site.',
            });
          }}
          onLoggedRain={() => {
            try {
              sessionStorage.removeItem(`oft:twin-snap:v3:${fieldId}:current`);
            } catch { /* ignore */ }
            setSnapshotReloadKey((n) => n + 1);
          }}
        />
      )}

      {snapshot && !error && (
        <div className={`grid gap-3 ${focusMode ? 'flex-1 min-h-0 grid-cols-1 xl:grid-cols-[minmax(0,1fr)_300px]' : 'grid-cols-1 xl:grid-cols-[minmax(0,1fr)_320px]'}`}>
          <div
            className="relative rounded-xl overflow-hidden border border-gray-200 shadow-sm"
            style={{ height: canvasHeight, minHeight: focusMode ? 480 : 420, background: '#87CEEB' }}
            data-testid="field-twin-canvas-wrap"
          >
            <Canvas
              key={`twin-${fieldId}-${viewEpoch}-${focusMode ? 'f' : 'n'}`}
              shadows={twinShadowsEnabled(quality)}
              dpr={[1, twinMaxDpr(quality)]}
              gl={{
                antialias: quality !== 'low',
                powerPreference: quality === 'low' ? 'low-power' : 'high-performance',
                alpha: false,
              }}
              onCreated={({ gl }) => {
                gl.setClearColor('#87CEEB');
                gl.toneMapping = THREE.ACESFilmicToneMapping;
                gl.toneMappingExposure = 1.12;
              }}
            >
              <PerspectiveCamera
                makeDefault
                // While walking, leave position alone — FieldWalkControls owns it.
                // Re-applying camPos on parent re-renders was fighting the walker.
                position={walkMode ? undefined : camPos}
                fov={walkMode ? 70 : 42}
                near={0.1}
                far={Math.max(4000, sceneFrame.extent * 14)}
              />
              <SceneControls
                enabled={walkMode}
                extent={sceneFrame.extent}
                targetY={controlTargetY}
                controlsRef={controlsRef}
              />
              {walkMode && (
                <FieldWalkControls
                  active={walkMode}
                  elevation={elevation}
                  bbox={walkBbox}
                  origin={snapshot?.local_origin}
                  extent={sceneFrame.extent}
                  exaggeration={exaggeration}
                  onExit={exitWalkMode}
                  stickRef={walkStickRef}
                />
              )}
              <Suspense fallback={null}>
                <SceneBody
                  snapshot={snapshot}
                  elevation={elevation}
                  ndviGrid={vegUnusable ? null : ndviGrid}
                  ndwiGrid={ndwiGrid}
                  textureUrl={activeTexture}
                  quality={quality}
                  exaggeration={exaggeration}
                  underground={underground}
                  showCrops={showCrops && cropConfirmed}
                  timeOfDay={timeOfDay}
                  hideCarpet={indexSurface}
                  canopyOpacityScale={canopyOpacityScale}
                  viewPreset={viewPreset}
                  isScenarioSurface={surfaceLayer === 'scenario'}
                  surfaceTextureMeta={surfaceTextureMeta}
                  surfaceLayer={surfaceLayer}
                  scenarioHotspots={hotspotsVisible ? scenarioHotspots : []}
                  selectedHotspot={selectedHotspot}
                  scenarioMeta={scenarioMeta}
                  onSelectHotspot={onSelectHotspot}
                  onPick={onPick}
                  onCropStats={onCropStats}
                  stormPlayback={playback}
                  businessId={businessId}
                  fieldId={fieldId}
                />
              </Suspense>
            </Canvas>
            <WalkHint enabled={walkMode} mobile={truckMode} />
            <FieldWalkStick stickRef={walkStickRef} visible={walkMode && truckMode} />
            {playback.active && (
              <div
                className={`absolute left-3 right-3 sm:right-auto sm:w-[230px] z-20 bg-black/80 text-white font-mont text-[11px] px-3 py-2 rounded-lg pointer-events-none shadow-lg ${walkMode ? 'bottom-12' : 'bottom-3'}`}
                role="status"
                aria-live="polite"
              >
                <div className="font-semibold text-sky-200 uppercase tracking-wide text-[10px]">
                  Scenario playing
                </div>
                <div className="mt-0.5 opacity-95">{playbackPhaseLabel(playback.progress)}</div>
                <div className="mt-2 h-1.5 rounded-full bg-white/20 overflow-hidden">
                  <div
                    className="h-full rounded-full bg-sky-400"
                    style={{ width: `${Math.round(playback.progress * 100)}%` }}
                  />
                </div>
              </div>
            )}
            {scenarioOverlayUrl && !playback.active && playback.progress >= 1 && (
              <div className={`absolute left-3 z-20 ${walkMode ? 'bottom-12' : 'bottom-3'}`}>
                <button
                  type="button"
                  onClick={replayScenario}
                  className="bg-black/75 hover:bg-black/85 text-white font-mont text-[11px] font-semibold px-3 py-1.5 rounded-lg border border-white/15"
                >
                  Replay scenario
                </button>
              </div>
            )}
            <div className={`absolute top-3 left-3 z-10 bg-black/65 text-white font-mont text-[11px] px-2.5 py-1.5 rounded-lg pointer-events-none max-w-[70%] ${playback.active ? 'hidden' : ''}`}>
              <div className="font-semibold">
                {fieldName || snapshot.field?.name || 'Field'}
                {' · '}
                {snapshot.crop?.crop_type || snapshot.crop?.recorded_crop_type || 'crop'}
                {snapshot.crop?.selected_source ? ` (${snapshot.crop.selected_source.replace(/_/g, ' ')})` : ''}
              </div>
              <div className="opacity-90 mt-0.5">
                {underground
                  ? (hasLocatedSoil
                    ? `Soil profile · ${locatedSoilCount} measured core${locatedSoilCount === 1 ? '' : 's'}`
                    : 'Underground · no soil data yet')
                  : playback.active
                    ? playbackPhaseLabel(playback.progress)
                    : surfaceLayer === 'scenario'
                      ? 'Scenario risk (modeled · screening-grade)'
                      : surfaceLayer === 'wetness'
                        ? 'Wetness overlay (derived)'
                        : surfaceLayer === 'ndvi'
                          ? `NDVI overlay (${
                            ndviGrid?.source === 'local_analysis'
                              ? 'stored analysis'
                              : ndviGrid?.source === 'screening_estimated'
                                ? 'screening estimate'
                                : 'derived'
                          })`
                          : surfaceLayer === 'ndwi'
                            ? `NDWI overlay (${
                              ndwiGrid?.source === 'local_analysis'
                                ? 'stored analysis'
                                : ndwiGrid?.source === 'screening_estimated'
                                  ? 'screening estimate'
                                  : 'derived'
                            })`
                            : viewPreset === 'canopy'
                              ? 'Inside the stand'
                              : 'Field overview'}
                {growthEstimated && !underground && !playback.active
                  ? ' · Growth estimated'
                  : ''}
                {cropStats?.visualSampleCount && !playback.active && !underground
                  ? ` · ${cropStats.visualSampleCount.toLocaleString()} display plants (not a count)`
                  : ''}
                {cropStats?.spatialNdvi && surfaceLayer !== 'scenario' && !playback.active && !underground ? ' · greenness-driven' : ''}
              </div>
            </div>
            {surfaceLayer === 'scenario' && scenarioMeta && !playback.active && (
              <div className="absolute bottom-3 right-3 z-10 bg-black/75 text-white font-mont text-[10px] px-2.5 py-2 rounded-lg pointer-events-none max-w-[240px]">
                <div className="font-semibold uppercase tracking-wide text-amber-200">Modeled · rough guess</div>
                <div className="mt-1 opacity-95">
                  {(() => {
                    const rIn = scenarioMeta.rainfall_mm != null ? (Number(scenarioMeta.rainfall_mm) / 25.4).toFixed(1) : '—';
                    const iIn = scenarioMeta.irrigation_mm != null ? (Number(scenarioMeta.irrigation_mm) / 25.4).toFixed(1) : null;
                    return (
                      <>
                        Rain {rIn} in
                        {iIn != null ? ` · irrig ${iIn} in` : ''}
                        {scenarioMeta.duration_hours != null ? ` · ${scenarioMeta.duration_hours} h` : ''}
                      </>
                    );
                  })()}
                </div>
                <div className="opacity-80 text-[9px] mt-0.5">
                  ({scenarioMeta.rainfall_mm ?? '—'} mm
                  {scenarioMeta.irrigation_mm != null ? ` · ${scenarioMeta.irrigation_mm} mm irrig` : ''})
                </div>
                <div className="opacity-90 mt-1">
                  Driveability {scenarioMeta.summary?.access_risk || '—'}
                  {scenarioMeta.confidence?.grade ? ` · ${scenarioMeta.confidence.grade} confidence` : ''}
                </div>
                <div className="flex items-center gap-1.5 mt-1.5">
                  <span className="w-16 h-2 rounded" style={{ background: 'linear-gradient(90deg,#2563eb,#ca8a04,#ea580c,#b91c1c)' }} />
                </div>
                <div className="flex justify-between mt-0.5 opacity-90">
                  <span>Less concern</span>
                  <span>Check first</span>
                </div>
              </div>
            )}
            {surfaceLayer === 'scenario' && playback.active && playback.progress >= RISK_MAP_AT && (
              <div className="absolute bottom-3 right-3 z-10 bg-black/70 text-white font-mont text-[10px] px-2.5 py-2 rounded-lg pointer-events-none">
                <div className="font-semibold text-amber-200 mb-1">Risk map forming</div>
                <div className="flex items-center gap-1.5">
                  <span className="w-16 h-2 rounded" style={{ background: 'linear-gradient(90deg,#2563eb,#ca8a04,#ea580c,#b91c1c)' }} />
                </div>
                <div className="flex justify-between mt-0.5 opacity-90">
                  <span>Low</span>
                  <span>Severe</span>
                </div>
              </div>
            )}
            {surfaceLayer === 'ndvi' && !playback.active && (
              <div className="absolute bottom-3 right-3 z-10 bg-black/70 text-white font-mont text-[10px] px-2.5 py-2 rounded-lg pointer-events-none">
                <div className="font-semibold mb-1">NDVI</div>
                <div className="flex items-center gap-1.5">
                  <span className="w-16 h-2 rounded" style={{ background: 'linear-gradient(90deg,#b91c1c,#eab308,#16a34a)' }} />
                </div>
                <div className="flex justify-between mt-0.5 opacity-90">
                  <span>Stressed</span>
                  <span>Healthy</span>
                </div>
              </div>
            )}
            {surfaceLayer === 'ndwi' && !playback.active && (
              <div className="absolute bottom-3 right-3 z-10 bg-black/70 text-white font-mont text-[10px] px-2.5 py-2 rounded-lg pointer-events-none">
                <div className="font-semibold mb-1">NDWI</div>
                <div className="flex items-center gap-1.5">
                  <span className="w-16 h-2 rounded" style={{ background: 'linear-gradient(90deg,#78350f,#67e8f9,#0369a1)' }} />
                </div>
                <div className="flex justify-between mt-0.5 opacity-90">
                  <span>Dry</span>
                  <span>Wet</span>
                </div>
              </div>
            )}
            {!elevation?.values && elevationStatus === 'loading' && (
              <div className="absolute inset-0 flex items-center justify-center bg-black/30 pointer-events-none">
                <div className="bg-white/90 rounded-lg px-4 py-2 font-mont text-sm text-gray-700">
                  Loading elevation surface…
                </div>
              </div>
            )}
            {elevation?.flat_fallback && elevationStatus === 'unavailable' && (
              <div className="absolute bottom-3 left-3 z-10 bg-black/75 text-white font-mont text-[10px] px-2.5 py-1.5 rounded-lg pointer-events-none max-w-[260px]">
                Flat stand-in — elevation grid failed to load. Relief and ponding paths are approximate.
              </div>
            )}
            {elevation?.values && !elevation?.flat_fallback && elevation?.source === 'open_meteo_elevation' && (
              <div className="absolute bottom-3 left-3 z-10 bg-black/60 text-white font-mont text-[10px] px-2.5 py-1.5 rounded-lg pointer-events-none max-w-[260px]">
                DEM from Open-Meteo (coarse heights) — not survey/lidar.
              </div>
            )}
            {elevation?.values && !elevation?.flat_fallback && elevation?.source === 'screening_bowl' && (
              <div className="absolute bottom-3 left-3 z-10 bg-black/60 text-amber-100 font-mont text-[10px] px-2.5 py-1.5 rounded-lg pointer-events-none max-w-[260px]">
                Modeled bowl DEM — Open-Meteo heights unavailable for this field.
              </div>
            )}
            {surfaceLayer === 'ndvi' && ndviGrid?.source === 'screening_estimated' && (
              <div className="absolute bottom-12 left-3 z-10 bg-black/65 text-amber-100 font-mont text-[10px] px-2.5 py-1.5 rounded-lg pointer-events-none max-w-[280px]">
                NDVI pattern is illustrative — not Sentinel pixels. Run Analysis for a real satellite map.
              </div>
            )}
            {!loading && !canSelectNdvi && snapshot && !snapshot?.selection?.is_historical && (
              <div className="absolute bottom-3 right-3 z-10 bg-black/70 text-white font-mont text-[10px] px-2.5 py-1.5 rounded-lg pointer-events-none max-w-[200px]">
                No NDVI map for this field yet — natural color only.
              </div>
            )}
            {overlayError && surfaceLayer !== 'natural' && surfaceLayer !== 'scenario' && (
              <div className="absolute top-14 left-3 z-20 bg-amber-900/85 text-amber-50 font-mont text-[11px] px-3 py-2 rounded-lg max-w-[260px]">
                {overlayError}
              </div>
            )}
          </div>
          <TwinInspector
            pick={pick}
            snapshot={snapshot}
            onClose={() => setPick(null)}
            businessId={businessId}
            fieldId={fieldId}
            onHotspotAction={onHotspotAction}
          />
        </div>
      )}

      {!loading && snapshot && !focusMode && snapshot.crop?.validation?.requires_confirmation && (
        <div className="rounded-xl border border-amber-200 bg-amber-50 p-3 space-y-2">
          <div className="font-mont text-[10px] font-semibold uppercase tracking-wide text-amber-800">
            Crop confirmation required
            {snapshot.selection?.effective_year ? ` · ${snapshot.selection.effective_year}` : ''}
          </div>
          <p className="font-mont text-[11px] text-amber-900">
            {snapshot.crop.validation.note
              || 'Confirm which recorded crop the twin should use for this season.'}
          </p>
          <div className="flex flex-wrap gap-2">
            {(snapshot.crop.candidates?.rotation?.crop || snapshot.crop.candidates?.field_record?.crop) && (
              <button
                type="button"
                disabled={confirmBusy}
                onClick={() => confirmCropChoice(
                  snapshot.crop.candidates?.rotation?.crop ? 'crop_rotation' : 'field_record',
                )}
                className="px-2.5 py-1 rounded-md bg-emerald-700 text-white font-mont text-[11px] disabled:opacity-50"
              >
                Use recorded ({snapshot.crop.candidates?.rotation?.crop || snapshot.crop.candidates?.field_record?.crop})
              </button>
            )}
          </div>
          {confirmError && (
            <p className="font-mont text-[11px] text-red-700">{confirmError}</p>
          )}
        </div>
      )}

      {!loading && snapshot && !focusMode && (
        <div className="bg-white rounded-xl border border-gray-200 p-3 space-y-2">
          <div className="font-mont text-[10px] font-semibold uppercase tracking-wide text-gray-500">
            India season
          </div>
          <div className="flex gap-1.5 overflow-x-auto pb-1">
            {INDIA_SEASONS.map((s) => {
              const active = (snapshot.selection?.india_season?.id || '').toLowerCase() === s.id;
              return (
                <button
                  key={s.id}
                  type="button"
                  onClick={() => onCompareScenario?.({
                    ...monsoonPreset(s.id),
                    infiltration_class: snapshot?.infiltration?.infiltration_class || 'moderate',
                  })}
                  className={`shrink-0 min-w-[88px] rounded-lg border px-2 py-1.5 text-left ${
                    active
                      ? 'border-emerald-500 bg-emerald-100 ring-1 ring-emerald-400'
                      : 'border-gray-200 bg-gray-50 hover:bg-white'
                  }`}
                  title={`${s.label} ${s.months} — replay typical rain`}
                >
                  <div className="font-mont text-[10px] text-gray-500">{s.months}</div>
                  <div className="font-mont text-[11px] font-semibold text-gray-900">{s.label}</div>
                </button>
              );
            })}
          </div>
        </div>
      )}

      {!loading && snapshot && !focusMode && ((snapshot.timeline || []).length > 0 || (snapshot.crop_history?.cdl_years || []).length > 0) && (
        <div className="bg-white rounded-xl border border-gray-200 p-3 space-y-3">
          <div className="font-mont text-[10px] font-semibold uppercase tracking-wide text-gray-500">
            Season timeline
            {snapshot.selection?.is_historical ? ' · historical' : ''}
            {snapshot.selection?.effective_year ? ` · ${snapshot.selection.effective_year}` : ''}
          </div>
          <div className="flex gap-1.5 overflow-x-auto pb-1">
            <button
              type="button"
              onClick={() => setSelectedYear(null)}
              className={`shrink-0 min-w-[76px] rounded-lg border px-2 py-1.5 text-left transition-colors ${
                selectedYear == null && !snapshot.selection?.is_historical
                  ? 'border-emerald-500 bg-emerald-100 ring-1 ring-emerald-400'
                  : 'border-emerald-100 bg-white hover:bg-emerald-50'
              }`}
              title="Current season (live NDVI / weather when available)"
            >
              <div className="font-mont text-[10px] text-emerald-800/80">Now</div>
              <div className="font-mont text-[11px] font-semibold text-emerald-950">This season</div>
            </button>
            {(snapshot.timeline?.length
              ? snapshot.timeline
              : (snapshot.crop_history?.cdl_years || []).map((row) => ({
                year: row.year,
                cdl: { crop: row.crop },
                recorded: null,
              }))
            ).slice(0, 12).map((row) => {
              const active = (selectedYear ?? snapshot.selection?.effective_year) === row.year;
              const label = row.recorded?.crop || row.cdl?.crop || row.decision?.selected_crop || '—';
              return (
                <button
                  key={row.year}
                  type="button"
                  onClick={() => setSelectedYear(row.year)}
                  className={`shrink-0 min-w-[76px] rounded-lg border px-2 py-1.5 text-left transition-colors ${
                    active
                      ? 'border-emerald-500 bg-emerald-100 ring-1 ring-emerald-400'
                      : 'border-emerald-100 bg-emerald-50/70 hover:bg-emerald-50'
                  }`}
                  title={label}
                >
                  <div className="font-mont text-[10px] text-emerald-800/80">{row.year}</div>
                  <div className="font-mont text-[11px] font-semibold text-emerald-950 truncate max-w-[88px]">
                    {label}
                  </div>
                </button>
              );
            })}
          </div>
          {!snapshot.crop?.validation?.requires_confirmation && snapshot.crop?.validation?.note && (
            <p className="font-mont text-[11px] text-gray-500">{snapshot.crop.validation.note}</p>
          )}
          {snapshot.selection?.is_historical && (
            <p className="font-mont text-[11px] text-violet-800 bg-violet-50 border border-violet-100 rounded-lg px-2 py-1.5">
              Historical season — canopy follows that year&apos;s crop; current NDVI and unmatched imagery are off.
            </p>
          )}
        </div>
      )}

      {!loading && snapshot && !focusMode && (
        <div className="flex flex-wrap gap-2 font-mont text-[11px] text-gray-600">
          <span className={`px-2 py-0.5 rounded border ${hasPolygon ? 'bg-green-50 text-green-800 border-green-100' : 'bg-amber-50 text-amber-800 border-amber-100'}`}>
            Boundary {hasPolygon ? '✓' : 'bbox only'}
          </span>
          <span className="px-2 py-0.5 rounded bg-blue-50 text-blue-800 border border-blue-100">
            DEM {snapshot.availability?.terrain ? '✓' : '—'}
          </span>
          <span className="px-2 py-0.5 rounded bg-blue-50 text-blue-800 border border-blue-100">
            Imagery {textureUrl ? '✓' : '—'}
          </span>
          <span className={`px-2 py-0.5 rounded border ${ndviGrid?.values ? 'bg-blue-50 text-blue-800 border-blue-100' : 'bg-amber-50 text-amber-800 border-amber-100'}`}>
            NDVI grid {ndviGrid?.values ? '✓' : '—'}
            {snapshot.vegetation?.acquired_at
              ? ` · ${String(snapshot.vegetation.acquired_at).slice(0, 10)}`
              : ''}
          </span>
          <span className={`px-2 py-0.5 rounded border ${snapshot.crop?.validation?.status === 'matched' || snapshot.crop?.validation?.status === 'confirmed' ? 'bg-green-50 text-green-800 border-green-100' : snapshot.crop?.validation?.status === 'mismatch' ? 'bg-amber-50 text-amber-800 border-amber-100' : 'bg-violet-50 text-violet-800 border-violet-100'}`}>
            {snapshot.crop?.crop_type || '—'}
            {snapshot.crop?.selected_source ? ` · ${snapshot.crop.selected_source}` : ''}
            {snapshot.crop?.validation?.status === 'mismatch' ? ' · needs confirm' : ''}
          </span>
          {(snapshot.crop_history?.cdl_years || []).length > 0 && (
            <span className="px-2 py-0.5 rounded bg-emerald-50 text-emerald-900 border border-emerald-100">
              Crop history {(snapshot.crop_history.cdl_years || []).length} yrs
            </span>
          )}
          <span className={`px-2 py-0.5 rounded border ${hasLocatedSoil ? 'bg-amber-50 text-amber-900 border-amber-100' : 'bg-gray-50 text-gray-600 border-gray-100'}`}>
            Soil {hasLocatedSoil
              ? `${locatedSoilCount} measured core${locatedSoilCount === 1 ? '' : 's'}`
              : 'no samples'}
            {snapshot.soil_samples?.unlocated_count
              ? ` · ${snapshot.soil_samples.unlocated_count} unlocated`
              : ''}
          </span>
          <span className="px-2 py-0.5 rounded bg-green-50 text-green-800 border border-green-100">
            Canopy {underground
              ? 'hidden'
              : !cropConfirmed
                ? 'locked'
              : showCrops
                ? (cropStats?.visualSampleCount
                  ? `${cropStats.visualSampleCount.toLocaleString()} samples`
                  : 'on')
                : 'off'}
          </span>
          <span className="px-2 py-0.5 rounded bg-pink-50 text-pink-800 border border-pink-100">
            Scouts {snapshot.scouts?.count || 0}
          </span>
          {scenarioOverlayUrl && (
            <span className="px-2 py-0.5 rounded bg-amber-50 text-amber-900 border border-amber-200">
              Scenario risk on · {(scenarioHotspots || []).length} hotspots
              {scenarioMeta?.summary?.access_risk ? ` · access ${scenarioMeta.summary.access_risk}` : ''}
            </span>
          )}
          {snapshot.water_use?.available && (
            <span className="px-2 py-0.5 rounded bg-sky-50 text-sky-900 border border-sky-100">
              Water use{' '}
              {snapshot.water_use.eta_mm != null
                ? `${Number(snapshot.water_use.eta_mm).toFixed(0)} mm ET`
                : '✓'}
              {snapshot.water_use.period_date ? ` · ${snapshot.water_use.period_date}` : ''}
            </span>
          )}
          {snapshot.irrigation?.recommendation && (
            <span className="px-2 py-0.5 rounded bg-sky-50 text-sky-900 border border-sky-100" title={snapshot.irrigation.note || ''}>
              {snapshot.irrigation.deficit_mm != null
                ? `Water need ~${Number(snapshot.irrigation.deficit_mm).toFixed(0)} mm short (est.)`
                : snapshot.irrigation.recommendation}
            </span>
          )}
        </div>
      )}
    </div>
  );
}
