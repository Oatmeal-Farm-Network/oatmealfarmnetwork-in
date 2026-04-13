import React, { useEffect, useState } from 'react';
import { useParams, useNavigate, useLocation, Link } from 'react-router-dom';
import { API_ENDPOINTS } from '../config';
import { DIRECTORY_TYPE_TO_IMAGE, DIRECTORY_TYPE_TO_BUSINESS_TYPE } from './directoryMappings';
import photoNotAvailable from '../images/photo not available .jpg';
import Header from '../../Header';
import Footer from '../../Footer';
import PageMeta from '../../PageMeta';

const DIRECTORY_TYPE_TO_BUSINESS_TYPE_ID = {
    'agricultural-associations': '1',
    'artisan-producers': '11',
    'business-resources': '28',
    'crafter-organizations': '15',
    'farmers-markets': '29',
    'farms-ranches': '8',
    'fiber-cooperatives': '25',
    'fiber-mills': '18',
    'fisheries': '22',
    'fishermen': '23',
    'food-cooperatives': '14',
    'food-hubs': '18',
    'grocery-stores': '26',
    'herb-and-tea-producer': '31',
    'manufacturers': '16',
    'marinas': '21',
    'meat-wholesalers': '19',
    'real-estate-agents': '30',
    'restaurants': '9',
    'retailers': '24',
    'service-providers': '20',
    'transporter': '32',
    'universities': '27',
    'veterinarians': '17',
    'vineyards': '34',
    'wineries': '33',
    'others': '3',
};

function fixUrl(val) {
    if (!val || val.trim() === '') return null;
    if (val.startsWith('http')) return val;
    return 'https://' + val;
}

function SocialLinks({ business }) {
    const links = [
        { url: fixUrl(business.BusinessFacebook),     icon: '/icons/facebook.png',         alt: 'Facebook' },
        { url: fixUrl(business.BusinessX),            icon: '/icons/TwitterX.png',          alt: 'Twitter/X' },
        { url: fixUrl(business.BusinessInstagram),    icon: '/icons/instagramicon.png',     alt: 'Instagram' },
        { url: fixUrl(business.BusinessLinkedIn),     icon: '/icons/LinkedIcon.png',        alt: 'LinkedIn' },
        { url: fixUrl(business.BusinessPinterest),    icon: '/icons/PinterestLogo.png',     alt: 'Pinterest' },
        { url: fixUrl(business.BusinessYouTube),      icon: '/icons/YouTube.jpg',           alt: 'YouTube' },
        { url: fixUrl(business.BusinessTruthSocial),  icon: '/icons/Truthsocial.png',       alt: 'Truth Social' },
        { url: fixUrl(business.BusinessBlog),         icon: '/icons/BlogIcon.png',          alt: 'Blog' },
        { url: fixUrl(business.BusinessOtherSocial1), icon: '/icons/GeneralSocialIcon.png', alt: 'Social Media' },
        { url: fixUrl(business.BusinessOtherSocial2), icon: '/icons/GeneralSocialIcon.png', alt: 'Social Media' },
    ].filter(l => l.url !== null);

    if (links.length === 0) return null;
    return (
        <div className="flex gap-1.5 flex-wrap mt-2">
            {links.map((l, i) => (
                <a key={i} href={l.url} target="_blank" rel="noopener noreferrer">
                    <img src={l.icon} alt={l.alt} style={{ width: '24px', height: '24px', objectFit: 'contain' }} />
                </a>
            ))}
        </div>
    );
}

