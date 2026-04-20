import React, { useEffect, useState } from 'react';
import { useParams, Link, useSearchParams, useNavigate, useLocation } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import { useAccount } from './AccountContext';
import { FaFacebookF, FaPinterestP, FaXTwitter, FaInstagram, FaLinkedinIn, FaYoutube, FaGlobe, FaBlog } from 'react-icons/fa6';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';
const GCP = 'https://storage.googleapis.com/oatmeal-farm-network-images/Animals/Uploads';

const SOCIAL_LINKS = [
  { key: 'facebook',    label: 'Facebook',    icon: <FaFacebookF />,  base: 'https://facebook.com/',          color: 'bg-[#1877F2]' },
  { key: 'instagram',   label: 'Instagram',   icon: <FaInstagram />,  base: 'https://instagram.com/',         color: 'bg-[#E1306C]' },
  { key: 'linkedin',    label: 'LinkedIn',    icon: <FaLinkedinIn />, base: 'https://linkedin.com/company/',  color: 'bg-[#0A66C2]' },
  { key: 'x',          label: 'Twitter / X', icon: <FaXTwitter />,   base: 'https://twitter.com/',           color: 'bg-black' },
  { key: 'pinterest',  label: 'Pinterest',   icon: <FaPinterestP />, base: 'https://pinterest.com/',         color: 'bg-[#E60023]' },
  { key: 'youtube',    label: 'YouTube',     icon: <FaYoutube />,    base: 'https://youtube.com/',           color: 'bg-[#FF0000]' },
  { key: 'blog',       label: 'Blog',        icon: <FaBlog />,       base: '',                               color: 'bg-[#507033]' },
  { key: 'truth_social',label:'Truth Social', icon: <FaGlobe />,     base: '',                               color: 'bg-[#5b2d8e]' },
  { key: 'other_social1',label:'Social',      icon: <FaGlobe />,     base: '',                               color: 'bg-gray-500' },
  { key: 'other_social2',label:'Social',      icon: <FaGlobe />,     base: '',                               color: 'bg-gray-500' },
];

// ── Contact form ──────────────────────────────────────────────────────────────
function ContactForm({ ranch }) {
  const [form, setForm] = useState({ firstName: '', lastName: '', email: '', phone: '', state: '', country: '', message: '' });
  const [answer, setAnswer] = useState('');
  const [sent, setSent] = useState(false);
  const [error, setError] = useState('');
  const [q] = useState(() => {
    const a = Math.floor(Math.random() * 9) + 1;
    const b = Math.floor(Math.random() * 9) + 1;
    return { a, b, answer: a + b };
  });

  const set = (k) => (e) => setForm(p => ({ ...p, [k]: e.target.value }));

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');
    if (!form.firstName || !form.lastName || !form.email) { setError('Please fill in all required fields.'); return; }
    if (parseInt(answer) !== q.answer) { setError('Math answer is incorrect.'); return; }
    setSent(true);
  };

  if (sent) return (
    <div style={{ backgroundColor: '#d4edda', border: '1px solid #c3e6cb', borderRadius: '8px', padding: '24px', textAlign: 'center' }}>
      <div style={{ fontSize: '2rem', marginBottom: '8px' }}>✓</div>
      <h3 style={{ color: '#155724', margin: '0 0 8px' }}>Message Sent!</h3>
      <p style={{ color: '#155724', margin: 0 }}>Thank you for contacting {ranch.business_name}. They will be in touch soon.</p>
    </div>
  );

  return (
    <form onSubmit={handleSubmit}>
      {error && <div style={{ backgroundColor: '#f8d7da', border: '1px solid #f5c6cb', borderRadius: '4px', padding: '12px', marginBottom: '16px', color: '#721c24', fontSize: '0.9rem' }}>{error}</div>}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px', marginBottom: '12px' }}>
        <div>
          <label style={formLabel}>First Name</label>
          <input value={form.firstName} onChange={set('firstName')} required style={formInput} />
        </div>
        <div>
          <label style={formLabel}>Last Name</label>
          <input value={form.lastName} onChange={set('lastName')} required style={formInput} />
        </div>
      </div>
      <div style={{ marginBottom: '12px' }}>
        <label style={formLabel}>Email</label>
        <input type="email" value={form.email} onChange={set('email')} required style={formInput} />
      </div>
      <div style={{ marginBottom: '12px' }}>
        <label style={formLabel}>Phone <span style={{ color: '#999', fontWeight: 400 }}>(Optional)</span></label>
        <input type="tel" value={form.phone} onChange={set('phone')} style={formInput} />
      </div>
      <div style={{ marginBottom: '12px' }}>
        <label style={formLabel}>State / Province <span style={{ color: '#999', fontWeight: 400 }}>(Optional)</span></label>
        <input value={form.state} onChange={set('state')} style={formInput} />
      </div>
      <div style={{ marginBottom: '12px' }}>
        <label style={formLabel}>Questions / Comments <span style={{ color: '#999', fontWeight: 400 }}>(Optional)</span></label>
        <textarea value={form.message} onChange={set('message')} rows={5} style={{ ...formInput, resize: 'vertical' }} />
      </div>
      <div style={{ backgroundColor: '#f8f8f8', border: '1px solid #e0e0e0', borderRadius: '8px', padding: '16px', marginBottom: '16px' }}>
        <p style={{ margin: '0 0 10px', fontWeight: 600, fontSize: '0.9rem' }}>Human Verification</p>
        <p style={{ margin: '0 0 10px', fontSize: '0.85rem', color: '#666' }}>Answer the simple math question below.</p>
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          <span style={{ fontSize: '1.1rem', fontWeight: 'bold' }}>{q.a} + {q.b} =</span>
          <input type="number" value={answer} onChange={e => setAnswer(e.target.value)}
            placeholder="?" style={{ width: '70px', padding: '8px', border: '1px solid #ccc', borderRadius: '4px', fontSize: '1rem', textAlign: 'center' }} />
        </div>
      </div>
      <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
        <button type="submit" style={{ padding: '12px 32px', backgroundColor: '#819360', color: '#fff', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 700, fontSize: '1rem' }}>
          Send Message
        </button>
      </div>
    </form>
  );
}

