import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';
import AnimalPicker from './AnimalPicker';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';

const EVENT_TYPES = ['Illness', 'Injury', 'Observation', 'Reproductive', 'Respiratory', 'Digestive', 'Neurological', 'Other'];
const SEVERITIES  = ['Critical', 'High', 'Medium', 'Low'];
const SEV_COLORS  = { Critical: '#9B1B4B', High: '#DB2777', Medium: '#CA8A04', Low: '#10B981' };

const EMPTY = {
  AnimalTag:'', EventDate:'', EventType:'', Severity:'Medium', Title:'',
  Description:'', Treatment:'', ResolvedDate:'', ResolvedNotes:'', RecordedBy:'',
};

function Form({ init, onSave, onCancel, businessId }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Animal">
          <AnimalPicker businessId={businessId} value={f.AnimalTag} animalId={f.AnimalID}
            onChange={(tag, id) => setF(p => ({ ...p, AnimalTag: tag, AnimalID: id }))} />
        </Field>
        <Field label="Event Date*"><input type="date" value={f.EventDate} onChange={set('EventDate')} className={inp} required /></Field>
        <Field label="Event Type">
          <select value={f.EventType} onChange={set('EventType')} className={inp}>
            <option value="">— select —</option>
            {EVENT_TYPES.map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="Severity">
          <select value={f.Severity} onChange={set('Severity')} className={inp}>
            {SEVERITIES.map(s => <option key={s}>{s}</option>)}
          </select>
        </Field>
        <Field label="Title" className="sm:col-span-2"><input value={f.Title} onChange={set('Title')} className={inp} /></Field>
        <Field label="Description" className="sm:col-span-2"><textarea value={f.Description} onChange={set('Description')} rows={3} className={inp} /></Field>
        <Field label="Treatment Given" className="sm:col-span-2"><textarea value={f.Treatment} onChange={set('Treatment')} rows={2} className={inp} /></Field>
        <Field label="Resolved Date"><input type="date" value={f.ResolvedDate} onChange={set('ResolvedDate')} className={inp} /></Field>
        <Field label="Recorded By"><input value={f.RecordedBy} onChange={set('RecordedBy')} className={inp} /></Field>
        <Field label="Resolution Notes" className="sm:col-span-2"><textarea value={f.ResolvedNotes} onChange={set('ResolvedNotes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2 pt-1">
        <button onClick={() => onSave(f)} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthEvents() {
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
    fetch(`${API}/api/herd-health/events?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : [])
      .then(setRows).catch(() => setRows([])).finally(() => setLoading(false));
  }, [BusinessID]);

  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/events/${editing.EventID}`
      : `${API}/api/herd-health/events?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };

  const del = async (id) => {
    await fetch(`${API}/api/herd-health/events/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Health Events"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Health Events' }]}>
      <div className="space-y-4 max-w-4xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Health Events</h1>
            <p className="font-mont text-xs text-gray-500">Illnesses, injuries, observations, and incidents.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold"
            style={{ backgroundColor: ACCENT }}>+ New Event</button>
        </div>

        {(showForm && !editing) && (
          <Form onSave={save} onCancel={() => setShowForm(false)} businessId={BusinessID} />
        )}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No health events recorded yet.</div>
        ) : (
          <div className="space-y-2">
            {rows.map(row => (
              <div key={row.EventID}>
                {editing?.EventID === row.EventID ? (
                  <Form init={editing} onSave={save} onCancel={() => setEditing(null)} businessId={BusinessID} />
                ) : (
                  <div className="bg-white rounded-xl border border-gray-200 p-4">
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex items-start gap-3 min-w-0">
                        <div className="w-2.5 h-2.5 rounded-full mt-1.5 shrink-0" style={{ background: SEV_COLORS[row.Severity] || '#9CA3AF' }} />
                        <div className="min-w-0">
                          <div className="font-mont text-sm font-semibold text-gray-900">{row.Title || row.EventType}</div>
                          <div className="font-mont text-xs text-gray-500 mt-0.5">
                            {row.AnimalTag && <span className="mr-2">#{row.AnimalTag}</span>}
                            <span className="mr-2">{row.EventType}</span>
                            <span className="mr-2">{row.EventDate?.slice(0,10)}</span>
                            <span className="px-1.5 py-0.5 rounded text-xs" style={{ background: SEV_COLORS[row.Severity] + '20', color: SEV_COLORS[row.Severity] }}>{row.Severity}</span>
                          </div>
                          {row.Description && <p className="font-mont text-xs text-gray-600 mt-1 line-clamp-2">{row.Description}</p>}
                          {row.ResolvedDate && <div className="font-mont text-xs text-green-600 mt-1">✓ Resolved {row.ResolvedDate?.slice(0,10)}</div>}
                        </div>
                      </div>
                      <div className="flex gap-2 shrink-0">
                        <button onClick={() => setEditing(row)} className="font-mont text-xs text-gray-500 hover:text-gray-700 px-2 py-1 rounded hover:bg-gray-100">Edit</button>
                        {deleting === row.EventID
                          ? <><button onClick={() => del(row.EventID)} className="font-mont text-xs text-red-600 font-semibold px-2 py-1 rounded bg-red-50">Confirm</button>
                              <button onClick={() => setDeleting(null)} className="font-mont text-xs text-gray-500 px-2 py-1 rounded hover:bg-gray-100">Cancel</button></>
                          : <button onClick={() => setDeleting(row.EventID)} className="font-mont text-xs text-red-400 hover:text-red-600 px-2 py-1 rounded hover:bg-red-50">Delete</button>
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

const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return (
    <div className={className}>
      <label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>
      {children}
    </div>
  );
}
