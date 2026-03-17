import React, { useState, useEffect } from 'react';
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
    { title: "Artisan Producers",         slug: "artisan-producers",         imgSrc: artisianImg },
    { title: "Business Resources",        slug: "business-resources",        imgSrc: brImg },
    { title: "Crafter Organizations",     slug: "crafter-organizations",     imgSrc: crafOrgImg },
    { title: "Farmers Markets",           slug: "farmers-markets",           imgSrc: farmersMarketImg },
    { title: "Farms / Ranches",           slug: "farms-ranches",             imgSrc: farmsRanchesImg },
    { title: "Fiber Cooperatives",        slug: "fiber-cooperatives",        imgSrc: fiberImg },
    { title: "Fiber Mills",               slug: "fiber-mills",               imgSrc: fiberMillsImg },
    { title: "Fisheries",                 slug: "fisheries",                 imgSrc: fisheriesImg },
    { title: "Fishermen",                 slug: "fishermen",                 imgSrc: fishermenImg },
    { title: "Food Cooperatives",         slug: "food-cooperatives",         imgSrc: foodCopImg },
    { title: "Food Hubs",                 slug: "food-hubs",                 imgSrc: foodHubImg },
    { title: "Grocery Stores",            slug: "grocery-stores",            imgSrc: groceryStoreImg },
    { title: "Manufacturers",             slug: "manufacturers",             imgSrc: manfacImg },
    { title: "Marinas",                   slug: "marinas",                   imgSrc: marinasImg },
    { title: "Meat Wholesalers",          slug: "meat-wholesalers",          imgSrc: meatImg },
    { title: "Real Estate Agents",        slug: "real-estate-agents",        imgSrc: realEstateImg },
    { title: "Restaurants",              slug: "restaurants",               imgSrc: restaurantsImg },
    { title: "Retailers",                 slug: "retailers",                 imgSrc: retailersImg },
    { title: "Service Providers",         slug: "service-providers",         imgSrc: serviceProvidersImg },
    { title: "Universities",              slug: "universities",              imgSrc: universitiesImg },
    { title: "Veterinarians",             slug: "veterinarians",             imgSrc: vetImg },
    { title: "Vineyards",                 slug: "vineyards",                 imgSrc: vineyardsImg },
    { title: "Wineries",                  slug: "wineries",                  imgSrc: wineriesImg },
    { title: "Other",                     slug: "others",                    imgSrc: othersImg },
];

const DirectoryList = () => {
    const [isLoggedIn, setIsLoggedIn] = useState(false);

    useEffect(() => {
        const token = localStorage.getItem('access_token');
        setIsLoggedIn(Boolean(token));
    }, []);
    return (
        <div className="min-h-screen bg-gray-100 font-sans">
            <Header />

        {/* Video Hero Banner */}
{/* Video Hero Banner */}
<div className="w-full overflow-hidden bg-black" style={{ maxWidth: '1300px', margin: '0 auto' }}>
    <video
        autoPlay
        muted
        loop
        playsInline
        className="w-full block"
        style={{ maxHeight: '300px', objectFit: 'cover', width: '100%' }}
    >
        <source src="/images/FoodSystemDirectory.mp4" type="video/mp4" />
    </video>
</div>

            {/* Hero Text - below video */}
            <div className="bg-white px-6 py-6 border-b border-gray-200">
                <div className="max-w-6xl mx-auto">
                    <h1 className="text-3xl font-bold text-gray-900 mb-2">
                        Food System &amp; Beyond Directory
                    </h1>
                    <p className="text-gray-600 text-base">
                        Find what you're looking for in our directory; it makes it easy to search and connect with local farms, food hubs, restaurants, and more.
                    </p>
                </div>
            </div>

            {/* Category Grid */}
            <div className="max-w-6xl mx-auto px-5 py-10">
                <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-5">
                    {directoryCategories.map((dir) => (
                        <Link
                            key={dir.slug}
                            to={'/directory/' + dir.slug}
                            className="no-underline group"
                        >
                            <div className="flex flex-col items-center bg-white border border-gray-200 rounded-xl overflow-hidden shadow-sm group-hover:shadow-md group-hover:-translate-y-1 transition-all duration-200 h-full p-4">
                                {/* Icon area */}
                                <div className="flex items-center justify-center w-full mb-3">
                                    <img
                                        src={dir.imgSrc}
                                        alt={dir.title}
                                        className="w-24 h-24 object-contain"
                                    />
                                </div>
                                {/* Green text label */}
                                <span className="text-[#4d734d] text-sm font-semibold text-center leading-tight group-hover:underline">
                                    {dir.title}
                                </span>
                            </div>
                        </Link>
                    ))}
               </div>
            </div>
            <Footer />  
        </div>
    );
};

export default DirectoryList;
