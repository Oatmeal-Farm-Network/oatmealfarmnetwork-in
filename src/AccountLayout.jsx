import React from 'react';
import { Link } from 'react-router-dom';
import HeaderGated from './HeaderGated';
import Footer from './Footer';
import { useAccount } from './AccountContext';

export default function AccountLayout({ children, Business, BusinessID, PeopleID }) {
  const { Expanded, setExpanded, OpenSections, setOpenSections } = useAccount();
  const BT = Business?.BusinessTypeID;

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
              <span className="text-gray-500 text-xs">{IsOpen ? '▲' : '▼'}</span>
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

  return (
    <div className="min-h-screen bg-gray-50 font-sans flex flex-col">
      <HeaderGated />

      <div className="flex flex-grow">

        {/* Sidebar - fixed, overlays footer */}
        <div
          className={`fixed top-[72px] left-0 bottom-0 z-40 flex flex-col transition-all duration-300 ${Expanded ? 'w-52' : 'w-16'}`}
          style={{ backgroundColor: 'rgba(210, 211, 210, 0.75)', backdropFilter: 'blur(4px)' }}
        >
          {/* Toggle Button */}
          <button
            onClick={() => setExpanded(!Expanded)}
            className="flex items-center justify-center py-3 text-gray-600 hover:bg-white/30 transition-colors border-b border-gray-300/50"
          >
            {Expanded ? '◀' : '▶'}
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

            <NavItem
              To={`/account?BusinessID=${BusinessID}`}
              Icon="/icons/Website.svg"
              Label="Account Home"
            />

            {[8, 10, 14, 26, 29, 31].includes(BT) && (
              <NavItem
                To={`/produce/inventory?BusinessID=${BusinessID}`}
                Icon="/icons/produce.webp"
                Label="Produce"
              />
            )}

            {BT === 8 && (
              <NavSection Icon="/icons/PrecisionAg.svg" Label="Precision Ag">
                <NavChild To={`/oatsense?BusinessID=${BusinessID}`} Label="Dashboard" />
                <NavChild To={`/precision-ag/fields?BusinessID=${BusinessID}`} Label="Fields" />
                <NavChild To={`/precision-ag/add?BusinessID=${BusinessID}`} Label="Add Field" />
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

        {/* Main Content - padded to clear sidebar */}
        <div className={`flex-grow p-6 transition-all duration-300 ${Expanded ? 'ml-52' : 'ml-16'}`}>
          {children}
        </div>

      </div>

      <Footer />
    </div>
  );
}