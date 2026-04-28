// src/AboutRosemarie.jsx
// Route: /platform/rosemarie
import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import RosemarieChat from './RosemarieChat';

const ACCENT = '#8B5CF6';

const FOR_ICONS = ['🌾', '🍞', '🧀', '🥒', '🍯', '🫖', '🍫', '🥓'];

export default function AboutRosemarie() {
  const { t } = useTranslation();

  const forItems = FOR_ICONS.map((icon, i) => ({
    icon,
    label: t(`rosemarie.for${i + 1}`),
  }));

  const capabilities = [
    { icon: '🌾', title: t('rosemarie.cap1_title'), body: t('rosemarie.cap1_body') },
    { icon: '📦', title: t('rosemarie.cap2_title'), body: t('rosemarie.cap2_body') },
    { icon: '📥', title: t('rosemarie.cap3_title'), body: t('rosemarie.cap3_body') },
    { icon: '📤', title: t('rosemarie.cap4_title'), body: t('rosemarie.cap4_body') },
    { icon: '🏷️', title: t('rosemarie.cap5_title'), body: t('rosemarie.cap5_body') },
    { icon: '📚', title: t('rosemarie.cap6_title'), body: t('rosemarie.cap6_body') },
  ];

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Rosemarie | AI Agent for Artisan Food Producers"
        description="Rosemarie is the Oatmeal Farm Network AI agent for mills, bakers, cheesemakers, and artisan food producers — recipes, yields, sourcing, labeling, and small-batch operations."
        canonical="https://oatmealfarmnetwork.com/platform/rosemarie"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🌿</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('rosemarie.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>{t('rosemarie.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">{t('rosemarie.hero_body')}</p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/account"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('rosemarie.hero_cta1')}
            </Link>
            <Link to="/marketplaces/farm-to-table"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('rosemarie.hero_cta2')}
            </Link>
          </div>
          <p className="mt-4 text-xs text-white/85 italic">{t('rosemarie.hero_note')}</p>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services', to: '/platform' },
          { label: 'Rosemarie' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('rosemarie.what_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">{t('rosemarie.what_body')}</p>
        </section>

        <section className="mt-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('rosemarie.for_title')}
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {forItems.map(x => (
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
            {t('rosemarie.cap_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {capabilities.map(c => (
              <Capability key={c.title} icon={c.icon} title={c.title} body={c.body} />
            ))}
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('rosemarie.ask_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {[1, 2, 3, 4, 5, 6].map(i => (
              <div key={i} className="bg-white border border-gray-200 rounded-xl p-4 text-sm text-gray-800 italic">
                {t(`rosemarie.q${i}`)}
              </div>
            ))}
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('rosemarie.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-4">{t('rosemarie.cta_body')}</p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/account"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              {t('rosemarie.cta1')}
            </Link>
            <Link to="/processed-food-inventory"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              {t('rosemarie.cta2')}
            </Link>
          </div>
        </section>
      </div>

      <RosemarieChat />
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
