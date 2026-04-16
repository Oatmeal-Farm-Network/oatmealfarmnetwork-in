import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import { useAccount } from './AccountContext';

export default function Dashboard() {
  const navigate = useNavigate();
  const API_URL = import.meta.env.VITE_API_URL;
  const { setBusinesses: setContextBusinesses } = useAccount();
  const [user, setUser] = useState(null);
  const [businesses, setBusinesses] = useState([]);
  const [businessFieldsMap, setBusinessFieldsMap] = useState({});
  const [businessFeaturesMap, setBusinessFeaturesMap] = useState({});
  const [expandedBusiness, setExpandedBusiness] = useState(null);
  const [weather, setWeather] = useState(null);
  const [weatherLoading, setWeatherLoading] = useState(true);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }

    const peopleId = localStorage.getItem('people_id');
    const userData = {
      firstName: localStorage.getItem('first_name'),
      lastName: localStorage.getItem('last_name'),
      peopleId,
      accessLevel: parseInt(localStorage.getItem('access_level') || '0'),
    };
    setUser(userData);

    // Fetch businesses then fetch fields + features for each
    if (peopleId) {
      fetch(`${API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
        .then(r => r.json())
        .then(async data => {
          const list = Array.isArray(data) ? data : [];
          setBusinesses(list);
          setContextBusinesses(list);
          // Auto-expand the first business
          if (list.length > 0) setExpandedBusiness(list[0].BusinessID);
          // Fetch fields only for Farm / Ranch businesses (BusinessTypeID 8)
          const fieldsMap = {};
          await Promise.all(list.filter(b => b.BusinessTypeID === 8).map(async b => {
            try {
              const r = await fetch(`${API_URL}/api/fields?business_id=${b.BusinessID}`);
              if (r.ok) {
                const fields = await r.json();
                if (Array.isArray(fields)) fieldsMap[b.BusinessID] = fields;
              }
            } catch {}
          }));
          setBusinessFieldsMap(fieldsMap);
          // Fetch subscription-aware feature flags for every business
          const featuresMap = {};
          await Promise.all(list.map(async b => {
            try {
              const r = await fetch(`${API_URL}/api/company/features?business_id=${b.BusinessID}`);
              if (r.ok) {
                const rows = await r.json();
                const map = {};
                if (Array.isArray(rows)) rows.forEach(f => { map[f.feature_key] = f.is_enabled; });
                featuresMap[b.BusinessID] = map;
              } else {
                featuresMap[b.BusinessID] = {};
              }
            } catch { featuresMap[b.BusinessID] = {}; }
          }));
          setBusinessFeaturesMap(featuresMap);
        })
        .catch(() => setBusinesses([]));
    }

    // Fetch weather based on user location
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (pos) => {
          const { latitude, longitude } = pos.coords;
          fetch(`${API_URL}/api/weather?lat=${latitude}&lon=${longitude}`)
            .then(r => r.json())
            .then(data => setWeather(data))
            .catch(() => setWeather(null))
            .finally(() => setWeatherLoading(false));
        },
        () => setWeatherLoading(false)
      );
    } else {
      setWeatherLoading(false);
    }
  }, [navigate]);

  const handleLogout = () => {
    ['access_token', 'people_id', 'first_name', 'last_name', 'access_level',
     'AccessToken', 'PeopleID', 'PeopleFirstName', 'PeopleLastName', 'AccessLevel']
      .forEach(k => localStorage.removeItem(k));
    Object.keys(localStorage)
      .filter(k => k.startsWith('saige_'))
      .forEach(k => localStorage.removeItem(k));
    navigate('/login');
  };

  if (!user) return null;

  // BusinessTypeID gating — mirror AccountLayout.jsx so Dashboard and sidebar stay in sync.
  const FARM_TO_TABLE_BTS   = [8, 9, 10, 11, 14, 19, 22, 23, 26, 29, 31, 33, 34];
  const PRODUCE_BTS         = [8, 10, 14, 26, 29, 31, 34];
  const PROCESSED_FOOD_BTS  = [8, 10, 11, 14, 26, 29, 31, 33, 34];
  const MEAT_BTS            = [8, 10, 14, 19, 22, 23, 26, 29];
  const PRODUCTS_BTS        = [8, 10, 11, 14, 15, 16, 18, 19, 24, 25, 26, 29, 31, 33, 34];
  const SERVICES_PROVIDER_BTS = [1, 8, 9, 10, 17, 18, 20, 21, 27, 28, 32];
  const PROPERTIES_BTS      = [8, 30];

  // Return a flat, ordered list of quick links for a business card.
  // Each section is only included when the feature is enabled in the business's
  // subscription (fail-closed when features haven't loaded yet) AND the
  // BusinessType gating allows it.
  const buildQuickLinks = (bt, bid, features) => {
    const feats = features || {};
    const on = (key) => feats[key] === true;
    const links = [];

    if (on('blog')) {
      links.push({ label: '📝 Blog', to: `/blog/manage?BusinessID=${bid}` });
    }

    if (on('livestock')) {
      links.push({ label: '🐄 Animals', to: `/animals?BusinessID=${bid}` });
    }

    if (on('farm_2_table') && FARM_TO_TABLE_BTS.includes(bt)) {
      links.push({ label: '📦 Incoming Orders', to: `/seller/orders?BusinessID=${bid}` });
      if (PRODUCE_BTS.includes(bt))        links.push({ label: '🥬 Produce',        to: `/produce/inventory?BusinessID=${bid}` });
      if (PROCESSED_FOOD_BTS.includes(bt)) links.push({ label: '🍯 Processed Foods', to: `/produce/processed-food?BusinessID=${bid}` });
      if (MEAT_BTS.includes(bt))           links.push({ label: '🥩 Meat',           to: `/produce/meat?BusinessID=${bid}` });
    }

    if (on('products') && PRODUCTS_BTS.includes(bt)) {
      links.push({ label: '🛍️ Products', to: `/products/settings?BusinessID=${bid}` });
    }

    if (on('services')) {
      if (SERVICES_PROVIDER_BTS.includes(bt)) {
        links.push({ label: '🔧 My Services', to: `/services?BusinessID=${bid}` });
      } else {
        links.push({ label: '🔧 Browse Services', to: '/services/directory' });
      }
    }

    if (on('events')) {
      links.push({ label: '🎪 Events', to: `/events/manage?BusinessID=${bid}` });
    }

    if (on('properties') && PROPERTIES_BTS.includes(bt)) {
      links.push({ label: '🏡 Properties', to: `/properties?BusinessID=${bid}` });
    }

    if (on('associations') && bt === 1) {
      links.push({ label: '🏛️ Association', to: `/association/create?BusinessID=${bid}` });
    }

    if (on('my_website')) {
      links.push({ label: '🌐 My Website', to: `/website/builder?BusinessID=${bid}` });
    }

    return links;
  };

  const formatHour = (timeStr) => {
    const d = new Date(timeStr);
    const h = d.getHours();
    if (h === 0) return '12a';
    if (h === 12) return 'Noon';
    return h < 12 ? `${h}am` : `${h - 12}pm`;
  };

  const dayName = (dateStr) => {
    const days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    return days[new Date(dateStr).getDay()];
  };

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <PageMeta
        title="Dashboard | Oatmeal Farm Network"
        description="Your Oatmeal Farm Network dashboard — manage your farm businesses, orders, livestock, and more."
        noIndex
      />
      <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '1.5rem 1rem 3rem' }}>

        {/* Welcome Banner */}
        <div className="rounded-xl px-8 py-6 mb-8 flex flex-col md:flex-row md:items-center md:justify-between shadow"
             style={{ background: 'linear-gradient(to right, #4d734d, #819360)' }}>
          <div>
            <h1 className="text-white text-2xl font-bold m-0">Welcome back, {user.firstName}!</h1>
            <p className="text-white/80 mt-1 text-sm">{user.firstName} {user.lastName} · Account #{user.peopleId}</p>
          </div>
          <button onClick={handleLogout}
            className="mt-4 md:mt-0 bg-white text-[#A3301E] font-bold py-2 px-6 rounded-xl text-sm hover:bg-red-50 transition-colors uppercase tracking-wider">
            Log Out
          </button>
        </div>

        {/* Two column layout */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">

          {/* LEFT (2/3) — Accounts + Fields */}
          <div className="lg:col-span-2 flex flex-col gap-4">

            <div className="bg-white rounded-xl shadow border border-gray-100 p-6">
              <div className="flex items-center justify-between mb-4 pb-3 border-b-2 border-green-300">
                <h2 className="text-2xl font-bold" style={{ color: '#3D6B34' }}>Accounts / Logbooks</h2>
                <Link to={`/accounts/new?PeopleID=${user.peopleId}`}
                  className="text-sm font-semibold text-[#3D6B34] hover:underline">
                  + Add Account
                </Link>
              </div>

              {businesses.length === 0 ? (
                <p className="text-gray-400 text-sm">No accounts found.</p>
              ) : (
                businesses.map(b => {
                  const isFarmRanch = b.BusinessTypeID === 8;
                  const fields = isFarmRanch ? (businessFieldsMap[b.BusinessID] || []) : [];
                  const activeFields = fields.filter(f => f.monitoring_enabled);
                  const isExpanded = expandedBusiness === b.BusinessID;
                  const features = businessFeaturesMap[b.BusinessID];
                  const quickLinks = buildQuickLinks(b.BusinessTypeID, b.BusinessID, features);

                  return (
                    <div key={b.BusinessID} className="mb-4 rounded-xl border border-gray-100 overflow-hidden shadow-sm">
                      {/* Business header row */}
                      <div
                        className="flex items-center justify-between px-5 py-3 cursor-pointer hover:bg-gray-50 transition-colors"
                        style={{ background: '#f8faf5' }}
                        onClick={() => setExpandedBusiness(isExpanded ? null : b.BusinessID)}
                      >
                        <div className="flex items-center gap-3 min-w-0">
                          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#3D6B34" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="shrink-0">
                            {isExpanded ? <path d="M18 15l-6-6-6 6" /> : <path d="M6 9l6 6 6-6" />}
                          </svg>
                          <div className="min-w-0">
                            <span className="font-bold text-gray-900 text-base">{b.BusinessName}</span>
                            {b.BusinessType && (
                              <span className="ml-2 text-xs text-gray-500">{b.BusinessType}</span>
                            )}
                          </div>
                        </div>
                        <div className="flex items-center gap-2 shrink-0">
                          {fields.length > 0 && (
                            <span className="text-xs bg-green-100 text-green-700 px-2 py-0.5 rounded-full font-medium">
                              {fields.length} field{fields.length !== 1 ? 's' : ''}
                            </span>
                          )}
                          <Link
                            to={`/account?PeopleID=${user.peopleId}&BusinessID=${b.BusinessID}`}
                            className="regsubmit2 text-xs"
                            onClick={e => e.stopPropagation()}
                          >
                            View
                          </Link>
                        </div>
                      </div>

                      {/* Expanded content */}
                      {isExpanded && (
                        <div className="px-5 pb-4 pt-3 border-t border-gray-100">
                          {isFarmRanch && features?.precision_ag && (
                            <>
                              {/* Summary stats row */}
                              {fields.length > 0 && (
                                <div className="grid grid-cols-3 gap-3 mb-4">
                                  <div className="rounded-lg p-3 text-center" style={{ background: '#6D8E2244' }}>
                                    <div className="text-2xl font-bold text-gray-800">{fields.length}</div>
                                    <div className="text-xs text-gray-600 mt-0.5">Total Fields</div>
                                  </div>
                                  <div className="rounded-lg p-3 text-center" style={{ background: '#FFC56744' }}>
                                    <div className="text-2xl font-bold text-gray-800">{activeFields.length}</div>
                                    <div className="text-xs text-gray-600 mt-0.5">Active</div>
                                  </div>
                                  <div className="rounded-lg p-3 text-center" style={{ background: '#2AB9CF44' }}>
                                    <div className="text-2xl font-bold text-gray-800">
                                      {fields.filter(f => f.latitude && f.longitude).length}
                                    </div>
                                    <div className="text-xs text-gray-600 mt-0.5">With GPS</div>
                                  </div>
                                </div>
                              )}

                              {/* Fields list */}
                              {fields.length === 0 ? (
                                <div className="text-center py-6 text-gray-400 text-sm">
                                  <p className="mb-2">No fields yet.</p>
                                  <Link
                                    to={`/precision-ag/fields?BusinessID=${b.BusinessID}&view=create-field`}
                                    className="regsubmit2 text-xs"
                                  >
                                    + Add First Field
                                  </Link>
                                </div>
                              ) : (
                                <div className="flex flex-col gap-2 mb-4">
                                  {fields.map(field => (
                                    <Link
                                      key={field.fieldid}
                                      to={`/precision-ag/analyses?BusinessID=${b.BusinessID}&FieldID=${field.fieldid}`}
                                      className="flex items-center justify-between px-4 py-2.5 rounded-lg border border-gray-100 hover:border-green-200 hover:bg-green-50/40 transition-all group"
                                      style={{ background: '#fafafa' }}
                                    >
                                      <div className="min-w-0">
                                        <span className="font-semibold text-gray-800 text-sm group-hover:text-[#3D6B34]">
                                          {field.name}
                                        </span>
                                        {field.address && (
                                          <span className="ml-2 text-xs text-gray-400 truncate">
                                            📍 {field.address}
                                          </span>
                                        )}
                                      </div>
                                      <div className="flex items-center gap-2 shrink-0">
                                        <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${
                                          field.monitoring_enabled
                                            ? 'bg-green-100 text-green-700'
                                            : 'bg-gray-100 text-gray-500'
                                        }`}>
                                          {field.monitoring_enabled ? 'Active' : 'Inactive'}
                                        </span>
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                          <path d="M9 18l6-6-6-6" />
                                        </svg>
                                      </div>
                                    </Link>
                                  ))}
                                </div>
                              )}

                              {/* Precision Ag action links */}
                              <div className="flex flex-wrap gap-2 pb-3 mb-3 border-b border-gray-100">
                                <Link
                                  to={`/precision-ag/fields?BusinessID=${b.BusinessID}&view=create-field`}
                                  className="text-xs font-medium text-white bg-[#3D6B34] hover:bg-[#2d5226] px-3 py-1.5 rounded-lg transition-colors"
                                >
                                  + Add Field
                                </Link>
                                <Link
                                  to={`/precision-ag/fields?BusinessID=${b.BusinessID}`}
                                  className="text-xs font-medium text-[#3D6B34] border border-[#3D6B34]/30 hover:bg-green-50 px-3 py-1.5 rounded-lg transition-colors"
                                >
                                  🗺️ Manage Fields
                                </Link>
                                <Link
                                  to={`/oatsense/crop-rotation?BusinessID=${b.BusinessID}`}
                                  className="text-xs font-medium text-[#3D6B34] border border-[#3D6B34]/30 hover:bg-green-50 px-3 py-1.5 rounded-lg transition-colors"
                                >
                                  🌾 Crop Rotation
                                </Link>
                                <Link
                                  to={`/oatsense/notes?BusinessID=${b.BusinessID}`}
                                  className="text-xs font-medium text-[#3D6B34] border border-[#3D6B34]/30 hover:bg-green-50 px-3 py-1.5 rounded-lg transition-colors"
                                >
                                  📓 Field Journal
                                </Link>
                                <Link
                                  to={`/precision-ag/crop-detection?BusinessID=${b.BusinessID}`}
                                  className="text-xs font-medium text-[#3D6B34] border border-[#3D6B34]/30 hover:bg-green-50 px-3 py-1.5 rounded-lg transition-colors"
                                >
                                  🔍 Crop Detection
                                </Link>
                              </div>
                            </>
                          )}

                          {/* Subscription- and type-aware quick links for every business */}
                          <div className="flex flex-wrap gap-2">
                            <Link
                              to={`/account?PeopleID=${user.peopleId}&BusinessID=${b.BusinessID}`}
                              className="text-xs font-medium text-white bg-[#3D6B34] hover:bg-[#2d5226] px-3 py-1.5 rounded-lg transition-colors"
                            >
                              Go to Account
                            </Link>
                            {features === undefined ? (
                              <span className="text-xs text-gray-400 italic px-1 py-1.5">Loading…</span>
                            ) : quickLinks.length === 0 ? (
                              <span className="text-xs text-gray-400 italic px-1 py-1.5">
                                No features available on this subscription.
                              </span>
                            ) : (
                              quickLinks.map(link => (
                                <Link
                                  key={link.to}
                                  to={link.to}
                                  className="text-xs font-medium text-[#3D6B34] border border-[#3D6B34]/30 hover:bg-green-50 px-3 py-1.5 rounded-lg transition-colors"
                                >
                                  {link.label}
                                </Link>
                              ))
                            )}
                          </div>
                        </div>
                      )}
                    </div>
                  );
                })
              )}
            </div>
          </div>
          {/* END LEFT column */}

          {/* RIGHT (1/3) — Weather */}
          <div className="bg-white rounded-xl shadow border border-gray-100 p-6 h-fit sticky top-4">
            <h2 className="text-2xl font-bold mb-4 pb-3 border-b-2 border-green-300" style={{ color: '#3D6B34' }}>
              Weather
            </h2>

            {weatherLoading ? (
              <p className="text-gray-400 text-sm">Loading weather…</p>
            ) : !weather ? (
              <p className="text-gray-400 text-sm">
                Weather unavailable. Allow location access to see your local forecast.
              </p>
            ) : (
              <div>
                {/* Location */}
                {weather.location?.city && (
                  <p className="text-center text-gray-500 text-sm mb-3">
                    📍 {weather.location.city}, {weather.location.state}
                  </p>
                )}

                {/* Current conditions */}
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-3">
                    <span className="text-5xl font-light text-gray-800">
                      {Math.round(weather.current?.temp_f ?? 0)}°F
                    </span>
                    {weather.current?.icon && (
                      <img src={weather.current.icon} alt="weather" style={{ width: '3.5rem', height: '3.5rem' }} />
                    )}
                    <div>
                      <p className="text-sm font-medium text-gray-700">{weather.current?.condition}</p>
                      {weather.today?.high_f != null && (
                        <p className="text-xs text-gray-500 mt-0.5">
                          H: {Math.round(weather.today.high_f)}°F &nbsp;·&nbsp; L: {Math.round(weather.today.low_f ?? 0)}°F
                        </p>
                      )}
                    </div>
                  </div>
                  <div className="text-right text-xs text-gray-500 space-y-0.5">
                    {weather.current?.feelslike_f != null && (
                      <p>Feels like: {Math.round(weather.current.feelslike_f)}°F</p>
                    )}
                    <p>Wind: {Math.round(weather.current?.wind_mph ?? 0)} mph{weather.current?.wind_dir ? ` ${weather.current.wind_dir}` : ''}</p>
                    {weather.current?.humidity != null && (
                      <p>Humidity: {Math.round(weather.current.humidity)}%</p>
                    )}
                  </div>
                </div>

                <hr className="my-2 border-gray-100" />

                {/* Hourly forecast */}
                {weather.hourly?.length > 0 && (
                  <>
                    <p className="text-xs font-semibold text-gray-400 mb-1 uppercase tracking-wide">Hourly</p>
                    <div style={{ display: 'flex', overflowX: 'auto', gap: '0.25rem', marginBottom: '0.5rem' }}>
                      {weather.hourly.map((h, i) => (
                        <div key={i} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', flex: '0 0 auto', minWidth: '48px', padding: '0.2rem' }}>
                          <span style={{ fontSize: '0.65rem', color: '#9CA3AF' }}>{formatHour(h.time)}</span>
                          {h.icon && <img src={h.icon} alt="" style={{ width: '2.2rem', height: '2.2rem' }} />}
                          <span style={{ fontSize: '0.7rem', fontWeight: 600 }}>{Math.round(h.temp_f)}°</span>
                        </div>
                      ))}
                    </div>
                    <hr className="my-2 border-gray-100" />
                  </>
                )}

                {/* Daily forecast */}
                {weather.daily?.length > 0 && (
                  <>
                    <p className="text-xs font-semibold text-gray-400 mb-1 uppercase tracking-wide">7-Day</p>
                    <div style={{ display: 'flex', overflowX: 'auto', gap: '0.25rem' }}>
                      {weather.daily.map((d, i) => (
                        <div key={i} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', flex: '0 0 auto', minWidth: '52px', padding: '0.25rem', background: i === 0 ? '#f0f5e8' : 'transparent', borderRadius: '0.5rem' }}>
                          <span style={{ fontSize: '0.65rem', fontWeight: 600, color: '#6B7280' }}>{i === 0 ? 'Today' : dayName(d.date)}</span>
                          {d.icon && <img src={d.icon} alt="" style={{ width: '2rem', height: '2rem' }} />}
                          <span style={{ fontSize: '0.68rem', color: '#EF4444', fontWeight: 600 }}>
                            {d.high_f != null ? `${Math.round(d.high_f)}°` : '—'}
                          </span>
                          <span style={{ fontSize: '0.68rem', color: '#3B82F6' }}>
                            {d.low_f != null ? `${Math.round(d.low_f)}°` : '—'}
                          </span>
                        </div>
                      ))}
                    </div>
                  </>
                )}
              </div>
            )}
          </div>
          {/* END RIGHT weather card */}

        </div>
        {/* END grid */}

      </div>
      {/* END outer container */}

    </div>
  );
}
