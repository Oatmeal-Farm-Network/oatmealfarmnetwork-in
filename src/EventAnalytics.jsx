import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import EventAdminLayout from './EventAdminLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

const fmtMoney = (n) => `$${(Number(n) || 0).toFixed(2)}`;
const fmtPct = (n) => `${Math.round((Number(n) || 0) * 100)}%`;

function StatCard({ label, value, hint }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 shadow-sm">
      <div className="text-[11px] uppercase tracking-wide text-gray-500">{label}</div>
      <div className="text-2xl font-bold text-gray-800 mt-1">{value}</div>
      {hint && <div className="text-xs text-gray-500 mt-1">{hint}</div>}
    </div>
  );
}

// ── Per-event view ──────────────────────────────────────────────────────────
function EventView({ eventId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [err, setErr] = useState('');

  useEffect(() => {
    setLoading(true);
    fetch(`${API}/api/events/${eventId}/analytics`)
      .then(r => r.ok ? r.json() : Promise.reject(`HTTP ${r.status}`))
      .then(d => { setData(d); setLoading(false); })
      .catch(e => { setErr(String(e)); setLoading(false); });
  }, [eventId]);

  if (loading) return <div className="p-6 text-gray-500">Loading analytics…</div>;
  if (err)     return <div className="p-6 text-red-600">Failed to load: {err}</div>;
  if (!data)   return null;

  const kinds = Object.entries(data.byKind || {});

  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between flex-wrap gap-3">
        <div>
          <h1 className="text-xl font-bold text-gray-800">{data.EventName}</h1>
          <div className="text-sm text-gray-500">
            {data.EventType} · {data.EventStartDate || ''}
          </div>
        </div>
        <div className="flex gap-2">
          <a
            href={`${API}/api/events/${eventId}/attendees.csv`}
            className="px-3 py-2 text-sm rounded-lg bg-[#819360] text-white hover:bg-[#6d7e52]"
          >
            Export attendees CSV
          </a>
          <Link
            to={`/events/${eventId}/checkin`}
            className="px-3 py-2 text-sm rounded-lg bg-emerald-600 text-white hover:bg-emerald-700"
          >
            Check-in
          </Link>
          <Link
            to={`/events/${eventId}/broadcast`}
            className="px-3 py-2 text-sm rounded-lg bg-amber-600 text-white hover:bg-amber-700"
          >
            Broadcast
          </Link>
        </div>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-5 gap-3">
        <StatCard label="Registrations" value={data.totalRegistrations} />
        <StatCard label="Total attendees" value={data.totalAttendees} hint="incl. party size" />
        <StatCard label="Checked in" value={data.checkedIn} hint={fmtPct(data.checkInRate) + ' of regs'} />
        <StatCard label="Revenue (all)" value={fmtMoney(data.revenue)} />
        <StatCard label="Revenue (paid)" value={fmtMoney(data.paidRevenue)} />
      </div>

      {kinds.length > 0 && (
        <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 text-gray-600">
              <tr>
                <th className="text-left py-2 px-3">Type</th>
                <th className="text-right py-2 px-3">Regs</th>
                <th className="text-right py-2 px-3">Attendees</th>
                <th className="text-right py-2 px-3">Checked in</th>
                <th className="text-right py-2 px-3">Revenue</th>
              </tr>
            </thead>
            <tbody>
              {kinds.map(([k, b]) => (
                <tr key={k} className="border-t border-gray-100">
                  <td className="py-2 px-3">{k}</td>
                  <td className="py-2 px-3 text-right">{b.count}</td>
                  <td className="py-2 px-3 text-right">{b.attendees}</td>
                  <td className="py-2 px-3 text-right">{b.checkedIn}</td>
                  <td className="py-2 px-3 text-right">{fmtMoney(b.revenue)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

// ── Organizer rollup view ───────────────────────────────────────────────────
function OrganizerView({ businessId }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    fetch(`${API}/api/businesses/${businessId}/events/analytics`)
      .then(r => r.ok ? r.json() : Promise.reject(`HTTP ${r.status}`))
      .then(d => { setData(d); setLoading(false); })
      .catch(() => setLoading(false));
  }, [businessId]);

  if (loading) return <div className="p-6 text-gray-500">Loading analytics…</div>;
  if (!data)   return <div className="p-6 text-gray-500">No data.</div>;

  const t = data.totals || {};
  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-xl font-bold text-gray-800">Events Analytics</h1>
        <div className="text-sm text-gray-500">Rollup across {t.eventCount || 0} events</div>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-5 gap-3">
        <StatCard label="Events" value={t.eventCount || 0} />
        <StatCard label="Registrations" value={t.totalRegistrations || 0} />
        <StatCard label="Attendees" value={t.totalAttendees || 0} />
        <StatCard label="Revenue (all)" value={fmtMoney(t.revenue)} />
        <StatCard label="Revenue (paid)" value={fmtMoney(t.paidRevenue)} />
      </div>

      <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 text-gray-600">
            <tr>
              <th className="text-left py-2 px-3">Event</th>
              <th className="text-left py-2 px-3">Date</th>
              <th className="text-right py-2 px-3">Regs</th>
              <th className="text-right py-2 px-3">Attendees</th>
              <th className="text-right py-2 px-3">Checked in</th>
              <th className="text-right py-2 px-3">Revenue</th>
              <th className="text-right py-2 px-3"></th>
            </tr>
          </thead>
          <tbody>
            {(data.events || []).map(e => (
              <tr key={e.EventID} className="border-t border-gray-100">
                <td className="py-2 px-3">
                  <Link to={`/events/${e.EventID}/analytics`} className="text-[#819360] hover:underline">
                    {e.EventName}
                  </Link>
                </td>
                <td className="py-2 px-3 text-gray-600">{e.EventStartDate || ''}</td>
                <td className="py-2 px-3 text-right">{e.totalRegistrations || 0}</td>
                <td className="py-2 px-3 text-right">{e.totalAttendees || 0}</td>
                <td className="py-2 px-3 text-right">{e.checkedIn || 0}</td>
                <td className="py-2 px-3 text-right">{fmtMoney(e.revenue)}</td>
                <td className="py-2 px-3 text-right">
                  <a
                    href={`${API}/api/events/${e.EventID}/attendees.csv`}
                    className="text-xs text-[#819360] hover:underline"
                  >
                    CSV
                  </a>
                </td>
              </tr>
            ))}
            {!(data.events || []).length && (
              <tr><td colSpan="7" className="py-4 px-3 text-center text-gray-500">No events yet.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default function EventAnalytics() {
  const { eventId } = useParams();
  const { account } = useAccount() || {};
  const businessId = account?.BusinessID || localStorage.getItem('business_id');

  const Wrapper = eventId ? EventAdminLayout : AccountLayout;
  const wrapperProps = eventId ? { eventId } : {};

  return (
    <Wrapper {...wrapperProps}>
      <div className="max-w-6xl mx-auto px-4 py-6">
        {eventId
          ? <EventView eventId={eventId} />
          : (businessId
              ? <OrganizerView businessId={businessId} />
              : <div className="p-6 text-gray-500">Sign in as an organizer to see analytics.</div>)
        }
      </div>
    </Wrapper>
  );
}
