import React, { useEffect, useState } from 'react';
import { useParams, useNavigate, useLocation } from 'react-router-dom';
import { API_ENDPOINTS } from '../config';
import { DIRECTORY_TYPE_TO_IMAGE, DIRECTORY_TYPE_TO_BUSINESS_TYPE } from './directoryMappings';
import photoNotAvailable from '../images/photo not available .jpg';
import Header from '../../Header';
import Footer from '../../Footer';

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
    'others': '3'
};

function fixUrl(val) {
    if (!val || val.trim() === '') return null;
    if (val.startsWith('http')) return val;
    return 'https://' + val;
}

function SocialLinks(props) {
    var business = props.business;
    var links = [
        { url: fixUrl(business.BusinessFacebook),     icon: '/icons/facebook.png',         alt: 'Facebook' },
        { url: fixUrl(business.BusinessX),            icon: '/icons/TwitterX.png',          alt: 'Twitter/X' },
        { url: fixUrl(business.BusinessInstagram),    icon: '/icons/instagramicon.png',     alt: 'Instagram' },
        { url: fixUrl(business.BusinessLinkedIn),     icon: '/icons/linkedin.png',          alt: 'LinkedIn' },
        { url: fixUrl(business.BusinessPinterest),    icon: '/icons/PinterestLogo.png',     alt: 'Pinterest' },
        { url: fixUrl(business.BusinessYouTube),      icon: '/icons/YouTube.jpg',           alt: 'YouTube' },
        { url: fixUrl(business.BusinessTruthSocial),  icon: '/icons/Truthsocial.png',       alt: 'Truth Social' },
        { url: fixUrl(business.BusinessBlog),         icon: '/icons/BlogIcon.png',          alt: 'Blog' },
        { url: fixUrl(business.BusinessOtherSocial1), icon: '/icons/GeneralSocialIcon.png', alt: 'Social Media' },
        { url: fixUrl(business.BusinessOtherSocial2), icon: '/icons/GeneralSocialIcon.png', alt: 'Social Media' },
    ];

    var activeLinks = links.filter(function(l) { return l.url !== null; });
    if (activeLinks.length === 0) return null;

    return React.createElement(
        'div',
        { style: { display: 'flex', gap: '6px', marginBottom: '10px', alignItems: 'center', flexWrap: 'wrap' } },
        activeLinks.map(function(l, i) {
            return React.createElement(
                'a',
                { key: i, href: l.url, target: '_blank', rel: 'noopener noreferrer' },
                React.createElement('img', {
                    src: l.icon,
                    alt: l.alt,
                    style: { width: '28px', height: '28px', objectFit: 'contain' }
                })
            );
        })
    );
}

function Pagination(props) {
    var currentPage = props.currentPage;
    var totalPages = props.totalPages;
    var onPageChange = props.onPageChange;

    if (totalPages <= 1) return null;

    var pages = [];
    if (totalPages <= 7) {
        for (var i = 1; i <= totalPages; i++) pages.push(i);
    } else {
        var startPage = Math.max(1, currentPage - 2);
        var endPage = Math.min(totalPages, currentPage + 2);
        if (currentPage <= 3) endPage = Math.min(totalPages, 5);
        if (currentPage >= totalPages - 2) startPage = Math.max(1, totalPages - 4);
        for (var j = startPage; j <= endPage; j++) pages.push(j);
    }

    var btnBase = { padding: '6px 12px', border: '1px solid #ccc', borderRadius: '4px', backgroundColor: '#fff', cursor: 'pointer', fontSize: '0.85rem', color: '#333' };
    var btnActive = { padding: '6px 12px', border: '1px solid #5a7a3a', borderRadius: '4px', backgroundColor: '#5a7a3a', cursor: 'pointer', fontSize: '0.85rem', color: '#fff', fontWeight: 'bold' };

    return (
        <div style={{ display: 'flex', gap: '4px', alignItems: 'center', marginBottom: '16px', flexWrap: 'wrap' }}>
            {pages.map(function(pageNum) {
                return (
                    <button key={pageNum} style={currentPage === pageNum ? btnActive : btnBase} onClick={function() { onPageChange(pageNum); }}>
                        {pageNum}
                    </button>
                );
            })}
            {currentPage < totalPages ? (
                <button style={btnBase} onClick={function() { onPageChange(currentPage + 1); }}>{'>'}</button>
            ) : null}
            {totalPages > 5 ? (
                <button style={btnBase} onClick={function() { onPageChange(totalPages); }}>Last</button>
            ) : null}
        </div>
    );
}

