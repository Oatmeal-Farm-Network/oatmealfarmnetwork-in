import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function AccountHome() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const [Business, setBusiness] = useState(null);
  const [features, setFeatures] = useState(null); // null = loading
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

  useEffect(() => {
    if (!BusinessID) return;
    fetch(`${API_URL}/api/company/features?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : [])
      .then(rows => {
        const map = {};
        rows.forEach(f => { map[f.feature_key] = f.is_enabled; });
        setFeatures(map);
      })
      .catch(() => setFeatures({}));
  }, [BusinessID]);

  if (Error) return <div className="p-8 text-red-600">Error loading account.</div>;
  if (!Business || features === null) return <div className="p-8 text-gray-500">Loading...</div>;

  const BT = Business.BusinessTypeID;
  // null = still loading (fail-open); otherwise check the map
  const on = (key) => features === null || features[key] === true;

  // Sections gated by BOTH subscription feature AND business type where applicable
  const sections = [

    on('blog') && {
      icon: '/icons/Blog.png',
      label: 'Blog',
      links: [
        { to: `/blog/manage?BusinessID=${BusinessID}`, label: 'Manage Blog' },
        { to: `/blog/manage?BusinessID=${BusinessID}&view=new`, label: 'Add Post' },
        { to: `/blog/authors/manage?BusinessID=${BusinessID}`, label: 'Authors' },
      ],
    },

    // Precision Ag — Farm/Ranch only
    on('precision_ag') && BT === 8 && {
      icon: '/icons/PrecisionAg.svg',
      label: 'Precision Ag',
      links: [
        { to: `/precision-ag/fields?BusinessID=${BusinessID}`, label: 'Fields' },
        { to: `/precision-ag/fields?BusinessID=${BusinessID}&view=create-field`, label: 'Add Field' },
        { to: `/precision-ag/analyses?BusinessID=${BusinessID}`, label: 'Analyses' },
        { to: `/precision-ag/crop-detection?BusinessID=${BusinessID}`, label: 'Crop Detection' },
        { to: `/oatsense/crop-rotation?BusinessID=${BusinessID}`, label: 'Crop Rotation' },
        { to: `/oatsense/notes?BusinessID=${BusinessID}`, label: 'Field Journal' },
      ],
    },

    // Livestock
    on('livestock') && {
      icon: '/icons/Livestock.svg',
      label: 'Livestock',
      links: [
        { to: `/animals?BusinessID=${BusinessID}`, label: 'List Animals' },
        { to: `/animals/add?BusinessID=${BusinessID}`, label: 'Add' },
        { to: `/animals/transfer?BusinessID=${BusinessID}`, label: 'Transfer' },
        { to: `/animals/stats?BusinessID=${BusinessID}`, label: 'Statistics' },
      ],
    },

    // Farm 2 Table — food/produce sellers
    on('farm_2_table') && [8, 9, 10, 11, 14, 19, 22, 23, 26, 29, 31, 33, 34].includes(BT) && {
      icon: '/icons/produce.webp',
      label: 'Farm 2 Table',
      links: [
        { to: `/seller/orders?BusinessID=${BusinessID}`, label: 'Incoming Orders' },
        ...[8, 10, 14, 26, 29, 31, 34].includes(BT)
          ? [{ to: `/produce/inventory?BusinessID=${BusinessID}`, label: 'Produce Inventory' }]
          : [],
        ...[8, 10, 11, 14, 26, 29, 31, 33, 34].includes(BT)
          ? [{ to: `/produce/processed-food?BusinessID=${BusinessID}`, label: 'Processed Foods' }]
          : [],
        ...[8, 10, 14, 19, 22, 23, 26, 29].includes(BT)
          ? [{ to: `/produce/meat?BusinessID=${BusinessID}`, label: 'Meat' }]
          : [],
      ],
    },

    // Products — physical product sellers
    on('products') && [8, 10, 11, 14, 15, 16, 18, 19, 24, 25, 26, 29, 31, 33, 34].includes(BT) && {
      icon: '/icons/Products.svg',
      label: 'Products',
      links: [
        { to: `/marketplace/products`, label: 'Browse Marketplace' },
        { to: `/products/settings?BusinessID=${BusinessID}`, label: 'Settings' },
      ],
    },

    // Services — service providers manage; all can browse
    on('services') && {
      icon: '/icons/Services.svg',
      label: 'Services',
      links: [
        { to: `/services/directory`, label: 'Browse Directory' },
        ...[1, 8, 9, 10, 17, 18, 20, 21, 27, 28, 32].includes(BT)
          ? [
              { to: `/services?BusinessID=${BusinessID}`, label: 'My Services' },
              { to: `/services/add?BusinessID=${BusinessID}`, label: 'Add Service' },
              { to: `/services/suggest-category?BusinessID=${BusinessID}`, label: 'Suggest Category' },
            ]
          : [],
      ],
    },

    // Events — all
    on('events') && {
      icon: '/icons/Assoc-events-icon.svg',
      label: 'Events',
      links: [
        { to: `/events`, label: 'Browse Events' },
        { to: `/events/manage?BusinessID=${BusinessID}`, label: 'My Events' },
        { to: `/events/my-registrations?BusinessID=${BusinessID}`, label: 'My Registrations' },
      ],
    },

    // Properties — Farm/Ranch and Real Estate Agents
    on('properties') && [8, 30].includes(BT) && {
      icon: '/icons/Real-Estate.svg',
      label: 'Properties',
      links: [
        { to: `/properties?BusinessID=${BusinessID}`, label: 'List Properties' },
        { to: `/properties/add?BusinessID=${BusinessID}`, label: 'Add Property' },
      ],
    },

    // Associations — Agricultural Associations only
    on('associations') && BT === 1 && {
      icon: '/icons/Assoc-administration-icon.svg',
      label: 'Associations',
      links: [
        { to: `/association/create?BusinessID=${BusinessID}`, label: 'Create' },
        { to: `/association/delete?BusinessID=${BusinessID}`, label: 'Delete' },
      ],
    },

    // My Website — all
    on('my_website') && {
      icon: '/icons/Website.svg',
      label: 'My Website',
      links: [
        { to: `/website/builder?BusinessID=${BusinessID}&view=design`, label: 'Design' },
        { to: `/website/builder?BusinessID=${BusinessID}&view=settings`, label: 'Settings (& Delete)' },
      ],
    },

    // Accounting — all businesses with AccessLevelID >= 3
    {
      icon: '/icons/accounting.svg',
      label: 'Accounting',
      links: [
        { to: `/accounting?BusinessID=${BusinessID}`, label: 'Dashboard' },
        { to: `/accounting?BusinessID=${BusinessID}#invoices`, label: 'Invoices' },
        { to: `/accounting?BusinessID=${BusinessID}#customers`, label: 'Customers' },
        { to: `/accounting?BusinessID=${BusinessID}#vendors`, label: 'Vendors' },
        { to: `/accounting?BusinessID=${BusinessID}#reports`, label: 'Reports' },
      ],
    },

  ].filter(Boolean);

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Account Home">
      <div className="max-w-full mx-auto space-y-6">

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