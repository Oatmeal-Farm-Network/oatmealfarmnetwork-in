import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';

const API = import.meta.env.VITE_API_URL || '';

function authHeaders() {
  const t = localStorage.getItem('access_token');
  return t ? { Authorization: `Bearer ${t}` } : {};
}

const statusLabel = {
  draft:              'Draft',
  pending_payment:    'Payment Pending',
  pending_capture:    'Payment Authorized',
  paid:               'Paid',
  refunded:           'Refunded',
  partially_refunded: 'Partially Refunded',
  cancelled:          'Cancelled',
};

export default function EventCartReceipt() {
  const { cartId } = useParams();
  const [cart, setCart] = useState(null);
  const [ev, setEv] = useState(null);
  const [loading, setLoading] = useState(true);
  const [err, setErr] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/cart/${cartId}`, { headers: authHeaders() })
      .then(r => r.ok ? r.json() : Promise.reject('Cart not found'))
      .then(c => {
        setCart(c);
        return fetch(`${API}/api/events/${c.EventID}`).then(r => r.ok ? r.json() : null);
      })
      .then(e => { setEv(e); setLoading(false); })
      .catch(e => { setErr(String(e)); setLoading(false); });
  }, [cartId]);

  if (loading) {
    return <div className="min-h-screen bg-[#FAF7EE] flex items-center justify-center">
      <div className="text-sm text-gray-500">Loading receipt…</div>
    </div>;
  }

  if (err || !cart) {
    return <div className="min-h-screen bg-[#FAF7EE] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow p-6 max-w-md text-center">
        <div className="text-lg font-semibold text-red-600 mb-2">Receipt unavailable</div>
        <p className="text-sm text-gray-600">{err || 'Could not load this receipt.'}</p>
        <Link to="/my-registrations" className="inline-block mt-4 text-sm text-[#3D6B34] hover:underline">
          Back to My Registrations
        </Link>
      </div>
    </div>;
  }

  const eventAddr = ev ? [
    ev.EventLocationName, ev.EventLocationStreet, ev.EventLocationCity,
    ev.EventLocationState, ev.EventLocationZip,
  ].filter(Boolean).join(', ') : '';

  const fmtDate = d => d ? new Date(d).toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' }) : '—';

  const paidDate = cart.PaidDate ? new Date(cart.PaidDate).toLocaleString() : '—';
  const refunded = Number(cart.AmountRefunded || 0);

  return (
    <div className="min-h-screen bg-[#FAF7EE] py-8 px-4 print:bg-white print:py-0">
      <style>{`
        @media print {
          .no-print { display: none !important; }
          body { background: white; }
        }
      `}</style>
      <div className="max-w-2xl mx-auto">
        <div className="flex justify-between items-center mb-4 no-print">
          <Link to="/my-registrations" className="text-sm text-[#3D6B34] hover:underline">← Back</Link>
          <button
            onClick={() => window.print()}
            className="px-4 py-2 bg-[#3D6B34] text-white rounded-lg text-sm hover:bg-[#2f5226]"
          >
            🖨️ Print Receipt
          </button>
        </div>

        <div className="bg-white rounded-xl shadow-sm overflow-hidden print:shadow-none print:rounded-none">
          <div className="bg-[#3D6B34] text-white px-6 py-5 print:bg-gray-100 print:text-gray-900 print:border-b-4 print:border-[#3D6B34]">
            <div className="text-[10px] uppercase tracking-[0.15em] opacity-80">Payment Receipt</div>
            <div className="text-2xl font-semibold mt-1">{ev?.EventName || 'Event'}</div>
            <div className="text-xs opacity-80 mt-1">
              Order #{cart.CartID} · {statusLabel[cart.Status] || cart.Status}
            </div>
          </div>

          <div className="px-6 py-5 border-b border-gray-100">
            <div className="grid grid-cols-2 gap-4 text-sm">
              <div>
                <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Attendee</div>
                <div className="mt-1 font-medium text-gray-800">
                  {cart.AttendeeFirstName} {cart.AttendeeLastName}
                </div>
                <div className="text-xs text-gray-600">{cart.AttendeeEmail}</div>
                {cart.AttendeePhone && <div className="text-xs text-gray-600">{cart.AttendeePhone}</div>}
              </div>
              <div>
                <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Event</div>
                <div className="mt-1 text-gray-800">{fmtDate(ev?.EventStartDate)}</div>
                {eventAddr && <div className="text-xs text-gray-600 mt-1">{eventAddr}</div>}
              </div>
            </div>
          </div>

          <div className="px-6 py-5">
            <div className="text-xs uppercase tracking-wide text-gray-500 font-semibold mb-2">Line Items</div>
            {(!cart.items || cart.items.length === 0) ? (
              <div className="text-sm text-gray-500 italic py-3">No line items.</div>
            ) : (
              <table className="w-full text-sm">
                <thead>
                  <tr className="text-[10px] uppercase text-gray-500 border-b">
                    <th className="text-left py-1.5 font-semibold">Item</th>
                    <th className="text-right py-1.5 font-semibold">Qty</th>
                    <th className="text-right py-1.5 font-semibold">Unit</th>
                    <th className="text-right py-1.5 font-semibold">Line</th>
                  </tr>
                </thead>
                <tbody>
                  {cart.items.map(it => (
                    <tr key={it.LineID} className="border-b border-gray-100">
                      <td className="py-2 text-gray-800">
                        <div>{it.Label}</div>
                        <div className="text-[10px] text-gray-400 uppercase">{it.FeatureKey}</div>
                      </td>
                      <td className="py-2 text-right text-gray-700">{it.Quantity}</td>
                      <td className="py-2 text-right text-gray-700">${Number(it.UnitAmount || 0).toFixed(2)}</td>
                      <td className="py-2 text-right text-gray-800 font-medium">${Number(it.LineAmount || 0).toFixed(2)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            )}

            <div className="mt-4 space-y-1 text-sm">
              <Row label="Subtotal" value={`$${Number(cart.Subtotal || 0).toFixed(2)}`} />
              <Row label="Platform Fee" value={`$${Number(cart.PlatformFeeAmount || 0).toFixed(2)}`} />
              <div className="border-t border-gray-300 my-2" />
              <Row label="Total" value={`$${Number(cart.Total || 0).toFixed(2)}`} bold />
              <Row label="Paid" value={`$${Number(cart.AmountPaid || 0).toFixed(2)}`} />
              {refunded > 0 && <Row label="Refunded" value={`-$${refunded.toFixed(2)}`} tone="red" />}
            </div>
          </div>

          <div className="px-6 py-4 bg-gray-50 border-t text-xs text-gray-600 space-y-1">
            <div><strong>Payment date:</strong> {paidDate}</div>
            {cart.StripePaymentIntentID && (
              <div className="font-mono text-[10px] text-gray-400">
                Stripe ref: {cart.StripePaymentIntentID}
              </div>
            )}
          </div>
        </div>

        <div className="text-center text-xs text-gray-500 mt-6 no-print">
          Need help? Reply to your confirmation email or visit
          {' '}<Link to="/my-registrations" className="text-[#3D6B34] hover:underline">My Registrations</Link>.
        </div>
      </div>
    </div>
  );
}

function Row({ label, value, bold, tone }) {
  return (
    <div className={`flex justify-between ${bold ? 'font-bold text-gray-900 text-base' : 'text-gray-700'} ${tone === 'red' ? 'text-red-700' : ''}`}>
      <span>{label}</span>
      <span>{value}</span>
    </div>
  );
}
