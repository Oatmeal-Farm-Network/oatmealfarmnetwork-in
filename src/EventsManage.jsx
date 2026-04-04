import React, { useEffect, useState } from 'react';
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

// ── Event Form ─────────────────────────────────────────────────────────────────
function EventForm({ initial, onSave, onCancel, saving }) {
  const [form, setForm] = useState(initial || EMPTY);
  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  const setB = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.checked }));

  return (
    <form onSubmit={(e) => { e.preventDefault(); onSave(form); }} className="space-y-5">

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div className="md:col-span-2">
          <label className={lbl}>Event Name *</label>
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

      <div className="flex gap-3 pt-2">
        <button type="submit" disabled={saving}
          className="bg-[#3D6B34] text-white font-semibold px-6 py-2 rounded-lg hover:bg-[#2d5226] disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Event'}
        </button>
        <button type="button" onClick={onCancel}
          className="px-5 py-2 rounded-lg border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">
          Cancel
        </button>
      </div>
    </form>
  );
}

// ── Registration Options Editor ───────────────────────────────────────────────
function OptionsEditor({ eventId }) {
  const [opts, setOpts] = useState([]);
  const [adding, setAdding] = useState(false);
  const [newOpt, setNewOpt] = useState({ OptionName: '', OptionDescription: '', Price: '', MaxQty: '' });

  const load = () => fetch(`${API}/api/events/${eventId}/options`).then(r => r.json()).then(d => setOpts(Array.isArray(d) ? d : [])).catch(() => {});

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
        <h3 className="text-sm font-bold text-gray-600 uppercase tracking-wide">Registration Options</h3>
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
            <input value={newOpt.OptionDescription} onChange={e => setNewOpt(o => ({ ...o, OptionDescription: e.target.value }))} className={inp} placeholder="Description" />
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

// ── Registrations List (for organizer) ────────────────────────────────────────
function RegistrationsList({ eventId }) {
  const [regs, setRegs] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/registrations`)
      .then(r => r.json()).then(d => { setRegs(Array.isArray(d) ? d : []); setLoading(false); })
      .catch(() => setLoading(false));
  }, [eventId]);

  if (loading) return <div className="text-gray-400 text-sm py-4">Loading registrations…</div>;
  if (regs.length === 0) return <p className="text-sm text-gray-400">No registrations yet.</p>;

  return (
    <div className="overflow-x-auto">
      <table className="w-full text-sm">
        <thead>
          <tr className="border-b border-gray-200 text-xs text-gray-500 uppercase">
            <th className="text-left py-2 px-2">Name</th>
            <th className="text-left py-2 px-2">Email</th>
            <th className="text-left py-2 px-2">Phone</th>
            <th className="text-left py-2 px-2">Total</th>
            <th className="text-left py-2 px-2">Status</th>
            <th className="text-left py-2 px-2">Date</th>
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-100">
          {regs.map(r => (
            <tr key={r.RegID}>
              <td className="py-2 px-2 font-medium text-gray-800">{r.AttendeeFirstName} {r.AttendeeLastName}</td>
              <td className="py-2 px-2 text-gray-600">{r.AttendeeEmail}</td>
              <td className="py-2 px-2 text-gray-600">{r.AttendeePhone || '—'}</td>
              <td className="py-2 px-2 font-bold text-[#3D6B34]">${parseFloat(r.TotalAmount || 0).toFixed(2)}</td>
              <td className="py-2 px-2">
                <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${r.PaymentStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}`}>
                  {r.PaymentStatus}
                </span>
              </td>
              <td className="py-2 px-2 text-gray-400">{new Date(r.RegDate).toLocaleDateString()}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

// ── Main component ─────────────────────────────────────────────────────────────
export default function EventsManage() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  const navigate = useNavigate();

  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editingEvent, setEditingEvent] = useState(null);
  const [expandedEvent, setExpandedEvent] = useState(null);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!BusinessID) return;
    LoadBusiness(BusinessID);
    loadEvents();
  }, [BusinessID]);

  const loadEvents = () => {
    setLoading(true);
    fetch(`${API}/api/events/my-events?business_id=${BusinessID}`)
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
                      {ev.EventStartDate && <span>📅 {formatDate(ev.EventStartDate)}{ev.EventEndDate && ev.EventEndDate !== ev.EventStartDate ? ` – ${formatDate(ev.EventEndDate)}` : ''}</span>}
                      {ev.EventLocationCity && <span>📍 {[ev.EventLocationCity, ev.EventLocationState].filter(Boolean).join(', ')}</span>}
                      <span>👥 {ev.AttendeeCount || 0} registered</span>
                    </div>
                  </div>
                  <div className="flex gap-2 shrink-0">
                    <Link to={`/events/${ev.EventID}`} target="_blank"
                      className="text-xs text-gray-500 hover:underline no-underline border border-gray-200 px-3 py-1.5 rounded-lg hover:bg-gray-50">
                      Preview
                    </Link>
                    <button onClick={() => openEdit(ev)} className="text-xs text-blue-600 hover:underline border border-blue-100 px-3 py-1.5 rounded-lg hover:bg-blue-50">
                      Edit
                    </button>
                    <button onClick={() => setExpandedEvent(expandedEvent === ev.EventID ? null : ev.EventID)}
                      className="text-xs text-[#3D6B34] hover:underline border border-[#3D6B34]/20 px-3 py-1.5 rounded-lg hover:bg-[#3D6B34]/5">
                      {expandedEvent === ev.EventID ? 'Hide' : 'Manage'}
                    </button>
                    <button onClick={() => deleteEvent(ev)} className="text-xs text-red-500 hover:underline border border-red-100 px-3 py-1.5 rounded-lg hover:bg-red-50">
                      Delete
                    </button>
                  </div>
                </div>

                {/* Expanded management panel */}
                {expandedEvent === ev.EventID && (
                  <div className="border-t border-gray-100 p-4 space-y-6 bg-gray-50">
                    <OptionsEditor eventId={ev.EventID} />
                    <div>
                      <h3 className="text-sm font-bold text-gray-600 uppercase tracking-wide mb-3">Registrations ({ev.AttendeeCount || 0})</h3>
                      <RegistrationsList eventId={ev.EventID} />
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
