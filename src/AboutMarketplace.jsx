// src/AboutMarketplace.jsx
// Route: /platform/marketplace
import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#A3301E';

export default function AboutMarketplace() {
  const { t } = useTranslation();
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Marketplace | Oatmeal Farm Network"
        description="List farm products once and appear in Farm 2 Table (chefs), Products (consumers), and Livestock (ranches). Stripe Connect payouts built in."
        canonical="https://oatmealfarmnetwork.com/platform/marketplace"
      />
      <Header />

      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🛒</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('mkt_about.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>{t('mkt_about.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            {t('mkt_about.hero_body')}
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/account"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('mkt_about.hero_cta1')}
            </Link>
            <Link to="/marketplaces/farm-to-table"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('mkt_about.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Marketplace' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('mkt_about.three_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">
            {t('mkt_about.three_body')}
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('mkt_about.mkts_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <MarketCard to="/marketplaces/farm-to-table" icon="🍽️"
              title={t('mkt_about.m1_title')} body={t('mkt_about.m1_body')} />
            <MarketCard to="/marketplace/products" icon="🛍️"
              title={t('mkt_about.m2_title')} body={t('mkt_about.m2_body')} />
            <MarketCard to="/marketplaces/livestock" icon="🐄"
              title={t('mkt_about.m3_title')} body={t('mkt_about.m3_body')} />
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('mkt_about.included_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon="💳" title={t('mkt_about.feat1_title')} body={t('mkt_about.feat1_body')} />
            <Feature icon="🏷️" title={t('mkt_about.feat2_title')} body={t('mkt_about.feat2_body')} />
            <Feature icon="📜" title={t('mkt_about.feat3_title')} body={t('mkt_about.feat3_body')} />
            <Feature icon="💬" title={t('mkt_about.feat4_title')} body={t('mkt_about.feat4_body')} />
            <Feature icon="📦" title={t('mkt_about.feat5_title')} body={t('mkt_about.feat5_body')} />
            <Feature icon="🌱" title={t('mkt_about.feat6_title')} body={t('mkt_about.feat6_body')} />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('mkt_about.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            {t('mkt_about.cta_body')}
          </p>
          <Link to="/account"
            className="inline-block px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
            style={{ backgroundColor: ACCENT }}>
            {t('mkt_about.cta')}
          </Link>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function Feature({ icon, title, body }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <div className="flex items-center gap-2 mb-1">
        <span className="text-xl">{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600">{body}</p>
    </div>
  );
}

function MarketCard({ to, icon, title, body }) {
  return (
    <Link to={to} className="block bg-white border border-gray-200 rounded-xl p-5 hover:border-[#A3301E] transition no-underline">
      <div className="flex items-center gap-2 mb-2">
        <span className="text-2xl">{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600">{body}</p>
    </Link>
  );
}
