// src/FarmStandingOrders.jsx
// Farm-side view of incoming recurring orders from restaurants.
// Route: /farm/standing-orders
import React, { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

const FREQUENCY_LABELS = { weekly: 'Weekly', biweekly: 'Every 2 weeks', monthly: 'Monthly' };
const DAY_NAMES = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];

export default function FarmStandingOrders() {
  const { businesses } = useAccount() || {};

  const farmBusinesses = useMemo(() =>
    (Array.isArray(businesses) ? businesses : [])
      .filter(b => b.BusinessTypeID === 8),
    [businesses]
  );

  const [selectedFarmId, setSelectedFarmId] = useState(null);
  useEffect(() => {
    if (!selectedFarmId && farmBusinesses[0]) setSelectedFarmId(farmBusinesses[0].BusinessID);
  }, [farmBusinesses, selectedFarmId]);

  const [orders,  setOrders]  = useState([]);
  const [loading, setLoading] = useState(true);
  const [err,     setErr]     = useState('');

  const load = async () => {
    if (!selectedFarmId) { setLoading(false); return; }
    setLoading(true);
    setErr('');
    try {
      const r = await fetch(`${API}/api/marketplace/standing-orders?farm_business_id=${selectedFarmId}`);
      if (!r.ok) throw new Error(`${r.status}`);
      const data = await r.json();
      setOrders(Array.isArray(data) ? data : []);
    } catch {
      setErr('Could not load incoming orders.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); /* eslint-disable-next-line react-hooks/exhaustive-deps */ }, [selectedFarmId]);

  const markFulfilled = async (order) => {
    const qtyInput = window.prompt(
      `Record delivery of "${order.ProductTitle || 'standing order'}" to ${order.BuyerName || 'the restaurant'}.\nDelivered quantity (${order.UnitLabel || 'unit'}):`,
      String(order.Quantity ?? '')
    );
    if (qtyInput === null) return;
    const qty = parseFloat(qtyInput);
    if (!(qty > 0)) { alert('Please enter a positive quantity.'); return; }
    const notes = window.prompt('Optional notes. Leave blank for none:', '') || null;
    try {
      const r = await fetch(`${API}/api/marketplace/standing-orders/${order.StandingOrderID}/fulfill`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ DeliveredQuantity: qty, Notes: notes }),
      });
      if (!r.ok) throw new Error(`${r.status}`);
      await load();
    } catch {
      alert('Could not record delivery — please try again.');
    }
  };

  const skipNext = async (order) => {
    const next = order.NextDeliveryDate || '(no date set)';
    if (!window.confirm(`Skip the ${next} delivery to ${order.BuyerName || 'the restaurant'}?\nThe restaurant will be notified and the next date rolled forward by one cycle.`)) return;
    const reason = window.prompt('Optional reason (sent to the restaurant). Leave blank for none:', '') || null;
    try {
      const r = await fetch(`${API}/api/marketplace/standing-orders/${order.StandingOrderID}/skip`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ Reason: reason, InitiatedBy: 'farm' }),
      });
      if (!r.ok) throw new Error(`${r.status}`);
      await load();
    } catch {
      alert('Could not skip delivery — please try again.');
    }
  };

  const reschedule = async (order) => {
    const current = order.NextDeliveryDate || '';
    const newDate = window.prompt(
      `Reschedule delivery to ${order.BuyerName || 'the restaurant'}.\nEnter the new delivery date as YYYY-MM-DD:`,
      current
    );
    if (newDate === null) return;
    if (!/^\d{4}-\d{2}-\d{2}$/.test(newDate.trim())) { alert('Please enter a date in YYYY-MM-DD format.'); return; }
    const reason = window.prompt('Optional reason (sent to the restaurant). Leave blank for none:', '') || null;
    try {
      const r = await fetch(`${API}/api/marketplace/standing-orders/${order.StandingOrderID}/reschedule`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ NewDate: newDate.trim(), Reason: reason, InitiatedBy: 'farm' }),
      });
      if (!r.ok) {
        const err = await r.json().catch(() => ({}));
        throw new Error(err.detail || `${r.status}`);
      }
      await load();
    } catch (e) {
      alert(`Could not reschedule: ${e.message}`);
    }
  };

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Incoming Standing Orders | Farm Dashboard"
        description="Recurring orders from restaurants — mark deliveries as fulfilled."
      />
      <Header />

      <div className="mx-auto px-4 pt-4 pb-10" style={{ maxWidth: '1100px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Account', to: '/account' },
          { label: 'Incoming Standing Orders' },
        ]} />

        <div className="mt-4 mb-6 flex flex-wrap items-end justify-between gap-3">
          <div>
            <h1 className="text-2xl font-bold text-gray-900" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
              🚜 Incoming Standing Orders
            </h1>
            <p className="text-sm text-gray-600 mt-1">
              Recurring orders restaurants have set up for your farm. Mark each delivery as fulfilled once it leaves.
            </p>
          </div>
          {farmBusinesses.length > 1 && (
            <select
              value={selectedFarmId || ''}
              onChange={e => setSelectedFarmId(parseInt(e.target.value, 10))}
              className="px-3 py-2 border border-gray-300 rounded-lg text-sm"
            >
              {farmBusinesses.map(b => (
                <option key={b.BusinessID} value={b.BusinessID}>{b.BusinessName}</option>
              ))}
            </select>
          )}
        </div>

        {farmBusinesses.length === 0 ? (
          <EmptyState
            title="No farm business found on your account"
            body="This page shows standing orders for businesses on your account with type 'Farm/Ranch'."
            cta={<Link to="/account" className="text-[#3D6B34] underline font-semibold">Go to account</Link>}
          />
        ) : loading ? (
          <div className="text-center py-16 text-gray-400">Loading…</div>
        ) : err ? (
          <div className="text-center py-16 text-red-500">{err}</div>
        ) : orders.length === 0 ? (
          <EmptyState
            title="No incoming standing orders yet"
            body="When a restaurant sets up a recurring order from your farm, it will appear here."
            cta={null}
          />
        ) : (
          <div className="space-y-3">
            {orders.map(o => (
              <OrderRow
                key={o.StandingOrderID}
                order={o}
                onFulfill={() => markFulfilled(o)}
                onSkip={() => skipNext(o)}
                onReschedule={() => reschedule(o)}
              />
            ))}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}

function OrderRow({ order: o, onFulfill, onSkip, onReschedule }) {
  const status = o.Status || 'active';
  const isOverdue = status === 'overdue';
  const isActive  = status === 'active' || isOverdue;
  const next = o.NextDeliveryDate ? new Date(o.NextDeliveryDate).toLocaleDateString(undefined, { month: 'short', day: 'numeric', year: 'numeric' }) : null;

  return (
    <div
      className="bg-white rounded-xl border p-4 flex flex-wrap items-start gap-4 shadow-sm"
      style={{
        borderColor: isOverdue ? '#dc2626' : '#e5e7eb',
        opacity: isActive ? 1 : 0.65,
      }}
    >
      <div className="flex-grow min-w-0">
        <div className="flex items-center gap-2 mb-1 flex-wrap">
          <h3 className="font-bold text-gray-900 truncate">{o.ProductTitle || `${o.ListingType} #${o.ListingSourceID}`}</h3>
          {isOverdue && <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-red-100 text-red-700">Overdue</span>}
          {status === 'paused' && <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-gray-200 text-gray-600">Paused</span>}
          {status === 'cancelled' && <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded-full bg-gray-200 text-gray-600">Cancelled</span>}
        </div>
        <div className="text-sm text-[#3D6B34]">🏢 {o.BuyerName || `Buyer #${o.BuyerBusinessID}`}</div>
        <div className="text-xs text-gray-500 mt-1 flex flex-wrap gap-x-3 gap-y-1">
          <span>📦 {o.Quantity} {o.UnitLabel || 'unit'}</span>
          <span>🔁 {FREQUENCY_LABELS[o.Frequency] || o.Frequency}</span>
          {o.DayOfWeek != null && <span>📆 {DAY_NAMES[o.DayOfWeek]}</span>}
          {next && <span className={isOverdue ? 'text-red-600 font-semibold' : ''}>Next: {next}</span>}
        </div>
        {o.Notes && <p className="text-xs italic text-gray-600 mt-2">"{o.Notes}"</p>}
      </div>

      {isActive && (
        <div className="flex items-center gap-2 flex-shrink-0 flex-wrap">
          <button onClick={onFulfill} className="text-xs font-semibold text-white bg-[#3D6B34] hover:bg-[#2d5225] px-3 py-1.5 rounded">
            ✅ Mark fulfilled
          </button>
          <button onClick={onSkip} className="text-xs font-semibold text-gray-700 border border-gray-300 hover:bg-gray-50 px-3 py-1.5 rounded">
            ⏭️ Skip
          </button>
          <button onClick={onReschedule} className="text-xs font-semibold text-gray-700 border border-gray-300 hover:bg-gray-50 px-3 py-1.5 rounded">
            📅 Reschedule
          </button>
        </div>
      )}
    </div>
  );
}

function EmptyState({ title, body, cta }) {
  return (
    <div className="text-center py-16 bg-white rounded-2xl border border-gray-200">
      <div className="text-5xl mb-3">🚜</div>
      <p className="text-lg font-bold text-gray-700">{title}</p>
      <p className="text-sm text-gray-500 mt-2 max-w-md mx-auto">{body}</p>
      {cta && <div className="mt-4">{cta}</div>}
    </div>
  );
}
