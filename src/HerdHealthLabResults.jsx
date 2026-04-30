import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';
const TEST_PANELS = [
  'CBC (Complete Blood Count)', 'BMP / CMP (Metabolic Panel)', 'Liver Panel',
  'Fecal Egg Count', 'Fecal Culture', 'Brucellosis Test', 'TB Test (Tuberculin)',
  'Johne\'s Disease (ELISA)', 'BVD / IBR / PI3 Screen', 'Leptospirosis Titer',
  'Pregnancy Test', 'Culture & Sensitivity', 'PCR Panel', 'Mineral Profile',
  'Blood Urea Nitrogen (BUN)', 'Viral Serology', 'Toxicology Screen', 'Other',
];
const RESULT_STATUSES = ['Pending', 'Normal', 'Abnormal', 'Inconclusive', 'Positive', 'Negative'];
const STATUS_COLOR = { Pending: '#6B7280', Normal: '#10B981', Abnormal: '#EF4444', Inconclusive: '#F59E0B', Positive: '#DC2626', Negative: '#059669' };

const inp = "w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mont focus:outline-none focus:border-green-500";
function Field({ label, children, className }) {
  return <div className={className}><label className="block text-xs font-semibold text-gray-600 mb-1 font-mont">{label}</label>{children}</div>;
}

const EMPTY = {
  AnimalTag: '', GroupName: '', SampleDate: '', ResultDate: '', LabName: '',
  AccessionNumber: '', TestPanel: '', ResultStatus: 'Pending',
  ResultSummary: '', AbnormalValues: '', ReferenceRanges: '', Interpretation: '',
  VetReviewed: '', FollowUpRequired: '', FollowUpDate: '', Notes: '',
};

function Form({ init, onSave, onCancel }) {
  const [f, setF] = useState(init || EMPTY);
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));
  return (
    <div className="bg-gray-50 rounded-xl border border-gray-200 p-5 space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Field label="Animal Tag / ID"><input value={f.AnimalTag} onChange={set('AnimalTag')} className={inp} /></Field>
        <Field label="Group Name"><input value={f.GroupName} onChange={set('GroupName')} placeholder="e.g. Spring calves" className={inp} /></Field>
        <Field label="Sample Date"><input type="date" value={f.SampleDate} onChange={set('SampleDate')} className={inp} /></Field>
        <Field label="Result Date"><input type="date" value={f.ResultDate} onChange={set('ResultDate')} className={inp} /></Field>
        <Field label="Laboratory">
          <input value={f.LabName} onChange={set('LabName')} placeholder="e.g. Texas A&M TVMDL" className={inp} />
        </Field>
        <Field label="Accession / Lab Number"><input value={f.AccessionNumber} onChange={set('AccessionNumber')} className={inp} /></Field>
        <Field label="Test / Panel">
          <select value={f.TestPanel} onChange={set('TestPanel')} className={inp}>
            <option value="">— select —</option>
            {TEST_PANELS.map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="Result Status">
          <select value={f.ResultStatus} onChange={set('ResultStatus')} className={inp}>
            {RESULT_STATUSES.map(s => <option key={s}>{s}</option>)}
          </select>
        </Field>
        <Field label="Result Summary" className="sm:col-span-2"><textarea value={f.ResultSummary} onChange={set('ResultSummary')} rows={2} className={inp} /></Field>
        <Field label="Abnormal Values" className="sm:col-span-2"><textarea value={f.AbnormalValues} onChange={set('AbnormalValues')} rows={2} placeholder="List out-of-range values with units..." className={inp} /></Field>
        <Field label="Reference Ranges" className="sm:col-span-2"><textarea value={f.ReferenceRanges} onChange={set('ReferenceRanges')} rows={2} className={inp} /></Field>
        <Field label="Clinical Interpretation" className="sm:col-span-2"><textarea value={f.Interpretation} onChange={set('Interpretation')} rows={3} className={inp} /></Field>
        <Field label="Vet Reviewed"><input value={f.VetReviewed} onChange={set('VetReviewed')} className={inp} /></Field>
        <Field label="Follow-Up Required?">
          <select value={f.FollowUpRequired} onChange={set('FollowUpRequired')} className={inp}>
            <option value="">— select —</option>
            <option>Yes</option><option>No</option>
          </select>
        </Field>
        <Field label="Follow-Up Date"><input type="date" value={f.FollowUpDate} onChange={set('FollowUpDate')} className={inp} /></Field>
        <Field label="Notes" className="sm:col-span-2"><textarea value={f.Notes} onChange={set('Notes')} rows={2} className={inp} /></Field>
      </div>
      <div className="flex gap-2">
        <button onClick={() => onSave(f)} className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>Save</button>
        <button onClick={onCancel} className="px-4 py-2 rounded-lg text-sm font-mont text-gray-600 bg-gray-200 hover:bg-gray-300">Cancel</button>
      </div>
    </div>
  );
}

