import React, { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';

const API = import.meta.env.VITE_API_URL || '';

const KIND_COLORS = {
  Conference: 'bg-blue-100 text-blue-700',
  'Competition Entry': 'bg-amber-100 text-amber-700',
  Dining: 'bg-rose-100 text-rose-700',
  Tour: 'bg-emerald-100 text-emerald-700',
  Simple: 'bg-gray-100 text-gray-700',
  Event: 'bg-gray-100 text-gray-700',
};

const STATUS_COLORS = {
  Confirmed: 'text-green-700',
  Registered: 'text-green-700',
  Entered: 'text-green-700',
  Waitlisted: 'text-amber-700',
  Cancelled: 'text-red-600',
  Disqualified: 'text-red-600',
};

function fmtDate(iso) {
  if (!iso) return '';
  const dt = new Date(iso);
  if (isNaN(dt)) return String(iso);
  return dt.toLocaleDateString([], { month: 'short', day: 'numeric', year: 'numeric' });
}

const CART_STATUS_COLORS = {
  draft:              'text-gray-500',
  pending_payment:    'text-amber-700',
  pending_capture:    'text-blue-700',
  paid:               'text-green-700',
  refunded:           'text-red-600',
  partially_refunded: 'text-orange-700',
  cancelled:          'text-gray-500',
};

function authHeaders() {
  const t = localStorage.getItem('access_token');
  return t ? { Authorization: `Bearer ${t}` } : {};
}

export default function MyRegistrations() {
  const peopleId = localStorage.getItem('people_id');
  const [rows, setRows] = useState([]);
  const [carts, setCarts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState('upcoming');

  const loadCarts = () => {
    if (!peopleId) return;
    fetch(`${API}/api/people/${peopleId}/event-carts`, { headers: authHeaders() })
      .then(r => r.ok ? r.json() : [])
      .then(d => setCarts(Array.isArray(d) ? d : []))
      .catch(() => setCarts([]));
  };

  useEffect(() => {
    if (!peopleId) { setLoading(false); return; }
    fetch(`${API}/api/people/${peopleId}/event-registrations`)
      .then(r => r.json())
      .then(d => setRows(Array.isArray(d) ? d : []))
      .catch(() => setRows([]))
      .finally(() => setLoading(false));
    loadCarts();
  }, [peopleId]);

  const requestCartRefund = async (cart) => {
    if (!confirm(`Request a refund for "${cart.EventName}"? (${cart.Status === 'pending_capture' ? 'pre-auth will be cancelled' : 'full refund'})`)) return;
    try {
      const res = await fetch(`${API}/api/events/cart/${cart.CartID}/refund`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', ...authHeaders() },
        body: JSON.stringify({}),
      });
      if (!res.ok) {
        const t = await res.text();
        alert(`Refund failed: ${t}`);
        return;
      }
      loadCarts();
    } catch (e) {
      alert(`Refund failed: ${e.message || e}`);
    }
  };

  const cancel = async (r, refund = false) => {
    const msg = refund
      ? `Cancel "${r.EventName}" and request a refund?`
      : `Cancel your registration for "${r.EventName}"?`;
    if (!confirm(msg)) return;
    const res = await fetch(`${API}/api/events/registrations/cancel`, {
      method: 'POST', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ kind: r.RegistrationKind === 'Competition Entry' ? 'Competition' : r.RegistrationKind, reg_id: r.RegID, refund }),
    });
    if (res.ok) {
      setRows(rs => rs.map(x =>
        (x.RegID === r.RegID && x.RegistrationKind === r.RegistrationKind)
          ? { ...x, Status: 'cancelled', PaidStatus: refund ? 'refunded' : x.PaidStatus }
          : x));
    } else {
      alert('Cancel failed');
    }
  };

  const { upcoming, past } = useMemo(() => {
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const up = [], pa = [];
    for (const r of rows) {
      const d = r.EventStartDate ? new Date(r.EventStartDate) : null;
      if (d && d >= today) up.push(r); else pa.push(r);
    }
    return { upcoming: up, past: pa };
  }, [rows]);

  const visible = filter === 'upcoming' ? upcoming : filter === 'past' ? past : rows;

  if (!peopleId) {
    return (
      <div className="min-h-screen bg-[#FAF7EE] flex items-center justify-center p-4">
        <div className="bg-white rounded-xl shadow p-6 max-w-md text-center">
          <div className="text-lg font-semibold text-[#3D6B34] mb-2">Sign in required</div>
          <p className="text-sm text-gray-600">Log in to see the events you've registered for.</p>
          <Link to="/login" className="inline-block mt-4 text-sm text-[#3D6B34] hover:underline">Go to login</Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#FAF7EE] py-8 px-4">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-3xl font-semibold text-[#3D6B34] mb-1">My Registrations</h1>
        <p className="text-sm text-gray-500 mb-6">Everything you've signed up for across all events.</p>

        {carts.length > 0 && (
          <div className="mb-6">
            <div className="text-xs uppercase tracking-wide text-gray-500 mb-2 font-medium">Event Carts & Payments</div>
            <div className="bg-white rounded-xl shadow divide-y divide-gray-100">
              {carts.map(c => {
                const canRefund = c.Status === 'paid' || c.Status === 'pending_capture' || c.Status === 'partially_refunded';
                const hasReceipt = ['paid', 'pending_capture', 'refunded', 'partially_refunded'].includes(c.Status);
                return (
                  <div key={c.CartID} className="p-4 flex items-start justify-between gap-3">
                    <Link to={`/events/${c.EventID}`} className="min-w-0 flex-1 block no-underline">
                      <div className="font-medium text-gray-800 truncate">{c.EventName || `Event #${c.EventID}`}</div>
                      <div className="text-xs text-gray-500 mt-0.5">
                        {fmtDate(c.EventStartDate)} · {c.ItemCount} item{c.ItemCount === 1 ? '' : 's'}
                      </div>
                    </Link>
                    <div className="text-right shrink-0">
                      <div className={`text-xs font-medium ${CART_STATUS_COLORS[c.Status] || 'text-gray-600'}`}>
                        {c.Status}
                      </div>
                      <div className="text-sm text-gray-800 mt-0.5">${Number(c.Total || 0).toFixed(2)}</div>
                      {Number(c.AmountRefunded || 0) > 0 && (
                        <div className="text-xs text-red-600">-${Number(c.AmountRefunded).toFixed(2)} refunded</div>
                      )}
                      <div className="flex gap-2 justify-end mt-1">
                        {hasReceipt && (
                          <Link to={`/events/cart/${c.CartID}/receipt`} className="text-xs text-[#3D6B34] hover:underline">
                            View receipt
                          </Link>
                        )}
                        {canRefund && (
                          <button onClick={() => requestCartRefund(c)} className="text-xs text-amber-600 hover:underline">
                            Request refund
                          </button>
                        )}
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}

        <div className="flex gap-2 mb-4">
          {[
            ['upcoming', `Upcoming (${upcoming.length})`],
            ['past', `Past (${past.length})`],
            ['all', `All (${rows.length})`],
          ].map(([k, label]) => (
            <button key={k} onClick={() => setFilter(k)}
              className={`text-xs px-3 py-1.5 rounded-full border ${filter === k
                ? 'bg-[#3D6B34] text-white border-[#3D6B34]'
                : 'border-gray-300 text-gray-700 bg-white hover:bg-gray-50'}`}>
              {label}
            </button>
          ))}
        </div>

        {loading ? (
          <div className="bg-white rounded-xl shadow p-6 text-sm text-gray-500">Loading…</div>
        ) : visible.length === 0 ? (
          <div className="bg-white rounded-xl shadow p-8 text-center">
            <div className="text-sm text-gray-500 mb-3">
              {filter === 'upcoming' ? 'No upcoming registrations.' :
               filter === 'past' ? 'Nothing in your history yet.' :
               "You haven't registered for any events yet."}
            </div>
            <Link to="/events" className="inline-block text-sm text-[#3D6B34] hover:underline">Browse events →</Link>
          </div>
        ) : (
          <div className="bg-white rounded-xl shadow divide-y divide-gray-100">
            {visible.map(r => {
              const isCancellable = r.Status && !['cancelled', 'Cancelled', 'disqualified', 'Disqualified'].includes(r.Status);
              return (
                <div key={`${r.RegistrationKind}-${r.RegID}`} className="p-4 hover:bg-gray-50 transition">
                  <div className="flex items-start justify-between gap-3">
                    <Link to={`/events/${r.EventID}`} className="min-w-0 flex-1 block no-underline">
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className={`text-[10px] uppercase font-semibold px-2 py-0.5 rounded ${KIND_COLORS[r.RegistrationKind] || 'bg-gray-100 text-gray-700'}`}>
                          {r.RegistrationKind}
                        </span>
                        {r.EventType && (
                          <span className="text-xs text-gray-500">{r.EventType}</span>
                        )}
                      </div>
                      <div className="font-medium text-gray-800 mt-1 truncate">{r.EventName || 'Untitled event'}</div>
                      <div className="text-xs text-gray-500 mt-0.5">
                        {fmtDate(r.EventStartDate)}
                        {r.BusinessName && ` · ${r.BusinessName}`}
                      </div>
                    </Link>
                    <div className="text-right shrink-0">
                      {r.Status && (
                        <div className={`text-xs font-medium ${STATUS_COLORS[r.Status] || 'text-gray-600'}`}>
                          {r.Status}
                        </div>
                      )}
                      {r.TotalFee != null && r.TotalFee > 0 && (
                        <div className="text-xs text-gray-500 mt-0.5">
                          ${Number(r.TotalFee).toFixed(2)}
                          {r.PaidStatus && ` · ${r.PaidStatus}`}
                        </div>
                      )}
                      {r.CheckedIn && (
                        <div className="text-xs text-green-600 mt-0.5">✓ Checked in</div>
                      )}
                      {isCancellable && (
                        <div className="flex gap-2 mt-2 justify-end">
                          <button onClick={() => cancel(r, false)} className="text-xs text-red-600 hover:underline">Cancel</button>
                          {r.PaidStatus === 'paid' && (
                            <button onClick={() => cancel(r, true)} className="text-xs text-amber-600 hover:underline">Cancel + refund</button>
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
