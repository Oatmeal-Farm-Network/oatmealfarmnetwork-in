import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from './Header';
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
      <Header />

      <div className="max-w-7xl mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-gray-900">Saige</h1>
        <p className="text-gray-500 mt-2">
          Your AI-powered farm assistant.
        </p>

        {isLoggedIn ? (
          <div className="mt-6 w-full" style={{ height: 'calc(100vh - 220px)', minHeight: 600 }}>
            <iframe
              src="https://hitl-ag-agent-frontend-802455386518.us-central1.run.app/"
              title="Saige AI Assistant"
              className="w-full h-full rounded-xl border border-gray-200 shadow"
              style={{ border: 'none' }}
              allow="microphone; camera"
            />
          </div>
        ) : (
          <div className="mt-10 text-center">
            <p className="text-gray-500 mb-4">Please log in to access Saige.</p>
            <button
              onClick={() => navigate('/login')}
              className="px-6 py-3 bg-green-600 text-white rounded-lg font-semibold hover:bg-green-700 transition"
            >
              Login to Access
            </button>
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}