import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';

const S = ({ children }) => (
  <svg width="24" height="24" viewBox="0 0 16 16" fill="none" stroke="currentColor"
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
};

const STATS_VALUES = ['6', '10+', '24h', '∞'];

export default function AboutPrecisionAg() {
  const { t } = useTranslation();

  const features = [
    { icon: ICONS.satellite, title: t('precision.feat1_title'),  body: t('precision.feat1_body'),  link: '/oatsense' },
    { icon: ICONS.climate,   title: t('precision.feat2_title'),  body: t('precision.feat2_body'),  link: '/oatsense' },
    { icon: ICONS.soil,      title: t('precision.feat3_title'),  body: t('precision.feat3_body'),  link: '/oatsense' },
    { icon: ICONS.gdd,       title: t('precision.feat4_title'),  body: t('precision.feat4_body'),  link: '/oatsense' },
    { icon: ICONS.scout,     title: t('precision.feat5_title'),  body: t('precision.feat5_body'),  link: '/oatsense' },
    { icon: ICONS.zones,     title: t('precision.feat6_title'),  body: t('precision.feat6_body'),  link: '/oatsense' },
    { icon: ICONS.yield,     title: t('precision.feat7_title'),  body: t('precision.feat7_body'),  link: '/oatsense' },
    { icon: ICONS.carbon,    title: t('precision.feat8_title'),  body: t('precision.feat8_body'),  link: '/oatsense' },
    { icon: ICONS.alert,     title: t('precision.feat9_title'),  body: t('precision.feat9_body'),  link: '/oatsense' },
    { icon: ICONS.report,    title: t('precision.feat10_title'), body: t('precision.feat10_body'), link: '/oatsense' },
  ];

  const stats = [
    { value: STATS_VALUES[0], label: t('precision.stat1_lbl') },
    { value: STATS_VALUES[1], label: t('precision.stat2_lbl') },
    { value: STATS_VALUES[2], label: t('precision.stat3_lbl') },
    { value: STATS_VALUES[3], label: t('precision.stat4_lbl') },
  ];

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Precision Agriculture | Oatmeal Farm Network"
        description="Satellite crop monitoring, predictive climate stress, soil intelligence, yield forecasting, and more — all in one integrated precision agriculture platform."
        canonical="https://oatmealfarmnetwork.com/platform/precision-ag"
      />
      <Header />

      {/* Breadcrumbs */}
      <div className="mx-auto px-4 pt-4" style={{ maxWidth: '1300px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: t('precision.hero_badge') },
        ]} />
      </div>

      {/* Hero — photo + gradient overlay matching /for-farms */}
      <div className="mx-auto px-4 pt-2" style={{ maxWidth: '1300px' }}>
        <div className="relative w-full overflow-hidden rounded-xl">
          <img
            src="/images/CoreFeaturesPrecisionAg.webp"
            alt={t('precision.hero_title')}
            className="w-full object-cover"
            style={{ height: '250px', display: 'block' }}
            loading="eager"
            onError={e => { e.target.onerror = null; e.target.style.display = 'none'; }}
          />
          <div
            className="absolute inset-0"
            style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.92) 0%, rgba(255,255,255,0.78) 45%, rgba(255,255,255,0) 80%)' }}
          />
          <div className="absolute inset-0 flex flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            <h1
              style={{
                color: '#000000',
                fontFamily: "'Lora','Times New Roman',serif",
                fontSize: '2rem',
                fontWeight: 'bold',
                margin: '0 0 12px',
                lineHeight: 1.2,
              }}
            >
              {t('precision.hero_title')}
            </h1>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: '0 0 16px', lineHeight: 1.6 }}>
              {t('precision.hero_body')}
            </p>
            <div className="flex flex-wrap gap-3">
              <Link
                to="/oatsense"
                className="font-bold px-5 py-2 rounded-lg shadow hover:shadow-md transition text-sm"
                style={{ backgroundColor: ACCENT, color: '#fff' }}
              >
                {t('precision.hero_cta1')}
              </Link>
              <Link
                to="/signup"
                className="font-bold px-5 py-2 rounded-lg border-2 transition hover:bg-gray-50 text-sm"
                style={{ color: ACCENT, borderColor: ACCENT }}
              >
                {t('precision.hero_cta2')}
              </Link>
            </div>
          </div>
        </div>
      </div>

      {/* Stats bar */}
      <div className="mx-auto px-4 pt-4" style={{ maxWidth: '1300px' }}>
        <div className="bg-white border border-gray-200 rounded-xl">
          <div className="grid grid-cols-2 md:grid-cols-4 divide-x divide-gray-100">
            {stats.map(s => (
              <div key={s.label} className="text-center py-4 px-2">
                <div className="text-2xl font-bold" style={{ color: ACCENT }}>{s.value}</div>
                <div className="text-xs text-gray-500 mt-0.5 uppercase tracking-wide font-semibold">{s.label}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Body */}
      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        {/* What is it */}
        <section className="mb-8">
          <h2
            className="text-lg font-bold text-gray-900 mb-3"
            style={{ fontFamily: "'Lora','Times New Roman',serif" }}
          >
            {t('precision.what_title')}
          </h2>
          <p className="text-sm text-gray-700 leading-relaxed max-w-3xl">{t('precision.what_body')}</p>
        </section>

        {/* Features grid */}
        <h2
          className="text-lg font-bold text-gray-900 mb-5"
          style={{ fontFamily: "'Lora','Times New Roman',serif" }}
        >
          {t('precision.included_title')}
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5 mb-10">
          {features.map((f, i) => (
            <ToolCard key={i} icon={f.icon} title={f.title} body={f.body} link={f.link} />
          ))}
        </div>

        {/* How it works */}
        <h2
          className="text-lg font-bold text-gray-900 mb-5"
          style={{ fontFamily: "'Lora','Times New Roman',serif" }}
        >
          {t('precision.how_title')}
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-5 mb-10">
          <StepCard n="1" title={t('precision.step1_title')} body={t('precision.step1_body')} />
          <StepCard n="2" title={t('precision.step2_title')} body={t('precision.step2_body')} />
          <StepCard n="3" title={t('precision.step3_title')} body={t('precision.step3_body')} />
        </div>

        {/* Bottom CTA — matching /for-farms banner style */}
        <div
          className="flex flex-col sm:flex-row items-center justify-between gap-4
                     bg-white border border-gray-200 rounded-xl px-8 py-6"
        >
          <div>
            <h3
              className="font-bold text-gray-900 text-base mb-1"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}
            >
              {t('precision.cta_title')}
            </h3>
            <p className="text-sm text-gray-600">{t('precision.cta_body')}</p>
          </div>
          <div className="flex flex-wrap gap-3 shrink-0">
            <Link
              to="/oatsense"
              className="px-5 py-2.5 rounded-lg text-white font-bold text-sm shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}
            >
              {t('precision.cta1')}
            </Link>
            <Link
              to="/signup"
              className="px-5 py-2.5 rounded-lg font-bold border-2 text-sm transition hover:bg-gray-50"
              style={{ color: ACCENT, borderColor: ACCENT }}
            >
              {t('precision.cta2')}
            </Link>
          </div>
        </div>

      </div>

      <Footer />
    </div>
  );
}

