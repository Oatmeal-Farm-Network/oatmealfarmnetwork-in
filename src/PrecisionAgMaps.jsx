import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, useAnalyses, getIndex, useRaster, ndviColor } from './precisionAgUtils';
import SaigeWidget from './SaigeWidget';

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

function FieldMap({ fieldId, indexKey, analysisId = null, height = 420 }) {
  const { data, loading, error } = useRaster(fieldId, indexKey, COLS, analysisId);

  if (loading) return (
    <div className="flex items-center justify-center text-gray-400 font-mont text-sm animate-pulse" style={{ height }}>
      Loading raster…
    </div>
  );
  if (error || !data?.grid?.values) return (
    <div className="flex items-center justify-center text-gray-400 font-mont text-sm" style={{ height }}>
      {error ? `Couldn't load raster: ${error}` : 'No data — run an analysis first'}
    </div>
  );

  const { values, rows: gRows, cols: gCols } = data.grid;
  const min = data.raster?.min ?? 0;
  const max = data.raster?.max ?? 1;
  const cellW = 100 / gCols, cellH = 100 / gRows;

  return (
    <div className="relative w-full overflow-hidden rounded-lg" style={{ height }}>
      <svg viewBox="0 0 100 100" preserveAspectRatio="none" className="w-full h-full">
        {values.flatMap((row, r) => row.map((v, c) => {
          if (v == null) return <rect key={`${r}-${c}`} x={c*cellW} y={r*cellH} width={cellW+0.1} height={cellH+0.1} fill="#F3F4F6" />;
          return (
            <rect key={`${r}-${c}`}
              x={c * cellW} y={r * cellH}
              width={cellW + 0.1} height={cellH + 0.1}
              fill={indexColor(v, min, max, indexKey)}>
              <title>{`${indexKey} = ${v.toFixed(3)}`}</title>
            </rect>
          );
        }))}
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

// Per-date raster thumbnail. Fetches the historical scene via analysis_id ONLY
// when that analysis has a satellite_acquired_at to anchor the time window —
// otherwise the per-date fetch falls back to "latest" on the backend, so we'd
// be making N redundant requests for the same scene. In that case we just
// show the index mean as a colored chip.
function DateThumbnail({ fieldId, indexKey, analysisId, satelliteAcquiredAt, indexData, date, cloudPercent, active, onClick }) {
  const canFetchScene = !!satelliteAcquiredAt;
  const { data, loading } = useRaster(fieldId, indexKey, 16, canFetchScene ? analysisId : null);
  const meanFallback = indexData ? indexColor(indexData.mean, indexData.min, indexData.max, indexKey) : '#E5E7EB';
  const heavyCloud = cloudPercent != null && cloudPercent > 30;

  return (
    <button onClick={onClick}
      className={`rounded-lg border overflow-hidden text-left transition-all ${active ? 'border-[#6D8E22] ring-2 ring-[#6D8E22]/30' : 'border-gray-100 hover:border-gray-300'}`}>
      <div className="relative w-full" style={{ paddingBottom: '62.5%', background: meanFallback }}>
        {canFetchScene && loading && (
          <div className="absolute inset-0 flex items-center justify-center text-white/60 text-[10px] font-mont animate-pulse bg-black/10">…</div>
        )}
        {canFetchScene && data?.grid?.values && (
          <svg viewBox={`0 0 ${data.grid.cols} ${data.grid.rows}`} preserveAspectRatio="none" className="absolute inset-0 w-full h-full">
            {data.grid.values.flatMap((row, r) => row.map((v, c) => {
              if (v == null) return <rect key={`${r}-${c}`} x={c} y={r} width="1.05" height="1.05" fill="#F3F4F6" />;
              return <rect key={`${r}-${c}`} x={c} y={r} width="1.05" height="1.05"
                fill={indexColor(v, data.raster.min, data.raster.max, indexKey)} />;
            }))}
          </svg>
        )}
        {heavyCloud && (
          <div className="absolute inset-0 pointer-events-none" style={{
            background: 'repeating-linear-gradient(45deg, rgba(255,255,255,0.35) 0px, rgba(255,255,255,0.35) 4px, transparent 4px, transparent 10px)'
          }} />
        )}
        {!data && !loading && !indexData && (
          <div className="absolute inset-0 bg-gray-100 flex items-center justify-center text-gray-300 text-xs">No data</div>
        )}
      </div>
      <div className="px-2 py-1.5 border-t border-gray-100">
        <div className="font-mont text-xs text-gray-600 font-semibold">
          {new Date(date).toLocaleDateString('en-US',{month:'short',day:'numeric'})}
        </div>
        {indexData && (
          <div className="font-mont text-xs text-gray-400">{indexData.mean.toFixed(3)}</div>
        )}
      </div>
    </button>
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
            <div className="flex justify-center mb-4"><svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"><polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"/><line x1="8" y1="2" x2="8" y2="18"/><line x1="16" y1="6" x2="16" y2="22"/></svg></div>
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
                <span className="font-mont text-xs text-gray-500">
                  As of {new Date(analysis.analysis_date).toLocaleDateString('en-US',{month:'long',day:'numeric',year:'numeric'})}
                  {analysis.cloud_percent > 20 && <span className="ml-2 text-amber-600">☁ {analysis.cloud_percent.toFixed(0)}% cloud cover</span>}
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
                fieldId={fieldIdNum}
                indexKey={selectedIndex}
                analysisId={analysis?.analysis_id || null}
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
                const active = i === selectedAnalysisIdx;
                return (
                  <DateThumbnail key={i}
                    fieldId={fieldIdNum}
                    indexKey={selectedIndex}
                    analysisId={a.analysis_id}
                    satelliteAcquiredAt={a.satellite_acquired_at}
                    indexData={iData}
                    date={a.analysis_date}
                    cloudPercent={a.cloud_percent}
                    active={active}
                    onClick={() => setSelectedAnalysisIdx(i)}
                  />
                );
              })}
            </div>
          </div>
        )}
      </div>
      <SaigeWidget businessId={BusinessID} fieldId={selectedFieldId} pageContext="Precision Ag — Maps" />
    </AccountLayout>
  );
}
