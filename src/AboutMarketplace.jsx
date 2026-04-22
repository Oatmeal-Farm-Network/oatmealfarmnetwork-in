// src/AboutMarketplace.jsx
// Route: /platform/marketplace
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#A3301E';

export default function AboutMarketplace() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Marketplace | Oatmeal Farm Network"
        description="List farm products once and appear in Farm 2 Table (chefs), Products (consumers), and Livestock (ranches). Stripe Connect payouts built in."
        canonical="https://oatmealfarmnetwork.com/platform/marketplace"
      />
      <Header />

      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🛒</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Marketplace</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            List your farm products once and they show up everywhere buyers are looking — Farm 2 Table for
            chefs, the general Products marketplace for consumers, and the Livestock marketplace for ranches.
            Stripe payouts, messaging, and order tracking are built in.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/account"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Start selling →
            </Link>
            <Link to="/marketplaces/farm-to-table"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Browse Farm 2 Table
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Marketplace' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Three marketplaces, one listing
          </h2>
          <p className="text-gray-700 leading-relaxed">
            Every product you add to OFN flows into the right marketplaces automatically. A case of heirloom
            tomatoes shows up in Farm 2 Table for chefs. A pint of raspberry jam goes into the Products
            marketplace for direct-to-consumer. A registered Angus bull goes into the Livestock marketplace
            for other ranches. One record, many storefronts.
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            The three marketplaces
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <MarketCard to="/marketplaces/farm-to-table" icon="🍽️"
              title="Farm 2 Table"
              body="Wholesale to chefs, restaurants, and professional kitchens. Wholesale pricing unlocks for verified buyers." />
            <MarketCard to="/marketplace/products" icon="🛍️"
              title="Products"
              body="Direct-to-consumer for jams, baked goods, eggs, produce, meat shares, honey, fiber — the whole farm shop." />
            <MarketCard to="/marketplaces/livestock" icon="🐄"
              title="Livestock"
              body="Breeding stock, stud service, and sale animals across cattle, sheep, goats, poultry, and more." />
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon="💳" title="Stripe Connect payouts"
              body="Connect your Stripe account and get paid directly. We never touch the money — your payouts land in your bank." />
            <Feature icon="🏷️" title="Wholesale + retail pricing"
              body="Show retail by default and unlock wholesale pricing for verified restaurant and co-op buyers." />
            <Feature icon="📜" title="Provenance cards"
              body="Every product can print a provenance card showing the farm, the field, and the animal it came from." />
            <Feature icon="💬" title="Buyer messaging"
              body="Questions about harvest dates, cuts, or dietary details flow into your OFN inbox — not a spam folder." />
            <Feature icon="📦" title="Order tracking"
              body="Confirm, reject, and ship orders from one dashboard. Tracking numbers and ETAs flow back to the buyer automatically." />
            <Feature icon="🌱" title="Seasonal + harvest-date aware"
              body="Listings know when produce is ready and fall off the marketplace when the window closes — no dead listings." />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ready to sell?
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free to list. Standard Stripe fees apply to payouts. No OFN commission on your first $1,000 in sales.
          </p>
          <Link to="/account"
            className="inline-block px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
            style={{ backgroundColor: ACCENT }}>
            Start selling →
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

function MarketCard({ to, icon, title, body }) {
  return (
    <Link to={to} className="block bg-white border border-gray-200 rounded-xl p-5 hover:border-[#A3301E] transition no-underline">
      <div className="flex items-center gap-2 mb-2">
        <span className="text-2xl">{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600">{body}</p>
    </Link>
  );
}
