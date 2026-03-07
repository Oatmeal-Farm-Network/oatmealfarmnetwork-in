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
  const [availableLetters, setAvailableLetters] = useState([]);
  const [selectedLetter, setSelectedLetter] = useState(null);
  const [breeds, setBreeds] = useState(null);
  const [loadingBreeds, setLoadingBreeds] = useState(false);

  // On species change: load species info + available letters
  useEffect(() => {
    window.scrollTo(0, 0);
    setSpeciesInfo(null);
    setBreeds(null);
    setSelectedLetter(null);
    setAvailableLetters([]);

    fetch(API_URL + '/api/livestock/species/' + species + '/letters')
      .then(r => r.json())
      .then(data => {
        setSpeciesInfo(data.species_info || null);
        const letters = data.letters || [];
        setAvailableLetters(letters);
        // Auto-select first available letter
        if (letters.length > 0) {
          setSelectedLetter(letters[0]);
        }
      })
      .catch(() => {});
  }, [species]);

  // When selected letter changes: fetch breeds for that letter
  useEffect(() => {
    if (!selectedLetter) return;
    setBreeds(null);
    setLoadingBreeds(true);
    fetch(API_URL + '/api/livestock/species/' + species + '?letter=' + encodeURIComponent(selectedLetter))
      .then(r => r.json())
      .then(data => {
        setBreeds(data.breeds || []);
        setLoadingBreeds(false);
      })
      .catch(() => { setBreeds([]); setLoadingBreeds(false); });
  }, [species, selectedLetter]);

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

        {/* Header image */}
        <div style={{ width: '100%', height: '300px', backgroundColor: '#f3f4f6', borderRadius: '8px', marginBottom: '1rem', overflow: 'hidden' }}>
          <img
            src={headerImg}
            alt={label}
            style={{ width: '100%', height: '300px', objectFit: 'cover', display: 'block' }}
            onError={e => {
              if (e.target.src !== window.location.origin + headerImgJpg) {
                e.target.src = headerImgJpg;
              } else {
                e.target.parentElement.style.display = 'none';
              }
            }}
          />
        </div>

        <div className="flex justify-end mb-6">
          <Link to={`/livestock/${species}/about`} className="regsubmit2">
            Learn More About {pluralTerm}
          </Link>
        </div>

        {/* Breeds section */}
        <h2 className="text-xl font-bold text-gray-900 mb-4">
          All {label} Breeds
        </h2>

        {/* Letter selector */}
        {availableLetters.length > 0 && (
          <div className="flex flex-wrap gap-1 mb-6 p-3 bg-gray-50 rounded-lg border border-gray-300">
            {availableLetters.map(letter => (
              <button
                key={letter}
                onClick={() => setSelectedLetter(letter)}
                className="w-9 h-9 text-sm font-bold rounded transition-all"
                style={{
                  backgroundColor: selectedLetter === letter ? '#3D6B34' : '#fff',
                  color: selectedLetter === letter ? '#fff' : '#3D6B34',
                  border: '1px solid #3D6B34',
                }}
              >
                {letter}
              </button>
            ))}
          </div>
        )}

        {/* Breeds list */}
        {loadingBreeds ? (
          <div className="text-gray-400 py-12 text-center">Loading breeds...</div>
        ) : breeds === null ? (
          <div className="text-gray-400 py-12 text-center">Select a letter above to browse breeds.</div>
        ) : breeds.length === 0 ? (
          <div className="text-gray-400 py-8 text-center">No breeds found for "{selectedLetter}".</div>
        ) : (
          <div className="space-y-4">
            {breeds.map((b, i) => (
              <div
                key={b.breed_id}
                className="border border-gray-400 rounded-lg overflow-hidden shadow-sm flex gap-0"
              style={{
                display: 'grid',
                gridTemplateColumns: i % 2 === 0 ? '200px 1fr' : '1fr 200px',
                gridTemplateAreas: i % 2 === 0 ? '"image content"' : '"content image"',
              }}
              >
                {/* Image */}
               <div style={{
                gridArea: 'image',
                width: '200px',
                flexShrink: 0,
                backgroundColor: '#f9fafb',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                padding: '8px',
              }}>
                {b.image ? (
                  <Link to={`/livestock/${species}/breed/${b.breed_id}`}>
                    <img
                      src={getImageSrc(b.image)}
                      alt={b.breed}
                      loading="lazy"
                      style={{ width: '184px', height: 'auto', objectFit: 'contain', display: 'block' }}
                      onError={e => { e.target.parentElement.style.display = 'none'; }}
                    />
                  </Link>
                ) : (
                  <span className="text-gray-300 text-xs text-center px-2">No image</span>
                )}
              </div>

                {/* Content */}
                <div style={{
                  gridArea: 'content',
                  backgroundColor: '#EFF3E5',
                  padding: '14px 16px',
                  margin: '12px',
                  borderRadius: '8px',
                  display: 'flex',
                  flexDirection: 'column',
                  justifyContent: 'space-between',
                }}>
                  <div>
                    <h3 className="font-bold text-base mb-2" style={{ color: '#3f51b5', borderBottom: '1px solid #ddd', paddingBottom: '5px' }}>
                      {b.breed}
                    </h3>
                    {b.description && (
                      <p className="text-sm text-gray-700 leading-relaxed">
                        {b.description.replace(/<[^>]+>/g, '').substring(0, 350)}
                        {b.description.length > 350 ? '...' : ''}
                      </p>
                    )}
                  </div>
                  {b.description && b.description.length > 25 && (
                    <div className="flex justify-center mt-3">
                      <Link to={`/livestock/${species}/breed/${b.breed_id}`} className="regsubmit2">
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
