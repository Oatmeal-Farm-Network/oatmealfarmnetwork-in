// src/AboutSaige.jsx
// Marketing / about page for Saige — the AI agricultural assistant.
// Route: /platform/saige
import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';

export default function AboutSaige() {
  const { t } = useTranslation();
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Saige | AI Agricultural Assistant"
        description="Saige is the Oatmeal Farm Network AI agent for growers and ranchers — crops, livestock, soil, weather, markets, and more."
        canonical="https://oatmealfarmnetwork.com/platform/saige"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🌾</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">{t('saige.hero_badge')}</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>{t('saige.hero_title')}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            {t('saige.hero_body')}
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/saige"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              {t('saige.hero_cta1')}
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {t('saige.hero_cta2')}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services', to: '/platform' },
          { label: 'Saige' },
        ]} />

        {/* What Saige Does */}
        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('saige.what_title')}
          </h2>
          <p className="text-gray-700 leading-relaxed">
            {t('saige.what_body')}
          </p>
        </section>

        {/* Capabilities */}
        <section className="mt-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('saige.cap_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Capability icon="🌱" title={t('saige.cap1_title')} body={t('saige.cap1_body')} />
            <Capability icon="🐄" title={t('saige.cap2_title')} body={t('saige.cap2_body')} />
            <Capability icon="☁️" title={t('saige.cap3_title')} body={t('saige.cap3_body')} />
            <Capability icon="📈" title={t('saige.cap4_title')} body={t('saige.cap4_body')} />
            <Capability icon="📝" title={t('saige.cap5_title')} body={t('saige.cap5_body')} />
            <Capability icon="🗂️" title={t('saige.cap6_title')} body={t('saige.cap6_body')} />
          </div>
        </section>

        {/* Example conversations */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('saige.ask_title')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {[
              '"Should I plant buckwheat or sudangrass as my summer cover?"',
              '"My ewe lambed twins this morning — log it and remind me to vaccinate at 2 weeks."',
              '"Draft a blog post about our fall apple harvest and schedule it."',
              '"Frost warning Thursday — what do I need to cover and which fields are at risk?"',
              '"How much grain should my 180 lb ram get through breeding season?"',
              '"Pull together a precision-ag summary for the North pasture."',
            ].map((q, i) => (
              <div key={i} className="bg-white border border-gray-200 rounded-xl p-4 text-sm text-gray-800 italic">
                {q}
              </div>
            ))}
          </div>
        </section>

        {/* How Saige is different */}
        <section className="mt-10 bg-white border border-gray-200 rounded-2xl p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('saige.diff_title')}
          </h2>
          <ul className="text-sm text-gray-700 space-y-2">
            <li>• <b>{t('saige.diff1_label')}</b> {t('saige.diff1_body')}</li>
            <li>• <b>{t('saige.diff2_label')}</b> {t('saige.diff2_body')}</li>
            <li>• <b>{t('saige.diff3_label')}</b> {t('saige.diff3_body')}</li>
            <li>• <b>{t('saige.diff4_label')}</b> {t('saige.diff4_body')}</li>
            <li>• <b>{t('saige.diff5_label')}</b> {t('saige.diff5_body')}</li>
          </ul>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('saige.cta_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-4">{t('saige.cta_body')}</p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/saige"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              {t('saige.cta1')}
            </Link>
            <Link to="/account"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              {t('saige.cta2')}
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
