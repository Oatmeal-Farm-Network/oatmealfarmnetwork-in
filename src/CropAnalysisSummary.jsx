import React, { useEffect, useMemo, useState } from 'react';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, Cell,
} from 'recharts';

const API = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const PALETTE = ['#819360', '#3D6B35', '#A3301E', '#7C5CBF', '#E6A23C', '#5C7A9A', '#D4A373', '#6B8E4E'];

// Backend sends the same keys (fields, crops, plantTypes, etc.) even though we
// now label the "fields" filter as "Variety" in the UI — a variety row is a
// specific cultivar of a crop (e.g., Crop=Tomato, Variety=Brandywine).
const FILTER_KEYS = [
  { key: 'crop',         label: 'Crop',           optionsKey: 'crops',        help: 'Pick a single crop (plant species) to focus the dashboard on. Choosing a crop auto-fills Plant Type and narrows the Variety list.' },
  { key: 'field',        label: 'Variety',        optionsKey: 'fields',       help: 'Specific cultivar of the selected crop (e.g., Brandywine for Tomato). Pick a crop first to scope this list.' },
  { key: 'plantType',    label: 'Plant Type',     optionsKey: 'plantTypes',   help: 'High-level plant category — Fruits, Grains, Vegetables, Herbs. Useful on its own for browsing a group; auto-fills (and becomes redundant) once you pick a Crop.' },
  { key: 'soilTexture',  label: 'Soil Texture',   optionsKey: 'soilTextures', help: 'Dominant soil makeup required by the crop — Clay, Loam, Sandy, Silty, etc.' },
  { key: 'zone',         label: 'Hardiness Zone', optionsKey: 'zones',        help: 'USDA plant hardiness zone the crop tolerates (e.g., 5a, 7b).' },
  { key: 'phRange',      label: 'pH Range',       optionsKey: 'phRanges',     help: 'Preferred soil pH band for the crop (e.g., 6.0 – 7.0).' },
];

const EMPTY_FILTERS = {
  field: null, crop: null, plantType: null,
  soilTexture: null, zone: null, phRange: null,
};

function Kpi({ label, value, suffix }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <p className="text-xs text-gray-500 uppercase tracking-wide">{label}</p>
      <p className="text-2xl font-bold text-[#3D6B35] mt-1">
        {value ?? '—'}{value != null && suffix ? <span className="text-sm text-gray-500 font-semibold ml-1">{suffix}</span> : null}
      </p>
    </div>
  );
}

function ChartCard({ title, children }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <p className="text-xs font-semibold text-gray-600 uppercase tracking-wide mb-3">{title}</p>
      <div style={{ width: '100%', height: 260 }}>
        {children}
      </div>
    </div>
  );
}

function Slicer({ label, value, options, onChange, help }) {
  return (
    <div className="bg-[#faf6ef] border border-gray-200 rounded-lg p-3">
      <div className="flex items-center gap-1 mb-1">
        <label className="block text-[11px] font-semibold text-gray-600 uppercase tracking-wide">{label}</label>
        {help && (
          <span className="relative inline-block group">
            <span
              tabIndex={0}
              aria-label={help}
              className="inline-flex items-center justify-center w-4 h-4 rounded-full bg-gray-300 text-white text-[10px] font-bold cursor-help hover:bg-[#819360] focus:outline-none focus:ring-2 focus:ring-[#819360] focus:ring-offset-1"
            >
              ?
            </span>
            <span
              role="tooltip"
              className="pointer-events-none absolute z-50 left-1/2 -translate-x-1/2 bottom-full mb-2 w-56 bg-gray-800 text-white text-[11px] leading-snug font-normal normal-case tracking-normal rounded px-2 py-1.5 shadow-lg opacity-0 group-hover:opacity-100 group-focus-within:opacity-100 transition-opacity"
            >
              {help}
              <span className="absolute top-full left-1/2 -translate-x-1/2 -mt-px border-4 border-transparent border-t-gray-800" />
            </span>
          </span>
        )}
      </div>
      <select
        value={value || ''}
        onChange={e => onChange(e.target.value || null)}
        className="w-full bg-white border border-gray-300 rounded px-2 py-1.5 text-sm text-gray-800"
      >
        <option value="">All</option>
        {options.map(o => <option key={o} value={o}>{o}</option>)}
      </select>
    </div>
  );
}

