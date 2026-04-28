import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#B87F0B';
const ACCENT_BG = '#FEF3C7';

const S = ({ children }) => (
  <svg width="22" height="22" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

const ICONS = {
  ticket:   <S><rect x="1" y="4" width="14" height="8" rx="1"/><line x1="5" y1="4" x2="5" y2="12" strokeDasharray="1.5 1.5"/><line x1="11" y1="4" x2="11" y2="12" strokeDasharray="1.5 1.5"/></S>,
  meals:    <S><path d="M5 2v5a3 3 0 0 0 6 0V2"/><line x1="8" y1="10" x2="8" y2="14"/><line x1="5" y1="14" x2="11" y2="14"/></S>,
  page:     <S><rect x="2" y="1" width="12" height="14" rx="1"/><line x1="5" y1="5" x2="11" y2="5"/><line x1="5" y1="8" x2="11" y2="8"/><line x1="5" y1="11" x2="8" y2="11"/></S>,
  checkin:  <S><path d="M10 2H6a1 1 0 0 0-1 1v1H4a1 1 0 0 0-1 1v9a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V5a1 1 0 0 0-1-1h-1V3a1 1 0 0 0-1-1z"/><polyline points="6 8 7.5 9.5 10 7"/></S>,
  judge:    <S><path d="M8 2l1.5 3 3.5.5-2.5 2.5.5 3.5L8 10l-3 1.5.5-3.5L3 5.5 6.5 5z"/></S>,
  speaker:  <S><circle cx="8" cy="5" r="2.5"/><path d="M3 14c0-3.3 2.2-5 5-5s5 1.7 5 5"/><line x1="12" y1="2" x2="15" y2="2"/><line x1="12" y1="5" x2="15" y2="5"/></S>,
  chart:    <S><rect x="2" y="10" width="3" height="4"/><rect x="6.5" y="6" width="3" height="8"/><rect x="11" y="3" width="3" height="11"/><line x1="1" y1="14" x2="15" y2="14"/></S>,
  mail:     <S><rect x="1" y="3" width="14" height="10" rx="1"/><path d="M1 4l7 5 7-5"/></S>,
  badge:    <S><rect x="4" y="1" width="8" height="5" rx="1"/><path d="M4 4H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V5a1 1 0 0 0-1-1h-2"/><line x1="8" y1="9" x2="8" y2="11"/><circle cx="8" cy="7.5" r="0.8" fill="currentColor" stroke="none"/></S>,
  cert:     <S><rect x="1" y="3" width="14" height="10" rx="1"/><circle cx="8" cy="8" r="2.5"/><line x1="5" y1="12" x2="5" y2="14"/><line x1="11" y1="12" x2="11" y2="14"/></S>,
  stripe:   <S><rect x="1" y="4" width="14" height="9" rx="1"/><line x1="1" y1="7" x2="15" y2="7"/><line x1="4" y1="10.5" x2="7" y2="10.5"/></S>,
};

const EVENT_TYPES = [
  { label: 'Livestock Shows',     icon: '🐄', desc: 'Halter, fleece, performance, and breed classes with full judging and barn card printing.' },
  { label: 'Fiber Festivals',     icon: '🧶', desc: 'Vendor booths, fleece judging, spin-offs, workshops, and marketplace all on one platform.' },
  { label: 'Competitions',        icon: '🏆', desc: 'Custom class structures, judge portals, scorecards, and automated results distribution.' },
  { label: 'Conferences',         icon: '🎙️', desc: 'Speaker portals, agenda builders, session tracks, and certificate printing for attendees.' },
  { label: 'Auctions',            icon: '🔨', desc: 'Lot registration, bidder check-in, and real-time catalog management.' },
  { label: 'Farm Tours',          icon: '🚜', desc: 'Timed-entry ticketing, guided group management, and attendance tracking.' },
  { label: 'Vendor Fairs',        icon: '🛍️', desc: 'Booth assignment, exhibitor check-in, lead retrieval for vendors, and floor plan management.' },
  { label: 'Farm Dinners',        icon: '🍽️', desc: 'Seating management, meal selection at registration, and dietary restriction tracking.' },
  { label: 'Workshops',           icon: '📚', desc: 'Class capacity limits, material lists, prerequisite flags, and completion certificates.' },
  { label: 'Field Days',          icon: '🌾', desc: 'Demo schedules, station check-ins, and group size management for educational farm events.' },
  { label: 'Festivals',           icon: '🎉', desc: 'General admission plus add-ons — VIP passes, shuttle tickets, meal vouchers, and more.' },
  { label: 'RSVP Events',         icon: '📅', desc: 'Free-to-host simple events with headcount tracking and day-of check-in.' },
  { label: 'Certifications',      icon: '🎓', desc: 'Completion tracking, exam scheduling, and branded certificate generation.' },
  { label: 'Association Meetings',icon: '🤝', desc: 'Member-only registration, voting record tracking, and annual meeting management.' },
];

const FEATURES = [
  {
    icon: ICONS.ticket,
    title: 'Tickets, tiers & add-ons',
    body: 'Create multiple ticket types — general admission, VIP, member pricing, day passes. Add optional meal plans, shuttle tickets, and merchandise. Promo codes, early-bird pricing, and waitlists are all built in.',
  },
  {
    icon: ICONS.page,
    title: 'Branded registration pages',
    body: 'Every event gets a public registration page with your logo, banner, schedule, and description. Attendees register directly on OFN — no third-party redirects, no iframe hacks.',
  },
  {
    icon: ICONS.checkin,
    title: 'Check-in & nametags',
    body: 'Scan QR codes on arrival or search by name. Print nametags, barn cards, and class sheets from the same dashboard. Works on any device — phone, tablet, or desktop.',
  },
  {
    icon: ICONS.judge,
    title: 'Judge portals',
    body: 'Competition and livestock show events include a dedicated judge portal. Assign classes, enter scores, and publish results — all without sharing your admin credentials.',
  },
  {
    icon: ICONS.speaker,
    title: 'Speaker & agenda tools',
    body: 'Conferences get a speaker submission portal, agenda builder with session tracks, and a speaker-facing dashboard. Attendees see the live schedule the moment you publish it.',
  },
  {
    icon: ICONS.cert,
    title: 'Certificates',
    body: 'Print branded completion certificates for workshops, certifications, and conference attendees. Customize the template with your organization\'s name, logo, and signatory.',
  },
  {
    icon: ICONS.badge,
    title: 'Lead retrieval for exhibitors',
    body: 'Exhibitors and sponsors scan attendee badges to capture leads on the show floor. Contacts export to CSV after the event for seamless follow-up.',
  },
  {
    icon: ICONS.chart,
    title: 'Real-time analytics',
    body: 'Watch registration counts, revenue, and ticket-type breakdowns update live. See attendance by day, demographic summaries, and meal counts — all from your organizer dashboard.',
  },
  {
    icon: ICONS.stripe,
    title: 'Payments & payouts',
    body: 'Stripe powers all ticketing. Funds go directly to your account — no waiting 30 days for a payout. Free RSVPs are always free to host; paid tickets carry a low platform fee.',
  },
  {
    icon: ICONS.mail,
    title: 'Mailing list & broadcasts',
    body: 'Every registration builds an attendee list you own. Send day-of announcements, post-event follow-ups, and year-over-year invitations directly from the platform.',
  },
];

export default function AboutEventRegistration() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Event Registration | Oatmeal Farm Network"
        description="Turnkey event registration for livestock shows, fiber festivals, farm tours, auctions, conferences, competitions, and every other type of ag event."
        canonical="https://oatmealfarmnetwork.com/event-registration"
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
                <rect x="1" y="3" width="14" height="11" rx="1"/>
                <path d="M5 3V1M11 3V1"/>
                <line x1="1" y1="7" x2="15" y2="7"/>
              </svg>
            </div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow">Event Registration</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Turnkey event management built for the ag world — livestock shows, fiber festivals, farm tours,
            auctions, vendor fairs, competitions, and more. Registration, ticketing, check-in, judging,
            payouts, and post-event certificates in one place.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/events/add"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT }}>
              Host an event →
            </Link>
            <Link to="/events"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              See upcoming events
            </Link>
          </div>
        </div>
      </div>

      {/* Stats bar */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 py-5 grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
          {[
            { v: '14+', l: 'Event types' },
            { v: 'Live', l: 'Registration tracking' },
            { v: 'Direct', l: 'Stripe payouts' },
            { v: 'Free', l: 'Simple RSVPs' },
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
          { label: 'Event Registration' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Built for every shape of ag event
          </h2>
          <p className="text-gray-700 leading-relaxed">
            Most event platforms treat a livestock show the same as a tech conference. Ours started
            with the edge cases — fleece judging, barn card printing, halter class brackets — and
            built out from there. Whatever your event looks like, the registration flow is tuned to
            what your attendees and exhibitors actually need to tell you.
          </p>
        </section>

        {/* Event types grid */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Event types we support
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {EVENT_TYPES.map(t => (
              <div key={t.label}
                className="bg-white border border-gray-200 rounded-xl px-4 py-3 flex items-start gap-3">
                <span className="text-2xl shrink-0 leading-none mt-0.5">{t.icon}</span>
                <div>
                  <div className="font-bold text-gray-900 text-sm">{t.label}</div>
                  <div className="text-xs text-gray-500 mt-0.5 leading-relaxed">{t.desc}</div>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* Features */}
        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {FEATURES.map(f => (
              <FeatureCard key={f.title} icon={f.icon} title={f.title} body={f.body} />
            ))}
          </div>
        </section>

        {/* CTA */}
        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Ready to host your next event?
          </h3>
          <p className="text-sm text-gray-600 mb-5">
            Free to host simple RSVPs. Paid tickets carry a low platform fee plus Stripe's standard
            payment processing. No monthly subscription required.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/events/add"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT }}>
              Host an event →
            </Link>
            <Link to="/events"
              className="px-6 py-3 rounded-lg font-bold border-2 transition"
              style={{ color: ACCENT, borderColor: ACCENT }}>
              See upcoming events
            </Link>
            <Link to="/signup"
              className="px-6 py-3 rounded-lg font-bold border border-gray-300 text-gray-600 hover:bg-gray-50 transition">
              Create a free account
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function FeatureCard({ icon, title, body }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <div className="flex items-center gap-2 mb-1">
        <span className="flex items-center shrink-0" style={{ color: ACCENT }}>{icon}</span>
        <h3 className="font-bold text-gray-900">{title}</h3>
      </div>
      <p className="text-sm text-gray-600 leading-relaxed">{body}</p>
    </div>
  );
}
