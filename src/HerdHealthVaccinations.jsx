import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';

const ROUTES_ADMIN = ['IM', 'SQ', 'IN', 'Oral', 'Topical', 'IV'];
const VACCINE_TYPES = ['Modified Live Virus (MLV)', 'Killed/Inactivated', 'Toxoid', 'Recombinant', 'Subunit', 'Other'];

const EMPTY = {
  AnimalTag:'', GroupName:'', VaccineName:'', VaccineManufacturer:'', VaccineType:'',
  AdministeredDate:'', NextDueDate:'', Dosage:'', Route:'', LotNumber:'',
  ExpirationDate:'', AdministeredBy:'', Notes:'',
};

const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return (
    <div className={className}>
      <label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>
      {children}
    </div>
  );
}

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Animal Tag (leave blank for herd group)"><input value={f.AnimalTag} onChange={set('AnimalTag')} className={inp} /></Field>
        <Field label="Group / Herd Name"><input value={f.GroupName} onChange={set('GroupName')} placeholder="e.g. All Ewes, Spring Calves" className={inp} /></Field>
        <Field label="Vaccine Name*"><input value={f.VaccineName} onChange={set('VaccineName')} className={inp} required /></Field>
        <Field label="Manufacturer"><input value={f.VaccineManufacturer} onChange={set('VaccineManufacturer')} className={inp} /></Field>
        <Field label="Vaccine Type">
          <select value={f.VaccineType} onChange={set('VaccineType')} className={inp}>
            <option value="">— select —</option>
            {VACCINE_TYPES.map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="Route">
          <select value={f.Route} onChange={set('Route')} className={inp}>
            <option value="">— select —</option>
            {ROUTES_ADMIN.map(r => <option key={r}>{r}</option>)}
          </select>
        </Field>
        <Field label="Date Administered"><input type="date" value={f.AdministeredDate} onChange={set('AdministeredDate')} className={inp} /></Field>
        <Field label="Next Due Date"><input type="date" value={f.NextDueDate} onChange={set('NextDueDate')} className={inp} /></Field>
        <Field label="Dosage"><input value={f.Dosage} onChange={set('Dosage')} placeholder="e.g. 2 mL" className={inp} /></Field>
        <Field label="Administered By"><input value={f.AdministeredBy} onChange={set('AdministeredBy')} className={inp} /></Field>
        <Field label="Lot Number"><input value={f.LotNumber} onChange={set('LotNumber')} className={inp} /></Field>
        <Field label="Vial Expiration Date"><input type="date" value={f.ExpirationDate} onChange={set('ExpirationDate')} className={inp} /></Field>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave(f)} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthVaccinations() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showForm, setShowForm] = useState(searchParams.get('new') === '1');
  const [editing, setEditing] = useState(null);
  const [deleting, setDeleting] = useState(null);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);

  const load = useCallback(() => {
    if (!BusinessID) return;
    setLoading(true);
    fetch(`${API}/api/herd-health/vaccinations?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);

  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/vaccinations/${editing.VaccinationID}`
      : `${API}/api/herd-health/vaccinations?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };

  const del = async (id) => {
    await fetch(`${API}/api/herd-health/vaccinations/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const today = new Date().toISOString().slice(0, 10);
  const overdue = rows.filter(r => r.NextDueDate && r.NextDueDate.slice(0,10) < today);

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Vaccinations"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Vaccinations' }]}>
      <div className="space-y-4 max-w-4xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Vaccinations</h1>
            <p className="font-mont text-xs text-gray-500">Vaccination records, schedules, and due dates.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold"
            style={{ backgroundColor: ACCENT }}>+ Add Vaccination</button>
        </div>

        {overdue.length > 0 && (
          <div className="bg-amber-50 border border-amber-200 rounded-xl px-4 py-3 font-mont text-sm text-amber-800">
            <strong>{overdue.length} vaccination{overdue.length > 1 ? 's' : ''}</strong> past due date.
          </div>
        )}

        {(showForm && !editing) && (
          <Form onSave={save} onCancel={() => setShowForm(false)} />
        )}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No vaccination records yet.</div>
        ) : (
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <table className="w-full text-xs font-mont">
              <thead className="bg-gray-50 border-b border-gray-100">
                <tr>
                  {['Animal/Group','Vaccine','Type','Date Given','Next Due','By',''].map(h => (
                    <th key={h} className="px-3 py-2.5 text-left font-semibold text-gray-500">{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {rows.map(row => {
                  const due = row.NextDueDate?.slice(0,10);
                  const isOverdue = due && due < today;
                  return editing?.VaccinationID === row.VaccinationID ? (
                    <tr key={row.VaccinationID}><td colSpan={7} className="p-3">
                      <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                    </td></tr>
                  ) : (
                    <tr key={row.VaccinationID} className="hover:bg-gray-50">
                      <td className="px-3 py-2.5 font-semibold text-gray-800">{row.AnimalTag ? `#${row.AnimalTag}` : row.GroupName || '—'}</td>
                      <td className="px-3 py-2.5 text-gray-700">{row.VaccineName}</td>
                      <td className="px-3 py-2.5 text-gray-500">{row.VaccineType}</td>
                      <td className="px-3 py-2.5 text-gray-500">{row.AdministeredDate?.slice(0,10)}</td>
                      <td className="px-3 py-2.5">
                        <span className={`${isOverdue ? 'text-red-600 font-semibold' : 'text-gray-500'}`}>{due || '—'}</span>
                        {isOverdue && <span className="ml-1 text-red-500">⚠</span>}
                      </td>
                      <td className="px-3 py-2.5 text-gray-500">{row.AdministeredBy}</td>
                      <td className="px-3 py-2.5">
                        <div className="flex gap-1">
                          <button onClick={() => setEditing(row)} className="text-gray-400 hover:text-gray-600 px-1.5 py-0.5 rounded hover:bg-gray-100">Edit</button>
                          {deleting === row.VaccinationID
                            ? <><button onClick={() => del(row.VaccinationID)} className="text-red-600 font-semibold px-1.5 py-0.5 rounded bg-red-50">✓</button>
                                <button onClick={() => setDeleting(null)} className="text-gray-400 px-1.5 py-0.5 rounded hover:bg-gray-100">✕</button></>
                            : <button onClick={() => setDeleting(row.VaccinationID)} className="text-red-400 hover:text-red-600 px-1.5 py-0.5 rounded hover:bg-red-50">Del</button>
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
