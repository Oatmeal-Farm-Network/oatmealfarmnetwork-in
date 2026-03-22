// src/NewsFeed.jsx
import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const CATEGORIES = ['All', 'Markets', 'Weather', 'Policy', 'AgTech', 'Livestock', 'General'];

const CATEGORY_IMAGES = {
  Markets: '/images/news/news-markets.svg',
  Weather: '/images/news/news-weather.svg',
  Policy: '/images/news/news-policy.svg',
  AgTech: '/images/news/news-agtech.svg',
  Livestock: '/images/news/news-livestock.svg',
  General: '/images/news/news-general.svg',
};

const NEWS_API = import.meta.env.VITE_NEWS_API_URL || import.meta.env.VITE_API_URL || '';

const NewsFeed = () => {
  const navigate = useNavigate();
  const [articles, setArticles] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [query, setQuery] = useState('');
  const [category, setCategory] = useState('All');
  const [sort, setSort] = useState('Newest');

  useEffect(() => {
    const fetchNews = async () => {
      setLoading(true);
      setError('');
      try {
        const response = await fetch(`${NEWS_API}/api/news`);
        if (!response.ok) throw new Error('Failed to fetch news');
        const data = await response.json();
        setArticles(data.articles || []);
      } catch (err) {
        console.error('News fetch error:', err);
        setError('Unable to load news. Please try again later.');
      } finally {
        setLoading(false);
      }
    };
    fetchNews();
  }, []);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    let result = articles.filter(a =>
      (category === 'All' || a.category === category) &&
      (!q || a.title.toLowerCase().includes(q) || a.description.toLowerCase().includes(q) || a.source.toLowerCase().includes(q))
    );
    result.sort((a, b) => {
      const da = new Date(a.pubDate).getTime();
      const db = new Date(b.pubDate).getTime();
      return sort === 'Newest' ? db - da : da - db;
    });
    return result;
  }, [articles, query, category, sort]);

  const formatDate = (dateStr) => {
    const date = new Date(dateStr);
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
    if (diffHours < 1) return 'Just now';
    if (diffHours < 24) return `${diffHours}h ago`;
    if (diffDays < 7) return `${diffDays}d ago`;
    return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
  };

  const getCategoryColor = (cat) => {
    const colors = { Markets: '#2563eb', Weather: '#0891b2', Policy: '#7c3aed', AgTech: '#059669', Livestock: '#b45309', General: '#6b7280' };
    return colors[cat] || '#6b7280';
  };

  const getArticleImage = (article) => {
    const img = article.image?.trim();
    if (img && img.startsWith('http')) return img;
    return article.placeholderImage || CATEGORY_IMAGES[article.category] || CATEGORY_IMAGES.General;
  };

  return (
    <div style={{ paddingTop: '1.5rem', paddingBottom: '2rem', paddingLeft: '2rem', paddingRight: '2rem', maxWidth: '1200px', margin: '0 auto' }}>
      <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
        <h1 style={{ fontSize: '1.75rem', fontWeight: 700, color: '#111827', margin: '0 0 0.25rem' }}>Agriculture News</h1>
        <p style={{ color: '#6b7280', fontSize: '0.9rem', margin: 0 }}>Live updates from USDA, Farm Journal, Brownfield Ag, AGDAILY and more.</p>
      </div>

      <div style={{ display: 'flex', gap: '0.75rem', marginBottom: '1.5rem', flexWrap: 'wrap' }}>
        <input placeholder="Search headlines or sources..." value={query} onChange={e => setQuery(e.target.value)}
          style={{ flex: 1, minWidth: '200px', paddingTop: '0.5rem', paddingBottom: '0.5rem', paddingLeft: '0.75rem', paddingRight: '0.75rem', border: '1px solid #d1d5db', borderRadius: '8px', fontSize: '0.9rem' }} />
        <select value={category} onChange={e => setCategory(e.target.value)}
          style={{ paddingTop: '0.5rem', paddingBottom: '0.5rem', paddingLeft: '0.75rem', paddingRight: '0.75rem', border: '1px solid #d1d5db', borderRadius: '8px', fontSize: '0.9rem' }}>
          {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
        </select>
        <select value={sort} onChange={e => setSort(e.target.value)}
          style={{ paddingTop: '0.5rem', paddingBottom: '0.5rem', paddingLeft: '0.75rem', paddingRight: '0.75rem', border: '1px solid #d1d5db', borderRadius: '8px', fontSize: '0.9rem' }}>
          <option>Newest</option>
          <option>Oldest</option>
        </select>
      </div>

      {loading && <div style={{ textAlign: 'center', paddingTop: '2rem', color: '#6b7280' }}>Loading agriculture news...</div>}
      {error && <div style={{ textAlign: 'center', paddingTop: '2rem', color: '#dc2626' }}>{error}</div>}
      {!loading && !error && filtered.length === 0 && <div style={{ textAlign: 'center', paddingTop: '2rem', color: '#9ca3af' }}>No articles match your filters.</div>}

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1rem' }}>
        {filtered.map((a, i) => (
          <div key={`${a.id}-${i}`} onClick={() => navigate(`/app/news/${a.id}`)}
            style={{ cursor: 'pointer', borderRadius: '10px', overflow: 'hidden', backgroundColor: '#fff', border: '1px solid #e5e7eb', transition: 'box-shadow 0.2s' }}
            onMouseEnter={e => { e.currentTarget.style.boxShadow = '0 4px 12px rgba(0,0,0,0.1)'; }}
            onMouseLeave={e => { e.currentTarget.style.boxShadow = 'none'; }}>
            <div style={{ position: 'relative', overflow: 'hidden', lineHeight: 0 }}>
              <img src={getArticleImage(a)} alt={a.title}
                style={{ width: '100%', height: '140px', objectFit: 'cover', display: 'block' }}
                onError={e => {
                  const fallback = CATEGORY_IMAGES[a.category] || CATEGORY_IMAGES.General;
                  if (e.target.src !== fallback) e.target.src = fallback;
                }} />
              <span style={{ position: 'absolute', top: '0.4rem', left: '0.4rem', backgroundColor: getCategoryColor(a.category), color: '#fff', fontSize: '0.6rem', fontWeight: 600,
                paddingTop: '2px', paddingBottom: '2px', paddingLeft: '6px', paddingRight: '6px', borderRadius: '3px', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                {a.category}
              </span>
            </div>
            <div style={{ paddingTop: '0.6rem', paddingBottom: '0.75rem', paddingLeft: '0.75rem', paddingRight: '0.75rem' }}>
              <h3 style={{ fontSize: '0.85rem', fontWeight: 600, lineHeight: 1.3, margin: '0 0 0.3rem', color: '#111827',
                display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                {a.title}
              </h3>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '0.7rem', color: '#9ca3af' }}>
                <span>{a.source}</span>
                <span>{formatDate(a.pubDate)}</span>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default NewsFeed;
