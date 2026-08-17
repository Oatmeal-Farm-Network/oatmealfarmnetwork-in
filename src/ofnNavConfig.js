/**
 * India OFN stack: show the full USA top nav, but only enable links that work on India Cloud Run.
 * Do not fetch OAT / oatmeal-main nav config (India has no oatmeal-main service).
 */

export const ALL_OFN_NAV_KEYS = [
  'home',
  'dashboard',
  'directory',
  'marketplaces',
  'mkt_farm2table',
  'mkt_products',
  'mkt_livestock',
  'mkt_equipment',
  'mkt_realestate',
  'mkt_services_dir',
  'mkt_events',
  'services',
  'svc_saige',
  'svc_rosemarie',
  'svc_pairsley',
  'svc_website',
  'svc_marketplace',
  'svc_events',
  'svc_crop_monitor',
  'svc_directory',
  'ai_advisors',
  'ai_saige',
  'ai_pairsley',
  'ai_rosemarie',
  'ai_thaiyme',
  'newsroom',
  'nr_newsfeed',
  'nr_blogs',
  'knowledgebases',
  'kb_plants',
  'kb_livestock',
  'kb_ingredients',
  'about',
  'contact',
  'signup',
];

/** Nav keys that navigate on the India deployment (same labels as USA). */
export const INDIA_ENABLED_NAV_KEYS = new Set([
  'home',
  'dashboard',
  'directory',
  'about',
  'contact',
  'signup',
  'ai_saige',
  'svc_saige',
  'nr_newsfeed',
]);

export function isNavVisible() {
  return true;
}

export function isNavEnabled(navKey) {
  return INDIA_ENABLED_NAV_KEYS.has(navKey);
}

/** Optional absolute base for India frontend (Cloud Run). Relative paths used when unset. */
export function indiaAppPath(path) {
  const base = (import.meta.env.VITE_APP_URL || '').replace(/\/$/, '');
  const p = path.startsWith('/') ? path : `/${path}`;
  return base ? `${base}${p}` : p;
}
