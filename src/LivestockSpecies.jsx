import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';


const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const getImageSrc = (image) => {
  if (!image) return null;
  if (image.startsWith('http')) return image;
  const filename = image.replace(/^.*[\\/]/, '');
  return `/images/${filename}`;
};

export default function LivestockSpecies() {
  const { species } = useParams();
  const [speciesInfo, setSpeciesInfo] = useState(null);
  const [breeds, setBreeds] = useState(null);

  useEffect(() => {
    window.scrollTo(0, 0);
    fetch(API_URL + '/api/livestock/species/' + species)
      .then(r => r.json())
      .then(data => {
        setSpeciesInfo(data.species_info || null);
        setBreeds(data.breeds || []);
      })
      .catch(() => setBreeds([]));
  }, [species]);

  const label = species
    ? species.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase())
    : '';

  const pluralTerm = speciesInfo?.plural || label;

  const headerImg = `/images/${label.replace(/ /g, '')}header.webp`;
  const headerImgJpg = `/images/${label.replace(/ /g, '')}header.jpg`;
  const iconImg = `/icons/${label.replace(/ /g, '')}Iconwhite.png`;

  return (
    <div className="min-h-screen bg-white font-sans">
     <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '1rem 1rem 3rem' }}>

        {/* Title with icon */}
        <h1 className="text-2xl font-bold text-gray-900 mb-4 flex items-center gap-2">
          <img
            src={iconImg}
            alt={label}
            style={{ width: '40px', height: '40px', objectFit: 'contain' }}
            onError={e => { e.target.style.display = 'none'; }}
          />
           Breeds of {pluralTerm}
        </h1>

        {/* Intro card */}
        <div >
          <img
            src={headerImg}
            alt={label}
            className="w-full object-cover rounded-lg mb-4"
            style={{ maxHeight: '300px' }}
            onError={e => {
              if (e.target.src !== window.location.origin + headerImgJpg) {
                e.target.src = headerImgJpg;
              } else {
                e.target.style.display = 'none';
              }
            }}
          />

          <div className="flex justify-end">
            <Link to={`/livestock/${species}/about`} className="regsubmit2">
              Learn More About {pluralTerm}
            </Link>
          </div>
        </div>

        {/* Breeds list */}
        <h2 className="text-xl font-bold text-gray-900 mb-4">All {label} Breeds</h2>

        {breeds === null ? (
          <div className="text-gray-400 py-12 text-center">Loading...</div>
        ) : breeds.length === 0 ? (
          <div className="text-gray-400 py-8 text-center">No breeds found.</div>
        ) : (
          <div className="space-y-6">
            {breeds.map((b, i) => (
              <div
                key={b.breed_id}
                className="border border-gray-200 rounded-lg overflow-hidden shadow-sm"
                style={{
                  display: 'grid',
                  gridTemplateColumns: i % 2 === 0 ? '200px 1fr' : '1fr 200px',
                  gridTemplateAreas: i % 2 === 0 ? '"image content"' : '"content image"',
                }}
              >
                {/* Image */}
                <div style={{ gridArea: 'image', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '10px' }}>
                  {b.image ? (
                    <Link to={`/livestock/${species}/breed/${b.breed_id}`}>
                      <img
                        src={getImageSrc(b.image)}
                        alt={b.breed}
                        className="rounded"
                        style={{ maxWidth: '180px', height: 'auto' }}
                        onError={e => { e.target.style.display = 'none'; }}
                      />
                    </Link>
                  ) : null}
                </div>

                {/* Content */}
                <div style={{ gridArea: 'content', backgroundColor: '#EFF3E5', padding: '10px', margin: '20px', borderRadius: '8px', display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
                  <div>
                    <h3 className="font-bold text-lg mb-2" style={{ color: '#3f51b5', borderBottom: '1px solid #eee', paddingBottom: '5px' }}>
                      {b.breed}
                    </h3>
                    <p className="text-sm text-gray-700 leading-relaxed">
                      {b.description
                        ? b.description.replace(/<[^>]+>/g, '').substring(0, 450) + (b.description.length > 450 ? ' ...' : '')
                        : ''}
                    </p>
                  </div>
                  {b.description && b.description.length > 25 && (
                    <div className="flex justify-center mt-4">
                      <Link
                        to={`/livestock/${species}/breed/${b.breed_id}`}
                        className="regsubmit2"
                      >
                        Learn More
                      </Link>
                    </div>
                  )}
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