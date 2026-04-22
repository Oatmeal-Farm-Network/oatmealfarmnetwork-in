import React from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function PrecisionAgCropStatus() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business } = useAccount();

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle="Crop Status"
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Precision Ag' },
        { label: 'Analysis' },
        { label: 'Crop Status' },
      ]}
    >
      <h1 className="text-2xl font-bold text-gray-900 mb-2">Crop Status</h1>
      <p className="text-gray-600 max-w-2xl">
        At-a-glance health summary across every field — growth stage, stress flags, scouting due dates, and
        anomalies worth a ground check. The morning dashboard for a grower with acreage to cover.
      </p>
      <div className="mt-6 p-10 bg-white rounded-xl border border-dashed border-gray-300 text-center text-gray-500">
        Coming soon.
      </div>
    </AccountLayout>
  );
}
