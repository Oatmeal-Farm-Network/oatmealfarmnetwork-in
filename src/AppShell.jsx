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

  const pad = Expanded ? '13rem' : '4rem';

  return (
    <>
      <style>{`
        .app-shell-wrapper { --sidebar-pad: ${pad}; padding-left: var(--sidebar-pad); transition: padding 300ms; }
        .app-shell-wrapper > * {
          padding-top: 72px;
          box-sizing: border-box;
          min-height: 100vh;
          display: flex;
          flex-direction: column;
        }
        .app-shell-wrapper nav.sticky {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          width: auto;
          padding-left: calc(var(--sidebar-pad) + 1rem);
          box-sizing: border-box;
          z-index: 50;
        }
        .app-shell-wrapper footer {
          margin-top: auto;
          margin-left: calc(-1 * var(--sidebar-pad));
          width: calc(100% + var(--sidebar-pad));
          box-sizing: border-box;
          position: relative;
          z-index: 50;
        }
      `}</style>
      <AccountSidebar />
      <div className="app-shell-wrapper">
        {children}
      </div>
    </>
  );
}
