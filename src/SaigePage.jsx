import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from './Header';
import HeaderGated from './HeaderGated';
import Footer from './Footer';

export default function SaigePage() {
  const navigate = useNavigate();
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    setIsLoggedIn(Boolean(token));
  }, []);

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      {isLoggedIn ? <HeaderGated /> : <Header />}

      <div className="max-w-7xl mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-gray-900">Saige</h1>
        <p className="text-gray-500 mt-2">
          Your AI-powered farm assistant — coming soon.
        </p>

        {!isLoggedIn && (
          <button
            onClick={() => navigate('/login')}
            className="mt-6 px-4 py-2 bg-green-600 text-white rounded"
          >
            Login to Access
          </button>
        )}
      </div>

      <Footer />
    </div>
  );
}