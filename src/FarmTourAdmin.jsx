import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

function d(v) { return v ? String(v).substring(0, 10) : ''; }

function fmtSlot(iso) {
  if (!iso) return '';
  const dt = new Date(iso);
  if (isNaN(dt)) return String(iso);
  return dt.toLocaleString([], { weekday: 'short', month: 'short', day: 'numeric', hour: 'numeric', minute: '2-digit' });
}

function toLocalInput(iso) {
  if (!iso) return '';
  const dt = new Date(iso);
  if (isNaN(dt)) return '';
  const pad = (n) => String(n).padStart(2, '0');
  return `${dt.getFullYear()}-${pad(dt.getMonth()+1)}-${pad(dt.getDate())}T${pad(dt.getHours())}:${pad(dt.getMinutes())}`;
}

const EMPTY_CONFIG = {
  Description: '', PricePerAdult: 0, PricePerChild: '', ChildAgeLimit: 12,
  DefaultSlotCapacity: 15, RequireWaiver: true, WaiverText: '',
  ParkingNotes: '', DrivingDirections: '', ThingsToBring: '',
  RegistrationEndDate: '', IsActive: true,
};

function ConfigTab({ eventId }) {
  const [cfg, setCfg] = useState(EMPTY_CONFIG);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');

  const load = () => fetch(`${API}/api/events/${eventId}/tour/config`)
    .then(r => r.json())
    .then(d_ => {
      if (d_?.configured) {
        setCfg({
          Description: d_.Description || '',
          PricePerAdult: d_.PricePerAdult || 0,
          PricePerChild: d_.PricePerChild ?? '',
          ChildAgeLimit: d_.ChildAgeLimit ?? 12,
          DefaultSlotCapacity: d_.DefaultSlotCapacity ?? 15,
          RequireWaiver: !!d_.RequireWaiver,
          WaiverText: d_.WaiverText || '',
          ParkingNotes: d_.ParkingNotes || '',
          DrivingDirections: d_.DrivingDirections || '',
          ThingsToBring: d_.ThingsToBring || '',
          RegistrationEndDate: d(d_.RegistrationEndDate),
          IsActive: !!d_.IsActive,
        });
      }
    })
    .catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setB = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.checked }));

  const save = async (e) => {
    e.preventDefault();
    setSaving(true);
    setMsg('');
    try {
      const r = await fetch(`${API}/api/events/${eventId}/tour/config`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...cfg,
          PricePerAdult: Number(cfg.PricePerAdult) || 0,
          PricePerChild: cfg.PricePerChild === '' ? null : Number(cfg.PricePerChild),
          ChildAgeLimit: Number(cfg.ChildAgeLimit) || 12,
          DefaultSlotCapacity: Number(cfg.DefaultSlotCapacity) || 15,
        }),
      });
      if (!r.ok) throw new Error('Save failed');
      setMsg('Saved');
    } catch (ex) {
      setMsg(ex.message);
    } finally {
      setSaving(false);
      setTimeout(() => setMsg(''), 3000);
    }
  };

  return (
    <form onSubmit={save} className="space-y-5">
      <div>
        <label className={lbl}>Tour description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={180} />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label className={lbl}>Adult ticket ($)</label>
          <input type="number" step="0.01" value={cfg.PricePerAdult} onChange={set('PricePerAdult')} className={inp} />
        </div>
        <div>
          <label className={lbl}>Child ticket ($)</label>
          <input type="number" step="0.01" value={cfg.PricePerChild} onChange={set('PricePerChild')} className={inp} placeholder="Same as adult" />
        </div>
        <div>
          <label className={lbl}>Child age cutoff</label>
          <input type="number" min="0" value={cfg.ChildAgeLimit} onChange={set('ChildAgeLimit')} className={inp} />
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label className={lbl}>Default slot capacity</label>
          <input type="number" min="1" value={cfg.DefaultSlotCapacity} onChange={set('DefaultSlotCapacity')} className={inp} />
        </div>
        <div>
          <label className={lbl}>Registration closes</label>
          <input type="date" value={cfg.RegistrationEndDate} onChange={set('RegistrationEndDate')} className={inp} />
        </div>
        <label className="flex items-center gap-2 text-sm text-gray-700 self-end pb-2">
          <input type="checkbox" checked={cfg.IsActive} onChange={setB('IsActive')} className="w-4 h-4 accent-green-600" />
          Active (visitors can book)
        </label>
      </div>

      <label className="flex items-center gap-2 text-sm text-gray-700">
        <input type="checkbox" checked={cfg.RequireWaiver} onChange={setB('RequireWaiver')} className="w-4 h-4 accent-green-600" />
        Require liability waiver signature at registration
      </label>

      {cfg.RequireWaiver && (
        <div>
          <label className={lbl}>Waiver text (shown to guests before signature)</label>
          <RichTextEditor value={cfg.WaiverText || ''}
            onChange={(v) => setCfg(c => ({ ...c, WaiverText: v }))} minHeight={180} />
        </div>
      )}

      <div>
        <label className={lbl}>Driving directions</label>
        <RichTextEditor value={cfg.DrivingDirections || ''}
          onChange={(v) => setCfg(c => ({ ...c, DrivingDirections: v }))} minHeight={120} />
      </div>
      <div>
        <label className={lbl}>Parking notes</label>
        <RichTextEditor value={cfg.ParkingNotes || ''}
          onChange={(v) => setCfg(c => ({ ...c, ParkingNotes: v }))} minHeight={100} />
      </div>
      <div>
        <label className={lbl}>What to bring / wear</label>
        <RichTextEditor value={cfg.ThingsToBring || ''}
          onChange={(v) => setCfg(c => ({ ...c, ThingsToBring: v }))} minHeight={100} />
      </div>

      <div className="flex justify-end gap-3 pt-2">
        {msg && <span className="text-sm text-gray-500 self-center mr-auto">{msg}</span>}
        <button type="submit" disabled={saving} className="bg-[#3D6B34] text-white font-semibold px-6 py-2 rounded-lg hover:bg-[#2d5226] disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Configuration'}
        </button>
      </div>
    </form>
  );
}

