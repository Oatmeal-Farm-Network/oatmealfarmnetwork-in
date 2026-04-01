import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

// Resolve image src — prefer DB IngredientImage, fall back to local convention
function imgSrc(ingredient) {
  const img = ingredient.image || ingredient.IngredientImage;
  if (img) {
    if (img.startsWith('http') || img.startsWith('/')) return img;
    return '/images/' + img;
  }
  // convention fallback
  return '/images/' + (ingredient.name || ingredient.IngredientName || '').replace(/ /g, '') + '.webp';
}

function IngredientCard({ ing, category }) {
  const [imgErr, setImgErr] = useState(false);
  const src = imgSrc(ing);
  const name = ing.name || ing.IngredientName || '';
  const description = ing.description || ing.IngredientDescription || '';
  const hasVarieties = ing.variety_count > 0;

  return (
    <div style={{
      background: '#fff',
      borderRadius: 12,
      border: '1px solid #e5e7eb',
      overflow: 'hidden',
      display: 'flex',
      flexDirection: 'column',
      transition: 'box-shadow 0.15s, transform 0.15s',
    }}
      onMouseEnter={e => {
        e.currentTarget.style.boxShadow = '0 4px 20px rgba(0,0,0,0.10)';
        e.currentTarget.style.transform = 'translateY(-2px)';
      }}
      onMouseLeave={e => {
        e.currentTarget.style.boxShadow = 'none';
        e.currentTarget.style.transform = 'translateY(0)';
      }}
    >
      {/* Image — linked if has varieties, otherwise links to detail page */}
      {(() => {
        const imgContent = !imgErr ? (
          <img
            src={src}
            alt={name}
            onError={() => setImgErr(true)}
            style={{ width: '100%', height: '100%', objectFit: 'cover', display: 'block', transition: 'transform 0.2s' }}
          />
        ) : (
          <div style={{
            width: '100%', height: '100%',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            background: 'linear-gradient(135deg, #f0fdf4, #dcfce7)',
            fontSize: '2.5rem',
          }}>
            🥬
          </div>
        );

        const containerStyle = {
          width: '100%', aspectRatio: '4/3', background: '#f3f4f6',
          overflow: 'hidden', flexShrink: 0, display: 'block',
        };

        const linkTo = hasVarieties
          ? '/ingredient-knowledgebase/' + category + '/varieties/' + ing.id
          : '/ingredient-knowledgebase/' + category + '/' + (ing.id || ing.IngredientID);

        return (
          <Link
            to={linkTo}
            style={{ ...containerStyle, cursor: 'pointer' }}
            onMouseEnter={e => { const img = e.currentTarget.querySelector('img'); if (img) img.style.transform = 'scale(1.04)'; }}
            onMouseLeave={e => { const img = e.currentTarget.querySelector('img'); if (img) img.style.transform = 'scale(1)'; }}
          >
            {imgContent}
          </Link>
        );
      })()}

      {/* Body */}
      <div style={{ padding: '0.75rem 0.875rem 0.875rem', flex: 1, display: 'flex', flexDirection: 'column', gap: '0.3rem' }}>
        {hasVarieties ? (
          <Link
            to={'/ingredient-knowledgebase/' + category + '/varieties/' + ing.id}
            style={{
              color: '#3D6B34', fontWeight: 600, fontSize: '0.875rem',
              textDecoration: 'none', lineHeight: 1.3,
            }}
            onMouseEnter={e => e.currentTarget.style.textDecoration = 'underline'}
            onMouseLeave={e => e.currentTarget.style.textDecoration = 'none'}
          >
            {name}
            <span style={{ fontSize: '0.72rem', color: '#6b7280', fontWeight: 400, marginLeft: '0.35rem' }}>
              {ing.variety_count} {ing.variety_count === 1 ? 'variety' : 'varieties'} →
            </span>
          </Link>
        ) : (
          <span style={{ fontWeight: 600, fontSize: '0.875rem', color: '#111827', lineHeight: 1.3 }}>{name}</span>
        )}

        {description && (
          <p style={{
            margin: 0, fontSize: '0.78rem', color: '#6b7280',
            lineHeight: 1.5, flex: 1,
            display: '-webkit-box', WebkitLineClamp: 3, WebkitBoxOrient: 'vertical', overflow: 'hidden',
          }}>
            {description}
          </p>
        )}
      </div>
    </div>
  );
}

export default function IngredientCategory() {
  const { category } = useParams();
  const [catName, setCatName] = useState('');
  const [catHeader, setCatHeader] = useState('');
  const [ingredients, setIngredients] = useState(null);
  const [search, setSearch] = useState('');

  useEffect(() => {
    window.scrollTo(0, 0);

    fetch(API_URL + '/api/ingredient-knowledgebase/category/' + category)
      .then(r => r.json())
      .then(data => {
        setCatName(data.category_name || category);
        setCatHeader(data.header_image || '');
        setIngredients(Array.isArray(data.ingredients) ? data.ingredients : []);
      })
      .catch(() => setIngredients([]));
  }, [category]);

  const filtered = ingredients
    ? ingredients.filter(ing => {
        const q = search.trim().toLowerCase();
        if (!q) return true;
        const name = (ing.name || ing.IngredientName || '').toLowerCase();
        const desc = (ing.description || ing.IngredientDescription || '').toLowerCase();
        return name.includes(q) || desc.includes(q);
      })
    : null;

  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '0 1rem 3rem' }}>

        {/* Header image */}
        <img
          src={catHeader || '/images/' + category.replace(/-/g, '').charAt(0).toUpperCase() + category.replace(/-/g, '').slice(1) + 'IngredientHeader.webp'}
          alt={catName}
          className="w-full object-cover mb-5"
          style={{ height: '200px', objectPosition: 'center', display: 'block' }}
          onError={e => {
            const lower = '/images/' + category.replace(/-/g, '').toLowerCase() + 'IngredientHeader.webp';
            if (e.target.src !== window.location.origin + lower) {
              e.target.src = lower;
            } else {
              e.target.style.display = 'none';
            }
          }}
        />

        {/* Title + search */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.75rem', marginBottom: '1.5rem' }}>
          <h2 style={{ margin: 0, fontSize: '1.25rem', fontWeight: 700, color: '#111827' }}>
            {catName} Ingredient Types
            {filtered && (
              <span style={{ fontSize: '0.8rem', fontWeight: 400, color: '#9ca3af', marginLeft: '0.6rem' }}>
                {filtered.length} ingredient{filtered.length !== 1 ? 's' : ''}
              </span>
            )}
          </h2>

          {ingredients && ingredients.length > 6 && (
            <input
              type="search"
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Search ingredients…"
              style={{
                padding: '0.4rem 0.75rem', border: '1px solid #d1d5db', borderRadius: 8,
                fontSize: '0.85rem', outline: 'none', width: 220, color: '#374151',
              }}
            />
          )}
        </div>

        {/* Grid */}
        {filtered === null ? (
          <div style={{ textAlign: 'center', color: '#9ca3af', padding: '4rem 0', fontSize: '0.95rem' }}>Loading…</div>
        ) : filtered.length === 0 ? (
          <div style={{ textAlign: 'center', color: '#6b7280', padding: '4rem 0', fontSize: '0.95rem' }}>
            {search ? `No results for "${search}"` : 'No ingredients found.'}
          </div>
        ) : (
          <div style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))',
            gap: '1.25rem',
          }}>
            {filtered.map(ing => (
              <IngredientCard key={ing.id || ing.IngredientID} ing={ing} category={category} />
            ))}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}