import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const CATEGORIES = [
  { key: 'Algaes',         label: 'Algae',           img: '/images/Algae.webp',         path: '/plant-knowledgebase/algae',          desc: 'Ancient, tide-kissed, and quietly extraordinary — seaweeds and microalgae carry the flavor of the open ocean into broths, salads, and supplements unlike anything grown on land.' },
  { key: 'Berries',        label: 'Berries',          img: '/images/Berries.webp',        path: '/plant-knowledgebase/berries',         desc: 'There is something almost magical about a perfectly ripe berry — the way a blueberry bursts, a raspberry melts, or a sun-warmed strawberry tastes like summer itself.' },
  { key: 'Bulbs',          label: 'Bulbs',            img: '/images/Bulbs.webp',          path: '/plant-knowledgebase/bulbs',           desc: "Onions caramelized low and slow until golden, garlic roasted until it becomes something sweet and almost spiritual — bulbs are the soulful foundation that makes everything else taste better." },
  { key: 'Corms',          label: 'Corms',            img: '/images/Corms.webp',          path: '/plant-knowledgebase/corms',           desc: 'Humble and ancient, corms like taro and water chestnuts have nourished whole civilizations — their quiet starchiness a canvas for bold flavors across generations of cooks.' },
  { key: 'Culinary Herbs', label: 'Culinary Herbs',   img: '/images/CulinaryHerbs.webp',  path: '/plant-knowledgebase/culinary-herbs',  desc: 'A handful of fresh basil torn over warm tomatoes, a fistful of cilantro stirred into a broth at the last moment — herbs are how a cook says "I care" without uttering a word.' },
  { key: 'Edible Flowers', label: 'Edible Flowers',   img: '/images/EdibleFlowers.webp',  path: '/plant-knowledgebase/edible-flowers',  desc: 'Lavender, nasturtium, rose — edible flowers are proof that the most beautiful things in a garden can also be the most delicious, turning every dish into something that stops people mid-bite.' },
  { key: 'Fruits',         label: 'Fruits',           img: '/images/Fruit.webp',          path: '/plant-knowledgebase/fruits',          desc: 'From a mango so ripe it drips down your wrist to a crisp apple that snaps clean on an autumn morning — fruit is nature at its most generous, sweet, and alive.' },
  { key: 'Ginkgoes',       label: 'Ginkgos',          img: '/images/Ginko.webp',          path: '/plant-knowledgebase/ginkgos',         desc: 'Survivors of the age of dinosaurs, ginkgo trees carry 200 million years of resilience in their fan-shaped leaves and quietly remarkable edible nuts.' },
  { key: 'Grains',         label: 'Grains',           img: '/images/Grains.webp',         path: '/plant-knowledgebase/grains',          desc: "Every loaf of bread, every bowl of rice, every plate of pasta begins with a grain — these small seeds carry the weight of human history and the warmth of a billion home-cooked meals." },
  { key: 'Grasses',        label: 'Grasses',          img: '/images/Grasses.webp',        path: '/plant-knowledgebase/grasses',         desc: 'The vast, wind-rippled fields of wheat and the tender shoots of wheatgrass — grasses feed the world quietly and completely, covering the earth in a living, breathing harvest.' },
  { key: 'Leafy Greens',   label: 'Leafy Greens',     img: '/images/LeafyGreens.webp',    path: '/plant-knowledgebase/leafy-greens',    desc: "There's a reason every grandmother urged you to eat your greens — spinach wilted in garlic butter, young kale massaged with lemon, tender lettuce barely touched with vinaigrette. They make you feel alive." },
  { key: 'Legumes',        label: 'Legumes',          img: '/images/Legumes.jpg',         path: '/plant-knowledgebase/legumes',         desc: 'A pot of lentils simmering with cumin and onion, a bowl of black beans slow-cooked since morning — legumes are patient, generous, and the kind of ingredient that feels like a warm embrace.' },
  { key: 'Medicinal Herb', label: 'Medicinal Herbs',  img: '/images/MedicinalHerbs.webp', path: '/plant-knowledgebase/medicinal-herbs', desc: 'Long before pharmacies, there were gardens — chamomile to calm, echinacea to strengthen, valerian to quiet the mind. Medicinal herbs are humanity\'s oldest form of care.' },
  { key: 'Mushroom',       label: 'Mushrooms',        img: '/images/Mushrooms.webp',      path: '/plant-knowledgebase/mushrooms',       desc: 'There is nothing in the food world quite like the deep, woodsy umami of a chanterelle sautéed in butter, or a shiitake that makes a broth taste like it has been cooking for days.' },
  { key: 'Nut',            label: 'Nuts',             img: '/images/Nuts.webp',           path: '/plant-knowledgebase/nuts',            desc: 'Toasted walnuts warm from the oven, creamy almond butter on morning toast, a single perfect pecan in the center of a praline — nuts are small, but they carry enormous joy.' },
  { key: 'Palms',          label: 'Palms',            img: '/images/Palms.webp',          path: '/plant-knowledgebase/palms',           desc: 'The coconut cracked open on a beach, dates so sweet they taste like dessert pulled straight from the tree — palms are the taste of warmth, sun, and abundance.' },
  { key: 'Pseudocereal',   label: 'Pseudocereals',    img: '/images/Psuodcereals.webp',   path: '/plant-knowledgebase/pseudocereals',   desc: 'Quinoa and amaranth fed the Inca and Aztec empires for centuries — these resilient, protein-rich seeds are having a well-deserved renaissance in kitchens around the world.' },
  { key: 'Rhizomes',       label: 'Rhizomes',         img: '/images/Rhizomes.webp',       path: '/plant-knowledgebase/rhizomes',        desc: 'Fresh ginger grated into a sauce that suddenly sings, turmeric turning a broth a vivid gold — rhizomes grow hidden underground but announce themselves boldly in every dish they touch.' },
  { key: 'Root',           label: 'Root Vegetables',  img: '/images/RootVegetables.webp', path: '/plant-knowledgebase/root-vegetables', desc: 'Pulled from dark soil, scrubbed clean, and roasted until caramelized at the edges — root vegetables are honest, grounding food that connects us to the earth with every bite.' },
  { key: 'Spices',         label: 'Spices',           img: '/images/Spices.webp',         path: '/plant-knowledgebase/spices',          desc: 'Cinnamon that makes a kitchen smell like belonging, cardamom that transports you somewhere ancient, smoked paprika that whispers of fire — spices are emotion in powdered form.' },
  { key: 'Tubers',         label: 'Tubers',           img: '/images/Tubers.webp',         path: '/plant-knowledgebase/tubers',          desc: "Crispy roasted potatoes with flaky salt, silky sweet potato mash on a cold night, chewy cassava flatbread — tubers are the world's most comforting food, buried treasure waiting to be found." },
  { key: 'Vegetable',      label: 'Vegetables',       img: '/images/Vegetables.webp',     path: '/plant-knowledgebase/vegetables',      desc: 'Asparagus in spring, corn in summer, squash in autumn — vegetables mark the seasons better than any calendar, and a garden at peak harvest is one of life\'s great pleasures.' },
];

