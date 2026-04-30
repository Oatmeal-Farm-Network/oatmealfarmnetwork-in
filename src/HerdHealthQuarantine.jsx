import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const REASONS = ['New Arrival', 'Disease Suspected', 'Confirmed Illness', 'Post-Surgery Recovery', 'Injury', 'Pre-Sale', 'Regulatory Requirement', 'Other'];
const STATUSES = ['Active', 'Released', 'Transferred', 'Deceased'];
const STATUS_COLOR = { Active: '#EF4444', Released: '#10B981', Transferred: '#3B82F6', Deceased: '#6B7280' };

const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}

const EMPTY = {
  AnimalTag: '', Species: '', StartDate: '', ExpectedEndDate: '', ActualEndDate: '',
  Reason: '', Location: '', Status: 'Active', ResponsiblePerson: '',
  DailyObservations: '', ConditionOnEntry: '', ConditionOnRelease: '',
  VetConsulted: '', TestsRequired: '', TestsCompleted: '', Notes: '',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Animal Tag / ID*"><input value={f.AnimalTag} onChange={set('AnimalTag')} className={inp} /></Field>
        <Field label="Species"><input value={f.Species} onChange={set('Species')} placeholder="e.g. Bovine, Ovine" className={inp} /></Field>
        <Field label="Start Date"><input type="date" value={f.StartDate} onChange={set('StartDate')} className={inp} /></Field>
        <Field label="Expected Release Date"><input type="date" value={f.ExpectedEndDate} onChange={set('ExpectedEndDate')} className={inp} /></Field>
        <Field label="Actual Release Date"><input type="date" value={f.ActualEndDate} onChange={set('ActualEndDate')} className={inp} /></Field>
        <Field label="Reason for Quarantine">
          <select value={f.Reason} onChange={set('Reason')} className={inp}>
            <option value="">— select —</option>
            {REASONS.map(r => <option key={r}>{r}</option>)}
          </select>
        </Field>
        <Field label="Quarantine Location"><input value={f.Location} onChange={set('Location')} placeholder="e.g. Pen 4, Isolation Barn" className={inp} /></Field>
        <Field label="Status">
          <select value={f.Status} onChange={set('Status')} className={inp}>
            {STATUSES.map(s => <option key={s}>{s}</option>)}
          </select>
        </Field>
        <Field label="Responsible Person"><input value={f.ResponsiblePerson} onChange={set('ResponsiblePerson')} className={inp} /></Field>
        <Field label="Vet Consulted"><input value={f.VetConsulted} onChange={set('VetConsulted')} className={inp} /></Field>
        <Field label="Tests Required" className="sm:col-span-2"><input value={f.TestsRequired} onChange={set('TestsRequired')} placeholder="e.g. Brucellosis, TB test" className={inp} /></Field>
        <Field label="Tests Completed" className="sm:col-span-2"><input value={f.TestsCompleted} onChange={set('TestsCompleted')} className={inp} /></Field>
        <Field label="Condition on Entry" className="sm:col-span-2"><textarea value={f.ConditionOnEntry} onChange={set('ConditionOnEntry')} rows={2} className={inp} /></Field>
        <Field label="Condition on Release" className="sm:col-span-2"><textarea value={f.ConditionOnRelease} onChange={set('ConditionOnRelease')} rows={2} className={inp} /></Field>
        <Field label="Daily Observations" className="sm:col-span-2"><textarea value={f.DailyObservations} onChange={set('DailyObservations')} rows={3} placeholder="Running log of daily checks..." className={inp} /></Field>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave(f)} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthQuarantine() {
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
    fetch(`${API}/api/herd-health/quarantine?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/quarantine/${editing.QuarantineID}`
      : `${API}/api/herd-health/quarantine?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/quarantine/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const today = new Date().toISOString().slice(0, 10);
  const active = rows.filter(r => r.Status === 'Active');
  const overdue = rows.filter(r => r.Status === 'Active' && r.ExpectedEndDate && r.ExpectedEndDate.slice(0, 10) < today);

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Quarantine"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Quarantine' }]}>
      <div className="space-y-4 max-w-5xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Quarantine Management</h1>
            <p className="font-mont text-xs text-gray-500">Isolation records for new arrivals, sick animals, and regulatory compliance.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Add Quarantine</button>
        </div>

        {(active.length > 0 || overdue.length > 0) && (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {active.length > 0 && <div className="bg-red-50 border border-red-200 rounded-xl px-4 py-3 font-mont text-sm text-red-800"><strong>{active.length}</strong> animal{active.length > 1 ? 's' : ''} currently in quarantine.</div>}
            {overdue.length > 0 && <div className="bg-amber-50 border border-amber-200 rounded-xl px-4 py-3 font-mont text-sm text-amber-800">⚠ <strong>{overdue.length}</strong> quarantine{overdue.length > 1 ? 's' : ''} past expected release date.</div>}
          </div>
        )}

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No quarantine records yet.</div>
        ) : (
          <div className="space-y-3">
            {rows.map(row => (
              <div key={row.QuarantineID}>
                {editing?.QuarantineID === row.QuarantineID ? (
                  <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                ) : (
                  <div className="bg-white rounded-xl border border-gray-200 p-4">
                    <div className="flex items-start justify-between gap-3">
                      <div className="min-w-0 flex-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <span className="font-mont text-sm font-bold text-gray-900">#{row.AnimalTag}</span>
                          {row.Species && <span className="font-mont text-xs text-gray-500">{row.Species}</span>}
                          <span className="font-mont text-xs px-2 py-0.5 rounded-full text-white font-semibold" style={{ backgroundColor: STATUS_COLOR[row.Status] || '#9CA3AF' }}>{row.Status}</span>
                          {row.Reason && <span className="font-mont text-xs text-gray-600 bg-gray-100 px-2 py-0.5 rounded-full">{row.Reason}</span>}
                        </div>
                        <div className="font-mont text-xs text-gray-500 mt-1 flex flex-wrap gap-x-3">
                          {row.StartDate && <span>Started: {row.StartDate.slice(0, 10)}</span>}
                          {row.ExpectedEndDate && <span className={row.Status === 'Active' && row.ExpectedEndDate.slice(0, 10) < today ? 'text-amber-600 font-semibold' : ''}>Expected release: {row.ExpectedEndDate.slice(0, 10)}</span>}
                          {row.Location && <span>Location: {row.Location}</span>}
                          {row.ResponsiblePerson && <span>Responsible: {row.ResponsiblePerson}</span>}
                        </div>
                        {row.ConditionOnEntry && <p className="font-mont text-xs text-gray-500 mt-1 line-clamp-1">Entry: {row.ConditionOnEntry}</p>}
                      </div>
                      <div className="flex gap-1 shrink-0">
                        <button onClick={() => setEditing(row)} className="font-mont text-xs text-gray-400 hover:text-gray-600 px-2 py-1 rounded hover:bg-gray-100">Edit</button>
                        {deleting === row.QuarantineID
                          ? <><button onClick={() => del(row.QuarantineID)} className="font-mont text-xs text-red-600 font-semibold px-2 py-1 rounded bg-red-50">Confirm</button>
                              <button onClick={() => setDeleting(null)} className="font-mont text-xs text-gray-400 px-2 py-1 rounded hover:bg-gray-100">Cancel</button></>
                          : <button onClick={() => setDeleting(row.QuarantineID)} className="font-mont text-xs text-red-400 hover:text-red-600 px-2 py-1 rounded hover:bg-red-50">Delete</button>
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
