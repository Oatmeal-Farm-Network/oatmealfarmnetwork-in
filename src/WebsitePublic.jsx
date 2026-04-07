import React, { useState, useEffect } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';

const API = import.meta.env.VITE_API_URL;

// ── Build CSS rules for [data-rte-style] spans (mirrors WebsiteBuilder's buildRteTypoCss) ──
function buildPublicRteTypoCss(site) {
  if (!site) return '';
  return [['h1','h1'],['h2','h2'],['h3','h3'],['h4','h4'],['body','body']].map(([k]) => {
    const size       = site[`${k}_size`]   || (k==='body'?'16px':k==='h1'?'40px':k==='h2'?'29px':k==='h3'?'21px':'17px');
    const weight     = site[`${k}_weight`] || (k==='body'?'400':k==='h1'?'800':k==='h2'?'700':k==='h3'?'600':'600');
    const color      = site[`${k}_color`]  || site.text_color || '';
    const fontFamily = site[`${k}_font`]   || site.font_family || '';
    const uline      = site[`${k}_underline`];
    const hasRule    = k !== 'body' && site[`${k}_rule`];
    const ruleclr    = site[`${k}_rule_color`] || site.text_color || '#000';
    const align      = site[`${k}_align`]  || 'left';
    let css = `font-size:${size};font-weight:${weight};`;
    if (fontFamily) css += `font-family:${fontFamily};`;
    if (color)      css += `color:${color};`;
    css += uline ? `text-decoration:underline;` : `text-decoration:none;`;
    css += hasRule ? `border-bottom:2px solid ${ruleclr};padding-bottom:2px;` : `border-bottom:none;padding-bottom:0;`;
    if (align !== 'left') css += `display:inline-block;text-align:${align};width:100%;`;
    return `.site-rte [data-rte-style="${k}"] { ${css} }`;
  }).join('\n    ');
}

// ── Content cache (avoid re-fetching per block) ──────────────────
const contentCache = {};
async function fetchContent(url) {
  if (contentCache[url]) return contentCache[url];
  const r = await fetch(url);
  if (!r.ok) return [];
  const data = await r.json();
  contentCache[url] = data;
  return data;
}

// ── Block renderers ───────────────────────────────────────────────

function HeroBlock({ data, site }) {
  const align = data.align || 'center';
  const alignClass = align === 'left' ? 'items-start text-left' : align === 'right' ? 'items-end text-right' : 'items-center text-center';
  const bgWidth = site.body_bg_width || '100%';
  const textWidth = site.body_content_width || '100%';
  return (
    <div style={{ display: 'flex', justifyContent: 'center' }}>
      <section style={{
        width: '100%', maxWidth: bgWidth,
        minHeight: '70vh', display: 'flex', alignItems: 'center',
        justifyContent: align === 'left' ? 'flex-start' : align === 'right' ? 'flex-end' : 'center',
        backgroundImage: data.image_url ? `url(${data.image_url})` : `linear-gradient(135deg, ${site.primary_color}cc, ${site.secondary_color}cc)`,
        backgroundSize: 'cover', backgroundPosition: 'center', position: 'relative',
      }}>
        {data.image_url && data.overlay && (
          <div style={{ position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.45)' }} />
        )}
        <div style={{ position: 'relative', width: '100%', maxWidth: textWidth, padding: '3rem 2rem', zIndex: 1 }}
             className={`flex flex-col gap-4 ${alignClass}`}>
          {data.headline && (
            <h1 style={{ fontSize: 'clamp(2rem, 5vw, 3.5rem)', fontWeight: 800, lineHeight: 1.15,
                          color: '#fff', fontFamily: site.font_family }}>
              {data.headline}
            </h1>
          )}
          {data.subtext && (
            <p style={{ fontSize: '1.2rem', color: data.image_url ? 'rgba(255,255,255,0.9)' : 'rgba(255,255,255,0.85)',
                         fontFamily: site.font_family }}>
              {data.subtext}
            </p>
          )}
          {data.cta_text && data.cta_link && (
            <a href={data.cta_link} style={{
              display: 'inline-block', background: site.accent_color, color: '#fff',
              fontWeight: 700, padding: '0.85rem 2rem', borderRadius: 50, textDecoration: 'none',
              fontSize: '1rem', transition: 'transform 0.2s', boxShadow: '0 4px 20px rgba(0,0,0,0.2)',
            }} onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px)'}
               onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
              {data.cta_text}
            </a>
          )}
        </div>
      </section>
    </div>
  );
}

