import React, { useEffect, useMemo, useState } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import EventAdminMenu, { EVENT_MENU_WIDTH_EXPANDED, EVENT_MENU_WIDTH_COLLAPSED } from './EventAdminMenu';

const API = import.meta.env.VITE_API_URL || '';

const fmtMoney = (n) => `$${(Number(n) || 0).toFixed(2)}`;
const fmtDate  = (d) => d ? new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : '';
const fmtDateTime = (d) => d ? new Date(d).toLocaleString('en-US', { month: 'short', day: 'numeric', hour: 'numeric', minute: '2-digit' }) : '';

// Matches the event-type → admin-module map in EventDetail.jsx / EventsManage.jsx.
function typeAdminModule(evType) {
  if (!evType) return null;
  if (evType === 'Alpaca Cottage Industry Fleece Show') return { path: 'admin/fiber-arts', label: 'Fiber Arts Admin' };
  if (['Halter Show', 'Basic Animal or Fleece Show', 'Spin-Off'].includes(evType))
    return { path: 'admin/halter', label: `${evType} Admin` };
  if (evType === 'Auction')              return { path: 'admin/auction',      label: 'Auction Admin' };
  if (evType === 'Market/Vendor Fair')   return { path: 'admin/vendor-fair',  label: 'Vendor Fair Admin' };
  if (evType === 'Dining Event')         return { path: 'admin/dining',       label: 'Dining Admin' };
  if (evType === 'Farm Tour/Open House') return { path: 'admin/tour',         label: 'Farm Tour Admin' };
  if (evType === 'Conference')           return { path: 'admin/conference',   label: 'Conference Admin' };
  if (evType === 'Competition/Judging')  return { path: 'admin/competition',  label: 'Competition Admin' };
  if (['Seminar', 'Free Event', 'Basic Event', 'Workshop/Clinic', 'Webinar/Online Class', 'Networking Event'].includes(evType))
    return { path: 'admin/simple', label: `${evType} Admin` };
  return null;
}

function Stat({ label, value, hint, tone }) {
  const toneCls = {
    green:  'text-[#3D6B34]',
    indigo: 'text-indigo-700',
    amber:  'text-amber-700',
    slate:  'text-gray-800',
  }[tone || 'slate'];
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 shadow-sm">
      <div className="text-[11px] uppercase tracking-wide text-gray-500">{label}</div>
      <div className={`text-2xl font-bold mt-1 ${toneCls}`}>{value}</div>
      {hint && <div className="text-xs text-gray-500 mt-1">{hint}</div>}
    </div>
  );
}

function ActionTile({ to, href, icon, label, color }) {
  const cls = `flex items-center gap-3 px-4 py-3 rounded-xl border ${color} no-underline transition-colors`;
  const inner = (
    <>
      <span className="text-lg">{icon}</span>
      <span className="text-sm font-semibold">{label}</span>
    </>
  );
  if (href) return <a href={href} className={cls}>{inner}</a>;
  return <Link to={to} className={cls}>{inner}</Link>;
}

function StatusBadge({ status, paid }) {
  const s = (status || '').toLowerCase();
  const p = (paid || '').toLowerCase();
  let cls = 'bg-gray-100 text-gray-600';
  if (s === 'cancelled') cls = 'bg-red-100 text-red-700';
  else if (s === 'confirmed' || s === 'registered') cls = 'bg-green-100 text-green-700';
  else if (s === 'waitlist') cls = 'bg-amber-100 text-amber-700';
  else if (s === 'disqualified') cls = 'bg-red-100 text-red-700';
  return (
    <div className="flex gap-1 flex-wrap">
      {status && <span className={`text-[10px] font-semibold px-2 py-0.5 rounded-full ${cls}`}>{status}</span>}
      {paid && (
        <span className={`text-[10px] font-semibold px-2 py-0.5 rounded-full ${
          p === 'paid' ? 'bg-green-100 text-green-700'
          : p === 'refunded' ? 'bg-gray-100 text-gray-500'
          : 'bg-amber-100 text-amber-700'
        }`}>{paid}</span>
      )}
    </div>
  );
}

