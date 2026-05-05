import React, { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAccount } from './AccountContext';

const OTF_API = import.meta.env.VITE_OTF_API_URL || import.meta.env.VITE_API_URL || '';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

// ─── Minimal SVG icons ────────────────────────────────────────────────────────
const S = ({ children }) => (
  <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

const ICONS = {
  accounts:        <S><circle cx="8" cy="5" r="2.5"/><path d="M2 14c0-3.3 2.7-5 6-5s6 1.7 6 5"/></S>,
  personalSettings:(
    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor"
      strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="8" cy="8" r="2"/>
      <path d="M8 1v1.5M8 13.5V15M1 8h1.5M13.5 8H15M3.05 3.05l1.06 1.06M11.89 11.89l1.06 1.06M12.95 3.05l-1.06 1.06M4.11 11.89l-1.06 1.06"/>
    </svg>
  ),
  dashboard:     <S><path d="M2 8L8 2l6 6"/><path d="M3 7.5V14h3.5v-3h3v3H13V7.5"/></S>,
  blog:          <S><path d="M11 2l3 3-8 8H3v-3z"/><line x1="9" y1="4" x2="12" y2="7"/></S>,
  precisionAg:   <S><rect x="2" y="2" width="12" height="12" rx="1"/><line x1="2" y1="6" x2="14" y2="6"/><line x1="2" y1="10" x2="14" y2="10"/><line x1="6" y1="6" x2="6" y2="14"/></S>,
  farm2table:    <S><path d="M2 5h12l-1.5 7H3.5z"/><path d="M5.5 5L6.5 2M10.5 5l-1-3"/><circle cx="5.5" cy="13.5" r="0.8" fill="currentColor" stroke="none"/><circle cx="10.5" cy="13.5" r="0.8" fill="currentColor" stroke="none"/></S>,
  restaurant:    <S><line x1="5" y1="2" x2="5" y2="14"/><path d="M3 2v4a2 2 0 0 0 4 0V2"/><line x1="11" y1="2" x2="11" y2="14"/><path d="M9 2h3a0 0 0 0 1 0 4v0"/></S>,
  livestock:     <S><ellipse cx="8" cy="9.5" rx="4.5" ry="3"/><circle cx="4" cy="5" r="1.5"/><circle cx="8" cy="4" r="1.5"/><circle cx="12" cy="5" r="1.5"/></S>,
  products:      <S><path d="M2 5l6-3 6 3v6l-6 3-6-3z"/><line x1="8" y1="2" x2="8" y2="14"/><path d="M2 5l6 3 6-3"/></S>,
  services:      <S><path d="M13 3a3.5 3.5 0 0 0-4.2 3.5L2.5 12.5a1.5 1.5 0 1 0 2 2L10 9a3.5 3.5 0 1 0 3-6z"/><circle cx="12.5" cy="3.5" r="1"/></S>,
  events:        <S><rect x="2" y="3" width="12" height="11" rx="1"/><line x1="2" y1="7" x2="14" y2="7"/><line x1="5" y1="1" x2="5" y2="5"/><line x1="11" y1="1" x2="11" y2="5"/><circle cx="5.5" cy="10.5" r="0.8" fill="currentColor" stroke="none"/><circle cx="8" cy="10.5" r="0.8" fill="currentColor" stroke="none"/><circle cx="10.5" cy="10.5" r="0.8" fill="currentColor" stroke="none"/></S>,
  foodAgg:       <S><circle cx="8" cy="8" r="1.8"/><circle cx="2.5" cy="4" r="1.2"/><circle cx="13.5" cy="4" r="1.2"/><circle cx="2.5" cy="12" r="1.2"/><circle cx="13.5" cy="12" r="1.2"/><line x1="3.6" y1="4.8" x2="6.3" y2="6.6"/><line x1="12.4" y1="4.8" x2="9.7" y2="6.6"/><line x1="3.6" y1="11.2" x2="6.3" y2="9.4"/><line x1="12.4" y1="11.2" x2="9.7" y2="9.4"/></S>,
  testimonials:  <S><polygon points="8,1.5 10,6 15,6 11,9.5 12.5,14 8,11.5 3.5,14 5,9.5 1,6 6,6"/></S>,
  chef:          <S><path d="M4 10h8v4H4z"/><path d="M4 10a3 3 0 0 1-1-2 3 3 0 0 1 3-3 3 3 0 0 1 4 0 3 3 0 0 1 3 3 3 3 0 0 1-1 2"/></S>,
  rosemarie:     <S><circle cx="8" cy="8" r="1.5"/><circle cx="8" cy="3.5" r="1.5"/><circle cx="8" cy="12.5" r="1.5"/><circle cx="3.5" cy="8" r="1.5"/><circle cx="12.5" cy="8" r="1.5"/></S>,
  properties:    <S><path d="M2 8L8 2l6 6"/><path d="M3.5 7V14h3.5v-3.5h2V14H13V7"/></S>,
  website:       <S><circle cx="8" cy="8" r="6"/><path d="M8 2c-2 1.5-3 3.5-3 6s1 4.5 3 6"/><path d="M8 2c2 1.5 3 3.5 3 6s-1 4.5-3 6"/><line x1="2" y1="8" x2="14" y2="8"/></S>,
  accounting:    <S><rect x="2" y="3" width="12" height="10" rx="1"/><line x1="5" y1="7" x2="11" y2="7"/><line x1="5" y1="9.5" x2="9" y2="9.5"/><line x1="8" y1="1" x2="8" y2="3"/><line x1="8" y1="13" x2="8" y2="15"/></S>,
  equipment:     <S><rect x="1" y="4" width="9" height="8" rx="1"/><path d="M10 7h3l2 2v3h-5V7z"/><circle cx="3.5" cy="13" r="1.2"/><circle cx="12" cy="13" r="1.2"/></S>,
  foodWanted:    <S><rect x="3" y="2" width="10" height="12" rx="1"/><line x1="6" y1="6" x2="10" y2="6"/><line x1="6" y1="8.5" x2="10" y2="8.5"/><line x1="6" y1="11" x2="8.5" y2="11"/><circle cx="5" cy="6" r="0.7" fill="currentColor" stroke="none"/><circle cx="5" cy="8.5" r="0.7" fill="currentColor" stroke="none"/><circle cx="5" cy="11" r="0.7" fill="currentColor" stroke="none"/></S>,
  settings:      <S><circle cx="8" cy="8" r="2.5"/><path d="M8 1v2M8 13v2M1 8h2M13 8h2"/><path d="M3.2 3.2l1.4 1.4M11.4 11.4l1.4 1.4M12.8 3.2l-1.4 1.4M4.6 11.4l-1.4 1.4"/></S>,
  otfDM: <img src="/images/Over-the-Fence-LogIcon.webp" alt="" width="16" height="16" style={{ display: 'block', borderRadius: 3, objectFit: 'cover' }} onError={e => { e.target.style.display = 'none'; }} />,
  jobBoard:      <S><path d="M4 4h8a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1z"/><path d="M6 4V3a1 1 0 0 1 2 0v1"/><line x1="5" y1="8" x2="11" y2="8"/><line x1="5" y1="11" x2="9" y2="11"/></S>,
  csa:           <S><path d="M8 1L9.5 5.5H14L10.5 8.5 12 13 8 10 4 13 5.5 8.5 2 5.5H6.5z"/></S>,
  land:          <S><path d="M1 13L6 4l4 5 3-3 2 7z"/><line x1="1" y1="13" x2="15" y2="13"/></S>,
  certifications:<S><circle cx="8" cy="7" r="4"/><path d="M5.5 13l.5-2h4l.5 2"/><line x1="8" y1="11" x2="8" y2="15"/></S>,
  suppliers:     <S><rect x="2" y="9" width="5" height="5" rx="0.5"/><rect x="9" y="9" width="5" height="5" rx="0.5"/><rect x="5.5" y="2" width="5" height="5" rx="0.5"/><line x1="8" y1="7" x2="8" y2="9"/><line x1="4.5" y1="9" x2="4.5" y2="8"/><line x1="11.5" y1="9" x2="11.5" y2="8"/></S>,
  grants:        <S><rect x="2" y="5" width="12" height="9" rx="1"/><path d="M5 5V4a3 3 0 0 1 6 0v1"/><line x1="8" y1="8" x2="8" y2="11"/><line x1="6.5" y1="9.5" x2="9.5" y2="9.5"/></S>,
  education:     <S><path d="M2 8l6-4 6 4-6 4z"/><path d="M14 8v4"/><path d="M5 10v3a5 3 0 0 0 6 0v-3"/></S>,
  commodityPrices:<S><polyline points="2,12 6,8 9,10 13,4"/><line x1="13" y1="4" x2="15" y2="4"/><line x1="13" y1="4" x2="13" y2="6"/></S>,
  forums:        <S><path d="M2 3h9a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5L2 12V4a1 1 0 0 1 1-1z"/><path d="M14 6h1a1 1 0 0 1 1 1v4l-2 2v-3h-2"/></S>,
  landLeasing:   <S><path d="M2 13h12"/><path d="M4 13V7l4-4 4 4v6"/><line x1="7" y1="13" x2="7" y2="10"/><line x1="9" y1="13" x2="9" y2="10"/></S>,
  csaAdvanced:   <S><circle cx="8" cy="8" r="5"/><line x1="8" y1="5" x2="8" y2="8"/><line x1="8" y1="8" x2="11" y2="8"/><circle cx="8" cy="8" r="1" fill="currentColor" stroke="none"/><line x1="5" y1="3" x2="5" y2="1.5"/><line x1="11" y1="3" x2="11" y2="1.5"/></S>,
  meetings:      <S><rect x="2" y="3" width="12" height="11" rx="1"/><line x1="2" y1="7" x2="14" y2="7"/><line x1="5" y1="1" x2="5" y2="5"/><line x1="11" y1="1" x2="11" y2="5"/><polyline points="5,10 7,12 11,9"/></S>,
};

const CollapseIcon = () => (
  <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
    <line x1="14" y1="2" x2="14" y2="14" />
    <line x1="2" y1="8" x2="11" y2="8" />
    <polyline points="6,4 2,8 6,12" />
  </svg>
);

const ExpandIcon = () => (
  <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
    <line x1="2" y1="2" x2="2" y2="14" />
    <line x1="5" y1="8" x2="14" y2="8" />
    <polyline points="10,4 14,8 10,12" />
  </svg>
);

function NavChild({ to, label }) {
  return (
    <Link
      to={to}
      className="flex items-center px-3 py-1.5 ml-4 rounded-lg hover:bg-white/50 text-gray-600 text-xs transition-all"
    >
      {label}
    </Link>
  );
}

function NavSection({ icon, label, expanded, isOpen, onToggle, children, iconOnly = false }) {
  return (
    <div className="mb-1">
      <button
        onClick={onToggle}
        title={(!expanded || iconOnly) ? label : undefined}
        className={`w-full flex items-center py-2 rounded-lg hover:bg-white/50 text-gray-700 text-sm transition-all ${
          expanded ? 'gap-3 px-3' : 'justify-center'
        }`}
      >
        <span className="w-4 h-4 shrink-0 flex items-center justify-center">{icon}</span>
        {expanded && !iconOnly && (
          <>
            <span className="grow text-left whitespace-nowrap">{label}</span>
            <svg width="11" height="11" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="text-gray-400 shrink-0">
              {isOpen ? <path d="M3 10l5-5 5 5" /> : <path d="M3 6l5 5 5-5" />}
            </svg>
          </>
        )}
        {expanded && iconOnly && (
          <svg width="11" height="11" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="text-gray-400 shrink-0 ml-auto">
            {isOpen ? <path d="M3 10l5-5 5 5" /> : <path d="M3 6l5 5 5-5" />}
          </svg>
        )}
      </button>
      {isOpen && expanded && (
        <div className="flex flex-col gap-0.5 mt-0.5">
          {children}
        </div>
      )}
    </div>
  );
}

export default function AccountSidebar() {
  const { t } = useTranslation();
  const { Business, BusinessID, Expanded, setExpanded, OpenSections, setOpenSections, businesses, websiteSlug, setWebsiteSlug } = useAccount();
  const peopleId = typeof window !== 'undefined' ? localStorage.getItem('people_id') || '' : '';
  const [fields, setFields] = useState([]);
  const [features, setFeatures] = useState(null);
  const location = useLocation();

  useEffect(() => {
    if (!BusinessID) return;
    fetch(`${API_URL}/api/fields?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : [])
      .then(data => setFields(Array.isArray(data) ? data : []))
      .catch(() => setFields([]));
  }, [BusinessID]);

  useEffect(() => {
    if (!BusinessID) {
      setWebsiteSlug(null);
      return;
    }
    fetch(`${API_URL}/api/website/site?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : null)
      .then(site => setWebsiteSlug(site?.slug ?? null))
      .catch(() => setWebsiteSlug(null));
  }, [BusinessID]);

  useEffect(() => {
    const url = BusinessID
      ? `${API_URL}/api/company/features?business_id=${BusinessID}`
      : `${API_URL}/api/company/features`;
    fetch(url)
      .then(r => r.ok ? r.json() : [])
      .then(rows => {
        const map = {};
        rows.forEach(f => { map[f.feature_key] = f.is_enabled; });
        setFeatures(map);
      })
      .catch(() => setFeatures({}));
  }, [BusinessID]);

  const on = (key) => {
    if (features === null) return !BusinessID;
    return features[key] === true;
  };

  useEffect(() => {
    if (location.pathname.startsWith('/website/')) {
      setOpenSections(prev => prev['My Website'] ? prev : { ...prev, 'My Website': true });
    }
  }, [location.pathname]);

  const toggleSection = (label) => {
    setOpenSections(prev => ({ ...prev, [label]: !prev[label] }));
  };

  const isAccountOpen = OpenSections.Account || false;

  return (
    <div
      className={`fixed top-18 left-0 bottom-0 z-60 flex flex-col transition-all duration-300 ${Expanded ? 'w-52' : 'w-16'}`}
      style={{ backgroundColor: '#faf6ef' }}
    >
      <button
        onClick={() => setExpanded(!Expanded)}
        className="flex items-center justify-end px-3 py-2 text-gray-400 hover:text-gray-600 hover:bg-white/20 transition-all border-b border-gray-300/30 shrink-0"
        title={Expanded ? t('account_sidebar.toggle_collapse') : t('account_sidebar.toggle_expand')}
      >
        {Expanded ? <CollapseIcon /> : <ExpandIcon />}
      </button>

      {/* Over The Fence DM — always visible, above business name */}
      <div className="px-2 pt-2 shrink-0">
        <Link
          to="/over-the-fence"
          title={!Expanded ? 'Over The Fence DM' : undefined}
          className={`flex items-center py-2 rounded-lg hover:bg-white/50 text-gray-700 text-sm transition-all ${Expanded ? 'gap-3 px-3' : 'justify-center'}`}
        >
          <span className="w-4 h-4 shrink-0 flex items-center justify-center">{ICONS.otfDM}</span>
          {Expanded && <span className="grow text-left whitespace-nowrap">Over The Fence DM</span>}
        </Link>
      </div>

      {/* Accounts dropdown — always visible */}
      <div className="px-2 pb-2 border-b border-gray-300/50 shrink-0">
        <NavSection
          icon={ICONS.accounts}
          label={t('nav.accounts', 'Accounts')}
          expanded={Expanded}
          isOpen={OpenSections['Accounts'] || false}
          onToggle={() => toggleSection('Accounts')}
        >
          <NavChild to="/dashboard" label={t('nav.accounts', 'Accounts')} />
          <NavChild to={`/accounts/new?PeopleID=${peopleId}`} label={t('nav.add_account', 'Add Account')} />
          <NavChild to="/account/settings" label={t('nav.settings', 'Settings')} />
          {Array.isArray(businesses) && businesses.length > 0 && (
            <>
              <div className="mx-3 my-1 border-t border-gray-200" />
              {businesses.map(b => (
                <NavChild
                  key={b.BusinessID}
                  to={`/account?PeopleID=${peopleId}&BusinessID=${b.BusinessID}`}
                  label={b.BusinessName.substring(0, 25)}
                />
              ))}
            </>
          )}
        </NavSection>
      </div>

      {/* Business name + all feature nav — only shown when an org account is selected */}
      {!!BusinessID && (
        <>
          {Expanded && (
            <div className="px-3 py-3 border-b border-gray-300/50 shrink-0">
              <p className="text-gray-800 font-bold text-sm truncate">{Business?.BusinessName}</p>
              <p className="text-gray-500 text-xs truncate">{Business?.BusinessType}</p>
            </div>
          )}

          <nav className="flex flex-col gap-1 p-2 grow overflow-y-auto">

            {/* Dashboard */}
            <div className="mb-1">
              <div className={`flex items-center rounded-lg hover:bg-white/50 transition-all ${!Expanded ? 'justify-center' : ''}`}>
                <Link
                  to="/dashboard"
                  title={!Expanded ? t('account_sidebar.sec_dashboard') : undefined}
                  className={`flex items-center py-2 text-gray-700 text-sm flex-1 min-w-0 ${Expanded ? 'gap-3 px-3' : 'justify-center'}`}
                >
                  <span className="w-4 h-4 shrink-0 flex items-center justify-center">{ICONS.dashboard}</span>
                  {Expanded && <span className="grow text-left whitespace-nowrap">{t('account_sidebar.sec_dashboard')}</span>}
                </Link>
                {Expanded && (
                  <button
                    onClick={() => toggleSection('Account')}
                    className="pr-3 py-2 text-gray-400 hover:text-gray-600 transition-colors"
                  >
                    <svg width="11" height="11" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                      {isAccountOpen ? <path d="M3 10l5-5 5 5" /> : <path d="M3 6l5 5 5-5" />}
                    </svg>
                  </button>
                )}
              </div>
              {isAccountOpen && Expanded && (
                <div className="flex flex-col gap-0.5 mt-0.5">
                  <NavChild to={`/account/profile?BusinessID=${BusinessID}`} label={t('account_sidebar.edit_profile')} />
                  <NavChild to={`/account/team?BusinessID=${BusinessID}`} label={t('account_sidebar.team_members')} />
                  <NavChild to={`/account/change-type?BusinessID=${BusinessID}`} label={t('account_sidebar.change_account_type')} />
                  <NavChild to={`/account/delete?BusinessID=${BusinessID}`} label={t('account_sidebar.delete_account')} />
                </div>
              )}
            </div>

        {on('blog') && (
          <NavSection icon={ICONS.blog} label={t('account_sidebar.sec_blog')} expanded={Expanded}
            isOpen={OpenSections['Blog'] || false} onToggle={() => toggleSection('Blog')}>
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}`} label={t('account_sidebar.manage_blog')} />
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}&view=new`} label={t('account_sidebar.add_post')} />
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}&tab=categories`} label={t('account_sidebar.blog_categories')} />
            <NavChild to={`/blog/authors/manage?BusinessID=${BusinessID}`} label={t('account_sidebar.authors')} />
          </NavSection>
        )}

        {on('precision_ag') && (
          <NavSection icon={ICONS.precisionAg} label={t('account_sidebar.sec_precision_ag')} expanded={Expanded}
            isOpen={OpenSections['Precision Ag'] || false} onToggle={() => toggleSection('Precision Ag')}>
            <NavChild to={`/precision-ag/fields?BusinessID=${BusinessID}`} label={t('account_sidebar.ag_dashboard')} />
            <NavChild to={`/precision-ag/crop-detection?BusinessID=${BusinessID}`} label={t('account_sidebar.crop_detection')} />
            {fields.length > 0 && (
              <div className="mt-1 pt-1 border-t border-gray-300/40">
                {fields.map(f => {
                  const fid = f.fieldid ?? f.id;
                  const fname = f.name ?? f.fieldname ?? f.FieldName ?? `Field ${fid}`;
                  return (
                    <NavChild key={fid}
                      to={`/precision-ag/analyses?BusinessID=${BusinessID}&FieldID=${fid}`}
                      label={fname} />
                  );
                })}
              </div>
            )}
          </NavSection>
        )}

        {on('farm_2_table') && (
          <NavSection icon={ICONS.farm2table} label={t('account_sidebar.sec_farm_2_table')} expanded={Expanded}
            isOpen={OpenSections['Farm 2 Table'] || false} onToggle={() => toggleSection('Farm 2 Table')}>
            <NavChild to={`/seller/orders?BusinessID=${BusinessID}`} label={t('account_sidebar.incoming_orders')} />
            <NavChild to="/farm/standing-orders" label={t('account_sidebar.standing_orders')} />
            <NavChild to={`/account/stripe-connect?BusinessID=${BusinessID}`} label={t('account_sidebar.stripe_payouts')} />
            <NavChild to={`/produce/inventory?BusinessID=${BusinessID}`} label={t('account_sidebar.produce')} />
            <NavChild to={`/produce/processed-food?BusinessID=${BusinessID}`} label={t('account_sidebar.processed_foods')} />
            <NavChild to={`/produce/meat?BusinessID=${BusinessID}`} label={t('account_sidebar.meat')} />
          </NavSection>
        )}

        {on('restaurant_sourcing') && (
          <NavSection icon={ICONS.restaurant} label={t('account_sidebar.sec_restaurant')} expanded={Expanded}
            isOpen={OpenSections['Restaurant Sourcing'] || false} onToggle={() => toggleSection('Restaurant Sourcing')}>
            <NavChild to="/marketplaces/farm-to-table" label={t('account_sidebar.browse_marketplace')} />
            <NavChild to="/restaurant/standing-orders" label={t('account_sidebar.standing_orders')} />
            <NavChild to="/restaurant/farms"           label={t('account_sidebar.saved_farms')} />
            <NavChild to="/restaurant/digest"          label={t('account_sidebar.weekly_digest')} />
          </NavSection>
        )}

        {on('equipment') && (
          <NavSection icon={ICONS.equipment} label="Equipment" expanded={Expanded}
            isOpen={OpenSections['Equipment'] || false} onToggle={() => toggleSection('Equipment')}>
            <NavChild to="/marketplaces/equipment" label="Browse Equipment" />
            <NavChild to={`/equipment/my-listings?BusinessID=${BusinessID}`} label="My Listings" />
          </NavSection>
        )}

        {on('food_wanted') && (
          <NavSection icon={ICONS.foodWanted} label="Food Wanted" expanded={Expanded}
            isOpen={OpenSections['Food Wanted'] || false} onToggle={() => toggleSection('Food Wanted')}>
            <NavChild to="/marketplaces/food-wanted" label="Browse Wanted Ads" />
            <NavChild to={`/food-wanted/my-ads?BusinessID=${BusinessID}`} label="My Ads" />
          </NavSection>
        )}

        {on('job_board') && (
          <NavSection icon={ICONS.jobBoard} label="Job Board" expanded={Expanded}
            isOpen={OpenSections['Job Board'] || false} onToggle={() => toggleSection('Job Board')}>
            <NavChild to="/jobs" label="Browse Jobs" />
            <NavChild to={`/jobs/my-listings?BusinessID=${BusinessID}`} label="My Job Listings" />
          </NavSection>
        )}

        {on('csa_advanced') && (
          <NavSection icon={ICONS.csaAdvanced} label="CSA Advanced" expanded={Expanded}
            isOpen={OpenSections['CSA Advanced'] || false} onToggle={() => toggleSection('CSA Advanced')}>
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=contracts`} label="Contracts & Risk Sharing" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=payment-plans`} label="Payment Plans" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=work-shares`} label="Work Share Tracking" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=boxbot`} label="BoxBot Share Balancing" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=vacation-holds`} label="Vacation Holds" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=pickup-sites`} label="Pickup Sites" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=crop-progress`} label="Crop Progress" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=newsletters`} label="What's In The Box" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=harvest`} label="Harvest Allocation" />
            <NavChild to={`/csa-advanced?BusinessID=${BusinessID}&tab=box-labels`} label="Box Labels" />
          </NavSection>
        )}

        {on('csa_management') && (
          <NavSection icon={ICONS.csa} label="CSA Management" expanded={Expanded}
            isOpen={OpenSections['CSA Management'] || false} onToggle={() => toggleSection('CSA Management')}>
            <NavChild to="/csa" label="Browse CSA Plans" />
            <NavChild to={`/csa/manage?BusinessID=${BusinessID}`} label="Manage My Plans" />
          </NavSection>
        )}

        {on('land_leasing') && (
          <NavSection icon={ICONS.landLeasing} label="Land Leasing" expanded={Expanded}
            isOpen={OpenSections['Land Leasing'] || false} onToggle={() => toggleSection('Land Leasing')}>
            <NavChild to="/land" label="Browse Listings" />
            <NavChild to={`/land/my-listings?BusinessID=${BusinessID}`} label="My Listings" />
          </NavSection>
        )}

        {on('certifications') && (
          <NavSection icon={ICONS.certifications} label="Certifications" expanded={Expanded}
            isOpen={OpenSections['Certifications'] || false} onToggle={() => toggleSection('Certifications')}>
            <NavChild to={`/certifications?BusinessID=${BusinessID}`} label="My Certifications" />
          </NavSection>
        )}

        {on('supplier_directory') && (
          <NavSection icon={ICONS.suppliers} label="Supplier Directory" expanded={Expanded}
            isOpen={OpenSections['Supplier Directory'] || false} onToggle={() => toggleSection('Supplier Directory')}>
            <NavChild to="/suppliers" label="Browse Suppliers" />
          </NavSection>
        )}

        {on('grants_programs') && (
          <NavSection icon={ICONS.grants} label="Grants & Programs" expanded={Expanded}
            isOpen={OpenSections['Grants & Programs'] || false} onToggle={() => toggleSection('Grants & Programs')}>
            <NavChild to="/grants" label="Browse Programs" />
            <NavChild to={`/grants?tab=my-tracking&BusinessID=${BusinessID}`} label="My Tracker" />
          </NavSection>
        )}

        {on('education_center') && (
          <NavSection icon={ICONS.education} label="Education Center" expanded={Expanded}
            isOpen={OpenSections['Education Center'] || false} onToggle={() => toggleSection('Education Center')}>
            <NavChild to="/education" label="Courses & Articles" />
          </NavSection>
        )}

        {on('commodity_prices') && (
          <NavSection icon={ICONS.commodityPrices} label="Commodity Prices" expanded={Expanded}
            isOpen={OpenSections['Commodity Prices'] || false} onToggle={() => toggleSection('Commodity Prices')}>
            <NavChild to="/commodity-prices" label="Market Prices" />
          </NavSection>
        )}

        {on('forums') && (
          <NavSection icon={ICONS.forums} label="Forums" expanded={Expanded}
            isOpen={OpenSections['Forums'] || false} onToggle={() => toggleSection('Forums')}>
            <NavChild to="/forums" label="Browse Forums" />
            <NavChild to="/over-the-fence" label="Over the Fence DM" />
          </NavSection>
        )}

        {on('livestock') && (
          <NavSection icon={ICONS.livestock} label={t('account_sidebar.sec_livestock')} expanded={Expanded}
            isOpen={OpenSections.Livestock || false} onToggle={() => toggleSection('Livestock')}>
            <NavChild to={`/animals?BusinessID=${BusinessID}`} label={t('account_sidebar.animals_list')} />
            <NavChild to={`/animals/add?BusinessID=${BusinessID}`} label={t('account_sidebar.add')} />
            <NavChild to={`/animals/delete?BusinessID=${BusinessID}`} label={t('account_sidebar.delete')} />
            <NavChild to={`/animals/transfer?BusinessID=${BusinessID}`} label={t('account_sidebar.transfer')} />
            <NavChild to={`/animals/packages?BusinessID=${BusinessID}`} label={t('account_sidebar.packages')} />
            <NavChild to={`/animals/stats?BusinessID=${BusinessID}`} label={t('account_sidebar.statistics')} />
            <NavChild to={`/herd-health?BusinessID=${BusinessID}`} label="Herd Health" />
          </NavSection>
        )}

        {on('products') && (
          <NavSection icon={ICONS.products} label={t('account_sidebar.sec_products')} expanded={Expanded}
            isOpen={OpenSections.Products || false} onToggle={() => toggleSection('Products')}>
            <NavChild to="/marketplace/products" label={t('account_sidebar.browse_marketplace')} />
            <NavChild to={`/products?BusinessID=${BusinessID}`} label={t('account_sidebar.my_products')} />
            <NavChild to={`/products/add?BusinessID=${BusinessID}`} label={t('account_sidebar.add_product')} />
            <NavChild to={`/products/settings?BusinessID=${BusinessID}`} label={t('account_sidebar.settings')} />
          </NavSection>
        )}

        {on('services') && (
          <NavSection icon={ICONS.services} label={t('account_sidebar.sec_services')} expanded={Expanded}
            isOpen={OpenSections.Services || false} onToggle={() => toggleSection('Services')}>
            <NavChild to="/services/directory" label={t('account_sidebar.browse_services')} />
            <NavChild to={`/services?BusinessID=${BusinessID}`} label={t('account_sidebar.my_services')} />
            <NavChild to={`/services/add?BusinessID=${BusinessID}`} label={t('account_sidebar.add')} />
            <NavChild to={`/services/suggest-category?BusinessID=${BusinessID}`} label={t('account_sidebar.suggest_category')} />
          </NavSection>
        )}

        {on('events') && (
          <NavSection icon={ICONS.events} label={t('account_sidebar.sec_events')} expanded={Expanded}
            isOpen={OpenSections.Events || false} onToggle={() => toggleSection('Events')}>
            <NavChild to="/events" label={t('account_sidebar.browse_events')} />
            <NavChild to={`/events/manage?BusinessID=${BusinessID}`} label={t('account_sidebar.my_events')} />
            <NavChild to={`/events/add?BusinessID=${BusinessID}`} label={t('account_sidebar.add_event')} />
            <NavChild to="/my-registrations" label={t('account_sidebar.my_registrations')} />
          </NavSection>
        )}

        {on('food_aggregation') && (
          <NavSection icon={ICONS.foodAgg} label={t('account_sidebar.sec_food_agg')} expanded={Expanded}
            isOpen={OpenSections['Food Aggregation'] || false} onToggle={() => toggleSection('Food Aggregation')}>
            <NavChild to={`/aggregator?BusinessID=${BusinessID}`}           label={t('account_sidebar.hub_dashboard')} />
            <NavChild to={`/aggregator/farms?BusinessID=${BusinessID}`}     label={t('account_sidebar.farm_network')} />
            <NavChild to={`/aggregator/produce?BusinessID=${BusinessID}`}   label={t('account_sidebar.procurement')} />
            <NavChild to={`/aggregator/logistics?BusinessID=${BusinessID}`} label={t('account_sidebar.logistics')} />
            <NavChild to={`/aggregator/sales?BusinessID=${BusinessID}`}     label={t('account_sidebar.b2b_sales')} />
            <NavChild to={`/aggregator/esg?BusinessID=${BusinessID}`}       label={t('account_sidebar.esg_reports')} />
          </NavSection>
        )}

        {on('testimonials') && (
          <NavSection icon={ICONS.testimonials} label={t('account_sidebar.sec_testimonials')} expanded={Expanded}
            isOpen={OpenSections.Testimonials || false} onToggle={() => toggleSection('Testimonials')}>
            <NavChild to={`/testimonials/manage?BusinessID=${BusinessID}`} label={t('account_sidebar.manage_testimonials')} />
            <NavChild to={`/testimonials/request?BusinessID=${BusinessID}`} label={t('account_sidebar.request_testimonials')} />
          </NavSection>
        )}

        {(on('chef_dashboard') || on('pairsley') || on('provenance')) && (
          <NavSection icon={ICONS.chef} label={t('account_sidebar.sec_chef')} expanded={Expanded}
            isOpen={OpenSections['Chef Dashboard'] || false} onToggle={() => toggleSection('Chef Dashboard')}>
            {on('chef_dashboard') && <NavChild to={`/chef?BusinessID=${BusinessID}`} label={t('account_sidebar.sec_chef')} />}
            {on('pairsley')       && <NavChild to={`/platform/pairsley?BusinessID=${BusinessID}`} label={t('account_sidebar.pairsley_ai')} />}
            {on('provenance')     && <NavChild to={`/provenance/${BusinessID}`} label={t('account_sidebar.provenance_card')} />}
          </NavSection>
        )}