// ── Animal card ───────────────────────────────────────────────────────────────
function AnimalCard({ animal, isStuds }) {
  const [imgFailed, setImgFailed] = useState(false);
  const detailUrl = `/livestockmarketplace/Animals/Details.asp?ID=${animal.animal_id}`;
  const priceVal = isStuds ? animal.stud_fee : animal.price;

  return (
    <div style={{ border: '1px solid #e8e8e8', borderRadius: '8px', overflow: 'hidden', backgroundColor: '#fff', boxShadow: '0 1px 3px rgba(0,0,0,0.08)' }}>
      <div style={{ height: '160px', backgroundColor: '#f5f5f5', display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden' }}>
        {!imgFailed && animal.photo ? (
          <a href={detailUrl}>
            <img src={animal.photo} alt={animal.full_name} loading="lazy"
              onError={() => setImgFailed(true)}
              style={{ width: '100%', height: '160px', objectFit: 'contain' }} />
          </a>
        ) : (
          <div style={{ color: '#ccc', fontSize: '12px', textAlign: 'center' }}>No Photo</div>
        )}
      </div>
      <div style={{ padding: '12px' }}>
        <a href={detailUrl} style={{ fontWeight: 600, color: '#333', textDecoration: 'none', fontSize: '0.9rem', display: 'block', marginBottom: '4px' }}>
          {animal.full_name}
        </a>
        {animal.breeds?.length > 0 && <p style={{ margin: '0 0 4px', fontSize: '0.8rem', color: '#888' }}>{animal.breeds.join(', ')}</p>}
        <p style={{ margin: '0 0 8px', fontSize: '0.85rem', fontWeight: 600, color: '#507033' }}>
          {priceVal ? `$${Math.round(priceVal).toLocaleString()}` : 'Call for Price'}
        </p>
        <a href={detailUrl} style={{ fontSize: '0.8rem', color: '#fff', backgroundColor: '#6c757d', padding: '4px 10px', borderRadius: '4px', textDecoration: 'none' }}>
          View Details
        </a>
      </div>
    </div>
  );
}

// ── Animals tab ───────────────────────────────────────────────────────────────
function AnimalsTab({ businessId, isStuds }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);

  useEffect(() => {
    setLoading(true);
    fetch(`${API_URL}/api/ranches/profile/${businessId}/animals?page=${page}&studs_only=${isStuds}`)
      .then(r => r.ok ? r.json() : null)
      .then(d => { setData(d); setLoading(false); })
      .catch(() => setLoading(false));
  }, [businessId, page, isStuds]);

  if (loading) return (
    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(180px, 1fr))', gap: '16px' }}>
      {[...Array(4)].map((_, i) => (
        <div key={i} className="animate-pulse" style={{ border: '1px solid #eee', borderRadius: '8px', overflow: 'hidden' }}>
          <div style={{ height: '160px', backgroundColor: '#e8e8e8' }} />
          <div style={{ padding: '12px' }}>
            <div style={{ height: '14px', backgroundColor: '#e8e8e8', borderRadius: '4px', marginBottom: '8px' }} />
            <div style={{ height: '12px', backgroundColor: '#e8e8e8', borderRadius: '4px', width: '60%' }} />
          </div>
        </div>
      ))}
    </div>
  );

  if (!data || data.animals.length === 0) return (
    <p style={{ color: '#888', padding: '20px 0' }}>No {isStuds ? 'stud' : 'sale'} listings at this time.</p>
  );

  return (
    <div>
      <p style={{ color: '#666', fontSize: '0.85rem', marginBottom: '16px' }}>{data.total} animal{data.total !== 1 ? 's' : ''}</p>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(180px, 1fr))', gap: '16px', marginBottom: '16px' }}>
        {data.animals.map(a => <AnimalCard key={a.animal_id} animal={a} isStuds={isStuds} />)}
      </div>
      {data.total_pages > 1 && (
        <div style={{ display: 'flex', gap: '4px' }}>
          {page > 1 && <button onClick={() => setPage(p => p - 1)} style={btnStyle}>‹ Prev</button>}
          {page < data.total_pages && <button onClick={() => setPage(p => p + 1)} style={btnStyle}>Next ›</button>}
        </div>
      )}
    </div>
  );
}

