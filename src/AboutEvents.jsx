// src/AboutEvents.jsx
// Route: /platform/events
import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#EFAE15';
const ACCENT_DARK = '#B87F0B';

export default function AboutEvents() {
  const { t } = useTranslation();

  const eventTypes = [
    { icon: '🐏', label: t('events_about.et_livestock') },
    { icon: '🧶', label: t('events_about.et_fiber') },
    { icon: '🎙️', label: t('events_about.et_conferences') },
    { icon: '🏆', label: t('events_about.et_competitions') },
    { icon: '🔨', label: t('events_about.et_auctions') },
    { icon: '🚜', label: t('events_about.et_farm_tours') },
    { icon: '🛍️', label: t('events_about.et_vendor') },
    { icon: '🍽️', label: t('events_about.et_dinners') },
    { icon: '📚', label: t('events_about.et_workshops') },
    { icon: '🎉', label: t('events_about.et_festivals') },
    { icon: '📅', label: t('events_about.et_rsvp') },
    { icon: '🎓', label: t('events_about.et_certs') },
  ];

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Events | Oatmeal Farm Network"
        description="Turnkey event management for the ag world — fiber festivals, livestock shows, auctions, conferences, workshops, farm tours, and vendor fairs. All in one place."
        canonical="https://oatmealfarmnetwork.com/platform/events"
      />
      <Header />

      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT_DARK }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🎪</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('events_about.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>{t('events_about.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            {t('events_about.hero_body')}
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/events"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT_DARK }}>
              {t('events_about.hero_cta1')}
            </Link>
            <Link to="/events/add"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('events_about.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Events' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('events_about.shape_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">
            {t('events_about.shape_body')}
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('events_about.types_title')}
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {eventTypes.map(x => (
              <div key={x.label} className="bg-white border border-gray-200 rounded-xl p-3 text-center">
                <div className="text-2xl mb-1">{x.icon}</div>
                <div className="text-xs font-semibold text-gray-700">{x.label}</div>
              </div>
            ))}
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('events_about.included_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon="🎟️" title={t('events_about.feat1_title')} body={t('events_about.feat1_body')} />
            <Feature icon="🏷️" title={t('events_about.feat2_title')} body={t('events_about.feat2_body')} />
            <Feature icon="📊" title={t('events_about.feat3_title')} body={t('events_about.feat3_body')} />
            <Feature icon="👨‍⚖️" title={t('events_about.feat4_title')} body={t('events_about.feat4_body')} />
            <Feature icon="🎤" title={t('events_about.feat5_title')} body={t('events_about.feat5_body')} />
            <Feature icon="📧" title={t('events_about.feat6_title')} body={t('events_about.feat6_body')} />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('events_about.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            {t('events_about.cta_body')}
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/events/add"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT_DARK }}>
              {t('events_about.cta1')}
            </Link>
            <Link to="/events"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT_DARK, color: ACCENT_DARK }}>
              {t('events_about.cta2')}
            </Link>
          </div>
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
