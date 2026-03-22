// src/SellerListings.jsx
import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

export default function SellerListings() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [listings, setListings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showAdd, setShowAdd] = useState(false);
  const [saving, setSaving] = useState(false);
  const [form, setForm] = useState({
    ProductType: 'produce', Title: '', Description: '', CategoryName: '', UnitPrice: '', WholesalePrice: '',
    UnitLabel: 'each', QuantityAvailable: '', MinOrderQuantity: '1', ImageURL: '', IsOrganic: false,
    Weight: '', WeightUnit: 'lb', Tags: '', DeliveryOptions: 'pickup',
  });

  useEffect(() => { if (BusinessID) { LoadBusiness(BusinessID); load(); } }, [BusinessID]);

  const load = async () => {
    setLoading(true);
    try {
      const res = await fetch(`${API}/api/marketplace/listings/seller/${BusinessID}`);
      const data = await res.json();
      setListings(data.listings || []);
    } catch {} finally { setLoading(false); }
  };

  const handleAdd = async (e) => {
    e.preventDefault();
    setSaving(true);
    try {
      const res = await fetch(`${API}/api/marketplace/listings`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, BusinessID: parseInt(BusinessID), SourceID: 0,
          UnitPrice: parseFloat(form.UnitPrice), WholesalePrice: form.WholesalePrice ? parseFloat(form.WholesalePrice) : null,
          QuantityAvailable: parseFloat(form.QuantityAvailable || '0'), MinOrderQuantity: parseFloat(form.MinOrderQuantity || '1'),
          Weight: form.Weight ? parseFloat(form.Weight) : null }),
      });
      if (res.ok) {
        setShowAdd(false);
        setForm({ ProductType: 'produce', Title: '', Description: '', CategoryName: '', UnitPrice: '', WholesalePrice: '',
          UnitLabel: 'each', QuantityAvailable: '', MinOrderQuantity: '1', ImageURL: '', IsOrganic: false,
          Weight: '', WeightUnit: 'lb', Tags: '', DeliveryOptions: 'pickup' });
        load();
      }
    } catch {} finally { setSaving(false); }
  };

  const toggleActive = async (id, current) => {
    await fetch(`${API}/api/marketplace/listings/${id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ IsActive: current ? 0 : 1 }),
    });
    load();
  };

  const inputCls = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
  const labelCls = "block text-xs font-medium text-gray-500 mb-1";

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="max-w-5xl mx-auto space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-800">Marketplace Listings</h1>
          <button onClick={() => setShowAdd(!showAdd)}
            className="bg-[#819360] text-white font-semibold px-5 py-2 rounded-lg hover:bg-[#6a7a4e]">
            {showAdd ? 'Cancel' : '+ Add Listing'}
          </button>
        </div>

        {showAdd && (
          <div className="bg-white rounded-xl border border-gray-200 p-6">
            <h2 className="font-bold text-gray-700 mb-4">New Listing</h2>
            <form onSubmit={handleAdd}>
              <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                <div>
                  <label className={labelCls}>Product Type</label>
                  <select value={form.ProductType} onChange={e => setForm(f => ({ ...f, ProductType: e.target.value }))} className={inputCls}>
                    <option value="produce">Produce</option>
                    <option value="meat">Meat</option>
                    <option value="processed_food">Value Added / Processed</option>
                  </select>
                </div>
                <div className="col-span-2">
                  <label className={labelCls}>Title</label>
                  <input value={form.Title} onChange={e => setForm(f => ({ ...f, Title: e.target.value }))} className={inputCls} required placeholder="e.g. Fresh Organic Strawberries" />
                </div>
                <div className="col-span-3">
                  <label className={labelCls}>Description</label>
                  <textarea value={form.Description} onChange={e => setForm(f => ({ ...f, Description: e.target.value }))} className={inputCls} rows={2} placeholder="Describe your product..." />
                </div>
                <div>
                  <label className={labelCls}>Category</label>
                  <input value={form.CategoryName} onChange={e => setForm(f => ({ ...f, CategoryName: e.target.value }))} className={inputCls} placeholder="Berries, Beef, Jams..." />
                </div>
                <div>
                  <label className={labelCls}>Retail Price</label>
                  <input type="number" step="0.01" value={form.UnitPrice} onChange={e => setForm(f => ({ ...f, UnitPrice: e.target.value }))} className={inputCls} required placeholder="0.00" />
                </div>
                <div>
                  <label className={labelCls}>Wholesale Price</label>
                  <input type="number" step="0.01" value={form.WholesalePrice} onChange={e => setForm(f => ({ ...f, WholesalePrice: e.target.value }))} className={inputCls} placeholder="0.00" />
                </div>
                <div>
                  <label className={labelCls}>Unit</label>
                  <select value={form.UnitLabel} onChange={e => setForm(f => ({ ...f, UnitLabel: e.target.value }))} className={inputCls}>
                    {['each', 'lb', 'oz', 'kg', 'dozen', 'bushel', 'pint', 'quart', 'gallon', 'flat', 'case', 'bundle'].map(u => <option key={u} value={u}>{u}</option>)}
                  </select>
                </div>
                <div>
                  <label className={labelCls}>Quantity Available</label>
                  <input type="number" value={form.QuantityAvailable} onChange={e => setForm(f => ({ ...f, QuantityAvailable: e.target.value }))} className={inputCls} placeholder="0" />
                </div>
                <div>
                  <label className={labelCls}>Min Order Qty</label>
                  <input type="number" value={form.MinOrderQuantity} onChange={e => setForm(f => ({ ...f, MinOrderQuantity: e.target.value }))} className={inputCls} />
                </div>
                <div className="col-span-2">
                  <label className={labelCls}>Image URL</label>
                  <input value={form.ImageURL} onChange={e => setForm(f => ({ ...f, ImageURL: e.target.value }))} className={inputCls} placeholder="https://..." />
                </div>
                <div>
                  <label className={labelCls}>Tags (comma separated)</label>
                  <input value={form.Tags} onChange={e => setForm(f => ({ ...f, Tags: e.target.value }))} className={inputCls} placeholder="organic, grass-fed" />
                </div>
                <div className="flex items-end gap-4">
                  <label className="flex items-center gap-2 text-sm">
                    <input type="checkbox" checked={form.IsOrganic} onChange={e => setForm(f => ({ ...f, IsOrganic: e.target.checked }))} /> Organic
                  </label>
                </div>
              </div>
              <div className="flex justify-end mt-4">
                <button type="submit" disabled={saving} className="bg-[#819360] text-white font-semibold px-6 py-2 rounded-lg hover:bg-[#6a7a4e] disabled:opacity-50">
                  {saving ? 'Saving...' : 'Create Listing'}
                </button>
              </div>
            </form>
          </div>
        )}

        {loading ? <div className="text-center py-12 text-gray-400">Loading...</div> :
          listings.length === 0 ? <div className="text-center py-12 text-gray-400">No listings yet. Create your first listing above!</div> :
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <table className="w-full">
              <thead>
                <tr className="bg-gray-50 text-left text-xs font-semibold text-gray-500 uppercase">
                  <th className="px-4 py-3">Product</th>
                  <th className="px-4 py-3">Type</th>
                  <th className="px-4 py-3">Price</th>
                  <th className="px-4 py-3">Available</th>
                  <th className="px-4 py-3">Status</th>
                  <th className="px-4 py-3">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {listings.map(l => (
                  <tr key={l.ListingID} className={l.IsActive ? '' : 'opacity-50'}>
                    <td className="px-4 py-3">
                      <p className="font-semibold text-sm text-gray-800">{l.Title}</p>
                      <p className="text-xs text-gray-400">{l.CategoryName}</p>
                    </td>
                    <td className="px-4 py-3 text-sm text-gray-600 capitalize">{l.ProductType?.replace('_', ' ')}</td>
                    <td className="px-4 py-3 text-sm font-bold text-[#819360]">${parseFloat(l.UnitPrice).toFixed(2)}/{l.UnitLabel}</td>
                    <td className="px-4 py-3 text-sm text-gray-600">{l.QuantityAvailable}</td>
                    <td className="px-4 py-3">
                      <span className={`text-xs font-semibold px-2 py-0.5 rounded ${l.IsActive ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                        {l.IsActive ? 'Active' : 'Inactive'}
                      </span>
                    </td>
                    <td className="px-4 py-3">
                      <button onClick={() => toggleActive(l.ListingID, l.IsActive)}
                        className="text-xs text-blue-600 hover:underline mr-3">
                        {l.IsActive ? 'Deactivate' : 'Activate'}
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        }
      </div>
    </AccountLayout>
  );
}
