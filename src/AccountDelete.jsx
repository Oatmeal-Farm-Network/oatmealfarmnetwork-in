import React, { useEffect, useState } from 'react';
import { useNavigate, useSearchParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function AccountDelete() {
  const [searchParams] = useSearchParams();
  const businessId = searchParams.get('BusinessID');
  const navigate = useNavigate();

  const [business, setBusiness] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const [error, setError] = useState(null);
  const [confirmed, setConfirmed] = useState(false);

  const peopleId = localStorage.getItem('people_id');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }
    if (!businessId) { navigate('/dashboard'); return; }

    fetch(`${API_URL}/api/businesses/profile/${businessId}`)
      .then(r => r.json())
      .then(data => setBusiness(data))
      .catch(() => setError('Could not load account details.'));
  }, [businessId]);

  const handleDelete = async () => {
    if (!confirmed) {
      setError('Please check the confirmation box before deleting.');
      return;
    }
    setDeleting(true);
    setError(null);
    try {
      const res = await fetch(`${API_URL}/api/businesses/delete/${businessId}`, {
        method: 'DELETE',
        headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
      });
      if (res.ok) {
        navigate('/dashboard', { state: { deleted: business?.BusinessName } });
      } else {
        const data = await res.json();
        setError(data.detail || 'An error occurred. Please try again.');
      }
    } catch {
      setError('An error occurred. Please try again.');
    } finally {
      setDeleting(false);
    }
  };

  if (!business && !error) return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <Header />
      <div className="text-center py-20 text-gray-400">Loading...</div>
      <Footer />
    </div>
  );

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <PageMeta
        title="Delete Account | Oatmeal Farm Network"
        description="Permanently delete your business account on Oatmeal Farm Network."
        noIndex
      />
      <Header />

      <div style={{ maxWidth: '550px', margin: '2rem auto', padding: '0 1rem 3rem' }}>
        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'My Accounts', to: '/accounts' }, { label: 'Delete Account' }]} />

        {/* Back link */}
        <Link
          to={`/account?PeopleID=${peopleId}&BusinessID=${businessId}`}
          className="text-sm text-gray-500 hover:text-gray-700 flex items-center gap-1 mb-4"
        >
          ← Back to Account
        </Link>

        <div className="bg-white rounded-xl shadow border border-gray-100 p-8">

          {/* Warning header */}
          <div className="flex items-center gap-3 mb-6">
            <div className="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center flex-shrink-0">
              <svg className="w-5 h-5 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z" />
              </svg>
            </div>
            <h1 className="text-xl font-bold text-red-600">Delete Account</h1>
          </div>

          <p className="text-gray-600 text-sm mb-6 leading-relaxed">
            Are you sure you want to permanently delete this account? This action
            cannot be undone. All associated data including listings, animals,
            and account access will be removed.
          </p>

          {/* Business details card */}
          {business && (
            <div className="border border-gray-200 rounded-lg p-4 mb-6 bg-gray-50">
              <h2 className="font-bold text-gray-800 text-base mb-1">{business.BusinessName}</h2>
              {business.BusinessType && (
                <p className="text-sm text-gray-500">{business.BusinessType} Account</p>
              )}
              {business.AddressCity && (
                <p className="text-sm text-gray-500">
                  {[business.AddressCity, business.AddressState].filter(Boolean).join(', ')}
                </p>
              )}
            </div>
          )}

          {/* Confirmation checkbox */}
          <label className="flex items-start gap-3 mb-6 cursor-pointer">
            <input
              type="checkbox"
              checked={confirmed}
              onChange={e => { setConfirmed(e.target.checked); setError(null); }}
              className="mt-0.5"
            />
            <span className="text-sm text-gray-700">
              I understand this is permanent and cannot be undone. I want to delete{' '}
              <strong>{business?.BusinessName}</strong>.
            </span>
          </label>

          {error && (
            <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm mb-4">
              {error}
            </div>
          )}

          {/* Action buttons */}
          <div className="flex gap-3">
            <Link
              to={`/account?PeopleID=${peopleId}&BusinessID=${businessId}`}
              className="flex-1 text-center border border-gray-300 rounded-lg px-4 py-2 text-sm text-gray-600 hover:bg-gray-50 transition-colors"
            >
              Cancel
            </Link>
            <button
              onClick={handleDelete}
              disabled={deleting}
              className="flex-1 bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-lg text-sm transition-colors disabled:opacity-50"
            >
              {deleting ? 'Deleting...' : 'Delete Account'}
            </button>
          </div>

        </div>
      </div>

      <Footer />
    </div>
  );
}
