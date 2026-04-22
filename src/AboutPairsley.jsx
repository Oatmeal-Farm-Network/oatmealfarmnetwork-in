// src/AboutPairsley.jsx
// Marketing / about page for Pairsley — the AI agent for restaurants & professional kitchens.
// Route: /platform/pairsley
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#2f7d4a';

export default function AboutPairsley() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Pairsley | AI Agent for Restaurants & Professional Kitchens"
        description="Pairsley is the Oatmeal Farm Network AI agent for restaurateurs, chefs, and professional kitchens — sourcing, seasonal menus, costing, and vendor relationships."
        canonical="https://oatmealfarmnetwork.com/platform/pairsley"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🍳</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">AI Agent</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Meet Pairsley</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Your AI food-service partner — for restaurateurs, chefs, and professional kitchens. Sourcing,
            seasonal menus, dish costing, and vendor relationships, all grounded in the actual farms near you.
          </p>
          <p className="mt-2 text-sm text-white/80 italic">(Pronounced "parsley" — the herb, with a twist.)</p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/restaurant/farms"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Open Pairsley →
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
          { label: 'Services', to: '/platform' },
          { label: 'Pairsley' },
        ]} />

        {/* What Pairsley Does */}
        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What Pairsley does
          </h2>
          <p className="text-gray-700 leading-relaxed">
            Pairsley is a conversational AI purpose-built for people who cook for a living. She knows your
            concept, your vendors, your menu structure, and the produce, meat, and artisan goods on offer
            from farms in your region. She helps you write tonight's specials, cost a plate, chase down a
            short order, and keep your saved-farm roster tight — and she can make profile changes for you
            directly, from inside the chat.
          </p>
        </section>

        {/* Capabilities */}
        <section className="mt-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Capabilities
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Capability icon="🥬" title="What's available this week"
              body="Real-time view of what's harvestable and in inventory at farms near you — and a weekly email digest if you'd rather have it pushed." />
            <Capability icon="📋" title="Seasonal menu help"
              body="Draft specials and tasting menus tuned to what's actually ripe, with allergen notes and ingredient sourcing baked in." />
            <Capability icon="💵" title="Plate costing & margin"
              body="Cost out a dish with current wholesale prices from your saved farms and price it to your target food cost." />
            <Capability icon="🤝" title="Vendor & farm relationships"
              body="Track your saved farms, recurring orders, and standing relationships — Pairsley keeps the roster tidy." />
            <Capability icon="🛒" title="Standing orders"
              body="Set up weekly standing orders with farms and adjust on the fly when something is short or something new comes in." />
            <Capability icon="⚙️" title="Account changes from chat"
              body="Update your restaurant profile, website, slogan, and contact info without leaving the conversation." />
          </div>
        </section>

        {/* How it connects */}
        <section className="mt-10 bg-white border border-gray-200 rounded-2xl p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Built on top of the farm-to-table marketplace
          </h2>
          <p className="text-sm text-gray-700 leading-relaxed mb-3">
            Pairsley plugs directly into the rest of the restaurant toolkit on Oatmeal Farm Network, so every
            answer is grounded in real inventory and real farms:
          </p>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            <MiniTile to="/marketplaces/farm-to-table" icon="🛒" title="Farm 2 Table" body="Browse produce, meat, and processed foods from farms in your region." />
            <MiniTile to="/restaurant/farms" icon="❤️" title="My Farms" body="Your saved-farm list for quick re-ordering and standing relationships." />
            <MiniTile to="/restaurant/standing-orders" icon="🔁" title="Standing Orders" body="Recurring weekly orders from the farms you trust most." />
            <MiniTile to="/restaurant/digest" icon="📬" title="Weekly Digest" body="An email every week with everything available now — perfect for menu planning." />
            <MiniTile to="/chef/dashboard" icon="👨‍🍳" title="Chef Dashboard" body="Your command center for menus, costing, specials, and sourcing." />
          </div>
        </section>

        {/* Example conversations */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What you can ask
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {[
              '"What\'s coming in from my saved farms this week?"',
              '"Draft three specials built around the fennel that just hit."',
              '"Cost a plate: 6 oz sirloin, roasted heirloom carrots, salsa verde."',
              '"Set up a weekly standing order of 10 lb of microgreens from Blackbird Farm."',
              '"Update our website slogan to \'Produce-forward, plain-spoken\'."',
              '"I need 30 lb of beets by Thursday — who\'s got them?"',
            ].map((q, i) => (
              <div key={i} className="bg-white border border-gray-200 rounded-xl p-4 text-sm text-gray-800 italic">
                {q}
              </div>
            ))}
          </div>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Put Pairsley to work in your kitchen
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free with any OFN restaurant account. Pairsley is available as a popup or full-screen chat on every
            restaurant page in the app.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/chef/dashboard"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Open Chef Dashboard →
            </Link>
            <Link to="/marketplaces/farm-to-table"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              Browse Farm 2 Table
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

function MiniTile({ to, icon, title, body }) {
  return (
    <Link to={to} className="block bg-gray-50 border border-gray-200 rounded-lg p-3 hover:border-[#2f7d4a] transition no-underline">
      <div className="flex items-center gap-2 mb-1">
        <span className="text-lg">{icon}</span>
        <h4 className="font-bold text-gray-900 text-sm">{title}</h4>
      </div>
      <p className="text-xs text-gray-600">{body}</p>
    </Link>
  );
}
