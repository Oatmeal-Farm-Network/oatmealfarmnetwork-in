import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, useAnalyses, getIndex, seededRand, ndviColor, generateMapCells, calcHaFromGeojson } from './precisionAgUtils';

// ─── Zoning map ───────────────────────────────────────────────────────────────
function ZoneMap({ cells, numZones, min, max, palette, cols = 32, rows = 20 }) {
  if (!cells) return (
    <div className="flex items-center justify-center text-gray-400 font-mont text-sm rounded-xl bg-gray-50 border border-dashed border-gray-200"
      style={{ minHeight: 260 }}>
      Select a field and run an analysis to generate zone data
    </div>
  );
  const range = max - min || 0.01;
  const PALETTES = {
    ndvi:  ['#A32715','#C86419','#DCB428','#AAD232','#5AA528','#1E6414'],
    blue:  ['#1E3A5F','#1D4ED8','#3B82F6','#60A5FA','#93C5FD','#DBEAFE'],
    warm:  ['#7C2D12','#C2410C','#F97316','#FB923C','#FED7AA','#FFF7ED'],
    cool:  ['#064E3B','#065F46','#047857','#10B981','#6EE7B7','#D1FAE5'],
    mono:  ['#111827','#374151','#6B7280','#9CA3AF','#D1D5DB','#F9FAFB'],
  };
  const pal = PALETTES[palette] || PALETTES.ndvi;

  return (
    <div className="rounded-xl overflow-hidden border border-gray-200" style={{ display: 'grid', gridTemplateColumns: `repeat(${cols}, 1fr)`, height: 260 }}>
      {cells.map((cell, i) => {
        const t = (cell.v - min) / range;
        const zoneIdx = Math.min(numZones - 1, Math.floor(t * numZones));
        const color = pal[Math.floor((zoneIdx / Math.max(1, numZones - 1)) * (pal.length - 1))];
        return <div key={i} style={{ background: color }} />;
      })}
    </div>
  );
}

// ─── Mini histogram for zone panel ───────────────────────────────────────────
function ZoneHistogram({ cells, numZones, min, max, palette }) {
  if (!cells) return null;
  const range = max - min || 0.01;
  const bins = Array(numZones).fill(0);
  cells.forEach(cell => {
    const zoneIdx = Math.min(numZones - 1, Math.floor(((cell.v - min) / range) * numZones));
    bins[zoneIdx]++;
  });
  const maxBin = Math.max(...bins, 1);
  const PALETTES = {
    ndvi: ['#A32715','#C86419','#DCB428','#AAD232','#5AA528','#1E6414'],
    blue: ['#1E3A5F','#1D4ED8','#3B82F6','#60A5FA','#93C5FD','#DBEAFE'],
    warm: ['#7C2D12','#C2410C','#F97316','#FB923C','#FED7AA','#FFF7ED'],
    cool: ['#064E3B','#065F46','#047857','#10B981','#6EE7B7','#D1FAE5'],
    mono: ['#111827','#374151','#6B7280','#9CA3AF','#D1D5DB','#F9FAFB'],
  };
  const pal = PALETTES[palette] || PALETTES.ndvi;
  const W = 300, H = 80, PL = 4, PR = 4, PT = 4, PB = 4;
  const cW = W - PL - PR, cH = H - PT - PB;
  const binW = cW / numZones;
  return (
    <svg viewBox={`0 0 ${W} ${H}`} className="w-full" style={{ height: 80 }}>
      {bins.map((count, i) => {
        const bH = Math.max(2, (count / maxBin) * cH);
        const color = pal[Math.floor((i / Math.max(1, numZones - 1)) * (pal.length - 1))];
        return <rect key={i} x={PL + i * binW + 1} y={PT + cH - bH} width={Math.max(1, binW - 2)} height={bH} fill={color} rx="2" />;
      })}
    </svg>
  );
}

