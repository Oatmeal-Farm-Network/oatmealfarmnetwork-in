import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const S = ({ children, size = 28 }) => (
  <svg width={size} height={size} viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

const AGENTS = [
  {
    name: 'Saige',
    color: '#3D6B34',
    tagline: 'AI Agricultural Assistant',
    audience: 'For farmers, growers, and ranchers',
    description:
      'Saige is your always-on farm advisor — equal parts agronomist, livestock manager, and field-data analyst. She combines a curated agricultural knowledge base with live access to your fields, animals, and precision-ag records, so her advice is grounded in what\'s actually happening on your operation.',
    icon: (
      <svg width="36" height="36" viewBox="0 0 16 16" fill="none" stroke="white"
        strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
        <path d="M8 14V8"/>
        <path d="M5 11c0-3 3-4 3-7 0 3 3 4 3 7a3 3 0 0 1-6 0z"/>
        <path d="M3 8c1-2 2.5-2.5 5-2"/>
        <path d="M13 8c-1-2-2.5-2.5-5-2"/>
      </svg>
    ),
    capabilities: [
      'Crop & soil advisory — planting dates, rotation plans, soil amendments, pest ID',
      'Livestock health & breeding — nutrition, parasite management, record-keeping',
      'Weather & risk — frost alerts, heat stress, drought mitigation tied to your location',
      'Manages your records — adds animals, logs field notes, creates events from chat',
      'Drafts blog posts, product descriptions, and social content in your voice',
    ],
    cta: { label: 'Chat with Saige →', to: '/saige' },
    learnMore: { label: 'About Saige', to: '/platform/saige' },
  },
  {
    name: 'Pairsley',
    color: '#2f7d4a',
    tagline: 'AI Food-Service Partner',
    audience: 'For chefs, restaurateurs, and professional kitchens',
    description:
      'Pairsley plugs directly into the OFN farm-to-table marketplace so every answer is grounded in real inventory from real farms near you. She helps you write tonight\'s specials, cost a plate, source a short order, and manage your standing relationships — and she can make account changes for you directly from inside the chat.',
    icon: (
      <svg width="36" height="36" viewBox="0 0 16 16" fill="none" stroke="white"
        strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
        <path d="M5 2v5a3 3 0 0 0 6 0V2"/>
        <line x1="8" y1="10" x2="8" y2="14"/>
        <line x1="5" y1="14" x2="11" y2="14"/>
        <line x1="5" y1="4" x2="5" y2="2"/>
      </svg>
    ),
    capabilities: [
      'What\'s available this week — real-time inventory from your saved farms',
      'Seasonal menu help — draft specials and tasting menus around what\'s ripe',
      'Plate costing & margin — cost a dish with live wholesale prices',
      'Standing orders — set up recurring orders and adjust on the fly',
      'Account changes from chat — update your profile, website, and slogan without leaving the conversation',
    ],
    cta: { label: 'Open Pairsley →', to: '/restaurant/farms' },
    learnMore: { label: 'About Pairsley', to: '/platform/pairsley' },
  },
  {
    name: 'Rosemarie',
    color: '#8B5CF6',
    tagline: 'AI Assistant for Artisan Food Producers',
    audience: 'For mills, bakers, cheesemakers, picklers, preservers & small-batch shops',
    description:
      'Rosemarie knows flour extraction rates and sourdough hydration. She knows curd cuts and cave humidity. She keeps it all tied to your recipes, your batches, and your ingredient suppliers on OFN — so the advice is grounded in your actual shop, not a generic textbook.',
    icon: (
      <svg width="36" height="36" viewBox="0 0 16 16" fill="none" stroke="white"
        strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
        <path d="M8 2c-1 2-3 3-3 5.5A3 3 0 0 0 8 11a3 3 0 0 0 3-3.5C11 5 9 4 8 2z"/>
        <path d="M6 10c-1 1-1.5 2.5-1 3.5"/>
        <path d="M10 10c1 1 1.5 2.5 1 3.5"/>
        <line x1="8" y1="11" x2="8" y2="14"/>
      </svg>
    ),
    capabilities: [
      'Source raw ingredients — browse live OFN listings for grain, milk, fruit, honey, and meat',
      'Par levels & restock drafts — auto-draft multi-farm orders when inventory dips below threshold',
      'Incoming wholesale orders — confirm, reject, or ship orders from chefs and restaurants via chat',
      'Craft knowledge base — milling, fermentation, cheesemaking, and food-safety guidance',
      'Profile & listings — update your business and see what you\'re selling at a glance',
    ],
    cta: { label: 'Open Rosemarie →', to: '/account' },
    learnMore: { label: 'About Rosemarie', to: '/platform/rosemarie' },
  },
  {
    name: 'Thaiyme',
    color: '#7A5A3D',
    tagline: 'Business Operations AI',
    audience: 'For event organizers and business account holders',
    description:
      'Thaiyme sits inside your accounting and event registration pages, ready to help you make sense of the numbers and the registrant data. He can explain revenue trends, surface anomalies, suggest next steps, and make small changes to event registrations on your behalf — all without you leaving the page you\'re already on.',
    icon: (
      <img src="/images/ThaiymeIcon.png" alt="Thaiyme"
        style={{ width: 36, height: 36, display: 'block', objectFit: 'contain', filter: 'brightness(0) invert(1)' }} />
    ),
    capabilities: [
      'Accounting assistant — explains revenue, expenses, and trends in plain language',
      'Event registration — reviews registrant lists, flags issues, and makes small edits on request',
      'Context-aware — knows which page you\'re on and loads the relevant data automatically',
      'PII-safe — sensitive attendee data is redacted server-side before it reaches the AI',
      'Action confirmation — all write actions require your explicit approval before executing',
    ],
    cta: { label: 'Open an account →', to: '/signup' },
    learnMore: null,
  },
  {
    name: 'Lavendir',
    color: '#7C5CBF',
    tagline: 'AI Website Design Assistant',
    audience: 'For anyone building or redesigning a website on OFN',
    description:
      'Lavendir is the AI co-pilot inside the OFN Website Builder. She can scrape your existing site to capture your brand\'s colors, fonts, and layout, then use that context to help you rebuild or migrate to OFN. Ask her to draft a new page, suggest a layout, or write your hero copy — publishing always requires your review.',
    icon: (
      <img src="/images/LavendirIcon.png" alt="Lavendir"
        style={{ width: 36, height: 36, display: 'block', objectFit: 'contain', filter: 'brightness(0) invert(1)' }} />
    ),
    capabilities: [
      'Brand scraping — captures your existing site\'s colors, fonts, and nav style automatically',
      'Page drafting — generates full page layouts with your brand context already applied',
      'Hero copy — writes your headline, subhead, and CTA text to match your voice',
      'Layout suggestions — recommends widget arrangements and section orders',
      'Always in review — every suggestion is a draft; you publish what you approve',
    ],
    cta: { label: 'Open Website Builder →', to: '/website-builder' },
    learnMore: null,
  },
];

export default function AboutAIAgents() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="AI Agents | Oatmeal Farm Network"
        description="Meet Saige, Pairsley, Rosemarie, Thaiyme, and Lavendir — five purpose-built AI agents covering every role in the food system, from field to fork to website."
        canonical="https://oatmealfarmnetwork.com/ai-agents"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: '#3D6B34' }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-white">
              <S size={28}>
                <circle cx="8" cy="5" r="2.5"/>
                <path d="M3 14c0-3.3 2.2-5 5-5s5 1.7 5 5"/>
                <circle cx="13" cy="4" r="1.5"/>
                <circle cx="3" cy="4" r="1.5"/>
                <path d="M14.5 11c0-2.2-1-3.5-1.5-3.5"/>
                <path d="M1.5 11c0-2.2 1-3.5 1.5-3.5"/>
              </S>
            </div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">AI Agents</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow">Meet Our AI Agents</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Five purpose-built AI agents — each designed for a specific role in the food system.
            From the field to the kitchen to your website, there's an agent ready to help.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/saige"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: '#3D6B34' }}>
              Chat with Saige →
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Open An Account
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'AI Agents' },
        ]} />

        <p className="mt-6 text-gray-700 leading-relaxed max-w-3xl">
          Every agent on OFN is purpose-built for a specific corner of the food system. They share your
          account data, talk to the same backend, and operate within guardrails — destructive actions always
          require your confirmation, and drafts sit in a review queue before going live.
        </p>

        {/* Agent Cards */}
        <div className="mt-8 space-y-6">
          {AGENTS.map(agent => (
            <AgentCard key={agent.name} agent={agent} />
          ))}
        </div>

        {/* Shared traits */}
        <section className="mt-12 bg-white border border-gray-200 rounded-2xl p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What every agent has in common
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Trait title="Connected to your data"
              body="Each agent reads and writes your actual OFN records — animals, fields, inventory, events, and blog posts — not a sandboxed demo." />
            <Trait title="Confirmation before action"
              body="No agent makes a destructive or publish-worthy change without your explicit approval. Drafts stay in queue until you say go." />
            <Trait title="Free with your account"
              body="All five agents are included at no extra cost with any OFN account. The agent you see depends on which pages you use." />
          </div>
        </section>

        {/* CTA */}
        <section className="mt-8 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ready to put them to work?
          </h3>
          <p className="text-sm text-gray-600 mb-5">
            Free with any OFN account. Each agent appears automatically on the pages where they're most useful.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/saige"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: '#3D6B34' }}>
              Chat with Saige →
            </Link>
            <Link to="/signup"
              className="px-6 py-3 rounded-lg font-bold border-2 transition hover:bg-green-50"
              style={{ color: '#3D6B34', borderColor: '#3D6B34' }}>
              Create a free account
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function AgentCard({ agent }) {
  return (
    <div className="bg-white border border-gray-200 rounded-2xl overflow-hidden">
      {/* Header bar */}
      <div className="px-6 py-5 flex items-start gap-4" style={{ backgroundColor: agent.color }}>
        <div className="w-14 h-14 rounded-xl bg-white/20 flex items-center justify-center shrink-0">
          {agent.icon}
        </div>
        <div className="text-white min-w-0">
          <div className="text-xs font-bold uppercase tracking-widest text-white/80 mb-0.5">AI Agent</div>
          <h2 className="text-2xl font-bold leading-tight">{agent.name}</h2>
          <div className="text-sm text-white/90 font-semibold">{agent.tagline}</div>
          <div className="text-xs text-white/70 mt-0.5 italic">{agent.audience}</div>
        </div>
      </div>

      {/* Body */}
      <div className="px-6 py-5">
        <p className="text-gray-700 leading-relaxed text-sm mb-4">{agent.description}</p>

        <ul className="space-y-1.5 mb-5">
          {agent.capabilities.map(c => (
            <li key={c} className="flex items-start gap-2 text-sm text-gray-700">
              <span className="mt-0.5 shrink-0 font-bold" style={{ color: agent.color }}>→</span>
              <span>{c}</span>
            </li>
          ))}
        </ul>

        <div className="flex flex-wrap gap-2">
          <Link to={agent.cta.to}
            className="px-4 py-2 rounded-lg text-white text-sm font-bold shadow hover:shadow-md transition"
            style={{ backgroundColor: agent.color }}>
            {agent.cta.label}
          </Link>
          {agent.learnMore && (
            <Link to={agent.learnMore.to}
              className="px-4 py-2 rounded-lg text-sm font-bold border-2 transition hover:bg-gray-50"
              style={{ color: agent.color, borderColor: agent.color }}>
              {agent.learnMore.label}
            </Link>
          )}
        </div>
      </div>
    </div>
  );
}

function Trait({ title, body }) {
  return (
    <div>
      <h3 className="font-bold text-gray-900 mb-1">{title}</h3>
      <p className="text-sm text-gray-600 leading-relaxed">{body}</p>
    </div>
  );
}
