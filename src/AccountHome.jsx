import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';

export default function AccountHome() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const [Business, setBusiness] = useState(null);
  const [Error, setError] = useState(false);

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_URL}/auth/account-home?BusinessID=${BusinessID}`)
      .then(Res => Res.json())
      .then(Data => setBusiness(Data))
      .catch(Err => {
        console.error('Error fetching account:', Err);
        setError(true);
      });
  }, [BusinessID]);

  if (Error) return <div className="p-8 text-red-600">Error loading account.</div>;
  if (!Business) return <div className="p-8 text-gray-500">Loading...</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>

      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
          <div>
            <h2 className="text-2xl font-bold text-green-700 mb-4 border-b-2 border-green-300 pb-3">
              {Business.BusinessName}
            </h2>
            <p className="text-sm text-gray-700 mb-1">Account Name: <strong>{Business.BusinessName}</strong></p>
            <p className="text-sm text-gray-700 mb-1">Account Type: <strong>{Business.BusinessType}</strong></p>
            <Link to={`/account/change-type?BusinessID=${BusinessID}`} className="text-xs text-[#819360] hover:underline">Change Account Type</Link>
            <p className="text-sm text-gray-700 mt-2 mb-1">Subscription Level: <strong>{Business.SubscriptionLevel}</strong></p>
            <p className="text-sm text-gray-700 mb-1">Subscription Ends: <strong>{Business.SubscriptionEndDate || 'Not Set'}</strong></p>
          </div>
          <div className="flex flex-col gap-2 justify-start pt-8">
            <Link to={`/account/profile?BusinessID=${BusinessID}`} className="text-sm text-[#3D6B34] hover:underline">Account Profile</Link>
            <Link to="/account/renew" className="text-sm text-[#3D6B34] hover:underline">Renew / Upgrade Membership</Link>
            <Link to={`/account/delete?BusinessID=${BusinessID}`} className="text-sm text-red-600 hover:underline">Delete Account</Link>
          </div>
        </div>
      </div>

    </AccountLayout>
  );
} 