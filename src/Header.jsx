import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAccount } from './AccountContext';
import NotificationBell from './NotificationBell';
import CartBell from './CartBell';
import LanguageSelector from './LanguageSelector';

const Header = () => {
  const { t } = useTranslation();
  const { businesses, clearBusiness } = useAccount();
  const [isOpen, setIsOpen] = useState(false);
  const [kbOpen, setKbOpen] = useState(false);
  const [kbMobileOpen, setKbMobileOpen] = useState(false);
  const [mktOpen, setMktOpen] = useState(false);
  const [mktMobileOpen, setMktMobileOpen] = useState(false);
  const [nrOpen, setNrOpen] = useState(false);
  const [nrMobileOpen, setNrMobileOpen] = useState(false);
  const [svcOpen, setSvcOpen] = useState(false);
  const [svcMobileOpen, setSvcMobileOpen] = useState(false);
  const [aiOpen, setAiOpen] = useState(false);
  const [aiMobileOpen, setAiMobileOpen] = useState(false);
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [user, setUser] = useState(null);
  const [psOpen, setPsOpen] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();
  const kbRef = useRef(null);
  const mktRef = useRef(null);
  const nrRef = useRef(null);
  const svcRef = useRef(null);
  const aiRef = useRef(null);
  const psRef = useRef(null);

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
      if (mktRef.current && !mktRef.current.contains(e.target)) setMktOpen(false);
      if (nrRef.current && !nrRef.current.contains(e.target)) setNrOpen(false);
      if (svcRef.current && !svcRef.current.contains(e.target)) setSvcOpen(false);
      if (aiRef.current && !aiRef.current.contains(e.target)) setAiOpen(false);
      if (psRef.current && !psRef.current.contains(e.target)) setPsOpen(false);
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleLogout = () => {
  ['access_token', 'people_id', 'first_name', 'last_name', 'access_level',
   'AccessToken', 'PeopleID', 'PeopleFirstName', 'PeopleLastName', 'AccessLevel',
   'selected_business_id']
    .forEach(k => localStorage.removeItem(k));
  Object.keys(localStorage)
  .filter(k => k.startsWith('saige_'))
  .forEach(k => localStorage.removeItem(k));
  clearBusiness();
  setIsLoggedIn(false);
  setUser(null);
  navigate('/login');
};

  const KbDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-48 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <Link to="/plant-knowledgebase" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.plants')}</Link>
        <Link to="/livestock" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.livestock_breeds')}</Link>
        <Link to="/ingredient-knowledgebase" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.ingredients')}</Link>
      </div>
    </div>
  );

  const NrDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-44 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <Link to="/app/news" onClick={() => setNrOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.newsfeed')}</Link>
        <Link to="/blog" onClick={() => setNrOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.blogs')}</Link>
      </div>
    </div>
  );

  const OUR_SERVICES_COL1 = [
    { key: 'accounting',             label: 'Accounting',                     to: '/platform/accounting'            },
    { key: 'blog',                   label: 'Blog',                           to: '/platform/blog'                  },
    { key: 'certifications-tracker', label: 'Certifications Tracker',         to: '/platform/certifications-tracker'},
    { key: 'csa',                    label: 'CSA Management',                 to: '/platform/csa'                   },
    { key: 'directory',              label: 'Directories',                    to: '/platform/directory'             },
    { key: 'events',                 label: 'Events Registration',            to: '/platform/events'                },
    { key: 'aggregator',             label: 'Food Aggregator',                to: '/platform/aggregator'            },
    { key: 'community',              label: 'Forums & Community',             to: '/platform/community'             },
  ];
  const OUR_SERVICES_COL2 = [
    { key: 'grants',                 label: 'Grants & Programs',              to: '/platform/grants'                },
    { key: 'jobs',                   label: 'Job Board',                      to: '/platform/jobs'                  },
    { key: 'livestock-herd-health',  label: 'Livestock & Herd Health',        to: '/platform/livestock-herd-health' },
    { key: 'marketplaces',           label: 'Marketplaces',                   to: '/platform/marketplaces'          },
    { key: 'precision-ag',           label: 'Precision Ag',                   to: '/platform/precision-ag'          },
    { key: 'land-leasing',           label: 'Real Estate & Land Leasing',     to: '/platform/land-leasing'          },
    { key: 'website-builder',        label: 'Website Builder',                to: '/platform/website-builder'       },
  ];

  const SvcDropdown = () => (
    <div className="absolute top-full left-0 pt-2 z-10000" style={{ width: '480px' }}>
      <div className="bg-white rounded shadow-lg overflow-hidden py-1">
        <div className="grid grid-cols-2">
          <div className="border-r border-gray-100">
            {OUR_SERVICES_COL1.map(s => (
              <Link key={s.key} to={s.to}
                onClick={() => setSvcOpen(false)}
                className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
                {s.label}
              </Link>
            ))}
          </div>
          <div>
            {OUR_SERVICES_COL2.map(s => (
              <Link key={s.key} to={s.to}
                onClick={() => setSvcOpen(false)}
                className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
                {s.label}
              </Link>
            ))}
          </div>
        </div>
      </div>
    </div>
  );

  const SvcMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      {[...OUR_SERVICES_COL1, ...OUR_SERVICES_COL2].map(s => (
        <li key={s.key}>
          <Link to={s.to} onClick={() => setIsOpen(false)} className="!text-white/80 block">
            {s.label}
          </Link>
        </li>
      ))}
    </ul>
  );

  const MktDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-56 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <Link to="/marketplaces/farm-to-table" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          {t('nav.farm2table')}
        </Link>
        <Link to="/marketplace/products" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          {t('nav.products_marketplace')}
        </Link>
        <Link to="/marketplaces/livestock" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          {t('nav.livestock_marketplace')}
        </Link>
        <Link to="/marketplaces/equipment" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          Equipment Marketplace
        </Link>
        <Link to="/marketplaces/real-estate" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          Real Estate For Sale
        </Link>
        <hr className="my-1 border-gray-100" />
        <Link to="/services/directory" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          {t('nav.services_directory')}
        </Link>
        <hr className="my-1 border-gray-100" />
        <Link to="/events" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">
          {t('nav.events')}
        </Link>
      </div>
    </div>
  );

  const KbMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li><Link to="/plant-knowledgebase" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.plants')}</Link></li>
      <li><Link to="/livestock" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.livestock_breeds')}</Link></li>
      <li><Link to="/ingredient-knowledgebase" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.ingredients')}</Link></li>
    </ul>
  );

  const MktMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li>
        <Link to="/marketplaces/farm-to-table" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          {t('nav.farm2table')}
        </Link>
      </li>
      <li>
        <Link to="/marketplace/products" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          {t('nav.products_marketplace')}
        </Link>
      </li>
      <li>
        <Link to="/marketplaces/livestock" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          {t('nav.livestock_marketplace')}
        </Link>
      </li>
      <li>
        <Link to="/marketplaces/equipment" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          Equipment Marketplace
        </Link>
      </li>
      <li>
        <Link to="/marketplaces/real-estate" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          Real Estate For Sale
        </Link>
      </li>
      <li>
        <Link to="/services/directory" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          {t('nav.services_directory')}
        </Link>
      </li>
      <li>
        <Link to="/events" onClick={() => setIsOpen(false)} className="!text-white/80 block">
          {t('nav.events')}
        </Link>
      </li>
    </ul>
  );

  const AiDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-44 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <Link to="/platform/saige"     onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Saige</Link>
        <Link to="/platform/pairsley"  onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Pairsley</Link>
        <Link to="/platform/rosemarie" onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Rosemarie</Link>
        <Link to="/platform/thaiyme"   onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Thaiyme</Link>
      </div>
    </div>
  );

  const AiMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li><Link to="/platform/saige"     onClick={() => setIsOpen(false)} className="!text-white/80 block">Saige</Link></li>
      <li><Link to="/platform/pairsley"  onClick={() => setIsOpen(false)} className="!text-white/80 block">Pairsley</Link></li>
      <li><Link to="/platform/rosemarie" onClick={() => setIsOpen(false)} className="!text-white/80 block">Rosemarie</Link></li>
      <li><Link to="/platform/thaiyme"   onClick={() => setIsOpen(false)} className="!text-white/80 block">Thaiyme</Link></li>
    </ul>
  );

  const LoginIcon = () => (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/>
      <polyline points="10 17 15 12 10 7"/>
      <line x1="15" y1="12" x2="3" y2="12"/>
    </svg>
  );

  const LogoutIcon = () => (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
      <polyline points="16 17 21 12 16 7"/>
      <line x1="21" y1="12" x2="9" y2="12"/>
    </svg>
  );

  const ChevronIcon = ({ open }) => (
    <svg className={`w-3 h-3 transition-transform ${open ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
    </svg>
  );

  return (
    <nav className="bg-[#A3301E] py-3 shadow-2xl sticky top-0 z-10000 font-montserrat">
      <div className="max-w-[1300px] mx-auto px-4 flex justify-between items-center">

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
                <li><Link to="/dashboard" className="nav-link">{t('nav.dashboard')}</Link></li>
                <li><Link to="/directory" className="nav-link">{t('nav.directory')}</Link></li>
              </>
            ) : (
              <>
                <li><Link to="/" className="nav-link">{t('nav.home')}</Link></li>
                <li><Link to="/directory" className="nav-link">{t('nav.directory')}</Link></li>
              </>
            )}

            {/* Marketplaces dropdown */}
            <li className="relative" ref={mktRef} onMouseEnter={() => setMktOpen(true)} onMouseLeave={() => setMktOpen(false)}>
              <button onClick={() => setMktOpen(!mktOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.marketplaces')} <ChevronIcon open={mktOpen} />
              </button>
              {mktOpen && <MktDropdown />}
            </li>

            {/* Newsroom dropdown */}
            <li className="relative" ref={nrRef} onMouseEnter={() => setNrOpen(true)} onMouseLeave={() => setNrOpen(false)}>
              <button onClick={() => setNrOpen(!nrOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.newsroom')} <ChevronIcon open={nrOpen} />
              </button>
              {nrOpen && <NrDropdown />}
            </li>

            {/* Knowledgebases dropdown */}
            <li className="relative" ref={kbRef} onMouseEnter={() => setKbOpen(true)} onMouseLeave={() => setKbOpen(false)}>
              <button onClick={() => setKbOpen(!kbOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.knowledgebases')} <ChevronIcon open={kbOpen} />
              </button>
              {kbOpen && <KbDropdown />}
            </li>

            {/* Our Services dropdown */}
            <li className="relative" ref={svcRef} onMouseEnter={() => setSvcOpen(true)} onMouseLeave={() => setSvcOpen(false)}>
              <button onClick={() => setSvcOpen(!svcOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.our_services', 'Our Services')} <ChevronIcon open={svcOpen} />
              </button>
              {svcOpen && <SvcDropdown />}
            </li>

            {/* AI Advisors dropdown */}
            <li className="relative" ref={aiRef} onMouseEnter={() => setAiOpen(true)} onMouseLeave={() => setAiOpen(false)}>
              <button onClick={() => setAiOpen(!aiOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.ai_advisors', 'AI Advisors')} <ChevronIcon open={aiOpen} />
              </button>
              {aiOpen && <AiDropdown />}
            </li>

            {isLoggedIn ? (
              <li><Link to="/contact-us" className="nav-link">{t('nav.contact')}</Link></li>
            ) : (
              <>
                <li><Link to="/about" className="nav-link">{t('nav.about')}</Link></li>
                <li><Link to="/contact-us" className="nav-link">{t('nav.contact')}</Link></li>
                <li><Link to="/signup" className="nav-link">{t('nav.signup')}</Link></li>
              </>
            )}
          </ul>
        </div>

        {/* Right: icons on desktop, hamburger on mobile */}
        <div className="flex items-center gap-3 shrink-0">
          {isLoggedIn ? (
            <div className="hidden lg:flex items-center gap-3">
              <CartBell />
              <NotificationBell />
              <LanguageSelector />
              <div className="relative" ref={psRef}>
                <button
                  onClick={() => setPsOpen(o => !o)}
                  onMouseEnter={() => setPsOpen(true)}
                  title="Personal Settings"
                  className="text-white/80 hover:text-white transition-colors flex items-center"
                >
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
                    <circle cx="12" cy="12" r="3"/>
                    <path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/>
                  </svg>
                </button>
                {psOpen && (
                  <div className="absolute right-0 top-full pt-2 w-52 z-10000" onMouseLeave={() => setPsOpen(false)}>
                    <div className="bg-white rounded shadow-lg overflow-hidden">
                      <Link to="/account/settings" onClick={() => setPsOpen(false)} className="block px-3 py-2 text-xs text-gray-700 hover:bg-gray-100">Login &amp; Account</Link>
                      <Link to="/account/settings?tab=audio" onClick={() => setPsOpen(false)} className="block px-3 py-2 text-xs text-gray-700 hover:bg-gray-100">Language &amp; Audio Settings</Link>
                    </div>
                  </div>
                )}
              </div>
              <button onClick={handleLogout} title={t('nav.log_out')} className="text-white/80 hover:text-white transition-colors flex items-center">
                <LogoutIcon />
              </button>
            </div>
          ) : (
            <div className="hidden lg:flex items-center gap-3">
              <LanguageSelector />
              <Link to="/login" title={t('nav.login')} className="flex items-center transition-colors" style={{ color: 'rgba(255,255,255,0.8)' }}>
                <LoginIcon />
              </Link>
            </div>
          )}
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
                <li><Link to="/dashboard" onClick={() => setIsOpen(false)} className="nav-link block">{t('nav.dashboard')}</Link></li>
                <li><Link to="/directory" onClick={() => setIsOpen(false)} className="nav-link block">{t('nav.directory')}</Link></li>
              </>
            ) : (
              <>
                <li><Link to="/" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.home')}</Link></li>
                <li><Link to="/directory" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.directory')}</Link></li>
              </>
            )}

            {/* Marketplaces mobile */}
            <li>
              <button onClick={() => setMktMobileOpen(!mktMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.marketplaces')} <ChevronIcon open={mktMobileOpen} />
              </button>
              {mktMobileOpen && <MktMobileLinks />}
            </li>

            {/* Newsroom mobile */}
            <li>
              <button onClick={() => setNrMobileOpen(!nrMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.newsroom')} <ChevronIcon open={nrMobileOpen} />
              </button>
              {nrMobileOpen && (
                <ul className="mt-2 space-y-2 text-sm">
                  <li><Link to="/app/news" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.newsfeed')}</Link></li>
                  <li><Link to="/blog" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.blogs')}</Link></li>
                </ul>
              )}
            </li>

            {/* Knowledgebases mobile */}
            <li>
              <button onClick={() => setKbMobileOpen(!kbMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.knowledgebases')} <ChevronIcon open={kbMobileOpen} />
              </button>
              {kbMobileOpen && <KbMobileLinks />}
            </li>

            {/* Our Services mobile */}
            <li>
              <button onClick={() => setSvcMobileOpen(!svcMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.our_services', 'Our Services')} <ChevronIcon open={svcMobileOpen} />
              </button>
              {svcMobileOpen && <SvcMobileLinks />}
            </li>

            {/* AI Advisors mobile */}
            <li>
              <button onClick={() => setAiMobileOpen(!aiMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.ai_advisors', 'AI Advisors')} <ChevronIcon open={aiMobileOpen} />
              </button>
              {aiMobileOpen && <AiMobileLinks />}
            </li>

            {isLoggedIn ? (
              <>
                <li><Link to="/contact-us" onClick={() => setIsOpen(false)} className="nav-link block">{t('nav.contact')}</Link></li>
                <li className="flex items-center justify-center gap-5 pt-1">
                  <CartBell />
                  <NotificationBell />
                  <LanguageSelector />
                  <button onClick={handleLogout} title={t('nav.log_out')} className="text-white/80 hover:text-white transition-colors flex items-center">
                    <LogoutIcon />
                  </button>
                </li>
              </>
            ) : (
              <>
                <li><Link to="/about" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.about')}</Link></li>
                <li><Link to="/contact-us" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.contact')}</Link></li>
                <li><Link to="/signup" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.signup')}</Link></li>
                <li className="flex items-center justify-center gap-5 pt-1">
                  <LanguageSelector />
                  <Link to="/login" onClick={() => setIsOpen(false)} title={t('nav.login')} className="flex items-center transition-colors" style={{ color: 'rgba(255,255,255,0.8)' }}>
                    <LoginIcon />
                  </Link>
                </li>
              </>
            )}
          </ul>
        </div>
      )}
    </nav>
  );
};

export default Header;