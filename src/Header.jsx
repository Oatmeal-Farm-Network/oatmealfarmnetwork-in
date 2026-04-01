import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAccount } from './AccountContext';

const Header = () => {
  const { businesses } = useAccount();
  const [isOpen, setIsOpen] = useState(false);
  const [kbOpen, setKbOpen] = useState(false);
  const [kbMobileOpen, setKbMobileOpen] = useState(false);
  const [mktOpen, setMktOpen] = useState(false);
  const [mktMobileOpen, setMktMobileOpen] = useState(false);
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [user, setUser] = useState(null);
  const [acctOpen, setAcctOpen] = useState(false);
  const navigate = useNavigate();
  const kbRef = useRef(null);
  const acctRef = useRef(null);
  const mktRef = useRef(null);

  useEffect(() => {
    const token = localStorage.getItem('access_token') || localStorage.getItem('AccessToken');
    const firstName = localStorage.getItem('first_name') || localStorage.getItem('PeopleFirstName');
    const peopleId = localStorage.getItem('people_id') || localStorage.getItem('PeopleID');

    if (token && firstName) {
      setIsLoggedIn(true);
      setUser({ firstName, peopleId });
    }
  }, []);

  // Close dropdowns when clicking outside
  useEffect(() => {
    const handleClickOutside = (e) => {
      if (kbRef.current && !kbRef.current.contains(e.target)) setKbOpen(false);
      if (acctRef.current && !acctRef.current.contains(e.target)) setAcctOpen(false);
      if (mktRef.current && !mktRef.current.contains(e.target)) setMktOpen(false);
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

 const handleLogout = () => {
  ['access_token', 'people_id', 'first_name', 'last_name', 'access_level',
   'AccessToken', 'PeopleID', 'PeopleFirstName', 'PeopleLastName', 'AccessLevel']
    .forEach(k => localStorage.removeItem(k));
  Object.keys(localStorage)
  .filter(k => k.startsWith('saige_'))
  .forEach(k => localStorage.removeItem(k));
  setIsLoggedIn(false);
  setUser(null);
  navigate('/login');
};

  const KbDropdown = () => (
    <div className="absolute top-full left-0 mt-2 w-48 bg-white rounded shadow-lg z-50 overflow-hidden">
      <Link to="/plant-knowledgebase" onClick={() => setKbOpen(false)} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Plants</Link>
      <Link to="/livestock" onClick={() => setKbOpen(false)} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Livestock Breeds</Link>
      <Link to="/ingredient-knowledgebase" onClick={() => setKbOpen(false)} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Ingredients</Link>
    </div>
  );

  const MktDropdown = () => (
    <div className="absolute top-full left-0 mt-2 w-56 bg-white rounded shadow-lg z-50 overflow-hidden">
      <Link to="/marketplaces/farm-to-table" onClick={() => setMktOpen(false)} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
       Farm 2 Table Marketplace
      </Link>
      <Link to="/marketplaces/livestock" onClick={() => setMktOpen(false)} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
        Livestock Marketplace
      </Link>
    </div>
  );

  const KbMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li><Link to="/plant-knowledgebase" onClick={() => setIsOpen(false)} className="!text-white/80 block">Plants</Link></li>
      <li><Link to="/livestock" onClick={() => setIsOpen(false)} className="!text-white/80 block">Livestock Breeds</Link></li>
      <li><Link to="/ingredient-knowledgebase" onClick={() => setIsOpen(false)} className="!text-white/80 block">Ingredients</Link></li>
    </ul>
  );

  const MktMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li>
        <Link to="/marketplaces/farm-to-table" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          🍽️ Farm 2 Table Marketplace
          <span className="text-yellow-400 text-xs ml-1">(Coming Soon)</span>
        </Link>
      </li>
      <li>
        <Link to="/marketplaces/livestock" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          🐄 Livestock Marketplace
          <span className="text-yellow-400 text-xs ml-1">(Coming Soon)</span>
        </Link>
      </li>
    </ul>
  );

  const ChevronIcon = ({ open }) => (
    <svg className={`w-3 h-3 transition-transform ${open ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
    </svg>
  );

  return (
    <nav className="bg-[#A3301E] py-3 px-4 shadow-2xl sticky top-0 z-50 font-montserrat">
      <div className="max-w-7xl mx-auto flex justify-between items-center">

        {/* Logo */}
        <Link to={isLoggedIn ? "/dashboard" : "/"} className="flex items-center shrink-0">
          <img
            src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp"
            className="h-10 md:h-12"
            alt="Oatmeal Farm Network"
            width="160"
            height="40"
            fetchPriority="high"
          />
        </Link>

        {/* Desktop Navigation */}
        <div className="hidden lg:flex flex-grow justify-center">
          <ul className="flex space-x-10 text-sm font-normal items-center">

            {isLoggedIn ? (
              <>
                <li><Link to="/dashboard" className="nav-link">Dashboard</Link></li>
                <li><Link to="/saige" className="nav-link">Saige</Link></li>
                <li><Link to="/directory" className="nav-link">Directory</Link></li>
              </>
            ) : (
              <>
                <li><Link to="/" className="nav-link">Home</Link></li>
                <li><Link to="/directory" className="nav-link">Directory</Link></li>
              </>
            )}

            {/* Knowledgebases dropdown */}
            <li className="relative" ref={kbRef}>
              <button onClick={() => setKbOpen(!kbOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                Knowledgebases <ChevronIcon open={kbOpen} />
              </button>
              {kbOpen && <KbDropdown />}
            </li>

            {/* Marketplaces dropdown */}
            <li className="relative" ref={mktRef}>
              <button onClick={() => setMktOpen(!mktOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                Marketplaces <ChevronIcon open={mktOpen} />
              </button>
              {mktOpen && <MktDropdown />}
            </li>

            {isLoggedIn ? (
              <>
                {/* Accounts dropdown */}
                <li className="relative" ref={acctRef}>
                  <button onClick={() => setAcctOpen(!acctOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                    Accounts <ChevronIcon open={acctOpen} />
                  </button>
                  {acctOpen && (
                    <div className="absolute top-full left-0 mt-2 w-52 bg-white rounded shadow-lg z-50 overflow-hidden">
                      <Link to={`/accounts?PeopleID=${user?.peopleId}`} onClick={() => setAcctOpen(false)} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Accounts</Link>
                      <Link to={`/accounts/new?PeopleID=${user?.peopleId}`} onClick={() => setAcctOpen(false)} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Add Account</Link>
                      {businesses.length > 0 && (
                        <>
                          <hr className="my-1 border-gray-200" />
                          {businesses.map(b => (
                            <Link
                              key={b.BusinessID}
                              to={`/account?PeopleID=${user?.peopleId}&BusinessID=${b.BusinessID}`}
                              onClick={() => setAcctOpen(false)}
                              className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                            >
                              {b.BusinessName.substring(0, 25)}
                            </Link>
                          ))}
                        </>
                      )}
                    </div>
                  )}
                </li>
                <li><Link to="/contact-us" className="nav-link">Contact Us</Link></li>
                <li><button onClick={handleLogout} className="nav-link">Log Out</button></li>
              </>
            ) : (
              <>
                <li><Link to="/saige" className="nav-link">Saige</Link></li>
                <li><Link to="/about" className="nav-link">About</Link></li>
                <li><Link to="/contact-us" className="nav-link">Contact</Link></li>
                <li><Link to="/login" className="nav-link">Login</Link></li>
                <li><Link to="/signup" className="nav-link">Join</Link></li>
              </>
            )}
          </ul>
        </div>

        {/* Hamburger */}
        <div className="lg:w-[180px] flex justify-end">
          <button onClick={() => setIsOpen(!isOpen)} className="lg:hidden text-white text-3xl focus:outline-none" type="button">
            {isOpen ? '✕' : '☰'}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {isOpen && (
        <div className="lg:hidden bg-[#A3301E] absolute top-full left-0 w-full border-t border-white/10 shadow-xl z-50">
          <ul className="flex flex-col p-6 space-y-4 text-base font-normal text-center">

            {isLoggedIn ? (
              <>
                <li><Link to="/dashboard" onClick={() => setIsOpen(false)} className="nav-link block">Dashboard</Link></li>
                <li><Link to="/saige" onClick={() => setIsOpen(false)} className="nav-link block">Saige</Link></li>
                <li><Link to="/directory" onClick={() => setIsOpen(false)} className="nav-link block">Directory</Link></li>
              </>
            ) : (
              <>
                <li><Link to="/" onClick={() => setIsOpen(false)} className="!text-white block">Home</Link></li>
                <li><Link to="/directory" onClick={() => setIsOpen(false)} className="!text-white block">Directory</Link></li>
              </>
            )}

            {/* Knowledgebases mobile */}
            <li>
              <button onClick={() => setKbMobileOpen(!kbMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                Knowledgebases <ChevronIcon open={kbMobileOpen} />
              </button>
              {kbMobileOpen && <KbMobileLinks />}
            </li>

            {/* Marketplaces mobile */}
            <li>
              <button onClick={() => setMktMobileOpen(!mktMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                Marketplaces <ChevronIcon open={mktMobileOpen} />
              </button>
              {mktMobileOpen && <MktMobileLinks />}
            </li>

            {isLoggedIn ? (
              <>
                <li>
                  <p className="text-[#EFAE15] font-semibold text-sm mb-1">Accounts</p>
                  <ul className="space-y-2">
                    <li><Link to={`/accounts?PeopleID=${user?.peopleId}`} onClick={() => setIsOpen(false)} className="nav-link block">Accounts</Link></li>
                    <li><Link to={`/accounts/new?PeopleID=${user?.peopleId}`} onClick={() => setIsOpen(false)} className="nav-link block">Add Account</Link></li>
                    {businesses.length > 0 && (
                      <>
                        <hr className="border-white/20 my-1" />
                        {businesses.map(b => (
                          <li key={b.BusinessID}>
                            <Link to={`/account?PeopleID=${user?.peopleId}&BusinessID=${b.BusinessID}`} onClick={() => setIsOpen(false)} className="nav-link block">
                              {b.BusinessName}
                            </Link>
                          </li>
                        ))}
                      </>
                    )}
                  </ul>
                </li>
                <li><Link to="/contact-us" onClick={() => setIsOpen(false)} className="nav-link block">Contact Us</Link></li>
                <li><button onClick={handleLogout} className="nav-link">Log Out</button></li>
              </>
            ) : (
              <>
                <li><Link to="/saige" onClick={() => setIsOpen(false)} className="!text-white block">Saige</Link></li>
                <li><Link to="/about" onClick={() => setIsOpen(false)} className="!text-white block">About Us</Link></li>
                <li><Link to="/contact-us" onClick={() => setIsOpen(false)} className="!text-white block">Contact Us</Link></li>
                <li><Link to="/login" onClick={() => setIsOpen(false)} className="!text-white block">Login</Link></li>
                <li><Link to="/signup" onClick={() => setIsOpen(false)} className="!text-white block">Sign Up</Link></li>
              </>
            )}
          </ul>
        </div>
      )}
    </nav>
  );
};

export default Header;