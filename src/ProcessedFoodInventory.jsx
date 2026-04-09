import React, { useState, useEffect } from 'react';

const API_URL = import.meta.env.VITE_API_URL;

const STATUS_COLORS = {
  active:   { bg: 'bg-[#e8f0e0]', text: 'text-[#4a6741]', dot: 'bg-[#819360]' },
  inactive: { bg: 'bg-gray-100',  text: 'text-gray-500',  dot: 'bg-gray-400'  },
  low:      { bg: 'bg-amber-50',  text: 'text-amber-700', dot: 'bg-amber-400' },
};

function getStockStatus(item) {
  if (!item.ShowProcessedFood) return 'inactive';
  if (item.Quantity <= 5)       return 'low';
  return 'active';
}

function StatusBadge({ item }) {
  const status = getStockStatus(item);
  const c = STATUS_COLORS[status];
  const labels = { active: 'Active', inactive: 'Inactive', low: 'Low Stock' };
  return (
    <span className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-semibold ${c.bg} ${c.text}`}>
      <span className={`w-1.5 h-1.5 rounded-full ${c.dot}`} />
      {labels[status]}
    </span>
  );
}

export default function ProcessedFoodInventory() {
  const [items, setItems]       = useState([]);
  const [loading, setLoading]   = useState(true);
  const [error, setError]       = useState('');
  const [search, setSearch]     = useState('');
  const [sortBy, setSortBy]     = useState('newest');
  const [showModal, setShowModal] = useState(false);
  const [editing, setEditing]   = useState(null);
  const [saving, setSaving]     = useState(false);
  const [formError, setFormError] = useState('');

  const businessId = localStorage.getItem('business_id');
  const token      = localStorage.getItem('access_token');

  const headers = {
    'Content-Type': 'application/json',
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };

  // ── Fetch listings ────────────────────────────────────────────────────────
  async function fetchItems() {
    setLoading(true);
    setError('');
    try {
      const res  = await fetch(`${API_URL}/api/marketplace/seller/listings?business_id=${businessId}`, { headers });
      const data = await res.json();
      if (!res.ok) throw new Error(data.detail || 'Failed to load inventory');
      setItems(data.filter(i => i.ProductType === 'processed_food'));
    } catch (e) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => { fetchItems(); }, []);

  // ── Derived list ──────────────────────────────────────────────────────────
  const filtered = items
    .filter(i => !search || i.Title?.toLowerCase().includes(search.toLowerCase()) ||
                             i.Description?.toLowerCase().includes(search.toLowerCase()))
    .sort((a, b) => {
      if (sortBy === 'name_asc')    return (a.Title || '').localeCompare(b.Title || '');
      if (sortBy === 'price_asc')   return a.UnitPrice - b.UnitPrice;
      if (sortBy === 'price_desc')  return b.UnitPrice - a.UnitPrice;
      if (sortBy === 'qty_asc')     return a.QuantityAvailable - b.QuantityAvailable;
      return b.SourceID - a.SourceID; // newest
    });

  // ── Modal helpers ─────────────────────────────────────────────────────────
  const emptyForm = {
    Name: '', Description: '', RetailPrice: '', WholesalePrice: '',
    Quantity: '', ShowProcessedFood: true, AvailableDate: '', ImageURL: '',
  };

  function openAdd()  { setEditing(emptyForm); setFormError(''); setShowModal(true); }
  function openEdit(item) {
    setEditing({
      ProcessedFoodID:  item.SourceID,
      Name:             item.Title        || '',
      Description:      item.Description  || '',
      RetailPrice:      item.UnitPrice    ?? '',
      WholesalePrice:   item.WholesalePrice ?? '',
      Quantity:         item.QuantityAvailable ?? '',
      ShowProcessedFood: item.IsActive ?? true,
      AvailableDate:    item.AvailableDate ? item.AvailableDate.split('T')[0] : '',
      ImageURL:         item.ImageURL     || '',
    });
    setFormError('');
    setShowModal(true);
  }
  function closeModal() { setShowModal(false); setEditing(null); }

  async function handleSave(e) {
    e.preventDefault();
    setSaving(true);
    setFormError('');
    try {
      const isNew = !editing.ProcessedFoodID;
      const payload = {
        ...editing,
        BusinessID:    parseInt(businessId),
        RetailPrice:   parseFloat(editing.RetailPrice),
        WholesalePrice: editing.WholesalePrice ? parseFloat(editing.WholesalePrice) : null,
        Quantity:      parseFloat(editing.Quantity),
      };
      const url    = isNew
        ? `${API_URL}/api/marketplace/processed-food`
        : `${API_URL}/api/marketplace/processed-food/${editing.ProcessedFoodID}`;
      const method = isNew ? 'POST' : 'PUT';
      const res    = await fetch(url, { method, headers, body: JSON.stringify(payload) });
      const data   = await res.json();
      if (!res.ok) throw new Error(data.detail || 'Save failed');
      closeModal();
      fetchItems();
    } catch (e) {
      setFormError(e.message);
    } finally {
      setSaving(false);
    }
  }

  async function toggleVisibility(item) {
    try {
      await fetch(`${API_URL}/api/marketplace/processed-food/${item.SourceID}`, {
        method: 'PUT',
        headers,
        body: JSON.stringify({ ShowProcessedFood: !item.IsActive }),
      });
      fetchItems();
    } catch { /* silent */ }
  }

  // ── Stats ─────────────────────────────────────────────────────────────────
  const totalItems    = items.length;
  const activeItems   = items.filter(i => i.IsActive).length;
  const lowStockItems = items.filter(i => i.IsActive && i.QuantityAvailable <= 5).length;
  const totalValue    = items.reduce((s, i) => s + (i.UnitPrice * i.QuantityAvailable), 0);

  // ── Render ────────────────────────────────────────────────────────────────
  return (
    <div className="min-h-screen bg-[#f7f5f0] font-sans">

      {/* Header */}
      <div className="bg-white border-b border-gray-200 px-6 py-5">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-gray-900 font-lora">Processed Food Inventory</h1>
            <p className="text-sm text-gray-500 mt-0.5">Manage your value-added and processed food listings</p>
          </div>
          <button
            onClick={openAdd}
            className="bg-[#819360] hover:bg-[#3D6B35] text-white font-semibold px-5 py-2.5 rounded-xl text-sm transition-colors flex items-center gap-2"
          >
            <span className="text-lg leading-none">+</span> Add Item
          </button>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-6 py-8">

        {/* Stats row */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
          {[
            { label: 'Total Items',   value: totalItems,                      color: 'text-gray-800' },
            { label: 'Active',        value: activeItems,                     color: 'text-[#819360]' },
            { label: 'Low Stock',     value: lowStockItems,                   color: 'text-amber-600' },
            { label: 'Inventory Value', value: `$${totalValue.toFixed(2)}`,   color: 'text-gray-800' },
          ].map(s => (
            <div key={s.label} className="bg-white rounded-2xl px-5 py-4 shadow-sm border border-gray-100">
              <p className="text-xs text-gray-400 uppercase tracking-wider font-semibold">{s.label}</p>
              <p className={`text-2xl font-bold mt-1 ${s.color}`}>{s.value}</p>
            </div>
          ))}
        </div>

        {/* Filters */}
        <div className="flex flex-col sm:flex-row gap-3 mb-6">
          <input
            type="text"
            placeholder="Search items..."
            value={search}
            onChange={e => setSearch(e.target.value)}
            className="flex-1 border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20 bg-white"
          />
          <select
            value={sortBy}
            onChange={e => setSortBy(e.target.value)}
            className="border border-gray-200 rounded-xl px-4 py-2.5 text-sm bg-white focus:outline-none focus:border-[#819360] text-gray-600"
          >
            <option value="newest">Newest First</option>
            <option value="name_asc">Name A–Z</option>
            <option value="price_asc">Price: Low–High</option>
            <option value="price_desc">Price: High–Low</option>
            <option value="qty_asc">Quantity: Low–High</option>
          </select>
        </div>

        {/* Error */}
        {error && (
          <div className="bg-red-50 border border-red-200 text-red-700 rounded-xl px-4 py-3 mb-6 text-sm">
            {error}
          </div>
        )}

        {/* Loading */}
        {loading && (
          <div className="text-center py-20 text-gray-400 text-sm">Loading inventory...</div>
        )}

        {/* Empty state */}
        {!loading && !error && filtered.length === 0 && (
          <div className="text-center py-20 bg-white rounded-2xl border border-dashed border-gray-200">
            <p className="text-4xl mb-3">🫙</p>
            <p className="text-gray-500 font-medium">No processed food items yet</p>
            <p className="text-gray-400 text-sm mt-1">Add jams, sauces, baked goods, and more</p>
            <button onClick={openAdd} className="mt-5 bg-[#819360] text-white px-5 py-2 rounded-xl text-sm font-semibold hover:bg-[#6a7a4f] transition-colors">
              Add Your First Item
            </button>
          </div>
        )}

        {/* Table */}
        {!loading && filtered.length > 0 && (
          <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-gray-100 bg-[#f9faf7]">
                  <th className="text-left px-5 py-3.5 text-xs font-semibold text-gray-500 uppercase tracking-wider">Item</th>
                  <th className="text-left px-5 py-3.5 text-xs font-semibold text-gray-500 uppercase tracking-wider hidden md:table-cell">Retail Price</th>
                  <th className="text-left px-5 py-3.5 text-xs font-semibold text-gray-500 uppercase tracking-wider hidden md:table-cell">Wholesale</th>
                  <th className="text-left px-5 py-3.5 text-xs font-semibold text-gray-500 uppercase tracking-wider">Qty</th>
                  <th className="text-left px-5 py-3.5 text-xs font-semibold text-gray-500 uppercase tracking-wider">Status</th>
                  <th className="text-right px-5 py-3.5 text-xs font-semibold text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {filtered.map(item => (
                  <tr key={item.ListingID} className="hover:bg-[#f9faf7] transition-colors">
                    <td className="px-5 py-4">
                      <div className="flex items-center gap-3">
                        {item.ImageURL ? (
                          <img src={item.ImageURL} alt={item.Title} className="w-10 h-10 rounded-lg object-cover border border-gray-100" />
                        ) : (
                          <div className="w-10 h-10 rounded-lg bg-[#e8f0e0] flex items-center justify-center text-lg">🫙</div>
                        )}
                        <div>
                          <p className="font-semibold text-gray-800">{item.Title}</p>
                          {item.Description && (
                            <p className="text-gray-400 text-xs mt-0.5 line-clamp-1 max-w-[200px]">{item.Description}</p>
                          )}
                        </div>
                      </div>
                    </td>
                    <td className="px-5 py-4 hidden md:table-cell text-gray-700 font-medium">
                      ${item.UnitPrice?.toFixed(2)}
                    </td>
                    <td className="px-5 py-4 hidden md:table-cell text-gray-500">
                      {item.WholesalePrice ? `$${item.WholesalePrice.toFixed(2)}` : '—'}
                    </td>
                    <td className="px-5 py-4">
                      <span className={`font-semibold ${item.QuantityAvailable <= 5 ? 'text-amber-600' : 'text-gray-700'}`}>
                        {item.QuantityAvailable}
                      </span>
                    </td>
                    <td className="px-5 py-4">
                      <StatusBadge item={item} />
                    </td>
                    <td className="px-5 py-4 text-right">
                      <div className="flex items-center justify-end gap-2">
                        <button
                          onClick={() => toggleVisibility(item)}
                          className="text-xs px-3 py-1.5 rounded-lg border border-gray-200 text-gray-500 hover:bg-gray-50 transition-colors"
                        >
                          {item.IsActive ? 'Hide' : 'Show'}
                        </button>
                        <button
                          onClick={() => openEdit(item)}
                          className="text-xs px-3 py-1.5 rounded-lg bg-[#819360] text-white hover:bg-[#6a7a4f] transition-colors font-medium"
                        >
                          Edit
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Add/Edit Modal */}
      {showModal && editing && (
        <div className="fixed inset-0 bg-black/40 backdrop-blur-sm flex items-center justify-center z-50 px-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto">
            <div className="bg-[#819360] px-6 py-5 rounded-t-2xl">
              <h2 className="text-white font-bold text-lg font-lora">
                {editing.ProcessedFoodID ? 'Edit Item' : 'Add New Item'}
              </h2>
            </div>
            <form onSubmit={handleSave} className="px-6 py-6 space-y-4">
              {formError && (
                <div className="bg-red-50 border border-red-200 text-red-700 rounded-xl px-4 py-3 text-sm">
                  {formError}
                </div>
              )}

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1.5 uppercase tracking-wide">Name</label>
                <input
                  required
                  value={editing.Name}
                  onChange={e => setEditing(p => ({ ...p, Name: e.target.value }))}
                  placeholder="e.g. Strawberry Jam, Hot Sauce..."
                  className="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1.5 uppercase tracking-wide">Description <span className="text-gray-400 normal-case font-normal">(Optional)</span></label>
                <textarea
                  value={editing.Description}
                  onChange={e => setEditing(p => ({ ...p, Description: e.target.value }))}
                  rows={3}
                  placeholder="Ingredients, flavor notes, size..."
                  className="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20 resize-none"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-gray-600 mb-1.5 uppercase tracking-wide">Retail Price</label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm">$</span>
                    <input
                      required type="number" min="0" step="0.01"
                      value={editing.RetailPrice}
                      onChange={e => setEditing(p => ({ ...p, RetailPrice: e.target.value }))}
                      placeholder="0.00"
                      className="w-full border border-gray-200 rounded-xl pl-7 pr-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20"
                    />
                  </div>
                </div>
                <div>
                  <label className="block text-xs font-semibold text-gray-600 mb-1.5 uppercase tracking-wide">Wholesale Price <span className="text-gray-400 normal-case font-normal">(Optional)</span></label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm">$</span>
                    <input
                      type="number" min="0" step="0.01"
                      value={editing.WholesalePrice}
                      onChange={e => setEditing(p => ({ ...p, WholesalePrice: e.target.value }))}
                      placeholder="0.00"
                      className="w-full border border-gray-200 rounded-xl pl-7 pr-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20"
                    />
                  </div>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-gray-600 mb-1.5 uppercase tracking-wide">Quantity</label>
                  <input
                    required type="number" min="0" step="1"
                    value={editing.Quantity}
                    onChange={e => setEditing(p => ({ ...p, Quantity: e.target.value }))}
                    placeholder="0"
                    className="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-gray-600 mb-1.5 uppercase tracking-wide">Available Date <span className="text-gray-400 normal-case font-normal">(Optional)</span></label>
                  <input
                    type="date"
                    value={editing.AvailableDate}
                    onChange={e => setEditing(p => ({ ...p, AvailableDate: e.target.value }))}
                    className="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20"
                  />
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-gray-600 mb-1.5 uppercase tracking-wide">Image URL <span className="text-gray-400 normal-case font-normal">(Optional)</span></label>
                <input
                  type="url"
                  value={editing.ImageURL}
                  onChange={e => setEditing(p => ({ ...p, ImageURL: e.target.value }))}
                  placeholder="https://..."
                  className="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20"
                />
              </div>

              <div className="flex items-center gap-3 pt-1">
                <button
                  type="button"
                  onClick={() => setEditing(p => ({ ...p, ShowProcessedFood: !p.ShowProcessedFood }))}
                  className={`relative w-11 h-6 rounded-full transition-colors ${editing.ShowProcessedFood ? 'bg-[#819360]' : 'bg-gray-300'}`}
                >
                  <span className={`absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform ${editing.ShowProcessedFood ? 'translate-x-5' : 'translate-x-0'}`} />
                </button>
                <span className="text-sm text-gray-600 font-medium">
                  {editing.ShowProcessedFood ? 'Visible in marketplace' : 'Hidden from marketplace'}
                </span>
              </div>

              <div className="flex justify-end gap-3 pt-2">
                <button
                  type="button" onClick={closeModal}
                  className="border border-gray-200 text-gray-600 font-semibold px-5 py-2.5 rounded-xl text-sm hover:bg-gray-50 transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit" disabled={saving}
                  className="bg-[#819360] hover:bg-[#3D6B35] text-white font-semibold px-6 py-2.5 rounded-xl text-sm transition-colors disabled:opacity-60"
                >
                  {saving ? 'Saving...' : (editing.ProcessedFoodID ? 'Save Changes' : 'Add Item')}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}