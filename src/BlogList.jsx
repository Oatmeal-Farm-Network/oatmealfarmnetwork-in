import React, { useState, useEffect } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function getExcerpt(content, wordLimit = 100) {
  if (!content) return '';
  let text = content;
  try {
    const blocks = JSON.parse(content);
    if (Array.isArray(blocks))
      text = blocks.filter(b => b.type === 'text').map(b => b.content || '').join(' ');
  } catch {}
  const plain = text.replace(/<[^>]*>/g, '').trim();
  const words = plain.split(/\s+/);
  if (words.length <= wordLimit) return plain;
  return words.slice(0, wordLimit).join(' ') + '…';
}

const CATEGORY_COLORS = {
  'Farm News':      '#15803d',
  'Recipes':        '#b45309',
  'Seasonal':       '#0891b2',
  'Events':         '#7C5CBF',
  'Education':      '#1d4ed8',
  'Market Updates': '#be185d',
  'Community':      '#6b7280',
  'General':        '#6b7280',
};

function PostCard({ post }) {
  const catColor = CATEGORY_COLORS[post.category] || '#6b7280';
  const date = (post.published_at || post.created_at)
    ? new Date(post.published_at || post.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
    : '';
  const excerpt = getExcerpt(post.content, 100);

  return (
    <div
      style={{ background: '#fff', borderRadius: '10px', border: '1px solid #e5e7eb', overflow: 'hidden', transition: 'box-shadow 0.2s', display: 'flex', gap: 0 }}
      onMouseEnter={e => e.currentTarget.style.boxShadow = '0 4px 16px rgba(0,0,0,0.08)'}
      onMouseLeave={e => e.currentTarget.style.boxShadow = 'none'}
    >
      {post.cover_image && (
        <img
          src={post.cover_image} alt={post.title}
          style={{ width: 180, minWidth: 180, objectFit: 'cover', display: 'block', flexShrink: 0 }}
          onError={e => e.target.style.display = 'none'}
        />
      )}
      <div style={{ padding: '1.1rem 1.25rem', display: 'flex', flexDirection: 'column', gap: '0.3rem', flex: 1 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
          {post.category && (
            <span style={{ fontSize: '0.68rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', color: catColor, background: catColor + '18', padding: '2px 8px', borderRadius: '10px' }}>
              {post.category}
            </span>
          )}
          <span style={{ fontSize: '0.75rem', color: '#9ca3af' }}>{date}</span>
          {post.business_name && (
            <span style={{ fontSize: '0.75rem', color: '#9ca3af' }}>
              · By <Link to={`/directory/${post.business_id}`} style={{ color: '#7C5CBF', textDecoration: 'none', fontWeight: 600 }}>{post.business_name}</Link>
            </span>
          )}
        </div>
        <Link to={`/blog/${post.blog_id}`} style={{ textDecoration: 'none', color: 'inherit' }}>
          <h3 style={{ margin: '0.1rem 0 0.3rem', fontSize: '1.05rem', fontWeight: 700, color: '#111827', lineHeight: 1.35 }}>
            {post.title}
          </h3>
        </Link>
        {excerpt && (
          <p style={{ margin: 0, fontSize: '0.88rem', color: '#4b5563', lineHeight: 1.6 }}>
            {excerpt}
          </p>
        )}
        <div style={{ marginTop: 'auto', paddingTop: '0.5rem' }}>
          <Link to={`/blog/${post.blog_id}`} style={{ fontSize: '0.83rem', color: '#819360', fontWeight: 600, textDecoration: 'none' }}>
            Read more →
          </Link>
        </div>
      </div>
    </div>
  );
}

function BlogListContent() {
  const [searchParams, setSearchParams] = useSearchParams();
  const [posts, setPosts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');

  const activeCategory = searchParams.get('category') || '';

  useEffect(() => {
    fetch(`${API_URL}/api/blog/categories/global`)
      .then(r => r.ok ? r.json() : [])
      .then(data => setCategories(Array.isArray(data) ? data.map(c => c.name) : []))
      .catch(() => {});
  }, []);

  useEffect(() => {
    setLoading(true);
    const params = new URLSearchParams({ limit: '50' });
    if (activeCategory) params.set('category_name', activeCategory);
    fetch(`${API_URL}/api/blog/posts?${params}`)
      .then(r => r.ok ? r.json() : [])
      .then(data => setPosts(Array.isArray(data) ? data : []))
      .catch(() => setPosts([]))
      .finally(() => setLoading(false));
  }, [activeCategory]);

  const filtered = search.trim()
    ? posts.filter(p =>
        p.title.toLowerCase().includes(search.toLowerCase()) ||
        (p.content || '').toLowerCase().includes(search.toLowerCase()) ||
        (p.business_name || '').toLowerCase().includes(search.toLowerCase())
      )
    : posts;

  return (
    <div style={{ maxWidth: '1100px', margin: '0 auto', padding: '2rem 1.5rem', width: '100%', boxSizing: 'border-box' }}>
      <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
        <h1 style={{ fontSize: '2rem', fontWeight: 800, color: '#111827', margin: '0 0 0.5rem' }}>Blogs</h1>
        <p style={{ color: '#6b7280', fontSize: '0.95rem', margin: 0 }}>Stories, tips, and updates from food lovers across the network</p>
      </div>

      <div style={{ display: 'flex', gap: '0.75rem', marginBottom: '1.5rem', flexWrap: 'wrap', alignItems: 'center' }}>
        <input
          placeholder="Search posts..."
          value={search}
          onChange={e => setSearch(e.target.value)}
          style={{ flex: 1, minWidth: '200px', padding: '0.5rem 0.75rem', border: '1px solid #d1d5db', borderRadius: '8px', fontSize: '0.9rem' }}
        />
        <div style={{ display: 'flex', gap: '0.4rem', flexWrap: 'wrap' }}>
          <button
            onClick={() => setSearchParams({})}
            style={{ padding: '0.35rem 0.85rem', borderRadius: '20px', border: '1px solid', fontSize: '0.82rem', cursor: 'pointer', fontWeight: activeCategory ? 400 : 700, background: activeCategory ? '#f9fafb' : '#819360', color: activeCategory ? '#374151' : '#fff', borderColor: activeCategory ? '#d1d5db' : '#819360' }}
          >
            All
          </button>
          {categories.map(cat => (
            <button
              key={cat}
              onClick={() => setSearchParams({ category: cat })}
              style={{ padding: '0.35rem 0.85rem', borderRadius: '20px', border: '1px solid', fontSize: '0.82rem', cursor: 'pointer', fontWeight: activeCategory === cat ? 700 : 400, background: activeCategory === cat ? '#819360' : '#f9fafb', color: activeCategory === cat ? '#fff' : '#374151', borderColor: activeCategory === cat ? '#819360' : '#d1d5db' }}
            >
              {cat}
            </button>
          ))}
        </div>
      </div>

      {loading && <p style={{ textAlign: 'center', color: '#9ca3af', padding: '3rem 0' }}>Loading posts...</p>}
      {!loading && filtered.length === 0 && (
        <p style={{ textAlign: 'center', color: '#9ca3af', padding: '3rem 0' }}>No posts found.</p>
      )}

      <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
        {filtered.map(post => <PostCard key={post.blog_id} post={post} />)}
      </div>
    </div>
  );
}

export default function BlogList() {
  const [searchParams] = useSearchParams();
  const { Business, businesses, LoadBusiness } = useAccount();
  const isLoggedIn = !!localStorage.getItem('access_token');

  // Prefer BusinessID from URL, fall back to first business in context
  const urlBusinessID = searchParams.get('BusinessID');
  const BusinessID = urlBusinessID || (businesses?.[0]?.BusinessID ?? null);
  const PeopleID = localStorage.getItem('people_id');

  useEffect(() => {
    if (isLoggedIn && BusinessID) LoadBusiness(BusinessID);
  }, [isLoggedIn, BusinessID]);

  if (isLoggedIn && BusinessID) {
    return (
      <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
        <BlogListContent />
      </AccountLayout>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col font-sans">
      <PageMeta
        title="Farm Blog | Stories from Farmers, Ranchers & Food Producers"
        description="Read the latest blog posts from farmers, ranchers, and food producers on Oatmeal Farm Network — farm news, recipes, seasonal updates, market insights, and community stories."
        keywords="farm blog, ranch blog, farmer stories, farm recipes, agricultural news, food producer blog, seasonal farming, market updates"
        canonical="https://oatmealfarmnetwork.com/blog"
      />
      <Header />
      <div style={{ flex: 1 }}>
        <BlogListContent />
      </div>
      <Footer />
    </div>
  );
}
