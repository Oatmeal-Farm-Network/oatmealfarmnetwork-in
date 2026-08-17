import React, { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { API_URL, authHeaders } from '../../precisionAgUtils';
import { openWhatsAppText, shareFromSnapshot } from './fieldStatusShare';

export function formatMm(mm, digits = 0) {
  if (mm == null || Number.isNaN(Number(mm))) return '—';
  return `${Number(mm).toFixed(digits)} mm`;
}

/**
 * Farmer-facing scoreboard: millimetre water numbers + one next action.
 */
export default function TwinScoreboard({
  snapshot,
  scenarioMeta = null,
  fieldId,
  businessId,
  truckMode = false,
  onRunIrrigate,
  onRunRainOnly,
  onWalkField,
  onScoutWorstHotspot = null,
  refreshing = false,
  onLoggedRain = null,
  onRunMonsoon = null,
}) {
  const cards = useMemo(() => buildCards(snapshot, scenarioMeta), [snapshot, scenarioMeta]);
  const next = useMemo(
    () => nextAction(snapshot, scenarioMeta, { fieldId, businessId }),
    [snapshot, scenarioMeta, fieldId, businessId],
  );
  const season = snapshot?.selection?.effective_year;
  const indiaSeason = snapshot?.selection?.india_season;
  const rainHint = Number(indiaSeason?.rain_hint_mm) || 80;
  const historical = Boolean(snapshot?.selection?.is_historical);
  const soilCount = snapshot?.soil_samples?.located_count
    ?? (snapshot?.soil_samples?.samples || []).filter((s) => s.latitude != null && s.longitude != null).length;
  const [shareMsg, setShareMsg] = useState('');
  const [rainMm, setRainMm] = useState('10');
  const [rainBusy, setRainBusy] = useState(false);
  const [rainMsg, setRainMsg] = useState('');
  const [dismissRainPrompt, setDismissRainPrompt] = useState(false);

  const yesterdayPrecip = useMemo(() => {
    const today = new Date().toISOString().slice(0, 10);
    const days = snapshot?.weather?.daily || [];
    const past = days.filter((d) => d?.date && String(d.date) <= today);
    const last = past[past.length - 1];
    return Number(last?.precip);
  }, [snapshot]);
  const promptGauge = (
    !dismissRainPrompt
    && snapshot?.irrigation?.precip_source === 'open_meteo'
    && Number.isFinite(yesterdayPrecip)
    && yesterdayPrecip >= 15
  );

  useEffect(() => {
    if (Number.isFinite(yesterdayPrecip) && yesterdayPrecip >= 1) {
      setRainMm(String(Math.round(yesterdayPrecip)));
    }
  }, [yesterdayPrecip]);

  if (!snapshot) return null;

  const logRain = async (depthOverride) => {
    const depth = Number(depthOverride ?? rainMm);
    if (!fieldId || !(depth > 0) || depth > 500) {
      setRainMsg('Enter rain between 1 and 500 mm');
      return;
    }
    setRainBusy(true);
    setRainMsg('');
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/precip-logs`, {
        method: 'POST',
        headers: { ...authHeaders(), 'Content-Type': 'application/json' },
        body: JSON.stringify({ depth_mm: depth, source: 'gauge' }),
      });
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      setRainMsg(`Logged ${depth.toFixed(0)} mm rain — refresh twin to update water need`);
      onLoggedRain?.(depth);
    } catch (e) {
      setRainMsg(e?.message || 'Could not log rain');
    } finally {
      setRainBusy(false);
      setTimeout(() => setRainMsg(''), 4000);
    }
  };

  const runNext = () => {
    if (next.action === 'rain_only') onRunRainOnly?.();
    else if (next.action === 'irrigate') onRunIrrigate?.();
    else if (next.action === 'walk') onWalkField?.();
    else if (next.action === 'scout_worst') onScoutWorstHotspot?.();
  };

  const copyScenario = async () => {
    const text = formatScenarioShare(snapshot, scenarioMeta);
    if (!text) return;
    try {
      await navigator.clipboard.writeText(text);
      setShareMsg('Copied scenario summary');
    } catch {
      setShareMsg('Could not copy — select and copy manually');
    }
    setTimeout(() => setShareMsg(''), 2500);
  };

  const shareWhatsApp = () => {
    const text = scenarioMeta
      ? `${shareFromSnapshot(snapshot, next.text)}\n\n${formatScenarioShare(snapshot, scenarioMeta)}`
      : shareFromSnapshot(snapshot, next.text);
    if (!text) return;
    openWhatsAppText(text);
  };

  const shareFieldCard = () => {
    openWhatsAppText(shareFromSnapshot(snapshot, next.text));
  };

  const btnBase = truckMode
    ? 'px-3 py-2.5 rounded-xl text-sm font-mont font-semibold min-h-[44px]'
    : 'px-2.5 py-1 rounded-lg text-[11px] font-mont font-semibold';

  return (
    <div
      className={`bg-white rounded-xl border border-gray-200 ${truckMode ? 'p-3.5 space-y-3' : 'p-3 space-y-3'}`}
      data-testid="twin-scoreboard"
      data-truck-mode={truckMode ? '1' : '0'}
    >
      <div className="flex flex-wrap items-center justify-between gap-2">
        <div>
          <div className="font-lora text-sm font-bold text-gray-900">
            {truckMode ? 'Field check' : 'Field status'}
          </div>
          <p className="font-mont text-[11px] text-gray-500 mt-0.5">
            {refreshing
              ? 'Refreshing live data… showing last good view'
              : historical
                ? `Viewing historical ${season} — switch to This season for live satellite / weather.`
                : oneLiner(snapshot, next)}
          </p>
        </div>
        <div className={`flex flex-wrap gap-1.5 ${truckMode ? 'w-full sm:w-auto' : ''}`}>
          {onRunRainOnly && (
            <button
              type="button"
              onClick={onRunRainOnly}
              className={`${btnBase} flex-1 sm:flex-none border border-gray-300 text-gray-700 hover:bg-gray-50`}
              title={`What-if: about ${rainHint} mm of rain, no irrigate (rough model)`}
            >
              What if ~{rainHint} mm rain
            </button>
          )}
          {onRunMonsoon && (
            <button
              type="button"
              onClick={onRunMonsoon}
              className={`${btnBase} flex-1 sm:flex-none border border-sky-400 text-sky-950 bg-sky-50 hover:bg-sky-100`}
              title="Replay a monsoon burst (80–150 mm). Screening-grade only."
            >
              Replay monsoon
            </button>
          )}
          {onRunIrrigate && (
            <button
              type="button"
              onClick={onRunIrrigate}
              className={`${btnBase} flex-1 sm:flex-none border border-sky-300 text-sky-900 bg-sky-50 hover:bg-sky-100`}
              title="What-if: about 40 mm canal/borewell irrigate after light rain (rough model, not a schedule)"
            >
              {truckMode ? 'What if ~40 mm irrigate' : 'What if ~40 mm canal/borewell'}
            </button>
          )}
          {onWalkField && (
            <button
              type="button"
              onClick={onWalkField}
              className={`${btnBase} bg-[#0F766E] text-white`}
            >
              Walk the field
            </button>
          )}
        </div>
      </div>

      <div className={`grid gap-2 ${truckMode ? 'grid-cols-2' : 'grid-cols-2 sm:grid-cols-4'}`}>
        {cards.map((c) => (
          <div
            key={c.label}
            className="rounded-lg border border-gray-100 bg-gray-50 px-2.5 py-2"
          >
            <div className="font-mont text-[10px] uppercase tracking-wide text-gray-400">{c.label}</div>
            <div className={`font-lora font-bold text-gray-900 mt-0.5 ${truckMode ? 'text-lg' : 'text-base'}`}>
              {c.value}
            </div>
            {c.note && <div className="font-mont text-[10px] text-gray-500 mt-0.5">{c.note}</div>}
          </div>
        ))}
      </div>

      {fieldId && (
        <div className="flex flex-wrap items-end gap-2 rounded-lg border border-sky-100 bg-sky-50/60 px-2.5 py-2">
          <div className="flex flex-col gap-0.5">
            <label className="font-mont text-[10px] uppercase tracking-wide text-sky-800">Log rain gauge (mm)</label>
            <input
              type="number"
              min="1"
              max="500"
              step="1"
              value={rainMm}
              onChange={(e) => setRainMm(e.target.value)}
              className="w-24 rounded-md border border-sky-200 px-2 py-1 text-sm font-mont"
            />
          </div>
          <button
            type="button"
            disabled={rainBusy}
            onClick={() => logRain()}
            className={`${btnBase} bg-sky-800 text-white disabled:opacity-60`}
          >
            {rainBusy ? 'Saving…' : 'Save rain'}
          </button>
          {promptGauge && (
            <button
              type="button"
              disabled={rainBusy}
              onClick={() => logRain(Math.round(yesterdayPrecip))}
              className={`${btnBase} bg-amber-700 text-white disabled:opacity-60`}
              data-testid="twin-log-yesterday-rain"
            >
              Log yesterday ~{yesterdayPrecip.toFixed(0)} mm
            </button>
          )}
          <p className="font-mont text-[10px] text-sky-900/80">
            Gauge logs replace weather-grid rain in the water-need estimate (not a schedule).
          </p>
          {promptGauge && (
            <p className="font-mont text-[11px] text-amber-950 w-full bg-amber-50 border border-amber-100 rounded-md px-2 py-1">
              Open-Meteo shows about {yesterdayPrecip.toFixed(0)} mm yesterday — tap log if your gauge agrees.
              <button type="button" className="ml-2 underline" onClick={() => setDismissRainPrompt(true)}>Dismiss</button>
            </p>
          )}
          {rainMsg && <p className="font-mont text-[11px] text-sky-900 w-full">{rainMsg}</p>}
        </div>
      )}

      <div className={`flex flex-wrap items-center gap-2 ${truckMode ? 'flex-col items-stretch' : 'justify-between'}`}>
        <p className="font-mont text-xs text-gray-700">
          <span className="font-semibold text-gray-900">Next: </span>
          {next.text}
        </p>
        <div className={`flex flex-wrap gap-2 ${truckMode ? 'w-full' : ''}`}>
          {next.action && next.action !== 'link' && (
            <button
              type="button"
              onClick={runNext}
              className={`${btnBase} ${truckMode ? 'flex-1' : ''} bg-[#1E3A5F] text-white`}
              data-testid="twin-next-action"
            >
              {next.cta}
            </button>
          )}
          {next.href && (
            <Link
              to={next.href}
              className={`${btnBase} ${truckMode ? 'flex-1 text-center' : ''} bg-[#1E3A5F] text-white`}
            >
              {next.cta}
            </Link>
          )}
          {soilCount === 0 && businessId && fieldId && !next.href?.includes('soil-samples') && (
            <Link
              to={`/precision-ag/soil-samples?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(fieldId)}`}
              className={`${btnBase} ${truckMode ? 'flex-1 text-center' : ''} bg-amber-50 text-amber-950 border border-amber-200`}
            >
              Add soil test
            </Link>
          )}
          <button
            type="button"
            onClick={shareFieldCard}
            className={`${btnBase} border border-emerald-300 text-emerald-950 bg-emerald-50`}
            data-testid="twin-whatsapp-field"
          >
            WhatsApp field
          </button>
          {scenarioMeta && (
            <>
              <button
                type="button"
                onClick={copyScenario}
                className={`${btnBase} border border-gray-300 text-gray-700 hover:bg-gray-50`}
                data-testid="twin-share-scenario"
              >
                Copy scenario
              </button>
              <button
                type="button"
                onClick={shareWhatsApp}
                className={`${btnBase} border border-emerald-300 text-emerald-950 bg-emerald-50`}
                data-testid="twin-whatsapp-scenario"
              >
                WhatsApp what-if
              </button>
            </>
          )}
        </div>
        {shareMsg && (
          <p className="font-mont text-[11px] text-emerald-800 w-full">{shareMsg}</p>
        )}
      </div>
    </div>
  );
}

