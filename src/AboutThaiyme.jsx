// src/AboutThaiyme.jsx
// Route: /platform/thaiyme
import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#7A5A3D';
const ACCENT_LIGHT = '#fdf6ee';
const ACCENT_BORDER = '#e8d5bc';

export default function AboutThaiyme() {
  const { t } = useTranslation();

  const S = (p) => (
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke={ACCENT}
      strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" {...p} />
  );

  const capabilities = [
    {
      icon: <S><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></S>,
      title: 'Accounting Assistant',
      body: 'Explains revenue, expenses, invoice summaries, and cash-flow trends in plain language — no spreadsheet required.',
    },
    {
      icon: <S><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></S>,
      title: 'Event Registration',
      body: 'Reviews registrant lists, flags incomplete entries, answers attendee questions, and can make small edits on your behalf with one-click confirmation.',
    },
    {
      icon: <S><circle cx="12" cy="12" r="3"/><path d="M12 1v4M12 19v4M4.22 4.22l2.83 2.83M16.95 16.95l2.83 2.83M1 12h4M19 12h4M4.22 19.78l2.83-2.83M16.95 7.05l2.83-2.83"/></S>,
      title: 'Context-Aware',
      body: 'Knows which page you\'re on and loads the relevant data automatically — no copy-pasting numbers into a chat window.',
    },
    {
      icon: <S><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></S>,
      title: 'PII-Safe by Design',
      body: 'Sensitive attendee data — SSNs, payment info, routing numbers, emails, and phone numbers — is redacted server-side before any of it reaches the AI model.',
    },
    {
      icon: <S><polyline points="9 11 12 14 22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></S>,
      title: 'Confirm Before Executing',
      body: 'All write actions — editing a registration, updating an invoice — surface as a confirmation card you approve explicitly. Thaiyme never mutates data without your say-so.',
    },
    {
      icon: <S><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></S>,
      title: 'Works Across Business Types',
      body: 'Whether you run a farm, a ranch, a restaurant, a fiber studio, or a trade show — Thaiyme understands your account type and adjusts its questions and suggestions accordingly.',
    },
  ];

  const questions = [
    '"What was my total revenue last month, and how does it compare to the month before?"',
    '"Show me all registrants for the Fall Harvest Fair who haven\'t paid yet."',
    '"Are there any duplicate registrations in tonight\'s event?"',
    '"Update the booth assignment for vendor #14 to Aisle B, spot 6."',
    '"Which of my invoices are more than 30 days overdue?"',
    '"Summarize the expense categories from Q3 and flag anything unusual."',
  ];

  const where = [
    {
      icon: <S><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></S>,
      title: 'Accounting Dashboard',
      body: 'Available as a floating bubble on every accounting page — invoices, expenses, customers, vendors, and reports.',
      to: '/accounting',
    },
    {
      icon: <S><rect x="2" y="3" width="20" height="15" rx="2"/><line x1="2" y1="9" x2="22" y2="9"/></S>,
      title: 'Event Registration',
      body: 'Appears on all event organizer pages — registrant lists, check-in, floor plan, sponsorship, and more.',
      to: '/events',
    },
  ];

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Thaiyme | Business Operations AI for OFN"
        description="Thaiyme is the Oatmeal Farm Network business-operations AI — accounting assistant, event registration analyst, and action-confirmation agent for OFN directory businesses."
        canonical="https://oatmealfarmnetwork.com/platform/thaiyme"
      />
      <Header />

      <div className="mx-auto px-4 pt-4" style={{ maxWidth: '1300px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services', to: '/platform' },
          { label: 'Thaiyme' },
        ]} />
      </div>

      {/* Hero */}
      <div className="mx-auto px-4 pt-2" style={{ maxWidth: '1300px' }}>
        <div className="relative w-full overflow-hidden rounded-xl" style={{ background: 'linear-gradient(135deg, #3d2210 0%, #7A5A3D 60%, #b8956a 100%)', minHeight: 260 }}>
          <div className="absolute inset-0 flex flex-col justify-center px-8 py-8" style={{ maxWidth: '720px' }}>
            <div className="flex items-center gap-3 mb-3">
              <div className="w-10 h-10 rounded-xl flex items-center justify-center overflow-hidden" style={{ backgroundColor: 'rgba(255,255,255,0.18)' }}>
                <img src="/images/ThaiymeIcon.png" alt="Thaiyme" width="28" height="28" style={{ display: 'block', objectFit: 'cover' }} onError={e => { e.target.style.display = 'none'; }} />
              </div>
              <span className="text-xs font-bold uppercase tracking-widest" style={{ color: 'rgba(255,255,255,0.85)' }}>Business Operations AI</span>
            </div>
            <h1 style={{ color: '#ffffff', fontFamily: "'Lora','Times New Roman',serif", fontSize: '2rem', fontWeight: 'bold', margin: '0 0 10px', lineHeight: 1.2 }}>
              Meet Thaiyme
            </h1>
            <p style={{ color: 'rgba(255,255,255,0.92)', fontSize: '0.92rem', margin: '0 0 6px', lineHeight: 1.6 }}>
              The AI agent that lives inside your accounting and event registration pages. Ask about revenue, dig into registrant data, or hand off small edits — all without leaving the page you're on.
            </p>
            <p style={{ color: 'rgba(255,255,255,0.7)', fontSize: '0.84rem', margin: '0 0 18px', lineHeight: 1.5, fontStyle: 'italic' }}>
              Available to all OFN business account holders. No setup required.
            </p>
            <div className="flex flex-wrap gap-3">
              <Link to="/account"
                className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition text-sm"
                style={{ color: ACCENT }}>
                Open My Account →
              </Link>
              <Link to="/accounting"
                className="border-2 font-bold px-5 py-2.5 rounded-lg transition text-sm hover:bg-white/10"
                style={{ borderColor: '#ffffff', color: '#ffffff' }}>
                Go to Accounting
              </Link>
            </div>
          </div>
          {/* Decorative thyme-sprig motif */}
          <div className="absolute right-8 top-1/2 -translate-y-1/2 hidden lg:block opacity-10" aria-hidden="true">
            <svg width="180" height="180" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="0.6" strokeLinecap="round" strokeLinejoin="round">
              <path d="M12 2c0 0-4 4-4 8a4 4 0 0 0 8 0c0-4-4-8-4-8z"/>
              <path d="M12 10v12"/>
              <path d="M8 14c-2 0-4-1-4-3s2-3 4-3"/>
              <path d="M16 14c2 0 4-1 4-3s-2-3-4-3"/>
              <path d="M8 18c-2 0-4-1-4-3"/>
              <path d="M16 18c2 0 4-1 4-3"/>
            </svg>
          </div>
        </div>
      </div>

      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        {/* What Thaiyme does */}
        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What Thaiyme Does
          </h2>
          <p className="text-gray-700 leading-relaxed max-w-3xl">
            Thaiyme is a conversational AI built into the operations layer of your OFN account. He reads your accounting records and event registrant data, answers questions about both in plain language, and can propose small changes — updating a registration, flagging an overdue invoice — that you approve with a single click before anything executes. Sensitive data never leaves your control: all PII is stripped server-side before it reaches the model.
          </p>
        </section>

        {/* Capabilities */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Capabilities
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {capabilities.map(c => (
              <div key={c.title} className="bg-white border border-gray-200 rounded-xl p-4">
                <div className="flex items-center gap-2 mb-1">
                  <span className="flex items-center shrink-0">{c.icon}</span>
                  <h3 className="font-bold text-gray-900">{c.title}</h3>
                </div>
                <p className="text-sm text-gray-600">{c.body}</p>
              </div>
            ))}
          </div>
        </section>

        {/* Where to find Thaiyme */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Where You'll Find Him
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {where.map(w => (
              <div key={w.title} className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md transition-all duration-200"
                   style={{ borderColor: ACCENT_BORDER }}>
                <div className="shrink-0 flex items-center justify-center"
                     style={{ width: '100px', minHeight: '100px', backgroundColor: ACCENT_LIGHT, color: ACCENT }}>
                  {w.icon}
                </div>
                <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                  <div>
                    <p className="font-bold text-sm mb-1" style={{ color: ACCENT }}>{w.title}</p>
                    <p className="text-xs text-gray-600 leading-relaxed">{w.body}</p>
                  </div>
                  <div className="mt-3">
                    <Link to={w.to} className="text-xs font-bold hover:underline" style={{ color: ACCENT }}>
                      GO THERE →
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>
          <p className="text-sm text-gray-500 mt-3">
            Look for the brown bubble in the bottom-right corner of any accounting or event management page.
          </p>
        </section>

        {/* Example questions */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What You Can Ask
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {questions.map((q, i) => (
              <div key={i} className="bg-white border border-gray-200 rounded-xl p-4 text-sm text-gray-800 italic">
                {q}
              </div>
            ))}
          </div>
        </section>

        {/* How it works */}
        <section className="mt-10 bg-white border border-gray-200 rounded-2xl p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            How the Confirm Flow Works
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {[
              { step: '1', title: 'You ask', body: 'Type a question or request into the Thaiyme bubble on any supported page.' },
              { step: '2', title: 'Thaiyme proposes', body: 'For read actions, he answers immediately. For write actions, he surfaces a confirmation card summarizing exactly what will change.' },
              { step: '3', title: 'You approve', body: 'Click Yes to execute, or No to discard. Nothing changes in your account until you confirm.' },
            ].map(s => (
              <div key={s.step} className="flex gap-3">
                <div className="w-8 h-8 rounded-full flex items-center justify-center shrink-0 text-sm font-bold text-white" style={{ backgroundColor: ACCENT }}>
                  {s.step}
                </div>
                <div>
                  <p className="font-bold text-sm text-gray-900 mb-1">{s.title}</p>
                  <p className="text-xs text-gray-600 leading-relaxed">{s.body}</p>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Thaiyme Is Already in Your Account
          </h3>
          <p className="text-sm text-gray-600 mb-4 max-w-xl mx-auto">
            No installation. No configuration. Open your accounting dashboard or any event management page and tap the brown bubble in the corner.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/accounting"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Go to Accounting
            </Link>
            <Link to="/events"
              className="px-6 py-3 rounded-lg border-2 font-bold transition hover:bg-gray-50"
              style={{ borderColor: ACCENT, color: ACCENT }}>
              Manage Events
            </Link>
          </div>
        </section>

      </div>
      <Footer />
    </div>
  );
}
