import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function AccountHome() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const [Business, setBusiness] = useState(null);
  const [Error, setError] = useState(false);

  useEffect(() => {
    fetch(`${API_URL}/auth/account-home?BusinessID=${BusinessID}`)
      .then(Res => Res.json())
      .then(Data => setBusiness(Data))
      .catch(Err => {
        console.error('Error fetching account:', Err);
        setError(true);
      });
  }, [BusinessID]);

  if (Error) return <div className="p-8 text-red-600">Error loading account.</div>;
  if (!Business) return <div className="p-8 text-gray-500">Loading...</div>;

  const BT = Business.BusinessTypeID;

  // Sections shown based on BusinessTypeID
  const sections = [

    // Precision Ag — BT 8
    BT === 8 && {
      icon: '/icons/PrecisionAg.svg',
      label: 'Precision Ag',
      links: [
        { to: `/oatsense?BusinessID=${BusinessID}`, label: 'Dashboard' },
        { to: `/precision-ag/fields?BusinessID=${BusinessID}`, label: 'Fields' },
        { to: `/precision-ag/fields?BusinessID=${BusinessID}&view=create-field`, label: 'Add Field' },
        { to: `/precision-ag/analyses?BusinessID=${BusinessID}`, label: 'Analyses' },
      ],
    },

    // Livestock — BT 8
    BT === 8 && {
      icon: '/icons/Livestock.svg',
      label: 'Livestock',
      links: [
        { to: `/animals?BusinessID=${BusinessID}`, label: 'List of Animals' },
        { to: `/animals/add?BusinessID=${BusinessID}`, label: 'Add' },
        { to: `/animals/delete?BusinessID=${BusinessID}`, label: 'Delete' },
        { to: `/animals/transfer?BusinessID=${BusinessID}`, label: 'Transfer' },
        { to: `/animals/stats?BusinessID=${BusinessID}`, label: 'Statistics' },
      ],
    },

    // Produce — BT 8, 10, 14, 26, 29, 31
    [8, 10, 14, 26, 29, 31].includes(BT) && {
      icon: '/icons/produce.webp',
      label: 'Produce',
      links: [
        { to: `/produce/inventory?BusinessID=${BusinessID}`, label: 'Inventory' },
        { to: `/produce/add?BusinessID=${BusinessID}`, label: 'Add' },
        { to: `/produce/orders?BusinessID=${BusinessID}`, label: 'Orders' },
      ],
    },

    // Products — all
    {
      icon: '/icons/Products.svg',
      label: 'Products',
      links: [
        { to: `/products?BusinessID=${BusinessID}`, label: 'List' },
        { to: `/products/add?BusinessID=${BusinessID}`, label: 'Add' },
        { to: `/products/settings?BusinessID=${BusinessID}`, label: 'Settings' },
      ],
    },

    // Services — all
    {
      icon: '/icons/Services.svg',
      label: 'Services',
      links: [
        { to: `/services?BusinessID=${BusinessID}`, label: 'List' },
        { to: `/services/add?BusinessID=${BusinessID}`, label: 'Add' },
        { to: `/services/delete?BusinessID=${BusinessID}`, label: 'Delete' },
        { to: `/services/suggest-category?BusinessID=${BusinessID}`, label: 'Suggest Category' },
      ],
    },

    // Properties — BT 8, 30
    [8, 30].includes(BT) && {
      icon: '/icons/Real-Estate.svg',
      label: 'Properties',
      links: [
        { to: `/properties?BusinessID=${BusinessID}`, label: 'List of Properties' },
        { to: `/properties/add?BusinessID=${BusinessID}`, label: 'Add a Property' },
      ],
    },

    // Associations — BT 1
    BT === 1 && {
      icon: '/icons/Assoc-administration-icon.svg',
      label: 'Associations',
      links: [
        { to: `/association/create?BusinessID=${BusinessID}`, label: 'Create Account' },
        { to: `/association/delete?BusinessID=${BusinessID}`, label: 'Delete Account' },
      ],
    },

    // My Website — all
    {
      icon: '/icons/Website.svg',
      label: 'My Website',
      links: [
        { to: `/website/design?BusinessID=${BusinessID}`, label: 'Graphic Design (colors, fonts, etc.)' },
        { to: `/website/home?BusinessID=${BusinessID}&PeopleID=${PeopleID}`, label: 'Home Page' },
        { to: `/website/about?BusinessID=${BusinessID}&PeopleID=${PeopleID}`, label: 'About Us Page' },
      ],
    },

  ].filter(Boolean);

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="max-w-4xl mx-auto space-y-6">

        {/* Account Info Card */}
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <h2 className="text-2xl font-bold text-green-700 mb-4 border-b-2 border-green-200 pb-3">
                {Business.BusinessName}
              </h2>
              <p className="text-sm text-gray-700 mb-1">Account Name: <strong>{Business.BusinessName}</strong></p>
              <p className="text-sm text-gray-700 mb-1">Account Type: <strong>{Business.BusinessType}</strong></p>
              <Link to={`/account/change-type?BusinessID=${BusinessID}`} className="text-xs text-[#819360] hover:underline">
                Change Account Type
              </Link>
              <p className="text-sm text-gray-700 mt-3 mb-1">Subscription Level: <strong>{Business.SubscriptionLevel}</strong></p>
              <p className="text-sm text-gray-700 mb-1">Subscription Ends: <strong>{Business.SubscriptionEndDate || 'Not Set'}</strong></p>
              {Business.FavoriteAssociationName ? (
                <p className="text-sm text-gray-700 mt-1">
                  Favorite Association: <strong>{Business.FavoriteAssociationName}</strong>
                </p>
              ) : (
                <p className="text-sm text-gray-500 mt-1">Favorite Association: Not Set</p>
              )}
              <Link to={`/account/associations?BusinessID=${BusinessID}`} className="text-xs text-[#819360] hover:underline">
                Set Favorite Association
              </Link>
            </div>
            <div className="flex flex-col gap-2 pt-1 md:pt-8">
              <Link to={`/account/profile?BusinessID=${BusinessID}`} className="text-sm text-[#3D6B34] hover:underline">
                Account Profile
              </Link>
              <Link to={`/account/renew?BusinessID=${BusinessID}`} className="text-sm text-[#3D6B34] hover:underline">
                Renew / Upgrade Membership
              </Link>
              <Link to={`/account/delete?BusinessID=${BusinessID}`} className="text-sm text-red-600 hover:underline">
                Delete Account
              </Link>
            </div>
          </div>
        </div>

        {/* Sections Table */}
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
          <table className="w-full">
            <tbody>
              {sections.map((section, i) => (
                <tr key={section.label} className={i % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                  <td className="w-20 min-w-[80px] px-4 py-4 align-top">
                    <img
                      src={section.icon}
                      alt={section.label}
                      className="w-10 h-10"
                      loading="lazy"
                    />
                  </td>
                  <td className="px-4 py-4">
                    <p className="font-semibold text-gray-800 mb-2">{section.label}</p>
                    <div className="flex flex-wrap gap-x-4 gap-y-1">
                      {section.links.map(link => (
                        <Link
                          key={link.to}
                          to={link.to}
                          className="text-sm text-[#3D6B34] hover:underline"
                        >
                          {link.label}
                        </Link>
                      ))}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

      </div>
    </AccountLayout>
  );
}