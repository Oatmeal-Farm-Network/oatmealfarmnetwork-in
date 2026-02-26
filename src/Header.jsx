import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';

const Header = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [user, setUser] = useState(null);
  const navigate = useNavigate();

useEffect(() => {
  const firstName = localStorage.getItem('PeopleFirstName');
  const AccessToken = localStorage.getItem('AccessToken');
  if (AccessToken && firstName) {
    setUser({ firstName });
  }
}, []);

const handleLogout = () => {
  localStorage.removeItem('AccessToken');
  localStorage.removeItem('PeopleID');
  localStorage.removeItem('PeopleFirstName');
  localStorage.removeItem('PeopleLastName');
  localStorage.removeItem('AccessLevel');
  setUser(null);
  navigate('/login');
};

  return (
    <nav className="bg-[#A3301E] py-3 px-4 shadow-2xl sticky top-0 z-50 font-montserrat">
      <div className="max-w-7xl mx-auto flex justify-between items-center">

        {/* Logo */}
        <Link to="/" className="flex items-center shrink-0">
          <img
            src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp"
            className="h-10 md:h-12"
            alt="Oatmeal Farm Network"
          />
        </Link>

        {/* Desktop Navigation */}
        <div className="hidden lg:flex flex-grow justify-center">
          <ul className="flex space-x-10 text-sm font-normal">
            <li><Link to="/" className="nav-link">Home</Link></li>
            <li><Link to="/directory" className="nav-link">Directory</Link></li>
            <li><Link to="/knowledgebases" className="nav-link">Knowledgebases</Link></li>
            <li><Link to="/marketplaces" className="nav-link">Marketplaces</Link></li>
            <li><Link to="/saige" className="nav-link">Saige</Link></li>
            <li><Link to="/about" className="nav-link">About Us</Link></li>
            {!user ? (
              <>
                <li><Link to="/login" className="nav-link">Login</Link></li>
                <li><Link to="/signup" className="nav-link">Signup</Link></li>
              </>
            ) : (
              <>
                <li>
                  <button onClick={handleLogout} className="nav-link">
                    Log Out
                  </button>
                </li>
              </>
            )}
          </ul>
        </div>

        {/* Hamburger */}
        <div className="lg:w-[180px] flex justify-end">
          <button
            onClick={() => setIsOpen(!isOpen)}
            className="lg:hidden text-white text-3xl focus:outline-none"
            type="button"
          >
            {isOpen ? '✕' : '☰'}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {isOpen && (
        <div className="lg:hidden bg-[#A3301E] absolute top-full left-0 w-full border-t border-white/10 shadow-xl z-50">
          <ul className="flex flex-col p-6 space-y-4 text-base font-normal text-center">
            <li><Link to="/" onClick={() => setIsOpen(false)} className="!text-white block">Home</Link></li>
            <li><Link to="/directory" onClick={() => setIsOpen(false)} className="!text-white block">Directory</Link></li>
            <li><Link to="/knowledgebases" onClick={() => setIsOpen(false)} className="!text-white block">Knowledgebases</Link></li>
            <li><Link to="/marketplaces" onClick={() => setIsOpen(false)} className="!text-white block">Marketplaces</Link></li>
            <li><Link to="/saige" onClick={() => setIsOpen(false)} className="!text-white block">Saige</Link></li>
            <li><Link to="/about" onClick={() => setIsOpen(false)} className="!text-white block">About Us</Link></li>
            {!user ? (
              <>
                <li><Link to="/login" onClick={() => setIsOpen(false)} className="!text-white block">Login</Link></li>
                <li><Link to="/signup" onClick={() => setIsOpen(false)} className="!text-white block">Sign Up</Link></li>
              </>
            ) : (
              <>
                <li><button onClick={handleLogout} className="!text-white">Log Out</button></li>
              </>
            )}
          </ul>
        </div>
      )}
    </nav>
  );
};

export default Header;