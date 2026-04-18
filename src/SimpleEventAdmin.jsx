import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

const TYPES_WITH_SPEAKER   = new Set(['Seminar', 'Workshop/Clinic', 'Webinar/Online Class']);
const TYPES_WITH_MATERIALS = new Set(['Workshop/Clinic']);
const TYPES_WITH_STREAMING = new Set(['Webinar/Online Class']);
const TYPES_WITH_ICEBREAK  = new Set(['Networking Event']);
const TYPES_WITH_DIRECTORY = new Set(['Networking Event']);
const TYPES_WITH_CERT      = new Set(['Workshop/Clinic', 'Webinar/Online Class', 'Seminar']);
const TYPES_FREE_DEFAULT   = new Set(['Free Event']);

function d(v) { return v ? String(v).substring(0, 10) : ''; }

const EMPTY = {
  Description: '', IsFree: false, PriceAdult: 0, PriceChild: '',
  EarlyBirdPrice: '', EarlyBirdEndDate: '',
  MaxAttendees: '', WaitlistEnabled: true, RegistrationEndDate: '',
  SpeakerName: '', SpeakerBio: '', SpeakerPhoto: '',
  MaterialsList: '', SkillLevel: '', CertificateEnabled: false,
  StreamingLink: '', StreamingPlatform: '', RecordingLink: '',
  HandoutLink: '', TimezoneNote: '',
  IcebreakerPrompts: '', DirectoryVisible: false,
  PrepEmailSubject: '', PrepEmailBody: '',
  IsActive: true,
};