function buildCards(snapshot, scenarioMeta) {
  const veg = snapshot?.vegetation || {};
  const indices = snapshot?.analysis?.data?.vegetation_indices || [];
  const ndvi = indices.find((i) => String(i.index_type || '').toUpperCase() === 'NDVI');
  const moisture = snapshot?.soil_moisture;
  const irrig = snapshot?.irrigation;
  const access = scenarioMeta?.summary?.access_risk;
  const vegOff = snapshot?.selection?.is_historical || veg.available === false;
  const fert = snapshot?.fertility;

  const deficit = irrig?.deficit_mm ?? irrig?.cumulative_deficit_mm ?? irrig?.deficit_in ?? irrig?.cumulative_deficit_in;
  const waterValue = deficit != null
    ? (Number(deficit) < 4 ? 'About even' : `${Number(deficit).toFixed(0)} mm short`)
    : (irrig?.recommendation || '—');

  const waterNote = irrig?.available
    ? [
        irrig.recommendation || null,
        irrig.suggested_apply_mm > 0 ? `suggest ~${Number(irrig.suggested_apply_mm).toFixed(0)} mm` : null,
        irrig.applied_irrig_mm > 0 ? `logged irrigate −${Number(irrig.applied_irrig_mm).toFixed(0)} mm` : null,
        irrig.precip_source === 'field_gauge' ? 'rain gauge' : null,
        irrig.et_source === 'openet' ? 'satellite ET' : 'weather model',
      ].filter(Boolean).join(' · ')
    : (irrig?.note || 'weather model unavailable');

  const cards = [
    {
      label: 'Crop greenness (satellite)',
      value: ndvi?.mean != null
        ? Number(ndvi.mean).toFixed(2)
        : (vegOff ? 'Not this year' : 'No map yet'),
      note: snapshot?.selection?.is_historical
        ? 'Live satellite off for history'
        : (veg.freshness === 'stale'
          ? `STALE · ${veg.age_days}d old · not plant count`
          : (veg.acquired_at
            ? `image ${String(veg.acquired_at).slice(0, 10)}${veg.age_days != null ? ` · ${veg.age_days}d` : ''} · not plant count`
            : (ndvi?.mean != null
              ? 'from latest analysis · not plant count'
              : (vegOff ? 'satellite withheld' : 'waiting on imagery')))),
    },
    {
      label: moisture?.provenance === 'observed' ? 'Soil wetness (probe)' : 'Soil wetness (est.)',
      value: moisture?.farmer_label || moisture?.level || 'unknown',
      note: moisture?.provenance === 'observed'
        ? `probe ${moisture.moisture_pct != null ? `${Number(moisture.moisture_pct).toFixed(0)}%` : ''}${moisture.depth_cm != null ? ` @ ${moisture.depth_cm} cm` : ''}`.trim()
        : ((moisture?.deficit_mm ?? moisture?.deficit_in) != null
          ? `~${Number(moisture.deficit_mm ?? moisture.deficit_in).toFixed(0)} mm short · not a probe`
          : 'estimated — not a probe'),
    },
    {
      label: 'Water need (est.)',
      value: waterValue,
      note: waterNote,
    },
    {
      label: 'Driveability (model)',
      value: access || 'not run',
      note: scenarioMeta?.fallback
        ? 'flat-field rough guess — walk wet spots'
        : (access ? 'relative risk, not mud depth' : 'run rain / irrigate what-if'),
    },
  ];

  if (fert?.available) {
    const a = fert.averages || {};
    const bits = [
      a.ph != null ? `pH ${a.ph}` : null,
      a.organic_matter != null ? `OM ${a.organic_matter}%` : null,
      a.phosphorus != null ? `P ${a.phosphorus}` : null,
      a.potassium != null ? `K ${a.potassium}` : null,
    ].filter(Boolean);
    if (bits.length) {
      cards.push({
        label: 'Lab fertility (avg)',
        value: bits[0],
        note: `${[...bits.slice(1), `${fert.core_count} GPS core${fert.core_count === 1 ? '' : 's'}`].filter(Boolean).join(' · ')}`,
      });
    }
  }

  return cards;
}

