import React from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';

const About = () => {
  return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      
      {/* Container with correct JSX style object and className */}
      <div className="container-fluid mx-auto px-4" style={{ maxWidth: '1300px', minHeight: '67px', backgroundColor: 'white' }}>
        <div className="py-8">
          <div className="text-center">
            <h1 className="text-4xl font-bold mb-6">Supporting Agriculture</h1>
            
            {/* Self-closing img tag with correct width object */}
            <div className="flex justify-center mb-4">
               <img 
                 src="/images/Oatmeal-Farm-Network-logo-horizontal.svg" 
                 style={{ width: '220px' }} 
                 alt="Oatmeal Farm Network Logo" 
               />
            </div>
            
            <p className="text-xl italic mb-8">
              We empower farmers and ranchers with the tools to make smarter decisions, reach new markets, and build the future of agriculture.
            </p>
          </div>

          {/* Floated image replaced with a responsive grid or flex for better React behavior */}
          <div className="block overflow-hidden">
            <img 
              src="/images/AboutUs.webp" 
              className="md:float-right m-4 rounded-lg shadow-md max-w-sm w-full" 
              alt="About Us" 
            />
            
            <p className="mb-4">
              In today's agricultural landscape, success means more than just a good harvest or a healthy herd. It means leveraging cutting-edge technology to operate more efficiently and building direct connections to the communities you feed. 
            </p>
            <p className="mb-4">
              The <strong>Oatmeal Farm Network</strong> was built for this new era. We combine a vibrant, connected community with the revolutionary power of <strong>Oatmeal AI</strong> to give you an unmatched advantage. 
            </p>

            <h2 className="text-2xl font-bold mt-8 mb-4">The Oatmeal Advantage: AI-Powered Farming</h2>
            <p className="mb-4">
              Stop guessing and start knowing. Our network is exclusively powered by <strong>Oatmeal AI</strong>, delivering intelligent agents that analyze data, offer predictive insights, and help streamline your entire operation. 
            </p>

            <h2 className="text-2xl font-bold mt-8 mb-4">More Than a Network: A Complete Ecosystem</h2>
            <p className="mb-4">
              Break free from traditional barriers and connect to a larger world. The Oatmeal Farm Network is your gateway to a vast ecosystem designed to help you grow. 
            </p>
            
            <ul className="list-disc ml-8 space-y-2 mb-8">
              <li>
                <strong>The Livestock Marketplace:</strong> Showcase your animals to a nationwide audience and connect with serious buyers through our online marketplace. 
              </li>
              <li>
                <strong>The Food-System Directory:</strong> From seed to supper, find new partners, suppliers, and customers in our comprehensive directory. 
              </li>
              <li>
                <strong>Farm-to-Table Initiatives:</strong> We provide the tools and connections you need to build a thriving direct-to-consumer business. 
              </li>
            </ul>

            <h2 className="text-2xl font-bold mt-8 mb-4">Ready to Build the Future?</h2>
            <p className="mb-4">
              You're not just a user; you're a member of a community that understands the challenges and triumphs of agriculture. 
            </p>
            <p className="font-bold mb-4">Join us, and let's grow the future of agriculture, together.</p>
            
            <ul className="space-y-2">
              {/* Use Link instead of <a> for better performance */}
              <li><Link to="/LivestockDB/" className="text-blue-600 hover:underline">Explore the Marketplace</Link></li>
              <li><Link to="/Livestockmarketplace/" className="text-blue-600 hover:underline">View the Livestock DB</Link></li>
              <li><Link to="/directory" className="text-blue-600 hover:underline">Browse the Directory</Link></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default About;
