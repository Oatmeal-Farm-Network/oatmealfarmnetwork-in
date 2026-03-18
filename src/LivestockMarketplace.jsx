import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const SIDEBAR_SECTIONS = [
  {
    label: 'Livestock For Sale',
    items: [
      { label: 'Alpacas', path: '/marketplaces/livestock/alpacas' },
      { label: 'Bison', path: '/marketplaces/livestock/bison' },
      { label: 'Buffalo', path: '/marketplaces/livestock/buffalo' },
      { label: 'Camels', path: '/marketplaces/livestock/camels' },
      { label: 'Cattle', path: '/marketplaces/livestock/cattle' },
      { label: 'Chickens', path: '/marketplaces/livestock/chickens' },
      { label: 'Crocodiles & Alligators', path: '/marketplaces/livestock/crocodiles' },
      { label: 'Deer', path: '/marketplaces/livestock/deer' },
      { label: 'Working Dogs', path: '/marketplaces/livestock/dogs' },
      { label: 'Donkeys', path: '/marketplaces/livestock/donkeys' },
      { label: 'Ducks', path: '/marketplaces/livestock/ducks' },
      { label: 'Emus', path: '/marketplaces/livestock/emus' },
      { label: 'Geese', path: '/marketplaces/livestock/geese' },
      { label: 'Goats', path: '/marketplaces/livestock/goats' },
      { label: 'Guinea Fowl', path: '/marketplaces/livestock/guinea-fowl' },
      { label: 'Honey Bees', path: '/marketplaces/livestock/honey-bees' },
      { label: 'Horses', path: '/marketplaces/livestock/horses' },
      { label: 'Llamas', path: '/marketplaces/livestock/llamas' },
      { label: 'Musk Ox', path: '/marketplaces/livestock/musk-ox' },
      { label: 'Ostriches', path: '/marketplaces/livestock/ostriches' },
      { label: 'Pheasants', path: '/marketplaces/livestock/pheasants' },
      { label: 'Pigeons', path: '/marketplaces/livestock/pigeons' },
      { label: 'Pigs', path: '/marketplaces/livestock/pigs' },
      { label: 'Quails', path: '/marketplaces/livestock/quails' },
      { label: 'Rabbits', path: '/marketplaces/livestock/rabbits' },
      { label: 'Sheep', path: '/marketplaces/livestock/sheep' },
      { label: 'Snails', path: '/marketplaces/livestock/snails' },
      { label: 'Turkeys', path: '/marketplaces/livestock/turkeys' },
      { label: 'Yaks', path: '/marketplaces/livestock/yaks' },
    ],
  },
  {
    label: 'Stud Services',
    items: [
      { label: 'Alpaca Studs', path: '/marketplaces/livestock/studs/alpacas' },
      { label: 'Bison Studs', path: '/marketplaces/livestock/studs/bison' },
      { label: 'Buffalo Studs', path: '/marketplaces/livestock/studs/buffalo' },
      { label: 'Camel Studs', path: '/marketplaces/livestock/studs/camels' },
      { label: 'Cattle Studs', path: '/marketplaces/livestock/studs/cattle' },
      { label: 'Working Dog Studs', path: '/marketplaces/livestock/studs/dogs' },
      { label: 'Donkey Studs', path: '/marketplaces/livestock/studs/donkeys' },
      { label: 'Goat Studs', path: '/marketplaces/livestock/studs/goats' },
      { label: 'Horse Studs', path: '/marketplaces/livestock/studs/horses' },
      { label: 'Llama Studs', path: '/marketplaces/livestock/studs/llamas' },
      { label: 'Pig Studs', path: '/marketplaces/livestock/studs/pigs' },
      { label: 'Rabbit Studs', path: '/marketplaces/livestock/studs/rabbits' },
      { label: 'Sheep Studs', path: '/marketplaces/livestock/studs/sheep' },
      { label: 'Yak Studs', path: '/marketplaces/livestock/studs/yaks' },
    ],
  },
  {
    label: 'Ranches',
    items: [
      { label: 'Alpaca Ranches', path: '/marketplaces/livestock/ranches/alpacas' },
      { label: 'Bees, Honey', path: '/marketplaces/livestock/ranches/honey-bees' },
      { label: 'Bison Ranches', path: '/marketplaces/livestock/ranches/bison' },
      { label: 'Buffalo Ranches', path: '/marketplaces/livestock/ranches/buffalo' },
      { label: 'Camel Ranches', path: '/marketplaces/livestock/ranches/camels' },
      { label: 'Cattle Ranches', path: '/marketplaces/livestock/ranches/cattle' },
      { label: 'Chicken Ranches', path: '/marketplaces/livestock/ranches/chickens' },
      { label: 'Crocodile & Alligator Ranches', path: '/marketplaces/livestock/ranches/crocodiles' },
      { label: 'Deer Ranches', path: '/marketplaces/livestock/ranches/deer' },
      { label: 'Working Dog Ranches', path: '/marketplaces/livestock/ranches/dogs' },
      { label: 'Donkey Ranches', path: '/marketplaces/livestock/ranches/donkeys' },
      { label: 'Duck Ranches', path: '/marketplaces/livestock/ranches/ducks' },
      { label: 'Emu Ranches', path: '/marketplaces/livestock/ranches/emus' },
      { label: 'Geese Ranches', path: '/marketplaces/livestock/ranches/geese' },
      { label: 'Goat Ranches', path: '/marketplaces/livestock/ranches/goats' },
      { label: 'Guinea Fowl Ranches', path: '/marketplaces/livestock/ranches/guinea-fowl' },
      { label: 'Horse Ranches', path: '/marketplaces/livestock/ranches/horses' },
      { label: 'Llama Ranches', path: '/marketplaces/livestock/ranches/llamas' },
      { label: 'Musk Ox Ranches', path: '/marketplaces/livestock/ranches/musk-ox' },
      { label: 'Ostrich Ranches', path: '/marketplaces/livestock/ranches/ostriches' },
      { label: 'Pheasant Ranches', path: '/marketplaces/livestock/ranches/pheasants' },
      { label: 'Pig Ranches', path: '/marketplaces/livestock/ranches/pigs' },
      { label: 'Pigeon Ranches', path: '/marketplaces/livestock/ranches/pigeons' },
      { label: 'Quail Ranches', path: '/marketplaces/livestock/ranches/quails' },
      { label: 'Rabbit Ranches', path: '/marketplaces/livestock/ranches/rabbits' },
      { label: 'Sheep Ranches', path: '/marketplaces/livestock/ranches/sheep' },
      { label: 'Snail Ranches', path: '/marketplaces/livestock/ranches/snails' },
      { label: 'Turkey Ranches', path: '/marketplaces/livestock/ranches/turkeys' },
      { label: 'Yak Ranches', path: '/marketplaces/livestock/ranches/yaks' },
    ],
  },
];

