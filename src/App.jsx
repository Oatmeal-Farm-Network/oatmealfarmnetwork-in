/**
 * Home page — rebuilt to the 2026-04-27 mockup.
 *
 * Layout:
 *   1. Hero (split): tagline + intro + CTA on left, hero image with quote on right
 *   2. Stats bar (dark green strip with 4 KPIs)
 *   3. "Built for the Ecosystem" — 4-card grid (Farm / Ranches / Artisan / Restaurants)
 *   4. Company News + Market News — two horizontal cards (image-right alternation)
 *   5. "Core Features" — 3x3 grid of 9 feature cards
 *   6. Footer (existing component)
 *
 * All images are pulled from /public/images. Replace any of the IMG_* constants
 * if you want a different shot in a particular slot.
 */
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

// ─── Image map ────────────────────────────────────────────────────────────────
// Hand-mapped to existing files in /public/images so a fresh checkout renders
// without needing new assets. Swap any of these one-liners to update a slot.
const IMG_HERO         = '/images/HomePageField.webp';
const IMG_FARM         = '/images/Farm.webp';
const IMG_RANCHES      = '/images/Cattle.webp';
const IMG_ARTISAN      = '/images/ArtisanProducers.webp';
const IMG_RESTAURANTS  = '/images/Restaurants.webp';
const IMG_COMPANY_NEWS = '/images/Field2.webp';
const IMG_MARKET_NEWS  = '/images/FarmersMarket.webp';
const IMG_PRECISION    = '/images/FarmManagement.webp';
const IMG_FARM2TABLE   = '/images/HomepageLivestockMarketplace.webp';
const IMG_ASSOCIATION  = '/images/AssociationGoats.webp';
const IMG_LIVESTOCK    = '/images/HomepageLivestockMarketplace.webp';
const IMG_EVENTS       = '/images/EventsHeader.webp';
const IMG_AI_ADVISORS  = '/images/SaigeBanner.webp';
const IMG_CHEF_PANTRY  = '/images/Restaurants.webp';
const IMG_WEBSITE      = '/images/204654websitedesignad.webp';
const IMG_KNOWLEDGE    = '/images/PlantDBHome.webp';

// ─── Reusable sub-components ──────────────────────────────────────────────────

function EcosystemCard({ title, description, img, link, eager }) {
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden flex flex-col hover:shadow-md hover:border-[#819360] transition-all duration-200">
      <Link to={link} className="block aspect-[4/3] overflow-hidden">
        <img
          src={img}
          alt={title}
          loading={eager ? 'eager' : 'lazy'}
          decoding={eager ? 'sync' : 'async'}
          fetchPriority={eager ? 'high' : 'auto'}
          className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
          onError={e => { e.target.src = '/images/DirectoryHome.webp'; }}
        />
      </Link>
      <div className="p-4 flex flex-col flex-1">
        <h3 className="font-bold text-lg text-gray-900 mb-2">{title}</h3>
        <p className="text-sm text-gray-600 flex-1 leading-relaxed">{description}</p>
        <Link
          to={link}
          className="mt-3 self-start text-[#3D6B34] font-semibold text-sm hover:underline"
        >
          Explore →
        </Link>
      </div>
    </div>
  );
}

function NewsCard({ title, description, img, link, imageRight }) {
  const Img = (
    <Link to={link} className="block w-full md:w-2/5 shrink-0 overflow-hidden aspect-video md:aspect-auto">
      <img
        src={img}
        alt={title}
        loading="lazy"
        className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
        onError={e => { e.target.src = '/images/DirectoryHome.webp'; }}
      />
    </Link>
  );
  const Text = (
    <div className="p-6 flex flex-col justify-center flex-1">
      <h3 className="font-lora font-bold text-xl text-[#3D6B34] mb-2">{title}</h3>
      <p className="text-sm text-gray-700 leading-relaxed mb-3">{description}</p>
      <Link to={link} className="self-start text-[#3D6B34] font-semibold text-sm hover:underline">
        Explore →
      </Link>
    </div>
  );
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden flex flex-col md:flex-row hover:shadow-md transition-shadow duration-200">
      {imageRight ? (<>{Text}{Img}</>) : (<>{Img}{Text}</>)}
    </div>
  );
}

