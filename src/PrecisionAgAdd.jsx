import React, { useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import PrecisionAgFields from './PrecisionAgFields';

export default function PrecisionAgAdd() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const { Business, LoadBusiness } = useAccount();

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);

  if (!Business) return <div className="p-8 text-gray-500">Loading...</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Add Field" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Precision Ag' }, { label: 'Fields', to: `/precision-ag/fields?BusinessID=${BusinessID}` }, { label: 'Add' }]}>
      <PrecisionAgFields businessId={BusinessID} />
    </AccountLayout>
  );
}