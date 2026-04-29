import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

export default function AccountLayout({ children, pageTitle, breadcrumbs, allowAnonymous = false }) {
  const { t } = useTranslation();
  const navigate = useNavigate();

  useEffect(() => {
    if (allowAnonymous) return;
    const token = localStorage.getItem('access_token');
    if (!token) {
      navigate('/login');
    }
  }, [navigate, allowAnonymous]);

  return (
    <div className="min-h-screen bg-gray-50 font-sans flex flex-col">
      <PageMeta
        title={pageTitle ? `${pageTitle} | Oatmeal Farm Network` : t('account_layout.meta_title')}
        description={t('account_layout.meta_desc')}
        noIndex
      />
      <Header />

      <div className="grow p-6">
        {breadcrumbs && breadcrumbs.length > 0 && (
          <Breadcrumbs items={breadcrumbs} />
        )}
        {children}
      </div>

      <Footer />
    </div>
  );
}
