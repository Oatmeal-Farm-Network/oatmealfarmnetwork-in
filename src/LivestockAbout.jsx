import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function LivestockAbout() {
  const { species } = useParams();
  const [info, setInfo] = useState(null);
  const [colors, setColors] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    window.scrollTo(0, 0);
    fetch(API_URL + '/api/livestock/about/' + species)
      .then(r => r.json())
  .then(data => {
  setInfo(data);
  setColors(data.colors || []);
  console.log('ABOUT DATA:', data);
})
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [species]);

  const label = species ? species.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase()) : '';

  return (
    <div className="min-h-screen font-sans">
      <PageMeta
        title={`About ${label} | Livestock Species Overview`}
        description={`Learn about ${label.toLowerCase()} — history, characteristics, colors, uses, and farming considerations. Part of the Oatmeal Farm Network livestock knowledgebase.`}
        keywords={`${label.toLowerCase()}, ${label.toLowerCase()} farming, ${label.toLowerCase()} history, livestock species`}
        canonical={`https://oatmealfarmnetwork.com/livestock/${species}/about`}
      />
     <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '1.5rem 1rem 3rem' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Knowledgebases', to: '/knowledgebases' },
          { label: 'Livestock Database', to: '/livestock' },
          { label, to: `/livestock/${species}` },
          { label: 'About' },
        ]} />
        {loading ? (
          <div className="text-gray-400 py-12 text-center">Loading...</div>
        ) : !info ? (
          <div className="text-gray-500 py-12 text-center">Information not found.</div>
        ) : (
          <div className="bg-white rounded-lg shadow p-8">

            {/* Page header */}
            <div className="text-center mb-6 pb-4 border-b-2 border-gray-200">
              <h1 className="text-3xl font-bold text-gray-900 flex items-center justify-center gap-3">
                <img
                  src={`/images/${label.replace(/ /g,'')}.webp`}
                  alt={label}
                  loading="lazy"  
                  style={{ width: '40px', height: '40px', objectFit: 'cover', borderRadius: '4px' }}
                  onError={e => { e.target.style.display = 'none'; }}
                />
                About {label}
              </h1>
            </div>

            <Link to={`/livestock/${species}`} className="text-sm font-bold hover:underline block mb-4" style={{ color: '#3D6B34' }}>
              About {label} Breeds
            </Link>

            {/* Main content with floated image */}
            <div className="overflow-hidden mb-6">
              {info.main_image && (
                <div className="float-right ml-6 mb-4 rounded overflow-hidden shadow" style={{ width: '300px' }}>
                  <img
                    src={info.main_image.startsWith('http') ? info.main_image : `/images/${info.main_image}`}
                    alt={label}
                    loading="lazy"  
                    className="w-full"
                    onError={e => { e.target.style.display = 'none'; }}
                  />
                </div>
              )}
              <div
                className="text-sm text-gray-700 leading-relaxed"
                dangerouslySetInnerHTML={{ __html: info.about_html || '' }}
              />
            </div>

            {/* Sub-sections */}
            {info.sections && info.sections.map((section, i) => (
              <div key={i} className="mt-8 clear-both">
                <h2 className="text-2xl font-bold text-gray-800 mb-4">{section.title}</h2>
                <div className="overflow-hidden">
                  {section.image && (
                    <div className="float-left mr-6 mb-4 rounded overflow-hidden shadow" style={{ width: '200px' }}>
                      <img
                        src={section.image.startsWith('http') ? section.image : `/images/${section.image}`}
                        alt={section.title}
                        className="w-full"
                        loading="lazy"  
                        onError={e => { e.target.style.display = 'none'; }}
                      />
                    </div>
                  )}
                  <div
                    className="text-sm text-gray-700 leading-relaxed"
                    dangerouslySetInnerHTML={{ __html: section.content }}
                  />
                </div>
              </div>
            ))}

            {/* Colors */}
            {colors.length > 0 && (
              <div className="mt-8 pt-6 border-t border-gray-200 clear-both">
                <h2 className="text-xl font-bold mb-3" style={{ color: '#4CAF50' }}>{label} Colors</h2>
                <p className="text-sm text-gray-700 mb-2">{label} come in the following colors:</p>
                <ul className="list-disc pl-6 text-sm text-gray-700 space-y-1">
                  {colors.map((c, i) => <li key={i}>{c}</li>)}
                </ul>
              </div>
            )}

            <div className="mt-8 pt-4 border-t border-gray-100">
              <Link to={`/livestock/${species}`} className="text-sm hover:underline" style={{ color: '#3D6B34' }}>
                ← Back to {label} Breeds
              </Link>
            </div>
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
