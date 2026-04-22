// src/AboutCropMonitor.jsx
// Route: /platform/crop-monitor
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#2563EB';

export default function AboutCropMonitor() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Crop Monitor | Oatmeal Farm Network"
        description="Field-level imagery and crop-health analytics built on satellite and drone data. NDVI, moisture, crop detection, and season-over-season trends."
        canonical="https://oatmealfarmnetwork.com/platform/crop-monitor"
      />
      <Header />

      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🛰️</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Crop Monitor</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Field-level imagery and crop-health analytics, built on top of satellite and drone data. See
            what's thriving and what's struggling before you drive out to look.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/precision-ag/fields"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Open Crop Monitor →
            </Link>
            <Link to="/precision-ag/add"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Add a field
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Crop Monitor' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What it does
          </h2>
          <p className="text-gray-700 leading-relaxed">
            Draw a polygon around a field once. Crop Monitor pulls the latest satellite passes, computes
            vegetation indices (NDVI, NDWI, and custom bands), and shows you a heatmap of what's happening
            across the acreage. Upload drone imagery when you have it and we'll overlay it on the same map.
            Ask Saige to summarize trouble spots, compare to last year, or schedule scouting when the
            signal warrants a field visit.
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon="🛰️" title="Satellite + drone imagery"
              body="Regular satellite passes plus drone overlays when you have them. NDVI, moisture, and custom vegetation indices." />
            <Feature icon="🌱" title="Crop detection"
              body="Identify what's growing where — and flag unexpected changes in cover between passes." />
            <Feature icon="📊" title="Season-over-season trends"
              body="Compare this year to last year at a glance, by field. Spot a dip before it becomes a loss." />
            <Feature icon="📈" title="Visualizations dashboard"
              body="Aggregate views across all your fields — yield proxies, stress hotspots, and rotation outcomes." />
            <Feature icon="🌾" title="Saige integration"
              body="Ask Saige to summarize field health, plan rotations, or flag risk hotspots for next week's weather." />
            <Feature icon="📝" title="Field notes & scouting"
              body="Log scouting visits directly on the map. Notes stay tied to the field and the date, so a season is a searchable record." />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            See your fields from above
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free tier includes monthly satellite passes on up to three fields. Precision tier adds weekly
            imagery, drone support, and historical archives.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/precision-ag/fields"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Open Crop Monitor →
            </Link>
            <Link to="/precision-ag/visualizations"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              See sample visualizations
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
