import React, { useMemo, useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import {
  fetchMandiCatalog,
  fetchCommodityQuotes,
  readQuotesCache,
  hasQuoteData,
} from './commodityQuotes';
import { formatInr } from './money';

const CREAM = '#f7f2e8';
const OLIVE = '#3d6b34';
const RUST = '#8b3a2b';
const INK = '#2c2c2c';
const MUTED = '#6b6b6b';
const HERO_IMG = '/images/NewsHeroWheat.png';

const OFFICIAL_LINKS = [
  { label: 'Agmarknet — Mandi prices', url: 'https://agmarknet.gov.in/' },
  { label: 'eNAM — National Agriculture Market', url: 'https://www.enam.gov.in/' },
  { label: 'MSP — Commission for Agricultural Costs & Prices', url: 'https://cacp.dacnet.nic.in/' },
  { label: 'Ministry of Agriculture & Farmers Welfare', url: 'https://agriwelfare.gov.in/' },
  { label: 'PM-KISAN', url: 'https://pmkisan.gov.in/' },
  { label: 'Soil Health Card', url: 'https://soilhealth.dac.gov.in/' },
];

const MARKET_NEWS = [
  { name: 'farmer.in prices', url: 'https://farmer.in/' },
  { name: 'Agriwatch', url: 'https://www.agriwatch.com/' },
  { name: 'NCDEX markets', url: 'https://www.ncdex.com/' },
  { name: 'MCX agriculture', url: 'https://www.mcxindia.com/' },
  { name: 'ICAR news', url: 'https://icar.org.in/' },
  { name: 'PIB Agriculture', url: 'https://pib.gov.in/' },
];

function formatQuotesAt(fetchedAt) {
  if (!fetchedAt) return null;
  try {
    const raw =
      fetchedAt.endsWith?.('Z') || String(fetchedAt).includes('T')
        ? fetchedAt
        : `${fetchedAt}Z`;
    const d = new Date(raw);
    if (Number.isNaN(d.getTime())) return null;
    return d.toLocaleString('en-IN');
  } catch {
    return null;
  }
}

function quotesToCommodities(quotes) {
  return Object.entries(quotes || {}).map(([id, q]) => ({
    id,
    name: q.name || id,
    hindi: q.hindi || '',
    icon: q.icon || '🌾',
    category: q.category || 'Other',
    unit: q.unit || 'quintal',
    currency: q.currency || 'INR',
    price: q.price,
    change: q.change,
    pct: q.pct,
    prev: q.prev,
    min: q.min,
    max: q.max,
    msp: q.msp,
    url: 'https://agmarknet.gov.in/',
    major_states: q.major_states || [],
  }));
}

function MandiCard({ c, loading }) {
  const up = c && Number(c.change) > 0;
  const dn = c && Number(c.change) < 0;
  const priceColor = up ? OLIVE : dn ? RUST : INK;
  const unit = c?.unit || 'quintal';

  return (
    <a
      href={c.url || 'https://agmarknet.gov.in/'}
      target="_blank"
      rel="noopener noreferrer"
      className="group block rounded-2xl bg-white border border-black/5 p-4 md:p-5 no-underline transition hover:border-[#3d6b34]/35 hover:shadow-md"
    >
      <div className="flex items-start justify-between gap-2 mb-3">
        <div className="min-w-0">
          <div className="text-[10px] font-bold tracking-[0.14em] uppercase" style={{ color: OLIVE }}>
            {(c.icon || '🌾') + ' ' + (c.category || 'Mandi')}
          </div>
          <div
            className="text-base font-bold mt-0.5 leading-snug truncate"
            style={{ fontFamily: "'Lora', 'Times New Roman', serif", color: INK }}
          >
            {c.name}
          </div>
          {c.hindi ? (
            <div className="text-xs mt-0.5 truncate" style={{ color: MUTED }}>
              {c.hindi}
            </div>
          ) : null}
        </div>
        <span
          className="shrink-0 rounded-full px-2 py-0.5 text-[10px] font-semibold"
          style={{ background: '#f0ece4', color: MUTED }}
        >
          ₹/qtl
        </span>
      </div>

      {c?.price != null ? (
        <>
          <div className="flex items-baseline gap-1.5">
            <span className="text-2xl md:text-[1.75rem] font-bold tabular-nums" style={{ color: priceColor }}>
              {formatInr(c.price, { digits: 0 })}
            </span>
            <span className="text-xs font-medium" style={{ color: MUTED }}>
              /{unit === 'quintal' ? 'qtl' : unit}
            </span>
          </div>
          <div
            className="mt-1.5 inline-flex items-center gap-1 text-xs font-bold tabular-nums"
            style={{ color: up ? OLIVE : dn ? RUST : MUTED }}
          >
            <span aria-hidden>{up ? '▲' : dn ? '▼' : '—'}</span>
            <span>
              {formatInr(Math.abs(Number(c.change) || 0), { digits: 0 })} ({Number(c.pct) > 0 ? '+' : ''}
              {Number(c.pct || 0).toFixed(2)}%)
            </span>
          </div>
          {(c.msp != null || c.min != null || c.max != null) && (
            <div className="mt-2 text-[11px] leading-relaxed" style={{ color: MUTED }}>
              {c.msp != null && (
                <div>
                  MSP {formatInr(c.msp, { digits: 0 })}
                  {Number(c.price) >= Number(c.msp)
                    ? ` · ₹${Math.round(c.price - c.msp)} above MSP — consider selling`
                    : ` · ₹${Math.round(c.msp - c.price)} below MSP — check procurement / hold`}
                </div>
              )}
              {(c.min != null || c.max != null) && (
                <div>
                  Range {c.min != null ? formatInr(c.min, { digits: 0 }) : '—'} –{' '}
                  {c.max != null ? formatInr(c.max, { digits: 0 }) : '—'}
                </div>
              )}
            </div>
          )}
        </>
      ) : (
        <div className="text-sm italic py-2" style={{ color: MUTED }}>
          {loading ? 'Loading mandi price…' : 'Unavailable'}
        </div>
      )}

      <div
        className="mt-4 pt-3 border-t border-black/5 text-xs font-semibold flex items-center justify-between"
        style={{ color: OLIVE }}
      >
        <span>View on Agmarknet</span>
        <span className="opacity-70 group-hover:opacity-100 transition">↗</span>
      </div>
    </a>
  );
}

export default function CommodityPrices() {
  const cached = readQuotesCache();
  const [allCommodities, setAllCommodities] = useState(() =>
    cached && hasQuoteData(cached.quotes) ? quotesToCommodities(cached.quotes) : []
  );
  const [categories, setCategories] = useState([]);
  const [category, setCategory] = useState('');
  const [states, setStates] = useState([]);
  const [stateFilter, setStateFilter] = useState('');
  const [search, setSearch] = useState('');
  const [quotesAt, setQuotesAt] = useState(() =>
    cached?.fetched_at ? formatQuotesAt(cached.fetched_at) : null
  );
  const [meta, setMeta] = useState(() => cached?.meta || null);
  const [loading, setLoading] = useState(() => allCommodities.length === 0);
  const [fromCache, setFromCache] = useState(() => allCommodities.length > 0);
  const [refreshing, setRefreshing] = useState(false);

  const loadCatalog = async ({ preferCache = false } = {}) => {
    // Always fetch full catalog once; filter client-side (faster search, fewer API hits)
    const result = await fetchMandiCatalog({
      timeoutMs: 15000,
      limit: 200,
    });
    if (result.commodities?.length) {
      setAllCommodities(result.commodities);
      setCategories(result.categories || []);
      setStates(result.states || []);
      setQuotesAt(formatQuotesAt(result.fetched_at));
      setMeta(result.meta || null);
      setFromCache(false);
      setLoading(false);
      return true;
    }

    const quotesResult = await fetchCommodityQuotes({ preferCache, timeoutMs: 12000 });
    if (hasQuoteData(quotesResult.quotes)) {
      setAllCommodities(quotesToCommodities(quotesResult.quotes));
      setQuotesAt(formatQuotesAt(quotesResult.fetched_at));
      setMeta(quotesResult.meta || null);
      setFromCache(!!quotesResult.fromCache);
      setLoading(false);
      return true;
    }
    setLoading(false);
    return false;
  };

  useEffect(() => {
    let cancelled = false;
    (async () => {
      if (allCommodities.length) setLoading(false);
      else setLoading(true);
      await loadCatalog({ preferCache: true });
      if (cancelled) return;
    })();
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps -- mount-only
  }, []);

  const handleRefresh = async () => {
    setRefreshing(true);
    try {
      await loadCatalog({ preferCache: false });
    } finally {
      setRefreshing(false);
    }
  };

  const commodities = useMemo(() => {
    const needle = search.trim().toLowerCase();
    return allCommodities.filter((c) => {
      if (category && (c.category || '') !== category) return false;
      if (stateFilter) {
        const st = stateFilter.toLowerCase();
        const majors = c.major_states || [];
        if (!majors.some((s) => String(s).toLowerCase().includes(st))) return false;
      }
      if (!needle) return true;
      return (
        (c.name || '').toLowerCase().includes(needle) ||
        (c.hindi || '').toLowerCase().includes(needle) ||
        (c.id || '').toLowerCase().includes(needle) ||
        (c.category || '').toLowerCase().includes(needle)
      );
    });
  }, [allCommodities, category, stateFilter, search]);

  const groups = useMemo(() => {
    const map = {};
    commodities.forEach((c) => {
      const g = c.category || 'Other';
      if (!map[g]) map[g] = [];
      map[g].push(c);
    });
    return map;
  }, [commodities]);

  const liveCount = commodities.filter((c) => c.price != null).length;
  const attribution =
    meta?.attribution ||
    'Agmarknet / Government of India via farmer.in';

  return (
    <div className="min-h-screen font-sans flex flex-col" style={{ background: CREAM }}>
      <PageMeta
        title="Mandi Commodity Prices — Oatmeal Farm Network India"
        description="Live India mandi modal prices in ₹/quintal for wheat, rice, pulses, oilseeds, and more."
      />
      <Header />

      <main className="grow w-full max-w-[1100px] mx-auto px-4 md:px-6 py-6 md:py-8">
        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'Commodity Prices' }]} />

        <section className="relative overflow-hidden rounded-2xl min-h-[200px] md:min-h-[260px] flex items-end mb-8">
          <img
            src={HERO_IMG}
            alt=""
            className="absolute inset-0 w-full h-full object-cover"
            loading="eager"
          />
          <div
            className="absolute inset-0"
            style={{
              background:
                'linear-gradient(105deg, rgba(20,20,20,0.75) 0%, rgba(20,20,20,0.45) 55%, rgba(20,20,20,0.2) 100%)',
            }}
            aria-hidden
          />
          <div className="relative z-[1] p-6 md:p-10 max-w-2xl">
            <p
              className="text-[10px] font-bold tracking-[0.16em] uppercase mb-2"
              style={{ color: 'rgba(255,255,255,0.85)' }}
            >
              India Mandi Markets
            </p>
            <h1
              className="text-3xl md:text-4xl font-bold leading-tight mb-3"
              style={{ fontFamily: "'Lora', 'Times New Roman', serif", color: '#ffffff' }}
            >
              Commodity Prices
            </h1>
            <p className="text-sm md:text-[0.95rem] leading-relaxed" style={{ color: 'rgba(255,255,255,0.92)' }}>
              Modal mandi prices in ₹/quintal for staples, pulses, oilseeds, and vegetables — with MSP
              context for farm planning.
            </p>
          </div>
        </section>

        <div
          className="mb-4 rounded-xl border border-black/5 px-4 py-3 flex flex-wrap items-center justify-between gap-3"
          style={{ background: 'rgba(255,255,255,0.7)' }}
        >
          <div className="text-sm" style={{ color: MUTED }}>
            <span style={{ color: INK }}>
              <strong>{liveCount}</strong> commodities
            </span>
            {(quotesAt || fromCache) && (
              <span>
                {' '}
                · {quotesAt ? `Updated ${quotesAt}` : ''}
                {fromCache ? ' · Cached' : ''}
                {' '}
                · ₹ / quintal
              </span>
            )}
          </div>
          <div className="flex items-center gap-2">
            <Link
              to="/app/news"
              className="text-xs font-bold no-underline hover:underline"
              style={{ color: OLIVE }}
            >
              Latest Dispatches
            </Link>
            <button
              type="button"
              onClick={handleRefresh}
              disabled={refreshing}
              className="rounded-lg px-3 py-1.5 text-xs font-bold text-white disabled:opacity-60 cursor-pointer"
              style={{ background: OLIVE, border: 'none' }}
            >
              {refreshing ? 'Refreshing…' : 'Refresh'}
            </button>
          </div>
        </div>

        <div className="mb-6 flex flex-wrap gap-2">
          <input
            type="search"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search wheat, rice, pulse…"
            className="grow min-w-[180px] rounded-lg border border-black/10 bg-white px-3 py-2 text-sm"
            style={{ color: INK }}
          />
          <select
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            className="rounded-lg border border-black/10 bg-white px-3 py-2 text-sm"
            style={{ color: INK }}
          >
            <option value="">All categories</option>
            {categories.map((cat) => (
              <option key={cat} value={cat}>
                {cat}
              </option>
            ))}
          </select>
          <select
            value={stateFilter}
            onChange={(e) => setStateFilter(e.target.value)}
            className="rounded-lg border border-black/10 bg-white px-3 py-2 text-sm"
            style={{ color: INK }}
          >
            <option value="">All states</option>
            {states.map((st) => (
              <option key={st} value={st}>
                {st}
              </option>
            ))}
          </select>
        </div>

        {loading && commodities.length === 0 ? (
          <p className="text-sm mb-8 italic" style={{ color: MUTED }}>
            Loading India mandi prices…
          </p>
        ) : null}

        {!loading && commodities.length === 0 ? (
          <p className="text-sm mb-8" style={{ color: MUTED }}>
            Mandi prices are temporarily unavailable. Try Refresh, or check Agmarknet directly.
          </p>
        ) : null}

        {Object.entries(groups).map(([groupName, items]) => (
          <section key={groupName} className="mb-8">
            <div className="flex items-end justify-between gap-3 mb-3">
              <h2
                className="text-xl font-bold"
                style={{ fontFamily: "'Lora', 'Times New Roman', serif", color: OLIVE }}
              >
                {groupName}
              </h2>
              <span className="text-[10px] font-bold tracking-[0.12em] uppercase" style={{ color: MUTED }}>
                Mandi modal
              </span>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 md:gap-4">
              {items.map((c) => (
                <MandiCard key={c.id || c.name} c={c} loading={loading} />
              ))}
            </div>
          </section>
        ))}

        <section className="mb-8">
          <h2
            className="text-xl font-bold mb-1"
            style={{ fontFamily: "'Lora', 'Times New Roman', serif", color: INK }}
          >
            Official India Market Sources
          </h2>
          <p className="text-sm mb-4" style={{ color: MUTED }}>
            Government mandi, MSP, and farmer welfare portals.
          </p>
          <div className="rounded-2xl bg-white border border-black/5 overflow-hidden divide-y divide-black/5">
            {OFFICIAL_LINKS.map((r) => (
              <a
                key={r.label}
                href={r.url}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-between gap-3 px-4 md:px-5 py-3.5 no-underline hover:bg-[#faf8f4] transition"
              >
                <span className="text-sm font-semibold" style={{ color: INK }}>
                  {r.label}
                </span>
                <span className="shrink-0 text-sm font-bold" style={{ color: OLIVE }}>
                  ↗
                </span>
              </a>
            ))}
          </div>
        </section>

        <section className="mb-6">
          <h2
            className="text-xl font-bold mb-1"
            style={{ fontFamily: "'Lora', 'Times New Roman', serif", color: INK }}
          >
            Market News & Analysis
          </h2>
          <p className="text-sm mb-4" style={{ color: MUTED }}>
            Outside sources for deeper India agri-market coverage.
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
            {MARKET_NEWS.map((n) => (
              <a
                key={n.name}
                href={n.url}
                target="_blank"
                rel="noopener noreferrer"
                className="rounded-xl border border-black/5 bg-white px-4 py-3.5 text-sm font-semibold no-underline flex items-center justify-between gap-2 hover:border-[#3d6b34]/30 transition"
                style={{ color: INK }}
              >
                <span>{n.name}</span>
                <span style={{ color: OLIVE }}>↗</span>
              </a>
            ))}
          </div>
        </section>

        <p className="text-xs text-center pb-4" style={{ color: MUTED }}>
          Prices are indicative mandi modal averages ({attribution}). Not financial advice. Always
          verify with your local mandi, FPO, or commission agent before selling.
        </p>
      </main>

      <Footer />
    </div>
  );
}
