import React, { useEffect, useState } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API = import.meta.env.VITE_API_URL || '';

function formatDate(d) {
  if (!d) return '';
  return new Date(d).toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
}

export default function EventDetail() {
  const { eventId } = useParams();
  const navigate = useNavigate();
  const [ev, setEv] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`)
      .then(r => r.ok ? r.json() : null)
      .then(d => { setEv(d); setLoading(false); })
      .catch(() => setLoading(false));
  }, [eventId]);

  if (loading) return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      <div className="max-w-4xl mx-auto px-4 py-16 text-center text-gray-400">Loading…</div>
      <Footer />
    </div>
  );

  if (!ev) return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      <div className="max-w-4xl mx-auto px-4 py-16 text-center">
        <p className="text-gray-500 mb-4">Event not found.</p>
        <Link to="/events" className="text-[#3D6B34] hover:underline">← Back to Events</Link>
      </div>
      <Footer />
    </div>
  );

  const hasOptions = ev.options?.length > 0;
  const location = [ev.EventLocationName, ev.EventLocationStreet,
    [ev.EventLocationCity, ev.EventLocationState, ev.EventLocationZip].filter(Boolean).join(', ')]
    .filter(Boolean);

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <Header />

      <div className="max-w-5xl mx-auto px-4 py-8">

        {/* Breadcrumb */}
        <div className="text-sm text-gray-500 mb-6 flex items-center gap-1">
          <Link to="/events" className="hover:text-[#3D6B34] hover:underline no-underline text-gray-500">Events</Link>
          <span>/</span>
          <span className="text-gray-700 font-medium">{ev.EventName}</span>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">

          {/* ── Left: main content ── */}
          <div className="lg:col-span-2 space-y-6">

            {/* Hero image */}
            {ev.EventImage && (
              <img src={ev.EventImage} alt={ev.EventName}
                className="w-full rounded-xl object-cover max-h-72"
                onError={e => e.target.style.display = 'none'} />
            )}

            {/* Title + badges */}
            <div>
              <div className="flex flex-wrap gap-2 mb-2">
                {ev.EventType && <span className="text-xs bg-gray-100 text-gray-600 font-medium px-3 py-1 rounded-full">{ev.EventType}</span>}
                {ev.IsFree ? (
                  <span className="text-xs bg-green-100 text-green-700 font-semibold px-3 py-1 rounded-full">Free</span>
                ) : (
                  <span className="text-xs bg-blue-100 text-blue-700 font-semibold px-3 py-1 rounded-full">Paid</span>
                )}
                {ev.RegistrationRequired && (
                  <span className="text-xs bg-amber-100 text-amber-700 font-semibold px-3 py-1 rounded-full">Registration Required</span>
                )}
              </div>
              <h1 className="text-2xl font-bold text-gray-800">{ev.EventName}</h1>
              <p className="text-sm text-gray-500 mt-1">Hosted by {ev.BusinessName}</p>
            </div>

            {/* Description */}
            {ev.EventDescription && (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                <h2 className="font-bold text-gray-700 mb-3">About This Event</h2>
                <p className="text-sm text-gray-700 leading-relaxed whitespace-pre-line">{ev.EventDescription}</p>
              </div>
            )}

            {/* Additional dates */}
            {ev.dates?.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                <h2 className="font-bold text-gray-700 mb-3">Schedule</h2>
                <div className="space-y-2">
                  {ev.dates.map(d => (
                    <div key={d.DateID} className="flex items-center gap-3 text-sm">
                      <span className="font-medium text-gray-800">{formatDate(d.EventDate)}</span>
                      {(d.StartTime || d.EndTime) && (
                        <span className="text-gray-500">{d.StartTime}{d.EndTime ? ` – ${d.EndTime}` : ''}</span>
                      )}
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Registration options */}
            {hasOptions && (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                <h2 className="font-bold text-gray-700 mb-3">Registration Options</h2>
                <div className="divide-y divide-gray-100">
                  {ev.options.map(opt => (
                    <div key={opt.OptionID} className="py-3 flex items-center justify-between gap-3">
                      <div>
                        <p className="font-medium text-gray-800 text-sm">{opt.OptionName}</p>
                        {opt.OptionDescription && <p className="text-xs text-gray-500 mt-0.5">{opt.OptionDescription}</p>}
                        {opt.MaxQty && <p className="text-xs text-amber-600 mt-0.5">Limit: {opt.MaxQty}</p>}
                      </div>
                      <span className="font-bold text-[#3D6B34] text-sm shrink-0">
                        {parseFloat(opt.Price) === 0 ? 'Free' : `$${parseFloat(opt.Price).toFixed(2)}`}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* ── Right: sidebar ── */}
          <div className="space-y-5">

            {/* Date / time card */}
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <h3 className="font-bold text-gray-700 mb-3 text-sm uppercase tracking-wide">Event Details</h3>

              {ev.EventStartDate && (
                <div className="flex gap-3 mb-3">
                  <svg className="w-5 h-5 text-[#3D6B34] shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                  </svg>
                  <div className="text-sm text-gray-700">
                    <p className="font-medium">{formatDate(ev.EventStartDate)}</p>
                    {ev.EventEndDate && ev.EventEndDate !== ev.EventStartDate && (
                      <p className="text-gray-500">to {formatDate(ev.EventEndDate)}</p>
                    )}
                  </div>
                </div>
              )}

              {location.length > 0 && (
                <div className="flex gap-3 mb-3">
                  <svg className="w-5 h-5 text-[#3D6B34] shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  </svg>
                  <div className="text-sm text-gray-700">
                    {location.map((l, i) => <p key={i}>{l}</p>)}
                  </div>
                </div>
              )}

              {ev.EventPhone && (
                <div className="flex gap-3 mb-3">
                  <svg className="w-5 h-5 text-[#3D6B34] shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                  </svg>
                  <a href={`tel:${ev.EventPhone}`} className="text-sm text-[#3D6B34] hover:underline">{ev.EventPhone}</a>
                </div>
              )}

              {ev.EventContactEmail && (
                <div className="flex gap-3 mb-3">
                  <svg className="w-5 h-5 text-[#3D6B34] shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                  </svg>
                  <a href={`mailto:${ev.EventContactEmail}`} className="text-sm text-[#3D6B34] hover:underline break-all">{ev.EventContactEmail}</a>
                </div>
              )}

              {ev.EventWebsite && (
                <div className="flex gap-3 mb-3">
                  <svg className="w-5 h-5 text-[#3D6B34] shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9" />
                  </svg>
                  <a href={ev.EventWebsite.startsWith('http') ? ev.EventWebsite : `https://${ev.EventWebsite}`}
                    target="_blank" rel="noopener noreferrer" className="text-sm text-[#3D6B34] hover:underline break-all">
                    {ev.EventWebsite}
                  </a>
                </div>
              )}

              {ev.MaxAttendees && (
                <div className="flex gap-3">
                  <svg className="w-5 h-5 text-[#3D6B34] shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0" />
                  </svg>
                  <p className="text-sm text-gray-700">Max {ev.MaxAttendees} attendees · {ev.AttendeeCount || 0} registered</p>
                </div>
              )}
            </div>

            {/* Register CTA */}
            {ev.RegistrationRequired && (
              <button
                onClick={() => navigate(`/events/${eventId}/register`)}
                className="w-full bg-[#3D6B34] text-white font-bold py-3 rounded-xl hover:bg-[#2d5226] transition-colors text-base"
              >
                Register for This Event
              </button>
            )}

            {/* Organizer card */}
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <p className="text-xs text-gray-400 uppercase tracking-wide mb-2">Organized by</p>
              <Link to={`/profile?BusinessID=${ev.BusinessID}`}
                className="font-bold text-gray-800 hover:text-[#3D6B34] no-underline block">
                {ev.BusinessName}
              </Link>
            </div>

            <Link to="/events" className="block text-sm text-center text-[#3D6B34] hover:underline">
              ← All Events
            </Link>
          </div>
        </div>
      </div>

      <Footer />
    </div>
  );
}