function ConfigTab({ eventId, eventType }) {
  const [cfg, setCfg] = useState(EMPTY);
  const [booked, setBooked] = useState(0);
  const [waitlist, setWaitlist] = useState(0);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');

  const load = () => fetch(`${API}/api/events/${eventId}/simple/config`)
    .then(r => r.json())
    .then(x => {
      setBooked(x?.AttendeesBooked || 0);
      setWaitlist(x?.WaitlistCount || 0);
      if (x?.configured) {
        setCfg({
          Description: x.Description || '',
          IsFree: !!x.IsFree,
          PriceAdult: x.PriceAdult ?? 0,
          PriceChild: x.PriceChild ?? '',
          EarlyBirdPrice: x.EarlyBirdPrice ?? '',
          EarlyBirdEndDate: d(x.EarlyBirdEndDate),
          MaxAttendees: x.MaxAttendees ?? '',
          WaitlistEnabled: x.WaitlistEnabled !== false,
          RegistrationEndDate: d(x.RegistrationEndDate),
          SpeakerName: x.SpeakerName || '',
          SpeakerBio: x.SpeakerBio || '',
          SpeakerPhoto: x.SpeakerPhoto || '',
          MaterialsList: x.MaterialsList || '',
          SkillLevel: x.SkillLevel || '',
          CertificateEnabled: !!x.CertificateEnabled,
          StreamingLink: x.StreamingLink || '',
          StreamingPlatform: x.StreamingPlatform || '',
          RecordingLink: x.RecordingLink || '',
          HandoutLink: x.HandoutLink || '',
          TimezoneNote: x.TimezoneNote || '',
          IcebreakerPrompts: x.IcebreakerPrompts || '',
          DirectoryVisible: !!x.DirectoryVisible,
          PrepEmailSubject: x.PrepEmailSubject || '',
          PrepEmailBody: x.PrepEmailBody || '',
          IsActive: x.IsActive !== false,
        });
      } else if (TYPES_FREE_DEFAULT.has(eventType)) {
        setCfg(c => ({ ...c, IsFree: true }));
      }
    })
    .catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setB = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.checked }));

  const save = async (e) => {
    e.preventDefault();
    setSaving(true); setMsg('');
    try {
      const payload = {
        ...cfg,
        PriceAdult: Number(cfg.PriceAdult) || 0,
        PriceChild: cfg.PriceChild === '' ? null : Number(cfg.PriceChild),
        EarlyBirdPrice: cfg.EarlyBirdPrice === '' ? null : Number(cfg.EarlyBirdPrice),
        MaxAttendees: cfg.MaxAttendees === '' ? null : Number(cfg.MaxAttendees),
      };
      const r = await fetch(`${API}/api/events/${eventId}/simple/config`, {
        method: 'PUT', headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(payload),
      });
      if (!r.ok) throw new Error('Save failed');
      setMsg('Saved');
    } catch (ex) { setMsg(ex.message); }
    finally { setSaving(false); setTimeout(() => setMsg(''), 3000); }
  };

  const showSpeaker   = TYPES_WITH_SPEAKER.has(eventType);
  const showMaterials = TYPES_WITH_MATERIALS.has(eventType);
  const showStreaming = TYPES_WITH_STREAMING.has(eventType);
  const showIcebreak  = TYPES_WITH_ICEBREAK.has(eventType);
  const showDirectory = TYPES_WITH_DIRECTORY.has(eventType);
  const showCert      = TYPES_WITH_CERT.has(eventType);
  const showPricing   = !TYPES_FREE_DEFAULT.has(eventType);

  return (
    <form onSubmit={save} className="space-y-5">
      {(booked > 0 || waitlist > 0) && (
        <div className="bg-[#F5F2E8] border border-[#E8DEC2] rounded-lg p-3 text-sm">
          <span className="font-medium text-[#3D6B34]">{booked}</span> confirmed
          {waitlist > 0 && <> · <span className="font-medium text-amber-700">{waitlist}</span> waitlisted</>}
        </div>
      )}

      <div>
        <label className={lbl}>Description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={160} />
      </div>

      {showPricing && (
        <div className="bg-gray-50 rounded-lg p-4 space-y-4">
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={!!cfg.IsFree} onChange={setB('IsFree')} />
            <span>Free event (no payment)</span>
          </label>
          {!cfg.IsFree && (
            <div className="grid grid-cols-1 md:grid-cols-4 gap-3">
              <div>
                <label className={lbl}>Price / adult</label>
                <input className={inp} type="number" step="0.01" value={cfg.PriceAdult} onChange={set('PriceAdult')} />
              </div>
              <div>
                <label className={lbl}>Price / child (optional)</label>
                <input className={inp} type="number" step="0.01" value={cfg.PriceChild} onChange={set('PriceChild')} />
              </div>
              <div>
                <label className={lbl}>Early-bird price</label>
                <input className={inp} type="number" step="0.01" value={cfg.EarlyBirdPrice} onChange={set('EarlyBirdPrice')} />
              </div>
              <div>
                <label className={lbl}>Early-bird ends</label>
                <input className={inp} type="date" value={cfg.EarlyBirdEndDate} onChange={set('EarlyBirdEndDate')} />
              </div>
            </div>
          )}
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div>
          <label className={lbl}>Max attendees (blank = unlimited)</label>
          <input className={inp} type="number" value={cfg.MaxAttendees} onChange={set('MaxAttendees')} />
        </div>
        <div>
          <label className={lbl}>Registration ends</label>
          <input className={inp} type="date" value={cfg.RegistrationEndDate} onChange={set('RegistrationEndDate')} />
        </div>
        <label className="flex items-end gap-2 text-sm pb-2">
          <input type="checkbox" checked={!!cfg.WaitlistEnabled} onChange={setB('WaitlistEnabled')} />
          <span>Enable waitlist when full</span>
        </label>
      </div>

      {showSpeaker && (
        <div className="border border-gray-200 rounded-lg p-4 space-y-3">
          <div className="font-medium text-sm text-[#3D6B34]">Speaker / instructor</div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div>
              <label className={lbl}>Name</label>
              <input className={inp} value={cfg.SpeakerName} onChange={set('SpeakerName')} />
            </div>
            <div>
              <label className={lbl}>Photo URL</label>
              <input className={inp} value={cfg.SpeakerPhoto} onChange={set('SpeakerPhoto')} />
            </div>
          </div>
          <div>
            <label className={lbl}>Bio</label>
            <RichTextEditor value={cfg.SpeakerBio || ''}
              onChange={(v) => setCfg(c => ({ ...c, SpeakerBio: v }))} minHeight={120} />
          </div>
        </div>
      )}

      {showMaterials && (
        <div className="border border-gray-200 rounded-lg p-4 space-y-3">
          <div className="font-medium text-sm text-[#3D6B34]">Workshop details</div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div>
              <label className={lbl}>Skill level</label>
              <select className={inp} value={cfg.SkillLevel} onChange={set('SkillLevel')}>
                <option value="">—</option>
                <option>Beginner</option>
                <option>Intermediate</option>
                <option>Advanced</option>
                <option>All levels</option>
              </select>
            </div>
            <div>
              <label className={lbl}>Handout link</label>
              <input className={inp} value={cfg.HandoutLink} onChange={set('HandoutLink')} />
            </div>
          </div>
          <div>
            <label className={lbl}>Materials to bring</label>
            <textarea className={inp} rows={4} value={cfg.MaterialsList} onChange={set('MaterialsList')} />
          </div>
        </div>
      )}

      {showStreaming && (
        <div className="border border-gray-200 rounded-lg p-4 space-y-3">
          <div className="font-medium text-sm text-[#3D6B34]">Streaming / online</div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <div>
              <label className={lbl}>Platform</label>
              <input className={inp} value={cfg.StreamingPlatform} onChange={set('StreamingPlatform')} placeholder="Zoom, Google Meet..." />
            </div>
            <div className="md:col-span-2">
              <label className={lbl}>Streaming link (sent to registrants)</label>
              <input className={inp} value={cfg.StreamingLink} onChange={set('StreamingLink')} />
            </div>
            <div className="md:col-span-2">
              <label className={lbl}>Recording link (post-event)</label>
              <input className={inp} value={cfg.RecordingLink} onChange={set('RecordingLink')} />
            </div>
            <div>
              <label className={lbl}>Timezone note</label>
              <input className={inp} value={cfg.TimezoneNote} onChange={set('TimezoneNote')} placeholder="e.g. All times Central" />
            </div>
          </div>
        </div>
      )}

      {showIcebreak && (
        <div className="border border-gray-200 rounded-lg p-4 space-y-3">
          <div className="font-medium text-sm text-[#3D6B34]">Networking setup</div>
          <div>
            <label className={lbl}>Icebreaker prompts (one per line)</label>
            <textarea className={inp} rows={4} value={cfg.IcebreakerPrompts} onChange={set('IcebreakerPrompts')} />
          </div>
          {showDirectory && (
            <label className="flex items-center gap-2 text-sm">
              <input type="checkbox" checked={!!cfg.DirectoryVisible} onChange={setB('DirectoryVisible')} />
              <span>Share attendee directory with registrants</span>
            </label>
          )}
        </div>
      )}

      {showCert && (
        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" checked={!!cfg.CertificateEnabled} onChange={setB('CertificateEnabled')} />
          <span>Issue certificate of attendance</span>
        </label>
      )}

      <div className="border border-gray-200 rounded-lg p-4 space-y-3">
        <div className="font-medium text-sm text-[#3D6B34]">Prep email (sent on registration)</div>
        <div>
          <label className={lbl}>Subject</label>
          <input className={inp} value={cfg.PrepEmailSubject} onChange={set('PrepEmailSubject')} />
        </div>
        <div>
          <label className={lbl}>Body</label>
          <RichTextEditor value={cfg.PrepEmailBody || ''}
            onChange={(v) => setCfg(c => ({ ...c, PrepEmailBody: v }))} minHeight={120} />
        </div>
      </div>

      <label className="flex items-center gap-2 text-sm">
        <input type="checkbox" checked={!!cfg.IsActive} onChange={setB('IsActive')} />
        <span>Event active (accepting registrations)</span>
      </label>

      <div className="flex items-center gap-3 justify-end">
        {msg && <span className="text-sm text-[#3D6B34] mr-auto">{msg}</span>}
        <Link to="/account/events"
          className="text-sm px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-50">
          Cancel
        </Link>
        <button type="submit" disabled={saving}
          className="bg-[#3D6B34] hover:bg-[#2D5228] text-white text-sm px-5 py-2 rounded-lg disabled:opacity-50">
          {saving ? 'Saving…' : 'Save configuration'}
        </button>
      </div>
    </form>
  );
}

function RegistrationsTab({ eventId, eventType }) {
  const [regs, setRegs] = useState([]);
  const [loading, setLoading] = useState(true);

  const load = () => {
    setLoading(true);
    fetch(`${API}/api/events/${eventId}/simple/registrations`)
      .then(r => r.json())
      .then(setRegs)
      .catch(() => setRegs([]))
      .finally(() => setLoading(false));
  };
  useEffect(() => { load(); }, [eventId]);

  const toggleCheckin = async (reg) => {
    await fetch(`${API}/api/events/simple/registrations/${reg.RegID}/checkin`, {
      method: 'PUT', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ CheckedIn: !reg.CheckedIn }),
    });
    load();
  };
  const setPaid = async (reg, paid) => {
    await fetch(`${API}/api/events/simple/registrations/${reg.RegID}`, {
      method: 'PUT', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ PaidStatus: paid ? 'paid' : 'pending' }),
    });
    load();
  };
  const promote = async (reg) => {
    await fetch(`${API}/api/events/simple/registrations/${reg.RegID}`, {
      method: 'PUT', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ Status: 'confirmed' }),
    });
    load();
  };
  const remove = async (reg) => {
    if (!confirm(`Remove ${reg.GuestName}?`)) return;
    await fetch(`${API}/api/events/simple/registrations/${reg.RegID}`, { method: 'DELETE' });
    load();
  };

  if (loading) return <div className="text-sm text-gray-500">Loading…</div>;
  if (!regs.length) return <div className="text-sm text-gray-500">No registrations yet.</div>;

  const confirmed = regs.filter(r => (r.Status || 'confirmed') === 'confirmed');
  const waitlist = regs.filter(r => r.Status === 'waitlist');

  const row = (r) => (
    <tr key={r.RegID} className="border-t border-gray-100">
      <td className="py-2 px-3">
        <div className="font-medium text-gray-800">{r.GuestName}</div>
        {r.GuestEmail && <div className="text-xs text-gray-500">{r.GuestEmail}</div>}
        {r.NameTagTitle && <div className="text-xs text-gray-400">{r.NameTagTitle}</div>}
      </td>
      <td className="py-2 px-3 text-sm">{r.PartySize}{r.ChildCount ? ` (${r.ChildCount} child)` : ''}</td>
      <td className="py-2 px-3 text-sm">${Number(r.TotalFee || 0).toFixed(2)}</td>
      <td className="py-2 px-3 text-sm">
        <button onClick={() => setPaid(r, r.PaidStatus !== 'paid')}
          className={`text-xs px-2 py-1 rounded ${r.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'}`}>
          {r.PaidStatus === 'paid' ? 'Paid' : 'Pending'}
        </button>
      </td>
      <td className="py-2 px-3 text-sm">
        <button onClick={() => toggleCheckin(r)}
          className={`text-xs px-2 py-1 rounded ${r.CheckedIn ? 'bg-[#3D6B34] text-white' : 'bg-gray-100 text-gray-600'}`}>
          {r.CheckedIn ? 'Checked in' : 'Check in'}
        </button>
      </td>
      <td className="py-2 px-3 text-sm">
        {r.Status === 'waitlist' && (
          <button onClick={() => promote(r)}
            className="text-xs px-2 py-1 rounded bg-amber-100 text-amber-700 mr-2">
            Promote
          </button>
        )}
        <button onClick={() => remove(r)} className="text-xs text-red-600 hover:underline">Remove</button>
      </td>
    </tr>
  );

  const table = (title, rows) => (
    <div>
      <div className="font-medium text-sm text-[#3D6B34] mb-2">{title} ({rows.length})</div>
      <div className="border border-gray-200 rounded-lg overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 text-xs text-gray-500 uppercase">
            <tr>
              <th className="py-2 px-3 text-left">Guest</th>
              <th className="py-2 px-3 text-left">Party</th>
              <th className="py-2 px-3 text-left">Fee</th>
              <th className="py-2 px-3 text-left">Payment</th>
              <th className="py-2 px-3 text-left">Check-in</th>
              <th className="py-2 px-3 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>{rows.map(row)}</tbody>
        </table>
      </div>
    </div>
  );

  return (
    <div className="space-y-5">
      {table('Confirmed', confirmed)}
      {waitlist.length > 0 && table('Waitlist', waitlist)}
    </div>
  );
}

