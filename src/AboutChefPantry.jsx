import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#2f7d4a';

const S = ({ children }) => (
  <svg width="22" height="22" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

const ICONS = {
  farm:    <S><path d="M1 14V7l7-5 7 5v7"/><path d="M6 14V9h4v5"/></S>,
  recipe:  <S><rect x="3" y="1" width="10" height="14" rx="1"/><line x1="6" y1="5" x2="10" y2="5"/><line x1="6" y1="8" x2="10" y2="8"/><line x1="6" y1="11" x2="9" y2="11"/></S>,
  cost:    <S><circle cx="8" cy="8" r="6"/><path d="M8 5v1.5M8 9.5V11"/><path d="M6 6.5c0-.8.9-1.5 2-1.5s2 .7 2 1.5S9.1 8 8 8s-2 .7-2 1.5S6.9 11 8 11s2-.7 2-1.5"/></S>,
  truck:   <S><rect x="1" y="5" width="10" height="8" rx="1"/><path d="M11 8h3l1 3v2h-4V8z"/><circle cx="4" cy="14" r="1.5"/><circle cx="12" cy="14" r="1.5"/></S>,
  repeat:  <S><path d="M4 4h8a3 3 0 0 1 0 6H4"/><path d="M7 7L4 4l3-3"/></S>,
  mail:    <S><rect x="1" y="3" width="14" height="10" rx="1"/><path d="M1 4l7 5 7-5"/></S>,
  market:  <S><path d="M2 3h12l-1 5H3L2 3z"/><path d="M3 8l1 5h8l1-5"/><line x1="8" y1="8" x2="8" y2="13"/><line x1="5.5" y1="8" x2="5.5" y2="13"/><line x1="10.5" y1="8" x2="10.5" y2="13"/></S>,
  pairsley:<S><path d="M8 14V8"/><path d="M5 11c0-3 3-4 3-7 0 3 3 4 3 7a3 3 0 0 1-6 0z"/><path d="M3 8c1-2 2.5-2.5 5-2"/><path d="M13 8c-1-2-2.5-2.5-5-2"/></S>,
  heart:   <S><path d="M8 13s-6-3.5-6-7a4 4 0 0 1 6-3.5A4 4 0 0 1 14 6c0 3.5-6 7-6 7z"/></S>,
};

const FEATURES = [
  {
    icon: ICONS.market,
    title: 'Farm-to-Table Marketplace',
    body: 'Browse produce, meat, and processed goods from farms in your region. Filter by category, distance, or farm. Every listing shows current availability, unit price, and minimum order — no cold calls, no guesswork.',
    cta: { label: 'Browse the marketplace', to: '/marketplaces/farm-to-table' },
  },
  {
    icon: ICONS.heart,
    title: 'My Farms',
    body: 'Save the farms you work with most into a curated shortlist. Quickly re-order from your trusted suppliers, check their current availability, and track your buying history — all in one place.',
    cta: { label: 'My saved farms', to: '/restaurant/farms' },
  },
  {
    icon: ICONS.repeat,
    title: 'Standing Orders',
    body: 'Set up recurring weekly, biweekly, or monthly orders with your go-to farms. Choose the day of delivery, quantity, and product — and adjust on the fly when something is short or something new comes in.',
    cta: { label: 'Manage standing orders', to: '/restaurant/standing-orders' },
  },
  {
    icon: ICONS.mail,
    title: 'Weekly Harvest Digest',
    body: 'Subscribe to a weekly email that shows everything available from OFN farms right now — or limit it to just your saved farms. Arrive at Monday prep with a clear picture of what\'s ripe and ready.',
    cta: { label: 'Set up your digest', to: '/restaurant/digest' },
  },
  {
    icon: ICONS.recipe,
    title: 'Recipe Library',
    body: 'Store your recipes in a structured library tied to your pantry. Attach ingredient quantities, methods, and tags — and pull up any recipe instantly when you\'re costing a menu or training a new cook.',
    cta: { label: 'Open chef dashboard', to: '/chef' },
  },
  {
    icon: ICONS.cost,
    title: 'Plate Costing',
    body: 'Cost any recipe against live wholesale prices from your saved farms. Get a per-plate food cost, food-cost percentage, and suggested menu price at your target margin — updated automatically when farm prices change.',
    cta: { label: 'Open chef dashboard', to: '/chef' },
  },
  {
    icon: ICONS.truck,
    title: 'Order Tracking',
    body: 'See all your pending and in-transit orders in one view. Farms mark orders confirmed and shipped with tracking details — and you\'ll get a notification the moment something changes.',
    cta: { label: 'Open chef dashboard', to: '/chef' },
  },
  {
    icon: ICONS.pairsley,
    title: 'Pairsley — Your AI Kitchen Partner',
    body: 'Pairsley rides along on every chef page. Ask what\'s available from your farms this week, get a seasonal menu drafted around what\'s ripe, cost a plate in real time, or set up a standing order — all from one conversation.',
    cta: { label: 'About Pairsley', to: '/platform/pairsley' },
  },
];

const QUOTES = [
  '"What\'s coming in from my saved farms this week?"',
  '"Draft three specials built around the fennel that just hit."',
  '"Cost a plate: 6 oz sirloin, roasted heirloom carrots, salsa verde."',
  '"Set up a weekly order of 10 lb of microgreens from Blackbird Farm."',
  '"I need 30 lb of beets by Thursday — who\'s got them?"',
  '"Update our website description to focus on our farm relationships."',
];

export default function AboutChefPantry() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Chef's Digital Pantry | Oatmeal Farm Network"
        description="A complete sourcing and kitchen management suite for chefs and restaurateurs — farm marketplace, standing orders, weekly harvest digest, recipes, plate costing, and Pairsley AI."
        canonical="https://oatmealfarmnetwork.com/chef-pantry"
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
                <path d="M5 2v5a3 3 0 0 0 6 0V2"/>
                <line x1="8" y1="10" x2="8" y2="14"/>
                <line x1="5" y1="14" x2="11" y2="14"/>
              </svg>
            </div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow">Chef's Digital Pantry</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            A complete sourcing and kitchen management suite that connects your restaurant directly
            to the farms that supply it — marketplace, standing orders, weekly digest, recipes,
            plate costing, and Pairsley AI, all in one place.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/chef"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Open Chef Dashboard →
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
        <div className="max-w-5xl mx-auto px-4 py-5 grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
          {[
            { v: '25+', l: 'Food categories' },
            { v: 'Live', l: 'Farm inventory' },
            { v: 'Weekly', l: 'Harvest digest' },
            { v: 'Real-time', l: 'Plate costing' },
          ].map(s => (
            <div key={s.l}>
              <div className="text-2xl font-bold" style={{ color: ACCENT }}>{s.v}</div>
              <div className="text-xs text-gray-500 mt-0.5 uppercase tracking-wide font-semibold">{s.l}</div>
            </div>
          ))}
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: "Chef's Digital Pantry" },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What it does
          </h2>
          <p className="text-gray-700 leading-relaxed">
            The Chef's Digital Pantry is OFN's end-to-end toolkit for food-service professionals.
            It connects your kitchen directly to farms in your region, gives you a clear view of
            what's available and at what price, and takes the friction out of sourcing local ingredients
            at scale — whether you're running a single bistro or a multi-location group.
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {FEATURES.map(f => (
              <FeatureCard key={f.title} icon={f.icon} title={f.title} body={f.body} cta={f.cta} />
            ))}
          </div>
        </section>

        {/* Ask Pairsley */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ask Pairsley anything
          </h2>
          <p className="text-gray-600 text-sm mb-4">
            Pairsley is available as a floating chat bubble on every chef and restaurant page.
            Here are a few things you can ask her right now:
          </p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {QUOTES.map((q, i) => (
              <div key={i}
                className="bg-white border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 italic">
                {q}
              </div>
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
            <Step n="1" title="Browse & save farms"
              body="Search the marketplace, discover farms near you, and save your favorites to My Farms for quick reordering." />
            <Step n="2" title="Order on your schedule"
              body="Place one-off orders or set up standing orders. Subscribe to the weekly harvest digest to plan your menu before you order." />
            <Step n="3" title="Cost your menu"
              body="Load your recipes into the Chef Dashboard, attach ingredients, and get a live food-cost breakdown at your target margin." />
          </div>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ready to source smarter?
          </h3>
          <p className="text-sm text-gray-600 mb-5">
            Free with any OFN restaurant account. Browse the marketplace without an account — sign up to save farms, place orders, and unlock Pairsley.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/marketplaces/farm-to-table"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Browse the marketplace →
            </Link>
            <Link to="/signup"
              className="px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-green-50"
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

function FeatureCard({ icon, title, body, cta }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 flex flex-col">
      <div className="flex items-center gap-2 mb-1">
        <span className="flex items-center shrink-0" style={{ color: ACCENT }}>{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600 leading-relaxed flex-1">{body}</p>
      <div className="mt-3">
        <Link to={cta.to}
          className="text-xs font-bold hover:underline"
          style={{ color: ACCENT }}>
          {cta.label} →
        </Link>
      </div>
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
