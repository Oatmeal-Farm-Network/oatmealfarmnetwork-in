// src/MarketplaceOrders.jsx
import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

const statusColors = {
  pending: { bg: '#fef3c7', text: '#92400e', label: 'Pending' },
  confirmed: { bg: '#d1fae5', text: '#065f46', label: 'Confirmed' },
  partially_confirmed: { bg: '#dbeafe', text: '#1e40af', label: 'Partial' },
  rejected: { bg: '#fee2e2', text: '#991b1b', label: 'Rejected' },
  shipped: { bg: '#e0e7ff', text: '#3730a3', label: 'Shipped' },
  delivered: { bg: '#d1fae5', text: '#065f46', label: 'Delivered' },
  cancelled: { bg: '#f3f4f6', text: '#6b7280', label: 'Cancelled' },
  processing: { bg: '#fef3c7', text: '#92400e', label: 'Processing' },
};

export default function MarketplaceOrders() {
  const navigate = useNavigate();
  const peopleId = localStorage.getItem('people_id');
  const businessId = new URLSearchParams(window.location.search).get('BusinessID');
  const { Business } = useAccount();

  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState('');

  useEffect(() => {
    if (!peopleId) return;
    const load = async () => {
      setLoading(true);
      try {
        const params = new URLSearchParams();
        if (filter) params.set('status', filter);
        const res = await fetch(`${API}/api/marketplace/orders/buyer/${peopleId}?${params}`);
        const data = await res.json();
        setOrders(data.orders || []);
      } catch {} finally { setLoading(false); }
    };
    load();
  }, [peopleId, filter]);

  const Badge = ({ status }) => {
    const s = statusColors[status] || statusColors.pending;
    return (
      <span style={{ backgroundColor: s.bg, color: s.text, fontSize: '0.7rem', fontWeight: 700, padding: '2px 8px', borderRadius: '4px', textTransform: 'uppercase' }}>
        {s.label}
      </span>
    );
  };

  const content = (
    <div className="max-w-4xl mx-auto py-6 px-4 space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="text-2xl font-bold text-gray-800">My Orders</h1>
        <div className="flex gap-2">
          {['', 'pending', 'confirmed', 'shipped', 'delivered'].map(f => (
            <button key={f} onClick={() => setFilter(f)}
              className={`px-3 py-1.5 rounded-lg text-xs font-semibold ${filter === f ? 'bg-[#819360] text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
              {f || 'All'}
            </button>
          ))}
        </div>
      </div>

      {loading ? <div className="text-center py-12 text-gray-400">Loading orders...</div> :
        orders.length === 0 ? (
          <div className="text-center py-16">
            <p className="text-gray-400 text-lg mb-4">No orders yet.</p>
            <button onClick={() => navigate('/marketplaces/farm-to-table')}
              className="bg-[#819360] text-white font-semibold px-6 py-3 rounded-xl">Browse Marketplace</button>
          </div>
        ) : orders.map(order => (
          <div key={order.OrderID} className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <div className="flex justify-between items-center bg-gray-50 px-5 py-3 border-b border-gray-200">
              <div>
                <span className="font-bold text-gray-700 mr-3">{order.OrderNumber}</span>
                <Badge status={order.OrderStatus} />
              </div>
              <div className="text-right">
                <span className="font-bold text-[#819360] text-lg">${parseFloat(order.TotalAmount).toFixed(2)}</span>
                <p className="text-xs text-gray-400">{new Date(order.CreatedAt).toLocaleDateString()}</p>
              </div>
            </div>
            <div className="divide-y divide-gray-100">
              {(order.items || []).map(item => (
                <div key={item.OrderItemID} className="flex items-center gap-4 px-5 py-3">
                  <span className="text-2xl">{item.ProductType === 'meat' ? '🥩' : item.ProductType === 'processed_food' ? '🫙' : '🥬'}</span>
                  <div className="flex-grow">
                    <p className="font-semibold text-sm text-gray-800">{item.ProductTitle}</p>
                    <p className="text-xs text-gray-400">{item.SellerName || item.BusinessName} · {item.Quantity} × ${parseFloat(item.UnitPrice).toFixed(2)}</p>
                  </div>
                  <Badge status={item.SellerStatus} />
                  <span className="font-bold text-sm">${parseFloat(item.LineTotal).toFixed(2)}</span>
                </div>
              ))}
            </div>
            <div className="px-5 py-3 bg-gray-50 flex justify-between items-center border-t border-gray-200">
              <span className="text-xs text-gray-400">
                {order.DeliveryMethod === 'pickup' ? '🏪 Pickup' : order.DeliveryMethod === 'local_delivery' ? '🚛 Local Delivery' : '📦 Shipping'}
              </span>
              <button onClick={() => navigate(`/orders/${order.OrderID}`)}
                className="text-sm text-[#819360] font-semibold hover:underline">
                View Details →
              </button>
            </div>
          </div>
        ))}
    </div>
  );

  if (businessId) {
    return <AccountLayout Business={Business} BusinessID={businessId} PeopleID={peopleId} pageTitle="My Orders" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Marketplace' }, { label: 'My Orders' }]}>{content}</AccountLayout>;
  }
  return content;
}
