import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import AccountLayout from './AccountLayout';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function AccountHome() {
  const { t } = useTranslation();
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = SearchParams.get('PeopleID') ||
                   localStorage.getItem('PeopleID') ||
                   localStorage.getItem('people_id');
  const [Business, setBusiness] = useState(null);
  const [features, setFeatures] = useState(null); // null = loading
  const [Error, setError] = useState(false);

  useEffect(() => {
    if (!BusinessID) return;
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
        rows.forEach(f => { map[f.feature_key] = f; });
        setFeatures(map);
      })
      .catch(() => setFeatures({}));
  }, [BusinessID]);

  if (Error) return <div className="p-8 text-red-600">{t('account_home.error_loading')}</div>;
  if (!Business || features === null) return <div className="p-8 text-gray-500">{t('account_home.loading')}</div>;

  const Icon = ({ d, size = 24, viewBox = '0 0 24 24', fill = 'none', children }) => (
    <svg width={size} height={size} viewBox={viewBox} fill={fill} stroke="currentColor" strokeWidth="1.75" strokeLinecap="round" strokeLinejoin="round">
      {d ? <path d={d} /> : children}
    </svg>
  );

  const icons = {
    blog: (
      <Icon>
        <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/>
        <polyline points="14 2 14 8 20 8"/>
        <line x1="16" y1="13" x2="8" y2="13"/>
        <line x1="16" y1="17" x2="8" y2="17"/>
        <polyline points="10 9 9 9 8 9"/>
      </Icon>
    ),
    precisionAg: (
      <Icon>
        <path d="M12 2a10 10 0 100 20A10 10 0 0012 2z"/>
        <path d="M12 2C6 8 6 16 12 22"/>
        <path d="M12 2c6 6 6 14 0 20"/>
        <line x1="2" y1="12" x2="22" y2="12"/>
        <line x1="4" y1="7" x2="20" y2="7"/>
        <line x1="4" y1="17" x2="20" y2="17"/>
      </Icon>
    ),
    livestock: (
      <Icon viewBox="0 0 24 24">
        <path d="M20 7l-2-4H6L4 7"/>
        <path d="M4 7c0 0-1 1-1 3s1 4 1 4v5h4v-3h8v3h4v-5s1-2 1-4-1-3-1-3"/>
        <path d="M9 10h6"/>
        <circle cx="8.5" cy="8.5" r="0.5" fill="currentColor"/>
        <circle cx="15.5" cy="8.5" r="0.5" fill="currentColor"/>
      </Icon>
    ),
    farm2table: (
      <Icon>
        <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/>
        <line x1="3" y1="6" x2="21" y2="6"/>
        <path d="M16 10a4 4 0 01-8 0"/>
      </Icon>
    ),
    products: (
      <Icon>
        <path d="M21 16V8a2 2 0 00-1-1.73l-7-4a2 2 0 00-2 0l-7 4A2 2 0 003 8v8a2 2 0 001 1.73l7 4a2 2 0 002 0l7-4A2 2 0 0021 16z"/>
        <polyline points="3.27 6.96 12 12.01 20.73 6.96"/>
        <line x1="12" y1="22.08" x2="12" y2="12"/>
      </Icon>
    ),
    services: (
      <Icon>
        <circle cx="12" cy="12" r="3"/>
        <path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06a1.65 1.65 0 00-.33 1.82V9c.26.6.852.997 1.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/>
      </Icon>
    ),
    events: (
      <Icon>
        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
        <line x1="16" y1="2" x2="16" y2="6"/>
        <line x1="8" y1="2" x2="8" y2="6"/>
        <line x1="3" y1="10" x2="21" y2="10"/>
        <line x1="9" y1="15" x2="10" y2="15"/>
        <line x1="14" y1="15" x2="15" y2="15"/>
      </Icon>
    ),
    properties: (
      <Icon>
        <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
        <polyline points="9 22 9 12 15 12 15 22"/>
      </Icon>
    ),
    associations: (
      <Icon>
        <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
        <circle cx="9" cy="7" r="4"/>
        <path d="M23 21v-2a4 4 0 00-3-3.87"/>
        <path d="M16 3.13a4 4 0 010 7.75"/>
      </Icon>
    ),
    website: (
      <Icon>
        <circle cx="12" cy="12" r="10"/>
        <line x1="2" y1="12" x2="22" y2="12"/>
        <path d="M12 2a15.3 15.3 0 014 10 15.3 15.3 0 01-4 10 15.3 15.3 0 01-4-10 15.3 15.3 0 014-10z"/>
      </Icon>
    ),
    accounting: (
      <Icon>
        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
        <line x1="2" y1="9" x2="22" y2="9"/>
        <line x1="8" y1="21" x2="16" y2="21"/>
        <line x1="12" y1="17" x2="12" y2="21"/>
      </Icon>
    ),
  };

  // Show only features the API says are enabled for this business's subscription.
  // features===null means still loading; show everything to avoid flicker, then
  // the real list renders once the fetch resolves.
  const on = (key) => features === null || features[key]?.is_enabled === true;

  // Full catalogue of sections. Visibility is controlled entirely by
  // CompanySiteManagement feature flags; business-type guards have been removed.
  const ALL_SECTIONS = [
    {
      key: 'blog',
      icon: icons.blog,
      label: t('account_home.sec_blog'),
      links: [
        { to: `/blog/manage?BusinessID=${BusinessID}`, label: t('account_home.blog_manage') },
        { to: `/blog/manage?BusinessID=${BusinessID}&view=new`, label: t('account_home.blog_add_post') },
        { to: `/blog/authors/manage?BusinessID=${BusinessID}`, label: t('account_home.blog_authors') },
      ],
    },
    {
      key: 'precision_ag',
      icon: icons.precisionAg,
      label: t('account_home.sec_precision_ag'),
      links: [
        { to: `/precision-ag/fields?BusinessID=${BusinessID}`, label: t('account_home.pag_fields') },
        { to: `/precision-ag/fields?BusinessID=${BusinessID}&view=create-field`, label: t('account_home.pag_add_field') },
        { to: `/precision-ag/analyses?BusinessID=${BusinessID}`, label: t('account_home.pag_analyses') },
        { to: `/precision-ag/crop-detection?BusinessID=${BusinessID}`, label: t('account_home.pag_crop_detection') },
        { to: `/oatsense/crop-rotation?BusinessID=${BusinessID}`, label: t('account_home.pag_crop_rotation') },
        { to: `/oatsense/notes?BusinessID=${BusinessID}`, label: t('account_home.pag_field_journal') },
      ],
    },
    {
      key: 'livestock',
      icon: icons.livestock,
      label: t('account_home.sec_livestock'),
      links: [
        { to: `/animals?BusinessID=${BusinessID}`, label: t('account_home.lv_list') },
        { to: `/animals/add?BusinessID=${BusinessID}`, label: t('account_home.lv_add') },
        { to: `/animals/transfer?BusinessID=${BusinessID}`, label: t('account_home.lv_transfer') },
        { to: `/animals/packages?BusinessID=${BusinessID}`, label: t('account_home.lv_packages') },
        { to: `/animals/stats?BusinessID=${BusinessID}`, label: t('account_home.lv_stats') },
      ],
    },
    {
      key: 'farm_2_table',
      icon: icons.farm2table,
      label: t('account_home.sec_farm_2_table'),
      links: [
        { to: `/seller/orders?BusinessID=${BusinessID}`, label: t('account_home.f2t_orders') },
        { to: `/produce/inventory?BusinessID=${BusinessID}`, label: t('account_home.f2t_produce') },
        { to: `/produce/processed-food?BusinessID=${BusinessID}`, label: t('account_home.f2t_processed') },
        { to: `/produce/meat?BusinessID=${BusinessID}`, label: t('account_home.f2t_meat') },
        { to: `/account/stripe-connect?BusinessID=${BusinessID}`, label: t('account_home.f2t_stripe') },
      ],
    },
    {
      key: 'products',
      icon: icons.products,
      label: t('account_home.sec_products'),
      links: [
        { to: `/marketplace/products`, label: t('account_home.prod_browse') },
        { to: `/products?BusinessID=${BusinessID}`, label: t('account_home.prod_my') },
        { to: `/products/settings?BusinessID=${BusinessID}`, label: t('account_home.prod_settings') },
      ],
    },
    {
      key: 'services',
      icon: icons.services,
      label: t('account_home.sec_services'),
      links: [
        { to: `/services/directory`, label: t('account_home.svc_browse') },
        { to: `/services?BusinessID=${BusinessID}`, label: t('account_home.svc_my') },
        { to: `/services/add?BusinessID=${BusinessID}`, label: t('account_home.svc_add') },
        { to: `/services/suggest-category?BusinessID=${BusinessID}`, label: t('account_home.svc_suggest') },
      ],
    },
    {
      key: 'events',
      icon: icons.events,
      label: t('account_home.sec_events'),
      links: [
        { to: `/events`, label: t('account_home.ev_browse') },
        { to: `/events/manage?BusinessID=${BusinessID}`, label: t('account_home.ev_my') },
        { to: `/events/my-registrations?BusinessID=${BusinessID}`, label: t('account_home.ev_registrations') },
      ],
    },
    {
      key: 'properties',
      icon: icons.properties,
      label: t('account_home.sec_properties'),
      links: [
        { to: `/properties?BusinessID=${BusinessID}`, label: t('account_home.prop_list') },
        { to: `/properties/add?BusinessID=${BusinessID}`, label: t('account_home.prop_add') },
      ],
    },
    {
      key: 'associations',
      icon: icons.associations,
      label: t('account_home.sec_associations'),
      links: [
        { to: `/association/create?BusinessID=${BusinessID}`, label: t('account_home.assoc_create') },
        { to: `/association/delete?BusinessID=${BusinessID}`, label: t('account_home.assoc_delete') },
      ],
    },
    {
      key: 'my_website',
      icon: icons.website,
      label: t('account_home.sec_my_website'),
      links: [
        { to: `/website/builder?BusinessID=${BusinessID}&view=design`, label: t('account_home.web_design') },
        { to: `/website/builder?BusinessID=${BusinessID}&view=settings`, label: t('account_home.web_settings') },
      ],
    },
    {
      key: 'accounting',
      icon: icons.accounting,
      label: t('account_home.sec_accounting'),
      links: [
        { to: `/accounting?BusinessID=${BusinessID}`, label: t('account_home.acct_dashboard') },
        { to: `/accounting?BusinessID=${BusinessID}#invoices`, label: t('account_home.acct_invoices') },
        { to: `/accounting?BusinessID=${BusinessID}#customers`, label: t('account_home.acct_customers') },
        { to: `/accounting?BusinessID=${BusinessID}#vendors`, label: t('account_home.acct_vendors') },
        { to: `/accounting?BusinessID=${BusinessID}#reports`, label: t('account_home.acct_reports') },
      ],
    },
  ];

  // Respect the sort_order coming from the DB where available
  const dbOrder = Object.fromEntries(
    Object.entries(features || {}).map(([k, v]) => [k, v?.sort_order ?? 999])
  );

  const sections = ALL_SECTIONS
    .filter(s => on(s.key))
    .sort((a, b) => (dbOrder[a.key] ?? 999) - (dbOrder[b.key] ?? 999));

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle={t('account_home.page_title')}
      breadcrumbs={[
        { label: t('nav.dashboard'), to: '/dashboard' },
        { label: Business.BusinessName || t('account_home.page_title') },
      ]}
    >
      <div className="max-w-full mx-auto space-y-6">

        {/* Account Info Card */}
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <h2 className="text-2xl font-bold text-green-700 mb-4 border-b-2 border-green-200 pb-3">
                {Business.BusinessName}
              </h2>
              <p className="text-sm text-gray-700 mb-1">{t('account_home.label_name')} <strong>{Business.BusinessName}</strong></p>
              <p className="text-sm text-gray-700 mb-1">{t('account_home.label_type')} <strong>{Business.BusinessType}</strong></p>
              <Link to={`/account/change-type?BusinessID=${BusinessID}`} className="text-xs text-[#819360] hover:underline">
                {t('account_home.change_type')}
              </Link>
              <p className="text-sm text-gray-700 mt-3 mb-1">{t('account_home.label_sub_level')} <strong>{Business.SubscriptionLevel}</strong></p>
              <p className="text-sm text-gray-700 mb-1">{t('account_home.label_sub_ends')} <strong>{Business.SubscriptionEndDate || t('account_home.not_set')}</strong></p>
              {Business.FavoriteAssociationName ? (
                <p className="text-sm text-gray-700 mt-1">
                  {t('account_home.label_fav_assoc')} <strong>{Business.FavoriteAssociationName}</strong>
                </p>
              ) : (
                <p className="text-sm text-gray-500 mt-1">{t('account_home.fav_assoc_not_set')}</p>
              )}
              <Link to={`/account/associations?BusinessID=${BusinessID}`} className="text-xs text-[#819360] hover:underline">
                {t('account_home.set_fav_assoc')}
              </Link>
            </div>
            <div className="flex flex-col gap-2 pt-1 md:pt-8">
              <Link to={`/account/profile?BusinessID=${BusinessID}`} className="text-sm text-[#3D6B34] hover:underline">
                {t('account_home.link_profile')}
              </Link>
              <Link to={`/account/subscription?BusinessID=${BusinessID}`} className="text-sm text-[#3D6B34] hover:underline">
                {t('account_home.link_billing')}
              </Link>
              <Link to={`/account/delete?BusinessID=${BusinessID}`} className="text-sm text-red-600 hover:underline">
                {t('account_home.link_delete')}
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
                  <td className="w-16 min-w-[64px] px-4 py-4 align-top">
                    <div className="w-10 h-10 rounded-lg bg-[#f0f5e8] flex items-center justify-center text-[#3D6B34]">
                      {section.icon}
                    </div>
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