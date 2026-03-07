import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const CATEGORIES = [
  { key: 'Algaes',         label: 'Algae',           img: '/images/Algae.webp',         path: '/plant-knowledgebase/algae',          desc: 'A diverse group of aquatic organisms, including seaweeds and microalgae, used in cooking, supplements, and other products.' },
  { key: 'Berries',        label: 'Berries',          img: '/images/Berries.webp',        path: '/plant-knowledgebase/berries',         desc: 'Small, fleshy fruits that grow on bushes or vines, such as blueberries and cranberries, valued for their sweet or tart flavor.' },
  { key: 'Bulbs',          label: 'Bulbs',            img: '/images/Bulbs.webp',          path: '/plant-knowledgebase/bulbs',           desc: 'The underground storage organs of plants, like onions and garlic, that are a fundamental flavor base in many cuisines.' },
  { key: 'Corms',          label: 'Corms',            img: '/images/Corms.webp',          path: '/plant-knowledgebase/corms',           desc: 'Underground storage organs that are botanically distinct from bulbs and tubers, such as taro and water chestnuts.' },
  { key: 'Culinary Herbs', label: 'Culinary Herbs',   img: '/images/CulinaryHerbs.webp',  path: '/plant-knowledgebase/culinary-herbs',  desc: 'Plants or plant parts, like parsley and basil, used specifically to enhance the flavor, aroma, and appearance of food.' },
  { key: 'Edible Flowers', label: 'Edible Flowers',   img: '/images/EdibleFlowers.webp',  path: '/plant-knowledgebase/edible-flowers',  desc: 'Flowers that are safe for human consumption, often used for their flavor, aroma, or decorative qualities in dishes.' },
  { key: 'Fruits',         label: 'Fruits',           img: '/images/Fruit.webp',          path: '/plant-knowledgebase/fruits',          desc: 'The sweet, seed-bearing produce of a plant, ranging from crisp apples to juicy melons, enjoyed fresh or in countless dishes and drinks.' },
  { key: 'Ginkgoes',       label: 'Ginkgos',          img: '/images/Ginko.webp',          path: '/plant-knowledgebase/ginkgos',         desc: 'Ancient and resilient trees distinguished by their unique fan-shaped leaves and edible nuts.' },
  { key: 'Grains',         label: 'Grains',           img: '/images/Grains.webp',         path: '/plant-knowledgebase/grains',          desc: 'The hard, dry seeds of cereal grasses, such as wheat, rice, and corn, that are foundational to many diets globally.' },
  { key: 'Grasses',        label: 'Grasses',          img: '/images/Grasses.webp',        path: '/plant-knowledgebase/grasses',         desc: 'A diverse and widespread group of plants including cereal crops like wheat and rice, and various forage plants.' },
  { key: 'Leafy Greens',   label: 'Leafy Greens',     img: '/images/LeafyGreens.webp',    path: '/plant-knowledgebase/leafy-greens',    desc: 'A variety of edible plant leaves, such as spinach and lettuce, packed with vitamins and minerals and perfect for salads or cooking.' },
  { key: 'Legumes',        label: 'Legumes',          img: '/images/Legumes.jpg',         path: '/plant-knowledgebase/legumes',         desc: 'Plants in the pea family grown for their nutrient-rich seeds and pods, including popular staples like beans, lentils, and peas.' },
  { key: 'Medicinal Herb', label: 'Medicinal Herbs',  img: '/images/MedicinalHerbs.webp', path: '/plant-knowledgebase/medicinal-herbs', desc: 'Plants used for their therapeutic properties, often valued in traditional medicine for promoting health and wellness.' },
  { key: 'Mushroom',       label: 'Mushrooms',        img: '/images/Mushrooms.webp',      path: '/plant-knowledgebase/mushrooms',       desc: 'The edible, fleshy fruiting bodies of fungi, prized for their earthy flavors and unique textures in cooking.' },
  { key: 'Nut',            label: 'Nuts',             img: '/images/Nuts.webp',           path: '/plant-knowledgebase/nuts',            desc: 'Dry, hard-shelled seeds or fruits that are a fantastic source of protein and healthy fats, such as almonds, walnuts, and pecans.' },
  { key: 'Palms',          label: 'Palms',            img: '/images/Palms.webp',          path: '/plant-knowledgebase/palms',           desc: 'Tropical trees with large fronds, cultivated for their delicious and useful fruits like coconuts and dates.' },
  { key: 'Pseudocereal',   label: 'Pseudocereals',    img: '/images/Psuodcereals.webp',   path: '/plant-knowledgebase/pseudocereals',   desc: 'Plants, like quinoa and amaranth, whose seeds are used in the same way as grains but are not botanically from the grass family.' },
  { key: 'Rhizomes',       label: 'Rhizomes',         img: '/images/Rhizomes.webp',       path: '/plant-knowledgebase/rhizomes',        desc: 'Underground stems that grow horizontally, such as ginger and turmeric, used as spices and in traditional medicine.' },
  { key: 'Root',           label: 'Root Vegetables',  img: '/images/RootVegetables.webp', path: '/plant-knowledgebase/root-vegetables', desc: 'Edible plant roots that grow underground, including carrots and radishes, valued for their distinct flavors and dense nutrition.' },
  { key: 'Spices',         label: 'Spices',           img: '/images/Spices.webp',         path: '/plant-knowledgebase/spices',          desc: 'Aromatic plant substances, derived from seeds, bark, or roots, used to add depth of flavor and aroma to dishes.' },
  { key: 'Tubers',         label: 'Tubers',           img: '/images/Tubers.webp',         path: '/plant-knowledgebase/tubers',          desc: "Enlarged, starchy storage organs of a plant's stem, like potatoes and yams, that serve as a crucial source of carbohydrates." },
  { key: 'Vegetable',      label: 'Vegetables',       img: '/images/Vegetables.webp',     path: '/plant-knowledgebase/vegetables',      desc: 'A wide variety of plants and plant parts, from crunchy carrots to tender asparagus, that are staples of savory meals around the world.' },
];

