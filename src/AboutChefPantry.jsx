import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#2f7d4a';

const S = ({ children }) => (
  <svg width="22" height="22" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

const ICONS = {
  farm:    <S><path d="M1 14V7l7-5 7 5v7"/><path d="M6 14V9h4v5"/></S>,
  recipe:  <S><rect x="3" y="1" width="10" height="14" rx="1"/><line x1="6" y1="5" x2="10" y2="5"/><line x1="6" y1="8" x2="10" y2="8"/><line x1="6" y1="11" x2="9" y2="11"/></S>,
  cost:    <S><circle cx="8" cy="8" r="6"/><path d="M8 5v1.5M8 9.5V11"/><path d="M6 6.5c0-.8.9-1.5 2-1.5s2 .7 2 1.5S9.1 8 8 8s-2 .7-2 1.5S6.9 11 8 11s2-.7 2-1.5"/></S>,
  truck:   <S><rect x="1" y="5" width="10" height="8" rx="1"/><path d="M11 8h3l1 3v2h-4V8z"/><circle cx="4" cy="14" r="1.5"/><circle cx="12" cy="14" r="1.5"/></S>,
  repeat:  <S><path d="M4 4h8a3 3 0 0 1 0 6H4"/><path d="M7 7L4 4l3-3"/></S>,
  mail:    <S><rect x="1" y="3" width="14" height="10" rx="1"/><path d="M1 4l7 5 7-5"/></S>,
  market:  <S><path d="M2 3h12l-1 5H3L2 3z"/><path d="M3 8l1 5h8l1-5"/><line x1="8" y1="8" x2="8" y2="13"/><line x1="5.5" y1="8" x2="5.5" y2="13"/><line x1="10.5" y1="8" x2="10.5" y2="13"/></S>,
  pairsley:<S><path d="M8 14V8"/><path d="M5 11c0-3 3-4 3-7 0 3 3 4 3 7a3 3 0 0 1-6 0z"/><path d="M3 8c1-2 2.5-2.5 5-2"/><path d="M13 8c-1-2-2.5-2.5-5-2"/></S>,
  heart:   <S><path d="M8 13s-6-3.5-6-7a4 4 0 0 1 6-3.5A4 4 0 0 1 14 6c0 3.5-6 7-6 7z"/></S>,
};

const QUOTES = [
  '"What\'s coming in from my saved farms this week?"',
  '"Draft three specials built around the fennel that just hit."',
  '"Cost a plate: 6 oz sirloin, roasted heirloom carrots, salsa verde."',
  '"Set up a weekly order of 10 lb of microgreens from Blackbird Farm."',
  '"I need 30 lb of beets by Thursday — who\'s got them?"',
  '"Update our website description to focus on our farm relationships."',
];

const FEAT_LINKS = [
  '/marketplaces/farm-to-table',
  '/restaurant/farms',
  '/restaurant/standing-orders',
  '/restaurant/digest',
  '/chef',
  '/chef',
  '/chef',
  '/platform/pairsley',
];

export default function AboutChefPantry() {
  const { t } = useTranslation();

  const features = FEAT_LINKS.map((to, i) => ({
    icon: [ICONS.market, ICONS.heart, ICONS.repeat, ICONS.mail, ICONS.recipe, ICONS.cost, ICONS.truck, ICONS.pairsley][i],
    title: t(`chef_pantry.feat${i + 1}_title`),
    body:  t(`chef_pantry.feat${i + 1}_body`),
    cta:   { label: t(`chef_pantry.feat${i + 1}_cta`), to },
  }));

  const stats = [
    { v: '25+',        l: t('chef_pantry.stat1_l') },
    { v: t('chef_pantry.stat2_v'), l: t('chef_pantry.stat2_l') },
    { v: t('chef_pantry.stat3_v'), l: t('chef_pantry.stat3_l') },
    { v: t('chef_pantry.stat4_v'), l: t('chef_pantry.stat4_l') },
  ];

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Chef's Digital Pantry | Oatmeal Farm Network"
        description="A complete sourcing and kitchen management suite for chefs and restaurateurs — farm marketplace, standing orders, weekly harvest digest, recipes, plate costing, and Pairsley AI."
        canonical="https://oatmealfarmnetwork.com/chef-pantry"
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
                <path d="M5 2v5a3 3 0 0 0 6 0V2"/>
                <line x1="8" y1="10" x2="8" y2="14"/>
                <line x1="5" y1="14" x2="11" y2="14"/>
              </svg>
            </div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('chef_pantry.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow">{t('chef_pantry.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">{t('chef_pantry.hero_body')}</p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/chef"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('chef_pantry.hero_cta1')}
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('chef_pantry.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      {/* Stats bar */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 py-5 grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
          {stats.map(s => (
            <div key={s.l}>
              <div className="text-2xl font-bold" style={{ color: ACCENT }}>{s.v}</div>
              <div className="text-xs text-gray-500 mt-0.5 uppercase tracking-wide font-semibold">{s.l}</div>
            </div>
          ))}
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: t('chef_pantry.hero_title') },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('chef_pantry.what_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">{t('chef_pantry.what_body')}</p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('chef_pantry.included_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {features.map(f => (
              <FeatureCard key={f.title} icon={f.icon} title={f.title} body={f.body} cta={f.cta} />
            ))}
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('chef_pantry.pairsley_title')}
          </h2>
          <p className="text-gray-600 text-sm mb-4">{t('chef_pantry.pairsley_body')}</p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {QUOTES.map((q, i) => (
              <div key={i}
                className="bg-white border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 italic">
                {q}
              </div>
            ))}
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('chef_pantry.how_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Step n="1" title={t('chef_pantry.step1_title')} body={t('chef_pantry.step1_body')} />
            <Step n="2" title={t('chef_pantry.step2_title')} body={t('chef_pantry.step2_body')} />
            <Step n="3" title={t('chef_pantry.step3_title')} body={t('chef_pantry.step3_body')} />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('chef_pantry.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-5">{t('chef_pantry.cta_body')}</p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/marketplaces/farm-to-table"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              {t('chef_pantry.cta1')}
            </Link>
            <Link to="/signup"
              className="px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-green-50"
              style={{ color: ACCENT, borderColor: ACCENT }}>
              {t('chef_pantry.cta2')}
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function FeatureCard({ icon, title, body, cta }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 flex flex-col">
      <div className="flex items-center gap-2 mb-1">
        <span className="flex items-center shrink-0" style={{ color: ACCENT }}>{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600 leading-relaxed flex-1">{body}</p>
      <div className="mt-3">
        <Link to={cta.to}
          className="text-xs font-bold hover:underline"
          style={{ color: ACCENT }}>
          {cta.label} →
        </Link>
      </div>
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
