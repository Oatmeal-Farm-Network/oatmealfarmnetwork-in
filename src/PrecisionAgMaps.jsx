import React, { useState, useEffect, useMemo } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, useAnalyses, getIndex, generateMapCells, ndviColor } from './precisionAgUtils';

const INDEX_CONFIGS = [
  { key: 'NDVI',  label: 'NDVI',  desc: 'Vegetation density & biomass' },
  { key: 'NDRE',  label: 'NDRE',  desc: 'Nitrogen stress / red edge' },
  { key: 'EVI',   label: 'EVI',   desc: 'Enhanced veg, low soil noise' },
  { key: 'GNDVI', label: 'GNDVI', desc: 'Chlorophyll concentration' },
  { key: 'MSAVI2',label: 'MSAVI2',desc: 'Soil-adjusted vegetation' },
  { key: 'NDWI',  label: 'NDWI',  desc: 'Canopy water content' },
];

const COLS = 48, ROWS = 32;

function indexColor(v, min, max, indexKey) {
  const t = max > min ? (v - min) / (max - min) : 0.5;
  if (indexKey === 'NDWI') {
    const r = Math.round(210 - t * 180);
    const g = Math.round(230 - t * 60);
    const b = Math.round(100 + t * 155);
    return `rgb(${r},${g},${b})`;
  }
  if (indexKey === 'NDRE') {
    const r = Math.round(30  + t * 20);
    const g = Math.round(60  + t * 90);
    const b = Math.round(180 - t * 60);
    return `rgb(${r},${g},${b})`;
  }
  return ndviColor(t);
}

function FieldMap({ indexData, fieldId, indexKey, height = 420 }) {
  const cells = useMemo(
    () => generateMapCells(indexData, fieldId, indexKey, COLS, ROWS),
    [indexData, fieldId, indexKey]
  );

  if (!cells) return (
    <div className="flex items-center justify-center text-gray-400 font-mont text-sm" style={{ height }}>
      No data — run an analysis first
    </div>
  );

  const cellW = 100 / COLS, cellH = 100 / ROWS;

  return (
    <div className="relative w-full overflow-hidden rounded-lg" style={{ height }}>
      <svg viewBox="0 0 100 100" preserveAspectRatio="none" className="w-full h-full">
        {cells.map((cell, i) => {
          const col = i % COLS, row = Math.floor(i / COLS);
          return (
            <rect
              key={i}
              x={col * cellW} y={row * cellH}
              width={cellW + 0.1} height={cellH + 0.1}
              fill={indexColor(cell.v, cell.min, cell.max, indexKey)}
            />
          );
        })}
      </svg>
      {/* Coordinate grid overlay */}
      <svg viewBox="0 0 100 100" preserveAspectRatio="none" className="absolute inset-0 w-full h-full pointer-events-none opacity-10">
        {[1,2,3,4].map(i => (
          <line key={`v${i}`} x1={i*20} y1="0" x2={i*20} y2="100" stroke="white" strokeWidth="0.3" />
        ))}
        {[1,2,3,4].map(i => (
          <line key={`h${i}`} x1="0" y1={i*20} x2="100" y2={i*20} stroke="white" strokeWidth="0.3" />
        ))}
      </svg>
      {/* Field boundary */}
      <svg viewBox="0 0 100 100" preserveAspectRatio="none" className="absolute inset-0 w-full h-full pointer-events-none">
        <rect x="0" y="0" width="100" height="100" fill="none" stroke="white" strokeWidth="0.6" strokeDasharray="2,1" opacity="0.6" />
      </svg>
    </div>
  );
}

function ColorScaleLegend({ indexData, indexKey }) {
  if (!indexData) return null;
  const { min, max } = indexData;
  const stops = [0, 0.25, 0.5, 0.75, 1].map(t => {
    const v = min + t * (max - min);
    return { t, v, color: indexColor(v, min, max, indexKey) };
  });
  const gradient = `linear-gradient(to right, ${stops.map(s => s.color).join(', ')})`;
  return (
    <div className="flex items-center gap-3 mt-3">
      <span className="font-mont text-xs text-gray-400">{min.toFixed(2)}</span>
      <div className="flex-1 h-3 rounded" style={{ background: gradient }} />
      <span className="font-mont text-xs text-gray-400">{max.toFixed(2)}</span>
    </div>
  );
}

function StatPill({ label, value, color }) {
  return (
    <div className="flex flex-col items-center px-4 py-2 bg-gray-50 rounded-lg border border-gray-100">
      <span className="font-mont text-xs text-gray-400">{label}</span>
      <span className="font-mont text-sm font-bold mt-0.5" style={{ color: color || '#374151' }}>{value}</span>
    </div>
  );
}

