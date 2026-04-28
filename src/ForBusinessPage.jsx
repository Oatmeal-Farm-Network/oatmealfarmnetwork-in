import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

// ── Shared SVG wrapper ───────────────────────────────────────────
const S = ({ children }) => (
  <svg width="20" height="20" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

// ── Icons ────────────────────────────────────────────────────────
const I = {
  satellite: <S><rect x="5" y="1" width="6" height="4" rx="0.5"/><line x1="8" y1="5" x2="8" y2="8"/><circle cx="8" cy="10" r="3"/><line x1="1" y1="3" x2="4" y2="5"/><line x1="15" y1="3" x2="12" y2="5"/></S>,
  saige:     <S><path d="M8 14V8"/><path d="M5 11c0-3 3-4 3-7 0 3 3 4 3 7a3 3 0 0 1-6 0z"/></S>,
  livestock: <S><path d="M3 12c0-2.8 2.2-5 5-5s5 2.2 5 5"/><circle cx="8" cy="5" r="2.5"/><path d="M1 10c.5-1.5 1.5-2 2-2"/><path d="M15 10c-.5-1.5-1.5-2-2-2"/></S>,
  market:    <S><path d="M2 3h12l-1 5H3L2 3z"/><path d="M3 8l1 5h8l1-5"/><line x1="8" y1="8" x2="8" y2="13"/></S>,
  website:   <S><rect x="1" y="2" width="14" height="10" rx="1"/><line x1="4" y1="15" x2="12" y2="15"/><line x1="8" y1="12" x2="8" y2="15"/></S>,
  directory: <S><circle cx="8" cy="8" r="6"/><path d="M8 2c-2 1.5-3 3.5-3 6s1 4.5 3 6"/><path d="M8 2c2 1.5 3 3.5 3 6s-1 4.5-3 6"/><line x1="2" y1="8" x2="14" y2="8"/></S>,
  events:    <S><rect x="1" y="3" width="14" height="11" rx="1"/><path d="M5 3V1M11 3V1"/><line x1="1" y1="7" x2="15" y2="7"/></S>,
  assoc:     <S><path d="M8 1L2 4v4c0 3.5 2.5 6.5 6 7.5C14 14.5 14 8 14 8V4L8 1z"/></S>,
  rosemarie: <S><path d="M8 2c-1 2-3 3-3 5.5A3 3 0 0 0 8 11a3 3 0 0 0 3-3.5C11 5 9 4 8 2z"/><line x1="8" y1="11" x2="8" y2="14"/></S>,
  pairsley:  <S><path d="M5 2v5a3 3 0 0 0 6 0V2"/><line x1="8" y1="10" x2="8" y2="14"/><line x1="5" y1="14" x2="11" y2="14"/></S>,
  pantry:    <S><rect x="2" y="4" width="12" height="10" rx="1"/><path d="M5 4V2.5A1.5 1.5 0 0 1 6.5 1h3A1.5 1.5 0 0 1 11 2.5V4"/><line x1="8" y1="8" x2="8" y2="11"/><line x1="6" y1="9.5" x2="10" y2="9.5"/></S>,
  blog:      <S><path d="M11 2l3 3-8 8H3v-3z"/><line x1="9" y1="4" x2="12" y2="7"/></S>,
  source:    <S><path d="M4 8h8M8 4l4 4-4 4"/></S>,
};

// ── Page configs ─────────────────────────────────────────────────
const CONFIGS = {
  farms: {
    title: 'For Farms',
    color: '#3D6B34',
    heroTitle: 'OFN for Farms',
    heroSub: 'Everything a modern farm operation needs — from satellite field monitoring to selling your harvest directly to chefs and consumers.',
    what: 'Whether you grow vegetables, raise livestock, or do both, OFN gives your farm a full digital toolkit: precision agriculture, AI advisory, direct-to-consumer sales, a custom website, and connections to the broader food system.',
    tools: [
      { icon: I.satellite, title: 'Precision Agriculture', body: 'Monitor every field from space using six vegetation indices. Track crop health, soil moisture, GDD accumulation, and climate stress events in real time.', link: '/platform/precision-ag', cta: 'Learn about OatSense' },
      { icon: I.saige,     title: 'Saige — AI Farm Advisor', body: 'Ask Saige anything about your crops, soil, livestock, weather risk, or markets. She reads your field records and gives answers grounded in your actual operation.', link: '/platform/saige', cta: 'Meet Saige' },
      { icon: I.livestock, title: 'Livestock Marketplace', body: 'List your animals for sale to verified buyers across the country. Browse genetics, connect with breeders, and manage the whole transaction on-platform.', link: '/marketplaces/livestock', cta: 'Browse livestock' },
      { icon: I.market,    title: 'Farm-to-Table Marketplace', body: 'Sell your produce, eggs, meat, and artisan goods directly to restaurants and consumers. Set your own prices, manage orders, and get paid through Stripe.', link: '/marketplaces/farm-to-table', cta: 'Browse marketplace' },
      { icon: I.website,   title: 'Custom Farm Website', body: 'Launch a professional farm website in an afternoon. Farm-aware widgets pull your inventory, animals, events, and blog automatically — no copy-pasting required.', link: '/website-builder', cta: 'See Website Builder' },
      { icon: I.directory, title: 'OFN Directory Listing', body: 'Your farm appears in the OFN food-system directory, putting you in front of chefs, consumers, and buyers actively searching for local producers.', link: '/directory/farms-ranches', cta: 'View directory' },
      { icon: I.events,    title: 'Event Registration', body: 'Host farm tours, field days, workshops, and CSA open houses through OFN. Handle tickets, check-in, and post-event follow-ups without a separate platform.', link: '/event-registration', cta: 'See event tools' },
      { icon: I.assoc,     title: 'Association Support', body: 'Connect your farm to breed registries, grower cooperatives, and food-system associations that share the platform fees their members generate.', link: '/agriculture-support', cta: 'Learn more' },
    ],
    cta1: { label: 'Open OatSense →', to: '/oatsense' },
    cta2: { label: 'Create a free account', to: '/signup' },
    dir: '/directory/farms-ranches',
  },
  ranches: {
    title: 'For Ranches',
    color: '#7C5A3A',
    heroTitle: 'OFN for Ranches',
    heroSub: 'A full toolkit for livestock operations — buy and sell animals, monitor pastures, manage breeding records, and connect with the associations that matter to your herd.',
    what: 'OFN was built with ranching in mind. The livestock marketplace supports 28 species. The AI advisor knows parasite management and breeding calendars. The precision ag suite monitors pasture health from space. And your ranch gets a custom website that stays in sync with your records.',
    tools: [
      { icon: I.livestock, title: 'Livestock Marketplace', body: 'Buy and sell across 28 species with verified animal profiles, complete health histories, and genetics data. The most data-rich livestock marketplace in agriculture.', link: '/marketplaces/livestock', cta: 'Browse livestock' },
      { icon: I.saige,     title: 'Saige — AI Ranch Advisor', body: 'Nutrition plans, parasite management calendars, breeding schedules, and livestock health guidance — all tuned to your herd and region.', link: '/platform/saige', cta: 'Meet Saige' },
      { icon: I.satellite, title: 'Pasture Monitoring', body: 'Track pasture health and biomass across every paddock with satellite imagery. Know which pastures are stressed before your animals show it.', link: '/platform/precision-ag', cta: 'Learn about OatSense' },
      { icon: I.website,   title: 'Custom Ranch Website', body: 'A professional ranch website that pulls your animal listings, events, and blog directly from your OFN account — no duplicate data entry.', link: '/website-builder', cta: 'See Website Builder' },
      { icon: I.directory, title: 'OFN Directory Listing', body: 'Get found by buyers, breeders, and associations searching the OFN directory for ranches like yours.', link: '/directory/farms-ranches', cta: 'View directory' },
      { icon: I.events,    title: 'Event Registration', body: 'Run livestock shows, auctions, breed showcases, and ranch tours through OFN — with judge portals, barn card printing, and direct Stripe payouts.', link: '/event-registration', cta: 'See event tools' },
      { icon: I.assoc,     title: 'Breed Association Tools', body: 'Connect your ranch to breed registries and associations on OFN. Share your animals\' registry records directly from your account.', link: '/agriculture-support', cta: 'Learn more' },
      { icon: I.market,    title: 'Farm-to-Table Marketplace', body: 'List your grass-fed beef, pastured pork, and specialty meats directly to restaurants and consumers looking for traceable, local sources.', link: '/marketplaces/farm-to-table', cta: 'Browse marketplace' },
    ],
    cta1: { label: 'Browse livestock →', to: '/marketplaces/livestock' },
    cta2: { label: 'Create a free account', to: '/signup' },
    dir: '/directory/farms-ranches',
  },
  'artisan-producers': {
    title: 'For Artisan Producers',
    color: '#7C3F8B',
    heroTitle: 'OFN for Artisan Producers',
    heroSub: 'A dedicated marketplace, AI craft assistant, and professional website — built for mills, bakers, cheesemakers, and every kind of small-batch producer.',
    what: 'OFN gives artisan producers a direct channel to restaurants and consumers, a curated ingredient sourcing network, and an AI assistant who actually understands your craft. Rosemarie knows flour extraction rates, curd cuts, and fermentation schedules — and she keeps it tied to your actual shop.',
    tools: [
      { icon: I.market,    title: 'Farm-to-Table Marketplace', body: 'Sell your processed foods, specialty goods, and artisan products directly to chefs, restaurants, and consumers. Set your own prices and manage orders on your schedule.', link: '/marketplaces/farm-to-table', cta: 'Browse marketplace' },
      { icon: I.rosemarie, title: 'Rosemarie — AI Craft Assistant', body: 'Get production guidance, manage incoming wholesale orders, track par levels, and source raw ingredients — all from one conversation. Rosemarie knows your craft.', link: '/platform/rosemarie', cta: 'Meet Rosemarie' },
      { icon: I.source,    title: 'Source Farm Ingredients', body: 'Browse live listings for grain, dairy, fruit, honey, and specialty crops from farms across OFN. Filter by ingredient, region, and certification.', link: '/marketplaces/farm-to-table', cta: 'Source ingredients' },
      { icon: I.website,   title: 'Custom Producer Website', body: 'A professional website with your product catalog, story, and blog built in. Your OFN product listings populate your site automatically — no duplicate entry.', link: '/website-builder', cta: 'See Website Builder' },
      { icon: I.blog,      title: 'Built-in Blog', body: 'Share your process, your sourcing story, and seasonal releases. Your blog lives on your website and in the OFN directory — one post, two audiences.', link: '/website-builder', cta: 'See Website Builder' },
      { icon: I.directory, title: 'OFN Directory Listing', body: 'Appear in the artisan producers section of the OFN food-system directory, searchable by product type, region, and specialty.', link: '/directory/artisan-producers', cta: 'View directory' },
      { icon: I.events,    title: 'Event Registration', body: 'Host workshops, vendor fair booths, farm dinners, and tasting events through OFN. Collect registrations, manage capacity, and follow up with attendees.', link: '/event-registration', cta: 'See event tools' },
      { icon: I.assoc,     title: 'Guild & Association Connections', body: 'Connect with food-craft guilds, grower cooperatives, and producer associations that support artisan businesses at every scale.', link: '/agriculture-support', cta: 'Learn more' },
    ],
    cta1: { label: 'Browse marketplace →', to: '/marketplaces/farm-to-table' },
    cta2: { label: 'Create a free account', to: '/signup' },
    dir: '/directory/artisan-producers',
  },
  restaurants: {
    title: 'For Restaurants',
    color: '#2f7d4a',
    heroTitle: 'OFN for Restaurants',
    heroSub: 'A complete sourcing platform that connects your kitchen directly to the farms that supply it — with an AI sous chef built in.',
    what: 'OFN gives restaurants a single place to discover local farms, manage sourcing relationships, plan menus around what\'s in season, cost plates against live prices, and build a professional online presence — all with Pairsley, your AI food-service partner, riding along on every page.',
    tools: [
      { icon: I.pantry,    title: "Chef's Digital Pantry", body: 'Your complete sourcing suite — farm marketplace, saved farms, standing orders, weekly harvest digest, recipe library, and plate costing in one dashboard.', link: '/chef-pantry', cta: "See the Chef's Pantry" },
      { icon: I.market,    title: 'Farm-to-Table Marketplace', body: 'Browse fresh produce, pastured meats, specialty dairy, and artisan goods from farms in your region. Filter by product, distance, and availability.', link: '/marketplaces/farm-to-table', cta: 'Browse marketplace' },
      { icon: I.pairsley,  title: 'Pairsley — AI Kitchen Partner', body: 'Ask Pairsley what\'s available from your farms this week, get a seasonal menu drafted, cost a plate, or set up a standing order — all from one conversation.', link: '/platform/pairsley', cta: 'Meet Pairsley' },
      { icon: I.website,   title: 'Custom Restaurant Website', body: 'A professional restaurant website with your story, menu, farm partners, and blog. Lavendir AI can scrape your existing site and help you rebuild it on OFN.', link: '/website-builder', cta: 'See Website Builder' },
      { icon: I.directory, title: 'OFN Directory Listing', body: 'Your restaurant appears in the OFN food-system directory alongside the farms and producers you source from — a natural fit for farm-to-table positioning.', link: '/directory/restaurants', cta: 'View directory' },
      { icon: I.events,    title: 'Event Registration', body: 'Host farm dinners, tasting events, chef\'s table experiences, and cooking workshops through OFN — with ticketing, meal selection, and seating management.', link: '/event-registration', cta: 'See event tools' },
      { icon: I.blog,      title: 'Sourcing Blog', body: 'Tell your farm relationship story. A built-in blog lets you highlight your suppliers, seasonal specials, and the provenance behind your menu.', link: '/website-builder', cta: 'See Website Builder' },
      { icon: I.assoc,     title: 'Association & Guild Connections', body: 'Connect with culinary guilds, slow food chapters, and farm-to-table associations that support restaurant and chef communities on OFN.', link: '/agriculture-support', cta: 'Learn more' },
    ],
    cta1: { label: 'Browse the marketplace →', to: '/marketplaces/farm-to-table' },
    cta2: { label: 'Create a free account', to: '/signup' },
    dir: '/directory/restaurants',
  },
};

export default function ForBusinessPage({ type }) {
  const cfg = CONFIGS[type];
  const { t } = useTranslation();
  if (!cfg) return null;

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title={`${cfg.heroTitle} | Oatmeal Farm Network`}
        description={cfg.heroSub}
        canonical={`https://oatmealfarmnetwork.com/for-${type}`}
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: cfg.color }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <span className="text-xs font-bold uppercase tracking-widest text-white/80">Oatmeal Farm Network</span>
          <h1 className="text-4xl font-bold mt-2 mb-3 drop-shadow">{cfg.heroTitle}</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">{cfg.heroSub}</p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to={cfg.cta1.to}
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: cfg.color }}>
              {cfg.cta1.label}
            </Link>
            <Link to={cfg.cta2.to}
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              {cfg.cta2.label}
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: cfg.title },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('for_biz.what_ofn')}
          </h2>
          <p className="text-gray-700 leading-relaxed">{cfg.what}</p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('for_biz.tools_included')}
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {cfg.tools.map(t => (
              <ToolCard key={t.title} icon={t.icon} title={t.title} body={t.body}
                link={t.link} cta={t.cta} color={cfg.color} />
            ))}
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            {t('for_biz.ready_title')}
          </h3>
          <p className="text-sm text-gray-600 mb-5">
            {t('for_biz.ready_body')}
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/signup"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: cfg.color }}>
              {t('for_biz.create_free')}
            </Link>
            <Link to={cfg.dir}
              className="px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-gray-50"
              style={{ color: cfg.color, borderColor: cfg.color }}>
              {t('for_biz.browse_directory')}
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function ToolCard({ icon, title, body, link, cta, color }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 flex flex-col">
      <div className="flex items-center gap-2 mb-1">
        <span className="flex items-center shrink-0" style={{ color }}>{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600 leading-relaxed flex-1">{body}</p>
      <div className="mt-3">
        <Link to={link} className="text-xs font-bold hover:underline" style={{ color }}>
          {cta} →
        </Link>
      </div>
    </div>
  );
}
