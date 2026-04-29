import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function ProduceInventory() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  // Lookup data
  const [categories, setCategories] = useState([]);
  const [ingredients, setIngredients] = useState([]);
  const [measurements, setMeasurements] = useState([]);

  // Inventory
  const [inventory, setInventory] = useState([]);
  const [loadingInventory, setLoadingInventory] = useState(true);

  // Add form
  const [addForm, setAddForm] = useState({
    IngredientCategoryID: '',
    IngredientID: '',
    Quantity: '',
    MeasurementID: '',
    WholesalePrice: '',
    RetailPrice: '',
    AvailableDate: '',
  });
  const [adding, setAdding] = useState(false);
  const [addSuccess, setAddSuccess] = useState(false);

  // Inline edit state: { [ProduceID]: { ...fields } }
  const [editRows, setEditRows] = useState({});
  const [savingRow, setSavingRow] = useState(null);
  const [deletingRow, setDeletingRow] = useState(null);

  useEffect(() => {
    LoadBusiness(BusinessID);
    loadLookups();
    loadInventory();
  }, [BusinessID]);

  async function loadLookups() {
    const [catRes, measRes] = await Promise.all([
      fetch(`${API_URL}/api/produce/categories`).then(r => r.json()).catch(() => []),
      fetch(`${API_URL}/api/produce/measurements`).then(r => r.json()).catch(() => []),
    ]);
    setCategories(Array.isArray(catRes) ? catRes : []);
    setMeasurements(Array.isArray(measRes) ? measRes : []);
  }

  async function loadInventory() {
    setLoadingInventory(true);
    const data = await fetch(`${API_URL}/api/produce/inventory?BusinessID=${BusinessID}`)
      .then(r => r.json()).catch(() => []);
    setInventory(Array.isArray(data) ? data : []);
    setLoadingInventory(false);
  }

  async function handleCategoryChange(catId) {
    setAddForm(f => ({ ...f, IngredientCategoryID: catId, IngredientID: '' }));
    if (!catId) { setIngredients([]); return; }
    const data = await fetch(`${API_URL}/api/produce/ingredients?IngredientCategoryID=${catId}`)
      .then(r => r.json()).catch(() => []);
    setIngredients(Array.isArray(data) ? data : []);
  }

  async function handleAdd(e) {
    e.preventDefault();
    setAdding(true);
    setAddSuccess(false);
    const res = await fetch(`${API_URL}/api/produce/add`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...addForm, BusinessID }),
    });
    if (res.ok) {
      setAddSuccess(true);
      setAddForm({ IngredientCategoryID: '', IngredientID: '', Quantity: '', MeasurementID: '', WholesalePrice: '', RetailPrice: '', AvailableDate: '' });
      setIngredients([]);
      await loadInventory();
    }
    setAdding(false);
  }

  function startEdit(item) {
    setEditRows(prev => ({
      ...prev,
      [item.ProduceID]: {
        Quantity: item.Quantity ?? '',
        MeasurementID: item.MeasurementID ?? '',
        WholesalePrice: item.WholesalePrice ?? '',
        RetailPrice: item.RetailPrice ?? '',
        AvailableDate: item.AvailableDate ? item.AvailableDate.split('T')[0] : '',
        ShowProduce: item.ShowProduce ?? 0,
        IngredientID: item.IngredientID ?? '',
      },
    }));
  }

  function updateEditRow(produceId, field, value) {
    setEditRows(prev => ({
      ...prev,
      [produceId]: { ...prev[produceId], [field]: value },
    }));
  }

  async function handleUpdate(produceId) {
    setSavingRow(produceId);
    const row = editRows[produceId];
    const res = await fetch(`${API_URL}/api/produce/update/${produceId}?BusinessID=${BusinessID}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(row),
    });
    if (res.ok) {
      setEditRows(prev => { const n = { ...prev }; delete n[produceId]; return n; });
      await loadInventory();
    }
    setSavingRow(null);
  }

  async function handleDelete(produceId) {
    if (!confirm('Are you sure you want to delete this produce item?')) return;
    setDeletingRow(produceId);
    await fetch(`${API_URL}/api/produce/delete/${produceId}?BusinessID=${BusinessID}`, { method: 'DELETE' });
    await loadInventory();
    setDeletingRow(null);
  }

  const inputCls = "border border-gray-300 rounded px-2 py-1.5 text-sm focus:outline-none focus:border-[#819360] w-full";
  const labelCls = "block text-xs font-medium text-gray-500 mb-1";

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Produce Inventory" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Inventory' }, { label: 'Produce' }]}>
      <div className="max-w-full mx-auto space-y-6">

        {/* ── ADD PRODUCE FORM ── */}
        <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
          <h1 className="text-2xl font-bold text-gray-800 mb-1">Produce</h1>
          <h2 className="text-base font-semibold text-gray-600 mb-4">Add Produce</h2>

          {addSuccess && (
            <div className="bg-green-50 border border-green-300 text-green-700 rounded px-4 py-2 text-sm mb-4">
              Produce added successfully.
            </div>
          )}

          <form onSubmit={handleAdd}>
            <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-7 gap-3 items-end">

              {/* Category */}
              <div className="col-span-2 md:col-span-1 lg:col-span-1">
                <label className={labelCls}>Ingredient Category</label>
                <select
                  value={addForm.IngredientCategoryID}
                  onChange={e => handleCategoryChange(e.target.value)}
                  className={inputCls}
                  required
                >
                  <option value="">Select category</option>
                  {categories.map(c => (
                    <option key={c.IngredientCategoryID} value={c.IngredientCategoryID}>{c.IngredientCategory}</option>
                  ))}
                </select>
              </div>

              {/* Ingredient */}
              <div className="col-span-2 md:col-span-1 lg:col-span-1">
                <label className={labelCls}>Ingredient</label>
                <select
                  value={addForm.IngredientID}
                  onChange={e => setAddForm(f => ({ ...f, IngredientID: e.target.value }))}
                  className={inputCls}
                  disabled={!ingredients.length}
                  required
                >
                  <option value="">Select ingredient</option>
                  {ingredients.map(i => (
                    <option key={i.IngredientID} value={i.IngredientID}>{i.IngredientName}</option>
                  ))}
                </select>
              </div>

              {/* Quantity */}
              <div>
                <label className={labelCls}>Quantity <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="number" value={addForm.Quantity} onChange={e => setAddForm(f => ({ ...f, Quantity: e.target.value }))} className={inputCls} min="0" />
              </div>

              {/* Measurement */}
              <div>
                <label className={labelCls}>Measurement <span className="text-gray-400 font-normal">(Optional)</span></label>
                <select value={addForm.MeasurementID} onChange={e => setAddForm(f => ({ ...f, MeasurementID: e.target.value }))} className={inputCls}>
                  <option value="">Select</option>
                  {measurements.map(m => (
                    <option key={m.MeasurementID} value={m.MeasurementID}>{m.Measurement} ({m.MeasurementAbbreviation})</option>
                  ))}
                </select>
              </div>

              {/* Wholesale */}
              <div>
                <label className={labelCls}>Wholesale (USD) <span className="text-gray-400 font-normal">(Optional)</span></label>
                <div className="flex items-center border border-gray-300 rounded overflow-hidden focus-within:border-[#819360]">
                  <span className="px-2 text-gray-400 text-sm bg-gray-50 border-r border-gray-300">$</span>
                  <input type="number" value={addForm.WholesalePrice} onChange={e => setAddForm(f => ({ ...f, WholesalePrice: e.target.value }))} className="px-2 py-1.5 text-sm focus:outline-none w-full" step="0.01" min="0" />
                </div>
              </div>

              {/* Retail */}
              <div>
                <label className={labelCls}>Retail (USD) <span className="text-gray-400 font-normal">(Optional)</span></label>
                <div className="flex items-center border border-gray-300 rounded overflow-hidden focus-within:border-[#819360]">
                  <span className="px-2 text-gray-400 text-sm bg-gray-50 border-r border-gray-300">$</span>
                  <input type="number" value={addForm.RetailPrice} onChange={e => setAddForm(f => ({ ...f, RetailPrice: e.target.value }))} className="px-2 py-1.5 text-sm focus:outline-none w-full" step="0.01" min="0" />
                </div>
              </div>

              {/* Available Date */}
              <div>
                <label className={labelCls}>Available Date <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="date" value={addForm.AvailableDate} onChange={e => setAddForm(f => ({ ...f, AvailableDate: e.target.value }))} className={inputCls} />
              </div>

            </div>

            <div className="flex justify-end mt-4">
              <button type="submit" disabled={adding} className="regsubmit2" style={{ minWidth: '160px' }}>
                {adding ? 'Adding...' : 'Add Produce'}
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
            <div className="text-center py-12 text-gray-400">You do not currently have any produce listed.</div>
          ) : (
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr style={{ backgroundColor: '#F3F4F6' }}>
                  {['Ingredient', 'Wholesale', 'Retail', 'Qty', 'Unit', 'Available', 'Show', 'Actions'].map(h => (
                    <th key={h} style={{ padding: '0.6rem 0.75rem', textAlign: 'left', fontSize: '0.72rem', fontWeight: 600, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.04em', borderBottom: '1px solid #E5E7EB' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {inventory.map((item, i) => {
                  const isEditing = !!editRows[item.ProduceID];
                  const row = editRows[item.ProduceID] || {};
                  return (
                    <tr key={item.ProduceID} style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa', borderBottom: '1px solid #F3F4F6' }}>

                      {/* Ingredient name (not editable) */}
                      <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.85rem', fontWeight: 600, color: '#374151' }}>
                        {item.IngredientName}
                      </td>

                      {/* Wholesale */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <div className="flex items-center border border-gray-300 rounded overflow-hidden" style={{ maxWidth: '90px' }}>
                            <span className="px-1 text-gray-400 text-xs bg-gray-50 border-r border-gray-300">$</span>
                            <input type="number" value={row.WholesalePrice} onChange={e => updateEditRow(item.ProduceID, 'WholesalePrice', e.target.value)} className="px-1.5 py-1 text-xs focus:outline-none w-full" step="0.01" />
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
                            <input type="number" value={row.RetailPrice} onChange={e => updateEditRow(item.ProduceID, 'RetailPrice', e.target.value)} className="px-1.5 py-1 text-xs focus:outline-none w-full" step="0.01" />
                          </div>
                        ) : (
                          <span className="text-sm text-gray-700">${parseFloat(item.RetailPrice || 0).toFixed(2)}</span>
                        )}
                      </td>

                      {/* Quantity */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <input type="number" value={row.Quantity} onChange={e => updateEditRow(item.ProduceID, 'Quantity', e.target.value)} className="border border-gray-300 rounded px-1.5 py-1 text-xs focus:outline-none" style={{ width: '60px' }} />
                        ) : (
                          <span className="text-sm text-gray-700">{item.Quantity}</span>
                        )}
                      </td>

                      {/* Measurement */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <select value={row.MeasurementID} onChange={e => updateEditRow(item.ProduceID, 'MeasurementID', e.target.value)} className="border border-gray-300 rounded px-1 py-1 text-xs focus:outline-none" style={{ minWidth: '70px' }}>
                            {measurements.map(m => (
                              <option key={m.MeasurementID} value={m.MeasurementID}>{m.MeasurementAbbreviation}</option>
                            ))}
                          </select>
                        ) : (
                          <span className="text-sm text-gray-700">{item.MeasurementAbbreviation}</span>
                        )}
                      </td>

                      {/* Available Date */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        {isEditing ? (
                          <input type="date" value={row.AvailableDate} onChange={e => updateEditRow(item.ProduceID, 'AvailableDate', e.target.value)} className="border border-gray-300 rounded px-1.5 py-1 text-xs focus:outline-none" />
                        ) : (
                          <span className="text-sm text-gray-700">{item.AvailableDate ? item.AvailableDate.split('T')[0] : '—'}</span>
                        )}
                      </td>

                      {/* Show checkbox */}
                      <td style={{ padding: '0.5rem 0.75rem', textAlign: 'center' }}>
                        {isEditing ? (
                          <input type="checkbox" checked={row.ShowProduce == 1} onChange={e => updateEditRow(item.ProduceID, 'ShowProduce', e.target.checked ? 1 : 0)} />
                        ) : (
                          <span>{item.ShowProduce ? '✓' : '—'}</span>
                        )}
                      </td>

                      {/* Actions */}
                      <td style={{ padding: '0.5rem 0.75rem' }}>
                        <div className="flex items-center gap-2">
                          {isEditing ? (
                            <>
                              <button onClick={() => handleUpdate(item.ProduceID)} disabled={savingRow === item.ProduceID} className="text-xs bg-[#3D6B34] text-white px-2 py-1 rounded hover:bg-[#2e5227] transition-colors disabled:opacity-50">
                                {savingRow === item.ProduceID ? '...' : 'Save'}
                              </button>
                              <button onClick={() => setEditRows(prev => { const n = { ...prev }; delete n[item.ProduceID]; return n; })} className="text-xs text-gray-500 hover:text-gray-700 px-2 py-1 rounded border border-gray-300">
                                Cancel
                              </button>
                            </>
                          ) : (
                            <>
                              <button onClick={() => startEdit(item)} title="Edit" className="text-gray-500 hover:text-[#3D6B34]">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                              </button>
                              <span className="text-gray-300">|</span>
                              <button onClick={() => handleDelete(item.ProduceID)} disabled={deletingRow === item.ProduceID} title="Delete" className="text-gray-500 hover:text-red-600">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>
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
