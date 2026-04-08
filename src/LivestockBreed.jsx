import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function BreedSkeleton() {
  return (
    <div className="animate-pulse">
      {/* Header skeleton */}
      <div className="flex items-center gap-3 mb-6 pb-4 border-b border-gray-200">
        <div className="bg-gray-200 rounded" style={{ width: '40px', height: '40px', flexShrink: 0 }} />
        <div className="bg-gray-200 h-7 rounded w-64" />
      </div>
      {/* Floated image skeleton */}
      <div className="float-right ml-6 mb-4 bg-gray-200 rounded" style={{ width: '300px', height: '220px' }} />
      {/* Text skeleton */}
      <div className="space-y-3 overflow-hidden">
        {[...Array(8)].map((_, i) => (
          <div key={i} className="bg-gray-200 h-3 rounded" style={{ width: i % 3 === 2 ? '75%' : '100%' }} />
        ))}
      </div>
    </div>
  );
}

export default function LivestockBreed() {
  const { species, breedId } = useParams();
  const [breed, setBreed] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    window.scrollTo(0, 0);
    fetch(API_URL + '/api/livestock/breed/' + breedId)
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
    : undefined;

  return (
    <div className="min-h-screen bg-white font-sans">
      <PageMeta
        title={breed ? `${breed.breed} ${label} | Livestock Breed` : `${label} Breed | Livestock Database`}
        description={breed
          ? `Learn about the ${breed.breed} ${label.toLowerCase()} breed — origin, characteristics, and farming uses. Find ${breed.breed} listings on Oatmeal Farm Network.`
          : `${label} breed information in the Oatmeal Farm Network livestock database.`}
        image={breedImgUrl}
        ogType="article"
      />
      <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '1.5rem 1rem 3rem' }}>
        {loading ? (
          <BreedSkeleton />
        ) : !breed ? (
          <div className="text-gray-500 py-12 text-center">Breed not found.</div>
        ) : (
          <>
            {/* Header */}
            <div className="flex items-center gap-3 mb-6 pb-4 border-b border-gray-200">
              <img
                src={`/images/${label.replace(/ /g, '')}.webp`}
                alt={label}
                loading="eager"
                fetchPriority="high"
                style={{ width: '40px', height: '40px', objectFit: 'cover', borderRadius: '4px' }}
                onError={e => { e.target.style.display = 'none'; }}
              />
              <h1 className="text-2xl font-bold text-gray-900">About {breed.breed} {label}</h1>
            </div>

            {/* Content with floated image */}
            <div className="overflow-hidden">
              {breed.image && (
                <div className="float-right ml-6 mb-4" style={{ width: '300px' }}>
                  <img
                    src={breed.image.startsWith('http') ? breed.image : `/images/${breed.image.replace(/^.*[\\/]/, '')}`}
                    alt={breed.breed}
                    loading="eager"
                    fetchPriority="high"
                    className="w-full rounded shadow"
                    onError={e => { e.target.style.display = 'none'; }}
                  />
                  {breed.image_caption && (
                    <p
                      className="text-xs text-gray-500 mt-1 text-center"
                      dangerouslySetInnerHTML={{ __html: breed.image_caption }}
                    />
                  )}
                </div>
              )}
              <div
                className="text-sm text-gray-700 leading-relaxed"
                dangerouslySetInnerHTML={{ __html: breed.description || '<p>No description available.</p>' }}
              />
            </div>

            {/* Back link */}
            <div className="mt-8 pt-4 border-t border-gray-100">
              <Link to={`/livestock/${species}`} className="text-sm hover:underline" style={{ color: '#3D6B34' }}>
                ← Back to {label} Breeds
              </Link>
            </div>
          </>
        )}
      </div>

      <Footer />
    </div>
  );
}