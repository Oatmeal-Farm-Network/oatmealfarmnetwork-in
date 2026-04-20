import React, { useEffect, useState } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API = import.meta.env.VITE_API_URL || '';

export default function ServicesDirectory() {
  const { categoryId } = useParams();
  const navigate = useNavigate();

  const [categories, setCategories]   = useState([]);
  const [services,   setServices]     = useState([]);
  const [catName,    setCatName]      = useState('');
  const [loading,    setLoading]      = useState(true);

  // Load categories always
  useEffect(() => {
    fetch(`${API}/api/services/categories`)
      .then(r => r.json())
      .then(d => setCategories(Array.isArray(d) ? d : []))
      .catch(() => {});
  }, []);

  // Load services when category changes
  useEffect(() => {
    setLoading(true);
    const url = categoryId
      ? `${API}/api/services/public?category_id=${categoryId}`
      : `${API}/api/services/public`;
    fetch(url)
      .then(r => r.json())
      .then(d => { setServices(Array.isArray(d) ? d : []); setLoading(false); })
      .catch(() => { setServices([]); setLoading(false); });
  }, [categoryId]);

  // Set current category name
  useEffect(() => {
    if (categoryId && categories.length) {
      const cat = categories.find(c => String(c.ServiceCategoryID) === String(categoryId));
      setCatName(cat?.ServicesCategory || '');
    } else {
      setCatName('');
    }
  }, [categoryId, categories]);

  return (
    <div className="min-h-screen bg-gray-50 font-sans flex flex-col">
      <PageMeta
        title={catName ? `${catName} Services | Agricultural Services Directory` : 'Agricultural Services Directory | Find Farm Services'}
        description={catName
          ? `Find ${catName.toLowerCase()} services from farmers, ranchers, and agricultural professionals on Oatmeal Farm Network.`
          : 'Find agricultural services including veterinary care, farm consulting, equipment rental, shearing, farriery, and more. Browse service providers near you.'}
        keywords={catName
          ? `${catName}, ${catName} services, farm services, agricultural ${catName.toLowerCase()}, service providers`
          : 'agricultural services, farm services, veterinary, farriery, shearing, farm consulting, equipment rental, livestock services'}
        canonical={categoryId
          ? `https://oatmealfarmnetwork.com/services/directory/${categoryId}`
          : 'https://oatmealfarmnetwork.com/services/directory'}
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'CollectionPage',
          name: catName ? `${catName} Services` : 'Agricultural Services Directory',
          description: 'Browse farm and agricultural services by category.',
          url: categoryId
            ? `https://oatmealfarmnetwork.com/services/directory/${categoryId}`
            : 'https://oatmealfarmnetwork.com/services/directory',
        }}
      />
      <Header />

      {/* Hero */}
      <div
        className="relative w-full bg-cover bg-center"
        style={{ backgroundImage: "url('/images/Services.webp')", height: '220px' }}
      >
        <div className="absolute inset-0 bg-linear-to-r from-black/60 via-black/30 to-transparent" />
        <div className="relative max-w-6xl mx-auto h-full px-4 flex flex-col justify-center">
          <h1 className="text-3xl md:text-4xl font-bold text-white mb-1">Services Directory</h1>
          <p className="text-white/90 text-sm md:text-base">Browse farm and agricultural services by category.</p>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-4 py-10 flex-grow w-full">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services Directory', to: categoryId ? '/services/directory' : undefined },
          ...(catName ? [{ label: catName }] : []),
        ]} />

        {/* If no category selected — show category grid */}
        {!categoryId ? (
          <>
            {categories.length === 0 ? (
              <div className="text-center py-20 text-gray-400">Loading categories…</div>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
                {categories.map(cat => (
                  <Link
                    key={cat.ServiceCategoryID}
                    to={`/services/directory/${cat.ServiceCategoryID}`}
                    className="bg-white border border-gray-200 rounded-xl p-5 shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all flex items-start gap-4 no-underline"
                  >
                    <div className="w-10 h-10 rounded-full bg-[#3D6B34]/10 flex items-center justify-center shrink-0">
                      <svg className="w-5 h-5 text-[#3D6B34]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                      </svg>
                    </div>
                    <div>
                      <h3 className="font-semibold text-gray-800 text-base mb-0.5">{cat.ServicesCategory}</h3>
                      <p className="text-xs text-gray-500">View all services in this category</p>
                    </div>
                  </Link>
                ))}
              </div>
            )}
          </>
        ) : (
          /* Category selected — show services list */
          <>
            <div className="flex items-center gap-4 mb-8 flex-wrap">
              <h1 className="text-3xl font-bold text-gray-800">{catName || 'Services'}</h1>
              {/* Category filter chips */}
              <div className="flex gap-2 flex-wrap">
                {categories.map(cat => (
                  <Link
                    key={cat.ServiceCategoryID}
                    to={`/services/directory/${cat.ServiceCategoryID}`}
                    className={`px-3 py-1 rounded-full text-xs font-medium transition-colors no-underline ${
                      String(cat.ServiceCategoryID) === String(categoryId)
                        ? 'bg-[#3D6B34] text-white'
                        : 'bg-white border border-gray-200 text-gray-600 hover:border-[#3D6B34] hover:text-[#3D6B34]'
                    }`}
                  >
                    {cat.ServicesCategory}
                  </Link>
                ))}
              </div>
            </div>

            {loading ? (
              <div className="text-center py-20 text-gray-400">Loading services…</div>
            ) : services.length === 0 ? (
              <div className="bg-white rounded-xl border border-gray-200 p-16 text-center text-gray-400">
                <p className="mb-3">No services listed in this category yet.</p>
                <Link to="/services/directory" className="text-[#3D6B34] hover:underline text-sm">← All Categories</Link>
              </div>
            ) : (
              <div className="space-y-4">
                {services.map(svc => (
                  <Link
                    key={svc.ServicesID}
                    to={`/services/public/${svc.ServicesID}`}
                    className="bg-white border border-gray-200 rounded-xl p-5 shadow-sm hover:shadow-md transition-all flex gap-5 items-start no-underline group"
                  >
                    {svc.Photo1 ? (
                      <img src={svc.Photo1} alt={svc.ServiceTitle}
                        className="w-20 h-20 rounded-lg object-cover shrink-0"
                        onError={e => e.target.style.display = 'none'} />
                    ) : (
                      <div className="w-20 h-20 rounded-lg bg-gray-100 flex items-center justify-center shrink-0 text-2xl">🔧</div>
                    )}
                    <div className="flex-grow min-w-0">
                      <h3 className="font-bold text-gray-800 text-lg group-hover:text-[#3D6B34] transition-colors mb-0.5">
                        {svc.ServiceTitle}
                      </h3>
                      <p className="text-sm text-gray-500 mb-1">{svc.BusinessName}</p>
                      {svc.ServicesDescription && (
                        <p className="text-sm text-gray-600 line-clamp-2">{svc.ServicesDescription}</p>
                      )}
                    </div>
                    <div className="text-right shrink-0">
                      {svc.ServiceContactForPrice ? (
                        <span className="text-sm text-gray-500 italic">Contact for Price</span>
                      ) : svc.ServicePrice ? (
                        <span className="text-base font-bold text-[#3D6B34]">
                          ${parseFloat(svc.ServicePrice).toLocaleString()}
                        </span>
                      ) : null}
                      {svc.ServiceAvailable && (
                        <p className="text-xs text-gray-400 mt-1">{svc.ServiceAvailable}</p>
                      )}
                    </div>
                  </Link>
                ))}
              </div>
            )}
          </>
        )}

        {/* Sidebar: all categories when viewing a category */}
        {categoryId && (
          <div className="mt-8 pt-6 border-t border-gray-200">
            <Link to="/services/directory" className="text-sm text-[#3D6B34] hover:underline">
              ← Back to All Categories
            </Link>
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
