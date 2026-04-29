import React, { useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import PrecisionAgFields from './PrecisionAgFields';

export default function PrecisionAgAdd() {
  const { t } = useTranslation();
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const { Business, LoadBusiness } = useAccount();

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);

  if (!Business) return <div className="p-8 text-gray-500">{t('pag_add.loading')}</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle={t('pag_add.page_title')} breadcrumbs={[{ label: t('nav.dashboard'), to: '/dashboard' }, { label: t('pag_add.breadcrumb_pag') }, { label: t('pag_add.breadcrumb_fields'), to: `/precision-ag/fields?BusinessID=${BusinessID}` }, { label: t('pag_add.breadcrumb_add') }]}>
      <PrecisionAgFields businessId={BusinessID} />
    </AccountLayout>
  );
}