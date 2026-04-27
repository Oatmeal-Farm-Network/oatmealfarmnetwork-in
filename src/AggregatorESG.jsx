/**
 * AggregatorESG — automated, audit-ready proof of sustainable practices.
 *
 * Four tabs:
 *  - Live snapshot : auto-aggregated metrics from existing tables
 *  - Manual metrics : CRUD for everything we don't track automatically
 *  - Generate report : pick a period, snapshot live + manual into a saved record
 *  - Saved reports : list previous snapshots, view HTML, download PDF, delete
 *
 * The live snapshot pulls from OFNAggregator{Farm,Purchase,Input,Logistics,
 * Inventory} + OFNESGSensorReading. PDF and HTML are server-rendered so
 * audit-time numbers always match generation-time numbers.
 */
import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";
const btnGhost = "px-3 py-1.5 text-sm border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50";

const CATEGORIES = ['environmental', 'social', 'governance'];
const CAT_ICON = { environmental: '🌍', social: '🤝', governance: '⚖️' };
const SUGGESTED_KEYS = {
  environmental: [
    ['renewable_energy_pct', '% of operations on renewable energy', '%'],
    ['water_recycled_pct',   '% of process water recycled', '%'],
    ['ghg_offset_t',         'GHG offsets purchased (tCO₂e)', 'tCO2e'],
    ['plastic_diverted_kg',  'Plastic diverted from landfill (kg)', 'kg'],
    ['organic_acres_pct',    '% sourcing acres certified organic', '%'],
  ],
  social: [
    ['fair_wage_premium_paid', 'Fair-wage premium paid above market', '$'],
    ['training_hours_provided','Farmer training hours provided', 'hours'],
    ['workforce_local_pct',    '% of workforce hired locally', '%'],
    ['safety_incidents',       'Recordable safety incidents', 'count'],
  ],
  governance: [
    ['eu_csrd_status',         'EU CSRD reporting status', ''],
    ['ethifinance_rating',     'EthiFinance rating', ''],
    ['iso_14001_certified',    'ISO 14001 certified (Y/N)', ''],
    ['supplier_audits_done',   'Supplier audits completed in period', 'count'],
    ['board_independence_pct', '% of board members independent', '%'],
  ],
};

const fmt$  = (n) => Number(n || 0).toLocaleString(undefined, { maximumFractionDigits: 2 });
const fmtKg = (n) => Number(n || 0).toLocaleString(undefined, { maximumFractionDigits: 1 });
const fmtPct = (n) => n == null ? 'n/a' : `${Number(n).toFixed(1)}%`;
const isoDate = (d) => d.toISOString().slice(0, 10);
const today = new Date();
const ninetyDaysAgo = new Date(today.getTime() - 90 * 86400_000);

