import React, { useEffect } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function OatSense() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const { Business, LoadBusiness } = useAccount();

  useEffect(() => {
    LoadBusiness(BusinessID);
  }, [BusinessID]);

  if (!Business) return <div className="p-8 text-gray-500">Loading...</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <h1 className="text-3xl font-bold text-gray-900 mb-6">OatSense Dashboard</h1>
      <div className="flex flex-col gap-3 max-w-xs">
        <Link to={`/oatsense/crop-rotation?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Crop Rotation</Link>
        <Link to={`/oatsense/notes?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Notes</Link>
      </div>
    </AccountLayout>
  );
}