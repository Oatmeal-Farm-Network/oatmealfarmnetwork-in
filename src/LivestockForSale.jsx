import React, { useEffect, useState, useCallback } from 'react';
import { useParams, Link, useSearchParams } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const ANCESTRY_OPTIONS = [
  'Any', 'Full Peruvian', 'Partial Peruvian',
  'Full Chilean', 'Partial Chilean',
  'Full Bolivian', 'Partial Bolivian',
];

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

function Sidebar({ collapsed, onToggle, isStuds }) {
  const defaultOpen = isStuds ? 'Stud Services' : 'Livestock For Sale';
  const [openSections, setOpenSections] = useState({ [defaultOpen]: true });

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

function AnimalCard({ animal, type }) {
  const [imgFailed, setImgFailed] = useState(false);
  const detailUrl = `/livestockmarketplace/Animals/Details.asp?ID=${animal.animal_id}`;
  const priceLabel = type === 'studs' ? 'Stud Fee' : 'Price';
  const priceVal = type === 'studs' ? animal.stud_fee : animal.price;

  return (
    <div className="card mb-3" style={{ border: 'none', boxShadow: '0 1px 4px rgba(0,0,0,0.12)' }}>
      <div style={{ backgroundColor: '#507033', padding: '8px 12px', borderRadius: '4px 4px 0 0' }}>
        <a href={detailUrl} style={{ color: '#fff', textDecoration: 'none', fontWeight: 600, fontSize: '1rem' }}>
          {animal.full_name}
        </a>
      </div>
      <div style={{ display: 'flex', flexWrap: 'wrap' }}>
        <div style={{ width: '200px', padding: '12px', flexShrink: 0, textAlign: 'center' }}>
          {!imgFailed && animal.photo ? (
            <a href={detailUrl}>
              <img
                src={animal.photo}
                alt={animal.full_name}
                loading="lazy"
                onError={() => setImgFailed(true)}
                style={{ maxHeight: '200px', maxWidth: '100%', objectFit: 'contain', borderRadius: '4px' }}
              />
            </a>
          ) : (
            <div style={{ height: '160px', backgroundColor: '#f0f0f0', borderRadius: '4px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#aaa', fontSize: '12px' }}>
              No Photo
            </div>
          )}
        </div>
        <div style={{ flex: 1, padding: '12px', minWidth: '200px' }}>
          <p style={{ margin: '0 0 6px', fontSize: '0.9rem' }}>
            <strong>{priceLabel}:</strong>{' '}
            {priceVal ? `$${Math.round(priceVal).toLocaleString()}` : 'Call for Price'}
          </p>
          <p style={{ margin: '0 0 6px', fontSize: '0.9rem' }}>
            <strong>Breed:</strong> {animal.breeds && animal.breeds.length > 0 ? animal.breeds.join(', ') : 'N/A'}
          </p>
          <p style={{ margin: '0 0 6px', fontSize: '0.9rem' }}>
            <strong>Location:</strong> {animal.location || 'N/A'}
          </p>
          <p style={{ margin: '0 0 10px', fontSize: '0.9rem' }}>
            <strong>Seller:</strong> {animal.seller || 'N/A'}
          </p>
          <a href={detailUrl}
            style={{ backgroundColor: '#6c757d', color: '#fff', padding: '5px 14px', borderRadius: '4px', textDecoration: 'none', fontSize: '0.85rem' }}>
            View Details
          </a>
        </div>
      </div>
    </div>
  );
}

function Pagination({ page, totalPages, onPageChange }) {
  if (totalPages <= 1) return null;
  const pages = [];
  const start = Math.max(1, page - 2);
  const end = Math.min(totalPages, page + 2);
  for (let i = start; i <= end; i++) pages.push(i);
  return (
    <div style={{ display: 'flex', gap: '4px', flexWrap: 'wrap', margin: '16px 0' }}>
      {page > 1 && <button onClick={() => onPageChange(page - 1)} style={btnStyle}>‹ Prev</button>}
      {pages.map(p => (
        <button key={p} onClick={() => onPageChange(p)}
          style={{ ...btnStyle, backgroundColor: p === page ? '#507033' : '#fff', color: p === page ? '#fff' : '#333' }}>
          {p}
        </button>
      ))}
      {page < totalPages && <button onClick={() => onPageChange(page + 1)} style={btnStyle}>Next ›</button>}
      {totalPages > 5 && page < totalPages && (
        <button onClick={() => onPageChange(totalPages)} style={btnStyle}>Last</button>
      )}
    </div>
  );
}

const btnStyle = {
  padding: '5px 12px', border: '1px solid #ccc', borderRadius: '8px',
  backgroundColor: '#fff', cursor: 'pointer', fontSize: '0.85rem',
  boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
};

export default function LivestockForSale() {
  const { slug } = useParams();
  const [searchParams] = useSearchParams();
  const { pathname } = window.location;
  const isStuds = pathname.includes('/studs/');

  const [data, setData] = useState(null);
  const [filters, setFilters] = useState({ breeds: [], states: [] });
  const [loading, setLoading] = useState(true);
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);

  const [breedId, setBreedId] = useState(Number(searchParams.get('breed_id')) || 0);
  const [stateIndex, setStateIndex] = useState(Number(searchParams.get('state_index')) || 0);
  const [minPrice, setMinPrice] = useState(searchParams.get('min_price') || '');
  const [maxPrice, setMaxPrice] = useState(searchParams.get('max_price') || '');
  const [ancestry, setAncestry] = useState(searchParams.get('ancestry') || 'Any');
  const [sortBy, setSortBy] = useState(searchParams.get('sort_by') || 'lastupdated');
  const [orderBy, setOrderBy] = useState(searchParams.get('order_by') || 'desc');
  const [page, setPage] = useState(Number(searchParams.get('page')) || 1);

  useEffect(() => {
    if (window.innerWidth < 768) setSidebarCollapsed(true);
  }, []);

  // Reset all filters when species changes
  useEffect(() => {
    setBreedId(0);
    setStateIndex(0);
    setMinPrice('');
    setMaxPrice('');
    setAncestry('Any');
    setSortBy('lastupdated');
    setOrderBy('desc');
    setPage(1);
    setData(null);
  }, [slug]);

  useEffect(() => {
    fetch(`${API_URL}/api/marketplace/filters/${slug}`)
      .then(r => r.ok ? r.json() : { breeds: [], states: [] })
      .then(d => setFilters({ breeds: d.breeds || [], states: d.states || [] }))
      .catch(() => setFilters({ breeds: [], states: [] }));
  }, [slug]);

  const [singularTerm, setSingularTerm] = useState('');
  useEffect(() => {
    fetch(`${API_URL}/api/marketplace/species/${slug}`)
      .then(r => r.ok ? r.json() : null)
      .then(d => d && setSingularTerm(d.singular_term || ''))
      .catch(() => {});
  }, [slug]);

  const loadData = useCallback(() => {
    setLoading(true);
    const endpoint = isStuds ? 'studs' : 'for-sale';
    const priceParam = isStuds ? 'stud_fee' : 'price';
    const params = new URLSearchParams({
      page,
      breed_id: breedId,
      state_index: stateIndex,
      [`min_${priceParam}`]: minPrice || 0,
      [`max_${priceParam}`]: maxPrice || 100000000,
      ancestry,
      sort_by: sortBy,
      order_by: orderBy,
    });
    fetch(`${API_URL}/api/marketplace/${endpoint}/${slug}?${params}`)
      .then(r => r.ok ? r.json() : null)
      .then(d => {
        setData(d ? { ...d, animals: d.animals || [] } : { total: 0, page: 1, per_page: 10, total_pages: 1, animals: [] });
        setLoading(false);
      })
      .catch(() => {
        setData({ total: 0, page: 1, per_page: 10, total_pages: 1, animals: [] });
        setLoading(false);
      });
  }, [slug, page, breedId, stateIndex, minPrice, maxPrice, ancestry, sortBy, orderBy, isStuds]);

  useEffect(() => { loadData(); }, [loadData]);



  const rawLabel = data?.label || slug;
  const fallbackLabel = rawLabel.charAt(0).toUpperCase() + rawLabel.slice(1);
  const label = singularTerm || fallbackLabel;
  const pageTitle = isStuds ? `${label} Stud Services` : `${label} For Sale`;
  const otherLink = isStuds ? `/marketplaces/livestock/${slug}` : `/marketplaces/livestock/studs/${slug}`;
  const otherLabel = isStuds ? `${label} For Sale` : `${label} Stud Services`;
  const priceLabel = isStuds ? 'Stud Fee' : 'Price';

  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />

      {/* Sidebar + content directly under header */}
      <div style={{ display: 'flex', alignItems: 'flex-start' }}>

        <Sidebar
          collapsed={sidebarCollapsed}
          onToggle={() => setSidebarCollapsed(p => !p)}
          isStuds={isStuds}
        />

        {/* Right side — everything */}
        <div style={{ flex: 1, minWidth: 0 }}>

          {/* Green title bar */}
          <div style={{ backgroundColor: '#507033', padding: '12px 24px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
            <h1 style={{ color: '#fff', margin: 0, fontSize: '1.4rem', fontWeight: 'bold' }}>{pageTitle}</h1>
            <Link to={otherLink} style={{ color: '#fff', fontSize: '0.9rem', fontWeight: 600, whiteSpace: 'nowrap' }}>
              {otherLabel} →
            </Link>
          </div>

          <div style={{ display: 'flex', alignItems: 'flex-start', padding: '20px 16px', gap: '24px' }}>

            {/* Search filters */}
            <div style={{ width: '200px', flexShrink: 0 }}>
  <div>
                <div style={filterBox}>
                  <label style={filterLabel}>Breed</label>
                  <select value={breedId} onChange={e => { setBreedId(Number(e.target.value)); setPage(1); }} style={selectStyle}>
                    <option value={0}>All Breeds</option>
                    {filters.breeds.map(b => (
                      <option key={b.id} value={b.id}>{b.name}</option>
                    ))}
                  </select>
                </div>

                {filters.states.length > 0 && (
                  <div style={filterBox}>
                    <label style={filterLabel}>State</label>
                    <select value={stateIndex} onChange={e => { setStateIndex(Number(e.target.value)); setPage(1); }} style={selectStyle}>
                      <option value={0}>All States</option>
                      {filters.states.map(s => (
                        <option key={s.index} value={s.index}>{s.name}</option>
                      ))}
                    </select>
                  </div>
                )}

                <div style={filterBox}>
                  <label style={filterLabel}>Min {priceLabel}</label>
                  <input type="number" value={minPrice} onChange={e => setMinPrice(e.target.value)}
                    placeholder="$0" style={inputStyle} />
                </div>

                <div style={filterBox}>
                  <label style={filterLabel}>Max {priceLabel}</label>
                  <input type="number" value={maxPrice} onChange={e => setMaxPrice(e.target.value)}
                    placeholder="Any" style={inputStyle} />
                </div>

                {slug === 'alpacas' && (
                  <div style={filterBox}>
                    <label style={filterLabel}>Ancestry</label>
                    <select value={ancestry} onChange={e => { setAncestry(e.target.value); setPage(1); }} style={selectStyle}>
                      {ANCESTRY_OPTIONS.map(o => <option key={o} value={o}>{o}</option>)}
                    </select>
                  </div>
                )}

                {!isStuds && (
                  <div style={filterBox}>
                    <label style={filterLabel}>Sort By</label>
                    <select value={sortBy} onChange={e => { setSortBy(e.target.value); setPage(1); }} style={selectStyle}>
                      <option value="lastupdated">Last Updated</option>
                      <option value="price">Price</option>
                      <option value="name">Name</option>
                      <option value="breed">Breed</option>
                    </select>
                    <select value={orderBy} onChange={e => { setOrderBy(e.target.value); setPage(1); }}
                      style={{ ...selectStyle, marginTop: '4px' }}>
                      <option value="desc">Descending</option>
                      <option value="asc">Ascending</option>
                    </select>
                  </div>
                )}

</div>
            </div>

            {/* Results */}
            <div style={{ flex: 1, minWidth: 0 }}>
              {loading ? (
                <div>
                  {[...Array(3)].map((_, i) => (
                    <div key={i} className="animate-pulse" style={{ marginBottom: '16px', border: '1px solid #eee', borderRadius: '4px', overflow: 'hidden' }}>
                      <div style={{ height: '36px', backgroundColor: '#c8d9b8' }} />
                      <div style={{ display: 'flex', padding: '12px', gap: '12px' }}>
                        <div style={{ width: '180px', height: '160px', backgroundColor: '#e8e8e8', borderRadius: '4px', flexShrink: 0 }} />
                        <div style={{ flex: 1 }}>
                          {[...Array(4)].map((_, j) => (
                            <div key={j} style={{ height: '14px', backgroundColor: '#e8e8e8', borderRadius: '4px', marginBottom: '10px', width: j === 3 ? '40%' : '70%' }} />
                          ))}
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              ) : !data || data.animals.length === 0 ? (
                <div style={{ backgroundColor: '#d1ecf1', border: '1px solid #bee5eb', borderRadius: '4px', padding: '16px' }}>
                  <h4 style={{ margin: '0 0 8px' }}>No Results Found</h4>
                  <p style={{ margin: 0 }}>Please broaden your search criteria.</p>
                </div>
              ) : (
                <>
                  <div style={{ color: '#666', fontSize: '0.85rem', marginBottom: '12px' }}>
                    Showing {((page - 1) * data.per_page) + 1}–{Math.min(page * data.per_page, data.total)} of {data.total} results
                  </div>
                  <Pagination page={page} totalPages={data.total_pages} onPageChange={setPage} />
                  {data.animals.map(animal => (
                    <AnimalCard key={animal.animal_id} animal={animal} type={isStuds ? 'studs' : 'sale'} />
                  ))}
                  <Pagination page={page} totalPages={data.total_pages} onPageChange={setPage} />
                </>
              )}
            </div>
          </div>
        </div>
      </div>

      <Footer />
    </div>
  );
}

const filterBox = { marginBottom: '12px' };
const filterLabel = {
  display: 'block', fontSize: '0.8rem', fontWeight: 600,
  color: '#555', marginBottom: '4px', textTransform: 'uppercase',
};
const selectStyle = {
  width: '100%', padding: '6px 8px', border: '1px solid #ccc',
  borderRadius: '4px', fontSize: '0.85rem',
};
const inputStyle = {
  width: '100%', padding: '6px 8px', border: '1px solid #ccc',
  borderRadius: '4px', fontSize: '0.85rem', boxSizing: 'border-box',
};