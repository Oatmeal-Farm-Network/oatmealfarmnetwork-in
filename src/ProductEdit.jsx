import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const EMPTY_FORM = {
  prodName: '',
  prodShortDescription: '',
  prodDescription: '',
  prodPrice: '',
  SalePrice: '',
  prodSaleIsActive: 0,
  prodCallforPrice: 0,
  prodCustomorder: 0,
  prodMadeIn: '',
  prodCategoryId: '',
  prodSubCategoryId: '',
  ProdQuantityAvailable: '',
  Materials: '',
  prodWeight: '',
  prodShip: 0,
  prodLength: '',
  prodWidth: '',
  prodHeight: '',
  ProdDimensions: '',
  Publishproduct: 1,
  ProdForSale: 1,
};

const EMPTY_PHOTOS = {
  ProductImage1: '',
  ProductImage2: '',
  ProductImage3: '',
  ProductImage4: '',
  ProductImage5: '',
  ProductImage6: '',
  ProductImage7: '',
  ProductImage8: '',
};

export default function ProductEdit() {
  const { prodId } = useParams(); // undefined for /products/add
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const navigate = useNavigate();
  const { Business, LoadBusiness } = useAccount();

  const isNew = !prodId;
  const [form, setForm] = useState(EMPTY_FORM);
  const [photos, setPhotos] = useState(EMPTY_PHOTOS);
  const [categories, setCategories] = useState([]);
  const [subcategories, setSubcategories] = useState([]);
  const [loading, setLoading] = useState(!isNew);
  const [saving, setSaving] = useState(false);
  const [savedMsg, setSavedMsg] = useState('');

  useEffect(() => {
    if (BusinessID) LoadBusiness(BusinessID);
    loadCategories();
    if (!isNew) loadProduct();
  }, [prodId, BusinessID]);

  useEffect(() => {
    if (form.prodCategoryId) loadSubcategories(form.prodCategoryId);
    else setSubcategories([]);
  }, [form.prodCategoryId]);

  async function loadCategories() {
    const data = await fetch(`${API_URL}/api/sfproducts/categories`).then(r => r.json()).catch(() => []);
    setCategories(Array.isArray(data) ? data : []);
  }

  async function loadSubcategories(catId) {
    const data = await fetch(`${API_URL}/api/sfproducts/categories/${catId}/subcategories`).then(r => r.json()).catch(() => []);
    setSubcategories(Array.isArray(data) ? data : []);
  }

  async function loadProduct() {
    setLoading(true);
    const data = await fetch(`${API_URL}/api/sfproducts/${prodId}`).then(r => r.ok ? r.json() : null).catch(() => null);
    if (data) {
      setForm({
        prodName: data.prodName ?? '',
        prodShortDescription: data.prodShortDescription ?? '',
        prodDescription: data.prodDescription ?? '',
        prodPrice: data.prodPrice ?? '',
        SalePrice: data.SalePrice ?? '',
        prodSaleIsActive: data.prodSaleIsActive ?? 0,
        prodCallforPrice: data.prodCallforPrice ?? 0,
        prodCustomorder: data.prodCustomorder ?? 0,
        prodMadeIn: data.prodMadeIn ?? '',
        prodCategoryId: data.prodCategoryId ?? '',
        prodSubCategoryId: data.prodSubCategoryId ?? '',
        ProdQuantityAvailable: data.ProdQuantityAvailable ?? '',
        Materials: data.Materials ?? '',
        prodWeight: data.prodWeight ?? '',
        prodShip: data.prodShip ?? 0,
        prodLength: data.prodLength ?? '',
        prodWidth: data.prodWidth ?? '',
        prodHeight: data.prodHeight ?? '',
        ProdDimensions: data.ProdDimensions ?? '',
        Publishproduct: data.Publishproduct ?? 1,
        ProdForSale: data.ProdForSale ?? 1,
      });
      const p = Array.isArray(data.photos) ? data.photos : [];
      setPhotos({
        ProductImage1: p[0] || '',
        ProductImage2: p[1] || '',
        ProductImage3: p[2] || '',
        ProductImage4: p[3] || '',
        ProductImage5: p[4] || '',
        ProductImage6: p[5] || '',
        ProductImage7: p[6] || '',
        ProductImage8: p[7] || '',
      });
    }
    setLoading(false);
  }

  function set(field, value) {
    setForm(f => ({ ...f, [field]: value }));
  }

  function numOrNull(v) {
    if (v === '' || v === null || v === undefined) return null;
    const n = parseFloat(v);
    return Number.isFinite(n) ? n : null;
  }
  function intOrNull(v) {
    if (v === '' || v === null || v === undefined) return null;
    const n = parseInt(v, 10);
    return Number.isFinite(n) ? n : null;
  }

  async function handleSave(e) {
    e.preventDefault();
    setSaving(true);
    setSavedMsg('');

    const basePayload = {
      prodName: form.prodName,
      prodShortDescription: form.prodShortDescription || null,
      prodDescription: form.prodDescription || null,
      prodPrice: numOrNull(form.prodPrice) ?? 0.0,
      SalePrice: numOrNull(form.SalePrice),
      prodSaleIsActive: form.prodSaleIsActive ? 1 : 0,
      prodCallforPrice: form.prodCallforPrice ? 1 : 0,
      prodCustomorder: form.prodCustomorder ? 1 : 0,
      prodMadeIn: form.prodMadeIn || null,
      prodCategoryId: intOrNull(form.prodCategoryId),
      prodSubCategoryId: intOrNull(form.prodSubCategoryId),
      ProdQuantityAvailable: intOrNull(form.ProdQuantityAvailable) ?? 0,
      Materials: form.Materials || null,
      prodWeight: numOrNull(form.prodWeight),
      prodShip: form.prodShip ? 1 : 0,
      prodLength: numOrNull(form.prodLength),
      prodWidth: numOrNull(form.prodWidth),
      prodHeight: numOrNull(form.prodHeight),
      ProdDimensions: form.ProdDimensions || null,
      Publishproduct: form.Publishproduct ? 1 : 0,
      ProdForSale: form.ProdForSale ? 1 : 0,
    };

    let activeProdId = prodId;

    if (isNew) {
      const createBody = { ...basePayload, BusinessID: parseInt(BusinessID, 10), PeopleID: parseInt(PeopleID, 10) };
      const res = await fetch(`${API_URL}/api/sfproducts/`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(createBody),
      });
      if (!res.ok) { setSaving(false); alert('Failed to create product.'); return; }
      const created = await res.json();
      activeProdId = created.ProdID;
    } else {
      const res = await fetch(`${API_URL}/api/sfproducts/${prodId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(basePayload),
      });
      if (!res.ok) { setSaving(false); alert('Failed to save product.'); return; }
    }

    // Save photos (even if empty, to keep in sync)
    if (activeProdId) {
      await fetch(`${API_URL}/api/sfproducts/${activeProdId}/photos`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(photos),
      });
    }

    setSaving(false);
    setSavedMsg('Saved.');
    if (isNew && activeProdId) {
      navigate(`/products/edit/${activeProdId}?BusinessID=${BusinessID}`, { replace: true });
    }
  }

  const inputCls = "border border-gray-300 rounded px-2 py-1.5 text-sm focus:outline-none focus:border-[#819360] w-full";
  const labelCls = "block text-xs font-medium text-gray-500 mb-1";

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle={isNew ? 'Add Product' : 'Edit Product'}
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Products', to: `/products?BusinessID=${BusinessID}` },
        { label: isNew ? 'Add' : 'Edit' },
      ]}
    >
      <div className="max-w-5xl mx-auto space-y-6">
        {loading ? (
          <div className="text-center py-12 text-gray-400">Loading product...</div>
        ) : (
        <form onSubmit={handleSave} className="space-y-6">

          {/* Basics */}
          <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
            <h2 className="text-lg font-bold text-gray-800 mb-4">Basics</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="md:col-span-2">
                <label className={labelCls}>Product Name *</label>
                <input required type="text" value={form.prodName} onChange={e => set('prodName', e.target.value)} className={inputCls} />
              </div>
              <div className="md:col-span-2">
                <label className={labelCls}>Short Description</label>
                <input type="text" value={form.prodShortDescription} onChange={e => set('prodShortDescription', e.target.value)} className={inputCls} maxLength={255} />
              </div>
              <div className="md:col-span-2">
                <label className={labelCls}>Full Description</label>
                <textarea value={form.prodDescription} onChange={e => set('prodDescription', e.target.value)} className={`${inputCls} min-h-[120px]`} />
              </div>
              <div>
                <label className={labelCls}>Category</label>
                <select value={form.prodCategoryId} onChange={e => { set('prodCategoryId', e.target.value); set('prodSubCategoryId', ''); }} className={inputCls}>
                  <option value="">Select category</option>
                  {categories.map(c => (
                    <option key={c.CatID} value={c.CatID}>{c.CatName}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className={labelCls}>Subcategory</label>
                <select value={form.prodSubCategoryId} onChange={e => set('prodSubCategoryId', e.target.value)} className={inputCls} disabled={!subcategories.length}>
                  <option value="">Select subcategory</option>
                  {subcategories.map(s => (
                    <option key={s.SubCatID} value={s.SubCatID}>{s.SubCatName}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className={labelCls}>Made In</label>
                <input type="text" value={form.prodMadeIn} onChange={e => set('prodMadeIn', e.target.value)} className={inputCls} placeholder="e.g. Oregon, USA" />
              </div>
              <div>
                <label className={labelCls}>Materials</label>
                <input type="text" value={form.Materials} onChange={e => set('Materials', e.target.value)} className={inputCls} placeholder="e.g. 100% wool" />
              </div>
            </div>
          </div>

          {/* Pricing & Inventory */}
          <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
            <h2 className="text-lg font-bold text-gray-800 mb-4">Pricing & Inventory</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <label className={labelCls}>Price (USD) *</label>
                <div className="flex items-center border border-gray-300 rounded overflow-hidden focus-within:border-[#819360]">
                  <span className="px-2 text-gray-400 text-sm bg-gray-50 border-r border-gray-300">$</span>
                  <input required type="number" value={form.prodPrice} onChange={e => set('prodPrice', e.target.value)} className="px-2 py-1.5 text-sm focus:outline-none w-full" step="0.01" min="0" />
                </div>
              </div>
              <div>
                <label className={labelCls}>Sale Price (USD)</label>
                <div className="flex items-center border border-gray-300 rounded overflow-hidden focus-within:border-[#819360]">
                  <span className="px-2 text-gray-400 text-sm bg-gray-50 border-r border-gray-300">$</span>
                  <input type="number" value={form.SalePrice} onChange={e => set('SalePrice', e.target.value)} className="px-2 py-1.5 text-sm focus:outline-none w-full" step="0.01" min="0" />
                </div>
              </div>
              <div>
                <label className={labelCls}>Quantity Available</label>
                <input type="number" value={form.ProdQuantityAvailable} onChange={e => set('ProdQuantityAvailable', e.target.value)} className={inputCls} min="0" />
              </div>
              <div className="flex items-center gap-2 mt-2">
                <input id="saleActive" type="checkbox" checked={!!form.prodSaleIsActive} onChange={e => set('prodSaleIsActive', e.target.checked ? 1 : 0)} />
                <label htmlFor="saleActive" className="text-sm text-gray-700">Sale is active / featured</label>
              </div>
              <div className="flex items-center gap-2 mt-2">
                <input id="callForPrice" type="checkbox" checked={!!form.prodCallforPrice} onChange={e => set('prodCallforPrice', e.target.checked ? 1 : 0)} />
                <label htmlFor="callForPrice" className="text-sm text-gray-700">Call for price</label>
              </div>
              <div className="flex items-center gap-2 mt-2">
                <input id="customOrder" type="checkbox" checked={!!form.prodCustomorder} onChange={e => set('prodCustomorder', e.target.checked ? 1 : 0)} />
                <label htmlFor="customOrder" className="text-sm text-gray-700">Custom / made-to-order</label>
              </div>
            </div>
          </div>

          {/* Shipping & Handling */}
          <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
            <h2 className="text-lg font-bold text-gray-800 mb-4">Shipping & Handling</h2>
            <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
              <div className="col-span-2 md:col-span-5 flex items-center gap-2">
                <input id="prodShip" type="checkbox" checked={!!form.prodShip} onChange={e => set('prodShip', e.target.checked ? 1 : 0)} />
                <label htmlFor="prodShip" className="text-sm text-gray-700">This product ships (vs. local pickup only)</label>
              </div>
              <div>
                <label className={labelCls}>Weight (lbs)</label>
                <input type="number" value={form.prodWeight} onChange={e => set('prodWeight', e.target.value)} className={inputCls} step="0.01" min="0" />
              </div>
              <div>
                <label className={labelCls}>Length (in)</label>
                <input type="number" value={form.prodLength} onChange={e => set('prodLength', e.target.value)} className={inputCls} step="0.1" min="0" />
              </div>
              <div>
                <label className={labelCls}>Width (in)</label>
                <input type="number" value={form.prodWidth} onChange={e => set('prodWidth', e.target.value)} className={inputCls} step="0.1" min="0" />
              </div>
              <div>
                <label className={labelCls}>Height (in)</label>
                <input type="number" value={form.prodHeight} onChange={e => set('prodHeight', e.target.value)} className={inputCls} step="0.1" min="0" />
              </div>
              <div>
                <label className={labelCls}>Dimensions (text)</label>
                <input type="text" value={form.ProdDimensions} onChange={e => set('ProdDimensions', e.target.value)} className={inputCls} placeholder='e.g. 12" x 8" x 4"' />
              </div>
            </div>
          </div>

          {/* Photos */}
          <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
            <h2 className="text-lg font-bold text-gray-800 mb-4">Photos</h2>
            <p className="text-xs text-gray-500 mb-3">Paste up to 8 image URLs. First image is the cover photo on the marketplace.</p>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
              {[1,2,3,4,5,6,7,8].map(n => {
                const key = `ProductImage${n}`;
                const val = photos[key];
                return (
                  <div key={n} className="flex items-center gap-2">
                    <span className="text-xs text-gray-500 w-6">{n}.</span>
                    <input
                      type="url"
                      value={val}
                      onChange={e => setPhotos(p => ({ ...p, [key]: e.target.value }))}
                      className={inputCls}
                      placeholder="https://..."
                    />
                    {val ? (
                      <img src={val} alt="" style={{ width: 36, height: 36, objectFit: 'cover', borderRadius: 4, border: '1px solid #E5E7EB' }} onError={e => { e.target.style.display = 'none'; }} />
                    ) : null}
                  </div>
                );
              })}
            </div>
          </div>

          {/* Visibility */}
          <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
            <h2 className="text-lg font-bold text-gray-800 mb-4">Marketplace Visibility</h2>
            <div className="space-y-3">
              <div className="flex items-center gap-2">
                <input id="publish" type="checkbox" checked={!!form.Publishproduct} onChange={e => set('Publishproduct', e.target.checked ? 1 : 0)} />
                <label htmlFor="publish" className="text-sm text-gray-700">Show on the Products Marketplace (unchecked = hidden from buyers)</label>
              </div>
              <div className="flex items-center gap-2">
                <input id="forSale" type="checkbox" checked={!!form.ProdForSale} onChange={e => set('ProdForSale', e.target.checked ? 1 : 0)} />
                <label htmlFor="forSale" className="text-sm text-gray-700">For sale (can be added to cart &amp; checked out via Stripe)</label>
              </div>
              <p className="text-xs text-gray-500">Payments route through the platform Stripe account; seller payout and platform fee are handled per THE OAT settings.</p>
            </div>
          </div>

          {/* Actions */}
          <div className="flex justify-end items-center gap-3">
            {savedMsg && <span className="text-sm text-green-700">{savedMsg}</span>}
            <button type="button" onClick={() => navigate(`/products?BusinessID=${BusinessID}`)} className="text-sm px-4 py-2 rounded border border-gray-300 text-gray-700 hover:bg-gray-50">
              Cancel
            </button>
            <button type="submit" disabled={saving} className="regsubmit2" style={{ minWidth: '160px' }}>
              {saving ? 'Saving...' : isNew ? 'Create Product' : 'Save Changes'}
            </button>
          </div>

        </form>
        )}
      </div>
    </AccountLayout>
  );
}
