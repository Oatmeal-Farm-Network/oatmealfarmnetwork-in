/**
 * AggregatorProduce — procurement and inventory.
 *
 * Tabs: Purchases (goods receipts with residue testing) and Inventory
 * (cold-storage stock with QC + expiry tracking). Creating a Purchase
 * auto-creates a matching Inventory row, so the cold-chain log starts
 * the moment the truck unloads.
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

const RESIDUE_STATUSES = ['pending', 'passed', 'failed'];
const PAYMENT_STATUSES = ['unpaid', 'partial', 'paid'];
const QC_STATUSES      = ['ok', 'hold', 'quarantine', 'discarded'];

const fmt$  = (n) => Number(n || 0).toLocaleString(undefined, { maximumFractionDigits: 2 });
const fmtKg = (n) => Number(n || 0).toLocaleString(undefined, { maximumFractionDigits: 1 });
const todayISO = () => new Date().toISOString().slice(0, 10);

const S = ({ children }) => (
  <svg width="18" height="18" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" className="shrink-0 text-[#3D6B34]">
    {children}
  </svg>
);
const IconPurchase = () => <S><path d="M2 5l6-3 6 3v6l-6 3-6-3V5z"/><path d="M8 2v12"/><path d="M2 5l6 3 6-3"/><path d="M8 8l-2-1"/></S>;
const IconCold     = () => <S><line x1="8" y1="1" x2="8" y2="15"/><line x1="1" y1="8" x2="15" y2="8"/><line x1="3.5" y1="3.5" x2="12.5" y2="12.5"/><line x1="12.5" y1="3.5" x2="3.5" y2="12.5"/></S>;

// ─────────────────────────────────────────────────────────────────
// Purchase form + tab
// ─────────────────────────────────────────────────────────────────
function PurchaseForm({ purchase, farms, contracts, onSave, onCancel }) {
  const [s, setS] = useState(purchase || {
    FarmID: '', ContractID: '', CropType: '', Grade: 'premium',
    QuantityKg: '', PricePerKg: '', TotalPaid: '',
    ResidueTestStatus: 'pending', ResidueTestNotes: '',
    HarvestDate: '', ReceivedDate: todayISO(),
    PaymentStatus: 'unpaid',
    ColdStorageUnit: '', TargetTempC: 4,
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  // auto compute total
  useEffect(() => {
    if (s.QuantityKg != null && s.PricePerKg != null && s.QuantityKg !== '' && s.PricePerKg !== '') {
      const t = Number(s.QuantityKg) * Number(s.PricePerKg);
      if (!Number.isNaN(t)) setS(prev => ({ ...prev, TotalPaid: t }));
    }
  }, [s.QuantityKg, s.PricePerKg]);

  // contracts filtered to selected farm
  const farmContracts = contracts.filter(c => Number(c.FarmID) === Number(s.FarmID) && c.Status === 'active');

  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Farm *</label>
          <select className={inp} value={s.FarmID} onChange={set('FarmID')}>
            <option value="">— select —</option>
            {farms.map(f => <option key={f.FarmID} value={f.FarmID}>{f.FarmName}</option>)}
          </select></div>
        <div><label className={lbl}>Crop *</label><input className={inp} value={s.CropType} onChange={set('CropType')} placeholder="blueberry" /></div>
        <div><label className={lbl}>Contract (optional)</label>
          <select className={inp} value={s.ContractID || ''} onChange={set('ContractID')} disabled={!s.FarmID}>
            <option value="">— spot buy —</option>
            {farmContracts.map(c => <option key={c.ContractID} value={c.ContractID}>{c.CropType} · {c.ContractType} · ${fmt$(c.PricePerKg)}/kg</option>)}
          </select></div>
        <div><label className={lbl}>Grade</label>
          <select className={inp} value={s.Grade || 'premium'} onChange={set('Grade')}>
            <option>premium</option><option>standard</option><option>processing</option>
          </select></div>
        <div><label className={lbl}>Quantity (kg) *</label><input className={inp} type="number" step="0.01" value={s.QuantityKg ?? ''} onChange={setNum('QuantityKg')} /></div>
        <div><label className={lbl}>Price per kg ($)</label><input className={inp} type="number" step="0.01" value={s.PricePerKg ?? ''} onChange={setNum('PricePerKg')} /></div>
        <div><label className={lbl}>Total paid ($)</label><input className={inp} type="number" step="0.01" value={s.TotalPaid ?? ''} onChange={setNum('TotalPaid')} /></div>
        <div><label className={lbl}>Residue test</label>
          <select className={inp} value={s.ResidueTestStatus} onChange={set('ResidueTestStatus')}>
            {RESIDUE_STATUSES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Payment</label>
          <select className={inp} value={s.PaymentStatus} onChange={set('PaymentStatus')}>
            {PAYMENT_STATUSES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Harvest date</label><input className={inp} type="date" value={s.HarvestDate || ''} onChange={set('HarvestDate')} /></div>
        <div><label className={lbl}>Received</label><input className={inp} type="date" value={s.ReceivedDate || ''} onChange={set('ReceivedDate')} /></div>
        {!purchase && <>
          <div><label className={lbl}>Cold storage unit</label><input className={inp} placeholder="bay 3 / chamber A" value={s.ColdStorageUnit || ''} onChange={set('ColdStorageUnit')} /></div>
          <div><label className={lbl}>Target temp (°C)</label><input className={inp} type="number" step="0.1" value={s.TargetTempC ?? ''} onChange={setNum('TargetTempC')} /></div>
        </>}
      </div>
      <div><label className={lbl}>Residue test notes</label><textarea className={inp} rows={2} value={s.ResidueTestNotes || ''} onChange={set('ResidueTestNotes')} /></div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} disabled={!s.FarmID || !s.CropType || !s.QuantityKg} className={btn}>Save</button>
      </div>
    </div>
  );
}

function PurchasesTab({ businessId, farms }) {
  const [list, setList]    = useState([]);
  const [contracts, setC]  = useState([]);
  const [editing, setEdit] = useState(null);
  const [adding, setAdd]   = useState(false);
  const [residue, setRes]  = useState('');
  const [crop, setCrop]    = useState('');

  const refresh = () => {
    const qs = new URLSearchParams();
    if (residue) qs.set('residue', residue);
    if (crop)    qs.set('crop',    crop);
    fetch(`${API}/api/aggregator/${businessId}/purchases?${qs}`).then(r => r.json()).then(setList);
  };
  useEffect(refresh, [businessId, residue, crop]);
  useEffect(() => {
    fetch(`${API}/api/aggregator/${businessId}/contracts`).then(r => r.json()).then(setC);
  }, [businessId]);

  const save = async (p) => {
    const isEdit = !!p.PurchaseID;
    const url = isEdit ? `${API}/api/aggregator/purchases/${p.PurchaseID}` : `${API}/api/aggregator/${businessId}/purchases`;
    const r = await fetch(url, { method: isEdit ? 'PUT' : 'POST',
                                 headers: { 'Content-Type': 'application/json' },
                                 body: JSON.stringify(p) });
    if (r.ok) { setEdit(null); setAdd(false); refresh(); } else alert('Save failed');
  };
  const del = async (id) => {
    if (!window.confirm('Delete this purchase? Linked inventory row will also go.')) return;
    await fetch(`${API}/api/aggregator/purchases/${id}`, { method: 'DELETE' });
    refresh();
  };

  const totalSpend = list.reduce((acc, r) => acc + Number(r.TotalPaid || 0), 0);
  const totalKg    = list.reduce((acc, r) => acc + Number(r.QuantityKg || 0), 0);
  const crops = [...new Set(list.map(r => r.CropType).filter(Boolean))].sort();

  const residueColor = (st) => st === 'passed' ? 'bg-emerald-100 text-emerald-800'
                          : st === 'failed' ? 'bg-red-100 text-red-800'
                          : 'bg-amber-100 text-amber-800';
  const paymentColor = (st) => st === 'paid' ? 'bg-emerald-100 text-emerald-800'
                          : st === 'partial' ? 'bg-amber-100 text-amber-800'
                          : 'bg-gray-100 text-gray-700';

  return (
    <div className="space-y-3">
      <div className="bg-white border border-gray-200 rounded-xl p-3 grid grid-cols-2 md:grid-cols-3 gap-3 text-sm">
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Records (filtered)</div><div className="text-xl font-bold">{list.length}</div></div>
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Total spend</div><div className="text-xl font-bold">${fmt$(totalSpend)}</div></div>
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Total received</div><div className="text-xl font-bold">{fmtKg(totalKg)} kg</div></div>
      </div>

      <div className="flex items-center gap-3 flex-wrap">
        <select className={inp + ' max-w-xs'} value={residue} onChange={e => setRes(e.target.value)}>
          <option value="">All residue statuses</option>
          {RESIDUE_STATUSES.map(x => <option key={x}>{x}</option>)}
        </select>
        <select className={inp + ' max-w-xs'} value={crop} onChange={e => setCrop(e.target.value)}>
          <option value="">All crops</option>
          {crops.map(c => <option key={c}>{c}</option>)}
        </select>
        <div className="flex-1" />
        <button onClick={() => setAdd(true)} disabled={farms.length === 0} className={btn}>+ Record purchase</button>
      </div>
      {farms.length === 0 && <div className="text-sm text-gray-500 italic">Add farms first.</div>}
      {adding && <PurchaseForm farms={farms} contracts={contracts} onSave={save} onCancel={() => setAdd(false)} />}

      <div className="space-y-2">
        {list.map(p => editing?.PurchaseID === p.PurchaseID ? (
          <PurchaseForm key={p.PurchaseID} purchase={editing} farms={farms} contracts={contracts}
                        onSave={save} onCancel={() => setEdit(null)} />
        ) : (
          <div key={p.PurchaseID} className="bg-white border border-gray-200 rounded-xl p-3 flex items-start gap-3">
            <div className="shrink-0 mt-0.5"><IconPurchase /></div>
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <strong className="text-gray-900">{p.FarmName || `Farm #${p.FarmID}`}</strong>
                <span className="text-sm text-gray-700">— {p.CropType}</span>
                {p.Grade && <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-blue-100 text-blue-800 font-semibold uppercase">{p.Grade}</span>}
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${residueColor(p.ResidueTestStatus)}`}>residue: {p.ResidueTestStatus}</span>
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${paymentColor(p.PaymentStatus)}`}>{p.PaymentStatus}</span>
              </div>
              <div className="text-xs text-gray-600 mt-0.5">
                {fmtKg(p.QuantityKg)} kg{p.PricePerKg != null && ` @ $${fmt$(p.PricePerKg)}/kg`}
                {p.TotalPaid != null && ` = $${fmt$(p.TotalPaid)}`}
                {p.ReceivedDate && ` · received ${(p.ReceivedDate || '').slice(0,10)}`}
                {p.HarvestDate && ` (harvest ${(p.HarvestDate || '').slice(0,10)})`}
              </div>
              {p.ResidueTestNotes && <div className="text-xs text-gray-500 mt-0.5">{p.ResidueTestNotes}</div>}
            </div>
            <button onClick={() => setEdit(p)} className={btnGhost}>Edit</button>
            <button onClick={() => del(p.PurchaseID)} className="text-xs text-red-600 hover:underline">Delete</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// Inventory tab — read-only list with inline edit (qty, temp, QC, expiry)
// ─────────────────────────────────────────────────────────────────
function InventoryEditForm({ row, onSave, onCancel }) {
  const [s, setS] = useState({
    CurrentKg: row.CurrentKg, ColdStorageUnit: row.ColdStorageUnit || '',
    TargetTempC: row.TargetTempC ?? '', CurrentTempC: row.CurrentTempC ?? '',
    QCStatus: row.QCStatus || 'ok', ExpiryDate: (row.ExpiryDate || '').slice(0,10),
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Current kg</label><input className={inp} type="number" step="0.01" value={s.CurrentKg ?? ''} onChange={setNum('CurrentKg')} /></div>
        <div><label className={lbl}>Cold storage unit</label><input className={inp} value={s.ColdStorageUnit} onChange={set('ColdStorageUnit')} /></div>
        <div><label className={lbl}>QC status</label>
          <select className={inp} value={s.QCStatus} onChange={set('QCStatus')}>
            {QC_STATUSES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Target °C</label><input className={inp} type="number" step="0.1" value={s.TargetTempC ?? ''} onChange={setNum('TargetTempC')} /></div>
        <div><label className={lbl}>Current °C</label><input className={inp} type="number" step="0.1" value={s.CurrentTempC ?? ''} onChange={setNum('CurrentTempC')} /></div>
        <div><label className={lbl}>Expiry</label><input className={inp} type="date" value={s.ExpiryDate || ''} onChange={set('ExpiryDate')} /></div>
      </div>
      <div className="flex justify-end gap-2">
        <button onClick={onCancel} className={btnGhost}>Cancel</button>
        <button onClick={() => onSave(s)} className={btn}>Save</button>
      </div>
    </div>
  );
}

function InventoryTab({ businessId }) {
  const [list, setList]    = useState([]);
  const [editing, setEdit] = useState(null);
  const [qcFilter, setQc]  = useState('');

  const refresh = () => {
    const qs = qcFilter ? `?qc=${qcFilter}` : '';
    fetch(`${API}/api/aggregator/${businessId}/inventory${qs}`).then(r => r.json()).then(setList);
  };
  useEffect(refresh, [businessId, qcFilter]);

  const save = async (s) => {
    const r = await fetch(`${API}/api/aggregator/inventory/${editing.InventoryID}`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(s),
    });
    if (r.ok) { setEdit(null); refresh(); } else alert('Save failed');
  };

  const totalKg = list.reduce((acc, r) => acc + Number(r.CurrentKg || 0), 0);
  const qcColor = (q) => q === 'ok' ? 'bg-emerald-100 text-emerald-800'
                       : q === 'hold' ? 'bg-amber-100 text-amber-800'
                       : q === 'quarantine' ? 'bg-red-100 text-red-800'
                       : 'bg-gray-200 text-gray-700';

  const tempBreach = (r) => r.TargetTempC != null && r.CurrentTempC != null
                            && Number(r.CurrentTempC) > Number(r.TargetTempC) + 2;

  return (
    <div className="space-y-3">
      <div className="bg-white border border-gray-200 rounded-xl p-3 grid grid-cols-2 md:grid-cols-3 gap-3 text-sm">
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">SKUs in storage</div><div className="text-xl font-bold">{list.length}</div></div>
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Total stock</div><div className="text-xl font-bold">{fmtKg(totalKg)} kg</div></div>
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">On hold/quarantine</div><div className="text-xl font-bold">{list.filter(r => r.QCStatus === 'hold' || r.QCStatus === 'quarantine').length}</div></div>
      </div>

      <div className="flex items-center gap-3 flex-wrap">
        <select className={inp + ' max-w-xs'} value={qcFilter} onChange={e => setQc(e.target.value)}>
          <option value="">All QC statuses</option>
          {QC_STATUSES.map(x => <option key={x}>{x}</option>)}
        </select>
      </div>

      <div className="space-y-2">
        {list.length === 0 && <div className="text-sm text-gray-500 italic">No inventory yet. Inventory rows are auto-created when you record a purchase.</div>}
        {list.map(r => editing?.InventoryID === r.InventoryID ? (
          <InventoryEditForm key={r.InventoryID} row={editing} onSave={save} onCancel={() => setEdit(null)} />
        ) : (
          <div key={r.InventoryID} className={`border rounded-xl p-3 flex items-start gap-3 ${tempBreach(r) ? 'bg-red-50 border-red-300' : 'bg-white border-gray-200'}`}>
            <div className="shrink-0 mt-0.5"><IconCold /></div>
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <strong className="text-gray-900">{r.CropType || '—'}</strong>
                <span className="text-sm text-gray-700">{fmtKg(r.CurrentKg)} kg</span>
                {r.FarmName && <span className="text-xs text-gray-500">from {r.FarmName}</span>}
                {r.Grade && <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-blue-100 text-blue-800 font-semibold uppercase">{r.Grade}</span>}
                {r.ResidueTestStatus && <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${r.ResidueTestStatus === 'passed' ? 'bg-emerald-100 text-emerald-800' : r.ResidueTestStatus === 'failed' ? 'bg-red-100 text-red-800' : 'bg-amber-100 text-amber-800'}`}>residue: {r.ResidueTestStatus}</span>}
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${qcColor(r.QCStatus)}`}>QC: {r.QCStatus}</span>
                {tempBreach(r) && <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-red-200 text-red-900 font-semibold uppercase">temp breach</span>}
              </div>
              <div className="text-xs text-gray-600 mt-0.5">
                {r.ColdStorageUnit && `${r.ColdStorageUnit} · `}
                {r.TargetTempC != null && `target ${r.TargetTempC}°C`}
                {r.CurrentTempC != null && ` · current ${r.CurrentTempC}°C`}
                {r.ExpiryDate && ` · expires ${(r.ExpiryDate || '').slice(0,10)}`}
              </div>
            </div>
            <button onClick={() => setEdit(r)} className={btnGhost}>Edit</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// Page
// ─────────────────────────────────────────────────────────────────
const TABS = [
  { key: 'purchases', label: 'Purchases (goods receipts)' },
  { key: 'inventory', label: 'Inventory & cold storage' },
];

export default function AggregatorProduce() {
  const [params] = useSearchParams();
  const { BusinessID: ctxBID } = useAccount();
  const BusinessID = params.get('BusinessID') || ctxBID;
  const [tab, setTab] = useState('purchases');
  const [farms, setFarms] = useState([]);
  useEffect(() => {
    if (!BusinessID) return;
    fetch(`${API}/api/aggregator/${BusinessID}/farms`).then(r => r.json()).then(setFarms);
  }, [BusinessID]);

  if (!BusinessID) {
    return (
      <AccountLayout pageTitle="Procurement & Inventory">
        <div className="p-6 text-sm text-gray-500">Pick a business from the account picker.</div>
      </AccountLayout>
    );
  }

  return (
    <AccountLayout
      pageTitle="Procurement & Inventory"
      breadcrumbs={[
        { label: 'Account', to: '/account' },
        { label: 'Food Aggregation', to: `/aggregator?BusinessID=${BusinessID}` },
        { label: 'Procurement & Inventory' },
      ]}
    >
      <div className="max-w-6xl mx-auto p-5 space-y-4">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">Procurement & Inventory</h1>
            <p className="text-sm text-gray-500 mt-1">Goods receipts from your farms, residue testing, and what's currently in cold storage.</p>
          </div>
          <Link to={`/aggregator?BusinessID=${BusinessID}`} className={btnGhost}>← Hub</Link>
        </div>

        <div className="border-b border-gray-200">
          <div className="flex gap-1">
            {TABS.map(t => (
              <button key={t.key}
                      onClick={() => setTab(t.key)}
                      className={`px-4 py-2 text-sm font-medium ${tab === t.key
                        ? 'border-b-2 border-[#3D6B34] text-[#3D6B34]'
                        : 'text-gray-500 hover:text-gray-700'}`}>
                {t.label}
              </button>
            ))}
          </div>
        </div>

        {tab === 'purchases' && <PurchasesTab businessId={BusinessID} farms={farms} />}
        {tab === 'inventory' && <InventoryTab businessId={BusinessID} />}
      </div>
    </AccountLayout>
  );
}