function BusinessCard(props) {
    var business = props.business;
    var onProfileClick = props.onProfileClick;

    return (
        <div style={{ backgroundColor: '#fff', border: '1px solid #e0e0e0', borderRadius: '6px', padding: '16px', marginBottom: '12px', display: 'flex', gap: '16px', alignItems: 'flex-start' }}>
            <div style={{ flexShrink: 0 }}>
                <img
                    src={business.ProfileImage || photoNotAvailable}
                    alt={business.BusinessName + ' logo'}
                    style={{ width: '90px', height: '90px', objectFit: 'contain', borderRadius: '4px', border: '1px solid #eee' }}
                    onError={function(e) { e.target.onerror = null; e.target.src = photoNotAvailable; }}
                />
            </div>
            <div style={{ flex: 1 }}>
                <div style={{ fontSize: '1.1rem', fontWeight: 'bold', color: '#222', marginBottom: '4px' }}>
                    {business.BusinessName}
                </div>
                <div style={{ fontSize: '0.9rem', color: '#555', marginBottom: '4px' }}>
                    {[business.AddressCity, business.AddressState, business.AddressCountry].filter(Boolean).join(', ')}
                </div>
                {business.BusinessWebsite ? (
                    <a
                        href={fixUrl(business.BusinessWebsite)}
                        target="_blank"
                        rel="noopener noreferrer"
                        style={{ fontSize: '0.9rem', color: '#c47d00', textDecoration: 'none', display: 'block', marginBottom: '6px' }}
                    >
                        {business.BusinessWebsite}
                    </a>
                ) : null}
                <SocialLinks business={business} />
                <button
                    onClick={function() { onProfileClick(business); }}
                    style={{ backgroundColor: '#5a7a3a', color: 'white', border: 'none', borderRadius: '4px', padding: '7px 18px', fontSize: '0.85rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    Profile
                </button>
            </div>
        </div>
    );
}

const DirectoryDetail = function() {
    var params = useParams();
    var directoryType = params.directoryType;
    var navigate = useNavigate();
    var location = useLocation();
    var backState = location.state;

    var [countries, setCountries] = useState([]);
    var [states, setStates] = useState([]);
    var [businesses, setBusinesses] = useState([]);
    var [selectedCountry, setSelectedCountry] = useState(backState?.selectedCountry || '');
    var [selectedState, setSelectedState] = useState(backState?.selectedState || '');
    var [nameFilter, setNameFilter] = useState(backState?.nameFilter || '');
    var [appliedCountry, setAppliedCountry] = useState(backState?.selectedCountry || '');
    var [appliedState, setAppliedState] = useState(backState?.selectedState || '');
    var [appliedName, setAppliedName] = useState(backState?.nameFilter || '');
    var [loading, setLoading] = useState(false);
    var [error, setError] = useState(null);
    var [currentPage, setCurrentPage] = useState(1);
    var itemsPerPage = 10;

    var businessType = DIRECTORY_TYPE_TO_BUSINESS_TYPE_ID[directoryType] || directoryType;
    var pageTitle = directoryType
        .replace(/-/g, ' ')
        .split(' ')
        .map(function(word) { return word.charAt(0).toUpperCase() + word.slice(1); })
        .join(' ');
    var categoryIcon = DIRECTORY_TYPE_TO_IMAGE ? DIRECTORY_TYPE_TO_IMAGE[directoryType] : null;

    useEffect(function() {
        if (backState) window.history.replaceState({}, document.title);
    }, []);

    useEffect(function() {
        fetch(API_ENDPOINTS.COUNTRIES)
            .then(function(r) { return r.ok ? r.json() : []; })
            .then(function(data) { setCountries(data); })
            .catch(function() {});
    }, []);

    useEffect(function() {
        if (countries.length > 0 && !selectedCountry && !backState?.selectedCountry) {
            fetch('https://ipapi.co/json/')
                .then(function(r) { return r.ok ? r.json() : null; })
                .then(function(data) {
                    if (!data) return;
                    var match = countries.find(function(c) {
                        return c.toLowerCase() === (data.country_name || '').toLowerCase()
                            || (data.country_code === 'US' && c === 'USA');
                    });
                    if (match) {
                        setSelectedCountry(match);
                        setAppliedCountry(match);
                    }
                })
                .catch(function() {});
        }
    }, [countries]);

    useEffect(function() {
        if (!selectedCountry) { setStates([]); setSelectedState(''); return; }
        fetch(API_ENDPOINTS.STATES + '?country=' + encodeURIComponent(selectedCountry))
            .then(function(r) { return r.ok ? r.json() : []; })
            .then(function(data) { setStates(data || []); })
            .catch(function() { setStates([]); });
    }, [selectedCountry]);

    useEffect(function() {
        if (!appliedCountry) { setBusinesses([]); return; }
        setLoading(true);
        setError(null);
        var url = API_ENDPOINTS.BUSINESSES
            + '?country=' + encodeURIComponent(appliedCountry)
            + '&BusinessTypeID=' + encodeURIComponent(businessType);
        if (appliedState) url += '&state=' + encodeURIComponent(appliedState);
        fetch(url)
            .then(function(r) {
                if (!r.ok) throw new Error('Failed to fetch: ' + r.statusText);
                return r.json();
            })
            .then(function(data) { setBusinesses(data || []); setLoading(false); })
            .catch(function(err) { setError(err.message); setLoading(false); });
    }, [appliedCountry, appliedState, businessType]);

    useEffect(function() { setCurrentPage(1); }, [appliedCountry, appliedState, appliedName]);

    function handleApplyFilters() {
        setAppliedCountry(selectedCountry);
        setAppliedState(selectedState);
        setAppliedName(nameFilter);
        setCurrentPage(1);
    }

    function handleProfileClick(business) {
        navigate('/profile', {
            state: { business: business, directoryType: directoryType, selectedCountry: appliedCountry, selectedState: appliedState, nameFilter: appliedName }
        });
    }

    function handlePageChange(page) {
        setCurrentPage(page);
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    var filteredBusinesses = businesses.filter(function(b) {
        return b.BusinessName && b.BusinessName.trim() !== ''
            && b.BusinessName.toLowerCase().indexOf(appliedName.toLowerCase()) !== -1;
    });

    var totalPages = Math.ceil(filteredBusinesses.length / itemsPerPage);
    var startIndex = (currentPage - 1) * itemsPerPage;
    var endIndex = startIndex + itemsPerPage;
    var currentBusinesses = filteredBusinesses.slice(startIndex, endIndex);

    return (
        <div style={{ fontFamily: 'Arial, sans-serif', backgroundColor: '#f5f5f5', minHeight: '100vh' }}>
            <Header />

            {/* Page Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '16px 24px', backgroundColor: '#fff', borderBottom: '1px solid #e0e0e0' }}>
                {categoryIcon ? (
                    <img src={categoryIcon} alt={pageTitle} style={{ width: '52px', height: '52px', objectFit: 'contain' }} />
                ) : null}
                <h1 style={{ fontSize: '1.4rem', fontWeight: 'bold', color: '#222', margin: 0 }}>{pageTitle}</h1>
            </div>

            <div style={{ maxWidth: '1100px', margin: '0 auto', padding: '20px 16px' }}>

                {/* Filter Bar */}
                <div style={{ backgroundColor: '#fff', border: '1px solid #e0e0e0', borderRadius: '6px', padding: '20px 24px', marginBottom: '20px' }}>
                    <div style={{ display: 'flex', gap: '20px', flexWrap: 'wrap', alignItems: 'flex-end', marginBottom: '16px' }}>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px', flex: '1', minWidth: '160px' }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: '600', color: '#333' }}>Country</label>
                            <select
                                value={selectedCountry}
                                onChange={function(e) { setSelectedCountry(e.target.value); setSelectedState(''); }}
                                style={{ padding: '8px 10px', border: '1px solid #ccc', borderRadius: '4px', fontSize: '0.9rem' }}
                            >
                                <option value="">Select Country</option>
                                {countries.map(function(c) { return <option key={c} value={c}>{c}</option>; })}
                            </select>
                        </div>

                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px', flex: '1', minWidth: '160px' }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: '600', color: '#333' }}>State</label>
                            <select
                                value={selectedState}
                                onChange={function(e) { setSelectedState(e.target.value); }}
                                disabled={states.length === 0}
                                style={{ padding: '8px 10px', border: '1px solid #ccc', borderRadius: '4px', fontSize: '0.9rem' }}
                            >
                                <option value="">Any</option>
                                {states.map(function(s) { return <option key={s} value={s}>{s}</option>; })}
                            </select>
                        </div>

                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px', flex: '2', minWidth: '200px' }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: '600', color: '#333' }}>Business Name</label>
                            <input
                                type="text"
                                value={nameFilter}
                                onChange={function(e) { setNameFilter(e.target.value); }}
                                placeholder="Search by name"
                                style={{ padding: '8px 10px', border: '1px solid #ccc', borderRadius: '4px', fontSize: '0.9rem' }}
                            />
                        </div>
                    </div>
                    <button
                        onClick={handleApplyFilters}
                        style={{ backgroundColor: '#5a7a3a', color: 'white', border: 'none', borderRadius: '4px', padding: '9px 24px', fontSize: '0.9rem', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        Apply Filters
                    </button>
                </div>

                {/* Results count */}
                {filteredBusinesses.length > 0 && !loading ? (
                    <div style={{ textAlign: 'right', fontSize: '0.9rem', color: '#555', marginBottom: '10px' }}>
                        {startIndex + 1} - {Math.min(endIndex, filteredBusinesses.length)} of {filteredBusinesses.length} Results
                    </div>
                ) : null}

                {error ? <p style={{ color: 'red' }}>Error: {error}</p> : null}
                {loading ? <p style={{ textAlign: 'center', padding: '40px', color: '#666' }}>Loading...</p> : null}

                <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={handlePageChange} />

                {currentBusinesses.length > 0 ? (
                    currentBusinesses.map(function(business, index) {
                        return <BusinessCard key={startIndex + index} business={business} onProfileClick={handleProfileClick} />;
                    })
                ) : (
                    !loading && appliedCountry ? (
                        <div style={{ textAlign: 'center', color: '#666', padding: '40px', backgroundColor: '#fff', borderRadius: '6px', border: '1px solid #e0e0e0' }}>
                            No businesses found for the selected filters.
                        </div>
                    ) : null
                )}

                {!appliedCountry && !loading ? (
                    <div style={{ textAlign: 'center', color: '#666', padding: '40px', backgroundColor: '#fff', borderRadius: '6px', border: '1px solid #e0e0e0' }}>
                        Please select a country and click Apply Filters to view businesses.
                    </div>
                ) : null}

                <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={handlePageChange} />
            </div>

            <Footer />
        </div>
    );
};

export default DirectoryDetail;
