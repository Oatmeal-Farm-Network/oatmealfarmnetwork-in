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
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const NEWS_API = import.meta.env.VITE_NEWS_API_URL || import.meta.env.VITE_API_URL || '';

// Strip HTML tags + decode entities (Brownfield/USDA articles arrive with HTML)
function plainText(html) {
  if (!html) return '';
  if (typeof window === 'undefined' || !window.DOMParser) return String(html);
  const doc = new DOMParser().parseFromString(String(html), 'text/html');
  return (doc.body.textContent || '').replace(/\s+/g, ' ').trim();
}

function firstNWords(text, n = 100) {
  const words = (text || '').split(/\s+/).filter(Boolean);
  // Always end with "..." to signal "click for more" — even when text is shorter
  // than the cap, the link goes somewhere with more content.
  if (words.length <= n) return (text || '').trim() + ' ...';
  return words.slice(0, n).join(' ') + ' ...';
}

// The news API also returns category-placeholder SVGs in the `image` field
// when the source article had no real image — skip those when picking the
// "latest article with an image."
function hasRealImage(a) {
  const img = (a?.image || '').trim();
  return img && !img.startsWith('/images/news/');
}

// ─── Image map ────────────────────────────────────────────────────────────────
// Hand-mapped to existing files in /public/images so a fresh checkout renders
// without needing new assets. Swap any of these one-liners to update a slot.
const IMG_HERO         = '/images/HomePageField.webp';
const IMG_FARM         = '/images/Homefarm.webp';
const IMG_RANCHES      = '/images/Homeranches.webp';
const IMG_ARTISAN      = '/images/HomeArtisanProducers.webp';
const IMG_RESTAURANTS  = '/images/HomeRestaurants.webp';
const IMG_COMPANY_NEWS = '/images/HomePageComingsoon.webp';
const IMG_MARKET_NEWS  = '/images/FarmersMarket.webp';
const IMG_PRECISION    = '/images/HomePrecisionAg.webp';
const IMG_FARM2TABLE   = '/images/HomepageLivestockMarketplace.webp';
const IMG_ASSOCIATION  = '/images/AssociationGoats.webp';
const IMG_LIVESTOCK    = '/images/HomepageLivestockMarketplace.webp';
const IMG_EVENTS       = '/images/EventsHeader.webp';
const IMG_AI_ADVISORS  = '/images/SaigeBanner.webp';
const IMG_CHEF_PANTRY  = '/images/Restaurants.webp';
const IMG_WEBSITE      = '/images/HomeCustomWebsiteSystem.webp';
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

