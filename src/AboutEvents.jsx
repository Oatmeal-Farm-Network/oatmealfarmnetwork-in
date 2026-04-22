// src/AboutEvents.jsx
// Route: /platform/events
import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const ACCENT = '#EFAE15';
const ACCENT_DARK = '#B87F0B';

export default function AboutEvents() {
  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Events | Oatmeal Farm Network"
        description="Turnkey event management for the ag world — fiber festivals, livestock shows, auctions, conferences, workshops, farm tours, and vendor fairs. All in one place."
        canonical="https://oatmealfarmnetwork.com/platform/events"
      />
      <Header />

      <div className="relative text-white py-20 px-4" style={{ backgroundColor: ACCENT_DARK }}>
        <div className="absolute inset-0 bg-black/20" aria-hidden="true" />
        <div className="relative max-w-5xl mx-auto">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-14 h-14 rounded-2xl bg-white/20 flex items-center justify-center text-3xl">🎪</div>
            <span className="text-xs font-bold uppercase tracking-widest text-white/90">Platform Service</span>
          </div>
          <h1 className="text-4xl font-bold mb-3 drop-shadow" style={{ color: '#fff' }}>Events</h1>
          <p className="text-lg text-white/95 drop-shadow max-w-2xl">
            Turnkey event management for the ag world — fiber festivals, livestock shows, farm tours,
            auctions, vendor fairs, conferences, competitions, workshops. Registration, ticketing, meals,
            check-in, payouts, and post-event certificates, all in one place.
          </p>
          <div className="mt-6 flex flex-wrap gap-3">
            <Link to="/events"
              className="bg-white font-bold px-5 py-2.5 rounded-lg shadow hover:shadow-md transition"
              style={{ color: ACCENT_DARK }}>
              See upcoming events →
            </Link>
            <Link to="/events/add"
              className="border-2 border-white/60 text-white font-bold px-5 py-2.5 rounded-lg hover:bg-white/10 transition">
              Host an event
            </Link>
          </div>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Events' },
        ]} />

        <section className="mt-6">
          <h2 className="text-2xl font-bold text-gray-900 mb-3"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Built for every shape of ag event
          </h2>
          <p className="text-gray-700 leading-relaxed">
            We started with fiber festivals and livestock shows — things most event platforms don't handle well.
            Now we run the whole calendar: workshops, conferences, auctions, farm tours, vendor fairs, dinners,
            competitions, and RSVP-only community gatherings. Each event type has its own registration flow
            tuned to what attendees actually need to tell you.
          </p>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Event types
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {[
              { icon: '🐏', label: 'Livestock shows' },
              { icon: '🧶', label: 'Fiber arts' },
              { icon: '🎙️', label: 'Conferences' },
              { icon: '🏆', label: 'Competitions' },
              { icon: '🔨', label: 'Auctions' },
              { icon: '🚜', label: 'Farm tours' },
              { icon: '🛍️', label: 'Vendor fairs' },
              { icon: '🍽️', label: 'Farm dinners' },
              { icon: '📚', label: 'Workshops' },
              { icon: '🎉', label: 'Festivals' },
              { icon: '📅', label: 'RSVP events' },
              { icon: '🎓', label: 'Certifications' },
            ].map(x => (
              <div key={x.label} className="bg-white border border-gray-200 rounded-xl p-3 text-center">
                <div className="text-2xl mb-1">{x.icon}</div>
                <div className="text-xs font-semibold text-gray-700">{x.label}</div>
              </div>
            ))}
          </div>
        </section>

        <section className="mt-10">
          <h2 className="text-2xl font-bold text-gray-900 mb-4"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            What's included
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Feature icon="🎟️" title="Tickets, meals, and packages"
              body="Sell multiple ticket tiers, optional meal plans, and add-ons. Promo codes, waitlists, and refunds are all included." />
            <Feature icon="🏷️" title="Check-in & nametags"
              body="Print nametags, barn cards, and class sheets. Scan people in on arrival. Broadcast day-of announcements." />
            <Feature icon="📊" title="Analytics & payouts"
              body="Real-time attendance, revenue, and demographics — plus Stripe payouts straight to the organizing account." />
            <Feature icon="👨‍⚖️" title="Judge portals"
              body="Competition events include a judge portal for fleece, halter, fiber arts, spin-offs, and more." />
            <Feature icon="🎤" title="Speaker & agenda tools"
              body="Conferences include speaker portals, agenda builders, and certificate printing for attendees." />
            <Feature icon="📧" title="Mailing list & digests"
              body="Every event builds a clean mailing list you own. Send follow-ups, year-over-year invites, and newsletters." />
          </div>
        </section>

        <section className="mt-10 text-center bg-white border border-gray-200 rounded-2xl p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-2"
              style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
            Host your next event here
          </h3>
          <p className="text-sm text-gray-600 mb-4">
            Free to host simple RSVPs. Paid tickets carry a low platform fee plus Stripe's standard payment processing.
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/events/add"
              className="px-6 py-3 rounded-lg text-white font-bold shadow hover:shadow-md transition"
              style={{ backgroundColor: ACCENT_DARK }}>
              Host an event →
            </Link>
            <Link to="/events"
              className="px-6 py-3 rounded-lg border-2 font-bold transition"
              style={{ borderColor: ACCENT_DARK, color: ACCENT_DARK }}>
              See upcoming events
            </Link>
          </div>
        </section>
      </div>

      <Footer />
    </div>
  );
}

function Feature({ icon, title, body }) {
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
