import React, { useState, useEffect, useRef } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';
const CROP_API_URL = window.location.hostname === 'localhost'
  ? 'http://127.0.0.1:8001'
  : 'https://crop-detection-802455386518.us-central1.run.app';

// ─── Safe API fetch (never throws, returns null on error) ─────────────────────
async function safeFetch(url) {
  try {
    const res = await fetch(url);
    if (!res.ok) return null;
    return await res.json();
  } catch {
    return null;
  }
}

// ─── Sparkline ────────────────────────────────────────────────────────────────
function Sparkline({ values }) {
  if (!values || values.length < 2) return null;
  const min = Math.min(...values);
  const max = Math.max(...values);
  const range = max - min || 1;
  const points = values.map((v, i) => {
    const x = (i / (values.length - 1)) * 100;
    const y = 100 - ((v - min) / range) * 100;
    return `${x},${y}`;
  }).join(' ');
  return (
    <svg viewBox="0 0 100 100" className="w-full h-8">
      <polyline fill="none" stroke="#6D8E22" strokeWidth="4" points={points} />
    </svg>
  );
}

// ─── Health donut ─────────────────────────────────────────────────────────────
function HealthDonut({ score }) {
  const color = score >= 70 ? '#21D727' : score >= 50 ? '#FFA500' : '#ED1A1A';
  const label = score >= 70 ? 'Good' : score >= 50 ? 'Fair' : 'Poor';
  return (
    <div className="flex flex-col items-center gap-1">
      <div style={{
        width: 64, height: 64, borderRadius: '50%',
        background: `conic-gradient(${color} ${score}%, #D9D9D9 0%)`,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
      }}>
        <div style={{ width: 44, height: 44, borderRadius: '50%', background: 'white' }} />
      </div>
      <div className="font-mont text-xs font-semibold text-center" style={{ color }}>
        {score}% · {label}
      </div>
    </div>
  );
}

// ─── Stat card ────────────────────────────────────────────────────────────────
function StatCard({ label, value, sub, bg = 'white' }) {
  return (
    <div className="rounded-xl border border-gray-100 p-4" style={{ background: bg }}>
      <div className="text-xs font-mont font-semibold text-gray-500 mb-1">{label}</div>
      <div className="text-2xl font-lora font-bold text-gray-900">{value ?? 'N/A'}</div>
      {sub && <div className="text-xs text-gray-400 mt-1">{sub}</div>}
    </div>
  );
}

// ─── Tab button ───────────────────────────────────────────────────────────────
function TabBtn({ label, active, onClick }) {
  return (
    <button
      onClick={onClick}
      className="px-4 py-2 rounded-lg font-mont text-sm font-semibold transition-all"
      style={{ background: active ? '#6D8E22' : '#E8EDE0', color: active ? 'white' : '#3a5a00' }}
    >
      {label}
    </button>
  );
}