function Pagination({ currentPage, totalPages, onPageChange }) {
    if (totalPages <= 1) return null;

    let pages = [];
    if (totalPages <= 7) {
        for (let i = 1; i <= totalPages; i++) pages.push(i);
    } else {
        let start = Math.max(1, currentPage - 2);
        let end   = Math.min(totalPages, currentPage + 2);
        if (currentPage <= 3) end   = Math.min(totalPages, 5);
        if (currentPage >= totalPages - 2) start = Math.max(1, totalPages - 4);
        for (let j = start; j <= end; j++) pages.push(j);
    }

    return (
        <div className="flex gap-1 flex-wrap items-center mb-4">
            {pages.map(p => (
                <button
                    key={p}
                    onClick={() => onPageChange(p)}
                    className="w-9 h-9 text-sm font-bold rounded-lg transition-all"
                    style={{
                        backgroundColor: currentPage === p ? '#3D6B34' : '#fff',
                        color:           currentPage === p ? '#fff'    : '#3D6B34',
                        border:          '1px solid #3D6B34',
                    }}
                >
                    {p}
                </button>
            ))}
            {currentPage < totalPages && (
                <button
                    onClick={() => onPageChange(currentPage + 1)}
                    className="px-3 h-9 text-sm font-bold rounded-lg transition-all"
                    style={{ backgroundColor: '#fff', color: '#3D6B34', border: '1px solid #3D6B34' }}
                >
                    &rsaquo;
                </button>
            )}
            {totalPages > 5 && (
                <button
                    onClick={() => onPageChange(totalPages)}
                    className="px-3 h-9 text-sm font-bold rounded-lg transition-all"
                    style={{ backgroundColor: '#fff', color: '#3D6B34', border: '1px solid #3D6B34' }}
                >
                    Last
                </button>
            )}
        </div>
    );
}

function BusinessCard({ business, onProfileClick }) {
    return (
        <div className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200">
            {/* Left: logo */}
            <div
                className="shrink-0 flex items-center justify-center bg-gray-50 border-r border-gray-100 cursor-pointer"
                style={{ width: '130px', height: '130px' }}
                onClick={() => onProfileClick(business)}
            >
                <img
                    loading="lazy"
                    src={business.ProfileImage || photoNotAvailable}
                    alt={business.BusinessName + ' logo'}
                    style={{ width: '110px', height: '110px', objectFit: 'contain', borderRadius: '6px' }}
                    onError={e => { e.target.onerror = null; e.target.src = photoNotAvailable; }}
                />
            </div>

            {/* Right: info */}
            <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                <div>
                    <button
                        onClick={() => onProfileClick(business)}
                        className="font-bold text-sm hover:underline text-left"
                        style={{ color: '#3D6B34', background: 'none', border: 'none', padding: 0, cursor: 'pointer' }}
                    >
                        {business.BusinessName}
                    </button>
                    <p className="text-xs font-semibold mt-0.5" style={{ color: '#819360' }}>
                        {[business.AddressCity, business.AddressState, business.AddressCountry].filter(Boolean).join(', ')}
                    </p>
                    {business.BusinessWebsite && (
                        <a
                            href={fixUrl(business.BusinessWebsite)}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-xs hover:underline block mt-1 truncate"
                            style={{ color: '#c47d00' }}
                        >
                            {business.BusinessWebsite}
                        </a>
                    )}
                    <SocialLinks business={business} />
                </div>
                <div className="mt-3">
                    <button
                        onClick={() => onProfileClick(business)}
                        className="text-xs font-bold hover:underline"
                        style={{ color: '#3D6B34', background: 'none', border: 'none', padding: 0, cursor: 'pointer' }}
                    >
                        VIEW PROFILE →
                    </button>
                </div>
            </div>
        </div>
    );
}

