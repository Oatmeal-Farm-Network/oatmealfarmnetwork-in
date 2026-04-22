// src/AboutWebsiteBuilder.jsx
// Route: /platform/website-builder
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';

export default function AboutWebsiteBuilder() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Website Builder | Oatmeal Farm Network"
        description="Launch a professional farm website in an afternoon with farm-aware drag-and-drop widgets, custom domains, and built-in AI help from Lavendir."
        canonical="https://oatmealfarmnetwork.com/platform/website-builder"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🖥️</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Website Builder</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Launch a professional farm website in an afternoon — not three months. Every widget is farm-aware,
            so your inventory, ranch profile, blog, and events stay in sync with the rest of your account.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/website/builder"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Build your site →
            </Link>
            <Link to="/account"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Open my account
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Website Builder' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What it does
          </h2>
          <p className="text-gray-700 leading-relaxed">
            A drag-and-drop site builder tuned for farms, ranches, and artisan producers.
            Pick from farm-aware widgets that already know about your inventory, your animals,
            your events, and your blog posts — drop them onto a page and they populate themselves.
            No copy-paste. No re-entering data.
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon="🧩" title="Widgets tuned to farms"
              body="Product catalogs, animal-of-the-week, upcoming events, blog feeds, testimonials, contact forms, photo galleries — all drag-and-drop." />
            <Feature icon="🔗" title="One source of truth"
              body="Add an animal or list a product once, and it appears on your website, your OFN directory profile, and the marketplace automatically." />
            <Feature icon="🌐" title="Custom domains"
              body="Point your own domain at your OFN site in minutes. SSL is automatic; DNS is straightforward — we walk you through it." />
            <Feature icon="💜" title="Lavendir AI help built in"
              body="Need a new page? Ask Lavendir, our design-assistant AI, to draft it for you. Publishing still requires your review." />
            <Feature icon="📱" title="Mobile-first"
              body="Every layout is responsive by default. Preview desktop, tablet, and phone side-by-side before you publish." />
            <Feature icon="📝" title="Built-in blog"
              body="Your OFN blog lives on your website and in the OFN directory. Write once, reach both audiences." />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ready to build?
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free with any OFN account. Start from a template and publish in under an hour.
          </p>
          <Link to="/website/builder"
            className="inline-block px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
            style={{ backgroundColor: ACCENT }}>
            Build your site →
          </Link>
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
