import React, { createContext, useContext, useState, useEffect } from 'react';

const AccountContext = createContext(null);

export function AccountProvider({ children }) {
  const [Business, setBusiness] = useState(null);
  const [BusinessID, setBusinessID] = useState(null);
  const [OpenSections, setOpenSections] = useState({});
  const [Expanded, setExpanded] = useState(true);
  const [businesses, setBusinesses] = useState([]);

  // Fetch user's businesses once on app load
  useEffect(() => {
    const token = localStorage.getItem('access_token');
    const peopleId = localStorage.getItem('people_id');
    if (token && peopleId) {
      fetch(`${import.meta.env.VITE_API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
        .then(r => r.json())
        .then(data => setBusinesses(Array.isArray(data) ? data : []))
        .catch(() => {});
    }
  }, []);

const LoadBusiness = (ID, Force = false) => {
    if (ID === BusinessID && Business && !Force) return;
    setBusinessID(ID);
    localStorage.setItem('selected_business_id', ID);  // ← add this line
    fetch(`${import.meta.env.VITE_API_URL}/auth/account-home?BusinessID=${ID}`)
      .then(Res => Res.json())
      .then(Data => setBusiness(Data));
  };

  return (
    <AccountContext.Provider value={{
      Business,
      setBusiness,
      BusinessID,
      LoadBusiness,
      OpenSections,
      setOpenSections,
      Expanded,
      setExpanded,
      businesses,
      setBusinesses,
    }}>
      {children}
    </AccountContext.Provider>
  );
}

export function useAccount() {
  return useContext(AccountContext);
}