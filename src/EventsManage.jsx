import React, { useEffect, useState, useRef } from 'react';
import { useSearchParams, Link, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

const EVENT_TYPES = ['Workshop', 'Farm Tour', 'Market', 'Fair', 'Show', 'Festival', 'Class', 'Meeting', 'Auction', 'Other'];

const EMPTY = {
  EventName: '', EventDescription: '', EventType: '', EventStartDate: '', EventEndDate: '',
  EventImage: '', EventLocationName: '', EventLocationStreet: '', EventLocationCity: '',
  EventLocationState: '', EventLocationZip: '', EventContactEmail: '', EventPhone: '',
  EventWebsite: '', IsPublished: true, IsFree: true, RegistrationRequired: false, MaxAttendees: '',
};

function formatDate(d) {
  if (!d) return '';
  return new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
}

// ── Event Form ────────────────────────────────────────────────────────────────
function EventForm({ initial, onSave, onCancel, saving }) {
  const [form, setForm] = useState(initial || EMPTY);
  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  const setB = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.checked }));

  return (
    <form onSubmit={(e) => { e.preventDefault(); onSave(form); }} className="space-y-5">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div className="md:col-span-2">
          <label className={lbl}>Event Name</label>
          <input value={form.EventName} onChange={set('EventName')} className={inp} required placeholder="e.g. Summer Farm Tour" />
        </div>
        <div>
          <label className={lbl}>Event Type</label>
          <select value={form.EventType} onChange={set('EventType')} className={inp}>
            <option value="">-- Select Type --</option>
            {EVENT_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
          </select>
        </div>
        <div>
          <label className={lbl}>Event Image URL</label>
          <input value={form.EventImage} onChange={set('EventImage')} className={inp} placeholder="https://…" />
        </div>
        <div>
          <label className={lbl}>Start Date</label>
          <input type="date" value={form.EventStartDate ? form.EventStartDate.substring(0,10) : ''} onChange={set('EventStartDate')} className={inp} />
        </div>
        <div>
          <label className={lbl}>End Date</label>
          <input type="date" value={form.EventEndDate ? form.EventEndDate.substring(0,10) : ''} onChange={set('EventEndDate')} className={inp} />
        </div>
        <div className="md:col-span-2">
          <label className={lbl}>Description</label>
          <textarea value={form.EventDescription} onChange={set('EventDescription')} className={inp} rows={4} placeholder="Describe your event…" />
        </div>
      </div>

      {/* Location */}
      <div>
        <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-3">Location</h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
          <div className="md:col-span-2">
            <label className={lbl}>Venue Name</label>
            <input value={form.EventLocationName} onChange={set('EventLocationName')} className={inp} placeholder="e.g. Sunflower Community Farm" />
          </div>
          <div className="md:col-span-2">
            <label className={lbl}>Street Address</label>
            <input value={form.EventLocationStreet} onChange={set('EventLocationStreet')} className={inp} />
          </div>
          <div>
            <label className={lbl}>City</label>
            <input value={form.EventLocationCity} onChange={set('EventLocationCity')} className={inp} />
          </div>
          <div>
            <label className={lbl}>State</label>
            <input value={form.EventLocationState} onChange={set('EventLocationState')} className={inp} placeholder="e.g. OR" />
          </div>
          <div>
            <label className={lbl}>ZIP</label>
            <input value={form.EventLocationZip} onChange={set('EventLocationZip')} className={inp} />
          </div>
        </div>
      </div>

      {/* Contact */}
      <div>
        <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-3">Contact</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
          <div>
            <label className={lbl}>Email</label>
            <input type="email" value={form.EventContactEmail} onChange={set('EventContactEmail')} className={inp} />
          </div>
          <div>
            <label className={lbl}>Phone</label>
            <input value={form.EventPhone} onChange={set('EventPhone')} className={inp} />
          </div>
          <div>
            <label className={lbl}>Website</label>
            <input value={form.EventWebsite} onChange={set('EventWebsite')} className={inp} placeholder="https://…" />
          </div>
        </div>
      </div>

      {/* Settings */}
      <div>
        <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-3">Settings</h3>
        <div className="flex flex-wrap gap-6">
          <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
            <input type="checkbox" checked={form.IsPublished} onChange={setB('IsPublished')} className="w-4 h-4 accent-green-600" />
            Published (visible to public)
          </label>
          <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
            <input type="checkbox" checked={form.IsFree} onChange={setB('IsFree')} className="w-4 h-4 accent-green-600" />
            Free Event
          </label>
          <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
            <input type="checkbox" checked={form.RegistrationRequired} onChange={setB('RegistrationRequired')} className="w-4 h-4 accent-green-600" />
            Registration Required
          </label>
          <div>
            <label className={lbl}>Max Attendees</label>
            <input type="number" min="1" value={form.MaxAttendees} onChange={set('MaxAttendees')} className={`${inp} w-28`} placeholder="Unlimited" />
          </div>
        </div>
      </div>

      <div className="flex justify-end gap-3 pt-2">
        <button type="button" onClick={onCancel}
          className="px-5 py-2 rounded-lg border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">
          Cancel
        </button>
        <button type="submit" disabled={saving}
          className="bg-[#3D6B34] text-white font-semibold px-6 py-2 rounded-lg hover:bg-[#2d5226] disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Event'}
        </button>
      </div>
    </form>
  );
}

