// src/ProvenanceCard.jsx
// "Sourced From" card — restaurants print or screenshot to credit the farm on menus, table tents, and social.
// Route: /provenance/:businessId   Optional query: ?productTitle=...&productType=...
import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams } from 'react-router-dom';
import PageMeta from './PageMeta';

const API      = import.meta.env.VITE_API_URL || '';
const OFN_BASE = 'https://oatmealfarmnetwork.com';

export default function ProvenanceCard() {
  const { businessId } = useParams();
  const [params] = useSearchParams();
  const productTitle = params.get('productTitle') || '';

  const [farm,    setFarm]    = useState(null);
  const [loading, setLoading] = useState(true);
  const [err,     setErr]     = useState('');

  useEffect(() => {
    const load = async () => {
      try {
        const r = await fetch(`${API}/api/ranches/profile/${businessId}`);
        if (!r.ok) throw new Error(`${r.status}`);
        const data = await r.json();
        setFarm(data);
      } catch (e) {
        setErr('Could not load farm info.');
      } finally {
        setLoading(false);
      }
    };
    load();
  }, [businessId]);

  const farmUrl  = `${OFN_BASE}/marketplaces/livestock/ranch/${businessId}`;
  const qrUrl    = `https://api.qrserver.com/v1/create-qr-code/?size=300x300&margin=2&data=${encodeURIComponent(farmUrl)}`;
  // /api/ranches/profile/:id returns snake_case; other callers may pass PascalCase — accept both.
  const logo     = farm?.logo || farm?.ProfileImage || farm?.BusinessLogo || farm?.BusinessImage || null;
  const farmName = farm?.business_name || farm?.BusinessName || 'Local Farm';
  const city     = farm?.address_city  || farm?.AddressCity  || farm?.City  || '';
  const state    = farm?.address_state || farm?.AddressState || farm?.State || '';
  const location = [city, state].filter(Boolean).join(', ');

  return (
    <div className="min-h-screen bg-gray-100 print:bg-white">
      <PageMeta
        title={`Sourced From ${farmName} | OatmealFarmNetwork`}
        description={`Credit the farm. This ingredient was sourced directly from ${farmName}${location ? `, ${location}` : ''}.`}
      />

      {/* ── Action bar (hidden when printing) ── */}
      <div className="print:hidden bg-white border-b border-gray-200">
        <div className="mx-auto max-w-3xl px-4 py-3 flex items-center justify-between">
          <a href={farmUrl} className="text-sm text-[#3D6B34] hover:underline">← Back to farm</a>
          <div className="flex items-center gap-2">
            <button
              onClick={() => window.print()}
              className="bg-[#3D6B34] hover:bg-[#2d5225] text-white font-bold px-4 py-2 rounded-lg text-sm"
            >
              🖨️ Print card
            </button>
            <button
              onClick={() => { navigator.clipboard?.writeText(window.location.href); }}
              className="bg-white border border-gray-300 hover:bg-gray-50 text-gray-700 font-semibold px-4 py-2 rounded-lg text-sm"
              title="Copy link to this card"
            >
              🔗 Copy link
            </button>
          </div>
        </div>
      </div>

      {loading ? (
        <div className="text-center py-20 text-gray-500">Loading farm info…</div>
      ) : err ? (
        <div className="text-center py-20 text-red-500">{err}</div>
      ) : (
        <div className="mx-auto max-w-3xl px-4 py-8 print:p-0 print:max-w-none">
          {/* ── The printable card ── */}
          <div
            id="provenance-card"
            className="mx-auto bg-white shadow-xl rounded-2xl overflow-hidden print:shadow-none print:rounded-none"
            style={{ aspectRatio: '4 / 6', maxWidth: '480px' }}
          >
            <div className="flex flex-col h-full">
              {/* Photo / gradient top half */}
              <div
                className="relative"
                style={{
                  height: '50%',
                  background: logo
                    ? `url(${logo}) center/cover no-repeat`
                    : 'linear-gradient(135deg, #3D6B34 0%, #819360 100%)',
                }}
              >
                {!logo && (
                  <div className="absolute inset-0 flex items-center justify-center text-white text-7xl">🌾</div>
                )}
                <div
                  className="absolute bottom-0 left-0 right-0 px-6 py-4"
                  style={{ background: 'linear-gradient(to top, rgba(0,0,0,0.85), transparent)' }}
                >
                  <p
                    className="text-white uppercase tracking-[0.25em] text-xs font-bold"
                    style={{ fontFamily: "'Lora','Times New Roman',serif" }}
                  >
                    Sourced From
                  </p>
                </div>
              </div>

              {/* Farm info + QR bottom half */}
              <div className="flex-grow flex flex-col justify-between px-6 py-5 text-center">
                <div>
                  <h1
                    className="text-2xl font-bold text-gray-900 leading-tight mb-1"
                    style={{ fontFamily: "'Lora','Times New Roman',serif" }}
                  >
                    {farmName}
                  </h1>
                  {location && (
                    <p className="text-sm text-gray-500">📍 {location}</p>
                  )}
                  {productTitle && (
                    <p className="mt-3 text-base text-[#3D6B34] font-semibold italic">
                      {productTitle}
                    </p>
                  )}
                </div>

                <div className="flex flex-col items-center mt-4">
                  <img src={qrUrl} alt={`Scan to visit ${farmName}`} className="w-28 h-28" />
                  <p className="text-xs text-gray-500 mt-2">Scan to meet the farm</p>
                  <p className="text-[10px] text-gray-400 mt-1 font-semibold uppercase tracking-widest">
                    oatmealfarmnetwork.com
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div className="print:hidden mt-6 text-center text-sm text-gray-500">
            Print this card for menu inserts and table tents, or screenshot it for Instagram.
          </div>
        </div>
      )}

      <style>{`
        @media print {
          @page { margin: 0.5in; }
          body  { background: white !important; }
        }
      `}</style>
    </div>
  );
}