export default function HerdHealthLabResults() {
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
    fetch(`${API}/api/herd-health/lab-results?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : []).then(setRows).catch(() => setRows([]))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const save = async (f) => {
    const method = editing ? 'PUT' : 'POST';
    const url = editing
      ? `${API}/api/herd-health/lab-results/${editing.LabResultID}`
      : `${API}/api/herd-health/lab-results?business_id=${BusinessID}`;
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(f) });
    setShowForm(false); setEditing(null); load();
  };
  const del = async (id) => {
    await fetch(`${API}/api/herd-health/lab-results/${id}`, { method: 'DELETE' });
    setDeleting(null); load();
  };

  const today = new Date().toISOString().slice(0, 10);
  const pending = rows.filter(r => r.ResultStatus === 'Pending');
  const abnormal = rows.filter(r => r.ResultStatus === 'Abnormal' || r.ResultStatus === 'Positive');

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Lab Results"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Lab Results' }]}>
      <div className="space-y-4 max-w-5xl">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-lora text-xl font-bold text-gray-900">Laboratory Results</h1>
            <p className="font-mont text-xs text-gray-500">Blood panels, cultures, titers, PCR tests, fecal exams, and all diagnostic lab work.</p>
          </div>
          <button onClick={() => { setShowForm(true); setEditing(null); }}
            className="px-4 py-2 rounded-lg text-white text-sm font-mont font-semibold" style={{ backgroundColor: ACCENT }}>+ Add Result</button>
        </div>

        {(pending.length > 0 || abnormal.length > 0) && (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {pending.length > 0 && <div className="bg-gray-100 border border-gray-300 rounded-xl px-4 py-3 font-mont text-sm text-gray-700"><strong>{pending.length}</strong> result{pending.length > 1 ? 's' : ''} pending.</div>}
            {abnormal.length > 0 && <div className="bg-red-50 border border-red-200 rounded-xl px-4 py-3 font-mont text-sm text-red-800">⚠ <strong>{abnormal.length}</strong> abnormal or positive result{abnormal.length > 1 ? 's' : ''} — review needed.</div>}
          </div>
        )}

        {(showForm && !editing) && <Form onSave={save} onCancel={() => setShowForm(false)} />}

        {loading ? (
          <div className="text-center py-12 font-mont text-sm text-gray-400 animate-pulse">Loading…</div>
        ) : rows.length === 0 ? (
          <div className="text-center py-16 bg-white rounded-xl border border-gray-200 font-mont text-sm text-gray-400">No lab results on file yet.</div>
        ) : (
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <table className="w-full text-xs font-mont">
              <thead className="bg-gray-50 border-b border-gray-100">
                <tr>
                  {['Animal/Group', 'Sample Date', 'Test', 'Lab', 'Status', 'Vet Reviewed', ''].map(h => (
                    <th key={h} className="px-3 py-2.5 text-left font-semibold text-gray-500">{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {rows.map(row => (
                  editing?.LabResultID === row.LabResultID ? (
                    <tr key={row.LabResultID}><td colSpan={7} className="p-3">
                      <Form init={editing} onSave={save} onCancel={() => setEditing(null)} />
                    </td></tr>
                  ) : (
                    <tr key={row.LabResultID} className="hover:bg-gray-50">
                      <td className="px-3 py-2.5 font-semibold text-gray-800">{row.AnimalTag ? `#${row.AnimalTag}` : row.GroupName || '—'}</td>
                      <td className="px-3 py-2.5 text-gray-500">{row.SampleDate?.slice(0, 10)}</td>
                      <td className="px-3 py-2.5 text-gray-700">{row.TestPanel}</td>
                      <td className="px-3 py-2.5 text-gray-400">{row.LabName}</td>
                      <td className="px-3 py-2.5">
                        <span className="font-semibold px-1.5 py-0.5 rounded text-white text-xs" style={{ backgroundColor: STATUS_COLOR[row.ResultStatus] || '#9CA3AF' }}>
                          {row.ResultStatus}
                        </span>
                      </td>
                      <td className="px-3 py-2.5 text-gray-500">{row.VetReviewed || '—'}</td>
                      <td className="px-3 py-2.5">
                        <div className="flex gap-1">
                          <button onClick={() => setEditing(row)} className="text-gray-400 hover:text-gray-600 px-1.5 py-0.5 rounded hover:bg-gray-100">Edit</button>
                          {deleting === row.LabResultID
                            ? <><button onClick={() => del(row.LabResultID)} className="text-red-600 font-semibold px-1.5 py-0.5 rounded bg-red-50">✓</button>
                                <button onClick={() => setDeleting(null)} className="text-gray-400 px-1.5 py-0.5 rounded hover:bg-gray-100">✕</button></>
                            : <button onClick={() => setDeleting(row.LabResultID)} className="text-red-400 hover:text-red-600 px-1.5 py-0.5 rounded hover:bg-red-50">Del</button>
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
