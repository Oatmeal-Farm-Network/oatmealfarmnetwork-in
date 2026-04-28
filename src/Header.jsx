import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAccount } from './AccountContext';
import NotificationBell from './NotificationBell';
import CartBell from './CartBell';
import LanguageSelector from './LanguageSelector';

const Header = () => {
  const { businesses } = useAccount();
  const [isOpen, setIsOpen] = useState(false);
  const [kbOpen, setKbOpen] = useState(false);
  const [kbMobileOpen, setKbMobileOpen] = useState(false);
  const [mktOpen, setMktOpen] = useState(false);
  const [mktMobileOpen, setMktMobileOpen] = useState(false);
  const [nrOpen, setNrOpen] = useState(false);
  const [nrMobileOpen, setNrMobileOpen] = useState(false);
  const [svcOpen, setSvcOpen] = useState(false);
  const [svcMobileOpen, setSvcMobileOpen] = useState(false);
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [user, setUser] = useState(null);
  const [acctOpen, setAcctOpen] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();
  const kbRef = useRef(null);
  const acctRef = useRef(null);
  const mktRef = useRef(null);
  const nrRef = useRef(null);
  const svcRef = useRef(null);

  useEffect(() => {
    const refreshAuth = () => {
      const token = localStorage.getItem('access_token') || localStorage.getItem('AccessToken');
      const peopleId = localStorage.getItem('people_id') || localStorage.getItem('PeopleID');
      const firstName =
        localStorage.getItem('first_name') ||
        localStorage.getItem('PeopleFirstName') ||
        '';

      // Token is the source of truth for authentication. Name is display-only.
      if (token && peopleId) {
        setIsLoggedIn(true);
        setUser({ firstName, peopleId });
      } else {
        setIsLoggedIn(false);
        setUser(null);
      }
      console.debug('[Header] auth check', { hasToken: !!token, hasPeopleId: !!peopleId, hasFirstName: !!firstName });
    };
    refreshAuth();
    window.addEventListener('storage', refreshAuth);
    return () => window.removeEventListener('storage', refreshAuth);
  }, [location.pathname]);

  // Close dropdowns when clicking outside
  useEffect(() => {
    const handleClickOutside = (e) => {
      if (kbRef.current && !kbRef.current.contains(e.target)) setKbOpen(false);
      if (acctRef.current && !acctRef.current.contains(e.target)) setAcctOpen(false);
      if (mktRef.current && !mktRef.current.contains(e.target)) setMktOpen(false);
      if (nrRef.current && !nrRef.current.contains(e.target)) setNrOpen(false);
      if (svcRef.current && !svcRef.current.contains(e.target)) setSvcOpen(false);
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
    <div className="absolute top-full left-0 mt-2 w-48 bg-white rounded shadow-lg z-10000 overflow-hidden">
      <Link to="/plant-knowledgebase" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Plants</Link>
      <Link to="/livestock" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Livestock Breeds</Link>
      <Link to="/ingredient-knowledgebase" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Ingredients</Link>
    </div>
  );

  const NrDropdown = () => (
    <div className="absolute top-full left-0 mt-2 w-44 bg-white rounded shadow-lg z-10000 overflow-hidden">
      <Link to="/app/news" onClick={() => setNrOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Newsfeed</Link>
      <Link to="/blog" onClick={() => setNrOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Blogs</Link>
    </div>
  );

  const FALLBACK_AGENTS = [
    { ServiceID: 'f1', Slug: 'saige',     Title: 'Saige',     IconEmoji: '🌾', RoutePath: '/platform/saige',     IsAgent: true },
    { ServiceID: 'f2', Slug: 'rosemarie', Title: 'Rosemarie', IconEmoji: '🌿', RoutePath: '/platform/rosemarie', IsAgent: true },
    { ServiceID: 'f3', Slug: 'pairsley',  Title: 'Pairsley',  IconEmoji: '🍳', RoutePath: '/platform/pairsley',  IsAgent: true },
  ];
  const FALLBACK_PLATFORM = [
    { ServiceID: 'p1', Slug: 'website-builder', Title: 'Website Builder', IconEmoji: '🖥️', RoutePath: '/platform/website-builder', IsAgent: false },
    { ServiceID: 'p2', Slug: 'marketplace',     Title: 'Marketplace',     IconEmoji: '🛒', RoutePath: '/platform/marketplace',     IsAgent: false },
    { ServiceID: 'p3', Slug: 'events',          Title: 'Events',          IconEmoji: '🎪', RoutePath: '/platform/events',          IsAgent: false },
    { ServiceID: 'p4', Slug: 'crop-monitor',    Title: 'Crop Monitor',    IconEmoji: '🛰️', RoutePath: '/platform/crop-monitor',    IsAgent: false },
    { ServiceID: 'p5', Slug: 'directory',       Title: 'Directory',       IconEmoji: '📖', RoutePath: '/platform/directory',       IsAgent: false },
  ];

  const SvcDropdown = () => (
    <div className="absolute top-full left-0 mt-2 w-64 bg-white rounded shadow-lg z-10000 overflow-hidden py-1">
      <p className="px-3 pt-2 pb-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">AI Agents</p>
      {FALLBACK_AGENTS.map(s => (
        <Link key={s.ServiceID} to={s.RoutePath}
          onClick={() => setSvcOpen(false)}
          className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          {s.IconEmoji} {s.Title}
        </Link>
      ))}
      <hr className="my-1 border-gray-100" />
      <p className="px-3 pt-2 pb-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">Platform Services</p>
      {FALLBACK_PLATFORM.map(s => (
        <Link key={s.ServiceID} to={s.RoutePath}
          onClick={() => setSvcOpen(false)}
          className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          {s.IconEmoji} {s.Title}
        </Link>
      ))}
    </div>
  );

  const SvcMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      {FALLBACK_AGENTS.map(s => (
        <li key={s.ServiceID}>
          <Link to={s.RoutePath} onClick={() => setIsOpen(false)} className="!text-white/80 block">
            {s.IconEmoji} {s.Title}
          </Link>
        </li>
      ))}
      {FALLBACK_PLATFORM.map(s => (
        <li key={s.ServiceID}>
          <Link to={s.RoutePath} onClick={() => setIsOpen(false)} className="!text-white/80 block">
            {s.IconEmoji} {s.Title}
          </Link>
        </li>
      ))}
    </ul>
  );

  const MktDropdown = () => (
    <div className="absolute top-full left-0 mt-2 w-56 bg-white rounded shadow-lg z-10000 overflow-hidden">
      <Link to="/marketplaces/farm-to-table" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
        Farm 2 Table
      </Link>
      <Link to="/marketplace/products" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
        Products Marketplace
      </Link>
      <Link to="/marketplaces/livestock" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
        Livestock Marketplace
      </Link>
      <hr className="my-1 border-gray-100" />
      <Link to="/services/directory" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
        Services Directory
      </Link>
      <hr className="my-1 border-gray-100" />
      <Link to="/events" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
        Events
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
          Farm 2 Table
        </Link>
      </li>
      <li>
        <Link to="/marketplace/products" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          Products Marketplace
        </Link>
      </li>
      <li>
        <Link to="/marketplaces/livestock" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          Livestock Marketplace
        </Link>
      </li>
      <li>
        <Link to="/services/directory" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          Services Directory
        </Link>
      </li>
      <li>
        <Link to="/events" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          Events
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
    <nav className="bg-[#A3301E] py-3 px-4 shadow-2xl sticky top-0 z-10000 font-montserrat">
      <div className="max-w-350 mx-auto flex justify-between items-center">

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
          <ul className="flex space-x-7 text-xs font-normal items-center">

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

            {/* Newsroom dropdown */}
            <li className="relative" ref={nrRef}>
              <button onClick={() => setNrOpen(!nrOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                Newsroom <ChevronIcon open={nrOpen} />
              </button>
              {nrOpen && <NrDropdown />}
            </li>

            {/* Services dropdown */}
            <li className="relative" ref={svcRef}>
              <button onClick={() => setSvcOpen(!svcOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                Services <ChevronIcon open={svcOpen} />
              </button>
              {svcOpen && <SvcDropdown />}
            </li>

            {isLoggedIn ? (
              <>
                {/* Accounts dropdown */}
                <li className="relative" ref={acctRef}>
                  <button onClick={() => setAcctOpen(!acctOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                    Accounts <ChevronIcon open={acctOpen} />
                  </button>
                  {acctOpen && (
                    <div className="absolute top-full left-0 mt-2 w-52 bg-white rounded shadow-lg z-10000 overflow-hidden">
                      <Link to="/dashboard" onClick={() => setAcctOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Accounts</Link>
                      <Link to={`/accounts/new?PeopleID=${user?.peopleId}`} onClick={() => setAcctOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Add Account</Link>
                      <Link to="/account/settings" onClick={() => setAcctOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Settings</Link>
                      {businesses.length > 0 && (
                        <>
                          <hr className="my-1 border-gray-200" />
                          {businesses.map(b => (
                            <Link
                              key={b.BusinessID}
                              to={`/account?PeopleID=${user?.peopleId}&BusinessID=${b.BusinessID}`}
                              onClick={() => setAcctOpen(false)}
                              className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100"
                            >
                              {b.BusinessName.substring(0, 25)}
                            </Link>
                          ))}
                        </>
                      )}
                    </div>
                  )}
                </li>
                <li><Link to="/contact-us" className="nav-link">Contact</Link></li>
                <li className="flex items-center"><CartBell /></li>
                <li className="flex items-center"><NotificationBell /></li>
                <li className="flex items-center"><LanguageSelector /></li>
                <li><button onClick={handleLogout} className="nav-link">Log Out</button></li>
              </>
            ) : (
              <>
                <li><Link to="/saige" className="nav-link">Saige</Link></li>
                <li><Link to="/about" className="nav-link">About</Link></li>
                <li><Link to="/contact-us" className="nav-link">Contact</Link></li>
                <li className="flex items-center"><LanguageSelector /></li>
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

            {/* Newsroom mobile */}
            <li>
              <button onClick={() => setNrMobileOpen(!nrMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                Newsroom <ChevronIcon open={nrMobileOpen} />
              </button>
              {nrMobileOpen && (
                <ul className="mt-2 space-y-2 text-sm">
                  <li><Link to="/app/news" onClick={() => setIsOpen(false)} className="!text-white/80 block">Newsfeed</Link></li>
                  <li><Link to="/blog" onClick={() => setIsOpen(false)} className="!text-white/80 block">Blogs</Link></li>
                </ul>
              )}
            </li>

            {/* Services mobile */}
            <li>
              <button onClick={() => setSvcMobileOpen(!svcMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                Services <ChevronIcon open={svcMobileOpen} />
              </button>
              {svcMobileOpen && <SvcMobileLinks />}
            </li>

            {isLoggedIn ? (
              <>
                <li>
                  <p className="text-[#EFAE15] font-semibold text-sm mb-1">Accounts</p>
                  <ul className="space-y-2">
                    <li><Link to="/dashboard" onClick={() => setIsOpen(false)} className="nav-link block">Accounts</Link></li>
                    <li><Link to={`/accounts/new?PeopleID=${user?.peopleId}`} onClick={() => setIsOpen(false)} className="nav-link block">Add Account</Link></li>
                    <li><Link to="/account/settings" onClick={() => setIsOpen(false)} className="nav-link block">Settings</Link></li>
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
                <li><Link to="/contact-us" onClick={() => setIsOpen(false)} className="nav-link block">Contact</Link></li>
                <li><button onClick={handleLogout} className="nav-link">Log Out</button></li>
              </>
            ) : (
              <>
                <li><Link to="/saige" onClick={() => setIsOpen(false)} className="!text-white block">Saige</Link></li>
                <li><Link to="/about" onClick={() => setIsOpen(false)} className="!text-white block">About Us</Link></li>
                <li><Link to="/contact-us" onClick={() => setIsOpen(false)} className="!text-white block">Contact</Link></li>
                <li className="flex justify-center"><LanguageSelector /></li>
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