export default function PlantKnowledgebase() {
  const [counts, setCounts] = useState({});
  const [total, setTotal] = useState(0);
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    setIsLoggedIn(Boolean(token));

    fetch(`${API_URL}/api/plant-knowledgebase/counts`)
      .then(r => r.ok ? r.json() : {})
      .then(data => {
        setCounts(data.counts || {});
        setTotal(data.total || 0);
      })
      .catch(() => {});
  }, []);

  // Pair categories into rows of 2
  const rows = [];
  for (let i = 0; i < CATEGORIES.length; i += 2) {
    rows.push(CATEGORIES.slice(i, i + 2));
  }

  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />

      <div className="mx-auto px-4 py-2" style={{ maxWidth: "1300px" }}>

        {/* Page title */}
        <h1 >Online Plant Database</h1>

        {/* Video banner — no overlay title, just the video */}
        <div className="w-full overflow-hidden mb-3" style={{ height: '200px' }}>
          <video
            src="/videos/PlantDBVideo.mp4"
            autoPlay loop muted playsInline
            className="w-full object-cover"
            style={{ height: '286px', marginTop: '-33px' }}
          />
        </div>

        {/* Intro text */}
        <p className="text-gray-800 mb-2">
          There are thousands of varieties of plants grown for food, we have documented{' '}
          <strong>{total > 0 ? `${total.toLocaleString()} Varieties` : '...'}</strong>{' '}
          so far. We have the mission to list them all here.
        </p>
        <p className="text-gray-800 mb-5">
          We are consistently adding more information and photos to the list, and we are always finding more varieties.
          If you would like to help out with photos, descriptions, or correcting errors please{' '}
          <Link to="/contact-us" className="text-[#3D6B34] hover:underline">Contact Us</Link>
          {' '}and let us know the more people we have helping, the more complete the information.
        </p>

        <h2 className="text-lg font-bold text-gray-900 mb-4">Categories of Food Plants</h2>

        {/* Category rows — 2 per row, image left, text right, matching production layout */}
        <div>
          {rows.map((row, ri) => (
            <div key={ri} className="grid grid-cols-2 gap-x-8 mb-4">
              {row.map(cat => {
                const count = counts[cat.key] || 0;
                return (
                  <div key={cat.key} className="flex gap-3 items-start mb-4">
                    <Link to={cat.path} className="shrink-0" style={{ marginTop: '15px' }}>
                      <img
                        src={cat.img}
                        alt={cat.label}
                        width="150"
                        height="150"
                        loading="lazy"
                        className="object-cover"
                        style={{ width: '150px', height: '150px' }}
                      />
                    </Link>
                    <div className="pt-4">
                      <Link
                        to={cat.path}
                        className="hover:underline text-sm"
                        style={{ color: '#3D6B34' }}
                      >
                        {cat.label}{count > 0 ? ` (${count} Varieties)` : ''}
                      </Link>
                      <br />
                      <span className="text-sm text-gray-700">{cat.desc}</span>
                    </div>
                  </div>
                );
              })}
            </div>
          ))}
        </div>

      </div>

      <Footer />
    </div>
  );
}