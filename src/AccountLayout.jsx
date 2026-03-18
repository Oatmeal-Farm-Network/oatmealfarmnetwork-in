
import React, { useState, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function AccountLayout({ children, Business, BusinessID, PeopleID }) {
  const { Expanded, setExpanded, OpenSections, setOpenSections } = useAccount();
  const BT = Business?.BusinessTypeID;
  const [fields, setFields] = useState([]);
  const location = useLocation();
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) {
      navigate('/login');
    }
  }, []);

  useEffect(() => {
    if (BT === 8 && BusinessID) {
      fetch(`${API_URL}/api/fields?business_id=${BusinessID}`)
        .then(r => r.ok ? r.json() : [])
        .then(data => setFields(Array.isArray(data) ? data : []))
        .catch(() => setFields([]));
    }
  }, [BT, BusinessID, location.pathname, location.search]);

  const ToggleSection = (Label) => {
    setOpenSections(Prev => ({ ...Prev, [Label]: !Prev[Label] }));
  };

  const NavItem = ({ To, Icon, Label }) => (
    <Link
      to={To}
      className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-white/50 text-gray-700 text-sm transition-all"
    >
      <img src={Icon} alt={Label} className="w-6 h-6 shrink-0" />
      {Expanded && <span className="whitespace-nowrap">{Label}</span>}
    </Link>
  );

  const NavChild = ({ To, Label }) => (
    <Link
      to={To}
      className="flex items-center px-3 py-1.5 ml-4 rounded-lg hover:bg-white/50 text-gray-600 text-xs transition-all"
    >
      {Label}
    </Link>
  );

  const NavSection = ({ Icon, Label, children }) => {
    const IsOpen = OpenSections[Label] || false;
    return (
      <div className="mb-1">
        <button
          onClick={() => ToggleSection(Label)}
          className="w-full flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-white/50 text-gray-700 text-sm transition-all"
        >
          <img src={Icon} alt={Label} className="w-6 h-6 shrink-0" />
          {Expanded && (
            <>
              <span className="flex-grow text-left whitespace-nowrap">{Label}</span>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="text-gray-400">
                {IsOpen ? <path d="M18 15l-6-6-6 6" /> : <path d="M6 9l6 6 6-6" />}
              </svg>
            </>
          )}
        </button>
        {IsOpen && Expanded && (
          <div className="flex flex-col gap-0.5 mt-0.5">
            {children}
          </div>
        )}
      </div>
    );
  };

  // Account section uses NavSection pattern but with a fixed icon
  const IsAccountOpen = OpenSections['Account'] || false;

  return (
    <div className="min-h-screen bg-gray-50 font-sans flex flex-col">
      <Header />

      <div className="flex flex-grow">

        {/* Sidebar */}
        <div
          className={`fixed top-[72px] left-0 bottom-0 z-40 flex flex-col transition-all duration-300 ${Expanded ? 'w-52' : 'w-16'}`}
          style={{ backgroundColor: 'rgba(210, 211, 210, 0.75)', backdropFilter: 'blur(4px)' }}
        >
          {/* Toggle Button */}
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

          {/* Business Name */}
          {Expanded && (
            <div className="px-3 py-3 border-b border-gray-300/50">
              <p className="text-gray-800 font-bold text-sm truncate">{Business?.BusinessName}</p>
              <p className="text-gray-500 text-xs truncate">{Business?.BusinessType}</p>
            </div>
          )}

          {/* Nav Items */}
          <nav className="flex flex-col gap-1 p-2 flex-grow overflow-y-auto">

            {/* Account Home — expandable section */}
            <div className="mb-1">
              <div className="flex items-center gap-0 rounded-lg overflow-hidden">
                <Link
                  to={`/account?BusinessID=${BusinessID}`}
                  className="flex items-center gap-3 px-3 py-2 flex-grow hover:bg-white/50 text-gray-700 text-sm transition-all"
                >
                  <img src="/icons/Website.svg" alt="Account Home" className="w-6 h-6 shrink-0" />
                  {Expanded && <span className="whitespace-nowrap">Account Home</span>}
                </Link>
                {Expanded && (
                  <button
                    onClick={() => ToggleSection('Account')}
                    className="px-2 py-2 hover:bg-white/50 text-gray-400 transition-all"
                  >
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                      {IsAccountOpen ? <path d="M18 15l-6-6-6 6" /> : <path d="M6 9l6 6 6-6" />}
                    </svg>
                  </button>
                )}
              </div>
              {IsAccountOpen && Expanded && (
                <div className="flex flex-col gap-0.5 mt-0.5">
                  <NavChild To={`/account/profile?BusinessID=${BusinessID}`} Label="Edit Profile" />
                  <NavChild To={`/account/change-type?BusinessID=${BusinessID}`} Label="Change Account Type" />
                  <NavChild To={`/account/delete?BusinessID=${BusinessID}`} Label="Delete Account" />
                </div>
              )}
            </div>

            {[8, 10, 14, 26, 29, 31].includes(BT) && (
  <NavSection Icon="/icons/produce.webp" Label="Farm 2 Table">
    <NavChild To={`/produce/inventory?BusinessID=${BusinessID}`} Label="Produce" />
    <NavChild To={`/produce/processed-food?BusinessID=${BusinessID}`} Label="Processed Foods" />
    <NavChild To={`/produce/meat?BusinessID=${BusinessID}`} Label="Meat" />
  </NavSection>
)}

           {BT === 8 && (
          <NavSection Icon="/icons/PrecisionAg.svg" Label="Precision Ag">
            <NavChild To={`/oatsense?BusinessID=${BusinessID}`} Label="Dashboard" />
            <NavChild To={`/precision-ag/crop-detection?BusinessID=${BusinessID}`} Label="Crop Detection" />  {/* ← add this */}
            <NavChild To={`/precision-ag/fields?BusinessID=${BusinessID}`} Label="Fields" />
            <NavChild To={`/precision-ag/fields?BusinessID=${BusinessID}&view=create-field`} Label="Add Field" />
            {fields.length > 0 && (
              <>
                <div className="ml-4 mt-1 mb-0.5 text-[10px] text-gray-400 uppercase tracking-wide px-3">
                  {Expanded ? 'Your Fields' : ''}
                </div>
                {fields.map(f => (
                  <NavChild
                    key={f.fieldid || f.id}
                    To={`/precision-ag/analyses?BusinessID=${BusinessID}&FieldID=${f.fieldid || f.id}`}
                    Label={`${f.name}`}
                  />
                ))}
              </>
            )}
            <NavChild To={`/precision-ag/analyses?BusinessID=${BusinessID}`} Label="Analyses" />
          
            <NavChild To={`/oatsense/crop-rotation?BusinessID=${BusinessID}`} Label="Crop Rotation" />
            <NavChild To={`/oatsense/notes?BusinessID=${BusinessID}`} Label="Notes" />
          </NavSection>
        )}

            {BT === 8 && (
              <NavSection Icon="/icons/Livestock.svg" Label="Livestock">
                <NavChild To={`/animals?BusinessID=${BusinessID}`} Label="List Animals" />
                <NavChild To={`/animals/add?BusinessID=${BusinessID}`} Label="Add" />
                <NavChild To={`/animals/delete?BusinessID=${BusinessID}`} Label="Delete" />
                <NavChild To={`/animals/transfer?BusinessID=${BusinessID}`} Label="Transfer" />
                <NavChild To={`/animals/stats?BusinessID=${BusinessID}`} Label="Statistics" />
              </NavSection>
            )}

            <NavSection Icon="/icons/Products.svg" Label="Products">
              <NavChild To={`/products?BusinessID=${BusinessID}`} Label="List" />
              <NavChild To={`/products/add?BusinessID=${BusinessID}`} Label="Add" />
              <NavChild To={`/products/settings?BusinessID=${BusinessID}`} Label="Settings" />
            </NavSection>

            <NavSection Icon="/icons/Services.svg" Label="Services">
              <NavChild To={`/services?BusinessID=${BusinessID}`} Label="List" />
              <NavChild To={`/services/add?BusinessID=${BusinessID}`} Label="Add" />
              <NavChild To={`/services/delete?BusinessID=${BusinessID}`} Label="Delete" />
              <NavChild To={`/services/suggest-category?BusinessID=${BusinessID}`} Label="Suggest Category" />
            </NavSection>

            {[8, 30].includes(BT) && (
              <NavSection Icon="/icons/Real-Estate.svg" Label="Properties">
                <NavChild To={`/properties?BusinessID=${BusinessID}`} Label="List" />
                <NavChild To={`/properties/add?BusinessID=${BusinessID}`} Label="Add" />
              </NavSection>
            )}

            {BT === 1 && (
              <NavSection Icon="/icons/Assoc-administration-icon.svg" Label="Associations">
                <NavChild To={`/association/create?BusinessID=${BusinessID}`} Label="Create" />
                <NavChild To={`/association/delete?BusinessID=${BusinessID}`} Label="Delete" />
              </NavSection>
            )}

            <NavSection Icon="/icons/Website.svg" Label="My Website">
              <NavChild To={`/website/design?BusinessID=${BusinessID}`} Label="Graphic Design" />
              <NavChild To={`/website/home?BusinessID=${BusinessID}&PeopleID=${PeopleID}`} Label="Home Page" />
              <NavChild To={`/website/about?BusinessID=${BusinessID}&PeopleID=${PeopleID}`} Label="About Us" />
            </NavSection>

          </nav>
        </div>

        {/* Main Content */}
        <div className={`flex-grow p-6 transition-all duration-300 ${Expanded ? 'ml-52' : 'ml-16'}`}>
          {children}
        </div>

      </div>

      <Footer />
    </div>
  );
}