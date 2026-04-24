import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, useAnalyses, getIndex, API_URL } from './precisionAgUtils';

function StatCard({ label, value, sub, color }) {
  return (
    <div className="bg-gray-50 rounded-lg border border-gray-100 px-4 py-3 flex flex-col gap-0.5">
      <span className="font-mont text-xs text-gray-400">{label}</span>
      <span className="font-mont text-lg font-bold" style={{ color: color || '#374151' }}>{value}</span>
      {sub && <span className="font-mont text-xs text-gray-400">{sub}</span>}
    </div>
  );
}

function HealthBadge({ score }) {
  if (score == null) return <span className="text-gray-300">—</span>;
  const color = score >= 70 ? '#16A34A' : score >= 50 ? '#D97706' : '#DC2626';
  const label = score >= 70 ? 'Good' : score >= 50 ? 'Fair' : 'Poor';
  return (
    <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-mont font-bold"
      style={{ background: color + '18', color }}>
      {score}% {label}
    </span>
  );
}

export default function PrecisionAgReports() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const { analyses, loading } = useAnalyses(selectedFieldId);
  const [scouts, setScouts] = useState([]);
  const [soilSamples, setSoilSamples] = useState([]);
  const [downloading, setDownloading] = useState(false);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);

  const load = useCallback(async () => {
    if (!selectedFieldId) return;
    const [sr, ss] = await Promise.all([
      fetch(`${API_URL}/api/fields/${selectedFieldId}/scouts`).then(r => r.ok ? r.json() : []),
      fetch(`${API_URL}/api/fields/${selectedFieldId}/soil-samples`).then(r => r.ok ? r.json() : []),
    ]);
    setScouts(sr);
    setSoilSamples(ss);
  }, [selectedFieldId]);
  useEffect(() => { load(); }, [load]);

  const selectedField = fields.find(f => String(f.fieldid || f.id) === selectedFieldId);
  const latest = analyses[0] || null;
  const ndviMean = getIndex(latest, 'NDVI')?.mean;

  const downloadExcel = async () => {
    setDownloading(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/report.xlsx`);
      if (!r.ok) throw new Error(await r.text());
      const blob = await r.blob();
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `field_${selectedFieldId}_report.xlsx`;
      a.click();
      URL.revokeObjectURL(url);
    } catch (e) {
      alert('Download failed: ' + e.message);
    } finally {
      setDownloading(false);
    }
  };

  // Trend: avg NDVI last 30 days vs prior 30 days
  const now = new Date();
  const recent = analyses.filter(a => (now - new Date(a.analysis_date)) / 86400000 <= 30);
  const prior  = analyses.filter(a => { const d = (now - new Date(a.analysis_date)) / 86400000; return d > 30 && d <= 60; });
  const avgRecent = recent.length ? recent.reduce((s, a) => s + (getIndex(a,'NDVI')?.mean ?? 0), 0) / recent.length : null;
  const avgPrior  = prior.length  ? prior.reduce((s, a)  => s + (getIndex(a,'NDVI')?.mean ?? 0), 0) / prior.length  : null;
  const trend = avgRecent != null && avgPrior != null ? avgRecent - avgPrior : null;

  // Soil averages
  const soilAvg = (key) => {
    const vals = soilSamples.map(s => s[key]).filter(v => v != null);
    return vals.length ? vals.reduce((a, b) => a + b, 0) / vals.length : null;
  };

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Reports" breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Reports' }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div className="flex items-start justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Field Reports</h1>
            <p className="font-mont text-sm text-gray-500">Full-field summary combining satellite analysis, soil samples, and scouting data. Export to Excel.</p>
          </div>
          <button onClick={downloadExcel} disabled={!selectedFieldId || downloading}
            className="flex items-center gap-2 px-5 py-2.5 bg-[#6D8E22] text-white text-sm font-mont font-semibold rounded-lg hover:bg-[#5a7519] disabled:opacity-50">
            {downloading ? '⏳ Preparing…' : '↓ Download Excel Report'}
          </button>
        </div>

        {/* Field selector */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-4 flex-wrap items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Field</label>
            <select value={selectedFieldId} onChange={e => setSelectedFieldId(e.target.value)}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-52">
              {fields.length === 0 && <option value="">No fields</option>}
              {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
            </select>
          </div>
          {selectedField && (
            <div className="font-mont text-xs text-gray-400 self-end pb-2">
              {selectedField.crop_type && <span className="mr-3">Crop: {selectedField.crop_type}</span>}
              {selectedField.field_size_hectares && <span>{selectedField.field_size_hectares.toFixed(1)} ha</span>}
            </div>
          )}
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : (
          <>
            {/* Summary cards */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
              <StatCard label="Analyses" value={analyses.length} sub="satellite passes" />
              <StatCard label="Current Health" value={latest ? <HealthBadge score={latest.health_score} /> : '—'} />
              <StatCard
                label="NDVI Trend (30d)"
                value={trend != null ? `${trend > 0 ? '+' : ''}${trend.toFixed(3)}` : '—'}
                color={trend != null ? (trend > 0 ? '#16A34A' : trend < 0 ? '#DC2626' : '#9CA3AF') : '#9CA3AF'}
                sub={trend != null ? (trend > 0 ? 'Improving' : trend < 0 ? 'Declining' : 'Stable') : 'Not enough data'}
              />
              <StatCard label="Scout Observations" value={scouts.length} sub={scouts.filter(s => s.severity === 'High' || s.severity === 'Critical').length + ' high/critical'} />
            </div>

            {/* Latest satellite analysis */}
            {latest && (
              <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
                <div className="px-5 py-3 border-b border-gray-100 font-mont text-sm font-semibold text-gray-600">
                  Latest Satellite Analysis —{' '}
                  <span className="font-normal text-gray-400">
                    {new Date(latest.analysis_date).toLocaleDateString('en-US',{month:'long',day:'numeric',year:'numeric'})}
                  </span>
                </div>
                <div className="p-5 grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-4">
                  {['NDVI','NDRE','EVI','GNDVI','NDWI'].map(k => {
                    const d = getIndex(latest, k);
                    return (
                      <div key={k} className="flex flex-col gap-0.5">
                        <span className="font-mont text-xs text-gray-400">{k}</span>
                        <span className="font-mont text-xl font-bold text-gray-800">{d?.mean?.toFixed(3) ?? '—'}</span>
                        {d && <span className="font-mont text-xs text-gray-400">Range {d.min?.toFixed(2)} – {d.max?.toFixed(2)}</span>}
                      </div>
                    );
                  })}
                </div>
              </div>
            )}

            {/* Analysis history mini-table */}
            {analyses.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
                <div className="px-5 py-3 border-b border-gray-100 font-mont text-sm font-semibold text-gray-600">
                  Analysis History ({analyses.length} passes)
                </div>
                <div className="overflow-x-auto">
                  <table className="w-full text-sm font-mont">
                    <thead>
                      <tr className="bg-gray-50 border-b border-gray-100">
                        <th className="text-left px-4 py-2.5 text-gray-500 font-semibold text-xs">Date</th>
                        <th className="text-center px-3 py-2.5 text-gray-500 font-semibold text-xs">NDVI</th>
                        <th className="text-center px-3 py-2.5 text-gray-500 font-semibold text-xs">NDRE</th>
                        <th className="text-center px-3 py-2.5 text-gray-500 font-semibold text-xs">EVI</th>
                        <th className="text-center px-3 py-2.5 text-gray-500 font-semibold text-xs">Health</th>
                        <th className="text-center px-3 py-2.5 text-gray-500 font-semibold text-xs">Cloud %</th>
                      </tr>
                    </thead>
                    <tbody>
                      {analyses.slice(0, 12).map((a, i) => (
                        <tr key={i} className="border-t border-gray-50 hover:bg-gray-50">
                          <td className="px-4 py-2 text-gray-700 font-semibold text-xs">
                            {new Date(a.analysis_date).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'})}
                          </td>
                          {['NDVI','NDRE','EVI'].map(k => (
                            <td key={k} className="px-3 py-2 text-center text-gray-600 text-xs">{getIndex(a,k)?.mean?.toFixed(3)??'—'}</td>
                          ))}
                          <td className="px-3 py-2 text-center text-xs"><HealthBadge score={a.health_score} /></td>
                          <td className="px-3 py-2 text-center text-gray-400 text-xs">{a.cloud_percent?.toFixed(1)??'—'}%</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            {/* Soil samples summary */}
            {soilSamples.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                <div className="font-mont text-sm font-semibold text-gray-600 mb-3">
                  Soil Samples — Field Average ({soilSamples.length} samples)
                </div>
                <div className="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-5 gap-3">
                  {[
                    { key:'ph',            label:'pH',     fmt: v => v?.toFixed(1) },
                    { key:'organic_matter',label:'OM %',   fmt: v => v?.toFixed(1) },
                    { key:'nitrogen',      label:'N kg/ha',fmt: v => v?.toFixed(0) },
                    { key:'phosphorus',    label:'P kg/ha',fmt: v => v?.toFixed(0) },
                    { key:'potassium',     label:'K kg/ha',fmt: v => v?.toFixed(0) },
                  ].map(n => {
                    const v = soilAvg(n.key);
                    return (
                      <div key={n.key} className="bg-gray-50 rounded-lg border border-gray-100 px-3 py-2">
                        <div className="font-mont text-xs text-gray-400">{n.label}</div>
                        <div className="font-mont text-lg font-bold text-gray-800">{v != null ? n.fmt(v) : '—'}</div>
                      </div>
                    );
                  })}
                </div>
              </div>
            )}

            {/* Scouting summary */}
            {scouts.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                <div className="font-mont text-sm font-semibold text-gray-600 mb-3">
                  Scouting Summary ({scouts.length} observations)
                </div>
                <div className="space-y-2">
                  {scouts.slice(0, 5).map(s => (
                    <div key={s.scout_id} className="flex items-center gap-3 text-sm font-mont">
                      <span className="text-gray-400 w-24 text-xs flex-shrink-0">
                        {new Date(s.observed_at).toLocaleDateString('en-US',{month:'short',day:'numeric'})}
                      </span>
                      <span className="text-gray-700">{s.category}</span>
                      {s.severity && (
                        <span className="text-xs px-2 py-0.5 rounded-full font-semibold"
                          style={{ background: {Low:'#D1FAE5',Medium:'#FEF3C7',High:'#FEE2E2',Critical:'#FEE2E2'}[s.severity] || '#F3F4F6',
                                   color: {Low:'#065F46',Medium:'#92400E',High:'#B91C1C',Critical:'#7F1D1D'}[s.severity] || '#6B7280' }}>
                          {s.severity}
                        </span>
                      )}
                      <span className="text-gray-500 text-xs truncate">{s.notes}</span>
                    </div>
                  ))}
                  {scouts.length > 5 && (
                    <div className="font-mont text-xs text-gray-400">+{scouts.length - 5} more — download Excel for full list</div>
                  )}
                </div>
              </div>
            )}

            {/* Empty state */}
            {analyses.length === 0 && soilSamples.length === 0 && scouts.length === 0 && (
              <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
                <div className="text-5xl mb-4">📄</div>
                <div className="font-lora text-xl text-gray-600 mb-2">No data yet</div>
                <div className="font-mont text-sm text-gray-400">
                  Run a satellite analysis, add soil samples, or log scouting observations to generate a report.
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </AccountLayout>
  );
}
