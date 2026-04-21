import React, { createContext, useContext, useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';

const AccountContext = createContext(null);

export function AccountProvider({ children }) {
  const [Business, setBusiness] = useState(null);
  const [BusinessID, setBusinessID] = useState(null);
  const [OpenSections, setOpenSections] = useState({});
  const [Expanded, setExpanded] = useState(true);
  const [businesses, setBusinesses] = useState([]);
  const location = useLocation();

  // Read BusinessID from URL so the context follows page navigation instead of
  // sticking on whichever business happened to be first in the list.
  const urlBusinessID = (() => {
    const p = parseInt(new URLSearchParams(location.search).get('BusinessID') || '', 10);
    return Number.isFinite(p) ? p : null;
  })();

  // Fetch user's businesses once on app load, then auto-load either the URL's
  // BusinessID, the previously-selected one, or the first in the list.
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
        const pick =
          list.find(b => (b.BusinessID ?? b.businessId ?? b.id) === urlBusinessID) ||
          list.find(b => (b.BusinessID ?? b.businessId ?? b.id) === stored) ||
          list[0];
        const id = pick.BusinessID ?? pick.businessId ?? pick.id;
        if (id) LoadBusiness(id);
      })
      .catch(() => {});
  }, []);

  // If the URL's BusinessID changes (e.g. user navigates to a different account's
  // page), swap the context so the sidebar re-renders against the right business.
  useEffect(() => {
    if (urlBusinessID && urlBusinessID !== BusinessID) {
      LoadBusiness(urlBusinessID);
    }
  }, [urlBusinessID]);

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