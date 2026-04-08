import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const EAGER_COUNT = 4;

function imgSrc(cat) {
  if (cat.image) {
    if (cat.image.startsWith('/') || cat.image.startsWith('http')) return cat.image;
    return '/images/' + cat.image;
  }
  return '/images/' + cat.name.replace(/ /g, '') + '.webp';
}

function CategorySkeleton() {
  return (
    <div className="grid grid-cols-2 gap-x-8 gap-y-6">
      {[...Array(8)].map((_, i) => (
        <div key={i} className="flex gap-4 items-start animate-pulse">
          <div className="bg-gray-200 rounded shrink-0" style={{ width: '150px', height: '150px' }} />
          <div className="flex-1 pt-1 space-y-2">
            <div className="bg-gray-200 h-4 rounded w-3/4" />
            <div className="bg-gray-200 h-3 rounded w-full" />
            <div className="bg-gray-200 h-3 rounded w-5/6" />
            <div className="bg-gray-200 h-3 rounded w-4/6" />
          </div>
        </div>
      ))}
    </div>
  );
}

export default function IngredientKnowledgebase() {
  const [categories, setCategories] = useState([]);
  const [totals, setTotals] = useState({ varieties: 0, ingredients: 0 });
  const [loading, setLoading] = useState(true);
  const [videoReady, setVideoReady] = useState(false);

  useEffect(() => {
    fetch(API_URL + '/api/ingredient-knowledgebase/categories')
      .then(r => r.json())
      .then(data => {
        setCategories(Array.isArray(data.categories) ? data.categories : []);
        setTotals({ varieties: data.total_varieties || 0, ingredients: data.total_ingredients || 0 });
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, []);

  useEffect(() => {
    // Double rAF — guarantees we're past the first paint before mounting the video
    let raf;
    raf = requestAnimationFrame(() => {
      raf = requestAnimationFrame(() => {
        setVideoReady(true);
      });
    });
    return () => cancelAnimationFrame(raf);
  }, []);

  return (
    <div className="min-h-screen bg-white font-sans">
      <PageMeta
        title="Ingredient Knowledgebase | 1,400+ Agricultural Ingredients"
        description="Browse 1,400+ agricultural ingredients and 14,000+ varieties. Search by category for flavor profiles, nutritional data, processing methods, and culinary uses."
        canonical="https://oatmealfarmnetwork.com/ingredient-knowledgebase"
      />
      <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '1rem 1rem 3rem' }}>
        <h2 className="text-xl font-bold text-gray-900 mb-3">Ingredient Knowledgebase</h2>

        {/* Video — deferred so nav links are clickable on first paint */}
        <div className="w-full mb-4 overflow-hidden" style={{ height: '200px' }}>
          {videoReady && (
            <video
              className="w-full object-cover"
              style={{ height: '200px' }}
              autoPlay muted loop playsInline
              preload="none"
            >
              <source src="/videos/Ingredients.mp4" type="video/mp4" />
            </video>
          )}
        </div>

        <p className="text-sm text-gray-700 mb-1">
          There are thousands of Ingredients, we have documented{' '}
          <strong>{totals.varieties.toLocaleString()} varieties of {totals.ingredients.toLocaleString()} Ingredients</strong>{' '}
          so far. We have the mission to list them all here.
        </p>
        <p className="text-sm text-gray-700 mb-6">
          We are consistently adding more information and photos to the list. If you would like to help out with photos,
          descriptions, or correcting errors please <Link to="/contact-us" style={{ color: '#3D6B34' }}>Contact Us</Link> and
          let us know the more people we have helping, the more complete the information.
        </p>

        <h3 className="text-lg font-bold text-gray-900 mb-4">Categories of Food Ingredients</h3>

        {loading ? (
          <CategorySkeleton />
        ) : (
          <div className="grid grid-cols-2 gap-x-8 gap-y-6">
            {categories.map((cat, index) => (
              <div key={cat.id} className="flex gap-4 items-start">
                <Link to={'/ingredient-knowledgebase/' + cat.slug} className="shrink-0">
                  <img
                    src={imgSrc(cat)}
                    alt={cat.name}
                    width="100"
                    height="100"
                    className="object-cover rounded"
                    loading={index < EAGER_COUNT ? 'eager' : 'lazy'}
                    decoding={index < EAGER_COUNT ? 'sync' : 'async'}
                    style={{ width: '150px', height: '150px' }}
                    onError={e => { e.target.src = '/images/IngredientsHeader.webp'; }}
                  />
                </Link>
                <div className="pt-1">
                  <Link
                    to={'/ingredient-knowledgebase/' + cat.slug}
                    className="hover:underline text-sm font-medium block mb-1"
                    style={{ color: '#3D6B34' }}
                  >
                    {cat.name} ({cat.ingredient_count} Ingredients)
                  </Link>
                  <p className="text-sm text-gray-700 leading-relaxed">{cat.description}</p>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}