// ── Date / Time Slots Editor ──────────────────────────────────────────────────
function DateSlotsEditor({ eventId }) {
  const [dates, setDates] = useState([]);
  const [adding, setAdding] = useState(false);
  const [newDate, setNewDate] = useState({ EventDate: '', StartTime: '', EndTime: '' });

  const load = () =>
    fetch(`${API}/api/events/${eventId}/dates`)
      .then(r => r.json()).then(d => setDates(Array.isArray(d) ? d : [])).catch(() => {});

  useEffect(() => { load(); }, [eventId]);

  const add = async () => {
    if (!newDate.EventDate) return;
    await fetch(`${API}/api/events/${eventId}/dates`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(newDate),
    });
    setNewDate({ EventDate: '', StartTime: '', EndTime: '' });
    setAdding(false);
    load();
  };

  const del = async (id) => {
    if (!confirm('Remove this date?')) return;
    await fetch(`${API}/api/events/dates/${id}`, { method: 'DELETE' });
    load();
  };

  return (
    <div>
      <div className="flex items-center justify-between mb-3">
        <h3 className="text-sm font-bold text-gray-600 uppercase tracking-wide">Schedule / Date Slots</h3>
        <button onClick={() => setAdding(true)} className="text-xs text-[#3D6B34] hover:underline font-semibold">+ Add Date</button>
      </div>

      {dates.length === 0 && !adding && (
        <p className="text-sm text-gray-400">No additional date slots. Add specific session times here.</p>
      )}

      <div className="space-y-1.5">
        {dates.map(d => (
          <div key={d.DateID} className="flex items-center gap-3 bg-gray-50 rounded-lg px-3 py-2 text-sm">
            <span className="font-medium text-gray-800">{formatDate(d.EventDate)}</span>
            {(d.StartTime || d.EndTime) && (
              <span className="text-gray-500">{d.StartTime}{d.EndTime ? ` – ${d.EndTime}` : ''}</span>
            )}
            <button onClick={() => del(d.DateID)} className="ml-auto text-xs text-red-400 hover:text-red-600">✕</button>
          </div>
        ))}
      </div>

      {adding && (
        <div className="mt-3 bg-gray-50 rounded-lg p-3 space-y-2">
          <div className="grid grid-cols-3 gap-2">
            <div>
              <label className={lbl}>Date</label>
              <input type="date" value={newDate.EventDate}
                onChange={e => setNewDate(d => ({ ...d, EventDate: e.target.value }))} className={inp} />
            </div>
            <div>
              <label className={lbl}>Start Time</label>
              <input type="time" value={newDate.StartTime}
                onChange={e => setNewDate(d => ({ ...d, StartTime: e.target.value }))} className={inp} />
            </div>
            <div>
              <label className={lbl}>End Time</label>
              <input type="time" value={newDate.EndTime}
                onChange={e => setNewDate(d => ({ ...d, EndTime: e.target.value }))} className={inp} />
            </div>
          </div>
          <div className="flex gap-2">
            <button onClick={add} className="text-sm bg-[#3D6B34] text-white px-4 py-1.5 rounded-lg hover:bg-[#2d5226]">Add</button>
            <button onClick={() => setAdding(false)} className="text-sm border border-gray-200 px-4 py-1.5 rounded-lg text-gray-600 hover:bg-gray-100">Cancel</button>
          </div>
        </div>
      )}
    </div>
  );
}