function SlotsTab({ eventId }) {
  const [slots, setSlots] = useState([]);
  const [cfg, setCfg] = useState(null);
  const [editing, setEditing] = useState(null);
  const [draft, setDraft] = useState(null);

  const load = () => {
    fetch(`${API}/api/events/${eventId}/tour/slots`).then(r => r.json()).then(setSlots).catch(() => {});
    fetch(`${API}/api/events/${eventId}/tour/config`).then(r => r.json()).then(setCfg).catch(() => {});
  };
  useEffect(() => { load(); }, [eventId]);

  const defaultCap = cfg?.DefaultSlotCapacity || 15;

  const startAdd = () => {
    setEditing('new');
    setDraft({ SlotStart: '', DurationMin: 60, Capacity: defaultCap, Notes: '', IsActive: true });
  };
  const startEdit = (s) => {
    setEditing(s.SlotID);
    setDraft({
      SlotStart: toLocalInput(s.SlotStart),
      DurationMin: s.DurationMin || 60,
      Capacity: s.Capacity,
      Notes: s.Notes || '',
      IsActive: !!s.IsActive,
    });
  };

  const save = async () => {
    if (!draft.SlotStart) return;
    const body = {
      ...draft,
      DurationMin: Number(draft.DurationMin) || 60,
      Capacity: Number(draft.Capacity) || defaultCap,
    };
    const url = editing === 'new'
      ? `${API}/api/events/${eventId}/tour/slots`
      : `${API}/api/events/tour/slots/${editing}`;
    const method = editing === 'new' ? 'POST' : 'PUT';
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body) });
    setEditing(null); setDraft(null);
    load();
  };

  const remove = async (id) => {
    if (!confirm('Delete this slot?')) return;
    const r = await fetch(`${API}/api/events/tour/slots/${id}`, { method: 'DELETE' });
    if (!r.ok) {
      const j = await r.json().catch(() => ({}));
      alert(j.detail || 'Delete failed');
    }
    load();
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <p className="text-sm text-gray-600">Add time slots for the tour. Visitors pick one at registration.</p>
        {!editing && (
          <button onClick={startAdd} className="text-sm bg-[#3D6B34] text-white px-4 py-1.5 rounded-lg hover:bg-[#2d5226]">
            + Add Slot
          </button>
        )}
      </div>

      {editing && draft && (
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-4 mb-4 space-y-3">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <div>
              <label className={lbl}>Start time</label>
              <input type="datetime-local" value={draft.SlotStart}
                onChange={e => setDraft(d => ({ ...d, SlotStart: e.target.value }))} className={inp} />
            </div>
            <div>
              <label className={lbl}>Duration (min)</label>
              <input type="number" min="10" value={draft.DurationMin}
                onChange={e => setDraft(d => ({ ...d, DurationMin: e.target.value }))} className={inp} />
            </div>
            <div>
              <label className={lbl}>Capacity</label>
              <input type="number" min="1" value={draft.Capacity}
                onChange={e => setDraft(d => ({ ...d, Capacity: e.target.value }))} className={inp} />
            </div>
          </div>
          <div>
            <label className={lbl}>Notes</label>
            <input value={draft.Notes} onChange={e => setDraft(d => ({ ...d, Notes: e.target.value }))} className={inp} placeholder="e.g. Alpaca barn + shearing demo" />
          </div>
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={!!draft.IsActive}
              onChange={e => setDraft(d => ({ ...d, IsActive: e.target.checked }))} /> Active (bookable)
          </label>
          <div className="flex justify-end gap-2">
            <button onClick={() => { setEditing(null); setDraft(null); }} className="px-4 py-1.5 text-sm border border-gray-300 rounded-lg">Cancel</button>
            <button onClick={save} className="px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg">
              {editing === 'new' ? 'Add' : 'Update'}
            </button>
          </div>
        </div>
      )}

      <div className="space-y-2">
        {slots.map(s => {
          const booked = Number(s.Booked || 0);
          const cap = Number(s.Capacity);
          const pct = cap ? Math.min(100, (booked / cap) * 100) : 0;
          const full = booked >= cap;
          return (
            <div key={s.SlotID} className={`bg-white border rounded-lg p-3 ${s.IsActive ? 'border-gray-200' : 'border-gray-200 opacity-60'}`}>
              <div className="flex items-start justify-between gap-3">
                <div className="flex-1 min-w-0">
                  <div className="font-semibold text-gray-900">{fmtSlot(s.SlotStart)}</div>
                  <div className="text-xs text-gray-500">
                    {s.DurationMin} min
                    {s.Notes && ` • ${s.Notes}`}
                    {!s.IsActive && ' • hidden'}
                  </div>
                  <div className="mt-2 h-1.5 bg-gray-100 rounded-full overflow-hidden">
                    <div className={`h-full ${full ? 'bg-red-500' : 'bg-[#3D6B34]'}`} style={{ width: `${pct}%` }} />
                  </div>
                  <div className="text-[11px] text-gray-500 mt-1">{booked} / {cap} booked</div>
                </div>
                <div className="flex gap-2 shrink-0">
                  <button onClick={() => startEdit(s)} className="text-xs text-gray-500 hover:text-gray-800">Edit</button>
                  <button onClick={() => remove(s.SlotID)} className="text-xs text-red-500 hover:text-red-700">Delete</button>
                </div>
              </div>
            </div>
          );
        })}
        {slots.length === 0 && !editing && <div className="text-sm text-gray-500">No slots yet.</div>}
      </div>
    </div>
  );
}

