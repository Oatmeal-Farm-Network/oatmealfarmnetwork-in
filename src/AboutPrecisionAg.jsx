import React from 'react';
import { Link } from 'react-router-dom';
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

const FEATURES = [
  {
    icon: ICONS.satellite,
    title: 'Satellite Crop Monitoring',
    body: 'Track field health from space using six vegetation indices — NDVI, NDRE, EVI, GNDVI, MSAVI2, and NDWI. View color-coded maps, run time-series analyses, and catch crop stress weeks before it becomes yield loss.',
  },
  {
    icon: ICONS.climate,
    title: 'Predictive Climate Stress',
    body: 'Get ahead of heatwaves, hard freezes, high-VPD drought events, heavy rain, and damaging wind. Each forecast includes onset timing, duration, peak intensity, and AI-generated recommended actions tailored to your crop type.',
  },
  {
    icon: ICONS.soil,
    title: 'Soil & Irrigation Intelligence',
    body: 'Log soil samples with pH, N, P, K, calcium, magnesium, CEC, and organic matter. Pair that with irrigation deficit forecasts — urgency levels tell you exactly when and how much to water, field by field.',
  },
  {
    icon: ICONS.gdd,
    title: 'Growing Degree Days & Maturity',
    body: 'Accumulate GDD against crop-specific models and watch milestone markers — emergence, tillering, flowering, grain fill, maturity — update in real time. Harvest timing predictions are recalculated as the season progresses.',
  },
  {
    icon: ICONS.scout,
    title: 'Field Scouting & Activity Log',
    body: 'Record pest, disease, weed, nutrient, and irrigation observations with severity ratings and GPS coordinates. The activity log captures every field operation — spray, fertilize, tillage, irrigation, harvest — in a searchable timeline.',
  },
  {
    icon: ICONS.zones,
    title: 'Management Zones & Prescriptions',
    body: 'Automatically segment your fields into high, medium, and low performance zones using k-means clustering on your satellite indices. Generate variable-rate application prescriptions for seed, fertilizer, or chemicals from those zones.',
  },
  {
    icon: ICONS.yield,
    title: 'Yield Forecasting',
    body: 'Predict end-of-season yield with high, medium, or low confidence based on NDVI trends, GDD accumulation, and historical baselines. Track forecast accuracy over time to calibrate the model to your specific conditions.',
  },
  {
    icon: ICONS.carbon,
    title: 'Carbon & Crop Rotation',
    body: 'Monitor soil organic matter trends and get a carbon sequestration score that reflects your management practices. Plan multi-year crop rotations to optimize soil health, reduce pest pressure, and meet sustainability goals.',
  },
  {
    icon: ICONS.alert,
    title: 'Smart Alert Dashboard',
    body: 'All critical signals — NDVI decline, pest or disease flags, irrigation urgency, frost risk — surface in one prioritized alert feed. Color-coded severity means you know at a glance what needs attention today versus this week.',
  },
  {
    icon: ICONS.report,
    title: 'Professional Field Reports',
    body: 'Generate print-ready or emailable field assessment reports with health scores, satellite analysis summaries, soil data, and agronomic recommendations. Share directly with agronomists, lenders, or buyers.',
  },
];

const STATS = [
  { value: '6', label: 'Vegetation indices' },
  { value: '10+', label: 'Analysis modules' },
  { value: '24h', label: 'Climate forecast horizon' },
  { value: '∞', label: 'Fields per account' },
];

export default function AboutPrecisionAg() {
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
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>
            Precision Agriculture
          </h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Satellite imagery, climate forecasting, soil intelligence, and yield prediction — unified
            into one platform that turns field data into decisions you can act on today.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/oatsense"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Open OatSense Dashboard →
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Open An Account
            </Link>
          </div>
        </div>
      </div>

      {/* Stats bar */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 py-5 grid grid-cols-2 md:grid-cols-4 gap-4">
          {STATS.map(s => (
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
            What it does
          </h2>
          <p className="text-gray-700 leading-relaxed">
            OatSense is OFN's precision agriculture suite — a full set of tools that connect satellite
            imagery, weather models, soil records, and field observations into a single coherent picture
            of your operation. Whether you're managing one field or fifty, the platform scales with you
            and keeps every decision grounded in real data.
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {FEATURES.map(f => (
              <FeatureCard key={f.title} icon={f.icon} title={f.title} body={f.body} />
            ))}
          </div>
        </section>

        {/* How it works */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            How it works
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Step n="1" title="Add your fields"
              body="Draw field boundaries on the map or enter coordinates. Assign a crop type, planting date, and any soil data you have on hand." />
            <Step n="2" title="Data populates automatically"
              body="Satellite passes update your vegetation indices on every clear-sky overpass. Weather models pull hourly forecasts for your exact coordinates." />
            <Step n="3" title="Act on what matters"
              body="Alerts surface the highest-priority issues. Reports package everything for your agronomist, lender, or co-op in one click." />
          </div>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ready to see your fields from space?
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free with any OFN account. Add your first field and get your first satellite analysis in minutes.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/oatsense"
              className="inline-block px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Open OatSense →
            </Link>
            <Link to="/signup"
              className="inline-block px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-gray-50"
              style={{ color: ACCENT, borderColor: ACCENT }}>
              Create a free account
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
