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

  const capabilities = [
    { icon: '🥬', title: t('pairsley.cap1_title'), body: t('pairsley.cap1_body') },
    { icon: '📋', title: t('pairsley.cap2_title'), body: t('pairsley.cap2_body') },
    { icon: '💵', title: t('pairsley.cap3_title'), body: t('pairsley.cap3_body') },
    { icon: '🤝', title: t('pairsley.cap4_title'), body: t('pairsley.cap4_body') },
    { icon: '🛒', title: t('pairsley.cap5_title'), body: t('pairsley.cap5_body') },
    { icon: '⚙️', title: t('pairsley.cap6_title'), body: t('pairsley.cap6_body') },
  ];

  const tiles = [
    { to: '/marketplaces/farm-to-table', icon: '🛒', title: t('pairsley.tile1_title'), body: t('pairsley.tile1_body') },
    { to: '/restaurant/farms',           icon: '❤️', title: t('pairsley.tile2_title'), body: t('pairsley.tile2_body') },
    { to: '/restaurant/standing-orders', icon: '🔁', title: t('pairsley.tile3_title'), body: t('pairsley.tile3_body') },
    { to: '/restaurant/digest',          icon: '📬', title: t('pairsley.tile4_title'), body: t('pairsley.tile4_body') },
    { to: '/chef/dashboard',             icon: '👨‍🍳', title: t('pairsley.tile5_title'), body: t('pairsley.tile5_body') },
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
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🍳</div>
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
