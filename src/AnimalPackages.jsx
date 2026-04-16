import React, { useEffect, useState, useMemo } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const fmt = (n) => {
  if (!n && n !== 0) return '$0';
  return Number(n).toLocaleString('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 });
};

export default function AnimalPackages() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [packages, setPackages] = useState([]);
  const [animals, setAnimals] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState(null);

  // Form state
  const [editingId, setEditingId] = useState(null);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [packagePrice, setPackagePrice] = useState('');
  const [selectedItems, setSelectedItems] = useState([]); // [{AnimalID, IncludeType:'sale'|'stud', FullName, Price, StudFee}]

  // Animal search
  const [animalQuery, setAnimalQuery] = useState('');

  const apiBase = import.meta.env.VITE_API_URL || '';
  const token = localStorage.getItem('access_token');
  const headers = { Authorization: `Bearer ${token}` };

  const loadPackages = () => {
    fetch(`${apiBase}/auth/packages?BusinessID=${BusinessID}`, { headers })
      .then(r => r.ok ? r.json() : [])
      .then(data => { setPackages(data); setLoading(false); })
      .catch(() => setLoading(false));
  };

  const loadAnimals = () => {
    fetch(`${apiBase}/auth/animals?BusinessID=${BusinessID}`, { headers })
      .then(r => r.ok ? r.json() : [])
      .then(data => setAnimals(Array.isArray(data) ? data : []))
      .catch(() => {});
  };

  useEffect(() => {
    LoadBusiness(BusinessID);
    loadPackages();
    loadAnimals();
  }, [BusinessID]);

  // Computed value of selected animals
  const totalValue = useMemo(() => {
    let total = 0;
    for (const item of selectedItems) {
      if (item.IncludeType === 'stud') {
        total += item.StudFee || 0;
      } else {
        total += item.Price || 0;
      }
    }
    return total;
  }, [selectedItems]);

  // Filter available animals (not already selected)
  const selectedIds = useMemo(() => new Set(selectedItems.map(i => i.AnimalID)), [selectedItems]);
  const filteredAnimals = useMemo(() => {
    let list = animals.filter(a => !selectedIds.has(a.AnimalID));
    const q = animalQuery.trim().toLowerCase();
    if (q) {
      list = list.filter(a =>
        (a.FullName || '').toLowerCase().includes(q) ||
        (a.Category || '').toLowerCase().includes(q) ||
        (a.SpeciesName || '').toLowerCase().includes(q)
      );
    }
    return list;
  }, [animals, selectedIds, animalQuery]);

  const clearForm = () => {
    setEditingId(null);
    setTitle('');
    setDescription('');
    setPackagePrice('');
    setSelectedItems([]);
    setAnimalQuery('');
    setSaveError(null);
  };

  const startEdit = (pkg) => {
    setEditingId(pkg.PackageID);
    setTitle(pkg.Title || '');
    setDescription(pkg.Description || '');
    setPackagePrice(pkg.PackagePrice ? String(pkg.PackagePrice) : '');
    setSelectedItems(
      (pkg.Items || []).map(it => ({
        AnimalID: it.AnimalID,
        IncludeType: it.IncludeType || 'sale',
        FullName: it.FullName,
        Price: it.Price || 0,
        StudFee: it.StudFee || 0,
      }))
    );
    setAnimalQuery('');
    setSaveError(null);
    setShowForm(true);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const addAnimal = (animal, includeType = 'sale') => {
    const price = animal.SalePrice > 0 ? animal.SalePrice : (animal.Price || 0);
    setSelectedItems(prev => [...prev, {
      AnimalID: animal.AnimalID,
      IncludeType: includeType,
      FullName: animal.FullName,
      Price: price,
      StudFee: animal.StudFee || 0,
    }]);
  };

  const removeItem = (animalId) => {
    setSelectedItems(prev => prev.filter(i => i.AnimalID !== animalId));
  };

  const toggleType = (animalId) => {
    setSelectedItems(prev => prev.map(i =>
      i.AnimalID === animalId
        ? { ...i, IncludeType: i.IncludeType === 'sale' ? 'stud' : 'sale' }
        : i
    ));
  };

  const handleSave = async (e) => {
    e.preventDefault();
    if (!title.trim()) return;
    setSaving(true);
    setSaveError(null);
    try {
      const res = await fetch(`${apiBase}/auth/packages/save`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', ...headers },
        body: JSON.stringify({
          PackageID: editingId,
          BusinessID,
          Title: title,
          Description: description,
          PackagePrice: packagePrice ? Number(packagePrice) : 0,
          Items: selectedItems.map(i => ({ AnimalID: i.AnimalID, IncludeType: i.IncludeType })),
        }),
      });
      if (!res.ok) throw new Error('Failed to save package');
      clearForm();
      setShowForm(false);
      loadPackages();
    } catch (err) {
      setSaveError(err.message);
    } finally {
      setSaving(false);
    }
  };

  const handleDelete = async (pkgId) => {
    if (!window.confirm('Delete this package?')) return;
    await fetch(`${apiBase}/auth/packages/delete`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', ...headers },
      body: JSON.stringify({ PackageID: pkgId }),
    });
    loadPackages();
  };

  if (!Business || loading) return <div className="p-8 text-gray-500">Loading...</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Animal Packages" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Livestock' }, { label: 'Packages' }]}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-2xl font-bold text-green-700">Animal Packages</h2>
          <button onClick={() => { if (showForm) { clearForm(); setShowForm(false); } else { clearForm(); setShowForm(true); } }} className="regsubmit2">
            {showForm ? 'Cancel' : 'Create Package'}
          </button>
        </div>

        {showForm && (
          <form onSubmit={handleSave} className="mb-6 border border-gray-200 rounded-lg p-4 bg-gray-50 space-y-4">
            <h3 className="text-lg font-semibold text-[#5a3e2b]">
              {editingId ? 'Edit Package' : 'New Package'}
            </h3>

            {saveError && (
              <div className="p-3 bg-red-50 text-red-700 rounded-lg text-sm">{saveError}</div>
            )}

            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">Package Title</label>
              <input
                type="text"
                value={title}
                onChange={e => setTitle(e.target.value)}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="Starter Herd Package"
              />
            </div>

            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">Description</label>
              <textarea
                value={description}
                onChange={e => setDescription(e.target.value)}
                rows={3}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600 resize-y"
                placeholder="Everything you need to start your herd..."
              />
            </div>

            {/* Animal selector */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Add Animals</label>
              <input
                type="text"
                value={animalQuery}
                onChange={e => setAnimalQuery(e.target.value)}
                className="w-full max-w-lg px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600 mb-2"
                placeholder="Search animals by name, category, or species..."
              />
              {filteredAnimals.length > 0 && (
                <div className="border border-gray-200 rounded-lg max-h-48 overflow-y-auto bg-white">
                  {filteredAnimals.map(a => {
                    const price = a.SalePrice > 0 ? a.SalePrice : (a.Price || 0);
                    const hasStud = a.StudFee > 0;
                    return (
                      <div key={a.AnimalID} className="flex items-center justify-between px-3 py-2 border-b border-gray-50 last:border-b-0 hover:bg-green-50">
                        <div>
                          <span className="font-medium text-[#5a3e2b] text-sm">{a.FullName}</span>
                          <span className="text-gray-400 text-xs ml-2">{a.Category || a.SpeciesName}</span>
                          <span className="text-gray-500 text-xs ml-2">{fmt(price)}</span>
                          {hasStud && <span className="text-blue-500 text-xs ml-2">Stud: {fmt(a.StudFee)}</span>}
                        </div>
                        <div className="flex gap-1">
                          <button type="button" onClick={() => addAnimal(a, 'sale')}
                            className="px-2 py-1 text-xs bg-green-600 text-white rounded hover:bg-green-700">
                            + Sale
                          </button>
                          {hasStud && (
                            <button type="button" onClick={() => addAnimal(a, 'stud')}
                              className="px-2 py-1 text-xs bg-blue-600 text-white rounded hover:bg-blue-700">
                              + Stud
                            </button>
                          )}
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>

            {/* Selected animals */}
            {selectedItems.length > 0 && (
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Package Animals</label>
                <div className="border border-gray-200 rounded-lg bg-white overflow-hidden">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="bg-gray-50 text-left text-xs text-gray-500 uppercase">
                        <th className="px-3 py-2">Animal</th>
                        <th className="px-3 py-2">Type</th>
                        <th className="px-3 py-2 text-right">Value</th>
                        <th className="px-3 py-2 w-10"></th>
                      </tr>
                    </thead>
                    <tbody>
                      {selectedItems.map(item => (
                        <tr key={item.AnimalID} className="border-t border-gray-100">
                          <td className="px-3 py-2 font-medium text-[#5a3e2b]">{item.FullName}</td>
                          <td className="px-3 py-2">
                            <button type="button" onClick={() => item.StudFee > 0 && toggleType(item.AnimalID)}
                              className={`px-2 py-0.5 text-xs rounded font-medium ${
                                item.IncludeType === 'stud'
                                  ? 'bg-blue-100 text-blue-700'
                                  : 'bg-green-100 text-green-700'
                              } ${item.StudFee > 0 ? 'cursor-pointer hover:opacity-80' : 'cursor-default'}`}
                              title={item.StudFee > 0 ? 'Click to toggle sale/stud' : ''}
                            >
                              {item.IncludeType === 'stud' ? 'Stud Fee' : 'Sale'}
                            </button>
                          </td>
                          <td className="px-3 py-2 text-right">
                            {fmt(item.IncludeType === 'stud' ? item.StudFee : item.Price)}
                          </td>
                          <td className="px-3 py-2 text-center">
                            <button type="button" onClick={() => removeItem(item.AnimalID)}
                              className="text-red-400 hover:text-red-600 text-lg leading-none">&times;</button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                    <tfoot>
                      <tr className="border-t-2 border-gray-200 bg-gray-50">
                        <td className="px-3 py-2 font-semibold text-gray-700" colSpan={2}>Total Animal Value</td>
                        <td className="px-3 py-2 text-right font-bold text-green-700">{fmt(totalValue)}</td>
                        <td></td>
                      </tr>
                    </tfoot>
                  </table>
                </div>
              </div>
            )}

            {/* Package price + savings */}
            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">Package Price</label>
              <div className="flex items-center gap-3">
                <div className="relative flex-1">
                  <span className="absolute left-3 top-2 text-gray-400 text-sm">$</span>
                  <input
                    type="number"
                    value={packagePrice}
                    onChange={e => setPackagePrice(e.target.value)}
                    min={0}
                    step="0.01"
                    className="w-full pl-7 pr-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                    placeholder="0"
                  />
                </div>
                {packagePrice && totalValue > 0 && Number(packagePrice) < totalValue && (
                  <span className="text-sm text-green-600 font-medium whitespace-nowrap">
                    Save {fmt(totalValue - Number(packagePrice))} ({Math.round((1 - Number(packagePrice) / totalValue) * 100)}% off)
                  </span>
                )}
              </div>
            </div>

            <div className="flex justify-end">
              <button type="submit" disabled={saving} className="regsubmit2">
                {saving ? 'Saving...' : editingId ? 'Update Package' : 'Save Package'}
              </button>
            </div>
          </form>
        )}

        {/* Package list */}
        {packages.length === 0 && !showForm ? (
          <p className="text-gray-500 text-sm">No packages yet. Create one to bundle animals together at a special price.</p>
        ) : (
          <div className="space-y-4">
            {packages.map(pkg => {
              const itemValue = (pkg.Items || []).reduce((sum, it) => {
                return sum + (it.IncludeType === 'stud' ? (it.StudFee || 0) : (it.Price || 0));
              }, 0);
              const savings = itemValue - (pkg.PackagePrice || 0);
              return (
                <div key={pkg.PackageID} className="border border-gray-100 rounded-lg p-4">
                  <div className="flex justify-between items-start">
                    <div>
                      <h3 className="text-lg font-bold text-[#5a3e2b]">{pkg.Title}</h3>
                      {pkg.Description && <p className="text-sm text-gray-600 mt-1">{pkg.Description}</p>}
                    </div>
                    <div className="text-right">
                      <p className="text-xl font-bold text-green-700">{fmt(pkg.PackagePrice)}</p>
                      {savings > 0 && (
                        <p className="text-xs text-green-600">
                          Save {fmt(savings)} ({Math.round((savings / itemValue) * 100)}% off)
                        </p>
                      )}
                    </div>
                  </div>

                  {(pkg.Items || []).length > 0 && (
                    <div className="mt-3">
                      <div className="flex flex-wrap gap-2">
                        {pkg.Items.map(it => (
                          <span key={it.AnimalID} className={`inline-flex items-center gap-1 px-2 py-1 rounded text-xs font-medium ${
                            it.IncludeType === 'stud' ? 'bg-blue-50 text-blue-700' : 'bg-green-50 text-green-700'
                          }`}>
                            {it.FullName}
                            <span className="text-gray-400">
                              {it.IncludeType === 'stud' ? `(Stud: ${fmt(it.StudFee)})` : `(${fmt(it.Price)})`}
                            </span>
                          </span>
                        ))}
                      </div>
                      <p className="text-xs text-gray-400 mt-2">
                        Total individual value: {fmt(itemValue)}
                      </p>
                    </div>
                  )}

                  <div className="flex gap-3 mt-3">
                    <button onClick={() => startEdit(pkg)}
                      className="text-xs text-[#5a3e2b] hover:underline font-medium">Edit</button>
                    <button onClick={() => handleDelete(pkg.PackageID)}
                      className="text-xs text-red-500 hover:underline font-medium">Delete</button>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
