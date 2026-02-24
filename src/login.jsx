import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import Header from './Header';

export default function Login() {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      const body = JSON.stringify({ Email: email, Password: password });
      console.log('Sending:', body);

     const response = await fetch(`${import.meta.env.VITE_API_URL}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: body,
      });

      const data = await response.json();
      console.log('Response:', JSON.stringify(data));

      if (!response.ok) {
        const detail = data.detail;
        if (Array.isArray(detail)) {
          setError(detail.map(function(d) { return d.msg; }).join(', '));
        } else {
          setError(detail || 'Login failed. Please try again.');
        }
        return;
      }

      localStorage.setItem('access_token', data.AccessToken);
      localStorage.setItem('people_id', data.PeopleID);
      localStorage.setItem('first_name', data.PeopleFirstName);
      localStorage.setItem('last_name', data.PeopleLastName);
      localStorage.setItem('access_level', data.AccessLevel);

      navigate('/dashboard');

    } catch (err) {
      console.error('Login error:', err);
      setError('Unable to connect to server. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-white font-sans">
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
              <h1 className="text-white text-2xl font-bold font-lora m-0">Welcome Back</h1>
              <p className="text-white/80 text-sm mt-1">Sign in to your account</p>
            </div>

            <div className="px-8 py-8">
              {error && (
                <div className="bg-red-50 border border-red-200 text-red-700 rounded-xl px-4 py-3 mb-6 text-sm">
                  {error}
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

                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-1.5">
                    Password
                  </label>
                  <input
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    placeholder="••••••••"
                    className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm focus:outline-none focus:border-[#819360] focus:ring-2 focus:ring-[#819360]/20 transition-all"
                  />
                </div>

                <div className="flex justify-end">
                  <Link to="/forgot-password" className="text-xs text-[#819360] hover:text-[#4d734d] font-medium">
                    Forgot password?
                  </Link>
                </div>

                <button
                  type="submit"
                  disabled={loading}
                  className="w-full bg-[#A3301E] hover:bg-[#8a2718] text-white font-bold py-3 px-6 rounded-xl transition-colors duration-200 text-sm uppercase tracking-wider disabled:opacity-60 disabled:cursor-not-allowed"
                >
                  {loading ? 'Signing In...' : 'Sign In'}
                </button>
              </form>

              <p className="text-center text-sm text-gray-500 mt-6">
                Don't have an account?{' '}
                <Link to="/signup" className="text-[#819360] font-semibold hover:text-[#4d734d]">
                  Sign Up
                </Link>
              </p>
            </div>
          </div>
        </div>
      </section>

      <footer className="bg-[#1a1a1a] text-white py-12 mt-12">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p className="text-gray-500 text-xs uppercase tracking-[0.2em]">© 2026 Oatmeal Farm Network. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}