function Sidebar({ collapsed, onToggle }) {
  const [openSections, setOpenSections] = useState({ 'Livestock For Sale': true });

  const toggleSection = (label) => {
    setOpenSections(prev => ({ ...prev, [label]: !prev[label] }));
  };

  return (
    <div style={{
      width: collapsed ? '40px' : '220px',
      minWidth: collapsed ? '40px' : '220px',
      transition: 'all 0.3s ease',
      backgroundColor: '#f5f5f0',
      borderRight: '1px solid #ddd',
      overflowY: collapsed ? 'hidden' : 'auto',
      overflowX: 'hidden',
      position: 'sticky',
      top: '72px',
      maxHeight: 'calc(100vh - 72px)',
      flexShrink: 0,
    }}>
      {/* Toggle button */}
      <button
        onClick={onToggle}
        style={{
          width: '100%', padding: '10px', border: 'none',
          backgroundColor: '#e59a24', color: '#fff',
          fontWeight: 'bold', cursor: 'pointer', fontSize: '14px',
          display: 'flex', alignItems: 'center',
          justifyContent: collapsed ? 'center' : 'space-between',
          gap: '6px',
        }}
      >
        {!collapsed && <span style={{ fontSize: '12px', fontWeight: 600 }}>Browse</span>}
        <span style={{ fontSize: '18px' }}>{collapsed ? '☰' : '✕'}</span>
      </button>

      {!collapsed && (
        <div style={{ padding: '8px 0' }}>
          {SIDEBAR_SECTIONS.map(section => (
            <div key={section.label}>
              <button
                onClick={() => toggleSection(section.label)}
                style={{
                  width: '100%', padding: '8px 12px', border: 'none',
                  backgroundColor: '#e8e8e0', color: '#333',
                  fontWeight: '700', fontSize: '12px', textAlign: 'left',
                  cursor: 'pointer', display: 'flex', justifyContent: 'space-between',
                  alignItems: 'center', textTransform: 'uppercase', letterSpacing: '0.5px',
                }}
              >
                {section.label}
                <span>{openSections[section.label] ? '▲' : '▼'}</span>
              </button>

              {openSections[section.label] && (
                <ul style={{ listStyle: 'none', margin: 0, padding: '4px 0' }}>
                  {section.items.map(item => (
                    <li key={item.label}>
                      <Link
                        to={item.path}
                        style={{
                          display: 'block', padding: '5px 16px',
                          fontSize: '13px', color: '#4d734d',
                          textDecoration: 'none',
                        }}
                        onMouseEnter={e => e.currentTarget.style.backgroundColor = '#e5ede5'}
                        onMouseLeave={e => e.currentTarget.style.backgroundColor = 'transparent'}
                      >
                        {item.label}
                      </Link>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

function AnimalCard({ animal }) {
  const [failed, setFailed] = useState(false);
  if (failed) return null;

  const priceDisplay = () => {
    if (animal.sale_price && animal.price) {
      const discounted = animal.price * ((100 - animal.sale_price) / 100);
      return (
        <>
          Price: <span style={{ textDecoration: 'line-through', color: 'red' }}>${Math.round(animal.price).toLocaleString()}</span>
          {' '}<strong>${Math.round(discounted).toLocaleString()}</strong>
        </>
      );
    }
    if (animal.price) {
      return <>Price: <strong>${Math.round(animal.price).toLocaleString()}</strong></>;
    }
    return <strong>Call For Price</strong>;
  };

  const shortName = animal.full_name?.length > 28
    ? animal.full_name.substring(0, 28) + '...'
    : animal.full_name;

  return (
    <div
      style={{
        backgroundColor: '#fff', border: '2px solid #abacab',
        borderRadius: '4px', padding: '10px',
        display: 'flex', flexDirection: 'column', alignItems: 'center',
        transition: 'box-shadow 0.2s, transform 0.2s', cursor: 'pointer',
      }}
      onMouseEnter={e => { e.currentTarget.style.boxShadow = '2px 2px 15px #a7ac20'; e.currentTarget.style.transform = 'scale(1.02)'; }}
      onMouseLeave={e => { e.currentTarget.style.boxShadow = 'none'; e.currentTarget.style.transform = 'scale(1)'; }}
    >
      <div style={{ width: '100%', height: '180px', display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden', paddingTop: '10px' }}>
        <img
          src={animal.photo}
          alt={animal.full_name}
          loading="lazy"
          onError={() => setFailed(true)}
          style={{ width: '100%', height: '180px', objectFit: 'contain' }}
        />
      </div>
      <div style={{ textAlign: 'center', marginTop: '8px', fontSize: '0.82rem', color: '#555', width: '100%' }}>
        <a
          href={`/livestockmarketplace/Animals/Details.asp?ID=${animal.animal_id}&CurrentPeopleID=${animal.people_id}`}
          style={{ fontWeight: 600, color: '#333', textDecoration: 'none', display: 'block' }}
        >
          {shortName}
        </a>
        <div style={{ color: '#666', marginTop: '2px' }}>{animal.breed} {animal.species}</div>
        <div style={{ marginTop: '4px' }}>{priceDisplay()}</div>
      </div>
    </div>
  );
}

function CardGrid({ animals }) {
  return (
    <div style={{
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))',
      gap: '16px',
    }}>
      {animals.map(animal => (
        <AnimalCard key={animal.animal_id} animal={animal} />
      ))}
    </div>
  );
}

export default function LivestockMarketplace() {
  const [listings, setListings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);

  useEffect(() => {
    if (window.innerWidth < 768) setSidebarCollapsed(true);

    fetch(`${API_URL}/api/marketplace/homepage-listings`)
      .then(r => r.json())
      .then(data => { setListings(Array.isArray(data) ? data : []); setLoading(false); })
      .catch(() => setLoading(false));
  }, []);

  const featured = listings.slice(0, 4);
  const browse = listings.slice(4, 12);

  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />

      {/* Sidebar + all content sit side by side directly under header */}
      <div style={{ display: 'flex', alignItems: 'flex-start' }}>

        <Sidebar collapsed={sidebarCollapsed} onToggle={() => setSidebarCollapsed(p => !p)} />

        {/* Right side — banner then everything else */}
        <div style={{ flex: 1, minWidth: 0 }}>

          {/* Banner image */}
          <div style={{ width: '100%' }}>
            <img
              src="/images/LOAwebbanner1898x360.webp"
              alt="Livestock of America"
              loading="eager"
              fetchPriority="high"
              style={{ width: '100%', display: 'block', maxHeight: '200px', objectFit: 'cover' }}
              onError={e => { e.target.style.display = 'none'; }}
            />
          </div>

          {/* Intro text */}
          <div style={{ padding: '1.5rem 1.5rem 1rem' }}>
            <h1 style={{ textAlign: 'center', fontSize: '1.4rem', fontWeight: 'bold', marginBottom: '0.5rem' }}>
              Connecting Ranches Across The United States
            </h1>
            <p style={{ fontSize: '0.9rem', color: '#333', lineHeight: 1.6, marginBottom: '0.5rem' }}>
              Livestock of America is a one-of-a-kind livestock marketplace, helping ranches showcase their animals online.
              We support all livestock breeders, regardless of breed or type.
            </p>
            <p style={{ fontSize: '0.9rem', color: '#333', lineHeight: 1.6, marginBottom: '1rem' }}>
              From the rugged Pacific coast to the historic shores of Plymouth, Livestock of America connects the breeders
              of animals who live off the land. These men and women keep our country fed, and we are proud to help them succeed.
            </p>
            <Link to="/signup" className="regsubmit2">Join Now</Link>
          </div>

          {loading ? (
            <div style={{ textAlign: 'center', padding: '3rem', color: '#888' }}>Loading listings...</div>
          ) : listings.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '3rem', color: '#888' }}>
              <p style={{ marginBottom: '1rem' }}>No listings available right now.</p>
              <Link to="/signup" className="regsubmit2">List Your Animals</Link>
            </div>
          ) : (
            <>
              {/* Featured Listings */}
              {featured.length > 0 && (
                <div style={{ backgroundColor: '#e59a24', padding: '1.5rem' }}>
                  <h2 style={{ textAlign: 'center', fontSize: '1.4rem', fontWeight: 'bold', marginBottom: '1.25rem', color: '#222' }}>
                    Featured Listings
                  </h2>
                  <CardGrid animals={featured} />
                </div>
              )}

              {/* Browse Listings */}
              {browse.length > 0 && (
                <div style={{
                  backgroundImage: "url('/images/HomepageBackground.jpg')",
                  backgroundSize: 'cover', backgroundPosition: 'center',
                  padding: '1.5rem', minHeight: '500px',
                }}>
                  <h2 style={{ textAlign: 'center', fontSize: '1.4rem', fontWeight: 'bold', marginBottom: '1.25rem', color: '#222' }}>
                    Browse Listings
                  </h2>
                  <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <CardGrid animals={browse.slice(0, 4)} />
                    {browse.length > 4 && <CardGrid animals={browse.slice(4, 8)} />}
                  </div>
                </div>
              )}
            </>
          )}
        </div>
      </div>

      <Footer />
    </div>
  );
}