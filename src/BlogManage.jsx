import React, { useState, useEffect } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function getExcerpt(content, wordLimit = 100) {
  if (!content) return '';
  const plain = content.replace(/<[^>]*>/g, '').trim();
  const words = plain.split(/\s+/);
  if (words.length <= wordLimit) return plain;
  return words.slice(0, wordLimit).join(' ') + '…';
}

const emptyForm = {
  title: '',
  content: '',
  cover_image: '',
  author: '',
  author_link: '',
  blog_cat_id: null,
  custom_cat_id: null,
  is_published: false,
  is_featured: false,
};

// ── PostEditor ──────────────────────────────────────────────────
function PostEditor({ post, businessId, globalCategories, customCategories,
                      onCustomCategoriesChange, onSave, onCancel }) {
  const [form, setForm] = useState(post ? {
    title:         post.title || '',
    content:       post.content || '',
    cover_image:   post.cover_image || '',
    author:        post.author || '',
    author_link:   post.author_link || '',
    blog_cat_id:   post.blog_cat_id ?? null,
    custom_cat_id: post.custom_cat_id ?? null,
    is_published:  post.is_published || false,
    is_featured:   post.is_featured || false,
  } : { ...emptyForm });

  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  // Inline custom category management
  const [showNewCat, setShowNewCat] = useState(false);
  const [newCatName, setNewCatName] = useState('');
  const [catSaving, setCatSaving] = useState(false);
  const [catError, setCatError] = useState('');
  const [removingCat, setRemovingCat] = useState(null);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const handleSave = async () => {
    if (!form.title.trim()) { setError('Title is required'); return; }
    setSaving(true);
    setError('');
    try {
      const isEdit = !!post;
      const url = isEdit
        ? `${API_URL}/api/blog/manage/${post.blog_id}?business_id=${businessId}`
        : `${API_URL}/api/blog/manage?business_id=${businessId}`;
      const res = await fetch(url, {
        method: isEdit ? 'PUT' : 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(form),
      });
      if (!res.ok) throw new Error('Save failed');
      onSave();
    } catch {
      setError('Failed to save post. Please try again.');
    } finally {
      setSaving(false);
    }
  };

  const handleAddCategory = async () => {
    const name = newCatName.trim();
    if (!name) return;
    setCatSaving(true);
    setCatError('');
    try {
      const res = await fetch(`${API_URL}/api/blog/categories/custom?business_id=${businessId}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name }),
      });
      if (res.status === 409) { setCatError('Already exists.'); return; }
      if (!res.ok) throw new Error();
      const created = await res.json();
      onCustomCategoriesChange([...customCategories, created]);
      set('custom_cat_id', created.id);
      setNewCatName('');
      setShowNewCat(false);
    } catch {
      setCatError('Failed to add.');
    } finally {
      setCatSaving(false);
    }
  };

  const handleRemoveCategory = async (cat) => {
    if (!window.confirm(`Remove "${cat.name}" from your categories?`)) return;
    setRemovingCat(cat.id);
    try {
      await fetch(`${API_URL}/api/blog/categories/custom/${cat.id}?business_id=${businessId}`,
        { method: 'DELETE' });
      onCustomCategoriesChange(customCategories.filter(c => c.id !== cat.id));
      if (form.custom_cat_id === cat.id) set('custom_cat_id', null);
    } finally {
      setRemovingCat(null);
    }
  };

  const inputStyle = {
    width: '100%', padding: '0.5rem 0.75rem', border: '1px solid #d1d5db',
    borderRadius: '6px', fontSize: '0.9rem', boxSizing: 'border-box',
  };
  const labelStyle = {
    display: 'block', fontSize: '0.8rem', fontWeight: 600,
    color: '#374151', marginBottom: '0.25rem',
  };

  const allCats = [...globalCategories, ...customCategories];
  const selectedCat = allCats.find(c => c.id === form.blog_cat_id);

  return (
    <div style={{ background: '#fff', borderRadius: '10px', border: '1px solid #e5e7eb', padding: '1.5rem' }}>
      <h2 style={{ margin: '0 0 1.25rem', fontSize: '1.1rem', fontWeight: 700, color: '#111827' }}>
        {post ? 'Edit Post' : 'New Blog Post'}
      </h2>

      {error && <div style={{ background: '#fef2f2', color: '#C0382B', padding: '0.5rem 0.75rem', borderRadius: '6px', marginBottom: '1rem', fontSize: '0.85rem' }}>{error}</div>}

      <div style={{ display: 'grid', gap: '1rem' }}>

        {/* Title */}
        <div>
          <label style={labelStyle}>Title</label>
          <input style={inputStyle} value={form.title}
            onChange={e => set('title', e.target.value)} placeholder="Post title" />
        </div>

        {/* Author row */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
          <div>
            <label style={labelStyle}>Author <span style={{ fontSize: '0.72rem', color: '#9ca3af', fontWeight: 400 }}>(optional)</span></label>
            <input style={inputStyle} value={form.author}
              onChange={e => set('author', e.target.value)} placeholder="Author name" />
          </div>
          <div>
            <label style={labelStyle}>Author Link <span style={{ fontSize: '0.72rem', color: '#9ca3af', fontWeight: 400 }}>(optional)</span></label>
            <input style={inputStyle} value={form.author_link}
              onChange={e => set('author_link', e.target.value)} placeholder="https://..." />
          </div>
        </div>

        {/* Categories + Cover Image — 3 columns */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '1rem' }}>

          {/* Public category */}
          <div>
            <label style={labelStyle}>Public Category</label>
            <select
              style={inputStyle}
              value={form.blog_cat_id ?? ''}
              onChange={e => set('blog_cat_id', e.target.value ? Number(e.target.value) : null)}
            >
              <option value="">— Select —</option>
              {globalCategories.map(c => (
                <option key={c.id} value={c.id}>{c.name}</option>
              ))}
            </select>
            <p style={{ margin: '0.25rem 0 0', fontSize: '0.72rem', color: '#9ca3af' }}>
              Shown network-wide in directory &amp; search
            </p>
          </div>

          {/* Personal category */}
          <div>
            <label style={labelStyle}>Personal Category <span style={{ fontSize: '0.72rem', color: '#9ca3af', fontWeight: 400 }}>(optional)</span></label>

            {/* Dropdown of existing custom cats */}
            <select
              style={inputStyle}
              value={form.custom_cat_id ?? ''}
              onChange={e => set('custom_cat_id', e.target.value ? Number(e.target.value) : null)}
            >
              <option value="">— None —</option>
              {customCategories.map(c => (
                <option key={c.id} value={c.id}>{c.name}</option>
              ))}
            </select>
            <p style={{ margin: '0.25rem 0 0', fontSize: '0.72rem', color: '#9ca3af' }}>
              Shown on your website &amp; directory listing
            </p>

            {/* Inline add / remove custom categories */}
            <div style={{ marginTop: '0.5rem', padding: '0.55rem 0.65rem', background: '#f9fafb', borderRadius: '6px', border: '1px solid #e5e7eb' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: customCategories.length > 0 || showNewCat ? '0.4rem' : 0 }}>
                <span style={{ fontSize: '0.7rem', fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: '0.04em' }}>Manage</span>
                {!showNewCat && (
                  <button type="button" onClick={() => { setShowNewCat(true); setCatError(''); }}
                    style={{ fontSize: '0.72rem', color: '#819360', background: 'none', border: 'none', cursor: 'pointer', fontWeight: 600, padding: 0 }}>
                    + New
                  </button>
                )}
              </div>

              {customCategories.length > 0 && !showNewCat && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem' }}>
                  {customCategories.map(c => (
                    <div key={c.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                      <span style={{ fontSize: '0.75rem', color: '#374151' }}>{c.name}</span>
                      <button type="button" onClick={() => handleRemoveCategory(c)} disabled={removingCat === c.id}
                        style={{ background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.7rem', color: '#C0382B', padding: 0 }}>
                        Remove
                      </button>
                    </div>
                  ))}
                </div>
              )}

              {customCategories.length === 0 && !showNewCat && (
                <p style={{ margin: 0, fontSize: '0.72rem', color: '#9ca3af' }}>No personal categories yet.</p>
              )}

              {showNewCat && (
                <div>
                  <div style={{ display: 'flex', gap: '0.3rem' }}>
                    <input autoFocus
                      style={{ flex: 1, padding: '0.25rem 0.4rem', border: '1px solid #d1d5db', borderRadius: '4px', fontSize: '0.8rem' }}
                      value={newCatName}
                      onChange={e => setNewCatName(e.target.value)}
                      onKeyDown={e => {
                        if (e.key === 'Enter') handleAddCategory();
                        if (e.key === 'Escape') { setShowNewCat(false); setNewCatName(''); }
                      }}
                      placeholder="Category name"
                    />
                    <button type="button" onClick={handleAddCategory} disabled={catSaving || !newCatName.trim()}
                      style={{ background: '#819360', color: '#fff', border: 'none', borderRadius: '4px', padding: '0.25rem 0.5rem', fontSize: '0.75rem', fontWeight: 600, cursor: 'pointer' }}>
                      {catSaving ? '…' : 'Add'}
                    </button>
                    <button type="button" onClick={() => { setShowNewCat(false); setNewCatName(''); setCatError(''); }}
                      style={{ background: '#f3f4f6', color: '#6b7280', border: '1px solid #d1d5db', borderRadius: '4px', padding: '0.25rem 0.4rem', fontSize: '0.75rem', cursor: 'pointer' }}>
                      ✕
                    </button>
                  </div>
                  {catError && <p style={{ margin: '0.2rem 0 0', fontSize: '0.72rem', color: '#C0382B' }}>{catError}</p>}
                </div>
              )}
            </div>
          </div>

          {/* Cover image */}
          <div>
            <label style={labelStyle}>Cover Image URL <span style={{ fontSize: '0.72rem', color: '#9ca3af', fontWeight: 400 }}>(optional)</span></label>
            <input style={inputStyle} value={form.cover_image}
              onChange={e => set('cover_image', e.target.value)} placeholder="https://..." />
          </div>
        </div>

        {/* Content */}
        <div>
          <label style={labelStyle}>Content</label>
          <textarea
            style={{ ...inputStyle, minHeight: '300px', resize: 'vertical', fontFamily: 'inherit', lineHeight: 1.6 }}
            value={form.content}
            onChange={e => set('content', e.target.value)}
            placeholder="Write your blog post here..."
          />
        </div>

        {/* Flags */}
        <div style={{ display: 'flex', gap: '1.5rem' }}>
          <label style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', fontSize: '0.9rem', color: '#374151', cursor: 'pointer' }}>
            <input type="checkbox" checked={form.is_published}
              onChange={e => set('is_published', e.target.checked)}
              style={{ width: '16px', height: '16px', cursor: 'pointer' }} />
            Published (visible to public)
          </label>
          <label style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', fontSize: '0.9rem', color: '#374151', cursor: 'pointer' }}>
            <input type="checkbox" checked={form.is_featured}
              onChange={e => set('is_featured', e.target.checked)}
              style={{ width: '16px', height: '16px', cursor: 'pointer' }} />
            Featured post
          </label>
        </div>
      </div>

      <div style={{ display: 'flex', gap: '0.75rem', marginTop: '1.25rem' }}>
        <button onClick={handleSave} disabled={saving}
          style={{ background: '#819360', color: '#fff', border: 'none', borderRadius: '6px', padding: '0.5rem 1.25rem', fontSize: '0.9rem', fontWeight: 600, cursor: saving ? 'not-allowed' : 'pointer', opacity: saving ? 0.7 : 1 }}>
          {saving ? 'Saving...' : 'Save Post'}
        </button>
        <button onClick={onCancel}
          style={{ background: '#f3f4f6', color: '#374151', border: '1px solid #d1d5db', borderRadius: '6px', padding: '0.5rem 1.25rem', fontSize: '0.9rem', cursor: 'pointer' }}>
          Cancel
        </button>
      </div>
    </div>
  );
}

// ── CategoriesTab ───────────────────────────────────────────────
function CategoriesTab({ businessId, globalCategories, customCategories, onCustomCategoriesChange }) {
  const [newName, setNewName] = useState('');
  const [adding, setAdding] = useState(false);
  const [deleting, setDeleting] = useState(null);
  const [error, setError] = useState('');

  const handleAdd = async () => {
    const name = newName.trim();
    if (!name) return;
    setAdding(true);
    setError('');
    try {
      const res = await fetch(`${API_URL}/api/blog/categories/custom?business_id=${businessId}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name }),
      });
      if (res.status === 409) { setError('That category already exists.'); return; }
      if (!res.ok) throw new Error();
      const created = await res.json();
      onCustomCategoriesChange([...customCategories, created]);
      setNewName('');
    } catch {
      setError('Failed to add category.');
    } finally {
      setAdding(false);
    }
  };

  const handleDelete = async (cat) => {
    if (!window.confirm(`Remove "${cat.name}"?`)) return;
    setDeleting(cat.id);
    try {
      await fetch(`${API_URL}/api/blog/categories/custom/${cat.id}?business_id=${businessId}`,
        { method: 'DELETE' });
      onCustomCategoriesChange(customCategories.filter(c => c.id !== cat.id));
    } finally {
      setDeleting(null);
    }
  };

  const inputStyle = { padding: '0.45rem 0.75rem', border: '1px solid #d1d5db', borderRadius: '6px', fontSize: '0.9rem', flex: 1 };

  return (
    <div style={{ display: 'grid', gap: '1.5rem', maxWidth: '700px' }}>
      {/* Global */}
      <div style={{ background: '#fff', borderRadius: '10px', border: '1px solid #e5e7eb', padding: '1.25rem' }}>
        <h3 style={{ margin: '0 0 0.4rem', fontSize: '0.95rem', fontWeight: 700, color: '#111827' }}>Global Categories</h3>
        <p style={{ margin: '0 0 0.9rem', fontSize: '0.82rem', color: '#6b7280' }}>
          Network-wide categories available to all businesses.
        </p>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.4rem' }}>
          {globalCategories.map(c => (
            <span key={c.id} style={{ fontSize: '0.78rem', padding: '3px 10px', borderRadius: '12px', background: '#f0fdf4', color: '#166534', border: '1px solid #bbf7d0', fontWeight: 500 }}>
              {c.name}
            </span>
          ))}
        </div>
      </div>

      {/* Custom */}
      <div style={{ background: '#fff', borderRadius: '10px', border: '1px solid #e5e7eb', padding: '1.25rem' }}>
        <h3 style={{ margin: '0 0 0.4rem', fontSize: '0.95rem', fontWeight: 700, color: '#111827' }}>My Categories</h3>
        <p style={{ margin: '0 0 0.9rem', fontSize: '0.82rem', color: '#6b7280' }}>
          Custom categories that appear only on your website and directory listing.
        </p>
        {error && <div style={{ background: '#fef2f2', color: '#C0382B', padding: '0.4rem 0.75rem', borderRadius: '6px', marginBottom: '0.75rem', fontSize: '0.82rem' }}>{error}</div>}
        <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1rem' }}>
          <input style={inputStyle} value={newName} onChange={e => setNewName(e.target.value)}
            onKeyDown={e => e.key === 'Enter' && handleAdd()} placeholder="New category name..." />
          <button onClick={handleAdd} disabled={adding || !newName.trim()}
            style={{ background: '#819360', color: '#fff', border: 'none', borderRadius: '6px', padding: '0.45rem 1rem', fontSize: '0.88rem', fontWeight: 600, cursor: 'pointer', opacity: adding ? 0.7 : 1, whiteSpace: 'nowrap' }}>
            + Add
          </button>
        </div>
        {customCategories.length === 0
          ? <p style={{ fontSize: '0.85rem', color: '#9ca3af', margin: 0 }}>No custom categories yet.</p>
          : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
              {customCategories.map(c => (
                <div key={c.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '0.4rem 0.75rem', background: '#f9fafb', borderRadius: '6px', border: '1px solid #e5e7eb' }}>
                  <span style={{ fontSize: '0.88rem', color: '#374151' }}>{c.name}</span>
                  <button onClick={() => handleDelete(c)} disabled={deleting === c.id}
                    style={{ background: '#C0382B', color: '#fff', border: 'none', borderRadius: '4px', padding: '2px 9px', fontSize: '0.75rem', cursor: 'pointer', opacity: deleting === c.id ? 0.6 : 1 }}>
                    Remove
                  </button>
                </div>
              ))}
            </div>
          )
        }
      </div>
    </div>
  );
}

