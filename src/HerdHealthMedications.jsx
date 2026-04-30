import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const CATEGORIES = ['Antibiotic', 'Vaccine', 'Antiparasitic', 'NSAID / Pain', 'Hormone', 'Electrolyte', 'Supplement', 'Antiseptic', 'Sedative', 'Other'];
const STORAGE_REQS = ['Refrigerate 2–8°C', 'Room Temperature', 'Freeze', 'Dark/Cool', 'No Special Requirements'];
const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}
const EMPTY = {
  MedicationName:'', ActiveIngredient:'', Category:'', Manufacturer:'', LotNumber:'',
  ExpirationDate:'', QuantityOnHand:'', Unit:'', StorageReq:'', WithdrawalMeat:'',
  WithdrawalMilk:'', Prescription:false, ReorderPoint:'', UnitCost:'', Supplier:'', Notes:'',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init ? { ...init, Prescription: !!init.Prescription } : EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Medication Name*"><input value={f.MedicationName} onChange={set('MedicationName')} className={inp} required /></Field>
        <Field label="Active Ingredient"><input value={f.ActiveIngredient} onChange={set('ActiveIngredient')} className={inp} /></Field>
        <Field label="Category">
          <select value={f.Category} onChange={set('Category')} className={inp}>
            <option value="">— select —</option>
            {CATEGORIES.map(c => <option key={c}>{c}</option>)}
          </select>
        </Field>
        <Field label="Manufacturer"><input value={f.Manufacturer} onChange={set('Manufacturer')} className={inp} /></Field>
        <Field label="Lot Number"><input value={f.LotNumber} onChange={set('LotNumber')} className={inp} /></Field>
        <Field label="Expiration Date"><input type="date" value={f.ExpirationDate} onChange={set('ExpirationDate')} className={inp} /></Field>
        <Field label="Quantity On Hand"><input type="number" step="0.01" value={f.QuantityOnHand} onChange={set('QuantityOnHand')} className={inp} /></Field>
        <Field label="Unit (mL, mg, tablets, vials…)"><input value={f.Unit} onChange={set('Unit')} className={inp} /></Field>
        <Field label="Storage Requirements">
          <select value={f.StorageReq} onChange={set('StorageReq')} className={inp}>
            <option value="">— select —</option>
            {STORAGE_REQS.map(s => <option key={s}>{s}</option>)}
          </select>
        </Field>
        <Field label="Supplier"><input value={f.Supplier} onChange={set('Supplier')} className={inp} /></Field>
        <Field label="Meat Withdrawal Period"><input value={f.WithdrawalMeat} onChange={set('WithdrawalMeat')} placeholder="e.g. 28 days" className={inp} /></Field>
        <Field label="Milk Withdrawal Period"><input value={f.WithdrawalMilk} onChange={set('WithdrawalMilk')} placeholder="e.g. 72 hours" className={inp} /></Field>
        <Field label="Reorder Point"><input type="number" step="0.01" value={f.ReorderPoint} onChange={set('ReorderPoint')} className={inp} /></Field>
        <Field label="Unit Cost ($)"><input type="number" step="0.01" value={f.UnitCost} onChange={set('UnitCost')} className={inp} /></Field>
        <div className="flex items-center gap-2 mt-1">
          <input type="checkbox" id="rx" checked={f.Prescription} onChange={e => setF(p => ({ ...p, Prescription: e.target.checked }))} className="w-4 h-4" />
          <label htmlFor="rx" className="font-mont text-sm text-gray-700">Prescription Required (Rx)</label>
        </div>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave({ ...f, QuantityOnHand: f.QuantityOnHand ? parseFloat(f.QuantityOnHand) : null, ReorderPoint: f.ReorderPoint ? parseFloat(f.ReorderPoint) : null, UnitCost: f.UnitCost ? parseFloat(f.UnitCost) : null })}
          className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthMedications() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showForm, setShowForm] = useState(false);
  const [editing, setEditing] = useState(null);
  const [deleting, setDeleting] = useState(null);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  const load = useCallback(() => {
    if (!BusinessID) return;
    setLoading(true);
    fetch(`${API}/api/herd-health/medications?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/medications/${editing.MedicationID}`
      : `${API}/api/herd-health/medications?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/medications/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const today = new Date().toISOString().slice(0,10);
  const expiring = rows.filter(r => r.ExpirationDate && r.ExpirationDate.slice(0,10) <= new Date(Date.now() + 30*24*60*60*1000).toISOString().slice(0,10));
  const lowStock = rows.filter(r => r.QuantityOnHand != null && r.ReorderPoint != null && r.QuantityOnHand <= r.ReorderPoint);

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Medications"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Medications' }]}>
      <div className="space-y-4 max-w-5xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Medication Inventory</h1>
            <p className="font-mont text-xs text-gray-500">Track drugs, vaccines, and supplies on hand with withdrawal periods and expiration dates.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Add Medication</button>
        </div>

        {(expiring.length > 0 || lowStock.length > 0) && (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {expiring.length > 0 && <div className="bg-amber-50 border border-amber-200 rounded-xl px-4 py-3 font-mont text-sm text-amber-800">⚠ <strong>{expiring.length}</strong> medication{expiring.length > 1 ? 's' : ''} expiring within 30 days.</div>}
            {lowStock.length > 0 && <div className="bg-red-50 border border-red-200 rounded-xl px-4 py-3 font-mont text-sm text-red-800">⚠ <strong>{lowStock.length}</strong> item{lowStock.length > 1 ? 's' : ''} at or below reorder point.</div>}
          </div>
        )}

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No medications in inventory yet.</div>
        ) : (
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <table className="w-full text-xs font-mont">
              <thead className="bg-gray-50 border-b border-gray-100">
                <tr>
                  {['Medication','Category','Qty On Hand','Expiration','Withdrawal','Rx',''].map(h => (
                    <th key={h} className="px-3 py-2.5 text-left font-semibold text-gray-500">{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {rows.map(row => {
                  const exp = row.ExpirationDate?.slice(0,10);
                  const isExpiring = exp && exp <= new Date(Date.now() + 30*24*60*60*1000).toISOString().slice(0,10);
                  const isLow = row.QuantityOnHand != null && row.ReorderPoint != null && row.QuantityOnHand <= row.ReorderPoint;
                  return editing?.MedicationID === row.MedicationID ? (
                    <tr key={row.MedicationID}><td colSpan={7} className="p-3">
                      <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                    </td></tr>
                  ) : (
                    <tr key={row.MedicationID} className="hover:bg-gray-50">
                      <td className="px-3 py-2.5">
                        <div className="font-semibold text-gray-800">{row.MedicationName}</div>
                        {row.ActiveIngredient && <div className="text-gray-400">{row.ActiveIngredient}</div>}
                      </td>
                      <td className="px-3 py-2.5 text-gray-500">{row.Category}</td>
                      <td className="px-3 py-2.5">
                        <span className={isLow ? 'text-red-600 font-bold' : 'text-gray-700'}>{row.QuantityOnHand != null ? `${row.QuantityOnHand} ${row.Unit || ''}` : '—'}</span>
                        {isLow && <div className="text-red-500">Low stock</div>}
                      </td>
                      <td className="px-3 py-2.5">
                        <span className={isExpiring ? 'text-amber-600 font-semibold' : 'text-gray-500'}>{exp || '—'}</span>
                      </td>
                      <td className="px-3 py-2.5 text-gray-500">
                        {row.WithdrawalMeat && <div>Meat: {row.WithdrawalMeat}</div>}
                        {row.WithdrawalMilk && <div>Milk: {row.WithdrawalMilk}</div>}
                      </td>
                      <td className="px-3 py-2.5">{row.Prescription ? <span className="text-purple-600 font-semibold">Rx</span> : <span className="text-gray-300">—</span>}</td>
                      <td className="px-3 py-2.5">
                        <div className="flex gap-1">
                          <button onClick={() => setEditing(row)} className="text-gray-400 hover:text-gray-600 px-1.5 py-0.5 rounded hover:bg-gray-100">Edit</button>
                          {deleting === row.MedicationID
                            ? <><button onClick={() => del(row.MedicationID)} className="text-red-600 font-semibold px-1.5 py-0.5 rounded bg-red-50">✓</button>
                                <button onClick={() => setDeleting(null)} className="text-gray-400 px-1.5 py-0.5 rounded hover:bg-gray-100">✕</button></>
                            : <button onClick={() => setDeleting(row.MedicationID)} className="text-red-400 hover:text-red-600 px-1.5 py-0.5 rounded hover:bg-red-50">Del</button>
                          }
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </HerdHealthLayout>
  );
}