// ── Registration Options Editor ───────────────────────────────────────────────
function OptionsEditor({ eventId }) {
  const [opts, setOpts] = useState([]);
  const [adding, setAdding] = useState(false);
  const [newOpt, setNewOpt] = useState({ OptionName: '', OptionDescription: '', Price: '', MaxQty: '' });

  const load = () =>
    fetch(`${API}/api/events/${eventId}/options`)
      .then(r => r.json()).then(d => setOpts(Array.isArray(d) ? d : [])).catch(() => {});

  useEffect(() => { load(); }, [eventId]);

  const add = async () => {
    if (!newOpt.OptionName) return;
    await fetch(`${API}/api/events/${eventId}/options`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...newOpt, Price: parseFloat(newOpt.Price) || 0, MaxQty: parseInt(newOpt.MaxQty) || null }),
    });
    setNewOpt({ OptionName: '', OptionDescription: '', Price: '', MaxQty: '' });
    setAdding(false);
    load();
  };

  const del = async (id) => {
    if (!confirm('Delete this option?')) return;
    await fetch(`${API}/api/events/options/${id}`, { method: 'DELETE' });
    load();
  };

  return (
    <div>
      <div className="flex items-center justify-between mb-3">
        <h3 className="text-sm font-bold text-gray-600 uppercase tracking-wide">Registration Options / Tickets</h3>
        <button onClick={() => setAdding(true)} className="text-xs text-[#3D6B34] hover:underline font-semibold">+ Add Option</button>
      </div>

      {opts.length === 0 && !adding && (
        <p className="text-sm text-gray-400">No options yet. Add ticket types or registration items.</p>
      )}

      <div className="space-y-2">
        {opts.map(opt => (
          <div key={opt.OptionID} className="flex items-center gap-3 bg-gray-50 rounded-lg px-3 py-2">
            <div className="flex-grow">
              <span className="text-sm font-medium text-gray-800">{opt.OptionName}</span>
              {opt.OptionDescription && <span className="text-xs text-gray-500 ml-2">{opt.OptionDescription}</span>}
            </div>
            <span className="text-sm font-bold text-[#3D6B34] shrink-0">
              {parseFloat(opt.Price) === 0 ? 'Free' : `$${parseFloat(opt.Price).toFixed(2)}`}
            </span>
            {opt.MaxQty && <span className="text-xs text-gray-400">max {opt.MaxQty}</span>}
            <button onClick={() => del(opt.OptionID)} className="text-xs text-red-400 hover:text-red-600">✕</button>
          </div>
        ))}
      </div>

      {adding && (
        <div className="mt-3 bg-gray-50 rounded-lg p-3 space-y-2">
          <div className="grid grid-cols-2 gap-2">
            <input value={newOpt.OptionName} onChange={e => setNewOpt(o => ({ ...o, OptionName: e.target.value }))} className={inp} placeholder="Option name *" />
            <input value={newOpt.OptionDescription} onChange={e => setNewOpt(o => ({ ...o, OptionDescription: e.target.value }))} className={inp} placeholder="Description (optional)" />
            <input type="number" step="0.01" min="0" value={newOpt.Price} onChange={e => setNewOpt(o => ({ ...o, Price: e.target.value }))} className={inp} placeholder="Price (0 = Free)" />
            <input type="number" min="1" value={newOpt.MaxQty} onChange={e => setNewOpt(o => ({ ...o, MaxQty: e.target.value }))} className={inp} placeholder="Max qty (optional)" />
          </div>
          <div className="flex gap-2">
            <button onClick={add} className="text-sm bg-[#3D6B34] text-white px-4 py-1.5 rounded-lg hover:bg-[#2d5226]">Add</button>
            <button onClick={() => setAdding(false)} className="text-sm border border-gray-200 px-4 py-1.5 rounded-lg text-gray-600 hover:bg-gray-100">Cancel</button>
          </div>
        </div>
      )}
    </div>
  );
}