export default function CropAnalysisSummary() {
  const { BusinessID } = useAccount();
  const [options, setOptions] = useState(null);
  const [cropPlantTypes, setCropPlantTypes] = useState({});
  const [myFields, setMyFields] = useState([]);
  const [selectedMyField, setSelectedMyField] = useState('');
  const [filters, setFilters] = useState(EMPTY_FILTERS);
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Load filter options — refetches with ?crop=X so the Variety list scopes to
  // the chosen crop. cropPlantTypes is a full map captured on first load.
  useEffect(() => {
    const url = filters.crop
      ? `${API}/api/precision-ag/crop-summary/options?crop=${encodeURIComponent(filters.crop)}`
      : `${API}/api/precision-ag/crop-summary/options`;
    fetch(url)
      .then(r => r.ok ? r.json() : Promise.reject(r.statusText))
      .then(o => {
        setOptions(o);
        if (o && o.cropPlantTypes && Object.keys(cropPlantTypes).length === 0) {
          setCropPlantTypes(o.cropPlantTypes);
        }
      })
      .catch(() => setOptions({ fields: [], crops: [], plantTypes: [], soilTextures: [], zones: [], phRanges: [] }));
    // Intentionally omit cropPlantTypes from deps — we only want to capture it once.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [filters.crop]);

  // Load the farmer's own Field records so they can auto-fill site conditions.
  useEffect(() => {
    if (!BusinessID) { setMyFields([]); return; }
    fetch(`${API}/api/precision-ag/crop-summary/my-fields?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : [])
      .then(d => setMyFields(Array.isArray(d) ? d : []))
      .catch(() => setMyFields([]));
  }, [BusinessID]);

  // Reload data whenever filters change
  useEffect(() => {
    const qs = Object.entries(filters)
      .filter(([, v]) => v)
      .map(([k, v]) => `${encodeURIComponent(k)}=${encodeURIComponent(v)}`)
      .join('&');
    const url = `${API}/api/precision-ag/crop-summary${qs ? `?${qs}` : ''}`;
    let cancelled = false;
    setLoading(true);
    setError(null);
    fetch(url)
      .then(r => r.ok ? r.json() : Promise.reject(`HTTP ${r.status}`))
      .then(d => { if (!cancelled) { setData(d); setLoading(false); } })
      .catch(err => { if (!cancelled) { setError(String(err)); setLoading(false); } });
    return () => { cancelled = true; };
  }, [filters]);

  const updateFilter = (key, value) => {
    setFilters(prev => {
      const next = { ...prev, [key]: value };
      // When the user picks a Crop, auto-fill Plant Type and clear the old
      // Variety selection (it likely doesn't belong to the new crop).
      if (key === 'crop') {
        next.plantType = value ? (cropPlantTypes[value] || null) : null;
        next.field = null;
      }
      return next;
    });
  };
  const resetFilters = () => {
    setFilters(EMPTY_FILTERS);
    setSelectedMyField('');
  };

  const applyMyField = (fieldId) => {
    setSelectedMyField(fieldId);
    if (!fieldId) return;
    const f = myFields.find(x => String(x.fieldId) === String(fieldId));
    if (!f) return;
    const sc = f.siteConditions || {};
    setFilters(prev => ({
      ...prev,
      soilTexture: sc.soilTexture || null,
      phRange: sc.phRange || null,
      zone: sc.zone || null,
    }));
  };

  const kpis = data?.kpis || {};
  const hasAnyFilter = useMemo(() => Object.values(filters).some(Boolean), [filters]);
  const missingFromMyField = useMemo(() => {
    if (!selectedMyField) return [];
    const f = myFields.find(x => String(x.fieldId) === String(selectedMyField));
    if (!f) return [];
    const sc = f.siteConditions || {};
    const miss = [];
    if (!sc.soilTexture) miss.push('Soil Texture');
    if (!sc.phRange) miss.push('pH Range');
    if (!sc.zone) miss.push('Hardiness Zone');
    return miss;
  }, [selectedMyField, myFields]);

  return (
    <div className="min-h-screen bg-gray-50 font-sans flex flex-col">
      <PageMeta title="Crop Analysis Summary | Oatmeal Farm Network" noIndex />
      <Header />

      <div className="grow max-w-7xl mx-auto w-full px-4 py-6">
        <Breadcrumbs items={[
          { label: 'Dashboard', to: '/dashboard' },
          { label: 'Precision Ag' },
          { label: 'Visualizations', to: '/precision-ag/visualizations' },
          { label: 'Crop Analysis Summary' },
        ]} />

        <div className="flex items-center justify-between mt-2 mb-2">
          <h1 className="text-2xl font-bold text-gray-800">Crop Analysis Summary</h1>
          {hasAnyFilter && (
            <button
              onClick={resetFilters}
              className="text-sm text-gray-600 hover:text-[#A3301E] underline underline-offset-2"
            >
              Reset filters
            </button>
          )}
        </div>

        <p className="text-sm text-gray-600 max-w-3xl mb-4">
          Use this tool to see whether a specific crop/variety will thrive in one of your fields.
          Pick a crop — Plant Type auto-fills and the Variety list narrows to that crop's cultivars.
          Then pick one of <span className="font-semibold">My Fields</span> to auto-fill soil texture,
          pH, and hardiness zone. The KPIs, charts, nutrient matrix, and summary table update live —
          every filter is combined with <span className="font-semibold">AND</span>, so leave any
          filter on <span className="font-semibold">All</span> to include everything in that
          dimension. Hover the <span className="inline-flex items-center justify-center w-4 h-4 rounded-full bg-gray-300 text-white text-[10px] font-bold align-middle">?</span> icons for details on each filter.
        </p>

        {/* My Field auto-fill */}
        <div className="bg-[#f4efe4] border border-[#d6cfbc] rounded-lg p-3 mb-4">
          <div className="flex flex-col sm:flex-row sm:items-center gap-2">
            <label className="text-[11px] font-semibold text-gray-700 uppercase tracking-wide shrink-0">
              My Field
            </label>
            <select
              value={selectedMyField}
              onChange={e => applyMyField(e.target.value)}
              disabled={!BusinessID || myFields.length === 0}
              className="bg-white border border-gray-300 rounded px-2 py-1.5 text-sm text-gray-800 sm:w-80 disabled:bg-gray-100 disabled:text-gray-400"
            >
              <option value="">
                {!BusinessID
                  ? 'Sign in to use your fields'
                  : myFields.length === 0
                    ? 'No fields on file — add one in Field Management'
                    : 'Select one of your fields to auto-fill site conditions'}
              </option>
              {myFields.map(f => (
                <option key={f.fieldId} value={f.fieldId}>
                  {f.name}{f.address ? ` — ${f.address}` : ''}
                </option>
              ))}
            </select>
            {selectedMyField && missingFromMyField.length > 0 && (
              <span className="text-[11px] text-[#A3301E]">
                Missing on this field: {missingFromMyField.join(', ')}. Add it in Field Management to auto-fill.
              </span>
            )}
          </div>
        </div>

        {error && (
          <div className="mb-4 bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm">
            Could not load dashboard: {error}
          </div>
        )}

        {/* Slicers */}
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-3 mb-5">
          {FILTER_KEYS.map(f => (
            <Slicer
              key={f.key}
              label={f.label}
              help={f.help}
              value={filters[f.key]}
              options={options?.[f.optionsKey] || []}
              onChange={v => updateFilter(f.key, v)}
            />
          ))}
        </div>

        {/* KPIs */}
        <div className="grid grid-cols-2 md:grid-cols-5 gap-3 mb-5">
          <Kpi label="Total Crops"         value={kpis.totalCrops} />
          <Kpi label="Total Field Options" value={kpis.totalFieldOptions} />
          <Kpi label="Avg Water Min"       value={kpis.avgWaterMin} suffix="in/wk" />
          <Kpi label="Avg Water Max"       value={kpis.avgWaterMax} suffix="in/wk" />
          <Kpi label="Unique Nutrients"    value={kpis.uniqueNutrients} />
        </div>

        {/* Current Selection + Water Range cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-3 mb-5">
          <div className="bg-white border border-gray-200 rounded-xl p-4">
            <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Current Selection</p>
            <p className="text-sm font-semibold text-gray-800">{data?.currentSelection || '—'}</p>
          </div>
          <div className="bg-white border border-gray-200 rounded-xl p-4">
            <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Water Requirement Range</p>
            <p className="text-sm font-semibold text-[#3D6B35]">{data?.waterRange || '—'}</p>
          </div>
        </div>

        {/* Charts */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-3 mb-5">
          <ChartCard title="Fields by Plant Type">
            <ResponsiveContainer>
              <BarChart data={data?.fieldsByPlantType || []} layout="vertical" margin={{ left: 10, right: 10 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis type="number" tick={{ fontSize: 11 }} />
                <YAxis type="category" dataKey="name" width={90} tick={{ fontSize: 11 }} />
                <Tooltip />
                <Bar dataKey="value">
                  {(data?.fieldsByPlantType || []).map((_, i) => (
                    <Cell key={i} fill={PALETTE[i % PALETTE.length]} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </ChartCard>

          <ChartCard title="Fields by Soil Texture">
            <ResponsiveContainer>
              <BarChart data={data?.fieldsBySoilTexture || []}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="name" tick={{ fontSize: 11 }} interval={0} angle={-30} textAnchor="end" height={70} />
                <YAxis tick={{ fontSize: 11 }} />
                <Tooltip />
                <Bar dataKey="value">
                  {(data?.fieldsBySoilTexture || []).map((_, i) => (
                    <Cell key={i} fill={PALETTE[i % PALETTE.length]} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </ChartCard>

          <ChartCard title="Fields by Salinity Classification">
            <ResponsiveContainer>
              <BarChart data={data?.fieldsBySalinity || []}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="name" tick={{ fontSize: 11 }} interval={0} angle={-30} textAnchor="end" height={70} />
                <YAxis tick={{ fontSize: 11 }} />
                <Tooltip />
                <Bar dataKey="value">
                  {(data?.fieldsBySalinity || []).map((_, i) => (
                    <Cell key={i} fill={PALETTE[i % PALETTE.length]} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </ChartCard>

          <ChartCard title="Fields by Humidity Classification">
            <ResponsiveContainer>
              <BarChart data={data?.fieldsByHumidity || []}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="name" tick={{ fontSize: 11 }} interval={0} angle={-30} textAnchor="end" height={70} />
                <YAxis tick={{ fontSize: 11 }} />
                <Tooltip />
                <Bar dataKey="value">
                  {(data?.fieldsByHumidity || []).map((_, i) => (
                    <Cell key={i} fill={PALETTE[i % PALETTE.length]} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </ChartCard>
        </div>

        {/* Pivot + Detail */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-3 mb-6">
          {/* Field × Nutrient matrix */}
          <div className="bg-white border border-gray-200 rounded-xl p-4 overflow-hidden">
            <p className="text-xs font-semibold text-gray-600 uppercase tracking-wide mb-3">Variety × Nutrient Matrix</p>
            <div className="overflow-auto max-h-80">
              <table className="min-w-full text-xs border-collapse">
                <thead className="sticky top-0 bg-gray-50">
                  <tr>
                    <th className="text-left p-2 border-b border-gray-200 font-semibold text-gray-600">Variety</th>
                    {(data?.nutrientMatrix?.nutrients || []).map(n => (
                      <th key={n} className="text-center p-2 border-b border-gray-200 font-semibold text-gray-600 whitespace-nowrap">{n}</th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {(data?.nutrientMatrix?.rows || []).map(row => (
                    <tr key={row.field} className="border-b border-gray-100">
                      <td className="p-2 font-medium text-gray-800 whitespace-nowrap">{row.field}</td>
                      {(data?.nutrientMatrix?.nutrients || []).map(n => (
                        <td key={n} className="text-center p-2">
                          {row.has[n] ? <span className="inline-block w-2 h-2 rounded-full bg-[#819360]"></span> : <span className="text-gray-300">·</span>}
                        </td>
                      ))}
                    </tr>
                  ))}
                  {(data?.nutrientMatrix?.rows || []).length === 0 && !loading && (
                    <tr><td colSpan={999} className="text-center py-6 text-gray-400 text-sm">No data</td></tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>

          {/* Detail table */}
          <div className="bg-white border border-gray-200 rounded-xl p-4 overflow-hidden">
            <p className="text-xs font-semibold text-gray-600 uppercase tracking-wide mb-3">Selected Crop Summary</p>
            <div className="overflow-auto max-h-80">
              <table className="min-w-full text-xs border-collapse">
                <thead className="sticky top-0 bg-gray-50">
                  <tr>
                    {['Crop', 'Variety', 'Type', 'Soil', 'pH', 'Zone', 'Salinity', 'Humidity', 'OM', 'W min', 'W max']
                      .map(h => <th key={h} className="text-left p-2 border-b border-gray-200 font-semibold text-gray-600 whitespace-nowrap">{h}</th>)}
                  </tr>
                </thead>
                <tbody>
                  {(data?.cropSummary || []).map((r, i) => (
                    <tr key={i} className="border-b border-gray-100">
                      <td className="p-2 text-gray-800 whitespace-nowrap">{r.PlantName}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.PlantVarietyName}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.PlantType}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.SoilTexture}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.PHRange}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.Zone}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.SalinityClassification}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.HumidityClassification}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.OrganicMatterContent}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.WaterRequirementMin ?? '—'}</td>
                      <td className="p-2 text-gray-700 whitespace-nowrap">{r.WaterRequirementMax ?? '—'}</td>
                    </tr>
                  ))}
                  {(data?.cropSummary || []).length === 0 && !loading && (
                    <tr><td colSpan={11} className="text-center py-6 text-gray-400 text-sm">No data</td></tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>

        {loading && (
          <div className="text-center py-3 text-gray-400 text-sm">Loading…</div>
        )}
      </div>

      <Footer />
    </div>
  );
}