// ─────────────────────────────────────────────────────────────────
// Live snapshot (read-only, recomputed for the chosen period)
// ─────────────────────────────────────────────────────────────────
function LiveTab({ businessId }) {
  const [start, setStart] = useState(isoDate(ninetyDaysAgo));
  const [end,   setEnd]   = useState(isoDate(today));
  const [data,  setData]  = useState(null);
  const [loading, setLoading] = useState(true);

  const refresh = () => {
    setLoading(true);
    fetch(`${API}/api/esg/${businessId}/live?start=${start}&end=${end}`)
      .then(r => r.json()).then(d => { setData(d); setLoading(false); });
  };
  useEffect(refresh, [businessId, start, end]);

  if (loading) return <div className="text-sm text-gray-500">Loading…</div>;

  const live = data?.live || {};
  const src = live.sourcing || {};
  const proc = live.procurement || {};
  const inputs = live.inputs_to_farms || {};
  const cold = live.cold_chain || {};
  const waste = live.waste || {};
  const sensors = (live.sensors || {}).by_type || [];
  const manual = data?.manual_metrics || [];

  const card = (title, icon, children) => (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <div className="flex items-center gap-2 mb-3">
        <span className="text-lg">{icon}</span>
        <strong className="text-gray-900">{title}</strong>
      </div>
      <div className="space-y-1 text-sm">{children}</div>
    </div>
  );
  const kv = (label, value, sub) => (
    <div className="flex justify-between gap-4">
      <span className="text-gray-600">{label}</span>
      <span className="font-semibold text-gray-900 text-right">{value}{sub && <div className="text-[10px] text-gray-500 font-normal">{sub}</div>}</span>
    </div>
  );

  return (
    <div className="space-y-4">
      <div className="flex items-end gap-3 flex-wrap">
        <div><label className={lbl}>Period start</label><input className={inp} type="date" value={start} onChange={e => setStart(e.target.value)} /></div>
        <div><label className={lbl}>Period end</label><input className={inp} type="date" value={end} onChange={e => setEnd(e.target.value)} /></div>
        <button onClick={refresh} className={btnGhost}>Refresh</button>
        <div className="flex-1" />
        <span className="text-xs text-gray-500">Numbers below come from real activity records — same query reproduces the same answer at audit time.</span>
      </div>

      <div className="grid md:grid-cols-2 gap-3">
        {card('Sourcing transparency', '🌱', <>
          {kv('Active partner farms',    src.active_farms ?? 0)}
          {kv('Certified farms',         `${src.farms_certified ?? 0} (${src.certified_pct ?? 0}%)`)}
          {(src.certifications || []).length > 0 && (
            <div className="pt-2 border-t border-gray-100 mt-2">
              {src.certifications.map(c => (
                <div key={c.Certification} className="flex justify-between text-xs">
                  <span className="text-gray-700">{c.Certification}</span>
                  <span className="text-gray-500">{c.N} farm{c.N === 1 ? '' : 's'}</span>
                </div>
              ))}
            </div>
          )}
        </>)}

        {card('Procurement & residue', '🫐', <>
          {kv('Purchase records',        proc.purchase_count ?? 0)}
          {kv('Quantity received',       `${fmtKg(proc.kg_received)} kg`)}
          {kv('Spend',                   `$${fmt$(proc.spend)}`)}
          {kv('Residue tests passed',    proc.residue_passed ?? 0)}
          {kv('Residue tests failed',    proc.residue_failed ?? 0, 'lower is better')}
          {kv('Residue pass rate',       fmtPct(proc.residue_pass_rate_pct))}
        </>)}

        {card('Inputs distributed to farms', '🧰', <>
          {(inputs.by_type || []).length > 0
            ? (inputs.by_type || []).map(r => (
                <div key={r.InputType} className="flex justify-between text-xs">
                  <span className="text-gray-700">{r.InputType}</span>
                  <span className="text-gray-500">{r.N} · ${fmt$(r.Spend)}</span>
                </div>
              ))
            : <div className="text-xs text-gray-500 italic">No inputs distributed in this period.</div>}
          <div className="pt-2 mt-2 border-t border-gray-100 flex justify-between font-semibold">
            <span className="text-gray-700">Total invested</span>
            <span className="text-gray-900">${fmt$(inputs.total_spend)}</span>
          </div>
        </>)}

        {card('Cold chain integrity', '❄️', <>
          {kv('Dispatches logged',     cold.dispatches ?? 0)}
          {kv('Cold-chain breaches',   cold.breaches ?? 0, 'lower is better')}
          {kv('Integrity rate',        fmtPct(cold.integrity_pct))}
        </>)}

        {card('Waste signal', '🗑️', <>
          {kv('Items quarantined / discarded', waste.items_quarantined_or_discarded ?? 0)}
          {kv('Kg quarantined / discarded',    fmtKg(waste.kg_quarantined_or_discarded))}
        </>)}

        {card('Sensor data (IoT)', '📡', <>
          {sensors.length > 0
            ? sensors.map(r => (
                <div key={r.sensor_type} className="flex justify-between text-xs">
                  <span className="text-gray-700">{r.sensor_type}</span>
                  <span className="text-gray-500">{r.readings} · avg {Number(r.avg).toFixed(2)}, range {Number(r.min).toFixed(2)}–{Number(r.max).toFixed(2)}</span>
                </div>
              ))
            : <div className="text-xs text-gray-500 italic">No sensor data ingested. POST to <code>/api/esg/{businessId}/sensor-webhook</code> from any IoT integration to start populating this.</div>}
        </>)}
      </div>

      {manual.length > 0 && (
        <div className="bg-white border border-gray-200 rounded-xl p-4">
          <div className="flex items-center gap-2 mb-3">
            <span className="text-lg">📋</span>
            <strong className="text-gray-900">Manual ESG metrics for this period</strong>
            <span className="text-xs text-gray-500">({manual.length})</span>
          </div>
          <div className="space-y-2">
            {manual.map(m => (
              <div key={m.MetricID} className="flex items-start gap-2 text-sm border-b border-gray-100 pb-2">
                <span>{CAT_ICON[m.Category] || '📋'}</span>
                <div className="flex-1">
                  <div className="font-semibold text-gray-900">{m.Label}</div>
                  <div className="text-xs text-gray-500">
                    {m.Value} {m.Unit && <span className="text-gray-400">{m.Unit}</span>}
                    {m.PeriodStart && <span> · {(m.PeriodStart || '').slice(0,10)} → {(m.PeriodEnd || '').slice(0,10)}</span>}
                    {m.EvidenceURL && <> · <a href={m.EvidenceURL} target="_blank" rel="noreferrer" className="text-[#3D6B34] hover:underline">evidence</a></>}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// Manual metrics CRUD
// ─────────────────────────────────────────────────────────────────
function MetricForm({ metric, onSave, onCancel }) {
  const [s, setS] = useState(metric || {
    Category: 'environmental', MetricKey: '', Label: '',
    Value: '', NumericValue: '', Unit: '',
    PeriodStart: '', PeriodEnd: '',
    EvidenceURL: '', Notes: '',
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  const pickSuggestion = (key, label, unit) => setS(prev => ({ ...prev, MetricKey: key, Label: label, Unit: unit }));
  const sugg = SUGGESTED_KEYS[s.Category] || [];
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Category</label>
          <select className={inp} value={s.Category} onChange={set('Category')}>
            {CATEGORIES.map(c => <option key={c}>{c}</option>)}
          </select></div>
        <div><label className={lbl}>Metric key *</label><input className={inp} placeholder="renewable_energy_pct" value={s.MetricKey} onChange={set('MetricKey')} /></div>
        <div><label className={lbl}>Unit</label><input className={inp} placeholder="% / $ / kg / hours" value={s.Unit || ''} onChange={set('Unit')} /></div>
        <div className="md:col-span-3"><label className={lbl}>Label *</label><input className={inp} placeholder="% of operations on renewable energy" value={s.Label} onChange={set('Label')} /></div>
        <div><label className={lbl}>Value</label><input className={inp} placeholder="85% / Yes / ISO 14001" value={s.Value || ''} onChange={set('Value')} /></div>
        <div><label className={lbl}>Numeric (optional)</label><input className={inp} type="number" step="0.0001" value={s.NumericValue ?? ''} onChange={setNum('NumericValue')} /></div>
        <div><label className={lbl}>Evidence URL</label><input className={inp} placeholder="https://… link to certificate / audit doc" value={s.EvidenceURL || ''} onChange={set('EvidenceURL')} /></div>
        <div><label className={lbl}>Period start</label><input className={inp} type="date" value={s.PeriodStart || ''} onChange={set('PeriodStart')} /></div>
        <div><label className={lbl}>Period end</label><input className={inp} type="date" value={s.PeriodEnd || ''} onChange={set('PeriodEnd')} /></div>
        <div className="md:col-span-3"><label className={lbl}>Notes</label><textarea className={inp} rows={2} value={s.Notes || ''} onChange={set('Notes')} /></div>
      </div>
      {!metric && sugg.length > 0 && (
        <div className="text-xs text-gray-500">
          <div className="mb-1">Quick fill:</div>
          <div className="flex flex-wrap gap-1.5">
            {sugg.map(([k, l, u]) => (
              <button key={k} type="button" onClick={() => pickSuggestion(k, l, u)}
                      className="border border-gray-200 rounded-full px-2 py-0.5 hover:border-[#819360]">
                {l}
              </button>
            ))}
          </div>
        </div>
      )}
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} disabled={!s.MetricKey || !s.Label} className={btn}>Save</button>
      </div>
    </div>
  );
}

function MetricsTab({ businessId }) {
  const [list, setList]    = useState([]);
  const [editing, setEdit] = useState(null);
  const [adding, setAdd]   = useState(false);
  const [filter, setFilt]  = useState('');

  const refresh = () => {
    const qs = filter ? `?category=${filter}` : '';
    fetch(`${API}/api/esg/${businessId}/metrics${qs}`).then(r => r.json()).then(setList);
  };
  useEffect(refresh, [businessId, filter]);

  const save = async (m) => {
    const isEdit = !!m.MetricID;
    const url = isEdit ? `${API}/api/esg/metrics/${m.MetricID}` : `${API}/api/esg/${businessId}/metrics`;
    const r = await fetch(url, { method: isEdit ? 'PUT' : 'POST',
                                 headers: { 'Content-Type': 'application/json' },
                                 body: JSON.stringify(m) });
    if (r.ok) { setEdit(null); setAdd(false); refresh(); } else alert('Save failed');
  };
  const del = async (id) => {
    if (!window.confirm('Delete this metric?')) return;
    await fetch(`${API}/api/esg/metrics/${id}`, { method: 'DELETE' });
    refresh();
  };

  return (
    <div className="space-y-3">
      <div className="flex items-center gap-3 flex-wrap">
        <select className={inp + ' max-w-xs'} value={filter} onChange={e => setFilt(e.target.value)}>
          <option value="">All categories</option>
          {CATEGORIES.map(c => <option key={c}>{c}</option>)}
        </select>
        <span className="text-sm text-gray-500">{list.length} metric{list.length === 1 ? '' : 's'}</span>
        <div className="flex-1" />
        <button onClick={() => setAdd(true)} className={btn}>+ Add metric</button>
      </div>
      {adding && <MetricForm onSave={save} onCancel={() => setAdd(false)} />}
      {list.length === 0 && <div className="text-sm text-gray-500 italic">No manual ESG metrics yet. Add ones that aren't tracked automatically — e.g. renewable energy %, fair-wage premium paid, EU CSRD status, ISO 14001 certification.</div>}

      <div className="space-y-2">
        {list.map(m => editing?.MetricID === m.MetricID ? (
          <MetricForm key={m.MetricID} metric={editing} onSave={save} onCancel={() => setEdit(null)} />
        ) : (
          <div key={m.MetricID} className="bg-white border border-gray-200 rounded-xl p-3 flex items-start gap-3">
            <div className="text-2xl shrink-0">{CAT_ICON[m.Category] || '📋'}</div>
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <strong className="text-gray-900">{m.Label}</strong>
                <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-gray-100 text-gray-700 font-semibold uppercase">{m.Category}</span>
                <code className="text-[10px] text-gray-400">{m.MetricKey}</code>
              </div>
              <div className="text-xs text-gray-700 mt-0.5">
                <strong>{m.Value || '—'}</strong>
                {m.Unit && <span className="text-gray-500"> {m.Unit}</span>}
                {m.PeriodStart && <span className="text-gray-500"> · {(m.PeriodStart || '').slice(0,10)} → {(m.PeriodEnd || '').slice(0,10)}</span>}
              </div>
              {m.EvidenceURL && (
                <div className="text-xs text-gray-500 mt-0.5">
                  📎 <a href={m.EvidenceURL} target="_blank" rel="noreferrer" className="text-[#3D6B34] hover:underline">{m.EvidenceURL}</a>
                </div>
              )}
              {m.Notes && <div className="text-xs text-gray-500 mt-0.5">{m.Notes}</div>}
            </div>
            <button onClick={() => setEdit(m)} className={btnGhost}>Edit</button>
            <button onClick={() => del(m.MetricID)} className="text-xs text-red-600 hover:underline">Delete</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// Generate report
// ─────────────────────────────────────────────────────────────────
function GenerateTab({ businessId, onSaved }) {
  const [s, setS] = useState({
    Title: '',
    PeriodStart: isoDate(ninetyDaysAgo),
    PeriodEnd:   isoDate(today),
    Signatory: '',
    SignatureDate: isoDate(today),
    Notes: '',
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const [busy, setBusy] = useState(false);
  const [result, setResult] = useState(null);

  const submit = async () => {
    setBusy(true);
    const r = await fetch(`${API}/api/esg/${businessId}/reports/generate`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(s),
    });
    if (r.ok) {
      const j = await r.json();
      setResult(j);
      onSaved?.();
    } else { alert('Generate failed'); }
    setBusy(false);
  };

  return (
    <div className="space-y-3">
      <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
        <div className="text-sm text-gray-700">Snapshots all live + manual metrics for the period below into a saved record. Once saved you can download as PDF — auditors get one immutable file with the same numbers no matter when they open it.</div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
          <div><label className={lbl}>Title</label><input className={inp} placeholder="Q1 2026 ESG Report" value={s.Title} onChange={set('Title')} /></div>
          <div className="grid grid-cols-2 gap-2">
            <div><label className={lbl}>Period start</label><input className={inp} type="date" value={s.PeriodStart} onChange={set('PeriodStart')} /></div>
            <div><label className={lbl}>Period end</label><input className={inp} type="date" value={s.PeriodEnd} onChange={set('PeriodEnd')} /></div>
          </div>
          <div><label className={lbl}>Signatory</label><input className={inp} placeholder="Jane Doe, ESG Officer" value={s.Signatory} onChange={set('Signatory')} /></div>
          <div><label className={lbl}>Signature date</label><input className={inp} type="date" value={s.SignatureDate} onChange={set('SignatureDate')} /></div>
        </div>
        <div><label className={lbl}>Notes (auditor context)</label><textarea className={inp} rows={2} value={s.Notes} onChange={set('Notes')} /></div>
        <div className="flex justify-end">
          <button onClick={submit} disabled={busy} className={btn}>{busy ? 'Generating…' : 'Generate & save'}</button>
        </div>
      </div>

      {result && (
        <div className="bg-emerald-50 border border-emerald-300 rounded-xl p-4 space-y-2">
          <div className="flex items-center gap-2">
            <span className="text-lg">✅</span>
            <strong className="text-emerald-900">Saved as report #{result.ReportID}</strong>
          </div>
          <div className="flex gap-2 flex-wrap">
            <a href={`${API}/api/esg/reports/${result.ReportID}/pdf`} target="_blank" rel="noreferrer" className={btn}>⬇ Download PDF</a>
            <a href={`${API}/api/esg/reports/${result.ReportID}/html`} target="_blank" rel="noreferrer" className={btnGhost}>View HTML</a>
            <a href={`${API}/api/esg/reports/${result.ReportID}`} target="_blank" rel="noreferrer" className={btnGhost}>View JSON</a>
          </div>
        </div>
      )}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// Saved reports list
// ─────────────────────────────────────────────────────────────────
function ReportsTab({ businessId, refreshKey }) {
  const [list, setList] = useState([]);
  const refresh = () => fetch(`${API}/api/esg/${businessId}/reports`).then(r => r.json()).then(setList);
  useEffect(refresh, [businessId, refreshKey]);

  const del = async (id) => {
    if (!window.confirm('Delete this saved report? This cannot be undone (the snapshot data is gone).')) return;
    await fetch(`${API}/api/esg/reports/${id}`, { method: 'DELETE' });
    refresh();
  };

  return (
    <div className="space-y-2">
      {list.length === 0 && <div className="text-sm text-gray-500 italic">No saved reports yet. Use the Generate tab to create your first audit-ready snapshot.</div>}
      {list.map(r => (
        <div key={r.ReportID} className="bg-white border border-gray-200 rounded-xl p-3 flex items-start gap-3">
          <div className="text-2xl shrink-0">📄</div>
          <div className="flex-1 min-w-0">
            <div className="font-semibold text-gray-900">{r.Title || `Report #${r.ReportID}`}</div>
            <div className="text-xs text-gray-600 mt-0.5">
              Period {(r.PeriodStart || '').slice(0,10)} → {(r.PeriodEnd || '').slice(0,10)}
              {' · '}generated {(r.GeneratedDate || '').slice(0,10)}
              {r.Signatory && <> · signed by <strong>{r.Signatory}</strong></>}
            </div>
          </div>
          <a href={`${API}/api/esg/reports/${r.ReportID}/pdf`} target="_blank" rel="noreferrer" className={btn}>PDF</a>
          <a href={`${API}/api/esg/reports/${r.ReportID}/html`} target="_blank" rel="noreferrer" className={btnGhost}>HTML</a>
          <button onClick={() => del(r.ReportID)} className="text-xs text-red-600 hover:underline">Delete</button>
        </div>
      ))}
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// Page
// ─────────────────────────────────────────────────────────────────
const TABS = [
  { key: 'live',     label: 'Live snapshot' },
  { key: 'metrics',  label: 'Manual metrics' },
  { key: 'generate', label: 'Generate report' },
  { key: 'reports',  label: 'Saved reports' },
];

export default function AggregatorESG() {
  const [params] = useSearchParams();
  const { BusinessID: ctxBID } = useAccount();
  const BusinessID = params.get('BusinessID') || ctxBID;
  const [tab, setTab] = useState('live');
  const [reportsRefresh, setReportsRefresh] = useState(0);

  if (!BusinessID) {
    return (
      <AccountLayout pageTitle="ESG Reports">
        <div className="p-6 text-sm text-gray-500">Pick a business from the account picker.</div>
      </AccountLayout>
    );
  }

  return (
    <AccountLayout
      pageTitle="ESG Reports"
      breadcrumbs={[
        { label: 'Account', to: '/account' },
        { label: 'Food Aggregation', to: `/aggregator?BusinessID=${BusinessID}` },
        { label: 'ESG Reports' },
      ]}
    >
      <div className="max-w-6xl mx-auto p-5 space-y-4">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">ESG Reports</h1>
            <p className="text-sm text-gray-500 mt-1">Automated, audit-ready proof of sustainable practices. Live numbers come from your sourcing, procurement, cold-chain and input records — manual metrics fill in everything else.</p>
          </div>
          <Link to={`/aggregator?BusinessID=${BusinessID}`} className={btnGhost}>← Hub</Link>
        </div>

        <div className="border-b border-gray-200">
          <div className="flex gap-1">
            {TABS.map(t => (
              <button key={t.key} onClick={() => setTab(t.key)}
                      className={`px-4 py-2 text-sm font-medium ${tab === t.key
                        ? 'border-b-2 border-[#3D6B34] text-[#3D6B34]'
                        : 'text-gray-500 hover:text-gray-700'}`}>
                {t.label}
              </button>
            ))}
          </div>
        </div>

        {tab === 'live'     && <LiveTab businessId={BusinessID} />}
        {tab === 'metrics'  && <MetricsTab businessId={BusinessID} />}
        {tab === 'generate' && <GenerateTab businessId={BusinessID} onSaved={() => setReportsRefresh(x => x + 1)} />}
        {tab === 'reports'  && <ReportsTab businessId={BusinessID} refreshKey={reportsRefresh} />}
      </div>
    </AccountLayout>
  );
}
