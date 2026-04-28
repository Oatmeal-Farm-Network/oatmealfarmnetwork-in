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
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import OTFDMWidget from './OTFDMWidget';

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
const IMG_PRECISION    = '/images/CoreFeaturesPrecisionAg.webp';
const IMG_FARM2TABLE   = '/images/CoreFeaturesFarm2Table.webp';
const IMG_ASSOCIATION  = '/images/CoreFeaturesAssociationSupport.webp';
const IMG_LIVESTOCK    = '/images/HomepageLivestockMarketplace.webp';
const IMG_EVENTS       = '/images/EventsHeader.webp';
const IMG_AI_ADVISORS  = '/images/SaigeBanner.webp';
const IMG_CHEF_PANTRY  = '/images/Restaurants.webp';
const IMG_WEBSITE      = '/images/HomeCustomWebsiteSystem.webp';
const IMG_KNOWLEDGE    = '/images/PlantDBHome.webp';

// ─── Reusable sub-components ──────────────────────────────────────────────────

function EcosystemCard({ title, description, img, link, eager }) {
  const { t } = useTranslation();
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
          className="mt-3 self-end text-[#3D6B34] font-semibold text-sm hover:underline"
        >
          {t('home.explore_arrow')}
        </Link>
      </div>
    </div>
  );
}

function NewsCard({ title, description, img, link, imageRight, eyebrow, imageFit = 'cover' }) {
  const { t } = useTranslation();
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
        {t('home.explore_arrow')}
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
  const { t } = useTranslation();
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
        title={t('home.market_news_title')}
        description={t('home.market_news_loading')}
        img={IMG_MARKET_NEWS}
        link="/app/news"
        imageRight={true}
      />
    );
  }
  if (!article) {
    return (
      <NewsCard
        title={t('home.market_news_title')}
        description={t('home.market_news_fallback')}
        img={IMG_MARKET_NEWS}
        link="/app/news"
        imageRight={true}
      />
    );
  }

  const excerpt = firstNWords(plainText(article.description || article.content), 100);
  return (
    <NewsCard
      eyebrow={t('home.industry_news_eyebrow')}
      title={article.title || t('home.market_news_title')}
      description={excerpt}
      img={article.image}
      link={`/app/news/${article.id}`}
      imageRight={true}
      imageFit="contain"
    />
  );
}

function FeatureCard({ title, description, img, link }) {
  const { t } = useTranslation();
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
        <h3 className="font-bold text-base mb-2">
          <Link to={link} className="hover:underline" style={{ color: '#3D6B34' }}>{title}</Link>
        </h3>
        <p className="text-xs text-gray-600 flex-1 leading-relaxed">{description}</p>
        <Link to={link} className="mt-3 self-end text-[#3D6B34] font-semibold text-xs hover:underline">
          {t('home.explore_arrow')}
        </Link>
      </div>
    </div>
  );
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function App() {
  const { t } = useTranslation();
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
              {t('home.hero_tagline')}
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
              {t('home.hero_title')}
            </h2>
            <p className="text-gray-700 text-base mb-3 leading-relaxed">
              {t('home.hero_body1')}
            </p>
            <p className="text-gray-700 text-base mb-6 leading-relaxed">
              {t('home.hero_body2')}
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
                {t('home.hero_quote')}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ─── 2. Stats bar ───────────────────────────────────────────────── */}
      <section style={{ backgroundColor: '#3D6B34' }} className="text-white">
        <div className="max-w-7xl mx-auto px-4 py-6 grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
          {[
            { n: '52',     label: t('home.stats_categories'), link: '/directory' },
            { n: '4K+',    label: t('home.stats_plants'),     link: '/plant-knowledgebase' },
            { n: '3K+',    label: t('home.stats_livestock'),  link: '/livestock' },
            { n: '1,400+', label: t('home.stats_ingredients'),link: '/ingredient-knowledgebase' },
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
              {t('home.ecosystem_title')} <span style={{ color: '#3D6B34' }}>{t('home.ecosystem_span')}</span>
            </h2>
            <p className="text-gray-600 mt-2">{t('home.ecosystem_sub')}</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
            <EcosystemCard
              title={t('home.ecosystem_farm_title')}
              description={t('home.ecosystem_farm_desc')}
              img={IMG_FARM} link="/for-farms" eager />
            <EcosystemCard
              title={t('home.ecosystem_ranches_title')}
              description={t('home.ecosystem_ranches_desc')}
              img={IMG_RANCHES} link="/for-ranches" eager />
            <EcosystemCard
              title={t('home.ecosystem_artisan_title')}
              description={t('home.ecosystem_artisan_desc')}
              img={IMG_ARTISAN} link="/for-artisan-producers" eager />
            <EcosystemCard
              title={t('home.ecosystem_restaurants_title')}
              description={t('home.ecosystem_restaurants_desc')}
              img={IMG_RESTAURANTS} link="/for-restaurants" eager />
          </div>
        </div>
      </section>

      {/* ─── 4. Company News + Market News ──────────────────────────────── */}
      <section className="pb-12">
        <div className="max-w-7xl mx-auto px-4 space-y-5">
          <NewsCard
            title={t('home.news_company_title')}
            description={t('home.news_company_desc')}
            img={IMG_COMPANY_NEWS}
            link="/news"
            imageRight={false}
          />
          <MarketNewsCard />
        </div>
      </section>

      {/* ─── 4.5 Over The Fence DM widget (logged-in users only) ───────── */}
      <OTFDMWidget />

      {/* ─── 5. Core Features ───────────────────────────────────────────── */}
      <section className="pb-16">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="font-lora text-3xl md:text-4xl font-bold text-gray-900 mb-8">
            {t('home.features_title')} <span style={{ color: '#3D6B34' }}>{t('home.features_span')}</span>
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            <FeatureCard title={t('home.feat_precision_title')} description={t('home.feat_precision_desc')} img={IMG_PRECISION} link="/platform/precision-ag" />
            <FeatureCard title={t('home.feat_farm2table_title')} description={t('home.feat_farm2table_desc')} img={IMG_FARM2TABLE} link="/marketplaces/farm-to-table" />
            <FeatureCard title={t('home.feat_association_title')} description={t('home.feat_association_desc')} img={IMG_ASSOCIATION} link="/agriculture-support" />
            <FeatureCard title={t('home.feat_livestock_title')} description={t('home.feat_livestock_desc')} img={IMG_LIVESTOCK} link="/marketplaces" />
            <FeatureCard title={t('home.feat_events_title')} description={t('home.feat_events_desc')} img={IMG_EVENTS} link="/event-registration" />
            <FeatureCard title={t('home.feat_ai_title')} description={t('home.feat_ai_desc')} img={IMG_AI_ADVISORS} link="/ai-agents" />
            <FeatureCard title={t('home.feat_chef_title')} description={t('home.feat_chef_desc')} img={IMG_CHEF_PANTRY} link="/chef-pantry" />
            <FeatureCard title={t('home.feat_website_title')} description={t('home.feat_website_desc')} img={IMG_WEBSITE} link="/website-builder" />
            <FeatureCard title={t('home.feat_knowledge_title')} description={t('home.feat_knowledge_desc')} img={IMG_KNOWLEDGE} link="/knowledgebases" />
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
}
