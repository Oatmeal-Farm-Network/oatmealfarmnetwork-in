// src/MyFoodWantedAds.jsx
// Route: /food-wanted/my-ads  (requires auth)
import React, { useState, useEffect, useCallback } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';
const ACCENT = '#3D6B34';

function authHeaders() {
  const token = localStorage.getItem('access_token');
  return token ? { Authorization: `Bearer ${token}` } : {};
}

const BUYER_TYPES = [
  'Restaurant', 'Artisan Producer', 'Grocery / Retailer',
  'Food Hub', 'Individual', 'Other',
];

const UNITS = ['lbs', 'kg', 'oz', 'cases', 'bushels', 'flats', 'bunches', 'gallons', 'units', 'each', ''];

const BLANK_AD = {
  title: '', description: '', buyer_type: '', delivery_preference: 'either',
  location_city: '', location_state: '', needed_by: '',
};
const BLANK_ITEM = { ingredient_name: '', quantity: '', unit: '', notes: '' };

export default function MyFoodWantedAds() {
  const { BusinessID } = useAccount();
  const [ads, setAds] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showForm, setShowForm] = useState(false);
  const [editing, setEditing] = useState(null);
  const [form, setForm] = useState(BLANK_AD);
  const [items, setItems] = useState([{ ...BLANK_ITEM }]);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState('');
  const [deleting, setDeleting] = useState(null);
  const [expandedAd, setExpandedAd] = useState(null);
  const [responses, setResponses] = useState({});

  const headers = authHeaders();

  const loadAds = useCallback(() => {
    if (!BusinessID) return;
    setLoading(true);
    fetch(`${API}/api/food-wanted/my?business_id=${BusinessID}`, { headers })
      .then(r => r.json())
      .then(d => setAds(Array.isArray(d) ? d : []))
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [BusinessID]);

  useEffect(() => { loadAds(); }, [loadAds]);

  function openCreate() {
    setEditing(null);
    setForm(BLANK_AD);
    setItems([{ ...BLANK_ITEM }]);
    setSaveError('');
    setShowForm(true);
  }

  function openEdit(ad) {
    setEditing(ad.AdID);
    setForm({
      title:               ad.Title              || '',
      description:         ad.Description        || '',
      buyer_type:          ad.BuyerType          || '',
      delivery_preference: ad.DeliveryPreference || 'either',
      location_city:       ad.LocationCity       || '',
      location_state:      ad.LocationState      || '',
      needed_by:           ad.NeededBy           ? ad.NeededBy.split('T')[0] : '',
    });
    setItems(
      ad.items?.length
        ? ad.items.map(i => ({
            ingredient_name: i.IngredientName || '',
            quantity:        i.Quantity       || '',
            unit:            i.Unit           || '',
            notes:           i.Notes          || '',
          }))
        : [{ ...BLANK_ITEM }]
    );
    setSaveError('');
    setShowForm(true);
  }

  function addItem() {
    setItems(prev => [...prev, { ...BLANK_ITEM }]);
  }

  function removeItem(idx) {
    setItems(prev => prev.filter((_, i) => i !== idx));
  }

  function setItemField(idx, field, val) {
    setItems(prev => prev.map((it, i) => i === idx ? { ...it, [field]: val } : it));
  }

  async function saveForm(e) {
    e.preventDefault();
    if (!BusinessID) return;
    setSaving(true); setSaveError('');
    const validItems = items.filter(it => it.ingredient_name.trim());
    const body = { ...form, items: validItems };
    const url = editing
      ? `${API}/api/food-wanted/${editing}`
      : `${API}/api/food-wanted?business_id=${BusinessID}`;
    try {
      const r = await fetch(url, {
        method: editing ? 'PUT' : 'POST',
        headers: { 'Content-Type': 'application/json', ...headers },
        body: JSON.stringify(body),
      });
      if (!r.ok) throw new Error();
      setShowForm(false);
      loadAds();
    } catch {
      setSaveError('Failed to save. Please try again.');
    } finally {
      setSaving(false);
    }
  }

  async function deleteAd(id) {
    if (!window.confirm('Remove this ad?')) return;
    setDeleting(id);
    try {
      await fetch(`${API}/api/food-wanted/${id}`, { method: 'DELETE', headers });
      loadAds();
    } catch {}
    setDeleting(null);
  }

  async function loadResponses(adId) {
    if (expandedAd === adId) { setExpandedAd(null); return; }
    setExpandedAd(adId);
    if (responses[adId]) return;
    try {
      const r = await fetch(`${API}/api/food-wanted/${adId}/responses`, { headers });
      const d = await r.json();
      setResponses(prev => ({ ...prev, [adId]: Array.isArray(d) ? d : [] }));
    } catch {
      setResponses(prev => ({ ...prev, [adId]: [] }));
    }
  }

  const f = form;
  const set = (k, v) => setForm(prev => ({ ...prev, [k]: v }));

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <Header />

      <div className="mx-auto px-4 pt-4" style={{ maxWidth: '1000px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Food Wanted', to: '/marketplaces/food-wanted' },
          { label: 'My Ads' },
        ]} />
      </div>

      <div className="mx-auto px-4 py-6" style={{ maxWidth: '1000px' }}>
        <div className="flex items-center justify-between mb-6">
          <h1 style={{ fontFamily: "'Lora','Times New Roman',serif", fontSize: '1.5rem', fontWeight: 'bold', color: '#111' }}>
            My Food Wanted Ads
          </h1>
          {!showForm && (
            <button onClick={openCreate}
              className="px-5 py-2 rounded-lg text-white font-bold text-sm shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              + New Ad
            </button>
          )}
        </div>

        {/* Create / Edit form */}
        {showForm && (
          <form onSubmit={saveForm} className="bg-white border border-gray-200 rounded-2xl p-6 mb-8 shadow-sm">
            <h2 style={{ fontFamily: "'Lora','Times New Roman',serif" }}
                className="text-lg font-bold text-gray-900 mb-5">
              {editing ? 'Edit Ad' : 'Post a Food Wanted Ad'}
            </h2>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
              <div className="md:col-span-2">
                <label className="block text-xs font-semibold text-gray-600 mb-1">Title <span className="text-red-500">*</span></label>
                <input required value={f.title} onChange={e => set('title', e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                  placeholder="e.g. Looking for heirloom tomatoes and fresh herbs for fall menu" />
              </div>

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">Buyer Type</label>
                <select value={f.buyer_type} onChange={e => set('buyer_type', e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm bg-white">
                  <option value="">Select…</option>
                  {BUYER_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
                </select>
              </div>

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">Delivery Preference</label>
                <select value={f.delivery_preference} onChange={e => set('delivery_preference', e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm bg-white">
                  <option value="either">Pickup or delivery</option>
                  <option value="pickup">Pickup only</option>
                  <option value="delivery">Delivery needed</option>
                </select>
              </div>

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">City</label>
                <input value={f.location_city} onChange={e => set('location_city', e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                  placeholder="e.g. Portland" />
              </div>

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">State / Province</label>
                <input value={f.location_state} onChange={e => set('location_state', e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                  placeholder="e.g. Oregon" />
              </div>

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1">Needed By (optional)</label>
                <input type="date" value={f.needed_by} onChange={e => set('needed_by', e.target.value)}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
              </div>

              <div className="md:col-span-2">
                <label className="block text-xs font-semibold text-gray-600 mb-1">Additional Details</label>
                <textarea value={f.description} onChange={e => set('description', e.target.value)}
                  rows={3} className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm resize-none"
                  placeholder="Describe sourcing preferences, quality standards, certifications needed (organic, local, etc.), frequency, etc." />
              </div>
            </div>

            {/* Ingredient list */}
            <div className="mb-6">
              <div className="flex items-center justify-between mb-3">
                <label className="text-xs font-semibold text-gray-600 uppercase tracking-wide">Ingredients Wanted</label>
                <button type="button" onClick={addItem}
                  className="text-xs font-semibold px-3 py-1 rounded-lg border transition hover:bg-gray-50"
                  style={{ color: ACCENT, borderColor: ACCENT }}>
                  + Add Item
                </button>
              </div>

              <div className="flex flex-col gap-3">
                {items.map((item, idx) => (
                  <div key={idx} className="grid grid-cols-12 gap-2 items-start p-3 bg-gray-50 rounded-xl border border-gray-200">
                    <div className="col-span-12 sm:col-span-4">
                      <input
                        placeholder="Ingredient name *"
                        value={item.ingredient_name}
                        onChange={e => setItemField(idx, 'ingredient_name', e.target.value)}
                        className="w-full border border-gray-300 rounded-lg px-3 py-1.5 text-sm bg-white"
                      />
                    </div>
                    <div className="col-span-5 sm:col-span-2">
                      <input
                        placeholder="Qty"
                        value={item.quantity}
                        onChange={e => setItemField(idx, 'quantity', e.target.value)}
                        className="w-full border border-gray-300 rounded-lg px-3 py-1.5 text-sm bg-white"
                      />
                    </div>
                    <div className="col-span-5 sm:col-span-2">
                      <select value={item.unit} onChange={e => setItemField(idx, 'unit', e.target.value)}
                        className="w-full border border-gray-300 rounded-lg px-2 py-1.5 text-sm bg-white">
                        <option value="">Unit</option>
                        {UNITS.filter(Boolean).map(u => <option key={u} value={u}>{u}</option>)}
                      </select>
                    </div>
                    <div className="col-span-10 sm:col-span-3">
                      <input
                        placeholder="Notes (organic, heirloom…)"
                        value={item.notes}
                        onChange={e => setItemField(idx, 'notes', e.target.value)}
                        className="w-full border border-gray-300 rounded-lg px-3 py-1.5 text-sm bg-white"
                      />
                    </div>
                    <div className="col-span-2 sm:col-span-1 flex items-center justify-center">
                      {items.length > 1 && (
                        <button type="button" onClick={() => removeItem(idx)}
                          className="text-gray-400 hover:text-red-500 transition p-1">
                          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                        </button>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {saveError && <p className="text-sm text-red-600 mb-3">{saveError}</p>}

            <div className="flex gap-3">
              <button type="submit" disabled={saving}
                className="px-6 py-2 rounded-lg text-white font-bold text-sm shadow hover:shadow-md transition disabled:opacity-60"
                style={{ backgroundColor: ACCENT }}>
                {saving ? 'Saving…' : editing ? 'Save Changes' : 'Post Ad'}
              </button>
              <button type="button" onClick={() => setShowForm(false)}
                className="px-6 py-2 rounded-lg font-bold text-sm border border-gray-300 text-gray-600 hover:bg-gray-50 transition">
                Cancel
              </button>
            </div>
          </form>
        )}

        {/* Ads list */}
        {loading ? (
          <div className="text-sm text-gray-400 py-12 text-center">Loading…</div>
        ) : ads.length === 0 ? (
          <div className="text-center py-16 bg-white border border-gray-200 rounded-2xl text-gray-500">
            <svg className="mx-auto mb-3 opacity-30" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.2"><path d="M17 8C8 10 5.9 16.17 3.82 22"/><path d="M9.5 9.5s1-3 4.5-5c0 0 1 3-1 7"/><path d="M3.82 22s1.5-3.5 8.18-4.5"/></svg>
            <p className="font-semibold mb-1">No ads yet</p>
            <p className="text-sm">Post your first food wanted ad and let farms find you.</p>
          </div>
        ) : (
          <div className="flex flex-col gap-4">
            {ads.map(ad => {
              const isExpanded = expandedAd === ad.AdID;
              const adResponses = responses[ad.AdID];
              return (
                <div key={ad.AdID} className="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden">
                  <div className="flex items-start gap-4 p-5">
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1 flex-wrap">
                        {ad.BuyerType && (
                          <span className="text-xs font-bold px-2 py-0.5 rounded-full bg-gray-100 text-gray-600">
                            {ad.BuyerType}
                          </span>
                        )}
                        {!ad.IsActive && (
                          <span className="text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-400">Inactive</span>
                        )}
                      </div>
                      <Link to={`/marketplaces/food-wanted/${ad.AdID}`}
                            className="font-bold text-sm hover:underline" style={{ color: ACCENT }}>
                        {ad.Title}
                      </Link>
                      {ad.items?.length > 0 && (
                        <div className="flex flex-wrap gap-1.5 mt-2">
                          {ad.items.slice(0, 5).map((item, i) => (
                            <span key={i} className="text-xs px-2 py-0.5 rounded-full font-medium"
                                  style={{ backgroundColor: '#f0f7ed', color: ACCENT }}>
                              {item.IngredientName}
                            </span>
                          ))}
                          {ad.items.length > 5 && (
                            <span className="text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-500">
                              +{ad.items.length - 5} more
                            </span>
                          )}
                        </div>
                      )}
                    </div>
                    <div className="flex items-center gap-2 shrink-0">
                      <button onClick={() => loadResponses(ad.AdID)}
                        className="text-xs font-semibold px-3 py-1.5 rounded-lg border border-gray-300 hover:bg-gray-50 transition flex items-center gap-1">
                        {ad.ResponseCount > 0 && (
                          <span className="w-4 h-4 rounded-full text-white text-xs flex items-center justify-center font-bold"
                                style={{ backgroundColor: ACCENT, fontSize: '10px' }}>
                            {ad.ResponseCount}
                          </span>
                        )}
                        {isExpanded ? 'Hide' : 'Responses'}
                      </button>
                      <button onClick={() => openEdit(ad)}
                        className="text-xs font-semibold px-3 py-1.5 rounded-lg border border-gray-300 hover:bg-gray-50 transition">
                        Edit
                      </button>
                      <button onClick={() => deleteAd(ad.AdID)}
                        disabled={deleting === ad.AdID}
                        className="text-xs font-semibold px-3 py-1.5 rounded-lg border border-red-200 text-red-600 hover:bg-red-50 transition disabled:opacity-50">
                        {deleting === ad.AdID ? '…' : 'Remove'}
                      </button>
                    </div>
                  </div>

                  {/* Responses panel */}
                  {isExpanded && (
                    <div className="border-t border-gray-100 bg-gray-50 px-5 py-4">
                      {!adResponses ? (
                        <p className="text-sm text-gray-400">Loading…</p>
                      ) : adResponses.length === 0 ? (
                        <p className="text-sm text-gray-400">No responses yet.</p>
                      ) : (
                        <div className="flex flex-col gap-3">
                          {adResponses.map(resp => (
                            <div key={resp.ResponseID} className="bg-white border border-gray-200 rounded-xl p-4">
                              <div className="flex items-center justify-between mb-1 gap-2 flex-wrap">
                                <p className="font-semibold text-sm text-gray-800">
                                  {resp.FromBusinessName || resp.SenderName || 'Anonymous'}
                                </p>
                                <span className="text-xs text-gray-400">
                                  {new Date(resp.CreatedAt).toLocaleDateString()}
                                </span>
                              </div>
                              {resp.SenderEmail && (
                                <p className="text-xs text-gray-500 mb-1">{resp.SenderEmail}</p>
                              )}
                              <p className="text-sm text-gray-700 leading-relaxed">{resp.Message}</p>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
