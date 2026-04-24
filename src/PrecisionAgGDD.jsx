import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, API_URL } from './precisionAgUtils';

const CROP_BASES = {
  wheat: 40, barley: 40, oats: 40,
  corn: 50, maize: 50, soy: 50, soybean: 50, rice: 50,
  canola: 41, cotton: 60,
};

// GDD milestones per crop (rough averages)
const MILESTONES = {
  corn:    [{ gdd: 100, label: 'Emergence' }, { gdd: 350, label: 'V6' }, { gdd: 860, label: 'Silking' }, { gdd: 1400, label: 'Dough' }, { gdd: 2700, label: 'Maturity' }],
  wheat:   [{ gdd: 150, label: 'Tillering' }, { gdd: 400, label: 'Jointing' }, { gdd: 700, label: 'Heading' }, { gdd: 1000, label: 'Soft dough' }, { gdd: 1400, label: 'Maturity' }],
  soybean: [{ gdd: 150, label: 'Emergence' }, { gdd: 500, label: 'Flowering' }, { gdd: 900, label: 'Pod fill' }, { gdd: 1500, label: 'Maturity' }],
  default: [{ gdd: 200, label: 'Emergence' }, { gdd: 600, label: 'Vegetative' }, { gdd: 1200, label: 'Reproductive' }, { gdd: 2000, label: 'Maturity' }],
};

function GDDChart({ daily, totalGDD, milestones }) {
  if (!daily || daily.length === 0) return null;
  const W = 680, H = 160, PAD = { l: 45, r: 20, t: 12, b: 28 };
  const maxCum = Math.max(...daily.map(d => d.cumulative), 1);
  const cx = i => PAD.l + (i / (daily.length - 1)) * (W - PAD.l - PAD.r);
  const cy = v => PAD.t + (1 - v / maxCum) * (H - PAD.t - PAD.b);
  const path = daily.map((d, i) => `${i === 0 ? 'M' : 'L'}${cx(i)},${cy(d.cumulative)}`).join(' ');
  // Y axis
  const yticks = [0, 0.25, 0.5, 0.75, 1.0].map(f => Math.round(f * maxCum));

  return (
    <svg viewBox={`0 0 ${W} ${H}`} className="w-full" style={{ maxHeight: 180 }}>
      {/* grid */}
      {yticks.map(v => (
        <g key={v}>
          <line x1={PAD.l} y1={cy(v)} x2={W - PAD.r} y2={cy(v)} stroke="#f0f0f0" strokeWidth="1" />
          <text x={PAD.l - 4} y={cy(v) + 4} textAnchor="end" fontSize="9" fill="#9CA3AF">{v}</text>
        </g>
      ))}
      {/* milestone lines */}
      {milestones.map(m => {
        if (m.gdd > maxCum) return null;
        const x = PAD.l + (m.gdd / maxCum) * (W - PAD.l - PAD.r);
        return (
          <g key={m.label}>
            <line x1={x} y1={PAD.t} x2={x} y2={H - PAD.b} stroke="#6D8E22" strokeDasharray="3,3" strokeWidth="1" />
            <text x={x + 3} y={PAD.t + 10} fontSize="8" fill="#6D8E22">{m.label}</text>
          </g>
        );
      })}
      {/* cumulative GDD area */}
      <path d={`${path} L${cx(daily.length - 1)},${H - PAD.b} L${cx(0)},${H - PAD.b} Z`}
        fill="#6D8E22" fillOpacity="0.12" />
      <path d={path} fill="none" stroke="#6D8E22" strokeWidth="2" />
      {/* x axis */}
      {[0, Math.floor(daily.length / 2), daily.length - 1].map(i => (
        <text key={i} x={cx(i)} y={H - 6} textAnchor="middle" fontSize="9" fill="#9CA3AF">
          {daily[i]?.date?.slice(5)}
        </text>
      ))}
    </svg>
  );
}

