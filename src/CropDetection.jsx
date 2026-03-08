import React from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function CropDetection() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  React.useEffect(() => {
    if (BusinessID) LoadBusiness(BusinessID);
  }, [BusinessID]);

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
        <h2 className="text-2xl font-bold text-green-700 mb-2">Crop Detection</h2>
        <p className="text-gray-500 text-sm mb-6">
          AI-powered crop detection and analysis for your fields.
        </p>
        <div style={{ height: 'calc(100vh - 280px)', minHeight: 500 }}>
          <iframe
            src="https://crop-detection-802455386518.us-central1.run.app/"
            title="Crop Detection"
            className="w-full h-full rounded-xl border border-gray-200"
            style={{ border: 'none' }}
            allow="camera; microphone"
          />
        </div>
      </div>
    </AccountLayout>
  );
}