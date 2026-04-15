import React, { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

export default function ContactUsConfirm() {
  const location = useLocation();
  const payload = location.state?.payload;
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    setIsLoggedIn(Boolean(token));
  }, []);

  return (
    <div className="min-h-screen bg-[#FBF9F4]">
      <PageMeta
        title="Thank You | Oatmeal Farm Network"
        description="Thanks for contacting Oatmeal Farm Network. We'll be in touch soon."
        noIndex
      />
      <Header />
      <main className="max-w-2xl mx-auto px-4 py-12">
        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'Contact Us', to: '/contact' }, { label: 'Confirmation' }]} />
        <section className="bg-white rounded-2xl p-8 md:p-10 shadow-[0_10px_25px_rgba(74,92,67,0.08)] text-center">
          <h1 className="text-3xl font-bold text-[#4A5C43] mb-4">Thank You</h1>
          <p className="text-gray-700 mb-6">We will get back to you soon.</p>

          {payload && (
            <div className="mb-8 rounded-xl bg-gray-50 border border-gray-200 p-4 text-left">
              <p className="text-sm text-gray-700 mb-1">
                <strong>Name:</strong> {payload.FName} {payload.LName}
              </p>
              <p className="text-sm text-gray-700 mb-1">
                <strong>Email:</strong> {payload.Email}
              </p>
              {payload.BizName && (
                <p className="text-sm text-gray-700">
                  <strong>Organization:</strong> {payload.BizName}
                </p>
              )}
            </div>
          )}

          <Link to={isLoggedIn ? '/dashboard' : '/'} className="regsubmit2">
            {isLoggedIn ? 'Return To Dashboard' : 'Return To Home'}
          </Link>
        </section>
      </main>
      <Footer />
    </div>
  );
}
