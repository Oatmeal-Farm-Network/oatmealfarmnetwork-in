import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const SPECIES_IMAGES = {
  'alpacas':      '/images/AlpacasHeader.webp',
  'bison':        '/images/BisonHeader.webp',
  'buffalo':      '/images/BuffaloHeader.webp',
  'camels':       '/images/camelHeader.webp',
  'cattle':       '/images/CattleHeader.webp',
  'chickens':     '/images/ChickenHeader.webp',
  'crocodiles':   '/images/CrocodileHeader.webp',
  'deer':         '/images/DeerHeader.webp',
  'dogs':         '/images/WorkingDogsHeader.webp',
  'donkeys':      '/images/DonkeysHeader.webp',
  'ducks':        '/images/DucksHeader.webp',
  'emus':         '/images/Emus.webp',
  'geese':        '/images/Geese.webp',
  'goats':        '/images/Goats.webp',
  'guinea-fowl':  '/images/Guineafowl.webp',
  'honey-bees':   '/images/HoneyBees.webp',
  'horses':       '/images/cowboy2.webp',
  'llamas':       '/images/Llama2.webp',
  'musk-ox':      '/images/muskox.webp',
  'ostriches':    '/images/Ostrich.webp',
  'pheasants':    '/images/Pheasant.webp',
  'pigs':         '/images/Pig.webp',
  'pigeons':      '/images/Pigeon.webp',
  'quails':       '/images/Quail.webp',
  'rabbits':      '/images/Rabitts.webp',
  'sheep':        '/images/Sheepbreeds.webp',
  'snails':       '/images/Snail.webp',
  'turkeys':      '/images/Turkey.webp',
  'yaks':         '/images/Yak.webp',
};

export default function LivestockBreed() {
  const { species, breedId } = useParams();
  const [breed, setBreed] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    window.scrollTo(0, 0);
    fetch(`${API_URL}/api/livestock/breed/${breedId}`)
      .then(r => r.json())
      .then(data => setBreed(data))
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [breedId]);

  const label = species
    ? species.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase())
    : '';

  const breedImgUrl = breed?.image
    ? (breed.image.startsWith('http') ? breed.image : `/images/${breed.image.replace(/^.*[\\/]/, '')}`)
    : null;

  const heroSrc = SPECIES_IMAGES[species] || '/images/HomepageLivestockDB.webp';

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title={breed ? `${breed.breed} ${label} | Livestock Breed` : `${label} Breed | Livestock Database`}
        description={breed
          ? `Learn about the ${breed.breed} ${label.toLowerCase()} breed — origin, characteristics, and farming uses.`
          : `${label} breed information in the Oatmeal Farm Network livestock database.`}
        image={breedImgUrl}
        ogType="article"
      />
      <Header />

      {/* ── Hero ── */}
      <div className="mx-auto px-4 pt-6" style={{ maxWidth: '1300px' }}>
        <div className="relative w-full overflow-hidden rounded-xl">
          <img
            src={heroSrc}
            alt={label}
            className="w-full object-cover"
            style={{ height: '250px', display: 'block' }}
            loading="eager"
            onError={e => { e.target.src = '/images/HomepageLivestockDB.webp'; }}
          />
          {/* Gradient overlay */}
          <div
            className="absolute inset-0"
            style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }}
          />
          {/* Text */}
          <div className="absolute inset-0 flex flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            {loading ? (
              <div className="bg-gray-200 animate-pulse h-8 rounded w-64" />
            ) : (
              <>
                <p
                  style={{
                    color: '#3D6B34',
                    fontFamily: "'Lora','Times New Roman',serif",
                    fontSize: '0.95rem',
                    fontWeight: '600',
                    margin: '0 0 6px',
                    textTransform: 'uppercase',
                    letterSpacing: '0.05em',
                  }}
                >
                  {label}
                </p>
                <h1
                  style={{
                    color: '#000000',
                    fontFamily: "'Lora','Times New Roman',serif",
                    fontSize: '2rem',
                    fontWeight: 'bold',
                    margin: '0 0 14px',
                    lineHeight: 1.2,
                  }}
                >
                  {breed?.breed || '…'}
                </h1>
                <div>
                  <Link
                    to={`/livestock/${species}`}
                    style={{
                      display: 'inline-block',
                      backgroundColor: '#3D6B34',
                      color: '#fff',
                      fontSize: '0.8rem',
                      fontWeight: 'bold',
                      padding: '7px 18px',
                      borderRadius: '6px',
                      textDecoration: 'none',
                    }}
                  >
                    ← All {label} Breeds
                  </Link>
                </div>
              </>
            )}
          </div>
        </div>
      </div>

      {/* ── Content ── */}
      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>
        {loading ? (
          <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-8 animate-pulse space-y-3">
            <div className="float-right ml-6 mb-4 bg-gray-200 rounded-xl" style={{ width: '300px', height: '220px' }} />
            {[...Array(8)].map((_, i) => (
              <div key={i} className="bg-gray-200 h-3 rounded" style={{ width: i % 3 === 2 ? '75%' : '100%' }} />
            ))}
          </div>
        ) : !breed ? (
          <div className="text-gray-500 py-12 text-center">Breed not found.</div>
        ) : (
          <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-8 overflow-hidden">
            {/* Floated breed image */}
            {breedImgUrl && (
              <div className="float-right ml-6 mb-4" style={{ maxWidth: '300px' }}>
                <img
                  src={breedImgUrl}
                  alt={breed.breed}
                  loading="eager"
                  className="w-full rounded-xl shadow-sm"
                  onError={e => { e.target.parentElement.style.display = 'none'; }}
                />
                {breed.image_caption && (
                  <p
                    className="text-xs text-gray-500 mt-2 text-center"
                    dangerouslySetInnerHTML={{ __html: breed.image_caption }}
                  />
                )}
              </div>
            )}

            {/* Description */}
            <div
              className="text-sm text-gray-700 leading-relaxed"
              dangerouslySetInnerHTML={{ __html: breed.description || '<p>No description available.</p>' }}
            />
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
