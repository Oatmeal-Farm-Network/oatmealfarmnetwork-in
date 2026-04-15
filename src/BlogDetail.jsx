import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

function buildExcerpt(content, max = 160) {
  if (!content) return '';
  let text = content;
  try {
    const blocks = JSON.parse(content);
    if (Array.isArray(blocks)) {
      text = blocks.filter(b => b.type === 'text').map(b => b.content || '').join(' ');
    }
  } catch {}
  const plain = text.replace(/<[^>]*>/g, ' ').replace(/\s+/g, ' ').trim();
  return plain.length > max ? plain.slice(0, max - 1) + '…' : plain;
}

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function renderContent(content) {
  if (!content) return null;
  let blocks;
  try {
    blocks = JSON.parse(content);
    if (!Array.isArray(blocks)) throw new Error();
  } catch {
    // Legacy plain text or HTML — render as-is
    return (
      <div style={{ fontSize: '1rem', color: '#1f2937', lineHeight: 1.8, wordBreak: 'break-word' }}
        dangerouslySetInnerHTML={{ __html: content }} />
    );
  }
  return (
    <>
      {blocks.map((block, i) => {
        if (block.type === 'image') {
          return (
            <figure key={i} style={{ margin: '1.75rem 0', textAlign: block.align || 'center' }}>
              <img
                src={block.url}
                alt={block.caption || ''}
                style={{ width: block.width || '100%', maxWidth: '100%', borderRadius: 10, display: 'inline-block', objectFit: 'contain' }}
                onError={e => e.target.style.display = 'none'}
              />
              {block.caption && (
                <figcaption style={{ fontSize: '0.85rem', color: '#6b7280', marginTop: '0.4rem', fontStyle: 'italic' }}>
                  {block.caption}
                </figcaption>
              )}
            </figure>
          );
        }
        return (
          <div key={i}
            style={{ fontSize: '1rem', color: '#1f2937', lineHeight: 1.8, wordBreak: 'break-word', marginBottom: '0.5rem' }}
            dangerouslySetInnerHTML={{ __html: block.content || '' }}
          />
        );
      })}
    </>
  );
}