export default function EventAdminDashboard() {
  const { eventId } = useParams();
  const navigate = useNavigate();
  const acct = useAccount() || {};
  const myBusinesses = acct.businesses || [];

  const [ev, setEv] = useState(null);
  const [analytics, setAnalytics] = useState(null);
  const [attendees, setAttendees] = useState([]);
  const [loading, setLoading] = useState(true);
  const [menuExpanded, setMenuExpanded] = useState(() =>
    localStorage.getItem('event_admin_menu_expanded') !== 'false'
  );
  useEffect(() => {
    localStorage.setItem('event_admin_menu_expanded', String(menuExpanded));
  }, [menuExpanded]);
  const menuWidth = menuExpanded ? EVENT_MENU_WIDTH_EXPANDED : EVENT_MENU_WIDTH_COLLAPSED;

  useEffect(() => {
    setLoading(true);
    Promise.all([
      fetch(`${API}/api/events/${eventId}`).then(r => r.ok ? r.json() : null),
      fetch(`${API}/api/events/${eventId}/analytics`).then(r => r.ok ? r.json() : null),
      fetch(`${API}/api/events/${eventId}/attendees`).then(r => r.ok ? r.json() : []),
    ]).then(([e, a, at]) => {
      setEv(e); setAnalytics(a); setAttendees(Array.isArray(at) ? at : []); setLoading(false);
    }).catch(() => setLoading(false));
  }, [eventId]);

  const isAdmin = useMemo(() => {
    if (!ev) return false;
    return !!myBusinesses.find(b => Number(b.BusinessID) === Number(ev.BusinessID));
  }, [ev, myBusinesses]);

  const adminBizQs = ev?.BusinessID ? `?BusinessID=${ev.BusinessID}` : '';
  const typeModule = typeAdminModule(ev?.EventType);

  if (loading) return <AccountLayout><div className="p-8 text-gray-500">Loading dashboard…</div></AccountLayout>;
  if (!ev)     return <AccountLayout><div className="p-8 text-gray-500">Event not found.</div></AccountLayout>;

  if (myBusinesses.length > 0 && !isAdmin) {
    return (
      <AccountLayout>
        <div className="p-8 text-gray-600">
          You don't have organizer access to this event.
          <div className="mt-3"><Link to={`/events/${eventId}`} className="text-[#3D6B34] hover:underline">View public page →</Link></div>
        </div>
      </AccountLayout>
    );
  }

  const locationLine = [ev.EventLocationCity, ev.EventLocationState].filter(Boolean).join(', ');
  const dateRange = ev.EventStartDate
    ? (ev.EventEndDate && ev.EventEndDate !== ev.EventStartDate
        ? `${fmtDate(ev.EventStartDate)} – ${fmtDate(ev.EventEndDate)}`
        : fmtDate(ev.EventStartDate))
    : 'Date TBD';

  const byKind = Object.entries(analytics?.byKind || {});
  const recent = attendees.slice(0, 10);

  return (
    <AccountLayout>
      <EventAdminMenu
        eventId={eventId}
        eventType={ev.EventType}
        businessId={ev.BusinessID}
        menuExpanded={menuExpanded}
        setMenuExpanded={setMenuExpanded}
      />
      <div
        className="transition-all duration-300 space-y-6"
        style={{ marginLeft: menuWidth }}
      >

        {/* Header */}
        <div className="flex items-start justify-between flex-wrap gap-3">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${ev.IsPublished ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                {ev.IsPublished ? 'Published' : 'Draft'}
              </span>
              {ev.EventType && <span className="text-xs bg-gray-100 text-gray-600 px-2 py-0.5 rounded-full">{ev.EventType}</span>}
            </div>
            <h1 className="text-2xl font-bold text-gray-800">{ev.EventName}</h1>
            <div className="text-sm text-gray-500 mt-1">
              {dateRange}{locationLine ? ` · ${locationLine}` : ''}
            </div>
          </div>
          <div className="flex gap-2">
            <Link to={`/events/${eventId}`} target="_blank"
              className="text-sm border border-gray-200 text-gray-600 px-3 py-2 rounded-lg hover:bg-gray-50 no-underline">
              Public page ↗
            </Link>
            <Link to={`/account/events?edit=${eventId}`}
              className="text-sm border border-blue-200 text-blue-700 px-3 py-2 rounded-lg hover:bg-blue-50 no-underline">
              ✏️ Edit event
            </Link>
          </div>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-2 md:grid-cols-5 gap-3">
          <Stat label="Registrations" value={analytics?.totalRegistrations ?? 0} tone="indigo" />
          <Stat label="Total attendees" value={analytics?.totalAttendees ?? 0} hint="incl. party size" />
          <Stat label="Checked in" value={analytics?.checkedIn ?? 0}
            hint={`${Math.round(((analytics?.checkInRate) || 0) * 100)}% of regs`} tone="green" />
          <Stat label="Revenue (all)" value={fmtMoney(analytics?.revenue)} />
          <Stat label="Revenue (paid)" value={fmtMoney(analytics?.paidRevenue)} tone="green" />
        </div>

        {/* Quick actions */}
        <div>
          <h2 className="font-bold text-gray-700 mb-2">Quick actions</h2>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
            {typeModule && (
              <ActionTile to={`/events/${eventId}/${typeModule.path}${adminBizQs}`}
                icon="🛠️" label={typeModule.label}
                color="border-purple-200 bg-purple-50 text-purple-700 hover:bg-purple-100" />
            )}
            <ActionTile to={`/events/${eventId}/checkin`} icon="✅" label="Check-in"
              color="border-emerald-200 bg-white text-emerald-700 hover:bg-emerald-50" />
            <ActionTile to={`/events/${eventId}/broadcast`} icon="📣" label="Broadcast email"
              color="border-amber-200 bg-white text-amber-700 hover:bg-amber-50" />
            <ActionTile to={`/events/${eventId}/analytics`} icon="📊" label="Analytics"
              color="border-indigo-200 bg-white text-indigo-700 hover:bg-indigo-50" />
            <ActionTile href={`${API}/api/events/${eventId}/attendees.csv`} icon="⬇️" label="Attendees CSV"
              color="border-gray-200 bg-white text-gray-700 hover:bg-gray-50" />
            <ActionTile href={`${API}/api/events/${eventId}/calendar.ics`} icon="📅" label="Export .ics"
              color="border-gray-200 bg-white text-gray-700 hover:bg-gray-50" />
            <ActionTile to={`/events/${eventId}/certificate`} icon="🏅" label="Certificates"
              color="border-yellow-200 bg-white text-yellow-700 hover:bg-yellow-50" />
          </div>
        </div>

        {/* Registration breakdown + recent registrations */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
          <div className="lg:col-span-1 bg-white border border-gray-200 rounded-xl p-5">
            <h3 className="font-bold text-gray-700 mb-3">Registrations by type</h3>
            {byKind.length === 0 ? (
              <p className="text-sm text-gray-500">No registrations yet.</p>
            ) : (
              <div className="space-y-2">
                {byKind.map(([k, b]) => (
                  <div key={k} className="flex items-center justify-between text-sm border-b border-gray-100 last:border-b-0 py-2">
                    <div>
                      <div className="font-medium text-gray-800">{k}</div>
                      <div className="text-xs text-gray-500">{b.attendees} attendees · {b.checkedIn} in</div>
                    </div>
                    <div className="text-right">
                      <div className="font-semibold text-gray-800">{b.count}</div>
                      <div className="text-xs text-gray-500">{fmtMoney(b.revenue)}</div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>

          <div className="lg:col-span-2 bg-white border border-gray-200 rounded-xl">
            <div className="p-5 pb-3 flex items-center justify-between">
              <h3 className="font-bold text-gray-700">Recent registrations</h3>
              <a href={`${API}/api/events/${eventId}/attendees.csv`}
                 className="text-xs text-[#3D6B34] hover:underline">Export all (CSV)</a>
            </div>
            {recent.length === 0 ? (
              <p className="p-5 pt-0 text-sm text-gray-500">Nobody's registered yet — share your event page.</p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead className="bg-gray-50 text-gray-600">
                    <tr>
                      <th className="text-left py-2 px-3">Name</th>
                      <th className="text-left py-2 px-3">Kind</th>
                      <th className="text-left py-2 px-3">Status</th>
                      <th className="text-right py-2 px-3">Fee</th>
                      <th className="text-right py-2 px-3">When</th>
                    </tr>
                  </thead>
                  <tbody>
                    {recent.map(r => (
                      <tr key={`${r.Kind}-${r.RegID}`} className="border-t border-gray-100">
                        <td className="py-2 px-3">
                          <div className="font-medium text-gray-800">{r.AttendeeName || '—'}</div>
                          <div className="text-xs text-gray-500">{r.AttendeeEmail || ''}</div>
                        </td>
                        <td className="py-2 px-3 text-gray-600">{r.Kind}</td>
                        <td className="py-2 px-3"><StatusBadge status={r.Status} paid={r.PaidStatus} /></td>
                        <td className="py-2 px-3 text-right">{r.TotalFee != null ? fmtMoney(r.TotalFee) : '—'}</td>
                        <td className="py-2 px-3 text-right text-xs text-gray-500">{fmtDateTime(r.CreatedAt)}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>

      </div>
    </AccountLayout>
  );
}
