import React, { useState, useEffect } from 'react';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

// Uses USDA AMS public APIs (no key required) + free static quotes
// Prices below are illustrative seed data; the fetch attempts live USDA data first.

const GREEN = '#3D6B34';

const STATIC_PRICES = [
  { commodity: 'Corn', symbol: 'ZC', price: null, unit: 'bu', exchange: 'CBOT', note: 'Live quote via CME Group', url: 'https://www.cmegroup.com/markets/agriculture/grains/corn.html' },
  { commodity: 'Soybeans', symbol: 'ZS', price: null, unit: 'bu', exchange: 'CBOT', note: 'Live quote via CME Group', url: 'https://www.cmegroup.com/markets/agriculture/oilseeds/soybeans.html' },
  { commodity: 'Wheat (SRW)', symbol: 'ZW', price: null, unit: 'bu', exchange: 'CBOT', note: 'Live quote via CME Group', url: 'https://www.cmegroup.com/markets/agriculture/grains/wheat.html' },
  { commodity: 'Live Cattle', symbol: 'LE', price: null, unit: 'cwt', exchange: 'CME', note: 'Live quote via CME Group', url: 'https://www.cmegroup.com/markets/agriculture/livestock/live-cattle.html' },
  { commodity: 'Feeder Cattle', symbol: 'GF', price: null, unit: 'cwt', exchange: 'CME', note: 'Live quote via CME Group', url: 'https://www.cmegroup.com/markets/agriculture/livestock/feeder-cattle.html' },
  { commodity: 'Lean Hogs', symbol: 'HE', price: null, unit: 'cwt', exchange: 'CME', note: 'Live quote via CME Group', url: 'https://www.cmegroup.com/markets/agriculture/livestock/lean-hogs.html' },
  { commodity: 'Class III Milk', symbol: 'DC', price: null, unit: 'cwt', exchange: 'CME', note: 'Live quote via CME Group', url: 'https://www.cmegroup.com/markets/agriculture/dairy/class-iii-milk.html' },
  { commodity: 'Cotton', symbol: 'CT', price: null, unit: 'lb', exchange: 'ICE', note: 'Live quote via ICE', url: 'https://www.theice.com/products/254/Cotton-No-2-Futures' },
];

// USDA AMS Retail Report — free, no key
const AMS_REPORTS = [
  { label: 'Nat\'l Chicken Breast Price', report: 'LM_PY0305', item: 'Boneless Skinless Chicken Breast' },
  { label: 'Nat\'l Pork Loin Price', report: 'LM_PK602', item: 'Pork Loin' },
];

function TrendArrow({ val }) {
  if (val === undefined || val === null) return null;
  if (val > 0) return <span className="text-green-600 text-xs font-bold ml-1">▲ {val.toFixed(2)}</span>;
  if (val < 0) return <span className="text-red-500 text-xs font-bold ml-1">▼ {Math.abs(val).toFixed(2)}</span>;
  return <span className="text-gray-400 text-xs ml-1">—</span>;
}

