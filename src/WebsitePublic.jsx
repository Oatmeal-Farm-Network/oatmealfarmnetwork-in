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

// ── Blog content helpers ─────────────────────────────────────────
function blogExcerpt(content, wordLimit = 30) {
  if (!content) return '';
  let text = content;
  try {
    const blocks = JSON.parse(content);
    if (Array.isArray(blocks))
      text = blocks.filter(b => b.type === 'text').map(b => b.content || '').join(' ');
  } catch {}
  const plain = text.replace(/<[^>]*>/g, '').trim();
  const words = plain.split(/\s+/);
  if (words.length <= wordLimit) return plain;
  return words.slice(0, wordLimit).join(' ') + '…';
}

function blogCoverImage(post) {
  if (post.cover_image) return post.cover_image;
  try {
    const blocks = JSON.parse(post.content || '');
    if (Array.isArray(blocks)) {
      const img = blocks.find(b => b.type === 'image' && b.url);
      if (img) return img.url;
    }
  } catch {}
  return null;
}

function renderBlogContent(content) {
  if (!content) return null;
  let blocks;
  try {
    blocks = JSON.parse(content);
    if (!Array.isArray(blocks)) throw new Error();
  } catch {
    return <div style={{ fontSize: '1rem', color: '#1f2937', lineHeight: 1.8, wordBreak: 'break-word' }} dangerouslySetInnerHTML={{ __html: content }} />;
  }
  return (
    <>
      {blocks.map((block, i) => {
        if (block.type === 'image') {
          return (
            <figure key={i} style={{ margin: '1.75rem 0', textAlign: block.align || 'center' }}>
              <img src={block.url} alt={block.caption || ''} style={{ width: block.width || '100%', maxWidth: '100%', borderRadius: 10, display: 'inline-block', objectFit: 'contain' }} onError={e => e.target.style.display = 'none'} />
              {block.caption && <figcaption style={{ fontSize: '0.85rem', color: '#6b7280', marginTop: '0.4rem', fontStyle: 'italic' }}>{block.caption}</figcaption>}
            </figure>
          );
        }
        return <div key={i} style={{ fontSize: '1rem', color: '#1f2937', lineHeight: 1.8, wordBreak: 'break-word', marginBottom: '0.5rem' }} dangerouslySetInnerHTML={{ __html: block.content || '' }} />;
      })}
    </>
  );
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

// ── Dropdown nav item with hover state ───────────────────────────
function DropdownItem({ label, active, navColor, hoverColor, fontFamily, onClick }) {
  const [hovered, setHovered] = useState(false);
  return (
    <button
      onClick={onClick}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      style={{
        display: 'block', width: '100%', textAlign: 'left',
        background: active || hovered ? hoverColor : 'none',
        border: 0, borderBottom: '1px solid rgba(255,255,255,0.08)',
        color: navColor, padding: '0.65rem 1rem',
        fontWeight: active ? 700 : 400, cursor: 'pointer',
        fontSize: '0.87rem', fontFamily,
        transition: 'background 0.15s',
      }}
    >{label}</button>
  );
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
        paddingTop: 10,
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

// Normalize images to {url, wrap, w} — handles new format and old position/x fields
const POS_DEFAULTS_PUB = { right:{wrap:'right',w:38}, left:{wrap:'left',w:38}, center:{wrap:'center',w:60}, full:{wrap:'full',w:100}, top:{wrap:'center',w:50}, bottom:{wrap:'right',w:38} };
function normImages(data) {
  const topCaption = data.image_caption || '';
  const raw = Array.isArray(data.images) && data.images.length > 0
    ? data.images
    : (data.image_url ? [data.image_url] : []);
  return raw.map(img => {
    if (typeof img === 'string') {
      const pos = data.image_position || 'right';
      const defaults = POS_DEFAULTS_PUB[pos] || POS_DEFAULTS_PUB.right;
      const w = data.image_width || defaults.w;
      return { url: img, ...defaults, w, caption: topCaption };
    }
    const caption = img.caption || topCaption;
    if (!img.wrap && typeof img.x === 'number') return { wrap: img.x < 50 ? 'left' : 'right', w: img.w || 38, y: img.y || 0, url: img.url, caption };
    if (!img.wrap && img.position) { const pos = img.position || 'right'; return { url: img.url, ...(POS_DEFAULTS_PUB[pos] || POS_DEFAULTS_PUB.right), caption }; }
    return { y: 0, ...img, caption };
  });
}

function figureWrapStyle(img, shadow) {
  const w  = `${Math.min(90, img.w || 38)}%`;
  const mt = `${img.y || 0}%`;
  const sh = shadow ? { boxShadow: '0 4px 20px rgba(0,0,0,0.12)' } : {};
  const base = { margin: 0, padding: 0, borderRadius: 12, overflow: 'hidden', ...sh };
  switch (img.wrap || 'right') {
    case 'left':   return { ...base, float:'left',  width:w, marginTop:mt, marginRight:'1.5rem', marginBottom:'1rem' };
    case 'right':  return { ...base, float:'right', width:w, marginTop:mt, marginLeft:'1.5rem',  marginBottom:'1rem' };
    case 'center': return { ...base, display:'block', width:w, marginTop:mt, marginLeft:'auto', marginRight:'auto', marginBottom:'1rem', clear:'both' };
    case 'full':   return { ...base, display:'block', width:'100%', marginTop:mt, marginBottom:'1rem', clear:'both' };
    default:       return { ...base, float:'right', width:w, marginTop:mt, marginLeft:'1.5rem', marginBottom:'1rem' };
  }
}

function BlockImage({ img, shadow }) {
  const hasCaption = img.caption && img.caption.trim();
  return (
    <figure style={figureWrapStyle(img, shadow)}>
      <img
        src={img.url}
        alt={img.caption || ''}
        style={{
          display: 'block',
          width: '100%',
          borderRadius: 12,
        }}
      />
      {hasCaption && (
        <figcaption style={{
          color: '#6b7280',
          fontSize: '0.8rem',
          textAlign: 'center',
          padding: '5px 10px',
          lineHeight: 1.4,
        }}>
          {img.caption}
        </figcaption>
      )}
    </figure>
  );
}

const stripHtml = html => html?.replace(/<[^>]*>/g, '').trim() || '';

// Ensure every <a> tag opens in a new tab
const addLinkTargets = html =>
  html ? html.replace(/<a\b([^>]*)>/gi, (_, attrs) => {
    const clean = attrs
      .replace(/\btarget\s*=\s*["'][^"']*["']/gi, '')
      .replace(/\brel\s*=\s*["'][^"']*["']/gi, '');
    return `<a${clean} target="_blank" rel="noopener noreferrer">`;
  }) : html;

function AboutBlock({ data, site }) {
  const imgs       = normImages(data);
  const hasHeading = !!data.heading?.trim();
  const hasBody    = !!stripHtml(data.body);
  if (!hasHeading && !hasBody && imgs.length === 0) return null;
  return (
    <SectionWrap site={site} blockBgColor={data.bg_color || undefined}>
      <div style={{ overflow: 'hidden' }}>
        {imgs.map((img, i) => <BlockImage key={i} img={img} shadow={true} />)}
        {hasHeading && <SectionHeading html={data.heading} site={site} headingStyle={data.heading_style || 'h2'} />}
        {hasBody && <BodyText html={data.body} site={site} />}
        <div style={{ clear: 'both' }} />
      </div>
    </SectionWrap>
  );
}

function ContentBlock({ data, site }) {
  const imgs       = normImages(data);
  const hasHeading = !!data.heading?.trim();
  const hasBody    = !!stripHtml(data.body);
  if (!hasHeading && !hasBody && imgs.length === 0) return null;

  // Use flexbox layout (matching editor) for a single side image (left/right).
  // data.image_width is authoritative (set by the editor's resize handle);
  // fall back to img0.w (from normImages/d.images) then to 38.
  const img0   = imgs[0];
  const isSide = img0 && (img0.wrap === 'left' || img0.wrap === 'right');

  if (isSide && (hasHeading || hasBody)) {
    const flexDir  = img0.wrap === 'left' ? 'row' : 'row-reverse';
    const wPct     = data.image_width ?? img0.w ?? 38;
    const imgW     = `${Math.min(90, wPct)}%`;
    const imgUrl   = data.image_url || img0.url;
    const caption  = data.image_caption || img0.caption || '';
    const otherImgs = imgs.slice(1);
    return (
      <SectionWrap site={site} blockBgColor={data.bg_color || undefined}>
        <div style={{ display: 'flex', flexDirection: flexDir, gap: '2rem', alignItems: 'flex-start' }}>
          <div style={{ width: imgW, flexShrink: 0 }}>
            <img src={imgUrl} alt={caption} style={{ width: '100%', display: 'block', borderRadius: 8 }} />
            {caption && (
              <p style={{ fontSize: '0.78rem', color: '#6b7280', fontStyle: 'italic', textAlign: 'center', margin: '4px 0 0' }}>{caption}</p>
            )}
          </div>
          <div style={{ flex: 1, minWidth: 0, overflow: 'hidden' }}>
            {otherImgs.map((img, i) => <BlockImage key={i} img={img} shadow={false} />)}
            {hasHeading && <SectionHeading html={data.heading} site={site} headingStyle={data.heading_style || 'h2'} />}
            {hasBody && <BodyText html={data.body} site={site} />}
            <div style={{ clear: 'both' }} />
          </div>
        </div>
      </SectionWrap>
    );
  }

  return (
    <SectionWrap site={site} blockBgColor={data.bg_color || undefined}>
      <div style={{ overflow: 'hidden' }}>
        {imgs.map((img, i) => <BlockImage key={i} img={img} shadow={false} />)}
        {hasHeading && <SectionHeading html={data.heading} site={site} headingStyle={data.heading_style || 'h2'} />}
        {hasBody && <BodyText html={data.body} site={site} />}
        <div style={{ clear: 'both' }} />
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
  const [selectedIdx, setSelectedIdx] = useState(null);
  const maxPosts = data.max_posts || 100;
  const filterCategory = data.category || '';

  useEffect(() => {
    const params = new URLSearchParams({ business_id: businessId, limit: maxPosts });
    if (filterCategory) params.set('category_name', filterCategory);
    fetchContent(`${API}/api/blog/posts?${params}`)
      .then(d => setPosts(Array.isArray(d) ? d : []))
      .catch(() => {
        fetchContent(`${API}/api/website/content/blog?business_id=${businessId}`)
          .then(d => setPosts((Array.isArray(d) ? d : []).slice(0, maxPosts).map(p => ({
            post_id: null, title: p.BlogHeadline, excerpt: p.BlogText1?.slice(0, 150),
            cover_image: p.BlogImage1,
            created_at: p.BlogYear ? `${p.BlogYear}-${String(p.BlogMonth||1).padStart(2,'0')}-${String(p.BlogDay||1).padStart(2,'0')}` : null,
            business_name: null,
          }))));
      });
  }, [businessId, filterCategory, maxPosts]);

  if (posts.length === 0) return null;

  const linkColor = site.link_color || site.accent_color || site.primary_color || '#2563eb';
  const heading   = data.heading || (data.category || 'From the Blog');
  const headingStyle = data.heading_style || 'h1';

  const bodyFont   = site.font_family || 'inherit';
  const bodySize   = site.body_size   || '1rem';
  const bodyColor  = site.body_color  || site.text_color || '#1f2937';
  const navLinkStyle = (disabled) => ({
    background: 'none', border: 'none', padding: 0, cursor: disabled ? 'default' : 'pointer',
    fontFamily: bodyFont, fontSize: bodySize, color: disabled ? 'transparent' : linkColor,
    opacity: disabled ? 0 : 1, pointerEvents: disabled ? 'none' : 'auto',
  });

  // ── Detail view ─────────────────────────────────────────────────
  if (selectedIdx !== null) {
    const p = posts[selectedIdx];
    const dateStr = (p.published_at || p.created_at)
      ? new Date(p.published_at || p.created_at).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })
      : '';
    const cover = blogCoverImage(p);
    return (
      <SectionWrap site={site} blockBgColor={data.bg_color || undefined}>
        {/* Back link — upper left */}
        <div style={{ display: 'flex', justifyContent: 'flex-start', marginBottom: '1rem' }}>
          <button style={navLinkStyle(false)} onClick={() => setSelectedIdx(null)}>← Back to {heading}</button>
        </div>

        {/* Article */}
        <article style={{ maxWidth: 760, margin: '0 auto' }}>
          {cover && (
            <img src={cover} alt={p.title} style={{ width: '100%', maxHeight: 380, objectFit: 'cover', borderRadius: 12, display: 'block', marginBottom: '1.5rem' }} onError={e => e.target.style.display = 'none'} />
          )}
          <div style={{ fontSize: '0.8rem', color: '#9ca3af', marginBottom: '0.5rem' }}>
            {dateStr}{p.business_name && ` · ${p.business_name}`}
          </div>
          <h2 style={{ margin: '0 0 1.25rem', fontSize: '1.6rem', fontWeight: 800, color: site.text_color || '#111827', fontFamily: bodyFont, lineHeight: 1.25 }}>
            {p.title}
          </h2>
          <div style={{ paddingTop: '0.5rem', borderTop: '1px solid #e5e7eb' }}>
            {renderBlogContent(p.content)}
          </div>
        </article>

        {/* Bottom nav — plain text arrows */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '2.5rem', paddingTop: '1.25rem', borderTop: '1px solid #e5e7eb' }}>
          <button style={navLinkStyle(selectedIdx === 0)} onClick={() => setSelectedIdx(selectedIdx - 1)}>← Previous</button>
          <button style={navLinkStyle(selectedIdx === posts.length - 1)} onClick={() => setSelectedIdx(selectedIdx + 1)}>Next →</button>
        </div>
      </SectionWrap>
    );
  }

  // ── List view ────────────────────────────────────────────────────
  return (
    <SectionWrap site={site} blockBgColor={data.bg_color || undefined}>
      <SectionHeading site={site} headingStyle={headingStyle}>{heading}</SectionHeading>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem', marginTop: '1.5rem' }}>
        {posts.map((p, i) => {
          const dateStr = (p.published_at || p.created_at) ? new Date(p.published_at || p.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : '';
          const cover = blogCoverImage(p);
          const excerpt = p.excerpt || blogExcerpt(p.content, 100);
          return (
            <div key={p.post_id || i}
              onClick={() => setSelectedIdx(i)}
              style={{ background: '#fff', borderRadius: 12, overflow: 'hidden', boxShadow: '0 2px 10px rgba(0,0,0,0.06)', display: 'flex', cursor: 'pointer', transition: 'box-shadow 0.15s' }}
              onMouseEnter={e => e.currentTarget.style.boxShadow = '0 4px 18px rgba(0,0,0,0.11)'}
              onMouseLeave={e => e.currentTarget.style.boxShadow = '0 2px 10px rgba(0,0,0,0.06)'}
            >
              {cover && (
                <img src={cover} alt="" style={{ width: 180, minWidth: 180, objectFit: 'cover', flexShrink: 0, display: 'block' }} onError={e => e.target.style.display = 'none'} />
              )}
              <div style={{ padding: '1.1rem 1.25rem', display: 'flex', flexDirection: 'column', gap: '0.3rem', flex: 1 }}>
                <div style={{ fontSize: '0.75rem', color: '#9CA3AF' }}>
                  {dateStr}{p.business_name && ` · ${p.business_name}`}
                </div>
                <div style={{ fontWeight: 700, fontSize: '1rem', color: site.text_color || '#111827', fontFamily: site.font_family, lineHeight: 1.35 }}>{p.title}</div>
                {excerpt && <p style={{ margin: 0, fontSize: '0.88rem', color: '#4B5563', lineHeight: 1.6 }}>{excerpt}</p>}
                <div style={{ marginTop: 'auto', paddingTop: '0.5rem', fontSize: '0.83rem', color: linkColor, fontWeight: 600 }}>
                  Read more →
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </SectionWrap>
  );
}

const CONTACT_API = import.meta.env.VITE_API_URL;

const contactInp = { border: '1px solid #E5E7EB', borderRadius: 8, padding: '0.6rem 0.9rem', fontSize: '0.9rem', width: '100%', boxSizing: 'border-box' };
const contactLbl = { display: 'block', fontSize: '0.78rem', fontWeight: 600, color: '#9CA3AF', marginBottom: 4, textTransform: 'lowercase' };

function ContactBlock({ data, site }) {
  const [form, setForm] = useState({ first_name: '', last_name: '', email: '', phone: '', organization: '', message: '' });
  const [sent, setSent] = useState(false);
  const [sending, setSending] = useState(false);

  const handleSubmit = async e => {
    e.preventDefault();
    setSending(true);
    const toEmail = data.contact_email || site.email || 'livestockoftheworld@gmail.com';
    try {
      await fetch(`${CONTACT_API}/api/website/contact-form`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, to_email: toEmail, site_name: site.site_name }),
      });
    } catch {}
    setSent(true);
    setSending(false);
  };

  return (
    <SectionWrap site={site} alt>
      <div style={{ maxWidth: 680, margin: '0 auto' }}>
        <SectionHeading site={site} centered>{data.heading || 'Get In Touch'}</SectionHeading>
        {data.sub_heading && (
          <p style={{ color: '#6B7280', textAlign: 'center', marginBottom: '1.5rem', fontFamily: site.font_family, lineHeight: 1.7 }}>
            {data.sub_heading}
          </p>
        )}
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
        {data.show_form !== false && !sent && (
          <form onSubmit={handleSubmit}
            style={{ background: '#fff', borderRadius: 16, padding: '1.5rem', boxShadow: '0 4px 20px rgba(0,0,0,0.08)', display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.75rem' }}>
              <div>
                <label style={contactLbl}>first name</label>
                <input required placeholder="First name" value={form.first_name} onChange={e => setForm(p => ({ ...p, first_name: e.target.value }))} style={contactInp} />
              </div>
              <div>
                <label style={contactLbl}>last name</label>
                <input required placeholder="Last name" value={form.last_name} onChange={e => setForm(p => ({ ...p, last_name: e.target.value }))} style={contactInp} />
              </div>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.75rem' }}>
              <div>
                <label style={contactLbl}>email</label>
                <input required type="email" placeholder="Email address" value={form.email} onChange={e => setForm(p => ({ ...p, email: e.target.value }))} style={contactInp} />
              </div>
              <div>
                <label style={contactLbl}>phone number <span style={{ fontWeight: 400 }}>(optional)</span></label>
                <input type="tel" placeholder="Phone number" value={form.phone} onChange={e => setForm(p => ({ ...p, phone: e.target.value }))} style={contactInp} />
              </div>
            </div>
            <div>
              <label style={contactLbl}>organization <span style={{ fontWeight: 400 }}>(optional)</span></label>
              <input placeholder="Organization" value={form.organization} onChange={e => setForm(p => ({ ...p, organization: e.target.value }))} style={contactInp} />
            </div>
            <div>
              <label style={contactLbl}>message</label>
              <textarea required placeholder="Your message" value={form.message} onChange={e => setForm(p => ({ ...p, message: e.target.value }))}
                style={{ ...contactInp, minHeight: 110, resize: 'vertical' }} />
            </div>
            <button type="submit" disabled={sending}
              style={{ background: site.primary_color, color: '#fff', fontWeight: 700, padding: '0.7rem 2rem', borderRadius: 8, border: 0, cursor: sending ? 'not-allowed' : 'pointer', fontSize: '0.9rem', opacity: sending ? 0.7 : 1 }}>
              {sending ? 'Sending…' : 'Send Message'}
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

function normLinksGroups(data) {
  if (Array.isArray(data.groups) && data.groups.length > 0) return data.groups;
  if (Array.isArray(data.items)  && data.items.length  > 0) return [{ heading: '', items: data.items }];
  return [];
}

function LinksBlock({ data, site }) {
  const groups    = normLinksGroups(data);
  const cols      = data.columns || 3;
  if (groups.length === 0) return null;
  const linkColor = site.link_color || site.accent_color || '#2563eb';
  const linkUline = site.link_underline !== false;
  const bodyFont  = site.body_font  || site.font_family || 'inherit';
  const bodySize  = site.body_size  || '1rem';
  const bodyColor = site.body_color || site.text_color  || '#111827';

  // Resolve H1/H2 styles from site typography settings
  const h1Size   = site.h1_size   || '2.5rem'; const h1Weight = site.h1_weight || '800';
  const h1Font   = site.h1_font   || site.font_family || 'inherit';
  const h1Color  = site.h1_color  || site.text_color  || '#111827';
  const h2Size   = site.h2_size   || '1.8rem'; const h2Weight = site.h2_weight || '700';
  const h2Font   = site.h2_font   || site.font_family || 'inherit';
  const h2Color  = site.h2_color  || site.text_color  || '#111827';

  return (
    <SectionWrap site={site}>
      {data.heading && (
        <h1 style={{ fontSize: h1Size, fontWeight: h1Weight, fontFamily: h1Font, color: h1Color, marginBottom: '1rem', lineHeight: 1.2 }}>
          {data.heading}
        </h1>
      )}
      {groups.map((group, gi) => (
        <div key={gi} style={{ marginBottom: '1.5rem' }}>
          {group.heading && (
            <h2 style={{ fontSize: h2Size, fontWeight: h2Weight, fontFamily: h2Font, color: h2Color, marginBottom: '0.75rem', lineHeight: 1.3 }}>
              {group.heading}
            </h2>
          )}
          <div style={{ display: 'grid', gridTemplateColumns: `repeat(${cols}, 1fr)`, gap: '0.75rem' }}>
            {(group.items || []).map((item, i) => (
              <a
                key={i}
                href={item.url || '#'}
                target={item.url ? '_blank' : undefined}
                rel="noopener noreferrer"
                style={{
                  display: 'flex', gap: '0.6rem', alignItems: 'flex-start',
                  color: linkColor,
                  textDecoration: linkUline ? 'underline' : 'none',
                  fontFamily: bodyFont,
                  fontSize: bodySize,
                }}
              >
                {item.icon_url && (
                  <div style={{ flexShrink: 0 }}>
                    <img src={item.icon_url} alt="" style={{ width: 32, height: 32, objectFit: 'contain', borderRadius: 4 }} />
                  </div>
                )}
                <div>
                  <div dangerouslySetInnerHTML={{ __html: item.label || '' }} style={{ fontWeight: 600 }} />
                  {item.description && (
                    <div
                      dangerouslySetInnerHTML={{ __html: item.description }}
                      style={{ color: bodyColor, fontWeight: 400, marginTop: 3, lineHeight: 1.4, textDecoration: 'none' }}
                    />
                  )}
                </div>
              </a>
            ))}
          </div>
        </div>
      ))}
    </SectionWrap>
  );
}

// ── Shared layout components ──────────────────────────────────────
function SectionWrap({ children, site, alt, blockBgColor }) {
  const bgColor = blockBgColor || (alt ? (site.bg_color === '#FFFFFF' ? '#F9FAFB' : site.bg_color + 'ee') : site.bg_color);
  const bgWidth = site.body_bg_width || '100%';
  const textWidth = site.body_content_width || '100%';
  return (
    <div style={{ display: 'flex', justifyContent: 'center' }}>
      <section style={{ width: '100%', maxWidth: bgWidth, paddingTop: 10, paddingLeft: '1.5rem', paddingRight: '1.5rem', paddingBottom: 0, background: bgColor }}>
        <div style={{ maxWidth: textWidth, margin: '0 auto' }}>{children}</div>
      </section>
    </div>
  );
}
function SectionHeading({ children, html, site, centered, headingStyle }) {
  // headingStyle is h1/h2/h3/h4/p from block_data; default to h2 for data-backed blocks
  const k   = (!headingStyle || headingStyle === 'p') ? 'body' : headingStyle;
  const tag = (!headingStyle || headingStyle === 'p') ? 'p'    : headingStyle;
  const ruleclr = site[`${k}_rule_color`] || site.text_color || '#000';
  const hasRule = k !== 'body' && !!site[`${k}_rule`];
  const align   = centered ? 'center' : (site[`${k}_align`] || 'left');
  const style = {
    fontSize:       site[`${k}_size`]   || (k==='body'?'1rem':k==='h1'?'2.5rem':k==='h2'?'clamp(1.5rem,3vw,2.2rem)':k==='h3'?'1.3rem':'1.1rem'),
    fontWeight:     site[`${k}_weight`] || (k==='body'?'400':k==='h1'?'800':k==='h2'?'700':'600'),
    color:          site[`${k}_color`]  || site.text_color,
    fontFamily:     site[`${k}_font`]   || site.font_family,
    marginTop:      (site[`${k}_margin_top`]    ?? 0)  + 'px',
    marginBottom:   (site[`${k}_margin_bottom`] ?? 8)  + 'px',
    textAlign:      align,
    textDecoration: site[`${k}_underline`] ? 'underline' : 'none',
    borderBottom:   hasRule ? `2px solid ${ruleclr}` : undefined,
    paddingBottom:  hasRule ? '2px' : undefined,
  };
  const Tag = tag;
  if (html !== undefined) return <Tag style={style} dangerouslySetInnerHTML={{ __html: html }} />;
  return <Tag style={style}>{children}</Tag>;
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
  if (html !== undefined) return <div className="site-rte" style={style} dangerouslySetInnerHTML={{ __html: addLinkTargets(html) }} />;
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
    case 'links':          return <LinksBlock data={data} site={site} />;
    case 'divider':        return <DividerBlock data={data} />;
    default:               return null;
  }
}

// Hostnames that are the OFN platform itself — everything else is a custom domain
const OFN_HOSTS = ['oatmealfarmnetwork.com', 'www.oatmealfarmnetwork.com', 'localhost', '127.0.0.1'];
const isCustomDomain = !OFN_HOSTS.some(h => window.location.hostname === h || window.location.hostname.endsWith(`.${h}`));

// ── Main public site renderer ─────────────────────────────────────
export default function WebsitePublic() {
  const { slug } = useParams();
  const [searchParams] = useSearchParams();
  const isPreview = searchParams.get('preview') === '1';

  const [siteData, setSiteData] = useState(null);
  const [activePage, setActivePage] = useState(null);
  const [loading, setLoading] = useState(true);
  const [mobileMenu, setMobileMenu] = useState(false);
  const [openDropdown, setOpenDropdown] = useState(null); // page_id of open nav dropdown

  useEffect(() => {
    // On a custom domain, look up by hostname instead of URL slug so the
    // address bar keeps showing the custom domain (no redirect needed).
    const url = isCustomDomain
      ? `${API}/api/website/bundle-by-domain?domain=${encodeURIComponent(window.location.hostname)}`
      : `${API}/api/website/bundle/${slug}`;

    fetch(url)
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

  // Apply favicon from site settings
  useEffect(() => {
    if (!siteData?.favicon_url) return;
    let link = document.querySelector("link[rel~='icon']");
    if (!link) { link = document.createElement('link'); link.rel = 'icon'; document.head.appendChild(link); }
    link.href = siteData.favicon_url;
    return () => { link.href = '/favicon.ico'; };
  }, [siteData?.favicon_url]);

  // Close mobile menu when viewport widens past the md breakpoint (768px)
  useEffect(() => {
    const onResize = () => { if (window.innerWidth >= 768) setMobileMenu(false); };
    window.addEventListener('resize', onResize);
    return () => window.removeEventListener('resize', onResize);
  }, []);

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

  // Full typography CSS for .site-rte rich-text blocks (standard h1/h2/h3/h4/p tags from inline editor)
  const buildSiteRteBodyCss = () => {
    const linkColor = site.link_color || site.accent_color || '#2563eb';
    const linkUline = site.link_underline !== false;
    const linkRule  = `.site-rte a{color:${linkColor};${linkUline ? 'text-decoration:underline;' : 'text-decoration:none;'}}`;
    const liFont  = site.body_font  || site.font_family || 'inherit';
    const liSize  = site.body_size  || '1rem';
    const liColor = site.body_color || site.text_color  || 'inherit';
    const listRules = [
      `.site-rte ul{list-style:disc!important;padding-left:1.5em!important;margin:0.4em 0!important;}`,
      `.site-rte ol{list-style:decimal!important;padding-left:1.5em!important;margin:0.4em 0!important;}`,
      `.site-rte li{margin:0.2em 0;font-family:${liFont};font-size:${liSize};color:${liColor};}`,
      `.site-rte li *{font-family:inherit;font-size:inherit;color:inherit;}`,
    ].join('');
    const tagRules  = [
      ['h1','h1'],['h2','h2'],['h3','h3'],['h4','h4'],['body','p'],
    ].map(([k, tag]) => {
      const size    = site[`${k}_size`]         || (k==='body'?'1rem':k==='h1'?'2.5rem':k==='h2'?'1.8rem':k==='h3'?'1.3rem':'1.1rem');
      const weight  = site[`${k}_weight`]       || (k==='body'?'400':k==='h1'?'800':k==='h2'?'700':'600');
      const color   = site[`${k}_color`]        || site.text_color || '';
      const font    = site[`${k}_font`]         || site.font_family || '';
      const uline   = site[`${k}_underline`];
      const hasRule = k !== 'body' && site[`${k}_rule`];
      const ruleclr = site[`${k}_rule_color`]   || site.text_color || '#000';
      const align   = site[`${k}_align`]        || 'left';
      const mt      = site[`${k}_margin_top`]   ?? 0;
      const mb      = site[`${k}_margin_bottom`]?? (k === 'body' ? 12 : 8);
      let css = `font-size:${size};font-weight:${weight};margin-top:${mt}px;margin-bottom:${mb}px;`;
      if (font)    css += `font-family:${font};`;
      if (color)   css += `color:${color};`;
      if (uline)   css += `text-decoration:underline;`;
      if (hasRule) css += `border-bottom:2px solid ${ruleclr};padding-bottom:2px;`;
      if (align !== 'left') css += `text-align:${align};`;
      return `.site-rte ${tag}{${css}}`;
    }).join('\n');
    return linkRule + '\n' + listRules + '\n' + tagRules;
  };

  const typographyCss = buildSiteRteBodyCss() + '\n' + buildPublicRteTypoCss(site);

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
        <div style={{ width: '100%', maxWidth: site.header_bg_width || '100%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>

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
                <div style={{ height: site.header_height || 120, background: site.header_banner_bg_color || site.primary_color || '#3D6B34' }} />
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
          {(() => {
            const navBg = site.nav_bg_image_url
              ? `url(${site.nav_bg_image_url}) center/cover no-repeat`
              : (site.primary_color || '#3D6B34');
            const navColor = site.nav_text_color || '#fff';
            const dropdownBg = site.dropdown_bg_color2
              ? `linear-gradient(${site.dropdown_gradient_dir || '135deg'}, ${site.dropdown_bg_color || site.primary_color || '#3D6B34'}, ${site.dropdown_bg_color2})`
              : (site.dropdown_bg_color || site.primary_color || '#3D6B34');
            const dropdownHover = site.dropdown_hover_color || 'rgba(255,255,255,0.15)';
            // Build nav tree — filter unpublished pages/headings on live site
            const visiblePages = isPreview ? pages : pages.filter(p => p.is_published !== false);
            const topLevelPages = visiblePages.filter(p => !p.parent_page_id);
            const childrenOf = parentId => visiblePages.filter(p => p.parent_page_id === parentId);
            const isActiveOrChild = p => activePage?.page_id === p.page_id || childrenOf(p.page_id).some(c => c.page_id === activePage?.page_id);
            return (
              <nav style={{ width: '100%', maxWidth: site.header_content_width || '100%', background: navBg, boxShadow: '0 2px 16px rgba(0,0,0,0.15)' }}>
                <div style={{ padding: '0 1.5rem', display: 'flex', alignItems: 'center', justifyContent: 'space-between', height: 50 }}>
                  {/* Desktop nav */}
                  <div className="hidden md:flex items-center gap-1" style={{ position: 'relative' }}>
                    {topLevelPages.map(p => {
                      const children = childrenOf(p.page_id);
                      const active = isActiveOrChild(p);
                      const isHeading = p.is_nav_heading || children.length > 0;
                      if (!isHeading) {
                        return (
                          <button key={p.page_id}
                            onClick={() => { setActivePage(p); setOpenDropdown(null); }}
                            style={{ background: active ? 'rgba(255,255,255,0.2)' : 'none', border: 0, color: navColor, padding: '0.4rem 0.9rem', borderRadius: 8, fontWeight: active ? 700 : 500, cursor: 'pointer', fontSize: '0.9rem', fontFamily: site.font_family, transition: 'background 0.2s' }}>
                            {p.page_name}
                          </button>
                        );
                      }
                      return (
                        <div key={p.page_id} style={{ position: 'relative' }}
                          onMouseEnter={() => setOpenDropdown(p.page_id)}
                          onMouseLeave={() => setOpenDropdown(null)}>
                          <span
                            style={{ background: active ? 'rgba(255,255,255,0.2)' : 'none', color: navColor, padding: '0.4rem 0.9rem', borderRadius: 8, fontWeight: active ? 700 : 500, fontSize: '0.9rem', fontFamily: site.font_family, display: 'inline-flex', alignItems: 'center', gap: 6, cursor: 'default', userSelect: 'none' }}>
                            {p.page_name}
                            {children.length > 0 && <span style={{ fontSize: '1rem', lineHeight: 1, opacity: 0.9 }}>▾</span>}
                          </span>
                          {children.length > 0 && openDropdown === p.page_id && (<>
                            {/* Invisible bridge — fills gap between trigger and dropdown so onMouseLeave doesn't fire */}
                            <div style={{ position: 'absolute', top: '100%', left: 0, width: '100%', height: 8, background: 'transparent' }} />
                            <div style={{ position: 'absolute', top: 'calc(100% + 8px)', left: 0, background: dropdownBg, borderRadius: 8, boxShadow: '0 6px 24px rgba(0,0,0,0.25)', minWidth: 170, zIndex: 300, overflow: 'hidden' }}>
                              {children.map(child => (
                                <DropdownItem key={child.page_id}
                                  label={child.page_name}
                                  active={activePage?.page_id === child.page_id}
                                  navColor={navColor}
                                  hoverColor={dropdownHover}
                                  fontFamily={site.font_family}
                                  onClick={() => { setActivePage(child); setOpenDropdown(null); }}
                                />
                              ))}
                            </div>
                          </>)}
                        </div>
                      );
                    })}
                  </div>
                  {/* Mobile: site name + hamburger */}
                  <button onClick={() => { setActivePage(pages.find(p => p.is_home_page) || pages[0]); setMobileMenu(false); }}
                    className="md:hidden"
                    style={{ fontWeight: 800, color: navColor, background: 'none', border: 0, cursor: 'pointer', fontSize: '1rem' }}>
                    {site.site_name}
                  </button>
                  <button onClick={() => setMobileMenu(!mobileMenu)} className="md:hidden" style={{ background: 'none', border: 0, color: navColor, cursor: 'pointer', fontSize: '1.4rem' }}>
                    {mobileMenu ? '✕' : '☰'}
                  </button>
                </div>
                {/* Mobile menu — parents then indented children */}
                {mobileMenu && (
                  <div style={{ background: site.secondary_color || site.primary_color, padding: '0.5rem 1.5rem 1rem' }}>
                    {topLevelPages.map(p => {
                      const children = childrenOf(p.page_id);
                      const isHeading = p.is_nav_heading || children.length > 0;
                      return (
                        <React.Fragment key={p.page_id}>
                          {isHeading ? (
                            <div style={{ display: 'block', width: '100%', color: navColor, padding: '0.6rem 0 0.2rem', fontWeight: 600, fontSize: '0.75rem', fontFamily: site.font_family, opacity: 0.65, textTransform: 'uppercase', letterSpacing: '0.07em', userSelect: 'none' }}>
                              {p.page_name}
                            </div>
                          ) : (
                          <button onClick={() => { setActivePage(p); setMobileMenu(false); }}
                            style={{ display: 'block', width: '100%', textAlign: 'left', background: 'none', border: 0, color: navColor, padding: '0.6rem 0', fontWeight: isActiveOrChild(p) ? 700 : 400, cursor: 'pointer', fontSize: '1rem', fontFamily: site.font_family, borderBottom: '1px solid rgba(255,255,255,0.1)' }}>
                            {p.page_name}
                          </button>
                          )}
                          {children.map((child, ci) => (
                            <button key={child.page_id} onClick={() => { setActivePage(child); setMobileMenu(false); }}
                              style={{ display: 'block', width: '100%', textAlign: 'left', background: 'none', border: 0, color: navColor, padding: '0.45rem 0 0.45rem 1.2rem', fontWeight: activePage?.page_id === child.page_id ? 700 : 400, cursor: 'pointer', fontSize: '0.9rem', fontFamily: site.font_family, opacity: 0.85, borderBottom: ci === children.length - 1 ? '1px solid rgba(255,255,255,0.1)' : 'none' }}>
                              {child.page_name}
                            </button>
                          ))}
                        </React.Fragment>
                      );
                    })}
                  </div>
                )}
              </nav>
            );
          })()}
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
        {/* Outer band — no background; footer content and copyright each carry their own */}
        <div style={{ width: '100%', maxWidth: site.footer_bg_width || '100%' }}>
          {site.footer_bg_image_url ? (
            /* Image case: image as bg, footer content overlaid, copyright below */
            <div style={{ position: 'relative' }}>
              <img src={site.footer_bg_image_url} alt="" style={{ width: '100%', display: 'block' }} />
              <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0 }}>
                <div style={{ maxWidth: site.footer_content_width || '100%', margin: '0 auto' }}>
                  {site.footer_html ? (
                    <div style={{ padding: '2rem 1.5rem', color: '#fff', lineHeight: 1.7 }}
                      dangerouslySetInnerHTML={{ __html: site.footer_html }} />
                  ) : null}
                </div>
              </div>
              {/* Copyright bar — its own background, below the image */}
              <div style={{ background: site.copyright_bar_bg_color || 'rgba(0,0,0,0.18)' }}>
                <div style={{ maxWidth: site.footer_content_width || '100%', margin: '0 auto', padding: '0.5rem 1.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <span style={{ fontSize: '0.72rem', color: 'rgba(255,255,255,0.65)' }}>
                    {site.copyright_text || `© ${new Date().getFullYear()} ${site.site_name}`}
                  </span>
                  <a href="https://www.OatmealFarmNetwork.com" target="_blank" rel="noopener noreferrer"
                    style={{ fontSize: '0.68rem', color: 'rgba(255,255,255,0.4)', textDecoration: 'none' }}>
                    Powered by Oatmeal Farm Network
                  </a>
                </div>
              </div>
            </div>
          ) : (
            /* No image: footer content and copyright are plain block siblings — no flex needed */
            <>
              {/* Footer content area — minHeight drives the height slider */}
              <div style={{ minHeight: Number(site.footer_height) || 200, background: site.footer_bg_color || site.primary_color }}>
                <div style={{ maxWidth: site.footer_content_width || '100%', margin: '0 auto' }}>
                  {site.footer_html ? (
                    <div style={{ padding: '2rem 1.5rem', color: '#fff', lineHeight: 1.7 }}
                      dangerouslySetInnerHTML={{ __html: site.footer_html }} />
                  ) : null}
                </div>
              </div>
              {/* Copyright bar — its own independent background, always below footer content */}
              <div style={{ background: site.copyright_bar_bg_color || 'rgba(0,0,0,0.18)' }}>
                <div style={{ maxWidth: site.footer_content_width || '100%', margin: '0 auto', padding: '0.5rem 1.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <span style={{ fontSize: '0.72rem', color: 'rgba(255,255,255,0.65)' }}>
                    {site.copyright_text || `© ${new Date().getFullYear()} ${site.site_name}`}
                  </span>
                  <a href="https://www.OatmealFarmNetwork.com" target="_blank" rel="noopener noreferrer"
                    style={{ fontSize: '0.68rem', color: 'rgba(255,255,255,0.4)', textDecoration: 'none' }}>
                    Powered by Oatmeal Farm Network
                  </a>
                </div>
              </div>
            </>
          )}
        </div>
      </footer>
    </div>
  );
}
