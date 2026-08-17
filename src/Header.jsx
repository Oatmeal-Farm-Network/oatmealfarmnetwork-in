import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAccount } from './AccountContext';
import NotificationBell from './NotificationBell';
import CartBell from './CartBell';
import LanguageSelector from './LanguageSelector';
import { isNavEnabled, indiaAppPath } from './ofnNavConfig';

// AI advisor destinations: logged-in users go straight to the actual advisor tool;
// logged-out visitors get the marketing "About" page (/platform/<slug>).
const AI_ADVISOR_ROUTE = {
  saige:     '/saige',
  pairsley:  '/chef',
  rosemarie: '/recipes',
  thaiyme:   '/accounting',
};
const advisorTo = (slug, isLoggedIn) =>
  (isLoggedIn && AI_ADVISOR_ROUTE[slug]) || `/platform/${slug}`;

const DISABLED_HINT = 'Not available on OFN India yet';

function NavAnchor({ navKey, to, className = '', onClick, children }) {
  if (!isNavEnabled(navKey)) {
    return (
      <span
        className={`${className} opacity-50 cursor-not-allowed select-none`}
        aria-disabled="true"
        title={DISABLED_HINT}
      >
        {children}
      </span>
    );
  }
  const resolved = indiaAppPath(to);
  if (resolved.startsWith('http')) {
    return (
      <a href={resolved} className={className} onClick={onClick}>
        {children}
      </a>
    );
  }
  return (
    <Link to={to} className={className} onClick={onClick}>
      {children}
    </Link>
  );
}