function AboutBlock({ data, site }) {
  const hasImage = data.image_url && data.image_position !== 'none';
  const imgRight = data.image_position !== 'left';
  return (
    <SectionWrap site={site}>
      <div className={`flex flex-col md:flex-row gap-10 items-center ${!imgRight ? 'md:flex-row-reverse' : ''}`}>
        <div className="flex-1">
          {data.heading && <SectionHeading html={data.heading} site={site} />}
          {data.body && <BodyText html={data.body} site={site} />}
        </div>
        {hasImage && (
          <div className="flex-1">
            <img src={data.image_url} alt="" style={{ width: '100%', borderRadius: 16, boxShadow: '0 8px 30px rgba(0,0,0,0.12)' }} />
          </div>
        )}
      </div>
    </SectionWrap>
  );
}

function ContentBlock({ data, site }) {
  const hasImage = data.image_url && data.image_position !== 'none';
  const imgRight = data.image_position === 'right';
  const imgTop = data.image_position === 'top';
  return (
    <SectionWrap site={site}>
      {imgTop && hasImage && <img src={data.image_url} alt="" style={{ width: '100%', borderRadius: 12, marginBottom: '1.5rem' }} />}
      <div className={`flex flex-col ${hasImage && !imgTop ? 'md:flex-row gap-10 items-start' : ''} ${hasImage && !imgTop && !imgRight ? 'md:flex-row-reverse' : ''}`}>
        <div className={hasImage && !imgTop ? 'flex-1' : 'w-full'}>
          {data.heading && <SectionHeading html={data.heading} site={site} />}
          {data.body && <BodyText html={data.body} site={site} />}
        </div>
        {hasImage && !imgTop && (
          <div className="flex-1">
            <img src={data.image_url} alt="" style={{ width: '100%', borderRadius: 12 }} />
          </div>
        )}
      </div>
    </SectionWrap>
  );
}

function LivestockBlock({ data, site, businessId }) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/livestock?business_id=${businessId}`)
      .then(all => {
        let filtered = all;
        if (data.show_for_sale && !data.show_studs) filtered = all.filter(a => a.PublishForSale);
        if (data.show_studs && !data.show_for_sale) filtered = all.filter(a => a.PublishStud);
        setItems(filtered.slice(0, data.max_items || 6));
      });
  }, [businessId]);

  if (items.length === 0) return null;
  return (
    <SectionWrap site={site} alt>
      <SectionHeading site={site}>{data.heading || 'Animals'}</SectionHeading>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5 mt-4">
        {items.map(a => (
          <div key={a.AnimalID} style={{ background: '#fff', borderRadius: 14, boxShadow: '0 2px 12px rgba(0,0,0,0.08)', overflow: 'hidden' }}>
            {a.Photo1 && <img src={a.Photo1} alt={a.FullName} style={{ width: '100%', height: 180, objectFit: 'cover' }} />}
            {!a.Photo1 && <div style={{ height: 140, background: `${site.primary_color}22`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2.5rem' }}>🐄</div>}
            <div style={{ padding: '1rem' }}>
              <div style={{ fontWeight: 700, fontSize: '1rem', color: site.text_color, fontFamily: site.font_family }}>{a.FullName || a.ShortName}</div>
              {a.Breed && <div style={{ fontSize: '0.82rem', color: '#6B7280', marginTop: 2 }}>{a.Breed} {a.Category ? `· ${a.Category}` : ''}</div>}
              {a.Description && <p style={{ fontSize: '0.8rem', color: '#6B7280', marginTop: 6, lineHeight: 1.5 }}>{a.Description?.slice(0, 120)}{a.Description?.length > 120 ? '…' : ''}</p>}
              <div style={{ marginTop: 8, display: 'flex', gap: 6 }}>
                {a.PublishForSale === 1 && <span style={{ background: site.primary_color + '22', color: site.primary_color, borderRadius: 20, padding: '2px 10px', fontSize: '0.72rem', fontWeight: 600 }}>For Sale</span>}
                {a.PublishStud === 1 && <span style={{ background: site.accent_color + '44', color: '#92400E', borderRadius: 20, padding: '2px 10px', fontSize: '0.72rem', fontWeight: 600 }}>Stud</span>}
              </div>
              {a.Financeterms && <p style={{ fontSize: '0.75rem', color: '#9CA3AF', marginTop: 4 }}>{a.Financeterms}</p>}
            </div>
          </div>
        ))}
      </div>
    </SectionWrap>
  );
}

function ProduceBlock({ data, site, businessId }) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/produce?business_id=${businessId}`)
      .then(d => setItems(d.slice(0, data.max_items || 8)));
  }, [businessId]);
  if (items.length === 0) return null;
  return (
    <SectionWrap site={site}>
      <SectionHeading site={site}>{data.heading || 'Fresh Produce'}</SectionHeading>
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4 mt-4">
        {items.map(p => (
          <PriceCard key={p.ProduceID} icon="🥕" name={p.IngredientName} price={p.RetailPrice}
            unit={p.QuantityMeasurement} tags={[p.IsOrganic && 'Organic', p.IsLocal && 'Local'].filter(Boolean)}
            site={site} />
        ))}
      </div>
    </SectionWrap>
  );
}

