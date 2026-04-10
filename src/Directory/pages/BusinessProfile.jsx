import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate, Link } from 'react-router-dom';
import { API_ENDPOINTS } from '../config';
import photoNotAvailable from '../images/photo not available .jpg';
import { DIRECTORY_TYPE_TO_IMAGE, DIRECTORY_TYPE_TO_BUSINESS_TYPE } from './directoryMappings';
import { FaFacebookF, FaPinterestP, FaXTwitter, FaInstagram, FaLinkedinIn, FaYoutube, FaGlobe } from 'react-icons/fa6';
import Header from '../../Header';
import Footer from '../../Footer';

const BLOG_API = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

function getExcerpt(content, wordLimit = 35) {
  if (!content) return '';
  let text = content;
  try {
    const blocks = JSON.parse(content);
    if (Array.isArray(blocks))
      text = blocks.filter(b => b.type === 'text').map(b => b.content || '').join(' ');
  } catch {}
  const plain = text.replace(/<[^>]*>/g, '').trim();
  const words = plain.split(/\s+/);
  if (words.length <= wordLimit) return plain;
  return words.slice(0, wordLimit).join(' ') + '…';
}

function getCoverImage(content, fallback) {
  if (fallback) return fallback;
  try {
    const blocks = JSON.parse(content || '');
    if (Array.isArray(blocks)) {
      const img = blocks.find(b => b.type === 'image' && b.url);
      if (img) return img.url;
    }
  } catch {}
  return null;
}

