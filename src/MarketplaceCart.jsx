// src/MarketplaceCart.jsx
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

export default function MarketplaceCart() {
  const navigate = useNavigate();
  const { Business } = useAccount();
  const peopleId = localStorage.getItem('people_id');
  const businessId = new URLSearchParams(window.location.search).get('BusinessID');

  const [cart, setCart] = useState({ sellers: [], itemCount: 0, subtotal: 0, platformFee: 0, total: 0 });
  const [loading, setLoading] = useState(true);
  const [checking, setChecking] = useState(false);
  const [deliveryMethod, setDeliveryMethod] = useState('pickup');
  const [deliveryAddress, setDeliveryAddress] = useState('');
  const [deliveryNotes, setDeliveryNotes] = useState('');
  const [deliveryDate, setDeliveryDate] = useState('');

  const loadCart = async () => {
    setLoading(true);
    try {
      const res = await fetch(`${API}/api/marketplace/cart/${peopleId}`);
      const data = await res.json();
      setCart(data);
    } catch {} finally { setLoading(false); }
  };

  useEffect(() => { if (peopleId) loadCart(); }, [peopleId]);

  const updateItem = async (cartItemId, quantity) => {
    await fetch(`${API}/api/marketplace/cart/${cartItemId}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ Quantity: quantity, Notes: null }),
    });
    loadCart();
  };

  const removeItem = async (cartItemId) => {
    await fetch(`${API}/api/marketplace/cart/${cartItemId}`, { method: 'DELETE' });
    loadCart();
  };

  const handleCheckout = async () => {
    if (cart.itemCount === 0) return;
    setChecking(true);
    try {
      const res = await fetch(`${API}/api/marketplace/checkout`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          BuyerPeopleID: parseInt(peopleId),
          BuyerBusinessID: businessId ? parseInt(businessId) : null,
          DeliveryMethod: deliveryMethod,
          DeliveryAddress: deliveryAddress || null,
          DeliveryNotes: deliveryNotes || null,
          RequestedDeliveryDate: deliveryDate || null,
        }),
      });
      const data = await res.json();
      if (res.ok) {
        navigate(`/orders/${data.OrderID}?new=true`);
      } else {
        alert(data.detail || 'Checkout failed');
      }
    } catch (err) {
      alert('Checkout error: ' + err.message);
    } finally { setChecking(false); }
  };

  const content = (
    <div className="max-w-4xl mx-auto space-y-6 py-6 px-4">
      <div className="flex justify-between items-center">
        <h1 className="text-2xl font-bold text-gray-800">Shopping Cart</h1>
        <button onClick={() => navigate('/marketplaces/farm-to-table')} className="text-sm text-[#819360] font-semibold hover:underline">
          ← Continue Shopping
        </button>
      </div>

      {loading ? (
        <div className="text-center py-12 text-gray-400">Loading cart...</div>
      ) : cart.itemCount === 0 ? (
        <div className="text-center py-16">
          <p className="text-gray-400 text-lg mb-4">Your cart is empty.</p>
          <button onClick={() => navigate('/marketplaces/farm-to-table')}
            className="bg-[#819360] text-white font-semibold px-6 py-3 rounded-xl hover:bg-[#3D6B35]">
            Browse Marketplace
          </button>
        </div>
      ) : (
        <>
          {/* Items grouped by seller */}
          {cart.sellers.map(seller => (
            <div key={seller.SellerBusinessID} className="bg-white rounded-xl border border-gray-200 overflow-hidden">
              <div className="bg-gray-50 px-4 py-3 border-b border-gray-200">
                <h2 className="font-bold text-gray-700">{seller.SellerName}</h2>
                <p className="text-xs text-gray-400">Subtotal: ${seller.subtotal.toFixed(2)}</p>
              </div>
              {seller.items.map(item => (
                <div key={item.CartItemID} className="flex items-center gap-4 px-4 py-3 border-b border-gray-100 last:border-0">
                  <div className="w-16 h-16 rounded-lg bg-gray-100 flex items-center justify-center flex-shrink-0 overflow-hidden">
                    {item.ImageURL ? <img src={item.ImageURL} className="w-full h-full object-cover" /> :
                      (item.ProductType === 'meat'
                        ? <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#6b7280" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M18.6 6.62a2.5 2.5 0 0 1-3.53 3.53L5 20a2 2 0 0 1-2.83-2.83l10.16-10.16a2.5 2.5 0 0 1 3.53-3.53"/><path d="m15.5 5.5-3 3"/></svg>
                        : item.ProductType === 'processed_food'
                        ? <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#6b7280" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M8 2h8l1 7H7L8 2z"/><path d="M7 9c0 7 2 11 5 11s5-4 5-11"/></svg>
                        : <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#6b7280" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M17 8C8 10 5.9 16.17 3.82 22"/><path d="M9.5 9.5s1-3 4.5-5c0 0 1 3-1 7"/><path d="M3.82 22s1.5-3.5 8.18-4.5"/></svg>
                      )}
                  </div>
                  <div className="flex-grow">
                    <p className="font-semibold text-gray-800 text-sm">{item.Title}</p>
                    <p className="text-xs text-gray-400">${parseFloat(item.UnitPrice).toFixed(2)} / {item.UnitLabel || 'each'}</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <button onClick={() => updateItem(item.CartItemID, item.Quantity - 1)}
                      className="w-7 h-7 rounded bg-gray-100 text-gray-600 font-bold hover:bg-gray-200">−</button>
                    <span className="w-8 text-center text-sm font-semibold">{item.Quantity}</span>
                    <button onClick={() => updateItem(item.CartItemID, item.Quantity + 1)}
                      className="w-7 h-7 rounded bg-gray-100 text-gray-600 font-bold hover:bg-gray-200">+</button>
                  </div>
                  <p className="text-sm font-bold text-gray-800 w-20 text-right">${item.lineTotal.toFixed(2)}</p>
                  <button onClick={() => removeItem(item.CartItemID)} className="text-red-400 hover:text-red-600 text-xs">✕</button>
                </div>
              ))}
            </div>
          ))}

          {/* Delivery options */}
          <div className="bg-white rounded-xl border border-gray-200 p-5">
            <h3 className="font-bold text-gray-700 mb-3">Delivery</h3>
            <div className="grid grid-cols-3 gap-3 mb-4">
              {['pickup', 'local_delivery', 'shipping'].map(m => (
                <button key={m} onClick={() => setDeliveryMethod(m)}
                  className={`p-3 rounded-lg border text-sm font-semibold text-center ${deliveryMethod === m ? 'border-[#819360] bg-[#f0f5e8] text-[#819360]' : 'border-gray-200 text-gray-600 hover:bg-gray-50'}`}>
                  {m === 'pickup' ? '🏪 Pickup' : m === 'local_delivery' ? '🚛 Local Delivery' : '📦 Ship'}
                </button>
              ))}
            </div>
            {deliveryMethod !== 'pickup' && (
              <div className="space-y-3">
                <input value={deliveryAddress} onChange={e => setDeliveryAddress(e.target.value)}
                  placeholder="Delivery address" className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                <div className="flex gap-3">
                  <input type="date" value={deliveryDate} onChange={e => setDeliveryDate(e.target.value)}
                    className="border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                  <input value={deliveryNotes} onChange={e => setDeliveryNotes(e.target.value)}
                    placeholder="Notes (loading dock, gate code, etc.)" className="flex-grow border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                </div>
              </div>
            )}
          </div>

          {/* Order summary */}
          <div className="bg-white rounded-xl border border-gray-200 p-5">
            <h3 className="font-bold text-gray-700 mb-3">Order Summary</h3>
            <div className="space-y-2 text-sm">
              <div className="flex justify-between"><span className="text-gray-500">Subtotal ({cart.itemCount} items)</span><span>${cart.subtotal.toFixed(2)}</span></div>
              <div className="flex justify-between"><span className="text-gray-500">Platform Fee (2.5%)</span><span>${cart.platformFee.toFixed(2)}</span></div>
              <div className="border-t border-gray-200 pt-2 flex justify-between font-bold text-lg">
                <span>Total</span><span className="text-[#819360]">${cart.total.toFixed(2)}</span>
              </div>
            </div>
            <p className="text-xs text-gray-400 mt-3">Payment will be processed only after sellers confirm your order. If a seller rejects an item, you'll only be charged for confirmed items.</p>
            <button onClick={handleCheckout} disabled={checking}
              className="w-full mt-4 bg-[#819360] hover:bg-[#3D6B35] text-white font-bold py-3 rounded-xl text-lg disabled:opacity-50">
              {checking ? 'Placing Order...' : 'Place Order'}
            </button>
          </div>
        </>
      )}
    </div>
  );

  // Wrap in AccountLayout if BusinessID is present
  if (businessId) {
    return <AccountLayout Business={Business} BusinessID={businessId} PeopleID={peopleId} pageTitle="Cart" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Marketplace' }, { label: 'Cart' }]}>{content}</AccountLayout>;
  }
  return content;
}