// ─── Field Detail ─────────────────────────────────────────────────────────────
function FieldDetail({ field, businessId, onBack }) {
  const [tab, setTab] = useState('overview');
  const [analyses, setAnalyses] = useState([]);
  const [weather, setWeather] = useState(null);
  const [recommendations, setRecommendations] = useState([]);
  const [alerts, setAlerts] = useState([]);
  const [agronomy, setAgronomy] = useState(null);
  const [loading, setLoading] = useState(true);
  const [analyzing, setAnalyzing] = useState(false);

  const fieldId = field.fieldid || field.id;

  useEffect(() => { loadAll(); }, [fieldId]);

  async function loadAll() {
    setLoading(true);
    const [analysesRes, weatherRes, recsRes, alertsRes, agronomyRes] = await Promise.all([
      safeFetch(`${CROP_API_URL}/api/fields/${fieldId}/analyses?limit=10`),
      safeFetch(`${CROP_API_URL}/api/fields/${fieldId}/weather`),
      safeFetch(`${CROP_API_URL}/api/fields/${fieldId}/recommendations`),
      safeFetch(`${CROP_API_URL}/api/fields/${fieldId}/alerts?status=open`),
      safeFetch(`${CROP_API_URL}/api/fields/${fieldId}/agronomy`),
    ]);
    setAnalyses(analysesRes?.analyses || []);
    setWeather(weatherRes || null);
    setRecommendations(recsRes?.recommendations || []);
    setAlerts(alertsRes?.alerts || []);
    setAgronomy(agronomyRes || null);
    setLoading(false);
  }

  async function triggerAnalysis() {
    setAnalyzing(true);
    try {
      await fetch(`${CROP_API_URL}/api/fields/${fieldId}/analyze`, { method: 'POST' });
      setTimeout(loadAll, 5000);
    } catch {}
    finally { setAnalyzing(false); }
  }

  const latest = analyses[0];
  const getIndex = (a, name) => a?.vegetation_indices?.find(i => i.index_type === name);

  return (
    <div className="pb-16">
      {/* Header */}
      <div className="flex items-start justify-between mb-6">
        <div>
          <button onClick={onBack} className="text-[#6D8E22] font-mont text-sm font-semibold flex items-center gap-1 mb-3 hover:opacity-70">
            ← Back to Fields
          </button>
          <h1 className="font-lora text-3xl font-bold text-gray-900">{field.name}</h1>
          {field.address && (
            <p className="text-gray-500 font-mont text-sm mt-1">📍 {field.address}</p>
          )}
          <div className="flex gap-4 mt-2 text-sm text-gray-500 font-mont">
            {field.crop_type && <span>🌱 {field.crop_type}</span>}
            {field.field_size_hectares && <span>📏 {field.field_size_hectares} ha</span>}
          </div>
        </div>
        <button
          onClick={triggerAnalysis}
          disabled={analyzing}
          className="px-5 py-2.5 rounded-lg font-mont font-semibold text-white text-sm transition-all disabled:opacity-50"
          style={{ background: '#6D8E22' }}
        >
          {analyzing ? 'Analyzing…' : '▶ Run Analysis'}
        </button>
      </div>

      {/* Alerts */}
      {alerts.length > 0 && (
        <div className="rounded-xl border border-red-300 bg-red-50 p-4 mb-6">
          <div className="font-lora font-bold text-red-700 mb-2">⚠️ {alerts.length} Active Alert{alerts.length > 1 ? 's' : ''}</div>
          {alerts.map((a, i) => (
            <div key={i} className="text-sm text-red-700 font-mont">{a.message || a.alert_type}</div>
          ))}
        </div>
      )}

      {/* Tabs */}
      <div className="flex gap-2 mb-6">
        {['overview', 'analyses', 'weather', 'recommendations'].map(t => (
          <TabBtn key={t} label={t.charAt(0).toUpperCase() + t.slice(1)} active={tab === t} onClick={() => setTab(t)} />
        ))}
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm">Loading field data…</div>
      ) : (
        <>
          {/* ── OVERVIEW ── */}
          {tab === 'overview' && (
            <div className="space-y-6">
              {/* Top stats */}
              {latest ? (
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                  <StatCard label="Health Score" value={`${latest.health_score}%`} sub={latest.status} bg="#f0f5e8" />
                  <StatCard label="NDVI" value={getIndex(latest, 'NDVI')?.mean?.toFixed(2) ?? 'N/A'} sub={`Range ${getIndex(latest, 'NDVI')?.min?.toFixed(2) ?? '?'} – ${getIndex(latest, 'NDVI')?.max?.toFixed(2) ?? '?'}`} />
                  <StatCard label="Last Analysis" value={new Date(latest.analysis_date).toLocaleDateString()} sub={`Cloud ${latest.cloud_percent?.toFixed(1) ?? '?'}%`} />
                  <StatCard label="EVI" value={getIndex(latest, 'EVI')?.mean?.toFixed(2) ?? 'N/A'} />
                </div>
              ) : (
                <div className="text-center py-16 rounded-xl bg-gray-50 border border-gray-100">
                  <div className="text-4xl mb-3">📡</div>
                  <div className="font-lora text-xl text-gray-700 mb-1">No analysis data yet</div>
                  <div className="font-mont text-sm text-gray-400">Click "Run Analysis" to get started</div>
                </div>
              )}

              {/* Vegetation indices */}
              {latest && (
                <div>
                  <h3 className="font-lora font-bold text-gray-900 text-lg mb-3">Vegetation Indices</h3>
                  <div className="grid grid-cols-2 md:grid-cols-5 gap-3">
                    {['NDVI', 'NDRE', 'EVI', 'GNDVI', 'NDWI'].map(name => {
                      const idx = getIndex(latest, name);
                      return (
                        <div key={name} className="rounded-xl border border-gray-100 p-3 bg-white">
                          <div className="text-xs font-mont font-semibold text-gray-400 mb-1">{name}</div>
                          <div className="text-xl font-lora font-bold text-gray-900">{idx ? idx.mean.toFixed(2) : '—'}</div>
                          {idx && <div className="text-xs text-gray-400">{idx.min.toFixed(2)} – {idx.max.toFixed(2)}</div>}
                        </div>
                      );
                    })}
                  </div>
                  <div className="grid grid-cols-2 gap-4 mt-4">
                    <div className="rounded-xl border border-gray-100 bg-white p-3">
                      <div className="text-xs font-mont font-semibold text-gray-400 mb-1">NDVI Trend</div>
                      <Sparkline values={analyses.slice(0,6).map(a => getIndex(a,'NDVI')?.mean).filter(v => v != null).reverse()} />
                    </div>
                    <div className="rounded-xl border border-gray-100 bg-white p-3">
                      <div className="text-xs font-mont font-semibold text-gray-400 mb-1">NDRE Trend</div>
                      <Sparkline values={analyses.slice(0,6).map(a => getIndex(a,'NDRE')?.mean).filter(v => v != null).reverse()} />
                    </div>
                  </div>
                </div>
              )}

              {/* Agronomy snapshot */}
              {agronomy && (
                <div>
                  <h3 className="font-lora font-bold text-gray-900 text-lg mb-3">Agronomy Snapshot</h3>
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                    <StatCard label="GDD (°C·days)" value={agronomy.gdd ? Math.round(agronomy.gdd.gdd) : 'N/A'} sub={agronomy.gdd ? `Base ${agronomy.gdd.base_temp_c}°C` : 'Add crop + planting date'} />
                    <StatCard label="Growth Stage" value={agronomy.growth_stage?.stage ?? 'N/A'} sub={agronomy.growth_stage?.model} />
                    <StatCard label="Spray Decision" value={agronomy.spray_decision?.decision ?? 'N/A'} sub={agronomy.spray_decision?.reasons?.join(', ')} />
                    <StatCard label="Irrigation" value={agronomy.irrigation_advice?.status ?? 'N/A'} />
                    <StatCard label="Disease Risk" value={agronomy.disease_risk?.risk ?? 'N/A'} />
                    <StatCard label="Confidence" value={agronomy.confidence ?? 'N/A'} sub={agronomy.freshness_days != null ? `${agronomy.freshness_days}d ago` : null} />
                  </div>
                </div>
              )}

              {/* Top recs */}
              {recommendations.length > 0 && (
                <div>
                  <h3 className="font-lora font-bold text-gray-900 text-lg mb-3">Top Recommendations</h3>
                  <div className="space-y-3">
                    {recommendations.slice(0, 3).map((rec, i) => (
                      <div key={i} className="rounded-xl border border-gray-100 bg-white p-4">
                        <div className="flex items-start justify-between mb-1">
                          <div className="font-mont font-semibold text-gray-900 text-sm">{rec.title}</div>
                          <span className={`px-2 py-0.5 rounded text-xs font-semibold ${rec.priority === 'high' ? 'bg-red-100 text-red-700' : rec.priority === 'medium' ? 'bg-yellow-100 text-yellow-700' : 'bg-green-100 text-green-700'}`}>
                            {rec.priority}
                          </span>
                        </div>
                        <p className="text-sm text-gray-600 font-mont">{rec.description}</p>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          )}

          {/* ── ANALYSES ── */}
          {tab === 'analyses' && (
            <div>
              {analyses.length === 0 ? (
                <div className="text-center py-16 rounded-xl bg-gray-50">
                  <div className="text-4xl mb-3">📊</div>
                  <div className="font-lora text-xl text-gray-700">No analyses yet</div>
                </div>
              ) : (
                <div className="space-y-4">
                  {analyses.map((a, i) => {
                    const ndvi = getIndex(a, 'NDVI');
                    const ndre = getIndex(a, 'NDRE');
                    const evi  = getIndex(a, 'EVI');
                    return (
                      <div key={i} className="rounded-xl border border-gray-100 bg-white p-5 flex items-center justify-between gap-4">
                        <div className="flex-1">
                          <div className="font-lora font-bold text-gray-900">
                            {new Date(a.analysis_date).toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' })}
                          </div>
                          {a.cloud_percent != null && <div className="text-xs text-gray-400 font-mont mt-0.5">Cloud {a.cloud_percent.toFixed(1)}%</div>}
                          <div className="flex gap-8 mt-3">
                            {[['NDVI', ndvi], ['NDRE', ndre], ['EVI', evi]].map(([name, idx]) => (
                              <div key={name}>
                                <div className="text-xs font-mont font-semibold text-gray-400">{name}</div>
                                <div className="font-mont font-semibold text-gray-900">{idx ? idx.mean.toFixed(3) : 'N/A'}</div>
                              </div>
                            ))}
                          </div>
                        </div>
                        <HealthDonut score={a.health_score} />
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          )}

          {/* ── WEATHER ── */}
          {tab === 'weather' && (
            <div>
              {!weather?.current ? (
                <div className="text-center py-16 rounded-xl bg-gray-50">
                  <div className="text-4xl mb-3">🌤️</div>
                  <div className="font-lora text-xl text-gray-700">Weather data unavailable</div>
                  <div className="font-mont text-sm text-gray-400 mt-1">Weather endpoint may not be configured yet</div>
                </div>
              ) : (
                <div>
                  <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                    <StatCard label="Temperature" value={`${weather.current.temp_c ?? weather.current.temperature}°C`} bg="#DEECFF" />
                    <StatCard label="Humidity" value={`${weather.current.humidity}%`} bg="#C8F2F4" />
                    <StatCard label="Wind" value={`${weather.current.wind_kph ?? weather.current.wind_speed} km/h`} bg="#D2F0DB" />
                    <StatCard label="Precipitation" value={`${weather.current.precip_mm ?? weather.current.precipitation} mm`} bg="#F4E9FF" />
                  </div>
                  {weather.forecast?.length > 0 && (
                    <div className="space-y-2">
                      <h3 className="font-lora font-bold text-gray-900 text-lg mb-3">14-Day Forecast</h3>
                      {weather.forecast.map((day, i) => (
                        <div key={i} className="flex items-center justify-between rounded-xl border border-gray-100 bg-white px-5 py-3">
                          <span className="font-mont font-semibold text-gray-900 text-sm">
                            {new Date(day.date).toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' })}
                          </span>
                          <span className="font-mont text-sm text-gray-500">{day.day?.condition?.text}</span>
                          <div className="flex gap-4 text-sm font-mont text-gray-600">
                            <span>↑ {day.day?.maxtemp_c}°C</span>
                            <span>↓ {day.day?.mintemp_c}°C</span>
                            <span>🌧 {day.day?.daily_chance_of_rain}%</span>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}
            </div>
          )}

          {/* ── RECOMMENDATIONS ── */}
          {tab === 'recommendations' && (
            <div>
              {recommendations.length === 0 ? (
                <div className="text-center py-16 rounded-xl bg-gray-50">
                  <div className="text-4xl mb-3">💡</div>
                  <div className="font-lora text-xl text-gray-700">No recommendations yet</div>
                  <div className="font-mont text-sm text-gray-400 mt-1">Run an analysis to get AI-powered recommendations</div>
                </div>
              ) : (
                <div className="space-y-4">
                  {recommendations.map((rec, i) => (
                    <div key={i} className="rounded-xl border border-gray-100 bg-white p-5">
                      <div className="flex items-start justify-between mb-2">
                        <div className="font-lora font-bold text-gray-900 text-lg">{rec.title}</div>
                        <div className="flex items-center gap-2">
                          {rec.estimated_savings && <span className="font-mont font-bold text-green-600 text-sm">${rec.estimated_savings} saved</span>}
                          <span className={`px-2 py-0.5 rounded text-xs font-semibold ${rec.priority === 'high' ? 'bg-red-100 text-red-700' : rec.priority === 'medium' ? 'bg-yellow-100 text-yellow-700' : 'bg-green-100 text-green-700'}`}>
                            {rec.priority?.toUpperCase()}
                          </span>
                        </div>
                      </div>
                      <p className="font-mont text-sm text-gray-600">{rec.description}</p>
                      {rec.recommendation_type && <div className="mt-3 text-xs text-gray-400 font-mont">Type: {rec.recommendation_type}</div>}
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}
        </>
      )}
    </div>
  );
}

// ─── Main export ──────────────────────────────────────────────────────────────
export default function PrecisionAgAnalyses() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const FieldID    = searchParams.get('FieldID');
  const PeopleID   = localStorage.getItem('PeopleID');
  const { Business, LoadBusiness } = useAccount();
  const [field, setField] = useState(null);
  const navigate = useNavigate();

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);

  // If FieldID provided, load that field
  useEffect(() => {
    if (!FieldID) return;
    fetch(`${API_URL}/api/fields?business_id=${BusinessID}`)
      .then(r => r.json())
      .then(fields => {
        const found = fields.find(f => String(f.fieldid) === String(FieldID) || String(f.id) === String(FieldID));
        if (found) setField(found);
      })
      .catch(() => {});
  }, [FieldID, BusinessID]);

  if (!Business) return <div className="p-8 text-gray-500 font-mont">Loading…</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="max-w-full mx-auto">
        {field ? (
          <FieldDetail
            field={field}
            businessId={BusinessID}
            onBack={() => navigate(`/precision-ag/fields?BusinessID=${BusinessID}`)}
          />
        ) : (
          <div className="text-center py-24">
            <div className="text-5xl mb-4">🌾</div>
            <div className="font-lora text-2xl text-gray-700 mb-2">Analyses</div>
            <div className="font-mont text-sm text-gray-400">Select a field from the Fields page to view its analysis</div>
            <button
              onClick={() => navigate(`/precision-ag/fields?BusinessID=${BusinessID}`)}
              className="mt-6 px-5 py-2.5 rounded-lg text-white font-mont font-semibold text-sm"
              style={{ background: '#6D8E22' }}
            >
              Go to Fields
            </button>
          </div>
        )}
      </div>
    </AccountLayout>
  );
}