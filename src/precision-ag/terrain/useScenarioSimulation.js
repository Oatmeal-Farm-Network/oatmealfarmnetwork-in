import { useCallback, useEffect, useRef, useState } from 'react';
import { API_URL, authHeaders } from '../../precisionAgUtils';

/**
 * Debounced, abortable water-scenario simulation against the authenticated API.
 */

const LOCAL_SCENARIO_PRESETS = [
  {
    id: 'forecast_storm',
    label: 'Forecast storm (48h)',
    rainfall_mm: 25,
    irrigation_mm: 0,
    duration_hours: 6,
    infiltration_class: 'moderate',
    antecedent: 'normal',
  },
  {
    id: 'heavy_rain',
    label: 'Monsoon burst (~80 mm)',
    rainfall_mm: 80,
    irrigation_mm: 0,
    duration_hours: 6,
    infiltration_class: 'moderate',
    antecedent: 'wet',
  },
  {
    id: 'monsoon_heavy',
    label: 'Heavy monsoon (~150 mm)',
    rainfall_mm: 150,
    irrigation_mm: 0,
    duration_hours: 8,
    infiltration_class: 'moderate',
    antecedent: 'wet',
  },
  {
    id: 'rain_only',
    label: 'Moderate rain (~50 mm)',
    rainfall_mm: 50,
    irrigation_mm: 0,
    duration_hours: 6,
    infiltration_class: 'moderate',
    antecedent: 'wet',
  },
  {
    id: 'after_irrigate',
    label: 'After 40 mm canal/borewell',
    rainfall_mm: 10,
    irrigation_mm: 40,
    duration_hours: 8,
    infiltration_class: 'moderate',
    antecedent: 'normal',
  },
];

export function useScenarioSimulation(fieldId, grid = 128) {
  const [presets, setPresets] = useState([]);
  const [forecastMm, setForecastMm] = useState(null);
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(false);
  const [presetsLoading, setPresetsLoading] = useState(false);
  const [error, setError] = useState(null);
  const abortRef = useRef(null);
  const debounceRef = useRef(null);

  useEffect(() => {
    // Never carry a previous field's risk map / hotspots into a new field.
    setResult(null);
    setError(null);
    if (!fieldId) {
      setPresets([]);
      setForecastMm(null);
      return undefined;
    }
    const ctrl = new AbortController();
    setPresetsLoading(true);
    fetch(`${API_URL}/api/fields/${fieldId}/terrain/scenario-presets`, {
      headers: authHeaders(),
      signal: ctrl.signal,
    })
      .then(async (r) => {
        if (!r.ok) throw new Error(await r.text().catch(() => `Presets failed (${r.status})`));
        return r.json();
      })
      .then((j) => {
        setPresets(j.presets?.length ? j.presets : LOCAL_SCENARIO_PRESETS);
        setForecastMm(j.forecast_precip_mm_48h ?? null);
      })
      .catch((e) => {
        if (e?.name === 'AbortError') return;
        // Soft-fail: keep Run / Rain only / Irrigate usable without CropMonitor terrain.
        setPresets(LOCAL_SCENARIO_PRESETS);
        setForecastMm(null);
      })
      .finally(() => setPresetsLoading(false));
    return () => ctrl.abort();
  }, [fieldId]);

  const runSimulation = useCallback((scenario, { debounceMs = 0 } = {}) => {
    if (!fieldId) return;
    if (debounceRef.current) clearTimeout(debounceRef.current);

    const exec = async () => {
      if (abortRef.current) abortRef.current.abort();
      const ctrl = new AbortController();
      abortRef.current = ctrl;
      setLoading(true);
      setError(null);
      try {
        const body = {
          ...scenario,
          grid,
          include_png: true,
          include_values: false,
          forecast_precip_mm_48h: scenario.forecast_precip_mm_48h ?? forecastMm,
        };
        const r = await fetch(`${API_URL}/api/fields/${fieldId}/terrain/simulate-water`, {
          method: 'POST',
          headers: authHeaders({ 'Content-Type': 'application/json' }),
          body: JSON.stringify(body),
          signal: ctrl.signal,
        });
        if (!r.ok) {
          const detail = await r.text().catch(() => '');
          // Flat / DEM-missing fields often 4xx/5xx here — still play a screening movie on the twin.
          const fallback = buildFlatScreeningFallback(fieldId, body, detail || `Simulation failed (${r.status})`);
          if (fallback) {
            setResult(fallback);
            return;
          }
          throw new Error(detail || `Simulation failed (${r.status})`);
        }
        const json = await r.json();
        setResult(json);
      } catch (e) {
        if (e?.name === 'AbortError') return;
        const fallback = buildFlatScreeningFallback(fieldId, scenario, String(e.message || e));
        if (fallback) {
          setResult(fallback);
        } else {
          setError(String(e.message || e));
        }
      } finally {
        setLoading(false);
      }
    };

    if (debounceMs > 0) {
      debounceRef.current = setTimeout(exec, debounceMs);
    } else {
      exec();
    }
  }, [fieldId, grid, forecastMm]);

  const clearResult = useCallback(() => {
    if (abortRef.current) abortRef.current.abort();
    setResult(null);
    setError(null);
  }, []);

  useEffect(() => () => {
    if (abortRef.current) abortRef.current.abort();
    if (debounceRef.current) clearTimeout(debounceRef.current);
  }, []);

  return {
    presets,
    forecastMm,
    presetsLoading,
    result,
    loading,
    error,
    runSimulation,
    clearResult,
  };
}

