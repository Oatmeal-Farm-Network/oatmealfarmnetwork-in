import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const CATEGORY_MAP = {
  'algae':           { dbType: 'Algaes',        label: 'Algae',           header: '/images/AlgaeHeader.webp' },
  'berries':         { dbType: 'Berries',        label: 'Berries',         header: '/images/BerriesHeader.webp' },
  'bulbs':           { dbType: 'Bulbs',          label: 'Bulbs',           header: '/images/BulbsHeader.webp' },
  'corms':           { dbType: 'Corms',          label: 'Corms',           header: '/images/CormsHeader.webp' },
  'culinary-herbs':  { dbType: 'Culinary Herbs', label: 'Culinary Herbs',  header: '/images/CulinaryHerbsHeader.webp' },
  'edible-flowers':  { dbType: 'Edible Flowers', label: 'Edible Flowers',  header: '/images/EdibleFlowersHeader.webp' },
  'fruits':          { dbType: 'Fruits',         label: 'Fruits',          header: '/images/FruitsHeader.webp' },
  'ginkgos':         { dbType: 'Ginkgoes',       label: 'Ginkgos',         header: '/images/GinkgoHeader.webp' },
  'grains':          { dbType: 'Grains',         label: 'Grains',          header: '/images/GrainsHeader.webp' },
  'grasses':         { dbType: 'Grasses',        label: 'Grasses',         header: '/images/GrassesHeader.webp' },
  'leafy-greens':    { dbType: 'Leafy Greens',   label: 'Leafy Greens',    header: '/images/LeafyGreensHeader.webp' },
  'legumes':         { dbType: 'Legumes',        label: 'Legumes',         header: '/images/LegumesHeader.webp' },
  'medicinal-herbs': { dbType: 'Medicinal Herb', label: 'Medicinal Herbs', header: '/images/MedicinalHerbsHeader.webp' },
  'mushrooms':       { dbType: 'Mushroom',       label: 'Mushrooms',       header: '/images/MushroomsHeader.webp' },
  'nuts':            { dbType: 'Nut',            label: 'Nuts',            header: '/images/NutsHeader.webp' },
  'palms':           { dbType: 'Palms',          label: 'Palms',           header: '/images/PalmsHeader.webp' },
  'pseudocereals':   { dbType: 'Pseudocereal',   label: 'Pseudocereals',   header: '/images/PseudocerealsHeader.webp' },
  'rhizomes':        { dbType: 'Rhizomes',       label: 'Rhizomes',        header: '/images/RhizomesHeader.webp' },
  'root-vegetables': { dbType: 'Root',           label: 'Root Vegetables', header: '/images/RootVegetablesHeader.webp' },
  'spices':          { dbType: 'Spices',         label: 'Spices',          header: '/images/SpicesHeader.webp' },
  'tubers':          { dbType: 'Tubers',         label: 'Tubers',          header: '/images/TubersHeader.webp' },
  'vegetables':      { dbType: 'Vegetable',      label: 'Vegetables',      header: '/images/VegetablesHeader.webp' },
};

function plantImgSrc(plant) {
  if (plant.plant_image) {
    if (plant.plant_image.startsWith("/") || plant.plant_image.startsWith("http")) return plant.plant_image;
    return "/images/" + plant.plant_image;
  }
  return "/images/" + plant.plant_name.replace(/ /g, "") + ".webp";
}

export default function PlantCategory() {
  const { category } = useParams();
  const [plants, setPlants] = useState(null);
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const cat = CATEGORY_MAP[category];

  useEffect(() => {
    window.scrollTo(0, 0);
    setPlants(null);
    const token = localStorage.getItem('access_token');
    setIsLoggedIn(Boolean(token));
    if (!cat) { setPlants([]); return; }

    const url = API_URL + '/api/plant-knowledgebase/plants?plant_type=' + encodeURIComponent(cat.dbType);
    fetch(url)
      .then(r => r.json())
      .then(data => setPlants(Array.isArray(data) ? data : []))
      .catch(() => setPlants([]));
  }, [category, cat?.dbType]);

  if (!cat) return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      <div className="text-center py-20 text-gray-500">Category not found: {category}</div>
      <Footer />
    </div>
  );

  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />

      <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '0 1rem 2rem' }}>

        <img
          src={cat.header}
          alt={cat.label}
          className="w-full object-cover mb-5"
          style={{ height: '200px', objectPosition: 'center', display: 'block' }}
          onError={e => { e.target.style.display = 'none'; }}
        />

        <h2 className="text-xl font-bold text-gray-900 mb-6">{cat.label} Plant Types</h2>

        {plants === null ? (
          <div className="text-gray-400 py-12 text-center">Loading...</div>
        ) : plants.length === 0 ? (
          <div className="text-gray-500 py-12 text-center">No plants found for {cat.dbType}</div>
        ) : (
          <div className="grid grid-cols-2 gap-x-8 gap-y-8">
            {plants.map(plant => (
              <div key={plant.plant_id}>
                <Link to={'/plant-knowledgebase/varietals/' + plant.plant_id}>
                  <img
                    src={plantImgSrc(plant)}
                    alt={plant.plant_name}
                    className="object-cover rounded mb-2"
                    loading="lazy"   // ← add this
                    style={{ width: '150px', height: '150px' }}
                    onError={e => { e.target.src = '/images/PlantDBHome.webp'; }}
                  />
                </Link>
                <Link
                  to={'/plant-knowledgebase/varietals/' + plant.plant_id}
                  className="hover:underline text-sm font-medium block mb-1"
                  style={{ color: '#3D6B34' }}
                >
                  {plant.plant_name} ({plant.variety_count} Varieties)
                </Link>
                <p className="text-sm text-gray-700 leading-relaxed">{plant.plant_description}</p>
              </div>
            ))}
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}