const Header = () => {
  const { t } = useTranslation();
  const { clearBusiness } = useAccount();
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
      if (token && peopleId) {
        setIsLoggedIn(true);
      } else {
        setIsLoggedIn(false);
      }
    };
    refreshAuth();
    window.addEventListener('storage', refreshAuth);
    return () => window.removeEventListener('storage', refreshAuth);
  }, [location.pathname]);

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
    navigate('/login');
  };

  const KbDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-48 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <NavAnchor navKey="kb_plants" to="/plant-knowledgebase" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.plants')}</NavAnchor>
        <NavAnchor navKey="kb_livestock" to="/livestock" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.livestock_breeds')}</NavAnchor>
        <NavAnchor navKey="kb_ingredients" to="/ingredient-knowledgebase" onClick={() => setKbOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.ingredients')}</NavAnchor>
      </div>
    </div>
  );

  const NrDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-44 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <NavAnchor navKey="nr_newsfeed" to="/app/news" onClick={() => setNrOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.newsfeed')}</NavAnchor>
        <NavAnchor navKey="nr_blogs" to="/blog" onClick={() => setNrOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.blogs')}</NavAnchor>
      </div>
    </div>
  );

  const FALLBACK_AGENTS = [
    { ServiceID: 'f1', Slug: 'saige', Title: 'Saige', RoutePath: '/platform/saige' },
    { ServiceID: 'f2', Slug: 'rosemarie', Title: 'Rosemarie', RoutePath: '/platform/rosemarie' },
    { ServiceID: 'f3', Slug: 'pairsley', Title: 'Pairsley', RoutePath: '/platform/pairsley' },
  ];
  const FALLBACK_PLATFORM = [
    { ServiceID: 'p1', Slug: 'website-builder', Title: 'Website Builder', RoutePath: '/platform/website-builder' },
    { ServiceID: 'p2', Slug: 'marketplace', Title: 'Marketplace', RoutePath: '/platform/marketplace' },
    { ServiceID: 'p3', Slug: 'events', Title: 'Events', RoutePath: '/platform/events' },
    { ServiceID: 'p4', Slug: 'crop-monitor', Title: 'Crop Monitor', RoutePath: '/platform/crop-monitor' },
    { ServiceID: 'p5', Slug: 'directory', Title: 'Directory', RoutePath: '/platform/directory' },
  ];

  const SVC_AGENT_KEYS = { f1: 'svc_saige', f2: 'svc_rosemarie', f3: 'svc_pairsley' };
  const SVC_PLATFORM_KEYS = { p1: 'svc_website', p2: 'svc_marketplace', p3: 'svc_events', p4: 'svc_crop_monitor', p5: 'svc_directory' };

  const SvcDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-56 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden py-1">
        <p className="px-3 pt-2 pb-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">{t('nav.ai_agents')}</p>
        {FALLBACK_AGENTS.map(s => (
          <NavAnchor
            key={s.ServiceID}
            navKey={SVC_AGENT_KEYS[s.ServiceID]}
            to={s.RoutePath}
            onClick={() => setSvcOpen(false)}
            className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100"
          >
            {s.Title}
          </NavAnchor>
        ))}
        <hr className="my-1 border-gray-100" />
        <p className="px-3 pt-2 pb-1 text-[10px] font-bold uppercase tracking-wider text-gray-400">{t('nav.platform_services')}</p>
        {FALLBACK_PLATFORM.map(s => (
          <NavAnchor
            key={s.ServiceID}
            navKey={SVC_PLATFORM_KEYS[s.ServiceID]}
            to={s.RoutePath}
            onClick={() => setSvcOpen(false)}
            className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100"
          >
            {s.Title}
          </NavAnchor>
        ))}
      </div>
    </div>
  );

  const SvcMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      {FALLBACK_AGENTS.map(s => (
        <li key={s.ServiceID}>
          <NavAnchor navKey={SVC_AGENT_KEYS[s.ServiceID]} to={s.RoutePath} onClick={() => setIsOpen(false)} className="!text-white/80 block">{s.Title}</NavAnchor>
        </li>
      ))}
      {FALLBACK_PLATFORM.map(s => (
        <li key={s.ServiceID}>
          <NavAnchor navKey={SVC_PLATFORM_KEYS[s.ServiceID]} to={s.RoutePath} onClick={() => setIsOpen(false)} className="!text-white/80 block">{s.Title}</NavAnchor>
        </li>
      ))}
    </ul>
  );

  const MktDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-56 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <NavAnchor navKey="mkt_farm2table" to="/marketplaces/farm-to-table" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.farm2table')}</NavAnchor>
        <NavAnchor navKey="mkt_products" to="/marketplace/products" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.products_marketplace')}</NavAnchor>
        <NavAnchor navKey="mkt_livestock" to="/marketplaces/livestock" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.livestock_marketplace')}</NavAnchor>
        <NavAnchor navKey="mkt_equipment" to="/marketplaces/equipment" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Equipment Marketplace</NavAnchor>
        <NavAnchor navKey="mkt_realestate" to="/marketplaces/real-estate" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Real Estate For Sale</NavAnchor>
        <hr className="my-1 border-gray-100" />
        <NavAnchor navKey="mkt_services_dir" to="/services/directory" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.services_directory')}</NavAnchor>
        <hr className="my-1 border-gray-100" />
        <NavAnchor navKey="mkt_events" to="/events" onClick={() => setMktOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">{t('nav.events')}</NavAnchor>
      </div>
    </div>
  );

  const KbMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li><NavAnchor navKey="kb_plants" to="/plant-knowledgebase" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.plants')}</NavAnchor></li>
      <li><NavAnchor navKey="kb_livestock" to="/livestock" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.livestock_breeds')}</NavAnchor></li>
      <li><NavAnchor navKey="kb_ingredients" to="/ingredient-knowledgebase" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.ingredients')}</NavAnchor></li>
    </ul>
  );

  const MktMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li><NavAnchor navKey="mkt_farm2table" to="/marketplaces/farm-to-table" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.farm2table')}</NavAnchor></li>
      <li><NavAnchor navKey="mkt_products" to="/marketplace/products" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.products_marketplace')}</NavAnchor></li>
      <li><NavAnchor navKey="mkt_livestock" to="/marketplaces/livestock" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.livestock_marketplace')}</NavAnchor></li>
      <li><NavAnchor navKey="mkt_equipment" to="/marketplaces/equipment" onClick={() => setIsOpen(false)} className="!text-white/80 block">Equipment Marketplace</NavAnchor></li>
      <li><NavAnchor navKey="mkt_realestate" to="/marketplaces/real-estate" onClick={() => setIsOpen(false)} className="!text-white/80 block">Real Estate For Sale</NavAnchor></li>
      <li><NavAnchor navKey="mkt_services_dir" to="/services/directory" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.services_directory')}</NavAnchor></li>
      <li><NavAnchor navKey="mkt_events" to="/events" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.events')}</NavAnchor></li>
    </ul>
  );

  const AiDropdown = () => (
    <div className="absolute top-full left-0 pt-2 w-44 z-10000">
      <div className="bg-white rounded shadow-lg overflow-hidden">
        <NavAnchor navKey="ai_saige" to={advisorTo('saige', isLoggedIn)} onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Saige</NavAnchor>
        <NavAnchor navKey="ai_pairsley" to={advisorTo('pairsley', isLoggedIn)} onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Pairsley</NavAnchor>
        <NavAnchor navKey="ai_rosemarie" to={advisorTo('rosemarie', isLoggedIn)} onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Rosemarie</NavAnchor>
        <NavAnchor navKey="ai_thaiyme" to={advisorTo('thaiyme', isLoggedIn)} onClick={() => setAiOpen(false)} className="block px-3 py-1.5 text-xs text-gray-700 hover:bg-gray-100">Thaiyme</NavAnchor>
      </div>
    </div>
  );

  const AiMobileLinks = () => (
    <ul className="mt-2 space-y-2 text-sm">
      <li><NavAnchor navKey="ai_saige" to={advisorTo('saige', isLoggedIn)} onClick={() => setIsOpen(false)} className="!text-white/80 block">Saige</NavAnchor></li>
      <li><NavAnchor navKey="ai_pairsley" to={advisorTo('pairsley', isLoggedIn)} onClick={() => setIsOpen(false)} className="!text-white/80 block">Pairsley</NavAnchor></li>
      <li><NavAnchor navKey="ai_rosemarie" to={advisorTo('rosemarie', isLoggedIn)} onClick={() => setIsOpen(false)} className="!text-white/80 block">Rosemarie</NavAnchor></li>
      <li><NavAnchor navKey="ai_thaiyme" to={advisorTo('thaiyme', isLoggedIn)} onClick={() => setIsOpen(false)} className="!text-white/80 block">Thaiyme</NavAnchor></li>
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

  const homeTo = isLoggedIn ? '/dashboard' : '/';

  return (
    <nav className="bg-[#A3301E] py-3 px-4 shadow-2xl sticky top-0 z-10000 font-montserrat">
      <div className="max-w-350 mx-auto flex justify-between items-center">

        <Link to={homeTo} className="flex items-center shrink-0">
          <img
            src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp"
            className="h-10 md:h-12"
            alt="Oatmeal Farm Network"
            width="160"
            height="40"
            fetchPriority="high"
          />
        </Link>

        <div className="hidden lg:flex flex-grow justify-center">
          <ul className="flex space-x-7 text-xs font-normal items-center">

            {isLoggedIn ? (
              <>
                <li><NavAnchor navKey="dashboard" to="/dashboard" className="nav-link">{t('nav.dashboard')}</NavAnchor></li>
                <li><NavAnchor navKey="directory" to="/directory" className="nav-link">{t('nav.directory')}</NavAnchor></li>
              </>
            ) : (
              <>
                <li><NavAnchor navKey="home" to="/" className="nav-link">{t('nav.home')}</NavAnchor></li>
                <li><NavAnchor navKey="directory" to="/directory" className="nav-link">{t('nav.directory')}</NavAnchor></li>
              </>
            )}

            <li className="relative" ref={mktRef} onMouseEnter={() => setMktOpen(true)} onMouseLeave={() => setMktOpen(false)}>
              <button type="button" onClick={() => setMktOpen(!mktOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.marketplaces')} <ChevronIcon open={mktOpen} />
              </button>
              {mktOpen && <MktDropdown />}
            </li>

            <li className="relative" ref={svcRef} onMouseEnter={() => setSvcOpen(true)} onMouseLeave={() => setSvcOpen(false)}>
              <button type="button" onClick={() => setSvcOpen(!svcOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.services')} <ChevronIcon open={svcOpen} />
              </button>
              {svcOpen && <SvcDropdown />}
            </li>

            <li className="relative" ref={aiRef} onMouseEnter={() => setAiOpen(true)} onMouseLeave={() => setAiOpen(false)}>
              <button type="button" onClick={() => setAiOpen(!aiOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.ai_advisors', 'AI Advisors')} <ChevronIcon open={aiOpen} />
              </button>
              {aiOpen && <AiDropdown />}
            </li>

            <li className="relative" ref={nrRef} onMouseEnter={() => setNrOpen(true)} onMouseLeave={() => setNrOpen(false)}>
              <button type="button" onClick={() => setNrOpen(!nrOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.newsroom')} <ChevronIcon open={nrOpen} />
              </button>
              {nrOpen && <NrDropdown />}
            </li>

            <li className="relative" ref={kbRef} onMouseEnter={() => setKbOpen(true)} onMouseLeave={() => setKbOpen(false)}>
              <button type="button" onClick={() => setKbOpen(!kbOpen)} className="nav-link flex items-center gap-1 focus:outline-none">
                {t('nav.knowledgebases')} <ChevronIcon open={kbOpen} />
              </button>
              {kbOpen && <KbDropdown />}
            </li>

            {isLoggedIn ? (
              <>
                <li><NavAnchor navKey="contact" to="/contact-us" className="nav-link">{t('nav.contact')}</NavAnchor></li>
                <li className="flex items-center gap-3">
                  <CartBell />
                  <NotificationBell />
                  <LanguageSelector />
                  <div className="relative" ref={psRef}>
                    <button
                      type="button"
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
                  <button type="button" onClick={handleLogout} title={t('nav.log_out')} className="text-white/80 hover:text-white transition-colors flex items-center">
                    <LogoutIcon />
                  </button>
                </li>
              </>
            ) : (
              <>
                <li><NavAnchor navKey="about" to="/about" className="nav-link">{t('nav.about')}</NavAnchor></li>
                <li><NavAnchor navKey="contact" to="/contact-us" className="nav-link">{t('nav.contact')}</NavAnchor></li>
                <li><NavAnchor navKey="signup" to="/signup" className="nav-link">{t('nav.signup')}</NavAnchor></li>
                <li className="flex items-center gap-3">
                  <LanguageSelector />
                  <Link to="/login" title={t('nav.login')} className="flex items-center transition-colors" style={{ color: 'rgba(255,255,255,0.8)' }}>
                    <LoginIcon />
                  </Link>
                </li>
              </>
            )}
          </ul>
        </div>

        <div className="lg:w-[180px] flex justify-end">
          <button onClick={() => setIsOpen(!isOpen)} className="lg:hidden text-white text-3xl focus:outline-none" type="button">
            {isOpen ? '✕' : '☰'}
          </button>
        </div>
      </div>

      {isOpen && (
        <div className="lg:hidden bg-[#A3301E] absolute top-full left-0 w-full border-t border-white/10 shadow-xl z-50">
          <ul className="flex flex-col p-6 space-y-4 text-base font-normal text-center">

            {isLoggedIn ? (
              <>
                <li><NavAnchor navKey="dashboard" to="/dashboard" onClick={() => setIsOpen(false)} className="nav-link block">{t('nav.dashboard')}</NavAnchor></li>
                <li><NavAnchor navKey="directory" to="/directory" onClick={() => setIsOpen(false)} className="nav-link block">{t('nav.directory')}</NavAnchor></li>
              </>
            ) : (
              <>
                <li><NavAnchor navKey="home" to="/" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.home')}</NavAnchor></li>
                <li><NavAnchor navKey="directory" to="/directory" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.directory')}</NavAnchor></li>
              </>
            )}

            <li>
              <button type="button" onClick={() => setMktMobileOpen(!mktMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.marketplaces')} <ChevronIcon open={mktMobileOpen} />
              </button>
              {mktMobileOpen && <MktMobileLinks />}
            </li>

            <li>
              <button type="button" onClick={() => setSvcMobileOpen(!svcMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.services')} <ChevronIcon open={svcMobileOpen} />
              </button>
              {svcMobileOpen && <SvcMobileLinks />}
            </li>

            <li>
              <button type="button" onClick={() => setAiMobileOpen(!aiMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.ai_advisors', 'AI Advisors')} <ChevronIcon open={aiMobileOpen} />
              </button>
              {aiMobileOpen && <AiMobileLinks />}
            </li>

            <li>
              <button type="button" onClick={() => setNrMobileOpen(!nrMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.newsroom')} <ChevronIcon open={nrMobileOpen} />
              </button>
              {nrMobileOpen && (
                <ul className="mt-2 space-y-2 text-sm">
                  <li><NavAnchor navKey="nr_newsfeed" to="/app/news" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.newsfeed')}</NavAnchor></li>
                  <li><NavAnchor navKey="nr_blogs" to="/blog" onClick={() => setIsOpen(false)} className="!text-white/80 block">{t('nav.blogs')}</NavAnchor></li>
                </ul>
              )}
            </li>

            <li>
              <button type="button" onClick={() => setKbMobileOpen(!kbMobileOpen)} className="!text-white flex items-center justify-center gap-1 w-full">
                {t('nav.knowledgebases')} <ChevronIcon open={kbMobileOpen} />
              </button>
              {kbMobileOpen && <KbMobileLinks />}
            </li>

            {isLoggedIn ? (
              <>
                <li><NavAnchor navKey="contact" to="/contact-us" onClick={() => setIsOpen(false)} className="nav-link block">{t('nav.contact')}</NavAnchor></li>
                <li className="flex items-center justify-center gap-5 pt-1">
                  <CartBell />
                  <NotificationBell />
                  <LanguageSelector />
                  <button type="button" onClick={handleLogout} title={t('nav.log_out')} className="text-white/80 hover:text-white transition-colors flex items-center">
                    <LogoutIcon />
                  </button>
                </li>
              </>
            ) : (
              <>
                <li><NavAnchor navKey="about" to="/about" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.about')}</NavAnchor></li>
                <li><NavAnchor navKey="contact" to="/contact-us" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.contact')}</NavAnchor></li>
                <li><NavAnchor navKey="signup" to="/signup" onClick={() => setIsOpen(false)} className="!text-white block">{t('nav.signup')}</NavAnchor></li>
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
