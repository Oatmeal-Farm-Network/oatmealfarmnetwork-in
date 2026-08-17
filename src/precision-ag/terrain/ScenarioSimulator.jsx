import React, { useEffect, useMemo, useRef, useState } from 'react';
import { API_URL, authHeaders } from '../../precisionAgUtils';
import { scenarioPngToObjectUrl, useScenarioSimulation } from './useScenarioSimulation';

const INFIL_OPTIONS = [
  { id: 'very_slow', label: 'Very slow (clay)' },
  { id: 'slow', label: 'Slow' },
  { id: 'moderate', label: 'Moderate (loam)' },
  { id: 'fast', label: 'Fast (sandy)' },
  { id: 'very_fast', label: 'Very fast' },
];

const ANTECEDENT_OPTIONS = [
  { id: 'dry', label: 'Dry' },
  { id: 'normal', label: 'Normal' },
  { id: 'wet', label: 'Wet' },
  { id: 'saturated', label: 'Saturated' },
];

function payloadFromPreset(preset, forecastMm, fallbackId = 'custom') {
  if (!preset) return null;
  return {
    preset_id: preset.id || fallbackId,
    rainfall_mm: Number(preset.rainfall_mm) || 0,
    duration_hours: Number(preset.duration_hours) || 6,
    irrigation_mm: Number(preset.irrigation_mm) || 0,
    infiltration_class: preset.infiltration_class || 'moderate',
    antecedent: preset.antecedent || 'normal',
    forecast_precip_mm_48h: forecastMm,
  };
}

/**
 * Storm / irrigation / field-access scenario controls.
 * Used by 3D Terrain and Field Twin (compact + collapsible).
 */
