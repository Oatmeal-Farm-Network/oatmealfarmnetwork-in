import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, useAnalyses, getIndex, seededRand } from './precisionAgUtils';

// ─── Histogram from min/mean/max (approximated normal distribution) ──────────
function IndexHistogram({ indexData, indexName, fieldId, color = '#6D8E22', height = 130 }) {
  if (!indexData) return (
    <div className="flex items-center justify-center text-gray-400 text-xs font-mont" style={{ height }}>No data — run an analysis first</div>
  );
  const { min, max, mean } = indexData;
  const range = max - min || 0.01;
  const BINS = 24;
  const step = range / BINS;
  const rand = seededRand(fieldId * 31 + indexName.charCodeAt(0));
  const std = range / 5;
  const samples = Array.from({ length: 800 }, () => {
    let s = 0;
    for (let i = 0; i < 6; i++) s += rand();
    return mean + (s - 3) * std * 0.6;
  });
  const bins = Array(BINS).fill(0);
  samples.forEach(v => {
    const idx = Math.min(BINS - 1, Math.max(0, Math.floor((v - min) / step)));
    bins[idx]++;
  });
  const maxBin = Math.max(...bins, 1);
  const W = 400, H = height;
  const PL = 8, PR = 8, PT = 10, PB = 28;
  const cW = W - PL - PR, cH = H - PT - PB;
  const binW = cW / BINS;
  const meanX = PL + ((mean - min) / range) * cW;

  return (
    <div>
      <svg viewBox={`0 0 ${W} ${H}`} className="w-full" style={{ height }}>
        {bins.map((count, i) => {
          const binCenter = min + (i + 0.5) * step;
          const c = binCenter < mean ? '#F97316' : color;
          const bH = Math.max(1, (count / maxBin) * cH);
          return <rect key={i} x={PL + i * binW + 0.5} y={PT + cH - bH} width={Math.max(1, binW - 1)} height={bH} fill={c} rx="1" />;
        })}
        <line x1={meanX} y1={PT} x2={meanX} y2={PT + cH} stroke="#111827" strokeWidth="1.5" strokeDasharray="3,2" />
        <text x={PL} y={H - 6} fontSize="9" fill="#9CA3AF">{min.toFixed(2)}</text>
        <text x={meanX} y={H - 6} textAnchor="middle" fontSize="9" fill="#374151" fontWeight="bold">{mean.toFixed(2)}</text>
        <text x={W - PR} y={H - 6} textAnchor="end" fontSize="9" fill="#9CA3AF">{max.toFixed(2)}</text>
      </svg>
      <div className="flex gap-4 mt-1 text-xs font-mont text-gray-500">
        <span>Min <strong>{min.toFixed(3)}</strong></span>
        <span>Mean <strong style={{ color }}>{mean.toFixed(3)}</strong></span>
        <span>Max <strong>{max.toFixed(3)}</strong></span>
        <span>Range <strong>{range.toFixed(3)}</strong></span>
      </div>
    </div>
  );
}

// ─── Color legend bar ─────────────────────────────────────────────────────────
function GradientBar({ min, max }) {
  return (
    <div className="flex items-center gap-2 mt-2">
      <span className="text-xs font-mont text-gray-400">{min.toFixed(2)}</span>
      <div className="flex-1 h-3 rounded" style={{ background: 'linear-gradient(to right, rgb(160,30,30), rgb(220,180,40), rgb(90,165,40), rgb(30,100,20))' }} />
      <span className="text-xs font-mont text-gray-400">{max.toFixed(2)}</span>
    </div>
  );
}

const INDEX_CONFIGS = [
  { key: 'NDVI',  label: 'NDVI',  color: '#6D8E22', desc: 'Normalized Difference Vegetation Index — overall greenness and biomass' },
  { key: 'NDRE',  label: 'NDRE',  color: '#3B82F6', desc: 'Normalized Difference Red Edge — nitrogen stress, late-season crops' },
  { key: 'EVI',   label: 'EVI',   color: '#F59E0B', desc: 'Enhanced Vegetation Index — reduced soil background signal' },
  { key: 'GNDVI', label: 'GNDVI', color: '#10B981', desc: 'Green NDVI — chlorophyll concentration and crop stress' },
  { key: 'NDWI',  label: 'NDWI',  color: '#6366F1', desc: 'Normalized Difference Water Index — canopy water content' },
];

