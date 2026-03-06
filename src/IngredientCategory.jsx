import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function imgSrc(ingredient) {
  if (ingredient.image) {
    if (ingredient.image.startsWith('/') || ingredient.image.startsWith('http')) return ingredient.image;
    return '/images/' + ingredient.image;
  }
  return '/images/' + ingredient.name.replace(/ /g, '') + '.webp';
}

export default function IngredientCategory() {
  const { category } = useParams();
  const [catName, setCatName] = useState('');
  const [catHeader, setCatHeader] = useState('');
  const [ingredients, setIngredients] = useState(null);
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
  window.scrollTo(0, 0);
  const token = localStorage.getItem('access_token');
  setIsLoggedIn(Boolean(token));

  fetch(API_URL + '/api/ingredient-knowledgebase/category/' + category)
    .then(r => r.json())
    .then(data => {
      setCatName(data.category_name || category);
      setCatHeader(data.header_image || '');
      setIngredients(Array.isArray(data.ingredients) ? data.ingredients : []);
    })
    .catch(() => setIngredients([]));
}, [category]);

  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '0 1rem 2rem' }}>

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






        <h2 className="text-xl font-bold text-gray-900 mb-6">{catName} Ingredient Types</h2>

        {ingredients === null ? (
          <div className="text-gray-400 py-12 text-center">Loading...</div>
        ) : ingredients.length === 0 ? (
          <div className="text-gray-500 py-12 text-center">No ingredients found.</div>
        ) : (
          <div className="grid grid-cols-3 gap-x-6 gap-y-6">
            {ingredients.map(ing => (
              <div key={ing.id}>
                {ing.variety_count > 0 ? (
                  <Link
                    to={'/ingredient-knowledgebase/' + category + '/varieties/' + ing.id}
                    className="hover:underline text-sm font-medium block mb-1"
                    style={{ color: '#3D6B34' }}
                  >
                    {ing.name}
                  </Link>
                ) : (
                  <span className="text-sm font-medium text-gray-800 block mb-1">{ing.name}</span>
                )}
                <p className="text-xs text-gray-600 leading-relaxed">{ing.description}</p>
              </div>
            ))}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