function AddOnsTab({ eventId }) {
  const [items, setItems] = useState([]);
  const [editing, setEditing] = useState(null);
  const [draft, setDraft] = useState(null);

  const load = () => fetch(`${API}/api/events/${eventId}/tour/addons`)
    .then(r => r.json()).then(setItems).catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const startAdd = () => {
    setEditing('new');
    setDraft({ AddOnName: '', AddOnDescription: '', Price: 0, MaxQuantity: '', DisplayOrder: 0, IsActive: true });
  };
  const startEdit = (i) => { setEditing(i.AddOnID); setDraft({ ...i, MaxQuantity: i.MaxQuantity ?? '' }); };

  const save = async () => {
    if (!draft.AddOnName) return;
    const body = {
      ...draft,
      Price: Number(draft.Price) || 0,
      MaxQuantity: draft.MaxQuantity === '' ? null : Number(draft.MaxQuantity),
      DisplayOrder: Number(draft.DisplayOrder) || 0,
    };
    const url = editing === 'new'
      ? `${API}/api/events/${eventId}/tour/addons`
      : `${API}/api/events/tour/addons/${editing}`;
    const method = editing === 'new' ? 'POST' : 'PUT';
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body) });
    setEditing(null); setDraft(null);
    load();
  };

  const remove = async (id) => {
    if (!confirm('Delete this add-on?')) return;
    await fetch(`${API}/api/events/tour/addons/${id}`, { method: 'DELETE' });
    load();
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <p className="text-sm text-gray-600">Optional extras (tea, cheese plate, souvenir). Visitors can pick these during checkout.</p>
        {!editing && (
          <button onClick={startAdd} className="text-sm bg-[#3D6B34] text-white px-4 py-1.5 rounded-lg hover:bg-[#2d5226]">
            + Add Add-On
          </button>
        )}
      </div>

      {editing && draft && (
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-4 mb-4 space-y-3">
          <div>
            <label className={lbl}>Name</label>
            <input value={draft.AddOnName} onChange={e => setDraft(d => ({ ...d, AddOnName: e.target.value }))} className={inp} />
          </div>
          <div>
            <label className={lbl}>Description</label>
            <RichTextEditor value={draft.AddOnDescription || ''}
              onChange={(v) => setDraft(d => ({ ...d, AddOnDescription: v }))} minHeight={100} />
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <div>
              <label className={lbl}>Price ($)</label>
              <input type="number" step="0.01" value={draft.Price}
                onChange={e => setDraft(d => ({ ...d, Price: e.target.value }))} className={inp} />
            </div>
            <div>
              <label className={lbl}>Max qty per registration</label>
              <input type="number" min="1" value={draft.MaxQuantity}
                onChange={e => setDraft(d => ({ ...d, MaxQuantity: e.target.value }))} className={inp} placeholder="Unlimited" />
            </div>
            <div>
              <label className={lbl}>Display order</label>
              <input type="number" value={draft.DisplayOrder}
                onChange={e => setDraft(d => ({ ...d, DisplayOrder: e.target.value }))} className={inp} />
            </div>
          </div>
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={!!draft.IsActive}
              onChange={e => setDraft(d => ({ ...d, IsActive: e.target.checked }))} /> Available
          </label>
          <div className="flex justify-end gap-2">
            <button onClick={() => { setEditing(null); setDraft(null); }} className="px-4 py-1.5 text-sm border border-gray-300 rounded-lg">Cancel</button>
            <button onClick={save} className="px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg">
              {editing === 'new' ? 'Add' : 'Update'}
            </button>
          </div>
        </div>
      )}

      <div className="space-y-2">
        {items.map(i => (
          <div key={i.AddOnID} className={`flex items-start justify-between bg-white border rounded-lg p-3 ${i.IsActive ? 'border-gray-200' : 'border-gray-200 opacity-50'}`}>
            <div className="flex-1">
              <div className="flex items-center gap-2">
                <div className="font-medium text-gray-900">{i.AddOnName}</div>
                <div className="text-sm text-[#3D6B34] font-semibold">${Number(i.Price).toFixed(2)}</div>
                {i.MaxQuantity && <span className="text-[10px] bg-gray-100 text-gray-600 px-1.5 py-0.5 rounded">max {i.MaxQuantity}</span>}
                {!i.IsActive && <span className="text-[10px] bg-gray-200 text-gray-600 px-1.5 py-0.5 rounded">hidden</span>}
              </div>
              {i.AddOnDescription && <div className="text-xs text-gray-600 mt-0.5" dangerouslySetInnerHTML={{ __html: i.AddOnDescription }} />}
            </div>
            <div className="flex gap-2 shrink-0">
              <button onClick={() => startEdit(i)} className="text-xs text-gray-500 hover:text-gray-800">Edit</button>
              <button onClick={() => remove(i.AddOnID)} className="text-xs text-red-500 hover:text-red-700">Delete</button>
            </div>
          </div>
        ))}
        {items.length === 0 && !editing && <div className="text-sm text-gray-500">No add-ons configured.</div>}
      </div>
    </div>
  );
}

