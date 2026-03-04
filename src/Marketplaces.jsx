import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const FeatureBox = ({ title, description, imgSrc, link }) => (
  <div className="flex flex-col bg-[#819360] rounded-[20px] p-[10px] shadow-[0_4px_8px_rgba(0,0,0,0.1)] min-h-[250px] text-center w-full mb-4 lg:mb-0 border border-[#4d734d]/20">
    <Link to={link} className="block mb-[10px] overflow-hidden rounded-[20px]">
      <img
        src={imgSrc}
        alt={title}
        className="w-full h-auto object-cover hover:scale-105 transition-transform duration-300"
      />
    </Link>
    <h3 className="text-[#e5af17] font-bold text-xl mb-2">
      <Link to={link} className="no-underline hover:underline transition-all duration-300 text-white">
        {title}
      </Link>
    </h3>
    <p className="text-white flex-grow text-sm mb-4 leading-relaxed font-medium">
      {description}
    </p>
    <Link
      to={link}
      className="bg-[#4d734d] text-white rounded-[20px] py-[10px] px-[25px] font-bold inline-block self-center hover:bg-white hover:text-[#4d734d] transition-colors mt-auto text-sm uppercase tracking-wider"
    >
      Learn More
    </Link>
  </div>
);

export default function Marketplaces() {
  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />

      <section className="py-6 bg-white text-center">
        <div className="max-w-7xl mx-auto px-4">
          <h1 className="text-4xl font-bold mt-3 mb-4 text-gray-900">
            Marketplaces
          </h1>
          <p className="mt-3 text-gray-800 text-lg leading-relaxed">
            Buy and sell through our marketplaces. Connect with farmers, ranchers, and buyers
            nationwide to grow your business.
          </p>
        </div>
      </section>

      <section className="py-8 bg-white text-center">
        <div className="max-w-7xl mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <FeatureBox
              title="Livestock Marketplace"
              description="Buy and sell livestock online with our marketplace filled with 28 species of Livestock."
              imgSrc="/images/HomepageLivestockMarketplace.webp"
              link="/marketplace"
            />
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
}
