import React, { useState } from 'react';
import { Link } from 'react-router-dom';

const Header = () => {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <nav className="bg-[#A3301E] py-3 px-4 shadow-2xl sticky top-0 z-50 font-montserrat">
      <div className="max-w-7xl mx-auto flex justify-between items-center">
        
        {/* Logo (Left side) */}
        <Link to="/" className="flex items-center shrink-0">
          <img 
            src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp" 
            className="h-10 md:h-12" 
            alt="Oatmeal Farm Network" 
          />
        </Link>

        {/* Desktop Navigation - Centered, Normal Weight, No Uppercase */}
        <div className="hidden lg:flex flex-grow justify-center">
          <ul className="flex space-x-10 text-sm font-normal">
            <li>
              <Link to="/" className="!text-white hover:text-[#EFAE15] transition-colors">Home</Link>
            </li>
             <li>
              <Link to="/directory" className="!text-white hover:text-[#EFAE15] transition-colors">Directory</Link>
            </li>
            <li>
              <Link to="/knowledgebases" className="!text-white hover:text-[#EFAE15] transition-colors">Knowledgebases</Link>
            </li>
             <li>
              <Link to="/marketplaces" className="!text-white hover:text-[#EFAE15] transition-colors">Marketplaces</Link>
            </li>
             <li>
              <Link to="/saige" className="!text-white hover:text-[#EFAE15] transition-colors">Saige</Link>
            </li>
            <li>
              <Link to="/about" className="!text-white hover:text-[#EFAE15] transition-colors">About Us</Link>
            </li>
           
           
            <li>
              <Link to="/login" className="!text-white hover:text-[#EFAE15] transition-colors">Login</Link>
            </li>
             <li>
              <Link to="/signup" className="!text-white hover:text-[#EFAE15] transition-colors">Signup</Link>
            </li>
          </ul>
        </div>

        {/* Placeholder for symmetry on desktop, Hamburger on mobile */}
        <div className="lg:w-[180px] flex justify-end"> {/* Matches logo width roughly to keep center perfectly centered */}
          <button 
            onClick={() => setIsOpen(!isOpen)}
            className="lg:hidden text-white text-3xl focus:outline-none"
            type="button"
          >
            {isOpen ? '✕' : '☰'}
          </button>
        </div>
      </div>

      {/* Mobile Menu Dropdown */}
      {isOpen && (
        <div className="lg:hidden bg-[#A3301E] absolute top-full left-0 w-full border-t border-white/10 shadow-xl z-50">
          <ul className="flex flex-col p-6 space-y-4 text-base font-normal text-center">
            <li><Link to="/" onClick={() => setIsOpen(false)} className="!text-white block">Home</Link></li>
             <li><Link to="/directory" onClick={() => setIsOpen(false)} className="!text-white block">Directory</Link></li>
              <li><Link to="/Knowledgebases" onClick={() => setIsOpen(false)} className="!text-white block">Knowledgebases</Link></li>
             <li><Link to="/marketplace" onClick={() => setIsOpen(false)} className="!text-white block">Marketplaces</Link></li>
            <li><Link to="/saige" onClick={() => setIsOpen(false)} className="!text-white block">Saige</Link></li>
            <li><Link to="/about" onClick={() => setIsOpen(false)} className="!text-white block">About Us</Link></li>
            <li><Link to="/login" onClick={() => setIsOpen(false)} className="!text-white block">Login</Link></li>
            <li><Link to="/signup" onClick={() => setIsOpen(false)} className="!text-white block">Sign Up</Link></li>

          </ul>
        </div>
      )}
    </nav>
  );
};

export default Header;