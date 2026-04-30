// src/AboutEquipmentMarketplace.jsx
// Route: /platform/equipment-marketplace
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useTranslation } from 'react-i18next';

const ACCENT = '#3D6B34';

const FEATURES = [
  {
    icon: <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><rect x="1" y="3" width="15" height="13" rx="1"/><path d="M16 8h4l3 3v5h-7V8z"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>,
    titleKey: 'feature_buy_sell_title',
    bodyKey: 'feature_buy_sell_body',
  },
  {
    icon: <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M7 16V4m0 0L3 8m4-4l4 4"/><path d="M17 8v12m0 0l4-4m-4 4l-4-4"/></svg>,
    titleKey: 'feature_swap_title',
    bodyKey: 'feature_swap_body',
  },
  {
    icon: <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>,
    titleKey: 'feature_borrow_title',
    bodyKey: 'feature_borrow_body',
  },
  {
    icon: <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>,
    titleKey: 'feature_search_title',
    bodyKey: 'feature_search_body',
  },
  {
    icon: <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>,
    titleKey: 'feature_msg_title',
    bodyKey: 'feature_msg_body',
  },
  {
    icon: <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>,
    titleKey: 'feature_trusted_title',
    bodyKey: 'feature_trusted_body',
  },
];

function Feature({ icon, titleKey, bodyKey }) {
  const { t } = useTranslation();
  const eq = k => t(`equipment.${k}`);
  return (
    <div className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200">
      <div className="shrink-0 flex items-center justify-center"
           style={{ width: '155px', minHeight: '155px', backgroundColor: '#f0f7ed', color: ACCENT }}>
        {icon}
      </div>
      <div className="flex flex-col justify-center px-5 py-4 flex-1 min-w-0">
        <h3 className="font-bold text-sm" style={{ color: ACCENT }}>{eq(titleKey)}</h3>
        <p className="text-xs text-gray-600 leading-relaxed mt-1">{eq(bodyKey)}</p>
      </div>
    </div>
  );
}

export default function AboutEquipmentMarketplace() {
  const { t } = useTranslation();
  const eq = k => t(`equipment.${k}`);
  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Farm Equipment Marketplace | Buy, Sell, Swap & Borrow | Oatmeal Farm Network"
        description="Buy, sell, trade, or borrow farm equipment with verified farms and ranches in your region. The Swap Meet connects neighbors who need what you have."
        canonical="https://oatmealfarmnetwork.com/platform/equipment-marketplace"
      />
      <Header />

      <div className="mx-auto px-4 pt-4" style={{ maxWidth: '1300px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Equipment Marketplace' },
        ]} />
      </div>

      {/* Hero */}
      <div className="mx-auto px-4 pt-2" style={{ maxWidth: '1300px' }}>
        <div className="relative w-full overflow-hidden rounded-xl">
          <img
            src="/images/EquipmentMarketplaceHeader.webp"
            alt="Farm Equipment Marketplace"
            className="w-full object-cover"
            style={{ height: '250px', display: 'block' }}
            loading="eager"
            onError={e => { e.target.onerror = null; e.target.style.display = 'none'; }}
          />
          <div className="absolute inset-0"
               style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.92) 0%, rgba(255,255,255,0.75) 45%, rgba(255,255,255,0) 78%)' }} />
          <div className="absolute inset-0 flex flex-col justify-center px-8 py-6" style={{ maxWidth: '720px' }}>
            <h1 style={{ color: '#000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '2rem', fontWeight: 'bold', margin: '0 0 12px', lineHeight: 1.2 }}>
              {eq('about_hero_title')}
            </h1>
            <p style={{ color: '#111', fontSize: '0.92rem', margin: '0 0 16px', lineHeight: 1.6 }}>
              {eq('about_hero_body')}
            </p>
            <div className="flex flex-wrap gap-3">
              <Link to="/marketplaces/equipment"
                className="font-bold px-5 py-2 rounded-lg border-2 transition hover:bg-gray-50 text-sm"
                style={{ color: ACCENT, borderColor: ACCENT }}>
                {eq('btn_browse_equipment')}
              </Link>
              <Link to="/equipment/my-listings"
                className="px-5 py-2 rounded-lg text-white font-bold text-sm shadow hover:shadow-md transition"
                style={{ backgroundColor: ACCENT }}>
                {eq('btn_post_listing')}
              </Link>
            </div>
          </div>
        </div>
      </div>

      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        <section className="mb-8">
          <h2 className="text-lg font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {eq('section_intro_title')}
          </h2>
          <p className="text-sm text-gray-700 leading-relaxed max-w-3xl">
            {eq('section_intro_body')}
          </p>
        </section>

        <h2 className="text-lg font-bold text-gray-900 mb-5"
            style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
          {eq('section_what_title')}
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5 mb-10">
          {FEATURES.map(f => <Feature key={f.titleKey} {...f} />)}
        </div>

        {/* How the Swap Meet works */}
        <h2 className="text-lg font-bold text-gray-900 mb-5"
            style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
          {eq('section_swap_title')}
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-5 mb-10">
          {[
            { n: '1', title: eq('step1_title'), body: eq('step1_body') },
            { n: '2', title: eq('step2_title'), body: eq('step2_body') },
            { n: '3', title: eq('step3_title'), body: eq('step3_body') },
          ].map(s => (
            <div key={s.n} className="bg-white border border-gray-200 rounded-xl px-5 py-5 shadow-sm">
              <div className="w-8 h-8 rounded-full flex items-center justify-center text-white text-sm font-bold mb-3"
                   style={{ backgroundColor: ACCENT }}>
                {s.n}
              </div>
              <h3 className="font-bold text-gray-900 text-sm mb-1">{s.title}</h3>
              <p className="text-xs text-gray-600 leading-relaxed">{s.body}</p>
            </div>
          ))}
        </div>

        {/* CTA banner */}
        <div className="flex flex-col sm:flex-row items-center justify-between gap-4 bg-white border border-gray-200 rounded-xl px-8 py-6">
          <div>
            <h3 className="font-bold text-gray-900 text-base mb-1"
                style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
              {eq('cta_title')}
            </h3>
            <p className="text-sm text-gray-600">{eq('cta_body')}</p>
          </div>
          <div className="flex flex-wrap gap-3 shrink-0">
            <Link to="/equipment/my-listings"
              className="px-5 py-2.5 rounded-lg text-white font-bold text-sm shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              {eq('btn_post_listing')}
            </Link>
            <Link to="/marketplaces/equipment"
              className="px-5 py-2.5 rounded-lg font-bold border-2 text-sm transition hover:bg-gray-50"
              style={{ color: ACCENT, borderColor: ACCENT }}>
              {eq('btn_browse_listings')}
            </Link>
          </div>
        </div>

      </div>

      <Footer />
    </div>
  );
}
