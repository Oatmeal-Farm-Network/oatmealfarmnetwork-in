import React, { useEffect, useState } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';
import { typeAdminModule } from './eventTypeAdminMap';

const API = import.meta.env.VITE_API_URL || '';

function formatDate(d) {
  if (!d) return '';
  return new Date(d).toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
}

function AdminSidebar({ ev, eventId, businessId }) {
  const typeModule = typeAdminModule(ev.EventType);
  const itemCls = "block text-sm px-3 py-2 rounded-lg hover:bg-gray-50 text-gray-700 no-underline border border-transparent hover:border-gray-200";
  const bizQs = businessId ? `?BusinessID=${businessId}` : '';
  return (
    <aside className="bg-white rounded-xl border border-purple-200 p-4 lg:sticky lg:top-4 self-start">
      <div className="flex items-center gap-2 mb-3">
        <span className="text-lg">🛠️</span>
        <div>
          <div className="text-[11px] uppercase tracking-wide text-purple-700 font-semibold">Organizer</div>
          <div className="text-xs text-gray-500">Admin tools</div>
        </div>
      </div>

      <div className="mb-3">
        <Link to={`/events/${eventId}/dashboard`}
          className="block text-sm font-semibold px-3 py-2 rounded-lg bg-[#3D6B34] text-white hover:bg-[#2d5226] no-underline text-center">
          🏠 Admin dashboard
        </Link>
      </div>

      {typeModule && (
        <div className="mb-3">
          <div className="text-[11px] uppercase tracking-wide text-gray-400 mb-1 px-2">Event module</div>
          <Link to={`/events/${eventId}/${typeModule.path}${bizQs}`}
            className="block text-sm font-semibold px-3 py-2 rounded-lg bg-purple-50 text-purple-700 hover:bg-purple-100 no-underline">
            {typeModule.label}
          </Link>
        </div>
      )}

      <div className="text-[11px] uppercase tracking-wide text-gray-400 mb-1 px-2">Attendees</div>
      <Link to={`/events/${eventId}/checkin`} className={itemCls}>✅ Check-in</Link>
      <Link to={`/events/${eventId}/broadcast`} className={itemCls}>📣 Broadcast email</Link>
      <Link to={`/events/${eventId}/analytics`} className={itemCls}>📊 Analytics</Link>
      <a href={`${API}/api/events/${eventId}/attendees.csv`} className={itemCls}>⬇️ Attendees CSV</a>

      <div className="text-[11px] uppercase tracking-wide text-gray-400 mt-3 mb-1 px-2">Calendar</div>
      <a href={`${API}/api/events/${eventId}/calendar.ics`} className={itemCls}>📅 Export .ics</a>

      <div className="text-[11px] uppercase tracking-wide text-gray-400 mt-3 mb-1 px-2">Event</div>
      <Link to={`/account/events?edit=${eventId}`} className={itemCls}>✏️ Edit details</Link>
      <Link to="/account/events" className={itemCls}>↩ All my events</Link>
    </aside>
  );
}

function PublicFeatureCTAs({ features, ev, eventId }) {
  const publics = (features || []).filter(f => f.PublicPath);
  if (publics.length === 0 && !ev.RegistrationRequired && !ev.EventStartDate) return null;

  const isExternal = (p) => /^https?:\/\//.test(p) || p.startsWith('/api/');
  const core = publics.find(f => f.IsCoreModule);
  const calendar = publics.find(f => f.FeatureKey === 'calendar_ics');
  const extras = publics.filter(f =>
    !f.IsCoreModule && f.FeatureKey !== 'calendar_ics' && !isExternal(f.PublicPath));

  // Feature keys that the unified registration wizard handles
  const WIZARD_KEYS = new Set([
    'halter_module', 'fleece_module', 'spinoff_module',
    'fiber_arts_module', 'vendor_fair_module',
  ]);
  const hasWizardFeature = publics.some(f => WIZARD_KEYS.has(f.FeatureKey));

  return (
    <>
      {hasWizardFeature && (
        <a
          href={`/events/${eventId}/register/wizard`}
          className="w-full block text-center bg-[#3D6B34] text-white font-bold py-3 rounded-xl hover:bg-[#2d5226] transition-colors text-base no-underline"
        >
          Register for This Event →
        </a>
      )}

      {!hasWizardFeature && core && (
        <a
          href={core.PublicPath}
          className="w-full block text-center bg-[#3D6B34] text-white font-bold py-3 rounded-xl hover:bg-[#2d5226] transition-colors text-base no-underline"
        >
          {core.Icon && <span className="mr-2">{core.Icon}</span>}
          {core.FeatureName} →
        </a>
      )}

      {!hasWizardFeature && !core && ev.RegistrationRequired && (
        <a
          href={`/events/${eventId}/register`}
          className="w-full block text-center bg-[#3D6B34] text-white font-bold py-3 rounded-xl hover:bg-[#2d5226] transition-colors text-base no-underline"
        >
          Register for This Event
        </a>
      )}

      {calendar && ev.EventStartDate && (
        <a
          href={`${API}${calendar.PublicPath}`}
          className="w-full block text-center border border-gray-300 text-gray-700 text-sm py-2 rounded-lg hover:bg-gray-50 no-underline"
        >
          📅 Add to Calendar (.ics)
        </a>
      )}
      {!calendar && ev.EventStartDate && (
        <a
          href={`${API}/api/events/${eventId}/calendar.ics`}
          className="w-full block text-center border border-gray-300 text-gray-700 text-sm py-2 rounded-lg hover:bg-gray-50 no-underline"
        >
          Add to Calendar (.ics)
        </a>
      )}

      {extras.map(f => (
        <a
          key={f.FeatureID}
          href={f.PublicPath}
          title={f.FeatureDescription || ''}
          className="w-full block text-center border border-[#3D6B34] text-[#3D6B34] font-medium py-2 rounded-xl hover:bg-[#3D6B34]/5 transition-colors text-sm no-underline"
        >
          {f.Icon && <span className="mr-1">{f.Icon}</span>}
          {f.FeatureName} →
        </a>
      ))}
    </>
  );
}

