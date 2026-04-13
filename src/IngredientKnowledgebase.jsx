import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const EAGER_COUNT = 4;

// Static descriptions keyed by category name (case-insensitive)
const DESCRIPTIONS = {
  'algae':                    'From silky wakame ribbons to umami-rich nori sheets, algae bring the briny depth of the ocean straight to your plate.',
  'beans':                    'Creamy, hearty, and endlessly versatile — slow-simmered black beans, smoky pintos, and buttery cannellinis are the soul of comfort cooking everywhere.',
  'berries':                  'Bursting with sweetness and just the right amount of tang, fresh berries turn everything from morning yogurt to evening desserts into something special.',
  'breads':                   'Few aromas are as irresistible as freshly baked bread — from crusty sourdoughs and pillowy brioche to flatbreads hot off a griddle.',
  'candy':                    'Pure, playful indulgence — from hand-pulled taffy and silky caramels to bittersweet dark chocolates that melt on the tongue.',
  'cheeses':                  'Aged, fresh, melted, or crumbled — cheese transforms every dish it touches, from a simple baguette to an elaborate charcuterie board.',
  'chemicals':                'The behind-the-scenes heroes of food crafting: leavening agents that make cakes rise, emulsifiers that keep sauces velvety, and preservatives that lock in freshness.',
  'edible flowers':           'Delicate, fragrant, and strikingly beautiful — edible blossoms like nasturtiums, lavender, and rose petals elevate salads, cocktails, and desserts to works of art.',
  'fish':                     'From flaky pan-seared salmon and crispy fish tacos to delicate crudo and slow-braised branzino — the ocean offers an endless variety of flavors.',
  'flours':                   'The quiet foundation of baking — fine wheat flour for airy croissants, nutty almond flour for tender macarons, and earthy buckwheat for rustic crepes.',
  'fruits':                   'Ripe, juicy, and alive with natural sweetness — from fragrant mangoes and tart passion fruit to crisp apples and sun-warmed peaches.',
  'fungi':                    'Earthy, meaty, and deeply savory — golden chanterelles, velvety porcini, and smoky shiitakes add unmistakable richness to any dish.',
  'gourds':                   'Roasted butternut squash with brown butter, cool cucumber salads, and pumpkin soups spiced with nutmeg — gourds are the quiet stars of the kitchen.',
  'grains':                   'The golden backbone of civilizations — nutty farro, fragrant basmati, creamy polenta, and chewy barley each tell a story of land and harvest.',
  'herbs':                    'A handful of fresh basil, a sprig of rosemary, a scattering of cilantro — herbs are the finishing touch that wakes up every dish.',
  'juices':                   'Cold-pressed, sun-bright, and brimming with flavor — freshly squeezed citrus, vibrant beet, and sweet pressed apple juice nourish and refresh.',
  'legumes':                  'Lentil dal fragrant with cumin, silky hummus drizzled with olive oil, and slow-cooked split pea soup — legumes are humble ingredients with extraordinary depth.',
  'meats':                    'Slow-braised short ribs, crackling roast chicken, smoky pulled pork — expertly sourced and carefully cooked meats are at the heart of celebratory meals worldwide.',
  'melons':                   'Cool, refreshing, and impossibly sweet — watermelon dusted with tajín, honeydew paired with prosciutto, and cantaloupe straight from the vine define summer eating.',
  'milks':                    'Creamy whole milk for a perfect béchamel, rich coconut milk for a Thai curry, frothy oat milk for a morning latte — dairy and its alternatives are indispensable.',
  'mollusks & crustaceans':   'Buttery lobster, briny oysters on the half shell, sweet Dungeness crab — the sea\'s most prized shellfish are a celebration on every plate.',
  'mollusks and crustaceans': 'Buttery lobster, briny oysters on the half shell, sweet Dungeness crab — the sea\'s most prized shellfish are a celebration on every plate.',
  'nuts':                     'Toasted marcona almonds, rich pecan pralines, creamy cashew sauces — nuts add irresistible crunch, depth, and warmth to both sweet and savory cooking.',
  'oils':                     'Grassy extra-virgin olive oil, nutty sesame, fragrant truffle — a great oil can transform a simple dish into something truly memorable.',
  'pastas':                   'Silky tagliatelle tossed in brown butter, al dente rigatoni pulling apart a slow ragù, fresh tortellini in golden broth — pasta is pure comfort.',
  'peppers':                  'Sweet bell peppers roasted until caramelized, smoky chipotles in adobo, and fresh Thai chilies — peppers bring color, warmth, and fire to the table.',
  'powders':                  'Vibrant matcha, smoky paprika, earthy turmeric, and tangy sumac — powdered ingredients deliver concentrated flavor in every pinch and spoonful.',
  'rice':                     'Sticky sushi rice, fragrant jasmine, creamy Arborio for risotto, and nutty wild rice — this ancient grain feeds the world and delights the palate.',
  'roots':                    'Honey-glazed carrots, silky parsnip purée, peppery raw radish — roots pulled from rich soil carry a natural sweetness and earthiness all their own.',
  'salts':                    'Flaky Maldon finishing salt, smoky Hawaiian black lava, briny fleur de sel — the right salt doesn\'t just season, it transforms and illuminates every flavor.',
  'seeds':                    'Toasted sesame on warm bread, chia seeds swelling in coconut milk, crunchy sunflower seeds scattered over a salad — small but mighty flavor boosters.',
  'spices':                   'Warm cinnamon, smoky cumin, floral cardamom, fiery gochugaru — spices are the soul of a recipe, turning simple ingredients into unforgettable dishes.',
  'sugars':                   'Golden caramel, deep molasses, fragrant vanilla sugar, and floral honey — sweetness in all its forms is the finishing grace note of great cooking.',
  'teas':                     'Smoky lapsang souchong, grassy sencha, floral jasmine, and malty Assam — from meditative morning cups to culinary infusions, tea offers endless depth.',
  'tubers':                   'Crispy duck-fat potatoes, velvety sweet potato purée, chewy cassava flatbreads — underground tubers are among the most satisfying ingredients on earth.',
  'vegetables':               'Charred leeks, caramelized onions, crisp snap peas straight from the garden — vegetables at their peak are vibrant, sweet, and endlessly inspiring.',
};

