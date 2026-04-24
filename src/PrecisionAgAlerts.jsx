import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, API_URL } from './precisionAgUtils';

const SEV_COLOR = {
  Critical: { bg: '#FEE2E2', text: '#7F1D1D', dot: '#DC2626' },
  High:     { bg: '#FEE2E2', text: '#B91C1C', dot: '#EF4444' },
  Medium:   { bg: '#FEF3C7', text: '#92400E', dot: '#F59E0B' },
  Low:      { bg: '#D1FAE5', text: '#065F46', dot: '#10B981' },
};

const TYPE_ICON = {
  Health:       '🩺',
  'NDVI Decline': '📉',
  Scouting:     '🔍',
  Pest:         '🐛',
  Disease:      '🦠',
  Weed:         '🌿',
  Irrigation:   '💧',
  Nutrient:     '🌱',
};

function AlertCard({ alert, onDismiss }) {
  const sev = SEV_COLOR[alert.severity] || SEV_COLOR.Low;
  const icon = TYPE_ICON[alert.type] || '⚠️';
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4 flex items-start gap-3">
      <div className="w-9 h-9 rounded-full flex items-center justify-center text-lg flex-shrink-0"
        style={{ background: sev.bg }}>
        {icon}
      </div>
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2 flex-wrap">
          <span className="font-mont text-xs font-bold px-2 py-0.5 rounded-full"
            style={{ background: sev.bg, color: sev.text }}>
            {alert.severity}
          </span>
          <span className="font-mont text-xs text-gray-500">{alert.type}</span>
          <span className="font-mont text-xs text-gray-400 ml-auto">{alert.date}</span>
        </div>
        <p className="font-mont text-sm text-gray-800 mt-1">{alert.message}</p>
        {alert.source && (
          <p className="font-mont text-xs text-gray-400 mt-0.5 capitalize">Source: {alert.source.replace('_', ' ')}</p>
        )}
      </div>
      <button onClick={() => onDismiss(alert.alert_id)}
        className="text-gray-300 hover:text-gray-500 text-lg leading-none flex-shrink-0 mt-0.5" title="Dismiss">
        ×
      </button>
    </div>
  );
}

export default function PrecisionAgAlerts() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const [alerts, setAlerts] = useState([]);
  const [loading, setLoading] = useState(false);
  const [dismissed, setDismissed] = useState(() => {
    try { return new Set(JSON.parse(localStorage.getItem('ag_dismissed_alerts') || '[]')); }
    catch { return new Set(); }
  });

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);

  const load = useCallback(async () => {
    if (!selectedFieldId) return;
    setLoading(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/alerts`);
      const data = r.ok ? await r.json() : { alerts: [] };
      setAlerts(data.alerts || []);
    } catch { setAlerts([]); }
    setLoading(false);
  }, [selectedFieldId]);

  useEffect(() => { load(); }, [load]);

  const dismiss = (id) => {
    const next = new Set([...dismissed, id]);
    setDismissed(next);
    localStorage.setItem('ag_dismissed_alerts', JSON.stringify([...next]));
  };

  const visible = alerts.filter(a => !dismissed.has(a.alert_id));
  const bySeverity = (s) => visible.filter(a => a.severity === s);

  const counts = {
    Critical: bySeverity('Critical').length,
    High:     bySeverity('High').length,
    Medium:   bySeverity('Medium').length,
    Low:      bySeverity('Low').length,
  };

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Alerts" breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Alerts' }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div className="flex items-start justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Field Alerts</h1>
            <p className="font-mont text-sm text-gray-500">Health warnings, NDVI declines, and scouting flags surfaced automatically.</p>
          </div>
          <button onClick={load} className="px-4 py-2 text-sm font-mont font-semibold bg-gray-100 hover:bg-gray-200 rounded-lg text-gray-700">
            ↻ Refresh
          </button>
        </div>

        {/* Field selector */}
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <label className="text-xs font-semibold font-mont text-gray-500 block mb-1">Field</label>
          <select value={selectedFieldId} onChange={e => setSelectedFieldId(e.target.value)}
            className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-52">
            {fields.length === 0 && <option value="">No fields</option>}
            {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
          </select>
        </div>

        {/* Summary pills */}
        {!loading && visible.length > 0 && (
          <div className="grid grid-cols-4 gap-3">
            {['Critical','High','Medium','Low'].map(sev => {
              const c = SEV_COLOR[sev];
              return (
                <div key={sev} className="rounded-xl border p-3 text-center"
                  style={{ background: c.bg + '80', borderColor: c.dot + '40' }}>
                  <div className="font-mont text-2xl font-bold" style={{ color: c.text }}>{counts[sev]}</div>
                  <div className="font-mont text-xs" style={{ color: c.text }}>{sev}</div>
                </div>
              );
            })}
          </div>
        )}

        {loading ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : visible.length === 0 ? (
          <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
            <div className="text-5xl mb-4">✅</div>
            <div className="font-lora text-xl text-gray-600 mb-2">No active alerts</div>
            <div className="font-mont text-sm text-gray-400">All clear — no issues detected for this field.</div>
          </div>
        ) : (
          <div className="space-y-3">
            {['Critical','High','Medium','Low'].flatMap(sev =>
              bySeverity(sev).map(a => <AlertCard key={a.alert_id} alert={a} onDismiss={dismiss} />)
            )}
            {dismissed.size > 0 && (
              <button onClick={() => {
                setDismissed(new Set());
                localStorage.removeItem('ag_dismissed_alerts');
              }} className="font-mont text-xs text-gray-400 hover:text-gray-600 underline">
                Restore {dismissed.size} dismissed alert{dismissed.size > 1 ? 's' : ''}
              </button>
            )}
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
