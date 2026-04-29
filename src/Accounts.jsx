import React, { useEffect, useState } from 'react';
import { useNavigate, useSearchParams, Link } from 'react-router-dom';
const IcoUsers = () => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>;
const IcoEdit  = () => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>;
const IcoDel   = () => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>;
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const FARM_RANCH_TYPE_ID = 8;

export default function Accounts() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const [businesses, setBusinesses] = useState([]);
  const [loading, setLoading] = useState(true);

  const peopleId = searchParams.get('PeopleID') || localStorage.getItem('people_id');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }
    if (!peopleId) return;

    fetch(`${import.meta.env.VITE_API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
      .then(r => r.json())
      .then(data => { setBusinesses(Array.isArray(data) ? data : []); setLoading(false); })
      .catch(() => setLoading(false));
  }, [peopleId]);

  return (
    <div className="min-h-screen font-sans">
      <PageMeta
        title="My Accounts | Oatmeal Farm Network"
        description="Manage your farm and ranch business accounts on Oatmeal Farm Network."
        noIndex
      />
      <Header />

      <div className="container mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'My Accounts' }]} />

        <h2 className="text-2xl font-bold text-gray-800 mb-6 pb-3 border-b-2 border-gray-200">
          Accounts
        </h2>

        {loading ? (
          <p className="text-gray-500 py-8">Loading...</p>
        ) : businesses.length === 0 ? (
          <div className="text-center py-16">
            <p className="text-gray-500 mb-4">You don't have any business accounts yet.</p>
            <Link to={`/accounts/new?PeopleID=${peopleId}`} className="regsubmit2">
              Add Your First Account
            </Link>
          </div>
        ) : (
          <table style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr>
                <th style={thStyle}>Account Name</th>
                <th style={thStyle}>Type</th>
                <th style={{ ...thStyle, minWidth: '110px' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {businesses.map((b, i) => (
                <React.Fragment key={b.BusinessID}>
                  {/* Main row */}
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
                    <td style={tdStyle}>
                      <div className="flex items-center gap-2">
                        <Link to={`/account/users?PeopleID=${peopleId}&BusinessID=${b.BusinessID}`} title="Users">
                          <IcoUsers />
                        </Link>
                        <span className="text-gray-300">|</span>
                        <Link to={`/account/profile?BusinessID=${b.BusinessID}`} title="Edit">
                          <IcoEdit />
                        </Link>
                        <span className="text-gray-300">|</span>
                        <Link to={`/account/delete?BusinessID=${b.BusinessID}`} title="Delete">
                          <IcoDel />
                        </Link>
                      </div>
                    </td>
                  </tr>

                  {/* Sub-links row */}
                  <tr style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa', borderBottom: '1px solid #E5E7EB' }}>
                    <td colSpan={3} style={{ padding: '0.25rem 1rem 0.6rem', fontSize: '0.82rem' }}>
                      {b.BusinessTypeID === FARM_RANCH_TYPE_ID ? (
                        <span className="flex gap-3 flex-wrap">
                          <Link to={`/account/livestock/add?BusinessID=${b.BusinessID}`} className="text-[#3D6B34] hover:underline">Add Livestock</Link>
                          <span className="text-gray-300">|</span>
                          <Link to={`/account/livestock?BusinessID=${b.BusinessID}`} className="text-[#3D6B34] hover:underline">List of Livestock</Link>
                          <span className="text-gray-300">|</span>
                          <Link to={`/account/produce?BusinessID=${b.BusinessID}`} className="text-[#3D6B34] hover:underline">Produce Inventory</Link>
                          <span className="text-gray-300">|</span>
                          <Link to={`/account/orders?BusinessID=${b.BusinessID}`} className="text-[#3D6B34] hover:underline">Orders</Link>
                        </span>
                      ) : (
                        <Link to={`/account/events?BusinessID=${b.BusinessID}`} className="text-[#3D6B34] hover:underline">Events</Link>
                      )}
                    </td>
                  </tr>
                </React.Fragment>
              ))}
            </tbody>
          </table>
        )}
      </div>

      <Footer />
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