// src/StandingOrderActivityWidget.jsx
// Compact dashboard card showing standing-order activity for one business.
// Used by both farm sellers (role="farm") and restaurant buyers (role="buyer").
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

const API = import.meta.env.VITE_API_URL || '';

const PARTY_LABEL = { farm: 'Buyer', buyer: 'Farm' };

export default function StandingOrderActivityWidget({ businessId, role = 'farm' }) {
  const [data, setData]       = useState(null);
  const [loading, setLoading] = useState(true);
  const [err, setErr]         = useState('');

  useEffect(() => {
    if (!businessId) return;
    let cancelled = false;
    setLoading(true);
    fetch(`${API}/api/marketplace/standing-orders/activity?business_id=${businessId}&role=${role}`)
      .then(r => r.ok ? r.json() : Promise.reject(r.status))
      .then(d => { if (!cancelled) setData(d); })
      .catch(()  => { if (!cancelled) setErr('Could not load activity.'); })
      .finally(() => { if (!cancelled) setLoading(false); });
    return () => { cancelled = true; };
  }, [businessId, role]);

  const ordersPath = role === 'farm' ? '/farm/standing-orders' : '/restaurant/standing-orders';
  const otherLabel = PARTY_LABEL[role];

  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
      <div className="flex items-center justify-between mb-3">
        <h3 className="text-sm font-bold text-gray-800 flex items-center gap-1.5">
          🔁 Standing Order Activity
        </h3>
        <Link to={ordersPath} className="text-xs text-[#3D6B34] hover:underline font-semibold">
          View all →
        </Link>
      </div>

      {loading ? (
        <div className="text-xs text-gray-400 py-3 text-center">Loading…</div>
      ) : err ? (
        <div className="text-xs text-red-500 py-3 text-center">{err}</div>
      ) : !data || data.stats.active === 0 && data.stats.fulfilled_30d === 0 ? (
        <div className="text-xs text-gray-400 py-3 text-center italic">
          No standing orders yet.
        </div>
      ) : (
        <>
          <div className="grid grid-cols-4 gap-2 mb-3">
            <Stat label="Active"     value={data.stats.active} />
            <Stat label="Overdue"    value={data.stats.overdue} accent={data.stats.overdue > 0 ? '#dc2626' : null} />
            <Stat label="Next 7d"    value={data.stats.upcoming_7d} />
            <Stat label="Done (30d)" value={data.stats.fulfilled_30d} />
          </div>

          {data.upcoming.length > 0 && (
            <div className="mb-3">
              <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold mb-1">
                Upcoming
              </div>
              <ul className="space-y-1">
                {data.upcoming.slice(0, 5).map(o => (
                  <UpcomingRow key={o.StandingOrderID} order={o} otherLabel={otherLabel} />
                ))}
              </ul>
            </div>
          )}

          {data.recent.length > 0 && (
            <div>
              <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold mb-1">
                Recent deliveries
              </div>
              <ul className="space-y-1">
                {data.recent.slice(0, 3).map(r => (
                  <RecentRow key={r.FulfillmentID} row={r} otherLabel={otherLabel} />
                ))}
              </ul>
            </div>
          )}
        </>
      )}
    </div>
  );
}

function Stat({ label, value, accent }) {
  return (
    <div className="text-center">
      <div className="text-lg font-bold leading-tight" style={accent ? { color: accent } : undefined}>{value}</div>
      <div className="text-[10px] text-gray-500 uppercase tracking-wide">{label}</div>
    </div>
  );
}

function UpcomingRow({ order: o, otherLabel }) {
  const overdue = o.Status === 'overdue';
  const date = o.NextDeliveryDate
    ? new Date(o.NextDeliveryDate).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })
    : '—';
  const when = overdue
    ? 'Overdue'
    : o.DaysUntil === 0 ? 'Today'
    : o.DaysUntil === 1 ? 'Tomorrow'
    : `${date}`;
  return (
    <li className="flex items-center justify-between text-xs gap-2">
      <span className="truncate flex-grow text-gray-700">
        <span className="font-semibold">{o.ProductTitle || 'Standing order'}</span>
        <span className="text-gray-500"> — {otherLabel}: {o.OtherPartyName || '—'}</span>
      </span>
      <span className={`flex-shrink-0 font-semibold ${overdue ? 'text-red-600' : 'text-[#3D6B34]'}`}>
        {when}
      </span>
    </li>
  );
}

function RecentRow({ row: r, otherLabel }) {
  const date = r.DeliveredAt
    ? new Date(r.DeliveredAt).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })
    : '—';
  return (
    <li className="flex items-center justify-between text-xs gap-2">
      <span className="truncate flex-grow text-gray-700">
        ✅ <span className="font-semibold">{r.ProductTitle || 'Delivered'}</span>
        <span className="text-gray-500"> — {otherLabel}: {r.OtherPartyName || '—'}</span>
      </span>
      <span className="flex-shrink-0 text-gray-500">{date}</span>
    </li>
  );
}
