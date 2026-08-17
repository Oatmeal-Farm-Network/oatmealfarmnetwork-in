/**
 * OFN top-nav visibility keys (managed in OAT / oatmeal-main admin).
 * When the public config API is unavailable or empty, fail open with this full set.
 */
export const DEFAULT_OFN_NAV_KEYS = [
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

const OTF_API = import.meta.env.VITE_OTF_API_URL || '';

/** @returns {Promise<Set<string>>} active keys; defaults when config missing */
export async function fetchOfnNavKeys() {
  if (!OTF_API) {
    return new Set(DEFAULT_OFN_NAV_KEYS);
  }
  try {
    const r = await fetch(`${OTF_API}/api/admin/ofn-nav/public`);
    if (!r.ok) return new Set(DEFAULT_OFN_NAV_KEYS);
    const items = await r.json();
    if (!Array.isArray(items) || items.length === 0) {
      return new Set(DEFAULT_OFN_NAV_KEYS);
    }
    return new Set(items.map((i) => i.NavKey).filter(Boolean));
  } catch {
    return new Set(DEFAULT_OFN_NAV_KEYS);
  }
}
