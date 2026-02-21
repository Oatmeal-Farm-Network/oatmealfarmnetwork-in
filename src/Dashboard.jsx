import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from './Header';

export default function Dashboard() {
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) {
      navigate('/login');
    }
  }, [navigate]);

  return (
    <div className="min-h-screen bg-[#f8f9f6] font-sans">
      <Header />

      <footer className="bg-[#1a1a1a] text-white py-12 mt-12">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p className="text-gray-500 text-xs uppercase tracking-[0.2em]">© 2026 Oatmeal Farm Network. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}