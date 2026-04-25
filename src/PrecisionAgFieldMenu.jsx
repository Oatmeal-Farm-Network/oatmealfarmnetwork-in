import React, { useEffect, useState } from 'react';
import { Link, useLocation, useSearchParams } from 'react-router-dom';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export const FIELD_MENU_WIDTH_EXPANDED = 208;  // w-52
export const FIELD_MENU_WIDTH_COLLAPSED = 56;  // w-14

// Path templates for the second blade. `tab` is optional — when present we
// match it against ?tab=<value> on /precision-ag/analyses so the Analyses
// sub-tabs (Histograms, Maps, etc.) highlight correctly.
const SECTIONS = [
  {
    label: 'Overview',
    items: [
      { icon: '🌾', label: 'Field Detail',   path: '/precision-ag/analyses' },
      { icon: '📊', label: 'Crop Status',    path: '/precision-ag/analysis/crop-status' },
      { icon: '🛰️', label: 'Crop Detection', path: '/precision-ag/crop-detection' },
      { icon: '🍇', label: 'Maturity',       path: '/precision-ag/analyses', tab: 'maturity' },
    ],
  },
  {
    label: 'Insights',
    items: [
      { icon: '📝', label: 'Assessment Report',  path: '/precision-ag/assessment-report' },
      { icon: '🌪️', label: 'Climate Forecast',    path: '/precision-ag/analyses', tab: 'climate' },
      { icon: '🌡️', label: 'Growing Degree Days', path: '/precision-ag/gdd' },
      { icon: '📦', label: 'Yield Forecast',      path: '/precision-ag/yield-forecast' },
      { icon: '🌍', label: 'Carbon',              path: '/precision-ag/carbon' },
      { icon: '📐', label: 'Benchmark',           path: '/precision-ag/benchmark' },
      { icon: '🚨', label: 'Alerts',              path: '/precision-ag/alerts' },
      { icon: '📄', label: 'Reports',             path: '/precision-ag/reports' },
      { icon: '🛰️', label: 'Agronomy AI',         path: '/precision-ag/agronomy' },
    ],
  },
  {
    label: 'Analysis',
    items: [
      { icon: '📈', label: 'Histograms',     path: '/precision-ag/analyses', tab: 'histograms' },
      { icon: '🗺️', label: 'Maps',           path: '/precision-ag/analysis/maps' },
      { icon: '🧩', label: 'Zoning',         path: '/precision-ag/analysis/zoning' },
      { icon: '🪟', label: 'Multi-layer',    path: '/precision-ag/analysis/multi-layer' },
      { icon: '🖼️', label: 'Visualizations', path: '/precision-ag/visualizations' },
    ],
  },
  {
    label: 'Field Ops',
    items: [
      { icon: '📓', label: 'Field Journal',     path: '/precision-ag/field-journal' },
      { icon: '🌱', label: 'Crop Rotation',     path: '/precision-ag/crop-rotation' },
      { icon: '💊', label: 'Prescriptions',     path: '/precision-ag/prescriptions' },
      { icon: '🧪', label: 'Soil Samples',      path: '/precision-ag/soil-samples' },
      { icon: '💧', label: 'Irrigation',        path: '/precision-ag/irrigation' },
      { icon: '🌊', label: 'Water Use',         path: '/precision-ag/water-use' },
      { icon: '📅', label: 'Activity Log',      path: '/precision-ag/activity-log' },
    ],
  },
];

function buildUrl(path, businessId, fieldId, tab) {
  const params = new URLSearchParams();
  if (businessId) params.set('BusinessID', businessId);
  if (fieldId)    params.set('FieldID', fieldId);
  if (tab)        params.set('tab', tab);
  const qs = params.toString();
  return qs ? `${path}?${qs}` : path;
}

function Row({ to, icon, label, expanded, active }) {
  const cls = `flex items-center gap-3 px-3 py-2 rounded-lg transition-all no-underline ${
    active
      ? 'bg-[#3D6B34] text-white font-semibold'
      : 'text-gray-700 hover:bg-white/50'
  }`;
  const style = active ? { color: '#fff' } : undefined;
  return (
    <Link to={to} className={cls} style={style} title={!expanded ? label : undefined}>
      <span className="w-5 text-center shrink-0 text-base leading-none">{icon}</span>
      {expanded && <span className="text-sm whitespace-nowrap truncate">{label}</span>}
    </Link>
  );
}

