import React, { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

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
        className="w-full flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-white/50 text-gray-700 text-sm transition-all"
      >
        {icon && <img src={icon} alt={label} className="w-6 h-6 shrink-0" />}
        {expanded && (
          <>
            <span className="grow text-left whitespace-nowrap">{label}</span>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="text-gray-400">
              {isOpen ? <path d="M18 15l-6-6-6 6" /> : <path d="M6 9l6 6 6-6" />}
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
  const BT = Business?.BusinessTypeID;
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
      <button
        onClick={() => setExpanded(!Expanded)}
        className="flex items-center justify-center py-2 text-gray-400 hover:text-gray-600 hover:bg-white/20 transition-all border-b border-gray-300/30"
      >
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
          {Expanded
            ? <path d="M15 18l-6-6 6-6" />
            : <path d="M9 18l6-6-6-6" />}
        </svg>
      </button>

      {Expanded && (
        <div className="px-3 py-3 border-b border-gray-300/50">
          <p className="text-gray-800 font-bold text-sm truncate">{Business?.BusinessName}</p>
          <p className="text-gray-500 text-xs truncate">{Business?.BusinessType}</p>
        </div>
      )}

      <nav className="flex flex-col gap-1 p-2 grow overflow-y-auto">

        {/* Dashboard */}
        <div className="mb-1">
          <div className="flex items-center rounded-lg hover:bg-white/50 transition-all">
            <Link
              to="/dashboard"
              className="flex items-center gap-3 px-3 py-2 text-gray-700 text-sm flex-1 min-w-0"
            >
              <img src="/icons/Website.svg" alt="Dashboard" className="w-6 h-6 shrink-0" />
              {Expanded && <span className="grow text-left whitespace-nowrap">Dashboard</span>}
            </Link>
            {Expanded && (
              <button
                onClick={() => toggleSection('Account')}
                className="pr-3 py-2 text-gray-400 hover:text-gray-600 transition-colors"
              >
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                  {isAccountOpen ? <path d="M18 15l-6-6-6 6" /> : <path d="M6 9l6 6 6-6" />}
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
          <NavSection
            icon="/icons/Blog.png"
            label="Blog"
            expanded={Expanded}
            isOpen={OpenSections['Blog'] || false}
            onToggle={() => toggleSection('Blog')}
          >
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}`} label="Manage Blog" />
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}&view=new`} label="Add Post" />
            <NavChild to={`/blog/manage?BusinessID=${BusinessID}&tab=categories`} label="Blog Categories" />
            <NavChild to={`/blog/authors/manage?BusinessID=${BusinessID}`} label="Authors" />
          </NavSection>
        )}

        {on('precision_ag') && (
          <NavSection
            icon="/icons/PrecisionAg.svg"
            label="Precision Ag"
            expanded={Expanded}
            isOpen={OpenSections['Precision Ag'] || false}
            onToggle={() => toggleSection('Precision Ag')}
          >
            <NavChild to={`/precision-ag/fields?BusinessID=${BusinessID}`} label="Ag Dashboard" />
            <NavChild to={`/precision-ag/crop-detection?BusinessID=${BusinessID}`} label="Crop Detection" />
            {fields.length > 0 && (
              <div className="mt-1 pt-1 border-t border-gray-300/40">
                {fields.map(f => {
                  const fid = f.fieldid ?? f.id;
                  const fname = f.name ?? f.fieldname ?? f.FieldName ?? `Field ${fid}`;
                  return (
                    <NavChild
                      key={fid}
                      to={`/precision-ag/analyses?BusinessID=${BusinessID}&FieldID=${fid}`}
                      label={fname}
                    />
                  );
                })}
              </div>
            )}
          </NavSection>
        )}

        {on('farm_2_table') && (
          <NavSection
            icon="/icons/produce.webp"
            label="Farm 2 Table"
            expanded={Expanded}
            isOpen={OpenSections['Farm 2 Table'] || false}
            onToggle={() => toggleSection('Farm 2 Table')}
          >
            <NavChild to={`/seller/orders?BusinessID=${BusinessID}`} label="Incoming Orders" />
            <NavChild to="/farm/standing-orders" label="Standing Orders" />
            <NavChild to={`/account/stripe-connect?BusinessID=${BusinessID}`} label="Stripe Payouts" />
            <NavChild to={`/produce/inventory?BusinessID=${BusinessID}`} label="Produce" />
            <NavChild to={`/produce/processed-food?BusinessID=${BusinessID}`} label="Processed Foods" />
            <NavChild to={`/produce/meat?BusinessID=${BusinessID}`} label="Meat" />
          </NavSection>
        )}

        {on('restaurant_sourcing') && (
          <NavSection
            icon="/icons/produce.webp"
            label="Restaurant Sourcing"
            expanded={Expanded}
            isOpen={OpenSections['Restaurant Sourcing'] || false}
            onToggle={() => toggleSection('Restaurant Sourcing')}
          >
            <NavChild to="/marketplaces/farm-to-table"  label="Browse Marketplace" />
            <NavChild to="/restaurant/standing-orders"  label="Standing Orders" />
            <NavChild to="/restaurant/farms"            label="Saved Farms" />
            <NavChild to="/restaurant/digest"           label="Weekly Digest" />
          </NavSection>
        )}

        {on('livestock') && (
          <NavSection
            icon="/icons/Livestock.svg"
            label="Livestock"
            expanded={Expanded}
            isOpen={OpenSections.Livestock || false}
            onToggle={() => toggleSection('Livestock')}
          >
            <NavChild to={`/animals?BusinessID=${BusinessID}`} label="Animals List" />
            <NavChild to={`/animals/add?BusinessID=${BusinessID}`} label="Add" />
            <NavChild to={`/animals/delete?BusinessID=${BusinessID}`} label="Delete" />
            <NavChild to={`/animals/transfer?BusinessID=${BusinessID}`} label="Transfer" />
            <NavChild to={`/animals/packages?BusinessID=${BusinessID}`} label="Packages" />
            <NavChild to={`/animals/stats?BusinessID=${BusinessID}`} label="Statistics" />
          </NavSection>
        )}

        {on('products') && (
          <NavSection
            icon="/icons/Products.svg"
            label="Products"
            expanded={Expanded}
            isOpen={OpenSections.Products || false}
            onToggle={() => toggleSection('Products')}
          >
            <NavChild to="/marketplace/products" label="Browse Marketplace" />
            <NavChild to={`/products?BusinessID=${BusinessID}`} label="My Products" />
            <NavChild to={`/products/add?BusinessID=${BusinessID}`} label="Add Product" />
            <NavChild to={`/products/settings?BusinessID=${BusinessID}`} label="Settings" />
          </NavSection>
        )}

        {on('services') && (
          <NavSection
            icon="/icons/Services.svg"
            label="Services"
            expanded={Expanded}
            isOpen={OpenSections.Services || false}
            onToggle={() => toggleSection('Services')}
          >
            <NavChild to="/services/directory" label="Browse Services" />
            <NavChild to={`/services?BusinessID=${BusinessID}`} label="My Services" />
            <NavChild to={`/services/add?BusinessID=${BusinessID}`} label="Add" />
            <NavChild to={`/services/suggest-category?BusinessID=${BusinessID}`} label="Suggest Category" />
          </NavSection>
        )}

        {on('events') && (
          <NavSection
            icon="/icons/Assoc-events-icon.svg"
            label="Events"
            expanded={Expanded}
            isOpen={OpenSections.Events || false}
            onToggle={() => toggleSection('Events')}
          >
            <NavChild to="/events" label="Browse Events" />
            <NavChild to={`/events/manage?BusinessID=${BusinessID}`} label="My Events" />
            <NavChild to={`/events/add?BusinessID=${BusinessID}`} label="Add Event" />
            <NavChild to="/my-registrations" label="My Registrations" />
          </NavSection>
        )}

        {on('food_aggregation') && (
          <NavSection
            icon="/images/FoodAggregators.webp"
            label="Food Aggregation"
            expanded={Expanded}
            isOpen={OpenSections['Food Aggregation'] || false}
            onToggle={() => toggleSection('Food Aggregation')}
          >
            <NavChild to={`/aggregator?BusinessID=${BusinessID}`}           label="Hub Dashboard" />
            <NavChild to={`/aggregator/farms?BusinessID=${BusinessID}`}     label="Farm Network" />
            <NavChild to={`/aggregator/produce?BusinessID=${BusinessID}`}   label="Procurement & Inventory" />
            <NavChild to={`/aggregator/logistics?BusinessID=${BusinessID}`} label="Logistics" />
            <NavChild to={`/aggregator/sales?BusinessID=${BusinessID}`}     label="B2B & D2C Sales" />
            <NavChild to={`/aggregator/esg?BusinessID=${BusinessID}`}       label="ESG Reports" />
          </NavSection>
        )}

        {on('testimonials') && (
          <NavSection
            icon="/images/Handshake.webp"
            label="Testimonials"
            expanded={Expanded}
            isOpen={OpenSections.Testimonials || false}
            onToggle={() => toggleSection('Testimonials')}
          >
            <NavChild to={`/testimonials/manage?BusinessID=${BusinessID}`} label="Manage Testimonials" />
            <NavChild to={`/testimonials/request?BusinessID=${BusinessID}`} label="Request Testimonials" />
          </NavSection>
        )}

        {(on('chef_dashboard') || on('pairsley') || on('provenance')) && (
          <NavSection
            icon="/icons/Assoc-restaurants-icon.svg"
            label="Chef Dashboard"
            expanded={Expanded}
            isOpen={OpenSections['Chef Dashboard'] || false}
            onToggle={() => toggleSection('Chef Dashboard')}
          >
            {on('chef_dashboard') && (
              <NavChild to={`/chef?BusinessID=${BusinessID}`} label="Chef Dashboard" />
            )}
            {on('pairsley') && (
              <NavChild to={`/platform/pairsley?BusinessID=${BusinessID}`} label="Pairsley AI" />
            )}
            {on('provenance') && (
              <NavChild to={`/provenance/${BusinessID}`} label="Provenance Card" />
            )}
          </NavSection>
        )}

        {on('rosemarie') && (
          <NavSection
            icon="/icons/Services.svg"
            label="Rosemarie AI"
            expanded={Expanded}
            isOpen={OpenSections.Rosemarie || false}
            onToggle={() => toggleSection('Rosemarie')}
          >
            <NavChild to={`/platform/rosemarie?BusinessID=${BusinessID}`} label="About Rosemarie" />
          </NavSection>
        )}

        {on('properties') && (
          <NavSection
            icon="/icons/Real-Estate.svg"
            label="Properties"
            expanded={Expanded}
            isOpen={OpenSections.Properties || false}
            onToggle={() => toggleSection('Properties')}
          >
            <NavChild to={`/properties?BusinessID=${BusinessID}`} label="List" />
            <NavChild to={`/properties/add?BusinessID=${BusinessID}`} label="Add" />
          </NavSection>
        )}

        {on('my_website') && (
          <NavSection
            icon="/icons/Website.svg"
            label="My Website"
            expanded={Expanded}
            isOpen={OpenSections['My Website'] || false}
            onToggle={() => toggleSection('My Website')}
          >
            <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=lavendir`} label={<><img src="/images/LavendirIcon.png" alt="" className="w-4 h-4 mr-1.5 inline-block align-text-bottom" />Lavendir AI</>} />
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
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center px-3 py-1.5 ml-4 rounded-lg hover:bg-white/50 text-gray-600 text-xs transition-all"
                >
                  View Live Site ↗
                </a>
              </>
            )}
          </NavSection>
        )}

        {on('accounting') && (
          <NavSection
            icon="/images/Accounting.png"
            label="Accounting"
            expanded={Expanded}
            isOpen={OpenSections['Accounting'] || false}
            onToggle={() => toggleSection('Accounting')}
          >
            <NavChild to={`/accounting?BusinessID=${BusinessID}`} label="Dashboard" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#invoices`} label="Invoices" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#customers`} label="Customers" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#vendors`} label="Vendors" />
            <NavChild to={`/accounting?BusinessID=${BusinessID}#reports`} label="Reports" />
          </NavSection>
        )}

        <NavSection
          icon="/icons/Subscription.png"
          label="Account Settings"
          expanded={Expanded}
          isOpen={OpenSections['Account Settings'] || false}
          onToggle={() => toggleSection('Account Settings')}
        >
          <NavChild to={`/account/change-type?BusinessID=${BusinessID}`} label="Change Account Type" />
          <NavChild to={`/account/profile?BusinessID=${BusinessID}`} label="Account Profile" />
          <NavChild to={`/account/subscription?BusinessID=${BusinessID}`} label="Subscription / Billing" />
          <NavChild to={`/account/delete?BusinessID=${BusinessID}`} label="Delete Account" />
        </NavSection>

      </nav>
    </div>
  );
}
