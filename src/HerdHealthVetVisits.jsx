import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const VISIT_TYPES = ['Routine Wellness', 'Emergency', 'Follow-up', 'Consultation', 'Pregnancy Check', 'Pre-Purchase Exam', 'Regulatory/Test', 'Other'];
const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}
const EMPTY = {
  VisitDate:'', VetName:'', ClinicName:'', VisitType:'', AffectedAnimals:'',
  ChiefComplaint:'', Findings:'', Diagnoses:'', ProceduresPerformed:'',
  Prescriptions:'', FollowUpDate:'', FollowUpNotes:'', Cost:'', Notes:'',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Visit Date"><input type="date" value={f.VisitDate} onChange={set('VisitDate')} className={inp} /></Field>
        <Field label="Visit Type">
          <select value={f.VisitType} onChange={set('VisitType')} className={inp}>
            <option value="">— select —</option>
            {VISIT_TYPES.map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="Veterinarian Name"><input value={f.VetName} onChange={set('VetName')} className={inp} /></Field>
        <Field label="Clinic / Practice"><input value={f.ClinicName} onChange={set('ClinicName')} className={inp} /></Field>
        <Field label="Animals Affected" className="sm:col-span-2"><input value={f.AffectedAnimals} onChange={set('AffectedAnimals')} placeholder="Tags, groups, or describe" className={inp} /></Field>
        <Field label="Chief Complaint / Reason" className="sm:col-span-2"><textarea value={f.ChiefComplaint} onChange={set('ChiefComplaint')} rows={2} className={inp} /></Field>
        <Field label="Clinical Findings" className="sm:col-span-2"><textarea value={f.Findings} onChange={set('Findings')} rows={3} className={inp} /></Field>
        <Field label="Diagnoses" className="sm:col-span-2"><textarea value={f.Diagnoses} onChange={set('Diagnoses')} rows={2} className={inp} /></Field>
        <Field label="Procedures Performed" className="sm:col-span-2"><textarea value={f.ProceduresPerformed} onChange={set('ProceduresPerformed')} rows={2} className={inp} /></Field>
        <Field label="Prescriptions / Medications" className="sm:col-span-2"><textarea value={f.Prescriptions} onChange={set('Prescriptions')} rows={2} className={inp} /></Field>
        <Field label="Follow-Up Date"><input type="date" value={f.FollowUpDate} onChange={set('FollowUpDate')} className={inp} /></Field>
        <Field label="Cost ($)"><input type="number" step="0.01" value={f.Cost} onChange={set('Cost')} className={inp} /></Field>
        <Field label="Follow-Up Notes" className="sm:col-span-2"><textarea value={f.FollowUpNotes} onChange={set('FollowUpNotes')} rows={2} className={inp} /></Field>
        <Field label="Additional Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave({ ...f, Cost: f.Cost ? parseFloat(f.Cost) : null })} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthVetVisits() {
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
    fetch(`${API}/api/herd-health/vet-visits?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/vet-visits/${editing.VisitID}`
      : `${API}/api/herd-health/vet-visits?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/vet-visits/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Vet Visits"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Vet Visits' }]}>
      <div className="space-y-4 max-w-4xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Veterinary Visits</h1>
            <p className="font-mont text-xs text-gray-500">Full visit records including findings, diagnoses, and prescriptions.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Log Visit</button>
        </div>

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No vet visit records yet.</div>
        ) : (
          <div className="space-y-3">
            {rows.map(row => (
              <div key={row.VisitID}>
                {editing?.VisitID === row.VisitID ? (
                  <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                ) : (
                  <div className="bg-white rounded-xl border border-gray-200 p-4">
                    <div className="flex items-start justify-between gap-3">
                      <div className="min-w-0 flex-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <span className="font-mont text-sm font-bold text-gray-900">{row.VisitDate?.slice(0,10)}</span>
                          <span className="font-mont text-xs px-2 py-0.5 rounded-full bg-blue-50 text-blue-700">{row.VisitType}</span>
                          <span className="font-mont text-sm text-gray-700">{row.VetName}{row.ClinicName ? ` · ${row.ClinicName}` : ''}</span>
                          {row.Cost && <span className="font-mont text-xs text-gray-500">${parseFloat(row.Cost).toFixed(2)}</span>}
                        </div>
                        {row.ChiefComplaint && <p className="font-mont text-xs text-gray-600 mt-1 line-clamp-2">{row.ChiefComplaint}</p>}
                        {row.Diagnoses && <p className="font-mont text-xs text-blue-700 mt-0.5 line-clamp-1"><strong>Dx:</strong> {row.Diagnoses}</p>}
                        {row.FollowUpDate && <p className="font-mont text-xs text-amber-600 mt-0.5">Follow-up: {row.FollowUpDate.slice(0,10)}</p>}
                        {row.AffectedAnimals && <p className="font-mont text-xs text-gray-500 mt-0.5">Animals: {row.AffectedAnimals}</p>}
                      </div>
                      <div className="flex gap-1 shrink-0">
                        <button onClick={() => setEditing(row)} className="font-mont text-xs text-gray-400 hover:text-gray-600 px-2 py-1 rounded hover:bg-gray-100">Edit</button>
                        {deleting === row.VisitID
                          ? <><button onClick={() => del(row.VisitID)} className="font-mont text-xs text-red-600 font-semibold px-2 py-1 rounded bg-red-50">Confirm</button>
                              <button onClick={() => setDeleting(null)} className="font-mont text-xs text-gray-400 px-2 py-1 rounded hover:bg-gray-100">Cancel</button></>
                          : <button onClick={() => setDeleting(row.VisitID)} className="font-mont text-xs text-red-400 hover:text-red-600 px-2 py-1 rounded hover:bg-red-50">Delete</button>
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
