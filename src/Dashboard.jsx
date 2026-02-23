import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import HeaderGated from './HeaderGated';
import Footer from './Footer';

export default function Dashboard() {
  const navigate = useNavigate();
  const [Businesses, setBusinesses] = useState([]);
  const [Weather, setWeather] = useState(null);
  const [WeatherError, setWeatherError] = useState(false);

  useEffect(() => {
    const AccessToken = localStorage.getItem('AccessToken');
    if (!AccessToken) {
      navigate('/login');
      return;
    }

    const PeopleID = localStorage.getItem('PeopleID');

    // Fetch businesses
fetch(`${import.meta.env.VITE_API_URL}/auth/my-businesses?PeopleID=${PeopleID}`)
      .then(Res => Res.json())
      .then(Data => setBusinesses(Data))
      .catch(Err => console.error('Error fetching businesses:', Err));

    // Fetch weather
    const ApiKey = '8cc8baea4a6f46b68d0213631252908';
    fetch(`https://api.weatherapi.com/v1/forecast.json?key=${ApiKey}&q=auto:ip&days=7&aqi=no&alerts=no`)
      .then(Res => Res.json())
      .then(Data => setWeather(Data))
      .catch(Err => {
        console.error('Weather error:', Err);
        setWeatherError(true);
      });

  }, [navigate]);

  const GetDayName = (DateStr) => {
    const Days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Days[new Date(DateStr).getDay()];
  };

  const FormatHour = (TimeStr) => {
    const Hour = new Date(TimeStr).getHours();
    if (Hour === 0) return '12a';
    if (Hour === 12) return 'Noon';
    if (Hour > 12) return `${Hour - 12}pm`;
    return `${Hour}am`;
  };

  const GetHourlyItems = () => {
    if (!Weather) return [];
    const CurrentHour = new Date(Weather.current.last_updated).getHours();
    const Hours = Weather.forecast.forecastday[0].hour;
    const Items = [];
    for (let I = 0; I < 8; I++) {
      const HourIndex = (CurrentHour + I * 3) % 24;
      Items.push(Hours[HourIndex]);
    }
    return Items;
  };

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <HeaderGated />

      <div className="max-w-7xl mx-auto px-4 py-8">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">

          {/* LEFT: My Accounts */}
          <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
            <h2 className="text-2xl font-bold text-green-700 mb-4 border-b-2 border-green-300 pb-3">
              My Accounts
            </h2>

            <div className="flex flex-col gap-3 mb-4">
              <Link
                to={`/accounts/new?PeopleID=${localStorage.getItem('PeopleID')}`}
                className="flex items-center p-3 bg-gray-50 rounded-lg border border-gray-100 shadow-sm hover:bg-gray-200 transition-all text-[#3D6B34] font-medium text-sm"
              >
                Add a New Account
              </Link>
              <Link
                to={`/accounts/delete?PeopleID=${localStorage.getItem('PeopleID')}`}
                className="flex items-center p-3 bg-gray-50 rounded-lg border border-gray-100 shadow-sm hover:bg-gray-200 transition-all text-[#3D6B34] font-medium text-sm"
              >
                Delete an Account
              </Link>
            </div>

            <div className="flex flex-col gap-3">
              {Businesses.length === 0 && (
                <p className="text-gray-500 text-sm">No accounts found.</p>
              )}
              {Businesses.map(B => (
                <div key={B.BusinessID} className="p-3 bg-gray-50 rounded-lg border border-gray-100 shadow-sm">
                  <Link
                    to={`/account?PeopleID=${localStorage.getItem('PeopleID')}&BusinessID=${B.BusinessID}`}
                    className="font-bold text-[#3D6B34] hover:underline text-sm"
                  >
                    {B.BusinessName}
                  </Link>
                </div>
              ))}
            </div>
          </div>

          {/* RIGHT: Weather */}
          <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
            {WeatherError && (
              <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-md">
                Unable to load weather data. Please check the API key.
              </div>
            )}

            {!Weather && !WeatherError && (
              <p className="text-gray-500 text-sm">Loading weather...</p>
            )}

            {Weather && (
              <div>
                <h2 className="text-xl font-bold text-center text-gray-700 mb-3">
                  Weather for {Weather.location.name}, {Weather.location.region}
                </h2>

                {/* Current Weather */}
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-2">
                    <span className="text-4xl font-bold">{Math.round(Weather.current.temp_f)}°F</span>
                    <img src={`https:${Weather.current.condition.icon}`} alt="weather" className="w-12 h-12" />
                    <div className="text-sm text-gray-600">
                      <p>{Weather.current.condition.text}</p>
                      <p>H: {Math.round(Weather.forecast.forecastday[0].day.maxtemp_f)}°F | L: {Math.round(Weather.forecast.forecastday[0].day.mintemp_f)}°F</p>
                    </div>
                  </div>
                  <div className="text-sm text-gray-600 text-right">
                    <p>Feels like: {Math.round(Weather.current.feelslike_f)}°F</p>
                    <p>Wind: {Math.round(Weather.current.wind_mph)} mph</p>
                    <p>Humidity: {Weather.current.humidity}%</p>
                  </div>
                </div>

                <hr className="my-2" />

                {/* Hourly Forecast */}
                <div className="flex overflow-x-auto gap-2 py-2">
                  {GetHourlyItems().map((Hour, I) => (
                    <div key={I} className="flex flex-col items-center min-w-[50px] text-xs text-gray-600">
                      <span>{FormatHour(Hour.time)}</span>
                      <img src={`https:${Hour.condition.icon}`} alt="weather" className="w-8 h-8" />
                      <span>{Math.round(Hour.temp_f)}°F</span>
                    </div>
                  ))}
                </div>

                <hr className="my-2" />

                {/* 7-Day Forecast */}
                <div className="flex overflow-x-auto gap-2 py-2">
                  {Weather.forecast.forecastday.map((Day, I) => (
                    <div key={I} className="flex flex-col items-center min-w-[50px] text-xs text-gray-600">
                      <span>{GetDayName(Day.date)}</span>
                      <img src={`https:${Day.day.condition.icon}`} alt="weather" className="w-8 h-8" />
                      <span>H: {Math.round(Day.day.maxtemp_f)}°F</span>
                      <span>L: {Math.round(Day.day.mintemp_f)}°F</span>
                    </div>
                  ))}
                </div>

              </div>
            )}
          </div>

        </div>
      </div>

      <Footer />
    </div>
  );
}