export default function PrecisionAgFieldMenu({ menuExpanded, setMenuExpanded }) {
  const { Expanded: accountExpanded, BusinessID: ctxBusinessID } = useAccount() || {};
  const loc = useLocation();
  const [searchParams] = useSearchParams();
  const fieldId    = searchParams.get('FieldID');
  const businessId = searchParams.get('BusinessID') || ctxBusinessID;
  const [field, setField] = useState(null);

  useEffect(() => {
    if (!fieldId || !businessId) { setField(null); return; }
    let alive = true;
    fetch(`${API}/api/fields?business_id=${businessId}`)
      .then(r => r.ok ? r.json() : [])
      .then(rows => {
        if (!alive) return;
        const list = Array.isArray(rows) ? rows : [];
        const match = list.find(f => String(f.fieldid ?? f.id) === String(fieldId));
        setField(match || null);
      })
      .catch(() => { if (alive) setField(null); });
    return () => { alive = false; };
  }, [fieldId, businessId]);

  const leftOffset = accountExpanded ? 208 : 64;
  const width = menuExpanded ? FIELD_MENU_WIDTH_EXPANDED : FIELD_MENU_WIDTH_COLLAPSED;
  const activeTab = searchParams.get('tab');

  const isActive = (item) => {
    if (loc.pathname !== item.path) return false;
    if (item.tab) return activeTab === item.tab;
    // For the bare /precision-ag/analyses path, only highlight "Field Detail"
    // when no ?tab is set.
    if (item.path === '/precision-ag/analyses' && !item.tab) return !activeTab;
    return true;
  };

  return (
    <aside
      className="fixed top-18 bottom-0 z-30 flex flex-col transition-all duration-300 border-r border-gray-300/50 overflow-hidden"
      style={{
        left: leftOffset,
        width: width,
        backgroundColor: '#f3ecdc',
      }}
    >
      <button
        onClick={() => setMenuExpanded(!menuExpanded)}
        className="flex items-center justify-center py-2 text-gray-400 hover:text-gray-600 hover:bg-white/20 transition-all border-b border-gray-300/30 shrink-0"
        title={menuExpanded ? 'Collapse field menu' : 'Expand field menu'}
      >
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
          {menuExpanded ? <path d="M15 18l-6-6 6-6" /> : <path d="M9 18l6-6-6-6" />}
        </svg>
      </button>

      {menuExpanded && (
        <div className="px-3 py-3 border-b border-gray-300/50 shrink-0">
          <p className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Field</p>
          <p className="text-gray-800 text-xs font-semibold truncate mt-0.5">
            {field?.name || field?.fieldname || field?.FieldName || `Field ${fieldId}`}
          </p>
          {(field?.crop_type || field?.croptype) && (
            <p className="text-gray-500 text-[11px] truncate">{field.crop_type || field.croptype}</p>
          )}
        </div>
      )}

      <nav className="flex flex-col gap-0.5 p-2 grow overflow-y-auto">
        {SECTIONS.map(section => (
          <div key={section.label} className="mt-2">
            {menuExpanded && (
              <div className="text-[10px] uppercase tracking-wide text-gray-400 px-3 pt-2 pb-1">
                {section.label}
              </div>
            )}
            {section.items.map(item => (
              <Row
                key={`${item.path}|${item.tab || ''}`}
                to={buildUrl(item.path, businessId, fieldId, item.tab)}
                icon={item.icon}
                label={item.label}
                expanded={menuExpanded}
                active={isActive(item)}
              />
            ))}
          </div>
        ))}

        <div className="mt-4 pb-4">
          <Row
            to={`/precision-ag/fields?BusinessID=${businessId || ''}`}
            icon="↩"
            label="All Fields"
            expanded={menuExpanded}
          />
        </div>
      </nav>
    </aside>
  );
}
