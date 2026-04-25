import React, { useEffect, useState } from 'react';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const EMPTY_SAMPLE = {
  sample_date: '',
  brix_degrees: '',
  anthocyanin_mg_g: '',
  firmness_kgf: '',
  ph: '',
  titratable_acidity_pct: '',
  cultivar: '',
  sample_size: '',
  lab_name: '',
  notes: '',
};

const EMPTY_TARGET = {
  destination_label: '',
  destination_address: '',
  destination_miles: '',
  receiving_lag_days: '',
  shelf_target_date: '',
  notes: '',
};

const STATUS_COLORS = {
  ok:                          { bg: '#ECFDF5', border: '#A7F3D0', text: '#065F46' },
  no_data:                     { bg: '#FEF3C7', border: '#FDE68A', text: '#92400E' },
  insufficient_metric:         { bg: '#FEF3C7', border: '#FDE68A', text: '#92400E' },
  single_sample_no_reference:  { bg: '#FEF3C7', border: '#FDE68A', text: '#92400E' },
  flat_trend:                  { bg: '#FEF3C7', border: '#FDE68A', text: '#92400E' },
  non_increasing:              { bg: '#FFF1F2', border: '#FECDD3', text: '#9F1239' },
  past_projected_peak:         { bg: '#FFF1F2', border: '#FECDD3', text: '#9F1239' },
};

function fmt(n, digits = 2) {
  if (n === null || n === undefined || n === '') return '—';
  const v = Number(n);
  return Number.isFinite(v) ? v.toFixed(digits) : '—';
}

function fmtDate(s) {
  if (!s) return '—';
  return String(s).split('T')[0];
}

function StatusBadge({ status, confidence }) {
  const c = STATUS_COLORS[status] || { bg: '#F3F4F6', border: '#D1D5DB', text: '#374151' };
  const conf = confidence != null ? `${Math.round(confidence * 100)}%` : '—';
  return (
    <span
      className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-semibold border"
      style={{ background: c.bg, borderColor: c.border, color: c.text }}
    >
      <span>{status?.replace(/_/g, ' ') || 'unknown'}</span>
      <span className="opacity-70">·</span>
      <span>confidence {conf}</span>
    </span>
  );
}

function ProgressBar({ pct }) {
  const clamped = Math.max(0, Math.min(100, Number(pct) || 0));
  return (
    <div className="w-full h-3 rounded-full bg-gray-200 overflow-hidden">
      <div
        className="h-full transition-all"
        style={{
          width: `${clamped}%`,
          background: clamped >= 95 ? '#10B981' : clamped >= 70 ? '#84CC16' : clamped >= 40 ? '#FACC15' : '#F97316',
        }}
      />
    </div>
  );
}

