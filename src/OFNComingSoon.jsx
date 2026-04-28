import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';
const WARM   = '#f7f2e8';

// ── Audience section data ────────────────────────────────────────────
const SECTIONS = [
  {
    id:    'farms',
    img:   '/images/FarmsPageHeader.webp',
    color: '#3D6B34',
    link:  '/for-farms',
    label: 'For Farmers',
    headline: 'Run a smarter, more connected farm',
    body: `Farmers are at the heart of the Oatmeal Farm Network. Whether you grow row crops, fruits, or vegetables, the platform gives you a single home for everything: AI-powered precision agriculture to monitor fields and forecast yields, a direct-to-buyer marketplace to sell local produce, a professional website to tell your story, and event listings to bring your community to your gate. Our AI advisor Saige provides on-demand agronomic guidance tailored to your specific crops, climate, and soil — like having an expert on call, every day of the season.`,
    features: [
      'Precision Ag dashboard — satellite NDVI, soil health, GDD, irrigation & yield forecasts',
      'Farm-to-Table marketplace — list products and reach local chefs and buyers directly',
      'AI Advisor Saige — agronomic Q&A, pest ID, and crop management guidance',
      'Farm directory listing — be discovered by buyers, partners, and agritourists',
      'Custom farm website — built-in, no coding required',
      'Event registration — host farm tours, pick-your-own days, and workshops',
    ],
  },
  {
    id:    'ranches',
    img:   '/images/RanchesHeader.webp',
    color: '#7C5A3A',
    link:  '/for-ranches',
    label: 'For Ranchers',
    headline: 'Manage your herd and grow your market',
    body: `Ranchers can list and sell livestock through a dedicated livestock marketplace, manage herd records and breeding data, and access AI-assisted herd health guidance. The platform connects you with buyers, breed associations, and feed suppliers — all from one dashboard. Whether you run a commercial cow-calf operation or a rare heritage breed ranch, the Oatmeal Farm Network helps you build a business that's visible and thriving year-round.`,
    features: [
      'Livestock marketplace — list cattle, sheep, goats, hogs, horses, and more',
      'Herd management — track animals, breeding records, and lineage',
      'AI Advisor Saige — herd health Q&A and pasture management guidance',
      'Ranch directory listing — attract buyers and breeders nationwide',
      'Precision Ag tools — field monitoring and pasture productivity tracking',
      'Association support — connect with breed registries and industry groups',
    ],
  },
  {
    id:    'restaurants',
    img:   '/images/Restaurants.webp',
    color: '#2f7d4a',
    link:  '/for-restaurants',
    label: 'For Restaurants',
    headline: 'Source local. Cook confidently. Build loyalty.',
    body: `The Oatmeal Farm Network gives restaurants a direct line to local farms and artisan producers. Browse the Farm-to-Table marketplace by ingredient, season, or region; set up standing orders with your favorite farm; and let our AI chef assistant Pairsley help you craft menus around what's freshest and most available. Your weekly digest tells you exactly what's in season and who has it — so you spend less time sourcing and more time cooking.`,
    features: [
      'Chef Pantry — browse and order local ingredients directly from farms',
      'Standing orders — schedule recurring deliveries from trusted producers',
      'AI Advisor Pairsley — menu ideation and pairing suggestions based on what\'s in season',
      'Restaurant directory listing — be found by food-curious diners in your area',
      'Event listings — advertise farm dinners, tastings, and private events',
      'Weekly marketplace digest — curated local availability sent to your inbox',
    ],
  },
  {
    id:    'artisan',
    img:   '/images/ArtisanProducers.webp',
    color: '#7C3F8B',
    link:  '/for-artisan-producers',
    label: 'For Artisan Producers',
    headline: 'Bring your craft to a wider table',
    body: `Whether you produce small-batch cheese, heritage-grain flour, craft vinegar, fermented foods, or handmade preserves, the Oatmeal Farm Network gives you a marketplace, a story, and an audience. List your products directly to restaurants and consumers, build a brand website, and let AI advisor Rosemarie help you trace your ingredients and communicate the provenance of your craft. Buyers who care about how food is made are looking for you — we make sure they find you.`,
    features: [
      'Farm-to-Table marketplace — sell direct to restaurants and consumers',
      'AI Advisor Rosemarie — ingredient sourcing, traceability, and product story guidance',
      'Artisan directory listing — be discovered by chefs, retailers, and food enthusiasts',
      'Custom producer website — showcase your process, values, and products',
      'Event listings — farmers\' markets, pop-ups, and tasting events',
      'Association support — connect with food craft guilds and regional producer groups',
    ],
  },
  {
    id:    'assoc',
    img:   '/images/CoreFeaturesAssociationSupport.webp',
    color: '#B45309',
    link:  '/agriculture-support',
    label: 'For Associations',
    headline: 'Serve your members. Strengthen your industry.',
    body: `Breed registries, grower cooperatives, farm bureaus, and agricultural nonprofits all have one thing in common: they exist to serve their members and advance the industry. The Oatmeal Farm Network provides associations with a full suite of digital infrastructure — member directories, event registration, breed registries, and communications tools — so you can focus on mission rather than administration. Our platform was built from the ground up to handle the complexity of multi-tier membership organizations.`,
    features: [
      'Member directory — searchable, branded listing for your entire membership',
      'Event registration — full-featured show and conference management',
      'Breed registry — lineage records, health data, and EPD management',
      'Association website — professional web presence with no technical overhead',
      'Email campaigns — newsletters and announcements to your membership',
      'AI advisor integration — give your members access to expert-level guidance',
    ],
  },
];