// ── Services tab ──────────────────────────────────────────────────────────────
function ServicesTab({ businessId }) {
  const [services, setServices] = useState([]);
  const [loading, setLoading]   = useState(true);

  useEffect(() => {
    fetch(`${API_URL}/api/services/business/${businessId}`)
      .then(r => r.ok ? r.json() : [])
      .then(d => { setServices(Array.isArray(d) ? d : []); setLoading(false); })
      .catch(() => setLoading(false));
  }, [businessId]);

  if (loading) return <div style={{ color: '#888', padding: '20px 0' }}>Loading services…</div>;
  if (!services.length) return <p style={{ color: '#888', padding: '20px 0' }}>No services listed at this time.</p>;

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
      {services.map(svc => (
        <a key={svc.ServicesID} href={`/services/public/${svc.ServicesID}`}
          style={{ display: 'flex', gap: '16px', alignItems: 'flex-start', background: '#fff', border: '1px solid #eee', borderRadius: '10px', padding: '16px', textDecoration: 'none', color: 'inherit', transition: 'box-shadow 0.2s' }}
          onMouseOver={e => e.currentTarget.style.boxShadow = '0 2px 10px rgba(0,0,0,0.08)'}
          onMouseOut={e => e.currentTarget.style.boxShadow = 'none'}
        >
          {svc.Photo1 ? (
            <img src={svc.Photo1} alt={svc.ServiceTitle}
              style={{ width: '72px', height: '72px', objectFit: 'cover', borderRadius: '8px', flexShrink: 0 }}
              onError={e => e.target.style.display = 'none'} />
          ) : (
            <div style={{ width: '72px', height: '72px', background: '#f3f4f6', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem', flexShrink: 0 }}>🔧</div>
          )}
          <div style={{ flexGrow: 1 }}>
            <div style={{ fontWeight: 700, fontSize: '1rem', color: '#222', marginBottom: '4px' }}>{svc.ServiceTitle}</div>
            {svc.ServicesCategory && <div style={{ fontSize: '0.8rem', color: '#507033', marginBottom: '4px' }}>{svc.ServicesCategory}</div>}
            {svc.ServicesDescription && <div style={{ fontSize: '0.85rem', color: '#555', overflow: 'hidden', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical' }}>{svc.ServicesDescription}</div>}
          </div>
          <div style={{ textAlign: 'right', flexShrink: 0 }}>
            {svc.ServiceContactForPrice ? (
              <span style={{ fontSize: '0.85rem', color: '#888', fontStyle: 'italic' }}>Contact for Price</span>
            ) : svc.ServicePrice ? (
              <span style={{ fontSize: '1rem', fontWeight: 700, color: '#507033' }}>${parseFloat(svc.ServicePrice).toLocaleString()}</span>
            ) : null}
            {svc.ServiceAvailable && <div style={{ fontSize: '0.75rem', color: '#999', marginTop: '4px' }}>{svc.ServiceAvailable}</div>}
          </div>
        </a>
      ))}
    </div>
  );
}

// ── Main component ────────────────────────────────────────────────────────────
export default function OrgProfile() {
  const { businessId: urlBusinessId } = useParams();
  const [searchParams, setSearchParams] = useSearchParams();
  const routerLocation = useLocation();
  const { businesses } = useAccount();
  const [ranch, setRanch] = useState(null);
  const [loading, setLoading] = useState(true);
  const [counts, setCounts] = useState({ for_sale: 0, studs: 0, services: 0 });

  const activeTab = searchParams.get('tab') || 'home';
  const setTab = (tab) => setSearchParams({ tab }, { replace: true });

  // Restaurant-buyer "save this farm" state — only relevant when the viewer is a restaurant
  // looking at a different business's profile.
  const restaurantBusinessId = Array.isArray(businesses)
    ? businesses.find(b => (b.BusinessType || '').toLowerCase() === 'restaurant')?.BusinessID
    : null;
  const [isSavedFarm, setIsSavedFarm] = useState(false);

  // Business ID can come from URL param (/ranch/:businessId),
  // router state (directory Profile button), the logged-in user's first business,
  // or the last selected business stored in localStorage
  const directoryBusiness = routerLocation.state?.business || null;
  const businessId = urlBusinessId
    || directoryBusiness?.BusinessID
    || businesses?.[0]?.BusinessID
    || localStorage.getItem('selected_business_id');

  useEffect(() => {
    // If directory passed full business object, use it directly
    if (directoryBusiness && !urlBusinessId) {
      const b = directoryBusiness;
      setRanch({
        business_id: b.BusinessID,
        business_name: b.BusinessName || '',
        logo: b.ProfileImage || b.BusinessLogo || null,
        header_image: null,
        home_heading: '',
        home_text: '',
        home_text2: '',
        description: b.BusinessDescription || '',
        address_street: b.AddressStreet || '',
        address_city: b.AddressCity || '',
        address_state: b.AddressState || '',
        address_zip: b.AddressZip || '',
        address_country: b.AddressCountry || '',
        website: b.BusinessWebsite || '',
        phone: b.BusinessPhone || '',
        contact_first_name: '',
        contact_last_name: '',
        facebook: b.BusinessFacebook || '',
        instagram: b.BusinessInstagram || '',
        linkedin: b.BusinessLinkedIn || '',
        x: b.BusinessX || '',
        pinterest: b.BusinessPinterest || '',
        youtube: b.BusinessYouTube || '',
        blog: b.BusinessBlog || '',
        truth_social: b.BusinessTruthSocial || '',
        other_social1: b.BusinessOtherSocial1 || '',
        other_social2: b.BusinessOtherSocial2 || '',
      });
      setLoading(false);
    } else if (businessId) {
      fetch(`${API_URL}/api/ranches/profile/${businessId}`)
        .then(r => r.ok ? r.json() : null)
        .then(d => { setRanch(d); setLoading(false); })
        .catch(() => setLoading(false));
    } else {
      setLoading(false);
    }

    if (businessId) {
      fetch(`${API_URL}/api/ranches/profile/${businessId}/animals?page=1&studs_only=false`)
        .then(r => r.ok ? r.json() : null)
        .then(d => d && setCounts(p => ({ ...p, for_sale: d.total })))
        .catch(() => {});

      fetch(`${API_URL}/api/ranches/profile/${businessId}/animals?page=1&studs_only=true`)
        .then(r => r.ok ? r.json() : null)
        .then(d => d && setCounts(p => ({ ...p, studs: d.total })))
        .catch(() => {});

      fetch(`${API_URL}/api/services/business/${businessId}`)
        .then(r => r.ok ? r.json() : [])
        .then(d => d && setCounts(p => ({ ...p, services: Array.isArray(d) ? d.length : 0 })))
        .catch(() => {});
    }
  }, [businessId]);

  // Fetch saved-farm membership when this profile belongs to a different business than the viewer's restaurant.
  useEffect(() => {
    if (!restaurantBusinessId || !businessId) { setIsSavedFarm(false); return; }
    if (parseInt(restaurantBusinessId) === parseInt(businessId)) { setIsSavedFarm(false); return; }
    fetch(`${API_URL}/api/marketplace/saved-farms?buyer_business_id=${restaurantBusinessId}`)
      .then(r => r.ok ? r.json() : [])
      .then(rows => setIsSavedFarm((rows || []).some(r => parseInt(r.FarmBusinessID) === parseInt(businessId))))
      .catch(() => setIsSavedFarm(false));
  }, [restaurantBusinessId, businessId]);

  const toggleSaveFarm = async () => {
    if (!restaurantBusinessId || !businessId) return;
    const wasSaved = isSavedFarm;
    setIsSavedFarm(!wasSaved);
    try {
      if (wasSaved) {
        await fetch(`${API_URL}/api/marketplace/saved-farms?buyer_business_id=${restaurantBusinessId}&farm_business_id=${businessId}`, { method: 'DELETE' });
      } else {
        const peopleId = localStorage.getItem('people_id');
        await fetch(`${API_URL}/api/marketplace/saved-farms`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            BuyerBusinessID: parseInt(restaurantBusinessId),
            FarmBusinessID:  parseInt(businessId),
            AddedByPeopleID: peopleId ? parseInt(peopleId) : null,
          }),
        });
      }
    } catch {
      setIsSavedFarm(wasSaved);
    }
  };

  if (loading) return (
    <div className="min-h-screen font-sans">
      <Header />
      <div style={{ maxWidth: '1100px', margin: '40px auto', padding: '0 16px' }} className="animate-pulse">
        <div style={{ height: '100px', backgroundColor: '#e8e8e8', borderRadius: '8px', marginBottom: '24px' }} />
        <div style={{ height: '48px', backgroundColor: '#e8e8e8', borderRadius: '4px', marginBottom: '24px' }} />
        <div style={{ height: '300px', backgroundColor: '#f0f0f0', borderRadius: '8px' }} />
      </div>
      <Footer />
    </div>
  );

  if (!ranch) return (
    <div className="min-h-screen font-sans">
      <Header />
      <div style={{ textAlign: 'center', padding: '80px 16px' }}>
        <p style={{ color: '#888', marginBottom: '16px' }}>Organization not found.</p>
        <Link to="/marketplaces/livestock" style={{ color: '#507033' }}>← Back to Marketplace</Link>
      </div>
      <Footer />
    </div>
  );

  const TABS = [
    { key: 'home',     label: 'Home',                                  show: true },
    { key: 'animals',  label: `Animals For Sale (${counts.for_sale})`, show: counts.for_sale > 0 },
    { key: 'studs',    label: `Stud Services (${counts.studs})`,       show: counts.studs > 0 },
    { key: 'services', label: `Services (${counts.services})`,         show: counts.services > 0 },
    { key: 'contact',  label: 'About / Contact',                       show: true },
  ].filter(t => t.show);

  const location = [ranch.address_city, ranch.address_state].filter(Boolean).join(', ');
  const activeSocials = SOCIAL_LINKS.filter(s => ranch[s.key]);
  const socialHref = (s) => {
    const val = ranch[s.key];
    if (!val) return null;
    return val.startsWith('http') ? val : `${s.base}${val}`;
  };

  const metaDesc = (ranch.description || ranch.home_text || `${ranch.business_name}${location ? ' in ' + location : ''} — a ranch or farm on Oatmeal Farm Network.`)
    .replace(/<[^>]*>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, 200);
  const metaImage = ranch.header_image || ranch.logo || undefined;
  const metaCanonical = businessId ? `https://oatmealfarmnetwork.com/marketplaces/livestock/ranch/${businessId}` : undefined;
  const orgJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: ranch.business_name,
    ...(metaImage ? { image: metaImage, logo: ranch.logo || metaImage } : {}),
    ...(ranch.website ? { url: ranch.website } : metaCanonical ? { url: metaCanonical } : {}),
    ...(ranch.phone ? { telephone: ranch.phone } : {}),
    ...(metaDesc ? { description: metaDesc } : {}),
    ...(ranch.address_street || ranch.address_city || ranch.address_state ? {
      address: {
        '@type': 'PostalAddress',
        ...(ranch.address_street ? { streetAddress: ranch.address_street } : {}),
        ...(ranch.address_city ? { addressLocality: ranch.address_city } : {}),
        ...(ranch.address_state ? { addressRegion: ranch.address_state } : {}),
        ...(ranch.address_zip ? { postalCode: ranch.address_zip } : {}),
        ...(ranch.address_country ? { addressCountry: ranch.address_country } : {}),
      },
    } : {}),
  };

  return (
    <div className="min-h-screen font-sans">
      <PageMeta
        title={`${ranch.business_name}${location ? ' · ' + location : ''}`}
        description={metaDesc}
        image={metaImage}
        canonical={metaCanonical}
        ogType="profile"
        jsonLd={orgJsonLd}
      />
      <Header />

      <div style={{ maxWidth: '1100px', margin: '0 auto', padding: '0 16px 60px' }}>
        <div style={{ paddingTop: '0.75rem' }}>
          <Breadcrumbs items={[
            { label: 'Home', to: '/' },
            { label: 'Directory', to: '/directory' },
            { label: ranch.business_name },
          ]} />
        </div>

        {/* ── Ranch header ── */}
        <div style={{ textAlign: 'center', padding: '32px 0 20px', borderBottom: '1px solid #eee' }}>
          {ranch.header_image ? (
            <img src={ranch.header_image} alt={ranch.business_name}
              style={{ display: 'block', maxHeight: '140px', maxWidth: '100%', objectFit: 'contain', margin: '0 auto 12px' }}
              onError={e => e.target.style.display = 'none'} />
          ) : ranch.logo ? (
            <img src={ranch.logo} alt={ranch.business_name}
              style={{ display: 'block', maxHeight: '100px', maxWidth: '100%', objectFit: 'contain', margin: '0 auto 12px' }}
              onError={e => e.target.style.display = 'none'} />
          ) : null}
          <h1 style={{ fontSize: '1.8rem', fontWeight: 'bold', color: '#222', margin: '0 0 6px' }}>
            {ranch.business_name}
          </h1>
          {location && <p style={{ color: '#888', margin: 0, fontSize: '0.95rem' }}>{location}</p>}
          {ranch.business_id && (
            <div style={{ marginTop: '12px', display: 'inline-flex', gap: '8px', flexWrap: 'wrap', justifyContent: 'center' }}>
              <a
                href={`/provenance/${ranch.business_id}`}
                target="_blank"
                rel="noopener noreferrer"
                style={{
                  display: 'inline-block',
                  padding: '6px 14px',
                  fontSize: '0.8rem',
                  fontWeight: 600,
                  color: '#3D6B34',
                  backgroundColor: '#fff',
                  border: '1px solid #3D6B34',
                  borderRadius: '6px',
                  textDecoration: 'none',
                }}
                title="Printable 'Sourced From' card for menus, table tents, and social"
              >
                🖨️ Get sourcing card
              </a>
              {restaurantBusinessId && parseInt(restaurantBusinessId) !== parseInt(ranch.business_id) && (
                <button
                  onClick={toggleSaveFarm}
                  style={{
                    padding: '6px 14px',
                    fontSize: '0.8rem',
                    fontWeight: 600,
                    color: isSavedFarm ? '#fff' : '#A3301E',
                    backgroundColor: isSavedFarm ? '#A3301E' : '#fff',
                    border: '1px solid #A3301E',
                    borderRadius: '6px',
                    cursor: 'pointer',
                  }}
                  title={isSavedFarm ? 'Saved to your My Farms list' : 'Save this farm for quick re-ordering'}
                >
                  {isSavedFarm ? '❤️ Saved to My Farms' : '🤍 Save to My Farms'}
                </button>
              )}
            </div>
          )}

          {/* ── Restaurant facts strip — only when fields are set ── */}
          {(ranch.cuisine || ranch.head_chef || ranch.seating_capacity || ranch.year_opened || ranch.restaurant_hours) && (
            <div style={{
              marginTop: '16px',
              display: 'inline-flex',
              flexWrap: 'wrap',
              gap: '6px 14px',
              justifyContent: 'center',
              fontSize: '0.85rem',
              color: '#555',
            }}>
              {ranch.cuisine          && <span>🍽️ <strong>{ranch.cuisine}</strong></span>}
              {ranch.head_chef        && <span>👨‍🍳 Chef <strong>{ranch.head_chef}</strong></span>}
              {ranch.seating_capacity && <span>🪑 Seats <strong>{ranch.seating_capacity}</strong></span>}
              {ranch.year_opened      && <span>📅 Est. <strong>{ranch.year_opened}</strong></span>}
              {ranch.restaurant_hours && <span>🕐 {ranch.restaurant_hours}</span>}
            </div>
          )}
          {ranch.sourcing_philosophy && (
            <p style={{
              marginTop: '12px',
              maxWidth: '640px',
              marginLeft: 'auto',
              marginRight: 'auto',
              fontSize: '0.9rem',
              color: '#555',
              fontStyle: 'italic',
              lineHeight: 1.5,
            }}>
              "{ranch.sourcing_philosophy}"
            </p>
          )}
        </div>

        {/* ── Tab nav ── */}
        <div style={{ display: 'flex', borderBottom: '2px solid #e0e0e0', overflowX: 'auto', marginBottom: '32px' }}>
          {TABS.map(tab => (
            <button key={tab.key} onClick={() => setTab(tab.key)} style={{
              padding: '12px 22px', border: 'none', cursor: 'pointer', whiteSpace: 'nowrap',
              backgroundColor: activeTab === tab.key ? '#507033' : 'transparent',
              color: activeTab === tab.key ? '#fff' : '#555',
              fontWeight: activeTab === tab.key ? 700 : 400,
              fontSize: '0.95rem', borderBottom: activeTab === tab.key ? '2px solid #507033' : 'none',
              transition: 'background 0.2s',
            }}>
              {tab.label}
            </button>
          ))}
        </div>

        {/* ── Home tab ── */}
        {activeTab === 'home' && (
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 340px', gap: '40px', alignItems: 'flex-start' }}>
            {/* Left — ranch info */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>

              {/* Business Information card — top */}
              <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                {/* Centered logo */}
                {(ranch.logo || ranch.header_image) && (
                  <div className="flex justify-center mb-4">
                    <img
                      src={ranch.logo || ranch.header_image}
                      alt={ranch.business_name}
                      style={{ maxHeight: '100px', maxWidth: '240px', objectFit: 'contain' }}
                      onError={e => { e.target.parentElement.style.display = 'none'; }}
                    />
                  </div>
                )}
                <h3 className="text-base font-bold mb-4" style={{ color: '#507033' }}>Business Information</h3>
                <dl className="grid grid-cols-2 gap-x-8 gap-y-3 text-sm text-gray-700 mb-4">
                  <div className="flex flex-col">
                    <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Business Name</dt>
                    <dd className="mt-0.5 font-medium">{ranch.business_name}</dd>
                  </div>
                  {location && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Location</dt>
                      <dd className="mt-0.5 font-medium">{location}</dd>
                    </div>
                  )}
                  {(ranch.contact_first_name || ranch.contact_last_name) && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Contact</dt>
                      <dd className="mt-0.5 font-medium">{[ranch.contact_first_name, ranch.contact_last_name].filter(Boolean).join(' ')}</dd>
                    </div>
                  )}
                  {ranch.phone && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Phone</dt>
                      <dd className="mt-0.5 font-medium">
                        <a href={`tel:${ranch.phone}`} style={{ color: '#507033', textDecoration: 'none' }}>{ranch.phone}</a>
                      </dd>
                    </div>
                  )}
                  {ranch.website && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Website</dt>
                      <dd className="mt-0.5">
                        <a href={ranch.website.startsWith('http') ? ranch.website : `https://${ranch.website}`} target="_blank" rel="noopener noreferrer" style={{ color: '#507033', wordBreak: 'break-all' }}>{ranch.website}</a>
                      </dd>
                    </div>
                  )}
                </dl>
                {/* Social icons — icon only */}
                {activeSocials.length > 0 && (
                  <div className="flex flex-wrap gap-2">
                    {activeSocials.map(s => (
                      <a key={s.key} href={socialHref(s)} target="_blank" rel="noopener noreferrer" title={s.label}
                        className={`flex items-center justify-center ${s.color} text-white rounded-lg hover:opacity-80 transition-opacity`}
                        style={{ width: '32px', height: '32px', fontSize: '0.9rem' }}>
                        {s.icon}
                      </a>
                    ))}
                  </div>
                )}
              </div>

              {/* About card */}
              {(ranch.home_heading || ranch.description || ranch.home_text || ranch.home_text2) && (
                <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                  {ranch.home_heading && <h2 className="text-lg font-bold mb-3" style={{ color: '#507033' }}>{ranch.home_heading}</h2>}
                  {ranch.description && (
                    <div className="prose prose-sm max-w-none text-sm text-gray-700 leading-relaxed mb-3"
                      dangerouslySetInnerHTML={{ __html: ranch.description }} />
                  )}
                  {ranch.home_text && (
                    <div style={{ fontSize: '0.95rem', lineHeight: 1.8, color: '#444', marginBottom: '12px' }}
                      dangerouslySetInnerHTML={{ __html: ranch.home_text }} />
                  )}
                  {ranch.home_text2 && (
                    <div style={{ fontSize: '0.95rem', lineHeight: 1.8, color: '#444' }}
                      dangerouslySetInnerHTML={{ __html: ranch.home_text2 }} />
                  )}
                </div>
              )}

            </div>

            {/* Right — contact form */}
            <div style={{ backgroundColor: '#fff', border: '1px solid #e8e8e8', borderRadius: '12px', padding: '24px', boxShadow: '0 2px 8px rgba(0,0,0,0.08)' }}>
              <h3 style={{ fontSize: '1.1rem', fontWeight: 700, marginBottom: '20px', color: '#333' }}>
                Contact {ranch.business_name}
              </h3>
              <ContactForm ranch={ranch} />
            </div>
          </div>
        )}

        {/* ── Animals for sale tab ── */}
        {activeTab === 'animals' && <AnimalsTab businessId={businessId} isStuds={false} />}

        {/* ── Stud services tab ── */}
        {activeTab === 'studs' && <AnimalsTab businessId={businessId} isStuds={true} />}

        {/* ── Services tab ── */}
        {activeTab === 'services' && <ServicesTab businessId={businessId} />}

        {/* ── About / Contact tab ── */}
        {activeTab === 'contact' && (
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 340px', gap: '40px', alignItems: 'flex-start' }}>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>

              {/* Business Information card — top */}
              <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                {/* Centered logo */}
                {(ranch.logo || ranch.header_image) && (
                  <div className="flex justify-center mb-4">
                    <img
                      src={ranch.logo || ranch.header_image}
                      alt={ranch.business_name}
                      style={{ maxHeight: '100px', maxWidth: '240px', objectFit: 'contain' }}
                      onError={e => { e.target.parentElement.style.display = 'none'; }}
                    />
                  </div>
                )}
                <h3 className="text-base font-bold mb-4" style={{ color: '#507033' }}>Business Information</h3>
                <dl className="grid grid-cols-2 gap-x-8 gap-y-3 text-sm text-gray-700 mb-4">
                  <div className="flex flex-col">
                    <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Business Name</dt>
                    <dd className="mt-0.5 font-medium">{ranch.business_name}</dd>
                  </div>
                  {location && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Location</dt>
                      <dd className="mt-0.5 font-medium">{location}</dd>
                    </div>
                  )}
                  {ranch.address_street && (
                    <div className="flex flex-col col-span-2">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Address</dt>
                      <dd className="mt-0.5 font-medium">
                        {[ranch.address_street, `${location} ${ranch.address_zip}`.trim(), ranch.address_country].filter(Boolean).join(', ')}
                      </dd>
                    </div>
                  )}
                  {(ranch.contact_first_name || ranch.contact_last_name) && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Contact</dt>
                      <dd className="mt-0.5 font-medium">{[ranch.contact_first_name, ranch.contact_last_name].filter(Boolean).join(' ')}</dd>
                    </div>
                  )}
                  {ranch.phone && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Phone</dt>
                      <dd className="mt-0.5 font-medium">
                        <a href={`tel:${ranch.phone}`} style={{ color: '#507033', textDecoration: 'none' }}>{ranch.phone}</a>
                      </dd>
                    </div>
                  )}
                  {ranch.website && (
                    <div className="flex flex-col">
                      <dt className="text-xs font-semibold text-gray-400 uppercase tracking-wide">Website</dt>
                      <dd className="mt-0.5">
                        <a href={ranch.website.startsWith('http') ? ranch.website : `https://${ranch.website}`} target="_blank" rel="noopener noreferrer" style={{ color: '#507033', wordBreak: 'break-all' }}>{ranch.website}</a>
                      </dd>
                    </div>
                  )}
                </dl>
                {/* Social icons — icon only */}
                {activeSocials.length > 0 && (
                  <div className="flex flex-wrap gap-2">
                    {activeSocials.map(s => (
                      <a key={s.key} href={socialHref(s)} target="_blank" rel="noopener noreferrer" title={s.label}
                        className={`flex items-center justify-center ${s.color} text-white rounded-lg hover:opacity-80 transition-opacity`}
                        style={{ width: '32px', height: '32px', fontSize: '0.9rem' }}>
                        {s.icon}
                      </a>
                    ))}
                  </div>
                )}
              </div>

              {/* About card */}
              {(ranch.description || ranch.home_text || ranch.home_text2) && (
                <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                  <h2 className="text-lg font-bold mb-3" style={{ color: '#507033' }}>About {ranch.business_name}</h2>
                  {ranch.description && (
                    <div className="prose prose-sm max-w-none text-sm text-gray-700 leading-relaxed mb-3"
                      dangerouslySetInnerHTML={{ __html: ranch.description }} />
                  )}
                  {ranch.home_text && (
                    <div style={{ fontSize: '0.95rem', lineHeight: 1.8, color: '#444', marginBottom: '12px' }}
                      dangerouslySetInnerHTML={{ __html: ranch.home_text }} />
                  )}
                  {ranch.home_text2 && (
                    <div style={{ fontSize: '0.95rem', lineHeight: 1.8, color: '#444' }}
                      dangerouslySetInnerHTML={{ __html: ranch.home_text2 }} />
                  )}
                </div>
              )}

            </div>

            <div style={{ backgroundColor: '#fff', border: '1px solid #e8e8e8', borderRadius: '12px', padding: '24px', boxShadow: '0 2px 8px rgba(0,0,0,0.08)' }}>
              <h3 style={{ fontSize: '1.1rem', fontWeight: 700, marginBottom: '20px', color: '#333' }}>
                Contact {ranch.business_name}
              </h3>
              <ContactForm ranch={ranch} />
            </div>
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}

const btnStyle = { padding: '5px 12px', border: '1px solid #ccc', borderRadius: '8px', backgroundColor: '#fff', cursor: 'pointer', fontSize: '0.85rem' };
const formLabel = { display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#444', marginBottom: '4px' };
const formInput = { width: '100%', padding: '9px 12px', border: '1px solid #d0d0d0', borderRadius: '6px', fontSize: '0.9rem', boxSizing: 'border-box', outline: 'none' };