function MeatBlock({ data, site, businessId }) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/meat?business_id=${businessId}`)
      .then(d => setItems(d.slice(0, data.max_items || 8)));
  }, [businessId]);
  if (items.length === 0) return null;
  return (
    <SectionWrap site={site} alt>
      <SectionHeading site={site}>{data.heading || 'Meat'}</SectionHeading>
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4 mt-4">
        {items.map(m => (
          <PriceCard key={m.MeatInventoryID} icon="🥩" name={m.IngredientName}
            price={m.RetailPrice} unit={`${m.Weight} ${m.WeightUnit}`}
            tags={[]} site={site} />
        ))}
      </div>
    </SectionWrap>
  );
}

function ProcessedFoodBlock({ data, site, businessId }) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/processed-food?business_id=${businessId}`)
      .then(d => setItems(d.slice(0, data.max_items || 8)));
  }, [businessId]);
  if (items.length === 0) return null;
  return (
    <SectionWrap site={site}>
      <SectionHeading site={site}>{data.heading || 'Farm Products'}</SectionHeading>
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4 mt-4">
        {items.map(f => (
          <PriceCard key={f.ProcessedFoodID} icon="🫙" name={f.Name} price={f.RetailPrice}
            image={f.ImageURL} desc={f.Description} tags={[]} site={site} />
        ))}
      </div>
    </SectionWrap>
  );
}

function ServicesBlock({ data, site, businessId }) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/services?business_id=${businessId}`)
      .then(d => setItems(d.slice(0, data.max_items || 6)));
  }, [businessId]);
  if (items.length === 0) return null;
  return (
    <SectionWrap site={site} alt>
      <SectionHeading site={site}>{data.heading || 'Our Services'}</SectionHeading>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5 mt-4">
        {items.map(s => (
          <div key={s.ServicesID} style={{ background: '#fff', borderRadius: 14, padding: '1.25rem', boxShadow: '0 2px 12px rgba(0,0,0,0.07)' }}>
            {s.Photo1 && <img src={s.Photo1} alt={s.ServiceTitle} style={{ width: '100%', height: 160, objectFit: 'cover', borderRadius: 8, marginBottom: '0.75rem' }} />}
            <div style={{ fontWeight: 700, color: site.text_color, fontFamily: site.font_family }}>{s.ServiceTitle}</div>
            {s.ServicesDescription && <p style={{ fontSize: '0.82rem', color: '#6B7280', marginTop: 6, lineHeight: 1.5 }}>{s.ServicesDescription?.slice(0, 150)}</p>}
            {(s.ServicePrice || s.Price2) && (
              <div style={{ marginTop: 8, fontWeight: 600, color: site.primary_color }}>{s.ServicePrice || `$${s.Price2}`}</div>
            )}
          </div>
        ))}
      </div>
    </SectionWrap>
  );
}

function MarketplaceBlock({ data, site, businessId }) {
  const [items, setItems] = useState([]);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/marketplace?business_id=${businessId}`)
      .then(d => setItems(d.slice(0, data.max_items || 12)));
  }, [businessId]);
  if (items.length === 0) return null;
  return (
    <SectionWrap site={site}>
      <SectionHeading site={site}>{data.heading || 'Shop Our Store'}</SectionHeading>
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4 mt-4">
        {items.map(m => (
          <PriceCard key={m.ListingID} name={m.Title} price={m.UnitPrice}
            unit={m.UnitLabel} image={m.ImageURL} desc={m.Description}
            tags={[m.IsFeatured && 'Featured', m.IsOrganic && 'Organic', m.IsLocal && 'Local'].filter(Boolean)}
            site={site} />
        ))}
      </div>
    </SectionWrap>
  );
}