function FeatureCard({ title, description, img, link }) {
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden flex flex-col hover:shadow-md hover:border-[#819360] transition-all duration-200">
      <Link to={link} className="block aspect-video overflow-hidden">
        <img
          src={img}
          alt={title}
          loading="lazy"
          className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
          onError={e => { e.target.src = '/images/DirectoryHome.webp'; }}
        />
      </Link>
      <div className="p-5 flex flex-col flex-1">
        <h3 className="font-bold text-base text-gray-900 mb-2">{title}</h3>
        <p className="text-xs text-gray-600 flex-1 leading-relaxed">{description}</p>
        <Link to={link} className="mt-3 self-start text-[#3D6B34] font-semibold text-xs hover:underline">
          Explore →
        </Link>
      </div>
    </div>
  );
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function App() {
  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Oatmeal Farm Network | AI-Powered Farm & Food Network"
        description="Connect farms, buyers, and food businesses with AI-powered tools. Browse 3,000+ livestock breeds, 4,000+ plant varieties, 14,000+ ingredients, and a local food marketplace on Oatmeal Farm Network."
        keywords="farm network, livestock marketplace, plant database, food system directory, AI farming, agriculture, livestock breeds, farm to table"
        canonical="https://oatmealfarmnetwork.com"
        jsonLd={[
          {
            '@context': 'https://schema.org',
            '@type': 'Organization',
            name: 'Oatmeal Farm Network',
            url: 'https://oatmealfarmnetwork.com',
            logo: 'https://oatmealfarmnetwork.com/images/Oatmeal-Farm-Network-og-default.jpg',
            sameAs: [],
            description: 'AI-powered farm and food system network connecting farms, buyers, and food businesses.',
          },
          {
            '@context': 'https://schema.org',
            '@type': 'WebSite',
            name: 'Oatmeal Farm Network',
            url: 'https://oatmealfarmnetwork.com',
          },
        ]}
      />
      <Header />

      {/* ─── 1. Hero ─────────────────────────────────────────────────────── */}
      <section className="bg-white">
        <div className="max-w-7xl mx-auto px-4 py-10 grid md:grid-cols-2 gap-10 items-center">
          <div>
            <h1 className="font-lora text-3xl md:text-4xl text-gray-900 leading-tight mb-2">
              Connect, Grow, Thrive:
            </h1>
            <h2 className="font-lora text-3xl md:text-4xl font-bold mb-5" style={{ color: '#3D6B34' }}>
              The Oatmeal Farm Network
            </h2>
            <p className="text-gray-700 text-base mb-3 leading-relaxed">
              <strong>Oatmeal Farm Network</strong> is your all-in-one platform connecting the entire food system.
            </p>
            <p className="text-gray-700 text-base mb-6 leading-relaxed">
              Discover local connections through our Food-System Directory, make smarter
              decisions with Saige's AI insights, and explore over 4,000 plant varieties and
              3,000 livestock breeds in our specialized databases. With our upcoming Livestock
              Marketplace, you'll soon be able to buy and sell directly within the network —
              helping you grow, connect, and thrive from ground to gourmet.
            </p>
            <Link
              to="/directory"
              className="inline-block px-6 py-2.5 rounded-full font-semibold text-white shadow-sm hover:shadow-md transition"
              style={{ backgroundColor: '#3D6B34' }}
            >
              Explore Directory
            </Link>
          </div>
          <div className="relative rounded-2xl overflow-hidden shadow-md aspect-[4/3]">
            <img
              src={IMG_HERO}
              alt="Sunset over a farm field"
              loading="eager"
              fetchPriority="high"
              className="w-full h-full object-cover"
              onError={e => { e.target.src = '/images/DirectoryHome.webp'; }}
            />
            <div className="absolute right-4 bottom-4 bg-white/85 backdrop-blur-sm rounded-xl p-4 max-w-[55%]">
              <div className="font-lora italic text-gray-800 text-sm md:text-base leading-snug">
                "The future of food is rooted in the precision of our past."
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ─── 2. Stats bar ───────────────────────────────────────────────── */}
      <section style={{ backgroundColor: '#3D6B34' }} className="text-white">
        <div className="max-w-7xl mx-auto px-4 py-6 grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
          {[
            { n: '4K+',    label: 'PLANT VARIETIES' },
            { n: '3K+',    label: 'LIVESTOCK BREEDS' },
            { n: '1,400+', label: 'UNIQUE INGREDIENTS' },
            { n: '52',     label: 'GLOBAL CATEGORIES' },
          ].map(s => (
            <div key={s.label}>
              <div className="text-3xl md:text-4xl font-bold leading-none">{s.n}</div>
              <div className="text-[10px] md:text-xs tracking-widest opacity-90 mt-1">{s.label}</div>
            </div>
          ))}
        </div>
      </section>

      {/* ─── 3. Built for the Ecosystem ─────────────────────────────────── */}
      <section className="py-12">
        <div className="max-w-7xl mx-auto px-4">
          <div className="text-center mb-8">
            <h2 className="font-lora text-3xl md:text-4xl font-bold text-gray-900">
              Built for the <span style={{ color: '#3D6B34' }}>Ecosystem</span>
            </h2>
            <p className="text-gray-600 mt-2">Four pillars of the modern food network, unified.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
            <EcosystemCard
              title="Farm"
              description="Grow smarter with modern tools and reliable connections designed to support today's agriculture."
              img={IMG_FARM} link="/directory/farms-ranches" eager />
            <EcosystemCard
              title="Ranches"
              description="Manage livestock more efficiently while expanding your reach to stronger, more sustainable markets."
              img={IMG_RANCHES} link="/directory/farms-ranches" eager />
            <EcosystemCard
              title="Artisan Producers"
              description="Bring your handcrafted goods to a wider, quality-focused audience that values authenticity and craft."
              img={IMG_ARTISAN} link="/directory/artisan-producers" eager />
            <EcosystemCard
              title="Restaurants"
              description="Connect with trusted local sources to serve fresh, high-quality ingredients with full transparency."
              img={IMG_RESTAURANTS} link="/directory/restaurants" eager />
          </div>
        </div>
      </section>

      {/* ─── 4. Company News + Market News ──────────────────────────────── */}
      <section className="pb-12">
        <div className="max-w-7xl mx-auto px-4 space-y-5">
          <NewsCard
            title="Company News"
            description="Stay informed with the latest updates from across the Oatmeal ecosystem. Our Company News section covers product launches, feature updates, partnerships, and key milestones shaping the future of agriculture and food systems. Discover innovations in AI-powered tools and stories from farmers, producers, and restaurants. Stay connected to how we're building a more transparent, efficient, and connected farm-to-table network."
            img={IMG_COMPANY_NEWS}
            link="/news"
            imageRight={false}
          />
          <NewsCard
            title="Market News"
            description="Stay updated on the latest trends and insights shaping the agricultural and food markets. Our Market News section covers pricing shifts, supply and demand changes, seasonal forecasts, and key industry developments. From crop performance to livestock trends and emerging market opportunities, we provide the insights you need to make informed decisions and stay ahead in a rapidly evolving food ecosystem."
            img={IMG_MARKET_NEWS}
            link="/news?category=market"
            imageRight={true}
          />
        </div>
      </section>

      {/* ─── 5. Core Features ───────────────────────────────────────────── */}
      <section className="pb-16">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="font-lora text-3xl md:text-4xl font-bold text-gray-900 mb-8">
            Core <span style={{ color: '#3D6B34' }}>Features</span>
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            <FeatureCard
              title="Precision Agriculture"
              description="An integrated precision agriculture solution that turns field data into actionable insights. Monitor crop health with satellite data, receive real-time alerts for stress or pests, and use predictive analytics to optimize yield, irrigation, and nutrient planning."
              img={IMG_PRECISION} link="/precision-ag/fields" />
            <FeatureCard
              title="Farm 2 Table Marketplace"
              description="A farm-to-table ecosystem that connects producers directly with chefs, restaurants, and consumers. Easily source fresh, local products, manage orders with smart logistics, and ensure full transparency with traceable product origins."
              img={IMG_FARM2TABLE} link="/marketplace" />
            <FeatureCard
              title="Association Support"
              description="A support program that equips food-system organizations with modern digital tools at no cost. Get a custom website, seamless event management, and earn a share of platform fees to support your community."
              img={IMG_ASSOCIATION} link="/associations" />
            <FeatureCard
              title="Livestock Marketplace"
              description="A data-driven livestock marketplace built for transparent buying, selling, and management. Access verified animal profiles, discover quality genetics for breeding, and make informed decisions with complete lifecycle visibility."
              img={IMG_LIVESTOCK} link="/marketplaces" />
            <FeatureCard
              title="Event Registration"
              description="A streamlined event management system designed for associations and producers. Easily create events, track registrations in real time, and offer seamless ticketing with fully branded event pages — all in one place."
              img={IMG_EVENTS} link="/events" />
            <FeatureCard
              title="AI Advisors"
              description="Industry-specific AI assistants designed to support every role in the ecosystem. From optimizing farm operations to managing restaurant inventory and streamlining artisan production, each AI helps automate workflows and improve decision-making."
              img={IMG_AI_ADVISORS} link="/saige" />
            <FeatureCard
              title="Chef's Digital Pantry"
              description="An intelligent inventory system that connects your kitchen directly to its supply chain. Track ingredients in real time, automate restocking, and manage costs with up-to-date pricing — all while sourcing seamlessly from local producers."
              img={IMG_CHEF_PANTRY} link="/chef" />
            <FeatureCard
              title="Custom Website System"
              description="An AI-powered website builder and CMS designed for producers with no technical skills. Instantly create a professional site, manage content with simple commands, and keep everything updated in real time."
              img={IMG_WEBSITE} link="/website-builder" />
            <FeatureCard
              title="Knowledgebases"
              description="A comprehensive knowledgebase built as a trusted source of truth for the food ecosystem. Explore detailed data on plant varieties, livestock breeds, and ingredients to support better decisions across agriculture and culinary industries."
              img={IMG_KNOWLEDGE} link="/plant-knowledgebase" />
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
}