const DirectoryDetail = function () {
    const { directoryType } = useParams();
    const navigate  = useNavigate();
    const location  = useLocation();
    const backState = location.state;

    const [countries, setCountries]           = useState([]);
    const [states, setStates]                 = useState([]);
    const [businesses, setBusinesses]         = useState([]);
    const [selectedCountry, setSelectedCountry] = useState(backState?.selectedCountry || '');
    const [selectedState, setSelectedState]   = useState(backState?.selectedState || '');
    const [nameFilter, setNameFilter]         = useState(backState?.nameFilter || '');
    const [appliedCountry, setAppliedCountry] = useState(backState?.selectedCountry || '');
    const [appliedState, setAppliedState]     = useState(backState?.selectedState || '');
    const [appliedName, setAppliedName]       = useState(backState?.nameFilter || '');
    const [loading, setLoading]               = useState(true);
    const [error, setError]                   = useState(null);
    const [currentPage, setCurrentPage]       = useState(1);
    const itemsPerPage = 10;

    const businessType = DIRECTORY_TYPE_TO_BUSINESS_TYPE_ID[directoryType] || directoryType;
    const pageTitle    = directoryType
        .replace(/-/g, ' ')
        .split(' ')
        .map(w => w.charAt(0).toUpperCase() + w.slice(1))
        .join(' ');
    const categoryIcon = DIRECTORY_TYPE_TO_IMAGE?.[directoryType] || null;

    useEffect(() => { if (backState) window.history.replaceState({}, document.title); }, []);

    useEffect(() => {
        fetch(API_ENDPOINTS.COUNTRIES)
            .then(r => r.ok ? r.json() : [])
            .then(data => setCountries(data))
            .catch(() => {});
    }, []);

    useEffect(() => {
        if (!selectedCountry) { setStates([]); setSelectedState(''); return; }
        fetch(API_ENDPOINTS.STATES + '?country=' + encodeURIComponent(selectedCountry))
            .then(r => r.ok ? r.json() : [])
            .then(data => setStates(data || []))
            .catch(() => setStates([]));
    }, [selectedCountry]);

    useEffect(() => {
        setLoading(true);
        setError(null);
        let url = API_ENDPOINTS.BUSINESSES + '?BusinessTypeID=' + encodeURIComponent(businessType);
        if (appliedCountry) url += '&country=' + encodeURIComponent(appliedCountry);
        if (appliedState)   url += '&state='   + encodeURIComponent(appliedState);
        fetch(url)
            .then(r => { if (!r.ok) throw new Error('Failed to fetch: ' + r.statusText); return r.json(); })
            .then(data => { setBusinesses(data || []); setLoading(false); })
            .catch(err => { setError(err.message); setLoading(false); });
    }, [appliedCountry, appliedState, businessType]);

    useEffect(() => { setCurrentPage(1); }, [appliedCountry, appliedState, appliedName]);

    function handleApplyFilters() {
        setAppliedCountry(selectedCountry);
        setAppliedState(selectedState);
        setAppliedName(nameFilter);
        setCurrentPage(1);
    }

    function handleProfileClick(business) {
        navigate('/profile', {
            state: { business, directoryType, selectedCountry: appliedCountry, selectedState: appliedState, nameFilter: appliedName },
        });
    }

    function handlePageChange(page) {
        setCurrentPage(page);
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    const filteredBusinesses = businesses.filter(b =>
        b.BusinessName && b.BusinessName.trim() !== '' &&
        b.BusinessName.toLowerCase().includes(appliedName.toLowerCase())
    );
    const totalPages       = Math.ceil(filteredBusinesses.length / itemsPerPage);
    const startIndex       = (currentPage - 1) * itemsPerPage;
    const currentBusinesses = filteredBusinesses.slice(startIndex, startIndex + itemsPerPage);

    return (
        <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
            <PageMeta
                title={`${pageTitle} Directory | Farm & Food Business Listings`}
                description={`Find ${pageTitle.toLowerCase()} businesses near you. Browse verified listings with contact information, location, and details on Oatmeal Farm Network.`}
            />
            <Header />

            {/* ── Hero ── */}
            <div className="mx-auto px-4 pt-6" style={{ maxWidth: '1300px' }}>
                <div className="relative w-full overflow-hidden rounded-xl">
                    <img
                        src="/images/DirectoryHeader.webp"
                        alt={pageTitle}
                        className="w-full object-cover"
                        style={{ height: '250px', display: 'block' }}
                        loading="eager"
                        onError={e => { e.target.style.display = 'none'; }}
                    />
                    <div
                        className="absolute inset-0"
                        style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }}
                    />
                    <div className="absolute inset-0 flex flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
                        <div className="flex items-center gap-3 mb-3">
                            {categoryIcon && (
                                <img src={categoryIcon} alt={pageTitle} style={{ width: '48px', height: '48px', objectFit: 'contain' }} />
                            )}
                            <h1
                                style={{
                                    color: '#000000',
                                    fontFamily: "'Lora','Times New Roman',serif",
                                    fontSize: '2rem',
                                    fontWeight: 'bold',
                                    margin: 0,
                                    lineHeight: 1.2,
                                }}
                            >
                                {pageTitle}
                            </h1>
                        </div>
                        <Link
                            to="/directory"
                            style={{
                                display: 'inline-block',
                                backgroundColor: '#3D6B34',
                                color: '#fff',
                                fontSize: '0.8rem',
                                fontWeight: 'bold',
                                padding: '7px 18px',
                                borderRadius: '6px',
                                textDecoration: 'none',
                                width: 'fit-content',
                            }}
                        >
                            ← All Categories
                        </Link>
                    </div>
                </div>
            </div>

            <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

                {/* ── Filter card ── */}
                <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                    <div className="flex gap-4 flex-wrap items-end mb-4">
                        <div className="flex flex-col gap-1.5 flex-1" style={{ minWidth: '160px' }}>
                            <label className="text-xs font-semibold text-gray-600">Country</label>
                            <select
                                value={selectedCountry}
                                onChange={e => { setSelectedCountry(e.target.value); setSelectedState(''); }}
                                className="border border-gray-300 rounded-lg text-sm text-gray-700"
                                style={{ padding: '8px 10px' }}
                            >
                                <option value="">Select Country</option>
                                {countries.map(c => <option key={c} value={c}>{c}</option>)}
                            </select>
                        </div>

                        <div className="flex flex-col gap-1.5 flex-1" style={{ minWidth: '160px' }}>
                            <label className="text-xs font-semibold text-gray-600">State / Province</label>
                            <select
                                value={selectedState}
                                onChange={e => setSelectedState(e.target.value)}
                                disabled={states.length === 0}
                                className="border border-gray-300 rounded-lg text-sm text-gray-700"
                                style={{ padding: '8px 10px' }}
                            >
                                <option value="">Any</option>
                                {states.map(s => <option key={s.StateIndex} value={s.name}>{s.name}</option>)}
                            </select>
                        </div>

                        <div className="flex flex-col gap-1.5" style={{ minWidth: '200px', flex: 2 }}>
                            <label className="text-xs font-semibold text-gray-600">Business Name</label>
                            <input
                                type="text"
                                value={nameFilter}
                                onChange={e => setNameFilter(e.target.value)}
                                onKeyDown={e => e.key === 'Enter' && handleApplyFilters()}
                                placeholder="Search by name…"
                                className="border border-gray-300 rounded-lg text-sm text-gray-700"
                                style={{ padding: '8px 10px' }}
                            />
                        </div>
                    </div>
                    <button
                        onClick={handleApplyFilters}
                        style={{
                            backgroundColor: '#3D6B34',
                            color: '#fff',
                            border: 'none',
                            borderRadius: '6px',
                            padding: '8px 24px',
                            fontSize: '0.85rem',
                            fontWeight: 'bold',
                            cursor: 'pointer',
                        }}
                    >
                        Apply Filters
                    </button>
                </div>

                {/* ── Results heading ── */}
                <div className="flex items-center justify-between mb-4">
                    <h2 className="text-lg font-bold text-gray-900">
                        {pageTitle} Listings
                    </h2>
                    {!loading && filteredBusinesses.length > 0 && (
                        <span className="text-sm text-gray-400">
                            {startIndex + 1}–{Math.min(startIndex + itemsPerPage, filteredBusinesses.length)} of {filteredBusinesses.length}
                        </span>
                    )}
                </div>

                {error && <p className="text-red-500 mb-4">Error: {error}</p>}

                <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={handlePageChange} />

                {/* ── Business cards ── */}
                {loading ? (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                        {[...Array(6)].map((_, i) => (
                            <div key={i} className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 animate-pulse" style={{ height: '130px' }}>
                                <div className="shrink-0 bg-gray-200" style={{ width: '130px' }} />
                                <div className="flex-1 px-5 py-4 space-y-2">
                                    <div className="bg-gray-200 h-4 rounded w-3/4" />
                                    <div className="bg-gray-200 h-3 rounded w-1/2" />
                                    <div className="bg-gray-200 h-3 rounded w-2/3" />
                                </div>
                            </div>
                        ))}
                    </div>
                ) : currentBusinesses.length > 0 ? (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                        {currentBusinesses.map((business, i) => (
                            <BusinessCard key={startIndex + i} business={business} onProfileClick={handleProfileClick} />
                        ))}
                    </div>
                ) : (
                    <div className="bg-white rounded-xl border border-gray-200 text-center text-gray-500 py-16">
                        No businesses found for the selected filters.
                    </div>
                )}

                <div className="mt-6">
                    <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={handlePageChange} />
                </div>

            </div>

            <Footer />
        </div>
    );
};

export default DirectoryDetail;
