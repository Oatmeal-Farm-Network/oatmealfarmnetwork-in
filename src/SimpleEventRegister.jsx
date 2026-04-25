import React, { useEffect, useState, useMemo } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import { useAccount } from './AccountContext';
import ThaiymeChat from './ThaiymeChat';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

const TYPES_WITH_DIRECTORY = new Set(['Networking Event']);
const TYPES_WITH_NAMETAG   = new Set(['Networking Event', 'Workshop/Clinic', 'Seminar']);
const TYPES_WITH_PARTY     = new Set(['Seminar', 'Basic Event', 'Workshop/Clinic', 'Free Event']);

export default function SimpleEventRegister() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const { BusinessID: ctxBusinessID } = useAccount() || {};
  const BusinessID = params.get('BusinessID') || ctxBusinessID;
  const peopleId = Number(localStorage.getItem('people_id')) || null;

  const [event, setEvent] = useState(null);
  const [cfg, setCfg] = useState(null);
  const [directory, setDirectory] = useState([]);

  const [form, setForm] = useState({
    GuestName: '', GuestEmail: '', GuestPhone: '',
    PartySize: 1, ChildCount: 0,
    NameTagTitle: '',
    DietaryRestrictions: '', SpecialRequests: '',
  });
  const [saving, setSaving] = useState(false);
  const [err, setErr] = useState('');
  const [result, setResult] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
    fetch(`${API}/api/events/${eventId}/simple/config`).then(r => r.json()).then(setCfg).catch(() => {});
  }, [eventId]);

  const eventType = event?.EventType || '';
  const showParty = TYPES_WITH_PARTY.has(eventType);
  const showNameTag = TYPES_WITH_NAMETAG.has(eventType);
  const showDirectoryOptIn = TYPES_WITH_DIRECTORY.has(eventType) && cfg?.DirectoryVisible;

  useEffect(() => {
    if (TYPES_WITH_DIRECTORY.has(eventType) && cfg?.DirectoryVisible) {
      fetch(`${API}/api/events/${eventId}/simple/directory`)
        .then(r => r.json()).then(setDirectory).catch(() => {});
    }
  }, [eventId, eventType, cfg]);

  const fee = useMemo(() => {
    if (!cfg || cfg.IsFree) return 0;
    const party = Number(form.PartySize) || 0;
    const kids = Math.min(Number(form.ChildCount) || 0, party);
    const adults = Math.max(0, party - kids);
    let adultPrice = Number(cfg.PriceAdult || 0);
    if (cfg.EarlyBirdPrice != null && cfg.EarlyBirdEndDate) {
      const today = new Date().toISOString().substring(0, 10);
      if (today <= String(cfg.EarlyBirdEndDate).substring(0, 10)) {
        adultPrice = Number(cfg.EarlyBirdPrice);
      }
    }
    const childPrice = cfg.PriceChild != null ? Number(cfg.PriceChild) : adultPrice;
    return adults * adultPrice + kids * childPrice;
  }, [cfg, form]);

  const submit = async (e) => {
    e.preventDefault();
    setErr('');
    if (!form.GuestName.trim()) { setErr('Name required'); return; }
    setSaving(true);
    try {
      const r = await fetch(`${API}/api/events/${eventId}/simple/registrations`, {
        method: 'POST', headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
          PeopleID: peopleId, BusinessID: BusinessID ? Number(BusinessID) : null,
          ...form,
          PartySize: Number(form.PartySize) || 1,
          ChildCount: Number(form.ChildCount) || 0,
        }),
      });
      if (!r.ok) {
        const j = await r.json().catch(() => ({}));
        throw new Error(j.detail || 'Registration failed');
      }
      setResult(await r.json());
    } catch (ex) { setErr(ex.message); }
    finally { setSaving(false); }
  };

  if (result) {
    const waitlisted = result.Status === 'waitlist';
    return (
      <div className="min-h-screen bg-[#FAF7EE] py-10 px-4">
        <div className="max-w-xl mx-auto bg-white rounded-xl shadow p-6">
          <h1 className="text-xl font-semibold text-[#3D6B34] mb-2">
            {waitlisted ? "You're on the waitlist" : "You're registered"}
          </h1>
          <div className="text-sm text-gray-600 mb-4">
            {event?.EventName}
          </div>
          {waitlisted ? (
            <p className="text-sm text-amber-700">
              The event is full. We'll email you if a spot opens up.
            </p>
          ) : (
            <>
              <p className="text-sm text-gray-700 mb-3">
                A confirmation email is on the way.
              </p>
              {cfg?.StreamingLink && (
                <div className="bg-[#F5F2E8] border border-[#E8DEC2] rounded-lg p-3 text-sm mb-3">
                  <div className="font-medium text-[#3D6B34] mb-1">Join link</div>
                  <a href={cfg.StreamingLink} target="_blank" rel="noreferrer"
                    className="text-[#3D6B34] underline break-all">{cfg.StreamingLink}</a>
                  {cfg.TimezoneNote && <div className="text-xs text-gray-500 mt-1">{cfg.TimezoneNote}</div>}
                </div>
              )}
              {fee > 0 && (
                <div className="text-sm text-gray-700">
                  Total: <span className="font-medium">${fee.toFixed(2)}</span>
                </div>
              )}
            </>
          )}
          <Link to={`/events/${eventId}`}
            className="inline-block mt-5 text-sm text-[#3D6B34] hover:underline">
            ← Back to event
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#FAF7EE] py-10 px-4">
      <div className="max-w-xl mx-auto bg-white rounded-xl shadow p-6">
        <Link to={`/events/${eventId}`} className="text-xs text-gray-500 hover:text-[#3D6B34]">← Back</Link>
        <h1 className="text-2xl font-semibold text-[#3D6B34] mt-1 mb-1">
          Register — {event?.EventName || ''}
        </h1>
        <div className="text-sm text-gray-500 mb-5">{eventType}</div>

        {cfg?.Description && (
          <div className="prose prose-sm max-w-none mb-5" dangerouslySetInnerHTML={{ __html: cfg.Description }} />
        )}

        {cfg?.TimezoneNote && (
          <div className="text-xs text-gray-500 mb-4">{cfg.TimezoneNote}</div>
        )}

        <form onSubmit={submit} className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div>
              <label className={lbl}>Full name *</label>
              <input className={inp} required value={form.GuestName}
                onChange={e => setForm(f => ({ ...f, GuestName: e.target.value }))} />
            </div>
            <div>
              <label className={lbl}>Email</label>
              <input className={inp} type="email" value={form.GuestEmail}
                onChange={e => setForm(f => ({ ...f, GuestEmail: e.target.value }))} />
            </div>
            <div>
              <label className={lbl}>Phone</label>
              <input className={inp} value={form.GuestPhone}
                onChange={e => setForm(f => ({ ...f, GuestPhone: e.target.value }))} />
            </div>
            {showNameTag && (
              <div>
                <label className={lbl}>Name tag / title (optional)</label>
                <input className={inp} value={form.NameTagTitle}
                  onChange={e => setForm(f => ({ ...f, NameTagTitle: e.target.value }))} />
              </div>
            )}
          </div>

          {showParty && (
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className={lbl}>Party size</label>
                <input className={inp} type="number" min="1" value={form.PartySize}
                  onChange={e => setForm(f => ({ ...f, PartySize: e.target.value }))} />
              </div>
              <div>
                <label className={lbl}># children</label>
                <input className={inp} type="number" min="0" value={form.ChildCount}
                  onChange={e => setForm(f => ({ ...f, ChildCount: e.target.value }))} />
              </div>
            </div>
          )}

          <div>
            <label className={lbl}>Dietary restrictions / allergies</label>
            <input className={inp} value={form.DietaryRestrictions}
              onChange={e => setForm(f => ({ ...f, DietaryRestrictions: e.target.value }))} />
          </div>
          <div>
            <label className={lbl}>Special requests</label>
            <textarea className={inp} rows={3} value={form.SpecialRequests}
              onChange={e => setForm(f => ({ ...f, SpecialRequests: e.target.value }))} />
          </div>

          {!cfg?.IsFree && (
            <div className="bg-[#F5F2E8] border border-[#E8DEC2] rounded-lg p-3 text-sm">
              Total: <span className="font-medium text-[#3D6B34]">${fee.toFixed(2)}</span>
            </div>
          )}

          {err && <div className="text-sm text-red-600">{err}</div>}

          <div className="flex items-center gap-3 justify-end">
            <Link to={`/events/${eventId}`} className="text-sm px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-50">
              Cancel
            </Link>
            <button type="submit" disabled={saving}
              className="bg-[#3D6B34] hover:bg-[#2D5228] text-white text-sm px-5 py-2 rounded-lg disabled:opacity-50">
              {saving ? 'Submitting…' : (cfg?.IsFree ? 'RSVP' : 'Register')}
            </button>
          </div>
        </form>

        {showDirectoryOptIn && directory.length > 0 && (
          <div className="mt-8">
            <div className="text-sm font-medium text-[#3D6B34] mb-2">Who else is attending</div>
            <ul className="text-sm text-gray-700 grid grid-cols-2 gap-1">
              {directory.map(d => (
                <li key={d.RegID}>
                  {d.GuestName}{d.NameTagTitle ? ` — ${d.NameTagTitle}` : ''}
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>
      <ThaiymeChat eventId={Number(eventId) || null} page="simple_event_register" />
    </div>
  );
}
