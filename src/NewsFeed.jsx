// src/NewsFeed.jsx
import React, { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import PageMeta from './PageMeta';
import './NewsFeed.css';

const CATEGORIES = ['All', 'Markets', 'Weather', 'Policy', 'AgTech', 'Livestock', 'General'];

const CATEGORY_IMAGES = {
  Markets: '/images/news/news-markets.svg',
  Weather: '/images/news/news-weather.svg',
  Policy: '/images/news/news-policy.svg',
  AgTech: '/images/news/news-agtech.svg',
  Livestock: '/images/news/news-livestock.svg',
  General: '/images/news/news-general.svg',
};

const API = import.meta.env.VITE_NEWS_API_URL || import.meta.env.VITE_API_URL || '';

const NewsFeed = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [articles, setArticles] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [query, setQuery] = useState('');
  const [category, setCategory] = useState('All');
  const [sort, setSort] = useState('Newest');
  const [syncing, setSyncing] = useState(false);
  const [syncStatus, setSyncStatus] = useState(null);
  const [prefsOpen, setPrefsOpen] = useState(false);
  const [prefs, setPrefs] = useState({ categories: [], emailFrequency: 'off', preferredHour: 7 });
  const [prefsSaving, setPrefsSaving] = useState(false);
  const [prefsMsg, setPrefsMsg] = useState('');

  const peopleId = localStorage.getItem('people_id') || '';
  const accessLevel = parseInt(localStorage.getItem('access_level') || '0');
  const isSignedIn = !!peopleId;
  const isAdmin = accessLevel > 2;

  const authHeaders = () => {
    const h = { 'Content-Type': 'application/json' };
    if (peopleId) h['x-people-id'] = peopleId;
    if (accessLevel) h['x-access-level'] = String(accessLevel);
    return h;
  };

  useEffect(() => {
    const fetchNews = async () => {
      setLoading(true);
      setError('');
      try {
        const response = await fetch(`${API}/api/news`);
        if (!response.ok) throw new Error('Failed to fetch news');
        const data = await response.json();
        setArticles(data.articles || []);
      } catch (err) {
        console.error('News fetch error:', err);
        setError(t('news.error'));
      } finally {
        setLoading(false);
      }
    };
    fetchNews();

    fetch(`${API}/api/news/sync/status`).then(r => r.json()).then(setSyncStatus).catch(() => {});
  }, []);

  const openPrefs = async () => {
    setPrefsOpen(true);
    setPrefsMsg('');
    if (!isSignedIn) return;
    try {
      const r = await fetch(`${API}/api/news/prefs/me`, { headers: authHeaders() });
      if (r.ok) {
        const data = await r.json();
        setPrefs({
          categories: Array.isArray(data.categories) ? data.categories : [],
          emailFrequency: data.emailFrequency || 'off',
          preferredHour: typeof data.preferredHour === 'number' ? data.preferredHour : 7,
          lastSentAt: data.lastSentAt,
        });
      }
    } catch {}
  };

  const savePrefs = async () => {
    setPrefsSaving(true);
    setPrefsMsg('');
    try {
      const r = await fetch(`${API}/api/news/prefs/me`, {
        method: 'PUT',
        headers: authHeaders(),
        body: JSON.stringify(prefs),
      });
      if (!r.ok) throw new Error('Save failed');
      setPrefsMsg(t('news.prefs_saved_msg'));
    } catch {
      setPrefsMsg(t('news.prefs_error_msg'));
    } finally {
      setPrefsSaving(false);
    }
  };

  const sendPreview = async () => {
    setPrefsSaving(true);
    setPrefsMsg('');
    try {
      const r = await fetch(`${API}/api/news/digest/send-now`, {
        method: 'POST',
        headers: authHeaders(),
      });
      const data = await r.json();
      if (!r.ok) throw new Error(data.detail || 'Failed');
      setPrefsMsg(t('news.preview_sent', { to: data.to }));
    } catch (err) {
      setPrefsMsg(err.message || t('news.prefs_error_msg'));
    } finally {
      setPrefsSaving(false);
    }
  };

  const toggleCategory = (cat) => {
    setPrefs(p => ({
      ...p,
      categories: p.categories.includes(cat)
        ? p.categories.filter(c => c !== cat)
        : [...p.categories, cat],
    }));
  };

  const handleSync = async () => {
    setSyncing(true);
    try {
      await fetch(`${API}/api/news/sync`, { method: 'POST' });
      const response = await fetch(`${API}/api/news`);
      const data = await response.json();
      setArticles(data.articles || []);
      const status = await fetch(`${API}/api/news/sync/status`).then(r => r.json());
      setSyncStatus(status);
    } catch {} finally { setSyncing(false); }
  };

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
    if (diffHours < 1) return t('news.just_now');
    if (diffHours < 24) return t('news.hours_ago', { h: diffHours });
    if (diffDays < 7) return t('news.days_ago', { d: diffDays });
    return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
  };

  const getCategoryColor = (cat) => {
    const colors = {
      Markets: '#2563eb', Weather: '#0891b2', Policy: '#7c3aed',
      AgTech: '#059669', Livestock: '#b45309', General: '#6b7280',
    };
    return colors[cat] || '#6b7280';
  };

  const getArticleImage = (article) => {
    const img = article.image?.trim();
    if (img) return img;
    return article.placeholderImage || CATEGORY_IMAGES[article.category] || CATEGORY_IMAGES.General;
  };

  return (
    <div className="news-page">
      <PageMeta
        title="Agricultural News & Farm Market Updates"
        description="Stay current with agricultural news covering markets, weather, policy, AgTech, and livestock. Curated daily for farmers, ranchers, and food producers."
        keywords="farm news, agricultural news, commodity markets, farm policy, AgTech news, livestock news, weather alerts, crop markets"
        canonical="https://oatmealfarmnetwork.com/app/news"
        image="https://oatmealfarmnetwork.com/images/NewsroomBanner.webp"
        imageAlt="Oatmeal Farm Network Newsroom"
        jsonLd={[
          {
            '@context': 'https://schema.org',
            '@type': 'CollectionPage',
            name: 'Agricultural News & Farm Market Updates',
            description: 'Curated agricultural news for farmers, ranchers, and food producers.',
            url: 'https://oatmealfarmnetwork.com/app/news',
          },
          articles.length > 0 ? {
            '@context': 'https://schema.org',
            '@type': 'ItemList',
            url: 'https://oatmealfarmnetwork.com/app/news',
            itemListElement: articles.slice(0, 10).map((a, i) => ({
              '@type': 'ListItem',
              position: i + 1,
              url: `https://oatmealfarmnetwork.com/app/news/${a.id}`,
              name: a.title,
            })),
          } : null,
        ].filter(Boolean)}
      />
      {/* Hero — matches Saige/Thaiyme/Rosemarie pattern */}
      <div className="mx-auto px-4 pt-2" style={{ maxWidth: '1300px' }}>
        <div className="relative w-full overflow-hidden rounded-xl">
          <img
            src="/images/NewsroomBanner.webp"
            alt="Agriculture News"
            className="w-full object-cover"
            style={{ height: '260px', display: 'block' }}
            loading="eager"
            fetchPriority="high"
            width="1300"
            height="260"
            onError={e => { e.target.onerror = null; e.target.style.display = 'none'; }}
          />
          <div
            className="absolute inset-0"
            style={{ background: 'linear-gradient(to right, rgba(10,30,10,0.92) 0%, rgba(10,30,10,0.75) 45%, rgba(10,30,10,0) 78%)' }}
          />
          <div className="absolute inset-0 flex flex-col justify-center px-8 py-6" style={{ maxWidth: '720px' }}>
            <span className="text-xs font-bold uppercase tracking-widest mb-3" style={{ color: 'rgba(255,255,255,0.85)' }}>
              Oatmeal Farm Network
            </span>
            <h1 style={{ color: '#ffffff', fontFamily: "'Lora','Times New Roman',serif", fontSize: '2rem', fontWeight: 'bold', margin: '0 0 10px', lineHeight: 1.2 }}>
              {t('news.header_title')}
            </h1>
            <p style={{ color: 'rgba(255,255,255,0.9)', fontSize: '0.92rem', margin: '0 0 16px', lineHeight: 1.6 }}>
              {t('news.header_body')}
            </p>
            <div className="flex flex-wrap gap-3">
              {isSignedIn ? (
                <button
                  onClick={openPrefs}
                  className="border-2 font-bold px-5 py-2.5 rounded-lg transition text-sm hover:bg-white/10"
                  style={{ borderColor: '#ffffff', color: '#ffffff', background: 'transparent', cursor: 'pointer' }}
                >
                  {t('news.prefs_btn')}
                </button>
              ) : (
                <button
                  onClick={() => navigate('/login')}
                  className="border-2 font-bold px-5 py-2.5 rounded-lg transition text-sm hover:bg-white/10"
                  style={{ borderColor: '#ffffff', color: '#ffffff', background: 'transparent', cursor: 'pointer' }}
                >
                  {t('news.signin_btn')}
                </button>
              )}
            </div>
            {syncStatus?.lastSync && isAdmin && (
              <div style={{ fontSize: '0.7rem', color: 'rgba(255,255,255,0.55)', marginTop: '0.5rem' }}>
                {t('news.last_synced')} {new Date(syncStatus.lastSync).toLocaleString()} · {syncStatus.articleCount} articles
                <button onClick={handleSync} disabled={syncing}
                  style={{ marginLeft: '0.5rem', fontSize: '0.7rem', padding: '1px 6px', backgroundColor: 'rgba(255,255,255,0.15)', border: '1px solid rgba(255,255,255,0.3)', borderRadius: '4px', color: '#fff', cursor: 'pointer' }}>
                  {syncing ? t('news.syncing') : t('news.sync_now')}
                </button>
              </div>
            )}
          </div>
        </div>
      </div>

      <section className="news-controls">
        <div className="news-controls-row">
          <input className="news-input" placeholder={t('news.search_placeholder')} value={query} onChange={(e) => setQuery(e.target.value)} />
          <select className="news-input" value={category} onChange={(e) => setCategory(e.target.value)}>
            {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
          </select>
          <select className="news-input" value={sort} onChange={(e) => setSort(e.target.value)}>
            <option value="Newest">{t('news.sort_newest')}</option>
            <option value="Oldest">{t('news.sort_oldest')}</option>
          </select>
        </div>
      </section>

      <section className="news-grid">
        {loading && <div className="news-empty"><p>{t('news.loading')}</p></div>}
        {error && <div className="news-empty" style={{ color: '#b91c1c' }}><p>{error}</p></div>}
        {!loading && !error && filtered.length === 0 && <div className="news-empty">{t('news.no_articles')}</div>}

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '1rem' }}>
          {filtered.map((a, i) => (
            <div key={`${a.id}-${i}`} onClick={() => navigate(`/app/news/${a.id}`)}
              style={{ cursor: 'pointer', borderRadius: '8px', overflow: 'hidden', backgroundColor: '#fff', border: '1px solid #e5e7eb', transition: 'box-shadow 0.2s' }}
              onMouseEnter={(e) => e.currentTarget.style.boxShadow = '0 4px 12px rgba(0,0,0,0.1)'}
              onMouseLeave={(e) => e.currentTarget.style.boxShadow = 'none'}>
              <div style={{ position: 'relative', overflow: 'hidden', margin: 0, lineHeight: 0 }}>
                <img src={getArticleImage(a)} alt={a.title}
                  style={{ width: '100%', height: '120px', objectFit: 'cover', display: 'block', margin: 0 }}
                  onError={(e) => {
                    const img = e.target;
                    const fallback = CATEGORY_IMAGES[a.category] || CATEGORY_IMAGES.General;
                    if (img.src !== fallback) img.src = fallback;
                  }} />
                <span style={{ position: 'absolute', top: '0.4rem', left: '0.4rem', backgroundColor: getCategoryColor(a.category), color: '#fff', fontSize: '0.6rem', fontWeight: 600, paddingTop: '1px', paddingBottom: '1px', paddingLeft: '6px', paddingRight: '6px', borderRadius: '3px', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                  {a.category}
                </span>
              </div>
              <div style={{ paddingTop: '0.5rem', paddingBottom: '0.6rem', paddingLeft: '0.75rem', paddingRight: '0.75rem', margin: 0 }}>
                <h3 style={{ fontSize: '0.85rem', fontWeight: 600, lineHeight: 1.3, margin: '0 0 0.3rem', color: '#111827', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                  {a.title}
                </h3>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '0.7rem', color: '#9ca3af', margin: 0 }}>
                  <span>{a.source}</span>
                  <span>{formatDate(a.pubDate)}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      {prefsOpen && (
        <div
          onClick={() => setPrefsOpen(false)}
          style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.45)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: '1rem' }}
        >
          <div
            onClick={(e) => e.stopPropagation()}
            style={{ background: '#fff', borderRadius: '12px', maxWidth: '520px', width: '100%', maxHeight: '90vh', overflowY: 'auto', padding: '1.75rem', boxShadow: '0 20px 60px rgba(0,0,0,0.25)' }}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
              <h2 style={{ margin: 0, fontSize: '1.35rem', color: '#111827' }}>{t('news.prefs_title')}</h2>
              <button onClick={() => setPrefsOpen(false)} style={{ background: 'none', border: 'none', fontSize: '1.5rem', color: '#9ca3af', cursor: 'pointer', lineHeight: 1 }}>×</button>
            </div>

            {!isSignedIn ? (
              <div>
                <p style={{ color: '#4b5563', lineHeight: 1.6 }}>{t('news.prefs_signin_body')}</p>
                <button
                  onClick={() => navigate('/login')}
                  style={{ marginTop: '0.5rem', padding: '0.6rem 1.5rem', backgroundColor: '#819360', color: '#fff', border: 'none', borderRadius: '8px', cursor: 'pointer', fontSize: '0.9rem', fontWeight: 600 }}
                >
                  {t('news.prefs_signin_btn')}
                </button>
              </div>
            ) : (
              <>
                <div style={{ marginBottom: '1.25rem' }}>
                  <label style={{ display: 'block', fontWeight: 600, color: '#111827', marginBottom: '0.5rem', fontSize: '0.9rem' }}>
                    {t('news.prefs_categories_label')}
                  </label>
                  <p style={{ margin: '0 0 0.6rem', color: '#6b7280', fontSize: '0.8rem' }}>
                    {t('news.prefs_categories_hint')}
                  </p>
                  <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.4rem' }}>
                    {CATEGORIES.filter(c => c !== 'All').map(c => {
                      const on = prefs.categories.includes(c);
                      return (
                        <button
                          key={c}
                          onClick={() => toggleCategory(c)}
                          style={{
                            padding: '0.35rem 0.85rem',
                            fontSize: '0.8rem',
                            fontWeight: 600,
                            border: `1px solid ${on ? '#819360' : '#d1d5db'}`,
                            backgroundColor: on ? '#819360' : '#fff',
                            color: on ? '#fff' : '#4b5563',
                            borderRadius: '999px',
                            cursor: 'pointer',
                          }}
                        >
                          {c}
                        </button>
                      );
                    })}
                  </div>
                </div>

                <div style={{ marginBottom: '1.25rem' }}>
                  <label style={{ display: 'block', fontWeight: 600, color: '#111827', marginBottom: '0.5rem', fontSize: '0.9rem' }}>
                    {t('news.prefs_digest_label')}
                  </label>
                  <select
                    value={prefs.emailFrequency}
                    onChange={(e) => setPrefs(p => ({ ...p, emailFrequency: e.target.value }))}
                    style={{ width: '100%', padding: '0.5rem 0.75rem', fontSize: '0.9rem', border: '1px solid #d1d5db', borderRadius: '6px', background: '#fff' }}
                  >
                    <option value="off">{t('news.digest_off')}</option>
                    <option value="daily">{t('news.digest_daily')}</option>
                    <option value="weekly">{t('news.digest_weekly')}</option>
                  </select>
                </div>

                {prefs.emailFrequency !== 'off' && (
                  <div style={{ marginBottom: '1.25rem' }}>
                    <label style={{ display: 'block', fontWeight: 600, color: '#111827', marginBottom: '0.5rem', fontSize: '0.9rem' }}>
                      {t('news.prefs_hour_label')}
                    </label>
                    <select
                      value={prefs.preferredHour}
                      onChange={(e) => setPrefs(p => ({ ...p, preferredHour: parseInt(e.target.value) }))}
                      style={{ width: '100%', padding: '0.5rem 0.75rem', fontSize: '0.9rem', border: '1px solid #d1d5db', borderRadius: '6px', background: '#fff' }}
                    >
                      {Array.from({ length: 24 }, (_, h) => (
                        <option key={h} value={h}>{String(h).padStart(2, '0')}:00 UTC</option>
                      ))}
                    </select>
                  </div>
                )}

                {prefs.lastSentAt && (
                  <div style={{ fontSize: '0.75rem', color: '#9ca3af', marginBottom: '1rem' }}>
                    {t('news.last_digest_sent')} {new Date(prefs.lastSentAt).toLocaleString()}
                  </div>
                )}

                {prefsMsg && (
                  <div style={{ fontSize: '0.8rem', color: prefsMsg.startsWith('Could') || prefsMsg.startsWith('Failed') ? '#b91c1c' : '#047857', marginBottom: '0.75rem' }}>
                    {prefsMsg}
                  </div>
                )}

                <div style={{ display: 'flex', gap: '0.5rem', justifyContent: 'flex-end', flexWrap: 'wrap' }}>
                  {prefs.emailFrequency !== 'off' && (
                    <button
                      onClick={sendPreview}
                      disabled={prefsSaving}
                      style={{ padding: '0.55rem 1.1rem', fontSize: '0.85rem', fontWeight: 600, border: '1px solid #819360', backgroundColor: '#fff', color: '#819360', borderRadius: '6px', cursor: 'pointer' }}
                    >
                      {t('news.prefs_preview')}
                    </button>
                  )}
                  <button
                    onClick={() => setPrefsOpen(false)}
                    style={{ padding: '0.55rem 1.1rem', fontSize: '0.85rem', fontWeight: 600, border: '1px solid #d1d5db', backgroundColor: '#fff', color: '#4b5563', borderRadius: '6px', cursor: 'pointer' }}
                  >
                    {t('news.prefs_cancel')}
                  </button>
                  <button
                    onClick={savePrefs}
                    disabled={prefsSaving}
                    style={{ padding: '0.55rem 1.4rem', fontSize: '0.85rem', fontWeight: 600, border: 'none', backgroundColor: '#819360', color: '#fff', borderRadius: '6px', cursor: 'pointer' }}
                  >
                    {prefsSaving ? t('news.prefs_saving') : t('news.prefs_save')}
                  </button>
                </div>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default NewsFeed;
