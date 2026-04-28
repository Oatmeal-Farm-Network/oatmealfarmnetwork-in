import React, { useEffect, useState } from 'react';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const SEVERITY_STYLE = {
  critical: { bg: '#FFE4E6', border: '#FB7185', text: '#9F1239', dot: '#E11D48', label: 'Critical' },
  severe:   { bg: '#FFEDD5', border: '#FB923C', text: '#9A3412', dot: '#F97316', label: 'Severe'  },
  warn:     { bg: '#FEF3C7', border: '#FBBF24', text: '#92400E', dot: '#F59E0B', label: 'Warning' },
};

const KI = ({ children }) => (
  <svg width="18" height="18" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" className="shrink-0">
    {children}
  </svg>
);

const KIND_LABEL = {
  heatwave:   { label: 'Heatwave',                  icon: <KI><path d="M8 1v2M8 13v2M3.5 3.5l1.4 1.4M11.1 11.1l1.4 1.4M1 8h2M13 8h2M3.5 12.5l1.4-1.4M11.1 4.9l1.4-1.4"/><circle cx="8" cy="8" r="3"/></KI> },
  frost:      { label: 'Frost / Hard Freeze',        icon: <KI><line x1="8" y1="1" x2="8" y2="15"/><line x1="1" y1="8" x2="15" y2="8"/><line x1="3.5" y1="3.5" x2="12.5" y2="12.5"/><line x1="12.5" y1="3.5" x2="3.5" y2="12.5"/></KI> },
  cold_snap:  { label: 'Cold Snap',                  icon: <KI><path d="M8 2v12M5 5l3-3 3 3M5 11l3 3 3-3M2 8l3-3-3 3M14 8l-3-3 3 3"/></KI> },
  high_vpd:   { label: 'High VPD / Drought Stress',  icon: <KI><path d="M8 14V8"/><path d="M5 10c0-3 3-5 3-8 0 3 3 5 3 8a3 3 0 0 1-6 0z"/><line x1="4" y1="6" x2="12" y2="6" strokeDasharray="1.5 1.5"/></KI> },
  heavy_rain: { label: 'Heavy Rain',                 icon: <KI><path d="M3 9a5 5 0 0 1 10 0 3 3 0 0 1 0 6H3a3 3 0 0 1 0-6z"/><line x1="5" y1="13" x2="4" y2="15"/><line x1="8" y1="13" x2="7" y2="15"/><line x1="11" y1="13" x2="10" y2="15"/></KI> },
  high_wind:  { label: 'High Wind',                  icon: <KI><path d="M2 8h9a2 2 0 1 0-2-2"/><path d="M2 11h6a2 2 0 1 1-2 2"/><path d="M2 5h5a2 2 0 1 0-2-2"/></KI> },
};

const WarnIcon = () => (
  <KI><path d="M8 2L1 14h14z"/><line x1="8" y1="7" x2="8" y2="10"/><circle cx="8" cy="12.5" r="0.6" fill="currentColor" stroke="none"/></KI>
);

function fmtRelative(hours) {
  if (hours == null) return '—';
  if (hours < 1)   return 'now';
  if (hours < 24)  return `in ${hours}h`;
  const days = Math.floor(hours / 24);
  const rem  = hours % 24;
  return rem === 0 ? `in ${days}d` : `in ${days}d ${rem}h`;
}

function fmtClock(iso) {
  if (!iso) return '—';
  try {
    const d = new Date(iso);
    return d.toLocaleString(undefined, { weekday: 'short', month: 'short', day: 'numeric', hour: 'numeric' });
  } catch {
    return iso;
  }
}

function MiniSpark({ rows, valueKey, lo, hi, color }) {
  if (!rows || rows.length === 0) return null;
  const vals = rows.map(r => r?.[valueKey]).filter(v => v != null);
  if (vals.length === 0) return null;
  const min = lo != null ? lo : Math.min(...vals);
  const max = hi != null ? hi : Math.max(...vals);
  const range = max - min || 1;
  const w = 220, h = 36;
  const step = w / Math.max(rows.length - 1, 1);
  const path = rows.map((r, i) => {
    const v = r?.[valueKey];
    if (v == null) return '';
    const x = i * step;
    const y = h - ((v - min) / range) * h;
    return `${i === 0 ? 'M' : 'L'} ${x.toFixed(1)} ${y.toFixed(1)}`;
  }).filter(Boolean).join(' ');
  return (
    <svg width={w} height={h} className="overflow-visible">
      <path d={path} fill="none" stroke={color} strokeWidth="1.5" strokeLinejoin="round" />
    </svg>
  );
}