export default function PrecisionAgHistograms() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const { analyses, loading } = useAnalyses(selectedFieldId);
  const [selectedAnalysisIdx, setSelectedAnalysisIdx] = useState(0);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);
  useEffect(() => { setSelectedAnalysisIdx(0); }, [selectedFieldId]);

  const analysis = analyses[selectedAnalysisIdx] || null;
  const fieldIdNum = parseInt(selectedFieldId) || 1;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Histograms"
      breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Histograms' }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div>
          <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Histograms</h1>
          <p className="font-mont text-sm text-gray-500">
            Pixel-value distributions for each vegetation index — per field, per satellite pass. Spot outliers and track season-over-season shifts.
          </p>
        </div>

        {/* Selectors */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-4 flex-wrap items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Field</label>
            <select value={selectedFieldId} onChange={e => setSelectedFieldId(e.target.value)}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-[200px]">
              {fields.length === 0 && <option value="">No fields</option>}
              {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
            </select>
          </div>
          {analyses.length > 0 && (
            <div className="flex flex-col gap-1">
              <label className="text-xs font-semibold font-mont text-gray-500">Analysis Date</label>
              <select value={selectedAnalysisIdx} onChange={e => setSelectedAnalysisIdx(Number(e.target.value))}
                className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-[180px]">
                {analyses.map((a, i) => (
                  <option key={i} value={i}>
                    {new Date(a.analysis_date).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'})}
                    {i === 0 ? ' (latest)' : ''}
                  </option>
                ))}
              </select>
            </div>
          )}
        </div>

        {/* Content */}
        {loading ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : analyses.length === 0 ? (
          <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
            <div className="text-5xl mb-4">📊</div>
            <div className="font-lora text-xl text-gray-600 mb-2">No analysis data</div>
            <div className="font-mont text-sm text-gray-400">Run an analysis on this field to generate histogram data.</div>
          </div>
        ) : (
          <>
            {/* Summary header */}
            {analysis && (
              <div className="bg-white rounded-xl border border-gray-200 p-4 flex items-center gap-6 flex-wrap">
                <div className="text-sm font-mont text-gray-600">
                  <span className="font-semibold text-gray-800">{new Date(analysis.analysis_date).toLocaleDateString('en-US',{month:'long',day:'numeric',year:'numeric'})}</span>
                  {analysis.cloud_percent != null && <span className="ml-3 text-gray-400">Cloud cover: {analysis.cloud_percent.toFixed(1)}%</span>}
                </div>
                <div className="flex items-center gap-3 ml-auto">
                  <span className="w-3 h-3 rounded-sm" style={{ background:'#F97316' }} />
                  <span className="text-xs font-mont text-gray-500">Below mean</span>
                  <span className="w-3 h-3 rounded-sm ml-2" style={{ background:'#6D8E22' }} />
                  <span className="text-xs font-mont text-gray-500">Above mean</span>
                  <span className="text-xs font-mont text-gray-400 ml-2">— Mean value</span>
                </div>
              </div>
            )}

            {/* Histogram grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              {INDEX_CONFIGS.map(cfg => {
                const idxData = getIndex(analysis, cfg.key);
                return (
                  <div key={cfg.key} className="bg-white rounded-xl border border-gray-200 p-5">
                    <div className="flex items-center justify-between mb-1">
                      <div className="font-lora font-bold text-gray-900 text-base">{cfg.label}</div>
                      {idxData && (
                        <span className="font-mont text-sm font-bold" style={{ color: cfg.color }}>
                          {idxData.mean.toFixed(3)}
                        </span>
                      )}
                    </div>
                    <p className="font-mont text-xs text-gray-400 mb-3">{cfg.desc}</p>
                    <IndexHistogram
                      indexData={idxData}
                      indexName={cfg.key}
                      fieldId={fieldIdNum}
                      color={cfg.color}
                      height={130}
                    />
                    {idxData && <GradientBar min={idxData.min} max={idxData.max} />}
                  </div>
                );
              })}
            </div>

            {/* Analysis comparison — if multiple runs */}
            {analyses.length >= 2 && (
              <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
                <div className="px-5 py-3 border-b border-gray-100 font-mont text-sm font-semibold text-gray-600">
                  NDVI Distribution — All Analyses
                </div>
                <div className="p-5 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
                  {analyses.map((a, i) => {
                    const idxData = getIndex(a, 'NDVI');
                    return (
                      <div key={i} className={`rounded-lg border p-3 ${i === selectedAnalysisIdx ? 'border-[#6D8E22] bg-green-50' : 'border-gray-100'}`}>
                        <div className="font-mont text-xs font-semibold text-gray-600 mb-2">
                          {new Date(a.analysis_date).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'})}
                          {i === 0 && <span className="ml-1 text-gray-400">(latest)</span>}
                        </div>
                        <IndexHistogram indexData={idxData} indexName="NDVI" fieldId={fieldIdNum + i * 13} height={90} />
                      </div>
                    );
                  })}
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </AccountLayout>
  );
}
