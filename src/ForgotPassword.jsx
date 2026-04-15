import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

export default function ForgotPassword() {
  const [email, setEmail]                   = useState('');
  const [error, setError]                   = useState('');
  const [loading, setLoading]               = useState(false);
  const [sent, setSent]                     = useState(false);
  const [notFound, setNotFound]             = useState(false);
  const [submittedEmail, setSubmittedEmail] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setNotFound(false);
    setLoading(true);
    setSubmittedEmail(email);

    try {
      const body = JSON.stringify({ Email: email });
      console.log('Sending:', body);

      const response = await fetch(`${import.meta.env.VITE_API_URL}/auth/forgot-password`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: body,
      });

      const text = await response.text();
      console.log('Raw response:', text);
      const data = text ? JSON.parse(text) : {};
      console.log('Response:', JSON.stringify(data));

      if (response.status === 404) {
        setNotFound(true);
        return;
      }

      if (!response.ok) {
        setError(data.detail || `Request failed (${response.status}). Please try again.`);
        return;
      }

      setSent(true);

    } catch (err) {
      console.error('Forgot password error:', err);
      setError('Unable to connect to server. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen font-sans">
      <PageMeta
        title="Forgot Password | Oatmeal Farm Network"
        description="Recover your Oatmeal Farm Network account password by email."
        noIndex
      />
      <Header />

      <section className="py-16 px-4">
        <div className="max-w-md mx-auto">
          <div className="bg-white rounded-[20px] shadow-[0_8px_32px_rgba(0,0,0,0.12)] border border-gray-100 overflow-hidden">

            <div className="bg-[#819360] px-8 py-8 text-center">
              <img
                src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp"
                alt="Oatmeal Farm Network"
                className="h-10 mx-auto mb-4"
              />
              <h1 className="text-white text-2xl font-bold font-lora m-0">Retrieve Your Password</h1>
              <p className="text-white/80 text-sm mt-1">We'll email it to you right away</p>
            </div>

            <div className="px-8 py-8">

              {/* ── SUCCESS ── */}
              {sent && (
                <div className="text-center space-y-4">
                  <div className="text-5xl">✉️</div>
                  <h2 className="text-xl font-bold text-gray-800">Password Sent!</h2>
                  <p className="text-sm text-gray-600">
                    Your password has been emailed to{' '}
                    <span className="font-semibold text-gray-800">{submittedEmail}</span>.
                    Please check your inbox and log in.
                  </p>
                  <p className="text-xs text-gray-500">
                    Don't see it? Check your spam folder.
                  </p>
                  <Link
                    to="/login"
                    className="inline-block mt-2  hover:bg-[#4d734d] text-white font-bold py-2.5 px-6 rounded-xl transition-colors duration-200 text-sm uppercase tracking-wider"
                  >
                    Go to Login
                  </Link>
                </div>
              )}

              {/* ── FORM (idle, not found, error) ── */}
              {!sent && (
                <>
                  <p className="text-sm text-gray-600 mb-6">
                    Enter the email address associated with your account and we'll send your password to you.
                  </p>

                  {error && (
                    <div className="bg-red-50 border border-red-200 text-red-700 rounded-xl px-4 py-3 mb-6 text-sm">
                      {error}
                    </div>
                  )}

                  {notFound && (
                    <div className="bg-red-50 border border-red-200 text-red-700 rounded-xl px-4 py-3 mb-6 text-sm">
                      The email address <span className="font-semibold">{submittedEmail}</span> was not found in our system.
                      Please double-check or{' '}
                      <Link to="/signup" className="underline font-semibold">create a new account</Link>.
                    </div>
                  )}

                  <form onSubmit={handleSubmit} className="space-y-5">
                    <div>
                      <label className="block text-sm font-semibold text-gray-700 mb-1.5">
                        Email Address
                      </label>
                      <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                        placeholder="you@example.com"
                        className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20 transition-all"
                      />
                    </div>

                    <button
                      type="submit"
                      disabled={loading}
                      className="w-full bg-[#A3301E] hover:bg-[#8a2718] text-white font-bold py-3 px-6 rounded-xl transition-colors duration-200 text-sm uppercase tracking-wider disabled:opacity-60 disabled:cursor-not-allowed"
                    >
                      {loading ? 'Sending...' : 'Send My Password'}
                    </button>
                  </form>

                  <p className="text-center text-sm text-gray-500 mt-6">
                    Remember your password?{' '}
                    <Link to="/login" className="text-[#819360] font-semibold hover:text-[#4d734d]">
                      Sign In
                    </Link>
                  </p>
                </>
              )}

            </div>
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
}