export default function PrecisionAgGDD() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const [selectedField, setSelectedField] = useState(null);
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [days, setDays] = useState(180);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId) {
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
      setSelectedField(fields[0]);
    }
  }, [fields]);

  const load = useCallback(async () => {
    if (!selectedFieldId) return;
    setLoading(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/gdd?days=${days}`);
      setData(r.ok ? await r.json() : null);
    } catch { setData(null); }
    setLoading(false);
  }, [selectedFieldId, days]);

  useEffect(() => { load(); }, [load]);

  const cropKey = (data?.crop_type || '').toLowerCase().split(' ')[0];
  const milestones = MILESTONES[cropKey] || MILESTONES.default;

  // Find next milestone
  const nextMilestone = data
    ? milestones.find(m => m.gdd > (data.total_gdd || 0))
    : null;
  const prevMilestone = data
    ? [...milestones].reverse().find(m => m.gdd <= (data.total_gdd || 0))
    : null;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="GDD" breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Growing Degree Days' }]}>
      <div className="max-w-full mx-auto space-y-5">
        <div>
          <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Growing Degree Days</h1>
          <p className="font-mont text-sm text-gray-500">Heat unit accumulation to track crop development stages.</p>
        </div>

        {/* Controls */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-4 flex-wrap items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Field</label>
            <select value={selectedFieldId}
              onChange={e => { setSelectedFieldId(e.target.value); setSelectedField(fields.find(f => String(f.fieldid||f.id) === e.target.value)); }}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-52">
              {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
            </select>
          </div>
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Period</label>
            <select value={days} onChange={e => setDays(Number(e.target.value))}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2">
              <option value={90}>90 days</option>
              <option value={180}>180 days</option>
              <option value={270}>270 days</option>
              <option value={365}>365 days</option>
            </select>
          </div>
          {data && (
            <div className="font-mont text-xs text-gray-400 self-end pb-2">
              Base temp: {data.base_temp_f}°F — Crop: {data.crop_type || 'Unknown'}
            </div>
          )}
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm animate-pulse">Loading…</div>
        ) : !data ? (
          <div className="text-center py-24 bg-white rounded-xl border border-gray-200">
            <div className="text-5xl mb-4">🌡️</div>
            <div className="font-lora text-xl text-gray-600">No data available</div>
            <div className="font-mont text-sm text-gray-400 mt-1">Ensure the field has coordinates set.</div>
          </div>
        ) : (
          <>
            {/* Summary cards */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">Total GDD</div>
                <div className="font-mont text-2xl font-bold text-[#6D8E22]">{data.total_gdd?.toLocaleString()}</div>
              </div>
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">Current Stage</div>
                <div className="font-mont text-lg font-bold text-gray-800">{prevMilestone?.label || 'Pre-emergence'}</div>
              </div>
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">Next Stage</div>
                <div className="font-mont text-lg font-bold text-gray-800">{nextMilestone?.label || '—'}</div>
                {nextMilestone && (
                  <div className="font-mont text-xs text-gray-400">{(nextMilestone.gdd - data.total_gdd).toFixed(0)} GDD remaining</div>
                )}
              </div>
              <div className="bg-gray-50 rounded-xl border border-gray-100 px-4 py-3">
                <div className="font-mont text-xs text-gray-400">Avg GDD/day</div>
                <div className="font-mont text-2xl font-bold text-gray-800">
                  {data.daily?.length ? (data.total_gdd / data.daily.length).toFixed(1) : '—'}
                </div>
              </div>
            </div>

            {/* Milestones progress */}
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <div className="font-mont text-sm font-semibold text-gray-600 mb-4">Development Milestones</div>
              <div className="relative">
                <div className="absolute left-0 right-0 top-4 h-1 bg-gray-100 rounded-full" />
                <div className="absolute left-0 top-4 h-1 bg-[#6D8E22] rounded-full transition-all"
                  style={{ width: `${Math.min(100, data.total_gdd / (milestones[milestones.length - 1]?.gdd || 1) * 100)}%` }} />
                <div className="relative flex justify-between">
                  {milestones.map(m => {
                    const reached = data.total_gdd >= m.gdd;
                    return (
                      <div key={m.label} className="flex flex-col items-center gap-1">
                        <div className={`w-3 h-3 rounded-full border-2 ${reached ? 'bg-[#6D8E22] border-[#6D8E22]' : 'bg-white border-gray-300'}`} />
                        <span className={`font-mont text-xs mt-1 ${reached ? 'text-[#6D8E22] font-semibold' : 'text-gray-400'}`}>{m.label}</span>
                        <span className="font-mont text-xs text-gray-300">{m.gdd}</span>
                      </div>
                    );
                  })}
                </div>
              </div>
            </div>

            {/* Chart */}
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <div className="font-mont text-sm font-semibold text-gray-600 mb-3">Cumulative GDD — {days}-day period</div>
              <GDDChart daily={data.daily} totalGDD={data.total_gdd} milestones={milestones} />
            </div>

            {/* Daily table (last 14) */}
            <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
              <div className="px-5 py-3 border-b border-gray-100 font-mont text-sm font-semibold text-gray-600">
                Recent Daily GDD
              </div>
              <div className="overflow-x-auto">
                <table className="w-full text-sm font-mont">
                  <thead>
                    <tr className="bg-gray-50 border-b border-gray-100">
                      <th className="text-left px-4 py-2 text-xs font-semibold text-gray-500">Date</th>
                      <th className="text-center px-3 py-2 text-xs font-semibold text-gray-500">Daily GDD</th>
                      <th className="text-center px-3 py-2 text-xs font-semibold text-gray-500">Cumulative</th>
                    </tr>
                  </thead>
                  <tbody>
                    {[...(data.daily || [])].reverse().slice(0, 14).map((d, i) => (
                      <tr key={i} className="border-t border-gray-50 hover:bg-gray-50">
                        <td className="px-4 py-2 text-xs font-semibold text-gray-700">{d.date}</td>
                        <td className="px-3 py-2 text-center text-xs text-gray-600">{d.gdd}</td>
                        <td className="px-3 py-2 text-center text-xs font-semibold text-[#6D8E22]">{d.cumulative}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </>
        )}
      </div>
    </AccountLayout>
  );
}
