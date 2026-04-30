import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, API_URL } from './precisionAgUtils';
import { useTranslation } from 'react-i18next';

const CONF_STYLE = {
  high:   { color: '#16A34A', labelKey: 'conf_high' },
  medium: { color: '#D97706', labelKey: 'conf_medium' },
  low:    { color: '#9CA3AF', labelKey: 'conf_low' },
};

function ForecastChart({ history, baseline }) {
  if (!history || history.length === 0) return null;
  const rev = [...history].reverse();
  const W = 680, H = 160, PAD = { l: 60, r: 20, t: 12, b: 28 };
  const maxY = Math.max(...rev.map(d => d.forecast_kgha), baseline) * 1.15;
  const cx = i => PAD.l + (i / Math.max(rev.length - 1, 1)) * (W - PAD.l - PAD.r);
  const cy = v => PAD.t + (1 - v / maxY) * (H - PAD.t - PAD.b);
  const path = rev.map((d, i) => `${i === 0 ? 'M' : 'L'}${cx(i)},${cy(d.forecast_kgha)}`).join(' ');
  const yticks = [0, 0.25, 0.5, 0.75, 1].map(f => Math.round(f * maxY / 500) * 500);

  return (
    <svg viewBox={`0 0 ${W} ${H}`} className="w-full" style={{ maxHeight: 180 }}>
      {yticks.map(v => (
        <g key={v}>
          <line x1={PAD.l} y1={cy(v)} x2={W - PAD.r} y2={cy(v)} stroke="#f0f0f0" strokeWidth="1" />
          <text x={PAD.l - 4} y={cy(v) + 4} textAnchor="end" fontSize="9" fill="#9CA3AF">{v.toLocaleString()}</text>
        </g>
      ))}
      {/* baseline */}
      <line x1={PAD.l} y1={cy(baseline)} x2={W - PAD.r} y2={cy(baseline)}
        stroke="#9CA3AF" strokeDasharray="4,3" strokeWidth="1" />
      <text x={W - PAD.r - 2} y={cy(baseline) - 3} textAnchor="end" fontSize="9" fill="#9CA3AF">Baseline</text>
      {/* area + line */}
      <path d={`${path} L${cx(rev.length - 1)},${H - PAD.b} L${cx(0)},${H - PAD.b} Z`}
        fill="#6D8E22" fillOpacity="0.12" />
      <path d={path} fill="none" stroke="#6D8E22" strokeWidth="2.5" />
      {/* dots */}
      {rev.map((d, i) => (
        <circle key={i} cx={cx(i)} cy={cy(d.forecast_kgha)} r="3.5"
          fill="#6D8E22" stroke="white" strokeWidth="1.5" />
      ))}
      {/* x axis */}
      {rev.map((d, i) => i % Math.ceil(rev.length / 6) === 0 ? (
        <text key={i} x={cx(i)} y={H - 6} textAnchor="middle" fontSize="9" fill="#9CA3AF">
          {d.date?.slice(5)}
        </text>
      ) : null)}
    </svg>
  );
}

