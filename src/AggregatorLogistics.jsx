/**
 * AggregatorLogistics — dispatch and cold-chain tracking.
 *
 * Each dispatch is a single vehicle moving goods between three legs:
 *  - inbound : farm → aggregator (matches a Purchase)
 *  - b2b     : aggregator → buyer (matches a B2B order)
 *  - d2c     : aggregator → consumer (matches a D2C order)
 * Cold-chain temperature is logged per dispatch; a breach flag marks any
 * trip where the cooling threshold was violated, surfacing on the hub
 * dashboard.
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

const ORDER_TYPES = ['b2b', 'd2c', 'inbound'];
const STATUSES    = ['scheduled', 'in_transit', 'delivered', 'failed'];
const ORDER_TYPE_ICON = { b2b: '🏬', d2c: '🛵', inbound: '🚜' };

const fmtDT = (s) => s ? new Date(s).toLocaleString(undefined, { dateStyle: 'short', timeStyle: 'short' }) : '';

function DispatchForm({ row, onSave, onCancel }) {
  const [s, setS] = useState(row || {
    OrderType: 'b2b', OrderID: '', VehicleID: '',
    DriverName: '', DriverPhone: '',
    PickupTime: '', DeliveryTime: '',
    ColdChainTempC: '', ColdChainBreach: false,
    RouteNotes: '', Status: 'scheduled',
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  const setBool = k => e => setS(prev => ({ ...prev, [k]: e.target.checked }));
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Type *</label>
          <select className={inp} value={s.OrderType} onChange={set('OrderType')}>
            {ORDER_TYPES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Linked order ID</label><input className={inp} type="number" value={s.OrderID ?? ''} onChange={setNum('OrderID')} placeholder="purchase / B2B / D2C" /></div>
        <div><label className={lbl}>Status</label>
          <select className={inp} value={s.Status} onChange={set('Status')}>
            {STATUSES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Vehicle ID</label><input className={inp} value={s.VehicleID || ''} onChange={set('VehicleID')} placeholder="MH-12 AB 1234 / fleet #07" /></div>
        <div><label className={lbl}>Driver name</label><input className={inp} value={s.DriverName || ''} onChange={set('DriverName')} /></div>
        <div><label className={lbl}>Driver phone</label><input className={inp} value={s.DriverPhone || ''} onChange={set('DriverPhone')} /></div>
        <div><label className={lbl}>Pickup time</label><input className={inp} type="datetime-local" value={(s.PickupTime || '').slice(0,16)} onChange={set('PickupTime')} /></div>
        <div><label className={lbl}>Delivery time</label><input className={inp} type="datetime-local" value={(s.DeliveryTime || '').slice(0,16)} onChange={set('DeliveryTime')} /></div>
        <div><label className={lbl}>Max cold-chain temp (°C)</label><input className={inp} type="number" step="0.1" value={s.ColdChainTempC ?? ''} onChange={setNum('ColdChainTempC')} /></div>
        <div className="flex items-end">
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={!!s.ColdChainBreach} onChange={setBool('ColdChainBreach')} />
            Cold chain breach
          </label>
        </div>
      </div>
      <div><label className={lbl}>Route notes</label><textarea className={inp} rows={2} value={s.RouteNotes || ''} onChange={set('RouteNotes')} placeholder="Stops, delays, gate/dock instructions" /></div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} className={btn}>Save</button>
      </div>
    </div>
  );
}

export default function AggregatorLogistics() {
  const [params] = useSearchParams();
  const { BusinessID: ctxBID } = useAccount();
  const BusinessID = params.get('BusinessID') || ctxBID;
  const [list, setList]    = useState([]);
  const [editing, setEdit] = useState(null);
  const [adding, setAdd]   = useState(false);
  const [statusF, setStF]  = useState('');
  const [typeF,   setTpF]  = useState('');

  const refresh = () => {
    if (!BusinessID) return;
    const qs = new URLSearchParams();
    if (statusF) qs.set('status',     statusF);
    if (typeF)   qs.set('order_type', typeF);
    fetch(`${API}/api/aggregator/${BusinessID}/logistics?${qs}`).then(r => r.json()).then(setList);
  };
  useEffect(refresh, [BusinessID, statusF, typeF]);

  const save = async (d) => {
    const isEdit = !!d.DispatchID;
    const url = isEdit ? `${API}/api/aggregator/logistics/${d.DispatchID}` : `${API}/api/aggregator/${BusinessID}/logistics`;
    const r = await fetch(url, { method: isEdit ? 'PUT' : 'POST',
                                 headers: { 'Content-Type': 'application/json' },
                                 body: JSON.stringify(d) });
    if (r.ok) { setEdit(null); setAdd(false); refresh(); } else alert('Save failed');
  };
  const del = async (id) => {
    if (!window.confirm('Delete this dispatch record?')) return;
    await fetch(`${API}/api/aggregator/logistics/${id}`, { method: 'DELETE' });
    refresh();
  };

  if (!BusinessID) {
    return (
      <AccountLayout pageTitle="Logistics">
        <div className="p-6 text-sm text-gray-500">Pick a business from the account picker.</div>
      </AccountLayout>
    );
  }

  const inTransit = list.filter(r => r.Status === 'in_transit').length;
  const breaches  = list.filter(r => r.ColdChainBreach).length;
  const statusColor = (st) => st === 'delivered' ? 'bg-emerald-100 text-emerald-800'
                          : st === 'in_transit' ? 'bg-blue-100 text-blue-800'
                          : st === 'failed' ? 'bg-red-100 text-red-800'
                          : 'bg-gray-100 text-gray-700';

  return (
    <AccountLayout
      pageTitle="Logistics"
      breadcrumbs={[
        { label: 'Account', to: '/account' },
        { label: 'Food Aggregation', to: `/aggregator?BusinessID=${BusinessID}` },
        { label: 'Logistics' },
      ]}
    >
      <div className="max-w-6xl mx-auto p-5 space-y-4">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">Logistics</h1>
            <p className="text-sm text-gray-500 mt-1">Dispatch records covering inbound (farm pickup), B2B delivery, and D2C last-mile — with cold-chain temp logging and breach flagging.</p>
          </div>
          <Link to={`/aggregator?BusinessID=${BusinessID}`} className={btnGhost}>← Hub</Link>
        </div>

        <div className="bg-white border border-gray-200 rounded-xl p-3 grid grid-cols-3 gap-3 text-sm">
          <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Records (filtered)</div><div className="text-xl font-bold">{list.length}</div></div>
          <div><div className="text-[10px] uppercase text-gray-500 font-semibold">In transit</div><div className="text-xl font-bold">{inTransit}</div></div>
          <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Cold-chain breaches</div><div className={`text-xl font-bold ${breaches > 0 ? 'text-red-600' : ''}`}>{breaches}</div></div>
        </div>

        <div className="flex items-center gap-3 flex-wrap">
          <select className={inp + ' max-w-xs'} value={typeF} onChange={e => setTpF(e.target.value)}>
            <option value="">All types</option>
            {ORDER_TYPES.map(x => <option key={x}>{x}</option>)}
          </select>
          <select className={inp + ' max-w-xs'} value={statusF} onChange={e => setStF(e.target.value)}>
            <option value="">All statuses</option>
            {STATUSES.map(x => <option key={x}>{x}</option>)}
          </select>
          <div className="flex-1" />
          <button onClick={() => setAdd(true)} className={btn}>+ Schedule dispatch</button>
        </div>

        {adding && <DispatchForm onSave={save} onCancel={() => setAdd(false)} />}
        {list.length === 0 && <div className="text-sm text-gray-500 italic">No dispatch records yet.</div>}

        <div className="space-y-2">
          {list.map(r => editing?.DispatchID === r.DispatchID ? (
            <DispatchForm key={r.DispatchID} row={editing} onSave={save} onCancel={() => setEdit(null)} />
          ) : (
            <div key={r.DispatchID}
                 className={`border rounded-xl p-3 flex items-start gap-3 ${r.ColdChainBreach ? 'bg-red-50 border-red-300' : 'bg-white border-gray-200'}`}>
              <div className="text-2xl shrink-0">{ORDER_TYPE_ICON[r.OrderType] || '🚛'}</div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 flex-wrap">
                  <strong className="text-gray-900 capitalize">{r.OrderType}</strong>
                  {r.OrderID && <span className="text-xs text-gray-500">order #{r.OrderID}</span>}
                  <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${statusColor(r.Status)}`}>{r.Status}</span>
                  {r.ColdChainBreach && <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-red-200 text-red-900 font-semibold uppercase">⚠ breach</span>}
                </div>
                <div className="text-xs text-gray-700 mt-0.5">
                  {r.VehicleID && `🚐 ${r.VehicleID}`}
                  {r.DriverName && ` · ${r.DriverName}`}
                  {r.DriverPhone && ` (${r.DriverPhone})`}
                </div>
                <div className="text-xs text-gray-500 mt-0.5">
                  {r.PickupTime && `pickup ${fmtDT(r.PickupTime)}`}
                  {r.DeliveryTime && ` → delivered ${fmtDT(r.DeliveryTime)}`}
                  {r.ColdChainTempC != null && ` · max ${r.ColdChainTempC}°C`}
                </div>
                {r.RouteNotes && <div className="text-xs text-gray-500 mt-0.5">{r.RouteNotes}</div>}
              </div>
              <button onClick={() => setEdit(r)} className={btnGhost}>Edit</button>
              <button onClick={() => del(r.DispatchID)} className="text-xs text-red-600 hover:underline">Delete</button>
            </div>
          ))}
        </div>
      </div>
    </AccountLayout>
  );
}
