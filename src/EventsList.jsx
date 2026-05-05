import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useLanguage } from './LanguageContext';

const API = import.meta.env.VITE_API_URL || '';

function formatDate(d) {
  if (!d) return '';
  const dt = new Date(d);
  return dt.toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });
}

function dateRange(start, end) {
  if (!start) return '';
  if (!end || start === end) return formatDate(start);
  return `${formatDate(start)} – ${formatDate(end)}`;
}

export default function EventsList() {
  const { t } = useTranslation();
  const { language } = useLanguage();
  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events?lang=${language}`)
      .then(r => r.ok ? r.json() : [])
      .then(d => { setEvents(Array.isArray(d) ? d : []); setLoading(false); })
      .catch(() => setLoading(false));
  }, [language]);

  const filtered = events.filter(e =>
    !filter ||
    e.EventName?.toLowerCase().includes(filter.toLowerCase()) ||
    e.EventType?.toLowerCase().includes(filter.toLowerCase()) ||
    e.EventLocationCity?.toLowerCase().includes(filter.toLowerCase()) ||
    e.BusinessName?.toLowerCase().includes(filter.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gray-50 font-sans flex flex-col">
      <PageMeta
        title="Farm Events & Agricultural Workshops"
        description="Discover upcoming farm events, agricultural workshops, farm tours, and food industry conferences near you. Browse and register for events on Oatmeal Farm Network."
        keywords="farm events, agricultural workshops, farm tours, farmers market events, livestock shows, harvest festivals, ag conferences, food industry events"
        canonical="https://oatmealfarmnetwork.com/events"
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'CollectionPage',
          name: 'Farm Events & Agricultural Workshops',
          description: 'Upcoming farm events, workshops, tours, and agricultural gatherings.',
          url: 'https://oatmealfarmnetwork.com/events',
        }}
      />
      <Header />

      {/* Hero */}
      <div className="w-full mx-auto px-4 pt-2" style={{ maxWidth: '1300px' }}>
        <div
          className="relative bg-[#3D6B34] text-white py-16 px-8 bg-center bg-cover rounded-xl overflow-hidden"
          style={{ backgroundImage: "url('/images/EventsHeader.webp')" }}
        >
          <div className="absolute inset-0 bg-black/40" aria-hidden="true" />
          <div className="relative">
            <h1 className="text-3xl font-bold mb-2 drop-shadow" style={{ color: '#fff' }}>{t('events.title')}</h1>
            <p className="text-white drop-shadow">{t('events.subtitle')}</p>
          </div>
        </div>
      </div>

      <div className="max-w-[1300px] mx-auto px-4 py-8 grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: t('events.title') },
        ]} />

        <div className="mb-6">
          <input
            value={filter}
            onChange={e => setFilter(e.target.value)}
            placeholder={t('events.search_placeholder')}
            className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm focus:outline-none focus:border-[#3D6B34]"
          />
        </div>

        {loading ? (
          <div className="text-center py-20 text-gray-400">{t('events.loading')}</div>
        ) : filtered.length === 0 ? (
          <div className="bg-white rounded-xl border border-gray-200 p-16 text-center text-gray-400">
            {filter ? t('events.no_match') : t('events.no_events')}
          </div>
        ) : (
          <div className="space-y-5">
            {filtered.map(ev => (
              <Link
                key={ev.EventID}
                to={`/events/${ev.EventID}`}
                className="bg-white border border-gray-200 rounded-xl shadow-sm hover:shadow-md transition-all flex gap-5 p-5 no-underline group"
              >
                {ev.EventImage ? (
                  <img src={ev.EventImage} alt={ev.EventName}
                    className="w-24 h-24 rounded-lg object-cover shrink-0"
                    onError={e => e.target.style.display = 'none'} />
                ) : (
                  <div className="w-24 h-24 rounded-lg bg-[#3D6B34]/10 flex items-center justify-center shrink-0 text-3xl">🎪</div>
                )}

                <div className="grow min-w-0">
                  <div className="flex items-start justify-between gap-3 flex-wrap">
                    <div>
                      <h3 className="font-bold text-gray-800 text-lg group-hover:text-[#3D6B34] transition-colors mb-0.5">
                        {ev.EventName}
                      </h3>
                      <p className="text-xs text-gray-500 mb-1">{t('events.hosted_by', { name: ev.BusinessName })}</p>
                    </div>
                    <div className="flex gap-2 flex-wrap">
                      {ev.IsFree ? (
                        <span className="text-xs bg-green-100 text-green-700 font-semibold px-2 py-0.5 rounded-full">{t('events.free_badge')}</span>
                      ) : (
                        <span className="text-xs bg-blue-100 text-blue-700 font-semibold px-2 py-0.5 rounded-full">{t('events.paid_badge')}</span>
                      )}
                      {ev.RegistrationRequired ? (
                        <span className="text-xs bg-amber-100 text-amber-700 font-semibold px-2 py-0.5 rounded-full">{t('events.reg_required')}</span>
                      ) : null}
                      {ev.EventType && (
                        <span className="text-xs bg-gray-100 text-gray-600 font-medium px-2 py-0.5 rounded-full">{ev.EventType}</span>
                      )}
                    </div>
                  </div>

                  <div className="flex items-center gap-4 text-sm text-gray-500 mt-1 flex-wrap">
                    {(ev.EventStartDate || ev.EventEndDate) && (
                      <span className="flex items-center gap-1">
                        <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                        </svg>
                        {dateRange(ev.EventStartDate, ev.EventEndDate)}
                      </span>
                    )}
                    {(ev.EventLocationCity || ev.EventLocationState) && (
                      <span className="flex items-center gap-1">
                        <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                        </svg>
                        {[ev.EventLocationCity, ev.EventLocationState].filter(Boolean).join(', ')}
                      </span>
                    )}
                    {ev.AttendeeCount > 0 && (
                      <span className="flex items-center gap-1">
                        <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0" />
                        </svg>
                        {t('events.registered_count', { count: ev.AttendeeCount })}
                      </span>
                    )}
                  </div>

                  {ev.EventDescription && (
                    <p className="text-sm text-gray-600 mt-2 line-clamp-2">{ev.EventDescription}</p>
                  )}
                </div>
              </Link>
            ))}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
