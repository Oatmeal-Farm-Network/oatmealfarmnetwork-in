import React from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function PrecisionAgMaps() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business } = useAccount();

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={PeopleID}
      pageTitle="Maps"
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Precision Ag' },
        { label: 'Analysis' },
        { label: 'Maps' },
      ]}
    >
      <h1 className="text-2xl font-bold text-gray-900 mb-2">Maps</h1>
      <p className="text-gray-600 max-w-2xl">
        Full-field basemaps with swappable overlays — satellite, NDVI, NDRE, moisture, and drone imagery.
        Pan and zoom across all your acreage on a single canvas.
      </p>
      <div className="mt-6 p-10 bg-white rounded-xl border border-dashed border-gray-300 text-center text-gray-500">
        Coming soon.
      </div>
    </AccountLayout>
  );
}
