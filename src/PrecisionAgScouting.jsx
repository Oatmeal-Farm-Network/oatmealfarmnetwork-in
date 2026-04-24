import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, API_URL } from './precisionAgUtils';

const CATEGORIES = ['General', 'Pest', 'Disease', 'Weed', 'Irrigation', 'Nutrient', 'Weather'];
const SEVERITIES = ['Low', 'Medium', 'High', 'Critical'];

const SEV_COLOR = { Low: '#10B981', Medium: '#F59E0B', High: '#F97316', Critical: '#EF4444' };
const CAT_ICON  = { General: '📋', Pest: '🐛', Disease: '🦠', Weed: '🌿', Irrigation: '💧', Nutrient: '⚗️', Weather: '⛈️' };

function ScoutCard({ scout, onDelete }) {
  const [confirming, setConfirming] = useState(false);
  const sevColor = SEV_COLOR[scout.severity] || '#9CA3AF';
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-4">
      <div className="flex-shrink-0 text-2xl w-10 text-center">{CAT_ICON[scout.category] || '📋'}</div>
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2 flex-wrap mb-1">
          <span className="font-mont text-sm font-semibold text-gray-800">{scout.category}</span>
          {scout.severity && (
            <span className="px-2 py-0.5 rounded-full text-xs font-mont font-bold" style={{ background: sevColor + '22', color: sevColor }}>
              {scout.severity}
            </span>
          )}
          <span className="font-mont text-xs text-gray-400 ml-auto">
            {new Date(scout.observed_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
          </span>
        </div>
        {scout.notes && <p className="font-mont text-sm text-gray-600 mb-2">{scout.notes}</p>}
        {scout.image_url && (
          <img src={scout.image_url} alt="Scout" className="w-32 h-24 object-cover rounded-lg border border-gray-100 mb-2" onError={e => e.currentTarget.style.display='none'} />
        )}
        {(scout.latitude || scout.longitude) && (
          <div className="font-mont text-xs text-gray-400">{scout.latitude?.toFixed(5)}, {scout.longitude?.toFixed(5)}</div>
        )}
      </div>
      <div className="flex-shrink-0">
        {confirming ? (
          <div className="flex flex-col gap-1">
            <button onClick={() => onDelete(scout.scout_id)} className="text-xs px-2 py-1 bg-red-500 text-white rounded font-mont">Confirm</button>
            <button onClick={() => setConfirming(false)} className="text-xs px-2 py-1 border border-gray-200 rounded font-mont">Cancel</button>
          </div>
        ) : (
          <button onClick={() => setConfirming(true)} className="text-xs text-gray-400 hover:text-red-500 font-mont">Delete</button>
        )}
      </div>
    </div>
  );
}

function AddScoutForm({ fieldId, onSaved, onCancel }) {
  const [form, setForm] = useState({
    category: 'General', severity: '', notes: '',
    observed_at: new Date().toISOString().slice(0, 10),
    latitude: '', longitude: '',
  });
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const submit = async () => {
    if (!form.notes.trim()) { setError('Please add a note.'); return; }
    setSaving(true); setError('');
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/scouts`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...form,
          observed_at: form.observed_at + 'T00:00:00',
          latitude:  form.latitude  ? parseFloat(form.latitude)  : null,
          longitude: form.longitude ? parseFloat(form.longitude) : null,
        }),
      });
      if (!r.ok) throw new Error(await r.text());
      onSaved(await r.json());
    } catch (e) {
      setError(String(e));
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="bg-white rounded-xl border border-gray-200 p-5 space-y-4">
      <h3 className="font-lora font-bold text-gray-900">New Observation</h3>
      {error && <div className="text-xs text-red-600 bg-red-50 rounded px-3 py-2 font-mont">{error}</div>}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div className="flex flex-col gap-1">
          <label className="text-xs font-semibold font-mont text-gray-500">Date</label>
          <input type="date" value={form.observed_at} onChange={e => set('observed_at', e.target.value)}
            className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2" />
        </div>
        <div className="flex flex-col gap-1">
          <label className="text-xs font-semibold font-mont text-gray-500">Category</label>
          <select value={form.category} onChange={e => set('category', e.target.value)}
            className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2">
            {CATEGORIES.map(c => <option key={c}>{c}</option>)}
          </select>
        </div>
        <div className="flex flex-col gap-1">
          <label className="text-xs font-semibold font-mont text-gray-500">Severity</label>
          <select value={form.severity} onChange={e => set('severity', e.target.value)}
            className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2">
            <option value="">— none —</option>
            {SEVERITIES.map(s => <option key={s}>{s}</option>)}
          </select>
        </div>
      </div>
      <div className="flex flex-col gap-1">
        <label className="text-xs font-semibold font-mont text-gray-500">Notes *</label>
        <textarea value={form.notes} onChange={e => set('notes', e.target.value)} rows={3}
          placeholder="Describe what you observed..."
          className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 resize-none" />
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="flex flex-col gap-1">
          <label className="text-xs font-semibold font-mont text-gray-500">Latitude (optional)</label>
          <input type="number" step="any" value={form.latitude} onChange={e => set('latitude', e.target.value)}
            placeholder="e.g. 41.8781"
            className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2" />
        </div>
        <div className="flex flex-col gap-1">
          <label className="text-xs font-semibold font-mont text-gray-500">Longitude (optional)</label>
          <input type="number" step="any" value={form.longitude} onChange={e => set('longitude', e.target.value)}
            placeholder="e.g. -87.6298"
            className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2" />
        </div>
      </div>
      <div className="flex justify-end gap-3">
        <button onClick={onCancel} className="px-4 py-2 text-sm font-mont text-gray-500 border border-gray-200 rounded-lg hover:bg-gray-50">Cancel</button>
        <button onClick={submit} disabled={saving}
          className="px-5 py-2 text-sm font-mont font-semibold bg-[#6D8E22] text-white rounded-lg hover:bg-[#5a7519] disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Observation'}
        </button>
      </div>
    </div>
  );
}

export default function PrecisionAgScouting() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const [scouts, setScouts] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showForm, setShowForm] = useState(false);
  const [filterCat, setFilterCat] = useState('All');

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);

  const loadScouts = useCallback(async () => {
    if (!selectedFieldId) return;
    setLoading(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/scouts`);
      setScouts(r.ok ? await r.json() : []);
    } finally {
      setLoading(false);
    }
  }, [selectedFieldId]);

  useEffect(() => { loadScouts(); }, [loadScouts]);

  const handleDelete = async (id) => {
    await fetch(`${API_URL}/api/fields/${selectedFieldId}/scouts/${id}`, { method: 'DELETE' });
    setScouts(s => s.filter(x => x.scout_id !== id));
  };

  const filtered = filterCat === 'All' ? scouts : scouts.filter(s => s.category === filterCat);

  const counts = CATEGORIES.reduce((acc, c) => {
    acc[c] = scouts.filter(s => s.category === c).length;
    return acc;
  }, {});

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Scouting" breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Scouting' }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div className="flex items-start justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Field Scouting</h1>
            <p className="font-mont text-sm text-gray-500">Log pest, disease, weed, and irrigation observations tied to a field and date.</p>
          </div>
          <button onClick={() => setShowForm(true)}
            className="px-4 py-2 bg-[#6D8E22] text-white text-sm font-mont font-semibold rounded-lg hover:bg-[#5a7519]">
            + Add Observation
          </button>
        </div>

        {/* Field selector */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-4 flex-wrap items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Field</label>
            <select value={selectedFieldId} onChange={e => { setSelectedFieldId(e.target.value); setShowForm(false); }}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-52">
              {fields.length === 0 && <option value="">No fields</option>}
              {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
            </select>
          </div>
          {scouts.length > 0 && (
            <div className="font-mont text-xs text-gray-400 self-end pb-2">
              {scouts.length} observation{scouts.length !== 1 ? 's' : ''} total
            </div>
          )}
        </div>

        {showForm && (
          <AddScoutForm
            fieldId={selectedFieldId}
            onSaved={s => { setScouts(prev => [s, ...prev]); setShowForm(false); }}
            onCancel={() => setShowForm(false)}
          />
        )}

        {/* Category filter pills */}
        {scouts.length > 0 && (
          <div className="flex gap-2 flex-wrap">
            {['All', ...CATEGORIES].map(c => {
              const active = filterCat === c;
              const count = c === 'All' ? scouts.length : (counts[c] || 0);
              if (c !== 'All' && count === 0) return null;
              return (
                <button key={c} onClick={() => setFilterCat(c)}
                  className="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-mont font-semibold border transition-all"
                  style={{ background: active ? '#6D8E22' : 'white', borderColor: active ? '#6D8E22' : '#E5E7EB', color: active ? 'white' : '#6B7280' }}>
                  {c !== 'All' && CAT_ICON[c]} {c}
                  <span className="ml-0.5 opacity-70">{count}</span>
                </button>
              );
            })}
          </div>
        )}

        {/* Observations */}
        {loading ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : filtered.length === 0 ? (
          <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
            <div className="text-5xl mb-4">🔍</div>
            <div className="font-lora text-xl text-gray-600 mb-2">{scouts.length === 0 ? 'No observations yet' : 'No observations in this category'}</div>
            <div className="font-mont text-sm text-gray-400">
              {scouts.length === 0 ? 'Click "Add Observation" to log your first scouting note.' : 'Try selecting a different category.'}
            </div>
          </div>
        ) : (
          <div className="space-y-3">
            {filtered.map(s => <ScoutCard key={s.scout_id} scout={s} onDelete={handleDelete} />)}
          </div>
        )}

        {/* Summary stats */}
        {scouts.length > 0 && (
          <div className="bg-white rounded-xl border border-gray-200 p-5">
            <div className="font-mont text-sm font-semibold text-gray-600 mb-3">Severity Breakdown</div>
            <div className="flex gap-4 flex-wrap">
              {SEVERITIES.map(sev => {
                const count = scouts.filter(s => s.severity === sev).length;
                if (!count) return null;
                return (
                  <div key={sev} className="flex items-center gap-2">
                    <span className="w-3 h-3 rounded-full" style={{ background: SEV_COLOR[sev] }} />
                    <span className="font-mont text-sm text-gray-600">{sev}</span>
                    <span className="font-mont text-sm font-bold" style={{ color: SEV_COLOR[sev] }}>{count}</span>
                  </div>
                );
              })}
            </div>
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
