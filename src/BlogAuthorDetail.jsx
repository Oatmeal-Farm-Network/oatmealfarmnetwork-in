import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function renderContent(content) {
  if (!content) return null;
  let blocks;
  try {
    blocks = JSON.parse(content);
    if (!Array.isArray(blocks)) throw new Error();
  } catch {
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
            <figure key={i} style={{ margin: '1.5rem 0', textAlign: block.align || 'center' }}>
              <img src={block.url} alt={block.caption || ''}
                style={{ width: block.width || '100%', maxWidth: '100%', borderRadius: 10, display: 'inline-block', objectFit: 'contain' }}
                onError={e => e.target.style.display = 'none'} />
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

function getExcerpt(content, wordLimit = 25) {
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

function getCover(post) {
  if (post.cover_image) return post.cover_image;
  try {
    const blocks = JSON.parse(post.content || '');
    if (Array.isArray(blocks)) {
      const img = blocks.find(b => b.type === 'image' && b.url);
      if (img) return img.url;
    }
  } catch {}
  return null;
}

export default function BlogAuthorDetail() {
  const { authorId } = useParams();
  const [author, setAuthor]   = useState(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);

  useEffect(() => {
    if (!authorId) return;
    setLoading(true);
    fetch(`${API_URL}/api/blog/authors/${authorId}`)
      .then(r => {
        if (r.status === 404) { setNotFound(true); return null; }
        return r.json();
      })
      .then(data => { if (data) setAuthor(data); })
      .catch(() => setNotFound(true))
      .finally(() => setLoading(false));
  }, [authorId]);

  const formatDate = dt => dt
    ? new Date(dt).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })
    : '';

  const authorBioText = author?.bio ? (() => {
    let text = author.bio;
    try {
      const blocks = JSON.parse(author.bio);
      if (Array.isArray(blocks))
        text = blocks.filter(b => b.type === 'text').map(b => b.content || '').join(' ');
    } catch {}
    return text.replace(/<[^>]*>/g, ' ').replace(/\s+/g, ' ').trim();
  })() : '';
  const authorDesc = author
    ? (authorBioText ? authorBioText.slice(0, 155) : `Read blog posts by ${author.name} on Oatmeal Farm Network.`)
    : '';
  const canonical = `https://oatmealfarmnetwork.com/blog/authors/${authorId}`;

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col font-sans">
      {author && (
        <PageMeta
          title={`${author.name} | Blog Author`}
          description={authorDesc}
          keywords={`${author.name}, blog author, farm blog, ${author.name} posts, Oatmeal Farm Network`}
          canonical={canonical}
          image={author.avatar_url || undefined}
          jsonLd={{
            '@context': 'https://schema.org',
            '@type': 'Person',
            name: author.name,
            description: authorDesc,
            url: canonical,
            ...(author.avatar_url ? { image: author.avatar_url } : {}),
            ...(author.author_link ? { sameAs: [author.author_link] } : {}),
          }}
        />
      )}
      {!author && !loading && notFound && (
        <PageMeta
          title="Author Not Found"
          description="The blog author you're looking for is no longer available on Oatmeal Farm Network."
          canonical={canonical}
          noIndex
        />
      )}
      <Header />
      <div style={{ maxWidth: '820px', margin: '0 auto', padding: '1rem 1.5rem 2rem', flex: 1, width: '100%', boxSizing: 'border-box' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Blog', to: '/blog' },
          { label: author?.name || 'Author' },
        ]} />
        <Link to="/blog" style={{ color: '#7C5CBF', textDecoration: 'none', fontSize: '0.85rem', display: 'inline-block', marginBottom: '1.5rem' }}>
          ← Back to Blog
        </Link>

        {loading && <p style={{ color: '#9ca3af', textAlign: 'center', padding: '3rem 0' }}>Loading...</p>}

        {notFound && !loading && (
          <div style={{ textAlign: 'center', padding: '3rem' }}>
            <h2 style={{ color: '#374151' }}>Author Not Found</h2>
            <p style={{ color: '#9ca3af' }}>This author profile may have been removed.</p>
          </div>
        )}

        {author && !loading && (
          <>
            {/* Author header */}
            <div style={{ background: '#fff', borderRadius: 14, border: '1px solid #e5e7eb', padding: '2rem', marginBottom: '2rem', display: 'flex', gap: '1.5rem', alignItems: 'flex-start', flexWrap: 'wrap' }}>
              {author.avatar_url ? (
                <img src={author.avatar_url} alt={author.name}
                  style={{ width: 96, height: 96, borderRadius: '50%', objectFit: 'cover', border: '3px solid #e5e7eb', flexShrink: 0 }}
                  onError={e => e.target.style.display = 'none'} />
              ) : (
                <div style={{ width: 96, height: 96, borderRadius: '50%', background: 'linear-gradient(135deg,#f3f4f6,#e5e7eb)', flexShrink: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2.5rem' }}>
                  👤
                </div>
              )}
              <div style={{ flex: 1, minWidth: 0 }}>
                <h1 style={{ margin: '0 0 0.25rem', fontSize: '1.75rem', fontWeight: 800, color: '#111827' }}>
                  {author.name}
                </h1>
                {author.author_link && (
                  <a href={author.author_link} target="_blank" rel="noopener noreferrer"
                    style={{ fontSize: '0.88rem', color: '#7C5CBF', textDecoration: 'none', fontWeight: 600 }}>
                    {author.author_link} ↗
                  </a>
                )}
                {author.bio && (
                  <div style={{ marginTop: '1rem' }}>
                    {renderContent(author.bio)}
                  </div>
                )}
              </div>
            </div>

            {/* Posts by this author */}
            {author.posts && author.posts.length > 0 && (
              <div>
                <h2 style={{ margin: '0 0 1rem', fontSize: '1.2rem', fontWeight: 700, color: '#111827' }}>
                  Posts by {author.name}
                </h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '1rem' }}>
                  {author.posts.map(post => {
                    const cover = getCover(post);
                    const date = formatDate(post.published_at || post.created_at);
                    return (
                      <Link key={post.blog_id} to={`/blog/${post.blog_id}`}
                        style={{ textDecoration: 'none', color: 'inherit', display: 'block' }}>
                        <div style={{ background: '#fff', borderRadius: 10, border: '1px solid #e5e7eb', overflow: 'hidden', transition: 'box-shadow 0.2s', cursor: 'pointer' }}
                          onMouseEnter={e => e.currentTarget.style.boxShadow = '0 4px 16px rgba(0,0,0,0.08)'}
                          onMouseLeave={e => e.currentTarget.style.boxShadow = 'none'}>
                          {cover ? (
                            <img src={cover} alt={post.title} style={{ width: '100%', height: 140, objectFit: 'cover', display: 'block' }}
                              onError={e => e.target.style.display = 'none'} />
                          ) : (
                            <div style={{ width: '100%', height: 80, background: 'linear-gradient(135deg,#f3f4f6,#e5e7eb)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                              <span style={{ fontSize: '2rem' }}>📝</span>
                            </div>
                          )}
                          <div style={{ padding: '0.85rem' }}>
                            <div style={{ fontSize: '0.7rem', color: '#9ca3af', marginBottom: '0.25rem' }}>{date}</div>
                            <div style={{ fontWeight: 700, fontSize: '0.92rem', color: '#111827', lineHeight: 1.3, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                              {post.title}
                            </div>
                            {post.content && (
                              <p style={{ margin: '0.3rem 0 0', fontSize: '0.78rem', color: '#6b7280', lineHeight: 1.5, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                                {getExcerpt(post.content)}
                              </p>
                            )}
                          </div>
                        </div>
                      </Link>
                    );
                  })}
                </div>
              </div>
            )}

            {author.posts && author.posts.length === 0 && (
              <p style={{ color: '#9ca3af', fontSize: '0.9rem', textAlign: 'center', padding: '2rem 0' }}>
                No published posts yet.
              </p>
            )}
          </>
        )}
      </div>
      <Footer />
    </div>
  );
}
