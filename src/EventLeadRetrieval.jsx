/**
 * EventLeadRetrieval — exhibitor-facing lead capture + management.
 *
 * Flow on the page:
 *   1. Big "Scan badge" input — paste/scan a BadgeCode, hit lookup → see attendee
 *   2. Add notes / rating / interest / follow-up status → Save
 *   3. Below: list of leads collected at this event for this business
 *   4. Filter by status, rating ≥ N. Click a row to edit.
 *   5. "Export CSV" button → downloads all leads
 *
 * Required URL params: ?BusinessID=…&FieldID is unused; eventId from path.
 */
import React, { useEffect, useState, useCallback } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import { useAccount } from './AccountContext';
import { queuedFetch, onConnectivityChange, flushQueue } from './offlineQueue';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-2 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50 font-semibold";
const btnGhost = "px-3 py-1.5 text-sm border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50";

const STATUS_OPTIONS = [
  { key: 'new',       label: 'New',       color: 'bg-blue-100 text-blue-800' },
  { key: 'contacted', label: 'Contacted', color: 'bg-amber-100 text-amber-800' },
  { key: 'qualified', label: 'Qualified', color: 'bg-emerald-100 text-emerald-800' },
  { key: 'won',       label: 'Won',       color: 'bg-green-200 text-green-900' },
  { key: 'lost',      label: 'Lost',      color: 'bg-gray-100 text-gray-700' },
];

function StatusBadge({ value }) {
  const opt = STATUS_OPTIONS.find(o => o.key === value) || STATUS_OPTIONS[0];
  return <span className={`inline-block text-[10px] px-2 py-0.5 rounded-full font-medium uppercase tracking-wide ${opt.color}`}>{opt.label}</span>;
}

function StarPicker({ value, onChange, size = 'md' }) {
  const px = size === 'sm' ? 14 : 22;
  return (
    <div className="flex gap-0.5">
      {[1,2,3,4,5].map(n => (
        <button key={n} type="button" onClick={() => onChange(n === value ? null : n)}
          className="leading-none" style={{ fontSize: px, color: (value || 0) >= n ? '#F59E0B' : '#D1D5DB' }}>
          ★
        </button>
      ))}
    </div>
  );
}

