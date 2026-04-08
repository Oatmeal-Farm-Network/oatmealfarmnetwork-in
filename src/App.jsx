import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const FeatureBox = ({ title, description, imgSrc, link, eager }) => (
  <div className="flex flex-col bg-white rounded-[20px] p-[10px] shadow-[0_4px_8px_rgba(0,0,0,0.1)] min-h-[250px] text-center w-full mb-4 lg:mb-0 border border-[#4d734d]/20">
   <Link to={link} className="block mb-[10px] overflow-hidden rounded-[20px] aspect-square">
    <img
      src={imgSrc}
      alt={title}
      loading={eager ? 'eager' : 'lazy'}
      decoding={eager ? 'sync' : 'async'}
      fetchPriority={eager ? 'high' : 'auto'}
      className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
    />
  </Link>
    <h3 className="text-[#819360] font-bold text-xl mb-2 text-left">
      <Link to={link} className="no-underline hover:underline transition-all duration-300 text-[#819360]">
        {title}
      </Link>
    </h3>
    <p className="flex-grow text-sm mb-4 leading-relaxed font-medium text-gray-700 text-justify">
      {description}
    </p>
    <Link to={link} className="regsubmit2">
      Explore
    </Link>
  </div>
);

export default function App() {
  return (
    <div className="min-h-screen bg-gray-100 font-sans">
      <PageMeta
        title="Oatmeal Farm Network | AI-Powered Farm & Food Network"
        description="Connect farms, buyers, and food businesses with AI-powered tools. Browse livestock, plants, ingredients, and local food markets on Oatmeal Farm Network."
        canonical="https://oatmealfarmnetwork.com"
      />
      <Header />

      {/* Hero Section */}
      <section className="py-6 bg-white">
        <div className="max-w-7xl mx-auto px-4">
          <h1 className="text-4xl font-bold mt-3 mb-4 text-gray-900">
            Connect, Grow, Thrive: The Oatmeal Farm Network
          </h1>
          <p className="mt-3 text-gray-800 text-lg leading-relaxed">
            We're your comprehensive resource connecting the entire food system.
            Whether you're using our Food-System Directory to find local connections,
            leveraging Saige's AI insights for farm management, exploring our 4,000+
            food plant varieties and 3,000+ livestock breeds in our specialized databases,
            or buying and selling livestock in our Livestock Marketplace (Coming soon!),
            we help you thrive from ground to gourmet.
          </p>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-8 bg-gray-100 text-center">
        <div className="max-w-7xl mx-auto px-4">

          {/* Row 1: Directory, Saige, Marketplace — eager load, above the fold */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
            <FeatureBox
              title="Food-System Directory"
              description="From seed to supper, connect with every part of the food system in our directory of 25 categories."
              imgSrc="/images/DirectoryHome.webp"
              link="/directory"
              eager={true}
            />
            <FeatureBox
              title="Saige"
              description="Boost your farm's success with Saige's AI-powered insights for weather, soil, pests, and livestock."
              imgSrc="/images/CharlieHome.webp"
              link="/saige"
              eager={true}
            />
            <FeatureBox
              title="Livestock Marketplace"
              description="Buy and sell livestock online with our marketplace filled with 28 species of Livestock."
              imgSrc="/images/HomepageLivestockMarketplace.webp"
              link="/marketplaces"
              eager={true}
            />
          </div>

          {/* Row 2: Plants, Livestock, Ingredients — lazy load, below the fold */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <FeatureBox
              title="Plant Knowledgebase"
              description="Explore detailed profiles for over 4,000 food plant varieties, from grains to culinary herbs and spices."
              imgSrc="/images/PlantDBHome.webp"
              link="/plant-knowledgebase"
              eager={false}
            />
            <FeatureBox
              title="Livestock Database"
              description="Delve into detailed profiles for over 2,000 livestock breeds, covering morphology, origin, and use."
              imgSrc="/images/HomepageLivestockDB.webp"
              link="/livestock"
              eager={false}
            />
            <FeatureBox
              title="Ingredient Knowledgebase"
              description="A comprehensive look at over 1,400 Ingredients with over 14,000 varieties."
              imgSrc="/images/Homepagefoodsystemdirectory.webp"
              link="/ingredient-knowledgebase"
              eager={false}
            />
          </div>

        </div>
      </section>

      <Footer />
    </div>
  );
}