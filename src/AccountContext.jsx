import React, { createContext, useContext, useState, useEffect } from 'react';

const AccountContext = createContext(null);

export function AccountProvider({ children }) {
  const [Business, setBusiness] = useState(null);
  const [BusinessID, setBusinessID] = useState(null);
  const [OpenSections, setOpenSections] = useState({});
  const [Expanded, setExpanded] = useState(true);
  const [businesses, setBusinesses] = useState([]);

  // Fetch user's businesses once on app load, then auto-load the previously-selected
  // (or first) business so the global sidebar has data on every page.
  useEffect(() => {
    const token = localStorage.getItem('access_token');
    const peopleId = localStorage.getItem('people_id');
    if (!token || !peopleId) return;
    fetch(`${import.meta.env.VITE_API_URL}/auth/my-businesses?PeopleID=${peopleId}`)
      .then(r => r.json())
      .then(data => {
        const list = Array.isArray(data) ? data : [];
        setBusinesses(list);
        if (list.length === 0) return;
        const stored = parseInt(localStorage.getItem('selected_business_id') || '', 10);
        const pick = list.find(b => (b.BusinessID ?? b.businessId ?? b.id) === stored) || list[0];
        const id = pick.BusinessID ?? pick.businessId ?? pick.id;
        if (id) LoadBusiness(id);
      })
      .catch(() => {});
  }, []);

const LoadBusiness = (ID, Force = false) => {
    if (ID === BusinessID && Business && !Force) return;
    setBusinessID(ID);
    localStorage.setItem('selected_business_id', ID);
    fetch(`${import.meta.env.VITE_API_URL}/auth/account-home?BusinessID=${ID}`)
      .then(Res => {
        if (!Res.ok) throw new Error(`HTTP ${Res.status}`);
        return Res.json();
      })
      .then(Data => setBusiness(Data))
      .catch(err => console.error('LoadBusiness failed:', err));
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