export default function EventDetail() {
  const { eventId } = useParams();
  const navigate = useNavigate();
  const [ev, setEv] = useState(null);
  const [loading, setLoading] = useState(true);
  const [features, setFeatures] = useState([]);
  const accountCtx = useAccount() || {};
  const myBusinesses = accountCtx.businesses || [];

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`)
      .then(r => r.ok ? r.json() : null)
      .then(d => { setEv(d); setLoading(false); })
      .catch(() => setLoading(false));
  }, [eventId]);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/features`)
      .then(r => r.ok ? r.json() : null)
      .then(d => setFeatures(Array.isArray(d?.features) ? d.features : []))
      .catch(() => setFeatures([]));
  }, [eventId]);

  if (loading) return (
    <div className="min-h-screen font-sans">
      <Header />
      <div className="max-w-4xl mx-auto px-4 py-16 text-center text-gray-400">Loading…</div>
      <Footer />
    </div>
  );

  if (!ev) return (
    <div className="min-h-screen font-sans">
      <Header />
      <div className="max-w-4xl mx-auto px-4 py-16 text-center">
        <p className="text-gray-500 mb-4">Event not found.</p>
        <Link to="/events" className="text-[#3D6B34] hover:underline">← Back to Events</Link>
      </div>
      <Footer />
    </div>
  );

  const hasOptions = ev.options?.length > 0;
  const isAdmin = !!myBusinesses.find(b => Number(b.BusinessID) === Number(ev.BusinessID));
  const adminBusinessId = isAdmin ? ev.BusinessID : null;
  const location = [ev.EventLocationName, ev.EventLocationStreet,
    [ev.EventLocationCity, ev.EventLocationState, ev.EventLocationZip].filter(Boolean).join(', ')]
    .filter(Boolean);

  const locationStr = [ev.EventLocationCity, ev.EventLocationState].filter(Boolean).join(', ');
  const evDesc = ev.EventDescription
    ? ev.EventDescription.replace(/<[^>]+>/g, '').slice(0, 155)
    : `${ev.EventName}${locationStr ? ` in ${locationStr}` : ''}. Register for this farm event on Oatmeal Farm Network.`;
  const evCanonical = `https://oatmealfarmnetwork.com/events/${eventId}`;
  const startIso = ev.EventStartDate ? new Date(ev.EventStartDate).toISOString() : undefined;
  const endIso = ev.EventEndDate ? new Date(ev.EventEndDate).toISOString() : startIso;
  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <PageMeta
        title={`${ev.EventName} | Farm Events`}
        description={evDesc}
        keywords={`${ev.EventName}, ${ev.EventType || 'farm event'}, ${ev.BusinessName || ''}, ${locationStr}, farm events, agricultural workshops`}
        image={ev.EventImage || undefined}
        canonical={evCanonical}
        ogType="event"
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'Event',
          name: ev.EventName,
          description: evDesc,
          ...(startIso ? { startDate: startIso } : {}),
          ...(endIso ? { endDate: endIso } : {}),
          ...(ev.EventImage ? { image: ev.EventImage } : {}),
          eventStatus: 'https://schema.org/EventScheduled',
          eventAttendanceMode: 'https://schema.org/OfflineEventAttendanceMode',
          location: {
            '@type': 'Place',
            name: ev.EventLocationName || locationStr || 'TBD',
            ...(ev.EventLocationStreet || ev.EventLocationCity ? {
              address: {
                '@type': 'PostalAddress',
                ...(ev.EventLocationStreet ? { streetAddress: ev.EventLocationStreet } : {}),
                ...(ev.EventLocationCity ? { addressLocality: ev.EventLocationCity } : {}),
                ...(ev.EventLocationState ? { addressRegion: ev.EventLocationState } : {}),
                ...(ev.EventLocationZip ? { postalCode: ev.EventLocationZip } : {}),
              },
            } : {}),
          },
          ...(ev.BusinessName ? {
            organizer: { '@type': 'Organization', name: ev.BusinessName },
          } : {}),
          ...(ev.IsFree ? {
            offers: {
              '@type': 'Offer',
              price: '0',
              priceCurrency: 'USD',
              availability: 'https://schema.org/InStock',
              url: evCanonical,
            }
          } : {}),
        }}
      />
      <Header />

      <div className="max-w-5xl mx-auto px-4 py-8">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Events', to: '/events' },
          { label: ev.EventName },
        ]} />

        <div className={`grid grid-cols-1 gap-8 ${isAdmin ? 'lg:grid-cols-5' : 'lg:grid-cols-3'}`}>

          {/* ── Admin sidebar (organizers only) ── */}
          {isAdmin && (
            <div className="lg:col-span-1 order-first">
              <AdminSidebar ev={ev} eventId={eventId} businessId={adminBusinessId} />
            </div>
          )}

          {/* ── Left: main content ── */}
          <div className={`${isAdmin ? 'lg:col-span-3' : 'lg:col-span-2'} space-y-6`}>

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

            {/* Public feature CTAs — driven by OFNEventFeatures catalog */}
            <PublicFeatureCTAs features={features} ev={ev} eventId={eventId} />

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