// ── BlogManage (main) ───────────────────────────────────────────
export default function BlogManage() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [view, setView] = useState('list');          // list | new | edit
  const [activeTab, setActiveTab] = useState('posts'); // posts | categories
  const [editPost, setEditPost] = useState(null);
  const [deleting, setDeleting] = useState(null);
  const [globalCategories, setGlobalCategories] = useState([]);
  const [customCategories, setCustomCategories] = useState([]);

  useEffect(() => { if (BusinessID) LoadBusiness(BusinessID); }, [BusinessID]);

  const loadCategories = async () => {
    const [g, c] = await Promise.all([
      fetch(`${API_URL}/api/blog/categories/global`).then(r => r.json()).catch(() => []),
      fetch(`${API_URL}/api/blog/categories/custom?business_id=${BusinessID}`).then(r => r.json()).catch(() => []),
    ]);
    setGlobalCategories(Array.isArray(g) ? g : []);
    setCustomCategories(Array.isArray(c) ? c : []);
  };

  const load = () => {
    setLoading(true);
    fetch(`${API_URL}/api/blog/manage?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : [])
      .then(data => setPosts(Array.isArray(data) ? data : []))
      .catch(() => setPosts([]))
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    if (BusinessID) { load(); loadCategories(); }
  }, [BusinessID]);

  const handleDelete = async (blogId) => {
    if (!window.confirm('Delete this post?')) return;
    setDeleting(blogId);
    try {
      await fetch(`${API_URL}/api/blog/manage/${blogId}?business_id=${BusinessID}`, { method: 'DELETE' });
      load();
    } finally { setDeleting(null); }
  };

  const handleSaved = () => { setView('list'); setEditPost(null); load(); };

  const formatDate = (dt) => {
    if (!dt) return '';
    return new Date(dt).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
  };

  const allCats = [...globalCategories, ...customCategories];
  const catName = (id) => allCats.find(c => c.id === id)?.name || '';

  const tabStyle = (tab) => ({
    padding: '0.45rem 1.1rem', fontSize: '0.88rem', fontWeight: 600,
    border: 'none', borderRadius: '7px', cursor: 'pointer',
    background: activeTab === tab ? '#819360' : '#f3f4f6',
    color: activeTab === tab ? '#fff' : '#374151',
  });

  if (view === 'new' || view === 'edit') {
    return (
      <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
        <div style={{ maxWidth: '800px' }}>
          <button onClick={() => { setView('list'); setEditPost(null); }}
            style={{ background: 'none', border: 'none', color: '#819360', cursor: 'pointer', fontSize: '0.85rem', marginBottom: '1rem', padding: 0 }}>
            ← Back to Posts
          </button>
          <PostEditor
            post={editPost}
            businessId={BusinessID}
            globalCategories={globalCategories}
            customCategories={customCategories}
            onCustomCategoriesChange={setCustomCategories}
            onSave={handleSaved}
            onCancel={() => { setView('list'); setEditPost(null); }}
          />
        </div>
      </AccountLayout>
    );
  }

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div style={{ maxWidth: '900px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem' }}>
          <div>
            <h1 style={{ margin: 0, fontSize: '1.4rem', fontWeight: 700, color: '#111827' }}>Blog</h1>
            <p style={{ margin: '0.25rem 0 0', fontSize: '0.85rem', color: '#6b7280' }}>Manage your farm's blog content</p>
          </div>
          {activeTab === 'posts' && (
            <button onClick={() => { setEditPost(null); setView('new'); }}
              style={{ background: '#819360', color: '#fff', border: 'none', borderRadius: '8px', padding: '0.5rem 1.1rem', fontSize: '0.9rem', fontWeight: 600, cursor: 'pointer' }}>
              + New Post
            </button>
          )}
        </div>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1.25rem' }}>
          <button style={tabStyle('posts')} onClick={() => setActiveTab('posts')}>Posts</button>
          <button style={tabStyle('categories')} onClick={() => setActiveTab('categories')}>Categories</button>
        </div>

        {activeTab === 'categories' && (
          <CategoriesTab
            businessId={BusinessID}
            globalCategories={globalCategories}
            customCategories={customCategories}
            onCustomCategoriesChange={setCustomCategories}
          />
        )}

        {activeTab === 'posts' && (
          <>
            {loading && <p style={{ color: '#9ca3af', fontSize: '0.9rem' }}>Loading posts...</p>}

            {!loading && posts.length === 0 && (
              <div style={{ textAlign: 'center', padding: '3rem', background: '#fff', borderRadius: '10px', border: '1px solid #e5e7eb' }}>
                <p style={{ color: '#9ca3af', marginBottom: '1rem' }}>No blog posts yet.</p>
                <button onClick={() => { setEditPost(null); setView('new'); }}
                  style={{ background: '#819360', color: '#fff', border: 'none', borderRadius: '8px', padding: '0.5rem 1.1rem', fontSize: '0.9rem', fontWeight: 600, cursor: 'pointer' }}>
                  Write Your First Post
                </button>
              </div>
            )}

            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
              {posts.map(post => (
                <div key={post.blog_id} style={{ background: '#fff', borderRadius: '10px', border: '1px solid #e5e7eb', padding: '1rem 1.25rem', display: 'flex', alignItems: 'flex-start', gap: '1rem' }}>
                  {post.cover_image && (
                    <img src={post.cover_image} alt="" style={{ width: '72px', height: '54px', objectFit: 'cover', borderRadius: '6px', flexShrink: 0 }}
                      onError={e => e.target.style.display = 'none'} />
                  )}
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap' }}>
                      <h3 style={{ margin: 0, fontSize: '0.95rem', fontWeight: 600, color: '#111827' }}>{post.title}</h3>
                      <span style={{ fontSize: '0.7rem', fontWeight: 600, padding: '1px 7px', borderRadius: '10px', background: post.is_published ? '#dcfce7' : '#f3f4f6', color: post.is_published ? '#16a34a' : '#6b7280' }}>
                        {post.is_published ? 'Published' : 'Draft'}
                      </span>
                      {post.is_featured && (
                        <span style={{ fontSize: '0.7rem', fontWeight: 600, padding: '1px 7px', borderRadius: '10px', background: '#fef9c3', color: '#854d0e' }}>Featured</span>
                      )}
                      {post.category_name && (
                        <span style={{ fontSize: '0.7rem', padding: '1px 7px', borderRadius: '10px', background: '#f0fdf4', color: '#166534', border: '1px solid #bbf7d0' }}>
                          {post.category_name}
                        </span>
                      )}
                      {post.custom_category_name && (
                        <span style={{ fontSize: '0.7rem', padding: '1px 7px', borderRadius: '10px', background: '#ede9fe', color: '#5b21b6', border: '1px solid #ddd6fe' }}>
                          {post.custom_category_name}
                        </span>
                      )}
                    </div>
                    {post.content && (
                      <p style={{ margin: '0.3rem 0 0', fontSize: '0.82rem', color: '#6b7280', overflow: 'hidden', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical' }}>
                        {getExcerpt(post.content)}
                      </p>
                    )}
                    <p style={{ margin: '0.25rem 0 0', fontSize: '0.75rem', color: '#9ca3af' }}>
                      {post.author && <span>{post.author} · </span>}
                      {formatDate(post.created_at)}
                    </p>
                  </div>
                  <div style={{ display: 'flex', gap: '0.5rem', flexShrink: 0 }}>
                    {post.is_published && (
                      <Link to={`/blog/${post.blog_id}`} target="_blank"
                        style={{ fontSize: '0.8rem', color: '#819360', textDecoration: 'none', padding: '0.3rem 0.6rem', border: '1px solid #819360', borderRadius: '6px' }}>
                        View ↗
                      </Link>
                    )}
                    <button onClick={() => { setEditPost(post); setView('edit'); }}
                      style={{ fontSize: '0.8rem', background: '#f3f4f6', border: '1px solid #d1d5db', borderRadius: '6px', padding: '0.3rem 0.6rem', cursor: 'pointer', color: '#374151' }}>
                      Edit
                    </button>
                    <button onClick={() => handleDelete(post.blog_id)} disabled={deleting === post.blog_id}
                      style={{ fontSize: '0.8rem', background: '#C0382B', border: 'none', borderRadius: '6px', padding: '0.3rem 0.6rem', cursor: 'pointer', color: '#fff', opacity: deleting === post.blog_id ? 0.6 : 1 }}>
                      Delete
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </div>
    </AccountLayout>
  );
}
