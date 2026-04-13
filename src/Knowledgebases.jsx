import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const FeatureBox = ({ title, description, imgSrc, link }) => (
  <div className="flex flex-col bg-[white] rounded-[20px] p-[10px] shadow-[0_4px_8px_rgba(0,0,0,0.1)] min-h-[250px] text-center w-full mb-4 lg:mb-0 border border-[#4d734d]/20">
    <Link to={link} className="block mb-[10px] overflow-hidden rounded-[20px]">
      <img
        src={imgSrc}
        alt={title}
        className="w-full h-auto object-cover hover:scale-105 transition-transform duration-300"
      />
    </Link>
    <h3>
      <Link to={link} className="body">
        {title}
      </Link>
    </h3>
    <p className="body">
      {description}
    </p>
    <Link to={link} className="regsubmit2">
      Learn More
    </Link>
  </div>
);

export default function Knowledgebases() {
  const isLoggedIn = useIsLoggedIn();

  return (
    <div className="min-h-screen font-sans">
      <PageMeta
        title="Agricultural Knowledgebases | Plants, Livestock & Ingredients"
        description="Explore 4,000+ food plant varieties, 2,000+ livestock breeds across 28 species, and 1,400+ agricultural ingredients in our comprehensive farm knowledgebases."
        canonical="https://oatmealfarmnetwork.com/knowledgebases"
      />
       <Header />

      <section className="py-6 bg-white text-center">
        <div className="max-w-7xl mx-auto px-4">
          <h1 className="text-4xl font-bold mt-3 mb-4 text-gray-900">
            Knowledgebases
          </h1>
          <p className="mt-3 text-gray-800 text-lg leading-relaxed">
            Explore our comprehensive databases covering plants, livestock, and ingredients.
            Whether you're researching food plant varieties, livestock breeds, or ingredient profiles,
            we have the information you need from ground to gourmet.
          </p>
        </div>
      </section>

      <section className="py-8 bg-white text-center">
        <div className="max-w-7xl mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <FeatureBox
              title="Plant Knowledgebase"
              description="Explore detailed profiles for over 4,000 food plant varieties, from grains to culinary herbs and spices."
              imgSrc="/images/PlantDBHome.webp"
              link="/plant-knowledgebase"
            />
            <FeatureBox
              title="Livestock Database"
              description="Delve into detailed profiles for over 2,000 livestock breeds, covering morphology, origin, and use."
              imgSrc="/images/HomepageLivestockDB.webp"
              link="/Livestock"
            />
            <FeatureBox
              title="Ingredient Knowledgebase"
              description="A comprehensive look at over 1,400 Ingredients with over 14,000 varieties."
              imgSrc="/images/Homepagefoodsystemdirectory.webp"
              link="/ingredient-knowledgebase"
            />
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
}