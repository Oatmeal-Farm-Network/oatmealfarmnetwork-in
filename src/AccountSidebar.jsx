import React, { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

// ─── Minimal SVG icons ────────────────────────────────────────────────────────
const S = ({ children }) => (
  <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

const ICONS = {
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
  settings:      <S><circle cx="8" cy="8" r="2.5"/><path d="M8 1v2M8 13v2M1 8h2M13 8h2"/><path d="M3.2 3.2l1.4 1.4M11.4 11.4l1.4 1.4M12.8 3.2l-1.4 1.4M4.6 11.4l-1.4 1.4"/></S>,
};

// ─── Collapse/expand toggle icons (right-justified panel style) ───────────────
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

function NavSection({ icon, label, expanded, isOpen, onToggle, children }) {
  return (
    <div className="mb-1">
      <button
        onClick={onToggle}
        title={!expanded ? label : undefined}
        className={`w-full flex items-center py-2 rounded-lg hover:bg-white/50 text-gray-700 text-sm transition-all ${
          expanded ? 'gap-3 px-3' : 'justify-center'
        }`}
      >
        <span className="w-4 h-4 shrink-0 flex items-center justify-center">{icon}</span>
        {expanded && (
          <>
            <span className="grow text-left whitespace-nowrap">{label}</span>
            <svg width="11" height="11" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="text-gray-400 shrink-0">
              {isOpen ? <path d="M3 10l5-5 5 5" /> : <path d="M3 6l5 5 5-5" />}
            </svg>
          </>
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
  const { Business, BusinessID, Expanded, setExpanded, OpenSections, setOpenSections } = useAccount();
  const [fields, setFields] = useState([]);
  const [websiteSlug, setWebsiteSlug] = useState(null);
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
    if (!BusinessID) return;
    fetch(`${API_URL}/api/website/site?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : null)
      .then(site => { if (site) setWebsiteSlug(site.slug); })
      .catch(() => {});
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
      {/* Toggle button — right-justified */}
      <button
        onClick={() => setExpanded(!Expanded)}
        className="flex items-center justify-end px-3 py-2 text-gray-400 hover:text-gray-600 hover:bg-white/20 transition-all border-b border-gray-300/30 shrink-0"
        title={Expanded ? 'Collapse sidebar' : 'Expand sidebar'}
      >
        {Expanded ? <CollapseIcon /> : <ExpandIcon />}
      </button>

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
              title={!Expanded ? 'Dashboard' : undefined}
              className={`flex items-center py-2 text-gray-700 text-sm flex-1 min-w-0 ${Expanded ? 'gap-3 px-3' : 'justify-center'}`}
            >
              <span className="w-4 h-4 shrink-0 flex items-center justify-center">{ICONS.dashboard}</span>
              {Expanded && <span className="grow text-left whitespace-nowrap">Dashboard</span>}
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
              <NavChild to={`/account/profile?BusinessID=${BusinessID}`} label="Edit Profile" />
              <NavChild to={`/account/team?BusinessID=${BusinessID}`} label="Team Members" />
              <NavChild to={`/account/change-type?BusinessID=${BusinessID}`} label="Change Account Type" />
              <NavChild to={`/account/delete?BusinessID=${BusinessID}`} label="Delete Account" />
            </div>
          )}
        </div>

        {on('blog') && (
          <NavSection icon={ICONS.blog} label="Blog" expanded={Expanded}
            isOpen={OpenSections['Blog'] || false} onToggle={() => toggleSection('Blog')}>
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}`} label="Manage Blog" />
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}&view=new`} label="Add Post" />
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}&tab=categories`} label="Blog Categories" />
            <NavChild to={`/blog/authors/manage?BusinessID=${BusinessID}`} label="Authors" />
          </NavSection>
        )}

        {on('precision_ag') && (
          <NavSection icon={ICONS.precisionAg} label="Precision Ag" expanded={Expanded}
            isOpen={OpenSections['Precision Ag'] || false} onToggle={() => toggleSection('Precision Ag')}>
            <NavChild to={`/precision-ag/fields?BusinessID=${BusinessID}`} label="Ag Dashboard" />
            <NavChild to={`/precision-ag/crop-detection?BusinessID=${BusinessID}`} label="Crop Detection" />
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
          <NavSection icon={ICONS.farm2table} label="Farm 2 Table" expanded={Expanded}
            isOpen={OpenSections['Farm 2 Table'] || false} onToggle={() => toggleSection('Farm 2 Table')}>
            <NavChild to={`/seller/orders?BusinessID=${BusinessID}`} label="Incoming Orders" />
            <NavChild to="/farm/standing-orders" label="Standing Orders" />
            <NavChild to={`/account/stripe-connect?BusinessID=${BusinessID}`} label="Stripe Payouts" />
            <NavChild to={`/produce/inventory?BusinessID=${BusinessID}`} label="Produce" />
            <NavChild to={`/produce/processed-food?BusinessID=${BusinessID}`} label="Processed Foods" />
            <NavChild to={`/produce/meat?BusinessID=${BusinessID}`} label="Meat" />
          </NavSection>
        )}

        {on('restaurant_sourcing') && (
          <NavSection icon={ICONS.restaurant} label="Restaurant Sourcing" expanded={Expanded}
            isOpen={OpenSections['Restaurant Sourcing'] || false} onToggle={() => toggleSection('Restaurant Sourcing')}>
            <NavChild to="/marketplaces/farm-to-table" label="Browse Marketplace" />
            <NavChild to="/restaurant/standing-orders"  label="Standing Orders" />
            <NavChild to="/restaurant/farms"            label="Saved Farms" />
            <NavChild to="/restaurant/digest"           label="Weekly Digest" />
          </NavSection>
        )}

        {on('livestock') && (
          <NavSection icon={ICONS.livestock} label="Livestock" expanded={Expanded}
            isOpen={OpenSections.Livestock || false} onToggle={() => toggleSection('Livestock')}>
            <NavChild to={`/animals?BusinessID=${BusinessID}`} label="Animals List" />
            <NavChild to={`/animals/add?BusinessID=${BusinessID}`} label="Add" />
            <NavChild to={`/animals/delete?BusinessID=${BusinessID}`} label="Delete" />
            <NavChild to={`/animals/transfer?BusinessID=${BusinessID}`} label="Transfer" />
            <NavChild to={`/animals/packages?BusinessID=${BusinessID}`} label="Packages" />
            <NavChild to={`/animals/stats?BusinessID=${BusinessID}`} label="Statistics" />
          </NavSection>
        )}

        {on('products') && (
          <NavSection icon={ICONS.products} label="Products" expanded={Expanded}
            isOpen={OpenSections.Products || false} onToggle={() => toggleSection('Products')}>
            <NavChild to="/marketplace/products" label="Browse Marketplace" />
            <NavChild to={`/products?BusinessID=${BusinessID}`} label="My Products" />
            <NavChild to={`/products/add?BusinessID=${BusinessID}`} label="Add Product" />
            <NavChild to={`/products/settings?BusinessID=${BusinessID}`} label="Settings" />
          </NavSection>
        )}

        {on('services') && (
          <NavSection icon={ICONS.services} label="Services" expanded={Expanded}
            isOpen={OpenSections.Services || false} onToggle={() => toggleSection('Services')}>
            <NavChild to="/services/directory" label="Browse Services" />
            <NavChild to={`/services?BusinessID=${BusinessID}`} label="My Services" />
            <NavChild to={`/services/add?BusinessID=${BusinessID}`} label="Add" />
            <NavChild to={`/services/suggest-category?BusinessID=${BusinessID}`} label="Suggest Category" />
          </NavSection>
        )}

        {on('events') && (
          <NavSection icon={ICONS.events} label="Events" expanded={Expanded}
            isOpen={OpenSections.Events || false} onToggle={() => toggleSection('Events')}>
            <NavChild to="/events" label="Browse Events" />
            <NavChild to={`/events/manage?BusinessID=${BusinessID}`} label="My Events" />
            <NavChild to={`/events/add?BusinessID=${BusinessID}`} label="Add Event" />
            <NavChild to="/my-registrations" label="My Registrations" />
          </NavSection>
        )}

        {on('food_aggregation') && (
          <NavSection icon={ICONS.foodAgg} label="Food Aggregation" expanded={Expanded}
            isOpen={OpenSections['Food Aggregation'] || false} onToggle={() => toggleSection('Food Aggregation')}>
            <NavChild to={`/aggregator?BusinessID=${BusinessID}`}           label="Hub Dashboard" />
            <NavChild to={`/aggregator/farms?BusinessID=${BusinessID}`}     label="Farm Network" />
            <NavChild to={`/aggregator/produce?BusinessID=${BusinessID}`}   label="Procurement & Inventory" />
            <NavChild to={`/aggregator/logistics?BusinessID=${BusinessID}`} label="Logistics" />
            <NavChild to={`/aggregator/sales?BusinessID=${BusinessID}`}     label="B2B & D2C Sales" />
            <NavChild to={`/aggregator/esg?BusinessID=${BusinessID}`}       label="ESG Reports" />
          </NavSection>
        )}

        {on('testimonials') && (
          <NavSection icon={ICONS.testimonials} label="Testimonials" expanded={Expanded}
            isOpen={OpenSections.Testimonials || false} onToggle={() => toggleSection('Testimonials')}>
            <NavChild to={`/testimonials/manage?BusinessID=${BusinessID}`} label="Manage Testimonials" />
            <NavChild to={`/testimonials/request?BusinessID=${BusinessID}`} label="Request Testimonials" />
          </NavSection>
        )}

        {(on('chef_dashboard') || on('pairsley') || on('provenance')) && (
          <NavSection icon={ICONS.chef} label="Chef Dashboard" expanded={Expanded}
            isOpen={OpenSections['Chef Dashboard'] || false} onToggle={() => toggleSection('Chef Dashboard')}>
            {on('chef_dashboard') && <NavChild to={`/chef?BusinessID=${BusinessID}`} label="Chef Dashboard" />}
            {on('pairsley')       && <NavChild to={`/platform/pairsley?BusinessID=${BusinessID}`} label="Pairsley AI" />}
            {on('provenance')     && <NavChild to={`/provenance/${BusinessID}`} label="Provenance Card" />}
          </NavSection>
        )}

        {on('rosemarie') && (
          <NavSection icon={ICONS.rosemarie} label="Rosemarie AI" expanded={Expanded}
            isOpen={OpenSections.Rosemarie || false} onToggle={() => toggleSection('Rosemarie')}>
            <NavChild to={`/platform/rosemarie?BusinessID=${BusinessID}`} label="About Rosemarie" />
          </NavSection>
        )}

        {on('properties') && (
          <NavSection icon={ICONS.properties} label="Properties" expanded={Expanded}
            isOpen={OpenSections.Properties || false} onToggle={() => toggleSection('Properties')}>
            <NavChild to={`/properties?BusinessID=${BusinessID}`} label="List" />
            <NavChild to={`/properties/add?BusinessID=${BusinessID}`} label="Add" />
          </NavSection>
        )}

        {on('my_website') && (
          <NavSection icon={ICONS.website} label="My Website" expanded={Expanded}
            isOpen={OpenSections['My Website'] || false} onToggle={() => toggleSection('My Website')}>
            <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=lavendir`} label="Lavendir AI" />
            {!websiteSlug ? (
              <NavChild to={`/website/builder?BusinessID=${BusinessID}`} label="Create Website" />
            ) : (
              <>
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=manage-pages`} label="Dashboard" />
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=design`} label="Design" />
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=settings`} label="Website Settings" />
                <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=delete`} label="Delete Website" />
                <a
                  href={`https://www.OatmealFarmNetwork.com/sites/${websiteSlug}`}
                  target="_blank" rel="noopener noreferrer"
                  className="flex items-center px-3 py-1.5 ml-4 rounded-lg hover:bg-white/50 text-gray-600 text-xs transition-all"
                >
                  View Live Site ↗
                </a>
              </>
            )}
          </NavSection>
        )}

        {on('accounting') && (
          <NavSection icon={ICONS.accounting} label="Accounting" expanded={Expanded}
            isOpen={OpenSections['Accounting'] || false} onToggle={() => toggleSection('Accounting')}>
            <NavChild to={`/accounting?BusinessID=${BusinessID}`} label="Dashboard" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#invoices`} label="Invoices" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#customers`} label="Customers" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#vendors`} label="Vendors" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#reports`} label="Reports" />
          </NavSection>
        )}

        <NavSection icon={ICONS.settings} label="Account Settings" expanded={Expanded}
          isOpen={OpenSections['Account Settings'] || false} onToggle={() => toggleSection('Account Settings')}>
          <NavChild to={`/account/change-type?BusinessID=${BusinessID}`} label="Change Account Type" />
          <NavChild to={`/account/profile?BusinessID=${BusinessID}`} label="Account Profile" />
          <NavChild to={`/account/subscription?BusinessID=${BusinessID}`} label="Subscription / Billing" />
          <NavChild to={`/account/delete?BusinessID=${BusinessID}`} label="Delete Account" />
        </NavSection>

      </nav>
    </div>
  );
}
