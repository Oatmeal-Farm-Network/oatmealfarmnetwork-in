import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';

const S = ({ children }) => (
  <svg width="22" height="22" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

const ICONS = {
  satellite: <S><rect x="5" y="1" width="6" height="4" rx="0.5"/><line x1="8" y1="5" x2="8" y2="8"/><circle cx="8" cy="10" r="3"/><line x1="1" y1="3" x2="4" y2="5"/><line x1="15" y1="3" x2="12" y2="5"/></S>,
  climate:   <S><path d="M3 9a5 5 0 0 1 10 0 3 3 0 0 1 0 6H3a3 3 0 0 1 0-6z"/><path d="M8 2v2M3.5 3.5l1.4 1.4M12.5 3.5l-1.4 1.4"/></S>,
  soil:      <S><path d="M2 12c0-3.3 2.7-6 6-6s6 2.7 6 6"/><path d="M5 12c0-1.7 1.3-3 3-3s3 1.3 3 3"/><line x1="8" y1="14" x2="8" y2="15"/><line x1="4" y1="14" x2="4" y2="15"/><line x1="12" y1="14" x2="12" y2="15"/></S>,
  gdd:       <S><path d="M2 12 L5 7 L8 9 L11 4 L14 6"/><line x1="2" y1="14" x2="14" y2="14"/><circle cx="14" cy="4" r="1.5" fill="currentColor" stroke="none"/></S>,
  scout:     <S><circle cx="8" cy="8" r="3"/><circle cx="8" cy="8" r="6.5"/><line x1="8" y1="1.5" x2="8" y2="4"/><line x1="8" y1="12" x2="8" y2="14.5"/><line x1="1.5" y1="8" x2="4" y2="8"/><line x1="12" y1="8" x2="14.5" y2="8"/></S>,
  zones:     <S><path d="M2 8a6 6 0 0 1 12 0"/><path d="M4.5 11a4 4 0 0 1 7 0"/><path d="M7 14a1.5 1.5 0 0 1 2 0"/><line x1="8" y1="2" x2="8" y2="14"/></S>,
  yield:     <S><path d="M2 13 L5 8 L8 10 L11 5 L14 7"/><path d="M11 5 L14 5 L14 8"/><line x1="2" y1="15" x2="14" y2="15"/></S>,
  carbon:    <S><path d="M8 2a6 6 0 1 0 0 12A6 6 0 0 0 8 2z"/><path d="M5.5 8.5c.5 1.5 1.5 2.5 2.5 2.5s2-.8 2-2-.8-1.5-2-1.5-2-.5-2-1.5.8-2 2-2 2 1 2.5 2.5"/><line x1="8" y1="2" x2="8" y2="1"/><line x1="8" y1="14" x2="8" y2="15"/></S>,
  report:    <S><rect x="3" y="1" width="10" height="14" rx="1"/><line x1="6" y1="5" x2="10" y2="5"/><line x1="6" y1="8" x2="10" y2="8"/><line x1="6" y1="11" x2="9" y2="11"/></S>,
  alert:     <S><path d="M8 2L1 14h14z"/><line x1="8" y1="7" x2="8" y2="10"/><circle cx="8" cy="12.5" r="0.6" fill="currentColor" stroke="none"/></S>,
  map:       <S><path d="M1 3l5 2 4-2 5 2v10l-5-2-4 2-5-2V3z"/><line x1="6" y1="5" x2="6" y2="15"/><line x1="10" y1="3" x2="10" y2="13"/></S>,
  water:     <S><path d="M8 14V8"/><path d="M5 10c0-3 3-5 3-8 0 3 3 5 3 8a3 3 0 0 1-6 0z"/></S>,
};

const STATS_VALUES = ['6', '10+', '24h', '∞'];

export default function AboutPrecisionAg() {
  const { t } = useTranslation();

  const features = [
    { icon: ICONS.satellite, title: t('precision.feat1_title'), body: t('precision.feat1_body') },
    { icon: ICONS.climate,   title: t('precision.feat2_title'), body: t('precision.feat2_body') },
    { icon: ICONS.soil,      title: t('precision.feat3_title'), body: t('precision.feat3_body') },
    { icon: ICONS.gdd,       title: t('precision.feat4_title'), body: t('precision.feat4_body') },
    { icon: ICONS.scout,     title: t('precision.feat5_title'), body: t('precision.feat5_body') },
    { icon: ICONS.zones,     title: t('precision.feat6_title'), body: t('precision.feat6_body') },
    { icon: ICONS.yield,     title: t('precision.feat7_title'), body: t('precision.feat7_body') },
    { icon: ICONS.carbon,    title: t('precision.feat8_title'), body: t('precision.feat8_body') },
    { icon: ICONS.alert,     title: t('precision.feat9_title'), body: t('precision.feat9_body') },
    { icon: ICONS.report,    title: t('precision.feat10_title'), body: t('precision.feat10_body') },
  ];

  const stats = [
    { value: STATS_VALUES[0], label: t('precision.stat1_lbl') },
    { value: STATS_VALUES[1], label: t('precision.stat2_lbl') },
    { value: STATS_VALUES[2], label: t('precision.stat3_lbl') },
    { value: STATS_VALUES[3], label: t('precision.stat4_lbl') },
  ];

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Precision Agriculture | Oatmeal Farm Network"
        description="Satellite crop monitoring, predictive climate stress, soil intelligence, yield forecasting, and more — all in one integrated precision agriculture platform."
        canonical="https://oatmealfarmnetwork.com/platform/precision-ag"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-white">
              <svg width="28" height="28" viewBox="0 0 16 16" fill="none" stroke="currentColor"
                strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
                <path d="M8 1a4.5 4.5 0 0 0-4.5 4.5C3.5 9 8 15 8 15s4.5-6 4.5-9.5A4.5 4.5 0 0 0 8 1z"/>
                <circle cx="8" cy="5.5" r="1.5"/>
              </svg>
            </div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('precision.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>
            {t('precision.hero_title')}
          </h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            {t('precision.hero_body')}
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/oatsense"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('precision.hero_cta1')}
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('precision.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      {/* Stats bar */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 py-5 grid grid-cols-2 md:grid-cols-4 gap-4">
          {stats.map(s => (
            <div key={s.label} className="text-center">
              <div className="text-2xl font-bold" style={{ color: ACCENT }}>{s.value}</div>
              <div className="text-xs text-gray-500 mt-0.5 uppercase tracking-wide font-semibold">{s.label}</div>
            </div>
          ))}
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Precision Agriculture' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('precision.what_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">
            {t('precision.what_body')}
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('precision.included_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {features.map(f => (
              <FeatureCard key={f.title} icon={f.icon} title={f.title} body={f.body} />
            ))}
          </div>
        </section>

        {/* How it works */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('precision.how_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Step n="1" title={t('precision.step1_title')} body={t('precision.step1_body')} />
            <Step n="2" title={t('precision.step2_title')} body={t('precision.step2_body')} />
            <Step n="3" title={t('precision.step3_title')} body={t('precision.step3_body')} />
          </div>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('precision.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            {t('precision.cta_body')}
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/oatsense"
              className="inline-block px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              {t('precision.cta1')}
            </Link>
            <Link to="/signup"
              className="inline-block px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-gray-50"
              style={{ color: ACCENT, borderColor: ACCENT }}>
              {t('precision.cta2')}
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function FeatureCard({ icon, title, body }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <div className="flex items-center gap-2 mb-1">
        <span className="flex items-center shrink-0" style={{ color: ACCENT }}>{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600 leading-relaxed">{body}</p>
    </div>
  );
}

function Step({ n, title, body }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-5">
      <div className="w-8 h-8 rounded-full flex items-center justify-center text-white text-sm font-bold mb-3"
           style={{ backgroundColor: ACCENT }}>
        {n}
      </div>
      <h3 className="font-bold text-gray-900 mb-1">{title}</h3>
      <p className="text-sm text-gray-600 leading-relaxed">{body}</p>
    </div>
  );
}
