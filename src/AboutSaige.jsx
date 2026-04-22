// src/AboutSaige.jsx
// Marketing / about page for Saige — the AI agricultural assistant.
// Route: /platform/saige
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#3D6B34';

export default function AboutSaige() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Saige | AI Agricultural Assistant"
        description="Saige is the Oatmeal Farm Network AI agent for growers and ranchers — crops, livestock, soil, weather, markets, and more."
        canonical="https://oatmealfarmnetwork.com/platform/saige"
      />
      <Header />

      {/* Hero */}
      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🌾</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">AI Agent</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Meet Saige</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Your AI agricultural assistant — crops, livestock, soil health, weather impacts, and farm operations,
            available 24/7 and tuned to the realities of running a real farm.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/saige"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Chat with Saige →
            </Link>
            <Link to="/signup"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Join the Network
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services', to: '/platform' },
          { label: 'Saige' },
        ]} />

        {/* What Saige Does */}
        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What Saige does
          </h2>
          <p className="text-gray-700 leading-relaxed">
            Saige is a conversational AI built on top of the Oatmeal Farm Network knowledge base. She combines
            retrieval-augmented generation (RAG) over thousands of curated agricultural documents with live
            tools that read and update your farm's records — animals, fields, precision-ag data, blog posts,
            events, and more. She remembers context across conversations and learns what matters to your
            operation over time.
          </p>
        </section>

        {/* Capabilities */}
        <section className="mt-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Capabilities
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Capability icon="🌱" title="Crop & soil advisory"
              body="Planting dates, rotation plans, cover crops, soil amendments, and pest/disease identification — region-aware and variety-specific." />
            <Capability icon="🐄" title="Livestock health & breeding"
              body="Nutrition, breeding calendars, parasite management, and record-keeping for cattle, sheep, goats, poultry, and more." />
            <Capability icon="☁️" title="Weather & risk"
              body="Frost risk, heat stress, drought mitigation, and crop-insurance guidance tied to your actual location." />
            <Capability icon="📈" title="Markets & pricing"
              body="Price forecasts, subsidies, and input-cost watches to inform planting, marketing, and cash-flow decisions." />
            <Capability icon="📝" title="Writes with your voice"
              body="Drafts blog posts, product descriptions, and social updates directly into the tools you already use on OFN." />
            <Capability icon="🗂️" title="Manages your records"
              body="Adds animals, logs precision-ag notes, creates events, and updates inventory — all through conversation." />
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
              '"Should I plant buckwheat or sudangrass as my summer cover?"',
              '"My ewe lambed twins this morning — log it and remind me to vaccinate at 2 weeks."',
              '"Draft a blog post about our fall apple harvest and schedule it."',
              '"Frost warning Thursday — what do I need to cover and which fields are at risk?"',
              '"How much grain should my 180 lb ram get through breeding season?"',
              '"Pull together a precision-ag summary for the North pasture."',
            ].map((q, i) => (
              <div key={i} className="bg-white border border-gray-200 rounded-xl p-4 text-sm text-gray-800 italic">
                {q}
              </div>
            ))}
          </div>
        </section>

        {/* How Saige is different */}
        <section className="mt-10 bg-white border border-gray-200 rounded-2xl p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            How Saige is different from a general chatbot
          </h2>
          <ul className="text-sm text-gray-700 space-y-2">
            <li>• <b>Connected to your data.</b> Saige can read and update your animals, fields, inventory, and blog — not just answer questions.</li>
            <li>• <b>Ag-specific knowledge base.</b> Saige's retrieval layer is built from curated agricultural content, not random web pages.</li>
            <li>• <b>Memory that actually helps.</b> Short-term context in the current conversation and long-term memory about your operation.</li>
            <li>• <b>Quiz mode.</b> Saige turns advisory sessions into teaching moments when you want to go deeper.</li>
            <li>• <b>Guardrails.</b> Destructive actions require confirmation; drafts sit in a review queue, not on your public site.</li>
          </ul>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ready to talk farming with Saige?
          </h3>
          <p className="text-sm text-gray-600 mb-4">Free for every OFN member. Join the network or jump straight in.</p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/saige"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Open Saige →
            </Link>
            <Link to="/account"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              Create an account
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
