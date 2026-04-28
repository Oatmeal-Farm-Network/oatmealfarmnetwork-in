import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

// ── Shared SVG wrapper ───────────────────────────────────────────
const S = ({ children }) => (
  <svg width="20" height="20" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

// ── Icons ────────────────────────────────────────────────────────
const I = {
  satellite: <S><rect x="5" y="1" width="6" height="4" rx="0.5"/><line x1="8" y1="5" x2="8" y2="8"/><circle cx="8" cy="10" r="3"/><line x1="1" y1="3" x2="4" y2="5"/><line x1="15" y1="3" x2="12" y2="5"/></S>,
  saige:     <S><path d="M8 14V8"/><path d="M5 11c0-3 3-4 3-7 0 3 3 4 3 7a3 3 0 0 1-6 0z"/></S>,
  livestock: <S><path d="M3 12c0-2.8 2.2-5 5-5s5 2.2 5 5"/><circle cx="8" cy="5" r="2.5"/><path d="M1 10c.5-1.5 1.5-2 2-2"/><path d="M15 10c-.5-1.5-1.5-2-2-2"/></S>,
  market:    <S><path d="M2 3h12l-1 5H3L2 3z"/><path d="M3 8l1 5h8l1-5"/><line x1="8" y1="8" x2="8" y2="13"/></S>,
  website:   <S><rect x="1" y="2" width="14" height="10" rx="1"/><line x1="4" y1="15" x2="12" y2="15"/><line x1="8" y1="12" x2="8" y2="15"/></S>,
  directory: <S><circle cx="8" cy="8" r="6"/><path d="M8 2c-2 1.5-3 3.5-3 6s1 4.5 3 6"/><path d="M8 2c2 1.5 3 3.5 3 6s-1 4.5-3 6"/><line x1="2" y1="8" x2="14" y2="8"/></S>,
  events:    <S><rect x="1" y="3" width="14" height="11" rx="1"/><path d="M5 3V1M11 3V1"/><line x1="1" y1="7" x2="15" y2="7"/></S>,
  assoc:     <S><path d="M8 1L2 4v4c0 3.5 2.5 6.5 6 7.5C14 14.5 14 8 14 8V4L8 1z"/></S>,
  rosemarie: <S><path d="M8 2c-1 2-3 3-3 5.5A3 3 0 0 0 8 11a3 3 0 0 0 3-3.5C11 5 9 4 8 2z"/><line x1="8" y1="11" x2="8" y2="14"/></S>,
  pairsley:  <S><path d="M5 2v5a3 3 0 0 0 6 0V2"/><line x1="8" y1="10" x2="8" y2="14"/><line x1="5" y1="14" x2="11" y2="14"/></S>,
  pantry:    <S><rect x="2" y="4" width="12" height="10" rx="1"/><path d="M5 4V2.5A1.5 1.5 0 0 1 6.5 1h3A1.5 1.5 0 0 1 11 2.5V4"/><line x1="8" y1="8" x2="8" y2="11"/><line x1="6" y1="9.5" x2="10" y2="9.5"/></S>,
  blog:      <S><path d="M11 2l3 3-8 8H3v-3z"/><line x1="9" y1="4" x2="12" y2="7"/></S>,
  source:    <S><path d="M4 8h8M8 4l4 4-4 4"/></S>,
};

// ── Static (non-text) data per type ─────────────────────────────
const TYPE_DATA = {
  farms: {
    key:    'farms',
    color:  '#3D6B34',
    cta1To: '/oatsense',
    cta2To: '/signup',
    dir:    '/directory/farms-ranches',
    tools: [
      { icon: I.satellite, link: '/platform/precision-ag' },
      { icon: I.saige,     link: '/platform/saige' },
      { icon: I.livestock, link: '/marketplaces/livestock' },
      { icon: I.market,    link: '/marketplaces/farm-to-table' },
      { icon: I.website,   link: '/website-builder' },
      { icon: I.directory, link: '/directory/farms-ranches' },
      { icon: I.events,    link: '/event-registration' },
      { icon: I.assoc,     link: '/agriculture-support' },
    ],
  },
  ranches: {
    key:    'ranches',
    color:  '#7C5A3A',
    cta1To: '/marketplaces/livestock',
    cta2To: '/signup',
    dir:    '/directory/farms-ranches',
    tools: [
      { icon: I.livestock, link: '/marketplaces/livestock' },
      { icon: I.saige,     link: '/platform/saige' },
      { icon: I.satellite, link: '/platform/precision-ag' },
      { icon: I.website,   link: '/website-builder' },
      { icon: I.directory, link: '/directory/farms-ranches' },
      { icon: I.events,    link: '/event-registration' },
      { icon: I.assoc,     link: '/agriculture-support' },
      { icon: I.market,    link: '/marketplaces/farm-to-table' },
    ],
  },
  'artisan-producers': {
    key:    'artisan',
    color:  '#7C3F8B',
    cta1To: '/marketplaces/farm-to-table',
    cta2To: '/signup',
    dir:    '/directory/artisan-producers',
    tools: [
      { icon: I.market,    link: '/marketplaces/farm-to-table' },
      { icon: I.rosemarie, link: '/platform/rosemarie' },
      { icon: I.source,    link: '/marketplaces/farm-to-table' },
      { icon: I.website,   link: '/website-builder' },
      { icon: I.blog,      link: '/website-builder' },
      { icon: I.directory, link: '/directory/artisan-producers' },
      { icon: I.events,    link: '/event-registration' },
      { icon: I.assoc,     link: '/agriculture-support' },
    ],
  },
  restaurants: {
    key:    'restaurants',
    color:  '#2f7d4a',
    cta1To: '/marketplaces/farm-to-table',
    cta2To: '/signup',
    dir:    '/directory/restaurants',
    tools: [
      { icon: I.pantry,    link: '/chef-pantry' },
      { icon: I.market,    link: '/marketplaces/farm-to-table' },
      { icon: I.pairsley,  link: '/platform/pairsley' },
      { icon: I.website,   link: '/website-builder' },
      { icon: I.directory, link: '/directory/restaurants' },
      { icon: I.events,    link: '/event-registration' },
      { icon: I.blog,      link: '/website-builder' },
      { icon: I.assoc,     link: '/agriculture-support' },
    ],
  },
};

export default function ForBusinessPage({ type }) {
  const { t } = useTranslation();
  const data = TYPE_DATA[type];
  if (!data) return null;

  const p = data.key;
  const cfg = {
    title:     t(`for_biz.${p}_title`),
    color:     data.color,
    heroTitle: t(`for_biz.${p}_hero_title`),
    heroSub:   t(`for_biz.${p}_hero_sub`),
    what:      t(`for_biz.${p}_what`),
    tools: data.tools.map((tool, i) => ({
      icon:  tool.icon,
      title: t(`for_biz.${p}_tool${i + 1}_title`),
      body:  t(`for_biz.${p}_tool${i + 1}_body`),
      link:  tool.link,
      cta:   t(`for_biz.${p}_tool${i + 1}_cta`),
    })),
    cta1: { label: t(`for_biz.${p}_cta1`), to: data.cta1To },
    cta2: { label: t(`for_biz.${p}_cta2`), to: data.cta2To },
    dir: data.dir,
  };

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title={`${cfg.heroTitle} | Oatmeal Farm Network`}
        description={cfg.heroSub}
        canonical={`https://oatmealfarmnetwork.com/for-${type}`}
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: cfg.color }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <span className="text-xs font-bold uppercase tracking-widest text-white/80">Oatmeal Farm Network</span>
          <h1 className="text-4xl font-bold mt-2 mb-3 drop-shadow">{cfg.heroTitle}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">{cfg.heroSub}</p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to={cfg.cta1.to}
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: cfg.color }}>
              {cfg.cta1.label}
            </Link>
            <Link to={cfg.cta2.to}
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {cfg.cta2.label}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: cfg.title },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('for_biz.what_ofn')}
          </h2>
          <p className="text-gray-700 leading-relaxed">{cfg.what}</p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('for_biz.tools_included')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {cfg.tools.map(tool => (
              <ToolCard key={tool.title} icon={tool.icon} title={tool.title} body={tool.body}
                link={tool.link} cta={tool.cta} color={cfg.color} />
            ))}
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('for_biz.ready_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-5">
            {t('for_biz.ready_body')}
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/signup"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: cfg.color }}>
              {t('for_biz.create_free')}
            </Link>
            <Link to={cfg.dir}
              className="px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-gray-50"
              style={{ color: cfg.color, borderColor: cfg.color }}>
              {t('for_biz.browse_directory')}
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function ToolCard({ icon, title, body, link, cta, color }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 flex flex-col">
      <div className="flex items-center gap-2 mb-1">
        <span className="flex items-center shrink-0" style={{ color }}>{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600 leading-relaxed flex-1">{body}</p>
      <div className="mt-3">
        <Link to={link} className="text-xs font-bold hover:underline" style={{ color }}>
          {cta} →
        </Link>
      </div>
    </div>
  );
}