const ZONE_METHODS = ['Equidistant', 'Quantile', 'Natural Breaks'];
const PALETTES = [
  { key: 'ndvi',  label: 'NDVI (Red→Green)',  swatches: ['#A32715','#DCB428','#1E6414'] },
  { key: 'blue',  label: 'Blue Scale',         swatches: ['#1E3A5F','#3B82F6','#DBEAFE'] },
  { key: 'warm',  label: 'Warm (Red→Orange)',  swatches: ['#7C2D12','#F97316','#FFF7ED'] },
  { key: 'cool',  label: 'Cool (Green)',        swatches: ['#064E3B','#10B981','#D1FAE5'] },
  { key: 'mono',  label: 'Monochrome',          swatches: ['#111827','#6B7280','#F9FAFB'] },
];

export default function PrecisionAgZoning() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const { analyses, loading } = useAnalyses(selectedFieldId);

  // Zone config
  const [zoneMethod,   setZoneMethod]   = useState('Equidistant');
  const [numZones,     setNumZones]     = useState(2);
  const [palette,      setPalette]      = useState('ndvi');
  const [smoothEdges,  setSmoothEdges]  = useState(false);
  const [selectedIdx,  setSelectedIdx]  = useState('NDVI');
  const [analysisIdx,  setAnalysisIdx]  = useState(0);
  const [saved,        setSaved]        = useState(false);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);

  const analysis    = analyses[analysisIdx] || null;
  const indexData   = analysis ? getIndex(analysis, selectedIdx) : null;
  const fieldIdNum  = parseInt(selectedFieldId) || 1;
  const cells       = indexData ? generateMapCells(indexData, fieldIdNum, selectedIdx, 32, 20) : null;

  const totalHa = (() => {
    const f = fields.find(f => String(f.fieldid || f.id) === selectedFieldId);
    if (!f) return null;
    return f.field_size_hectares ? parseFloat(f.field_size_hectares)
      : f.boundary_geojson ? calcHaFromGeojson(f.boundary_geojson)
      : null;
  })();

  // Zone stats
  const zoneStats = (() => {
    if (!cells || !indexData) return [];
    const { min, max } = indexData;
    const range = max - min || 0.01;
    const counts = Array(numZones).fill(0);
    cells.forEach(cell => {
      const zi = Math.min(numZones - 1, Math.floor(((cell.v - min) / range) * numZones));
      counts[zi]++;
    });
    const total = cells.length;
    return counts.map((count, i) => ({
      zone: i + 1,
      pct: count / total,
      ha: totalHa ? (count / total) * totalHa : null,
    }));
  })();

  const ZONE_PALETTE_COLORS = {
    ndvi: ['#A32715','#C86419','#DCB428','#AAD232','#5AA528','#1E6414'],
    blue: ['#1E3A5F','#1D4ED8','#3B82F6','#60A5FA','#93C5FD','#DBEAFE'],
    warm: ['#7C2D12','#C2410C','#F97316','#FB923C','#FED7AA','#FFF7ED'],
    cool: ['#064E3B','#065F46','#047857','#10B981','#6EE7B7','#D1FAE5'],
    mono: ['#111827','#374151','#6B7280','#9CA3AF','#D1D5DB','#F9FAFB'],
  };
  const pal = ZONE_PALETTE_COLORS[palette] || ZONE_PALETTE_COLORS.ndvi;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Zoning"
      breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Zoning' }]}>
      <div className="max-w-full mx-auto">
        <div className="mb-5">
          <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Zoning</h1>
          <p className="font-mont text-sm text-gray-500">
            Management-zone maps built from clustering vegetation indices. Drive variable-rate applications and targeted scouting.
          </p>
        </div>

        {/* Field + index selectors */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 mb-5 flex gap-4 flex-wrap items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Field</label>
            <select value={selectedFieldId} onChange={e => setSelectedFieldId(e.target.value)}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-[200px]">
              {fields.length === 0 && <option value="">No fields</option>}
              {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
            </select>
          </div>
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Index</label>
            <select value={selectedIdx} onChange={e => setSelectedIdx(e.target.value)}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2">
              {['NDVI','NDRE','EVI','GNDVI','NDWI'].map(k => <option key={k} value={k}>{k}</option>)}
            </select>
          </div>
          {analyses.length > 0 && (
            <div className="flex flex-col gap-1">
              <label className="text-xs font-semibold font-mont text-gray-500">Date</label>
              <select value={analysisIdx} onChange={e => setAnalysisIdx(Number(e.target.value))}
                className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2">
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

        {loading ? (
          <div className="flex items-center justify-center py-32 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : (
          <div className="flex gap-5 items-start flex-wrap lg:flex-nowrap">
            {/* ── Left config panel ── */}
            <div className="bg-white rounded-xl border border-gray-200 p-5 flex-shrink-0 space-y-5" style={{ minWidth: 280, maxWidth: 320, width: '100%' }}>
              {/* Zone method */}
              <div>
                <label className="text-xs font-semibold font-mont text-gray-500 block mb-1.5">Zone method</label>
                <select value={zoneMethod} onChange={e => setZoneMethod(e.target.value)}
                  className="w-full border border-gray-300 rounded-lg text-sm font-mont px-3 py-2">
                  {ZONE_METHODS.map(m => <option key={m} value={m}>{m}</option>)}
                </select>
              </div>

              {/* Number of zones */}
              <div>
                <label className="text-xs font-semibold font-mont text-gray-500 block mb-1.5">Number of Zones</label>
                <div className="flex gap-1.5">
                  {[2,3,4,5,6,7].map(n => (
                    <button key={n} onClick={() => setNumZones(n)}
                      className="flex-1 h-9 text-sm font-mont font-bold rounded-lg transition-all border"
                      style={{
                        background:   numZones === n ? '#1D4ED8' : 'white',
                        color:        numZones === n ? 'white'   : '#374151',
                        borderColor:  numZones === n ? '#1D4ED8' : '#D1D5DB',
                      }}>
                      {n}
                    </button>
                  ))}
                </div>
              </div>

              {/* Color palette */}
              <div>
                <label className="text-xs font-semibold font-mont text-gray-500 block mb-1.5">Color palette</label>
                <div className="space-y-2">
                  {PALETTES.map(p => (
                    <button key={p.key} onClick={() => setPalette(p.key)}
                      className="w-full flex items-center gap-2 px-3 py-2 rounded-lg border transition-all text-left"
                      style={{ borderColor: palette === p.key ? '#1D4ED8' : '#E5E7EB', background: palette === p.key ? '#EFF6FF' : 'white' }}>
                      <div className="flex gap-0.5 flex-shrink-0">
                        {p.swatches.map((c, i) => <span key={i} className="w-4 h-4 rounded-sm" style={{ background: c }} />)}
                      </div>
                      <span className="text-xs font-mont text-gray-600">{p.label}</span>
                    </button>
                  ))}
                </div>
              </div>

              {/* Smooth edges */}
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold font-mont text-gray-500">Smooth edges</span>
                <button onClick={() => setSmoothEdges(s => !s)}
                  className="relative w-11 h-6 rounded-full transition-colors flex-shrink-0"
                  style={{ background: smoothEdges ? '#1D4ED8' : '#D1D5DB' }}>
                  <span className="absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform"
                    style={{ transform: smoothEdges ? 'translateX(20px)' : 'translateX(0)' }} />
                </button>
              </div>

              {/* Mini histogram */}
              {cells && <div>
                <div className="text-xs font-semibold font-mont text-gray-500 mb-1">Distribution</div>
                <ZoneHistogram cells={cells} numZones={numZones} min={indexData.min} max={indexData.max} palette={palette} />
              </div>}

              {/* Zone legend */}
              {zoneStats.length > 0 && (
                <div>
                  <div className="text-xs font-semibold font-mont text-gray-500 mb-2">Zones</div>
                  <div className="space-y-1.5">
                    {zoneStats.map((zs, i) => {
                      const color = pal[Math.floor((i / Math.max(1, numZones - 1)) * (pal.length - 1))];
                      return (
                        <div key={i} className="flex items-center justify-between text-xs font-mont">
                          <div className="flex items-center gap-2">
                            <span className="w-4 h-4 rounded-sm flex-shrink-0" style={{ background: color }} />
                            <span className="text-gray-700">Zone {zs.zone}</span>
                          </div>
                          <span className="text-gray-500">
                            {zs.ha ? `${zs.ha.toFixed(2)} ha` : `${(zs.pct * 100).toFixed(0)}%`}
                          </span>
                        </div>
                      );
                    })}
                  </div>
                </div>
              )}

              {/* Actions */}
              <div className="flex gap-2 pt-2 border-t border-gray-100">
                <button
                  onClick={() => { setSaved(true); setTimeout(() => setSaved(false), 2000); }}
                  disabled={!cells}
                  className="flex-1 py-2 rounded-lg font-mont font-bold text-sm text-white transition-all disabled:opacity-40"
                  style={{ background: '#1D4ED8' }}>
                  {saved ? '✓ Saved' : 'Create Zoning'}
                </button>
              </div>
            </div>

            {/* ── Right map panel ── */}
            <div className="flex-1 min-w-0 space-y-4">
              {analyses.length === 0 ? (
                <div className="bg-white rounded-xl border border-gray-200 flex items-center justify-center" style={{ minHeight: 340 }}>
                  <div className="text-center">
                    <div className="text-4xl mb-3">🗺️</div>
                    <div className="font-lora text-gray-600 text-lg mb-1">No analysis data</div>
                    <div className="font-mont text-sm text-gray-400">Run an analysis to generate zone maps.</div>
                  </div>
                </div>
              ) : (
                <div className="bg-white rounded-xl border border-gray-200 p-5">
                  <div className="flex items-center justify-between mb-3 flex-wrap gap-2">
                    <span className="font-mont text-sm font-semibold text-gray-600">
                      {fields.find(f => String(f.fieldid||f.id) === selectedFieldId)?.name} · {selectedIdx} · {zoneMethod} · {numZones} zones
                    </span>
                    {analysis && (
                      <span className="font-mont text-xs text-gray-400">
                        {new Date(analysis.analysis_date).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'})}
                      </span>
                    )}
                  </div>
                  <ZoneMap cells={cells} numZones={numZones} min={indexData?.min || 0} max={indexData?.max || 1} palette={palette} />

                  {/* Color scale legend */}
                  {indexData && (
                    <div className="mt-3 flex items-center gap-3">
                      <span className="font-mont text-xs text-gray-400">-1.00</span>
                      <div className="flex-1 h-4 rounded flex overflow-hidden">
                        {pal.map((c, i) => <div key={i} className="flex-1" style={{ background: c }} />)}
                      </div>
                      <span className="font-mont text-xs text-gray-400">1.00</span>
                      <div className="ml-3 flex flex-col gap-0.5">
                        <span className="font-mont text-xs text-blue-600 cursor-pointer hover:underline">Fixed</span>
                      </div>
                    </div>
                  )}
                </div>
              )}

              {/* Analysis info */}
              {analysis && indexData && (
                <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-6 flex-wrap text-sm font-mont text-gray-600">
                  <div><span className="text-gray-400 text-xs block">Index</span><strong>{selectedIdx}</strong></div>
                  <div><span className="text-gray-400 text-xs block">Date</span><strong>{new Date(analysis.analysis_date).toLocaleDateString()}</strong></div>
                  <div><span className="text-gray-400 text-xs block">Mean</span><strong>{indexData.mean.toFixed(3)}</strong></div>
                  <div><span className="text-gray-400 text-xs block">Min</span><strong>{indexData.min.toFixed(3)}</strong></div>
                  <div><span className="text-gray-400 text-xs block">Max</span><strong>{indexData.max.toFixed(3)}</strong></div>
                  {totalHa && <div><span className="text-gray-400 text-xs block">Field size</span><strong>{totalHa.toFixed(2)} ha</strong></div>}
                </div>
              )}
            </div>
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
