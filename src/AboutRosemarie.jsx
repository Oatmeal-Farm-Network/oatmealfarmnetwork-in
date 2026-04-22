// src/AboutRosemarie.jsx
// Marketing / about page for Rosemarie — the AI agent for artisan food producers.
// Route: /platform/rosemarie
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import RosemarieChat from './RosemarieChat';

const ACCENT = '#8B5CF6';

export default function AboutRosemarie() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Rosemarie | AI Agent for Artisan Food Producers"
        description="Rosemarie is the Oatmeal Farm Network AI agent for mills, bakers, cheesemakers, and artisan food producers — recipes, yields, sourcing, labeling, and small-batch operations."
        canonical="https://oatmealfarmnetwork.com/platform/rosemarie"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🌿</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">AI Agent</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Meet Rosemarie</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            The AI assistant for artisan food producers — mills, bakers, cheesemakers, picklers, preservers,
            and small-batch shops. Rosemarie helps you turn raw ingredients into finished products, and
            finished products into a business.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/account"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Open Rosemarie →
            </Link>
            <Link to="/marketplaces/farm-to-table"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Browse raw ingredients
            </Link>
          </div>
          <p className="mt-4 text-xs text-white/85 italic">
            Free with any OFN artisan producer account. Chat with Rosemarie using the purple bubble at the bottom-right of this page.
          </p>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services', to: '/platform' },
          { label: 'Rosemarie' },
        ]} />

        {/* What Rosemarie Does */}
        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What Rosemarie does
          </h2>
          <p className="text-gray-700 leading-relaxed">
            Rosemarie is a conversational AI built for the people who make things out of what farms grow.
            She knows flour extraction rates and sourdough hydration. She knows curd cuts and cave humidity.
            She knows the difference between a vinegar pickle and a lacto ferment, and why your last jar went soft.
            And she keeps it all tied to your recipes, your batches, and your ingredient suppliers — so the
            advice is grounded in your actual shop, not a generic textbook.
          </p>
        </section>

        {/* Who Rosemarie is for */}
        <section className="mt-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Who she's for
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {[
              { icon: '🌾', label: 'Millers' },
              { icon: '🍞', label: 'Bakers' },
              { icon: '🧀', label: 'Cheesemakers' },
              { icon: '🥒', label: 'Picklers & Preservers' },
              { icon: '🍯', label: 'Honey & Apiary Shops' },
              { icon: '🫖', label: 'Tea & Herb Blenders' },
              { icon: '🍫', label: 'Chocolatiers & Confectioners' },
              { icon: '🥓', label: 'Charcuterie & Smokehouses' },
            ].map(x => (
              <div key={x.label} className="bg-white border border-gray-200 rounded-xl p-3 text-center">
                <div className="text-2xl mb-1">{x.icon}</div>
                <div className="text-xs font-semibold text-gray-700">{x.label}</div>
              </div>
            ))}
          </div>
        </section>

        {/* Capabilities */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Capabilities
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Capability icon="🌾" title="Source raw ingredients"
              body="Browse live OFN listings for grain, milk, fruit, honey, and meat from farms in your state — filter by category or ingredient." />
            <Capability icon="📦" title="Par levels & restock drafts"
              body="Set par thresholds on your raw-ingredient inventory; Rosemarie drafts a multi-farm restock order the moment you dip below reorder." />
            <Capability icon="📥" title="Incoming wholesale orders"
              body="Pull up every order waiting on you from restaurants and chefs — confirm them, reject with a reason, or mark them shipped from the chat." />
            <Capability icon="📤" title="Ship & track"
              body="Hand Rosemarie a tracking number and she stamps the order shipped and notifies the buyer — no login to the fulfillment page required." />
            <Capability icon="🏷️" title="Profile & listings"
              body="Update your business name, description, slogan, and website in-chat. See what you're selling and what's running low at a glance." />
            <Capability icon="📚" title="Craft knowledge base"
              body="Milling, fermentation, cheesemaking, preserving, and food-safety guidance — grounded in a curated artisan-producer library, not a generic web search." />
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
              '"What hard red wheat is available from farms in PA right now?"',
              '"Show me all incoming orders from restaurants that are still pending."',
              '"Confirm order 4712 with a Tuesday ETA."',
              '"Set a par of 50 lb on heritage spelt with a reorder threshold of 20 lb."',
              '"What am I running low on in my inventory?"',
              '"Mark order 4689 as shipped, tracking 1Z999AA10123456784."',
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
            Put Rosemarie to work in your shop
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free with any OFN artisan producer account. Rosemarie rides along as a purple bubble on every
            producer page in the app — tap it and start a conversation.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/account"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Open my producer account →
            </Link>
            <Link to="/processed-food-inventory"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              Manage my products
            </Link>
          </div>
        </section>
      </div>

      <RosemarieChat />
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