{on('properties') && (
          <NavSection icon={ICONS.properties} label={t('account_sidebar.sec_properties')} expanded={Expanded}
            isOpen={OpenSections.Properties || false} onToggle={() => toggleSection('Properties')}>
            <NavChild to={`/properties?BusinessID=${BusinessID}`} label={t('account_sidebar.list')} />
            <NavChild to={`/properties/add?BusinessID=${BusinessID}`} label={t('account_sidebar.add')} />
          </NavSection>
        )}

        {on('my_website') && (
          <NavSection icon={ICONS.website} label={t('account_sidebar.sec_website')} expanded={Expanded}
            isOpen={OpenSections['My Website'] || false} onToggle={() => toggleSection('My Website')}>
            <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=lavendir`} label={t('account_sidebar.lavendir_ai')} />
            {!websiteSlug ? (
              <NavChild to={`/website/builder?BusinessID=${BusinessID}`} label={t('account_sidebar.create_website')} />
            ) : (
              <>
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=manage-pages`} label={t('account_sidebar.sec_dashboard')} />
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=design`} label={t('account_sidebar.design')} />
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=settings`} label={t('account_sidebar.website_settings')} />
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=delete`} label={t('account_sidebar.delete_website')} />
                <a
                  href={`https://www.OatmealFarmNetwork.com/sites/${websiteSlug}`}
                  target="_blank" rel="noopener noreferrer"
                  className="flex items-center px-3 py-1.5 ml-4 rounded-lg hover:bg-white/50 text-gray-600 text-xs transition-all"
                >
                  {t('account_sidebar.view_live')}
                </a>
              </>
            )}
          </NavSection>
        )}

        {on('accounting') && (
          <NavSection icon={ICONS.accounting} label={t('account_sidebar.sec_accounting')} expanded={Expanded}
            isOpen={OpenSections['Accounting'] || false} onToggle={() => toggleSection('Accounting')}>
            <NavChild to={`/accounting?BusinessID=${BusinessID}`} label={t('account_sidebar.sec_dashboard')} />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#invoices`} label={t('account_sidebar.invoices')} />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#customers`} label={t('account_sidebar.customers')} />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#vendors`} label={t('account_sidebar.vendors')} />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#reports`} label={t('account_sidebar.reports')} />
          </NavSection>
        )}

        {on('meetings') && (
          <NavSection icon={ICONS.meetings} label="Meetings" expanded={Expanded}
            isOpen={OpenSections['Meetings'] || false} onToggle={() => toggleSection('Meetings')}>
            <NavChild to={`/meetings?BusinessID=${BusinessID}`} label="All Meetings" />
            <NavChild to={`/meetings?BusinessID=${BusinessID}&view=new`} label="New Meeting" />
            <NavChild to={`/meetings?BusinessID=${BusinessID}&view=projects`} label="Projects" />
          </NavSection>
        )}

        <NavSection icon={ICONS.settings} label={t('account_sidebar.sec_settings')} expanded={Expanded}
          isOpen={OpenSections['Account Settings'] || false} onToggle={() => toggleSection('Account Settings')}>
          <NavChild to={`/account/change-type?BusinessID=${BusinessID}`} label={t('account_sidebar.change_account_type')} />
          <NavChild to={`/account/profile?BusinessID=${BusinessID}`} label={t('account_sidebar.account_profile')} />
          <NavChild to={`/account/subscription?BusinessID=${BusinessID}`} label={t('account_sidebar.subscription')} />
          <NavChild to={`/account/delete?BusinessID=${BusinessID}`} label={t('account_sidebar.delete_account')} />
        </NavSection>

          </nav>
        </>
      )}
    </div>
  );
}