export default function PrecisionAgYieldForecast() {
  const { t } = useTranslation();
  const pa = k => t(`precision_ag.${k}`);
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
      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/yield-forecast`);
      setData(r.ok ? await r.json() : null);
    } catch { setData(null); }
    setLoading(false);
  }, [selectedFieldId]);

  useEffect(() => { load(); }, [load]);

  const confStyle = data ? (CONF_STYLE[data.confidence] || CONF_STYLE.low) : null;
  const vsBaseline = data?.forecast_kgha != null && data?.baseline_kgha
    ? ((data.forecast_kgha - data.baseline_kgha) / data.baseline_kgha * 100).toFixed(1)
    : null;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle={pa('yield_title')} breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:pa('yield_title') }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div>
          <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">{pa('yield_title')}</h1>
          <p className="font-mont text-sm text-gray-500">{pa('yield_desc')}</p>
        </div>

        {/* Field selector */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-4 flex-wrap items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">{pa('f_field')}</label>
            <select value={selectedFieldId} onChange={e => setSelectedFieldId(e.target.value)}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-52">
              {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
            </select>
          </div>
          {data && (
            <div className="font-mont text-xs text-gray-400 self-end pb-2">
              Crop: {data.crop_type || 'Unknown'} — Baseline: {data.baseline_kgha?.toLocaleString()} kg/ha
            </div>
          )}
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm animate-pulse">{pa('loading')}</div>
        ) : !data ? (
          <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
            <div className="flex justify-center mb-4"><svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"><path d="M12 22V12"/><path d="M17 8c0 2.5-2 4-5 4S7 10.5 7 8c0-3 2.5-5 5-5s5 2 5 5z"/><line x1="12" y1="22" x2="4" y2="22"/><line x1="12" y1="22" x2="20" y2="22"/></svg></div>
            <div className="font-lora text-xl text-gray-600">{pa('no_forecast')}</div>
          </div>
        ) : data.forecast_kgha == null ? (
          <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
            <div className="flex justify-center mb-4"><svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"><path d="M4.9 4.9A10 10 0 1 0 19.1 19.1"/><path d="M16.24 7.76A6 6 0 1 0 7.76 16.24"/><path d="M12 12a2 2 0 1 0 0-4 2 2 0 0 0 0 4z"/><line x1="12" y1="12" x2="21" y2="21"/></svg></div>
            <div className="font-lora text-xl text-gray-600 mb-2">{pa('no_sat_analyses')}</div>
            <div className="font-mont text-sm text-gray-400">{data.message}</div>
          </div>
        ) : (
          <>
            {/* Forecast card */}
            <div className="bg-white rounded-xl border border-gray-200 p-6">
              <div className="flex items-end gap-4 flex-wrap">
                <div>
                  <div className="font-mont text-sm text-gray-400 mb-1">{pa('lbl_forecast_yield')}</div>
                  <div className="font-lora text-5xl font-bold text-gray-900">
                    {data.forecast_kgha?.toLocaleString()}
                    <span className="text-2xl font-normal text-gray-400 ml-2">{pa('unit_kg_ha')}</span>
                  </div>
                </div>
                <div className="mb-1">
                  {vsBaseline !== null && (
                    <span className="font-mont text-sm font-bold px-3 py-1 rounded-full"
                      style={{
                        background: parseFloat(vsBaseline) >= 0 ? '#D1FAE5' : '#FEE2E2',
                        color: parseFloat(vsBaseline) >= 0 ? '#065F46' : '#B91C1C',
                      }}>
                      {parseFloat(vsBaseline) >= 0 ? '+' : ''}{vsBaseline}% {pa('vs_baseline')}
                    </span>
                  )}
                </div>
                <div className="ml-auto text-right">
                  <div className="font-mont text-xs px-3 py-1 rounded-full inline-block"
                    style={{ background: confStyle.color + '18', color: confStyle.color }}>
                    {pa(confStyle.labelKey)}
                  </div>
                  {data.trend_pct !== null && (
                    <div className="font-mont text-xs text-gray-400 mt-1">
                      {pa('lbl_trend')} {data.trend_pct > 0 ? '+' : ''}{data.trend_pct}% since first analysis
                    </div>
                  )}
                </div>
              </div>
            </div>

            {/* Summary cards */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">{pa('lbl_baseline_crop')}</div>
                <div className="font-mont text-xl font-bold text-gray-700">{data.baseline_kgha?.toLocaleString()} {pa('unit_kg_ha')}</div>
              </div>
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">{pa('lbl_analyses_used')}</div>
                <div className="font-mont text-xl font-bold text-gray-700">{data.history?.length}</div>
              </div>
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">{pa('lbl_latest_ndvi')}</div>
                <div className="font-mont text-xl font-bold text-[#6D8E22]">{data.history?.[0]?.ndvi}</div>
              </div>
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">{pa('lbl_trend_label')}</div>
                <div className="font-mont text-xl font-bold"
                  style={{ color: data.trend_pct > 0 ? '#16A34A' : data.trend_pct < 0 ? '#DC2626' : '#9CA3AF' }}>
                  {data.trend_pct !== null ? `${data.trend_pct > 0 ? '+' : ''}${data.trend_pct}%` : '—'}
                </div>
              </div>
            </div>

            {/* Chart */}
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <div className="font-mont text-sm font-semibold text-gray-600 mb-3">{pa('forecast_history_title')}</div>
              <ForecastChart history={data.history} baseline={data.baseline_kgha} />
            </div>

            {/* Table */}
            <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
              <div className="px-5 py-3 border-b border-gray-100 font-mont text-sm font-semibold text-gray-600">
                {pa('analysis_history')}
              </div>
              <div className="overflow-x-auto">
                <table className="w-full text-sm font-mont">
                  <thead>
                    <tr className="bg-gray-50 border-b border-gray-100">
                      {[pa('th_date'), pa('th_ndvi'), pa('th_forecast_kgha'), pa('th_health'), pa('th_vs_baseline')].map(h => (
                        <th key={h} className="px-3 py-2.5 text-xs font-semibold text-gray-500 text-center first:text-left first:px-4">{h}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {(data.history || []).map((d, i) => {
                      const vs = data.baseline_kgha ? ((d.forecast_kgha - data.baseline_kgha) / data.baseline_kgha * 100).toFixed(1) : null;
                      return (
                        <tr key={i} className="border-t border-gray-50 hover:bg-gray-50">
                          <td className="px-4 py-2 text-xs font-semibold text-gray-700">{d.date}</td>
                          <td className="px-3 py-2 text-center text-xs text-[#6D8E22] font-semibold">{d.ndvi}</td>
                          <td className="px-3 py-2 text-center text-xs font-bold text-gray-800">{d.forecast_kgha?.toLocaleString()}</td>
                          <td className="px-3 py-2 text-center text-xs text-gray-500">{d.health_score ?? '—'}%</td>
                          <td className="px-3 py-2 text-center text-xs font-semibold"
                            style={{ color: vs > 0 ? '#16A34A' : vs < 0 ? '#DC2626' : '#9CA3AF' }}>
                            {vs !== null ? `${vs > 0 ? '+' : ''}${vs}%` : '—'}
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </div>

            <div className="bg-gray-50 rounded-xl border border-gray-100 p-4">
              <p className="font-mont text-xs text-gray-400">
                {pa('yield_disclaimer')}
              </p>
            </div>
          </>
        )}
      </div>
    </AccountLayout>
  );
}
