// src/FarmToTableMarketplace.jsx
// Farm-to-Restaurant Marketplace — browse meat, produce & value-added products
import React, { useEffect, useState, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

const PRODUCT_TYPES = [
  { key: 'all',            label: 'All Products',     emoji: '🛒' },
  { key: 'produce',        label: 'Produce',           emoji: '🥬' },
  { key: 'meat',           label: 'Meat',              emoji: '🥩' },
  { key: 'processed_food', label: 'Value-Added',       emoji: '🫙' },
  { key: 'service',        label: 'Services',          emoji: '🛠️' },
];

const SORT_OPTIONS = [
  { key: 'newest',         label: 'Newest First' },
  { key: 'price_asc',      label: 'Price: Low → High' },
  { key: 'price_desc',     label: 'Price: High → Low' },
  { key: 'name_asc',       label: 'Name A–Z' },
];

const AVAILABILITY_OPTIONS = [
  { key: '',   label: 'Any time' },
  { key: '0',  label: 'Available today' },
  { key: '7',  label: 'This week' },
  { key: '30', label: 'This month' },
];

// US state codes — enough coverage for restaurant buyers to filter by region
const STATE_OPTIONS = [
  '','AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY',
];

const typeEmoji = (type) =>
  type === 'meat' ? '🥩' : type === 'processed_food' ? '🫙' : '🥬';

// Format an AvailableDate string as a short "Ready Mon D" label, or null if past/invalid/today.
const formatAvailability = (dateStr) => {
  if (!dateStr) return null;
  const d = new Date(dateStr);
  if (isNaN(d)) return null;
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const target = new Date(d.getFullYear(), d.getMonth(), d.getDate());
  if (target <= today) return null; // already available — don't clutter the card
  return `Ready ${target.toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}`;
};

// ── Cart helpers (localStorage) ───────────────────────────────────────────────
function getCart() {
  try { return JSON.parse(localStorage.getItem('marketplace_cart') || '[]'); } catch { return []; }
}
function saveCart(cart) {
  localStorage.setItem('marketplace_cart', JSON.stringify(cart));
}
function cartCount(cart) {
  return cart.reduce((s, i) => s + i.quantity, 0);
}

export default function FarmToTableMarketplace() {
  const navigate = useNavigate();
  const [isLoggedIn, setIsLoggedIn] = useState(!!localStorage.getItem('access_token'));
  const peopleId   = localStorage.getItem('people_id');

  // Restaurant-buyer view: if any of the user's businesses is a Restaurant, show wholesale pricing.
  const { businesses } = useAccount() || {};
  const isRestaurant = isLoggedIn && Array.isArray(businesses) &&
    businesses.some(b => (b.BusinessType || '').toLowerCase() === 'restaurant');
  // First restaurant business — used as the "buyer" identity for the saved-farms list.
  const restaurantBusinessId = isRestaurant
    ? businesses.find(b => (b.BusinessType || '').toLowerCase() === 'restaurant')?.BusinessID
    : null;

  // ── Sign-in form state (inline in cart drawer) ─────────────────────────────
  const [showSignIn,   setShowSignIn]   = useState(false);
  const [signInEmail,  setSignInEmail]  = useState('');
  const [signInPass,   setSignInPass]   = useState('');
  const [signInError,  setSignInError]  = useState('');
  const [signInLoading, setSignInLoading] = useState(false);

  const handleSignIn = async (e) => {
    e.preventDefault();
    setSignInError('');
    setSignInLoading(true);
    try {
      const res = await fetch(`${API}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ Email: signInEmail, Password: signInPass }),
      });
      const data = await res.json();
      if (!res.ok) {
        setSignInError(Array.isArray(data.detail) ? data.detail.map(d => d.msg).join(', ') : data.detail || 'Login failed.');
        return;
      }
      localStorage.setItem('access_token', data.AccessToken);
      localStorage.setItem('people_id', data.PeopleID);
      localStorage.setItem('first_name', data.PeopleFirstName);
      localStorage.setItem('last_name', data.PeopleLastName);
      localStorage.setItem('access_level', data.AccessLevel);
      setIsLoggedIn(true);
      setShowSignIn(false);
      setSignInError('');
    } catch {
      setSignInError('Unable to connect. Please try again.');
    } finally {
      setSignInLoading(false);
    }
  };

  // ── State ──────────────────────────────────────────────────────────────────
  const [listings,     setListings]     = useState([]);
  const [loading,      setLoading]      = useState(true);
  const [error,        setError]        = useState('');

  const [typeFilter,     setTypeFilter]     = useState('all');
  const [search,         setSearch]         = useState('');
  const [sort,           setSort]           = useState('newest');
  const [organicOnly,    setOrganicOnly]    = useState(false);
  const [availableWithin,setAvailableWithin]= useState(''); // '', '0', '7', '30'
  const [minQty,         setMinQty]         = useState('');
  const [stateFilter,    setStateFilter]    = useState('');

  const [cart,         setCart]         = useState(getCart);
  const [toastMsg,     setToastMsg]     = useState('');
  const [toastKey,     setToastKey]     = useState(0);

  // Saved-farm IDs for the active restaurant buyer (Set for O(1) lookup).
  const [savedFarmIds, setSavedFarmIds] = useState(() => new Set());
  // Standing-order setup modal — null when closed; otherwise the listing being added.
  const [standingTarget, setStandingTarget] = useState(null);

  useEffect(() => {
    if (!restaurantBusinessId) { setSavedFarmIds(new Set()); return; }
    fetch(`${API}/api/marketplace/saved-farms?buyer_business_id=${restaurantBusinessId}`)
      .then(r => r.ok ? r.json() : [])
      .then(rows => setSavedFarmIds(new Set((rows || []).map(r => r.FarmBusinessID))))
      .catch(() => setSavedFarmIds(new Set()));
  }, [restaurantBusinessId]);

  const toggleSaveFarm = useCallback(async (farmBusinessId) => {
    if (!restaurantBusinessId || !farmBusinessId) return;
    const wasSaved = savedFarmIds.has(farmBusinessId);
    // Optimistic update
    setSavedFarmIds(prev => {
      const next = new Set(prev);
      if (wasSaved) next.delete(farmBusinessId); else next.add(farmBusinessId);
      return next;
    });
    try {
      if (wasSaved) {
        await fetch(`${API}/api/marketplace/saved-farms?buyer_business_id=${restaurantBusinessId}&farm_business_id=${farmBusinessId}`, { method: 'DELETE' });
        showToast('Removed from My Farms');
      } else {
        await fetch(`${API}/api/marketplace/saved-farms`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            BuyerBusinessID: restaurantBusinessId,
            FarmBusinessID:  farmBusinessId,
            AddedByPeopleID: peopleId ? parseInt(peopleId) : null,
          }),
        });
        showToast('Saved to My Farms');
      }
    } catch {
      // Revert on failure
      setSavedFarmIds(prev => {
        const next = new Set(prev);
        if (wasSaved) next.add(farmBusinessId); else next.delete(farmBusinessId);
        return next;
      });
    }
  }, [restaurantBusinessId, savedFarmIds, peopleId]);

  // Parse a synthetic ListingID like 'P123', 'M45', 'F9', 'S7' back to {type, sourceId}.
  const parseListingId = (id) => {
    if (typeof id !== 'string' || id.length < 2) return null;
    const prefix = id[0];
    const sourceId = parseInt(id.slice(1), 10);
    if (Number.isNaN(sourceId)) return null;
    const typeMap = { P: 'produce', M: 'meat', F: 'processed_food', G: 'sf', S: 'service' };
    const type = typeMap[prefix];
    return type ? { type, sourceId } : null;
  };

  const submitStandingOrder = async ({ frequency, dayOfWeek, quantity, notes }) => {
    if (!standingTarget || !restaurantBusinessId) return;
    const parsed = parseListingId(standingTarget.ListingID);
    if (!parsed) { showToast('Could not identify product.'); return; }
    try {
      const res = await fetch(`${API}/api/marketplace/standing-orders`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          BuyerBusinessID:   restaurantBusinessId,
          FarmBusinessID:    standingTarget.BusinessID,
          ListingType:       parsed.type,
          ListingSourceID:   parsed.sourceId,
          ProductTitle:      standingTarget.Title,
          Quantity:          quantity,
          UnitLabel:         standingTarget.UnitLabel || null,
          Frequency:         frequency,
          DayOfWeek:         dayOfWeek,
          Notes:             notes || null,
          CreatedByPeopleID: peopleId ? parseInt(peopleId) : null,
        }),
      });
      if (!res.ok) throw new Error();
      setStandingTarget(null);
      showToast('Standing order created');
    } catch {
      showToast('Could not create standing order');
    }
  };

  // ── Fetch listings ─────────────────────────────────────────────────────────
  useEffect(() => {
    const load = async () => {
      setLoading(true);
      setError('');
      try {
        const params = new URLSearchParams();
        if (typeFilter !== 'all')   params.set('product_type', typeFilter);
        if (organicOnly)            params.set('organic', 'true');
        if (search.trim())          params.set('search', search.trim());
        if (availableWithin !== '') params.set('available_within_days', availableWithin);
        if (minQty)                 params.set('min_quantity', minQty);
        if (stateFilter)            params.set('state', stateFilter);
        params.set('sort', sort);

        const res = await fetch(`${API}/api/marketplace/catalog?${params}`);
        if (!res.ok) throw new Error(`Server error ${res.status}`);
        const data = await res.json();
        setListings(Array.isArray(data) ? data : (data.listings || []));
      } catch (e) {
        setError('Could not load products. Please try again.');
        console.error(e);
      } finally {
        setLoading(false);
      }
    };
    load();
  }, [typeFilter, organicOnly, sort, search, availableWithin, minQty, stateFilter]);

  // ── Cart actions ───────────────────────────────────────────────────────────
  const showToast = (msg) => {
    setToastMsg(msg);
    setToastKey(k => k + 1);
  };

  const addToCart = useCallback((listing) => {
    setCart(prev => {
      const existing = prev.find(i => i.ListingID === listing.ListingID);
      let next;
      if (existing) {
        next = prev.map(i =>
          i.ListingID === listing.ListingID
            ? { ...i, quantity: Math.min(i.quantity + 1, listing.QuantityAvailable) }
            : i
        );
      } else {
        next = [...prev, {
          ListingID:         listing.ListingID,
          title:             listing.Title,
          price:             listing.UnitPrice,
          unitLabel:         listing.UnitLabel || 'each',
          sellerName:        listing.SellerName,
          productType:       listing.ProductType,
          imageURL:          listing.ImageURL || null,
          quantityAvailable: listing.QuantityAvailable,
          quantity:          1,
        }];
      }
      saveCart(next);
      return next;
    });
    showToast(`${listing.Title} added to cart`);
  }, []);

  const removeFromCart = useCallback((listingId) => {
    setCart(prev => {
      const next = prev.filter(i => i.ListingID !== listingId);
      saveCart(next);
      return next;
    });
  }, []);

  const updateQty = useCallback((listingId, delta, max) => {
    setCart(prev => {
      const next = prev.map(i => {
        if (i.ListingID !== listingId) return i;
        const q = Math.max(1, Math.min(i.quantity + delta, max));
        return { ...i, quantity: q };
      });
      saveCart(next);
      return next;
    });
  }, []);

  const checkout = async () => {
    const currentPeopleId = localStorage.getItem('people_id');
    if (!isLoggedIn || !currentPeopleId) { setShowSignIn(true); return; }
    if (!cart.length) return;
    try {
      // Sync localStorage cart to server, then checkout
      for (const item of cart) {
        await fetch(`${API}/api/marketplace/cart`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            BuyerPeopleID: parseInt(currentPeopleId),
            ListingID: item.ListingID,
            Quantity: item.quantity,
          }),
        });
      }
      const res = await fetch(`${API}/api/marketplace/checkout`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          BuyerPeopleID: parseInt(currentPeopleId),
          DeliveryMethod: 'pickup',
        }),
      });
      if (!res.ok) {
        const err = await res.json();
        alert(err.detail || 'Could not place order');
        return;
      }
      const data = await res.json();
      saveCart([]);
      setCart([]);
      navigate(`/orders/${data.OrderID}?new=true`);
    } catch (e) {
      alert('Connection error. Please try again.');
    }
  };

  // ── Derived ────────────────────────────────────────────────────────────────
  const cartTotal = cart.reduce((s, i) => s + parseFloat(i.price) * i.quantity, 0);
  const count     = cartCount(cart);

  // ── Render ─────────────────────────────────────────────────────────────────
  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Farm-to-Table Marketplace | Local Produce, Meat & Farm Products"
        description="Connect with local farms selling fresh produce, pasture-raised meat, dairy, and value-added products directly to restaurants, food hubs, and buyers."
        keywords="farm to table, local produce, pasture raised meat, farm marketplace, organic produce, direct from farm, wholesale produce"
        canonical="https://oatmealfarmnetwork.com/marketplaces/farm-to-table"
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'CollectionPage',
          name: 'Farm-to-Table Marketplace',
          url: 'https://oatmealfarmnetwork.com/marketplaces/farm-to-table',
          description: 'Local produce, meat, and value-added farm products for restaurants and buyers.'
        }}
      />
      <Header />

      {/* ── Hero ── */}
      <div className="mx-auto px-4 pt-2 md:pt-6" style={{ maxWidth: '1300px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Marketplaces', to: '/marketplaces' },
          { label: 'Farm-to-Table' },
        ]} />

        {/* Image — shorter on mobile, taller on desktop */}
        <div className="relative w-full overflow-hidden rounded-xl rounded-b-none md:rounded-b-xl">
          <img
            src="/images/FruitsIngredientHeader.webp"
            alt="Farm-to-Table Marketplace"
            className="w-full object-cover block h-[160px] md:h-[250px]"
            loading="eager"
            onError={e => { e.target.src = '/images/HomepageLivestockMarketplace.webp'; }}
          />
          {/* Gradient + text overlay — desktop only */}
          <div className="hidden md:block absolute inset-0" style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }} />
          <div className="hidden md:flex absolute inset-0 flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            <p style={{ color: '#3D6B34', fontFamily: "'Lora','Times New Roman',serif", fontSize: '0.85rem', fontWeight: '600', margin: '0 0 6px', textTransform: 'uppercase', letterSpacing: '0.06em' }}>
              Farm to Table
            </p>
            <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '2rem', fontWeight: 'bold', margin: '0 0 10px', lineHeight: 1.2 }}>
              Farm-to-Table Marketplace
            </h1>
            <p style={{ color: '#111111', fontSize: '0.88rem', margin: '0 0 14px', lineHeight: 1.5 }}>
              Order fresh produce, pasture-raised meat, and value-added products directly from local farms. No middlemen.
            </p>
            <div>
              <button
                onClick={() => document.getElementById('cart-drawer').classList.toggle('translate-x-full')}
                style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', backgroundColor: '#3D6B34', color: '#fff', fontSize: '0.8rem', fontWeight: 'bold', padding: '7px 18px', borderRadius: '6px', border: 'none', cursor: 'pointer' }}
              >
                🛒 Cart
                {count > 0 && (
                  <span style={{ backgroundColor: '#fff', color: '#3D6B34', fontSize: '0.7rem', fontWeight: 'bold', padding: '1px 7px', borderRadius: '999px' }}>
                    {count}
                  </span>
                )}
              </button>
            </div>
          </div>
        </div>

        {/* Text below image — mobile only */}
        <div className="md:hidden bg-white px-5 py-4 rounded-b-xl border border-t-0 border-gray-200">
          <p style={{ color: '#3D6B34', fontFamily: "'Lora','Times New Roman',serif", fontSize: '0.75rem', fontWeight: '600', margin: '0 0 4px', textTransform: 'uppercase', letterSpacing: '0.06em' }}>
            Farm to Table
          </p>
          <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '1.4rem', fontWeight: 'bold', margin: '0 0 8px', lineHeight: 1.2 }}>
            Farm-to-Table Marketplace
          </h1>
          <p style={{ color: '#111111', fontSize: '0.85rem', margin: '0 0 10px', lineHeight: 1.5 }}>
            Order fresh produce, pasture-raised meat, and value-added products directly from local farms.
          </p>
          <button
            onClick={() => document.getElementById('cart-drawer').classList.toggle('translate-x-full')}
            style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', backgroundColor: '#3D6B34', color: '#fff', fontSize: '0.8rem', fontWeight: 'bold', padding: '7px 18px', borderRadius: '6px', border: 'none', cursor: 'pointer' }}
          >
            🛒 Cart
            {count > 0 && (
              <span style={{ backgroundColor: '#fff', color: '#3D6B34', fontSize: '0.7rem', fontWeight: 'bold', padding: '1px 7px', borderRadius: '999px' }}>
                {count}
              </span>
            )}
          </button>
        </div>

      </div>

      {/* ── Filters bar ── */}
      <div className="sticky top-0 z-20 bg-white border-b border-gray-200 shadow-sm">
        <div className="mx-auto px-4 py-3 flex flex-wrap items-center gap-3" style={{ maxWidth: '1300px' }}>
          {/* Type pills */}
          <div className="flex gap-2 flex-wrap">
            {PRODUCT_TYPES.map(t => (
              <button
                key={t.key}
                onClick={() => setTypeFilter(t.key)}
                className="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-semibold border transition-all"
              style={typeFilter === t.key
                ? { backgroundColor: '#3D6B34', color: '#fff', borderColor: '#3D6B34' }
                : { backgroundColor: '#fff', color: '#3D6B34', borderColor: '#3D6B34' }}
              >
                <span>{t.emoji}</span> {t.label}
              </button>
            ))}
          </div>

          <div className="flex-grow" />

          {/* Organic toggle */}
          <label className="flex items-center gap-2 cursor-pointer select-none text-sm font-medium text-gray-700">
            <div
              onClick={() => setOrganicOnly(v => !v)}
              className={`w-10 h-5 rounded-full relative transition-colors ${organicOnly ? 'bg-[#819360]' : 'bg-gray-300'}`}
            >
              <div className={`absolute top-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${organicOnly ? 'translate-x-5' : 'translate-x-0.5'}`} />
            </div>
            Organic Only
          </label>

          {/* Search */}
          <input
            type="search"
            placeholder="Search products…"
            value={search}
            onChange={e => setSearch(e.target.value)}
            className="border border-gray-300 rounded-xl px-3 py-1.5 text-sm focus:outline-none focus:border-[#819360] w-44"
          />

          {/* Sort */}
          <select
            value={sort}
            onChange={e => setSort(e.target.value)}
            className="border border-gray-300 rounded-xl px-3 py-1.5 text-sm focus:outline-none focus:border-[#819360] bg-white"
          >
            {SORT_OPTIONS.map(o => <option key={o.key} value={o.key}>{o.label}</option>)}
          </select>

          {/* Cart button */}
          <button
            onClick={() => document.getElementById('cart-drawer').classList.toggle('translate-x-full')}
            className="relative bg-[#2d3a1e] text-white px-4 py-1.5 rounded-xl text-sm font-bold hover:bg-[#3f5229] transition-colors flex items-center gap-2"
          >
            🛒 Cart
            {count > 0 && (
              <span className="absolute -top-1.5 -right-1.5 bg-[#A3301E] text-white text-xs font-bold w-5 h-5 rounded-full flex items-center justify-center">
                {count}
              </span>
            )}
          </button>
        </div>

        {/* ── Restaurant / bulk buyer filters (secondary row) ── */}
        <div className="mx-auto px-4 pb-3 flex flex-wrap items-center gap-3 text-xs" style={{ maxWidth: '1300px' }}>
          <span className="font-semibold uppercase tracking-wider text-gray-500">For buyers:</span>

          {isRestaurant && (
            <>
              <span
                className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full font-bold uppercase tracking-wider"
                style={{ backgroundColor: '#fff4d6', color: '#8a6a0a' }}
                title="You're signed in as a Restaurant — wholesale prices are shown when available."
              >
                🍽️ Wholesale view
              </span>
              <button
                onClick={() => navigate('/restaurant/farms')}
                className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full font-bold uppercase tracking-wider text-[#3D6B34] border border-[#3D6B34] hover:bg-[#e8f0dc]"
                title="View the farms you've saved"
              >
                ❤️ My Farms ({savedFarmIds.size})
              </button>
              <button
                onClick={() => navigate('/restaurant/standing-orders')}
                className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full font-bold uppercase tracking-wider text-[#3D6B34] border border-[#3D6B34] hover:bg-[#e8f0dc]"
                title="Manage your recurring orders"
              >
                🔁 Standing Orders
              </button>
              <button
                onClick={() => navigate('/restaurant/digest')}
                className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full font-bold uppercase tracking-wider text-[#3D6B34] border border-[#3D6B34] hover:bg-[#e8f0dc]"
                title="Weekly email digest of available products"
              >
                📬 Weekly Digest
              </button>
            </>
          )}

          <label className="flex items-center gap-1.5 text-gray-700">
            <span>Available</span>
            <select
              value={availableWithin}
              onChange={e => setAvailableWithin(e.target.value)}
              className="border border-gray-300 rounded-lg px-2 py-1 text-xs bg-white focus:outline-none focus:border-[#819360]"
            >
              {AVAILABILITY_OPTIONS.map(o => <option key={o.key} value={o.key}>{o.label}</option>)}
            </select>
          </label>

          <label className="flex items-center gap-1.5 text-gray-700">
            <span>State</span>
            <select
              value={stateFilter}
              onChange={e => setStateFilter(e.target.value)}
              className="border border-gray-300 rounded-lg px-2 py-1 text-xs bg-white focus:outline-none focus:border-[#819360]"
            >
              {STATE_OPTIONS.map(s => <option key={s} value={s}>{s || 'Any'}</option>)}
            </select>
          </label>

          <label className="flex items-center gap-1.5 text-gray-700">
            <span>Min qty</span>
            <input
              type="number"
              min="0"
              step="1"
              placeholder="e.g. 20"
              value={minQty}
              onChange={e => setMinQty(e.target.value)}
              className="border border-gray-300 rounded-lg px-2 py-1 text-xs w-20 focus:outline-none focus:border-[#819360]"
            />
          </label>

          {(availableWithin !== '' || stateFilter || minQty) && (
            <button
              onClick={() => { setAvailableWithin(''); setStateFilter(''); setMinQty(''); }}
              className="text-xs text-[#A3301E] underline hover:text-[#8a2718]"
            >
              Clear buyer filters
            </button>
          )}
        </div>
      </div>

      {/* ── Products grid ── */}
      <main className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>
        {loading ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-5">
            {Array.from({ length: 8 }).map((_, i) => (
              <div key={i} className="bg-white rounded-2xl overflow-hidden animate-pulse">
                <div className="h-44 bg-gray-200" />
                <div className="p-4 space-y-2">
                  <div className="h-4 bg-gray-200 rounded w-3/4" />
                  <div className="h-3 bg-gray-200 rounded w-1/2" />
                  <div className="h-8 bg-gray-200 rounded mt-3" />
                </div>
              </div>
            ))}
          </div>
        ) : error ? (
          <div className="text-center py-20">
            <p className="text-red-500 font-semibold mb-4">{error}</p>
            <button onClick={() => setTypeFilter('all')} className="text-sm text-[#819360] underline">Try again</button>
          </div>
        ) : listings.length === 0 ? (
          <div className="text-center py-24 text-gray-400">
            <p className="text-5xl mb-4">🌾</p>
            <p className="text-xl font-semibold text-gray-600">No products found</p>
            <p className="text-sm mt-2">Try adjusting your filters</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-5">
            {listings.map(l => (
              <ProductCard
                key={l.ListingID}
                listing={l}
                inCart={cart.find(i => i.ListingID === l.ListingID)}
                onAdd={() => addToCart(l)}
                onView={() => navigate(`/marketplace/${l.ListingID}`)}
                isRestaurant={isRestaurant}
                isSaved={l.BusinessID && savedFarmIds.has(l.BusinessID)}
                onToggleSave={restaurantBusinessId && l.BusinessID
                  ? () => toggleSaveFarm(l.BusinessID)
                  : null}
                onMakeStanding={restaurantBusinessId
                  ? () => setStandingTarget(l)
                  : null}
              />
            ))}
          </div>
        )}
      </main>

      <Footer />

      {/* ── Cart Drawer ── */}
      <div
        id="cart-drawer"
        className="fixed top-0 right-0 h-full w-full max-w-sm bg-white shadow-2xl z-50 translate-x-full transition-transform duration-300 flex flex-col"
      >
        <div className="flex items-center justify-between px-5 py-4 border-b border-gray-200">
          <h2 className="text-lg font-bold text-gray-800">Your Cart ({count})</h2>
          <button
            onClick={() => document.getElementById('cart-drawer').classList.add('translate-x-full')}
            className="text-gray-400 hover:text-gray-700 text-2xl leading-none"
          >×</button>
        </div>

        <div className="flex-grow overflow-y-auto px-5 py-4 space-y-4">
          {cart.length === 0 ? (
            <div className="text-center py-16 text-gray-400">
              <p className="text-4xl mb-3">🛒</p>
              <p className="font-semibold">Your cart is empty</p>
              <p className="text-sm mt-1">Browse products and add items</p>
            </div>
          ) : cart.map(item => (
            <div key={item.ListingID} className="flex gap-3 items-start bg-gray-50 rounded-xl p-3">
              {item.imageURL ? (
                <img src={item.imageURL} alt={item.title} className="w-12 h-12 rounded-lg object-cover flex-shrink-0" />
              ) : (
                <div className="w-12 h-12 rounded-lg bg-gray-200 flex-shrink-0" />
              )}
              <div className="flex-grow min-w-0">
                <p className="font-semibold text-sm text-gray-800 truncate">{item.title}</p>
                <p className="text-xs text-gray-500">{item.sellerName}</p>
                <p className="text-[#819360] font-bold text-sm mt-0.5">
                  ${(parseFloat(item.price) * item.quantity).toFixed(2)}
                  <span className="text-gray-400 font-normal"> (${parseFloat(item.price).toFixed(2)} / {item.unitLabel})</span>
                </p>
                <div className="flex items-center gap-2 mt-2">
                  <button onClick={() => updateQty(item.ListingID, -1, item.quantityAvailable)}
                    className="w-6 h-6 rounded-full bg-gray-200 hover:bg-gray-300 text-sm font-bold flex items-center justify-center">−</button>
                  <span className="text-sm font-semibold w-6 text-center">{item.quantity}</span>
                  <button onClick={() => updateQty(item.ListingID, +1, item.quantityAvailable)}
                    className="w-6 h-6 rounded-full bg-gray-200 hover:bg-gray-300 text-sm font-bold flex items-center justify-center">+</button>
                  <button onClick={() => removeFromCart(item.ListingID)}
                    className="ml-auto text-xs text-red-400 hover:text-red-600">Remove</button>
                </div>
              </div>
            </div>
          ))}
        </div>

        {cart.length > 0 && (
          <div className="px-5 py-4 border-t border-gray-200 bg-white">
            <div className="flex justify-between text-sm text-gray-600 mb-1">
              <span>Subtotal</span>
              <span>${cartTotal.toFixed(2)}</span>
            </div>
            <div className="flex justify-between text-sm text-gray-400 mb-4">
              <span>Service fee (2.5%)</span>
              <span>${(cartTotal * 0.025).toFixed(2)}</span>
            </div>
            <div className="flex justify-between font-bold text-lg mb-4">
              <span>Total</span>
              <span className="text-[#819360]">${(cartTotal * 1.025).toFixed(2)}</span>
            </div>

            {/* Inline sign-in form — expands when not logged in */}
            {!isLoggedIn && showSignIn && (
              <div className="mb-4 bg-gray-50 rounded-xl p-4 border border-gray-200">
                <p className="text-sm font-bold text-gray-700 mb-3">Sign in to place your order</p>
                {signInError && (
                  <p className="text-xs text-red-600 bg-red-50 border border-red-200 rounded-lg px-3 py-2 mb-3">{signInError}</p>
                )}
                <form onSubmit={handleSignIn} className="space-y-3">
                  <input
                    type="email"
                    placeholder="Email address"
                    value={signInEmail}
                    onChange={e => setSignInEmail(e.target.value)}
                    required
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-[#819360]"
                  />
                  <input
                    type="password"
                    placeholder="Password"
                    value={signInPass}
                    onChange={e => setSignInPass(e.target.value)}
                    required
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-[#819360]"
                  />
                  <button
                    type="submit"
                    disabled={signInLoading}
                    className="w-full bg-[#A3301E] hover:bg-[#8a2718] text-white font-bold py-2.5 rounded-lg text-sm uppercase tracking-wider disabled:opacity-60"
                  >
                    {signInLoading ? 'Signing In...' : 'Sign In & Place Order'}
                  </button>
                </form>
                <p className="text-center text-xs text-gray-400 mt-2">
                  No account?{' '}
                  <a href="/signup" className="text-[#819360] font-semibold hover:underline">Sign Up</a>
                </p>
              </div>
            )}

            {isLoggedIn ? (
              <button
                onClick={checkout}
                className="w-full bg-[#2d3a1e] hover:bg-[#3f5229] text-white font-bold py-3 rounded-xl text-sm uppercase tracking-wider transition-colors"
              >
                Place Order
              </button>
            ) : !showSignIn ? (
              <button
                onClick={() => setShowSignIn(true)}
                className="w-full bg-[#2d3a1e] hover:bg-[#3f5229] text-white font-bold py-3 rounded-xl text-sm uppercase tracking-wider transition-colors"
              >
                Place Order
              </button>
            ) : null}
          </div>
        )}
      </div>

      {/* ── Backdrop ── */}
      <div
        id="cart-backdrop"
        className="fixed inset-0 bg-black/30 z-40 hidden"
        onClick={() => document.getElementById('cart-drawer').classList.add('translate-x-full')}
      />

      {/* ── Toast ── */}
      {toastMsg && (
        <Toast key={toastKey} message={toastMsg} onDone={() => setToastMsg('')} />
      )}

      {/* ── Standing-order setup modal ── */}
      {standingTarget && (
        <StandingOrderModal
          listing={standingTarget}
          onCancel={() => setStandingTarget(null)}
          onSubmit={submitStandingOrder}
        />
      )}
    </div>
  );
}

// ── Standing-order setup modal ───────────────────────────────────────────────
function StandingOrderModal({ listing, onCancel, onSubmit }) {
  const [frequency, setFrequency] = useState('weekly');
  const [dayOfWeek, setDayOfWeek] = useState(1); // Mon default
  const [quantity,  setQuantity]  = useState(1);
  const [notes,     setNotes]     = useState('');
  const [saving,    setSaving]    = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    await onSubmit({ frequency, dayOfWeek: parseInt(dayOfWeek), quantity: parseFloat(quantity), notes });
    setSaving(false);
  };

  return (
    <div className="fixed inset-0 bg-black/50 z-[60] flex items-center justify-center p-4" onClick={onCancel}>
      <div className="bg-white rounded-2xl shadow-2xl max-w-md w-full p-5" onClick={e => e.stopPropagation()}>
        <h2 className="text-lg font-bold text-gray-900 mb-1">🔁 Standing order</h2>
        <p className="text-sm text-gray-600 mb-4 truncate">
          {listing.Title} <span className="text-gray-400">· {listing.SellerName}</span>
        </p>

        <form onSubmit={handleSubmit} className="space-y-3">
          <div>
            <label className="block text-xs font-semibold text-gray-700 mb-1">Frequency</label>
            <select value={frequency} onChange={e => setFrequency(e.target.value)}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm">
              <option value="weekly">Weekly</option>
              <option value="biweekly">Every 2 weeks</option>
              <option value="monthly">Monthly</option>
            </select>
          </div>

          {frequency !== 'monthly' && (
            <div>
              <label className="block text-xs font-semibold text-gray-700 mb-1">Day of week</label>
              <select value={dayOfWeek} onChange={e => setDayOfWeek(e.target.value)}
                className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm">
                {['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'].map((d,i) =>
                  <option key={d} value={i}>{d}</option>
                )}
              </select>
            </div>
          )}

          <div>
            <label className="block text-xs font-semibold text-gray-700 mb-1">
              Quantity per delivery {listing.UnitLabel ? `(${listing.UnitLabel})` : ''}
            </label>
            <input type="number" min="0.25" step="0.25" value={quantity}
              onChange={e => setQuantity(e.target.value)} required
              className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
          </div>

          <div>
            <label className="block text-xs font-semibold text-gray-700 mb-1">Notes (optional)</label>
            <textarea value={notes} onChange={e => setNotes(e.target.value)} rows={2}
              placeholder="e.g. drop at back door, ring bell"
              className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
          </div>

          <div className="flex justify-end gap-2 pt-2">
            <button type="button" onClick={onCancel}
              className="px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-100 rounded-lg">
              Cancel
            </button>
            <button type="submit" disabled={saving}
              className="px-4 py-2 text-sm font-bold text-white bg-[#3D6B34] hover:bg-[#2d5225] rounded-lg disabled:opacity-60">
              {saving ? 'Creating…' : 'Create standing order'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// ── Product Card ──────────────────────────────────────────────────────────────
function ProductCard({ listing: l, inCart, onAdd, onView, isRestaurant = false, isSaved = false, onToggleSave = null, onMakeStanding = null }) {
  const wholesale = l.WholesalePrice ? parseFloat(l.WholesalePrice) : null;
  const retail    = l.UnitPrice      ? parseFloat(l.UnitPrice)      : 0;
  const showWholesaleHeadline = isRestaurant && wholesale && wholesale < retail;
  return (
    <div className="bg-white rounded-xl border border-gray-200 overflow-hidden hover:shadow-md hover:border-[#819360] transition-all duration-200 flex flex-col">
      {/* Image / emoji */}
      <div className="relative cursor-pointer" onClick={onView}>
        {l.ImageURL ? (
          <img src={l.ImageURL} alt={l.Title} className="w-full h-44 object-cover" loading="lazy" />
        ) : (
          <div className="w-full h-44 flex items-center justify-center" style={{ background: 'linear-gradient(135deg, #f0f4e8, #dde8c8)' }}>
            <span className="text-6xl">{typeEmoji(l.ProductType)}</span>
          </div>
        )}
        {l.IsOrganic && (
          <span className="absolute top-2 left-2 text-white text-[10px] font-bold px-2 py-0.5 rounded-full uppercase tracking-wide" style={{ backgroundColor: '#3D6B34' }}>Organic</span>
        )}
        {l.QuantityAvailable <= 0 && (
          <div className="absolute inset-0 bg-white/70 flex items-center justify-center">
            <span className="font-bold text-gray-500 text-sm">Out of Stock</span>
          </div>
        )}
        {onToggleSave && (
          <button
            onClick={(e) => { e.stopPropagation(); onToggleSave(); }}
            className="absolute top-2 right-2 w-8 h-8 rounded-full bg-white/90 hover:bg-white shadow flex items-center justify-center text-base"
            title={isSaved ? 'Remove from My Farms' : 'Save this farm to My Farms'}
            aria-label={isSaved ? 'Remove from My Farms' : 'Save to My Farms'}
          >
            {isSaved ? '❤️' : '🤍'}
          </button>
        )}
      </div>

      {/* Info */}
      <div className="p-4 flex flex-col flex-grow">
        <p className="text-[10px] font-semibold uppercase tracking-wider mb-0.5 capitalize" style={{ color: '#819360' }}>
          {l.ProductType?.replace('_', ' ')}{l.CategoryName ? ` · ${l.CategoryName}` : ''}
        </p>
        <h3 className="font-bold text-gray-800 text-sm leading-snug mb-1 cursor-pointer hover:underline line-clamp-2" style={{ color: '#3D6B34' }} onClick={onView}>
          {l.Title}
        </h3>
        <p className="text-xs text-gray-500 mb-2">{l.SellerName} · {l.SellerCity}, {l.SellerState}</p>

        {/* Restaurant-buyer info: availability date, stock, delivery options */}
        <div className="flex flex-wrap gap-1 mb-3">
          {formatAvailability(l.AvailableDate) && (
            <span className="text-[10px] font-semibold px-2 py-0.5 rounded-full" style={{ backgroundColor: '#fff4d6', color: '#8a6a0a' }}>
              📅 {formatAvailability(l.AvailableDate)}
            </span>
          )}
          {l.QuantityAvailable > 0 && (
            <span className="text-[10px] font-semibold px-2 py-0.5 rounded-full bg-gray-100 text-gray-600">
              📦 {Number(l.QuantityAvailable)} {l.UnitLabel || 'avail'}
            </span>
          )}
          {l.PickupAvailable ? (
            <span className="text-[10px] font-semibold px-2 py-0.5 rounded-full" style={{ backgroundColor: '#e8f0dc', color: '#3D6B34' }}>
              🚜 Pickup
            </span>
          ) : null}
          {l.ShippingAvailable ? (
            <span className="text-[10px] font-semibold px-2 py-0.5 rounded-full" style={{ backgroundColor: '#e8f0dc', color: '#3D6B34' }}>
              🚚 Delivery
            </span>
          ) : null}
        </div>

        <div className="mt-auto">
          <div className="flex items-baseline gap-1.5 mb-3 flex-wrap">
            {showWholesaleHeadline ? (
              <>
                <span className="text-[10px] font-bold uppercase tracking-wider px-1.5 py-0.5 rounded" style={{ backgroundColor: '#fff4d6', color: '#8a6a0a' }}>WS</span>
                <span className="text-xl font-bold" style={{ color: '#3D6B34' }}>${wholesale.toFixed(2)}</span>
                <span className="text-xs text-gray-400">/ {l.UnitLabel || 'each'}</span>
                <span className="text-xs text-gray-400 ml-1 line-through">${retail.toFixed(2)}</span>
              </>
            ) : (
              <>
                <span className="text-xl font-bold" style={{ color: '#3D6B34' }}>${retail.toFixed(2)}</span>
                <span className="text-xs text-gray-400">/ {l.UnitLabel || 'each'}</span>
                {wholesale && (
                  <span className="text-xs text-gray-400 ml-1">WS: ${wholesale.toFixed(2)}</span>
                )}
              </>
            )}
          </div>

          {l.QuantityAvailable > 0 ? (
            <button
              onClick={onAdd}
              className="w-full py-2 rounded-lg text-sm font-bold transition-all"
              style={inCart
                ? { backgroundColor: '#e8f0dc', color: '#3D6B34', border: '2px solid #819360' }
                : { backgroundColor: '#3D6B34', color: '#fff', border: '2px solid #3D6B34' }}
            >
              {inCart ? `✓ In Cart (${inCart.quantity})` : 'Add to Cart'}
            </button>
          ) : (
            <button disabled className="w-full py-2 rounded-lg text-sm font-semibold bg-gray-100 text-gray-400 cursor-not-allowed">
              Out of Stock
            </button>
          )}

          {onMakeStanding && (
            <button
              onClick={onMakeStanding}
              className="mt-2 w-full py-1.5 rounded-lg text-xs font-semibold border border-[#3D6B34] text-[#3D6B34] hover:bg-[#e8f0dc]"
              title="Set up a recurring weekly/biweekly/monthly purchase from this farm"
            >
              🔁 Make this a standing order
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

// ── Toast notification ────────────────────────────────────────────────────────
function Toast({ message, onDone }) {
  useEffect(() => {
    const t = setTimeout(onDone, 2500);
    return () => clearTimeout(t);
  }, [onDone]);

  return (
    <div className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 bg-[#2d3a1e] text-white text-sm font-semibold px-5 py-3 rounded-full shadow-lg animate-bounce-once pointer-events-none">
      ✓ {message}
    </div>
  );
}