// ─── Capture form ───────────────────────────────────────────────────────────
function CaptureForm({ eventId, businessId, peopleId, onSaved }) {
  const [badge, setBadge] = useState('');
  const [resolved, setResolved] = useState(null);
  const [lookupErr, setLookupErr] = useState('');
  const [draft, setDraft] = useState({
    AttendeeName: '', AttendeeBusiness: '', AttendeeEmail: '', AttendeePhone: '',
    Rating: null, Interest: '', Notes: '', FollowUpStatus: 'new',
  });
  const [saving, setSaving] = useState(false);
  const [savedMsg, setSavedMsg] = useState('');

  const lookup = async () => {
    setLookupErr(''); setResolved(null);
    if (!badge.trim()) return;
    const r = await fetch(`${API}/api/events/${eventId}/leads/lookup?code=${encodeURIComponent(badge.trim())}`);
    if (r.ok) {
      const data = await r.json();
      setResolved(data);
      setDraft(d => ({
        ...d,
        AttendeeName:     data.Name     || '',
        AttendeeBusiness: data.Business || '',
        AttendeeEmail:    data.Email    || '',
        AttendeePhone:    data.Phone    || '',
      }));
    } else {
      const j = await r.json().catch(() => ({}));
      setLookupErr(j.detail || 'Not found.');
    }
  };

  const reset = () => {
    setBadge(''); setResolved(null); setLookupErr('');
    setDraft({ AttendeeName: '', AttendeeBusiness: '', AttendeeEmail: '', AttendeePhone: '',
               Rating: null, Interest: '', Notes: '', FollowUpStatus: 'new' });
  };

  const save = async () => {
    setSaving(true); setSavedMsg('');
    // queuedFetch falls back to the SW bg-sync queue on network failure so
    // exhibitors scanning in spotty cell areas don't lose leads.
    const r = await queuedFetch(`${API}/api/events/${eventId}/leads/scan`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        ExhibitorBusinessID: Number(businessId),
        ScannedByPeopleID:   Number(peopleId),
        BadgeCode:           badge.trim() || null,
        ...draft,
      }),
      queueWhenOffline: true,
    });
    setSaving(false);
    if (r.ok) {
      const j = await r.json();
      if (j.queued || j.offline) {
        setSavedMsg('Saved offline — will sync when you have signal.');
      } else {
        setSavedMsg(j.deduped ? 'Already scanned (last 5 min).' : 'Lead saved!');
      }
      onSaved?.();
      setTimeout(() => { reset(); setSavedMsg(''); }, 1500);
    } else if (r.status === 202) {
      setSavedMsg('Queued for sync.');
      reset();
    } else {
      const j = await r.json().catch(() => ({}));
      setSavedMsg('Error: ' + (j.detail || 'save failed'));
    }
  };

  return (
    <div className="bg-white border border-gray-200 rounded-xl p-5 space-y-4">
      <div>
        <label className={lbl}>Badge code (scan or paste)</label>
        <div className="flex gap-2">
          <input className={inp} value={badge} autoFocus
            onChange={e => setBadge(e.target.value)}
            onKeyDown={e => { if (e.key === 'Enter') lookup(); }}
            placeholder="CONF42-12345" />
          <button onClick={lookup} className={btnGhost}>Look up</button>
        </div>
        {lookupErr && <div className="text-xs text-red-600 mt-1">{lookupErr}</div>}
        {resolved && (
          <div className="text-xs text-emerald-700 mt-1">
            ✓ Found: <strong>{resolved.Name}</strong>{resolved.Business ? ` · ${resolved.Business}` : ''}
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <div><label className={lbl}>Name</label>
          <input className={inp} value={draft.AttendeeName} onChange={e => setDraft(d => ({ ...d, AttendeeName: e.target.value }))} /></div>
        <div><label className={lbl}>Business</label>
          <input className={inp} value={draft.AttendeeBusiness} onChange={e => setDraft(d => ({ ...d, AttendeeBusiness: e.target.value }))} /></div>
        <div><label className={lbl}>Email</label>
          <input className={inp} type="email" value={draft.AttendeeEmail} onChange={e => setDraft(d => ({ ...d, AttendeeEmail: e.target.value }))} /></div>
        <div><label className={lbl}>Phone</label>
          <input className={inp} value={draft.AttendeePhone} onChange={e => setDraft(d => ({ ...d, AttendeePhone: e.target.value }))} /></div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div>
          <label className={lbl}>Lead quality</label>
          <StarPicker value={draft.Rating} onChange={v => setDraft(d => ({ ...d, Rating: v }))} />
        </div>
        <div>
          <label className={lbl}>Interest / product tag</label>
          <input className={inp} value={draft.Interest} onChange={e => setDraft(d => ({ ...d, Interest: e.target.value }))} placeholder="e.g. Tractor demo, Soil testing" />
        </div>
        <div>
          <label className={lbl}>Follow-up status</label>
          <select className={inp} value={draft.FollowUpStatus} onChange={e => setDraft(d => ({ ...d, FollowUpStatus: e.target.value }))}>
            {STATUS_OPTIONS.map(o => <option key={o.key} value={o.key}>{o.label}</option>)}
          </select>
        </div>
      </div>

      <div>
        <label className={lbl}>Notes</label>
        <textarea className={inp} rows={2} value={draft.Notes} onChange={e => setDraft(d => ({ ...d, Notes: e.target.value }))}
          placeholder="What did you discuss? Next step?" />
      </div>

      <div className="flex justify-between items-center">
        <span className={`text-xs ${savedMsg.startsWith('Error') ? 'text-red-600' : 'text-emerald-700'}`}>{savedMsg}</span>
        <div className="flex gap-2">
          <button onClick={reset} className={btnGhost}>Clear</button>
          <button onClick={save} disabled={saving || !draft.AttendeeName.trim()} className={btn}>
            {saving ? 'Saving…' : 'Save lead'}
          </button>
        </div>
      </div>
    </div>
  );
}

// ─── Lead list + filters + export ───────────────────────────────────────────
function LeadsList({ eventId, businessId, refreshKey, onChanged }) {
  const [leads, setLeads] = useState([]);
  const [summary, setSummary] = useState(null);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState({ status: '', minRating: 0 });
  const [editing, setEditing] = useState(null);

  const refresh = useCallback(() => {
    setLoading(true);
    const params = new URLSearchParams({ business_id: String(businessId) });
    if (filter.status)        params.set('status', filter.status);
    if (filter.minRating > 0) params.set('rating_min', String(filter.minRating));
    Promise.all([
      fetch(`${API}/api/events/${eventId}/leads?${params}`).then(r => r.ok ? r.json() : []),
      fetch(`${API}/api/events/${eventId}/leads/summary?business_id=${businessId}`).then(r => r.ok ? r.json() : null),
    ]).then(([l, s]) => { setLeads(l); setSummary(s); setLoading(false); });
  }, [eventId, businessId, filter.status, filter.minRating]);

  useEffect(refresh, [refresh, refreshKey]);

  const saveEdit = async (l) => {
    const r = await fetch(`${API}/api/events/leads/${l.ScanID}`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(l),
    });
    if (r.ok) { setEditing(null); refresh(); onChanged?.(); }
  };
  const del = async (id) => {
    if (!window.confirm('Delete this lead?')) return;
    await fetch(`${API}/api/events/leads/${id}`, { method: 'DELETE' });
    refresh(); onChanged?.();
  };

  const exportUrl = `${API}/api/events/${eventId}/leads/export.csv?business_id=${businessId}`;

  return (
    <div className="bg-white border border-gray-200 rounded-xl p-5 space-y-4">
      <div className="flex items-center justify-between flex-wrap gap-3">
        <div>
          <h2 className="font-lora text-lg font-bold text-gray-900">My leads ({leads.length})</h2>
          {summary && (
            <div className="text-xs text-gray-500 mt-1 flex flex-wrap gap-x-3">
              <span>Total: {summary.total}</span>
              {Object.entries(summary.by_status || {}).map(([k, n]) => <span key={k}>{k}: {n}</span>)}
            </div>
          )}
        </div>
        <a href={exportUrl} className={btnGhost} download>⬇ Export CSV</a>
      </div>

      <div className="flex flex-wrap gap-2 items-center text-xs">
        <span className="text-gray-500 font-medium">Filter:</span>
        <select className="border border-gray-300 rounded px-2 py-1 text-xs" value={filter.status}
          onChange={e => setFilter(f => ({ ...f, status: e.target.value }))}>
          <option value="">All statuses</option>
          {STATUS_OPTIONS.map(o => <option key={o.key} value={o.key}>{o.label}</option>)}
        </select>
        <select className="border border-gray-300 rounded px-2 py-1 text-xs" value={filter.minRating}
          onChange={e => setFilter(f => ({ ...f, minRating: Number(e.target.value) }))}>
          <option value={0}>Any rating</option>
          {[1,2,3,4,5].map(n => <option key={n} value={n}>{n}+ stars</option>)}
        </select>
      </div>

      {loading && <div className="text-sm text-gray-500">Loading…</div>}
      {!loading && leads.length === 0 && (
        <div className="text-sm text-gray-500 italic">No leads match. Scan a badge above to capture your first.</div>
      )}

      <div className="space-y-2">
        {leads.map(l => editing?.ScanID === l.ScanID ? (
          <div key={l.ScanID} className="border border-blue-300 bg-blue-50/30 rounded-lg p-3 space-y-2">
            <div className="grid grid-cols-2 gap-2">
              <input className={inp} value={editing.AttendeeName || ''} placeholder="Name"
                onChange={e => setEditing({ ...editing, AttendeeName: e.target.value })} />
              <input className={inp} value={editing.AttendeeBusiness || ''} placeholder="Business"
                onChange={e => setEditing({ ...editing, AttendeeBusiness: e.target.value })} />
              <input className={inp} value={editing.AttendeeEmail || ''} placeholder="Email"
                onChange={e => setEditing({ ...editing, AttendeeEmail: e.target.value })} />
              <input className={inp} value={editing.AttendeePhone || ''} placeholder="Phone"
                onChange={e => setEditing({ ...editing, AttendeePhone: e.target.value })} />
              <input className={inp} value={editing.Interest || ''} placeholder="Interest"
                onChange={e => setEditing({ ...editing, Interest: e.target.value })} />
              <select className={inp} value={editing.FollowUpStatus || 'new'}
                onChange={e => setEditing({ ...editing, FollowUpStatus: e.target.value })}>
                {STATUS_OPTIONS.map(o => <option key={o.key} value={o.key}>{o.label}</option>)}
              </select>
            </div>
            <div className="flex items-center gap-3">
              <span className="text-xs text-gray-500">Rating:</span>
              <StarPicker value={editing.Rating} onChange={v => setEditing({ ...editing, Rating: v })} size="sm" />
            </div>
            <textarea className={inp} rows={2} value={editing.Notes || ''} placeholder="Notes"
              onChange={e => setEditing({ ...editing, Notes: e.target.value })} />
            <div className="flex justify-end gap-2">
              <button onClick={() => setEditing(null)} className={btnGhost}>Cancel</button>
              <button onClick={() => saveEdit(editing)} className={btn}>Save</button>
            </div>
          </div>
        ) : (
          <div key={l.ScanID} className="border border-gray-200 rounded-lg p-3 hover:bg-gray-50">
            <div className="flex items-start justify-between gap-3">
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 flex-wrap">
                  <strong className="text-sm">{l.AttendeeName || '(unnamed)'}</strong>
                  {l.AttendeeBusiness && <span className="text-xs text-gray-500">— {l.AttendeeBusiness}</span>}
                  <StatusBadge value={l.FollowUpStatus} />
                  {l.Rating > 0 && <StarPicker value={l.Rating} onChange={() => {}} size="sm" />}
                </div>
                <div className="text-[11px] text-gray-400 mt-0.5 flex flex-wrap gap-x-3">
                  {l.AttendeeEmail && <span>{l.AttendeeEmail}</span>}
                  {l.AttendeePhone && <span>{l.AttendeePhone}</span>}
                  {l.Interest && <span>Interest: {l.Interest}</span>}
                  {l.BadgeCode && <span>Badge: {l.BadgeCode}</span>}
                  <span>{new Date(l.ScanDate).toLocaleString('en-US', { month: 'short', day: 'numeric', hour: 'numeric', minute: '2-digit' })}</span>
                </div>
                {l.Notes && <div className="text-xs text-gray-700 mt-1">{l.Notes}</div>}
              </div>
              <div className="flex gap-2 shrink-0">
                <button onClick={() => setEditing(l)} className={btnGhost}>Edit</button>
                <button onClick={() => del(l.ScanID)} className="text-xs text-red-600 hover:underline">Delete</button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─── Page ──────────────────────────────────────────────────────────────────
export default function EventLeadRetrieval() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const accountCtx = useAccount() || {};
  const businessId = params.get('BusinessID') || accountCtx.BusinessID;
  const peopleId = localStorage.getItem('people_id') || localStorage.getItem('PeopleID');
  const [event, setEvent] = useState(null);
  const [refreshKey, setRefreshKey] = useState(0);
  const [online, setOnline] = useState(typeof navigator !== 'undefined' ? navigator.onLine : true);
  const [flushing, setFlushing] = useState(false);
  const [flushMsg, setFlushMsg] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.ok ? r.json() : null).then(setEvent);
  }, [eventId]);

  useEffect(() => onConnectivityChange(setOnline), []);

  const retryQueued = async () => {
    setFlushing(true); setFlushMsg('');
    const r = await flushQueue();
    setFlushing(false);
    setFlushMsg(`Drained: ${r.ok || 0} sent, ${r.failed || 0} failed.`);
    setRefreshKey(k => k + 1);
  };

  if (!businessId) {
    return (
      <div className="min-h-screen bg-[#FAF7EE] py-10 px-4">
        <div className="max-w-xl mx-auto bg-white rounded-xl shadow p-6 text-center">
          <h1 className="text-lg font-semibold text-gray-800 mb-2">Lead retrieval</h1>
          <p className="text-sm text-gray-600">
            This page is for event exhibitors. Add <code>?BusinessID=…</code> to the URL or sign in with a business account.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#FAF7EE] py-8 px-4">
      <div className="max-w-3xl mx-auto space-y-5">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">Lead Retrieval</h1>
            <div className="text-sm text-gray-500">
              {event?.EventName || 'Event'} · Business #{businessId}
            </div>
          </div>
          <Link to={`/events/${eventId}`} className={btnGhost}>← Event detail</Link>
        </div>

        {/* Connectivity + retry banner */}
        <div className={`rounded-lg border p-2 text-xs flex items-center justify-between ${online ? 'bg-emerald-50 border-emerald-200 text-emerald-800' : 'bg-amber-50 border-amber-200 text-amber-900'}`}>
          <span>{online ? '● Online — scans send instantly.' : '⚠ Offline — scans are queued and will sync when you reconnect.'}</span>
          <div className="flex items-center gap-2">
            {flushMsg && <span className="text-gray-600">{flushMsg}</span>}
            <button onClick={retryQueued} disabled={flushing} className="text-xs underline hover:no-underline disabled:opacity-50">
              {flushing ? 'Retrying…' : 'Retry pending'}
            </button>
          </div>
        </div>

        <CaptureForm
          eventId={eventId}
          businessId={businessId}
          peopleId={peopleId}
          onSaved={() => setRefreshKey(k => k + 1)}
        />

        <LeadsList
          eventId={eventId}
          businessId={businessId}
          refreshKey={refreshKey}
          onChanged={() => setRefreshKey(k => k + 1)}
        />
      </div>
    </div>
  );
}
