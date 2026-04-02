import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import { useAccount } from './AccountContext';

export default function Dashboard() {
  const navigate = useNavigate();
  const API_URL = import.meta.env.VITE_API_URL;
  const { setBusinesses: setContextBusinesses } = useAccount();
  const [user, setUser] = useState(null);
  const [businesses, setBusinesses] = useState([]);
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

    // Fetch businesses
    if (peopleId) {
      fetch(`${API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
        .then(r => r.json())
        .then(data => {
          const list = Array.isArray(data) ? data : [];
          setBusinesses(list);
          setContextBusinesses(list);
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
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">

          {/* LEFT — Accounts */}
          <div className="bg-white rounded-xl shadow border border-gray-100 p-6">
            <h2 className="text-2xl font-bold mb-4 pb-3 border-b-2 border-green-300" style={{ color: '#3D6B34' }}>
              Accounts / Logbooks
            </h2>

            {/* Add new account */}
            <Link to={`/accounts/new?PeopleID=${user.peopleId}`} style={{
              display: 'flex', flexDirection: 'row', alignItems: 'center',
              padding: '0.5rem', backgroundColor: '#F9FAFB', borderRadius: '0.375rem',
              boxShadow: '0 1px 3px rgba(0,0,0,0.1)', border: '1px solid #F3F4F6',
              textDecoration: 'none', marginBottom: '1rem', color: '#3D6B34',
              transition: 'all 0.2s'
            }}
            onMouseEnter={e => e.currentTarget.style.backgroundColor = '#E5E7EB'}
            onMouseLeave={e => e.currentTarget.style.backgroundColor = '#F9FAFB'}>
              <span style={{ fontSize: '11pt' }}>+ Add a New Account</span>
            </Link>

            {/* Business list */}
            {businesses.length === 0 ? (
              <p className="text-gray-400 text-sm">No accounts found.</p>
            ) : (
              businesses.map(b => (
                <div key={b.BusinessID} style={{
                  display: 'flex', flexDirection: 'row', alignItems: 'center',
                  padding: '0.5rem', backgroundColor: '#F9FAFB', borderRadius: '0.375rem',
                  boxShadow: '0 1px 3px rgba(0,0,0,0.1)', border: '1px solid #F3F4F6',
                  marginBottom: '1rem'
                }}>
                  <div style={{ flexGrow: 1 }}>
                    <Link to={`/account?PeopleID=${user.peopleId}&BusinessID=${b.BusinessID}`}
                      style={{ fontWeight: 'bold', color: '#3D6B34', textDecoration: 'none', fontSize: '11pt' }}>
                      {b.BusinessName}
                    </Link>
                    {b.BusinessType && (
                      <span className="block text-gray-600 text-sm">{b.BusinessType} Account</span>
                    )}
                  </div>
                  <Link to={`/account?PeopleID=${user.peopleId}&BusinessID=${b.BusinessID}`}
                    className="regsubmit2 ml-4">
                    View
                  </Link>
                </div>
              ))
            )}
          </div>

          {/* RIGHT — Weather */}
          <div className="bg-white rounded-xl shadow border border-gray-100 p-6">
            <h2 className="text-2xl font-bold mb-4 pb-3 border-b-2 border-green-300" style={{ color: '#3D6B34' }}>
              Weather
            </h2>

            {weatherLoading ? (
              <p className="text-gray-400 text-sm">Loading weather...</p>
            ) : !weather ? (
              <div>
                <p className="text-gray-400 text-sm mb-2">Weather unavailable. Allow location access to see your local forecast.</p>
              </div>
            ) : (
              <div>
                {/* Location & current conditions */}
                <h5 className="text-center text-gray-600 text-sm mb-2">
                  {weather.location?.city}, {weather.location?.state}
                </h5>

                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-2">
                    <span className="text-4xl font-light">{Math.round(weather.current?.temp_f)}°F</span>
                    {weather.current?.icon && (
                      <img src={weather.current.icon} alt="weather" style={{ width: '3rem', height: '3rem' }} />
                    )}
                    <div>
                      <p className="text-sm text-gray-600">{weather.current?.condition}</p>
                      <p className="text-xs text-gray-500">
                        H: {Math.round(weather.today?.high_f)}°F | L: {Math.round(weather.today?.low_f)}°F
                      </p>
                    </div>
                  </div>
                  <div className="text-right text-xs text-gray-500">
                    <p>Feels like: {Math.round(weather.current?.feelslike_f)}°F</p>
                    <p>Wind: {Math.round(weather.current?.wind_mph)} mph</p>
                    <p>Humidity: {weather.current?.humidity}%</p>
                  </div>
                </div>

                <hr className="my-2" />

                {/* Hourly forecast */}
                {weather.hourly && (
                  <div style={{ display: 'flex', flexDirection: 'row', overflowX: 'auto', marginBottom: '0.5rem' }}>
                    {weather.hourly.map((h, i) => (
                      <div key={i} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '0.2rem', flex: '0 0 auto', minWidth: '50px' }}>
                        <span style={{ fontSize: '0.7rem' }}>{formatHour(h.time)}</span>
                        {h.icon && <img src={h.icon} alt="" style={{ width: '2.5rem', height: '2rem' }} />}
                        <span style={{ fontSize: '0.7rem' }}>{Math.round(h.temp_f)}°F</span>
                      </div>
                    ))}
                  </div>
                )}

                <hr className="my-2" />

                {/* Daily forecast */}
                {weather.daily && (
                  <div style={{ display: 'flex', flexDirection: 'row', overflowX: 'auto' }}>
                    {weather.daily.map((d, i) => (
                      <div key={i} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '0.2rem', flex: '0 0 auto', minWidth: '50px' }}>
                        <span style={{ fontSize: '0.7rem' }}>{dayName(d.date)}</span>
                        {d.icon && <img src={d.icon} alt="" style={{ width: '2rem', height: '2rem' }} />}
                        <span style={{ fontSize: '0.7rem' }}>H: {Math.round(d.high_f)}°F</span>
                        <span style={{ fontSize: '0.7rem' }}>L: {Math.round(d.low_f)}°F</span>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}
          </div>
          {/* END RIGHT weather card */}

        </div>
        {/* END two column grid */}

      </div>
      {/* END outer container */}

    </div>
    /* END min-h-screen wrapper */
  );
}