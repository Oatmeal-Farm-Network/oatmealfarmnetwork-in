import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
const IcoUsers = () => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>;
const IcoEdit  = () => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>;
const IcoDel   = () => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>;
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';

function buildServiceLinks(businessId, features, t) {
  if (!features) return null;
  const links = [];
  const on = (key) => features[key] === true;

  if (on('blog'))          links.push({ label: t('dashboard.svc_blog'),              to: `/blog/manage?BusinessID=${businessId}` });
  if (on('precision_ag'))  links.push({ label: t('dashboard.svc_precision_ag'),      to: `/precision-ag/fields?BusinessID=${businessId}` });
  if (on('farm_2_table'))  links.push({ label: t('dashboard.svc_farm_2_table'),      to: `/seller/orders?BusinessID=${businessId}` });
  if (on('restaurant_sourcing')) links.push({ label: t('dashboard.svc_restaurant'), to: '/marketplaces/farm-to-table' });
  if (on('livestock'))     links.push({ label: t('dashboard.svc_livestock'),         to: `/animals?BusinessID=${businessId}` });
  if (on('products'))      links.push({ label: t('dashboard.svc_products'),          to: `/products?BusinessID=${businessId}` });
  if (on('services'))      links.push({ label: t('dashboard.svc_services'),          to: `/services?BusinessID=${businessId}` });
  if (on('events'))        links.push({ label: t('dashboard.svc_events'),            to: `/events/manage?BusinessID=${businessId}` });
  if (on('properties'))    links.push({ label: t('dashboard.svc_properties'),        to: `/properties?BusinessID=${businessId}` });
  if (on('associations'))  links.push({ label: t('dashboard.svc_associations'),      to: `/association/create?BusinessID=${businessId}` });
  if (on('my_website'))    links.push({ label: t('dashboard.svc_my_website'),        to: `/website/builder?BusinessID=${businessId}&view=manage-pages` });
  if (on('accounting'))    links.push({ label: t('dashboard.svc_accounting'),        to: `/accounting?BusinessID=${businessId}` });
  if (on('testimonials'))  links.push({ label: t('dashboard.svc_testimonials'),      to: `/testimonials/manage?BusinessID=${businessId}` });
  if (on('chef_dashboard'))links.push({ label: t('dashboard.svc_chef_dashboard'),   to: `/chef?BusinessID=${businessId}` });
  if (on('pairsley'))      links.push({ label: t('dashboard.svc_pairsley'),          to: `/platform/pairsley?BusinessID=${businessId}` });
  if (on('rosemarie'))     links.push({ label: t('dashboard.svc_rosemarie'),         to: `/platform/rosemarie?BusinessID=${businessId}` });
  if (on('provenance'))       links.push({ label: t('dashboard.svc_provenance'),        to: `/provenance/${businessId}` });
  if (on('cold_chain'))       links.push({ label: 'Cold Chain Tracking',                to: `/cold-chain?BusinessID=${businessId}` });
  if (on('farmer_settlement'))links.push({ label: 'Farmer Settlement',                  to: `/farmer-settlement?BusinessID=${businessId}` });
  return links;
}

