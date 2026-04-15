// src/Breadcrumbs.jsx
// Reusable breadcrumb nav matching the site-wide style (green #3D6B34 links,
// › separators). Also emits BreadcrumbList JSON-LD to <head> for SEO.
//
// Usage:
//   <Breadcrumbs items={[
//     { label: 'Livestock Marketplace', to: '/marketplaces/livestock' },
//     { label: 'Alpacas', to: '/marketplaces/livestock/alpacas' },
//     { label: 'ALR Josephine' }, // last item (current page) — omit `to`
//   ]} />
import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';

const BASE_URL = 'https://oatmealfarmnetwork.com';
const MARKER   = 'data-breadcrumb-jsonld';

export default function Breadcrumbs({ items = [], className = '', style = {} }) {
  const key = JSON.stringify(items);

  useEffect(() => {
    if (!items || items.length === 0) return;
    const list = items.map((it, i) => {
      const entry = {
        '@type': 'ListItem',
        position: i + 1,
        name: it.label,
      };
      if (it.to) entry.item = BASE_URL + it.to;
      return entry;
    });
    const data = {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: list,
    };
    document.querySelectorAll(`script[${MARKER}]`).forEach(el => el.remove());
    const el = document.createElement('script');
    el.type = 'application/ld+json';
    el.setAttribute(MARKER, 'true');
    el.text = JSON.stringify(data);
    document.head.appendChild(el);
    return () => {
      document.querySelectorAll(`script[${MARKER}]`).forEach(el => el.remove());
    };
  }, [key]);

  if (!items || items.length === 0) return null;

  return (
    <nav
      aria-label="Breadcrumb"
      className={`text-xs mb-3 flex flex-wrap items-center ${className}`}
      style={{ gap: 4, color: '#6b7280', ...style }}
    >
      {items.map((item, idx) => {
        const isLast = idx === items.length - 1;
        return (
          <React.Fragment key={idx}>
            {idx > 0 && <span aria-hidden="true" style={{ color: '#9ca3af' }}>›</span>}
            {item.to && !isLast ? (
              <Link
                to={item.to}
                style={{ color: '#3D6B34', textDecoration: 'none', fontWeight: 600 }}
              >
                {item.label}
              </Link>
            ) : (
              <span
                aria-current={isLast ? 'page' : undefined}
                style={{ color: isLast ? '#374151' : '#6b7280' }}
              >
                {item.label}
              </span>
            )}
          </React.Fragment>
        );
      })}
    </nav>
  );
}