export default function MaturityPanel({ fieldId, businessId }) {
  const [data, setData]     = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError]   = useState(null);
  const [sampleForm, setSampleForm] = useState(EMPTY_SAMPLE);
  const [showSampleForm, setShowSampleForm] = useState(false);
  const [savingSample, setSavingSample] = useState(false);
  const [targetForm, setTargetForm] = useState(EMPTY_TARGET);
  const [showTargetForm, setShowTargetForm] = useState(false);
  const [savingTarget, setSavingTarget] = useState(false);

  const load = () => {
    setLoading(true);
    fetch(`${API_URL}/api/fields/${fieldId}/maturity`)
      .then(r => r.ok ? r.json() : Promise.reject(new Error(`HTTP ${r.status}`)))
      .then(d => {
        setData(d);
        setError(null);
        if (d.target) {
          setTargetForm({
            destination_label:   d.target.destination_label   ?? '',
            destination_address: '',
            destination_miles:   d.target.destination_miles   ?? '',
            receiving_lag_days:  d.target.receiving_lag_days  ?? '',
            shelf_target_date:   d.target.shelf_target_date   ?? '',
            notes:               d.target.notes               ?? '',
          });
        }
      })
      .catch(e => setError(e.message))
      .finally(() => setLoading(false));
  };

  useEffect(() => { if (fieldId) load(); /* eslint-disable-next-line */ }, [fieldId]);

  const submitSample = async (e) => {
    e.preventDefault();
    if (!businessId || !fieldId) return;
    const has = ['brix_degrees','anthocyanin_mg_g','firmness_kgf','ph','titratable_acidity_pct']
      .some(k => sampleForm[k] !== '' && sampleForm[k] != null);
    if (!has) {
      alert('Enter at least one measurement (Brix, anthocyanin, firmness, pH, or acidity).');
      return;
    }
    setSavingSample(true);
    const body = {
      field_id:    Number(fieldId),
      business_id: Number(businessId),
      sample_date: sampleForm.sample_date || new Date().toISOString().slice(0, 10),
      cultivar:    sampleForm.cultivar    || null,
      sample_size: sampleForm.sample_size ? Number(sampleForm.sample_size) : null,
      lab_name:    sampleForm.lab_name    || null,
      brix_degrees:           sampleForm.brix_degrees           !== '' ? Number(sampleForm.brix_degrees)           : null,
      anthocyanin_mg_g:       sampleForm.anthocyanin_mg_g       !== '' ? Number(sampleForm.anthocyanin_mg_g)       : null,
      firmness_kgf:           sampleForm.firmness_kgf           !== '' ? Number(sampleForm.firmness_kgf)           : null,
      ph:                     sampleForm.ph                     !== '' ? Number(sampleForm.ph)                     : null,
      titratable_acidity_pct: sampleForm.titratable_acidity_pct !== '' ? Number(sampleForm.titratable_acidity_pct) : null,
      notes:       sampleForm.notes || null,
    };
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/maturity/samples`, {
        method:  'POST',
        headers: { 'Content-Type': 'application/json' },
        body:    JSON.stringify(body),
      });
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      setSampleForm(EMPTY_SAMPLE);
      setShowSampleForm(false);
      load();
    } catch (e) {
      alert('Could not save sample: ' + e.message);
    } finally {
      setSavingSample(false);
    }
  };

  const deleteSample = async (sampleId) => {
    if (!confirm('Delete this sample?')) return;
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/maturity/samples/${sampleId}`, { method: 'DELETE' });
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      load();
    } catch (e) {
      alert('Could not delete: ' + e.message);
    }
  };

  const submitTarget = async (e) => {
    e.preventDefault();
    if (!businessId || !fieldId) return;
    setSavingTarget(true);
    const body = {
      field_id:    Number(fieldId),
      business_id: Number(businessId),
      destination_label:   targetForm.destination_label   || null,
      destination_address: targetForm.destination_address || null,
      destination_miles:   targetForm.destination_miles  !== '' ? Number(targetForm.destination_miles)  : null,
      receiving_lag_days:  targetForm.receiving_lag_days !== '' ? Number(targetForm.receiving_lag_days) : null,
      shelf_target_date:   targetForm.shelf_target_date  || null,
      notes:               targetForm.notes              || null,
    };
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/maturity/target`, {
        method:  'PUT',
        headers: { 'Content-Type': 'application/json' },
        body:    JSON.stringify(body),
      });
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      setShowTargetForm(false);
      load();
    } catch (e) {
      alert('Could not save target: ' + e.message);
    } finally {
      setSavingTarget(false);
    }
  };

  if (loading && !data) {
    return <div className="p-6 text-gray-500">Loading maturity data…</div>;
  }
  if (error && !data) {
    return <div className="p-6 text-red-600">Failed to load maturity: {error}</div>;
  }
  if (!data) return null;

  const {
    samples = [], prediction = {}, arrival, cultivar_reference, target, heat_units,
    light_context, regional_progress, satellite_anthocyanin_proxy: satProxy,
  } = data;
  const sortedSamples = [...samples].sort((a, b) =>
    String(b.sample_date || '').localeCompare(String(a.sample_date || ''))
  );

  return (
    <div className="space-y-6 pb-12">
      {/* Hero — prediction summary */}
      <div className="bg-white border border-gray-200 rounded-lg p-6">
        <div className="flex items-start justify-between flex-wrap gap-3">
          <div>
            <h3 className="font-lora text-xl font-bold text-gray-900">Maturity Engine</h3>
            <p className="text-sm text-gray-500 font-mont mt-1">
              Peak-antioxidant harvest prediction · {data.crop_type || 'Unknown crop'}
            </p>
          </div>
          <StatusBadge status={prediction.status} confidence={prediction.confidence} />
        </div>

        <div className="mt-5 grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">Predicted Peak</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">
              {prediction.predicted_peak_date ? fmtDate(prediction.predicted_peak_date) : '—'}
            </div>
            <div className="text-xs text-gray-500 mt-1">method: {prediction.method || '—'}</div>
          </div>
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">Progress to Ripe</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">
              {prediction.progress_pct != null ? `${prediction.progress_pct.toFixed(0)}%` : '—'}
            </div>
            {prediction.progress_pct != null && (
              <div className="mt-2"><ProgressBar pct={prediction.progress_pct} /></div>
            )}
          </div>
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">Trend Fit</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">
              {prediction.r_squared != null ? `R² ${prediction.r_squared}` : '—'}
            </div>
            <div className="text-xs text-gray-500 mt-1">
              {prediction.sample_count != null ? `${prediction.sample_count} sample(s)` : ''}
              {prediction.metric ? ` · metric: ${prediction.metric.replace(/_/g, ' ')}` : ''}
            </div>
          </div>
        </div>

        {prediction.message && (
          <p className="mt-4 text-sm text-gray-600 italic">{prediction.message}</p>
        )}
      </div>

      {/* Cultivar reference + heat units context */}
      {(cultivar_reference || heat_units) && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {cultivar_reference && (
            <div className="bg-white border border-gray-200 rounded-lg p-5">
              <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide">
                Cultivar reference
              </h4>
              <div className="mt-3 space-y-1 text-sm text-gray-700">
                <div>Ripe Brix target: <span className="font-semibold">{cultivar_reference.brix_ripe}°Bx</span></div>
                <div>Peak anthocyanin: <span className="font-semibold">{cultivar_reference.anthocyanin_peak_mg_g} mg/g</span></div>
                <div>Ripe firmness: <span className="font-semibold">{cultivar_reference.firmness_ripe_kgf} kgf</span></div>
                <div className="text-xs text-gray-500 italic mt-2">
                  Reference values from published cultivar phenology — used as the asymptote, not the prediction.
                </div>
              </div>
            </div>
          )}
          {heat_units && (
            <div className="bg-white border border-gray-200 rounded-lg p-5">
              <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide">
                Heat unit context
              </h4>
              <div className="mt-3 space-y-1 text-sm text-gray-700">
                <div>GDD over last {heat_units.total_gdd_period_days} days: <span className="font-semibold">{Math.round(heat_units.total_gdd)}</span></div>
                <div>Base temperature: <span className="font-semibold">{heat_units.base_temp_f}°F</span></div>
                <div className="text-xs text-gray-500 italic mt-2">
                  From Open-Meteo (real weather data); used to interpret sample-trend speed.
                </div>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Free public-API context: light, satellite NDRE, regional progress */}
      {(light_context || satProxy || regional_progress) && (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {light_context && (
            <div className="bg-white border border-gray-200 rounded-lg p-5">
              <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide">
                Light & temperature (last {light_context.days}d)
              </h4>
              <div className="mt-3 space-y-1 text-sm text-gray-700">
                {light_context.cumulative_par_mj_m2 != null && (
                  <div>Cumulative PAR: <span className="font-semibold">{light_context.cumulative_par_mj_m2} MJ/m²</span></div>
                )}
                {light_context.avg_par_mj_m2_per_day != null && (
                  <div>Avg daily PAR: <span className="font-semibold">{light_context.avg_par_mj_m2_per_day} MJ/m²/day</span></div>
                )}
                {light_context.avg_diurnal_c != null && (
                  <div>Avg diurnal range: <span className="font-semibold">{light_context.avg_diurnal_c}°C</span></div>
                )}
                {light_context.avg_dew_point_c != null && (
                  <div>Avg dew point: <span className="font-semibold">{light_context.avg_dew_point_c}°C</span></div>
                )}
                <div className="text-xs text-gray-500 italic mt-2">
                  NASA POWER. Wide diurnal range + cool nights drive anthocyanin accumulation.
                </div>
              </div>
            </div>
          )}
          {satProxy && (
            <div className="bg-white border border-gray-200 rounded-lg p-5">
              <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide">
                Satellite anthocyanin proxy
              </h4>
              <div className="mt-3 space-y-1 text-sm text-gray-700">
                <div>Latest NDRE: <span className="font-semibold">{satProxy.latest_ndre}</span> <span className="text-xs text-gray-500">({fmtDate(satProxy.latest_date)})</span></div>
                {satProxy.trend && (
                  <div>Trend across {satProxy.samples_used} scenes: <span className="font-semibold">{satProxy.trend}</span></div>
                )}
                {satProxy.first_ndre != null && (
                  <div className="text-xs text-gray-500">From {satProxy.first_ndre} on {fmtDate(satProxy.first_date)}</div>
                )}
                <div className="text-xs text-gray-500 italic mt-2">{satProxy.note}</div>
              </div>
            </div>
          )}
          {regional_progress && (
            <div className="bg-white border border-gray-200 rounded-lg p-5">
              <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide">
                Regional progress (USDA)
              </h4>
              <div className="mt-3 space-y-1 text-sm text-gray-700">
                <div>{regional_progress.statistic_label || 'Crop progress'}</div>
                {regional_progress.value_pct != null && (
                  <div className="text-2xl font-lora font-bold text-gray-900">
                    {regional_progress.value_pct}%
                  </div>
                )}
                <div className="text-xs text-gray-500">
                  {regional_progress.state} · week ending {fmtDate(regional_progress.week_ending)}
                </div>
                <div className="text-xs text-gray-500 italic mt-2">
                  USDA NASS QuickStats — sanity check vs. statewide pace.
                </div>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Ready-on-shelf plan */}
      <div className="bg-white border border-gray-200 rounded-lg p-5">
        <div className="flex items-center justify-between">
          <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide">
            Ready-on-shelf plan
          </h4>
          <button
            onClick={() => setShowTargetForm(s => !s)}
            className="text-xs text-[#6D8E22] font-semibold hover:underline"
          >
            {showTargetForm ? 'Cancel' : (target ? 'Edit destination' : 'Set destination')}
          </button>
        </div>

        {!target && !showTargetForm && (
          <p className="mt-3 text-sm text-gray-500">
            Set a buyer destination + shelf-target date to see the engine work backwards from the PO.
          </p>
        )}

        {target && !showTargetForm && (
          <div className="mt-3 grid grid-cols-1 sm:grid-cols-2 gap-3 text-sm">
            <div><span className="text-gray-500">Destination:</span> <span className="font-semibold">{target.destination_label || '—'}</span></div>
            <div><span className="text-gray-500">One-way miles:</span> <span className="font-semibold">{target.destination_miles ?? '—'}</span></div>
            <div><span className="text-gray-500">DC receiving lag:</span> <span className="font-semibold">{target.receiving_lag_days != null ? `${target.receiving_lag_days} day(s)` : '—'}</span></div>
            <div><span className="text-gray-500">Shelf target:</span> <span className="font-semibold">{fmtDate(target.shelf_target_date)}</span></div>
          </div>
        )}

        {arrival && arrival.status !== 'incomplete_destination' && (
          <div className="mt-4 p-4 rounded-lg" style={{
            background: arrival.alignment === 'on_target'    ? '#ECFDF5'
                       : arrival.alignment === 'after_peak'  ? '#FFF1F2'
                       : arrival.alignment === 'ahead_of_peak'? '#FEF3C7'
                       : '#F9FAFB',
            border:     '1px solid ' + (
                        arrival.alignment === 'on_target'    ? '#A7F3D0'
                       : arrival.alignment === 'after_peak'  ? '#FECDD3'
                       : arrival.alignment === 'ahead_of_peak'? '#FDE68A'
                       : '#E5E7EB'),
          }}>
            <div className="text-sm grid grid-cols-1 sm:grid-cols-2 gap-2">
              <div><span className="text-gray-500">Transit:</span> <span className="font-semibold">{arrival.transit_days ?? '—'} day(s)</span></div>
              <div><span className="text-gray-500">Projected shelf date:</span> <span className="font-semibold">{fmtDate(arrival.projected_shelf_date)}</span></div>
              {arrival.latest_pick_date && <div><span className="text-gray-500">Latest pick to hit target:</span> <span className="font-semibold">{fmtDate(arrival.latest_pick_date)}</span></div>}
              {arrival.pick_vs_peak_days != null && <div><span className="text-gray-500">Pick vs. peak:</span> <span className="font-semibold">{arrival.pick_vs_peak_days} day(s)</span></div>}
            </div>
            {arrival.alignment_message && (
              <p className="mt-3 text-sm text-gray-700">{arrival.alignment_message}</p>
            )}
          </div>
        )}
        {arrival && arrival.status === 'incomplete_destination' && (
          <p className="mt-3 text-sm text-amber-700">{arrival.message}</p>
        )}

        {showTargetForm && (
          <form onSubmit={submitTarget} className="mt-4 grid grid-cols-1 sm:grid-cols-2 gap-3">
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Destination label</span>
              <input className="w-full border rounded px-2 py-1.5" value={targetForm.destination_label}
                     onChange={e => setTargetForm(f => ({ ...f, destination_label: e.target.value }))}
                     placeholder="e.g. Whole Foods – Austin DC" />
            </label>
            <label className="text-sm sm:col-span-2">
              <span className="block text-gray-600 mb-1">
                Destination address <span className="text-gray-400 font-normal">(optional — auto-fills miles via OpenStreetMap + OSRM)</span>
              </span>
              <input className="w-full border rounded px-2 py-1.5" value={targetForm.destination_address}
                     onChange={e => setTargetForm(f => ({ ...f, destination_address: e.target.value }))}
                     placeholder="e.g. 525 Bowie St, Austin, TX" />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">One-way road miles</span>
              <input type="number" step="1" className="w-full border rounded px-2 py-1.5" value={targetForm.destination_miles}
                     onChange={e => setTargetForm(f => ({ ...f, destination_miles: e.target.value }))}
                     placeholder="leave blank to auto-fill" />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">DC receiving lag (days)</span>
              <input type="number" step="1" min="0" className="w-full border rounded px-2 py-1.5" value={targetForm.receiving_lag_days}
                     onChange={e => setTargetForm(f => ({ ...f, receiving_lag_days: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Shelf target date</span>
              <input type="date" className="w-full border rounded px-2 py-1.5" value={targetForm.shelf_target_date}
                     onChange={e => setTargetForm(f => ({ ...f, shelf_target_date: e.target.value }))} />
            </label>
            <label className="text-sm sm:col-span-2">
              <span className="block text-gray-600 mb-1">Notes</span>
              <textarea className="w-full border rounded px-2 py-1.5" rows="2" value={targetForm.notes}
                        onChange={e => setTargetForm(f => ({ ...f, notes: e.target.value }))} />
            </label>
            <div className="sm:col-span-2 flex justify-end gap-2">
              <button type="button" onClick={() => setShowTargetForm(false)}
                      className="px-3 py-1.5 text-sm rounded border border-gray-300">Cancel</button>
              <button type="submit" disabled={savingTarget}
                      className="px-3 py-1.5 text-sm rounded bg-[#3D6B34] text-white disabled:opacity-50">
                {savingTarget ? 'Saving…' : 'Save destination'}
              </button>
            </div>
          </form>
        )}
      </div>

      {/* Samples table */}
      <div className="bg-white border border-gray-200 rounded-lg p-5">
        <div className="flex items-center justify-between">
          <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide">
            Samples ({samples.length})
          </h4>
          <button
            onClick={() => setShowSampleForm(s => !s)}
            className="text-xs text-white bg-[#3D6B34] hover:opacity-90 px-3 py-1.5 rounded font-semibold"
          >
            {showSampleForm ? 'Cancel' : '+ Log sample'}
          </button>
        </div>

        {showSampleForm && (
          <form onSubmit={submitSample} className="mt-4 p-4 rounded-lg bg-gray-50 grid grid-cols-2 sm:grid-cols-3 gap-3">
            <label className="text-sm sm:col-span-1">
              <span className="block text-gray-600 mb-1">Sample date</span>
              <input type="date" className="w-full border rounded px-2 py-1.5" value={sampleForm.sample_date}
                     onChange={e => setSampleForm(f => ({ ...f, sample_date: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Brix (°Bx)</span>
              <input type="number" step="0.1" className="w-full border rounded px-2 py-1.5" value={sampleForm.brix_degrees}
                     onChange={e => setSampleForm(f => ({ ...f, brix_degrees: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Anthocyanin (mg/g)</span>
              <input type="number" step="0.01" className="w-full border rounded px-2 py-1.5" value={sampleForm.anthocyanin_mg_g}
                     onChange={e => setSampleForm(f => ({ ...f, anthocyanin_mg_g: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Firmness (kgf)</span>
              <input type="number" step="0.01" className="w-full border rounded px-2 py-1.5" value={sampleForm.firmness_kgf}
                     onChange={e => setSampleForm(f => ({ ...f, firmness_kgf: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">pH</span>
              <input type="number" step="0.01" className="w-full border rounded px-2 py-1.5" value={sampleForm.ph}
                     onChange={e => setSampleForm(f => ({ ...f, ph: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Titratable acidity (%)</span>
              <input type="number" step="0.01" className="w-full border rounded px-2 py-1.5" value={sampleForm.titratable_acidity_pct}
                     onChange={e => setSampleForm(f => ({ ...f, titratable_acidity_pct: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Cultivar</span>
              <input className="w-full border rounded px-2 py-1.5" value={sampleForm.cultivar}
                     onChange={e => setSampleForm(f => ({ ...f, cultivar: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Sample size (#)</span>
              <input type="number" className="w-full border rounded px-2 py-1.5" value={sampleForm.sample_size}
                     onChange={e => setSampleForm(f => ({ ...f, sample_size: e.target.value }))} />
            </label>
            <label className="text-sm">
              <span className="block text-gray-600 mb-1">Lab / device</span>
              <input className="w-full border rounded px-2 py-1.5" value={sampleForm.lab_name}
                     onChange={e => setSampleForm(f => ({ ...f, lab_name: e.target.value }))}
                     placeholder="e.g. Felix F-750, in-house refractometer" />
            </label>
            <label className="text-sm col-span-2 sm:col-span-3">
              <span className="block text-gray-600 mb-1">Notes</span>
              <textarea rows="2" className="w-full border rounded px-2 py-1.5" value={sampleForm.notes}
                        onChange={e => setSampleForm(f => ({ ...f, notes: e.target.value }))} />
            </label>
            <div className="col-span-2 sm:col-span-3 flex justify-end gap-2">
              <button type="button" onClick={() => setShowSampleForm(false)}
                      className="px-3 py-1.5 text-sm rounded border border-gray-300">Cancel</button>
              <button type="submit" disabled={savingSample}
                      className="px-3 py-1.5 text-sm rounded bg-[#3D6B34] text-white disabled:opacity-50">
                {savingSample ? 'Saving…' : 'Save sample'}
              </button>
            </div>
          </form>
        )}

        {sortedSamples.length === 0 ? (
          <p className="mt-3 text-sm text-gray-500">
            No samples logged yet. Each sample (Brix, anthocyanin, firmness, pH) tightens the harvest prediction.
          </p>
        ) : (
          <div className="mt-4 overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="text-left text-xs text-gray-500 uppercase tracking-wide">
                <tr>
                  <th className="py-2 pr-3">Date</th>
                  <th className="py-2 pr-3">Brix</th>
                  <th className="py-2 pr-3">Anthocyanin</th>
                  <th className="py-2 pr-3">Firmness</th>
                  <th className="py-2 pr-3">pH</th>
                  <th className="py-2 pr-3">Acidity</th>
                  <th className="py-2 pr-3">Lab</th>
                  <th className="py-2 pr-3"></th>
                </tr>
              </thead>
              <tbody>
                {sortedSamples.map(s => (
                  <tr key={s.sample_id} className="border-t border-gray-100">
                    <td className="py-2 pr-3 font-medium">{fmtDate(s.sample_date)}</td>
                    <td className="py-2 pr-3">{s.brix_degrees != null ? `${fmt(s.brix_degrees, 1)}°Bx` : '—'}</td>
                    <td className="py-2 pr-3">{s.anthocyanin_mg_g != null ? `${fmt(s.anthocyanin_mg_g, 2)} mg/g` : '—'}</td>
                    <td className="py-2 pr-3">{s.firmness_kgf != null ? `${fmt(s.firmness_kgf, 2)} kgf` : '—'}</td>
                    <td className="py-2 pr-3">{s.ph != null ? fmt(s.ph, 2) : '—'}</td>
                    <td className="py-2 pr-3">{s.titratable_acidity_pct != null ? `${fmt(s.titratable_acidity_pct, 2)}%` : '—'}</td>
                    <td className="py-2 pr-3 text-gray-600">{s.lab_name || '—'}</td>
                    <td className="py-2 pr-3 text-right">
                      <button onClick={() => deleteSample(s.sample_id)}
                              className="text-xs text-red-600 hover:underline">delete</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