function BusinessBlogPosts({ businessId }) {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!businessId) return;
    fetch(`${BLOG_API}/api/blog/posts?business_id=${businessId}&limit=6`)
      .then(r => r.ok ? r.json() : [])
      .then(data => setPosts(Array.isArray(data) ? data : []))
      .catch(() => setPosts([]))
      .finally(() => setLoading(false));
  }, [businessId]);

  if (loading || posts.length === 0) return null;

  return (
    <div className="bg-white rounded-2xl shadow-sm p-6">
      <h2 className="text-lg font-bold text-[#4d734d] mb-4">Blog Posts</h2>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '1rem' }}>
        {posts.map(post => {
          const cover = getCoverImage(post.content, post.cover_image);
          const date = (post.published_at || post.created_at)
            ? new Date(post.published_at || post.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
            : '';
          return (
            <Link key={post.blog_id} to={`/blog/${post.blog_id}`}
              style={{ textDecoration: 'none', color: 'inherit', display: 'block' }}>
              <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflow: 'hidden', transition: 'box-shadow 0.2s', cursor: 'pointer', background: '#fafafa' }}
                onMouseEnter={e => e.currentTarget.style.boxShadow = '0 4px 14px rgba(0,0,0,0.09)'}
                onMouseLeave={e => e.currentTarget.style.boxShadow = 'none'}>
                {cover ? (
                  <img src={cover} alt={post.title} style={{ width: '100%', height: 120, objectFit: 'cover', display: 'block' }}
                    onError={e => e.target.style.display = 'none'} />
                ) : (
                  <div style={{ width: '100%', height: 80, background: 'linear-gradient(135deg,#f3f4f6,#e5e7eb)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: '1.75rem' }}>📝</span>
                  </div>
                )}
                <div style={{ padding: '0.7rem 0.85rem' }}>
                  <div style={{ fontSize: '0.7rem', color: '#9ca3af', marginBottom: 3 }}>{date}</div>
                  <div style={{ fontWeight: 700, fontSize: '0.88rem', color: '#111827', lineHeight: 1.3, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                    {post.title}
                  </div>
                  {post.content && (
                    <p style={{ margin: '0.3rem 0 0', fontSize: '0.78rem', color: '#6b7280', lineHeight: 1.5, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                      {getExcerpt(post.content)}
                    </p>
                  )}
                  <span style={{ display: 'inline-block', marginTop: '0.4rem', fontSize: '0.75rem', color: '#7C5CBF', fontWeight: 600 }}>Read more →</span>
                </div>
              </div>
            </Link>
          );
        })}
      </div>
    </div>
  );
}


const BusinessProfile = () => {
    const location = useLocation();
    const navigate = useNavigate();
    const initialBusiness = location.state?.business;
    const directoryType = location.state?.directoryType;
    const selectedCountry = location.state?.selectedCountry;
    const selectedState = location.state?.selectedState;
    const nameFilter = location.state?.nameFilter;
    const [business, setBusiness] = useState(initialBusiness);
    const [isLoggedIn, setIsLoggedIn] = useState(false);

    useEffect(() => {
        setBusiness(initialBusiness);
    }, [initialBusiness]);

    const [formData, setFormData] = useState({
        firstName: '', lastName: '', email: '', phone: '', comments: ''
    });
    const [mathQuestion, setMathQuestion] = useState({ num1: 0, num2: 0, answer: '' });
    const [userMathAnswer, setUserMathAnswer] = useState('');
    const [formSubmitted, setFormSubmitted] = useState(false);

    const generateMathQuestion = () => {
        const num1 = Math.floor(Math.random() * 10) + 1;
        const num2 = Math.floor(Math.random() * 10) + 1;
        setMathQuestion({ num1, num2, answer: num1 + num2 });
        setUserMathAnswer('');
    };

    useEffect(() => { generateMathQuestion(); }, []);

    useEffect(() => {
        const token = localStorage.getItem('access_token');
        setIsLoggedIn(Boolean(token));
    }, []);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        if (parseInt(userMathAnswer) !== mathQuestion.answer) {
            alert('Please answer the math question correctly.');
            return;
        }
        if (!formData.firstName || !formData.lastName || !formData.email) {
            alert('Please fill in all required fields.');
            return;
        }
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(formData.email)) {
            alert('Please enter a valid email address.');
            return;
        }
        console.log('Form submitted:', formData);
        alert('Thank you for your message! We will get back to you soon.');
        setFormData({ firstName: '', lastName: '', email: '', phone: '', comments: '' });
        setUserMathAnswer('');
        generateMathQuestion();
        setFormSubmitted(true);
    };

    const backToListings = () => navigate(`/directory/${directoryType || 'agricultural-associations'}`, {
        state: { selectedCountry, selectedState, nameFilter }
    });

    const socialLinks = [
        { key: 'Facebook',  label: 'Facebook',  icon: <FaFacebookF />,  base: 'https://facebook.com/',  color: 'bg-[#1877F2]' },
        { key: 'Pinterest', label: 'Pinterest', icon: <FaPinterestP />, base: 'https://pinterest.com/', color: 'bg-[#E60023]' },
        { key: 'Twitter',   label: 'Twitter',   icon: <FaXTwitter />,   base: 'https://twitter.com/',   color: 'bg-black' },
        { key: 'Instagram', label: 'Instagram', icon: <FaInstagram />,  base: 'https://instagram.com/', color: 'bg-[#E1306C]' },
        { key: 'LinkedIn',  label: 'LinkedIn',  icon: <FaLinkedinIn />, base: 'https://linkedin.com/company/', color: 'bg-[#0A66C2]' },
        { key: 'YouTube',   label: 'YouTube',   icon: <FaYoutube />,    base: 'https://youtube.com/',   color: 'bg-[#FF0000]' },
        { key: 'Website',   label: 'Website',   icon: <FaGlobe />,      base: '',                       color: 'bg-[#4d734d]' },
    ];

    if (!business) {
        return (
            <div className="min-h-screen bg-white font-sans">
                <Header />
                <header className="header">
                    <div className="logo-container">
                        <img src={DIRECTORY_TYPE_TO_IMAGE[directoryType] || photoNotAvailable} className="logo-image" />
                        <span className="logo-text">{DIRECTORY_TYPE_TO_BUSINESS_TYPE[directoryType] || 'Business'}</span>
                    </div>
                </header>
                <div className="profile-page-container">
                    <p>No business information available.</p>
                    <button
                        onClick={() => navigate(`/directory/${directoryType || 'agricultural-associations'}`, {
                            state: { selectedCountry, selectedState, nameFilter }
                        })}
                        className="back-button"
                    >
                        ← Back to Listings
                    </button>
                </div>
                <Footer />
            </div>
        );
    }

    const fullAddress = [business.Address, business.City, business.State, business.ZipCode, business.Country].filter(Boolean).join(', ');

    return (
        <div className="min-h-screen bg-white font-sans">
            <Header />

            {/* Main container */}
            <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '1.5rem 1rem 3rem' }}>

                {/* Back button */}
                <button onClick={backToListings} className="text-[#4d734d] font-semibold hover:underline mb-3 inline-flex items-center gap-1">
                    ← Back to Listings
                </button>


                {/* Business name */}
                <div className="mb-6">
                    <h1 className="text-3xl font-bold text-gray-900">{business.BusinessName}</h1>
                </div>

                {/* Two column layout */}
                <div className="flex flex-col lg:flex-row gap-6">

                    {/* LEFT COLUMN */}
                    <div className="flex-1 space-y-6">

                        {/* Profile image + contact info side by side */}
                        <div className="bg-white rounded-2xl shadow-sm p-6 flex flex-col sm:flex-row gap-6">
                            <img
                                src={business.ProfileImage || photoNotAvailable}
                                alt={business.BusinessName}
                                className="w-40 h-40 object-cover rounded-xl border border-gray-200 flex-shrink-0"
                            />
                            <div className="flex-1 space-y-3">
                                {(business.Phone || business.Website) && (
                                    <div>
                                        <h2 className="text-lg font-bold text-[#4d734d] mb-2">Contact Information</h2>
                                        {business.Phone && (
                                            <p className="text-sm text-gray-700">
                                                <span className="font-semibold">Phone: </span>
                                                <a href={`tel:${business.Phone}`} className="text-[#4d734d] hover:underline">{business.Phone}</a>
                                            </p>
                                        )}
                                        {business.Website && (
                                            <p className="text-sm text-gray-700 mt-1">
                                                <span className="font-semibold">Website: </span>
                                                <a href={business.Website} target="_blank" rel="noopener noreferrer" className="text-[#4d734d] hover:underline break-all">{business.Website}</a>
                                            </p>
                                        )}
                                    </div>
                                )}

                                {/* Social icons */}
                                <div>
                                    <h2 className="text-lg font-bold text-[#4d734d] mb-2">Connect With Us</h2>
                                    <div className="flex flex-wrap gap-2">
                                        {socialLinks.map(({ key, label, icon, base, color }) => {
                                            const val = business[key];
                                            const href = val ? (val.startsWith('http') ? val : `${base}${val}`) : null;
                                            return href ? (
                                                <a key={key} href={href} target="_blank" rel="noopener noreferrer"
                                                    className={`flex items-center gap-1.5 ${color} text-white text-xs font-semibold px-3 py-1.5 rounded-full hover:opacity-80 transition-opacity`}>
                                                    {icon} {label}
                                                </a>
                                            ) : (
                                                <span key={key}
                                                    className="flex items-center gap-1.5 bg-gray-200 text-gray-400 text-xs font-semibold px-3 py-1.5 rounded-full cursor-not-allowed">
                                                    {icon} {label}
                                                </span>
                                            );
                                        })}
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/* END profile image + contact */}

                        {/* Business Information */}
                        <div className="bg-white rounded-2xl shadow-sm p-6">
                            <h2 className="text-lg font-bold text-[#4d734d] mb-4">Business Information</h2>
                            <dl className="grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-3 text-sm text-gray-700">
                                {[
                                    ['Business Name', business.BusinessName],
                                    ['Business Type', DIRECTORY_TYPE_TO_BUSINESS_TYPE[directoryType] || 'Business'],
                                    ['Address', business.Address],
                                    ['City', business.City],
                                    ['State', business.State],
                                    ['Zip Code', business.ZipCode],
                                    ['Country', business.Country],
                                ].filter(([, val]) => val).map(([label, val]) => (
                                    <div key={label} className="flex flex-col">
                                        <dt className="font-semibold text-gray-500 text-xs uppercase tracking-wide">{label}</dt>
                                        <dd className="mt-0.5">{val}</dd>
                                    </div>
                                ))}
                            </dl>
                        </div>
                        {/* END business information */}

                        {/* Location */}
                        {fullAddress && (
                            <div className="bg-white rounded-2xl shadow-sm p-6">
                                <h2 className="text-lg font-bold text-[#4d734d] mb-2">Location</h2>
                                <p className="text-sm text-gray-700">{fullAddress}</p>
                            </div>
                        )}

                        {/* Description */}
                        {(business.Heading || business.Description || business.About || business.Summary || business.Services || business.Details || business.Description2) && (
                            <div className="bg-white rounded-2xl shadow-sm p-6">
                                <h2 className="text-lg font-bold text-[#4d734d] mb-2">Description</h2>
                                {business.Heading && <h3 className="text-base font-semibold text-gray-800 mb-2">{business.Heading}</h3>}
                                {(business.Description || business.About || business.Summary || business.Services || business.Details) && (
                                    <p className="text-sm text-gray-700 leading-relaxed">
                                        {business.Description || business.About || business.Summary || business.Services || business.Details}
                                    </p>
                                )}
                                {business.Description2 && (
                                    <p className="text-sm text-gray-700 leading-relaxed mt-3">{business.Description2}</p>
                                )}
                            </div>
                        )}

                        {/* Blog Posts */}
                        <BusinessBlogPosts businessId={business.BusinessID} />

                    </div>
                    {/* END LEFT COLUMN */}

                    {/* RIGHT COLUMN — Contact Form */}
                    <div className="w-full lg:w-80 flex-shrink-0">
                        <div className="bg-white rounded-2xl shadow-sm p-6 sticky top-6">
                            <h2 className="text-lg font-bold text-[#4d734d] mb-4">Contact {business.BusinessName}</h2>
                            <form onSubmit={handleSubmit} className="space-y-4">
                                {[
                                    { id: 'firstName', label: 'First Name', type: 'text',  required: true },
                                    { id: 'lastName',  label: 'Last Name',  type: 'text',  required: true },
                                    { id: 'email',     label: 'Email',      type: 'email', required: true },
                                    { id: 'phone',     label: 'Phone',      type: 'tel',   required: false, optional: true },
                                ].map(({ id, label, type, required, optional }) => (
                                    <div key={id}>
                                        <label htmlFor={id} className="block text-sm font-semibold text-gray-700 mb-1">
                                            {label} {optional && <span className="text-gray-400 font-normal">(Optional)</span>}
                                        </label>
                                        <input
                                            type={type}
                                            id={id}
                                            name={id}
                                            value={formData[id]}
                                            onChange={handleInputChange}
                                            required={required}
                                            className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-[#4d734d] focus:outline-none focus:ring-2 focus:ring-[#4d734d]/20"
                                        />
                                    </div>
                                ))}

                                <div>
                                    <label htmlFor="comments" className="block text-sm font-semibold text-gray-700 mb-1">
                                        Comments / Questions <span className="text-gray-400 font-normal">(Optional)</span>
                                    </label>
                                    <textarea
                                        id="comments"
                                        name="comments"
                                        value={formData.comments}
                                        onChange={handleInputChange}
                                        rows={4}
                                        className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-[#4d734d] focus:outline-none focus:ring-2 focus:ring-[#4d734d]/20"
                                    />
                                </div>

                                {/* Math captcha */}
                                <div className="bg-gray-50 rounded-xl p-4">
                                    <p className="text-sm font-semibold text-gray-700 mb-1">Human Verification</p>
                                    <p className="text-xs text-gray-500 mb-2">Answer the simple math question below.</p>
                                    <div className="flex items-center gap-3">
                                        <span className="text-sm font-bold text-gray-800">{mathQuestion.num1} + {mathQuestion.num2} =</span>
                                        <input
                                            type="number"
                                            value={userMathAnswer}
                                            onChange={(e) => setUserMathAnswer(e.target.value)}
                                            required
                                            placeholder="?"
                                            className="w-16 rounded-lg border border-gray-300 px-2 py-1.5 text-sm focus:border-[#4d734d] focus:outline-none focus:ring-2 focus:ring-[#4d734d]/20"
                                        />
                                    </div>
                                </div>

                                <button type="submit"
                                    className="w-full bg-[#4d734d] text-white font-semibold py-2.5 rounded-lg hover:bg-[#3d5e3d] transition-colors text-sm">
                                    Send Message
                                </button>
                            </form>
                        </div>
                    </div>
                    {/* END RIGHT COLUMN */}

                </div>
                {/* END two column layout */}

            </div>
            {/* END main container */}

            <Footer />

        </div>
        /* END min-h-screen */
    );
};

export default BusinessProfile;