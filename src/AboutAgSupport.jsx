import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT      = '#3D6B34';
const GOLD        = '#B87F0B';
const GOLD_LIGHT  = '#FEF3C7';

const S = ({ children }) => (
  <svg width="22" height="22" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

// Icons only (JSX stays at module level)
const EVENT_ICONS = [
  <S><rect x="1" y="3" width="14" height="11" rx="1"/><path d="M5 3V1M11 3V1"/><line x1="1" y1="7" x2="15" y2="7"/></S>,
  <S><rect x="2" y="4" width="12" height="9" rx="1"/><path d="M5 4V2.5a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1V4"/><line x1="8" y1="8" x2="8" y2="11"/><line x1="6" y1="9.5" x2="10" y2="9.5"/></S>,
  <S><path d="M3 5h10M3 8h7M3 11h5"/><rect x="1" y="2" width="14" height="12" rx="1"/></S>,
  <S><circle cx="8" cy="6" r="3"/><path d="M2 14c0-3.3 2.7-6 6-6s6 2.7 6 6"/><line x1="13" y1="4" x2="15" y2="4"/><line x1="14" y1="3" x2="14" y2="5"/></S>,
  <S><path d="M8 2L1 14h14z"/><line x1="8" y1="7" x2="8" y2="10"/><circle cx="8" cy="12.5" r="0.6" fill="currentColor" stroke="none"/></S>,
  <S><path d="M2 12 L5 7 L8 9 L11 4 L14 6"/><line x1="2" y1="14" x2="14" y2="14"/></S>,
  <S><path d="M2 4h12v8a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4z"/><path d="M2 4l6 5 6-5"/></S>,
  <S><circle cx="8" cy="8" r="6"/><path d="M8 5v3l2 2"/></S>,
];

const ASSOC_ICONS = [
  <S><rect x="1" y="2" width="14" height="10" rx="1"/><line x1="4" y1="15" x2="12" y2="15"/><line x1="8" y1="12" x2="8" y2="15"/></S>,
  <S><circle cx="8" cy="8" r="6"/><path d="M8 2c-2 1.5-3 3.5-3 6s1 4.5 3 6"/><path d="M8 2c2 1.5 3 3.5 3 6s-1 4.5-3 6"/><line x1="2" y1="8" x2="14" y2="8"/></S>,
  <S><rect x="1" y="3" width="14" height="11" rx="1"/><path d="M5 3V1M11 3V1"/><line x1="1" y1="7" x2="15" y2="7"/></S>,
  <S><path d="M11 2l3 3-8 8H3v-3z"/><line x1="9" y1="4" x2="12" y2="7"/></S>,
  <S><path d="M2 13 L5 8 L8 10 L11 5 L14 7"/><path d="M11 5 L14 5 L14 8"/><line x1="2" y1="15" x2="14" y2="15"/></S>,
  <S><circle cx="6" cy="5" r="2.5"/><circle cx="11" cy="10" r="2.5"/><path d="M8.5 5H13a1 1 0 0 1 1 1v1"/><path d="M7.5 10H3a1 1 0 0 1-1-1V8"/></S>,
];

export default function AboutAgSupport() {
  const { t } = useTranslation();

  const eventFeatures = EVENT_ICONS.map((icon, i) => ({
    icon,
    title: t(`ag_support.ef${i + 1}_title`),
    body:  t(`ag_support.ef${i + 1}_body`),
  }));

  const assocFeatures = ASSOC_ICONS.map((icon, i) => ({
    icon,
    title: t(`ag_support.af${i + 1}_title`),
    body:  t(`ag_support.af${i + 1}_body`),
  }));

  const eventTypes = [
    t('ag_support.et1'),  t('ag_support.et2'),  t('ag_support.et3'),
    t('ag_support.et4'),  t('ag_support.et5'),  t('ag_support.et6'),
    t('ag_support.et7'),  t('ag_support.et8'),  t('ag_support.et9'),
    t('ag_support.et10'), t('ag_support.et11'), t('ag_support.et12'),
  ];

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Agriculture Support | Oatmeal Farm Network"
        description="Turnkey event registration and custom association websites — built for farms, ranches, livestock shows, fiber festivals, breed associations, and every corner of the ag world."
        canonical="https://oatmealfarmnetwork.com/agriculture-support"
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
                <path d="M8 1L2 4v4c0 3.5 2.5 6.5 6 7.5C14 14.5 14 8 14 8V4L8 1z"/>
              </svg>
            </div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('ag_support.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow">{t('ag_support.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            {t('ag_support.hero_body')}
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/events/add"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('ag_support.hero_cta1')}
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('ag_support.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Agriculture Support' },
        ]} />

        {/* ── Event Registration ─────────────────────────────────── */}
        <section className="mt-8">
          <div className="flex items-center gap-3 mb-1">
            <span style={{ color: GOLD }}>
              <svg width="24" height="24" viewBox="0 0 16 16" fill="none" stroke="currentColor"
                strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
                <rect x="1" y="3" width="14" height="11" rx="1"/><path d="M5 3V1M11 3V1"/><line x1="1" y1="7" x2="15" y2="7"/>
              </svg>
            </span>
            <h2 className="text-2xl font-bold text-gray-900"
                style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
              {t('ag_support.events_h')}
            </h2>
          </div>
          <p className="text-gray-700 leading-relaxed mt-2 mb-6">
            {t('ag_support.events_body')}
          </p>

          {/* Event type pills */}
          <div className="flex flex-wrap gap-2 mb-8">
            {eventTypes.map(label => (
              <span key={label}
                className="text-xs font-semibold px-3 py-1 rounded-full border"
                style={{ background: GOLD_LIGHT, borderColor: GOLD, color: GOLD }}>
                {label}
              </span>
            ))}
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {eventFeatures.map(f => (
              <FeatureCard key={f.title} icon={f.icon} title={f.title} body={f.body} accent={GOLD} />
            ))}
          </div>

          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/events/add"
              className="px-5 py-2.5 rounded-lg text-white font-bold shadow hover:shadow-md transition text-sm"
              style={{ backgroundColor: GOLD }}>
              {t('ag_support.events_cta1')}
            </Link>
            <Link to="/events"
              className="px-5 py-2.5 rounded-lg font-bold border-2 transition hover:bg-yellow-50 text-sm"
              style={{ borderColor: GOLD, color: GOLD }}>
              {t('ag_support.events_cta2')}
            </Link>
            <Link to="/platform/events"
              className="px-5 py-2.5 rounded-lg font-bold border border-gray-300 text-gray-600 hover:bg-gray-50 transition text-sm">
              {t('ag_support.events_cta3')}
            </Link>
          </div>
        </section>

        <hr className="my-12 border-gray-200" />

        {/* ── Association Support ────────────────────────────────── */}
        <section>
          <div className="flex items-center gap-3 mb-1">
            <span style={{ color: ACCENT }}>
              <svg width="24" height="24" viewBox="0 0 16 16" fill="none" stroke="currentColor"
                strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
                <path d="M8 1L2 4v4c0 3.5 2.5 6.5 6 7.5C14 14.5 14 8 14 8V4L8 1z"/>
              </svg>
            </span>
            <h2 className="text-2xl font-bold text-gray-900"
                style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
              {t('ag_support.assoc_h')}
            </h2>
          </div>
          <p className="text-gray-700 leading-relaxed mt-2 mb-6">
            {t('ag_support.assoc_body')}
          </p>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {assocFeatures.map(f => (
              <FeatureCard key={f.title} icon={f.icon} title={f.title} body={f.body} accent={ACCENT} />
            ))}
          </div>

          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/website-builder"
              className="px-5 py-2.5 rounded-lg text-white font-bold shadow hover:shadow-md transition text-sm"
              style={{ backgroundColor: ACCENT }}>
              {t('ag_support.assoc_cta1')}
            </Link>
            <Link to="/signup"
              className="px-5 py-2.5 rounded-lg font-bold border-2 transition hover:bg-green-50 text-sm"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              {t('ag_support.assoc_cta2')}
            </Link>
          </div>
        </section>

        {/* CTA */}
        <section className="mt-12 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('ag_support.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-5">
            {t('ag_support.cta_body')}
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/events/add"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: GOLD }}>
              {t('ag_support.cta1')}
            </Link>
            <Link to="/signup"
              className="px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-green-50"
              style={{ color: ACCENT, borderColor: ACCENT }}>
              {t('ag_support.cta2')}
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function FeatureCard({ icon, title, body, accent }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <div className="flex items-center gap-2 mb-1">
        <span className="flex items-center shrink-0" style={{ color: accent }}>{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600 leading-relaxed">{body}</p>
    </div>
  );
}
