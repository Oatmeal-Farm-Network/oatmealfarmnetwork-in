// src/AboutWebsiteBuilder.jsx
// Route: /platform/website-builder
import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';

const SI = ({ children }) => (
  <svg width="22" height="22" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);
const FEAT_ICONS = {
  widgets: <SI><rect x="1" y="1" width="6" height="6" rx="0.5"/><rect x="9" y="1" width="6" height="6" rx="0.5"/><rect x="1" y="9" width="6" height="6" rx="0.5"/><rect x="9" y="9" width="6" height="6" rx="0.5"/></SI>,
  source:  <SI><circle cx="8" cy="8" r="2"/><path d="M3 8H1M15 8h-2M8 3V1M8 15v-2"/><circle cx="3.5" cy="3.5" r="1"/><circle cx="12.5" cy="3.5" r="1"/><circle cx="3.5" cy="12.5" r="1"/><circle cx="12.5" cy="12.5" r="1"/></SI>,
  domain:  <SI><circle cx="8" cy="8" r="6"/><path d="M8 2c-2 1.5-3 3.5-3 6s1 4.5 3 6"/><path d="M8 2c2 1.5 3 3.5 3 6s-1 4.5-3 6"/><line x1="2" y1="8" x2="14" y2="8"/></SI>,
  mobile:  <SI><rect x="4" y="1" width="8" height="14" rx="1.5"/><circle cx="8" cy="12.5" r="0.8" fill="currentColor" stroke="none"/></SI>,
  blog:    <SI><path d="M11 2l3 3-8 8H3v-3z"/><line x1="9" y1="4" x2="12" y2="7"/></SI>,
  hero:    <SI><rect x="1" y="2" width="14" height="10" rx="1"/><path d="M5 14h6"/></SI>,
};

export default function AboutWebsiteBuilder() {
  const { t } = useTranslation();
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Website Builder | Oatmeal Farm Network"
        description="Launch a professional farm website in an afternoon with farm-aware drag-and-drop widgets, custom domains, and built-in AI help from Lavendir."
        canonical="https://oatmealfarmnetwork.com/platform/website-builder"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-white">
              <svg width="28" height="28" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"><rect x="1" y="2" width="14" height="10" rx="1"/><line x1="4" y1="15" x2="12" y2="15"/><line x1="8" y1="12" x2="8" y2="15"/></svg>
            </div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('web_build.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>{t('web_build.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            {t('web_build.hero_body')}
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/website/builder"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('web_build.hero_cta1')}
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('web_build.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Website Builder' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('web_build.what_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">
            {t('web_build.what_body')}
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('web_build.included_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon={FEAT_ICONS.widgets} title={t('web_build.feat1_title')} body={t('web_build.feat1_body')} />
            <Feature icon={FEAT_ICONS.source}  title={t('web_build.feat2_title')} body={t('web_build.feat2_body')} />
            <Feature icon={FEAT_ICONS.domain}  title={t('web_build.feat3_title')} body={t('web_build.feat3_body')} />
            <Feature icon={<img src="/images/LavendirIcon.png" alt="Lavendir" className="w-5 h-5" />} title={t('web_build.feat4_title')} body={t('web_build.feat4_body')} />
            <Feature icon={FEAT_ICONS.mobile}  title={t('web_build.feat5_title')} body={t('web_build.feat5_body')} />
            <Feature icon={FEAT_ICONS.blog}    title={t('web_build.feat6_title')} body={t('web_build.feat6_body')} />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('web_build.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            {t('web_build.cta_body')}
          </p>
          <Link to="/website/builder"
            className="inline-block px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
            style={{ backgroundColor: ACCENT }}>
            {t('web_build.cta')}
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
        <span className="text-[#3D6B34] flex items-center shrink-0">{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600">{body}</p>
    </div>
  );
}