export default function CommodityPrices() {
  const [amsData, setAmsData] = useState([]);
  const [quotes, setQuotes] = useState({});       // symbol -> {price, change, pct}
  const [quotesAt, setQuotesAt] = useState(null);
  const [loading, setLoading] = useState(true);
  const [lastUpdated, setLastUpdated] = useState(null);

  useEffect(() => {
    // Futures quotes via our backend proxy (Yahoo Finance, 5-min cache)
    fetch('/api/commodity-prices/quotes')
      .then(r => r.ok ? r.json() : null)
      .then(d => {
        if (d?.quotes) {
          setQuotes(d.quotes);
          setQuotesAt(d.fetched_at ? new Date(d.fetched_at + 'Z').toLocaleTimeString() : null);
        }
      })
      .catch(() => {});

    // USDA AMS retail reports
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 8000);
    Promise.allSettled(
      AMS_REPORTS.map(r =>
        fetch(`https://mpr.datamart.ams.usda.gov/services/public/LMR/Report?Report_ID=${r.report}&key=&q=`, { signal: controller.signal })
          .then(res => res.ok ? res.json() : null)
          .then(data => ({ ...r, data }))
          .catch(() => ({ ...r, data: null }))
      )
    ).then(results => {
      setAmsData(results.map(r => r.value || r.reason));
      setLastUpdated(new Date().toLocaleTimeString());
      setLoading(false);
    });
    return () => clearTimeout(timeout);
  }, []);

  return (
    <div style={{ backgroundColor: '#f7f2e8', minHeight: '100vh' }}>
      <PageMeta title="Commodity Prices — Oatmeal Farm Network" description="Live commodity prices for corn, soybeans, wheat, cattle, hogs, and more." />
      <Header />
      <div style={{ background: 'linear-gradient(90deg,rgba(255,255,255,0.93) 0%,rgba(255,255,255,0) 100%)', borderBottom: '1px solid #e5e7eb' }}>
        <div className="max-w-5xl mx-auto px-6 py-10">
          <Breadcrumbs items={[{ label: 'Commodity Prices' }]} />
          <h1 className="text-3xl font-bold text-gray-900 mt-1" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>Commodity Prices</h1>
          <p className="text-gray-500 text-sm mt-1">Futures quotes, USDA cash prices, and market news.</p>
        </div>
      </div>
      <div className="max-w-5xl mx-auto px-6 py-8 space-y-8">

        {/* Futures — live quotes via backend proxy + links to CME/ICE */}
        <div>
          <div className="flex items-center justify-between mb-3">
            <h2 className="text-lg font-bold text-gray-900" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>Futures Quotes</h2>
            <span className="text-xs text-gray-400">
              {quotesAt ? `Updated ${quotesAt} · ` : ''}Delayed · CME Group / ICE
            </span>
          </div>
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
            {STATIC_PRICES.map(c => {
              const q = quotes[`${c.symbol}=F`] || quotes[c.symbol] || null;
              const up = q && q.change > 0;
              const dn = q && q.change < 0;
              return (
                <a key={c.symbol}
                  href={c.url}
                  target="_blank" rel="noopener noreferrer"
                  className="bg-white rounded-xl border border-gray-200 p-4 hover:shadow-md transition block">
                  <div className="flex items-center justify-between mb-0.5">
                    <span className="text-xs font-bold text-green-700">{c.symbol}</span>
                    <span className="text-xs text-gray-400">{c.exchange}</span>
                  </div>
                  <div className="font-bold text-gray-900 text-sm">{c.commodity}</div>
                  {q ? (
                    <>
                      <div className="text-xl font-bold mt-1" style={{ color: up ? '#16a34a' : dn ? '#dc2626' : '#111827' }}>
                        {q.price.toFixed(2)}
                        <span className="text-xs font-normal text-gray-400 ml-1">/{c.unit}</span>
                      </div>
                      <div className={`text-xs font-semibold mt-0.5 ${up ? 'text-green-600' : dn ? 'text-red-500' : 'text-gray-400'}`}>
                        {up ? '▲' : dn ? '▼' : '—'} {Math.abs(q.change).toFixed(2)} ({q.pct > 0 ? '+' : ''}{q.pct.toFixed(2)}%)
                      </div>
                    </>
                  ) : (
                    <div className="text-sm text-gray-400 mt-1 italic">Loading…</div>
                  )}
                  <div className="text-xs text-gray-400 mt-2">View quote ↗</div>
                </a>
              );
            })}
          </div>
        </div>

        {/* USDA AMS links */}
        <div>
          <h2 className="text-lg font-bold text-gray-900 mb-3" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>USDA Cash & Retail Reports</h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {[
              { label: 'National Dairy Products Sales Report', url: 'https://www.ams.usda.gov/market-news/dairy-products' },
              { label: 'Livestock & Meat Market Reports', url: 'https://www.ams.usda.gov/market-news/livestock-and-meat' },
              { label: 'Grain & Feed Market News', url: 'https://www.ams.usda.gov/market-news/grain-and-feed' },
              { label: 'Fruit & Vegetable Market News', url: 'https://www.ams.usda.gov/market-news/fruits-and-vegetables' },
              { label: 'Poultry & Eggs Market News', url: 'https://www.ams.usda.gov/market-news/poultry' },
              { label: 'USDA NASS Crop Values Report', url: 'https://www.nass.usda.gov/Statistics_by_Subject/index.php?sector=CROPS' },
            ].map(r => (
              <a key={r.label} href={r.url} target="_blank" rel="noopener noreferrer"
                className="bg-white rounded-xl border border-gray-200 px-5 py-4 flex items-center justify-between hover:shadow-sm transition">
                <span className="text-sm font-semibold text-gray-800">{r.label}</span>
                <span className="text-green-700 text-sm ml-3 shrink-0">↗</span>
              </a>
            ))}
          </div>
        </div>

        {/* Market news links */}
        <div>
          <h2 className="text-lg font-bold text-gray-900 mb-3" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>Market News & Analysis</h2>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
            {[
              { name: 'AgWeb Market News', url: 'https://www.agweb.com/markets' },
              { name: 'DTN Progressive Farmer', url: 'https://www.dtnpf.com/agriculture/web/ag/markets' },
              { name: 'Barchart Agriculture', url: 'https://www.barchart.com/futures/quotes/ZC*0/futures-prices' },
              { name: 'World Agricultural Supply & Demand (WASDE)', url: 'https://www.usda.gov/oce/commodity/wasde' },
              { name: 'CME Group Agricultural', url: 'https://www.cmegroup.com/markets/agriculture.html' },
              { name: 'USDA Economic Research Service', url: 'https://www.ers.usda.gov/topics/farm-economy/commodity-outlook/' },
            ].map(n => (
              <a key={n.name} href={n.url} target="_blank" rel="noopener noreferrer"
                className="bg-white rounded-xl border border-gray-200 px-4 py-3 text-sm font-semibold text-gray-800 hover:shadow-sm transition flex items-center justify-between">
                {n.name}
                <span className="text-green-700 ml-2 shrink-0">↗</span>
              </a>
            ))}
          </div>
        </div>

        <p className="text-xs text-gray-400 text-center">Futures prices are delayed. Not financial advice. Always verify with your broker or elevator before making marketing decisions.</p>
      </div>
      <Footer />
    </div>
  );
}
