import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const ROLES = [
  'Large Animal Veterinarian', 'Small Animal Veterinarian', 'Mixed Practice Veterinarian',
  'Equine Veterinarian', 'Swine Specialist', 'Poultry Veterinarian', 'State Vet / USDA',
  'Farrier', 'Nutritionist', 'Embryo Transfer Technician', 'AI Technician',
  'Livestock Extension Agent', 'Feed / Supplement Rep', 'Emergency On-Call', 'Other',
];

const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}

const EMPTY = {
  Name: '', Role: '', ClinicName: '', Phone: '', EmergencyPhone: '', Email: '',
  Address: '', City: '', State: '', Zip: '', LicenseNumber: '', DEANumber: '',
  SpeciesServed: '', ServicesOffered: '', PreferredContact: '', Notes: '',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Name*"><input value={f.Name} onChange={set('Name')} className={inp} /></Field>
        <Field label="Role / Title">
          <select value={f.Role} onChange={set('Role')} className={inp}>
            <option value="">— select —</option>
            {ROLES.map(r => <option key={r}>{r}</option>)}
          </select>
        </Field>
        <Field label="Clinic / Practice Name"><input value={f.ClinicName} onChange={set('ClinicName')} className={inp} /></Field>
        <Field label="Primary Phone"><input type="tel" value={f.Phone} onChange={set('Phone')} className={inp} /></Field>
        <Field label="Emergency / After-Hours Phone"><input type="tel" value={f.EmergencyPhone} onChange={set('EmergencyPhone')} className={inp} /></Field>
        <Field label="Email"><input type="email" value={f.Email} onChange={set('Email')} className={inp} /></Field>
        <Field label="Address"><input value={f.Address} onChange={set('Address')} className={inp} /></Field>
        <Field label="City"><input value={f.City} onChange={set('City')} className={inp} /></Field>
        <Field label="State"><input value={f.State} onChange={set('State')} className={inp} /></Field>
        <Field label="ZIP Code"><input value={f.Zip} onChange={set('Zip')} className={inp} /></Field>
        <Field label="License Number"><input value={f.LicenseNumber} onChange={set('LicenseNumber')} className={inp} /></Field>
        <Field label="DEA Number"><input value={f.DEANumber} onChange={set('DEANumber')} className={inp} /></Field>
        <Field label="Species Served"><input value={f.SpeciesServed} onChange={set('SpeciesServed')} placeholder="e.g. Bovine, Ovine, Camelid" className={inp} /></Field>
        <Field label="Preferred Contact Method"><input value={f.PreferredContact} onChange={set('PreferredContact')} placeholder="e.g. Call, Text, Email" className={inp} /></Field>
        <Field label="Services Offered" className="sm:col-span-2"><textarea value={f.ServicesOffered} onChange={set('ServicesOffered')} rows={2} placeholder="e.g. Pregnancy checks, AI, herd health consultations, emergency calls..." className={inp} /></Field>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave(f)} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthVetContacts() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showForm, setShowForm] = useState(false);
  const [editing, setEditing] = useState(null);
  const [deleting, setDeleting] = useState(null);
  const [search, setSearch] = useState('');

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  const load = useCallback(() => {
    if (!BusinessID) return;
    setLoading(true);
    fetch(`${API}/api/herd-health/vet-contacts?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/vet-contacts/${editing.VetContactID}`
      : `${API}/api/herd-health/vet-contacts?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/vet-contacts/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const filtered = search
    ? rows.filter(r => [r.Name, r.ClinicName, r.Role, r.SpeciesServed].some(v => v?.toLowerCase().includes(search.toLowerCase())))
    : rows;

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Vet Contacts"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Vet Contacts' }]}>
      <div className="space-y-4 max-w-4xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Veterinary Contacts</h1>
            <p className="font-mont text-xs text-gray-500">Your vet, farrier, nutritionist, extension agent, and other livestock professional directory.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Add Contact</button>
        </div>

        {rows.length > 0 && (
          <input value={search} onChange={e => setSearch(e.target.value)}
            placeholder="Search by name, clinic, role, or species…"
            className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500" />
        )}

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : filtered.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">{rows.length === 0 ? 'No contacts yet.' : 'No contacts match your search.'}</div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {filtered.map(row => (
              <div key={row.VetContactID}>
                {editing?.VetContactID === row.VetContactID ? (
                  <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                ) : (
                  <div className="bg-white rounded-xl border border-gray-200 p-4 space-y-2">
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <div className="font-mont font-bold text-gray-900 text-sm">{row.Name}</div>
                        {row.Role && <div className="font-mont text-xs text-green-700 font-semibold">{row.Role}</div>}
                        {row.ClinicName && <div className="font-mont text-xs text-gray-500">{row.ClinicName}</div>}
                      </div>
                      <div className="flex gap-1 shrink-0">
                        <button onClick={() => setEditing(row)} className="font-mont text-xs text-gray-400 hover:text-gray-600 px-2 py-1 rounded hover:bg-gray-100">Edit</button>
                        {deleting === row.VetContactID
                          ? <><button onClick={() => del(row.VetContactID)} className="font-mont text-xs text-red-600 font-semibold px-2 py-1 rounded bg-red-50">✓</button>
                              <button onClick={() => setDeleting(null)} className="font-mont text-xs text-gray-400 px-2 py-1 rounded hover:bg-gray-100">✕</button></>
                          : <button onClick={() => setDeleting(row.VetContactID)} className="font-mont text-xs text-red-400 hover:text-red-600 px-2 py-1 rounded hover:bg-red-50">Del</button>
                        }
                      </div>
                    </div>
                    <div className="grid grid-cols-1 gap-1">
                      {row.Phone && (
                        <a href={`tel:${row.Phone}`} className="font-mont text-xs text-blue-600 hover:underline flex items-center gap-1">
                          <span>📞</span> {row.Phone}
                        </a>
                      )}
                      {row.EmergencyPhone && (
                        <a href={`tel:${row.EmergencyPhone}`} className="font-mont text-xs text-red-600 hover:underline flex items-center gap-1">
                          <span>🚨</span> Emergency: {row.EmergencyPhone}
                        </a>
                      )}
                      {row.Email && (
                        <a href={`mailto:${row.Email}`} className="font-mont text-xs text-blue-600 hover:underline flex items-center gap-1">
                          <span>✉</span> {row.Email}
                        </a>
                      )}
                    </div>
                    {row.SpeciesServed && <div className="font-mont text-xs text-gray-400">Species: {row.SpeciesServed}</div>}
                    {row.ServicesOffered && <div className="font-mont text-xs text-gray-400 line-clamp-2">{row.ServicesOffered}</div>}
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
