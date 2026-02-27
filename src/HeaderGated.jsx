import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';

const Header = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [user, setUser] = useState(null);
  const navigate = useNavigate();
  const [Businesses, setBusinesses] = useState([]);

  useEffect(() => {
    const firstName = localStorage.getItem('first_name');
    const token = localStorage.getItem('access_token');
    const peopleId = localStorage.getItem('people_id');
    if (token && firstName) {
      setUser({ PeopleFirstName: firstName, PeopleID: peopleId });

      fetch(`${import.meta.env.VITE_API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
        .then(Res => Res.json())
        .then(Data => setBusinesses(Data))
        .catch(Err => console.error('Error fetching businesses:', Err));
    }
  }, []);

  const handleLogout = () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('people_id');
    localStorage.removeItem('first_name');
    localStorage.removeItem('last_name');
    localStorage.removeItem('access_level');
    setUser(null);
    navigate('/login');
  };

  return (
    <nav className="bg-[#A3301E] py-3 px-4 shadow-2xl sticky top-0 z-50 font-montserrat">
      <div className="max-w-7xl mx-auto flex justify-between items-center">

        {/* Logo */}
        <Link to="/" className="flex items-center shrink-0">
          <img
            src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp"
            className="h-10 md:h-12"
            alt="Oatmeal Farm Network"
          />
        </Link>

        {/* Desktop Navigation */}
        <div className="hidden lg:flex flex-grow justify-center">
          <ul className="flex space-x-10 text-sm font-normal">
            <li><Link to="/dashboard" className="nav-link">Dashboard</Link></li>
            <li><Link to="/saige" className="nav-link">Saige</Link></li>
            <li><Link to="/contact-us" className="nav-link">Contact Us</Link></li>

            <li className="relative group">
              <button className="nav-link flex items-center gap-1">
                Accounts ▾
              </button>
              <ul className="absolute top-full left-0 bg-white shadow-lg rounded-xl py-2 min-w-[180px] hidden group-hover:block z-50">
                <li>
                  <Link to={`/accounts?PeopleID=${user?.PeopleID}`} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                    Accounts
                  </Link>
                </li>
                <li>
                  <Link to={`/accounts/new?PeopleID=${user?.PeopleID}`} className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                    Add Account
                  </Link>
                </li>
                {Businesses.length > 0 && (
                  <>
                    <li><hr className="my-2 border-gray-200" /></li>
                    {Businesses.map(B => (
                      <li key={B.BusinessID}>
                        <Link
                          to={`/account?PeopleID=${user?.PeopleID}&BusinessID=${B.BusinessID}`}
                          className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                        >
                          {B.BusinessName.substring(0, 25)}
                        </Link>
                      </li>
                    ))}
                  </>
                )}
              </ul>
            </li>

            <li><button onClick={handleLogout} className="nav-link">Log Out</button></li>
          </ul>
        </div>

        {/* Hamburger */}
        <div className="lg:w-[180px] flex justify-end">
          <button
            onClick={() => setIsOpen(!isOpen)}
            className="lg:hidden text-white text-3xl focus:outline-none"
            type="button"
          >
            {isOpen ? '✕' : '☰'}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {isOpen && (
        <div className="lg:hidden bg-[#A3301E] absolute top-full left-0 w-full border-t border-white/10 shadow-xl z-50">
          <ul className="flex flex-col p-6 space-y-4 text-base font-normal text-center">
            <li><Link to="/dashboard" onClick={() => setIsOpen(false)} className="nav-link block">Dashboard</Link></li>
            <li><Link to="/saige" onClick={() => setIsOpen(false)} className="nav-link block">Saige</Link></li>
            <li><Link to="/contact-us" onClick={() => setIsOpen(false)} className="nav-link block">Contact Us</Link></li>
            <li>
              <p className="text-[#EFAE15] font-semibold text-sm mb-1">Accounts</p>
              <ul className="space-y-2">
                <li>
                  <Link to={`/accounts?PeopleID=${user?.PeopleID}`} onClick={() => setIsOpen(false)} className="nav-link block">
                    Accounts
                  </Link>
                </li>
                <li>
                  <Link to={`/accounts/new?PeopleID=${user?.PeopleID}`} onClick={() => setIsOpen(false)} className="nav-link block">
                    Add Account
                  </Link>
                </li>
                {Businesses.length > 0 && (
                  <>
                    <hr className="border-white/20 my-1" />
                    {Businesses.map(B => (
                      <li key={B.BusinessID}>
                        <Link
                          to={`/account?PeopleID=${user?.PeopleID}&BusinessID=${B.BusinessID}`}
                          onClick={() => setIsOpen(false)}
                          className="nav-link block"
                        >
                          {B.BusinessName}
                        </Link>
                      </li>
                    ))}
                  </>
                )}
              </ul>
            </li>
            <li><button onClick={handleLogout} className="nav-link">Log Out</button></li>
          </ul>
        </div>
      )}
    </nav>
  );
};

export default Header;
