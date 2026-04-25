/**
 * BoothServicesAdmin — manage the per-event service catalog (electrical,
 * water, table rental, internet, AV, drayage). Vendors order these line
 * items at booking time. Includes a revenue-by-service summary at top.
 */
import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";
const btnGhost = "px-3 py-1.5 text-sm border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50";

const CATEGORIES = ['general', 'electrical', 'water', 'internet', 'furniture', 'av', 'shipping'];
const CAT_ICON = { general: '📦', electrical: '⚡', water: '💧', internet: '📶', furniture: '🪑', av: '📺', shipping: '🚚' };

function ServiceForm({ svc, onSave, onCancel }) {
  const [s, setS] = useState(svc || {
    Name: '', Description: '', Category: 'general', Price: 0, Unit: 'each',
    MaxPerBooth: '', IsRequired: false, IsActive: true, SortOrder: 100,
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
        <div className="md:col-span-2"><label className={lbl}>Name *</label><input className={inp} placeholder="e.g. 110V outlet (single)" value={s.Name} onChange={set('Name')} /></div>
        <div><label className={lbl}>Category</label>
          <select className={inp} value={s.Category} onChange={set('Category')}>
            {CATEGORIES.map(c => <option key={c} value={c}>{CAT_ICON[c]} {c}</option>)}
          </select></div>
        <div><label className={lbl}>Sort order</label><input className={inp} type="number" value={s.SortOrder ?? 100} onChange={setNum('SortOrder')} /></div>
        <div><label className={lbl}>Price ($) *</label><input className={inp} type="number" step="0.01" value={s.Price ?? 0} onChange={setNum('Price')} /></div>
        <div><label className={lbl}>Unit</label><input className={inp} placeholder="each / day / linear ft / kWh" value={s.Unit || 'each'} onChange={set('Unit')} /></div>
        <div><label className={lbl}>Max per booth</label><input className={inp} type="number" placeholder="unlimited" value={s.MaxPerBooth ?? ''} onChange={setNum('MaxPerBooth')} /></div>
        <div className="flex items-end gap-3">
          <label className="flex items-center gap-1 text-sm"><input type="checkbox" checked={!!s.IsActive} onChange={e => setS(prev => ({ ...prev, IsActive: e.target.checked }))} />Active</label>
          <label className="flex items-center gap-1 text-sm"><input type="checkbox" checked={!!s.IsRequired} onChange={e => setS(prev => ({ ...prev, IsRequired: e.target.checked }))} />Required</label>
        </div>
      </div>
      <div><label className={lbl}>Description</label><textarea className={inp} rows={2} value={s.Description || ''} onChange={set('Description')} placeholder="What this service includes; any restrictions" /></div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} disabled={!s.Name} className={btn}>Save</button>
      </div>
    </div>
  );
}

