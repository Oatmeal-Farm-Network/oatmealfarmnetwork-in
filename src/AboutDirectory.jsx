// src/AboutDirectory.jsx
// Route: /platform/directory
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';

export default function AboutDirectory() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Directory | Oatmeal Farm Network"
        description="A searchable directory of farms, ranches, mills, bakers, chefs, and agricultural businesses on Oatmeal Farm Network. Filter by product, livestock breed, certification, and region."
        canonical="https://oatmealfarmnetwork.com/platform/directory"
      />
      <Header />

      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">📖</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Directory</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            A searchable directory of farms, ranches, mills, bakers, chefs, and agricultural businesses —
            all on Oatmeal Farm Network. Filter by product, livestock breed, certification, region, and more.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/directory"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Browse the directory →
            </Link>
            <Link to="/account"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Claim your profile
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Directory' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Your business card on the public internet
          </h2>
          <p className="text-gray-700 leading-relaxed">
            Every OFN account gets a directory profile — no tiered pricing, no "premium listing" upsell.
            Photos, story, products, events, and contact info in one place, at an address you can hand out.
            The directory is how chefs find new suppliers, how breeders find new bloodlines, and how community
            members find the people growing their food.
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Searchable by everything that matters
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {[
              { icon: '🌽', label: 'Product' },
              { icon: '🐑', label: 'Livestock species' },
              { icon: '🧬', label: 'Breed' },
              { icon: '📍', label: 'Region' },
              { icon: '🚚', label: 'Delivery radius' },
              { icon: '🏅', label: 'Certifications' },
              { icon: '🌱', label: 'Growing practices' },
              { icon: '🛒', label: 'What they sell' },
            ].map(x => (
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
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon="🆓" title="Free for members"
              body="Every OFN account gets a directory profile. No tiered pricing to get listed." />
            <Feature icon="📸" title="Rich profiles"
              body="Hero photo, story, logo, contact, address map, product gallery, and linked events and blog posts." />
            <Feature icon="🔍" title="SEO-indexed"
              body="Directory pages are public and indexable. Buyers searching for your breed or your county can find you on Google." />
            <Feature icon="🔁" title="One source of truth"
              body="Your directory profile updates automatically when you add products, animals, or events. No double data entry." />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Get on the map
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free with any OFN account. Claim your business card and fill it in — it takes about fifteen minutes.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/directory"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Browse the directory →
            </Link>
            <Link to="/account"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              Claim your profile
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