export default function BlogDetail() {
  const { postId } = useParams();
  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);

  useEffect(() => {
    if (!postId) return;
    setLoading(true);
    fetch(`${API_URL}/api/blog/posts/${postId}`)
      .then(r => {
        if (r.status === 404) { setNotFound(true); return null; }
        return r.json();
      })
      .then(data => { if (data) setPost(data); })
      .catch(() => setNotFound(true))
      .finally(() => setLoading(false));
  }, [postId]);

  const formatDate = (dt) => {
    if (!dt) return '';
    return new Date(dt).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });
  };

  const CATEGORY_COLORS = {
    'Farm News': '#15803d', 'Recipes': '#b45309', 'Seasonal': '#0891b2',
    'Events': '#7C5CBF', 'Education': '#1d4ed8', 'Market Updates': '#be185d',
    'Community': '#6b7280', 'General': '#6b7280',
  };
  const catColor = post ? (CATEGORY_COLORS[post.category] || '#6b7280') : '#6b7280';

  const postDesc = post ? (post.excerpt || buildExcerpt(post.content, 160)) : '';
  const postImg = post && post.cover_image
    ? (/^https?:\/\//i.test(post.cover_image) ? post.cover_image : `https://oatmealfarmnetwork.com${post.cover_image.startsWith('/') ? '' : '/'}${post.cover_image}`)
    : undefined;
  const publishedIso = post ? (() => {
    const d = post.published_at || post.created_at;
    if (!d) return undefined;
    const parsed = new Date(d);
    return isNaN(parsed.getTime()) ? undefined : parsed.toISOString();
  })() : undefined;
  const postCanonical = `https://oatmealfarmnetwork.com/blog/${postId}`;
  const postJsonLd = post ? {
    '@context': 'https://schema.org',
    '@type': 'BlogPosting',
    headline: post.title,
    description: postDesc,
    ...(postImg ? { image: postImg } : {}),
    author: { '@type': 'Person', name: post.author || post.business_name || 'Oatmeal Farm Network' },
    publisher: {
      '@type': 'Organization',
      name: 'Oatmeal Farm Network',
      logo: { '@type': 'ImageObject', url: 'https://oatmealfarmnetwork.com/images/OFN-Logo.png' },
    },
    mainEntityOfPage: { '@type': 'WebPage', '@id': postCanonical },
    ...(publishedIso ? { datePublished: publishedIso, dateModified: publishedIso } : {}),
    ...(post.category ? { articleSection: post.category } : {}),
  } : null;

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col font-sans">
      {post && (
        <PageMeta
          title={`${post.title}${post.business_name ? ' · ' + post.business_name : ''}`}
          description={postDesc}
          image={postImg}
          canonical={postCanonical}
          ogType="article"
          jsonLd={postJsonLd}
        />
      )}
      {!post && !loading && notFound && (
        <PageMeta
          title="Post Not Found"
          description="The blog post you're looking for is no longer available on Oatmeal Farm Network."
          canonical={`https://oatmealfarmnetwork.com/blog/${postId}`}
          noIndex
        />
      )}
      <Header />
      <div style={{ maxWidth: '780px', margin: '0 auto', padding: '1rem 1.5rem 2rem', flex: 1, width: '100%', boxSizing: 'border-box' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Blog', to: '/blog' },
          { label: post?.title || 'Post' },
        ]} />
        <Link to="/blog" style={{ color: '#7C5CBF', textDecoration: 'none', fontSize: '0.85rem', display: 'inline-block', marginBottom: '1.5rem' }}>
          ← Back to Blogs
        </Link>

        {loading && <p style={{ color: '#9ca3af', textAlign: 'center', padding: '3rem 0' }}>Loading...</p>}

        {notFound && !loading && (
          <div style={{ textAlign: 'center', padding: '3rem' }}>
            <h2 style={{ color: '#374151' }}>Post Not Found</h2>
            <p style={{ color: '#9ca3af' }}>This post may have been removed or is no longer published.</p>
          </div>
        )}

        {post && !loading && (
          <article>
            {post.cover_image && (
              <img
                src={post.cover_image}
                alt={post.title}
                style={{ width: '100%', maxHeight: '400px', objectFit: 'cover', borderRadius: '12px', display: 'block', marginBottom: '1.5rem' }}
                onError={e => e.target.style.display = 'none'}
              />
            )}

            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '0.75rem', flexWrap: 'wrap' }}>
              {post.category && (
                <span style={{ fontSize: '0.72rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', color: catColor, background: catColor + '18', padding: '3px 10px', borderRadius: '12px' }}>
                  {post.category}
                </span>
              )}
              <span style={{ fontSize: '0.85rem', color: '#9ca3af' }}>{formatDate(post.published_at || post.created_at)}</span>
            </div>

            <h1 style={{ margin: '0 0 1rem', fontSize: '1.75rem', fontWeight: 800, color: '#111827', lineHeight: 1.25 }}>
              {post.title}
            </h1>

            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '1.75rem', paddingBottom: '1.75rem', borderBottom: '1px solid #e5e7eb', flexWrap: 'wrap' }}>
              <span style={{ fontSize: '0.88rem', color: '#6b7280' }}>By</span>
              {post.author ? (
                post.author_id ? (
                  <Link
                    to={`/blog/authors/${post.author_id}`}
                    style={{ fontSize: '0.88rem', color: '#7C5CBF', fontWeight: 600, textDecoration: 'none' }}
                  >
                    {post.author}
                  </Link>
                ) : (
                  <span style={{ fontSize: '0.88rem', color: '#374151', fontWeight: 600 }}>{post.author}</span>
                )
              ) : (
                <Link
                  to={`/directory/${post.business_id}`}
                  style={{ fontSize: '0.88rem', color: '#7C5CBF', fontWeight: 600, textDecoration: 'none' }}
                >
                  {post.business_name}
                </Link>
              )}
              {post.author && (
                <>
                  <span style={{ fontSize: '0.88rem', color: '#9ca3af' }}>·</span>
                  <Link
                    to={`/directory/${post.business_id}`}
                    style={{ fontSize: '0.88rem', color: '#9ca3af', textDecoration: 'none' }}
                  >
                    {post.business_name}
                  </Link>
                </>
              )}
            </div>

            {post.excerpt && (
              <p style={{ fontSize: '1.05rem', color: '#4b5563', lineHeight: 1.7, marginBottom: '1.5rem', fontStyle: 'italic' }}>
                {post.excerpt}
              </p>
            )}

            {renderContent(post.content)}

            <div style={{ marginTop: '2.5rem', paddingTop: '1.5rem', borderTop: '1px solid #e5e7eb' }}>
              <Link
                to={`/directory/${post.business_id}`}
                style={{ display: 'inline-block', background: '#819360', color: '#fff', textDecoration: 'none', padding: '0.55rem 1.25rem', borderRadius: '8px', fontSize: '0.9rem', fontWeight: 600 }}
              >
                View {post.business_name}'s Profile
              </Link>
              <Link to="/blog" style={{ marginLeft: '1rem', color: '#7C5CBF', textDecoration: 'none', fontSize: '0.9rem' }}>
                More Blog Posts →
              </Link>
            </div>
          </article>
        )}
      </div>
      <Footer />
    </div>
  );
}