function RegistrationsTab({ eventId }) {
  const [regs, setRegs] = useState([]);
  const [editing, setEditing] = useState(null);
  const [draft, setDraft] = useState(null);

  const load = () => fetch(`${API}/api/events/${eventId}/tour/registrations`)
    .then(r => r.json()).then(setRegs).catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const startEdit = (r) => {
    setEditing(r.RegID);
    setDraft({
      PaidStatus: r.PaidStatus || 'pending',
      Status: r.Status || 'confirmed',
      OrganizerNotes: r.OrganizerNotes || '',
    });
  };

  const save = async () => {
    await fetch(`${API}/api/events/tour/registrations/${editing}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(draft),
    });
    setEditing(null); setDraft(null);
    load();
  };

  const toggleCheckin = async (r) => {
    await fetch(`${API}/api/events/tour/registrations/${r.RegID}/checkin`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ CheckedIn: !r.CheckedIn }),
    });
    load();
  };

  const remove = async (id) => {
    if (!confirm('Remove this registration?')) return;
    await fetch(`${API}/api/events/tour/registrations/${id}`, { method: 'DELETE' });
    load();
  };

  const bySlot = regs.reduce((acc, r) => {
    const key = r.SlotStart || 'Unscheduled';
    (acc[key] ||= []).push(r);
    return acc;
  }, {});

  const totalRevenue = regs.filter(r => r.PaidStatus === 'paid').reduce((s, r) => s + Number(r.TotalFee || 0), 0);
  const expected = regs.reduce((s, r) => s + Number(r.TotalFee || 0), 0);

  return (
    <div>
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 mb-4 text-xs">
        <div className="bg-white border border-gray-200 rounded-lg p-3">
          <div className="text-gray-500">Registrations</div>
          <div className="text-lg font-semibold">{regs.length}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg p-3">
          <div className="text-gray-500">Visitors</div>
          <div className="text-lg font-semibold">{regs.reduce((s, r) => s + Number(r.PartySize || 0), 0)}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg p-3">
          <div className="text-gray-500">Revenue (paid)</div>
          <div className="text-lg font-semibold text-[#3D6B34]">${totalRevenue.toFixed(2)}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg p-3">
          <div className="text-gray-500">Expected</div>
          <div className="text-lg font-semibold text-gray-800">${expected.toFixed(2)}</div>
        </div>
      </div>

      {Object.entries(bySlot).map(([slotIso, list]) => (
        <div key={slotIso} className="mb-5">
          <h3 className="text-sm font-bold text-gray-600 uppercase tracking-wide mb-2">
            {slotIso === 'Unscheduled' ? 'Unscheduled' : fmtSlot(slotIso)}
            <span className="text-xs font-normal text-gray-400 ml-2">({list.length} registrations)</span>
          </h3>
          <div className="space-y-2">
            {list.map(r => (
              <div key={r.RegID} className="bg-white border border-gray-200 rounded-lg p-3">
                <div className="flex items-start justify-between gap-3">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <div className="font-medium text-gray-900">{r.GuestName}</div>
                      {r.CheckedIn && <span className="text-[10px] bg-green-100 text-green-700 px-1.5 py-0.5 rounded">✓ checked in</span>}
                      {r.WaiverSignedBy && <span className="text-[10px] bg-blue-100 text-blue-700 px-1.5 py-0.5 rounded">waiver signed</span>}
                    </div>
                    <div className="text-xs text-gray-500">
                      Party of {r.PartySize}{r.ChildCount ? ` (${r.ChildCount} child)` : ''}
                      {r.GuestEmail && ` • ${r.GuestEmail}`}
                      {r.GuestPhone && ` • ${r.GuestPhone}`}
                    </div>
                    {r.AddOns?.length > 0 && (
                      <div className="text-xs text-gray-600 mt-1">
                        Add-ons: {r.AddOns.map(a => `${a.AddOnName} × ${a.Quantity}`).join(', ')}
                      </div>
                    )}
                    {r.SpecialRequests && <div className="text-xs text-gray-600 mt-0.5">Note: {r.SpecialRequests}</div>}
                  </div>
                  <div className="flex flex-col items-end gap-1 shrink-0">
                    <div className="text-sm font-medium">${Number(r.TotalFee || 0).toFixed(2)}</div>
                    <div className={`text-[11px] px-2 py-0.5 rounded ${r.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                      {r.PaidStatus}
                    </div>
                    {editing !== r.RegID && (
                      <div className="flex gap-2 mt-1">
                        <button onClick={() => toggleCheckin(r)} className={`text-xs ${r.CheckedIn ? 'text-gray-400' : 'text-green-600'} hover:underline`}>
                          {r.CheckedIn ? 'Undo' : 'Check in'}
                        </button>
                        <button onClick={() => startEdit(r)} className="text-xs text-gray-500 hover:text-gray-800">Edit</button>
                        <button onClick={() => remove(r.RegID)} className="text-xs text-red-500 hover:text-red-700">Remove</button>
                      </div>
                    )}
                  </div>
                </div>

                {editing === r.RegID && draft && (
                  <div className="mt-3 pt-3 border-t border-gray-100 space-y-3">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                      <div>
                        <label className={lbl}>Paid status</label>
                        <select value={draft.PaidStatus} onChange={e => setDraft(d => ({ ...d, PaidStatus: e.target.value }))} className={inp}>
                          <option value="pending">Pending</option>
                          <option value="paid">Paid</option>
                          <option value="refunded">Refunded</option>
                        </select>
                      </div>
                      <div>
                        <label className={lbl}>Status</label>
                        <select value={draft.Status} onChange={e => setDraft(d => ({ ...d, Status: e.target.value }))} className={inp}>
                          <option value="confirmed">Confirmed</option>
                          <option value="waitlist">Waitlist</option>
                          <option value="cancelled">Cancelled</option>
                        </select>
                      </div>
                    </div>
                    <div>
                      <label className={lbl}>Organizer notes</label>
                      <RichTextEditor value={draft.OrganizerNotes || ''}
                        onChange={(v) => setDraft(d => ({ ...d, OrganizerNotes: v }))} minHeight={90} />
                    </div>
                    <div className="flex justify-end gap-2">
                      <button onClick={() => { setEditing(null); setDraft(null); }} className="px-4 py-1.5 text-sm border border-gray-300 rounded-lg">Cancel</button>
                      <button onClick={save} className="px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg">Save</button>
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      ))}
      {regs.length === 0 && <div className="text-sm text-gray-500">No registrations yet.</div>}
    </div>
  );
}

export default function FarmTourAdmin() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const BusinessID = params.get('BusinessID');
  const [tab, setTab] = useState(params.get('tab') || 'config');
  const [event, setEvent] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
  }, [eventId]);

  const TABS = [
    { id: 'config', label: 'Configuration' },
    { id: 'slots', label: 'Time Slots' },
    { id: 'addons', label: 'Add-Ons' },
    { id: 'registrations', label: 'Registrations' },
  ];

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6 flex-wrap gap-3">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Farm Tour / Open House Admin</h1>
            <p className="text-sm text-gray-500 mt-1">
              {event?.EventName || 'Event'} — configure slots, add-ons, and waivers.
            </p>
          </div>
          <Link to={`/events/manage?BusinessID=${BusinessID || ''}`} className="text-sm text-gray-500 hover:text-gray-700">
            ← Back to My Events
          </Link>
        </div>

        <div className="flex gap-1 border-b border-gray-200 mb-6 overflow-x-auto">
          {TABS.map(t => (
            <button
              key={t.id}
              onClick={() => setTab(t.id)}
              className={`px-4 py-2 text-sm font-medium border-b-2 -mb-px whitespace-nowrap ${tab === t.id ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            >
              {t.label}
            </button>
          ))}
        </div>

        {tab === 'config' && <ConfigTab eventId={eventId} />}
        {tab === 'slots' && <SlotsTab eventId={eventId} />}
        {tab === 'addons' && <AddOnsTab eventId={eventId} />}
        {tab === 'registrations' && <RegistrationsTab eventId={eventId} />}
      </div>
    </EventAdminLayout>
  );
}
