import React from 'react';
import { useLocation } from 'react-router-dom';
import { useAccount } from './AccountContext';
import AccountSidebar from './AccountSidebar';

const EXCLUDED_PREFIXES = [
  '/login',
  '/signup',
  '/forgot-password',
  '/sites/',
  '/judge/',
  '/speaker/',
  '/provenance/',
];

function isExcluded(pathname) {
  return EXCLUDED_PREFIXES.some(p =>
    p.endsWith('/') ? pathname.startsWith(p) : pathname === p
  );
}

export default function AppShell({ children }) {
  const { Business, BusinessID, Expanded } = useAccount();
  const location = useLocation();
  const token = typeof window !== 'undefined' ? localStorage.getItem('access_token') : null;

  const showSidebar =
    !!token &&
    !!(Business || BusinessID) &&
    !isExcluded(location.pathname);

  if (!showSidebar) return children;

  return (
    <>
      <AccountSidebar />
      <div
        className="transition-[padding] duration-300"
        style={{ paddingLeft: Expanded ? '13rem' : '4rem' }}
      >
        {children}
      </div>
    </>
  );
}