function nextAction(snapshot, scenarioMeta, { fieldId, businessId } = {}) {
  const soilHref = (businessId && fieldId)
    ? `/precision-ag/soil-samples?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(fieldId)}`
    : null;
  const soilCount = snapshot?.soil_samples?.located_count
    ?? (snapshot?.soil_samples?.samples || []).filter((s) => s.latitude != null && s.longitude != null).length;

  if (snapshot?.crop?.validation?.requires_confirmation) {
    return {
      text: 'Confirm this season’s crop so the canopy matches what you planted.',
      href: null,
      cta: 'Scroll to confirm',
      action: null,
    };
  }
  if (soilCount === 0 && soilHref) {
    return {
      text: 'No GPS soil cores on the twin yet — add a lab test so fertility isn’t guesswork.',
      href: soilHref,
      cta: 'Add soil test',
      action: 'link',
    };
  }
  if (!scenarioMeta) {
    return {
      text: 'Run a rain what-if to see wet corners before you drive or spray.',
      href: null,
      cta: 'Try monsoon rain',
      action: 'rain_only',
    };
  }
  if (scenarioMeta?.summary?.access_risk === 'high' || scenarioMeta?.summary?.access_risk === 'severe') {
    return {
      text: 'Driveability looks high — scout the worst hotspot before heavy traffic.',
      href: null,
      cta: 'Scout worst spot',
      action: 'scout_worst',
    };
  }
  const deficit = snapshot?.irrigation?.deficit_mm
    ?? snapshot?.irrigation?.cumulative_deficit_mm
    ?? snapshot?.irrigation?.deficit_in
    ?? snapshot?.irrigation?.cumulative_deficit_in;
  if (deficit != null && Number(deficit) >= 20) {
    return {
      text: `Model says about ${Number(deficit).toFixed(0)} mm short — compare a ~40 mm canal/borewell what-if (not a schedule).`,
      href: null,
      cta: 'Try ~40 mm irrigate',
      action: 'irrigate',
    };
  }
  if (snapshot?.irrigation?.recommendation && /irrigat|short|need/i.test(String(snapshot.irrigation.recommendation))) {
    return {
      text: `${snapshot.irrigation.recommendation}. Compare a canal/borewell what-if before you change the set.`,
      href: null,
      cta: 'Try ~40 mm irrigate',
      action: 'irrigate',
    };
  }
  return {
    text: 'Replay monsoon vs canal/borewell, or walk the crop before the next pass.',
    href: null,
    cta: 'Try ~40 mm irrigate',
    action: 'irrigate',
  };
}

