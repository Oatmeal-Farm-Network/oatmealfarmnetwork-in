/**
 * AggregatorHub — landing page for Food Aggregation tools.
 *
 * Top-level KPI cards across all 4 subdashboards (Farms, Produce, Logistics,
 * Sales) plus tile links to each. Pulls everything from the single
 * GET /api/aggregator/{businessId}/dashboard summary endpoint.
 */
import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

const TILES = [
  { slug: 'farms',     icon: '🌱', title: 'Farm Network',
    desc: 'Partner farms, contracts, input distribution (saplings, tunnels, training).' },
  { slug: 'produce',   icon: '🫐', title: 'Procurement & Inventory',
    desc: 'Goods receipts, residue testing, cold-storage stock, QC status.' },
  { slug: 'logistics', icon: '🚛', title: 'Logistics',
    desc: 'Dispatch, drivers, cold-chain temperature log, breach alerts.' },
  { slug: 'sales',     icon: '🛒', title: 'B2B & D2C Sales',
    desc: 'Retail/restaurant accounts plus Zepto / Swiggy / own-app channels.' },
];

const fmt$  = (n) => Number(n || 0).toLocaleString(undefined, { maximumFractionDigits: 0 });
const fmtKg = (n) => Number(n || 0).toLocaleString(undefined, { maximumFractionDigits: 1 });

export default function AggregatorHub() {
  const [params] = useSearchParams();
  const { BusinessID: ctxBID } = useAccount();
  const BusinessID = params.get('BusinessID') || ctxBID;
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!BusinessID) return;
    setLoading(true);
    fetch(`${API}/api/aggregator/${BusinessID}/dashboard`)
      .then(r => r.ok ? r.json() : null)
      .then(d => { setData(d); setLoading(false); })
      .catch(() => setLoading(false));
  }, [BusinessID]);

  if (!BusinessID) {
    return (
      <AccountLayout pageTitle="Food Aggregation">
        <div className="p-6 text-sm text-gray-500">Pick a business from the account picker to see aggregator metrics.</div>
      </AccountLayout>
    );
  }

  const kpi = (label, value, sub) => (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <div className="text-[10px] uppercase font-semibold text-gray-500">{label}</div>
      <div className="text-2xl font-bold text-gray-900 mt-1">{value}</div>
      {sub && <div className="text-xs text-gray-500 mt-0.5">{sub}</div>}
    </div>
  );

  const breaches = data?.logistics?.cold_chain_breaches_7d || 0;
  const onHold   = data?.inventory?.items_on_hold || 0;

  return (
    <AccountLayout
      pageTitle="Food Aggregation"
      breadcrumbs={[{ label: 'Account', to: '/account' }, { label: 'Food Aggregation' }]}
    >
      <div className="max-w-6xl mx-auto p-5 space-y-6">
        <div>
          <h1 className="font-lora text-2xl font-bold text-gray-900">Food Aggregator Dashboard</h1>
          <p className="text-sm text-gray-500 mt-1">
            Direct procurement model — buy from your farm network, hold inventory + cold chain, distribute B2B and D2C.
          </p>
        </div>

        {(breaches > 0 || onHold > 0) && (
          <div className="bg-amber-50 border border-amber-300 rounded-xl p-3 text-sm text-amber-900 flex flex-wrap gap-x-4 gap-y-1">
            {breaches > 0 && <span>⚠️ <strong>{breaches}</strong> cold-chain breach{breaches === 1 ? '' : 'es'} in the last 7 days</span>}
            {onHold > 0 && <span>🛑 <strong>{onHold}</strong> inventory item{onHold === 1 ? '' : 's'} on hold / quarantine</span>}
          </div>
        )}

        {/* Top-line KPIs (last 30 days) */}
        <div>
          <div className="text-xs uppercase font-semibold text-gray-500 mb-2">Last 30 days</div>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {kpi('Active farms',     loading ? '…' : data?.farms?.active ?? 0,
                 `${data?.contracts?.active ?? 0} active contracts`)}
            {kpi('Procurement spend', loading ? '…' : '$' + fmt$(data?.purchases?.spend_30d),
                 `${fmtKg(data?.purchases?.kg_30d)} kg received`)}
            {kpi('Inventory on hand', loading ? '…' : fmtKg(data?.inventory?.current_kg) + ' kg',
                 'cold storage, OK + hold')}
            {kpi('Sales revenue',     loading ? '…' :
                 '$' + fmt$((data?.sales?.b2b_revenue_30d || 0) + (data?.sales?.d2c_revenue_30d || 0)),
                 `${(data?.sales?.b2b_orders_30d ?? 0) + (data?.sales?.d2c_orders_30d ?? 0)} orders`)}
          </div>
        </div>

        {/* B2B vs D2C breakdown */}
        <div className="grid md:grid-cols-2 gap-4">
          <div className="bg-white border border-gray-200 rounded-xl p-4">
            <div className="font-semibold text-gray-900 mb-1">B2B distribution</div>
            <div className="text-xs text-gray-500 mb-3">Retail chains, restaurants, distributors</div>
            <div className="text-2xl font-bold text-gray-900">${fmt$(data?.sales?.b2b_revenue_30d)}</div>
            <div className="text-xs text-gray-500">{data?.sales?.b2b_orders_30d ?? 0} orders · last 30d</div>
          </div>
          <div className="bg-white border border-gray-200 rounded-xl p-4">
            <div className="font-semibold text-gray-900 mb-1">D2C distribution</div>
            <div className="text-xs text-gray-500 mb-3">Own storefront + instant-commerce apps</div>
            <div className="text-2xl font-bold text-gray-900">${fmt$(data?.sales?.d2c_revenue_30d)}</div>
            <div className="text-xs text-gray-500">{data?.sales?.d2c_orders_30d ?? 0} orders · last 30d</div>
            {data?.sales?.d2c_by_channel?.length > 0 && (
              <div className="mt-3 space-y-1">
                {data.sales.d2c_by_channel.map(c => (
                  <div key={c.Channel} className="flex justify-between text-xs">
                    <span className="text-gray-700">{c.Channel}</span>
                    <span className="text-gray-500">${fmt$(c.Revenue)} · {c.Orders}</span>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        {/* Subdashboard tiles */}
        <div>
          <div className="text-xs uppercase font-semibold text-gray-500 mb-2">Manage</div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {TILES.map(t => (
              <Link key={t.slug}
                    to={`/aggregator/${t.slug}?BusinessID=${BusinessID}`}
                    className="bg-white border border-gray-200 rounded-xl p-4 flex gap-3 hover:border-[#819360] hover:shadow-sm transition">
                <div className="text-3xl shrink-0">{t.icon}</div>
                <div>
                  <div className="font-semibold text-gray-900">{t.title}</div>
                  <div className="text-xs text-gray-600 mt-0.5">{t.desc}</div>
                </div>
              </Link>
            ))}
          </div>
        </div>

        <div className="text-xs text-gray-400 italic pt-2">
          Inputs cost (last 30d): ${fmt$(data?.inputs?.cost_30d)} — saplings, tunnels, fertilizer distributed to farms.
        </div>
      </div>
    </AccountLayout>
  );
}
