import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import HeaderGated from './HeaderGated';
import Footer from './Footer';

export default function SaigePage() {
  const navigate = useNavigate();

  useEffect(() => {
    const AccessToken = localStorage.getItem('AccessToken');
    if (!AccessToken) navigate('/login');
  }, [navigate]);

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <HeaderGated />

      <div className="max-w-7xl mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-gray-900">Saige</h1>
        <p className="text-gray-500 mt-2">Your AI-powered farm assistant — coming soon.</p>
      </div>

      <Footer />
    </div>
  );
}