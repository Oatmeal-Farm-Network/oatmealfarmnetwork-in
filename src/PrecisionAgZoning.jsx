import React from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function PrecisionAgZoning() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business } = useAccount();

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle="Zoning"
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Precision Ag' },
        { label: 'Analysis' },
        { label: 'Zoning' },
      ]}
    >
      <h1 className="text-2xl font-bold text-gray-900 mb-2">Zoning</h1>
      <p className="text-gray-600 max-w-2xl">
        Management-zone maps built from clustering NDVI, yield, and soil-moisture layers. Drive variable-rate
        applications and targeted scouting from consistent within-field patterns.
      </p>
      <div className="mt-6 p-10 bg-white rounded-xl border border-dashed border-gray-300 text-center text-gray-500">
        Coming soon.
      </div>
    </AccountLayout>
  );
}
