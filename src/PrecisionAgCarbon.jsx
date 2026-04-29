import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, API_URL } from './precisionAgUtils';

function ScoreGauge({ score }) {
  const color = score >= 75 ? '#16A34A' : score >= 50 ? '#D97706' : '#DC2626';
  const label = score >= 75 ? 'Good' : score >= 50 ? 'Fair' : 'Needs Improvement';
  const deg = (score / 100) * 180;
  const rad = (deg - 90) * (Math.PI / 180);
  const needleX = 50 + 35 * Math.cos(rad);
  const needleY = 50 + 35 * Math.sin(rad);
  return (
    <div className="flex flex-col items-center">
      <svg viewBox="0 0 100 60" className="w-48">
        <path d="M 10 50 A 40 40 0 0 1 90 50" fill="none" stroke="#FEE2E2" strokeWidth="8" strokeLinecap="round" />
        <path d="M 10 50 A 40 40 0 0 1 90 50" fill="none" stroke="#FEF3C7" strokeWidth="8" strokeLinecap="round"
          strokeDasharray="62.8" strokeDashoffset="31.4" />
        <path d="M 10 50 A 40 40 0 0 1 90 50" fill="none" stroke="#D1FAE5" strokeWidth="8" strokeLinecap="round"
          strokeDasharray="62.8" strokeDashoffset="62.8" />
        <path d={`M 10 50 A 40 40 0 0 1 ${needleX} ${needleY}`}
          fill="none" stroke={color} strokeWidth="3" strokeLinecap="round" />
        <circle cx="50" cy="50" r="4" fill={color} />
        <text x="50" y="42" textAnchor="middle" fontSize="14" fontWeight="bold" fill={color}>{score}</text>
        <text x="50" y="57" textAnchor="middle" fontSize="7" fill="#9CA3AF">{label}</text>
      </svg>
    </div>
  );
}

function OMChart({ history }) {
  if (!history || history.length < 2) return null;
  const W = 520, H = 120, PAD = { l: 40, r: 20, t: 12, b: 28 };
  const vals = history.map(h => h.om_pct).filter(Boolean);
  const minV = Math.max(0, Math.min(...vals) - 0.5);
  const maxV = Math.max(...vals) + 0.5;
  const cx = i => PAD.l + (i / Math.max(history.length - 1, 1)) * (W - PAD.l - PAD.r);
  const cy = v => PAD.t + (1 - (v - minV) / (maxV - minV)) * (H - PAD.t - PAD.b);
  const path = history.map((d, i) => d.om_pct ? `${i === 0 ? 'M' : 'L'}${cx(i)},${cy(d.om_pct)}` : '').join(' ');
  return (
    <svg viewBox={`0 0 ${W} ${H}`} className="w-full" style={{ maxHeight: 130 }}>
      {[minV, (minV + maxV) / 2, maxV].map(v => (
        <g key={v}>
          <line x1={PAD.l} y1={cy(v)} x2={W - PAD.r} y2={cy(v)} stroke="#f0f0f0" strokeWidth="1" />
          <text x={PAD.l - 4} y={cy(v) + 4} textAnchor="end" fontSize="9" fill="#9CA3AF">{v.toFixed(1)}%</text>
        </g>
      ))}
      <path d={`${path} L${cx(history.length - 1)},${H - PAD.b} L${cx(0)},${H - PAD.b} Z`}
        fill="#16A34A" fillOpacity="0.1" />
      <path d={path} fill="none" stroke="#16A34A" strokeWidth="2" />
      {history.map((d, i) => d.om_pct ? (
        <circle key={i} cx={cx(i)} cy={cy(d.om_pct)} r="3.5" fill="#16A34A" stroke="white" strokeWidth="1.5" />
      ) : null)}
      {history.map((d, i) => (
        <text key={i} x={cx(i)} y={H - 6} textAnchor="middle" fontSize="8" fill="#9CA3AF">
          {d.date ? d.date.slice(0, 7) : d.label?.slice(0, 6)}
        </text>
      ))}
    </svg>
  );
}

const ROTATION_COLORS = ['#6D8E22','#2563EB','#7C3AED','#D97706','#0891B2','#059669','#DC2626'];