export default function Dashboard() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const API_URL = import.meta.env.VITE_API_URL;
  const { setBusinesses: setContextBusinesses } = useAccount();
  const [user, setUser] = useState(null);
  const [businesses, setBusinesses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [featuresByBusiness, setFeaturesByBusiness] = useState({});
  const [confirmDelete, setConfirmDelete] = useState(null); // { BusinessID, BusinessName }
  const [deleting, setDeleting] = useState(false);
  const [deleteError, setDeleteError] = useState(null);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }

    const peopleId = localStorage.getItem('people_id');
    setUser({
      firstName: localStorage.getItem('first_name'),
      lastName: localStorage.getItem('last_name'),
      peopleId,
      accessLevel: parseInt(localStorage.getItem('access_level') || '0'),
    });

    if (peopleId) {
      fetch(`${API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
        .then(r => r.json())
        .then(data => {
          const list = Array.isArray(data) ? data : [];
          setBusinesses(list);
          setContextBusinesses(list);
        })
        .catch(() => setBusinesses([]))
        .finally(() => setLoading(false));
    } else {
      setLoading(false);
    }
  }, [navigate]);

  useEffect(() => {
    if (!businesses.length) return;
    businesses.forEach(b => {
      fetch(`${API_URL}/api/company/features?business_id=${b.BusinessID}`)
        .then(r => r.ok ? r.json() : [])
        .then(rows => {
          const map = {};
          (Array.isArray(rows) ? rows : []).forEach(f => { map[f.feature_key] = f.is_enabled; });
          setFeaturesByBusiness(prev => ({ ...prev, [b.BusinessID]: map }));
        })
        .catch(() => {
          setFeaturesByBusiness(prev => ({ ...prev, [b.BusinessID]: {} }));
        });
    });
  }, [businesses, API_URL]);

  const handleDelete = async () => {
    if (!confirmDelete) return;
    setDeleting(true);
    setDeleteError(null);
    try {
      const res = await fetch(`${API_URL}/api/businesses/delete/${confirmDelete.BusinessID}`, {
        method: 'DELETE',
        headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
      });
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        throw new Error(data.detail || 'Could not delete account.');
      }
      setBusinesses(prev => prev.filter(b => b.BusinessID !== confirmDelete.BusinessID));
      setContextBusinesses(prev => prev.filter(b => b.BusinessID !== confirmDelete.BusinessID));
      setConfirmDelete(null);
    } catch (e) {
      setDeleteError(e.message || 'Delete failed.');
    } finally {
      setDeleting(false);
    }
  };

  if (!user) return null;
  const peopleId = user.peopleId;

  return (
    <div className="min-h-screen font-sans">
      <PageMeta
        title="Dashboard | Oatmeal Farm Network"
        description="Your Oatmeal Farm Network dashboard — manage your farm businesses, orders, livestock, and more."
        noIndex
      />
      <Header />

      <div className="container mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'Dashboard' }]} />

        <div className="flex items-center justify-between mb-6 pb-3 border-b-2 border-gray-200">
          <h2 className="text-2xl font-bold text-gray-800">{t('dashboard.heading')}</h2>
          <Link to={`/accounts/new?PeopleID=${peopleId}`} className="text-sm font-semibold text-[#3D6B34] hover:underline">
            {t('dashboard.add_account')}
          </Link>
        </div>

        {loading ? (
          <p className="text-gray-500 py-8">{t('dashboard.loading')}</p>
        ) : businesses.length === 0 ? (
          <div className="text-center py-16">
            <p className="text-gray-500 mb-4">{t('dashboard.no_accounts')}</p>
            <Link to={`/accounts/new?PeopleID=${peopleId}`} className="regsubmit2">
              {t('dashboard.add_first_account')}
            </Link>
          </div>
        ) : (
          <table style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr>
                <th style={thStyle}>{t('dashboard.th_account_name')}</th>
                <th style={thStyle}>{t('dashboard.th_type')}</th>
                <th style={thStyle}>{t('dashboard.th_association')}</th>
                <th style={{ ...thStyle, minWidth: '110px' }}>{t('dashboard.th_actions')}</th>
              </tr>
            </thead>
            <tbody>
              {businesses.map((b, i) => {
                const features = featuresByBusiness[b.BusinessID];
                const serviceLinks = buildServiceLinks(b.BusinessID, features, t);
                return (
                  <React.Fragment key={b.BusinessID}>
                    <tr style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa' }}>
                      <td style={tdStyle}>
                        <Link
                          to={`/account?PeopleID=${peopleId}&BusinessID=${b.BusinessID}`}
                          className="text-[#3D6B34] hover:underline font-medium"
                        >
                          {b.BusinessName}
                        </Link>
                      </td>
                      <td style={tdStyle} className="text-gray-600 text-sm">
                        {b.BusinessType || '—'}
                      </td>
                      <td style={tdStyle} className="text-sm">
                        {b.BusinessTypeID === 1 ? (
                          <span className="text-gray-400">—</span>
                        ) : (
                          <span className="flex items-center gap-2 flex-wrap">
                            {b.FavoriteAssociationName ? (
                              <span className="text-gray-700">{b.FavoriteAssociationName}</span>
                            ) : (
                              <span className="text-gray-400">{t('dashboard.assoc_none')}</span>
                            )}
                            <Link
                              to={`/account/associations?BusinessID=${b.BusinessID}`}
                              className="text-[#3D6B34] hover:underline text-xs"
                            >
                              {b.FavoriteAssociationName ? t('dashboard.assoc_change') : t('dashboard.assoc_set')}
                            </Link>
                          </span>
                        )}
                      </td>
                      <td style={tdStyle}>
                        <div className="flex items-center gap-2">
                          <Link to={`/account/users?PeopleID=${peopleId}&BusinessID=${b.BusinessID}`} title={t('dashboard.ico_users')}>
                            <IcoUsers />
                          </Link>
                          <span className="text-gray-300">|</span>
                          <Link to={`/account/profile?BusinessID=${b.BusinessID}`} title={t('dashboard.ico_edit')}>
                            <IcoEdit />
                          </Link>
                          <span className="text-gray-300">|</span>
                          <button
                            type="button"
                            title={t('dashboard.ico_delete')}
                            onClick={() => {
                              setDeleteError(null);
                              setConfirmDelete({ BusinessID: b.BusinessID, BusinessName: b.BusinessName });
                            }}
                            className="bg-transparent border-0 p-0 cursor-pointer"
                          >
                            <IcoDel />
                          </button>
                        </div>
                      </td>
                    </tr>

                    <tr style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa', borderBottom: '1px solid #E5E7EB' }}>
                      <td colSpan={4} style={{ padding: '0.25rem 1rem 0.6rem', fontSize: '0.82rem' }}>
                        {serviceLinks === null ? (
                          <span className="text-gray-400">{t('dashboard.svc_loading')}</span>
                        ) : serviceLinks.length === 0 ? (
                          <span className="text-gray-400">{t('dashboard.svc_none')}</span>
                        ) : (
                          <span className="flex gap-3 flex-wrap items-center">
                            {serviceLinks.map((link, idx) => (
                              <React.Fragment key={link.label}>
                                {idx > 0 && <span className="text-gray-300">|</span>}
                                <Link to={link.to} className="text-[#3D6B34] hover:underline">{link.label}</Link>
                              </React.Fragment>
                            ))}
                          </span>
                        )}
                      </td>
                    </tr>
                  </React.Fragment>
                );
              })}
            </tbody>
          </table>
        )}
      </div>

      <Footer />

      {confirmDelete && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4"
          onClick={() => !deleting && setConfirmDelete(null)}
        >
          <div
            className="bg-white rounded-xl shadow-xl max-w-md w-full p-6"
            onClick={e => e.stopPropagation()}
          >
            <h3 className="text-lg font-bold text-gray-900 mb-2">{t('dashboard.delete_title')}</h3>
            <p className="text-sm text-gray-600 mb-4">
              {t('dashboard.delete_body', { name: confirmDelete.BusinessName || t('dashboard.delete_this_account') })}
            </p>
            {deleteError && (
              <div className="bg-red-50 border border-red-300 text-red-700 rounded px-3 py-2 text-sm mb-4">
                {deleteError}
              </div>
            )}
            <div className="flex justify-end gap-2">
              <button
                type="button"
                disabled={deleting}
                onClick={() => setConfirmDelete(null)}
                className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50"
              >
                {t('dashboard.btn_cancel')}
              </button>
              <button
                type="button"
                disabled={deleting}
                onClick={handleDelete}
                className="bg-red-600 hover:bg-red-700 text-white rounded px-4 py-2 text-sm font-semibold disabled:opacity-50"
              >
                {deleting ? t('dashboard.btn_deleting') : t('dashboard.btn_delete')}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

const thStyle = {
  padding: '0.75rem 1rem',
  textAlign: 'left',
  backgroundColor: '#F3F4F6',
  fontWeight: '600',
  color: '#4B5563',
  textTransform: 'uppercase',
  fontSize: '0.75rem',
  letterSpacing: '0.05em',
  borderBottom: '1px solid #E5E7EB',
};

const tdStyle = {
  padding: '0.75rem 1rem',
  textAlign: 'left',
  borderBottom: 'none',
  verticalAlign: 'middle',
};
