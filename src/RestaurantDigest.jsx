// src/RestaurantDigest.jsx
// "Available this week" — restaurants opt in to a weekly digest of farm products available now.
// Route: /restaurant/digest
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';
import PairsleyChat from './PairsleyChat';

const API = import.meta.env.VITE_API_URL || '';

export default function RestaurantDigest() {
  const { businesses } = useAccount() || {};
  const restaurantBusiness = Array.isArray(businesses)
    ? businesses.find(b => (b.BusinessType || '').toLowerCase() === 'restaurant')
    : null;
  const buyerBusinessId = restaurantBusiness?.BusinessID || null;

  const [sub,     setSub]     = useState(null);
  const [email,   setEmail]   = useState('');
  const [savedOnly, setSavedOnly] = useState(false);
  const [frequency, setFrequency] = useState('weekly');
  const [preview, setPreview] = useState(null);
  const [loading, setLoading] = useState(true);
  const [saving,  setSaving]  = useState(false);
  const [sendingNow, setSendingNow] = useState(false);
  const [msg,     setMsg]     = useState('');

  const load = async () => {
    if (!buyerBusinessId) { setLoading(false); return; }
    setLoading(true);
    try {
      const [subRes, prevRes] = await Promise.all([
        fetch(`${API}/api/marketplace/digest-subscription?buyer_business_id=${buyerBusinessId}`),
        fetch(`${API}/api/marketplace/digest-preview?buyer_business_id=${buyerBusinessId}`),
      ]);
      const subData  = subRes.ok ? await subRes.json() : null;
      const prevData = prevRes.ok ? await prevRes.json() : null;
      setSub(subData);
      setPreview(prevData);
      if (subData) {
        setEmail(subData.Email || '');
        setSavedOnly(!!subData.SavedFarmsOnly);
        setFrequency(subData.Frequency || 'weekly');
      } else {
        const fallbackEmail = localStorage.getItem('email') || '';
        setEmail(fallbackEmail);
      }
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); /* eslint-disable-next-line react-hooks/exhaustive-deps */ }, [buyerBusinessId]);

  const subscribe = async (e) => {
    e?.preventDefault();
    if (!email.trim()) { setMsg('Email is required.'); return; }
    setSaving(true);
    setMsg('');
    try {
      const res = await fetch(`${API}/api/marketplace/digest-subscription`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          BuyerBusinessID: buyerBusinessId,
          Email:           email.trim(),
          Frequency:       frequency,
          SavedFarmsOnly:  savedOnly,
          Status:          'active',
        }),
      });
      if (!res.ok) throw new Error();
      setMsg('Subscription saved.');
      load();
    } catch {
      setMsg('Could not save subscription.');
    } finally {
      setSaving(false);
    }
  };

  const unsubscribe = async () => {
    if (!window.confirm('Unsubscribe from the weekly digest?')) return;
    await fetch(`${API}/api/marketplace/digest-subscription?buyer_business_id=${buyerBusinessId}`, { method: 'DELETE' });
    setSub(null);
    setMsg('Unsubscribed.');
  };

  const sendNow = async () => {
    setSendingNow(true);
    setMsg('');
    try {
      const res = await fetch(`${API}/api/marketplace/digest-send-now?buyer_business_id=${buyerBusinessId}`, { method: 'POST' });
      if (!res.ok) throw new Error();
      const data = await res.json();
      setMsg(`Digest queued: "${data.subject}" → ${data.to} (${data.item_count} items). ${data.note || ''}`);
      load();
    } catch {
      setMsg('Could not send digest preview.');
    } finally {
      setSendingNow(false);
    }
  };

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Available This Week | Restaurant Email Digest"
        description="Weekly email digest of farm products available now — for restaurant buyers."
      />
      <Header />

      <div className="mx-auto px-4 pt-4 pb-10" style={{ maxWidth: '900px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Marketplaces', to: '/marketplaces' },
          { label: 'Farm-to-Table', to: '/marketplaces/farm-to-table' },
          { label: 'Weekly Digest' },
        ]} />

        <h1 className="mt-4 text-2xl font-bold text-gray-900" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
          📬 Available This Week
        </h1>
        <p className="text-sm text-gray-600 mt-1 mb-6">
          Get a weekly email with everything fresh from local farms — perfect for menu planning. Optionally restrict it to your saved farms.
        </p>

        {!buyerBusinessId ? (
          <div className="bg-white rounded-2xl border border-gray-200 p-6 text-center">
            <p className="text-gray-700 font-semibold">No restaurant business found on your account.</p>
            <Link to="/account" className="text-[#3D6B34] underline text-sm">Go to account</Link>
          </div>
        ) : loading ? (
          <div className="text-gray-400 text-center py-10">Loading…</div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* ── Subscription form ── */}
            <div className="bg-white rounded-2xl border border-gray-200 p-5">
              <h2 className="font-bold text-gray-900 mb-3">Your subscription</h2>
              {sub && (
                <p className="text-xs bg-[#e8f0dc] text-[#3D6B34] font-semibold px-3 py-2 rounded mb-3">
                  ✓ Active — last sent {sub.LastSentAt ? new Date(sub.LastSentAt).toLocaleDateString() : 'never'}
                </p>
              )}
              <form onSubmit={subscribe} className="space-y-3">
                <div>
                  <label className="block text-xs font-semibold text-gray-700 mb-1">Email</label>
                  <input type="email" value={email} onChange={e => setEmail(e.target.value)} required
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-gray-700 mb-1">Frequency</label>
                  <select value={frequency} onChange={e => setFrequency(e.target.value)}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm">
                    <option value="weekly">Weekly</option>
                    <option value="biweekly">Every 2 weeks</option>
                    <option value="monthly">Monthly</option>
                  </select>
                </div>
                <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
                  <input type="checkbox" checked={savedOnly} onChange={e => setSavedOnly(e.target.checked)} />
                  <span>Only include farms I've saved (<Link to="/restaurant/farms" className="text-[#3D6B34] underline">My Farms</Link>)</span>
                </label>

                <div className="flex justify-end gap-2 pt-2">
                  {sub && (
                    <button type="button" onClick={unsubscribe}
                      className="text-xs text-red-500 hover:underline px-2">
                      Unsubscribe
                    </button>
                  )}
                  <button type="submit" disabled={saving}
                    className="px-4 py-2 text-sm font-bold text-white bg-[#3D6B34] hover:bg-[#2d5225] rounded-lg disabled:opacity-60">
                    {saving ? 'Saving…' : sub ? 'Update' : 'Subscribe'}
                  </button>
                </div>
              </form>

              {sub && (
                <button onClick={sendNow} disabled={sendingNow}
                  className="mt-4 w-full text-xs font-semibold text-[#3D6B34] border border-[#3D6B34] hover:bg-[#e8f0dc] py-2 rounded-lg disabled:opacity-60">
                  {sendingNow ? 'Sending…' : '📤 Send a digest now'}
                </button>
              )}

              {msg && <p className="text-xs text-gray-700 bg-gray-50 border border-gray-200 rounded p-2 mt-3">{msg}</p>}
            </div>

            {/* ── Preview ── */}
            <div className="bg-white rounded-2xl border border-gray-200 p-5">
              <h2 className="font-bold text-gray-900 mb-3">Preview ({preview?.item_count ?? 0} items)</h2>
              {!preview || (preview.items || []).length === 0 ? (
                <p className="text-sm text-gray-500">Nothing available right now. Save some farms or check back later.</p>
              ) : (
                <ul className="divide-y divide-gray-100 max-h-96 overflow-y-auto">
                  {preview.items.map((it, idx) => (
                    <li key={idx} className="py-2">
                      <div className="flex justify-between gap-2">
                        <div className="min-w-0">
                          <p className="text-sm font-semibold text-gray-900 truncate">{it.Title}</p>
                          <p className="text-xs text-gray-500 truncate">
                            {it.FarmName}{it.AddressCity ? ` · ${it.AddressCity}, ${it.AddressState}` : ''}
                          </p>
                        </div>
                        <div className="text-xs text-right whitespace-nowrap">
                          {it.WholesalePrice && <span className="text-[#8a6a0a] font-bold">WS ${parseFloat(it.WholesalePrice).toFixed(2)} · </span>}
                          <span className="text-[#3D6B34] font-bold">${parseFloat(it.RetailPrice || 0).toFixed(2)}</span>
                        </div>
                      </div>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </div>
        )}
      </div>

      <Footer />
      <PairsleyChat businessId={buyerBusinessId} />
    </div>
  );
}
