import React, { createContext, useContext, useState, useEffect } from 'react';

const AccountContext = createContext(null);

export function AccountProvider({ children }) {
  const [Business, setBusiness] = useState(null);
  const [BusinessID, setBusinessID] = useState(null);
  const [OpenSections, setOpenSections] = useState({});
  const [Expanded, setExpanded] = useState(true);

  const LoadBusiness = (ID, Force = false) => {
    if (ID === BusinessID && Business && !Force) return;
    setBusinessID(ID);
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
      setExpanded
    }}>
      {children}
    </AccountContext.Provider>
  );
}

export function useAccount() {
  return useContext(AccountContext);
}