export default function BoothServicesAdmin() {
  const { eventId } = useParams();
  const [services, setServices] = useState([]);
  const [revenue, setRevenue]   = useState(null);
  const [editing, setEditing]   = useState(null);
  const [adding, setAdding]     = useState(false);
  const [loading, setLoading]   = useState(true);

  const refresh = () => {
    setLoading(true);
    Promise.all([
      fetch(`${API}/api/events/${eventId}/booth-services?active_only=false`).then(r => r.json()),
      fetch(`${API}/api/events/${eventId}/booth-services/revenue`).then(r => r.json()),
    ]).then(([s, r]) => { setServices(s); setRevenue(r); setLoading(false); });
  };
  useEffect(refresh, [eventId]);

  const save = async (s) => {
    const isEdit = !!s.ServiceID;
    const url = isEdit ? `${API}/api/events/booth-services/${s.ServiceID}` : `${API}/api/events/${eventId}/booth-services`;
    const r = await fetch(url, { method: isEdit ? 'PUT' : 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(s) });
    if (r.ok) { setEditing(null); setAdding(false); refresh(); } else alert('Save failed');
  };
  const del = async (id) => {
    if (!window.confirm('Delete this service?')) return;
    const r = await fetch(`${API}/api/events/booth-services/${id}`, { method: 'DELETE' });
    const j = await r.json();
    if (j.soft_deleted) alert(j.message || 'Deactivated (in-use).');
    refresh();
  };

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl mx-auto p-5 space-y-5">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">Booth Services Catalog</h1>
            <p className="text-sm text-gray-500">À la carte services vendors can order at booking time. Revenue rolls up here in real time.</p>
          </div>
          <Link to={`/events/${eventId}`} className={btnGhost}>← Event detail</Link>
        </div>

        {revenue && (
          <div className="bg-white border border-gray-200 rounded-xl p-4">
            <div className="flex items-end justify-between flex-wrap gap-3">
              <div>
                <div className="text-[10px] uppercase text-gray-500 font-semibold">Total services revenue</div>
                <div className="text-3xl font-bold text-gray-900">${Number(revenue.total_revenue || 0).toLocaleString()}</div>
              </div>
              <div className="text-xs text-gray-500">across {(revenue.by_service || []).length} catalog item(s)</div>
            </div>
            {revenue.by_service?.length > 0 && (
              <div className="mt-3 grid md:grid-cols-2 lg:grid-cols-3 gap-2">
                {revenue.by_service.filter(r => Number(r.revenue || 0) > 0).map(r => (
                  <div key={r.ServiceID} className="border border-gray-100 rounded-lg p-2 text-xs">
                    <div className="font-semibold text-gray-700">{CAT_ICON[r.Category] || '📦'} {r.Name}</div>
                    <div className="text-gray-500">{r.units_sold} {r.Unit} · ${Number(r.revenue).toFixed(2)}</div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        <div className="flex justify-end">
          <button onClick={() => setAdding(true)} className={btn}>+ Add service</button>
        </div>
        {adding && <ServiceForm onSave={save} onCancel={() => setAdding(false)} />}

        {loading && <div className="text-sm text-gray-500">Loading…</div>}
        {!loading && services.length === 0 && (
          <div className="text-sm text-gray-500 italic">No services configured yet. Common starting set: 110V outlet, 220V outlet, water hookup, internet (wifi), 6ft table, chair, banner stand, drayage.</div>
        )}

        <div className="space-y-2">
          {services.map(s => editing?.ServiceID === s.ServiceID ? (
            <ServiceForm key={s.ServiceID} svc={editing} onSave={save} onCancel={() => setEditing(null)} />
          ) : (
            <div key={s.ServiceID} className={`border rounded-xl p-3 flex items-start gap-3 ${s.IsActive ? 'bg-white border-gray-200' : 'bg-gray-50 border-gray-200'}`}>
              <div className="text-2xl shrink-0">{CAT_ICON[s.Category] || '📦'}</div>
              <div className="flex-1">
                <div className="flex items-center gap-2 flex-wrap">
                  <strong className={s.IsActive ? 'text-gray-900' : 'text-gray-500'}>{s.Name}</strong>
                  <span className="text-sm text-gray-600">${Number(s.Price || 0).toFixed(2)} / {s.Unit}</span>
                  {s.IsRequired && <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-red-100 text-red-800 font-semibold uppercase">Required</span>}
                  {!s.IsActive && <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-gray-200 text-gray-700 font-semibold uppercase">Inactive</span>}
                  {s.MaxPerBooth && <span className="text-xs text-gray-500">max {s.MaxPerBooth} per booth</span>}
                </div>
                {s.Description && <div className="text-xs text-gray-600 mt-0.5">{s.Description}</div>}
              </div>
              <button onClick={() => setEditing(s)} className={btnGhost}>Edit</button>
              <button onClick={() => del(s.ServiceID)} className="text-xs text-red-600 hover:underline">Delete</button>
            </div>
          ))}
        </div>
      </div>
    </EventAdminLayout>
  );
}
