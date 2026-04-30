import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const ROUTES_ADMIN = ['IM', 'SQ', 'IV', 'Oral', 'Topical', 'Intranasal', 'Intramammary', 'Other'];
const OUTCOMES = ['Recovered', 'Ongoing', 'Improving', 'Deteriorating', 'Died', 'Culled'];
const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}
const EMPTY = {
  AnimalTag:'', TreatmentDate:'', Diagnosis:'', Medication:'', ActiveIngredient:'',
  Dosage:'', Route:'', Frequency:'', DurationDays:'', WithdrawalDate:'', WithdrawalMilk:'',
  PrescribedBy:'', AdministeredBy:'', Cost:'', Outcome:'', Notes:'',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Animal Tag / ID"><input value={f.AnimalTag} onChange={set('AnimalTag')} className={inp} /></Field>
        <Field label="Treatment Date"><input type="date" value={f.TreatmentDate} onChange={set('TreatmentDate')} className={inp} /></Field>
        <Field label="Diagnosis" className="sm:col-span-2"><input value={f.Diagnosis} onChange={set('Diagnosis')} className={inp} /></Field>
        <Field label="Medication / Drug"><input value={f.Medication} onChange={set('Medication')} className={inp} /></Field>
        <Field label="Active Ingredient"><input value={f.ActiveIngredient} onChange={set('ActiveIngredient')} className={inp} /></Field>
        <Field label="Dosage"><input value={f.Dosage} onChange={set('Dosage')} placeholder="e.g. 5 mL/100 lbs" className={inp} /></Field>
        <Field label="Route">
          <select value={f.Route} onChange={set('Route')} className={inp}>
            <option value="">— select —</option>
            {ROUTES_ADMIN.map(r => <option key={r}>{r}</option>)}
          </select>
        </Field>
        <Field label="Frequency"><input value={f.Frequency} onChange={set('Frequency')} placeholder="e.g. Once daily x 5 days" className={inp} /></Field>
        <Field label="Duration (days)"><input type="number" value={f.DurationDays} onChange={set('DurationDays')} className={inp} /></Field>
        <Field label="Meat Withdrawal Date"><input type="date" value={f.WithdrawalDate} onChange={set('WithdrawalDate')} className={inp} /></Field>
        <Field label="Milk Withdrawal Date"><input type="date" value={f.WithdrawalMilk} onChange={set('WithdrawalMilk')} className={inp} /></Field>
        <Field label="Prescribed By"><input value={f.PrescribedBy} onChange={set('PrescribedBy')} className={inp} /></Field>
        <Field label="Administered By"><input value={f.AdministeredBy} onChange={set('AdministeredBy')} className={inp} /></Field>
        <Field label="Cost ($)"><input type="number" step="0.01" value={f.Cost} onChange={set('Cost')} className={inp} /></Field>
        <Field label="Outcome">
          <select value={f.Outcome} onChange={set('Outcome')} className={inp}>
            <option value="">— select —</option>
            {OUTCOMES.map(o => <option key={o}>{o}</option>)}
          </select>
        </Field>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave(f)} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

const OUTCOME_COLOR = { Recovered: '#10B981', Ongoing: '#2563EB', Improving: '#059669', Deteriorating: '#D97706', Died: '#6B7280', Culled: '#6B7280' };

export default function HerdHealthTreatments() {
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
    fetch(`${API}/api/herd-health/treatments?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/treatments/${editing.TreatmentID}`
      : `${API}/api/herd-health/treatments?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ ...f, DurationDays: f.DurationDays ? parseInt(f.DurationDays) : null, Cost: f.Cost ? parseFloat(f.Cost) : null }) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/treatments/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const today = new Date().toISOString().slice(0,10);
  const withdrawalAlert = rows.filter(r => r.WithdrawalDate && r.WithdrawalDate.slice(0,10) >= today);

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Treatments"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Treatments' }]}>
      <div className="space-y-4 max-w-4xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Treatments</h1>
            <p className="font-mont text-xs text-gray-500">Medication administration, diagnoses, and withdrawal tracking.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Log Treatment</button>
        </div>

        {withdrawalAlert.length > 0 && (
          <div className="bg-red-50 border border-red-200 rounded-xl px-4 py-3 font-mont text-sm text-red-800">
            ⚠ <strong>{withdrawalAlert.length} animal{withdrawalAlert.length > 1 ? 's' : ''}</strong> currently under withdrawal period — not eligible for slaughter or milk harvest.
          </div>
        )}

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No treatment records yet.</div>
        ) : (
          <div className="space-y-2">
            {rows.map(row => (
              <div key={row.TreatmentID}>
                {editing?.TreatmentID === row.TreatmentID ? (
                  <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                ) : (
                  <div className="bg-white rounded-xl border border-gray-200 p-4">
                    <div className="flex items-start justify-between gap-3">
                      <div className="min-w-0 flex-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <span className="font-mont text-sm font-bold text-gray-900">{row.AnimalTag ? `#${row.AnimalTag}` : '—'}</span>
                          <span className="font-mont text-sm text-gray-700">{row.Diagnosis}</span>
                          {row.Outcome && <span className="font-mont text-xs px-2 py-0.5 rounded-full text-white" style={{ backgroundColor: OUTCOME_COLOR[row.Outcome] || '#9CA3AF' }}>{row.Outcome}</span>}
                        </div>
                        <div className="font-mont text-xs text-gray-500 mt-1 flex flex-wrap gap-x-3">
                          <span>{row.TreatmentDate?.slice(0,10)}</span>
                          <span>{row.Medication}{row.Dosage ? ` · ${row.Dosage}` : ''}{row.Route ? ` · ${row.Route}` : ''}</span>
                          {row.WithdrawalDate && <span className={row.WithdrawalDate.slice(0,10) >= today ? 'text-red-600 font-semibold' : 'text-green-600'}>Withdrawal: {row.WithdrawalDate.slice(0,10)}</span>}
                          {row.Cost && <span>Cost: ${parseFloat(row.Cost).toFixed(2)}</span>}
                        </div>
                        {row.Notes && <p className="font-mont text-xs text-gray-500 mt-1 line-clamp-1">{row.Notes}</p>}
                      </div>
                      <div className="flex gap-1 shrink-0">
                        <button onClick={() => setEditing(row)} className="font-mont text-xs text-gray-400 hover:text-gray-600 px-2 py-1 rounded hover:bg-gray-100">Edit</button>
                        {deleting === row.TreatmentID
                          ? <><button onClick={() => del(row.TreatmentID)} className="font-mont text-xs text-red-600 font-semibold px-2 py-1 rounded bg-red-50">Confirm</button>
                              <button onClick={() => setDeleting(null)} className="font-mont text-xs text-gray-400 px-2 py-1 rounded hover:bg-gray-100">Cancel</button></>
                          : <button onClick={() => setDeleting(row.TreatmentID)} className="font-mont text-xs text-red-400 hover:text-red-600 px-2 py-1 rounded hover:bg-red-50">Delete</button>
                        }
                      </div>
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </HerdHealthLayout>
  );
}
