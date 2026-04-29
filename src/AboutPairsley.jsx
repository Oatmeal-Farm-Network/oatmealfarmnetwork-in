// src/AboutPairsley.jsx
// Route: /platform/pairsley
import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#2f7d4a';

export default function AboutPairsley() {
  const { t } = useTranslation();

  const S = (p) => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={ACCENT} strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" {...p}/>;
  const capabilities = [
    { icon: <S><path d="M17 8C8 10 5.9 16.17 3.82 20.99"/><path d="M9.1 17.64C10.63 16.13 12.5 14.5 17 13"/><path d="M17 8c0 6-5 9-5 9"/></S>, title: t('pairsley.cap1_title'), body: t('pairsley.cap1_body') },
    { icon: <S><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></S>, title: t('pairsley.cap2_title'), body: t('pairsley.cap2_body') },
    { icon: <S><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></S>, title: t('pairsley.cap3_title'), body: t('pairsley.cap3_body') },
    { icon: <S><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></S>, title: t('pairsley.cap4_title'), body: t('pairsley.cap4_body') },
    { icon: <S><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></S>, title: t('pairsley.cap5_title'), body: t('pairsley.cap5_body') },
    { icon: <S><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93l-1.41 1.41M4.93 4.93l1.41 1.41M12 2v2M12 20v2M4.93 19.07l1.41-1.41M19.07 19.07l-1.41-1.41M2 12h2M20 12h2"/></S>, title: t('pairsley.cap6_title'), body: t('pairsley.cap6_body') },
  ];

  const TS = (p) => <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" {...p}/>;
  const tiles = [
    { to: '/marketplaces/farm-to-table', icon: <TS><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></TS>, title: t('pairsley.tile1_title'), body: t('pairsley.tile1_body') },
    { to: '/restaurant/farms',           icon: <TS><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></TS>, title: t('pairsley.tile2_title'), body: t('pairsley.tile2_body') },
    { to: '/restaurant/standing-orders', icon: <TS><polyline points="17 1 21 5 17 9"/><path d="M3 11V9a4 4 0 0 1 4-4h14"/><polyline points="7 23 3 19 7 15"/><path d="M21 13v2a4 4 0 0 1-4 4H3"/></TS>, title: t('pairsley.tile3_title'), body: t('pairsley.tile3_body') },
    { to: '/restaurant/digest',          icon: <TS><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22 6 12 13 2 6"/></TS>, title: t('pairsley.tile4_title'), body: t('pairsley.tile4_body') },
    { to: '/chef/dashboard',             icon: <TS><path d="M20 7a4 4 0 0 0-4-4 4 4 0 0 0-4 4 4 4 0 0 0-4-4 4 4 0 0 0-4 4 4 4 0 0 0 4 4h8a4 4 0 0 0 4-4z"/><path d="M8 11v9h8v-9"/></TS>, title: t('pairsley.tile5_title'), body: t('pairsley.tile5_body') },
  ];

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Pairsley | AI Agent for Restaurants & Professional Kitchens"
        description="Pairsley is the Oatmeal Farm Network AI agent for restaurateurs, chefs, and professional kitchens — sourcing, seasonal menus, costing, and vendor relationships."
        canonical="https://oatmealfarmnetwork.com/platform/pairsley"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center"><svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"><path d="M3 2v7c0 1.1.9 2 2 2h4a2 2 0 0 0 2-2V2"/><path d="M7 2v20"/><path d="M21 15V2a5 5 0 0 0-5 5v6c0 1.1.9 2 2 2h3zm0 0v7"/></svg></div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('pairsley.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>{t('pairsley.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">{t('pairsley.hero_body')}</p>
          <p className="mt-2 text-sm text-white/80 italic">{t('pairsley.hero_tagline')}</p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/restaurant/farms"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('pairsley.hero_cta1')}
            </Link>
            <Link to="/marketplaces/farm-to-table"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('pairsley.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services', to: '/platform' },
          { label: 'Pairsley' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('pairsley.what_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">{t('pairsley.what_body')}</p>
        </section>

        <section className="mt-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('pairsley.cap_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {capabilities.map(c => (
              <Capability key={c.title} icon={c.icon} title={c.title} body={c.body} />
            ))}
          </div>
        </section>

        <section className="mt-10 bg-white border border-gray-200 rounded-2xl p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('pairsley.connected_title')}
          </h2>
          <p className="text-sm text-gray-700 leading-relaxed mb-3">{t('pairsley.connected_body')}</p>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            {tiles.map(tile => (
              <MiniTile key={tile.title} to={tile.to} icon={tile.icon} title={tile.title} body={tile.body} />
            ))}
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('pairsley.ask_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {[1, 2, 3, 4, 5, 6].map(i => (
              <div key={i} className="bg-white border border-gray-200 rounded-xl p-4 text-sm text-gray-800 italic">
                {t(`pairsley.q${i}`)}
              </div>
            ))}
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('pairsley.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-4">{t('pairsley.cta_body')}</p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/chef/dashboard"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              {t('pairsley.cta1')}
            </Link>
            <Link to="/marketplaces/farm-to-table"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              {t('pairsley.cta2')}
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function Capability({ icon, title, body }) {
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

function MiniTile({ to, icon, title, body }) {
  return (
    <Link to={to} className="block bg-gray-50 border border-gray-200 rounded-lg p-3 hover:border-[#2f7d4a] transition no-underline">
      <div className="flex items-center gap-2 mb-1">
        <span className="text-lg">{icon}</span>
        <h4 className="font-bold text-gray-900 text-sm">{title}</h4>
      </div>
      <p className="text-xs text-gray-600">{body}</p>
    </Link>
  );
}
