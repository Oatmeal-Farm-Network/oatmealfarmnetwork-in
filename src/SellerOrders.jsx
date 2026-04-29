// src/SellerOrders.jsx
import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

export default function SellerOrders() {
  const { t } = useTranslation();
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState('pending');
  const [processingId, setProcessingId] = useState(null);

  useEffect(() => { if (BusinessID) LoadBusiness(BusinessID); }, [BusinessID]);

  const load = async () => {
    setLoading(true);
    try {
      const params = new URLSearchParams();
      if (filter) params.set('status', filter);
      const res = await fetch(`${API}/api/marketplace/orders/seller/${BusinessID}?${params}`);
      const data = await res.json();
      setOrders(data.orders || []);
    } catch {} finally { setLoading(false); }
  };

  useEffect(() => { if (BusinessID) load(); }, [BusinessID, filter]);

  const confirmItem = async (orderItemId, estimatedDate) => {
    setProcessingId(orderItemId);
    try {
      await fetch(`${API}/api/marketplace/orders/seller/confirm`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ OrderItemID: orderItemId, Status: 'confirmed', EstimatedDeliveryDate: estimatedDate || null }),
      });
      load();
    } catch {} finally { setProcessingId(null); }
  };

  const rejectItem = async (orderItemId) => {
    const reason = prompt(t('seller_orders.prompt_reject'));
    if (!reason) return;
    setProcessingId(orderItemId);
    try {
      await fetch(`${API}/api/marketplace/orders/seller/confirm`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ OrderItemID: orderItemId, Status: 'rejected', RejectionReason: reason }),
      });
      load();
    } catch {} finally { setProcessingId(null); }
  };

  const shipItem = async (orderItemId) => {
    const tracking = prompt(t('seller_orders.prompt_tracking'));
    setProcessingId(orderItemId);
    try {
      await fetch(`${API}/api/marketplace/orders/seller/ship`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ OrderItemID: orderItemId, TrackingNumber: tracking || null }),
      });
      load();
    } catch {} finally { setProcessingId(null); }
  };

  const statusBadge = (status) => {
    const map = {
      pending: { bg: '#fef3c7', color: '#92400e' },
      confirmed: { bg: '#d1fae5', color: '#065f46' },
      rejected: { bg: '#fee2e2', color: '#991b1b' },
      shipped: { bg: '#e0e7ff', color: '#3730a3' },
      delivered: { bg: '#d1fae5', color: '#065f46' },
    };
    const s = map[status] || map.pending;
    return <span style={{ backgroundColor: s.bg, color: s.color, fontSize: '0.7rem', fontWeight: 700, padding: '2px 8px', borderRadius: '4px', textTransform: 'uppercase' }}>{status}</span>;
  };

  const FILTERS = ['pending', 'confirmed', 'shipped', 'delivered', ''];

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}
      pageTitle={t('seller_orders.page_title')}
      breadcrumbs={[
        { label: t('seller_orders.crumb_dashboard'), to: '/dashboard' },
        { label: t('seller_orders.crumb_marketplace') },
        { label: t('seller_orders.page_title') },
      ]}>
      <div className="max-w-5xl mx-auto space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-800">{t('seller_orders.heading')}</h1>
          <div className="flex gap-2">
            {FILTERS.map(f => (
              <button key={f} onClick={() => setFilter(f)}
                className={`px-3 py-1.5 rounded-lg text-xs font-semibold ${filter === f ? 'bg-[#819360] text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
                {f ? t('seller_orders.filter_' + f) : t('seller_orders.filter_all')}
              </button>
            ))}
          </div>
        </div>

        {loading ? <div className="text-center py-12 text-gray-400">{t('seller_orders.loading')}</div> :
          orders.length === 0 ? <div className="text-center py-12 text-gray-400">{t('seller_orders.empty', { filter: filter || '' })}</div> :
          <div className="space-y-4">
            {orders.map(o => (
              <div key={o.OrderItemID} className="bg-white rounded-xl border border-gray-200 p-5">
                <div className="flex justify-between items-start mb-3">
                  <div>
                    <span className="font-bold text-gray-700 mr-2">{o.OrderNumber}</span>
                    {statusBadge(o.SellerStatus)}
                    <p className="text-sm text-gray-500 mt-1">{o.BuyerName} · {o.BuyerEmail}</p>
                    {o.BuyerPhone && <p className="text-xs text-gray-400">{o.BuyerPhone}</p>}
                  </div>
                  <div className="text-right">
                    <p className="font-bold text-lg text-[#819360]">${parseFloat(o.LineTotal).toFixed(2)}</p>
                    <p className="text-xs text-gray-400">{t('seller_orders.your_payout', { amount: parseFloat(o.SellerPayout).toFixed(2) })}</p>
                    <p className="text-xs text-gray-400">{new Date(o.CreatedAt).toLocaleDateString()}</p>
                  </div>
                </div>

                <div className="bg-gray-50 rounded-lg p-3 mb-3">
                  <p className="text-sm font-semibold text-gray-700">{o.ProductTitle}</p>
                  <p className="text-xs text-gray-500">{t('seller_orders.qty_line', { qty: o.Quantity, price: parseFloat(o.UnitPrice).toFixed(2), type: o.ProductType })}</p>
                  {o.Notes && <p className="text-xs text-gray-400 mt-1">{t('seller_orders.notes_label')} {o.Notes}</p>}
                  {o.DeliveryMethod && <p className="text-xs text-gray-400">{t('seller_orders.delivery_label')} {o.DeliveryMethod} {o.DeliveryAddress ? `- ${o.DeliveryAddress}` : ''}</p>}
                  {o.RequestedDeliveryDate && <p className="text-xs text-gray-400">{t('seller_orders.requested_date_label')} {new Date(o.RequestedDeliveryDate).toLocaleDateString()}</p>}
                </div>

                <div className="flex gap-2">
                  {o.SellerStatus === 'pending' && (
                    <>
                      <button onClick={() => confirmItem(o.OrderItemID)} disabled={processingId === o.OrderItemID}
                        className="bg-green-600 text-white text-sm font-semibold px-4 py-2 rounded-lg hover:bg-green-700 disabled:opacity-50">
                        {t('seller_orders.btn_confirm')}
                      </button>
                      <button onClick={() => rejectItem(o.OrderItemID)} disabled={processingId === o.OrderItemID}
                        className="bg-red-500 text-white text-sm font-semibold px-4 py-2 rounded-lg hover:bg-red-600 disabled:opacity-50">
                        {t('seller_orders.btn_reject')}
                      </button>
                    </>
                  )}
                  {o.SellerStatus === 'confirmed' && (
                    <button onClick={() => shipItem(o.OrderItemID)} disabled={processingId === o.OrderItemID}
                      className="bg-blue-600 text-white text-sm font-semibold px-4 py-2 rounded-lg hover:bg-blue-700 disabled:opacity-50">
                      {t('seller_orders.btn_ship')}
                    </button>
                  )}
                  {o.SellerStatus === 'shipped' && o.TrackingNumber && (
                    <span className="text-sm text-gray-500">{t('seller_orders.tracking_label')} {o.TrackingNumber}</span>
                  )}
                </div>
              </div>
            ))}
          </div>
        }
      </div>
    </AccountLayout>
  );
}
