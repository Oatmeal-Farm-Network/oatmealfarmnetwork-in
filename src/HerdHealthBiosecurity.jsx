import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const LOG_TYPES = [
  'Visitor Entry', 'Vehicle Entry', 'Animal Delivery', 'Feed Delivery',
  'Medication / Supply Delivery', 'Employee Entry', 'Quarantine Check',
  'Facility Cleaning & Disinfection', 'Pest Control', 'Water Test',
  'Protocol Review / Update', 'Incident / Breach', 'Other',
];
const RISK_LEVELS = ['Low', 'Medium', 'High', 'Critical'];
const RISK_COLOR = { Low: '#10B981', Medium: '#F59E0B', High: '#EF4444', Critical: '#DC2626' };

const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}

const EMPTY = {
  LogDate: '', LogType: '', PersonOrOrg: '', Purpose: '', EntryPoint: '',
  VehiclePlate: '', PPEUsed: '', BootDipUsed: '', AreaAccessed: '',
  AnimalContactMade: '', RiskLevel: 'Low', ProtocolsFollowed: '',
  IncidentDescription: '', CorrectiveAction: '', LoggedBy: '', Notes: '',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Date"><input type="date" value={f.LogDate} onChange={set('LogDate')} className={inp} /></Field>
        <Field label="Log Type">
          <select value={f.LogType} onChange={set('LogType')} className={inp}>
            <option value="">— select —</option>
            {LOG_TYPES.map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="Person / Organization"><input value={f.PersonOrOrg} onChange={set('PersonOrOrg')} className={inp} /></Field>
        <Field label="Purpose / Reason for Visit"><input value={f.Purpose} onChange={set('Purpose')} className={inp} /></Field>
        <Field label="Entry Point / Gate"><input value={f.EntryPoint} onChange={set('EntryPoint')} placeholder="e.g. Main Gate, North Barn" className={inp} /></Field>
        <Field label="Vehicle Plate / ID"><input value={f.VehiclePlate} onChange={set('VehiclePlate')} className={inp} /></Field>
        <Field label="Area(s) Accessed"><input value={f.AreaAccessed} onChange={set('AreaAccessed')} placeholder="e.g. Maternity pen, Feed storage" className={inp} /></Field>
        <Field label="Animal Contact?">
          <select value={f.AnimalContactMade} onChange={set('AnimalContactMade')} className={inp}>
            <option value="">— select —</option>
            <option>Yes</option><option>No</option>
          </select>
        </Field>
        <Field label="PPE Used?">
          <select value={f.PPEUsed} onChange={set('PPEUsed')} className={inp}>
            <option value="">— select —</option>
            <option>Yes – Full</option><option>Yes – Partial</option><option>No</option>
          </select>
        </Field>
        <Field label="Boot Dip / Footbath Used?">
          <select value={f.BootDipUsed} onChange={set('BootDipUsed')} className={inp}>
            <option value="">— select —</option>
            <option>Yes</option><option>No</option><option>N/A</option>
          </select>
        </Field>
        <Field label="Risk Level">
          <select value={f.RiskLevel} onChange={set('RiskLevel')} className={inp}>
            {RISK_LEVELS.map(r => <option key={r}>{r}</option>)}
          </select>
        </Field>
        <Field label="Protocols Followed"><input value={f.ProtocolsFollowed} onChange={set('ProtocolsFollowed')} placeholder="e.g. SOP-BIO-01" className={inp} /></Field>
        <Field label="Logged By"><input value={f.LoggedBy} onChange={set('LoggedBy')} className={inp} /></Field>
        <Field label="Incident Description" className="sm:col-span-2"><textarea value={f.IncidentDescription} onChange={set('IncidentDescription')} rows={2} placeholder="Only for breaches or incidents..." className={inp} /></Field>
        <Field label="Corrective Action" className="sm:col-span-2"><textarea value={f.CorrectiveAction} onChange={set('CorrectiveAction')} rows={2} className={inp} /></Field>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave(f)} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthBiosecurity() {
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
    fetch(`${API}/api/herd-health/biosecurity?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/biosecurity/${editing.BiosecurityID}`
      : `${API}/api/herd-health/biosecurity?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/biosecurity/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const incidents = rows.filter(r => r.LogType === 'Incident / Breach' || r.RiskLevel === 'Critical' || r.RiskLevel === 'High');

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Biosecurity"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Biosecurity' }]}>
      <div className="space-y-4 max-w-5xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Biosecurity Log</h1>
            <p className="font-mont text-xs text-gray-500">Visitor access, animal deliveries, cleaning & disinfection, and biosecurity incident records.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Add Entry</button>
        </div>

        {incidents.length > 0 && (
          <div className="bg-red-50 border border-red-200 rounded-xl px-4 py-3 font-mont text-sm text-red-800">
            ⚠ <strong>{incidents.length}</strong> high-risk or incident entry{incidents.length > 1 ? 's' : ''} on record — review recommended.
          </div>
        )}

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No biosecurity log entries yet.</div>
        ) : (
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <table className="w-full text-xs font-mont">
              <thead className="bg-gray-50 border-b border-gray-100">
                <tr>
                  {['Date', 'Type', 'Person / Org', 'Area Accessed', 'Risk', 'PPE', 'Logged By', ''].map(h => (
                    <th key={h} className="px-3 py-2.5 text-left font-semibold text-gray-500">{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {rows.map(row => (
                  editing?.BiosecurityID === row.BiosecurityID ? (
                    <tr key={row.BiosecurityID}><td colSpan={8} className="p-3">
                      <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                    </td></tr>
                  ) : (
                    <tr key={row.BiosecurityID} className="hover:bg-gray-50">
                      <td className="px-3 py-2.5 text-gray-500">{row.LogDate?.slice(0, 10)}</td>
                      <td className="px-3 py-2.5 text-gray-700">{row.LogType}</td>
                      <td className="px-3 py-2.5 font-semibold text-gray-800">{row.PersonOrOrg || '—'}</td>
                      <td className="px-3 py-2.5 text-gray-500">{row.AreaAccessed || '—'}</td>
                      <td className="px-3 py-2.5">
                        <span className="font-semibold px-1.5 py-0.5 rounded text-white text-xs" style={{ backgroundColor: RISK_COLOR[row.RiskLevel] || '#9CA3AF' }}>
                          {row.RiskLevel}
                        </span>
                      </td>
                      <td className="px-3 py-2.5 text-gray-500">{row.PPEUsed || '—'}</td>
                      <td className="px-3 py-2.5 text-gray-400">{row.LoggedBy || '—'}</td>
                      <td className="px-3 py-2.5">
                        <div className="flex gap-1">
                          <button onClick={() => setEditing(row)} className="text-gray-400 hover:text-gray-600 px-1.5 py-0.5 rounded hover:bg-gray-100">Edit</button>
                          {deleting === row.BiosecurityID
                            ? <><button onClick={() => del(row.BiosecurityID)} className="text-red-600 font-semibold px-1.5 py-0.5 rounded bg-red-50">✓</button>
                                <button onClick={() => setDeleting(null)} className="text-gray-400 px-1.5 py-0.5 rounded hover:bg-gray-100">✕</button></>
                            : <button onClick={() => setDeleting(row.BiosecurityID)} className="text-red-400 hover:text-red-600 px-1.5 py-0.5 rounded hover:bg-red-50">Del</button>
                          }
                        </div>
                      </td>
                    </tr>
                  )
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </HerdHealthLayout>
  );
}
