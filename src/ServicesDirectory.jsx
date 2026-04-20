import React, { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API = import.meta.env.VITE_API_URL || '';
const FALLBACK_IMG = '/images/Services.webp';
const EAGER_COUNT = 4;

export default function ServicesDirectory() {
  const { categoryId } = useParams();

  const [categories, setCategories] = useState([]);
  const [services,   setServices]   = useState([]);
  const [catName,    setCatName]    = useState('');
  const [loading,    setLoading]    = useState(true);

  useEffect(() => {
    fetch(`${API}/api/services/categories`)
      .then(r => r.json())
      .then(d => setCategories(Array.isArray(d) ? d : []))
      .catch(() => {});
  }, []);

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

  useEffect(() => {
    if (categoryId && categories.length) {
      const cat = categories.find(c => String(c.ServiceCategoryID) === String(categoryId));
      setCatName(cat?.ServicesCategory || '');
    } else {
      setCatName('');
    }
  }, [categoryId, categories]);

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8' }}>
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

      {/* ── Hero ── */}
      <div className="mx-auto px-4 pt-2 md:pt-6 w-full" style={{ maxWidth: '1300px' }}>
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Services Directory', to: categoryId ? '/services/directory' : undefined },
          ...(catName ? [{ label: catName }] : []),
        ]} />

        <div className="relative w-full overflow-hidden rounded-xl rounded-b-none md:rounded-b-xl">
          <img
            src="/images/ServiceDirectory.webp"
            alt="Agricultural Services Directory"
            className="w-full object-cover block h-[160px] md:h-[250px]"
            loading="eager"
          />
          <div className="hidden md:block absolute inset-0" style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }} />
          <div className="hidden md:flex absolute inset-0 flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '2rem', fontWeight: 'bold', margin: '0 0 12px', lineHeight: 1.2 }}>
              {catName || 'Agricultural Services Directory'}
            </h1>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: '0 0 8px', lineHeight: 1.6 }}>
              From veterinarians and farriers to shearing, equipment rental, and farm consulting — connect with{' '}
              <strong>{categories.length > 0 ? `${categories.length} service categories` : '…'}</strong>{' '}
              of agricultural professionals serving farms and ranches.
            </p>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: 0, lineHeight: 1.6 }}>
              Listings are added regularly. If you'd like to list a service or help us grow the directory, please{' '}
              <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>.
            </p>
          </div>
        </div>

        <div className="md:hidden bg-white px-5 py-4 rounded-b-xl border border-t-0 border-gray-200">
          <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '1.4rem', fontWeight: 'bold', margin: '0 0 8px', lineHeight: 1.2 }}>
            {catName || 'Agricultural Services Directory'}
          </h1>
          <p style={{ color: '#111111', fontSize: '0.85rem', margin: '0 0 6px', lineHeight: 1.6 }}>
            Connect with <strong>{categories.length > 0 ? `${categories.length} categories` : '…'}</strong> of
            agricultural professionals serving farms and ranches.
          </p>
          <p style={{ color: '#111111', fontSize: '0.85rem', margin: 0, lineHeight: 1.6 }}>
            Want to list a service?{' '}
            <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>.
          </p>
        </div>
      </div>

      <div className="mx-auto px-4 py-8 w-full flex-grow" style={{ maxWidth: '1300px' }}>

        {!categoryId ? (
          <>
            <h2 className="text-lg font-bold text-gray-900 mb-5">Service Categories</h2>

            {categories.length === 0 ? (
              <div className="text-center py-20 text-gray-400">Loading categories…</div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                {categories.map((cat, index) => (
                  <div
                    key={cat.ServiceCategoryID}
                    className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200"
                  >
                    <Link
                      to={`/services/directory/${cat.ServiceCategoryID}`}
                      className="shrink-0 overflow-hidden"
                      style={{ width: '155px', height: '155px' }}
                    >
                      <img
                        src={FALLBACK_IMG}
                        alt={cat.ServicesCategory}
                        width="155"
                        height="155"
                        loading={index < EAGER_COUNT ? 'eager' : 'lazy'}
                        decoding={index < EAGER_COUNT ? 'sync' : 'async'}
                        className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                      />
                    </Link>

                    <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                      <div>
                        <Link
                          to={`/services/directory/${cat.ServiceCategoryID}`}
                          className="font-bold text-sm hover:underline"
                          style={{ color: '#3D6B34' }}
                        >
                          {cat.ServicesCategory}
                        </Link>
                        <p className="text-xs text-gray-600 leading-relaxed mt-2">
                          Find {cat.ServicesCategory.toLowerCase()} professionals offering services to farmers, ranchers, and agricultural businesses.
                        </p>
                      </div>
                      <div className="mt-3">
                        <Link
                          to={`/services/directory/${cat.ServiceCategoryID}`}
                          className="text-xs font-bold hover:underline"
                          style={{ color: '#3D6B34' }}
                        >
                          EXPLORE →
                        </Link>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </>
        ) : (
          <>
            <div className="flex items-center gap-3 flex-wrap mb-5">
              <Link to="/services/directory" className="text-sm text-[#3D6B34] hover:underline">
                ← All Categories
              </Link>
              <span className="text-gray-300">|</span>
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
              <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                {services.map((svc, index) => (
                  <div
                    key={svc.ServicesID}
                    className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200"
                  >
                    <Link
                      to={`/services/public/${svc.ServicesID}`}
                      className="shrink-0 overflow-hidden"
                      style={{ width: '155px', height: '155px' }}
                    >
                      <img
                        src={svc.Photo1 || FALLBACK_IMG}
                        alt={svc.ServiceTitle}
                        width="155"
                        height="155"
                        loading={index < EAGER_COUNT ? 'eager' : 'lazy'}
                        decoding={index < EAGER_COUNT ? 'sync' : 'async'}
                        className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                        onError={e => { e.target.onerror = null; e.target.src = FALLBACK_IMG; }}
                      />
                    </Link>

                    <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                      <div>
                        <Link
                          to={`/services/public/${svc.ServicesID}`}
                          className="font-bold text-sm hover:underline block"
                          style={{ color: '#3D6B34' }}
                        >
                          {svc.ServiceTitle}
                        </Link>
                        <p className="text-xs font-semibold mt-0.5" style={{ color: '#819360' }}>
                          {svc.BusinessName}
                        </p>
                        {svc.ServicesDescription && (
                          <p className="text-xs text-gray-600 leading-relaxed mt-2 line-clamp-3">
                            {svc.ServicesDescription}
                          </p>
                        )}
                      </div>
                      <div className="mt-3 flex items-end justify-between gap-2">
                        <Link
                          to={`/services/public/${svc.ServicesID}`}
                          className="text-xs font-bold hover:underline"
                          style={{ color: '#3D6B34' }}
                        >
                          VIEW →
                        </Link>
                        <div className="text-right shrink-0">
                          {svc.ServiceContactForPrice ? (
                            <span className="text-xs text-gray-500 italic">Contact for Price</span>
                          ) : svc.ServicePrice ? (
                            <span className="text-sm font-bold text-[#3D6B34]">
                              ${parseFloat(svc.ServicePrice).toLocaleString()}
                            </span>
                          ) : null}
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </>
        )}
      </div>

      <Footer />
    </div>
  );
}