function getDesc(name) {
  return DESCRIPTIONS[name.toLowerCase()] || null;
}

function imgSrc(cat) {
  if (cat.image) {
    if (cat.image.startsWith('/') || cat.image.startsWith('http')) return cat.image;
    return '/images/' + cat.image;
  }
  return '/images/' + cat.name.replace(/ /g, '') + '.webp';
}

export default function IngredientKnowledgebase() {
  const [categories, setCategories] = useState([]);
  const [totals, setTotals] = useState({ varieties: 0, ingredients: 0 });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`${API_URL}/api/ingredient-knowledgebase/categories`)
      .then(r => r.json())
      .then(data => {
        setCategories(Array.isArray(data.categories) ? data.categories : []);
        setTotals({ varieties: data.total_varieties || 0, ingredients: data.total_ingredients || 0 });
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, []);

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Ingredient Knowledgebase | 1,400+ Agricultural Ingredients"
        description="Browse 1,400+ agricultural ingredients and 14,000+ varieties. Search by category for flavor profiles, nutritional data, processing methods, and culinary uses."
        canonical="https://oatmealfarmnetwork.com/ingredient-knowledgebase"
      />
      <Header />

      {/* ── Hero ── */}
      <div className="mx-auto px-4 pt-6" style={{ maxWidth: '1300px' }}>
        <div className="relative w-full overflow-hidden rounded-xl">
          <img
            src="/images/FruitsIngredientHeader.webp"
            alt="Ingredient Knowledgebase"
            className="w-full object-cover"
            style={{ height: '250px', display: 'block' }}
            loading="eager"
          />
          {/* Gradient overlay */}
          <div
            className="absolute inset-0"
            style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }}
          />
          {/* Text */}
          <div className="absolute inset-0 flex flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            <h1
              style={{
                color: '#000000',
                fontFamily: "'Lora','Times New Roman',serif",
                fontSize: '2rem',
                fontWeight: 'bold',
                margin: '0 0 12px',
                lineHeight: 1.2,
              }}
            >
              Ingredient Knowledgebase
            </h1>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: '0 0 8px', lineHeight: 1.6 }}>
              There are thousands of Ingredients, we have documented{' '}
              <strong>
                {totals.varieties > 0
                  ? `${totals.varieties.toLocaleString()} varieties of ${totals.ingredients.toLocaleString()} Ingredients`
                  : '…'}
              </strong>{' '}
              so far. We have the mission to list them all here.
            </p>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: 0, lineHeight: 1.6 }}>
              We are consistently adding more information and photos to the list. If you would like to help out with photos,
              descriptions, or correcting errors please{' '}
              <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>
              {' '}and let us know — the more people we have helping, the more complete the information.
            </p>
          </div>
        </div>
      </div>

      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        {/* ── Section heading ── */}
        <h2 className="text-lg font-bold text-gray-900 mb-5">Categories of Ingredients</h2>

        {/* ── 2-column grid of horizontal cards ── */}
        {loading ? (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
            {[...Array(8)].map((_, i) => (
              <div key={i} className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 animate-pulse" style={{ height: '155px' }}>
                <div className="shrink-0 bg-gray-200" style={{ width: '155px', height: '155px' }} />
                <div className="flex-1 px-5 py-4 space-y-2">
                  <div className="bg-gray-200 h-4 rounded w-3/4" />
                  <div className="bg-gray-200 h-3 rounded w-1/3" />
                  <div className="bg-gray-200 h-3 rounded w-full" />
                  <div className="bg-gray-200 h-3 rounded w-5/6" />
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
            {categories.map((cat, index) => {
              const desc = cat.description || getDesc(cat.name);
              return (
                <div
                  key={cat.id}
                  className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200"
                >
                  {/* Left: square image */}
                  <Link to={`/ingredient-knowledgebase/${cat.slug}`} className="shrink-0 overflow-hidden" style={{ width: '155px', height: '155px' }}>
                    <img
                      src={imgSrc(cat)}
                      alt={cat.name}
                      width="155"
                      height="155"
                      loading={index < EAGER_COUNT ? 'eager' : 'lazy'}
                      decoding={index < EAGER_COUNT ? 'sync' : 'async'}
                      className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                      onError={e => { e.target.src = '/images/GrainsIngredientHeader.webp'; }}
                    />
                  </Link>

                  {/* Right: text content */}
                  <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                    <div>
                      <Link
                        to={`/ingredient-knowledgebase/${cat.slug}`}
                        className="font-bold text-sm hover:underline"
                        style={{ color: '#3D6B34' }}
                      >
                        {cat.name}
                      </Link>
                      <p
                        className="text-xs font-semibold mt-0.5 mb-2"
                        style={{ color: '#819360' }}
                      >
                        {cat.ingredient_count > 0 ? `${cat.ingredient_count.toLocaleString()} Ingredients` : '—'}
                      </p>
                      <p className="text-xs text-gray-600 leading-relaxed">{desc}</p>
                    </div>
                    <div className="mt-3">
                      <Link
                        to={`/ingredient-knowledgebase/${cat.slug}`}
                        className="text-xs font-bold hover:underline"
                        style={{ color: '#3D6B34' }}
                      >
                        EXPLORE →
                      </Link>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )}

      </div>

      <Footer />
    </div>
  );
}
