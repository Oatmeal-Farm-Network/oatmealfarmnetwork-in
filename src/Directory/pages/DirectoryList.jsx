import React from 'react';
import { Link } from 'react-router-dom';
import Header from '../../Header';
import Footer from '../../Footer';

import agriAssociaImg from '../Icons/Agricultural Associations.jpg';
import artisianImg from '../Icons/Artisan Producers.jpg';
import brImg from '../Icons/Business Resources.jpg';
import crafOrgImg from '../Icons/Crafter-organizations.jpg';
import farmersMarketImg from '../Icons/Farmers Markets.jpg';
import farmsRanchesImg from '../Icons/Farms_Ranches.jpg';
import fiberImg from '../Icons/Fiber Cooperatives.jpg';
import fiberMillsImg from '../Icons/Fiber Mills.jpg';
import fisheriesImg from '../Icons/Fisheries.jpg';
import fishermenImg from '../Icons/Fishermen.jpg';
import foodCopImg from '../Icons/Food Cooperatives.jpg';
import foodHubImg from '../Icons/Food Hubs.jpg';
import groceryStoreImg from '../Icons/Grocery Stores.jpg';
import manfacImg from '../Icons/Manufacturers.jpg';
import marinasImg from '../Icons/Marinas.jpg';
import meatImg from '../Icons/Meat Wholesalers.jpg';
import realEstateImg from '../Icons/Real Estate Agents.jpg';
import restaurantsImg from '../Icons/Restaurants.jpg';
import retailersImg from '../Icons/Retailers.jpg';
import serviceProvidersImg from '../Icons/Service Providers.jpg';
import universitiesImg from '../Icons/Universities.jpg';
import vetImg from '../Icons/Veterinarians.jpg';
import vineyardsImg from '../Icons/Vineyards.jpg';
import wineriesImg from '../Icons/Wineries.jpg';
import othersImg from '../Icons/Other.jpg';

const directoryCategories = [
    { title: "Agricultural Associations", slug: "agricultural-associations", imgSrc: agriAssociaImg },
    { title: "Artisan Producers", slug: "artisan-producers", imgSrc: artisianImg },
    { title: "Business Resources", slug: "business-resources", imgSrc: brImg },
    { title: "Crafter Organizations", slug: "crafter-organizations", imgSrc: crafOrgImg },
    { title: "Farmers Markets", slug: "farmers-markets", imgSrc: farmersMarketImg },
    { title: "Farms / Ranches", slug: "farms-ranches", imgSrc: farmsRanchesImg },
    { title: "Fiber Cooperatives", slug: "fiber-cooperatives", imgSrc: fiberImg },
    { title: "Fiber Mills", slug: "fiber-mills", imgSrc: fiberMillsImg },
    { title: "Fisheries", slug: "fisheries", imgSrc: fisheriesImg },
    { title: "Fishermen", slug: "fishermen", imgSrc: fishermenImg },
    { title: "Food Cooperatives", slug: "food-cooperatives", imgSrc: foodCopImg },
    { title: "Food Hubs", slug: "food-hubs", imgSrc: foodHubImg },
    { title: "Grocery Stores", slug: "grocery-stores", imgSrc: groceryStoreImg },
    { title: "Manufacturers", slug: "manufacturers", imgSrc: manfacImg },
    { title: "Marinas", slug: "marinas", imgSrc: marinasImg },
    { title: "Meat Wholesalers", slug: "meat-wholesalers", imgSrc: meatImg },
    { title: "Real Estate Agents", slug: "real-estate-agents", imgSrc: realEstateImg },
    { title: "Restaurants", slug: "restaurants", imgSrc: restaurantsImg },
    { title: "Retailers", slug: "retailers", imgSrc: retailersImg },
    { title: "Service Providers", slug: "service-providers", imgSrc: serviceProvidersImg },
    { title: "Universities", slug: "universities", imgSrc: universitiesImg },
    { title: "Veterinarians", slug: "veterinarians", imgSrc: vetImg },
    { title: "Vineyards", slug: "vineyards", imgSrc: vineyardsImg },
    { title: "Wineries", slug: "wineries", imgSrc: wineriesImg },
    { title: "Other", slug: "others", imgSrc: othersImg }
];