const EAGER_COUNT = 4;

export default function PlantKnowledgebase() {
  const [counts, setCounts] = useState({});
  const [total, setTotal]   = useState(0);

  useEffect(() => {
    fetch(`${API_URL}/api/plant-knowledgebase/counts`)
      .then(r => r.ok ? r.json() : {})
      .then(data => {
        setCounts(data.counts || {});
        setTotal(data.total || 0);
      })
      .catch(() => {});
  }, []);

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Online Plant Database | 4,000+ Food Plant Varieties"
        description="Browse over 4,000 food plant varieties across 22 categories including grains, berries, legumes, and herbs. Find growing guides, soil requirements, and nutritional data."
        keywords="plant database, food plants, edible plant varieties, vegetables, grains, herbs, fruits, berries, legumes"
        canonical="https://oatmealfarmnetwork.com/plant-knowledgebase"
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'CollectionPage',
          name: 'Online Plant Knowledgebase',
          url: 'https://oatmealfarmnetwork.com/plant-knowledgebase',
          description: 'Comprehensive database of food plant varieties across 22 categories.'
        }}
      />
      <Header />

      {/* ── Hero ── */}
      <div className="mx-auto px-4 pt-2 md:pt-6" style={{ maxWidth: '1300px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Knowledgebases', to: '/knowledgebases' },
          { label: 'Plant Knowledgebase' },
        ]} />

        {/* Image — shorter on mobile, taller on desktop */}
        <div className="relative w-full overflow-hidden rounded-xl rounded-b-none md:rounded-b-xl">
          <img
            src="/images/PlantDBHeader.webp"
            alt="Online Plant Knowledgebase"
            className="w-full object-cover block h-[160px] md:h-[250px]"
            loading="eager"
          />
          {/* Gradient + text overlay — desktop only */}
          <div className="hidden md:block absolute inset-0" style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }} />
          <div className="hidden md:flex absolute inset-0 flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '2rem', fontWeight: 'bold', margin: '0 0 12px', lineHeight: 1.2 }}>
              Online Plant Knowledgebase
            </h1>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: '0 0 8px', lineHeight: 1.6 }}>
              There are thousands of varieties of plants grown for food, we have documented{' '}
              <strong>{total > 0 ? `${total.toLocaleString()} Varieties` : '…'}</strong>{' '}
              so far. We have the mission to list them all here.
            </p>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: 0, lineHeight: 1.6 }}>
              We are consistently adding more information and photos to the list, and we are always finding more varieties.
              If you would like to help out with photos, descriptions, or correcting errors please{' '}
              <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>
              {' '}and let us know — the more people we have helping, the more complete the information.
            </p>
          </div>
        </div>

        {/* Text below image — mobile only */}
        <div className="md:hidden bg-white px-5 py-4 rounded-b-xl border border-t-0 border-gray-200">
          <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '1.4rem', fontWeight: 'bold', margin: '0 0 8px', lineHeight: 1.2 }}>
            Online Plant Knowledgebase
          </h1>
          <p style={{ color: '#111111', fontSize: '0.85rem', margin: '0 0 6px', lineHeight: 1.6 }}>
            There are thousands of varieties of plants grown for food, we have documented{' '}
            <strong>{total > 0 ? `${total.toLocaleString()} Varieties` : '…'}</strong>{' '}
            so far.
          </p>
          <p style={{ color: '#111111', fontSize: '0.85rem', margin: 0, lineHeight: 1.6 }}>
            If you'd like to help with photos or descriptions, please{' '}
            <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>.
          </p>
        </div>

      </div>

      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        {/* ── Section heading ── */}
        <h2 className="text-lg font-bold text-gray-900 mb-5">Categories of Food Plants</h2>

        {/* ── 2-column grid of horizontal cards (image left, text right) ── */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
          {CATEGORIES.map((cat, index) => {
            const count = counts[cat.key] || 0;
            return (
              <div
                key={cat.key}
                className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200"
              >
                {/* Left: square image */}
                <Link to={cat.path} className="shrink-0 overflow-hidden" style={{ width: '155px', height: '155px' }}>
                  <img
                    src={cat.img}
                    alt={cat.label}
                    width="155"
                    height="155"
                    loading={index < EAGER_COUNT ? 'eager' : 'lazy'}
                    decoding={index < EAGER_COUNT ? 'sync' : 'async'}
                    className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                  />
                </Link>

                {/* Right: text content */}
                <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                  <div>
                    <Link
                      to={cat.path}
                      className="font-bold text-sm hover:underline"
                      style={{ color: '#3D6B34' }}
                    >
                      {cat.label}
                    </Link>
                    <p
                      className="text-xs font-semibold mt-0.5 mb-2"
                      style={{ color: '#819360' }}
                    >
                      {count > 0 ? `${count.toLocaleString()} Varieties` : '—'}
                    </p>
                    <p className="text-xs text-gray-600 leading-relaxed">{cat.desc}</p>
                  </div>
                  <div className="mt-3">
                    <Link
                      to={cat.path}
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

      </div>

      <Footer />
    </div>
  );
}
