import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function ProductsInventory() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [savingRow, setSavingRow] = useState(null);
  const [deletingRow, setDeletingRow] = useState(null);
  const [editRows, setEditRows] = useState({});

  useEffect(() => {
    if (BusinessID) LoadBusiness(BusinessID);
    loadProducts();
  }, [BusinessID]);

  async function loadProducts() {
    setLoading(true);
    const data = await fetch(`${API_URL}/api/sfproducts/seller?business_id=${BusinessID}`)
      .then(r => r.json()).catch(() => []);
    setProducts(Array.isArray(data) ? data : []);
    setLoading(false);
  }

  function startEdit(p) {
    setEditRows(prev => ({
      ...prev,
      [p.ProdID]: {
        prodName: p.Title ?? '',
        prodPrice: p.UnitPrice ?? '',
        SalePrice: p.SalePrice ?? '',
        ProdQuantityAvailable: p.QuantityAvailable ?? '',
        Publishproduct: p.Publishproduct ?? 1,
        ProdForSale: p.ProdForSale ?? 1,
      },
    }));
  }

  function updateEditRow(prodId, field, value) {
    setEditRows(prev => ({
      ...prev,
      [prodId]: { ...prev[prodId], [field]: value },
    }));
  }

  async function handleUpdate(prodId) {
    setSavingRow(prodId);
    const row = editRows[prodId];
    const body = {
      prodName: row.prodName,
      prodPrice: parseFloat(row.prodPrice) || 0,
      SalePrice: row.SalePrice === '' ? null : parseFloat(row.SalePrice),
      ProdQuantityAvailable: parseInt(row.ProdQuantityAvailable, 10) || 0,
      Publishproduct: row.Publishproduct ? 1 : 0,
      ProdForSale: row.ProdForSale ? 1 : 0,
    };
    const res = await fetch(`${API_URL}/api/sfproducts/${prodId}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    });
    if (res.ok) {
      setEditRows(prev => { const n = { ...prev }; delete n[prodId]; return n; });
      await loadProducts();
    }
    setSavingRow(null);
  }

  async function handleDelete(prodId) {
    if (!confirm('Delete this product? This cannot be undone.')) return;
    setDeletingRow(prodId);
    await fetch(`${API_URL}/api/sfproducts/${prodId}`, { method: 'DELETE' });
    await loadProducts();
    setDeletingRow(null);
  }

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle="My Products"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Products' }, { label: 'My Products' }]}
    >
      <div className="max-w-full mx-auto space-y-6">

        {/* ── HEADER ── */}
        <div className="bg-white rounded-2xl shadow border border-gray-200 p-6 flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-gray-800 mb-1">Products</h1>
            <p className="text-sm text-gray-500">Manage your marketplace products. Buyers check out through our Stripe-powered cart; platform fees per THE OAT settings.</p>
          </div>
          <Link
            to={`/products/add?BusinessID=${BusinessID}`}
            className="regsubmit2"
            style={{ minWidth: '160px', textAlign: 'center' }}
          >
            + Add Product
          </Link>
        </div>

        {/* ── LIST ── */}
        <div className="bg-white rounded-2xl shadow border border-gray-200 overflow-hidden">
          <div className="px-6 py-4 border-b border-gray-100">
            <h2 className="text-lg font-bold text-gray-800">Inventory</h2>
          </div>

          {loading ? (
            <div className="text-center py-12 text-gray-400">Loading products...</div>
          ) : products.length === 0 ? (
            <div className="text-center py-12 text-gray-400">
              You don't have any products yet.{' '}
              <Link to={`/products/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] font-semibold hover:underline">Add your first product</Link>.
            </div>
          ) : (
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr style={{ backgroundColor: '#F3F4F6' }}>
                  {['Image', 'Name', 'Category', 'Price', 'Sale', 'Qty', 'Published', 'For Sale', 'Actions'].map(h => (
                    <th key={h} style={{ padding: '0.6rem 0.75rem', textAlign: 'left', fontSize: '0.72rem', fontWeight: 600, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.04em', borderBottom: '1px solid #E5E7EB' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {products.map((p, i) => {
                  const isEditing = !!editRows[p.ProdID];
                  const row = editRows[p.ProdID] || {};
                  return (
                    <tr key={p.ProdID} style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa', borderBottom: '1px solid #F3F4F6' }}>

                      {/* Image */}
                      <td style={{ padding: '0.5rem 0.75rem', width: 70 }}>
                        {p.ImageURL ? (
                          <img src={p.ImageURL} alt="" style={{ width: 48, height: 48, objectFit: 'cover', borderRadius: 6 }} />
                        ) : (
                          <div style={{ width: 48, height: 48, backgroundColor: '#F3F4F6', borderRadius: 6, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#9CA3AF', fontSize: 18 }}>📦</div>
                        )}
                      </td>

                      {/* Name */}
                      <td style={{ padding: '0.5rem 0.75rem', fontSize: '0.85rem', fontWeight: 600, color: '#374151' }}>
                        {isEditing ? (
                          <input type="text" value={row.prodName} onChange={e => updateEditRow(p.ProdID, 'prodName', e.target.value)} className="border border-gray-300 rounded px-2 py-1 text-sm focus:outline-none w-full" />
                        ) : (
                          <Link to={`/products/edit/${p.ProdID}?BusinessID=${BusinessID}`} className="hover:underline text-[#3D6B34]">{p.Title}</Link>
                        )}
                      </td>

                      {/* Category */}
                      <td style={{ padding: '0.5rem 0.75rem', fontSize: '0.8rem', color: '#6B7280' }}>
                        {p.CategoryName || '—'}
                      </td>

                      {/* Price */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <div className="flex items-center border border-gray-300 rounded overflow-hidden" style={{ maxWidth: '90px' }}>
                            <span className="px-1 text-gray-400 text-xs bg-gray-50 border-r border-gray-300">$</span>
                            <input type="number" value={row.prodPrice} onChange={e => updateEditRow(p.ProdID, 'prodPrice', e.target.value)} className="px-1.5 py-1 text-xs focus:outline-none w-full" step="0.01" />
                          </div>
                        ) : (
                          <span className="text-sm text-gray-700">${parseFloat(p.UnitPrice || 0).toFixed(2)}</span>
                        )}
                      </td>

                      {/* Sale Price */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <div className="flex items-center border border-gray-300 rounded overflow-hidden" style={{ maxWidth: '90px' }}>
                            <span className="px-1 text-gray-400 text-xs bg-gray-50 border-r border-gray-300">$</span>
                            <input type="number" value={row.SalePrice} onChange={e => updateEditRow(p.ProdID, 'SalePrice', e.target.value)} className="px-1.5 py-1 text-xs focus:outline-none w-full" step="0.01" />
                          </div>
                        ) : (
                          <span className="text-sm text-gray-700">{p.SalePrice ? `$${parseFloat(p.SalePrice).toFixed(2)}` : '—'}</span>
                        )}
                      </td>

                      {/* Qty */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <input type="number" value={row.ProdQuantityAvailable} onChange={e => updateEditRow(p.ProdID, 'ProdQuantityAvailable', e.target.value)} className="border border-gray-300 rounded px-1.5 py-1 text-xs focus:outline-none" style={{ width: 60 }} />
                        ) : (
                          <span className="text-sm text-gray-700">{p.QuantityAvailable ?? 0}</span>
                        )}
                      </td>

                      {/* Publish */}
                      <td style={{ padding: '0.5rem 0.75rem', textAlign: 'center' }}>
                        {isEditing ? (
                          <input type="checkbox" checked={!!row.Publishproduct} onChange={e => updateEditRow(p.ProdID, 'Publishproduct', e.target.checked ? 1 : 0)} />
                        ) : (
                          <span>{p.Publishproduct ? '✓' : '—'}</span>
                        )}
                      </td>

                      {/* For Sale */}
                      <td style={{ padding: '0.5rem 0.75rem', textAlign: 'center' }}>
                        {isEditing ? (
                          <input type="checkbox" checked={!!row.ProdForSale} onChange={e => updateEditRow(p.ProdID, 'ProdForSale', e.target.checked ? 1 : 0)} />
                        ) : (
                          <span>{p.ProdForSale ? '✓' : '—'}</span>
                        )}
                      </td>

                      {/* Actions */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        <div className="flex items-center gap-2">
                          {isEditing ? (
                            <>
                              <button onClick={() => handleUpdate(p.ProdID)} disabled={savingRow === p.ProdID} className="text-xs bg-[#3D6B34] text-white px-2 py-1 rounded hover:bg-[#2e5227] transition-colors disabled:opacity-50">
                                {savingRow === p.ProdID ? '...' : 'Save'}
                              </button>
                              <button onClick={() => setEditRows(prev => { const n = { ...prev }; delete n[p.ProdID]; return n; })} className="text-xs text-gray-500 hover:text-gray-700 px-2 py-1 rounded border border-gray-300">
                                Cancel
                              </button>
                            </>
                          ) : (
                            <>
                              <button onClick={() => startEdit(p)} title="Quick edit">
                                <img src="/images/edit.svg" alt="Edit" width="20" onError={e => e.target.replaceWith(Object.assign(document.createElement('span'), { textContent: '✏️' }))} />
                              </button>
                              <Link to={`/products/edit/${p.ProdID}?BusinessID=${BusinessID}`} className="text-xs text-[#3D6B34] hover:underline">Full Edit</Link>
                              <span className="text-gray-300">|</span>
                              <button onClick={() => handleDelete(p.ProdID)} disabled={deletingRow === p.ProdID} title="Delete">
                                <img src="/images/delete.svg" alt="Delete" width="20" onError={e => e.target.replaceWith(Object.assign(document.createElement('span'), { textContent: '🗑️' }))} />
                              </button>
                            </>
                          )}
                        </div>
                      </td>

                    </tr>
                  );
                })}
              </tbody>
            </table>
          )}
        </div>

      </div>
    </AccountLayout>
  );
}