// ── ToolCard — matches /for-farms horizontal card style ──────────────
function ToolCard({ icon, title, body, link }) {
  return (
    <div className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200">
      <Link
        to={link}
        className="shrink-0 flex items-center justify-center"
        style={{ width: '155px', minHeight: '155px', backgroundColor: `${ACCENT}18` }}
        aria-hidden="true"
        tabIndex={-1}
      >
        <span style={{ color: ACCENT, opacity: 0.85, transform: 'scale(2.2)', display: 'flex' }}>
          {icon}
        </span>
      </Link>
      <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
        <div>
          <Link
            to={link}
            className="font-bold text-sm hover:underline"
            style={{ color: ACCENT }}
          >
            {title}
          </Link>
          <p className="text-xs text-gray-600 leading-relaxed mt-1">{body}</p>
        </div>
        <div className="mt-3">
          <Link to={link} className="text-xs font-bold hover:underline" style={{ color: ACCENT }}>
            Open Dashboard →
          </Link>
        </div>
      </div>
    </div>
  );
}

// ── StepCard — matches white card style ──────────────────────────────
function StepCard({ n, title, body }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl px-5 py-5 shadow-sm">
      <div
        className="w-8 h-8 rounded-full flex items-center justify-center text-white text-sm font-bold mb-3"
        style={{ backgroundColor: ACCENT }}
      >
        {n}
      </div>
      <h3 className="font-bold text-gray-900 text-sm mb-1">{title}</h3>
      <p className="text-xs text-gray-600 leading-relaxed">{body}</p>
    </div>
  );
}
