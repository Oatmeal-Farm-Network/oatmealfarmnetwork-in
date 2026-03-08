import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function ProcessedFoodInventory() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [categories, setCategories] = useState([]);
  const [inventory, setInventory] = useState([]);
  const [loadingInventory, setLoadingInventory] = useState(true);

  // Add form
  const [addForm, setAddForm] = useState({
    Name: '',
    ProcessedFoodCategoryID: '',
    Quantity: '',
    WholesalePrice: '',
    RetailPrice: '',
  });
  const [adding, setAdding] = useState(false);
  const [addSuccess, setAddSuccess] = useState(false);
  const [addError, setAddError] = useState(null);

  // Inline edit state
  const [editRows, setEditRows] = useState({});
  const [savingRow, setSavingRow] = useState(null);
  const [deletingRow, setDeletingRow] = useState(null);

  useEffect(() => {
    LoadBusiness(BusinessID);
    loadCategories();
    loadInventory();
  }, [BusinessID]);

  async function loadCategories() {
    const data = await fetch(`${API_URL}/api/processed-food/categories`)
      .then(r => r.json()).catch(() => []);
    setCategories(Array.isArray(data) ? data : []);
  }

  async function loadInventory() {
    setLoadingInventory(true);
    const data = await fetch(`${API_URL}/api/processed-food/inventory?BusinessID=${BusinessID}`)
      .then(r => r.json()).catch(() => []);
    setInventory(Array.isArray(data) ? data : []);
    setLoadingInventory(false);
  }

  async function handleAdd(e) {
    e.preventDefault();
    setAdding(true);
    setAddSuccess(false);
    setAddError(null);
    const res = await fetch(`${API_URL}/api/processed-food/add`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...addForm, BusinessID }),
    });
    if (res.ok) {
      setAddSuccess(true);
      setAddForm({ Name: '', ProcessedFoodCategoryID: '', Quantity: '', WholesalePrice: '', RetailPrice: '' });
      await loadInventory();
    } else {
      const d = await res.json().catch(() => ({}));
      setAddError(d.detail || 'An error occurred.');
    }
    setAdding(false);
  }

  function startEdit(item) {
    setEditRows(prev => ({
      ...prev,
      [item.ProcessedFoodID]: {
        Quantity:        item.Quantity ?? '',
        WholesalePrice:  item.WholesalePrice ?? '',
        RetailPrice:     item.RetailPrice ?? '',
        AvailableDate:   item.AvailableDate ? item.AvailableDate.split('T')[0] : '',
        ShowProcessedFood: item.ShowProcessedFood ?? 0,
      },
    }));
  }

  function updateEditRow(id, field, value) {
    setEditRows(prev => ({ ...prev, [id]: { ...prev[id], [field]: value } }));
  }

  async function handleUpdate(id) {
    setSavingRow(id);
    const row = editRows[id];
    const res = await fetch(`${API_URL}/api/processed-food/update/${id}?BusinessID=${BusinessID}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(row),
    });
    if (res.ok) {
      setEditRows(prev => { const n = { ...prev }; delete n[id]; return n; });
      await loadInventory();
    }
    setSavingRow(null);
  }

  async function handleDelete(id) {
    if (!confirm('Are you sure you want to delete this processed food item?')) return;
    setDeletingRow(id);
    await fetch(`${API_URL}/api/processed-food/delete/${id}?BusinessID=${BusinessID}`, { method: 'DELETE' });
    await loadInventory();
    setDeletingRow(null);
  }

  const inputCls = "border border-gray-300 rounded px-2 py-1.5 text-sm focus:outline-none focus:border-[#819360] w-full";
  const labelCls = "block text-xs font-medium text-gray-500 mb-1";

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="max-w-full mx-auto space-y-6">

        {/* ── ADD FORM ── */}
        <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
          <h1 className="text-2xl font-bold text-gray-800 mb-1">Processed Food Inventory</h1>
          <p className="text-sm text-gray-500 mb-4">Jams, sauces, baked goods, etc.</p>
          <h2 className="text-base font-semibold text-gray-600 mb-4">Add Processed Food</h2>

          {addSuccess && (
            <div className="bg-green-50 border border-green-300 text-green-700 rounded px-4 py-2 text-sm mb-4">
              Processed food added successfully.
            </div>
          )}
          {addError && (
            <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-2 text-sm mb-4">
              {addError}
            </div>
          )}

          <form onSubmit={handleAdd}>
            {/* Item Name — full width row */}
            <div className="mb-3">
              <label className={labelCls}>Item Name</label>
              <input
                type="text"
                value={addForm.Name}
                onChange={e => setAddForm(f => ({ ...f, Name: e.target.value }))}
                className={inputCls}
                required
                maxLength={100}
                placeholder="e.g. Strawberry Jam"
              />
            </div>

            {/* Rest of fields in a row */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3 items-end">

              {/* Category */}
              <div>
                <label className={labelCls}>Category</label>
                <select
                  value={addForm.ProcessedFoodCategoryID}
                  onChange={e => setAddForm(f => ({ ...f, ProcessedFoodCategoryID: e.target.value }))}
                  className={inputCls}
                  required
                >
                  <option value="">Select category</option>
                  {categories.map(c => (
                    <option key={c.ProcessedFoodCategoryID} value={c.ProcessedFoodCategoryID}>
                      {c.CategoryName}
                    </option>
                  ))}
                </select>
              </div>

              {/* Quantity */}
              <div>
                <label className={labelCls}># Available</label>
                <input
                  type="number"
                  value={addForm.Quantity}
                  onChange={e => setAddForm(f => ({ ...f, Quantity: e.target.value }))}
                  className={inputCls}
                  min="0"
                />
              </div>

              {/* Wholesale */}
              <div>
                <label className={labelCls}>Wholesale (USD)</label>
                <div className="flex items-center border border-gray-300 rounded overflow-hidden focus-within:border-[#819360]">
                  <span className="px-2 text-gray-400 text-sm bg-gray-50 border-r border-gray-300">$</span>
                  <input
                    type="number"
                    value={addForm.WholesalePrice}
                    onChange={e => setAddForm(f => ({ ...f, WholesalePrice: e.target.value }))}
                    className="px-2 py-1.5 text-sm focus:outline-none w-full"
                    step="0.01" min="0"
                  />
                </div>
              </div>

              {/* Retail */}
              <div>
                <label className={labelCls}>Retail (USD)</label>
                <div className="flex items-center border border-gray-300 rounded overflow-hidden focus-within:border-[#819360]">
                  <span className="px-2 text-gray-400 text-sm bg-gray-50 border-r border-gray-300">$</span>
                  <input
                    type="number"
                    value={addForm.RetailPrice}
                    onChange={e => setAddForm(f => ({ ...f, RetailPrice: e.target.value }))}
                    className="px-2 py-1.5 text-sm focus:outline-none w-full"
                    step="0.01" min="0"
                  />
                </div>
              </div>

            </div>

            <div className="flex justify-end mt-4">
              <button type="submit" disabled={adding} className="regsubmit2" style={{ minWidth: '180px' }}>
                {adding ? 'Adding...' : 'Add Processed Food'}
              </button>
            </div>
          </form>
        </div>

        {/* ── INVENTORY TABLE ── */}
        <div className="bg-white rounded-2xl shadow border border-gray-200 overflow-hidden">
          <div className="px-6 py-4 border-b border-gray-100">
            <h2 className="text-lg font-bold text-gray-800">Inventory</h2>
          </div>

          {loadingInventory ? (
            <div className="text-center py-12 text-gray-400">Loading inventory...</div>
          ) : inventory.length === 0 ? (
            <div className="text-center py-12 text-gray-400">You do not currently have any processed foods listed.</div>
          ) : (
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr style={{ backgroundColor: '#F3F4F6' }}>
                  {['Processed Food', 'Category', 'Wholesale', 'Retail', 'Qty', 'Available', 'Display', 'Options'].map(h => (
                    <th key={h} style={{ padding: '0.6rem 0.75rem', textAlign: 'left', fontSize: '0.72rem', fontWeight: 600, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.04em', borderBottom: '1px solid #E5E7EB' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {inventory.map((item, i) => {
                  const isEditing = !!editRows[item.ProcessedFoodID];
                  const row = editRows[item.ProcessedFoodID] || {};
                  return (
                    <tr key={item.ProcessedFoodID} style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa', borderBottom: '1px solid #F3F4F6' }}>

                      {/* Name */}
                      <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.85rem', fontWeight: 600, color: '#374151' }}>
                        {item.Name}
                      </td>

                      {/* Category */}
                      <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.82rem', color: '#6B7280' }}>
                        {item.CategoryName}
                      </td>

                      {/* Wholesale */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <div className="flex items-center border border-gray-300 rounded overflow-hidden" style={{ maxWidth: '90px' }}>
                            <span className="px-1 text-gray-400 text-xs bg-gray-50 border-r border-gray-300">$</span>
                            <input type="number" value={row.WholesalePrice} onChange={e => updateEditRow(item.ProcessedFoodID, 'WholesalePrice', e.target.value)} className="px-1.5 py-1 text-xs focus:outline-none w-full" step="0.01" />
                          </div>
                        ) : (
                          <span className="text-sm text-gray-700">${parseFloat(item.WholesalePrice || 0).toFixed(2)}</span>
                        )}
                      </td>

                      {/* Retail */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <div className="flex items-center border border-gray-300 rounded overflow-hidden" style={{ maxWidth: '90px' }}>
                            <span className="px-1 text-gray-400 text-xs bg-gray-50 border-r border-gray-300">$</span>
                            <input type="number" value={row.RetailPrice} onChange={e => updateEditRow(item.ProcessedFoodID, 'RetailPrice', e.target.value)} className="px-1.5 py-1 text-xs focus:outline-none w-full" step="0.01" />
                          </div>
                        ) : (
                          <span className="text-sm text-gray-700">${parseFloat(item.RetailPrice || 0).toFixed(2)}</span>
                        )}
                      </td>

                      {/* Quantity */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <input type="number" value={row.Quantity} onChange={e => updateEditRow(item.ProcessedFoodID, 'Quantity', e.target.value)} className="border border-gray-300 rounded px-1.5 py-1 text-xs focus:outline-none" style={{ width: '60px' }} />
                        ) : (
                          <span className="text-sm text-gray-700">{item.Quantity}</span>
                        )}
                      </td>

                      {/* Available Date */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <input type="date" value={row.AvailableDate} onChange={e => updateEditRow(item.ProcessedFoodID, 'AvailableDate', e.target.value)} className="border border-gray-300 rounded px-1.5 py-1 text-xs focus:outline-none" />
                        ) : (
                          <span className="text-sm text-gray-700">{item.AvailableDate ? item.AvailableDate.split('T')[0] : '—'}</span>
                        )}
                      </td>

                      {/* Show checkbox */}
                      <td style={{ padding: '0.5rem 0.75rem', textAlign: 'center' }}>
                        {isEditing ? (
                          <input type="checkbox" checked={row.ShowProcessedFood == 1} onChange={e => updateEditRow(item.ProcessedFoodID, 'ShowProcessedFood', e.target.checked ? 1 : 0)} />
                        ) : (
                          <span>{item.ShowProcessedFood ? '✓' : '—'}</span>
                        )}
                      </td>

                      {/* Actions */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        <div className="flex items-center gap-2">
                          {isEditing ? (
                            <>
                              <button onClick={() => handleUpdate(item.ProcessedFoodID)} disabled={savingRow === item.ProcessedFoodID} className="text-xs bg-[#3D6B34] text-white px-2 py-1 rounded hover:bg-[#2e5227] transition-colors disabled:opacity-50">
                                {savingRow === item.ProcessedFoodID ? '...' : 'Save'}
                              </button>
                              <button onClick={() => setEditRows(prev => { const n = { ...prev }; delete n[item.ProcessedFoodID]; return n; })} className="text-xs text-gray-500 hover:text-gray-700 px-2 py-1 rounded border border-gray-300">
                                Cancel
                              </button>
                            </>
                          ) : (
                            <>
                              <button onClick={() => startEdit(item)} title="Edit">
                                <img src="/images/edit.svg" alt="Edit" width="20" onError={e => { e.target.style.display='none'; e.target.insertAdjacentText('afterend','✏️'); }} />
                              </button>
                              <span className="text-gray-300">|</span>
                              <button onClick={() => handleDelete(item.ProcessedFoodID)} disabled={deletingRow === item.ProcessedFoodID} title="Delete">
                                <img src="/images/delete.svg" alt="Delete" width="20" onError={e => { e.target.style.display='none'; e.target.insertAdjacentText('afterend','🗑️'); }} />
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
