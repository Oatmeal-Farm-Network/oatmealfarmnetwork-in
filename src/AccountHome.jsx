import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

// ─── SVG icon helper ──────────────────────────────────────────────────────────
const I = ({ children, size = 20 }) => (
  <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor"
    strokeWidth="1.75" strokeLinecap="round" strokeLinejoin="round">
    {children}
  </svg>
);

// ─── Business-type → persona mapping ─────────────────────────────────────────
// Persona drives hero color, priority stats, and feature order.
const BIZ_PERSONA = {
  8:  'farmer',       // Farm / Ranch
  22: 'farmer',       // Fishery
  23: 'farmer',       // Fishermen
  31: 'farmer',       // Herb & Tea Producer
  34: 'farmer',       // Vineyards
  11: 'producer',     // Artisan Food Producer
  16: 'producer',     // Manufacturer
  19: 'producer',     // Meat Wholesaler
  33: 'producer',     // Winery
  10: 'distributor',  // Food Hub
  14: 'distributor',  // Food Cooperative
  24: 'distributor',  // Retailer
  26: 'distributor',  // Grocery Store
  29: 'distributor',  // Farmers Market
  36: 'distributor',  // Food Aggregator
  9:  'restaurant',   // Restaurant
  1:  'community',    // Agricultural Association
  15: 'community',    // Crafters Organization
  25: 'community',    // Fiber Cooperative (events-heavy)
  27: 'community',    // University
  35: 'community',    // Hunger Relief Organization
  17: 'services_biz', // Veterinarian
  20: 'services_biz', // Service Provider
  21: 'services_biz', // Marina
  28: 'services_biz', // Business Resources
  30: 'services_biz', // Real Estate Agent
  32: 'services_biz', // Transporter
  18: 'fiber',        // Fiber Mill
};

const PERSONAS = {
  farmer: {
    color: '#3D6B34', bg: '#f0f5e8', lightBg: '#e8f0e0',
    emoji: '🌾',
    headline: 'Farm & Ranch Hub',
    tagline: 'Monitor your fields, manage your herd, and sell your harvest.',
    statKeys: ['fields', 'animals', 'pending_orders', 'upcoming_events'],
    priorityFeatures: ['precision_ag', 'livestock', 'farm_2_table', 'accounting', 'events', 'blog', 'my_website', 'certifications'],
  },
  producer: {
    color: '#A3301E', bg: '#fdf0ed', lightBg: '#fce5e0',
    emoji: '🏭',
    headline: 'Producer Hub',
    tagline: 'Craft, package, and sell your artisan products to the world.',
    statKeys: ['products', 'produce', 'pending_orders', 'upcoming_events'],
    priorityFeatures: ['products', 'farm_2_table', 'accounting', 'blog', 'events', 'rosemarie', 'my_website', 'certifications'],
  },
  distributor: {
    color: '#2563EB', bg: '#eff6ff', lightBg: '#dbeafe',
    emoji: '🚚',
    headline: 'Distribution Hub',
    tagline: 'Source, aggregate, and move food efficiently through your network.',
    statKeys: ['pending_orders', 'services', 'upcoming_events', 'blog_posts'],
    priorityFeatures: ['food_aggregation', 'farm_2_table', 'cold_chain', 'farmer_settlement', 'accounting', 'events', 'blog', 'my_website'],
  },
  restaurant: {
    color: '#7C3AED', bg: '#f5f3ff', lightBg: '#ede9fe',
    emoji: '🍽️',
    headline: 'Restaurant Hub',
    tagline: 'Source local ingredients, manage your kitchen, and fill your seats.',
    statKeys: ['pending_orders', 'upcoming_events', 'blog_posts', 'services'],
    priorityFeatures: ['restaurant_sourcing', 'events', 'accounting', 'blog', 'chef_dashboard', 'pairsley', 'my_website'],
  },
  community: {
    color: '#D97706', bg: '#fffbeb', lightBg: '#fef3c7',
    emoji: '🤝',
    headline: 'Community Hub',
    tagline: 'Bring people together, share knowledge, and grow your community.',
    statKeys: ['upcoming_events', 'blog_posts', 'services', 'products'],
    priorityFeatures: ['events', 'blog', 'education_center', 'grants_programs', 'certifications', 'my_website', 'forums', 'accounting'],
  },
  services_biz: {
    color: '#0891B2', bg: '#ecfeff', lightBg: '#cffafe',
    emoji: '🛠️',
    headline: 'Services Hub',
    tagline: 'Manage your service offerings, clients, and grow your business.',
    statKeys: ['services', 'upcoming_events', 'blog_posts', 'pending_orders'],
    priorityFeatures: ['services', 'events', 'blog', 'accounting', 'my_website', 'certifications', 'testimonials'],
  },
  fiber: {
    color: '#7C5CBF', bg: '#f5f0ff', lightBg: '#ede5ff',
    emoji: '🧶',
    headline: 'Fiber Arts Hub',
    tagline: 'Manage your animals, showcase your fiber, and run your events.',
    statKeys: ['animals', 'upcoming_events', 'products', 'blog_posts'],
    priorityFeatures: ['livestock', 'events', 'products', 'farm_2_table', 'blog', 'my_website', 'accounting'],
  },
  default: {
    color: '#4B5563', bg: '#f9fafb', lightBg: '#f3f4f6',
    emoji: '🏢',
    headline: 'Business Hub',
    tagline: 'Everything you need to run and grow your business on OFN.',
    statKeys: ['upcoming_events', 'blog_posts', 'pending_orders', 'services'],
    priorityFeatures: ['events', 'blog', 'precision_ag', 'accounting', 'my_website', 'services', 'products', 'certifications'],
  },
};