// ── Small helper components ──────────────────────────────────────────

function FeatureChip({ text }) {
  return (
    <li className="flex items-start gap-2 text-sm text-gray-700 leading-snug">
      <span style={{ color: ACCENT, flexShrink: 0, marginTop: '2px' }}>✓</span>
      {text}
    </li>
  );
}

function AudienceSection({ section, flip }) {
  return (
    <section className="mb-14">
      <div className={`flex flex-col ${flip ? 'lg:flex-row-reverse' : 'lg:flex-row'} gap-6 items-stretch`}>
        {/* Image */}
        <div className="lg:w-2/5 shrink-0 rounded-xl overflow-hidden shadow-sm" style={{ minHeight: '260px' }}>
          <img
            src={section.img}
            alt={section.label}
            className="w-full h-full object-cover"
            style={{ minHeight: '260px' }}
            loading="lazy"
            onError={e => { e.target.onerror = null; e.target.style.display = 'none'; }}
          />
        </div>

        {/* Text */}
        <div className="flex-1 bg-white rounded-xl border border-gray-200 px-7 py-6 shadow-sm flex flex-col justify-between">
          <div>
            <span
              className="inline-block text-xs font-bold uppercase tracking-wider px-3 py-1 rounded-full mb-3"
              style={{ backgroundColor: `${section.color}18`, color: section.color }}
            >
              {section.label}
            </span>
            <h2
              className="text-xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}
            >
              {section.headline}
            </h2>
            <p className="text-sm text-gray-700 leading-relaxed mb-5">{section.body}</p>
            <ul className="space-y-2 mb-6">
              {section.features.map((f, i) => <FeatureChip key={i} text={f} />)}
            </ul>
          </div>
          <div>
            <Link
              to={section.link}
              className="inline-flex items-center gap-1 text-sm font-bold hover:underline"
              style={{ color: section.color }}
            >
              Learn more about {section.label.replace('For ', '')} →
            </Link>
          </div>
        </div>
      </div>
    </section>
  );
}

// ── Page ─────────────────────────────────────────────────────────────

