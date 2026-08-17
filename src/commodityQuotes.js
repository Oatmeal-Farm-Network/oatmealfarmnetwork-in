import { formatInr as formatMoneyInr } from './money';

// India mandi quotes fetch + localStorage cache for fast paint.
// Uses OFN backend /api/commodity-prices (farmer.in / Agmarknet). No Yahoo fallback.

const CACHE_KEY = 'ofn_india_mandi_quotes_v1';
const CACHE_MAX_AGE_MS = 15 * 60 * 1000; // 15 minutes

const API_BASE = import.meta.env.VITE_API_URL || '';

export function readQuotesCache() {
  try {
    const raw = localStorage.getItem(CACHE_KEY);
    if (!raw) return null;
    const parsed = JSON.parse(raw);
    if (!parsed?.quotes || typeof parsed.quotes !== 'object') return null;
    return parsed;
  } catch {
    return null;
  }
}

export function writeQuotesCache(quotes, fetchedAt, extra = {}) {
  try {
    localStorage.setItem(
      CACHE_KEY,
      JSON.stringify({
        quotes: quotes || {},
        fetched_at: fetchedAt || new Date().toISOString(),
        cached_at: Date.now(),
        market: extra.market || 'india_mandi',
        currency: extra.currency || 'INR',
        meta: extra.meta || null,
      })
    );
  } catch {
    /* ignore quota */
  }
}

export function isQuotesCacheFresh(cache) {
  if (!cache?.cached_at) return false;
  return Date.now() - cache.cached_at < CACHE_MAX_AGE_MS;
}

export function hasQuoteData(quotes) {
  return quotes && typeof quotes === 'object' && Object.keys(quotes).length > 0;
}

function emptyResult(overrides = {}) {
  return {
    quotes: {},
    commodities: [],
    fetched_at: null,
    fromCache: false,
    stale: false,
    market: 'india_mandi',
    currency: 'INR',
    meta: null,
    ...overrides,
  };
}

/** Prefer Cloud Run API, then same-origin /api. No US futures fallback. */
export async function fetchCommodityQuotes({ timeoutMs = 12000, preferCache = true } = {}) {
  const cached = preferCache ? readQuotesCache() : null;
  if (cached && isQuotesCacheFresh(cached) && hasQuoteData(cached.quotes)) {
    return {
      quotes: cached.quotes,
      commodities: [],
      fetched_at: cached.fetched_at,
      fromCache: true,
      stale: false,
      market: cached.market || 'india_mandi',
      currency: cached.currency || 'INR',
      meta: cached.meta || null,
    };
  }

  const bases = [API_BASE, ''].filter((b, i, arr) => arr.indexOf(b) === i);

  for (const base of bases) {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeoutMs);
    try {
      const r = await fetch(`${base}/api/commodity-prices/quotes`, {
        signal: controller.signal,
        headers: { Accept: 'application/json' },
      });
      if (!r.ok) continue;
      const d = await r.json();
      const quotes = d?.quotes || {};
      if (hasQuoteData(quotes)) {
        writeQuotesCache(quotes, d.fetched_at, {
          market: d.market,
          currency: d.currency,
          meta: d.meta,
        });
        return {
          quotes,
          commodities: [],
          fetched_at: d.fetched_at || null,
          fromCache: false,
          stale: !!d.stale,
          market: d.market || 'india_mandi',
          currency: d.currency || 'INR',
          meta: d.meta || null,
        };
      }
    } catch {
      /* try next base */
    } finally {
      clearTimeout(timer);
    }
  }

  if (cached && hasQuoteData(cached.quotes)) {
    return {
      quotes: cached.quotes,
      commodities: [],
      fetched_at: cached.fetched_at,
      fromCache: true,
      stale: true,
      market: cached.market || 'india_mandi',
      currency: cached.currency || 'INR',
      meta: cached.meta || null,
    };
  }

  return emptyResult();
}

/** Rich mandi catalog (MSP, Hindi, season, states). */
export async function fetchMandiCatalog({
  timeoutMs = 15000,
  category = '',
  q = '',
  state = '',
  limit = 60,
} = {}) {
  const bases = [API_BASE, ''].filter((b, i, arr) => arr.indexOf(b) === i);
  const params = new URLSearchParams();
  if (category) params.set('category', category);
  if (q) params.set('q', q);
  if (state) params.set('state', state);
  params.set('limit', String(limit));

  for (const base of bases) {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeoutMs);
    try {
      const r = await fetch(`${base}/api/commodity-prices/mandi?${params}`, {
        signal: controller.signal,
        headers: { Accept: 'application/json' },
      });
      if (!r.ok) continue;
      const d = await r.json();
      const commodities = Array.isArray(d?.commodities) ? d.commodities : [];
      if (commodities.length) {
        // Keep quotes cache in sync for any other consumers
        const quotes = {};
        commodities.forEach((c) => {
          if (!c?.id) return;
          quotes[c.id] = {
            price: c.price,
            change: c.change,
            pct: c.pct,
            prev: c.prev,
            name: c.name,
            unit: c.unit,
            currency: c.currency || 'INR',
            hindi: c.hindi,
            icon: c.icon,
            category: c.category,
            msp: c.msp,
            min: c.min,
            max: c.max,
            major_states: c.major_states || [],
          };
        });
        writeQuotesCache(quotes, d.fetched_at, {
          market: d.market,
          currency: d.currency,
          meta: d.meta,
        });
        return {
          commodities,
          categories: d.categories || [],
          states: d.states || [],
          fetched_at: d.fetched_at || null,
          market: d.market || 'india_mandi',
          currency: d.currency || 'INR',
          meta: d.meta || null,
          count: d.count || commodities.length,
        };
      }
    } catch {
      /* try next */
    } finally {
      clearTimeout(timer);
    }
  }

  return {
    commodities: [],
    categories: [],
    states: [],
    fetched_at: null,
    market: 'india_mandi',
    currency: 'INR',
    meta: null,
    count: 0,
  };
}

/** Background refresh — updates cache without blocking UI */
export function refreshCommodityQuotesInBackground() {
  fetchCommodityQuotes({ preferCache: false, timeoutMs: 15000 }).catch(() => {});
}

export function formatInr(n, opts = {}) {
  return formatMoneyInr(n, opts);
}
