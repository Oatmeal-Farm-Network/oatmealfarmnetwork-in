import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function IngredientVarieties() {
  const { category, ingredientId } = useParams();
  const [ingredientName, setIngredientName] = useState('');
  const [varieties, setVarieties] = useState(null);
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    setIsLoggedIn(Boolean(token));

    fetch(API_URL + '/api/ingredient-knowledgebase/varieties/' + ingredientId)
      .then(r => r.json())
      .then(data => {
        setIngredientName(data.ingredient_name || '');
        setVarieties(Array.isArray(data.varieties) ? data.varieties : []);
      })
      .catch(() => setVarieties([]));
  }, [ingredientId]);

  return (
    <div className="min-h-screen font-sans">
      <PageMeta
        title={ingredientName ? `${ingredientName} Varieties | Ingredient Knowledgebase` : 'Ingredient Varieties | Ingredient Knowledgebase'}
        description={ingredientName ? `Browse all known varieties of ${ingredientName} including flavor profiles, sourcing information, and nutritional data.` : 'Browse ingredient varieties in the Oatmeal Farm Network knowledgebase.'}
      />
     <Header />

      <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '1rem 1rem 3rem' }}>
        <h1 className="text-2xl font-bold text-gray-900 mb-2">{ingredientName} Varieties</h1>
        <p className="text-gray-700 mb-6">
          Below is a list of all known varieties for {ingredientName}. Click on a variety name to view more detailed nutrient and sourcing information.
        </p>

        {varieties === null ? (
          <div className="text-gray-400 py-12 text-center">Loading...</div>
        ) : varieties.length === 0 ? (
          <div className="text-gray-500 py-8 text-center">No varieties found for {ingredientName}.</div>
        ) : (
          <div className="overflow-x-auto rounded border border-gray-200 shadow-sm">
            <table className="w-full text-sm border-collapse">
              <thead>
                <tr className="bg-gray-50 text-gray-600 text-xs uppercase tracking-wide">
                  <th className="px-4 py-3 text-left border-b border-gray-200">Variety Name</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Description</th>
                </tr>
              </thead>
              <tbody>
                {varieties.map((v, i) => (
                  <tr key={v.id} className={i % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                    <td className="px-4 py-3 border-b border-gray-100">
                      {v.nutrient_count > 0 ? (
                        <Link
                          to={'/ingredient-knowledgebase/' + category + '/variety-detail/' + v.id}
                          className="hover:underline"
                          style={{ color: '#3D6B34' }}
                        >
                          {v.name}
                        </Link>
                      ) : (
                        <span className="text-gray-800">{v.name}</span>
                      )}
                    </td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{v.description}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
