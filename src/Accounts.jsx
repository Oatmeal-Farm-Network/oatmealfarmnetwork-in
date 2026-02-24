import React, { useEffect, useState } from 'react';
import { useNavigate, useSearchParams, Link } from 'react-router-dom';
import Header from './HeaderGated';

export default function Accounts() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const [businesses, setBusinesses] = useState([]);
  const [loading, setLoading] = useState(true);

  const peopleId = searchParams.get('PeopleID') || localStorage.getItem('people_id');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) {
      navigate('/login');
      return;
    }

    if (!peopleId) return;

    fetch(`${import.meta.env.VITE_API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
      .then(r => r.json())
      .then(data => { setBusinesses(data); setLoading(false); })
      .catch(() => setLoading(false));
  }, [peopleId]);

  return (
    <div className="min-h-screen bg-[#f8f9f6] font-sans">
      <Header />

      <div className="max-w-4xl mx-auto px-4 py-10">
        <h1 className="text-2xl font-bold text-gray-800 mb-6">My Accounts</h1>

        {loading ? (
          <p className="text-gray-500">Loading...</p>
        ) : businesses.length === 0 ? (
          <div className="bg-white rounded-[20px] border border-gray-100 shadow-sm p-8 text-center">
            <p className="text-gray-500 mb-4">You don't have any business accounts yet.</p>
            <Link
              to={`/accounts/new?PeopleID=${peopleId}`}
              className="bg-[#819360] text-white font-bold py-2 px-6 rounded-xl text-sm uppercase tracking-wider hover:bg-[#4d734d] transition-colors"
            >
              Add Your First Account
            </Link>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
            {businesses.map(b => (
              <Link
                key={b.BusinessID}
                to={`/account?PeopleID=${peopleId}&BusinessID=${b.BusinessID}`}
                className="bg-white rounded-[20px] border border-gray-100 shadow-sm p-6 hover:shadow-md transition-shadow"
              >
                <h2 className="text-[#4d734d] font-bold text-lg">{b.BusinessName}</h2>
                <p className="text-gray-400 text-sm mt-1">Business ID: {b.BusinessID}</p>
              </Link>
            ))}
          </div>
        )}
      </div>

      <footer className="bg-[#1a1a1a] text-white py-12 mt-12">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p className="text-gray-500 text-xs uppercase tracking-[0.2em]">© 2026 Oatmeal Farm Network. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}