export default function SimpleEventAdmin() {
  const { eventId } = useParams();
  const [sp, setSp] = useSearchParams();
  const tab = sp.get('tab') || 'config';
  const [ev, setEv] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`)
      .then(r => r.json()).then(setEv).catch(() => setEv(null));
  }, [eventId]);

  const setTab = (t) => setSp({ tab: t });
  const eventType = ev?.EventType || '';

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl mx-auto p-4 md:p-6">
        <div className="flex items-center justify-between mb-4">
          <div>
            <Link to="/account/events" className="text-xs text-gray-500 hover:text-[#3D6B34]">← Events</Link>
            <h1 className="text-2xl font-semibold text-[#3D6B34] mt-1">
              {ev?.EventName || 'Event'} <span className="text-sm text-gray-400 font-normal">— {eventType || '…'}</span>
            </h1>
          </div>
        </div>

        <div className="flex gap-2 border-b border-gray-200 mb-5">
          {[
            ['config', 'Configuration'],
            ['regs', 'Registrations'],
          ].map(([k, label]) => (
            <button key={k} onClick={() => setTab(k)}
              className={`px-4 py-2 text-sm -mb-px border-b-2 ${tab === k ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
              {label}
            </button>
          ))}
        </div>

        {tab === 'config' && <ConfigTab eventId={eventId} eventType={eventType} />}
        {tab === 'regs'   && <RegistrationsTab eventId={eventId} eventType={eventType} />}
      </div>
    </EventAdminLayout>
  );
}