function NewsCard({ title, description, img, link, imageRight, eyebrow, imageFit = 'cover' }) {
  const Img = (
    <Link
      to={link}
      // .home-news-img caps height + vertically centers on lg+ via index.css
      // (Tailwind lg:max-h-44 + lg:self-center kept losing to JIT caching).
      className="home-news-img block w-full md:w-2/5 shrink-0 overflow-hidden aspect-video md:aspect-auto bg-white"
    >
      <img
        src={img}
        alt={title}
        loading="lazy"
        className={`w-full h-full ${imageFit === 'contain' ? 'object-contain' : 'object-cover hover:scale-105 transition-transform duration-300'}`}
        onError={e => { e.target.src = '/images/DirectoryHome.webp'; }}
      />
    </Link>
  );
  const Text = (
    <div className="p-6 flex flex-col justify-center flex-1">
      {eyebrow && (
        <div className="text-[10px] uppercase tracking-widest font-semibold text-gray-500 mb-1">
          {eyebrow}
        </div>
      )}
      <h3 className="font-lora font-bold text-xl text-[#3D6B34] mb-2">{title}</h3>
      <p className="text-sm text-gray-700 leading-relaxed mb-3">{description}</p>
      <Link to={link} className="self-end text-[#3D6B34] font-semibold text-sm hover:underline">
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

/**
 * Pulls the latest article from the news_articles Firestore collection that
 * actually has an image (skipping category-placeholder SVGs), and renders it
 * in the Market News slot. Falls back to a static "no recent news" card while
 * loading or if every recent article is image-less.
 */
function MarketNewsCard() {
  const [article, setArticle] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    fetch(`${NEWS_API}/api/news?limit=20`)
      .then(r => r.ok ? r.json() : null)
      .then(j => {
        if (cancelled) return;
        const list = (j && j.articles) || [];
        // API returns articles sorted by pubDate desc; first match wins.
        setArticle(list.find(hasRealImage) || null);
      })
      .catch(() => {})
      .finally(() => { if (!cancelled) setLoading(false); });
    return () => { cancelled = true; };
  }, []);

  if (loading) {
    return (
      <NewsCard
        title="Market News"
        description="Loading the latest market and food-system news…"
        img={IMG_MARKET_NEWS}
        link="/app/news"
        imageRight={true}
      />
    );
  }
  if (!article) {
    return (
      <NewsCard
        title="Market News"
        description="No recent articles to feature. Browse the full feed for today's pricing shifts, supply and demand changes, seasonal forecasts, and key industry developments."
        img={IMG_MARKET_NEWS}
        link="/app/news"
        imageRight={true}
      />
    );
  }

  const excerpt = firstNWords(plainText(article.description || article.content), 100);
  return (
    <NewsCard
      eyebrow="Industry News"
      title={article.title || 'Market News'}
      description={excerpt}
      img={article.image}
      link={`/app/news/${article.id}`}
      imageRight={true}
      imageFit="contain"
    />
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
        <Link to={link} className="mt-3 self-end text-[#3D6B34] font-semibold text-xs hover:underline">
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
            <h1
              className="leading-tight mb-3"
              style={{
                fontFamily: "'Lora', 'Times New Roman', serif",
                fontStyle: 'italic',
                fontWeight: 400,
                fontSize: 'clamp(1.625rem, 2.5vw, 2.25rem)',  // ~26px → ~36px
                color: '#232f3a',
              }}
            >
              Connect, Grow, Thrive:
            </h1>
            <h2
              className="mb-5"
              style={{
                fontFamily: "'Lora', 'Times New Roman', serif",
                fontWeight: 700,
                fontSize: 'clamp(1.875rem, 3vw, 2.25rem)',   // text-3xl → text-4xl
                color: '#4C8B5D',
              }}
            >
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
          </div>
          <div className="relative">
            <div className="rounded-2xl overflow-hidden shadow-md aspect-[4/3]">
              <img
                src={IMG_HERO}
                alt="Sunset over a farm field"
                loading="eager"
                fetchPriority="high"
                className="w-full h-full object-cover"
                onError={e => { e.target.src = '/images/DirectoryHome.webp'; }}
              />
            </div>
            {/* Quote sits at the bottom-left of the image with ~30% extending
                past the left edge — translate-x of -30% on a left-anchored
                element pushes that fraction of its width into the gutter. */}
            <div className="
              relative mt-3 mx-auto max-w-md
              md:absolute md:left-0 md:bottom-6 md:mt-0 md:mx-0 md:max-w-[42%] md:-translate-x-[20%]
              bg-white/60 backdrop-blur-sm rounded-xl shadow-md p-4
            ">
              <div className="font-lora italic text-gray-800 text-sm md:text-base leading-snug text-center md:text-left">
                "The future of food is rooted in the wisdom of our past."
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ─── 2. Stats bar ───────────────────────────────────────────────── */}
      <section style={{ backgroundColor: '#3D6B34' }} className="text-white">
        <div className="max-w-7xl mx-auto px-4 py-6 grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
          {[
            { n: '52',     label: 'BUSINESS CATEGORIES', link: '/directory' },
            { n: '4K+',    label: 'PLANT VARIETIES',     link: '/plant-knowledgebase' },
            { n: '3K+',    label: 'LIVESTOCK BREEDS',    link: '/livestock' },
            { n: '1,400+', label: 'INGREDIENTS',         link: '/ingredient-knowledgebase' },
          ].map(s => (
            <Link
              key={s.label}
              to={s.link}
              className="block rounded-xl px-2 py-1 font-bold transition-colors hover:bg-white/10 focus:bg-white/10 focus:outline-none"
              style={{
                fontFamily: "'Lora', 'Times New Roman', serif",
                color: '#ffffff',
              }}
            >
              <div className="text-3xl md:text-4xl leading-none" style={{ color: '#ffffff' }}>{s.n}</div>
              <div className="text-[10px] md:text-xs tracking-widest mt-1" style={{ color: '#ffffff' }}>{s.label}</div>
            </Link>
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
            title="Coming Soon: Open for Business"
            description={`The Oatmeal Farm Network is entering its final phase of technical readiness for our 2026 launch. We are currently onboarding a select group of pilot food businesses and associations to refine our "digital nervous system" before opening the gates to the wider community. Soon, the tools to manage everything from a single restaurant's pantry to a national breed association's registry will be available in one integrated ecosystem.`}
            img={IMG_COMPANY_NEWS}
            link="/news"
            imageRight={false}
          />
          <MarketNewsCard />
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
              img={IMG_KNOWLEDGE} link="/knowledgebases" />
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
}