function StressEventCard({ ev }) {
  const style = SEVERITY_STYLE[ev.severity] || SEVERITY_STYLE.warn;
  const kind  = KIND_LABEL[ev.kind] || { label: ev.kind, icon: <WarnIcon /> };
  return (
    <div className="rounded-lg border p-4" style={{ background: style.bg, borderColor: style.border }}>
      <div className="flex items-start justify-between gap-3 flex-wrap">
        <div className="flex items-center gap-2">
          <span style={{ color: style.text }}>{kind.icon}</span>
          <div>
            <div className="font-mont font-bold text-sm" style={{ color: style.text }}>
              {kind.label}
            </div>
            <div className="text-xs" style={{ color: style.text, opacity: 0.85 }}>
              Onset {fmtRelative(ev.onset_hours_out)} ({fmtClock(ev.onset)}) · {ev.duration_hours}h · peak {ev.peak_value} {ev.units}
            </div>
          </div>
        </div>
        <span
          className="text-[10px] uppercase tracking-wide font-bold px-2 py-0.5 rounded-full"
          style={{ background: style.dot, color: '#fff' }}
        >
          {style.label}
        </span>
      </div>
      <p className="mt-3 text-sm" style={{ color: style.text }}>{ev.reason}</p>
      {ev.recommended_actions?.length > 0 && (
        <ul className="mt-3 space-y-1">
          {ev.recommended_actions.map((a, i) => (
            <li key={i} className="text-sm flex items-start gap-2" style={{ color: style.text }}>
              <span className="mt-0.5">→</span>
              <span>{a}</span>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default function ClimateForecastPanel({ fieldId }) {
  const [data, setData]     = useState(null);
  const [loading, setLoad]  = useState(true);
  const [error, setError]   = useState(null);
  const [hours, setHours]   = useState(72);

  useEffect(() => {
    if (!fieldId) return;
    setLoad(true);
    setError(null);
    fetch(`${API_URL}/api/fields/${fieldId}/climate-forecast?hours=${hours}`)
      .then(r => r.ok ? r.json() : r.json().then(j => Promise.reject(new Error(j.detail || `HTTP ${r.status}`))))
      .then(setData)
      .catch(e => setError(e.message))
      .finally(() => setLoad(false));
  }, [fieldId, hours]);

  if (loading && !data) return <div className="p-6 text-gray-500">Loading forecast…</div>;
  if (error)            return <div className="p-6 text-red-600">Could not load climate forecast: {error}</div>;
  if (!data)            return null;

  const { summary = {}, events = [], hourly = [], crop_profile = {}, source } = data;
  const next72 = hourly.filter(r => r.hours_out < 72);

  return (
    <div className="space-y-6 pb-12">
      {/* Hero */}
      <div className="bg-white border border-gray-200 rounded-lg p-6">
        <div className="flex items-start justify-between flex-wrap gap-3">
          <div>
            <h3 className="font-lora text-xl font-bold text-gray-900">Predictive Climate Stress</h3>
            <p className="text-sm text-gray-500 font-mont mt-1">
              {data.field_name} · {data.crop_type || 'Unknown crop'} · next {data.horizon_hours}h
            </p>
          </div>
          <div className="flex gap-1 text-xs">
            {[24, 72, 168].map(h => (
              <button
                key={h}
                onClick={() => setHours(h)}
                className={`px-3 py-1 rounded font-mont font-semibold transition-all ${
                  hours === h ? 'bg-[#3D6B34] text-white' : 'border border-gray-300 text-gray-600 hover:bg-gray-50'
                }`}
              >
                {h === 168 ? '7d' : `${h}h`}
              </button>
            ))}
          </div>
        </div>

        <div className="mt-5 grid grid-cols-2 md:grid-cols-5 gap-4">
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">High</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">{summary.max_temp_f ?? '—'}°F</div>
            <MiniSpark rows={next72} valueKey="temp_f" color="#EF4444" />
          </div>
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">Low</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">{summary.min_temp_f ?? '—'}°F</div>
            <MiniSpark rows={next72} valueKey="temp_f" color="#3B82F6" />
          </div>
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">Peak VPD</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">{summary.max_vpd_kpa ?? '—'}</div>
            <div className="text-[10px] text-gray-400">kPa · drought-stress proxy</div>
          </div>
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">Peak Wind</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">{summary.max_wind_mph ?? '—'}</div>
            <div className="text-[10px] text-gray-400">mph</div>
          </div>
          <div>
            <div className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold">Total Rain</div>
            <div className="text-2xl font-lora font-bold text-gray-900 mt-1">{summary.total_precip_in ?? '—'}″</div>
            <div className="text-[10px] text-gray-400">over horizon</div>
          </div>
        </div>

        <p className="mt-4 text-xs text-gray-400 italic">
          Source: {source}. Tunnel-typical: {crop_profile.tunnel_typical ? 'yes' : 'no'} ·
          Heat-sensitive: {crop_profile.heat_sensitive ? 'yes' : 'no'} ·
          Frost-sensitive: {crop_profile.frost_sensitive ? 'yes' : 'no'} ·
          Rain-split risk: {crop_profile.rain_split_risk ? 'yes' : 'no'}
        </p>
      </div>

      {/* Events */}
      <div>
        <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide mb-3">
          {events.length > 0 ? `${events.length} stress event${events.length > 1 ? 's' : ''} predicted` : 'No stress events predicted'}
        </h4>
        {events.length === 0 ? (
          <div className="bg-white border border-green-200 rounded-lg p-5 text-sm text-green-800">
            ✓ No heatwave, frost, high-VPD, saturating rain, or damaging-wind events detected in the next {data.horizon_hours} hours. Continue routine operations.
          </div>
        ) : (
          <div className="space-y-3">
            {events.map((ev, i) => <StressEventCard key={i} ev={ev} />)}
          </div>
        )}
      </div>

      {/* Hourly strip — first 72 hours, condensed */}
      {next72.length > 0 && (
        <div className="bg-white border border-gray-200 rounded-lg p-5">
          <h4 className="font-mont text-sm font-bold text-gray-700 uppercase tracking-wide mb-3">Hourly outlook (next 72h)</h4>
          <div className="overflow-x-auto">
            <table className="w-full text-xs">
              <thead className="text-left text-gray-500">
                <tr>
                  <th className="py-2 pr-3">When</th>
                  <th className="py-2 pr-3">Temp</th>
                  <th className="py-2 pr-3">RH</th>
                  <th className="py-2 pr-3">VPD</th>
                  <th className="py-2 pr-3">Wind</th>
                  <th className="py-2 pr-3">Rain</th>
                </tr>
              </thead>
              <tbody>
                {next72.filter((_, i) => i % 3 === 0).map((r, i) => (
                  <tr key={i} className="border-t border-gray-100">
                    <td className="py-1.5 pr-3 text-gray-600">{fmtClock(r.time)}</td>
                    <td className="py-1.5 pr-3 font-medium">{r.temp_f != null ? `${r.temp_f.toFixed(0)}°F` : '—'}</td>
                    <td className="py-1.5 pr-3">{r.rh_pct != null ? `${r.rh_pct.toFixed(0)}%` : '—'}</td>
                    <td className="py-1.5 pr-3">{r.vpd_kpa != null ? r.vpd_kpa.toFixed(2) : '—'}</td>
                    <td className="py-1.5 pr-3">{r.wind_mph != null ? `${r.wind_mph.toFixed(0)} mph` : '—'}</td>
                    <td className="py-1.5 pr-3">{r.precip_in != null ? `${r.precip_in.toFixed(2)}″` : '—'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <div className="mt-2 text-[11px] text-gray-400 italic">
            Showing every 3rd hour for compactness. Full 168-hour series powers the event detection.
          </div>
        </div>
      )}
    </div>
  );
}