export default function OFNComingSoon() {
  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: WARM }}>
      <PageMeta
        title="Coming Soon: Oatmeal Farm Network Opening for Business | OFN"
        description="Oatmeal Farm Network is launching in 2026 — one integrated platform for farmers, ranchers, restaurants, artisan producers, and agricultural associations."
        canonical="https://oatmealfarmnetwork.com/news"
      />
      <Header />

      {/* Breadcrumbs */}
      <div className="mx-auto px-4 pt-4" style={{ maxWidth: '1100px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Coming Soon: Open for Business' },
        ]} />
      </div>

      {/* Hero */}
      <div className="mx-auto px-4 pt-3 pb-10" style={{ maxWidth: '1100px' }}>
        <div className="relative rounded-xl overflow-hidden shadow-md">
          <img
            src="/images/HomePageComingsoon.webp"
            alt="Oatmeal Farm Network — Opening Soon"
            className="w-full object-cover"
            style={{ height: '320px' }}
            loading="eager"
            onError={e => { e.target.onerror = null; e.target.style.display = 'none'; }}
          />
          <div
            className="absolute inset-0"
            style={{ background: 'linear-gradient(to right, rgba(0,0,0,0.72) 0%, rgba(0,0,0,0.45) 55%, rgba(0,0,0,0) 85%)' }}
          />
          <div className="absolute inset-0 flex flex-col justify-center px-10 py-8" style={{ maxWidth: '700px' }}>
            <span className="text-xs font-bold uppercase tracking-widest text-yellow-300 mb-2">Company News · 2026</span>
            <h1
              className="text-white font-bold mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif", fontSize: 'clamp(1.6rem, 4vw, 2.4rem)', lineHeight: 1.2 }}
            >
              Coming Soon: Oatmeal Farm Network Is Opening for Business
            </h1>
            <p className="text-white/85 text-sm leading-relaxed">
              One integrated platform for the entire local food ecosystem — from field to fork.
            </p>
          </div>
        </div>
      </div>

      {/* Article body */}
      <div className="mx-auto px-4 pb-16" style={{ maxWidth: '1100px' }}>

        {/* Lead */}
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm px-8 py-7 mb-12">
          <p
            className="text-lg font-semibold text-gray-800 leading-relaxed mb-4"
            style={{ fontFamily: "'Lora','Times New Roman',serif" }}
          >
            The Oatmeal Farm Network is entering its final phase of preparation before a full 2026 launch — and the platform arriving is unlike anything the agricultural industry has seen before.
          </p>
          <p className="text-sm text-gray-700 leading-relaxed mb-4">
            For years, the people who grow, raise, prepare, and celebrate food have been asked to stitch together dozens of disconnected tools: one app for herd records, another for online sales, a spreadsheet for orders, a third-party site for events, and countless email threads to manage relationships with buyers and suppliers. Oatmeal Farm Network was built to end that fragmentation.
          </p>
          <p className="text-sm text-gray-700 leading-relaxed mb-4">
            At its core, OFN is a <strong>digital nervous system for local and regional food systems</strong> — a single, integrated platform where farms, ranches, restaurants, artisan producers, and agricultural associations can all operate, connect, and grow. Every tool on the platform is designed to work together, so that a farm's inventory flows directly into a restaurant's sourcing dashboard, a breed association's registry connects to a rancher's herd records, and an artisan producer's product listing reaches the right chefs without a middleman.
          </p>
          <p className="text-sm text-gray-700 leading-relaxed">
            We are currently onboarding a select group of pilot businesses and associations to refine the experience before opening fully to the public. Whether you are a fourth-generation cattle rancher, a two-year-old craft creamery, or a regional grower cooperative, there will be a place for you here. Read on to learn what OFN will do for each part of the food ecosystem.
          </p>
        </div>

        {/* AI callout */}
        <div
          className="rounded-xl overflow-hidden shadow-sm mb-12 flex flex-col sm:flex-row"
          style={{ border: `1px solid ${ACCENT}30` }}
        >
          <div className="sm:w-56 shrink-0">
            <img
              src="/images/SaigeBanner.webp"
              alt="AI Advisors"
              className="w-full h-full object-cover"
              style={{ minHeight: '160px' }}
              loading="lazy"
              onError={e => { e.target.onerror = null; e.target.style.display = 'none'; }}
            />
          </div>
          <div className="flex-1 px-7 py-6" style={{ backgroundColor: `${ACCENT}08` }}>
            <h2
              className="font-bold text-gray-900 text-lg mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}
            >
              AI Advisors Built for Agriculture
            </h2>
            <p className="text-sm text-gray-700 leading-relaxed mb-3">
              Every account on OFN has access to a suite of AI advisors designed specifically for their role in the food system. <strong>Saige</strong> assists farmers and ranchers with crop management, herd health, and agronomic questions. <strong>Pairsley</strong> helps chefs and restaurants develop menus around seasonal local ingredients. <strong>Rosemarie</strong> guides artisan producers through ingredient traceability and product storytelling. <strong>Thaiyme</strong> supports food businesses with compliance, labeling, and market intelligence.
            </p>
            <p className="text-sm text-gray-700 leading-relaxed">
              These aren't generic chatbots — they are purpose-built advisors trained on agricultural science, food industry knowledge, and the real-time data flowing through the OFN platform.
            </p>
            <div className="flex flex-wrap gap-3 mt-4">
              <Link to="/platform/saige"     className="text-xs font-bold hover:underline" style={{ color: ACCENT }}>Saige →</Link>
              <Link to="/platform/pairsley"  className="text-xs font-bold hover:underline" style={{ color: ACCENT }}>Pairsley →</Link>
              <Link to="/platform/rosemarie" className="text-xs font-bold hover:underline" style={{ color: ACCENT }}>Rosemarie →</Link>
              <Link to="/platform/thaiyme"   className="text-xs font-bold hover:underline" style={{ color: ACCENT }}>Thaiyme →</Link>
            </div>
          </div>
        </div>

        {/* Per-audience sections */}
        <h2
          className="text-2xl font-bold text-gray-900 mb-8"
          style={{ fontFamily: "'Lora','Times New Roman',serif" }}
        >
          Who OFN Is Built For
        </h2>

        {SECTIONS.map((s, i) => (
          <AudienceSection key={s.id} section={s} flip={i % 2 !== 0} />
        ))}

        {/* Closing CTA */}
        <div
          className="rounded-xl px-8 py-8 flex flex-col sm:flex-row items-center justify-between gap-6 shadow-sm"
          style={{ backgroundColor: ACCENT, color: '#fff' }}
        >
          <div>
            <h3
              className="font-bold text-xl mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}
            >
              Ready to be part of the network?
            </h3>
            <p className="text-sm text-white/85 leading-relaxed max-w-lg">
              Create your free account today. Whether you're a farm, a restaurant, an artisan producer, or an association, your place in the network is waiting.
            </p>
          </div>
          <div className="flex flex-wrap gap-3 shrink-0">
            <Link
              to="/signup"
              className="px-6 py-2.5 rounded-lg font-bold text-sm shadow"
              style={{ backgroundColor: '#fff', color: ACCENT }}
            >
              Create Free Account
            </Link>
            <Link
              to="/directory"
              className="px-6 py-2.5 rounded-lg font-bold text-sm border-2 border-white/60 hover:bg-white/10 transition"
              style={{ color: '#fff' }}
            >
              Browse the Directory
            </Link>
          </div>
        </div>

      </div>

      <Footer />
    </div>
  );
}