// ─── Stat metadata ────────────────────────────────────────────────────────────
const STAT_META = {
  fields:          { label: 'Fields', icon: <I><rect x="2" y="2" width="20" height="20" rx="2"/><line x1="2" y1="9" x2="22" y2="9"/><line x1="2" y1="15" x2="22" y2="15"/><line x1="9" y1="9" x2="9" y2="22"/></I>, path: (b) => `/precision-ag/fields?BusinessID=${b}` },
  animals:         { label: 'Animals', icon: <I><ellipse cx="12" cy="14" rx="7" ry="4.5"/><circle cx="6" cy="8" r="2"/><circle cx="12" cy="6" r="2"/><circle cx="18" cy="8" r="2"/></I>, path: (b) => `/animals?BusinessID=${b}` },
  pending_orders:  { label: 'Open Orders', icon: <I><path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 01-8 0"/></I>, path: (b) => `/seller/orders?BusinessID=${b}` },
  upcoming_events: { label: 'Events', icon: <I><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></I>, path: (b) => `/events/manage?BusinessID=${b}` },
  blog_posts:      { label: 'Blog Posts', icon: <I><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></I>, path: (b) => `/blog/manage?BusinessID=${b}` },
  products:        { label: 'Products', icon: <I><path d="M21 16V8a2 2 0 00-1-1.73l-7-4a2 2 0 00-2 0l-7 4A2 2 0 003 8v8a2 2 0 001 1.73l7 4a2 2 0 002 0l7-4A2 2 0 0021 16z"/><polyline points="3.27 6.96 12 12.01 20.73 6.96"/><line x1="12" y1="22.08" x2="12" y2="12"/></I>, path: (b) => `/products?BusinessID=${b}` },
  services:        { label: 'Services', icon: <I><path d="M14.7 6.3a1 1 0 000 1.4l1.6 1.6a1 1 0 001.4 0l3.77-3.77a6 6 0 01-7.94 7.94l-6.91 6.91a2.12 2.12 0 01-3-3l6.91-6.91a6 6 0 017.94-7.94l-3.76 3.76z"/></I>, path: (b) => `/services?BusinessID=${b}` },
  produce:         { label: 'Produce Listings', icon: <I><path d="M12 2a10 10 0 100 20A10 10 0 0012 2z"/><path d="M12 2C6 8 6 16 12 22"/><path d="M12 2c6 6 6 14 0 20"/><line x1="2" y1="12" x2="22" y2="12"/></I>, path: (b) => `/produce/inventory?BusinessID=${b}` },
};

// ─── Feature card metadata ────────────────────────────────────────────────────
const FEATURE_META = {
  precision_ag: {
    label: 'Precision Ag', color: '#3D6B34', bg: '#f0f5e8',
    icon: <I><rect x="2" y="2" width="20" height="20" rx="2"/><line x1="2" y1="9" x2="22" y2="9"/><line x1="2" y1="15" x2="22" y2="15"/><line x1="9" y1="9" x2="9" y2="22"/></I>,
    desc: 'Satellite field monitoring, NDVI analyses, soil samples, and crop planning.',
    cta: { label: 'Open Fields', path: (b) => `/precision-ag/fields?BusinessID=${b}` },
    addCta: { label: 'Add Field', path: (b) => `/precision-ag/add?BusinessID=${b}` },
    links: (b) => [
      { label: 'Analyses', to: `/precision-ag/analyses?BusinessID=${b}` },
      { label: 'Crop Detection', to: `/precision-ag/crop-detection?BusinessID=${b}` },
      { label: 'Statistics', to: `/precision-ag/statistics?BusinessID=${b}` },
      { label: 'Field Journal', to: `/precision-ag/field-journal?BusinessID=${b}` },
    ],
    platformPage: '/platform/precision-ag',
  },
  livestock: {
    label: 'Livestock & Herd Health', color: '#78350F', bg: '#fef3c7',
    icon: <I><ellipse cx="12" cy="14" rx="7" ry="4.5"/><circle cx="6" cy="8" r="2"/><circle cx="12" cy="6" r="2"/><circle cx="18" cy="8" r="2"/></I>,
    desc: 'Track animals, manage herd health events, vaccinations, and weights.',
    cta: { label: 'View Animals', path: (b) => `/animals?BusinessID=${b}` },
    addCta: { label: 'Add Animal', path: (b) => `/animals/add?BusinessID=${b}` },
    links: (b) => [
      { label: 'Herd Health', to: `/herd-health?BusinessID=${b}` },
      { label: 'Vaccinations', to: `/herd-health/vaccinations?BusinessID=${b}` },
      { label: 'Packages', to: `/animals/packages?BusinessID=${b}` },
    ],
    platformPage: '/platform/livestock-herd-health',
  },
  farm_2_table: {
    label: 'Farm 2 Table Marketplace', color: '#A3301E', bg: '#fdf0ed',
    icon: <I><path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 01-8 0"/></I>,
    desc: 'List produce, meat, and processed foods. Manage incoming buyer orders.',
    cta: { label: 'View Orders', path: (b) => `/seller/orders?BusinessID=${b}` },
    addCta: { label: 'Add Produce', path: (b) => `/produce/inventory?BusinessID=${b}` },
    links: (b) => [
      { label: 'Produce Inventory', to: `/produce/inventory?BusinessID=${b}` },
      { label: 'Processed Foods', to: `/produce/processed-food?BusinessID=${b}` },
      { label: 'Meat Inventory', to: `/produce/meat?BusinessID=${b}` },
      { label: 'Stripe Payouts', to: `/account/stripe-connect?BusinessID=${b}` },
    ],
    platformPage: '/platform/marketplace',
  },
  products: {
    label: 'Products & Storefront', color: '#1D4ED8', bg: '#eff6ff',
    icon: <I><path d="M21 16V8a2 2 0 00-1-1.73l-7-4a2 2 0 00-2 0l-7 4A2 2 0 003 8v8a2 2 0 001 1.73l7 4a2 2 0 002 0l7-4A2 2 0 0021 16z"/><polyline points="3.27 6.96 12 12.01 20.73 6.96"/><line x1="12" y1="22.08" x2="12" y2="12"/></I>,
    desc: 'Sell artisan goods, processed foods, and branded products online.',
    cta: { label: 'My Products', path: (b) => `/products?BusinessID=${b}` },
    addCta: { label: 'Add Product', path: (b) => `/products/add?BusinessID=${b}` },
    links: (b) => [
      { label: 'Browse Marketplace', to: '/marketplace/products' },
      { label: 'Product Settings', to: `/products/settings?BusinessID=${b}` },
    ],
    platformPage: '/platform/products-storefront',
  },
  services: {
    label: 'Services Directory', color: '#0E7490', bg: '#ecfeff',
    icon: <I><path d="M14.7 6.3a1 1 0 000 1.4l1.6 1.6a1 1 0 001.4 0l3.77-3.77a6 6 0 01-7.94 7.94l-6.91 6.91a2.12 2.12 0 01-3-3l6.91-6.91a6 6 0 017.94-7.94l-3.76 3.76z"/></I>,
    desc: 'List your services and get found by farms, restaurants, and food businesses.',
    cta: { label: 'My Services', path: (b) => `/services?BusinessID=${b}` },
    addCta: { label: 'Add Service', path: (b) => `/services/add?BusinessID=${b}` },
    links: (b) => [
      { label: 'Browse Directory', to: '/services/directory' },
      { label: 'Suggest Category', to: `/services/suggest-category?BusinessID=${b}` },
    ],
    platformPage: null,
  },
  events: {
    label: 'Events', color: '#B45309', bg: '#fffbeb',
    icon: <I><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><line x1="8" y1="14" x2="8.01" y2="14"/><line x1="12" y1="14" x2="12.01" y2="14"/></I>,
    desc: 'Create and manage workshops, shows, festivals, auctions, and farm tours.',
    cta: { label: 'My Events', path: (b) => `/events/manage?BusinessID=${b}` },
    addCta: { label: 'Create Event', path: (b) => `/events/add?BusinessID=${b}` },
    links: (b) => [
      { label: 'Browse Events', to: '/events' },
      { label: 'My Registrations', to: '/my-registrations' },
    ],
    platformPage: '/platform/events',
  },
  blog: {
    label: 'Blog', color: '#6D28D9', bg: '#f5f3ff',
    icon: <I><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></I>,
    desc: 'Publish stories, recipes, farm updates, and news. Builds trust and SEO.',
    cta: { label: 'Manage Blog', path: (b) => `/blog/manage?BusinessID=${b}` },
    addCta: { label: 'New Post', path: (b) => `/blog/manage?BusinessID=${b}&view=new` },
    links: (b) => [
      { label: 'Authors', to: `/blog/authors/manage?BusinessID=${b}` },
      { label: 'Categories', to: `/blog/manage?BusinessID=${b}&tab=categories` },
    ],
    platformPage: '/platform/blog',
  },
  my_website: {
    label: 'Farm Website', color: '#0F766E', bg: '#f0fdfa',
    icon: <I><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 014 10 15.3 15.3 0 01-4 10 15.3 15.3 0 01-4-10 15.3 15.3 0 014-10z"/></I>,
    desc: 'Your own farm website with Lavendir AI — live in minutes on your own domain.',
    cta: { label: 'Edit Website', path: (b) => `/website/builder?BusinessID=${b}` },
    addCta: { label: 'Design', path: (b) => `/website/builder?BusinessID=${b}&view=design` },
    links: (b) => [
      { label: 'Lavendir AI Builder', to: `/website/builder?BusinessID=${b}&view=lavendir` },
      { label: 'Pages', to: `/website/builder?BusinessID=${b}&view=manage-pages` },
      { label: 'Settings', to: `/website/builder?BusinessID=${b}&view=settings` },
    ],
    platformPage: '/platform/website-builder',
  },
  accounting: {
    label: 'Accounting', color: '#065F46', bg: '#ecfdf5',
    icon: <I><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="2" y1="9" x2="22" y2="9"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></I>,
    desc: 'Invoices, expenses, customer management, and financial reports.',
    cta: { label: 'Open Accounting', path: (b) => `/accounting?BusinessID=${b}` },
    addCta: { label: 'New Invoice', path: (b) => `/accounting?BusinessID=${b}#invoices` },
    links: (b) => [
      { label: 'Customers', to: `/accounting?BusinessID=${b}#customers` },
      { label: 'Vendors', to: `/accounting?BusinessID=${b}#vendors` },
      { label: 'Reports', to: `/accounting?BusinessID=${b}#reports` },
    ],
    platformPage: '/platform/accounting',
  },
  restaurant_sourcing: {
    label: 'Restaurant Sourcing', color: '#7C3AED', bg: '#f5f3ff',
    icon: <I><line x1="5" y1="2" x2="5" y2="22"/><path d="M3 2v6a2 2 0 004 0V2"/><line x1="11" y1="2" x2="11" y2="22"/><path d="M9 2h4a3 3 0 010 6H9"/></I>,
    desc: 'Browse local farms, place standing orders, and source seasonal ingredients.',
    cta: { label: 'Browse Farms', path: () => '/marketplaces/farm-to-table' },
    addCta: { label: 'Saved Farms', path: () => '/restaurant/farms' },
    links: () => [
      { label: 'Standing Orders', to: '/restaurant/standing-orders' },
      { label: 'Weekly Digest', to: '/restaurant/digest' },
    ],
    platformPage: null,
  },
  food_aggregation: {
    label: 'Food Aggregation Hub', color: '#1D4ED8', bg: '#eff6ff',
    icon: <I><circle cx="12" cy="12" r="2.5"/><circle cx="3.5" cy="6" r="1.5"/><circle cx="20.5" cy="6" r="1.5"/><circle cx="3.5" cy="18" r="1.5"/><circle cx="20.5" cy="18" r="1.5"/><line x1="5" y1="6.8" x2="9.5" y2="10"/><line x1="19" y1="6.8" x2="14.5" y2="10"/><line x1="5" y1="17.2" x2="9.5" y2="14"/><line x1="19" y1="17.2" x2="14.5" y2="14"/></I>,
    desc: 'Manage your farm network, procurement, logistics, and B2B sales.',
    cta: { label: 'Open Hub', path: (b) => `/aggregator?BusinessID=${b}` },
    addCta: { label: 'Farm Network', path: (b) => `/aggregator/farms?BusinessID=${b}` },
    links: (b) => [
      { label: 'Procurement', to: `/aggregator/produce?BusinessID=${b}` },
      { label: 'Logistics', to: `/aggregator/logistics?BusinessID=${b}` },
      { label: 'B2B Sales', to: `/aggregator/sales?BusinessID=${b}` },
    ],
    platformPage: '/platform/aggregator',
  },
  cold_chain: {
    label: 'Cold Chain & Logistics', color: '#0369A1', bg: '#f0f9ff',
    icon: <I><rect x="1" y="6" width="12" height="10" rx="1"/><path d="M13 9h3l3 3v4h-6V9z"/><circle cx="4" cy="17" r="1.5"/><circle cx="11" cy="17" r="1.5"/><circle cx="17" cy="17" r="1.5"/><line x1="6" y1="6" x2="6" y2="3"/><line x1="8" y1="3" x2="4" y2="3"/></I>,
    desc: 'Track refrigerated vehicles, monitor temps, and ensure food safety compliance.',
    cta: { label: 'Track Vehicles', path: (b) => `/cold-chain?BusinessID=${b}` },
    addCta: { label: 'Add Vehicle', path: (b) => `/cold-chain?BusinessID=${b}` },
    links: () => [],
    platformPage: null,
  },
  farmer_settlement: {
    label: 'Farmer Settlement & Pay', color: '#065F46', bg: '#ecfdf5',
    icon: <I><circle cx="12" cy="12" r="8"/><line x1="12" y1="6" x2="12" y2="18"/><path d="M9 9h4a2 2 0 010 4H9"/><path d="M8 13h5"/></I>,
    desc: 'Settle payments with farmers and suppliers quickly and accurately.',
    cta: { label: 'Settlements', path: (b) => `/farmer-settlement?BusinessID=${b}` },
    addCta: { label: 'New Settlement', path: (b) => `/farmer-settlement?BusinessID=${b}` },
    links: () => [],
    platformPage: null,
  },
  chef_dashboard: {
    label: 'Chef Dashboard', color: '#7C3AED', bg: '#f5f3ff',
    icon: <I><path d="M4 13h8v7H4z"/><path d="M4 13a4 4 0 01-1-2.7A4 4 0 016.5 6a4 4 0 016 0A4 4 0 0116 13"/></I>,
    desc: 'Access chef-specific tools, menu costing, and kitchen intelligence.',
    cta: { label: 'Chef Dashboard', path: (b) => `/chef?BusinessID=${b}` },
    addCta: { label: 'Pairsley AI', path: (b) => `/platform/pairsley?BusinessID=${b}` },
    links: (b) => [
      { label: 'Sourced-From Card', to: `/provenance/${b}` },
    ],
    platformPage: '/platform/pairsley',
  },
  rosemarie: {
    label: 'Recipes & Batches', color: '#6D28D9', bg: '#f5f3ff',
    icon: <I><circle cx="12" cy="12" r="2"/><circle cx="12" cy="4" r="2"/><circle cx="12" cy="20" r="2"/><circle cx="4" cy="12" r="2"/><circle cx="20" cy="12" r="2"/></I>,
    desc: 'Scale recipes, track batch production, and manage ingredient sourcing.',
    cta: { label: 'Recipe Manager', path: (b) => `/recipes?BusinessID=${b}` },
    addCta: { label: 'New Recipe', path: (b) => `/recipes?BusinessID=${b}` },
    links: (b) => [
      { label: 'Batch Tracker', to: `/batches?BusinessID=${b}` },
      { label: 'About Rosemarie', to: '/platform/rosemarie' },
    ],
    platformPage: '/platform/rosemarie',
  },
  pairsley: {
    label: 'Pairsley AI', color: '#2F7D4A', bg: '#f0fdf4',
    icon: <I><line x1="5" y1="2" x2="5" y2="22"/><path d="M3 2v6a2 2 0 004 0V2"/><line x1="11" y1="2" x2="11" y2="22"/><path d="M9 2h4a3 3 0 010 6H9"/></I>,
    desc: 'AI assistant for restaurants — menus, sourcing, vendor relationships.',
    cta: { label: 'Open Pairsley', path: () => '/platform/pairsley' },
    addCta: { label: 'Learn More', path: () => '/platform/pairsley' },
    links: () => [],
    platformPage: '/platform/pairsley',
  },
  testimonials: {
    label: 'Testimonials', color: '#B45309', bg: '#fffbeb',
    icon: <I><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></I>,
    desc: 'Collect and display customer testimonials to build trust and social proof.',
    cta: { label: 'Manage Testimonials', path: (b) => `/testimonials/manage?BusinessID=${b}` },
    addCta: { label: 'Request Review', path: (b) => `/testimonials/request?BusinessID=${b}` },
    links: () => [],
    platformPage: null,
  },
  certifications: {
    label: 'Certifications', color: '#065F46', bg: '#ecfdf5',
    icon: <I><circle cx="12" cy="8" r="5"/><path d="M7 15.5L8 20h8l1-4.5"/><line x1="12" y1="13" x2="12" y2="20"/></I>,
    desc: 'Track USDA Organic, GAP, and other ag certifications in one place.',
    cta: { label: 'My Certifications', path: (b) => `/certifications?BusinessID=${b}` },
    addCta: { label: 'Add Certification', path: (b) => `/certifications?BusinessID=${b}` },
    links: () => [],
    platformPage: '/platform/certifications-tracker',
  },
  education_center: {
    label: 'Education Center', color: '#1D4ED8', bg: '#eff6ff',
    icon: <I><path d="M2 10l10-7 10 7-10 7-10-7z"/><path d="M20 10v7"/><path d="M6 12v4a7 4 0 0012 0v-4"/></I>,
    desc: 'Access courses, articles, and learning resources for ag professionals.',
    cta: { label: 'Courses & Articles', path: () => '/education' },
    addCta: { label: 'Browse', path: () => '/education' },
    links: () => [],
    platformPage: null,
  },
  grants_programs: {
    label: 'Grants & Programs', color: '#065F46', bg: '#ecfdf5',
    icon: <I><rect x="2" y="6" width="20" height="13" rx="1"/><path d="M6 6V5a3 3 0 016 0v1"/><line x1="12" y1="10" x2="12" y2="14"/><line x1="10" y1="12" x2="14" y2="12"/></I>,
    desc: 'Find USDA grants, EQIP programs, and state funding for your operation.',
    cta: { label: 'Browse Programs', path: () => '/grants' },
    addCta: { label: 'My Tracker', path: (b) => `/grants?tab=my-tracking&BusinessID=${b}` },
    links: () => [],
    platformPage: '/platform/grants',
  },
  forums: {
    label: 'Community Forums', color: '#4B5563', bg: '#f9fafb',
    icon: <I><path d="M2 3h9a1 1 0 011 1v5a1 1 0 01-1 1H5L2 13V4a1 1 0 011-1z"/><path d="M14 7h8a1 1 0 011 1v4l-3 3h-5a1 1 0 01-1-1V8a1 1 0 011-1z"/></I>,
    desc: 'Connect with other farmers, producers, and food businesses in the community.',
    cta: { label: 'Browse Forums', path: () => '/forums' },
    addCta: { label: 'Start Thread', path: () => '/forums' },
    links: () => [],
    platformPage: '/platform/community',
  },
  csa_management: {
    label: 'CSA Management', color: '#065F46', bg: '#ecfdf5',
    icon: <I><polyline points="21 8 21 21 3 21 3 8"/><rect x="1" y="3" width="22" height="5"/><line x1="10" y1="12" x2="14" y2="12"/></I>,
    desc: 'Manage Community Supported Agriculture subscriptions and member pickups.',
    cta: { label: 'Manage CSA', path: (b) => `/csa/manage?BusinessID=${b}` },
    addCta: { label: 'Browse Plans', path: () => '/csa' },
    links: () => [],
    platformPage: '/platform/csa',
  },
  properties: {
    label: 'Properties', color: '#4B5563', bg: '#f9fafb',
    icon: <I><path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></I>,
    desc: 'List and manage farm properties, buildings, and real estate.',
    cta: { label: 'My Properties', path: (b) => `/properties?BusinessID=${b}` },
    addCta: { label: 'Add Property', path: (b) => `/properties/add?BusinessID=${b}` },
    links: () => [],
    platformPage: null,
  },
};

// Features shown in "Discover More" that don't have full FEATURE_META entries
const DISCOVER_EXTRAS = [
  { key: 'equipment',        label: 'Equipment Marketplace', emoji: '🚜', path: '/marketplaces/equipment' },
  { key: 'food_wanted',      label: 'Food Wanted Board',      emoji: '📋', path: '/marketplaces/food-wanted' },
  { key: 'job_board',        label: 'Job Board',              emoji: '💼', path: '/jobs' },
  { key: 'land_leasing',     label: 'Land Leasing',           emoji: '🏞️', path: '/land' },
  { key: 'csa_advanced',     label: 'CSA Advanced',           emoji: '📦', path: '/csa-advanced' },
  { key: 'supplier_directory',label:'Supplier Directory',     emoji: '🤝', path: '/suppliers' },
  { key: 'commodity_prices', label: 'Commodity Prices',       emoji: '📈', path: '/commodity-prices' },
];

// ─── Sub-components ───────────────────────────────────────────────────────────
function StatCard({ statKey, value, businessId, persona }) {
  const meta = STAT_META[statKey];
  if (!meta) return null;
  return (
    <Link
      to={meta.path(businessId)}
      className="group flex flex-col items-center justify-center gap-2 rounded-2xl p-5 text-center transition-all hover:shadow-md hover:-translate-y-0.5"
      style={{ backgroundColor: persona.lightBg, border: `1.5px solid ${persona.color}22` }}
    >
      <div className="w-10 h-10 rounded-full flex items-center justify-center"
        style={{ backgroundColor: persona.color + '18', color: persona.color }}>
        {meta.icon}
      </div>
      <div className="text-3xl font-bold" style={{ color: persona.color }}>{value}</div>
      <div className="text-xs font-medium text-gray-500 uppercase tracking-wide">{meta.label}</div>
    </Link>
  );
}

function FeatureCard({ fKey, businessId }) {
  const m = FEATURE_META[fKey];
  if (!m) return null;
  return (
    <div className="bg-white rounded-2xl border border-gray-200 shadow-sm hover:shadow-md transition-shadow flex flex-col">
      {/* header */}
      <div className="flex items-start gap-3 p-5 pb-3">
        <div className="w-10 h-10 rounded-xl flex items-center justify-center shrink-0"
          style={{ backgroundColor: m.bg, color: m.color }}>
          {m.icon}
        </div>
        <div className="min-w-0">
          <p className="font-semibold text-gray-800 text-sm leading-tight">{m.label}</p>
          <p className="text-xs text-gray-500 mt-0.5 leading-snug">{m.desc}</p>
        </div>
      </div>

      {/* quick links */}
      <div className="px-5 pb-3 flex flex-wrap gap-x-3 gap-y-1">
        {m.links(businessId).map(l => (
          <Link key={l.to} to={l.to}
            className="text-xs hover:underline" style={{ color: m.color }}>
            {l.label}
          </Link>
        ))}
      </div>

      {/* CTAs */}
      <div className="mt-auto flex items-center justify-between gap-2 px-5 py-3 border-t border-gray-100">
        <Link to={m.addCta.path(businessId)}
          className="text-xs font-medium px-3 py-1.5 rounded-lg text-white transition-colors hover:opacity-80"
          style={{ backgroundColor: m.color + 'bb' }}>
          + {m.addCta.label}
        </Link>
        <Link to={m.cta.path(businessId)}
          className="text-xs font-semibold px-4 py-1.5 rounded-lg text-white transition-colors hover:opacity-90"
          style={{ backgroundColor: m.color }}>
          {m.cta.label} →
        </Link>
      </div>
    </div>
  );
}

function DiscoverCard({ item }) {
  return (
    <Link to={item.path}
      className="flex items-center gap-3 p-3 rounded-xl bg-white border border-gray-200 hover:border-gray-400 hover:shadow-sm transition-all group">
      <span className="text-xl">{item.emoji}</span>
      <div className="min-w-0">
        <p className="text-sm font-medium text-gray-700 group-hover:text-gray-900 truncate">{item.label}</p>
        <p className="text-[11px] text-gray-400">Browse &rarr;</p>
      </div>
    </Link>
  );
}

// ─── Main component ───────────────────────────────────────────────────────────
export default function AccountHome() {
  const [searchParams] = useSearchParams();
  const businessId = searchParams.get('BusinessID');
  const peopleId   = searchParams.get('PeopleID') ||
                     localStorage.getItem('PeopleID') ||
                     localStorage.getItem('people_id');

  const [business, setBusiness]   = useState(null);
  const [features, setFeatures]   = useState(null);
  const [stats, setStats]         = useState(null);
  const [error, setError]         = useState(false);

  useEffect(() => {
    if (!businessId) return;
    Promise.all([
      fetch(`${API_URL}/auth/account-home?BusinessID=${businessId}`).then(r => r.json()),
      fetch(`${API_URL}/api/company/features?business_id=${businessId}`).then(r => r.ok ? r.json() : []),
      fetch(`${API_URL}/api/dashboard/summary?business_id=${businessId}`).then(r => r.ok ? r.json() : {}),
    ])
      .then(([biz, feats, s]) => {
        setBusiness(biz);
        const map = {};
        feats.forEach(f => { map[f.feature_key] = f; });
        setFeatures(map);
        setStats(s);
      })
      .catch(() => setError(true));
  }, [businessId]);

  if (error)    return <div className="p-8 text-red-600">Error loading account.</div>;
  if (!business || features === null || stats === null)
    return <div className="p-8 text-gray-400">Loading…</div>;

  const on = (key) => features[key]?.is_enabled === true;

  const persona = PERSONAS[BIZ_PERSONA[business.BusinessTypeID]] ?? PERSONAS.default;

  // Ordered active features — priority list first, then any remaining enabled
  const priorityKeys = persona.priorityFeatures.filter(k => on(k));
  const allEnabled   = Object.keys(features).filter(k => features[k]?.is_enabled && !priorityKeys.includes(k) && FEATURE_META[k]);
  const featureKeys  = [...priorityKeys, ...allEnabled];

  // Stats: up to 4 from persona priority, then fill from any non-zero
  const statKeys = persona.statKeys.slice(0, 4);

  // Not-enabled features for Discover section
  const notEnabled = [
    ...Object.keys(FEATURE_META).filter(k => !on(k)),
    ...DISCOVER_EXTRAS.filter(d => !on(d.key)).map(d => d.key),
  ].filter((v, i, a) => a.indexOf(v) === i);

  const discoverItems = [
    ...Object.entries(FEATURE_META)
      .filter(([k]) => notEnabled.includes(k))
      .map(([k, m]) => ({ key: k, label: m.label, emoji: '✦', path: m.platformPage || '/platform' })),
    ...DISCOVER_EXTRAS.filter(d => notEnabled.includes(d.key)),
  ].slice(0, 12);

  const city  = business.AddressCity;
  const state = business.AddressState;
  const location = city && state ? `${city}, ${state}` : (city || state || null);

  return (
    <AccountLayout
      Business={business}
      BusinessID={businessId}
      PeopleID={peopleId}
      pageTitle={business.BusinessName}
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: business.BusinessName },
      ]}
    >
      <div className="max-w-5xl mx-auto space-y-7">

        {/* ── Hero banner ── */}
        <div className="rounded-2xl overflow-hidden shadow-sm"
          style={{ background: `linear-gradient(135deg, ${persona.color} 0%, ${persona.color}cc 100%)` }}>
          <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 p-7">
            <div className="flex items-center gap-4">
              <div className="text-5xl select-none">{persona.emoji}</div>
              <div>
                <p className="text-white/70 text-xs font-semibold uppercase tracking-widest mb-0.5">{persona.headline}</p>
                <h1 className="text-white text-2xl font-bold leading-tight">{business.BusinessName}</h1>
                <div className="flex flex-wrap items-center gap-2 mt-1.5">
                  <span className="text-white/80 text-sm">{business.BusinessType}</span>
                  {location && <><span className="text-white/40">·</span><span className="text-white/70 text-sm">📍 {location}</span></>}
                  {business.SubscriptionEndDate && (
                    <><span className="text-white/40">·</span>
                    <span className="text-white/70 text-xs">Subscription active through {new Date(business.SubscriptionEndDate).toLocaleDateString()}</span></>
                  )}
                </div>
              </div>
            </div>
            <div className="flex flex-wrap gap-2 sm:flex-col sm:items-end shrink-0">
              <Link to={`/account/profile?BusinessID=${businessId}`}
                className="text-xs font-semibold px-4 py-2 rounded-lg bg-white/20 hover:bg-white/30 text-white transition-colors">
                Edit Profile
              </Link>
              <Link to={`/account/subscription?BusinessID=${businessId}`}
                className="text-xs font-semibold px-4 py-2 rounded-lg bg-white/10 hover:bg-white/20 text-white transition-colors">
                Subscription
              </Link>
            </div>
          </div>
          <div className="px-7 pb-4">
            <p className="text-white/60 text-sm italic">{persona.tagline}</p>
          </div>
        </div>

        {/* ── Stat bar ── */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
          {statKeys.map(k => (
            <StatCard key={k} statKey={k} value={stats[k] ?? 0} businessId={businessId} persona={persona} />
          ))}
        </div>

        {/* ── Active services ── */}
        {featureKeys.length > 0 && (
          <section>
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-bold text-gray-800">Your Services</h2>
              <Link to={`/account/subscription?BusinessID=${businessId}`}
                className="text-xs font-semibold px-3 py-1.5 rounded-lg text-white transition-colors hover:opacity-90"
                style={{ backgroundColor: persona.color }}>
                + Add Services
              </Link>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {featureKeys.map(k => <FeatureCard key={k} fKey={k} businessId={businessId} />)}
            </div>
          </section>
        )}

        {/* ── Quick actions block (always visible) ── */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <Link to={`/account/profile?BusinessID=${businessId}`}
            className="flex items-center gap-3 p-4 bg-white rounded-xl border border-gray-200 hover:shadow-sm transition-shadow group">
            <div className="w-9 h-9 rounded-lg bg-gray-100 flex items-center justify-center text-gray-500 group-hover:text-gray-700">
              <I size={18}><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></I>
            </div>
            <div>
              <p className="text-sm font-semibold text-gray-800">Edit Profile</p>
              <p className="text-xs text-gray-400">Update your public listing</p>
            </div>
          </Link>
          <Link to={`/account/team?BusinessID=${businessId}`}
            className="flex items-center gap-3 p-4 bg-white rounded-xl border border-gray-200 hover:shadow-sm transition-shadow group">
            <div className="w-9 h-9 rounded-lg bg-gray-100 flex items-center justify-center text-gray-500 group-hover:text-gray-700">
              <I size={18}><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/></I>
            </div>
            <div>
              <p className="text-sm font-semibold text-gray-800">Team Members</p>
              <p className="text-xs text-gray-400">Add staff and collaborators</p>
            </div>
          </Link>
          <Link to={`/account/change-type?BusinessID=${businessId}`}
            className="flex items-center gap-3 p-4 bg-white rounded-xl border border-gray-200 hover:shadow-sm transition-shadow group">
            <div className="w-9 h-9 rounded-lg bg-gray-100 flex items-center justify-center text-gray-500 group-hover:text-gray-700">
              <I size={18}><polyline points="16 3 21 3 21 8"/><line x1="4" y1="20" x2="21" y2="3"/><polyline points="21 16 21 21 16 21"/><line x1="15" y1="15" x2="21" y2="21"/></I>
            </div>
            <div>
              <p className="text-sm font-semibold text-gray-800">Change Account Type</p>
              <p className="text-xs text-gray-400">Switch business category</p>
            </div>
          </Link>
        </div>

        {/* ── Discover more ── */}
        {discoverItems.length > 0 && (
          <section>
            <div className="flex items-center justify-between mb-4">
              <div>
                <h2 className="text-lg font-bold text-gray-800">Discover More</h2>
                <p className="text-xs text-gray-400">Explore other OFN tools available to your account</p>
              </div>
            </div>
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
              {discoverItems.map(item => <DiscoverCard key={item.key} item={item} />)}
            </div>
          </section>
        )}

      </div>
    </AccountLayout>
  );
}
