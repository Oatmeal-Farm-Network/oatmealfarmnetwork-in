import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const CAUSES = ['Disease', 'Respiratory', 'Digestive / Bloat', 'Dystocia / Birthing', 'Predator', 'Injury / Trauma', 'Poisoning', 'Lightning / Weather', 'Old Age', 'Unknown', 'Other'];
const DISPOSAL_METHODS = ['Rendering', 'Burial on-site', 'Composting', 'Incineration', 'Landfill', 'Veterinary Disposal', 'Other'];

const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}

const EMPTY = {
  AnimalTag: '', Species: '', Breed: '', Sex: '', AgeYears: '', WeightLbs: '',
  DateOfDeath: '', CauseOfDeath: '', PreliminaryDiagnosis: '',
  PostMortemPerformed: '', PostMortemFindings: '', SamplesSubmitted: '',
  LabResultsSummary: '', DisposalMethod: '', DisposalDate: '', DisposalLocation: '',
  InsuranceClaim: '', InsuranceClaimNumber: '', EstimatedValue: '',
  ReportedToAuthorities: '', WitnessedBy: '', VetNotified: '', Notes: '',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Animal Tag / ID"><input value={f.AnimalTag} onChange={set('AnimalTag')} className={inp} /></Field>
        <Field label="Date of Death"><input type="date" value={f.DateOfDeath} onChange={set('DateOfDeath')} className={inp} /></Field>
        <Field label="Species"><input value={f.Species} onChange={set('Species')} placeholder="e.g. Bovine, Ovine, Porcine" className={inp} /></Field>
        <Field label="Breed"><input value={f.Breed} onChange={set('Breed')} className={inp} /></Field>
        <Field label="Sex">
          <select value={f.Sex} onChange={set('Sex')} className={inp}>
            <option value="">— select —</option>
            <option>Male</option><option>Female</option><option>Castrated Male</option>
          </select>
        </Field>
        <Field label="Age (years)"><input type="number" step="0.1" value={f.AgeYears} onChange={set('AgeYears')} className={inp} /></Field>
        <Field label="Weight (lbs)"><input type="number" step="1" value={f.WeightLbs} onChange={set('WeightLbs')} className={inp} /></Field>
        <Field label="Cause of Death">
          <select value={f.CauseOfDeath} onChange={set('CauseOfDeath')} className={inp}>
            <option value="">— select —</option>
            {CAUSES.map(c => <option key={c}>{c}</option>)}
          </select>
        </Field>
        <Field label="Preliminary Diagnosis" className="sm:col-span-2"><input value={f.PreliminaryDiagnosis} onChange={set('PreliminaryDiagnosis')} className={inp} /></Field>
        <Field label="Post-Mortem Performed?">
          <select value={f.PostMortemPerformed} onChange={set('PostMortemPerformed')} className={inp}>
            <option value="">— select —</option>
            <option>Yes</option><option>No</option><option>Partial</option>
          </select>
        </Field>
        <Field label="Vet Notified"><input value={f.VetNotified} onChange={set('VetNotified')} className={inp} /></Field>
        <Field label="Post-Mortem Findings" className="sm:col-span-2"><textarea value={f.PostMortemFindings} onChange={set('PostMortemFindings')} rows={2} className={inp} /></Field>
        <Field label="Samples Submitted (Lab)"><input value={f.SamplesSubmitted} onChange={set('SamplesSubmitted')} placeholder="e.g. Brain, lung, blood" className={inp} /></Field>
        <Field label="Lab Results Summary"><input value={f.LabResultsSummary} onChange={set('LabResultsSummary')} className={inp} /></Field>
        <Field label="Disposal Method">
          <select value={f.DisposalMethod} onChange={set('DisposalMethod')} className={inp}>
            <option value="">— select —</option>
            {DISPOSAL_METHODS.map(d => <option key={d}>{d}</option>)}
          </select>
        </Field>
        <Field label="Disposal Date"><input type="date" value={f.DisposalDate} onChange={set('DisposalDate')} className={inp} /></Field>
        <Field label="Disposal Location / Record"><input value={f.DisposalLocation} onChange={set('DisposalLocation')} className={inp} /></Field>
        <Field label="Reported to Authorities?">
          <select value={f.ReportedToAuthorities} onChange={set('ReportedToAuthorities')} className={inp}>
            <option value="">— select —</option>
            <option>Yes</option><option>No</option><option>Not Required</option>
          </select>
        </Field>
        <Field label="Insurance Claim Filed?">
          <select value={f.InsuranceClaim} onChange={set('InsuranceClaim')} className={inp}>
            <option value="">— select —</option>
            <option>Yes</option><option>No</option><option>N/A</option>
          </select>
        </Field>
        <Field label="Insurance Claim Number"><input value={f.InsuranceClaimNumber} onChange={set('InsuranceClaimNumber')} className={inp} /></Field>
        <Field label="Estimated Value ($)"><input type="number" step="0.01" value={f.EstimatedValue} onChange={set('EstimatedValue')} className={inp} /></Field>
        <Field label="Witnessed By"><input value={f.WitnessedBy} onChange={set('WitnessedBy')} className={inp} /></Field>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave({ ...f, AgeYears: f.AgeYears ? parseFloat(f.AgeYears) : null, WeightLbs: f.WeightLbs ? parseFloat(f.WeightLbs) : null, EstimatedValue: f.EstimatedValue ? parseFloat(f.EstimatedValue) : null })}
          className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthMortality() {
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
    fetch(`${API}/api/herd-health/mortality?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/mortality/${editing.MortalityID}`
      : `${API}/api/herd-health/mortality?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/mortality/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const pendingDisposal = rows.filter(r => !r.DisposalMethod);
  const openClaims = rows.filter(r => r.InsuranceClaim === 'Yes' && !r.InsuranceClaimNumber);

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Mortality"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Mortality' }]}>
      <div className="space-y-4 max-w-5xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Mortality Records</h1>
            <p className="font-mont text-xs text-gray-500">Death records with post-mortem findings, disposal documentation, and insurance tracking.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Log Death</button>
        </div>

        {(pendingDisposal.length > 0 || openClaims.length > 0) && (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {pendingDisposal.length > 0 && <div className="bg-amber-50 border border-amber-200 rounded-xl px-4 py-3 font-mont text-sm text-amber-800">⚠ <strong>{pendingDisposal.length}</strong> record{pendingDisposal.length > 1 ? 's' : ''} missing disposal method.</div>}
            {openClaims.length > 0 && <div className="bg-blue-50 border border-blue-200 rounded-xl px-4 py-3 font-mont text-sm text-blue-800">ℹ <strong>{openClaims.length}</strong> insurance claim{openClaims.length > 1 ? 's' : ''} without a claim number.</div>}
          </div>
        )}

        {rows.length > 0 && (
          <div className="bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 grid grid-cols-3 gap-4 text-center">
            <div><div className="font-lora text-xl font-bold text-gray-900">{rows.length}</div><div className="font-mont text-xs text-gray-500">Total Deaths</div></div>
            <div><div className="font-lora text-xl font-bold text-gray-900">{rows.filter(r => r.InsuranceClaim === 'Yes').length}</div><div className="font-mont text-xs text-gray-500">Insurance Claims</div></div>
            <div><div className="font-lora text-xl font-bold text-gray-900">${rows.reduce((s, r) => s + (parseFloat(r.EstimatedValue) || 0), 0).toLocaleString()}</div><div className="font-mont text-xs text-gray-500">Est. Total Value</div></div>
          </div>
        )}

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No mortality records yet.</div>
        ) : (
          <div className="space-y-3">
            {rows.map(row => (
              <div key={row.MortalityID}>
                {editing?.MortalityID === row.MortalityID ? (
                  <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                ) : (
                  <div className="bg-white rounded-xl border border-gray-200 p-4">
                    <div className="flex items-start justify-between gap-3">
                      <div className="min-w-0 flex-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <span className="font-mont text-sm font-bold text-gray-900">{row.AnimalTag ? `#${row.AnimalTag}` : '—'}</span>
                          {row.Species && <span className="font-mont text-xs text-gray-500">{row.Species}{row.Breed ? ` · ${row.Breed}` : ''}</span>}
                          {row.CauseOfDeath && <span className="font-mont text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-700">{row.CauseOfDeath}</span>}
                          {row.InsuranceClaim === 'Yes' && <span className="font-mont text-xs px-2 py-0.5 rounded-full bg-blue-50 text-blue-700">Insurance</span>}
                        </div>
                        <div className="font-mont text-xs text-gray-500 mt-1 flex flex-wrap gap-x-3">
                          {row.DateOfDeath && <span>{row.DateOfDeath.slice(0, 10)}</span>}
                          {row.EstimatedValue && <span>Value: ${parseFloat(row.EstimatedValue).toFixed(2)}</span>}
                          {row.DisposalMethod && <span>Disposal: {row.DisposalMethod}</span>}
                          {row.PostMortemPerformed === 'Yes' && <span className="text-blue-600">PM performed</span>}
                        </div>
                        {row.PreliminaryDiagnosis && <p className="font-mont text-xs text-gray-600 mt-1 line-clamp-1">{row.PreliminaryDiagnosis}</p>}
                      </div>
                      <div className="flex gap-1 shrink-0">
                        <button onClick={() => setEditing(row)} className="font-mont text-xs text-gray-400 hover:text-gray-600 px-2 py-1 rounded hover:bg-gray-100">Edit</button>
                        {deleting === row.MortalityID
                          ? <><button onClick={() => del(row.MortalityID)} className="font-mont text-xs text-red-600 font-semibold px-2 py-1 rounded bg-red-50">Confirm</button>
                              <button onClick={() => setDeleting(null)} className="font-mont text-xs text-gray-400 px-2 py-1 rounded hover:bg-gray-100">Cancel</button></>
                          : <button onClick={() => setDeleting(row.MortalityID)} className="font-mont text-xs text-red-400 hover:text-red-600 px-2 py-1 rounded hover:bg-red-50">Delete</button>
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
