import React from 'react';
import { Link } from 'react-router-dom';

export default function Footer() {
  return (
    <footer className="bg-[#1a1a1a] text-white py-12 mt-12">
      <div className="max-w-7xl mx-auto px-4">
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
          
          {/* Brand */}
          <div>
            <img
              src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp"
              alt="Oatmeal Farm Network"
              className="h-10 mb-4"
            />
            <p className="text-gray-400 text-sm leading-relaxed">
              Connecting the entire food system — from seed to supper.
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="footer">Explore</h3>
            <ul className="space-y-2 text-sm">
              <li><Link to="/directory" className="footer">Food-System Directory</Link></li>
              <li><Link to="/plants" className="footer">Plant Knowledgebase</Link></li>
              <li><Link to="/livestock" className="footer">Livestock Database</Link></li>
              <li><Link to="/ingredients" className="footer">Ingredient Knowledgebase</Link></li>
              <li><Link to="/marketplace" className="footer">Livestock Marketplace</Link></li>
            </ul>
          </div>

          {/* Company */}
          <div>
            <h3 className="footer">Company</h3>
            <ul className="space-y-2 text-sm">
              <li><Link to="/about" className="footer">About Us</Link></li>
              <li><Link to="/saige" className="footer">Saige AI</Link></li>
              <li><Link to="/login" className="footer">Login</Link></li>
              <li><Link to="/signup" className="footer">Sign Up</Link></li>
            </ul>
          </div>

        </div>

        <div className="border-t border-gray-800 pt-6 text-center">
          <p className="text-gray-500 text-xs  tracking-[0.2em]">© 2025 - {new Date().getFullYear()} Oatmeal AI. All rights reserved.</p>
        </div>

      </div>
    </footer>
  );
}