// src/LivestockAnimalDetail.jsx
// Public animal detail page — /marketplaces/livestock/animal/:id
// Also handles legacy redirect: /livestockmarketplace/Animals/Details.asp?ID=xxx
import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, useNavigate, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

// ── Legacy redirect component ─────────────────────────────────────────────────
export function LegacyAnimalDetailRedirect() {
  const [params] = useSearchParams();
  const navigate = useNavigate();
  useEffect(() => {
    const id = params.get('ID') || params.get('id');
    if (id) {
      navigate(`/marketplaces/livestock/animal/${id}`, { replace: true });
    } else {
      navigate('/marketplaces/livestock', { replace: true });
    }
  }, []);
  return null;
}

// ── Helpers ───────────────────────────────────────────────────────────────────

function formatPrice(n) {
  if (n == null) return null;
  return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(n);
}

function formatDOB({ month, day, year }) {
  const parts = [];
  if (month && String(month) !== '0') parts.push(String(month).padStart(2, '0'));
  if (day   && String(day)   !== '0') parts.push(String(day).padStart(2, '0'));
  if (year  && String(year)  !== '0') parts.push(String(year));
  return parts.join('/') || null;
}

function hasAncestor(node) {
  return node && node.name && node.name.trim().length > 0;
}

// ── Photo gallery ─────────────────────────────────────────────────────────────
function PhotoGallery({ photos }) {
  const [active, setActive] = useState(0);
  // Track which indexes failed to load so they're hidden
  const [failed, setFailed] = useState({});

  const markFailed = (i) => setFailed(prev => ({ ...prev, [i]: true }));

  // Advance to next non-failed photo when active one fails
  const handleMainError = () => {
    markFailed(active);
    const next = photos.findIndex((_, i) => i > active && !failed[i]);
    if (next !== -1) setActive(next);
  };

  const visibleCount = photos ? photos.filter((_, i) => !failed[i]).length : 0;

  if (!photos || photos.length === 0 || visibleCount === 0) return (
    <div className="bg-gray-100 rounded-xl flex items-center justify-center" style={{ height: '320px' }}>
      <p className="text-gray-400 text-sm">No photos available</p>
    </div>
  );

  return (
    <div>
      {/* Main image — full image visible, no cropping */}
      <div
        className="rounded-xl bg-gray-100 flex items-center justify-center"
        style={{ width: '100%', minHeight: '240px', maxHeight: '560px', overflow: 'hidden' }}
      >
        <img
          key={active}
          src={photos[active]}
          alt="Animal photo"
          style={{
            maxWidth: '100%',
            maxHeight: '560px',
            width: 'auto',
            height: 'auto',
            objectFit: 'contain',
            display: 'block',
          }}
          onError={handleMainError}
        />
      </div>
      {/* Thumbnails — all photos attempted; failed ones hide themselves */}
      {photos.length > 1 && (
        <div className="flex gap-2 mt-3 flex-wrap">
          {photos.map((url, i) => (
            <button
              key={i}
              onClick={() => setActive(i)}
              className={`overflow-hidden rounded-lg border-2 transition-all ${i === active ? 'border-[#3D6B34]' : 'border-gray-200'}`}
              style={{ width: '72px', height: '72px', flexShrink: 0, display: failed[i] ? 'none' : 'block' }}
            >
              <img
                src={url}
                alt={`Photo ${i + 1}`}
                style={{ width: '100%', height: '100%', objectFit: 'contain', backgroundColor: '#f0ede6' }}
                onError={() => markFailed(i)}
              />
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

// ── Stats table row ───────────────────────────────────────────────────────────
function StatRow({ label, value, children }) {
  const content = children ?? value;
  if (content == null || content === '' || content === false) return null;
  return (
    <tr style={{ border: 'none' }}>
      <td style={{ border: 'none' }} className="py-0.5 pr-4 text-xs font-semibold text-gray-500 whitespace-nowrap w-32 align-top">{label}</td>
      <td style={{ border: 'none' }} className="py-0.5 text-sm text-gray-800 align-top">{content}</td>
    </tr>
  );
}

// ── Ancestry pedigree tree ────────────────────────────────────────────────────
function AncestorBox({ node, gender }) {
  const bg    = gender === 'male' ? '#dbeafe' : '#fce7f3';
  const border= gender === 'male' ? '#93c5fd' : '#f9a8d4';
  const text  = '#374151';
  const empty = !hasAncestor(node);
  return (
    <div
      className="rounded px-3 py-2 text-xs"
      style={{
        backgroundColor: empty ? '#f5f1ea' : bg,
        border: `1px solid ${empty ? '#e2d9cb' : border}`,
        color: text,
        width: '100%',
        minHeight: 56,
        wordBreak: 'break-word',
        opacity: empty ? 0.5 : 1,
      }}
    >
      {!empty && (
        <>
          <div className="font-semibold leading-tight">
            {(() => {
              const link = node.link;
              if (!link || link === '0' || String(link).length <= 4) return node.name;
              const isInternal = String(link).startsWith('/');
              return isInternal
                ? <Link to={link} style={{ color: '#3D6B34' }}>{node.name}</Link>
                : <a href={link} target="_blank" rel="noopener noreferrer" style={{ color: '#3D6B34' }}>{node.name}</a>;
            })()}
          </div>
          {node.color && node.color !== 'Not Available' && (
            <div className="text-gray-500 leading-tight mt-0.5">{node.color}</div>
          )}
          {node.reg && String(node.reg).trim() && (
            <div className="text-gray-500 leading-tight mt-0.5">Reg# {node.reg}</div>
          )}
        </>
      )}
    </div>
  );
}

function BranchCell({ top, bottom }) {
  return (
    <td
      style={{
        width: 18,
        padding: 0,
        borderRight: '2px solid #c9b89e',
        borderTop: top ? '2px solid #c9b89e' : 'none',
        borderBottom: bottom ? '2px solid #c9b89e' : 'none',
      }}
    />
  );
}

function AncCell({ children, rowSpan }) {
  return (
    <td rowSpan={rowSpan} style={{ padding: '3px 6px', verticalAlign: 'middle' }}>
      {children}
    </td>
  );
}

function AncestrySection({ ancestry, species }) {
  const bloodline = ancestry?.bloodline || {};
  const bloodlineEntries = Object.entries(bloodline).filter(([, v]) => v && String(v).trim());
  const hasAnyAncestor = [
    ancestry.sire, ancestry.sire_sire, ancestry.sire_dam,
    ancestry.sire_sire_sire, ancestry.sire_sire_dam,
    ancestry.sire_dam_sire, ancestry.sire_dam_dam,
    ancestry.dam, ancestry.dam_sire, ancestry.dam_dam,
    ancestry.dam_sire_sire, ancestry.dam_sire_dam,
    ancestry.dam_dam_sire, ancestry.dam_dam_dam,
  ].some(hasAncestor);
  if (bloodlineEntries.length === 0 && !hasAnyAncestor) return null;
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6 mt-6">
      <h2 className="text-base font-bold mb-3" style={{ color: '#507033' }}>Ancestry</h2>
      {bloodlineEntries.length > 0 && (
        <div className="flex flex-wrap gap-x-6 gap-y-1 text-sm text-gray-800 mb-5">
          {bloodlineEntries.map(([label, value]) => (
            <span key={label}>
              <span className="font-semibold">{value}</span> {label}
            </span>
          ))}
        </div>
      )}
      {hasAnyAncestor && <PedigreeTree ancestry={ancestry} species={species} />}
    </div>
  );
}

function PedigreeTree({ ancestry, species }) {
  const { sire_term: ST = 'Sire', dam_term: DT = 'Dam' } = ancestry;
  const a = ancestry;

  const anyAncestor = [
    a.sire, a.sire_sire, a.sire_dam, a.sire_sire_sire, a.sire_sire_dam,
    a.sire_dam_sire, a.sire_dam_dam,
    a.dam, a.dam_sire, a.dam_dam, a.dam_sire_sire, a.dam_sire_dam,
    a.dam_dam_sire, a.dam_dam_dam,
  ].some(hasAncestor);
  if (!anyAncestor) return null;

  return (
    <table style={{ width: '100%', borderCollapse: 'separate', borderSpacing: '0 2px', tableLayout: 'fixed' }}>
        <colgroup>
          <col style={{ width: '30%' }} />
          <col style={{ width: 18 }} />
          <col style={{ width: '30%' }} />
          <col style={{ width: 18 }} />
          <col style={{ width: '40%' }} />
        </colgroup>
        <tbody>
          {/* ── Sire side ── */}
          <tr>
            <AncCell rowSpan={4}>
              <AncestorBox node={a.sire} gender="male" />
              <div className="text-[10px] text-gray-400 text-center mt-0.5">{ST}</div>
            </AncCell>
            <BranchCell top={false} bottom={true} />
            <AncCell rowSpan={2}>
              <AncestorBox node={a.sire_sire} gender="male" />
            </AncCell>
            <BranchCell top={false} bottom={true} />
            <AncCell>
              <AncestorBox node={a.sire_sire_sire} gender="male" />
            </AncCell>
          </tr>
          <tr>
            <td style={{ borderRight: '2px solid #c9b89e', padding: 0, width: 18 }} />
            <BranchCell top={true} bottom={false} />
            <AncCell>
              <AncestorBox node={a.sire_sire_dam} gender="female" />
            </AncCell>
          </tr>
          <tr>
            <td style={{ borderRight: '2px solid #c9b89e', padding: 0, width: 18 }} />
            <AncCell rowSpan={2}>
              <AncestorBox node={a.sire_dam} gender="female" />
            </AncCell>
            <BranchCell top={false} bottom={true} />
            <AncCell>
              <AncestorBox node={a.sire_dam_sire} gender="male" />
            </AncCell>
          </tr>
          <tr>
            <td style={{ padding: 0, width: 18 }} />
            <BranchCell top={true} bottom={false} />
            <AncCell>
              <AncestorBox node={a.sire_dam_dam} gender="female" />
            </AncCell>
          </tr>

          {/* spacer */}
          <tr><td colSpan={5} style={{ height: 12 }} /></tr>

          {/* ── Dam side ── */}
          <tr>
            <AncCell rowSpan={4}>
              <AncestorBox node={a.dam} gender="female" />
              <div className="text-[10px] text-gray-400 text-center mt-0.5">{DT}</div>
            </AncCell>
            <BranchCell top={false} bottom={true} />
            <AncCell rowSpan={2}>
              <AncestorBox node={a.dam_sire} gender="male" />
            </AncCell>
            <BranchCell top={false} bottom={true} />
            <AncCell>
              <AncestorBox node={a.dam_sire_sire} gender="male" />
            </AncCell>
          </tr>
          <tr>
            <td style={{ borderRight: '2px solid #c9b89e', padding: 0, width: 18 }} />
            <BranchCell top={true} bottom={false} />
            <AncCell>
              <AncestorBox node={a.dam_sire_dam} gender="female" />
            </AncCell>
          </tr>
          <tr>
            <td style={{ borderRight: '2px solid #c9b89e', padding: 0, width: 18 }} />
            <AncCell rowSpan={2}>
              <AncestorBox node={a.dam_dam} gender="female" />
            </AncCell>
            <BranchCell top={false} bottom={true} />
            <AncCell>
              <AncestorBox node={a.dam_dam_sire} gender="male" />
            </AncCell>
          </tr>
          <tr>
            <td style={{ padding: 0, width: 18 }} />
            <BranchCell top={true} bottom={false} />
            <AncCell>
              <AncestorBox node={a.dam_dam_dam} gender="female" />
            </AncCell>
          </tr>
        </tbody>
      </table>
  );
}

// ── Fiber stats table ─────────────────────────────────────────────────────────
function FiberStats({ rows }) {
  if (!rows || rows.length === 0) return null;
  const hasData = rows.some(r =>
    r.Average || r.StandardDev || r.COV || r.GreaterThan30 ||
    r.BlanketWeight || r.ShearWeight || r.CF || r.Length || r.Curve || r.CrimpPerInch
  );
  if (!hasData) return null;

  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
      <h2 className="text-base font-bold mb-4" style={{ color: '#507033' }}>Fiber Stats</h2>
      <div className="overflow-x-auto">
        <table className="w-full text-xs">
          <thead>
            <tr className="border-b border-gray-200">
              <th className="text-left pb-2 text-gray-500 font-semibold">Date</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">AFD</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">SD</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">COV</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">%&gt;30µ</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">Curve</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">CF</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">Crimps/In</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">Staple Length</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">Shear Wt</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">Blanket Wt</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r, i) => {
              const dateParts = [];
              if (r.SampleDateMonth && r.SampleDateMonth !== '0') dateParts.push(r.SampleDateMonth);
              if (r.SampleDateDay   && r.SampleDateDay   !== '0') dateParts.push(r.SampleDateDay);
              if (r.SampleDateYear  && r.SampleDateYear  !== '0') dateParts.push(r.SampleDateYear);
              return (
                <tr key={i} className={i % 2 === 0 ? 'bg-gray-50' : ''}>
                  <td className="py-1.5 pr-3 whitespace-nowrap">{dateParts.join('/') || '—'}</td>
                  <td className="py-1.5 text-center">{r.Average || '—'}</td>
                  <td className="py-1.5 text-center">{r.StandardDev || '—'}</td>
                  <td className="py-1.5 text-center">{r.COV || '—'}</td>
                  <td className="py-1.5 text-center">{r.GreaterThan30 || '—'}</td>
                  <td className="py-1.5 text-center">{r.Curve || '—'}</td>
                  <td className="py-1.5 text-center">{r.CF || '—'}</td>
                  <td className="py-1.5 text-center">{r.CrimpPerInch || '—'}</td>
                  <td className="py-1.5 text-center">{r.Length || '—'}</td>
                  <td className="py-1.5 text-center">{r.ShearWeight || '—'}</td>
                  <td className="py-1.5 text-center">{r.BlanketWeight || '—'}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
}

// ── Awards table ──────────────────────────────────────────────────────────────
function Awards({ rows }) {
  if (!rows || rows.length === 0) return null;
  const filtered = rows.filter(r => r.ShowName || r.Placing || r.AwardClass);
  if (filtered.length === 0) return null;
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
      <h2 className="text-base font-bold mb-4" style={{ color: '#507033' }}>Awards</h2>
      <div className="space-y-2">
        {filtered.map((r, i) => (
          <div key={i} className={`rounded-lg px-4 py-2 text-sm ${i % 2 === 0 ? 'bg-gray-50' : 'bg-white border border-gray-100'}`}>
            <div className="flex flex-wrap gap-x-4 gap-y-0.5">
              {r.Placing    && <span className="font-semibold text-[#3D6B34]">{r.Placing}</span>}
              {r.AwardClass && <span className="text-gray-600">{r.AwardClass}</span>}
              {r.AwardYear && r.AwardYear !== '0' && <span className="text-gray-500">{r.AwardYear}</span>}
              {r.ShowName   && <span className="text-gray-700">{r.ShowName}</span>}
            </div>
            {r.AwardComments && <p className="text-gray-500 text-xs mt-0.5">{r.AwardComments}</p>}
          </div>
        ))}
      </div>
    </div>
  );
}

// ── Main component ────────────────────────────────────────────────────────────
export default function LivestockAnimalDetail() {
  const { id } = useParams();
  const [animal, setAnimal] = useState(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);

  useEffect(() => {
    window.scrollTo(0, 0);
    setLoading(true);
    setNotFound(false);
    fetch(`${API_URL}/api/marketplace/animal/${id}`)
      .then(r => {
        if (!r.ok) { setNotFound(true); return null; }
        return r.json();
      })
      .then(data => {
        if (data) setAnimal(data);
      })
      .catch(() => setNotFound(true))
      .finally(() => setLoading(false));
  }, [id]);

  if (loading) return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <Header />
      <div className="flex items-center justify-center py-32">
        <div className="w-8 h-8 border-4 border-[#3D6B34] border-t-transparent rounded-full animate-spin" />
      </div>
      <Footer />
    </div>
  );

  if (notFound || !animal) return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <Header />
      <div className="max-w-2xl mx-auto px-4 py-24 text-center">
        <h1 className="text-2xl font-bold text-gray-800 mb-4">Animal Not Found</h1>
        <p className="text-gray-600 mb-8">This listing may have been removed or the ID is incorrect.</p>
        <Link to="/marketplaces/livestock" className="text-sm font-bold" style={{ color: '#3D6B34' }}>← Back to Livestock Marketplace</Link>
      </div>
      <Footer />
    </div>
  );

  const { pricing, owner, ancestry, photos, awards, fiber_stats, registrations } = animal;
  const dob = formatDOB(animal.dob || {});

  const priceDisplay = pricing.free
    ? 'Free'
    : pricing.sold
    ? null
    : pricing.price
    ? formatPrice(pricing.price)
    : null;

  const studFeeDisplay = !animal.sold && (animal.publish_stud || pricing.stud_fee)
    ? (pricing.stud_fee ? formatPrice(pricing.stud_fee) : 'Call for Fee')
    : null;

  const backSlug = animal.species_slug;
  const backLabel = animal.species_singular ? `${animal.species_singular}s` : 'Livestock';

  const metaDesc = `${animal.full_name} — ${animal.species_singular} for sale at ${owner?.business_name || 'OatmealFarmNetwork'}${owner?.state ? `, ${owner.state}` : ''}. ${(animal.description || '').slice(0, 120)}`;

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title={`${animal.full_name} — ${animal.species_singular} For Sale | OatmealFarmNetwork`}
        description={metaDesc}
        keywords={`${animal.full_name}, ${animal.species_singular} for sale, ${backLabel || ''}, livestock marketplace`}
        canonical={`https://oatmealfarmnetwork.com/marketplaces/livestock/animal/${id}`}
        ogType="product"
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'Product',
          name: animal.full_name,
          description: metaDesc,
          url: `https://oatmealfarmnetwork.com/marketplaces/livestock/animal/${id}`,
          ...(pricing.price ? {
            offers: {
              '@type': 'Offer',
              price: pricing.price,
              priceCurrency: 'USD',
              availability: animal.sold ? 'https://schema.org/SoldOut' : 'https://schema.org/InStock',
            }
          } : {})
        }}
      />
      <Header />

      <div className="mx-auto px-4 py-6" style={{ maxWidth: '1200px' }}>

        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Marketplaces', to: '/marketplaces' },
          { label: 'Livestock', to: '/marketplaces/livestock' },
          ...(backSlug ? [{ label: backLabel, to: `/marketplaces/livestock/${backSlug}` }] : []),
          { label: animal.full_name },
        ]} />

        {/* Last updated */}
        {animal.last_updated && (
          <p className="text-xs text-gray-400 mb-4">
            Last updated: {new Date(animal.last_updated).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' })}
          </p>
        )}

        {/* Page title */}
        <h1 className="text-2xl font-bold text-gray-900 mb-6" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
          {animal.full_name}
        </h1>

        {/* Status badges */}
        <div className="flex flex-wrap gap-2 mb-6">
          {animal.sold && (
            <span className="inline-block bg-red-100 text-red-700 text-xs font-bold px-3 py-1 rounded-full">SOLD</span>
          )}
          {animal.sale_pending && !animal.sold && (
            <span className="inline-block bg-yellow-100 text-yellow-700 text-xs font-bold px-3 py-1 rounded-full">Sale Pending</span>
          )}
          {animal.publish_stud && !animal.sold && (
            <span className="inline-block bg-blue-100 text-blue-700 text-xs font-bold px-3 py-1 rounded-full">Stud Available</span>
          )}
        </div>

        {/* Two-column layout — equal width: left info, right photos */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">

          {/* ── Left column: combined info card ── */}
          <div className="space-y-5">

            {/* Combined: pricing + listed by + description */}
            <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6 space-y-5">

              {/* Pricing / key stats */}
              <div>
                {pricing.price_comments && (
                  <p className="text-sm font-semibold text-gray-700 mb-3">{pricing.price_comments}</p>
                )}
                <table className="w-full text-sm">
                  <tbody>
                    {priceDisplay && (
                      <StatRow label="Price">
                        <span className="font-bold text-lg" style={{ color: '#3D6B34' }}>{priceDisplay}</span>
                        {pricing.obo && <span className="ml-2 text-xs text-gray-500">OBO</span>}
                      </StatRow>
                    )}
                    {pricing.discount > 0 && priceDisplay && (
                      <StatRow label="Discount">
                        <span className="text-red-600 font-bold">{pricing.discount}% off</span>
                        <span className="ml-2 text-gray-500 line-through">{priceDisplay}</span>
                        <span className="ml-2 font-bold text-red-600">
                          {formatPrice(pricing.price * (1 - pricing.discount / 100))}
                        </span>
                      </StatRow>
                    )}
                    {studFeeDisplay && (
                      <StatRow label="Stud Fee">
                        <span className="font-bold" style={{ color: '#3D6B34' }}>{studFeeDisplay}</span>
                      </StatRow>
                    )}
                    {dob && <StatRow label="DOB" value={dob} />}
                    {(() => {
                      const seen = new Set();
                      return registrations
                        .filter(r => {
                          const key = `${r.type}|${r.number}`;
                          if (seen.has(key)) return false;
                          seen.add(key);
                          return true;
                        })
                        .map((r, i) => (
                          <StatRow key={i} label={r.type} value={r.number} />
                        ));
                    })()}
                    <StatRow label="Species" value={animal.species_singular} />
                    {animal.breeds.length > 0 && (
                      <StatRow label={animal.breeds.length > 1 ? 'Breeds' : 'Breed'} value={animal.breeds.join(', ')} />
                    )}
                    {animal.category && String(animal.category) !== '0' && (
                      <StatRow label="Category" value={animal.category} />
                    )}
                    {animal.colors.length > 0 && (
                      <StatRow label="Color" value={animal.colors.join(' / ')} />
                    )}
                    {animal.height && <StatRow label="Height" value={animal.height} />}
                    {animal.weight && <StatRow label="Weight" value={animal.weight} />}
                    {animal.horns  && <StatRow label="Horns"  value={animal.horns}  />}
                    {animal.temperament && animal.temperament !== '0' && (
                      <StatRow label="Temperament">
                        {animal.temperament} <span className="text-xs text-gray-400 ml-1">(1=calm, 10=spirited)</span>
                      </StatRow>
                    )}
                    {animal.vaccinations && (
                      <StatRow label="Vaccinations" value={animal.vaccinations} />
                    )}
                  </tbody>
                </table>
              </div>

              {/* Divider */}
              {(owner.business_name || owner.city || owner.state) && (
                <hr className="border-gray-100" />
              )}

              {/* Listed By */}
              {(owner.business_name || owner.city || owner.state) && (
                <div className="text-center">
                  <p className="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-2">Listed By</p>
                  {owner.logo && (
                    <img
                      src={owner.logo}
                      alt={owner.business_name}
                      className="mb-2 object-contain rounded mx-auto"
                      style={{ maxHeight: '56px', maxWidth: '160px' }}
                      onError={e => { e.target.style.display = 'none'; }}
                    />
                  )}
                  {owner.business_name && (
                    <p className="font-bold text-sm text-gray-800">{owner.business_name}</p>
                  )}
                  {(owner.city || owner.state) && (
                    <p className="text-sm text-gray-500 mt-0.5">
                      {[owner.city, owner.state].filter(Boolean).join(', ')}
                    </p>
                  )}
                  {owner.business_id && (
                    <div>
                      <Link
                        to={`/marketplaces/livestock/ranch/${owner.business_id}`}
                        className="inline-block mt-2 text-xs font-bold"
                        style={{ color: '#3D6B34' }}
                      >
                        View Ranch Page →
                      </Link>
                    </div>
                  )}
                  {owner.business_id && (
                    <div className="mt-4">
                      <p className="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-2">Contact Seller</p>
                      <Link
                        to={`/marketplaces/livestock/ranch/${owner.business_id}`}
                        className="inline-block px-4 py-1.5 rounded-lg font-bold text-xs text-white transition-all hover:opacity-90"
                        style={{ backgroundColor: 'rgb(123, 141, 92)', color: '#ffffff' }}
                      >
                        Contact Seller
                      </Link>
                    </div>
                  )}
                </div>
              )}


              {/* Finance terms */}
              {animal.finance_terms && animal.finance_terms.trim().length > 6 && (
                <>
                  <hr className="border-gray-100" />
                  <div>
                    <p className="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1">Financial Terms</p>
                    <p className="text-sm text-gray-700 leading-relaxed">{animal.finance_terms}</p>
                  </div>
                </>
              )}

            </div>

            {/* Co-owners */}
            {animal.co_owners && animal.co_owners.length > 0 && (
              <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                <h2 className="text-sm font-bold mb-2 text-gray-700">Co-Owned By</h2>
                {animal.co_owners.map((co, i) => (
                  <div key={i} className="text-sm text-gray-700 mb-1">
                    {co.link && co.link.length > 3
                      ? <a href={`http://${co.link}`} target="_blank" rel="noopener noreferrer" style={{ color: '#3D6B34' }}>{co.business || co.name}</a>
                      : <span>{co.business || co.name}</span>}
                    {co.business && co.name && co.business !== co.name && (
                      <span className="text-gray-500">, {co.name}</span>
                    )}
                  </div>
                ))}
              </div>
            )}

          </div>

          {/* ── Right column: photos ── */}
          <div className="space-y-6">

            {/* Photos */}
            <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-5">
              <PhotoGallery photos={photos} />
              {animal.video_url && (
                <div className="mt-3">
                  <a href={animal.video_url} target="_blank" rel="noopener noreferrer" className="text-xs font-bold" style={{ color: '#3D6B34' }}>
                    ▶ Watch Video
                  </a>
                </div>
              )}
              {(animal.registration_url || animal.histogram_url) && (
                <div className="mt-3 flex flex-col gap-1">
                  {animal.registration_url && (
                    <a href={animal.registration_url} target="_blank" rel="noopener noreferrer" download
                       className="text-xs font-bold" style={{ color: '#3D6B34' }}>
                      📄 Download Registration Certificate
                    </a>
                  )}
                  {animal.histogram_url && (
                    <a href={animal.histogram_url} target="_blank" rel="noopener noreferrer" download
                       className="text-xs font-bold" style={{ color: '#3D6B34' }}>
                      📄 Download Histogram
                    </a>
                  )}
                </div>
              )}
              <div className="mt-3">
                <Link to={`/marketplaces/livestock/animal/${animal.animal_id}/progeny`}
                      className="text-xs font-bold" style={{ color: '#3D6B34' }}>
                  👶 View Progeny
                </Link>
              </div>
            </div>

          </div>
        </div>

        {/* ── Full-width awards ── */}
        {awards && awards.length > 0 && (
          <div className="mt-6">
            <Awards rows={awards} />
          </div>
        )}

        {/* ── Full-width description ── */}
        {animal.description && (
          <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6 mt-6">
            <h2 className="text-base font-bold mb-3" style={{ color: '#507033' }}>
              About {animal.full_name}
            </h2>
            <div
              className="text-sm text-gray-700 leading-relaxed"
              dangerouslySetInnerHTML={{ __html: animal.description }}
            />
          </div>
        )}

        {/* ── Full-width fiber stats ── */}
        {fiber_stats && fiber_stats.length > 0 && (
          <div className="mt-6">
            <FiberStats rows={fiber_stats} />
          </div>
        )}

        {/* ── Full-width ancestry (bloodline + pedigree tree) ── */}
        {ancestry && (
          <AncestrySection ancestry={ancestry} species={animal.species_singular} />
        )}
      </div>

      <Footer />
    </div>
  );
}
