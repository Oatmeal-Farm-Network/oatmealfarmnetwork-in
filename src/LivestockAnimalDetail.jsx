// src/LivestockAnimalDetail.jsx
// Public animal detail page — /marketplaces/livestock/animal/:id
// Also handles legacy redirect: /livestockmarketplace/Animals/Details.asp?ID=xxx
import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, useNavigate, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

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
  if (!photos || photos.length === 0) return (
    <div className="bg-gray-100 rounded-xl flex items-center justify-center" style={{ height: '320px' }}>
      <p className="text-gray-400 text-sm">No photos available</p>
    </div>
  );

  return (
    <div>
      {/* Main image */}
      <div className="overflow-hidden rounded-xl bg-gray-100" style={{ height: '320px' }}>
        <img
          src={photos[active]}
          alt="Animal photo"
          className="w-full h-full object-cover"
          onError={e => { e.target.src = '/images/HomepageLivestockDB.webp'; }}
        />
      </div>
      {/* Thumbnails */}
      {photos.length > 1 && (
        <div className="flex gap-2 mt-2 flex-wrap">
          {photos.map((url, i) => (
            <button
              key={i}
              onClick={() => setActive(i)}
              className={`overflow-hidden rounded-lg border-2 transition-all ${i === active ? 'border-[#3D6B34]' : 'border-gray-200'}`}
              style={{ width: '60px', height: '60px', flexShrink: 0 }}
            >
              <img
                src={url}
                alt={`Photo ${i + 1}`}
                className="w-full h-full object-cover"
                onError={e => { e.target.parentElement.style.display = 'none'; }}
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
    <tr className="border-b border-gray-100">
      <td className="py-2 pr-4 text-xs font-semibold text-gray-500 whitespace-nowrap w-32 align-top">{label}</td>
      <td className="py-2 text-sm text-gray-800 align-top">{content}</td>
    </tr>
  );
}

// ── Ancestry pedigree tree ────────────────────────────────────────────────────
function AncestorBox({ node, gender }) {
  if (!hasAncestor(node)) return <div className="w-36 h-12" />;
  const bg    = gender === 'male' ? '#dbeafe' : '#fce7f3';
  const border= gender === 'male' ? '#93c5fd' : '#f9a8d4';
  const text  = '#374151';
  return (
    <div
      className="rounded px-2 py-1 text-xs"
      style={{ backgroundColor: bg, border: `1px solid ${border}`, color: text, minWidth: '130px', maxWidth: '150px', wordBreak: 'break-word' }}
    >
      <div className="font-semibold leading-tight">
        {node.link && node.link !== '0' && node.link.length > 4
          ? <a href={node.link} target="_blank" rel="noopener noreferrer" style={{ color: '#3D6B34' }}>{node.name}</a>
          : node.name}
      </div>
      {node.color && node.color !== 'Not Available' && (
        <div className="text-gray-500 leading-tight mt-0.5">{node.color}</div>
      )}
    </div>
  );
}

function PedigreeTree({ ancestry, species }) {
  const { sire_term: ST = 'Sire', dam_term: DT = 'Dam' } = ancestry;
  const a = ancestry;

  const hasSireTree = hasAncestor(a.sire) || hasAncestor(a.sire_sire) || hasAncestor(a.sire_dam);
  const hasDamTree  = hasAncestor(a.dam)  || hasAncestor(a.dam_sire)  || hasAncestor(a.dam_dam);
  if (!hasSireTree && !hasDamTree) return null;

  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
      <h2 className="text-base font-bold mb-5" style={{ color: '#507033' }}>Pedigree</h2>
      <div className="overflow-x-auto">
        <table className="border-separate" style={{ borderSpacing: '4px 4px' }}>
          <tbody>
            {/* ── Sire side ── */}
            <tr>
              <td rowSpan={4} className="align-middle pr-2">
                <AncestorBox node={a.sire} gender="male" />
                <div className="text-[10px] text-gray-400 text-center mt-0.5">{ST}</div>
              </td>
              <td rowSpan={2} className="align-middle pr-2">
                <AncestorBox node={a.sire_sire} gender="male" />
              </td>
              <td className="align-top">
                <AncestorBox node={a.sire_sire_sire} gender="male" />
              </td>
            </tr>
            <tr>
              <td className="align-bottom">
                <AncestorBox node={a.sire_sire_dam} gender="female" />
              </td>
            </tr>
            <tr>
              <td rowSpan={2} className="align-middle pr-2">
                <AncestorBox node={a.sire_dam} gender="female" />
              </td>
              <td className="align-top">
                <AncestorBox node={a.sire_dam_sire} gender="male" />
              </td>
            </tr>
            <tr>
              <td className="align-bottom">
                <AncestorBox node={a.sire_dam_dam} gender="female" />
              </td>
            </tr>

            {/* spacer */}
            <tr><td colSpan={3} className="h-3" /></tr>

            {/* ── Dam side ── */}
            <tr>
              <td rowSpan={4} className="align-middle pr-2">
                <AncestorBox node={a.dam} gender="female" />
                <div className="text-[10px] text-gray-400 text-center mt-0.5">{DT}</div>
              </td>
              <td rowSpan={2} className="align-middle pr-2">
                <AncestorBox node={a.dam_sire} gender="male" />
              </td>
              <td className="align-top">
                <AncestorBox node={a.dam_sire_sire} gender="male" />
              </td>
            </tr>
            <tr>
              <td className="align-bottom">
                <AncestorBox node={a.dam_sire_dam} gender="female" />
              </td>
            </tr>
            <tr>
              <td rowSpan={2} className="align-middle pr-2">
                <AncestorBox node={a.dam_dam} gender="female" />
              </td>
              <td className="align-top">
                <AncestorBox node={a.dam_dam_sire} gender="male" />
              </td>
            </tr>
            <tr>
              <td className="align-bottom">
                <AncestorBox node={a.dam_dam_dam} gender="female" />
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}

// ── Fiber stats table ─────────────────────────────────────────────────────────
function FiberStats({ rows }) {
  if (!rows || rows.length === 0) return null;
  const hasData = rows.some(r =>
    r.Average || r.StandardDev || r.COV || r.GreaterThan30 ||
    r.Blanketweight || r.Shearweight || r.CF || r.Length || r.Curve
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
              <th className="text-center pb-2 text-gray-500 font-semibold">CF</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">Curve</th>
              <th className="text-center pb-2 text-gray-500 font-semibold">Length</th>
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
                  <td className="py-1.5 text-center">{r.Average  || '—'}</td>
                  <td className="py-1.5 text-center">{r.StandardDev || '—'}</td>
                  <td className="py-1.5 text-center">{r.COV || '—'}</td>
                  <td className="py-1.5 text-center">{r.GreaterThan30 || '—'}</td>
                  <td className="py-1.5 text-center">{r.CF || '—'}</td>
                  <td className="py-1.5 text-center">{r.Curve || '—'}</td>
                  <td className="py-1.5 text-center">{r.Length || '—'}</td>
                  <td className="py-1.5 text-center">{r.Shearweight || '—'}</td>
                  <td className="py-1.5 text-center">{r.Blanketweight || '—'}</td>
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

  const studFeeDisplay = animal.publish_stud && !animal.sold
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
        canonical={`https://oatmealfarmnetwork.com/marketplaces/livestock/animal/${id}`}
      />
      <Header />

      <div className="mx-auto px-4 py-6" style={{ maxWidth: '1200px' }}>

        {/* Breadcrumb */}
        <nav className="text-xs text-gray-500 mb-4 flex gap-1 flex-wrap">
          <Link to="/marketplaces/livestock" style={{ color: '#3D6B34' }}>Livestock Marketplace</Link>
          {backSlug && <><span>›</span><Link to={`/marketplaces/livestock/${backSlug}`} style={{ color: '#3D6B34' }}>{backLabel}</Link></>}
          <span>›</span>
          <span className="text-gray-700">{animal.full_name}</span>
        </nav>

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
          {animal.publish_for_sale && !animal.sold && !animal.sale_pending && (
            <span className="inline-block text-xs font-bold px-3 py-1 rounded-full" style={{ backgroundColor: '#dcfce7', color: '#166534' }}>For Sale</span>
          )}
        </div>

        {/* Two-column layout */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">

          {/* ── Left column: photos + stats ── */}
          <div className="lg:col-span-2 space-y-6">

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
            </div>

            {/* Description */}
            {animal.description && (
              <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                <h2 className="text-base font-bold mb-3" style={{ color: '#507033' }}>About this Animal</h2>
                <p className="text-sm text-gray-700 leading-relaxed whitespace-pre-wrap">{animal.description}</p>
              </div>
            )}

            {/* Finance terms */}
            {animal.finance_terms && animal.finance_terms.trim().length > 6 && (
              <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                <h2 className="text-base font-bold mb-2" style={{ color: '#507033' }}>Financial Terms</h2>
                <p className="text-sm text-gray-700 leading-relaxed">{animal.finance_terms}</p>
              </div>
            )}

            {/* Fiber stats */}
            <FiberStats rows={fiber_stats} />

            {/* Awards */}
            <Awards rows={awards} />

            {/* Pedigree */}
            {ancestry && <PedigreeTree ancestry={ancestry} species={animal.species_singular} />}

          </div>

          {/* ── Right column: summary card ── */}
          <div className="space-y-5">

            {/* Price / key info card */}
            <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">

              {pricing.price_comments && (
                <p className="text-sm font-semibold text-gray-700 mb-4">{pricing.price_comments}</p>
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
                  <StatRow label="Species" value={animal.species_singular} />
                  {animal.breeds.length > 0 && (
                    <StatRow label={animal.breeds.length > 1 ? 'Breeds' : 'Breed'} value={animal.breeds.join(', ')} />
                  )}
                  {animal.category && animal.category !== '0' && (
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
                  {registrations.map((r, i) => (
                    <StatRow key={i} label={r.type} value={r.number} />
                  ))}
                </tbody>
              </table>
            </div>

            {/* Owner card */}
            {(owner.business_name || owner.city || owner.state) && (
              <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-6">
                <h2 className="text-base font-bold mb-3" style={{ color: '#507033' }}>Listed By</h2>
                {owner.logo && (
                  <img
                    src={owner.logo}
                    alt={owner.business_name}
                    className="mb-3 object-contain rounded"
                    style={{ maxHeight: '64px', maxWidth: '180px' }}
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
                  <Link
                    to={`/marketplaces/livestock/ranch/${owner.business_id}`}
                    className="inline-block mt-3 text-xs font-bold"
                    style={{ color: '#3D6B34' }}
                  >
                    View Ranch Page →
                  </Link>
                )}
              </div>
            )}

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

            {/* Contact button */}
            {owner.people_id && (
              <Link
                to={`/contact-us?subject=${encodeURIComponent(`Inquiry about ${animal.full_name}`)}&people_id=${owner.people_id}`}
                className="block w-full text-center py-3 rounded-xl font-bold text-sm text-white transition-all hover:opacity-90"
                style={{ backgroundColor: '#3D6B34' }}
              >
                Contact Seller
              </Link>
            )}

            {/* Last updated */}
            {animal.last_updated && (
              <p className="text-xs text-gray-400 text-center">
                Last updated: {new Date(animal.last_updated).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' })}
              </p>
            )}

          </div>
        </div>
      </div>

      <Footer />
    </div>
  );
}
