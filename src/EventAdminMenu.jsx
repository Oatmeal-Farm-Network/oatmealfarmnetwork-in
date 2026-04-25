import React, { useEffect, useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

// Tab lists for core modules, keyed by FeatureKey from OFNEventFeatures.
// Sub-tabs are a frontend-only concern — the backend feature catalog only
// tracks which modules a type exposes, not their internal tab structure.
const MODULE_TABS = {
  fiber_arts_module: [
    ['config',     'Configuration'],
    ['categories', 'Classes & Categories'],
    ['entries',    'Entries & Judging'],
  ],
  halter_module: [
    ['config',        'Configuration'],
    ['classes',       'Classes'],
    ['registrations', 'Registrations'],
    ['judging',       'Judging'],
  ],
  auction_module: [
    ['config', 'Configuration'],
    ['lots',   'Lots'],
    ['bids',   'Bids'],
  ],
  vendor_fair_module: [
    ['config', 'Configuration'],
    ['apps',   'Applications'],
  ],
  dining_module: [
    ['config',        'Configuration'],
    ['menu',          'Menu'],
    ['tables',        'Tables'],
    ['registrations', 'Registrations'],
    ['seating',       'Seating Chart'],
  ],
  tour_module: [
    ['config',        'Configuration'],
    ['slots',         'Time Slots'],
    ['addons',        'Add-Ons'],
    ['registrations', 'Registrations'],
  ],
  conference_module: [
    ['config',   'Configuration'],
    ['tracks',   'Tracks'],
    ['rooms',    'Rooms'],
    ['speakers', 'Speakers'],
    ['sessions', 'Sessions'],
    ['regs',     'Registrations'],
  ],
  competition_module: [
    ['config',       'Configuration'],
    ['categories',   'Categories & Rubric'],
    ['judges',       'Judges'],
    ['entries',      'Entries & Scoring'],
    ['leaderboard',  'Leaderboard'],
  ],
  simple_module: [
    ['config',        'Configuration'],
    ['registrations', 'Registrations'],
  ],
  fleece_module: [
    ['config',        'Configuration'],
    ['entries',       'Fleece Entries'],
    ['judging',       'Judging & Results'],
  ],
  spinoff_module: [
    ['config',        'Configuration'],
    ['entries',       'Spin-Off Entries'],
    ['judging',       'Judging & Results'],
  ],
};

export const EVENT_MENU_WIDTH_EXPANDED = 208; // w-52
export const EVENT_MENU_WIDTH_COLLAPSED = 56;  // w-14

function Row({ to, href, icon, label, expanded, active }) {
  const cls = `flex items-center gap-3 px-3 py-2 rounded-lg transition-all no-underline ${
    active
      ? 'bg-[#3D6B34] text-white font-semibold'
      : 'text-gray-700 hover:bg-white/50'
  }`;
  const style = active ? { color: '#fff' } : undefined;
  const content = (
    <>
      <span className="w-5 text-center shrink-0 text-base leading-none">{icon}</span>
      {expanded && <span className="text-sm whitespace-nowrap truncate">{label}</span>}
    </>
  );
  if (href) return <a href={href} className={cls} style={style} title={!expanded ? label : undefined}>{content}</a>;
  return <Link to={to} className={cls} style={style} title={!expanded ? label : undefined}>{content}</Link>;
}

function SubRow({ to, label, expanded, active }) {
  if (!expanded) return null;
  return (
    <Link
      to={to}
      className={`flex items-center px-3 py-1.5 ml-4 rounded-lg text-xs transition-all no-underline ${
        active ? 'bg-[#3D6B34]/15 text-[#3D6B34] font-semibold' : 'text-gray-600 hover:bg-white/50'
      }`}
    >
      {label}
    </Link>
  );
}

function appendBiz(path, businessId) {
  if (!businessId) return path;
  const sep = path.includes('?') ? '&' : '?';
  return `${path}${sep}BusinessID=${businessId}`;
}

function isAbsolute(url) {
  return /^https?:\/\//.test(url) || url?.startsWith('/api/');
}

export default function EventAdminMenu({
  eventId, eventType, businessId,
  menuExpanded, setMenuExpanded,
}) {
  const { Expanded: accountExpanded } = useAccount() || {};
  const loc = useLocation();
  const [features, setFeatures] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!eventId) return;
    let alive = true;
    setLoading(true);
    fetch(`${API}/api/events/${eventId}/features`)
      .then(r => r.ok ? r.json() : Promise.reject(new Error('features load failed')))
      .then(d => { if (alive) setFeatures(Array.isArray(d?.features) ? d.features : []); })
      .catch(() => { if (alive) setFeatures([]); })
      .finally(() => { if (alive) setLoading(false); });
    return () => { alive = false; };
  }, [eventId]);

  const leftOffset = accountExpanded ? 208 : 64;
  const width = menuExpanded ? EVENT_MENU_WIDTH_EXPANDED : EVENT_MENU_WIDTH_COLLAPSED;

  const dashboardPath = `/events/${eventId}/dashboard`;
  const activeTab = new URLSearchParams(loc.search).get('tab') || 'config';

  const core = features.filter(f => f.IsCoreModule && f.AdminPath);
  const tools = features.filter(f => !f.IsCoreModule && f.AdminPath && !isAbsolute(f.AdminPath));
  const exports = features.filter(f => f.AdminPath && isAbsolute(f.AdminPath));

  return (
    <aside
      className="fixed top-[72px] bottom-0 z-30 flex flex-col transition-all duration-300 border-r border-gray-300/50 overflow-hidden"
      style={{
        left: leftOffset,
        width: width,
        backgroundColor: '#f3ecdc',
      }}
    >
      <button
        onClick={() => setMenuExpanded(!menuExpanded)}
        className="flex items-center justify-center py-2 text-gray-400 hover:text-gray-600 hover:bg-white/20 transition-all border-b border-gray-300/30 shrink-0"
        title={menuExpanded ? 'Collapse event menu' : 'Expand event menu'}
      >
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
          {menuExpanded ? <path d="M15 18l-6-6 6-6" /> : <path d="M9 18l6-6-6-6" />}
        </svg>
      </button>

      {menuExpanded && (
        <div className="px-3 py-3 border-b border-gray-300/50 shrink-0">
          <p className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Event Admin</p>
          <p className="text-gray-800 text-xs truncate mt-0.5">{eventType || 'Event'}</p>
        </div>
      )}

      <nav className="flex flex-col gap-0.5 p-2 flex-grow overflow-y-auto">
        <Row
          to={dashboardPath} icon="🏠" label="Dashboard"
          expanded={menuExpanded}
          active={loc.pathname === dashboardPath}
        />

        {core.map(f => {
          const base = f.AdminPath.split('?')[0];
          const tabs = MODULE_TABS[f.FeatureKey] || [];
          return (
            <div key={f.FeatureID} className="mt-2">
              <Row
                to={appendBiz(`${base}?tab=config`, businessId)}
                icon={f.Icon || '📦'} label={f.FeatureName}
                expanded={menuExpanded}
                active={loc.pathname === base}
              />
              {tabs.map(([tabId, tabLabel]) => (
                <SubRow
                  key={tabId}
                  to={appendBiz(`${base}?tab=${tabId}`, businessId)}
                  label={tabLabel}
                  expanded={menuExpanded}
                  active={loc.pathname === base && activeTab === tabId}
                />
              ))}
            </div>
          );
        })}

        {tools.length > 0 && (
          <div className="mt-2">
            {menuExpanded && (
              <div className="text-[10px] uppercase tracking-wide text-gray-400 px-3 pt-2 pb-1">Tools</div>
            )}
            {tools.map(f => (
              <Row key={f.FeatureID}
                to={f.AdminPath} icon={f.Icon || '•'} label={f.FeatureName}
                expanded={menuExpanded}
                active={loc.pathname === f.AdminPath.split('?')[0]}
              />
            ))}
          </div>
        )}

        {exports.length > 0 && (
          <div className="mt-2">
            {menuExpanded && (
              <div className="text-[10px] uppercase tracking-wide text-gray-400 px-3 pt-2 pb-1">Exports</div>
            )}
            {exports.map(f => (
              <Row key={f.FeatureID}
                href={`${API}${f.AdminPath}`} icon={f.Icon || '⬇️'} label={f.FeatureName}
                expanded={menuExpanded}
              />
            ))}
          </div>
        )}

        {!loading && features.length === 0 && menuExpanded && (
          <div className="text-[11px] text-gray-400 px-3 py-2 italic">
            No features configured for this event type.
          </div>
        )}

        <div className="mt-2">
          {menuExpanded && (
            <div className="text-[10px] uppercase tracking-wide text-gray-400 px-3 pt-2 pb-1">Money</div>
          )}
          <Row to={`/events/${eventId}/admin/registrations`} icon="💳" label="Registrations & Carts"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/registrations`} />
          <Row to={`/events/${eventId}/admin/meals`} icon="🍽️" label="Meal Tickets"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/meals`} />
          <Row to={`/events/${eventId}/admin/promo-codes`} icon="🏷️" label="Promo Codes"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/promo-codes`} />
          <Row to={`/events/${eventId}/admin/waitlist`} icon="⏳" label="Waitlist"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/waitlist`} />
          <Row to={`/events/${eventId}/admin/abandoned-carts`} icon="🛒" label="Abandoned Carts"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/abandoned-carts`} />
          <Row to={`/events/${eventId}/admin/sponsorship`} icon="🏆" label="Sponsorship"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/sponsorship`} />
          <Row to={appendBiz(`/events/${eventId}/leads`, businessId)} icon="📇" label="My Leads (exhibitor)"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/leads`} />
          <Row to={`/events/${eventId}/admin/floor-plan`} icon="🗺️" label="Floor Plan"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/floor-plan`} />
          <Row to={`/events/${eventId}/admin/booth-services`} icon="⚡" label="Booth Services"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/booth-services`} />
          <Row to={`/events/${eventId}/admin/coi`} icon="📜" label="COI / Insurance"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/coi`} />
        </div>

        <div className="mt-2">
          {menuExpanded && (
            <div className="text-[10px] uppercase tracking-wide text-gray-400 px-3 pt-2 pb-1">Communications</div>
          )}
          <Row to={`/events/${eventId}/admin/mailing-list`} icon="📧" label="Mailing List"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/mailing-list`} />
          <Row to={`/events/${eventId}/admin/exports`} icon="⬇️" label="Exports & Schedules"
            expanded={menuExpanded}
            active={loc.pathname === `/events/${eventId}/admin/exports`} />
          <Row to={`/events/${eventId}/admin/print`} icon="🖨️" label="Printouts"
            expanded={menuExpanded}
            active={loc.pathname.startsWith(`/events/${eventId}/admin/print`)} />
        </div>

        <div className="mt-2 pb-4">
          {menuExpanded && (
            <div className="text-[10px] uppercase tracking-wide text-gray-400 px-3 pt-2 pb-1">Event</div>
          )}
          <Row to={`/events/${eventId}`} icon="👁️" label="Public Page"
            expanded={menuExpanded} />
          <Row to={appendBiz(`/events/manage?edit=${eventId}`, businessId)} icon="✏️" label="Edit details"
            expanded={menuExpanded} />
          <Row to={appendBiz('/events/manage', businessId)} icon="↩" label="All my events"
            expanded={menuExpanded} />
        </div>

      </nav>
    </aside>
  );
}