const DirectoryList = () => {
    return (
        <div>
            <Header />

            {/* Video Hero Banner */}
            <div style={{
                position: 'relative',
                width: '100%',
                maxHeight: '400px',
                overflow: 'hidden',
                backgroundColor: '#000',
            }}>
                <video
                    autoPlay
                    muted
                    loop
                    playsInline
                    style={{
                        width: '100%',
                        maxHeight: '400px',
                        objectFit: 'cover',
                        display: 'block',
                    }}
                >
                    <source src="/images/FoodSystemDirectory.mp4" type="video/mp4" />
                </video>

                {/* Overlay text on top of video */}
                <div style={{
                    position: 'absolute',
                    top: 0,
                    left: 0,
                    width: '100%',
                    height: '100%',
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                    justifyContent: 'center',
                    background: 'rgba(0,0,0,0.35)',
                }}>
                    <h1 style={{
                        color: 'white',
                        fontSize: '2.5rem',
                        fontWeight: 'bold',
                        textShadow: '2px 2px 6px rgba(0,0,0,0.7)',
                        margin: '0 0 10px 0',
                        textAlign: 'center',
                        padding: '0 20px',
                    }}>
                        Food System &amp; Beyond Directory
                    </h1>
                    <p style={{
                        color: 'white',
                        fontSize: '1.1rem',
                        textShadow: '1px 1px 4px rgba(0,0,0,0.7)',
                        margin: 0,
                        textAlign: 'center',
                        padding: '0 20px',
                    }}>
                        Find and connect with local farms, food hubs, restaurants, and more.
                    </p>
                </div>
            </div>

            {/* Category Grid */}
            <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '30px 20px 40px 20px' }}>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fill, minmax(140px, 1fr))',
                    gap: '16px',
                }}>
                    {directoryCategories.map(function(dir) {
                        return (
                            <Link
                                key={dir.slug}
                                to={'/directory/' + dir.slug}
                                style={{ textDecoration: 'none' }}
                            >
                                <div
                                    style={{
                                        border: '1px solid #ddd',
                                        borderRadius: '8px',
                                        padding: '16px 8px',
                                        textAlign: 'center',
                                        backgroundColor: '#fff',
                                        boxShadow: '0 2px 5px rgba(0,0,0,0.08)',
                                        transition: 'box-shadow 0.2s, transform 0.2s',
                                        cursor: 'pointer',
                                        height: '100%',
                                        display: 'flex',
                                        flexDirection: 'column',
                                        alignItems: 'center',
                                        justifyContent: 'space-between',
                                    }}
                                    onMouseEnter={function(e) {
                                        e.currentTarget.style.boxShadow = '0 4px 12px rgba(0,0,0,0.18)';
                                        e.currentTarget.style.transform = 'translateY(-2px)';
                                    }}
                                    onMouseLeave={function(e) {
                                        e.currentTarget.style.boxShadow = '0 2px 5px rgba(0,0,0,0.08)';
                                        e.currentTarget.style.transform = 'translateY(0)';
                                    }}
                                >
                                    <img
                                        src={dir.imgSrc}
                                        alt={dir.title}
                                        style={{
                                            width: '90px',
                                            height: '90px',
                                            objectFit: 'contain',
                                            marginBottom: '12px',
                                        }}
                                    />
                                    <span style={{
                                        display: 'block',
                                        backgroundColor: '#A3301E',
                                        color: 'white',
                                        borderRadius: '4px',
                                        padding: '6px 8px',
                                        fontSize: '0.78rem',
                                        fontWeight: 'bold',
                                        width: '100%',
                                        boxSizing: 'border-box',
                                    }}>
                                        {dir.title}
                                    </span>
                                </div>
                            </Link>
                        );
                    })}
                </div>
            </div>

            <Footer />
        </div>
    );
};

export default DirectoryList;
