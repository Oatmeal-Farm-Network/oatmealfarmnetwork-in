import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';

const API = import.meta.env.VITE_API_URL || '';

function authHeaders() {
  const t = localStorage.getItem('access_token');
  return t ? { Authorization: `Bearer ${t}` } : {};
}

const FEATURE_SCOPES = [
  { value: '', label: '— Whole cart —' },
  { value: 'halter',     label: 'Halter entries only' },
  { value: 'fleece',     label: 'Fleece entries only' },
  { value: 'spinoff',    label: 'Spin-off entries only' },
  { value: 'fiber-arts', label: 'Fiber arts entries only' },
  { value: 'meal',       label: 'Meal tickets only' },
  { value: 'vendor',     label: 'Vendor booths only' },
];

const EMPTY = {
  Code: '',
  Description: '',
  DiscountType: 'percent',
  DiscountValue: 10,
  FeatureScope: '',
  MinCartTotal: '',
  MaxUses: '',
  ValidFrom: '',
  ValidUntil: '',
  AutoApply: false,
  IsActive: true,
};

export default function PromoCodesAdmin() {
  const { eventId } = useParams();
  const [codes, setCodes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(null);

  const load = () => {
    setLoading(true);
    fetch(`${API}/api/events/${eventId}/promo-codes`, { headers: authHeaders() })
      .then(r => r.json())
      .then(d => setCodes(Array.isArray(d) ? d : []))
      .finally(() => setLoading(false));
  };
  useEffect(load, [eventId]);

  const saveCode = async (data) => {
    const isNew = !data.CodeID;
    const url = isNew
      ? `${API}/api/events/${eventId}/promo-codes`
      : `${API}/api/events/promo-codes/${data.CodeID}`;
    const res = await fetch(url, {
      method: isNew ? 'POST' : 'PUT',
      headers: { 'Content-Type': 'application/json', ...authHeaders() },
      body: JSON.stringify(data),
    });
    if (!res.ok) {
      const t = await res.text();
      alert(`Save failed: ${t}`);
      return;
    }
    setEditing(null);
    load();
  };

  const deleteCode = async (c) => {
    if (!confirm(`Deactivate code "${c.Code}"?`)) return;
    await fetch(`${API}/api/events/promo-codes/${c.CodeID}`, {
      method: 'DELETE', headers: authHeaders(),
    });
    load();
  };

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl">
        <div className="flex items-start justify-between gap-4 mb-2">
          <div>
            <h1 className="text-2xl font-semibold text-[#3D6B34]">Promo Codes & Discounts</h1>
            <p className="text-sm text-gray-600 mt-1">
              Create discount codes for marketing, comp tickets, or group rates.
              Mark a code <strong>Auto-apply</strong> to run an automatic early-bird
              discount — attendees get it without typing anything.
            </p>
          </div>
          <button onClick={() => setEditing({ ...EMPTY })}
            className="text-xs px-3 py-1.5 rounded-lg bg-[#3D6B34] text-white hover:bg-[#2f5226] whitespace-nowrap">
            + New code
          </button>
        </div>

        {loading ? (
          <div className="bg-white rounded-xl shadow p-6 text-sm text-gray-500">Loading…</div>
        ) : codes.length === 0 ? (
          <div className="bg-white rounded-xl shadow p-8 text-center text-sm text-gray-500">
            No promo codes yet. Create one above to enable discounts.
          </div>
        ) : (
          <div className="bg-white rounded-xl shadow overflow-hidden">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 text-[10px] uppercase text-gray-500">
                <tr>
                  <th className="text-left px-4 py-2 font-semibold">Code</th>
                  <th className="text-left px-4 py-2 font-semibold">Discount</th>
                  <th className="text-left px-4 py-2 font-semibold">Scope</th>
                  <th className="text-left px-4 py-2 font-semibold">Uses</th>
                  <th className="text-left px-4 py-2 font-semibold">Valid</th>
                  <th className="text-left px-4 py-2 font-semibold">Flags</th>
                  <th className="text-right px-4 py-2 font-semibold">Actions</th>
                </tr>
              </thead>
              <tbody>
                {codes.map(c => (
                  <tr key={c.CodeID} className={`border-t border-gray-100 ${c.IsActive ? '' : 'opacity-50'}`}>
                    <td className="px-4 py-2 font-mono font-medium text-gray-800">{c.Code}</td>
                    <td className="px-4 py-2">
                      {c.DiscountType === 'percent' ? `${Number(c.DiscountValue)}%` : `$${Number(c.DiscountValue).toFixed(2)}`}
                    </td>
                    <td className="px-4 py-2 text-xs text-gray-600">
                      {c.FeatureScope || 'Whole cart'}
                    </td>
                    <td className="px-4 py-2 text-xs text-gray-600">
                      {c.UsesSoFar || 0}{c.MaxUses ? ` / ${c.MaxUses}` : ''}
                    </td>
                    <td className="px-4 py-2 text-xs text-gray-500">
                      {c.ValidFrom ? new Date(c.ValidFrom).toLocaleDateString() : 'Now'}
                      {' → '}
                      {c.ValidUntil ? new Date(c.ValidUntil).toLocaleDateString() : '∞'}
                    </td>
                    <td className="px-4 py-2 text-xs">
                      {c.AutoApply && <span className="inline-block bg-amber-100 text-amber-700 px-2 py-0.5 rounded">Auto</span>}
                      {!c.IsActive && <span className="inline-block bg-gray-100 text-gray-500 px-2 py-0.5 rounded ml-1">Off</span>}
                    </td>
                    <td className="px-4 py-2 text-right whitespace-nowrap">
                      <button onClick={() => setEditing(c)} className="text-xs text-[#3D6B34] hover:underline mr-3">Edit</button>
                      <button onClick={() => deleteCode(c)} className="text-xs text-red-600 hover:underline">Deactivate</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {editing && <CodeEditor code={editing} onSave={saveCode} onClose={() => setEditing(null)} />}
      </div>
    </EventAdminLayout>
  );
}

function CodeEditor({ code, onSave, onClose }) {
  const [d, setD] = useState({ ...code });
  const set = (k, v) => setD(p => ({ ...p, [k]: v }));
  return (
    <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full p-5">
        <h2 className="text-lg font-semibold text-[#3D6B34] mb-3">
          {code.CodeID ? `Edit ${code.Code}` : 'New promo code'}
        </h2>
        <div className="grid grid-cols-2 gap-3 text-sm">
          <Label title="Code (e.g. EARLYBIRD)">
            <input className="border rounded px-3 py-2 w-full font-mono uppercase"
              disabled={!!code.CodeID}
              value={d.Code} onChange={e => set('Code', e.target.value.toUpperCase())} />
          </Label>
          <Label title="Description (internal)">
            <input className="border rounded px-3 py-2 w-full"
              value={d.Description || ''} onChange={e => set('Description', e.target.value)} />
          </Label>
          <Label title="Discount type">
            <select className="border rounded px-3 py-2 w-full" value={d.DiscountType}
              onChange={e => set('DiscountType', e.target.value)}>
              <option value="percent">Percent off</option>
              <option value="flat">Flat $ off</option>
            </select>
          </Label>
          <Label title={`Value ${d.DiscountType === 'percent' ? '(%)' : '($)'}`}>
            <input type="number" step="0.01" className="border rounded px-3 py-2 w-full"
              value={d.DiscountValue} onChange={e => set('DiscountValue', e.target.value)} />
          </Label>
          <Label title="Scope">
            <select className="border rounded px-3 py-2 w-full" value={d.FeatureScope || ''}
              onChange={e => set('FeatureScope', e.target.value)}>
              {FEATURE_SCOPES.map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
            </select>
          </Label>
          <Label title="Min cart total ($, optional)">
            <input type="number" step="0.01" className="border rounded px-3 py-2 w-full"
              value={d.MinCartTotal || ''} onChange={e => set('MinCartTotal', e.target.value)} />
          </Label>
          <Label title="Max uses (optional)">
            <input type="number" className="border rounded px-3 py-2 w-full"
              value={d.MaxUses || ''} onChange={e => set('MaxUses', e.target.value)} />
          </Label>
          <div />
          <Label title="Valid from (optional)">
            <input type="datetime-local" className="border rounded px-3 py-2 w-full"
              value={(d.ValidFrom || '').substring(0, 16)}
              onChange={e => set('ValidFrom', e.target.value)} />
          </Label>
          <Label title="Valid until (optional)">
            <input type="datetime-local" className="border rounded px-3 py-2 w-full"
              value={(d.ValidUntil || '').substring(0, 16)}
              onChange={e => set('ValidUntil', e.target.value)} />
          </Label>
          <label className="col-span-2 flex items-center gap-2 mt-2">
            <input type="checkbox" checked={!!d.AutoApply}
              onChange={e => set('AutoApply', e.target.checked)} />
            <span className="text-sm">Auto-apply (early bird — applied silently in the wizard)</span>
          </label>
          <label className="col-span-2 flex items-center gap-2">
            <input type="checkbox" checked={d.IsActive !== false}
              onChange={e => set('IsActive', e.target.checked)} />
            <span className="text-sm">Active</span>
          </label>
        </div>
        <div className="flex justify-end gap-2 mt-5">
          <button onClick={onClose} className="text-sm px-4 py-2 rounded border border-gray-300">Cancel</button>
          <button onClick={() => onSave(d)} className="text-sm px-4 py-2 rounded bg-[#3D6B34] text-white">
            {code.CodeID ? 'Save' : 'Create'}
          </button>
        </div>
      </div>
    </div>
  );
}

function Label({ title, children }) {
  return (
    <div>
      <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold mb-1">{title}</div>
      {children}
    </div>
  );
}
