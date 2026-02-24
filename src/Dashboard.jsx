import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import Header from './Header';

export default function Dashboard() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);

  useEffect(() => {
    // Check if user is logged in
    const token = localStorage.getItem('access_token');
    if (!token) {
      navigate('/login');
      return;
    }

    setUser({
      firstName: localStorage.getItem('first_name'),
      lastName: localStorage.getItem('last_name'),
      peopleId: localStorage.getItem('people_id'),
      accessLevel: parseInt(localStorage.getItem('access_level') || '0'),
    });
  }, [navigate]);

  const handleLogout = () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('people_id');
    localStorage.removeItem('first_name');
    localStorage.removeItem('last_name');
    localStorage.removeItem('access_level');
    navigate('/login');
  };

  if (!user) return null;

  const quickLinks = [
    { title: 'Food-System Directory', link: '/directory', img: '/images/DirectoryHome.webp', desc: 'Browse local food connections' },
    { title: 'Saige AI', link: '/saige', img: '/images/CharlieHome.png', desc: 'AI-powered farm insights' },
    { title: 'Livestock Marketplace', link: '/marketplace', img: '/images/HomepageLivestockMarketplace.webp', desc: 'Buy and sell livestock' },
    { title: 'Plant Knowledgebase', link: '/plants', img: '/images/PlantDBHome.webp', desc: 'Explore 4,000+ plant varieties' },
  ];

  return (
    <div className="min-h-screen bg-[#f8f9f6] font-sans">
      <Header />

      <div className="max-w-7xl mx-auto px-4 py-10">

        {/* Welcome Banner */}
        <div className="bg-[#819360] rounded-[20px] px-8 py-8 mb-8 flex flex-col md:flex-row md:items-center md:justify-between shadow-md">
          <div>
            <h1 className="text-white text-3xl font-bold m-0">
              Welcome back, {user.firstName}!
            </h1>
            <p className="text-white/80 mt-1 text-sm">
              {user.firstName} {user.lastName} &nbsp;·&nbsp; Account #{user.peopleId} &nbsp;·&nbsp; Access Level {user.accessLevel}
            </p>
          </div>
          <button
            onClick={handleLogout}
            className="mt-4 md:mt-0 bg-white text-[#A3301E] font-bold py-2 px-6 rounded-xl text-sm hover:bg-[#A3301E] hover:text-white transition-colors duration-200 uppercase tracking-wider"
          >
            Log Out
          </button>
        </div>

        {/* Quick Links */}
        <h2 className="text-xl font-bold text-gray-800 mb-4">Quick Access</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 mb-10">
          {quickLinks.map((item, i) => (
            <Link
              key={i}
              to={item.link}
              className="bg-white rounded-[20px] shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow duration-200 group"
            >
              <img
                src={item.img}
                alt={item.title}
                className="w-full h-36 object-cover group-hover:scale-105 transition-transform duration-300"
              />
              <div className="p-4">
                <h3 className="text-[#4d734d] font-bold text-sm mb-1">{item.title}</h3>
                <p className="text-gray-500 text-xs">{item.desc}</p>
              </div>
            </Link>
          ))}
        </div>

        {/* Account Info Card */}
        <h2 className="text-xl font-bold text-gray-800 mb-4">Your Account</h2>
        <div className="bg-white rounded-[20px] shadow-sm border border-gray-100 p-6 max-w-md">
          <div className="space-y-3 text-sm">
            <div className="flex justify-between border-b border-gray-100 pb-3">
              <span className="text-gray-500 font-medium">Name</span>
              <span className="text-gray-800 font-semibold">{user.firstName} {user.lastName}</span>
            </div>
            <div className="flex justify-between border-b border-gray-100 pb-3">
              <span className="text-gray-500 font-medium">Account ID</span>
              <span className="text-gray-800 font-semibold">#{user.peopleId}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-500 font-medium">Access Level</span>
              <span className="bg-[#819360] text-white text-xs font-bold px-3 py-1 rounded-full">Level {user.accessLevel}</span>
            </div>
          </div>
        </div>

      </div>

      <footer className="bg-[#1a1a1a] text-white py-12 mt-12">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p className="text-gray-500 text-xs uppercase tracking-[0.2em]">© 2026 Oatmeal Farm Network. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}