export default function ScenarioSimulator({
  fieldId,
  businessId,
  grid = 128,
  selectedHotspot,
  onSelectHotspot,
  onScenarioOverlay,
  onClearScenario,
  compact = false,
  defaultCollapsed = false,
  notesSourceLabel = 'Terrain Water Simulator',
  compareTrigger = null,
  defaultInfiltrationClass = null,
}) {
  const {
    presets, forecastMm, presetsLoading, result, loading, error,
    runSimulation, clearResult,
  } = useScenarioSimulation(fieldId, grid);

  // Compact Twin defaults to a useful screening event; full Terrain keeps forecast-first.
  const [presetId, setPresetId] = useState(compact ? 'heavy_rain' : 'forecast_storm');
  const [rainfallMm, setRainfallMm] = useState(compact ? 50 : 25);
  const [durationHours, setDurationHours] = useState(6);
  const [irrigationMm, setIrrigationMm] = useState(0);
  const [infiltration, setInfiltration] = useState(defaultInfiltrationClass || 'moderate');
  const [antecedent, setAntecedent] = useState(compact ? 'wet' : 'normal');
  const [actionMsg, setActionMsg] = useState('');
  const [actionBusy, setActionBusy] = useState(false);
  const [collapsed, setCollapsed] = useState(Boolean(defaultCollapsed));
  const defaultedPresetRef = useRef(false);

  // SoilGrids-derived infiltration from Field Twin snapshot (when provided)
  useEffect(() => {
    if (defaultInfiltrationClass) setInfiltration(defaultInfiltrationClass);
  }, [defaultInfiltrationClass]);

  // Apply preset values when presets load / selection changes
  useEffect(() => {
    if (!presets.length) return;
    const p = presets.find((x) => x.id === presetId) || presets[0];
    if (!p) return;
    setRainfallMm(Number(p.rainfall_mm) || 0);
    setDurationHours(Number(p.duration_hours) || 6);
    setIrrigationMm(Number(p.irrigation_mm) || 0);
    setInfiltration(p.infiltration_class || 'moderate');
    setAntecedent(p.antecedent || 'normal');
  }, [presets, presetId]);

  // Once presets load: if forecast storm is dry (0 mm), prefer Heavy rain so quick-run is useful
  useEffect(() => {
    if (!presets.length || defaultedPresetRef.current) return;
    defaultedPresetRef.current = true;
    if (compact) return; // already defaults to heavy_rain
    const forecast = presets.find((x) => x.id === 'forecast_storm');
    const dryForecast = forecast
      && (Number(forecast.rainfall_mm) || 0) <= 0
      && (Number(forecast.irrigation_mm) || 0) <= 0;
    if (dryForecast && presets.some((x) => x.id === 'heavy_rain')) {
      setPresetId('heavy_rain');
    }
  }, [presets, compact]);

  // Compact Twin: after a run, collapse to the Run / Adjust / Reset + mean-risk strip
  // (matches Field Twin product chrome with SCENARIO RESULT visible).
  useEffect(() => {
    if (compact && result && !loading) setCollapsed(true);
  }, [compact, result, loading]);

  // Publish overlay URL to parent when result changes (parent owns revoke of published URLs)
  useEffect(() => {
    if (!result?.overlay_png_base64) {
      onScenarioOverlay?.(null, result);
      return undefined;
    }
    const url = scenarioPngToObjectUrl(result);
    onScenarioOverlay?.(url, result);
    // If this effect re-runs / unmounts before parent swaps the URL, revoke the orphan we created.
    // Parent revokes the previous URL when it accepts a replacement.
    return () => {
      // Intentionally do not revoke `url` here — parent may still be displaying it.
    };
  }, [result]); // eslint-disable-line react-hooks/exhaustive-deps

  const scenarioPayload = useMemo(() => ({
    preset_id: presetId,
    rainfall_mm: Number(rainfallMm),
    duration_hours: Number(durationHours),
    irrigation_mm: Number(irrigationMm),
    infiltration_class: infiltration,
    antecedent,
    forecast_precip_mm_48h: forecastMm,
  }), [presetId, rainfallMm, durationHours, irrigationMm, infiltration, antecedent, forecastMm]);

  const ensureWaterPayload = (payload) => {
    const rain = Number(payload.rainfall_mm) || 0;
    const irrig = Number(payload.irrigation_mm) || 0;
    if (rain + irrig > 0) return payload;
    const heavy = presets.find((x) => x.id === 'heavy_rain');
    const next = payloadFromPreset(heavy, forecastMm, 'heavy_rain');
    if (!next) return payload;
    setPresetId('heavy_rain');
    return next;
  };

  const handleRun = () => runSimulation(ensureWaterPayload(scenarioPayload), { debounceMs: 0 });

  const handleQuickRun = () => {
    // Keep collapsed so Twin stays on screen; auto-collapse also fires when result lands
    runSimulation(ensureWaterPayload(scenarioPayload), { debounceMs: 0 });
  };

  // Twin scoreboard "Rain only" / "After irrigate" compare runs
  useEffect(() => {
    if (!compareTrigger?.key || !fieldId) return;
    const payload = ensureWaterPayload({
      preset_id: 'custom',
      rainfall_mm: Number(compareTrigger.rainfall_mm) || 0,
      duration_hours: Number(compareTrigger.duration_hours) || 6,
      irrigation_mm: Number(compareTrigger.irrigation_mm) || 0,
      infiltration_class: compareTrigger.infiltration_class || 'moderate',
      antecedent: compareTrigger.antecedent || 'normal',
      forecast_precip_mm_48h: forecastMm,
    });
    setPresetId('custom');
    setRainfallMm(payload.rainfall_mm);
    setDurationHours(payload.duration_hours);
    setIrrigationMm(payload.irrigation_mm);
    setInfiltration(payload.infiltration_class);
    setAntecedent(payload.antecedent);
    setCollapsed(true);
    runSimulation(payload, { debounceMs: 0 });
  }, [compareTrigger?.key]); // eslint-disable-line react-hooks/exhaustive-deps

  const handleReset = () => {
    clearResult();
    onClearScenario?.();
    onSelectHotspot?.(null);
    setActionMsg('');
  };

  const createScout = async () => {
    if (!selectedHotspot || !fieldId) return;
    setActionBusy(true);
    setActionMsg('');
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/scouts`, {
        method: 'POST',
        headers: authHeaders({ 'Content-Type': 'application/json' }),
        body: JSON.stringify({
          category: 'Water / Drainage',
          severity: selectedHotspot.band === 'severe' ? 'high' : 'moderate',
          notes: (
            `Water-risk screening hotspot (relative risk ${selectedHotspot.risk}). ` +
            `Scenario: ${rainfallMm} mm rain + ${irrigationMm} mm irrigation over ${durationHours} h. ` +
            `Screening-grade only — verify on site.`
          ),
          latitude: selectedHotspot.latitude,
          longitude: selectedHotspot.longitude,
          observed_at: new Date().toISOString(),
        }),
      });
      if (!r.ok) throw new Error(await r.text().catch(() => 'Scout create failed'));
      setActionMsg('Scouting observation created at the selected hotspot.');
    } catch (e) {
      setActionMsg(String(e.message || e));
    } finally {
      setActionBusy(false);
    }
  };

  const createWorkOrder = async () => {
    if (!selectedHotspot || !businessId) {
      setActionMsg('Business ID required to create a work order.');
      return;
    }
    const lat = Number(selectedHotspot.latitude);
    const lon = Number(selectedHotspot.longitude);
    if (!Number.isFinite(lat) || !Number.isFinite(lon)) {
      setActionMsg('Selected hotspot has no map coordinates yet — re-run the scenario.');
      return;
    }
    setActionBusy(true);
    setActionMsg('');
    try {
      const r = await fetch(`${API_URL}/api/work-orders`, {
        method: 'POST',
        headers: authHeaders({ 'Content-Type': 'application/json' }),
        body: JSON.stringify({
          BusinessID: Number(businessId),
          FieldID: Number(fieldId),
          TaskType: 'Scouting',
          Title: 'Check water / access risk hotspot',
          Description: (
            `Modeled relative water-risk ${selectedHotspot.risk} (${selectedHotspot.band}) at ` +
            `${lat.toFixed(5)}, ${lon.toFixed(5)}. ` +
            `Scenario rain ${rainfallMm} mm / irrigation ${irrigationMm} mm / ${durationHours} h. ` +
            `This is screening-grade — confirm before changing traffic or irrigation.`
          ),
          Priority: selectedHotspot.band === 'severe' ? 'high' : 'normal',
          Status: 'draft',
          Location: `${lat.toFixed(5)}, ${lon.toFixed(5)}`,
          Notes: `Created from ${notesSourceLabel} (not an automated action).`,
        }),
      });
      if (!r.ok) throw new Error(await r.text().catch(() => 'Work order create failed'));
      const j = await r.json();
      setActionMsg(`Draft work order created (WOID ${j.WOID || j.woid || '—'}).`);
    } catch (e) {
      setActionMsg(String(e.message || e));
    } finally {
      setActionBusy(false);
    }
  };

  const summary = result?.summary;
  const areas = summary?.affected_area_ac || {};
  const statusLabel = loading
    ? 'Scenario running'
    : result
      ? 'Scenario result'
      : 'Current field';

  return (
    <div
      className={`bg-white rounded-xl border border-gray-200 ${compact ? 'p-3' : 'p-4'} space-y-3`}
      role="region"
      aria-label="Water scenario simulator"
    >
      <div className="flex flex-wrap items-start justify-between gap-2">
        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2">
            <h3 className={`font-lora font-bold text-gray-900 ${compact ? 'text-base' : 'text-lg'}`}>
              {compact ? 'Simulate water' : 'Storm & Irrigation Simulator'}
            </h3>
            <span className={`text-[10px] font-mont font-semibold uppercase tracking-wide px-2 py-0.5 rounded-full border ${
              loading
                ? 'bg-sky-50 text-sky-800 border-sky-200'
                : result
                  ? 'bg-amber-50 text-amber-800 border-amber-200'
                  : 'bg-gray-50 text-gray-600 border-gray-200'
            }`}>
              {statusLabel}
            </span>
            <span className="text-[10px] font-mont font-semibold uppercase tracking-wide px-2 py-0.5 rounded-full bg-amber-50 text-amber-800 border border-amber-200">
              Screening-grade
            </span>
          </div>
          <p className="font-mont text-xs text-gray-500 mt-0.5">
            Relative ponding / access-risk screening — not flood depth or tile-drain performance.
            {compact ? ' Running a scenario plays the weather event on the Field Twin above.' : ''}
            {result?.summary?.access_risk ? ` Access risk: ${result.summary.access_risk}.` : ''}
          </p>
        </div>
        {compact && (
          <button
            type="button"
            onClick={() => setCollapsed((v) => !v)}
            className="px-2.5 py-1 rounded-lg text-[11px] font-mont font-semibold border border-gray-200 text-gray-600 hover:bg-gray-50"
            aria-expanded={!collapsed}
          >
            {collapsed ? 'Expand' : 'Collapse'}
          </button>
        )}
      </div>

      {collapsed && compact && (
        <div className="space-y-2">
          <div className="flex flex-wrap gap-2 items-center">
            <button
              type="button"
              onClick={handleQuickRun}
              disabled={loading || !fieldId}
              className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold text-white disabled:opacity-50"
              style={{ background: '#6D8E22' }}
              title={
                (Number(rainfallMm) || 0) + (Number(irrigationMm) || 0) <= 0
                  ? 'Runs Heavy rain (50 mm) — forecast is dry'
                  : `Runs ${presetId.replace(/_/g, ' ')} (${rainfallMm} mm rain)`
              }
            >
              {loading ? 'Running…' : 'Run scenario'}
            </button>
            <button
              type="button"
              onClick={() => {
                const monsoon = presets.find((x) => x.id === 'heavy_rain' || x.id === 'monsoon_heavy')
                  || { rainfall_mm: 80, irrigation_mm: 0, duration_hours: 6, infiltration_class: 'moderate', antecedent: 'wet' };
                const payload = ensureWaterPayload({
                  preset_id: monsoon.id || 'heavy_rain',
                  rainfall_mm: monsoon.rainfall_mm ?? 80,
                  duration_hours: monsoon.duration_hours ?? 6,
                  irrigation_mm: 0,
                  infiltration_class: monsoon.infiltration_class || 'moderate',
                  antecedent: 'wet',
                  forecast_precip_mm_48h: forecastMm,
                });
                setPresetId(payload.preset_id);
                setRainfallMm(payload.rainfall_mm);
                setDurationHours(payload.duration_hours);
                setIrrigationMm(0);
                setAntecedent('wet');
                runSimulation(payload, { debounceMs: 0 });
              }}
              disabled={loading || !fieldId}
              className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border border-sky-300 text-sky-950 bg-sky-50 disabled:opacity-50"
            >
              Replay monsoon
            </button>
            <button
              type="button"
              onClick={() => setCollapsed(false)}
              className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border border-gray-300 hover:bg-gray-50"
            >
              Adjust inputs
            </button>
            {result && (
              <button
                type="button"
                onClick={handleReset}
                className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border border-gray-300 hover:bg-gray-50"
              >
                Reset scenario
              </button>
            )}
            {result && (
              <span className="text-[11px] font-mont text-gray-600">
                Mean risk {summary?.mean_risk != null ? summary.mean_risk.toFixed(2) : '—'}
                {result.confidence?.grade ? ` · confidence ${result.confidence.grade}` : ''}
                {result.summary?.access_risk ? ` · access ${result.summary.access_risk}` : ''}
                {result.fallback ? ' · screening stand-in (no DEM)' : ''}
              </span>
            )}
          </div>
          {(error || loading) && (
            <div className={`rounded-lg p-2.5 text-xs font-mont ${
              error
                ? 'bg-red-50 border border-red-200 text-red-800'
                : 'bg-sky-50 border border-sky-200 text-sky-900'
            }`}
            >
              {loading ? 'Running water scenario on the Field Twin…' : error}
            </div>
          )}
          {(result?.hotspots || []).length > 0 && (
            <div className="flex flex-wrap gap-2 items-center">
              <span className="text-[11px] font-mont text-gray-500">Hotspots:</span>
              {result.hotspots.slice(0, 5).map((h, i) => (
                <button
                  key={`${h.row}-${h.col}`}
                  type="button"
                  onClick={() => onSelectHotspot?.(h)}
                  className="px-2 py-1 rounded-lg border text-[11px] font-mont"
                  style={{
                    borderColor: selectedHotspot?.row === h.row && selectedHotspot?.col === h.col
                      ? '#6D8E22' : '#E5E7EB',
                    background: selectedHotspot?.row === h.row && selectedHotspot?.col === h.col
                      ? '#F0F7E4' : 'white',
                  }}
                >
                  #{i + 1} · {h.band}
                </button>
              ))}
              {selectedHotspot && (
                <span className="text-[11px] font-mont text-gray-600">
                  Selected — expand for scout / work order
                </span>
              )}
            </div>
          )}
        </div>
      )}

      {!collapsed && (
        <>

      {/* Presets */}
      <div className="flex flex-wrap gap-2">
        {(presetsLoading ? [] : presets).map((p) => (
          <button
            key={p.id}
            type="button"
            onClick={() => setPresetId(p.id)}
            className="px-3 py-1.5 rounded-full text-xs font-mont font-semibold border transition-all"
            style={{
              background: presetId === p.id ? '#6D8E22' : 'white',
              borderColor: presetId === p.id ? '#6D8E22' : '#E5E7EB',
              color: presetId === p.id ? 'white' : '#6B7280',
            }}
            title={p.description}
          >
            {p.label}
            {p.id === 'forecast_storm' && forecastMm != null ? ` (${forecastMm} mm)` : ''}
          </button>
        ))}
        {presetsLoading && (
          <span className="text-xs font-mont text-gray-400 animate-pulse">Loading presets…</span>
        )}
      </div>

      {/* Inputs */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
        <label className="flex flex-col gap-1 text-xs font-mont text-gray-600">
          Rainfall (mm)
          <input type="number" min="0" max="500" step="1" value={rainfallMm}
            onChange={(e) => { setPresetId('custom'); setRainfallMm(e.target.value); }}
            className="border border-gray-300 rounded-lg px-3 py-2 text-sm" />
        </label>
        <label className="flex flex-col gap-1 text-xs font-mont text-gray-600">
          Duration (hours)
          <input type="number" min="0.25" max="168" step="0.25" value={durationHours}
            onChange={(e) => { setPresetId('custom'); setDurationHours(e.target.value); }}
            className="border border-gray-300 rounded-lg px-3 py-2 text-sm" />
        </label>
        <label className="flex flex-col gap-1 text-xs font-mont text-gray-600">
          Irrigation (mm)
          <input type="number" min="0" max="200" step="1" value={irrigationMm}
            onChange={(e) => { setPresetId('custom'); setIrrigationMm(e.target.value); }}
            className="border border-gray-300 rounded-lg px-3 py-2 text-sm" />
        </label>
        <label className="flex flex-col gap-1 text-xs font-mont text-gray-600">
          Infiltration class <span className="text-amber-700">(assumed)</span>
          <select value={infiltration} onChange={(e) => { setPresetId('custom'); setInfiltration(e.target.value); }}
            className="border border-gray-300 rounded-lg px-3 py-2 text-sm">
            {INFIL_OPTIONS.map((o) => <option key={o.id} value={o.id}>{o.label}</option>)}
          </select>
        </label>
        <label className="flex flex-col gap-1 text-xs font-mont text-gray-600">
          Antecedent moisture <span className="text-amber-700">(assumed unless observed)</span>
          <select value={antecedent} onChange={(e) => { setPresetId('custom'); setAntecedent(e.target.value); }}
            className="border border-gray-300 rounded-lg px-3 py-2 text-sm">
            {ANTECEDENT_OPTIONS.map((o) => <option key={o.id} value={o.id}>{o.label}</option>)}
          </select>
        </label>
        <div className="flex items-end gap-2">
          <button type="button" onClick={handleRun} disabled={loading || !fieldId}
            className="flex-1 px-4 py-2 rounded-lg text-sm font-mont font-semibold text-white disabled:opacity-50"
            style={{ background: '#6D8E22' }}>
            {loading ? 'Running…' : 'Run scenario'}
          </button>
          <button type="button" onClick={handleReset}
            className="px-3 py-2 rounded-lg text-sm font-mont font-semibold border border-gray-300 hover:bg-gray-50">
            Reset
          </button>
        </div>
      </div>

      {/* Badges */}
      <div className="flex flex-wrap gap-2 text-[10px] font-mont font-semibold uppercase tracking-wide">
        <span className="px-2 py-1 rounded bg-emerald-50 text-emerald-800 border border-emerald-200">Observed: DEM · boundary · optional NDWI/moisture</span>
        <span className="px-2 py-1 rounded bg-amber-50 text-amber-800 border border-amber-200">Assumed: infiltration · antecedent (unless logged)</span>
        <span className="px-2 py-1 rounded bg-sky-50 text-sky-800 border border-sky-200">Modeled: relative water-risk surface</span>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 text-red-800 rounded-lg p-3 text-sm font-mont">{error}</div>
      )}

      {result && (
        <div className="space-y-3">
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
            {[
              { label: 'Access risk', value: summary?.access_risk || '—' },
              { label: 'Mean risk', value: summary?.mean_risk != null ? summary.mean_risk.toFixed(2) : '—' },
              { label: 'High+ acres', value: ((areas.high || 0) + (areas.severe || 0)).toFixed(2) },
              { label: 'Confidence', value: result.confidence?.grade || '—' },
            ].map((c) => (
              <div key={c.label} className="bg-gray-50 border border-gray-100 rounded-lg px-3 py-2">
                <div className="text-[10px] uppercase text-gray-400 font-mont">{c.label}</div>
                <div className="font-lora text-lg font-bold text-gray-800 capitalize">{c.value}</div>
              </div>
            ))}
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-xs font-mont">
              <thead>
                <tr className="text-left text-gray-500 border-b border-gray-100">
                  <th className="py-1 pr-3">Band</th>
                  <th className="py-1 pr-3">Acres</th>
                  <th className="py-1">Hectares</th>
                </tr>
              </thead>
              <tbody>
                {['low', 'moderate', 'high', 'severe'].map((b) => (
                  <tr key={b} className="border-b border-gray-50">
                    <td className="py-1.5 pr-3 capitalize font-semibold text-gray-700">{b}</td>
                    <td className="py-1.5 pr-3">{(areas[b] ?? 0).toFixed(2)}</td>
                    <td className="py-1.5">{(summary?.affected_area_ha?.[b] ?? 0).toFixed(2)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {(result.hotspots || []).length > 0 && (
            <div>
              <div className="text-xs font-semibold font-mont text-gray-600 mb-1">Highest-risk locations (modeled)</div>
              <div className="flex flex-wrap gap-2">
                {result.hotspots.map((h, i) => (
                  <button
                    key={`${h.row}-${h.col}`}
                    type="button"
                    onClick={() => onSelectHotspot?.(h)}
                    className="px-2.5 py-1.5 rounded-lg border text-xs font-mont"
                    style={{
                      borderColor: selectedHotspot === h || (selectedHotspot?.row === h.row && selectedHotspot?.col === h.col)
                        ? '#6D8E22' : '#E5E7EB',
                      background: selectedHotspot?.row === h.row && selectedHotspot?.col === h.col ? '#F0F7E4' : 'white',
                    }}
                  >
                    #{i + 1} · risk {h.risk} · {h.band}
                  </button>
                ))}
              </div>
            </div>
          )}

          {selectedHotspot && (
            <div className="bg-slate-50 border border-slate-200 rounded-lg p-3 space-y-2">
              <p className="text-sm font-mont text-gray-700">
                Selected hotspot: {selectedHotspot.latitude.toFixed(5)}, {selectedHotspot.longitude.toFixed(5)}
                {' '}· risk {selectedHotspot.risk} ({selectedHotspot.band})
              </p>
              <div className="flex flex-wrap gap-2">
                <button type="button" disabled={actionBusy} onClick={createScout}
                  className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold text-white disabled:opacity-50"
                  style={{ background: '#3D6B34' }}>
                  Create scouting note
                </button>
                <button type="button" disabled={actionBusy} onClick={createWorkOrder}
                  className="px-3 py-1.5 rounded-lg text-xs font-mont font-semibold border border-gray-300 hover:bg-white disabled:opacity-50">
                  Create draft work order
                </button>
              </div>
              <p className="text-[11px] text-gray-500 font-mont">
                Optional human follow-up only — modeled output never auto-dispatches field work.
              </p>
              {actionMsg && <p className="text-xs font-mont text-gray-700">{actionMsg}</p>}
            </div>
          )}

          <div className="bg-amber-50 border border-amber-200 rounded-lg p-3 text-[11px] font-mont text-amber-900 space-y-1">
            <p className="font-semibold">Accuracy &amp; confidence</p>
            <p>{result.accuracy_statement}</p>
            <p>Model {result.model?.id} v{result.model?.version} · confidence {result.confidence?.score}/100 ({result.confidence?.grade})</p>
            <ul className="list-disc pl-4">
              {(result.confidence?.reasons || []).slice(0, 4).map((r) => (
                <li key={r}>{r}</li>
              ))}
            </ul>
          </div>
        </div>
      )}
        </>
      )}
    </div>
  );
}
