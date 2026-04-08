import React, { useEffect, useState } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API = import.meta.env.VITE_API_URL || '';

export default function ServiceDetail() {
  const { servicesId } = useParams();
  const navigate = useNavigate();
  const [svc, setSvc]           = useState(null);
  const [loading, setLoading]   = useState(true);
  const [mainPhoto, setMainPhoto] = useState(null);

  useEffect(() => {
    if (!servicesId) return;
    fetch(`${API}/api/services/public/${servicesId}`)
      .then(r => r.ok ? r.json() : null)
      .then(d => {
        setSvc(d);
        if (d?.photos?.length) setMainPhoto(d.photos[0]);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, [servicesId]);

  if (loading) return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      <div className="max-w-4xl mx-auto px-4 py-16 text-center text-gray-400">Loading…</div>
      <Footer />
    </div>
  );

  if (!svc) return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      <div className="max-w-4xl mx-auto px-4 py-16 text-center">
        <p className="text-gray-500 mb-4">Service not found.</p>
        <Link to="/services/directory" className="text-[#3D6B34] hover:underline">← Back to Services Directory</Link>
      </div>
      <Footer />
    </div>
  );

  const location = [svc.AddressCity, svc.AddressState].filter(Boolean).join(', ');

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <PageMeta
        title={`${svc.ServiceTitle} | Agricultural Services`}
        description={svc.ServiceDescription
          ? svc.ServiceDescription.replace(/<[^>]+>/g, '').slice(0, 155)
          : `${svc.ServiceTitle}${location ? ` in ${location}` : ''}${svc.ServicesCategory ? ` — ${svc.ServicesCategory}` : ''}. Find agricultural services on Oatmeal Farm Network.`}
        image={mainPhoto || undefined}
        ogType="article"
      />
      <Header />

      <div className="max-w-5xl mx-auto px-4 py-8">

        {/* Breadcrumb */}
        <div className="text-sm text-gray-500 mb-6 flex items-center gap-1 flex-wrap">
          <Link to="/services/directory" className="hover:text-[#3D6B34] hover:underline no-underline text-gray-500">
            Services Directory
          </Link>
          {svc.ServicesCategory && (
            <>
              <span>/</span>
              <Link to={`/services/directory/${svc.ServiceCategoryID}`}
                className="hover:text-[#3D6B34] hover:underline no-underline text-gray-500">
                {svc.ServicesCategory}
              </Link>
            </>
          )}
          <span>/</span>
          <span className="text-gray-700 font-medium">{svc.ServiceTitle}</span>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">

          {/* Left: photos */}
          <div>
            {mainPhoto ? (
              <img src={mainPhoto} alt={svc.ServiceTitle}
                className="w-full rounded-xl object-cover max-h-80 mb-3"
                onError={e => e.target.style.display = 'none'} />
            ) : (
              <div className="w-full rounded-xl bg-gray-100 flex items-center justify-center h-64 mb-3 text-5xl">🔧</div>
            )}

            {/* Thumbnail strip */}
            {svc.photos?.length > 1 && (
              <div className="flex gap-2 flex-wrap">
                {svc.photos.map((p, i) => (
                  <button key={i} onClick={() => setMainPhoto(p)}
                    className={`rounded-lg overflow-hidden border-2 transition-all ${mainPhoto === p ? 'border-[#3D6B34]' : 'border-gray-200'}`}>
                    <img src={p} alt={`Photo ${i + 1}`} className="w-16 h-16 object-cover"
                      onError={e => e.target.style.display = 'none'} />
                  </button>
                ))}
              </div>
            )}
          </div>

          {/* Right: details */}
          <div>
            <h1 className="text-2xl font-bold text-gray-800 mb-1">{svc.ServiceTitle}</h1>

            {svc.ServicesCategory && (
              <Link to={`/services/directory/${svc.ServiceCategoryID}`}
                className="inline-block text-xs font-medium bg-[#3D6B34]/10 text-[#3D6B34] px-3 py-1 rounded-full mb-4 no-underline hover:bg-[#3D6B34]/20">
                {svc.ServicesCategory}
              </Link>
            )}

            {/* Price */}
            <div className="mb-4">
              {svc.ServiceContactForPrice ? (
                <span className="text-lg text-gray-500 italic">Contact for Price</span>
              ) : svc.ServicePrice ? (
                <span className="text-2xl font-bold text-[#3D6B34]">
                  ${parseFloat(svc.ServicePrice).toLocaleString()}
                </span>
              ) : null}
            </div>

            {/* Availability */}
            {svc.ServiceAvailable && (
              <div className="flex items-center gap-2 mb-4 text-sm text-gray-600">
                <svg className="w-4 h-4 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span>{svc.ServiceAvailable}</span>
              </div>
            )}

            {/* Description */}
            {svc.ServicesDescription && (
              <div className="text-gray-700 text-sm leading-relaxed mb-6 whitespace-pre-line">
                {svc.ServicesDescription}
              </div>
            )}

            {/* Provider info */}
            <div className="bg-white border border-gray-200 rounded-xl p-5">
              <p className="text-xs text-gray-400 uppercase tracking-wide mb-2">Service provided by</p>
              <Link to={`/profile?BusinessID=${svc.BizID || svc.BusinessID}`}
                className="font-bold text-gray-800 text-base hover:text-[#3D6B34] no-underline block mb-1">
                {svc.BusinessName}
              </Link>
              {location && <p className="text-sm text-gray-500 mb-2">{location}</p>}
              {svc.ServicePhone && (
                <p className="text-sm text-gray-600 mb-1">
                  📞 <a href={`tel:${svc.ServicePhone}`} className="hover:underline">{svc.ServicePhone}</a>
                </p>
              )}
              {svc.Serviceemail && (
                <p className="text-sm text-gray-600 mb-1">
                  ✉️ <a href={`mailto:${svc.Serviceemail}`} className="hover:underline">{svc.Serviceemail}</a>
                </p>
              )}
              {svc.Servicewebsite && (
                <p className="text-sm text-gray-600 mb-3">
                  🌐 <a href={svc.Servicewebsite.startsWith('http') ? svc.Servicewebsite : `https://${svc.Servicewebsite}`}
                    target="_blank" rel="noopener noreferrer" className="hover:underline">
                    {svc.Servicewebsite}
                  </a>
                </p>
              )}
              <Link to={`/profile?BusinessID=${svc.BizID || svc.BusinessID}`}
                className="inline-block mt-1 bg-[#3D6B34] text-white text-sm font-semibold px-4 py-2 rounded-lg hover:bg-[#2d5226] no-underline transition-colors">
                View Business Profile
              </Link>
            </div>
          </div>
        </div>
      </div>

      <Footer />
    </div>
  );
}