// ── Registrations List ────────────────────────────────────────────────────────
function RegistrationsList({ eventId }) {
  const [regs, setRegs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showAddresses, setShowAddresses] = useState(false);
  const [expandedReg, setExpandedReg] = useState(null);
  const printRef = useRef(null);

  const load = () =>
    fetch(`${API}/api/events/${eventId}/registrations`)
      .then(r => r.json()).then(d => { setRegs(Array.isArray(d) ? d : []); setLoading(false); })
      .catch(() => setLoading(false));

  useEffect(() => { load(); }, [eventId]);

  const markPaid = async (regId) => {
    await fetch(`${API}/api/events/registrations/${regId}`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ PaymentStatus: 'paid' }),
    });
    load();
  };

  const markPending = async (regId) => {
    await fetch(`${API}/api/events/registrations/${regId}`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ PaymentStatus: 'pending' }),
    });
    load();
  };

  const deleteReg = async (regId) => {
    if (!confirm('Delete this registration?')) return;
    await fetch(`${API}/api/events/registrations/${regId}`, { method: 'DELETE' });
    load();
  };

  const printList = () => {
    const w = window.open('', '_blank');
    w.document.write(`
      <html><head><title>Registrations</title>
      <style>
        body { font-family: Arial, sans-serif; font-size: 12px; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 12px; }
        th { background: #f0f0f0; text-align: left; padding: 6px 8px; border-bottom: 2px solid #ccc; font-size: 11px; text-transform: uppercase; }
        td { padding: 6px 8px; border-bottom: 1px solid #eee; vertical-align: top; }
        .items { font-size: 11px; color: #555; }
        .total-row { font-weight: bold; background: #f8f8f8; }
        h2 { margin-bottom: 4px; }
        .meta { color: #666; font-size: 11px; margin-bottom: 12px; }
      </style></head><body>
      <h2>Event Registrations</h2>
      <div class="meta">Printed: ${new Date().toLocaleDateString()}</div>
      <table>
        <tr>
          <th>Date</th><th>Name</th><th>Email</th><th>Phone</th>
          ${showAddresses ? '' : ''}<th>Items</th><th>Total</th><th>Status</th>
        </tr>
        ${regs.map(r => `
          <tr>
            <td>${new Date(r.RegDate).toLocaleDateString()}</td>
            <td>${r.AttendeeFirstName} ${r.AttendeeLastName}</td>
            <td>${r.AttendeeEmail || ''}</td>
            <td>${r.AttendeePhone || ''}</td>
            <td class="items">${(r.items || []).map(i => `${i.Quantity}× ${i.OptionName}`).join('<br>')}</td>
            <td>$${parseFloat(r.TotalAmount || 0).toFixed(2)}</td>
            <td>${r.PaymentStatus}</td>
          </tr>
        `).join('')}
        <tr class="total-row">
          <td colspan="5" style="text-align:right">Total Income:</td>
          <td>$${regs.reduce((s, r) => s + parseFloat(r.TotalAmount || 0), 0).toFixed(2)}</td>
          <td></td>
        </tr>
      </table>
      </body></html>
    `);
    w.document.close();
    w.print();
  };

  if (loading) return <div className="text-gray-400 text-sm py-4">Loading registrations…</div>;

  const totalIncome = regs.reduce((s, r) => s + parseFloat(r.TotalAmount || 0), 0);

  return (
    <div>
      <div className="flex items-center justify-between mb-3 flex-wrap gap-2">
        <h3 className="text-sm font-bold text-gray-600 uppercase tracking-wide">
          Registrations ({regs.length})
        </h3>
        <div className="flex items-center gap-3">
          <label className="flex items-center gap-1.5 text-xs text-gray-500 cursor-pointer">
            <input type="checkbox" checked={showAddresses} onChange={e => setShowAddresses(e.target.checked)} className="w-3.5 h-3.5" />
            Show contact details
          </label>
          <button onClick={printList} className="text-xs text-gray-500 hover:text-gray-700 border border-gray-200 px-2 py-1 rounded hover:bg-gray-50">
            🖨 Print / Export
          </button>
        </div>
      </div>

      {regs.length === 0 ? (
        <p className="text-sm text-gray-400">No registrations yet.</p>
      ) : (
        <>
          <div className="overflow-x-auto rounded-xl border border-gray-200">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 border-b border-gray-200 text-xs text-gray-500 uppercase">
                  <th className="text-left py-2 px-3">Name</th>
                  {showAddresses && <th className="text-left py-2 px-3">Contact</th>}
                  <th className="text-left py-2 px-3">Items</th>
                  <th className="text-right py-2 px-3">Total</th>
                  <th className="text-left py-2 px-3">Status</th>
                  <th className="text-left py-2 px-3">Date</th>
                  <th className="py-2 px-3"></th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {regs.map(r => (
                  <React.Fragment key={r.RegID}>
                    <tr className="hover:bg-gray-50">
                      <td className="py-2 px-3 font-medium text-gray-800">
                        <button onClick={() => setExpandedReg(expandedReg === r.RegID ? null : r.RegID)}
                          className="text-left hover:text-[#3D6B34]">
                          {r.AttendeeFirstName} {r.AttendeeLastName}
                        </button>
                      </td>
                      {showAddresses && (
                        <td className="py-2 px-3 text-gray-500 text-xs">
                          <div>{r.AttendeeEmail}</div>
                          {r.AttendeePhone && <div>{r.AttendeePhone}</div>}
                        </td>
                      )}
                      <td className="py-2 px-3 text-gray-500 text-xs">
                        {(r.items || []).length > 0
                          ? (r.items || []).map(i => `${i.Quantity}× ${i.OptionName}`).join(', ')
                          : <span className="text-gray-300">—</span>}
                      </td>
                      <td className="py-2 px-3 font-bold text-[#3D6B34] text-right">
                        ${parseFloat(r.TotalAmount || 0).toFixed(2)}
                      </td>
                      <td className="py-2 px-3">
                        <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${
                          r.PaymentStatus === 'paid' ? 'bg-green-100 text-green-700'
                          : 'bg-amber-100 text-amber-700'
                        }`}>
                          {r.PaymentStatus}
                        </span>
                      </td>
                      <td className="py-2 px-3 text-gray-400 text-xs">{new Date(r.RegDate).toLocaleDateString()}</td>
                      <td className="py-2 px-3">
                        <div className="flex items-center gap-1">
                          {r.PaymentStatus !== 'paid' ? (
                            <button onClick={() => markPaid(r.RegID)}
                              className="text-xs text-green-600 hover:underline whitespace-nowrap">Mark paid</button>
                          ) : (
                            <button onClick={() => markPending(r.RegID)}
                              className="text-xs text-gray-400 hover:text-gray-600 whitespace-nowrap">Unmark</button>
                          )}
                          <span className="text-gray-200">|</span>
                          <button onClick={() => deleteReg(r.RegID)}
                            className="text-xs text-red-400 hover:text-red-600">Delete</button>
                        </div>
                      </td>
                    </tr>
                    {/* Expanded detail row */}
                    {expandedReg === r.RegID && (
                      <tr>
                        <td colSpan={showAddresses ? 7 : 6} className="bg-blue-50 px-4 py-3 text-sm border-y border-blue-100">
                          <div className="flex flex-wrap gap-6">
                            <div>
                              <p className="text-xs font-bold text-gray-500 uppercase mb-1">Contact</p>
                              <p className="text-gray-800">{r.AttendeeFirstName} {r.AttendeeLastName}</p>
                              <p className="text-gray-600">{r.AttendeeEmail}</p>
                              {r.AttendeePhone && <p className="text-gray-600">{r.AttendeePhone}</p>}
                            </div>
                            {(r.items || []).length > 0 && (
                              <div>
                                <p className="text-xs font-bold text-gray-500 uppercase mb-1">Registered Items</p>
                                {r.items.map((item, i) => (
                                  <p key={i} className="text-gray-700">
                                    {item.Quantity}× {item.OptionName}
                                    {parseFloat(item.UnitPrice) > 0 && <span className="text-gray-400 ml-1">(${parseFloat(item.UnitPrice).toFixed(2)} ea.)</span>}
                                  </p>
                                ))}
                              </div>
                            )}
                            {r.Notes && (
                              <div>
                                <p className="text-xs font-bold text-gray-500 uppercase mb-1">Notes</p>
                                <p className="text-gray-700">{r.Notes}</p>
                              </div>
                            )}
                          </div>
                        </td>
                      </tr>
                    )}
                  </React.Fragment>
                ))}
              </tbody>
              {totalIncome > 0 && (
                <tfoot>
                  <tr className="border-t-2 border-gray-200 bg-gray-50">
                    <td colSpan={showAddresses ? 3 : 2} className="py-2 px-3 text-xs font-bold text-gray-500 text-right uppercase">Total Income:</td>
                    <td className="py-2 px-3 font-bold text-[#3D6B34] text-right">${totalIncome.toFixed(2)}</td>
                    <td colSpan={showAddresses ? 3 : 2}></td>
                  </tr>
                </tfoot>
              )}
            </table>
          </div>
        </>
      )}
    </div>
  );
}

// ── Main component ────────────────────────────────────────────────────────────
export default function EventsManage() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editingEvent, setEditingEvent] = useState(null);
  const [expandedEvent, setExpandedEvent] = useState(null);
  const [activeTab, setActiveTab] = useState({}); // eventId → 'dates' | 'options' | 'registrations'
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!BusinessID) return;
    LoadBusiness(BusinessID);
    loadEvents();
  }, [BusinessID]);

  const loadEvents = () => {
    setLoading(true);
    fetch(`${API}/api/my-events?business_id=${BusinessID}`)
      .then(r => r.json()).then(d => { setEvents(Array.isArray(d) ? d : []); setLoading(false); })
      .catch(() => setLoading(false));
  };

  const openAdd = () => { setEditingEvent(null); setShowForm(true); };

  const openEdit = async (ev) => {
    const res = await fetch(`${API}/api/events/${ev.EventID}`);
    const d = await res.json();
    setEditingEvent(d);
    setShowForm(true);
  };

  const save = async (form) => {
    setSaving(true);
    try {
      const payload = { ...form, BusinessID: parseInt(BusinessID), PeopleID: PeopleID ? parseInt(PeopleID) : null };
      if (editingEvent) {
        await fetch(`${API}/api/events/${editingEvent.EventID}`, {
          method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(payload),
        });
      } else {
        const res = await fetch(`${API}/api/events`, {
          method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(payload),
        });
        const data = await res.json();
        setExpandedEvent(data.EventID);
      }
      setShowForm(false);
      setEditingEvent(null);
      loadEvents();
    } catch (err) { alert(err.message); }
    setSaving(false);
  };

  const deleteEvent = async (ev) => {
    if (!confirm(`Delete "${ev.EventName}"?`)) return;
    await fetch(`${API}/api/events/${ev.EventID}`, { method: 'DELETE' });
    loadEvents();
  };

  const getTab = (eventId) => activeTab[eventId] || 'registrations';
  const setTab = (eventId, tab) => setActiveTab(prev => ({ ...prev, [eventId]: tab }));

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="max-w-5xl mx-auto space-y-6">

        {/* Header */}
        <div className="flex items-center justify-between flex-wrap gap-3">
          <h1 className="text-2xl font-bold text-gray-800">My Events</h1>
          <div className="flex gap-2">
            <Link to="/events" className="border border-gray-200 text-sm text-gray-600 px-4 py-2 rounded-lg hover:bg-gray-50 no-underline">
              Browse Events
            </Link>
            <button onClick={openAdd}
              className="bg-[#3D6B34] text-white font-semibold px-5 py-2 rounded-lg hover:bg-[#2d5226]">
              + Create Event
            </button>
          </div>
        </div>

        {/* Create / Edit form */}
        {showForm && (
          <div className="bg-white rounded-xl border border-gray-200 p-6">
            <h2 className="font-bold text-gray-700 mb-5 text-lg">{editingEvent ? `Edit: ${editingEvent.EventName}` : 'New Event'}</h2>
            <EventForm
              initial={editingEvent}
              onSave={save}
              onCancel={() => { setShowForm(false); setEditingEvent(null); }}
              saving={saving}
            />
          </div>
        )}

        {/* Events list */}
        {loading ? (
          <div className="text-center py-12 text-gray-400">Loading…</div>
        ) : events.length === 0 ? (
          <div className="bg-white rounded-xl border border-gray-200 p-12 text-center text-gray-400">
            <div className="text-4xl mb-3">🎪</div>
            <p className="mb-4">No events yet. Create your first event to get started.</p>
          </div>
        ) : (
          <div className="space-y-4">
            {events.map(ev => (
              <div key={ev.EventID} className="bg-white rounded-xl border border-gray-200 overflow-hidden">
                {/* Event row */}
                <div className="p-4 flex items-center gap-4 flex-wrap">
                  <div className="flex-grow min-w-0">
                    <div className="flex items-center gap-2 flex-wrap mb-0.5">
                      <h3 className="font-bold text-gray-800">{ev.EventName}</h3>
                      <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${ev.IsPublished ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                        {ev.IsPublished ? 'Published' : 'Draft'}
                      </span>
                      {ev.EventType && <span className="text-xs bg-gray-100 text-gray-600 px-2 py-0.5 rounded-full">{ev.EventType}</span>}
                    </div>
                    <div className="text-xs text-gray-500 flex gap-3 flex-wrap">
                      {ev.EventStartDate && (
                        <span>📅 {formatDate(ev.EventStartDate)}{ev.EventEndDate && ev.EventEndDate !== ev.EventStartDate ? ` – ${formatDate(ev.EventEndDate)}` : ''}</span>
                      )}
                      {ev.EventLocationCity && <span>📍 {[ev.EventLocationCity, ev.EventLocationState].filter(Boolean).join(', ')}</span>}
                      <span>👥 {ev.AttendeeCount || 0} registered</span>
                    </div>
                  </div>
                  <div className="flex gap-2 shrink-0">
                    <Link to={`/events/${ev.EventID}`} target="_blank"
                      className="text-xs text-gray-500 border border-gray-200 px-3 py-1.5 rounded-lg hover:bg-gray-50 no-underline">
                      Preview ↗
                    </Link>
                    <button onClick={() => openEdit(ev)}
                      className="text-xs text-blue-600 border border-blue-100 px-3 py-1.5 rounded-lg hover:bg-blue-50">
                      Edit
                    </button>
                    <button onClick={() => setExpandedEvent(expandedEvent === ev.EventID ? null : ev.EventID)}
                      className="text-xs text-[#3D6B34] border border-[#3D6B34]/20 px-3 py-1.5 rounded-lg hover:bg-[#3D6B34]/5">
                      {expandedEvent === ev.EventID ? 'Close ▲' : 'Manage ▼'}
                    </button>
                    <button onClick={() => deleteEvent(ev)}
                      className="text-xs text-red-500 border border-red-100 px-3 py-1.5 rounded-lg hover:bg-red-50">
                      Delete
                    </button>
                  </div>
                </div>

                {/* Management panel */}
                {expandedEvent === ev.EventID && (
                  <div className="border-t border-gray-100 bg-gray-50">
                    {/* Tabs */}
                    <div className="flex border-b border-gray-200 bg-white">
                      {[
                        { id: 'registrations', label: `Registrations (${ev.AttendeeCount || 0})` },
                        { id: 'options', label: 'Ticket Options' },
                        { id: 'dates', label: 'Date Slots' },
                      ].map(tab => (
                        <button
                          key={tab.id}
                          onClick={() => setTab(ev.EventID, tab.id)}
                          className={`px-4 py-2.5 text-xs font-semibold border-b-2 transition-colors ${
                            getTab(ev.EventID) === tab.id
                              ? 'border-[#3D6B34] text-[#3D6B34]'
                              : 'border-transparent text-gray-500 hover:text-gray-700'
                          }`}
                        >
                          {tab.label}
                        </button>
                      ))}
                    </div>

                    <div className="p-4">
                      {getTab(ev.EventID) === 'registrations' && <RegistrationsList eventId={ev.EventID} />}
                      {getTab(ev.EventID) === 'options' && <OptionsEditor eventId={ev.EventID} />}
                      {getTab(ev.EventID) === 'dates' && <DateSlotsEditor eventId={ev.EventID} />}
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