function GalleryBlock({ data, site, businessId }) {
  const [items, setItems] = useState([]);
  const [lightbox, setLightbox] = useState(null);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/gallery?business_id=${businessId}`)
      .then(setItems);
  }, [businessId]);
  if (items.length === 0) return null;
  const cols = data.columns || 3;
  return (
    <SectionWrap site={site} alt>
      <SectionHeading site={site}>{data.heading || 'Gallery'}</SectionHeading>
      <div className={`grid gap-3 mt-4`} style={{ gridTemplateColumns: `repeat(${cols}, 1fr)` }}>
        {items.map(g => (
          <div key={g.GalleryID} onClick={() => setLightbox(g)}
            style={{ cursor: 'pointer', borderRadius: 10, overflow: 'hidden', aspectRatio: '1', position: 'relative' }}>
            <img src={g.GalleryImage} alt={g.GalleryCaption || ''} style={{ width: '100%', height: '100%', objectFit: 'cover', transition: 'transform 0.3s' }}
              onMouseEnter={e => e.currentTarget.style.transform = 'scale(1.05)'}
              onMouseLeave={e => e.currentTarget.style.transform = 'scale(1)'} />
          </div>
        ))}
      </div>
      {lightbox && (
        <div onClick={() => setLightbox(null)} style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.85)', zIndex: 9999, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '2rem', cursor: 'pointer' }}>
          <img src={lightbox.GalleryImage} alt={lightbox.GalleryCaption || ''} style={{ maxWidth: '90vw', maxHeight: '90vh', borderRadius: 8, boxShadow: '0 20px 60px rgba(0,0,0,0.5)' }} />
          {lightbox.GalleryCaption && <p style={{ position: 'absolute', bottom: '1.5rem', color: '#fff', fontSize: '0.9rem', background: 'rgba(0,0,0,0.5)', padding: '6px 16px', borderRadius: 20 }}>{lightbox.GalleryCaption}</p>}
        </div>
      )}
    </SectionWrap>
  );
}

function BlogBlock({ data, site, businessId }) {
  const [posts, setPosts] = useState([]);
  useEffect(() => {
    fetchContent(`${API}/api/website/content/blog?business_id=${businessId}`)
      .then(d => setPosts(d.slice(0, data.max_posts || 3)));
  }, [businessId]);
  if (posts.length === 0) return null;
  return (
    <SectionWrap site={site}>
      <SectionHeading site={site}>{data.heading || 'From the Blog'}</SectionHeading>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5 mt-4">
        {posts.map(p => (
          <div key={p.BlogID} style={{ background: '#fff', borderRadius: 14, overflow: 'hidden', boxShadow: '0 2px 12px rgba(0,0,0,0.07)' }}>
            {p.BlogImage1 && <img src={p.BlogImage1} alt="" style={{ width: '100%', height: 160, objectFit: 'cover' }} />}
            <div style={{ padding: '1rem' }}>
              <div style={{ fontSize: '0.72rem', color: '#9CA3AF', marginBottom: 4 }}>
                {[p.BlogMonth, p.BlogDay, p.BlogYear].filter(Boolean).join('/')}
                {p.Author && ` · ${p.Author}`}
              </div>
              <div style={{ fontWeight: 700, fontSize: '0.95rem', color: site.text_color, fontFamily: site.font_family, lineHeight: 1.3 }}>{p.BlogHeadline}</div>
              {p.BlogText1 && <p style={{ fontSize: '0.8rem', color: '#6B7280', marginTop: 6, lineHeight: 1.5 }}>{p.BlogText1?.slice(0, 150)}…</p>}
            </div>
          </div>
        ))}
      </div>
    </SectionWrap>
  );
}

function ContactBlock({ data, site }) {
  const [form, setForm] = useState({ name: '', email: '', message: '' });
  const [sent, setSent] = useState(false);
  return (
    <SectionWrap site={site} alt>
      <div className="max-w-2xl mx-auto">
        <SectionHeading site={site} centered>{data.heading || 'Get In Touch'}</SectionHeading>
        {data.custom_message && <p style={{ color: '#6B7280', textAlign: 'center', marginBottom: '1.5rem', fontFamily: site.font_family }}>{data.custom_message}</p>}
        {/* Contact info */}
        <div className="flex flex-wrap gap-6 justify-center mb-6 text-sm text-gray-600">
          {site.phone && <span>📞 {site.phone}</span>}
          {site.email && <a href={`mailto:${site.email}`} style={{ color: site.primary_color }}>✉️ {site.email}</a>}
          {site.address && <span>📍 {site.address}</span>}
        </div>
        {/* Social */}
        <div className="flex gap-4 justify-center mb-6">
          {site.facebook_url && <a href={site.facebook_url} target="_blank" rel="noreferrer" style={{ color: site.primary_color, textDecoration: 'none', fontSize: '0.85rem', fontWeight: 600 }}>Facebook</a>}
          {site.instagram_url && <a href={site.instagram_url} target="_blank" rel="noreferrer" style={{ color: site.primary_color, textDecoration: 'none', fontSize: '0.85rem', fontWeight: 600 }}>Instagram</a>}
          {site.twitter_url && <a href={site.twitter_url} target="_blank" rel="noreferrer" style={{ color: site.primary_color, textDecoration: 'none', fontSize: '0.85rem', fontWeight: 600 }}>X / Twitter</a>}
        </div>
        {/* Contact form */}
        {data.show_form && !sent && (
          <form onSubmit={e => { e.preventDefault(); setSent(true); }}
            style={{ background: '#fff', borderRadius: 16, padding: '1.5rem', boxShadow: '0 4px 20px rgba(0,0,0,0.08)' }}>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-3">
              <input required placeholder="Your name" value={form.name} onChange={e => setForm(p => ({ ...p, name: e.target.value }))}
                style={{ border: '1px solid #E5E7EB', borderRadius: 8, padding: '0.6rem 0.9rem', fontSize: '0.9rem', width: '100%' }} />
              <input required type="email" placeholder="Email address" value={form.email} onChange={e => setForm(p => ({ ...p, email: e.target.value }))}
                style={{ border: '1px solid #E5E7EB', borderRadius: 8, padding: '0.6rem 0.9rem', fontSize: '0.9rem', width: '100%' }} />
            </div>
            <textarea required placeholder="Your message" value={form.message} onChange={e => setForm(p => ({ ...p, message: e.target.value }))}
              style={{ border: '1px solid #E5E7EB', borderRadius: 8, padding: '0.6rem 0.9rem', fontSize: '0.9rem', width: '100%', minHeight: 100, resize: 'vertical', marginBottom: '0.75rem' }} />
            <button type="submit" style={{ background: site.primary_color, color: '#fff', fontWeight: 700, padding: '0.7rem 2rem', borderRadius: 8, border: 0, cursor: 'pointer', fontSize: '0.9rem', width: '100%' }}>
              Send Message
            </button>
          </form>
        )}
        {sent && (
          <div style={{ textAlign: 'center', padding: '2rem', background: '#F0FDF4', borderRadius: 16, color: '#15803D', fontWeight: 600 }}>
            Thank you! Your message has been received.
          </div>
        )}
      </div>
    </SectionWrap>
  );
}

function DividerBlock({ data }) {
  return <div style={{ height: data.height || 40 }} />;
}

// ── Shared layout components ──────────────────────────────────────
function SectionWrap({ children, site, alt }) {
  const bgColor = alt ? (site.bg_color === '#FFFFFF' ? '#F9FAFB' : site.bg_color + 'ee') : site.bg_color;
  const bgWidth = site.body_bg_width || '100%';
  const textWidth = site.body_content_width || '100%';
  return (
    <div style={{ display: 'flex', justifyContent: 'center' }}>
      <section style={{ width: '100%', maxWidth: bgWidth, padding: '5px 1.5rem', background: bgColor }}>
        <div style={{ maxWidth: textWidth, margin: '0 auto' }}>{children}</div>
      </section>
    </div>
  );
}
function SectionHeading({ children, html, site, centered }) {
  const style = {
    fontSize: site.h2_size || 'clamp(1.5rem, 3vw, 2.2rem)',
    fontWeight: site.h2_weight || 800,
    color: site.h2_color || site.text_color,
    fontFamily: site.font_family,
    marginTop: (site.h2_margin_top ?? 0) + 'px',
    marginBottom: (site.h2_margin_bottom ?? 8) + 'px',
    textAlign: centered ? 'center' : (site.h2_align || 'left'),
    textDecoration: site.h2_underline ? 'underline' : 'none',
  };
  if (html !== undefined) return <h2 style={style} dangerouslySetInnerHTML={{ __html: html }} />;
  return <h2 style={style}>{children}</h2>;
}
function BodyText({ children, html, site }) {
  const style = {
    color: site.body_color || '#4B5563',
    lineHeight: site.body_line_height || 1.75,
    fontSize: site.body_size || '1rem',
    fontFamily: site.font_family,
    marginTop: (site.body_margin_top ?? 0) + 'px',
    marginBottom: (site.body_margin_bottom ?? 12) + 'px',
  };
  if (html !== undefined) return <div className="site-rte" style={style} dangerouslySetInnerHTML={{ __html: html }} />;
  return <p style={{ ...style, whiteSpace: 'pre-wrap' }}>{children}</p>;
}
function PriceCard({ icon, name, price, unit, image, desc, tags, site }) {
  return (
    <div style={{ background: '#fff', borderRadius: 12, overflow: 'hidden', boxShadow: '0 2px 10px rgba(0,0,0,0.07)' }}>
      {image
        ? <img src={image} alt={name} style={{ width: '100%', height: 130, objectFit: 'cover' }} />
        : <div style={{ height: 80, background: `${site.primary_color}18`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem' }}>{icon || '📦'}</div>
      }
      <div style={{ padding: '0.75rem' }}>
        <div style={{ fontWeight: 700, fontSize: '0.85rem', color: site.text_color, fontFamily: site.font_family, lineHeight: 1.3 }}>{name}</div>
        {desc && <p style={{ fontSize: '0.72rem', color: '#9CA3AF', marginTop: 3, lineHeight: 1.4 }}>{desc?.slice(0, 80)}</p>}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 6, flexWrap: 'wrap', gap: 4 }}>
          {price != null && <span style={{ fontWeight: 700, color: site.primary_color, fontSize: '0.9rem' }}>${Number(price).toFixed(2)}{unit ? ` / ${unit}` : ''}</span>}
          {tags?.length > 0 && (
            <div style={{ display: 'flex', gap: 3, flexWrap: 'wrap' }}>
              {tags.map(t => <span key={t} style={{ background: site.accent_color + '44', color: '#78350F', fontSize: '0.65rem', fontWeight: 600, borderRadius: 10, padding: '1px 7px' }}>{t}</span>)}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

// ── Block dispatcher ──────────────────────────────────────────────
function RenderBlock({ block, site, businessId }) {
  const { block_type: type, block_data: data } = block;
  switch (type) {
    case 'hero':           return <HeroBlock data={data} site={site} />;
    case 'about':          return <AboutBlock data={data} site={site} />;
    case 'content':        return <ContentBlock data={data} site={site} />;
    case 'livestock':
    case 'studs':          return <LivestockBlock data={data} site={site} businessId={businessId} />;
    case 'produce':        return <ProduceBlock data={data} site={site} businessId={businessId} />;
    case 'meat':           return <MeatBlock data={data} site={site} businessId={businessId} />;
    case 'processed_food': return <ProcessedFoodBlock data={data} site={site} businessId={businessId} />;
    case 'services':       return <ServicesBlock data={data} site={site} businessId={businessId} />;
    case 'marketplace':    return <MarketplaceBlock data={data} site={site} businessId={businessId} />;
    case 'gallery':        return <GalleryBlock data={data} site={site} businessId={businessId} />;
    case 'blog':           return <BlogBlock data={data} site={site} businessId={businessId} />;
    case 'contact':        return <ContactBlock data={data} site={site} />;
    case 'divider':        return <DividerBlock data={data} />;
    default:               return null;
  }
}

// ── Main public site renderer ─────────────────────────────────────
export default function WebsitePublic() {
  const { slug } = useParams();
  const [searchParams] = useSearchParams();
  const isPreview = searchParams.get('preview') === '1';

  const [siteData, setSiteData] = useState(null);
  const [activePage, setActivePage] = useState(null);
  const [loading, setLoading] = useState(true);
  const [mobileMenu, setMobileMenu] = useState(false);

  useEffect(() => {
    fetch(`${API}/api/website/bundle/${slug}`)
      .then(r => {
        if (!r.ok) throw new Error('Site not found');
        return r.json();
      })
      .then(data => {
        setSiteData(data);
        const home = data.pages.find(p => p.is_home_page) || data.pages[0];
        setActivePage(home);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, [slug]);

  if (loading) return (
    <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', fontFamily: 'Inter, sans-serif', color: '#6B7280' }}>
      Loading…
    </div>
  );

  if (!siteData) return (
    <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', flexDirection: 'column', gap: '1rem', fontFamily: 'Inter, sans-serif' }}>
      <div style={{ fontSize: '3rem' }}>🌾</div>
      <h1 style={{ fontSize: '1.5rem', fontWeight: 700, color: '#111827' }}>Site Not Found</h1>
      <p style={{ color: '#6B7280' }}>No site exists at this address.</p>
    </div>
  );

  if (!siteData.is_published && !isPreview) return (
    <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', flexDirection: 'column', gap: '1rem', fontFamily: 'Inter, sans-serif' }}>
      <div style={{ fontSize: '3rem' }}>🚧</div>
      <h1 style={{ fontSize: '1.5rem', fontWeight: 700, color: '#111827' }}>Coming Soon</h1>
      <p style={{ color: '#6B7280' }}>This site is not yet published.</p>
    </div>
  );

  const site = siteData;
  const pages = siteData.pages || [];

  const pageBg = site.bg_image_url
    ? `url(${site.bg_image_url}) center/cover no-repeat fixed`
    : (site.bg_gradient || site.bg_color || '#fff');

  // Inject typography margin CSS for rich-text blocks (dangerouslySetInnerHTML)
  const typographyCss = `
    .site-rte h1 { margin-top:${site.h1_margin_top??0}px; margin-bottom:${site.h1_margin_bottom??8}px; }
    .site-rte h2 { margin-top:${site.h2_margin_top??0}px; margin-bottom:${site.h2_margin_bottom??8}px; }
    .site-rte h3 { margin-top:${site.h3_margin_top??0}px; margin-bottom:${site.h3_margin_bottom??6}px; }
    .site-rte h4 { margin-top:${site.h4_margin_top??0}px; margin-bottom:${site.h4_margin_bottom??4}px; }
    .site-rte p  { margin-top:${site.body_margin_top??0}px; margin-bottom:${site.body_margin_bottom??12}px; }
    ${buildPublicRteTypoCss(site)}
  `;

  return (
    <div style={{ minHeight: '100vh', background: pageBg, fontFamily: site.font_family }}>
      <style dangerouslySetInnerHTML={{ __html: typographyCss }} />
      {/* Preview banner */}
      {isPreview && (
        <div style={{ background: '#1E3A5F', color: '#fff', textAlign: 'center', padding: '0.5rem', fontSize: '0.8rem', fontFamily: 'Inter, sans-serif' }}>
          Preview Mode — <strong>Not Published</strong>
        </div>
      )}

      {/* ── Site Header (3 zones) ── */}
      <header style={{ position: 'sticky', top: 0, zIndex: 100, fontFamily: site.font_family, display: 'flex', justifyContent: 'center', background: 'transparent' }}>
        {/* Background band — only this div carries the color, constrained to header_bg_width */}
        <div style={{ width: '100%', maxWidth: site.header_bg_width || '100%', display: 'flex', flexDirection: 'column', alignItems: 'center', background: site.primary_color || '#3D6B34' }}>

          {/* Zone 1: Top bar */}
          {site.top_bar_enabled && site.top_bar_html && (
            <div style={{
              width: '100%', maxWidth: site.header_content_width || '100%',
              background: site.top_bar_bg_color || '#f8f5ef',
              padding: '5px 1.5rem', textAlign: site.top_bar_align || 'right',
            }}>
              <span style={{ fontSize: 13, color: site.top_bar_text_color || '#333' }}
                dangerouslySetInnerHTML={{ __html: site.top_bar_html }} />
            </div>
          )}

          {/* Zone 2: Header banner — image+logo constrained to header_content_width */}
          {(site.header_banner_url || site.logo_url || site.show_site_name !== false) && (
            <div style={{
              width: '100%', maxWidth: site.header_content_width || '100%',
              position: 'relative',
            }}>
              {site.header_banner_url ? (
                <img src={site.header_banner_url} alt=""
                  style={{ width: '100%', display: 'block' }} />
              ) : (
                <div style={{ height: site.header_height || 120, background: site.primary_color || '#3D6B34' }} />
              )}
              <div style={{
                position: 'absolute', top: 0, left: 0, right: 0, bottom: 0,
                display: 'flex', alignItems: 'center', padding: '0 1.5rem', gap: '1rem',
              }}>
                {site.logo_url && (
                  <img src={site.logo_url} alt="logo" style={{
                    height: Math.min((site.header_height || 120) * 0.55, 90),
                    objectFit: 'contain', borderRadius: 4,
                  }} />
                )}
                {site.show_site_name !== false && (
                  <span style={{
                    fontWeight: 800, color: site.nav_text_color || '#fff',
                    fontSize: 'clamp(1.1rem, 2.5vw, 1.8rem)',
                    textShadow: site.header_banner_url ? '1px 2px 6px rgba(0,0,0,0.55)' : 'none',
                  }}>{site.site_name}</span>
                )}
              </div>
            </div>
          )}

          {/* Zone 3: Nav bar — constrained to header_content_width */}
          <nav style={{
            width: '100%', maxWidth: site.header_content_width || '100%',
            background: site.nav_bg_image_url
              ? `url(${site.nav_bg_image_url}) center/cover no-repeat`
              : (site.primary_color || '#3D6B34'),
            boxShadow: '0 2px 16px rgba(0,0,0,0.15)',
          }}>
            <div style={{
              padding: '0 1.5rem',
              display: 'flex', alignItems: 'center', justifyContent: 'space-between', height: 50,
            }}>
              {/* Desktop nav links */}
              <div className="hidden md:flex items-center gap-1">
                {pages.map(p => (
                  <button key={p.page_id} onClick={() => { setActivePage(p); setMobileMenu(false); }}
                    style={{ background: activePage?.page_id === p.page_id ? 'rgba(255,255,255,0.2)' : 'none', border: 0, color: site.nav_text_color || '#fff', padding: '0.4rem 0.9rem', borderRadius: 8, fontWeight: activePage?.page_id === p.page_id ? 700 : 500, cursor: 'pointer', fontSize: '0.9rem', fontFamily: site.font_family, transition: 'background 0.2s' }}>
                    {p.page_name}
                  </button>
                ))}
              </div>
              {/* Mobile: site name + hamburger */}
              <button onClick={() => { setActivePage(pages.find(p => p.is_home_page) || pages[0]); setMobileMenu(false); }}
                className="md:hidden"
                style={{ fontWeight: 800, color: site.nav_text_color || '#fff', background: 'none', border: 0, cursor: 'pointer', fontSize: '1rem' }}>
                {site.site_name}
              </button>
              <button onClick={() => setMobileMenu(!mobileMenu)} className="md:hidden" style={{ background: 'none', border: 0, color: site.nav_text_color || '#fff', cursor: 'pointer', fontSize: '1.4rem' }}>
                {mobileMenu ? '✕' : '☰'}
              </button>
            </div>
            {/* Mobile dropdown */}
            {mobileMenu && (
              <div style={{ background: site.secondary_color || site.primary_color, padding: '0.5rem 1.5rem 1rem' }}>
                {pages.map(p => (
                  <button key={p.page_id} onClick={() => { setActivePage(p); setMobileMenu(false); }}
                    style={{ display: 'block', width: '100%', textAlign: 'left', background: 'none', border: 0, color: site.nav_text_color || '#fff', padding: '0.6rem 0', fontWeight: activePage?.page_id === p.page_id ? 700 : 400, cursor: 'pointer', fontSize: '1rem', fontFamily: site.font_family, borderBottom: '1px solid rgba(255,255,255,0.1)' }}>
                    {p.page_name}
                  </button>
                ))}
              </div>
            )}
          </nav>
        </div>
      </header>

      {/* Page content — CSS Grid with col_span support */}
      {activePage && (() => {
        // Group consecutive half/third blocks into grid rows; full-width blocks get their own row
        const rows = [];
        let currentRow = [];
        activePage.blocks.forEach(block => {
          const span = block.block_data?.col_span || 'full';
          if (span === 'full') {
            if (currentRow.length > 0) { rows.push(currentRow); currentRow = []; }
            rows.push([block]);
          } else {
            currentRow.push(block);
            const totalSpan = currentRow.reduce((acc, b) => {
              const s = b.block_data?.col_span || 'full';
              return acc + (s === 'third' ? 1 : 2); // half=2/3cols, third=1/3col (out of 3)
            }, 0);
            if (totalSpan >= 3) { rows.push(currentRow); currentRow = []; }
          }
        });
        if (currentRow.length > 0) rows.push(currentRow);

        return rows.map((row, ri) => {
          if (row.length === 1 && (!row[0].block_data?.col_span || row[0].block_data.col_span === 'full')) {
            return <RenderBlock key={row[0].block_id} block={row[0]} site={site} businessId={site.business_id} />;
          }
          return (
            <div key={ri} style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '1rem', maxWidth: site.body_content_width || '100%', margin: '0 auto', padding: '0 1rem' }}>
              {row.map(block => {
                const span = block.block_data?.col_span || 'full';
                const colSpan = span === 'third' ? 1 : 2;
                return (
                  <div key={block.block_id} style={{ gridColumn: `span ${colSpan}` }}>
                    <RenderBlock block={block} site={site} businessId={site.business_id} />
                  </div>
                );
              })}
            </div>
          );
        });
      })()}

      {/* Footer — outer band at footer_bg_width, inner content at footer_content_width */}
      <footer style={{ display: 'flex', justifyContent: 'center', background: 'transparent', fontFamily: site.font_family }}>
        {/* Background band — only this div carries the color, constrained to footer_bg_width */}
        <div style={{ width: '100%', maxWidth: site.footer_bg_width || '100%', position: 'relative', background: site.footer_bg_color || site.primary_color }}>
          {site.footer_bg_image_url ? (
            <img src={site.footer_bg_image_url} alt=""
              style={{ width: '100%', display: 'block' }} />
          ) : (
            <div style={{ minHeight: site.footer_height || 200, background: site.footer_bg_color || site.primary_color }} />
          )}
          <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, color: 'rgba(255,255,255,0.9)' }}>
            {/* Inner content constrained to footer_content_width */}
            <div style={{ maxWidth: site.footer_content_width || '100%', margin: '0 auto' }}>
              {site.footer_html ? (
                <div style={{ padding: '2rem 1.5rem', color: '#fff', lineHeight: 1.7 }}
                  dangerouslySetInnerHTML={{ __html: site.footer_html }} />
              ) : null}
              <div style={{ borderTop: '1px solid rgba(255,255,255,0.15)', background: 'rgba(0,0,0,0.18)', padding: '0.5rem 1.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <span style={{ fontSize: '0.72rem', color: 'rgba(255,255,255,0.65)' }}>
                  {site.copyright_text || `© ${new Date().getFullYear()} ${site.site_name}`}
                </span>
                <span style={{ fontSize: '0.68rem', color: 'rgba(255,255,255,0.4)' }}>Powered by Oatmeal Farm Network</span>
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