/** Convert API base64 PNG to a blob URL for MapLibre draping. */
export function scenarioPngToObjectUrl(result) {
  if (!result?.overlay_png_base64) return null;
  const bin = atob(result.overlay_png_base64);
  const bytes = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
  const blob = new Blob([bytes], { type: result.overlay_mime || 'image/png' });
  return URL.createObjectURL(blob);
}

/**
 * Screening-grade stand-in when CropMonitor DEM/simulate-water is unavailable.
 * Produces a PNG + a few hotspots so Field Twin playback still runs.
 */
export function buildFlatScreeningFallback(fieldId, scenario = {}, reason = '') {
  if (typeof document === 'undefined') return null;
  const size = 96;
  const canvas = document.createElement('canvas');
  canvas.width = size;
  canvas.height = size;
  const ctx = canvas.getContext('2d');
  if (!ctx) return null;

  const rain = Number(scenario.rainfall_mm) || 0;
  const irrig = Number(scenario.irrigation_mm) || 0;
  const water = Math.min(1, (rain + irrig) / 80);
  const seed = (Number(fieldId) || 1) * 9973 + Math.round(rain * 10);
  let s = seed >>> 0;
  const rand = () => {
    s += 0x6D2B79F5;
    let t = Math.imul(s ^ (s >>> 15), 1 | s);
    t ^= t + Math.imul(t ^ (t >>> 7), 61 | t);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };

  const img = ctx.createImageData(size, size);
  const values = [];
  for (let y = 0; y < size; y++) {
    const row = [];
    for (let x = 0; x < size; x++) {
      const nx = x / size - 0.5;
      const ny = y / size - 0.5;
      const bowl = Math.max(0, 1 - Math.hypot(nx * 1.6, ny * 1.6));
      const noise = rand() * 0.35;
      const risk = Math.min(1, Math.max(0, water * 0.55 + bowl * 0.35 + noise * 0.25));
      row.push(risk);
      const i = (y * size + x) * 4;
      // Blue (low) → yellow → red (severe)
      const r = Math.round(30 + risk * 220);
      const g = Math.round(80 + (1 - Math.abs(risk - 0.45) * 2) * 140);
      const b = Math.round(200 - risk * 180);
      img.data[i] = r;
      img.data[i + 1] = g;
      img.data[i + 2] = b;
      img.data[i + 3] = Math.round(90 + risk * 140);
    }
    values.push(row);
  }
  ctx.putImageData(img, 0, 0);
  const dataUrl = canvas.toDataURL('image/png');
  const overlay_png_base64 = dataUrl.replace(/^data:image\/png;base64,/, '');

  const hotspots = [];
  for (let i = 0; i < 5; i++) {
    const row = Math.floor(rand() * size);
    const col = Math.floor(rand() * size);
    const risk = values[row][col];
    hotspots.push({
      row,
      col,
      grid_rows: size,
      grid_cols: size,
      risk: Number(risk.toFixed(2)),
      band: risk > 0.75 ? 'severe' : risk > 0.55 ? 'high' : 'moderate',
      latitude: null,
      longitude: null,
    });
  }
  hotspots.sort((a, b) => b.risk - a.risk);
  const mean = values.flat().reduce((a, b) => a + b, 0) / (size * size);

  return {
    overlay_png_base64,
    overlay_mime: 'image/png',
    hotspots: hotspots.slice(0, 5),
    summary: {
      mean_risk: Number(mean.toFixed(2)),
      access_risk: mean > 0.65 ? 'high' : mean > 0.4 ? 'moderate' : 'low',
      areas_ha: { high: 0, severe: 0 },
    },
    confidence: { grade: 'low' },
    accuracy_statement:
      'Screening-grade stand-in — DEM/terrain simulation unavailable for this field. Relative ponding only.',
    fallback: true,
    fallback_reason: reason || 'terrain_unavailable',
    inputs: {
      rainfall_mm: rain,
      irrigation_mm: irrig,
      duration_hours: Number(scenario.duration_hours) || 6,
    },
  };
}