function oneLiner(snapshot, next) {
  const crop = snapshot?.crop?.crop_type || 'crop unconfirmed';
  const season = snapshot?.selection?.india_season?.label || 'season';
  const age = snapshot?.vegetation?.age_days;
  const deficit = snapshot?.irrigation?.deficit_mm ?? snapshot?.irrigation?.cumulative_deficit_mm;
  const sat = age == null ? 'no satellite age' : (age > 14 ? `satellite ${age}d stale` : `satellite ${age}d`);
  const water = deficit != null && Number(deficit) >= 4 ? `${Number(deficit).toFixed(0)} mm short` : 'water about even';
  return `${crop} · ${season} · ${sat} · ${water} · next: ${next?.text || 'walk or confirm crop'}`;
}

function formatScenarioShare(snapshot, scenarioMeta) {
  if (!scenarioMeta) return '';
  const name = snapshot?.field?.name || 'Field';
  const access = scenarioMeta.summary?.access_risk || '—';
  const rainMm = scenarioMeta.rainfall_mm;
  const irrigMm = scenarioMeta.irrigation_mm ?? 0;
  const grade = scenarioMeta.confidence?.grade || (scenarioMeta.fallback ? 'screening' : '—');
  const note = scenarioMeta.accuracy_statement
    || 'Rough relative water/driveability model — not flood depth. Verify on site.';
  return [
    `Field Twin water what-if — ${name}`,
    `Rain ${formatMm(rainMm)} · irrigate ${formatMm(irrigMm)} · driveability ${access} · confidence ${grade}`,
    note,
    `Season ${snapshot?.selection?.india_season?.label || snapshot?.selection?.effective_year || 'current'}`,
  ].join('\n');
}
