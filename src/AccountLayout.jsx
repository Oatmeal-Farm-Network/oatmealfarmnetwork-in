import React, { useState, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function NavItem({ to, icon, label, expanded }) {
  return (
    <Link
      to={to}
      className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-white/50 text-gray-700 text-sm transition-all"
    >
      <img src={icon} alt={label} className="w-6 h-6 shrink-0" />
      {expanded && <span className="whitespace-nowrap">{label}</span>}
    </Link>
  );
}

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
            <span className="flex-grow text-left whitespace-nowrap">{label}</span>
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

export default function AccountLayout({ children, Business, BusinessID, PeopleID }) {
  const { Expanded, setExpanded, OpenSections, setOpenSections } = useAccount();
  const BT = Business?.BusinessTypeID;
  const [fields, setFields] = useState([]);
  const [websiteSlug, setWebsiteSlug] = useState(null);
  const location = useLocation();
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) {
      navigate('/login');
    }
  }, [navigate]);

  useEffect(() => {
    if (BT === 8 && BusinessID) {
      fetch(`${API_URL}/api/fields?business_id=${BusinessID}`)
        .then(r => r.ok ? r.json() : [])
        .then(data => setFields(Array.isArray(data) ? data : []))
        .catch(() => setFields([]));
    }
  }, [BT, BusinessID]);

  useEffect(() => {
    if (!BusinessID) return;
    fetch(`${API_URL}/api/website/site?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : null)
      .then(site => {
        if (!site) return;
        setWebsiteSlug(site.slug);
      })
      .catch(() => {});
  }, [BusinessID]);

  // Auto-expand "My Website" whenever the user is on the website builder
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
    <div className="min-h-screen bg-gray-50 font-sans flex flex-col">
      <Header />

      <div className="flex flex-grow">
        <div
          className={`fixed top-[72px] left-0 bottom-0 z-40 flex flex-col transition-all duration-300 ${Expanded ? 'w-52' : 'w-16'}`}
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

          <nav className="flex flex-col gap-1 p-2 flex-grow overflow-y-auto">

            {/* Dashboard */}
            <div className="mb-1">
              <div className="flex items-center rounded-lg hover:bg-white/50 transition-all">
                <Link
                  to="/dashboard"
                  className="flex items-center gap-3 px-3 py-2 text-gray-700 text-sm flex-1 min-w-0"
                >
                  <img src="/icons/Website.svg" alt="Dashboard" className="w-6 h-6 shrink-0" />
                  {Expanded && <span className="flex-grow text-left whitespace-nowrap">Dashboard</span>}
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
                  <NavChild to={`/account/change-type?BusinessID=${BusinessID}`} label="Change Account Type" />
                  <NavChild to={`/account/delete?BusinessID=${BusinessID}`} label="Delete Account" />
                </div>
              )}
            </div>

            {BT === 8 && (
              <NavSection
                icon="/icons/PrecisionAg.svg"
                label="Precision Ag"
                expanded={Expanded}
                isOpen={OpenSections['Precision Ag'] || false}
                onToggle={() => toggleSection('Precision Ag')}
              >
                <NavChild to={`/precision-ag/crop-detection?BusinessID=${BusinessID}`} label="Crop Detection" />
                <NavChild to={`/precision-ag/fields?BusinessID=${BusinessID}`} label="Fields" />
                <NavChild to={`/precision-ag/fields?BusinessID=${BusinessID}&view=create-field`} label="Add Field" />
                {fields.length > 0 && (
                  <>
                    <div className="ml-4 mt-1 mb-0.5 text-[10px] text-gray-400 uppercase tracking-wide px-3">
                      {Expanded ? 'Your Fields' : ''}
                    </div>
                    {fields.map((field) => (
                      <NavChild
                        key={field.fieldid || field.id}
                        to={`/precision-ag/analyses?BusinessID=${BusinessID}&FieldID=${field.fieldid || field.id}`}
                        label={field.name}
                      />
                    ))}
                  </>
                )}
                <NavChild to={`/precision-ag/analyses?BusinessID=${BusinessID}`} label="Analyses" />
                <NavChild to={`/oatsense/crop-rotation?BusinessID=${BusinessID}`} label="Crop Rotation" />
                <NavChild to={`/oatsense/notes?BusinessID=${BusinessID}`} label="Notes" />
              </NavSection>
            )}

            {/* Farm 2 Table — food/produce sellers only */}
            {[8, 9, 10, 11, 14, 19, 22, 23, 26, 29, 31, 33, 34].includes(BT) && (
              <NavSection
                icon="/icons/produce.webp"
                label="Farm 2 Table"
                expanded={Expanded}
                isOpen={OpenSections['Farm 2 Table'] || false}
                onToggle={() => toggleSection('Farm 2 Table')}
              >
                <NavChild to={`/seller/orders?BusinessID=${BusinessID}`} label="Incoming Orders" />
                {[8, 10, 14, 26, 29, 31, 34].includes(BT) && (
                  <NavChild to={`/produce/inventory?BusinessID=${BusinessID}`} label="Produce" />
                )}
                {[8, 10, 11, 14, 26, 29, 31, 33, 34].includes(BT) && (
                  <NavChild to={`/produce/processed-food?BusinessID=${BusinessID}`} label="Processed Foods" />
                )}
                {[8, 10, 14, 19, 22, 23, 26, 29].includes(BT) && (
                  <NavChild to={`/produce/meat?BusinessID=${BusinessID}`} label="Meat" />
                )}
              </NavSection>
            )}

            {BT === 8 && (
              <NavSection
                icon="/icons/Livestock.svg"
                label="Livestock"
                expanded={Expanded}
                isOpen={OpenSections.Livestock || false}
                onToggle={() => toggleSection('Livestock')}
              >
                <NavChild to={`/animals?BusinessID=${BusinessID}`} label="List Animals" />
                <NavChild to={`/animals/add?BusinessID=${BusinessID}`} label="Add" />
                <NavChild to={`/animals/delete?BusinessID=${BusinessID}`} label="Delete" />
                <NavChild to={`/animals/transfer?BusinessID=${BusinessID}`} label="Transfer" />
                <NavChild to={`/animals/stats?BusinessID=${BusinessID}`} label="Statistics" />
              </NavSection>
            )}

            {/* Products — physical product sellers */}
            {[8, 10, 11, 14, 15, 16, 18, 19, 24, 25, 26, 29, 31, 33, 34].includes(BT) && (
              <NavSection
                icon="/icons/Products.svg"
                label="Products"
                expanded={Expanded}
                isOpen={OpenSections.Products || false}
                onToggle={() => toggleSection('Products')}
              >
                <NavChild to="/marketplace/products" label="Browse Marketplace" />
                <NavChild to={`/products/settings?BusinessID=${BusinessID}`} label="Settings" />
              </NavSection>
            )}

            <NavSection
              icon="/icons/Services.svg"
              label="Services"
              expanded={Expanded}
              isOpen={OpenSections.Services || false}
              onToggle={() => toggleSection('Services')}
            >
              <NavChild to="/services/directory" label="Browse Services" />
              {[1, 8, 9, 10, 17, 18, 20, 21, 27, 28, 32].includes(BT) && (
                <>
                  <NavChild to={`/services?BusinessID=${BusinessID}`} label="My Services" />
                  <NavChild to={`/services/add?BusinessID=${BusinessID}`} label="Add" />
                  <NavChild to={`/services/suggest-category?BusinessID=${BusinessID}`} label="Suggest Category" />
                </>
              )}
            </NavSection>

            {/* Events */}
            <NavSection
              icon="/icons/Assoc-events-icon.svg"
              label="Events"
              expanded={Expanded}
              isOpen={OpenSections.Events || false}
              onToggle={() => toggleSection('Events')}
            >
              <NavChild to="/events" label="Browse Events" />
              <NavChild to={`/events/manage?BusinessID=${BusinessID}`} label="My Events" />
              <NavChild to={`/events/my-registrations?BusinessID=${BusinessID}`} label="My Registrations" />
            </NavSection>

            {[8, 30].includes(BT) && (
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

            {BT === 1 && (
              <NavSection
                icon="/icons/Assoc-administration-icon.svg"
                label="Associations"
                expanded={Expanded}
                isOpen={OpenSections.Associations || false}
                onToggle={() => toggleSection('Associations')}
              >
                <NavChild to={`/association/create?BusinessID=${BusinessID}`} label="Create" />
                <NavChild to={`/association/delete?BusinessID=${BusinessID}`} label="Delete" />
              </NavSection>
            )}

            <NavSection
              icon="/icons/Website.svg"
              label="My Website"
              expanded={Expanded}
              isOpen={OpenSections['My Website'] || false}
              onToggle={() => toggleSection('My Website')}
            >
              <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=manage-pages`} label="Dashboard" />
              <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=design`} label="Design" />
              <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=settings`} label="Settings" />
              <NavChild to={`/website/builder?BusinessID=${BusinessID}&view=delete`} label="Delete Website" />
              {websiteSlug && (
                <NavChild to={`/sites/${websiteSlug}`} label="View Live Site ↗" />
              )}
            </NavSection>

            {/* Settings */}
            <NavSection
              icon="/icons/Gears.webp"
              label="Settings"
              expanded={Expanded}
              isOpen={OpenSections['Settings'] || false}
              onToggle={() => toggleSection('Settings')}
            >
              <NavChild to={`/account/audio-settings?BusinessID=${BusinessID}`} label="🎙 Audio Settings" />
            </NavSection>

          </nav>
        </div>

        <div className={`flex-grow p-6 transition-all duration-300 ${Expanded ? 'ml-52' : 'ml-16'}`}>
          {children}
        </div>
      </div>

      <Footer />
    </div>
  );
}