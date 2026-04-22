import React from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function PrecisionAgMultiLayer() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business } = useAccount();

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle="Multi-layer View"
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Precision Ag' },
        { label: 'Analysis' },
        { label: 'Multi-layer View' },
      ]}
    >
      <h1 className="text-2xl font-bold text-gray-900 mb-2">Multi-layer View</h1>
      <p className="text-gray-600 max-w-2xl">
        Side-by-side and stacked comparisons of multiple index layers on the same field — NDVI next to moisture,
        this week next to last, drone next to satellite. See what moved together and what didn't.
      </p>
      <div className="mt-6 p-10 bg-white rounded-xl border border-dashed border-gray-300 text-center text-gray-500">
        Coming soon.
      </div>
    </AccountLayout>
  );
}