export default function PrecisionAgCarbon() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);

  const load = useCallback(async () => {
    if (!selectedFieldId) return;
    setLoading(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/carbon`);
      setData(r.ok ? await r.json() : null);
    } catch { setData(null); }
    setLoading(false);
  }, [selectedFieldId]);

  useEffect(() => { load(); }, [load]);

  const selectedField = fields.find(f => String(f.fieldid || f.id) === selectedFieldId);
  const uniqueCrops = data ? [...new Set((data.rotation_history || []).map(r => r.crop).filter(Boolean))] : [];

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Carbon" breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Carbon & Sustainability' }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div>
          <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Carbon & Sustainability</h1>
          <p className="font-mont text-sm text-gray-500">Soil organic matter trends, crop rotation diversity, and sustainability scoring.</p>
        </div>

        {/* Field selector */}
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <label className="text-xs font-semibold font-mont text-gray-500 block mb-1">Field</label>
          <select value={selectedFieldId} onChange={e => setSelectedFieldId(e.target.value)}
            className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-52">
            {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
          </select>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : !data ? (
          <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
            <div className="flex justify-center mb-4"><svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg></div>
            <div className="font-lora text-xl text-gray-600">No data available</div>
          </div>
        ) : (
          <>
            {/* Score + key metrics */}
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <div className="flex flex-wrap gap-8 items-center">
                <div>
                  <div className="font-mont text-sm font-semibold text-gray-600 mb-2 text-center">Sustainability Score</div>
                  <ScoreGauge score={data.sustainability_score} />
                </div>
                <div className="flex-1 grid grid-cols-2 sm:grid-cols-3 gap-4">
                  {[
                    { label: 'Latest SOC Stock',   value: data.latest_soc_MgCha != null ? `${data.latest_soc_MgCha} Mg C/ha` : '—', color: '#16A34A' },
                    { label: 'OM Trend',            value: data.om_trend_pct != null ? `${data.om_trend_pct > 0 ? '+' : ''}${data.om_trend_pct}%` : '—',
                                                     color: data.om_trend_pct > 0 ? '#16A34A' : data.om_trend_pct < 0 ? '#DC2626' : '#9CA3AF' },
                    { label: 'Cover Crop Seasons',  value: data.cover_crop_seasons, color: '#6D8E22' },
                    { label: 'Crop Diversity',      value: uniqueCrops.length > 0 ? `${uniqueCrops.length} crops` : '—', color: '#2563EB' },
                    { label: 'Rotation Records',    value: data.rotation_history?.length || 0, color: '#7C3AED' },
                    { label: 'Soil Samples',        value: data.om_history?.length || 0, color: '#D97706' },
                  ].map(s => (
                    <div key={s.label} className="bg-gray-50 rounded-xl border border-gray-100 px-3 py-2.5">
                      <div className="font-mont text-xs text-gray-400">{s.label}</div>
                      <div className="font-mont text-xl font-bold" style={{ color: s.color }}>{s.value}</div>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            {/* OM history chart */}
            {data.om_history?.length > 0 ? (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                <div className="font-mont text-sm font-semibold text-gray-600 mb-3">Soil Organic Matter Trend (%)</div>
                {data.om_history.length >= 2
                  ? <OMChart history={data.om_history} />
                  : (
                    <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
                      {data.om_history.map((s, i) => (
                        <div key={i} className="bg-gray-50 rounded-lg border border-gray-100 p-3">
                          <div className="font-mont text-xs text-gray-400">{s.label || s.date}</div>
                          <div className="font-mont text-xl font-bold text-[#16A34A]">{s.om_pct?.toFixed(1)}%</div>
                          <div className="font-mont text-xs text-gray-400">SOC: {s.soc_stock_MgCha} Mg C/ha</div>
                        </div>
                      ))}
                    </div>
                  )
                }
              </div>
            ) : (
              <div className="bg-gray-50 rounded-xl border border-gray-100 p-5 text-center">
                <div className="font-mont text-sm text-gray-400">No soil samples with organic matter data yet.</div>
                <div className="font-mont text-xs text-gray-400 mt-1">Add soil samples in the Soil Samples section to track OM trends.</div>
              </div>
            )}

            {/* Crop rotation timeline */}
            {data.rotation_history?.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                <div className="font-mont text-sm font-semibold text-gray-600 mb-3">Crop Rotation History</div>
                <div className="space-y-2">
                  {data.rotation_history.map((rot, i) => {
                    const color = ROTATION_COLORS[uniqueCrops.indexOf(rot.crop) % ROTATION_COLORS.length] || '#9CA3AF';
                    return (
                      <div key={i} className="flex items-center gap-3">
                        <div className="w-16 font-mont text-xs font-bold text-gray-500 text-right flex-shrink-0">
                          {rot.season_year}
                        </div>
                        <div className="w-2 h-2 rounded-full flex-shrink-0" style={{ background: color }} />
                        <div className="flex-1 flex items-center gap-2 flex-wrap">
                          <span className="font-mont text-sm font-semibold" style={{ color }}>
                            {rot.crop}{rot.variety ? ` (${rot.variety})` : ''}
                          </span>
                          {rot.is_cover_crop && (
                            <span className="font-mont text-xs px-2 py-0.5 rounded-full bg-green-100 text-green-700">Cover</span>
                          )}
                          {rot.yield_amount && (
                            <span className="font-mont text-xs text-gray-400">
                              Yield: {rot.yield_amount} {rot.yield_unit}
                            </span>
                          )}
                        </div>
                      </div>
                    );
                  })}
                </div>
                <div className="mt-4 flex flex-wrap gap-2">
                  {uniqueCrops.map((c, i) => (
                    <span key={c} className="font-mont text-xs px-2 py-0.5 rounded-full text-white"
                      style={{ background: ROTATION_COLORS[i % ROTATION_COLORS.length] }}>
                      {c}
                    </span>
                  ))}
                </div>
              </div>
            )}

            {data.rotation_history?.length === 0 && (
              <div className="bg-gray-50 rounded-xl border border-gray-100 p-5 text-center">
                <div className="font-mont text-sm text-gray-400">No crop rotation records yet.</div>
                <div className="font-mont text-xs text-gray-400 mt-1">Add rotation history in the Crop Rotation section.</div>
              </div>
            )}

            {/* Carbon credit estimator */}
            {selectedField?.field_size_hectares && data.latest_soc_MgCha != null && (() => {
              const fieldHa = selectedField.field_size_hectares;
              const seqRate = data.om_trend_pct > 0 ? 0.3 : data.om_trend_pct < 0 ? 0.05 : 0.15;
              const annualCO2e = seqRate * fieldHa * 3.67;
              const lo = (annualCO2e * 15).toFixed(0);
              const hi = (annualCO2e * 50).toFixed(0);
              return (
                <div className="bg-white rounded-xl border border-gray-200 p-5">
                  <div className="font-mont text-sm font-semibold text-gray-600 mb-3">Carbon Credit Estimator</div>
                  <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-4">
                    <div className="bg-gray-50 rounded-xl border border-gray-100 px-3 py-2.5">
                      <div className="font-mont text-xs text-gray-400">Field Area</div>
                      <div className="font-mont text-xl font-bold text-gray-800">{fieldHa.toFixed(1)} ha</div>
                    </div>
                    <div className="bg-gray-50 rounded-xl border border-gray-100 px-3 py-2.5">
                      <div className="font-mont text-xs text-gray-400">Seq. Rate</div>
                      <div className="font-mont text-xl font-bold text-gray-800">{seqRate} tC/ha/yr</div>
                    </div>
                    <div className="bg-gray-50 rounded-xl border border-gray-100 px-3 py-2.5">
                      <div className="font-mont text-xs text-gray-400">Annual CO₂e</div>
                      <div className="font-mont text-xl font-bold text-[#16A34A]">{annualCO2e.toFixed(1)} t</div>
                    </div>
                    <div className="bg-gray-50 rounded-xl border border-gray-100 px-3 py-2.5">
                      <div className="font-mont text-xs text-gray-400">Estimated Value</div>
                      <div className="font-mont text-xl font-bold text-[#16A34A]">${lo}–${hi}/yr</div>
                    </div>
                  </div>
                  <p className="font-mont text-xs text-gray-400">
                    Estimate based on OM trend ({data.om_trend_pct > 0 ? 'improving' : data.om_trend_pct < 0 ? 'declining' : 'stable'}) at $15–$50/tCO₂e market range.
                    For verified credits, consult a certified carbon registry program.
                  </p>
                </div>
              );
            })()}

            {/* Carbon methodology note */}
            <div className="bg-gray-50 rounded-xl border border-gray-100 p-4">
              <p className="font-mont text-xs text-gray-400">
                SOC (Soil Organic Carbon) estimated as OM% × 0.58 × bulk density (1.3 t/m³) × sample depth.
                Sustainability score reflects cover crop adoption, OM trend, and crop diversity.
                For formal carbon credit verification, use certified lab analysis and accredited methodology.
              </p>
            </div>
          </>
        )}
      </div>
    </AccountLayout>
  );
}
