import React, { useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function PrecisionAgAnalyses() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const { Business, LoadBusiness } = useAccount();

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);

  if (!Business) return <div className="p-8 text-gray-500">Loading...</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <h1 className="text-3xl font-bold text-gray-900">Analyses</h1>
    </AccountLayout>
  );
}