export default function PrecisionAgMaps() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const { analyses, loading } = useAnalyses(selectedFieldId);
  const [selectedAnalysisIdx, setSelectedAnalysisIdx] = useState(0);
  const [selectedIndex, setSelectedIndex] = useState('NDVI');

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);
  useEffect(() => { setSelectedAnalysisIdx(0); }, [selectedFieldId]);

  const analysis = analyses[selectedAnalysisIdx] || null;
  const fieldIdNum = parseInt(selectedFieldId) || 1;
  const indexData = getIndex(analysis, selectedIndex);
  const selectedField = fields.find(f => String(f.fieldid || f.id) === selectedFieldId);

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Maps"
      breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Maps' }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div>
          <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Maps</h1>
          <p className="font-mont text-sm text-gray-500">
            Full-field vegetation index map — select a layer and date to visualize spatial variation across your acreage.
          </p>
        </div>

        {/* Toolbar */}
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
              <label className="text-xs font-semibold font-mont text-gray-500">Date</label>
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
          {analysis && (
            <div className="ml-auto font-mont text-xs text-gray-400">
              {analysis.cloud_percent != null && `Cloud: ${analysis.cloud_percent.toFixed(1)}%`}
            </div>
          )}
        </div>

        {/* Index selector pills */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex items-center gap-2 flex-wrap">
          <span className="text-xs font-semibold font-mont text-gray-500 mr-1">Layer:</span>
          {INDEX_CONFIGS.map(cfg => {
            const active = selectedIndex === cfg.key;
            return (
              <button key={cfg.key} onClick={() => setSelectedIndex(cfg.key)}
                title={cfg.desc}
                className="px-3 py-1.5 rounded-full text-xs font-mont font-semibold border transition-all"
                style={{
                  background: active ? '#6D8E22' : 'white',
                  borderColor: active ? '#6D8E22' : '#E5E7EB',
                  color: active ? 'white' : '#9CA3AF',
                }}>
                {cfg.label}
              </button>
            );
          })}
        </div>

        {/* Map area */}
        {loading ? (
          <div className="flex items-center justify-center py-32 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : analyses.length === 0 ? (
          <div className="text-center py-32 bg-white rounded-xl border border-gray-200">
            <div className="text-5xl mb-4">🗺️</div>
            <div className="font-lora text-xl text-gray-600 mb-2">No analysis data</div>
            <div className="font-mont text-sm text-gray-400">Run an analysis on this field to generate map data.</div>
          </div>
        ) : (
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            {/* Map header */}
            <div className="px-5 py-3 border-b border-gray-100 flex items-center gap-4 flex-wrap">
              <span className="font-mont text-sm font-semibold text-gray-700">
                {selectedField?.name} — {INDEX_CONFIGS.find(c => c.key === selectedIndex)?.label}
              </span>
              {analysis && (
                <span className="font-mont text-xs text-gray-400">
                  {new Date(analysis.analysis_date).toLocaleDateString('en-US',{month:'long',day:'numeric',year:'numeric'})}
                </span>
              )}
              {indexData && (
                <span className="ml-auto font-mont text-xs font-bold" style={{ color: '#6D8E22' }}>
                  Mean: {indexData.mean.toFixed(3)}
                </span>
              )}
            </div>

            {/* Map */}
            <div className="p-4">
              <FieldMap
                indexData={indexData}
                fieldId={fieldIdNum}
                indexKey={selectedIndex}
                height={440}
              />
              <ColorScaleLegend indexData={indexData} indexKey={selectedIndex} />
            </div>

            {/* Stats row */}
            {indexData && (
              <div className="px-5 py-4 border-t border-gray-100 flex gap-3 flex-wrap">
                <StatPill label="Min"  value={indexData.min.toFixed(3)}  />
                <StatPill label="Mean" value={indexData.mean.toFixed(3)} color="#6D8E22" />
                <StatPill label="Max"  value={indexData.max.toFixed(3)}  />
                <StatPill label="Range" value={(indexData.max - indexData.min).toFixed(3)} />
                {analysis.health_score != null && (
                  <StatPill
                    label="Health Score"
                    value={`${analysis.health_score}%`}
                    color={analysis.health_score >= 70 ? '#16A34A' : analysis.health_score >= 50 ? '#D97706' : '#DC2626'}
                  />
                )}
              </div>
            )}
          </div>
        )}

        {/* Analysis list — date thumbnails */}
        {analyses.length >= 2 && (
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <div className="px-5 py-3 border-b border-gray-100 font-mont text-sm font-semibold text-gray-600">
              {INDEX_CONFIGS.find(c => c.key === selectedIndex)?.label} — All Dates
            </div>
            <div className="p-4 grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3">
              {analyses.map((a, i) => {
                const iData = getIndex(a, selectedIndex);
                const cells = iData ? generateMapCells(iData, fieldIdNum + i * 7, selectedIndex, 16, 10) : null;
                const active = i === selectedAnalysisIdx;
                return (
                  <button key={i} onClick={() => setSelectedAnalysisIdx(i)}
                    className={`rounded-lg border overflow-hidden text-left transition-all ${active ? 'border-[#6D8E22] ring-2 ring-[#6D8E22]/30' : 'border-gray-100 hover:border-gray-300'}`}>
                    <div className="relative w-full" style={{ paddingBottom: '62.5%' }}>
                      {cells ? (
                        <svg viewBox="0 0 16 10" preserveAspectRatio="none" className="absolute inset-0 w-full h-full">
                          {cells.map((cell, ci) => {
                            const col = ci % 16, row = Math.floor(ci / 16);
                            return <rect key={ci} x={col} y={row} width="1.05" height="1.05"
                              fill={indexColor(cell.v, cell.min, cell.max, selectedIndex)} />;
                          })}
                        </svg>
                      ) : (
                        <div className="absolute inset-0 bg-gray-100 flex items-center justify-center text-gray-300 text-xs">No data</div>
                      )}
                    </div>
                    <div className="px-2 py-1.5 border-t border-gray-100">
                      <div className="font-mont text-xs text-gray-600 font-semibold">
                        {new Date(a.analysis_date).toLocaleDateString('en-US',{month:'short',day:'numeric'})}
                      </div>
                      {iData && (
                        <div className="font-mont text-xs text-gray-400">{iData.mean.toFixed(3)}</div>
                      )}
                    </div>
                  </button>
                );
              })}
            </div>
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
