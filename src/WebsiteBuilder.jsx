import React, { useState, useEffect, useRef, useCallback } from 'react';
import { createPortal } from 'react-dom';
import { useSearchParams, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import WebsiteAIAgent from './WebsiteAIAgent';

const API = import.meta.env.VITE_API_URL;

// ── Block type catalogue ─────────────────────────────────────────
const BLOCK_TYPES = [
  { type: 'hero',           icon: '🖼️',  label: 'Hero Banner',        desc: 'Full-width hero with image, headline & CTA' },
  { type: 'about',          icon: '🏡',  label: 'About Us',           desc: 'About section with text and image' },
  { type: 'content',        icon: '📄',  label: 'Content Block',      desc: 'Heading, text, and optional image' },
  { type: 'livestock',      icon: '🐄',  label: 'Livestock For Sale', desc: 'Animals listed for sale from your inventory' },
  { type: 'studs',          icon: '🐂',  label: 'Stud Services',      desc: 'Stud animals available for breeding' },
  { type: 'produce',        icon: '🥕',  label: 'Produce',            desc: 'Fresh produce from your inventory' },
  { type: 'meat',           icon: '🥩',  label: 'Meat',               desc: 'Meat inventory available for sale' },
  { type: 'processed_food', icon: '🫙',  label: 'Processed Foods',    desc: 'Value-added & processed food products' },
  { type: 'services',       icon: '🔧',  label: 'Services',           desc: 'Services your business offers' },
  { type: 'marketplace',    icon: '🛒',  label: 'Marketplace',        desc: 'All active marketplace listings' },
  { type: 'gallery',        icon: '🖼️',  label: 'Photo Gallery',      desc: 'Photo gallery from your albums' },
  { type: 'blog',           icon: '📝',  label: 'Blog Posts',         desc: 'Latest blog posts' },
  { type: 'contact',        icon: '📬',  label: 'Contact',            desc: 'Contact information and form' },
  { type: 'divider',        icon: '➖',  label: 'Spacer / Divider',   desc: 'Visual separator between sections' },
];

const defaultBlockData = {
  hero:           { headline: 'Welcome to Our Farm', subtext: 'Fresh, local, and sustainably grown.', image_url: '', cta_text: 'Learn More', cta_link: '#about', overlay: true, align: 'center' },
  about:          { heading: 'About Us', body: 'Tell your story here...', image_url: '', images: [], image_position: 'right' },
  content:        { heading: '', body: '', image_url: '', images: [], image_position: 'right' },
  livestock:      { heading: 'Animals For Sale', show_for_sale: true, show_studs: false, max_items: 6 },
  studs:          { heading: 'Stud Services', show_for_sale: false, show_studs: true, max_items: 6 },
  produce:        { heading: 'Fresh Produce', max_items: 8 },
  meat:           { heading: 'Meat', max_items: 8 },
  processed_food: { heading: 'Farm Products', max_items: 8 },
  services:       { heading: 'Our Services', max_items: 6 },
  marketplace:    { heading: 'Shop Our Store', max_items: 12 },
  gallery:        { heading: 'Photo Gallery', columns: 3 },
  blog:           { heading: 'From the Blog', max_posts: 3 },
  contact:        { heading: 'Get In Touch', show_form: true, custom_message: '' },
  divider:        { height: 40 },
};

// Full web-friendly font list (alphabetical)
const WEB_FONTS = [
  { label: 'Arial',              value: 'Arial, sans-serif' },
  { label: 'Bitter',             value: 'Bitter, serif' },
  { label: 'Caveat',             value: 'Caveat, cursive' },
  { label: 'Courier Prime',      value: 'Courier Prime, monospace' },
  { label: 'Crimson Text',       value: 'Crimson Text, serif' },
  { label: 'Dancing Script',     value: 'Dancing Script, cursive' },
  { label: 'DM Sans',            value: 'DM Sans, sans-serif' },
  { label: 'EB Garamond',        value: 'EB Garamond, serif' },
  { label: 'Georgia',            value: 'Georgia, serif' },
  { label: 'Inter',              value: 'Inter, sans-serif' },
  { label: 'Lato',               value: 'Lato, sans-serif' },
  { label: 'Libre Baskerville',  value: 'Libre Baskerville, serif' },
  { label: 'Lobster',            value: 'Lobster, cursive' },
  { label: 'Lora',               value: 'Lora, serif' },
  { label: 'Manrope',            value: 'Manrope, sans-serif' },
  { label: 'Merriweather',       value: 'Merriweather, serif' },
  { label: 'Montserrat',         value: 'Montserrat, sans-serif' },
  { label: 'Mulish',             value: 'Mulish, sans-serif' },
  { label: 'Noto Sans',          value: 'Noto Sans, sans-serif' },
  { label: 'Nunito',             value: 'Nunito, sans-serif' },
  { label: 'Open Sans',          value: 'Open Sans, sans-serif' },
  { label: 'Oswald',             value: 'Oswald, sans-serif' },
  { label: 'Pacifico',           value: 'Pacifico, cursive' },
  { label: 'Playfair Display',   value: 'Playfair Display, serif' },
  { label: 'Poppins',            value: 'Poppins, sans-serif' },
  { label: 'PT Sans',            value: 'PT Sans, sans-serif' },
  { label: 'PT Serif',           value: 'PT Serif, serif' },
  { label: 'Quicksand',          value: 'Quicksand, sans-serif' },
  { label: 'Raleway',            value: 'Raleway, sans-serif' },
  { label: 'Roboto',             value: 'Roboto, sans-serif' },
  { label: 'Satisfy',            value: 'Satisfy, cursive' },
  { label: 'Source Code Pro',    value: 'Source Code Pro, monospace' },
  { label: 'Source Sans Pro',    value: 'Source Sans Pro, sans-serif' },
  { label: 'Space Mono',         value: 'Space Mono, monospace' },
  { label: 'Times New Roman',    value: 'Times New Roman, serif' },
  { label: 'Ubuntu',             value: 'Ubuntu, sans-serif' },
  { label: 'Vollkorn',           value: 'Vollkorn, serif' },
  { label: 'Work Sans',          value: 'Work Sans, sans-serif' },
];

// Keep FONTS array for DesignView compatibility
const FONTS = WEB_FONTS.map(f => f.value);

const TEMPLATES = [
  { id: 'farmstead',   name: 'Farmstead',      primary_color: '#3D6B34', secondary_color: '#819360', accent_color: '#FFC567', bg_color: '#FAFAF7', text_color: '#1a2e1a', nav_text_color: '#FFFFFF', footer_bg_color: '#3D6B34', font_family: 'Georgia, serif' },
  { id: 'harvest',     name: 'Harvest',         primary_color: '#8B4513', secondary_color: '#CD853F', accent_color: '#FFD700', bg_color: '#FFF8F0', text_color: '#3d1a00', nav_text_color: '#FFFFFF', footer_bg_color: '#8B4513', font_family: 'Georgia, serif' },
  { id: 'modern',      name: 'Modern Market',   primary_color: '#1E3A5F', secondary_color: '#2E86AB', accent_color: '#A8DADC', bg_color: '#F8FAFB', text_color: '#111827', nav_text_color: '#FFFFFF', footer_bg_color: '#1E3A5F', font_family: 'Inter, sans-serif' },
  { id: 'artisan',     name: 'Artisan',         primary_color: '#6B2737', secondary_color: '#A0522D', accent_color: '#DEB887', bg_color: '#FAF6F0', text_color: '#2d1a0e', nav_text_color: '#FFFFFF', footer_bg_color: '#6B2737', font_family: 'Playfair Display, serif' },
  { id: 'fresh',       name: 'Fresh',           primary_color: '#2E7D32', secondary_color: '#66BB6A', accent_color: '#FFF176', bg_color: '#F1F8F1', text_color: '#1B5E20', nav_text_color: '#FFFFFF', footer_bg_color: '#2E7D32', font_family: 'Montserrat, sans-serif' },
  { id: 'classic',     name: 'Classic',         primary_color: '#1a237e', secondary_color: '#3949AB', accent_color: '#FFD700', bg_color: '#FFFFFF',  text_color: '#111827', nav_text_color: '#FFFFFF', footer_bg_color: '#1a237e', font_family: 'Georgia, serif' },
  { id: 'meadow',      name: 'Meadow',          primary_color: '#4A7C59', secondary_color: '#80B192', accent_color: '#F6D365', bg_color: '#F5FAF6', text_color: '#1c3325', nav_text_color: '#FFFFFF', footer_bg_color: '#4A7C59', font_family: 'Raleway, sans-serif' },
  { id: 'sunset',      name: 'Sunset Ranch',    primary_color: '#C0392B', secondary_color: '#E67E22', accent_color: '#F9CA24', bg_color: '#FFF9F5', text_color: '#2c1206', nav_text_color: '#FFFFFF', footer_bg_color: '#922B21', font_family: 'Lato, sans-serif' },
  { id: 'slate',       name: 'Slate & Stone',   primary_color: '#37474F', secondary_color: '#607D8B', accent_color: '#80CBC4', bg_color: '#F5F7F8', text_color: '#1c2b33', nav_text_color: '#FFFFFF', footer_bg_color: '#263238', font_family: 'Montserrat, sans-serif' },
  { id: 'lavender',    name: 'Lavender Field',  primary_color: '#6A4C93', secondary_color: '#9B72CF', accent_color: '#FFD6E0', bg_color: '#FAF8FF', text_color: '#2d1b4e', nav_text_color: '#FFFFFF', footer_bg_color: '#6A4C93', font_family: 'Raleway, sans-serif' },
  { id: 'coastal',     name: 'Coastal',         primary_color: '#006D77', secondary_color: '#83C5BE', accent_color: '#FFDDD2', bg_color: '#F8FFFE', text_color: '#003d44', nav_text_color: '#FFFFFF', footer_bg_color: '#004E57', font_family: 'Open Sans, sans-serif' },
  { id: 'midnight',    name: 'Midnight',        primary_color: '#1A1A2E', secondary_color: '#16213E', accent_color: '#E94560', bg_color: '#F4F4F8', text_color: '#1A1A2E', nav_text_color: '#FFFFFF', footer_bg_color: '#0F0F1A', font_family: 'Inter, sans-serif' },
];

const slugify = (s) => s.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');

function authHeaders() {
  const token = localStorage.getItem('access_token');
  return { 'Content-Type': 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) };
}
async function apiFetch(path, opts = {}) {
  const r = await fetch(`${API}${path}`, { headers: authHeaders(), ...opts });
  if (!r.ok) { const e = await r.json().catch(() => ({})); throw new Error(e.detail || 'Request failed'); }
  return r.json();
}

// ── Shared form helpers ───────────────────────────────────────────
const inp  = "w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-300";
const ta   = `${inp} resize-y min-h-[80px]`;

function FormField({ label, children }) {
  return (
    <div className="mb-4">
      <label className="block text-sm font-semibold text-gray-700 mb-1">{label}</label>
      {children}
    </div>
  );
}

// ── Image upload helper ───────────────────────────────────────────
async function uploadImageFile(file) {
  const formData = new FormData();
  formData.append('file', file);
  const token = localStorage.getItem('access_token');
  const res = await fetch(`${API}/api/website/upload-image`, {
    method: 'POST',
    headers: token ? { Authorization: `Bearer ${token}` } : {},
    body: formData,
  });
  if (!res.ok) throw new Error('Upload failed');
  const data = await res.json();
  return data.url;
}

// ── Drag-and-drop image upload field ─────────────────────────────
function ImageUploadField({ label, value, onChange, hint, compact = false }) {
  const [dragging, setDragging] = useState(false);
  const [uploading, setUploading] = useState(false);
  const inputRef = useRef(null);

  const handleFiles = useCallback(async (files) => {
    const file = files[0];
    if (!file) return;
    setUploading(true);
    try {
      const url = await uploadImageFile(file);
      onChange(url);
    } catch { alert('Image upload failed. Please try again.'); }
    finally { setUploading(false); }
  }, [onChange]);

  const onDrop = (e) => { e.preventDefault(); setDragging(false); handleFiles(e.dataTransfer.files); };

  return (
    <div>
      {label && <label className="block text-sm font-medium text-gray-700 mb-1">{label}</label>}
      {value && (
        <div className="relative inline-block mb-2">
          <img src={value} alt="" className={`rounded-lg object-cover border border-gray-200 ${compact ? 'h-12 w-20' : 'h-24 w-36'}`} />
          <button onClick={() => onChange('')}
            className="absolute -top-1.5 -right-1.5 bg-red-500 text-white rounded-full w-5 h-5 flex items-center justify-center text-xs leading-none hover:bg-red-600">×</button>
        </div>
      )}
      <div
        onDragOver={e => { e.preventDefault(); setDragging(true); }}
        onDragLeave={() => setDragging(false)}
        onDrop={onDrop}
        onClick={() => inputRef.current?.click()}
        className={`border-2 border-dashed rounded-xl text-center cursor-pointer transition-colors select-none
          ${compact ? 'py-2 px-3 text-xs' : 'py-5 px-4 text-sm'}
          ${dragging ? 'border-[#819360] bg-green-50' : 'border-gray-200 hover:border-[#819360] hover:bg-gray-50'}`}
      >
        {uploading
          ? <span className="text-gray-400 animate-pulse">Uploading…</span>
          : <span className="text-gray-400">Drop image here or <span className="text-[#3D6B34] font-medium">browse</span></span>}
        <input ref={inputRef} type="file" accept="image/*" className="hidden"
          onChange={e => handleFiles(e.target.files)} />
      </div>
      {hint && <p className="text-xs text-gray-400 mt-1">{hint}</p>}
    </div>
  );
}

// ── Header images manager ─────────────────────────────────────────
function HeaderImagesManager({ websiteId, hideTitle = false }) {
  const [images, setImages] = useState([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!websiteId) return;
    fetch(`${API}/api/website/header-images/${websiteId}`, {
      headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
    })
      .then(r => r.json())
      .then(data => setImages(Array.isArray(data) ? data : []))
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [websiteId]);

  const validate = (imgs) => {
    if (imgs.length < 2) return '';
    const sorted = [...imgs].sort((a, b) => (a.start_date || '') < (b.start_date || '') ? -1 : 1);
    for (let i = 0; i < sorted.length - 1; i++) {
      if (!sorted[i].end_date || !sorted[i + 1].start_date) continue;
      const endDate = new Date(sorted[i].end_date);
      const nextStart = new Date(sorted[i + 1].start_date);
      endDate.setDate(endDate.getDate() + 1);
      if (endDate.toDateString() !== nextStart.toDateString()) {
        return `Gap detected between "${sorted[i].end_date}" and "${sorted[i + 1].start_date}". Dates must be continuous with no gaps.`;
      }
    }
    return '';
  };

  const addImage = async (url) => {
    setSaving(true);
    try {
      const res = await fetch(`${API}/api/website/header-images`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${localStorage.getItem('access_token')}` },
        body: JSON.stringify({ website_id: websiteId, image_url: url, sort_order: images.length }),
      });
      const newImg = await res.json();
      setImages(prev => [...prev, newImg]);
    } finally { setSaving(false); }
  };

  const updateImage = async (id, field, value) => {
    const updated = images.map(img => img.header_image_id === id ? { ...img, [field]: value } : img);
    setImages(updated);
    const err = validate(updated);
    setError(err);
    if (!err) {
      await fetch(`${API}/api/website/header-images/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${localStorage.getItem('access_token')}` },
        body: JSON.stringify({ [field]: value }),
      });
    }
  };

  const deleteImage = async (id) => {
    await fetch(`${API}/api/website/header-images/${id}`, {
      method: 'DELETE',
      headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
    });
    const updated = images.filter(img => img.header_image_id !== id);
    setImages(updated);
    setError(validate(updated));
  };

  const sorted = [...images].sort((a, b) => (a.start_date || '') < (b.start_date || '') ? -1 : 1);

  return (
    <div>
      {!hideTitle && <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Header Images</h3>}
      <p className="text-xs text-gray-400 mb-3">
        Upload one or more banner images. If using multiple, assign start/end dates with no gaps between them.
      </p>
      {error && (
        <div className="mb-3 bg-amber-50 border border-amber-300 text-amber-700 rounded-lg px-3 py-2 text-xs">{error}</div>
      )}
      {loading ? (
        <p className="text-xs text-gray-400">Loading…</p>
      ) : (
        <div className="space-y-3 mb-3">
          {sorted.map((img) => (
            <div key={img.header_image_id} className="border border-gray-100 rounded-xl p-3 bg-gray-50">
              <div className="flex items-start gap-3">
                {img.image_url && (
                  <img src={img.image_url} alt="" className="w-20 h-12 object-cover rounded-lg border border-gray-200 shrink-0" />
                )}
                <div className="flex-1 min-w-0 space-y-2">
                  <div className="flex gap-2">
                    <div className="flex-1">
                      <label className="block text-xs text-gray-500 mb-0.5">Start Date {images.length > 1 ? '' : <span className="text-gray-300">(Optional)</span>}</label>
                      <input type="date" value={img.start_date || ''} className="w-full border border-gray-200 rounded-lg px-2 py-1 text-xs"
                        onChange={e => updateImage(img.header_image_id, 'start_date', e.target.value)} />
                    </div>
                    <div className="flex-1">
                      <label className="block text-xs text-gray-500 mb-0.5">End Date {images.length > 1 ? '' : <span className="text-gray-300">(Optional)</span>}</label>
                      <input type="date" value={img.end_date || ''} className="w-full border border-gray-200 rounded-lg px-2 py-1 text-xs"
                        onChange={e => updateImage(img.header_image_id, 'end_date', e.target.value)} />
                    </div>
                  </div>
                </div>
                <button onClick={() => deleteImage(img.header_image_id)}
                  className="shrink-0 text-red-400 hover:text-red-600 text-lg leading-none mt-0.5">×</button>
              </div>
              <div className="mt-2">
                <ImageUploadField compact value={img.image_url} onChange={url => updateImage(img.header_image_id, 'image_url', url)} />
              </div>
            </div>
          ))}
        </div>
      )}
      <ImageUploadField
        hint="Upload to add another header image"
        value=""
        onChange={url => url && addImage(url)}
      />
    </div>
  );
}

// ══════════════════════════════════════════════════════════════════
// WYSIWYG CANVAS COMPONENTS
// ══════════════════════════════════════════════════════════════════

// ── PaletteColorPicker: swatch grid + custom color input ─────────
// paletteColors: array of hex strings from the active site theme
// onColor: (hexColor) => void
// dark: boolean — use dark toolbar styling
function PaletteColorPicker({ paletteColors = [], onColor, dark = false }) {
  const [open, setOpen] = useState(false);
  const [custom, setCustom] = useState('#000000');
  const ref = useRef(null);

  // Standard web-safe-ish swatches (6 cols × 6 rows)
  const SWATCHES = [
    '#000000','#434343','#666666','#999999','#b7b7b7','#ffffff',
    '#ff0000','#ff4444','#ff9900','#ffff00','#00ff00','#00ffff',
    '#0000ff','#9900ff','#ff00ff','#ff99cc','#f6b26b','#ffd966',
    '#93c47d','#76a5af','#6fa8dc','#8e7cc3','#c27ba0','#e06666',
    '#cc0000','#e69138','#f1c232','#6aa84f','#45818e','#3d85c8',
    '#674ea7','#a61c00','#85200c','#7f6000','#274e13','#0c343d',
  ];

  useEffect(() => {
    if (!open) return;
    const close = (e) => { if (ref.current && !ref.current.contains(e.target)) setOpen(false); };
    document.addEventListener('mousedown', close);
    return () => document.removeEventListener('mousedown', close);
  }, [open]);

  const pick = (hex) => { onColor(hex); setOpen(false); };

  const bg     = dark ? '#2d2d3e' : '#fff';
  const border = dark ? '#444'    : '#d1d5db';
  const text   = dark ? '#e2e8f0' : '#111827';

  return (
    <div ref={ref} style={{ position: 'relative', display: 'inline-flex', alignItems: 'center' }}>
      {/* Trigger button: coloured "A" */}
      <button
        onMouseDown={e => { e.preventDefault(); setOpen(p => !p); }}
        title="Text color"
        style={{
          height: 26, minWidth: 26, padding: '0 5px',
          border: `1px solid ${border}`, borderRadius: 4,
          background: bg, cursor: 'pointer',
          display: 'flex', alignItems: 'center', gap: 3,
          color: custom, fontWeight: 700, fontSize: 13,
        }}
      >
        A<span style={{ display: 'block', width: 12, height: 3, background: custom, borderRadius: 1 }} />
      </button>

      {open && (
        <div
          style={{
            position: 'absolute', top: '110%', left: 0, zIndex: 99999,
            background: '#fff', border: '1px solid #d1d5db',
            borderRadius: 10, padding: 10,
            boxShadow: '0 8px 32px rgba(0,0,0,0.18)',
            width: 220,
          }}
          onMouseDown={e => e.preventDefault()}
        >
          {/* Palette colors from the active theme */}
          {paletteColors.length > 0 && (
            <>
              <div style={{ fontSize: 10, fontWeight: 600, color: '#6b7280', marginBottom: 5 }}>Site Palette</div>
              <div style={{ display: 'flex', gap: 5, marginBottom: 8, flexWrap: 'wrap' }}>
                {paletteColors.map(c => (
                  <button key={c} onMouseDown={() => { pick(c); setCustom(c); }}
                    title={c}
                    style={{ width: 22, height: 22, borderRadius: 4, background: c, border: '2px solid #e5e7eb', cursor: 'pointer', padding: 0 }} />
                ))}
              </div>
              <div style={{ height: 1, background: '#e5e7eb', margin: '6px 0' }} />
            </>
          )}

          {/* Standard swatches */}
          <div style={{ fontSize: 10, fontWeight: 600, color: '#6b7280', marginBottom: 5 }}>Standard Colors</div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(6, 1fr)', gap: 3, marginBottom: 8 }}>
            {SWATCHES.map(c => (
              <button key={c} onMouseDown={() => { pick(c); setCustom(c); }}
                title={c}
                style={{ width: '100%', aspectRatio: '1', borderRadius: 3, background: c, border: '1px solid rgba(0,0,0,0.1)', cursor: 'pointer', padding: 0 }} />
            ))}
          </div>

          <div style={{ height: 1, background: '#e5e7eb', margin: '6px 0' }} />

          {/* Custom color */}
          <div style={{ fontSize: 10, fontWeight: 600, color: '#6b7280', marginBottom: 5 }}>Custom Color</div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
            <input
              type="color"
              value={custom}
              onChange={e => setCustom(e.target.value)}
              style={{ width: 32, height: 32, border: '1px solid #d1d5db', borderRadius: 4, cursor: 'pointer', padding: 1 }}
            />
            <input
              type="text"
              value={custom}
              maxLength={7}
              onChange={e => { if (/^#[0-9a-fA-F]{0,6}$/.test(e.target.value)) setCustom(e.target.value); }}
              style={{ flex: 1, border: '1px solid #d1d5db', borderRadius: 4, padding: '4px 6px', fontSize: 12, fontFamily: 'monospace' }}
            />
            <button
              onMouseDown={() => { if (/^#[0-9a-fA-F]{6}$/.test(custom)) pick(custom); }}
              style={{ padding: '4px 8px', background: '#3D6B34', color: '#fff', border: 'none', borderRadius: 4, cursor: 'pointer', fontSize: 11, fontWeight: 600 }}
            >
              Apply
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

// ── InlineColorPicker: swatch button that opens palette popup ────────
function InlineColorPicker({ value, onChange, paletteColors = [], popupAlign = 'left' }) {
  const [open, setOpen] = useState(false);
  const [custom, setCustom] = useState(value || '#ffffff');
  const ref = useRef(null);

  const SWATCHES = [
    '#000000','#434343','#666666','#999999','#b7b7b7','#ffffff',
    '#ff0000','#ff4444','#ff9900','#ffff00','#00ff00','#00ffff',
    '#0000ff','#9900ff','#ff00ff','#ff99cc','#f6b26b','#ffd966',
    '#93c47d','#76a5af','#6fa8dc','#8e7cc3','#c27ba0','#e06666',
    '#cc0000','#e69138','#f1c232','#6aa84f','#45818e','#3d85c8',
    '#674ea7','#a61c00','#85200c','#7f6000','#274e13','#0c343d',
  ];

  useEffect(() => {
    if (!open) return;
    const close = (e) => { if (ref.current && !ref.current.contains(e.target)) setOpen(false); };
    document.addEventListener('mousedown', close);
    return () => document.removeEventListener('mousedown', close);
  }, [open]);

  const pick = (hex) => { onChange(hex); setCustom(hex); setOpen(false); };

  return (
    <div ref={ref} style={{ position: 'relative', display: 'inline-flex', alignItems: 'center', gap: 8 }}>
      <button
        onClick={() => setOpen(p => !p)}
        title={value}
        style={{ width: 36, height: 36, background: value || '#ffffff', border: '2px solid #e5e7eb', borderRadius: 8, cursor: 'pointer', boxShadow: '0 1px 4px rgba(0,0,0,0.12)', flexShrink: 0 }}
      />
      <input
        type="text" value={value || ''} maxLength={7}
        onChange={e => { if (/^#[0-9a-fA-F]{0,6}$/.test(e.target.value)) onChange(e.target.value); }}
        style={{ width: 76, border: '1px solid #e5e7eb', borderRadius: 6, padding: '4px 7px', fontSize: 12, fontFamily: 'monospace', color: '#374151' }}
      />
      {open && (
        <div style={{ position: 'absolute', top: '110%', ...(popupAlign === 'right' ? { right: 0 } : { left: 0 }), zIndex: 99999, background: '#fff', border: '1px solid #d1d5db', borderRadius: 10, padding: 10, boxShadow: '0 8px 32px rgba(0,0,0,0.18)', width: 220 }}
          onMouseDown={e => e.preventDefault()}>
          {paletteColors.length > 0 && (
            <>
              <div style={{ fontSize: 10, fontWeight: 600, color: '#6b7280', marginBottom: 5 }}>Site Palette</div>
              <div style={{ display: 'flex', gap: 5, marginBottom: 8, flexWrap: 'wrap' }}>
                {paletteColors.map(c => (
                  <button key={c} onMouseDown={() => pick(c)} title={c}
                    style={{ width: 22, height: 22, borderRadius: 4, background: c, border: '2px solid #e5e7eb', cursor: 'pointer', padding: 0 }} />
                ))}
              </div>
              <div style={{ height: 1, background: '#e5e7eb', margin: '6px 0' }} />
            </>
          )}
          <div style={{ fontSize: 10, fontWeight: 600, color: '#6b7280', marginBottom: 5 }}>Standard Colors</div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(6, 1fr)', gap: 3, marginBottom: 8 }}>
            {SWATCHES.map(c => (
              <button key={c} onMouseDown={() => pick(c)} title={c}
                style={{ width: '100%', aspectRatio: '1', borderRadius: 3, background: c, border: '1px solid rgba(0,0,0,0.1)', cursor: 'pointer', padding: 0 }} />
            ))}
          </div>
          <div style={{ height: 1, background: '#e5e7eb', margin: '6px 0' }} />
          <div style={{ fontSize: 10, fontWeight: 600, color: '#6b7280', marginBottom: 5 }}>Custom Color</div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
            <input type="color" value={custom} onChange={e => setCustom(e.target.value)}
              style={{ width: 32, height: 32, border: '1px solid #d1d5db', borderRadius: 4, cursor: 'pointer', padding: 1 }} />
            <input type="text" value={custom} maxLength={7}
              onChange={e => { if (/^#[0-9a-fA-F]{0,6}$/.test(e.target.value)) setCustom(e.target.value); }}
              style={{ flex: 1, border: '1px solid #d1d5db', borderRadius: 4, padding: '4px 6px', fontSize: 12, fontFamily: 'monospace' }} />
            <button onMouseDown={() => { if (/^#[0-9a-fA-F]{6}$/.test(custom)) pick(custom); }}
              style={{ padding: '4px 8px', background: '#3D6B34', color: '#fff', border: 'none', borderRadius: 4, cursor: 'pointer', fontSize: 11, fontWeight: 600 }}>
              Apply
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

// ── FontPickerDropdown: custom dropdown where each option renders in its own font ──
// globalFont: when set, adds a "(global)" entry at top; undefined = omit that entry (for transient pickers)
function FontPickerDropdown({ value, onChange, globalFont, dark = false, label = 'Font…' }) {
  const [open, setOpen] = useState(false);
  const btnRef = useRef(null);
  const [dropPos, setDropPos] = useState({ top: 0, left: 0 });

  const displayFont  = value || globalFont || 'inherit';
  const displayLabel = value
    ? (WEB_FONTS.find(f => f.value === value)?.label || value.split(',')[0].trim())
    : globalFont
      ? globalFont.split(',')[0].trim()
      : label;

  const openDropdown = (e) => {
    e.preventDefault();
    e.stopPropagation();
    if (btnRef.current) {
      const rect = btnRef.current.getBoundingClientRect();
      setDropPos({ top: rect.bottom + 4, left: rect.left });
    }
    setOpen(o => !o);
  };

  useEffect(() => {
    if (!open) return;
    const close = (e) => { if (!btnRef.current?.contains(e.target)) setOpen(false); };
    document.addEventListener('mousedown', close);
    return () => document.removeEventListener('mousedown', close);
  }, [open]);

  return (
    <>
      <button
        ref={btnRef}
        onMouseDown={openDropdown}
        title={displayLabel}
        style={{
          fontFamily: displayFont,
          background: dark ? '#2d2d3e' : '#fff',
          color: dark ? '#e2e8f0' : '#374151',
          border: dark ? 'none' : '1px solid #e5e7eb',
          borderRadius: 4,
          fontSize: dark ? 11 : 12,
          padding: '3px 6px',
          cursor: 'pointer',
          maxWidth: dark ? 120 : 150,
          minWidth: dark ? 70 : 90,
          overflow: 'hidden',
          textOverflow: 'ellipsis',
          whiteSpace: 'nowrap',
          textAlign: 'left',
        }}
      >
        {displayLabel} ▾
      </button>
      {open && createPortal(
        <div
          onMouseDown={e => e.stopPropagation()}
          style={{
            position: 'fixed',
            top: dropPos.top,
            left: dropPos.left,
            zIndex: 999999,
            background: dark ? '#1e1e2e' : '#fff',
            border: dark ? '1px solid #555' : '1px solid #e5e7eb',
            borderRadius: 6,
            boxShadow: '0 6px 24px rgba(0,0,0,0.28)',
            maxHeight: 300,
            overflowY: 'auto',
            minWidth: 200,
          }}
        >
          {globalFont !== undefined && (
            <div
              onMouseDown={e => { e.preventDefault(); e.stopPropagation(); onChange(''); setOpen(false); }}
              style={{
                fontFamily: globalFont || 'inherit',
                padding: '7px 14px',
                fontSize: 13,
                cursor: 'pointer',
                color: dark ? '#94a3b8' : '#6b7280',
                borderBottom: dark ? '1px solid #333' : '1px solid #f3f4f6',
                background: !value ? (dark ? '#2d2d3e' : '#f0fdf4') : 'transparent',
              }}
            >
              {globalFont ? globalFont.split(',')[0].trim() : 'Default'}
              <span style={{ fontSize: 11, opacity: 0.65, marginLeft: 6 }}>(global)</span>
            </div>
          )}
          {WEB_FONTS.map(f => (
            <div
              key={f.value}
              onMouseDown={e => { e.preventDefault(); e.stopPropagation(); onChange(f.value); setOpen(false); }}
              style={{
                fontFamily: f.value,
                padding: '7px 14px',
                fontSize: 13,
                cursor: 'pointer',
                background: value === f.value ? (dark ? '#2d2d3e' : '#f0fdf4') : 'transparent',
                color: dark ? '#e2e8f0' : '#1f2937',
              }}
            >
              {f.label}
            </div>
          ))}
        </div>,
        document.body
      )}
    </>
  );
}

// ── SimpleBlockPreview: read-only canvas preview of each block ────
function SimpleBlockPreview({ block, site }) {
  const d   = block.block_data || {};
  const bt  = block.block_type;
  const primary    = site?.primary_color  || '#3D6B34';
  const accent     = site?.accent_color   || '#FFC567';
  const textColor  = site?.text_color     || '#111827';
  const fontFamily = site?.font_family    || 'inherit';
  const bgColor    = d.bg_color || site?.bg_color || '#fff';
  const bgWidth    = site?.body_bg_width      || '100%';
  const cWidth     = site?.body_content_width || '100%';

  // Shared wrapper: outer div only centers (no bg); inner band carries the bg color up to bgWidth;
  // innermost div constrains content to cWidth — mirrors SectionWrap in WebsitePublic.jsx
  const BlockWrap = ({ children }) => (
    <div style={{ display: 'flex', justifyContent: 'center' }}>
      <div style={{ width: '100%', maxWidth: bgWidth, background: bgColor, padding: '1.75rem 2.5rem', fontFamily }}>
        <div style={{ maxWidth: cWidth, margin: '0 auto' }}>
          {children}
        </div>
      </div>
    </div>
  );

  if (bt === 'hero') {
    return (
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <div style={{
          width: '100%', maxWidth: bgWidth,
          minHeight: 220, position: 'relative', display: 'flex', alignItems: 'center',
          justifyContent: d.align === 'left' ? 'flex-start' : d.align === 'right' ? 'flex-end' : 'center',
          background: d.image_url ? `url(${d.image_url}) center/cover no-repeat` : primary,
          fontFamily,
        }}>
          {d.overlay && <div style={{ position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.42)' }} />}
          <div style={{ position: 'relative', zIndex: 1, padding: '2rem 3rem', textAlign: d.align || 'center', maxWidth: cWidth, width: '100%' }}>
            <h1 style={{ color: '#fff', fontSize: '2rem', fontWeight: 800, margin: '0 0 0.5rem', lineHeight: 1.2 }}>
              {d.headline || 'Your Headline'}
            </h1>
            {d.subtext && <p style={{ color: 'rgba(255,255,255,0.88)', fontSize: '1.05rem', margin: '0 0 1.2rem' }}>{d.subtext}</p>}
            {d.cta_text && (
              <span style={{ display: 'inline-block', background: accent, color: '#fff', padding: '0.5rem 1.5rem', borderRadius: 8, fontWeight: 700, fontSize: '0.95rem' }}>
                {d.cta_text}
              </span>
            )}
          </div>
        </div>
      </div>
    );
  }

  if (bt === 'about' || bt === 'content') {
    const imgs = Array.isArray(d.images) && d.images.length > 0 ? d.images : [];
    const rawUrl = d.image_url || (imgs[0] ? (typeof imgs[0] === 'string' ? imgs[0] : imgs[0].url) : null);
    const pos    = d.image_position || imgs[0]?.wrap || 'right';
    const isLeft = pos === 'left';
    return (
      <BlockWrap>
        <div style={{ display: 'flex', flexDirection: isLeft ? 'row' : 'row-reverse', gap: '2rem', alignItems: 'flex-start' }}>
          {rawUrl && (
            <img src={rawUrl} alt="" style={{ width: '38%', flexShrink: 0, borderRadius: 8, objectFit: 'cover', maxHeight: 220, display: 'block' }} />
          )}
          <div style={{ flex: 1, minWidth: 0 }}>
            {d.heading && <h2 style={{ color: textColor, fontWeight: 700, fontSize: '1.5rem', margin: '0 0 0.6rem' }}>{d.heading}</h2>}
            {d.body
              ? <div style={{ color: textColor, fontSize: '1rem', lineHeight: 1.7 }} dangerouslySetInnerHTML={{ __html: d.body }} />
              : !d.heading && <p style={{ color: '#9ca3af', fontStyle: 'italic', margin: 0 }}>Click to edit this block</p>}
          </div>
        </div>
      </BlockWrap>
    );
  }

  if (bt === 'divider') {
    return (
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <div style={{ width: '100%', maxWidth: bgWidth, height: d.height || 40, background: bgColor }} />
      </div>
    );
  }

  // Data-backed blocks: livestock, produce, services, etc.
  const meta = BLOCK_TYPES.find(b => b.type === bt) || { icon: '📦', label: bt };
  return (
    <BlockWrap>
      <div style={{ textAlign: 'center' }}>
        <div style={{ fontSize: '2rem', marginBottom: '0.4rem' }}>{meta.icon}</div>
        <div style={{ fontWeight: 700, fontSize: '1.1rem', color: primary, marginBottom: '0.25rem' }}>
          {d.heading || meta.label}
        </div>
        <div style={{ fontSize: '0.82rem', color: '#9ca3af' }}>
          Live data from your account will appear here on the published site.
        </div>
      </div>
    </BlockWrap>
  );
}

// ── CanvasBlock: click-to-select with ↑↓ + delete controls ────────
function CanvasBlock({ block, index, isSelected, onSelect, onDelete, onMoveUp, onMoveDown, isFirst, isLast, onDragStart, onDragOver, onDrop, isDragging, site }) {
  const meta = BLOCK_TYPES.find(b => b.type === block.block_type);
  return (
    <div
      onClick={e => { e.stopPropagation(); onSelect(block); }}
      draggable
      onDragStart={e => onDragStart(e, index)}
      onDragOver={e => { e.preventDefault(); onDragOver(e, index); }}
      onDrop={e => { e.preventDefault(); onDrop(e, index); }}
      style={{
        position: 'relative',
        outline: isSelected ? '2px solid #3b82f6' : '2px solid transparent',
        outlineOffset: -2,
        cursor: 'pointer',
        opacity: isDragging ? 0.35 : 1,
        transition: 'outline 0.1s, opacity 0.1s',
      }}
      className="canvas-block"
    >
      <SimpleBlockPreview block={block} site={site} />

      {/* Controls — always visible when selected, shown on hover via CSS */}
      <div className="block-controls" style={{
        position: 'absolute', top: 8, right: 8, display: 'flex', gap: 4, zIndex: 10,
        opacity: isSelected ? 1 : 0, transition: 'opacity 0.15s',
      }}>
        <span style={{ background: '#3b82f6', color: '#fff', fontSize: 10, fontWeight: 600, padding: '2px 7px', borderRadius: 4, alignSelf: 'center', marginRight: 4 }}>
          {meta?.label || block.block_type}
        </span>
        <button onClick={e => { e.stopPropagation(); onMoveUp(); }} disabled={isFirst}
          style={{ padding: '3px 8px', background: '#fff', border: '1px solid #e5e7eb', borderRadius: 6, cursor: isFirst ? 'default' : 'pointer', fontSize: 12, opacity: isFirst ? 0.35 : 1 }}>↑</button>
        <button onClick={e => { e.stopPropagation(); onMoveDown(); }} disabled={isLast}
          style={{ padding: '3px 8px', background: '#fff', border: '1px solid #e5e7eb', borderRadius: 6, cursor: isLast ? 'default' : 'pointer', fontSize: 12, opacity: isLast ? 0.35 : 1 }}>↓</button>
        <button onClick={e => { e.stopPropagation(); if (window.confirm('Delete this block?')) onDelete(block.block_id); }}
          style={{ padding: '3px 8px', background: '#fef2f2', color: '#dc2626', border: '1px solid #fecaca', borderRadius: 6, cursor: 'pointer', fontSize: 12 }}>🗑</button>
      </div>
      <style>{`.canvas-block:hover .block-controls { opacity: 1 !important; }`}</style>
    </div>
  );
}

// ── BlockEditorPanel: sidebar form editor for the selected block ───
function BlockEditorPanel({ block, onFieldSave, onFieldsSave, site }) {
  if (!block) return null;
  const d  = block.block_data || {};
  const bt = block.block_type;

  const paletteColors = [
    site?.primary_color, site?.secondary_color, site?.accent_color,
    site?.bg_color, site?.text_color,
  ].filter(Boolean);

  const Field = ({ label, children }) => (
    <div style={{ marginBottom: 16 }}>
      <label style={{ display: 'block', fontSize: 12, fontWeight: 600, color: '#374151', marginBottom: 5 }}>{label}</label>
      {children}
    </div>
  );

  // Uncontrolled text inputs — key ensures they remount when block changes
  const TxtInp = ({ field, placeholder = '' }) => (
    <input key={`${block.block_id}-${field}`} className={inp}
      defaultValue={d[field] || ''}
      placeholder={placeholder}
      onBlur={e => { if (e.target.value !== (d[field] || '')) onFieldSave(field, e.target.value); }}
    />
  );

  const TxtArea = ({ field, rows = 6, placeholder = '' }) => (
    <textarea key={`${block.block_id}-${field}`} className={ta} rows={rows}
      defaultValue={d[field] || ''}
      placeholder={placeholder}
      onBlur={e => { if (e.target.value !== (d[field] || '')) onFieldSave(field, e.target.value); }}
    />
  );

  const Pill = ({ label, active, onClick }) => (
    <button onClick={onClick}
      style={{
        padding: '4px 10px', borderRadius: 6, fontSize: 12, cursor: 'pointer',
        marginRight: 4, marginBottom: 4,
        border: '1px solid ' + (active ? '#3b82f6' : '#d1d5db'),
        background: active ? '#3b82f6' : '#f9fafb',
        color: active ? '#fff' : '#374151',
      }}>
      {label}
    </button>
  );

  const BgField = () => (
    <Field label="Background Color">
      <div style={{ display: 'flex', alignItems: 'center', gap: 8, flexWrap: 'wrap' }}>
        {paletteColors.map(c => (
          <button key={c} onClick={() => onFieldSave('bg_color', c)}
            style={{ width: 24, height: 24, borderRadius: 4, background: c, border: d.bg_color === c ? '2px solid #3b82f6' : '1px solid #e5e7eb', cursor: 'pointer', flexShrink: 0 }} />
        ))}
        <input type="color" value={d.bg_color || site?.bg_color || '#ffffff'}
          onChange={e => onFieldSave('bg_color', e.target.value)}
          title="Custom color"
          style={{ width: 28, height: 24, border: '1px solid #e5e7eb', borderRadius: 4, padding: 1, cursor: 'pointer' }} />
        {d.bg_color && (
          <button onClick={() => onFieldSave('bg_color', '')}
            style={{ fontSize: 11, color: '#6b7280', background: 'none', border: 'none', cursor: 'pointer', textDecoration: 'underline', padding: 0 }}>
            Reset
          </button>
        )}
      </div>
    </Field>
  );

  // ── Hero ──
  if (bt === 'hero') return (
    <div style={{ padding: 16 }}>
      <div style={{ fontWeight: 700, fontSize: 13, color: '#111827', marginBottom: 14, paddingBottom: 10, borderBottom: '1px solid #f3f4f6' }}>Hero Banner</div>
      <Field label="Headline">
        <TxtInp field="headline" placeholder="Welcome to our farm…" />
      </Field>
      <Field label="Sub-text">
        <TxtArea field="subtext" rows={3} placeholder="Fresh, local, sustainably grown." />
      </Field>
      <Field label="Button Text">
        <TxtInp field="cta_text" placeholder="Learn More" />
      </Field>
      <Field label="Button Link">
        <TxtInp field="cta_link" placeholder="#about or https://…" />
      </Field>
      <Field label="Background Image">
        <ImageUploadField value={d.image_url || ''} onChange={url => onFieldSave('image_url', url)} />
      </Field>
      <Field label="Text Alignment">
        {[['left','Left'],['center','Center'],['right','Right']].map(([v,l]) => (
          <Pill key={v} label={l} active={(d.align || 'center') === v} onClick={() => onFieldSave('align', v)} />
        ))}
      </Field>
      <Field label="Dark Overlay">
        <label style={{ display: 'flex', alignItems: 'center', gap: 8, cursor: 'pointer', fontSize: 13, color: '#374151' }}>
          <input type="checkbox" checked={!!d.overlay} onChange={e => onFieldSave('overlay', e.target.checked)}
            style={{ width: 16, height: 16, accentColor: '#3b82f6' }} />
          Show dark overlay over image
        </label>
      </Field>
      <BgField />
    </div>
  );

  // ── About / Content ──
  if (bt === 'about' || bt === 'content') {
    // Normalise image url + position from either legacy or new format
    const imgs   = Array.isArray(d.images) && d.images.length > 0 ? d.images : [];
    const imgUrl = d.image_url || (imgs[0] ? (typeof imgs[0] === 'string' ? imgs[0] : imgs[0].url) : '');
    const imgPos = d.image_position || imgs[0]?.wrap || 'right';

    const setImg = (url) => {
      onFieldsSave({ image_url: url, images: url ? [{ url, wrap: imgPos }] : [] });
    };
    const setPos = (pos) => {
      const newImages = imgs.length > 0
        ? imgs.map(im => ({ ...(typeof im === 'string' ? { url: im } : im), wrap: pos }))
        : imgUrl ? [{ url: imgUrl, wrap: pos }] : [];
      onFieldsSave({ image_position: pos, images: newImages });
    };

    return (
      <div style={{ padding: 16 }}>
        <div style={{ fontWeight: 700, fontSize: 13, color: '#111827', marginBottom: 14, paddingBottom: 10, borderBottom: '1px solid #f3f4f6' }}>
          {bt === 'about' ? 'About Block' : 'Content Block'}
        </div>
        <Field label="Heading">
          <TxtInp field="heading" placeholder="Section heading…" />
        </Field>
        <Field label="Body Text">
          <TxtArea field="body" rows={8} placeholder="Write your content here…" />
        </Field>
        <Field label="Image">
          <ImageUploadField value={imgUrl} onChange={setImg} />
        </Field>
        {imgUrl && (
          <Field label="Image Position">
            {[['right','Right ▶'],['left','◀ Left'],['center','▲ Center'],['full','⬛ Full']].map(([v,l]) => (
              <Pill key={v} label={l} active={imgPos === v} onClick={() => setPos(v)} />
            ))}
          </Field>
        )}
        <BgField />
      </div>
    );
  }

  // ── Divider ──
  if (bt === 'divider') return (
    <div style={{ padding: 16 }}>
      <div style={{ fontWeight: 700, fontSize: 13, color: '#111827', marginBottom: 14, paddingBottom: 10, borderBottom: '1px solid #f3f4f6' }}>Spacer / Divider</div>
      <Field label="Height (px)">
        <input key={`${block.block_id}-height`} type="number" className={inp} defaultValue={d.height || 40} min={8} max={400}
          onBlur={e => onFieldSave('height', Number(e.target.value))} />
      </Field>
      <BgField />
    </div>
  );

  // ── Generic data blocks ──
  const meta = BLOCK_TYPES.find(b => b.type === bt) || { icon: '📦', label: bt };
  return (
    <div style={{ padding: 16 }}>
      <div style={{ fontWeight: 700, fontSize: 13, color: '#111827', marginBottom: 4, paddingBottom: 10, borderBottom: '1px solid #f3f4f6' }}>
        {meta.icon} {meta.label}
      </div>
      <p style={{ fontSize: 11, color: '#6b7280', marginBottom: 14, lineHeight: 1.5 }}>
        This block pulls live data from your account automatically.
      </p>
      {d.heading !== undefined && (
        <Field label="Section Heading">
          <TxtInp field="heading" placeholder="Section heading…" />
        </Field>
      )}
      {d.max_items !== undefined && (
        <Field label="Max Items to Show">
          <input key={`${block.block_id}-max`} type="number" className={inp} defaultValue={d.max_items} min={1} max={50}
            onBlur={e => onFieldSave('max_items', Number(e.target.value))} />
        </Field>
      )}
      {d.max_posts !== undefined && (
        <Field label="Max Posts to Show">
          <input key={`${block.block_id}-posts`} type="number" className={inp} defaultValue={d.max_posts} min={1} max={20}
            onBlur={e => onFieldSave('max_posts', Number(e.target.value))} />
        </Field>
      )}
      <BgField />
    </div>
  );
}

// (legacy stub — kept so DesignView references compile)
function buildRteTypoCss(site) {
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
    return `.rte-editor [data-rte-style="${k}"] { ${css} }`;
  }).join('\n');
}

// (SelectionToolbar, FloatingBlockToolbar, HeroImageManager, WrapIcon, BlockImageEditor, AboutContentBlock removed — editing moved to BlockEditorPanel sidebar)

// ── getVideoInfo: YouTube / Vimeo URL parser ──────────────────────
function getVideoInfo(url) {
  if (!url) return null;
  const yt = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/)([^&\n?#]+)/);
  if (yt) return { type: 'youtube', embedUrl: `https://www.youtube.com/embed/${yt[1]}`, thumb: `https://img.youtube.com/vi/${yt[1]}/mqdefault.jpg` };
  const vm = url.match(/vimeo\.com\/(\d+)/);
  if (vm) return { type: 'vimeo', embedUrl: `https://player.vimeo.com/video/${vm[1]}`, thumb: null };
  return { type: 'file', embedUrl: url, thumb: null };
}

// ── CanvasSiteHeader: simulated site header shown in the canvas ───
function CanvasSiteHeader({ site, pages = [] }) {
  if (!site) return null;
  const headerHeight = Number(site.header_height) || 120;
  const bgW = site.header_bg_width || '100%';
  const cW  = site.header_content_width || '100%';
  // Build nav tree: top-level pages and which ones have children
  const topLevelNav = pages.filter(p => !p.parent_page_id && p.is_published !== false);
  const hasChildren = (pageId) => pages.some(p => p.parent_page_id === pageId);
  const navColor = site.nav_text_color || '#fff';
  return (
    <div style={{ display: 'flex', justifyContent: 'center', background: 'transparent', fontFamily: site.font_family }}>
      <div style={{ width: '100%', maxWidth: bgW, display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        {site.top_bar_enabled && site.top_bar_html && (
          <div style={{ width: '100%', maxWidth: cW, background: site.top_bar_bg_color || '#f8f5ef', padding: '5px 1rem', textAlign: site.top_bar_align || 'right' }}>
            <span style={{ fontSize: 12, color: site.top_bar_text_color || '#333' }}
              dangerouslySetInnerHTML={{ __html: site.top_bar_html }} />
          </div>
        )}
        {/* Banner constrained to header_content_width */}
        <div style={{ width: '100%', maxWidth: cW, position: 'relative' }}>
          {site.header_banner_url ? (
            <img src={site.header_banner_url} alt="" style={{ width: '100%', display: 'block' }} />
          ) : (
            <div style={{ height: headerHeight, background: site.header_banner_bg_color || site.primary_color || '#3D6B34' }} />
          )}
          <div style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0, display: 'flex', alignItems: 'center', padding: '0 1rem', gap: '1rem' }}>
            {site.logo_url && (
              <img src={site.logo_url} alt="" style={{ height: Math.min(headerHeight * 0.55, 80), objectFit: 'contain', borderRadius: 4 }} />
            )}
            {site.show_site_name !== false && (
              <span style={{ fontWeight: 800, color: navColor, fontSize: '1.5rem', textShadow: site.header_banner_url ? '1px 1px 4px rgba(0,0,0,0.55)' : 'none' }}>{site.site_name}</span>
            )}
          </div>
        </div>
        {/* Nav constrained to header_content_width */}
        <div style={{
          width: '100%', maxWidth: cW,
          background: site.nav_bg_image_url ? `url(${site.nav_bg_image_url}) center/cover no-repeat` : (site.primary_color || '#3D6B34'),
          padding: '0 1rem', height: 48, display: 'flex', alignItems: 'center', gap: 4,
        }}>
          {(topLevelNav.length > 0 ? topLevelNav : [{ page_name: 'Home', page_id: 0 }]).map(p => (
            <span key={p.page_id} style={{ color: navColor, fontSize: '0.85rem', fontWeight: 600, padding: '0.3rem 0.7rem', borderRadius: 6 }}>
              {p.page_name}{hasChildren(p.page_id) ? <span style={{ fontSize: '0.6rem', marginLeft: 3, opacity: 0.8 }}>▾</span> : null}
            </span>
          ))}
        </div>
      </div>
    </div>
  );
}

// ── CanvasSiteFooter: simulated site footer shown in the canvas ───
function CanvasSiteFooter({ site }) {
  if (!site) return null;
  const footerHeight = Number(site.footer_height) || 200;
  const bgW = site.footer_bg_width || '100%';
  const cW  = site.footer_content_width || '100%';
  const hasBgImg = !!site.footer_bg_image_url;
  const footerBg    = site.footer_bg_color    || site.primary_color || '#3D6B34';
  const copyrightBg = site.copyright_bar_bg_color || 'rgba(0,0,0,0.18)';

  const FooterContent = () => (
    <div style={{ background: footerBg }}>
      <div style={{ maxWidth: cW, margin: '0 auto' }}>
        {site.footer_html ? (
          <div style={{ padding: '1.5rem 1rem', color: '#fff', fontSize: '0.9rem', lineHeight: 1.6 }}
            dangerouslySetInnerHTML={{ __html: site.footer_html }} />
        ) : null}
      </div>
    </div>
  );

  const CopyrightStrip = () => (
    <div style={{ background: copyrightBg }}>
      <div style={{ maxWidth: cW, margin: '0 auto', padding: '0.6rem 1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <span style={{ fontSize: '0.72rem', color: 'rgba(255,255,255,0.65)' }}>
          {site.copyright_text || `© ${new Date().getFullYear()} ${site.site_name}`}
        </span>
        <a href="https://www.OatmealFarmNetwork.com" target="_blank" rel="noopener noreferrer"
          style={{ fontSize: '0.65rem', color: 'rgba(255,255,255,0.35)', textDecoration: 'none' }}>
          Powered by Oatmeal Farm Network
        </a>
      </div>
    </div>
  );

  return (
    <div style={{ display: 'flex', justifyContent: 'center', background: 'transparent', fontFamily: site.font_family }}>
      {/* Outer band — no background; footer content and copyright each carry their own */}
      <div style={{ width: '100%', maxWidth: bgW }}>
        {hasBgImg ? (
          /* Image case: image as bg, footer content overlaid, copyright below */
          <div style={{ position: 'relative' }}>
            <img src={site.footer_bg_image_url} alt="" style={{ width: '100%', display: 'block' }} />
            <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0 }}>
              <FooterContent />
            </div>
            <CopyrightStrip />
          </div>
        ) : (
          /* No image: plain block siblings — minHeight on footer content drives the height slider */
          <>
            <div style={{ minHeight: footerHeight, background: footerBg }}>
              <div style={{ maxWidth: cW, margin: '0 auto' }}>
                {site.footer_html ? (
                  <div style={{ padding: '1.5rem 1rem', color: '#fff', fontSize: '0.9rem', lineHeight: 1.6 }}
                    dangerouslySetInnerHTML={{ __html: site.footer_html }} />
                ) : null}
              </div>
            </div>
            <CopyrightStrip />
          </>
        )}
      </div>
    </div>
  );
}

// ── MediaPanel: localStorage-based media library ──────────────────
function MediaPanel({ siteId }) {
  const storageKey = `ofn_media_${siteId}`;
  const [items, setItems] = useState(() => {
    try { return JSON.parse(localStorage.getItem(storageKey) || '[]'); } catch { return []; }
  });
  const [uploading, setUploading] = useState(false);
  const [mediaDragging, setMediaDragging] = useState(false);
  const [videoUrl, setVideoUrl] = useState('');
  const fileRef = useRef(null);

  const save = (newItems) => {
    setItems(newItems);
    localStorage.setItem(storageKey, JSON.stringify(newItems));
  };

  const handleUpload = async (files) => {
    setUploading(true);
    const newItems = [...items];
    for (const file of Array.from(files)) {
      try {
        const url = await uploadImageFile(file);
        newItems.push({ type: 'image', url, name: file.name });
      } catch {}
    }
    save(newItems);
    setUploading(false);
  };

  const addVideo = () => {
    if (!videoUrl.trim()) return;
    const info = getVideoInfo(videoUrl);
    save([...items, { type: 'video', url: videoUrl, embedUrl: info?.embedUrl, thumb: info?.thumb, name: 'Video' }]);
    setVideoUrl('');
  };

  const deleteItem = (idx) => save(items.filter((_, i) => i !== idx));

  return (
    <div style={{ display: 'flex', flexDirection: 'column', height: '100%', overflow: 'hidden' }}>
      {/* Upload controls */}
      <div style={{ padding: '10px 12px', borderBottom: '1px solid #e5e7eb', flexShrink: 0 }}>
        <div
          onClick={() => fileRef.current?.click()}
          onDragOver={e => { e.preventDefault(); e.stopPropagation(); setMediaDragging(true); }}
          onDragLeave={() => setMediaDragging(false)}
          onDrop={e => { e.preventDefault(); e.stopPropagation(); setMediaDragging(false); handleUpload(e.dataTransfer.files); }}
          style={{ width: '100%', padding: '10px 0', borderRadius: 8, border: `1.5px dashed ${mediaDragging ? '#3b82f6' : '#bfdbfe'}`, background: mediaDragging ? '#dbeafe' : '#eff6ff', color: mediaDragging ? '#1d4ed8' : '#3b82f6', fontSize: 12, fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6, transition: 'all 0.15s', textAlign: 'center' }}>
          {uploading ? '⏳ Uploading…' : mediaDragging ? '📂 Drop images here' : '+ Upload Images or Drop Here'}
        </div>
        <input ref={fileRef} type="file" accept="image/*" multiple style={{ display: 'none' }}
          onChange={e => handleUpload(e.target.files)} />
        <div style={{ display: 'flex', gap: 6, marginTop: 8 }}>
          <input
            style={{ flex: 1, border: '1px solid #e5e7eb', borderRadius: 6, padding: '5px 8px', fontSize: 11, outline: 'none' }}
            placeholder="YouTube / Vimeo URL"
            value={videoUrl}
            onChange={e => setVideoUrl(e.target.value)}
            onKeyDown={e => e.key === 'Enter' && addVideo()} />
          <button onClick={addVideo}
            style={{ padding: '5px 10px', borderRadius: 6, background: '#f3f4f6', border: '1px solid #e5e7eb', fontSize: 11, cursor: 'pointer', color: '#374151', fontWeight: 600 }}>
            Add
          </button>
        </div>
      </div>

      {/* Media grid */}
      <div style={{ flex: 1, overflowY: 'auto', padding: 8 }}>
        {items.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '2rem 1rem', color: '#9ca3af' }}>
            <div style={{ fontSize: '2rem', marginBottom: 8 }}>🖼️</div>
            <div style={{ fontSize: 12 }}>Upload images or add videos.<br />Drag items onto blocks to add them.</div>
          </div>
        ) : (
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 6 }}>
            {items.map((item, idx) => (
              <div key={idx}
                draggable
                onDragStart={e => {
                  e.dataTransfer.setData('application/x-media-url', item.url);
                  e.dataTransfer.effectAllowed = 'copy';
                }}
                style={{ position: 'relative', borderRadius: 6, overflow: 'hidden', border: '1px solid #e5e7eb', aspectRatio: '1', background: '#f9fafb', cursor: 'grab' }}
                className="group"
              >
                {item.type === 'video' ? (
                  <div style={{ width: '100%', height: '100%', background: '#1f2937', display: 'flex', alignItems: 'center', justifyContent: 'center', position: 'relative' }}>
                    {item.thumb
                      ? <img src={item.thumb} alt="" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                      : <span style={{ fontSize: '2rem' }}>🎬</span>}
                    <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                      <div style={{ width: 28, height: 28, background: 'rgba(255,255,255,0.85)', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <span style={{ fontSize: 12, marginLeft: 2 }}>▶</span>
                      </div>
                    </div>
                  </div>
                ) : (
                  <img src={item.url} alt={item.name} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                )}
                <button onClick={() => deleteItem(idx)}
                  style={{ position: 'absolute', top: 3, right: 3, width: 18, height: 18, background: 'rgba(239,68,68,0.9)', border: 'none', borderRadius: '50%', color: '#fff', cursor: 'pointer', fontSize: 12, display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700, lineHeight: 1, opacity: 0 }}
                  className="group-hover-opacity">
                  ×
                </button>
                <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, background: 'rgba(0,0,0,0.55)', color: '#fff', fontSize: 9, padding: '2px 4px', opacity: 0, transition: 'opacity 0.15s' }}
                  className="media-label">
                  Drag to block
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* CSS for hover states */}
      <style>{`
        .group:hover .group-hover-opacity { opacity: 1 !important; }
        .group:hover .media-label { opacity: 1 !important; }
      `}</style>
    </div>
  );
}

// ══════════════════════════════════════════════════════════════════
// MAIN COMPONENT
// ══════════════════════════════════════════════════════════════════
export default function WebsiteBuilder() {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();

  const [site, setSite]             = useState(null);
  const [pages, setPages]           = useState([]);
  const [activePage, setActivePage] = useState(null);
  const [blocks, setBlocks]         = useState([]);
  const [loading, setLoading]       = useState(true);
  const [saving, setSaving]         = useState(false);
  const [setupMode, setSetupMode]   = useState(false);

  // Page sidebar UI
  const [showNewPage, setShowNewPage]         = useState(false);
  const [newPageName, setNewPageName]         = useState('');
  const [editingPageId, setEditingPageId]     = useState(null);
  const [editingPageName, setEditingPageName] = useState('');
  const [nestingPageId, setNestingPageId]     = useState(null); // page showing parent picker

  // Block picker
  const [showBlockPicker, setShowBlockPicker] = useState(false);

  // WYSIWYG canvas state
  const canvasRef     = useRef(null);
  const blocksRef     = useRef(blocks);
  useEffect(() => { blocksRef.current = blocks; }, [blocks]);

  // Inject/update CSS for [data-rte-style] spans so design changes apply live to existing styled text
  useEffect(() => {
    const css = buildRteTypoCss(site);
    let styleEl = document.getElementById('rte-typo-styles');
    if (!styleEl) {
      styleEl = document.createElement('style');
      styleEl.id = 'rte-typo-styles';
      document.head.appendChild(styleEl);
    }
    styleEl.textContent = css;
  }, [site]);

  const [selectedBlock, setSelectedBlock] = useState(null);
  const [activeTab, setActiveTab]         = useState('pages'); // 'pages' | 'blocks' | 'media'
  const [sidebarOpen, setSidebarOpen]     = useState(true);

  // Drag-to-reorder
  const dragIdx = useRef(null);
  const [draggingId, setDraggingId] = useState(null);

  // Responsive preview
  const [previewMode, setPreviewMode] = useState('desktop');

  // Setup wizard data
  const [setupData, setSetupData] = useState({
    site_name: '', slug: '', tagline: '', logo_url: '',
    primary_color:   TEMPLATES[0].primary_color,
    secondary_color: TEMPLATES[0].secondary_color,
    accent_color:    TEMPLATES[0].accent_color,
    bg_color:        TEMPLATES[0].bg_color,
    text_color:      TEMPLATES[0].text_color,
    nav_text_color:  TEMPLATES[0].nav_text_color,
    footer_bg_color: TEMPLATES[0].footer_bg_color,
    font_family:     TEMPLATES[0].font_family,
    phone: '', email: '', address: '', facebook_url: '', instagram_url: '', twitter_url: '',
  });

  const paramPage = searchParams.get('page');
  const paramView = searchParams.get('view');

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => { if (BusinessID) loadSite(); }, [BusinessID]);

  useEffect(() => {
    if (!site) return;
    if (paramView === 'design' || paramView === 'settings' || paramView === 'delete' || paramView === 'manage-pages') {
      setActivePage(paramView);
      return;
    }
    if (paramPage && pages.length > 0) {
      const target = pages.find(p => p.page_id === parseInt(paramPage));
      if (target) selectPage(target);
    }
  }, [paramPage, paramView, site]);

  const loadSite = async () => {
    setLoading(true);
    try {
      const data = await apiFetch(`/api/website/site?business_id=${BusinessID}`);
      if (!data) { setSetupMode(true); }
      else {
        setSite(data);
        await loadPages(data.website_id);
      }
    } catch { setSetupMode(true); }
    finally { setLoading(false); }
  };

  useEffect(() => {
    if (setupMode && Business) {
      setSetupData(p => ({
        ...p,
        site_name: p.site_name || Business.BusinessName || '',
        slug: p.slug || slugify(Business.BusinessName || ''),
        email: p.email || Business.BusinessEmail || '',
        phone: p.phone || Business.BusinessPhone || '',
      }));
    }
  }, [setupMode, Business]);

  const loadPages = async (websiteId) => {
    const ps = await apiFetch(`/api/website/pages?website_id=${websiteId}`);
    setPages(ps);
    if (paramView === 'design' || paramView === 'settings' || paramView === 'delete' || paramView === 'manage-pages') {
      setActivePage(paramView);
      return;
    }
    if (ps.length > 0) {
      const target = paramPage ? ps.find(p => p.page_id === parseInt(paramPage)) : null;
      const chosen = target || ps.find(p => p.is_home_page) || ps[0];
      setActivePage(chosen);
      await loadBlocks(chosen.page_id);
    } else {
      setActivePage('manage-pages');
    }
  };

  const loadBlocks = async (pageId) => {
    const bs = await apiFetch(`/api/website/blocks/${pageId}`);
    setBlocks(bs);
    setSelectedBlock(null);
  };

  const selectPage = async (page) => {
    navigate(`?BusinessID=${BusinessID}&page=${page.page_id}`, { replace: true });
    setActivePage(page);
    setBlocks([]);
    setShowBlockPicker(false);
    setSelectedBlock(null);
    await loadBlocks(page.page_id);
  };

  // ── Site creation ──────────────────────────────────────────────
  const createSite = async () => {
    setSaving(true);
    try {
      const bid = parseInt(BusinessID);
      const data = await apiFetch('/api/website/site', {
        method: 'POST',
        body: JSON.stringify({ ...setupData, business_id: bid }),
      });
      setSite(data);
      setSetupMode(false);

      const mkPage = (name, slug, isHome, order) =>
        apiFetch('/api/website/pages', { method: 'POST', body: JSON.stringify({ website_id: data.website_id, business_id: bid, page_name: name, slug, is_home_page: isHome, sort_order: order }) });
      const mkBlock = (pageId, blockType, blockData, order) =>
        apiFetch('/api/website/blocks', { method: 'POST', body: JSON.stringify({ page_id: pageId, block_type: blockType, block_data: blockData, sort_order: order }) });

      const content = await apiFetch(`/api/website/content/check?business_id=${bid}`).catch(() => ({}));
      let order = 0;

      const homePage = await mkPage('Home', 'home', true, order++);
      await mkBlock(homePage.page_id, 'hero', { headline: `Welcome to ${setupData.site_name}`, subtext: setupData.tagline || 'Fresh, local, and sustainably grown.', image_url: '', cta_text: 'Learn More', cta_link: '#about', overlay: true, align: 'center' }, 0);
      await mkBlock(homePage.page_id, 'content', { heading: 'What We Offer', body: 'We are a local farm dedicated to bringing you the finest quality produce, livestock, and products.', image_url: '', images: [], image_position: 'none' }, 1);

      const aboutPage = await mkPage('About Us', 'about', false, order++);
      await mkBlock(aboutPage.page_id, 'hero', { headline: 'About Us', subtext: `Learn more about ${setupData.site_name}`, image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
      await mkBlock(aboutPage.page_id, 'about', { heading: 'Our Story', body: 'Tell visitors who you are, where you are located, and what makes your farm special.', image_url: '', images: [], image_position: 'right' }, 1);

      if (content.livestock_for_sale) { const p = await mkPage('Livestock For Sale', 'livestock-for-sale', false, order++); await mkBlock(p.page_id, 'hero', { headline: 'Livestock For Sale', subtext: 'Browse our available animals.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0); await mkBlock(p.page_id, 'livestock', { heading: 'Animals For Sale', show_for_sale: true, show_studs: false, max_items: 12 }, 1); }
      if (content.studs) { const p = await mkPage('Stud Services', 'stud-services', false, order++); await mkBlock(p.page_id, 'hero', { headline: 'Stud Services', subtext: 'Premium breeding genetics available.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0); await mkBlock(p.page_id, 'studs', { heading: 'Stud Animals', show_for_sale: false, show_studs: true, max_items: 12 }, 1); }
      if (content.produce) { const p = await mkPage('Fresh Produce', 'produce', false, order++); await mkBlock(p.page_id, 'hero', { headline: 'Fresh Produce', subtext: 'Farm-fresh fruits and vegetables.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0); await mkBlock(p.page_id, 'produce', { heading: 'What We Grow', max_items: 20 }, 1); }
      if (content.meat) { const p = await mkPage('Meat', 'meat', false, order++); await mkBlock(p.page_id, 'hero', { headline: 'Farm-Raised Meat', subtext: 'Pasture-raised, humanely harvested.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0); await mkBlock(p.page_id, 'meat', { heading: 'Available Cuts', max_items: 20 }, 1); }
      if (content.processed_food) { const p = await mkPage('Farm Products', 'farm-products', false, order++); await mkBlock(p.page_id, 'hero', { headline: 'Farm Products', subtext: 'Handcrafted goods from our farm.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0); await mkBlock(p.page_id, 'processed_food', { heading: 'Our Products', max_items: 20 }, 1); }
      if (content.services) { const p = await mkPage('Services', 'services', false, order++); await mkBlock(p.page_id, 'hero', { headline: 'Our Services', subtext: 'See what we offer.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0); await mkBlock(p.page_id, 'services', { heading: 'What We Do', max_items: 20 }, 1); }
      if (content.marketplace) { const p = await mkPage('Shop', 'shop', false, order++); await mkBlock(p.page_id, 'hero', { headline: 'Shop Our Store', subtext: 'All of our listings in one place.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0); await mkBlock(p.page_id, 'marketplace', { heading: 'All Listings', max_items: 24 }, 1); }

      const contactPage = await mkPage('Contact Us', 'contact', false, order++);
      await mkBlock(contactPage.page_id, 'hero', { headline: 'Contact Us', subtext: "We'd love to hear from you.", image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
      await mkBlock(contactPage.page_id, 'contact', { heading: 'Get In Touch', custom_message: '', show_form: true }, 1);

      await loadPages(data.website_id);
      setActivePage('design');
    } catch (e) { alert(e.message); }
    finally { setSaving(false); }
  };

  // ── Site update ────────────────────────────────────────────────
  const saveSite = async (updates) => {
    if (!site) return;
    setSaving(true);
    try {
      const updated = await apiFetch(`/api/website/site/${site.website_id}`, { method: 'PUT', body: JSON.stringify(updates) });
      setSite(updated);
    } catch (e) { alert(e.message); }
    finally { setSaving(false); }
  };

  const togglePublish = async () => { await saveSite({ is_published: !site.is_published }); };

  const deleteSite = async () => {
    if (!site) return;
    if (!window.confirm(`Delete "${site.site_name}"? This will permanently remove the website, all pages, and all content.`)) return;
    try {
      await apiFetch(`/api/website/site/${site.website_id}`, { method: 'DELETE' });
      setSite(null); setSetupMode(true);
    } catch (e) { alert(e.message); }
  };

  // ── Page CRUD ──────────────────────────────────────────────────
  const addPage = async () => {
    if (!newPageName.trim()) return;
    setSaving(true);
    try {
      const page = await apiFetch('/api/website/pages', { method: 'POST', body: JSON.stringify({ website_id: site.website_id, business_id: parseInt(BusinessID), page_name: newPageName, slug: slugify(newPageName), sort_order: pages.length }) });
      setPages(prev => [...prev, page]);
      setShowNewPage(false);
      setNewPageName('');
      await selectPage(page);
    } catch (e) { alert(e.message); }
    finally { setSaving(false); }
  };

  const renamePage = async (pageId) => {
    if (!editingPageName.trim()) return;
    try {
      const updated = await apiFetch(`/api/website/pages/${pageId}`, { method: 'PUT', body: JSON.stringify({ page_name: editingPageName, slug: slugify(editingPageName) }) });
      setPages(prev => prev.map(p => p.page_id === pageId ? updated : p));
      if (activePage?.page_id === pageId) setActivePage(updated);
      setEditingPageId(null);
    } catch (e) { alert(e.message); }
  };

  // Set or clear parent_page_id (null = promote to top-level)
  const setPageParent = async (pageId, parentId) => {
    try {
      const updated = await apiFetch(`/api/website/pages/${pageId}`, {
        method: 'PUT',
        body: JSON.stringify({ parent_page_id: parentId }),
      });
      setPages(prev => prev.map(p => p.page_id === pageId ? updated : p));
      if (activePage?.page_id === pageId) setActivePage(updated);
    } catch (e) { alert(e.message); }
    setNestingPageId(null);
  };

  const deletePage = async (pageId) => {
    if (!confirm('Delete this page and all its blocks?')) return;
    try {
      await apiFetch(`/api/website/pages/${pageId}`, { method: 'DELETE' });
      // Remove deleted page; children get promoted to top-level by backend
      const remaining = pages
        .filter(p => p.page_id !== pageId)
        .map(p => p.parent_page_id === pageId ? { ...p, parent_page_id: null } : p);
      setPages(remaining);
      if (activePage?.page_id === pageId) {
        if (remaining.length > 0) { await selectPage(remaining.find(p => p.is_home_page) || remaining[0]); }
        else { setActivePage('manage-pages'); setBlocks([]); }
      }
    } catch (e) { alert(e.message); }
  };

  const togglePagePublished = async (page) => {
    try {
      const updated = await apiFetch(`/api/website/pages/${page.page_id}`, { method: 'PUT', body: JSON.stringify({ is_published: !page.is_published }) });
      setPages(prev => prev.map(p => p.page_id === page.page_id ? updated : p));
      if (activePage?.page_id === page.page_id) setActivePage(updated);
    } catch (e) { alert(e.message); }
  };

  // Move page within its sibling group (same parent)
  const movePage = async (pageId, direction) => {
    const page = pages.find(p => p.page_id === pageId);
    if (!page) return;
    const siblings = pages
      .filter(p => p.parent_page_id === page.parent_page_id)
      .sort((a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0));
    const idx = siblings.findIndex(p => p.page_id === pageId);
    const swapIdx = idx + direction;
    if (swapIdx < 0 || swapIdx >= siblings.length) return;
    // Swap sort_orders between the two pages
    const swapPage = siblings[swapIdx];
    const myOrder = page.sort_order ?? idx;
    const theirOrder = swapPage.sort_order ?? swapIdx;
    // Optimistic update
    setPages(prev => prev.map(p => {
      if (p.page_id === pageId) return { ...p, sort_order: theirOrder };
      if (p.page_id === swapPage.page_id) return { ...p, sort_order: myOrder };
      return p;
    }));
    try {
      await Promise.all([
        apiFetch(`/api/website/pages/${pageId}`, { method: 'PUT', body: JSON.stringify({ sort_order: theirOrder }) }),
        apiFetch(`/api/website/pages/${swapPage.page_id}`, { method: 'PUT', body: JSON.stringify({ sort_order: myOrder }) }),
      ]);
    } catch { /* best-effort, state already updated */ }
  };

  const setHomePage = async (pageId) => {
    try {
      const updated = await apiFetch(`/api/website/pages/${pageId}`, {
        method: 'PUT',
        body: JSON.stringify({ is_home_page: true }),
      });
      // Mark all others as not home page client-side
      setPages(prev => prev.map(p => p.page_id === pageId ? updated : { ...p, is_home_page: false }));
      if (activePage?.page_id === pageId) setActivePage(updated);
    } catch (e) { alert(e.message); }
  };

  // Accepts an array of page IDs in the desired order within their sibling group
  const reorderPages = async (orderedIds) => {
    // Optimistic update: assign new sort_orders 0,1,2,...
    setPages(prev => {
      const updated = [...prev];
      orderedIds.forEach((id, idx) => {
        const i = updated.findIndex(p => p.page_id === id);
        if (i !== -1) updated[i] = { ...updated[i], sort_order: idx };
      });
      return updated;
    });
    // Persist all in parallel (best-effort)
    try {
      await Promise.all(orderedIds.map((id, idx) =>
        apiFetch(`/api/website/pages/${id}`, { method: 'PUT', body: JSON.stringify({ sort_order: idx }) })
      ));
    } catch { /* state already updated */ }
  };

  const renameDirect = async (pageId, name) => {
    if (!name.trim()) return;
    try {
      const updated = await apiFetch(`/api/website/pages/${pageId}`, {
        method: 'PUT',
        body: JSON.stringify({ page_name: name.trim(), slug: slugify(name.trim()) }),
      });
      setPages(prev => prev.map(p => p.page_id === pageId ? updated : p));
      if (activePage?.page_id === pageId) setActivePage(updated);
    } catch (e) { alert(e.message); }
  };

  // ── Block CRUD ─────────────────────────────────────────────────
  const addBlock = async (blockType) => {
    setShowBlockPicker(false);
    if (!activePage || typeof activePage === 'string') return;
    try {
      const block = await apiFetch('/api/website/blocks', {
        method: 'POST',
        body: JSON.stringify({ page_id: activePage.page_id, block_type: blockType, block_data: defaultBlockData[blockType] || {}, sort_order: blocks.length }),
      });
      setBlocks(prev => [...prev, block]);
    } catch (e) { alert(e.message); }
  };

  const deleteBlock = async (blockId) => {
    if (!confirm('Delete this block?')) return;
    try {
      await apiFetch(`/api/website/blocks/${blockId}`, { method: 'DELETE' });
      setBlocks(prev => prev.filter(b => b.block_id !== blockId));
      if (selectedBlock?.block_id === blockId) setSelectedBlock(null);
    } catch (e) { alert(e.message); }
  };

  const moveBlock = async (index, direction) => {
    const nb = [...blocks];
    const si = index + direction;
    if (si < 0 || si >= nb.length) return;
    [nb[index], nb[si]] = [nb[si], nb[index]];
    const reordered = nb.map((b, i) => ({ ...b, sort_order: i }));
    setBlocks(reordered);
    try {
      await apiFetch('/api/website/blocks/reorder', { method: 'POST', body: JSON.stringify({ block_ids: reordered.map(b => b.block_id) }) });
    } catch { loadBlocks(activePage.page_id); }
  };

  // ── Inline field save ──────────────────────────────────────────
  const saveBlockField = useCallback(async (blockId, key, value) => {
    const block = blocksRef.current.find(b => b.block_id === blockId);
    if (!block) return;
    const newData = { ...block.block_data, [key]: value };
    setBlocks(prev => prev.map(b => b.block_id === blockId ? { ...b, block_data: newData } : b));
    setSelectedBlock(prev => prev?.block_id === blockId ? { ...prev, block_data: newData } : prev);
    try {
      await apiFetch(`/api/website/blocks/${blockId}`, { method: 'PUT', body: JSON.stringify({ block_data: newData }) });
    } catch {}
  }, []);

  const saveBlockFieldsMulti = useCallback(async (blockId, updates) => {
    const block = blocksRef.current.find(b => b.block_id === blockId);
    if (!block) return;
    const newData = { ...block.block_data, ...updates };
    setBlocks(prev => prev.map(b => b.block_id === blockId ? { ...b, block_data: newData } : b));
    setSelectedBlock(prev => prev?.block_id === blockId ? { ...prev, block_data: newData } : prev);
    try {
      await apiFetch(`/api/website/blocks/${blockId}`, { method: 'PUT', body: JSON.stringify({ block_data: newData }) });
    } catch {}
  }, []);

  const addImageToSelectedBlock = useCallback(async (file) => {
    if (!selectedBlock) return;
    try {
      const url = await uploadImageFile(file);
      const block = blocksRef.current.find(b => b.block_id === selectedBlock.block_id);
      if (!block) return;
      const raw = Array.isArray(block.block_data?.images) && block.block_data.images.length > 0
        ? block.block_data.images
        : (block.block_data?.image_url ? [block.block_data.image_url] : []);
      const existing = raw.map(img => typeof img === 'string' ? { url: img, position: block.block_data?.image_position || 'right' } : img);
      const newImg = { url, position: 'right' };
      await saveBlockFieldsMulti(selectedBlock.block_id, { images: [...existing, newImg], image_url: existing[0]?.url || url });
    } catch { alert('Image upload failed.'); }
  }, [selectedBlock, saveBlockFieldsMulti]);

  const handleMediaDrop = useCallback(async (blockId, url) => {
    const block = blocksRef.current.find(b => b.block_id === blockId);
    if (!block) return;
    const bt = block.block_type;
    if (bt === 'hero') {
      await saveBlockField(blockId, 'image_url', url);
    } else if (bt === 'about' || bt === 'content') {
      const raw = Array.isArray(block.block_data?.images) && block.block_data.images.length > 0
        ? block.block_data.images
        : (block.block_data?.image_url ? [block.block_data.image_url] : []);
      const existing = raw.map(img => typeof img === 'string' ? { url: img, position: block.block_data?.image_position || 'right' } : img);
      await saveBlockFieldsMulti(blockId, { images: [...existing, { url, position: 'right' }], image_url: existing[0]?.url || url });
    }
  }, [saveBlockField, saveBlockFieldsMulti]);

  // ── Drag-to-reorder handlers ───────────────────────────────────
  const handleDragStart = useCallback((e, idx) => {
    dragIdx.current = idx;
    setDraggingId(blocks[idx]?.block_id);
    e.dataTransfer.effectAllowed = 'move';
  }, [blocks]);

  const handleDragOver = useCallback((e, idx) => {
    e.preventDefault();
    if (dragIdx.current === null || dragIdx.current === idx) return;
    const nb = [...blocks];
    const dragged = nb.splice(dragIdx.current, 1)[0];
    nb.splice(idx, 0, dragged);
    dragIdx.current = idx;
    setBlocks(nb);
  }, [blocks]);

  const handleDrop = useCallback(async () => {
    setDraggingId(null);
    dragIdx.current = null;
    try {
      const reordered = blocks.map((b, i) => ({ ...b, sort_order: i }));
      setBlocks(reordered);
      await apiFetch('/api/website/blocks/reorder', { method: 'POST', body: JSON.stringify({ block_ids: reordered.map(b => b.block_id) }) });
    } catch { if (activePage?.page_id) loadBlocks(activePage.page_id); }
  }, [blocks, activePage]);

  // ── Render guards ──────────────────────────────────────────────
  const PeopleID = localStorage.getItem('people_id');

  if (loading) return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="p-8 text-gray-400">Loading website builder…</div>
    </AccountLayout>
  );

  // ── Setup wizard ───────────────────────────────────────────────
  if (setupMode) return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div style={{ maxWidth: 700, margin: '0 auto' }}>
        <h1 className="text-2xl font-bold text-gray-900 mb-1">Create Your Website</h1>
        <p className="text-gray-500 text-sm mb-6">Set up your public business website. You can change everything later.</p>

        <div className="bg-white rounded-xl border border-gray-100 shadow p-6 mb-4">
          <h2 className="text-base font-bold text-gray-800 mb-1">Choose a Starting Design</h2>
          <p className="text-xs text-gray-400 mb-4">Pick a color scheme to start with. You can customize every detail afterwards.</p>
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
            {TEMPLATES.map(t => (
              <button key={t.id}
                onClick={() => setSetupData(p => ({ ...p, primary_color: t.primary_color, secondary_color: t.secondary_color, accent_color: t.accent_color, bg_color: t.bg_color, text_color: t.text_color, nav_text_color: t.nav_text_color, footer_bg_color: t.footer_bg_color, font_family: t.font_family }))}
                className={`rounded-xl border-2 overflow-hidden text-left transition-all ${setupData.primary_color === t.primary_color ? 'border-[#3D6B34] shadow-md' : 'border-gray-100 hover:border-gray-300'}`}>
                <div className="flex h-8">{[t.primary_color, t.secondary_color, t.accent_color, t.bg_color].map((c, i) => <div key={i} className="flex-1" style={{ background: c }} />)}</div>
                <div className="px-2 py-1" style={{ background: t.primary_color }}><span className="text-xs font-bold" style={{ color: t.nav_text_color, fontFamily: t.font_family }}>{t.name}</span></div>
                <div className="px-2 py-1.5" style={{ background: t.bg_color }}><span className="text-xs" style={{ color: t.text_color, fontFamily: t.font_family }}>Sample text</span></div>
              </button>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-100 shadow p-6 flex flex-col gap-3">
          <FormField label="Site Name">
            <input className={inp} value={setupData.site_name} placeholder="Green Acres Farm"
              onChange={e => setSetupData(p => ({ ...p, site_name: e.target.value }))} />
          </FormField>
          <FormField label={`URL Slug — your site will be at /sites/${setupData.slug || 'your-farm'}`}>
            <input className={inp} value={setupData.slug} placeholder="green-acres-farm"
              onChange={e => setSetupData(p => ({ ...p, slug: slugify(e.target.value) }))} />
          </FormField>
          <FormField label="Tagline (Optional)">
            <input className={inp} value={setupData.tagline} placeholder="Fresh, local, sustainably grown."
              onChange={e => setSetupData(p => ({ ...p, tagline: e.target.value }))} />
          </FormField>
          <div className="grid grid-cols-2 gap-3">
            <FormField label="Phone (Optional)">
              <input className={inp} value={setupData.phone} onChange={e => setSetupData(p => ({ ...p, phone: e.target.value }))} />
            </FormField>
            <FormField label="Email (Optional)">
              <input className={inp} value={setupData.email} onChange={e => setSetupData(p => ({ ...p, email: e.target.value }))} />
            </FormField>
          </div>
          <button onClick={createSite} disabled={saving || !setupData.site_name || !setupData.slug}
            className="regsubmit2 w-full py-3 text-base mt-2 disabled:opacity-50">
            {saving ? 'Creating your site…' : 'Create My Website →'}
          </button>
        </div>
      </div>
    </AccountLayout>
  );

  // ── Main builder UI ────────────────────────────────────────────
  const isDesign      = activePage === 'design';
  const isSettings    = activePage === 'settings';
  const isDelete      = activePage === 'delete';
  const isManagePages = activePage === 'manage-pages';
  const isPage        = activePage && typeof activePage === 'object';

  // ── CANVAS PAGE EDITOR ─────────────────────────────────────────
  if (isPage) return (
    <>
      <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
        <div className="-m-6 flex flex-col" style={{ height: 'calc(100vh - 72px)', overflow: 'hidden' }}>

          {/* ── Top bar ── */}
          <div style={{ height: 48, flexShrink: 0, background: '#fff', borderBottom: '1px solid #e5e7eb', display: 'flex', alignItems: 'center', padding: '0 16px', gap: 12 }}>
            <div style={{ flex: 1, minWidth: 0 }}>
              <span style={{ fontWeight: 700, fontSize: 14, color: '#111827' }}>{site.site_name}</span>
              <span style={{ color: '#9ca3af', fontSize: 13, marginLeft: 8 }}>/ {activePage.page_name}</span>
              <span className={`ml-3 text-xs font-medium px-2 py-0.5 rounded-full ${activePage.is_published ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                {activePage.is_published ? 'Visible' : 'Hidden'}
              </span>
            </div>

            {/* Center note */}
            <div style={{ position: 'absolute', left: '50%', transform: 'translateX(-50%)', fontSize: 12, color: '#9ca3af', fontStyle: 'italic', pointerEvents: 'none', whiteSpace: 'nowrap' }}>
              ✓ Changes are automagically saved
            </div>

            {/* Responsive preview */}
            <div style={{ display: 'flex', border: '1px solid #e5e7eb', borderRadius: 8, overflow: 'hidden' }}>
              {[['desktop','🖥'],['tablet','📱'],['mobile','📲']].map(([id, icon]) => (
                <button key={id} onClick={() => setPreviewMode(id)}
                  style={{ padding: '4px 10px', background: previewMode === id ? '#3D6B34' : '#fff', color: previewMode === id ? '#fff' : '#6b7280', border: 'none', cursor: 'pointer', fontSize: 13 }}>
                  {icon}
                </button>
              ))}
            </div>

            <button onClick={() => window.open(`/sites/${site.slug}?preview=1`, '_blank')}
              style={{ padding: '5px 14px', fontSize: 13, fontWeight: 500, color: '#374151', background: '#fff', border: '1px solid #e5e7eb', borderRadius: 8, cursor: 'pointer' }}>
              Preview ↗
            </button>
            {site.is_published && (
              <a href={`/sites/${site.slug}`} target="_blank" rel="noreferrer"
                style={{ padding: '5px 14px', fontSize: 13, fontWeight: 500, color: '#3D6B34', background: '#fff', border: '1px solid #3D6B34', borderRadius: 8, cursor: 'pointer', textDecoration: 'none' }}>
                View Live ↗
              </a>
            )}
            <button onClick={togglePublish} disabled={saving}
              style={{ padding: '5px 14px', fontSize: 13, fontWeight: 700, color: site.is_published ? '#dc2626' : '#fff', background: site.is_published ? '#fef2f2' : '#3D6B34', border: `1px solid ${site.is_published ? '#fca5a5' : '#3D6B34'}`, borderRadius: 8, cursor: 'pointer', opacity: saving ? 0.6 : 1 }}>
              {site.is_published ? 'Unpublish' : 'Publish Site'}
            </button>
          </div>

          {/* ── Body ── */}
          <div style={{ flex: 1, display: 'flex', overflow: 'hidden' }}>

            {/* ── Left icon tabs (52px) ── */}
            <div style={{ width: 52, flexShrink: 0, background: '#f9fafb', borderRight: '1px solid #e5e7eb', display: 'flex', flexDirection: 'column', alignItems: 'center', paddingTop: 8, gap: 4 }}>
              {[['pages','📄','Pages'],['blocks','➕','Blocks'],['media','🖼️','Media']].map(([id, icon, label]) => (
                <button key={id} onClick={() => { if (activeTab === id) { setSidebarOpen(o => !o); } else { setActiveTab(id); setSidebarOpen(true); } }} title={label}
                  style={{ width: 40, height: 40, borderRadius: 8, border: 'none', cursor: 'pointer', fontSize: 18, display: 'flex', alignItems: 'center', justifyContent: 'center', background: activeTab === id && sidebarOpen ? '#e0f2fe' : 'transparent', color: activeTab === id && sidebarOpen ? '#0369a1' : '#6b7280' }}>
                  {icon}
                </button>
              ))}
              <div style={{ flex: 1 }} />
              <button onClick={() => setActivePage('manage-pages')} title="Manage Pages"
                style={{ width: 40, height: 40, borderRadius: 8, border: 'none', cursor: 'pointer', fontSize: 18, background: 'transparent', color: '#6b7280', marginBottom: 4 }}>
                📋
              </button>
              <button onClick={() => setActivePage('design')} title="Design"
                style={{ width: 40, height: 40, borderRadius: 8, border: 'none', cursor: 'pointer', fontSize: 18, background: 'transparent', color: '#6b7280', marginBottom: 4 }}>
                🎨
              </button>
              <button onClick={() => setActivePage('settings')} title="Settings"
                style={{ width: 40, height: 40, borderRadius: 8, border: 'none', cursor: 'pointer', fontSize: 18, background: 'transparent', color: '#6b7280', marginBottom: 8 }}>
                ⚙️
              </button>
            </div>

            {/* ── Left content panel (240px, collapsible) ── */}
            <div style={{ width: sidebarOpen ? 240 : 0, flexShrink: 0, background: '#fff', borderRight: sidebarOpen ? '1px solid #e5e7eb' : 'none', display: 'flex', flexDirection: 'column', overflow: 'hidden', transition: 'width 0.18s ease' }}>

              {/* Pages tab */}
              {activeTab === 'pages' && (
                <div style={{ flex: 1, overflowY: 'auto', padding: 8, minWidth: 240 }}>
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '4px 8px 8px' }}>
                    <span style={{ fontSize: 11, fontWeight: 600, color: '#6b7280' }}>Pages</span>
                    <button onClick={() => setSidebarOpen(false)} title="Close panel" style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af', fontSize: 16, lineHeight: 1, padding: '0 2px' }}>×</button>
                  </div>
                  {(() => {
                    // Build ordered tree: top-level pages, each followed by their children
                    const topLevel = pages.filter(p => !p.parent_page_id);
                    const childrenOf = parentId => pages.filter(p => p.parent_page_id === parentId);
                    const tree = [];
                    topLevel.forEach(p => {
                      tree.push({ page: p, depth: 0 });
                      childrenOf(p.page_id).forEach(c => tree.push({ page: c, depth: 1 }));
                    });
                    return tree.map(({ page, depth }) => (
                      <div key={page.page_id} style={{ borderRadius: 8, marginBottom: 2, marginLeft: depth === 1 ? 12 : 0 }}>
                        {/* Parent picker shown inline when this page is being nested */}
                        {nestingPageId === page.page_id ? (
                          <div style={{ display: 'flex', alignItems: 'center', gap: 4, padding: '5px 8px', background: '#eff6ff', borderRadius: 8, border: '1px solid #bfdbfe' }}>
                            <span style={{ fontSize: 11, color: '#3b82f6', whiteSpace: 'nowrap' }}>Nest under:</span>
                            <select autoFocus size={1}
                              style={{ flex: 1, fontSize: 11, border: '1px solid #93c5fd', borderRadius: 4, padding: '1px 3px' }}
                              defaultValue=""
                              onChange={e => { if (e.target.value) setPageParent(page.page_id, parseInt(e.target.value)); }}>
                              <option value="" disabled>Pick parent…</option>
                              {topLevel.filter(p => p.page_id !== page.page_id).map(p => (
                                <option key={p.page_id} value={p.page_id}>{p.page_name}</option>
                              ))}
                            </select>
                            <button onClick={() => setNestingPageId(null)}
                              style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af', fontSize: 14, lineHeight: 1, padding: '0 2px' }}>×</button>
                          </div>
                        ) : editingPageId === page.page_id ? (
                          <div style={{ display: 'flex', gap: 4, padding: '4px 6px' }}>
                            <input autoFocus value={editingPageName}
                              onChange={e => setEditingPageName(e.target.value)}
                              onKeyDown={e => { if (e.key === 'Enter') renamePage(page.page_id); if (e.key === 'Escape') setEditingPageId(null); }}
                              style={{ flex: 1, border: '1px solid #3b82f6', borderRadius: 6, padding: '3px 6px', fontSize: 12 }} />
                            <button onClick={() => renamePage(page.page_id)} style={{ fontSize: 11, padding: '2px 6px', background: '#3b82f6', color: '#fff', border: 'none', borderRadius: 4, cursor: 'pointer' }}>✓</button>
                          </div>
                        ) : (
                          <div
                            onClick={() => selectPage(page)}
                            style={{ display: 'flex', alignItems: 'center', padding: '7px 8px', borderRadius: 8, cursor: 'pointer', background: activePage?.page_id === page.page_id ? '#eff6ff' : 'transparent', gap: 4 }}
                            className="group"
                          >
                            {/* Depth indicator for children */}
                            {depth === 1 && <span style={{ color: '#d1d5db', fontSize: 10, flexShrink: 0 }}>└</span>}
                            <span style={{ flex: 1, fontSize: 13, fontWeight: activePage?.page_id === page.page_id ? 600 : 400, color: '#111827', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                              {page.page_name}
                            </span>
                            {childrenOf(page.page_id).length > 0 && (
                              <span style={{ fontSize: 9, color: '#9ca3af', flexShrink: 0 }}>▾</span>
                            )}
                            {!page.is_published && <span style={{ fontSize: 9, color: '#9ca3af', flexShrink: 0 }}>hidden</span>}
                            <div style={{ display: 'flex', gap: 1, flexShrink: 0, opacity: 0 }} className="group-actions">
                              <button onClick={e => { e.stopPropagation(); setEditingPageId(page.page_id); setEditingPageName(page.page_name); }}
                                style={{ padding: '1px 4px', background: 'none', border: 'none', cursor: 'pointer', fontSize: 11, color: '#6b7280' }} title="Rename">✏️</button>
                              {/* Nest (top-level → child) or Promote (child → top-level) */}
                              {depth === 0 && topLevel.length > 1 && childrenOf(page.page_id).length === 0 && (
                                <button onClick={e => { e.stopPropagation(); setNestingPageId(page.page_id); }}
                                  style={{ padding: '1px 4px', background: 'none', border: 'none', cursor: 'pointer', fontSize: 11, color: '#6b7280' }} title="Nest under another page">→</button>
                              )}
                              {depth === 1 && (
                                <button onClick={e => { e.stopPropagation(); setPageParent(page.page_id, null); }}
                                  style={{ padding: '1px 4px', background: 'none', border: 'none', cursor: 'pointer', fontSize: 11, color: '#6b7280' }} title="Promote to top-level">←</button>
                              )}
                              <button onClick={e => { e.stopPropagation(); togglePagePublished(page); }}
                                style={{ padding: '1px 4px', background: 'none', border: 'none', cursor: 'pointer', fontSize: 11 }} title={page.is_published ? 'Hide from nav' : 'Show in nav'}>
                                {page.is_published ? '👁' : '🚫'}
                              </button>
                              <button onClick={e => { e.stopPropagation(); deletePage(page.page_id); }}
                                style={{ padding: '1px 4px', background: 'none', border: 'none', cursor: 'pointer', fontSize: 11, color: '#ef4444' }} title="Delete">🗑</button>
                            </div>
                          </div>
                        )}
                      </div>
                    ));
                  })()}

                  {showNewPage ? (
                    <div style={{ display: 'flex', gap: 4, padding: '4px 6px', marginTop: 4 }}>
                      <input autoFocus value={newPageName} placeholder="Page name"
                        onChange={e => setNewPageName(e.target.value)}
                        onKeyDown={e => { if (e.key === 'Enter') addPage(); if (e.key === 'Escape') { setShowNewPage(false); setNewPageName(''); } }}
                        style={{ flex: 1, border: '1px solid #3b82f6', borderRadius: 6, padding: '4px 8px', fontSize: 12 }} />
                      <button onClick={addPage} style={{ padding: '2px 8px', background: '#3D6B34', color: '#fff', border: 'none', borderRadius: 4, cursor: 'pointer', fontSize: 12 }}>+</button>
                      <button onClick={() => { setShowNewPage(false); setNewPageName(''); }} style={{ padding: '2px 6px', background: 'none', border: 'none', cursor: 'pointer', fontSize: 14, color: '#9ca3af' }}>×</button>
                    </div>
                  ) : (
                    <button onClick={() => setShowNewPage(true)}
                      style={{ width: '100%', marginTop: 6, padding: '6px 10px', background: 'none', border: '1px dashed #d1d5db', borderRadius: 8, cursor: 'pointer', fontSize: 12, color: '#6b7280', textAlign: 'left' }}>
                      + Add Page
                    </button>
                  )}
                  <button onClick={() => setActivePage('manage-pages')}
                    style={{ width: '100%', marginTop: 10, padding: '6px 10px', background: 'none', border: '1px solid #e5e7eb', borderRadius: 8, cursor: 'pointer', fontSize: 11, color: '#6b7280', textAlign: 'center' }}>
                    📋 Manage All Pages →
                  </button>
                  <style>{`.group:hover .group-actions { opacity: 1 !important; }`}</style>
                </div>
              )}

              {/* Blocks tab */}
              {activeTab === 'blocks' && (
                <div style={{ flex: 1, overflowY: 'auto', padding: 8, minWidth: 240 }}>
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '4px 8px 8px' }}>
                    <span style={{ fontSize: 11, fontWeight: 600, color: '#6b7280' }}>Add Block</span>
                    <button onClick={() => setSidebarOpen(false)} title="Close panel" style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af', fontSize: 16, lineHeight: 1, padding: '0 2px' }}>×</button>
                  </div>
                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 4 }}>
                    {BLOCK_TYPES.map(bt => (
                      <button key={bt.type} onClick={() => addBlock(bt.type)}
                        style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 4, padding: '10px 6px', borderRadius: 8, border: '1px solid #e5e7eb', background: '#fff', cursor: 'pointer', textAlign: 'center', transition: 'all 0.1s' }}
                        onMouseEnter={e => e.currentTarget.style.background = '#f0fdf4'}
                        onMouseLeave={e => e.currentTarget.style.background = '#fff'}
                      >
                        <span style={{ fontSize: 20 }}>{bt.icon}</span>
                        <span style={{ fontSize: 10, fontWeight: 500, color: '#374151', lineHeight: 1.2 }}>{bt.label}</span>
                      </button>
                    ))}
                  </div>
                </div>
              )}

              {/* Media tab */}
              {activeTab === 'media' && (
                <div style={{ flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column', minWidth: 240 }}>
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '12px 12px 4px' }}>
                    <span style={{ fontSize: 11, fontWeight: 600, color: '#6b7280' }}>Media Library</span>
                    <button onClick={() => setSidebarOpen(false)} title="Close panel" style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af', fontSize: 16, lineHeight: 1, padding: '0 2px' }}>×</button>
                  </div>
                  <div style={{ flex: 1, overflow: 'hidden' }}>
                    <MediaPanel siteId={site?.website_id} />
                  </div>
                </div>
              )}
            </div>

            {/* ── Canvas ── */}
            <main
              ref={canvasRef}
              onClick={() => setSelectedBlock(null)}
              style={{
                flex: 1,
                overflowY: 'auto',
                overflowX: 'hidden',
                background: '#e5e7eb',
                padding: '8px',
              }}
            >
              <div style={{
                margin: '0 auto',
                background: site?.bg_image_url
                  ? `url(${site.bg_image_url}) center/cover no-repeat`
                  : (site?.bg_gradient || site?.bg_color || '#fff'),
                color: site?.text_color || '#111827',
                fontFamily: site?.font_family || 'inherit',
                boxShadow: '0 4px 32px rgba(0,0,0,0.12)',
                borderRadius: 4,
                overflow: 'hidden',
                maxWidth: previewMode === 'tablet' ? 768 : previewMode === 'mobile' ? 390 : '100%',
              }}>
                {/* Simulated site header */}
                <CanvasSiteHeader site={site} pages={pages} />

                {/* Page blocks */}
                {blocks.length === 0 ? (
                  <div style={{ padding: '4rem', textAlign: 'center', color: '#9ca3af', background: site?.bg_color || '#fff' }}>
                    <div style={{ fontSize: '2.5rem', marginBottom: 12 }}>📄</div>
                    <div style={{ fontWeight: 600, fontSize: 15, marginBottom: 6, color: '#374151' }}>This page has no blocks yet</div>
                    <div style={{ fontSize: 13, marginBottom: 20 }}>Click the ➕ tab on the left to add blocks</div>
                    <button onClick={() => { setActiveTab('blocks'); setSidebarOpen(true); }}
                      style={{ padding: '8px 20px', background: site?.primary_color || '#3D6B34', color: '#fff', border: 'none', borderRadius: 8, cursor: 'pointer', fontWeight: 600, fontSize: 14 }}>
                      + Add First Block
                    </button>
                  </div>
                ) : (
                  blocks.map((block, idx) => (
                    <CanvasBlock
                      key={block.block_id}
                      block={block}
                      index={idx}
                      isSelected={selectedBlock?.block_id === block.block_id}
                      onSelect={setSelectedBlock}
                      onDelete={deleteBlock}
                      onMoveUp={() => moveBlock(idx, -1)}
                      onMoveDown={() => moveBlock(idx, 1)}
                      isFirst={idx === 0}
                      isLast={idx === blocks.length - 1}
                      onDragStart={handleDragStart}
                      onDragOver={handleDragOver}
                      onDrop={handleDrop}
                      isDragging={draggingId === block.block_id}
                      site={site}
                    />
                  ))
                )}

                {/* Simulated site footer */}
                <CanvasSiteFooter site={site} />
              </div>
            </main>

            {/* ── Right block editor panel ── */}
            {selectedBlock && (
              <div key={selectedBlock.block_id} style={{ width: 280, flexShrink: 0, background: '#fff', borderLeft: '1px solid #e5e7eb', overflowY: 'auto' }}>
                <BlockEditorPanel
                  block={selectedBlock}
                  onFieldSave={(key, val) => saveBlockField(selectedBlock.block_id, key, val)}
                  onFieldsSave={(updates) => saveBlockFieldsMulti(selectedBlock.block_id, updates)}
                  site={site}
                />
              </div>
            )}
          </div>
        </div>
      </AccountLayout>

      {site && (
        <WebsiteAIAgent
          websiteId={site.website_id}
          businessId={parseInt(BusinessID)}
          currentView={activePage?.page_name || 'page'}
        />
      )}
    </>
  );

  // ── Design / Settings / Delete / No-page views ─────────────────
  return (
    <>
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>

      {/* ── Top bar ── */}
      <div className="flex items-center justify-between mb-5 flex-wrap gap-3">
        <div>
          <h1 className="text-xl font-bold text-gray-900">{site.site_name}</h1>
          <p className="text-xs text-gray-400 mt-0.5">
            {site.is_published
              ? <span className="text-green-600 font-medium">● Published</span>
              : <span className="text-gray-400">○ Unpublished</span>}
            <span className="ml-2">/sites/{site.slug}</span>
          </p>
        </div>
        <div className="flex items-center gap-2">
          <div className="flex items-center border border-gray-200 rounded-lg overflow-hidden">
            {[
              { id: 'desktop', icon: <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>, title: 'Desktop' },
              { id: 'tablet',  icon: <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><rect x="4" y="2" width="16" height="20" rx="2"/><line x1="12" y1="18" x2="12.01" y2="18"/></svg>, title: 'Tablet' },
              { id: 'mobile',  icon: <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><rect x="5" y="2" width="14" height="20" rx="2"/><line x1="12" y1="18" x2="12.01" y2="18"/></svg>, title: 'Mobile' },
            ].map(({ id, icon, title }) => (
              <button key={id} onClick={() => setPreviewMode(id)} title={title}
                className={`px-2.5 py-2 transition-colors ${previewMode === id ? 'bg-[#3D6B34] text-white' : 'text-gray-400 hover:bg-gray-50'}`}>
                {icon}
              </button>
            ))}
          </div>
          <button onClick={() => window.open(`/sites/${site.slug}?preview=1`, '_blank')}
            className="text-sm font-medium text-gray-600 border border-gray-200 px-4 py-2 rounded-lg hover:bg-gray-50 transition-colors">
            Preview ↗
          </button>
          {site.is_published && (
            <a href={`/sites/${site.slug}`} target="_blank" rel="noreferrer"
              className="text-sm font-medium text-[#3D6B34] border border-[#3D6B34]/30 px-4 py-2 rounded-lg hover:bg-green-50 transition-colors">
              View Live ↗
            </a>
          )}
          <button onClick={togglePublish} disabled={saving}
            className={`text-sm font-bold px-5 py-2 rounded-lg transition-colors ${site.is_published ? 'bg-red-100 text-red-700 hover:bg-red-200' : 'bg-[#3D6B34] text-white hover:bg-[#2d5226]'}`}>
            {site.is_published ? 'Unpublish' : 'Publish Site'}
          </button>
        </div>
      </div>

      <div style={{ minHeight: 'calc(100vh - 230px)' }}>
        <div className={`transition-all mx-auto ${previewMode === 'tablet' ? 'max-w-[768px]' : previewMode === 'mobile' ? 'max-w-[390px]' : 'max-w-none'}`}>
          {isDesign && <DesignView site={site} onSave={saveSite} saving={saving} onDelete={deleteSite} />}
          {isSettings && <SettingsView site={site} onSave={saveSite} saving={saving} onDelete={deleteSite} />}
          {isManagePages && (
            <PageManagementView
              pages={pages}
              site={site}
              onMovePage={movePage}
              onReorderPages={reorderPages}
              onTogglePublished={togglePagePublished}
              onSetHome={setHomePage}
              onDelete={deletePage}
              onSetParent={setPageParent}
              onRename={renameDirect}
              onAddPage={async (name, parentId, isNavHeading = false) => {
                if (!name.trim()) return;
                setSaving(true);
                try {
                  const siblings = pages.filter(p => p.parent_page_id === (parentId || null));
                  const page = await apiFetch('/api/website/pages', {
                    method: 'POST',
                    body: JSON.stringify({
                      website_id: site.website_id,
                      business_id: parseInt(BusinessID),
                      page_name: name.trim(),
                      slug: slugify(name.trim()),
                      sort_order: siblings.length,
                      parent_page_id: parentId || null,
                      is_nav_heading: isNavHeading,
                    }),
                  });
                  setPages(prev => [...prev, page]);
                } catch (e) { alert(e.message); }
                finally { setSaving(false); }
              }}
              onSelectPage={page => { selectPage(page); }}
            />
          )}
          {isDelete && (
            <div className="bg-white rounded-xl border border-red-100 shadow-sm p-6 max-w-lg">
              <h2 className="text-lg font-bold text-red-700 mb-2">Delete Website</h2>
              <p className="text-sm text-gray-600 mb-4">This will permanently delete <strong>{site.site_name}</strong>, all its pages, and all content. This action cannot be undone.</p>
              <button onClick={deleteSite} className="px-6 py-2 bg-red-600 text-white font-bold rounded-xl hover:bg-red-700 transition-colors">
                Permanently Delete
              </button>
            </div>
          )}
          {!isDesign && !isSettings && !isDelete && !isManagePages && (
            <div className="flex items-center justify-center bg-white rounded-xl border border-gray-100 text-gray-400 p-12">
              Select a page to start editing.
            </div>
          )}
        </div>

      </div>
    </AccountLayout>

    {site && (
      <WebsiteAIAgent
        websiteId={site.website_id}
        businessId={parseInt(BusinessID)}
        currentView={isDesign ? 'design' : isSettings ? 'settings' : isManagePages ? 'pages' : 'page'}
      />
    )}
    </>
  );
}

// ── TopBarEditor: mini WYSIWYG for the top bar HTML content ──────
function TopBarEditor({ value, onChange, bgColor, paletteColors = [] }) {
  const ref = useRef(null);
  const editing = useRef(false);
  const savedRange = useRef(null);
  const [showLink, setShowLink] = useState(false);
  const [linkUrl, setLinkUrl] = useState('');
  const [linkText, setLinkText] = useState('');

  useEffect(() => {
    if (ref.current && !editing.current) {
      ref.current.innerHTML = value || '';
    }
  }, [value]);

  const saveSelection = () => {
    const sel = window.getSelection();
    if (sel && sel.rangeCount > 0 && ref.current?.contains(sel.anchorNode)) {
      savedRange.current = sel.getRangeAt(0).cloneRange();
    }
  };

  const restoreSelection = () => {
    const sel = window.getSelection();
    if (savedRange.current) { sel.removeAllRanges(); sel.addRange(savedRange.current); }
  };

  const emit = () => { if (ref.current) onChange(ref.current.innerHTML); };

  const cmd = (command, val = null) => {
    restoreSelection();
    document.execCommand(command, false, val);
    emit();
  };

  const wrapSpan = (style) => {
    restoreSelection();
    const sel = window.getSelection();
    if (!sel || !savedRange.current || sel.isCollapsed) return;
    const span = document.createElement('span');
    Object.assign(span.style, style);
    try { savedRange.current.surroundContents(span); } catch { /* partial selection — skip */ }
    emit();
  };

  const insertLink = () => {
    restoreSelection();
    let href = linkUrl.trim();
    if (!href) return;
    if (!href.startsWith('http') && !href.startsWith('mailto:')) {
      href = href.includes('@') ? `mailto:${href}` : `https://${href}`;
    }
    const sel = window.getSelection();
    const displayText = linkText.trim() || (savedRange.current && !savedRange.current.collapsed ? savedRange.current.toString() : href);
    const a = document.createElement('a');
    a.href = href;
    a.textContent = displayText;
    if (savedRange.current && !savedRange.current.collapsed) {
      savedRange.current.deleteContents();
      savedRange.current.insertNode(a);
    } else {
      ref.current?.focus();
      document.execCommand('insertHTML', false, a.outerHTML);
    }
    emit();
    setShowLink(false);
    setLinkUrl('');
    setLinkText('');
  };

  const ToolBtn = ({ onMD, children, title, style = {} }) => (
    <button
      onMouseDown={e => { e.preventDefault(); saveSelection(); onMD(); }}
      title={title}
      style={{ height: 26, minWidth: 26, padding: '0 5px', border: '1px solid #e5e7eb', borderRadius: 4, background: '#fff', cursor: 'pointer', fontSize: 12, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#374151', ...style }}>
      {children}
    </button>
  );

  return (
    <div style={{ border: '1px solid #d1d5db', borderRadius: 8, overflow: 'visible', position: 'relative' }}>
      {/* Toolbar */}
      <div style={{ background: '#f9fafb', borderBottom: '1px solid #e5e7eb', padding: '5px 8px', display: 'flex', gap: 4, alignItems: 'center', flexWrap: 'wrap', borderRadius: '8px 8px 0 0' }}>

        {/* Font family */}
        <select
          onMouseDown={saveSelection}
          onChange={e => { wrapSpan({ fontFamily: e.target.value }); e.target.value = ''; }}
          defaultValue=""
          style={{ fontSize: 11, border: '1px solid #e5e7eb', borderRadius: 4, padding: '2px 4px', background: '#fff', maxWidth: 120, height: 26 }}>
          <option value="">Font…</option>
          {WEB_FONTS.map(f => <option key={f.value} value={f.value}>{f.label}</option>)}
        </select>

        {/* Font size */}
        <select
          onMouseDown={saveSelection}
          onChange={e => { wrapSpan({ fontSize: e.target.value }); e.target.value = ''; }}
          defaultValue=""
          style={{ fontSize: 11, border: '1px solid #e5e7eb', borderRadius: 4, padding: '2px 4px', background: '#fff', width: 64, height: 26 }}>
          <option value="">Size…</option>
          {['10px','11px','12px','13px','14px','15px','16px','18px','20px','22px','24px','28px','32px'].map(s => (
            <option key={s} value={s}>{s}</option>
          ))}
        </select>

        <div style={{ width: 1, height: 20, background: '#e5e7eb' }} />

        {/* Bold */}
        <ToolBtn onMD={() => cmd('bold')} title="Bold" style={{ fontWeight: 700 }}>B</ToolBtn>
        {/* Italic */}
        <ToolBtn onMD={() => cmd('italic')} title="Italic" style={{ fontStyle: 'italic' }}>I</ToolBtn>
        {/* Underline */}
        <ToolBtn onMD={() => cmd('underline')} title="Underline" style={{ textDecoration: 'underline' }}>U</ToolBtn>

        <div style={{ width: 1, height: 20, background: '#e5e7eb' }} />

        {/* Text color */}
        <PaletteColorPicker
          paletteColors={paletteColors}
          onColor={hex => { saveSelection(); wrapSpan({ color: hex }); }}
        />

        <div style={{ width: 1, height: 20, background: '#e5e7eb' }} />

        {/* Link button */}
        <div style={{ position: 'relative' }}>
          <ToolBtn onMD={() => { saveSelection(); setShowLink(p => !p); }} title="Insert link / email">
            🔗
          </ToolBtn>
          {showLink && (
            <div style={{ position: 'absolute', top: 30, left: 0, zIndex: 200, background: '#fff', border: '1px solid #d1d5db', borderRadius: 10, padding: 14, boxShadow: '0 6px 24px rgba(0,0,0,0.15)', width: 280 }}>
              <div style={{ fontSize: 12, fontWeight: 700, marginBottom: 10, color: '#111827' }}>Insert Link or Email</div>
              <input
                placeholder="URL (https://…) or email address"
                value={linkUrl}
                onChange={e => setLinkUrl(e.target.value)}
                onKeyDown={e => e.key === 'Enter' && insertLink()}
                style={{ width: '100%', border: '1px solid #d1d5db', borderRadius: 6, padding: '6px 8px', fontSize: 12, marginBottom: 6, boxSizing: 'border-box' }}
                autoFocus
              />
              <input
                placeholder="Display text (optional — uses selection)"
                value={linkText}
                onChange={e => setLinkText(e.target.value)}
                onKeyDown={e => e.key === 'Enter' && insertLink()}
                style={{ width: '100%', border: '1px solid #d1d5db', borderRadius: 6, padding: '6px 8px', fontSize: 12, marginBottom: 10, boxSizing: 'border-box' }}
              />
              <div style={{ fontSize: 10, color: '#9ca3af', marginBottom: 8 }}>
                Tip: entering an email address (e.g. you@farm.com) automatically creates a mailto: link.
              </div>
              <div style={{ display: 'flex', gap: 6 }}>
                <button onClick={insertLink}
                  style={{ flex: 1, padding: '6px 0', background: '#3D6B34', color: '#fff', border: 'none', borderRadius: 6, cursor: 'pointer', fontSize: 12, fontWeight: 600 }}>
                  Insert
                </button>
                <button onClick={() => { setShowLink(false); setLinkUrl(''); setLinkText(''); }}
                  style={{ flex: 1, padding: '6px 0', background: '#f3f4f6', border: '1px solid #e5e7eb', borderRadius: 6, cursor: 'pointer', fontSize: 12 }}>
                  Cancel
                </button>
              </div>
            </div>
          )}
        </div>

        {/* Remove formatting */}
        <ToolBtn onMD={() => cmd('removeFormat')} title="Clear formatting" style={{ color: '#6b7280', fontSize: 11 }}>
          ✕ fmt
        </ToolBtn>
      </div>

      {/* Editable area */}
      <div
        ref={ref}
        contentEditable
        suppressContentEditableWarning
        onFocus={() => { editing.current = true; }}
        onBlur={() => { editing.current = false; emit(); }}
        onKeyUp={emit}
        style={{
          padding: '8px 12px',
          minHeight: 44,
          outline: 'none',
          fontSize: 13,
          lineHeight: 1.6,
          background: bgColor || '#f8f5ef',
          borderRadius: '0 0 8px 8px',
          fontFamily: 'inherit',
        }}
        data-placeholder="Type your top bar content here…"
      />
    </div>
  );
}

const WIDTH_PRESETS = ['100%', '1400px', '1200px', '1100px', '960px', '800px', '75%', '60%'];

// ── Width Diagram: live mini site mockup showing all 6 width zones ─
function WidthDiagram({ local }) {
  const MAX_PX = 1600;

  // Convert any width value to a CSS percentage string relative to MAX_PX viewport
  const toPct = (val) => {
    if (!val || val === '100%') return '100%';
    const s = String(val).trim();
    if (s.endsWith('%')) return `${Math.min(100, parseFloat(s))}%`;
    if (s.endsWith('px')) return `${Math.min(100, (parseFloat(s) / MAX_PX) * 100).toFixed(1)}%`;
    return '100%';
  };

  const pageBg = local.bg_image_url
    ? `url(${local.bg_image_url}) center/cover`
    : (local.bg_gradient || local.bg_color || '#fff');

  // Zone renders the bg band (centered via margin:auto) and overlays a dashed
  // content-width indicator — both widths are relative to the same zone container
  // so percentages are always computed from the same full-width reference.
  const Zone = ({ bgWidth, contentWidth, bgColor, bgImage, children, labelRow }) => (
    <div style={{ position: 'relative' }}>
      {/* BG band: block element centered with margin:auto — width is % of zone container */}
      <div style={{
        width: toPct(bgWidth), margin: '0 auto',
        background: bgImage ? `url(${bgImage}) center/cover no-repeat` : bgColor,
        transition: 'width 0.25s ease',
        overflow: 'hidden',
      }}>
        {children}
      </div>
      {/* Content-width dashed guide — absolute so it's relative to the same zone container */}
      <div style={{
        position: 'absolute', top: 0, bottom: 0,
        left: '50%', transform: 'translateX(-50%)',
        width: toPct(contentWidth),
        borderLeft: '1px dashed rgba(255,255,255,0.55)',
        borderRight: '1px dashed rgba(255,255,255,0.55)',
        pointerEvents: 'none',
        transition: 'width 0.25s ease',
      }} />
      {/* Label bar */}
      {labelRow}
    </div>
  );

  const LabelBar = ({ left, right, dark }) => (
    <div style={{ background: dark ? 'rgba(0,0,0,0.55)' : 'rgba(0,0,0,0.38)', padding: '2px 5px', display: 'flex', justifyContent: 'space-between' }}>
      <span style={{ fontSize: 7.5, color: 'rgba(255,255,255,0.95)', fontWeight: 600 }}>{left}</span>
      <span style={{ fontSize: 7.5, color: 'rgba(255,255,255,0.7)' }}>{right}</span>
    </div>
  );

  return (
    <div>
      {/* Browser chrome */}
      <div style={{ borderRadius: 8, border: '1px solid #d1d5db', overflow: 'hidden', boxShadow: '0 2px 8px rgba(0,0,0,0.08)', minWidth: 0 }}>
        {/* Tab bar */}
        <div style={{ background: '#e9ecef', padding: '8px 12px', display: 'flex', gap: 6, alignItems: 'center' }}>
          {['#ef4444','#f59e0b','#22c55e'].map(c => (
            <div key={c} style={{ width: 12, height: 12, borderRadius: '50%', background: c }} />
          ))}
          <div style={{ flex: 1, background: '#fff', borderRadius: 6, height: 18, marginLeft: 6, opacity: 0.8 }} />
        </div>

        {/* Page */}
        <div style={{ background: pageBg }}>

          {/* Header */}
          <Zone
            bgWidth={local.header_bg_width}
            contentWidth={local.header_content_width}
            bgColor={local.primary_color}
            bgImage={local.header_banner_url}
            labelRow={<LabelBar dark left={`Header BG: ${local.header_bg_width || '100%'}`} right={`Content: ${local.header_content_width || '100%'}`} />}
          >
            {/* Top bar */}
            {local.top_bar_enabled && (
              <div style={{ background: local.top_bar_bg_color || '#f8f5ef', padding: '5px 10px', display: 'flex', justifyContent: local.top_bar_align === 'left' ? 'flex-start' : local.top_bar_align === 'center' ? 'center' : 'flex-end' }}>
                <div style={{ width: 80, height: 5, background: local.top_bar_text_color || '#333', opacity: 0.4, borderRadius: 2 }} />
              </div>
            )}
            {/* Banner — full image at natural aspect ratio, no cropping */}
            {local.header_banner_url ? (
              <img src={local.header_banner_url} alt="" style={{ width: '100%', display: 'block' }} />
            ) : (
              <div style={{ minHeight: 80, background: local.primary_color, display: 'flex', alignItems: 'center', padding: '10px 10px', gap: 6 }}>
                {local.logo_url
                  ? <img src={local.logo_url} alt="" style={{ height: 36, objectFit: 'contain', flexShrink: 0 }} />
                  : <div style={{ width: 48, height: 22, background: 'rgba(255,255,255,0.5)', borderRadius: 3, flexShrink: 0 }} />}
                <div style={{ flex: 1, display: 'flex', gap: 5, justifyContent: 'flex-end' }}>
                  {[36,24,32,20].map((w, i) => <div key={i} style={{ width: w, height: 7, background: 'rgba(255,255,255,0.6)', borderRadius: 3 }} />)}
                </div>
              </div>
            )}
            {/* Logo overlay row when banner image is set */}
            {local.header_banner_url && (local.logo_url || local.show_site_name !== false) && (
              <div style={{ background: local.primary_color + 'cc', padding: '6px 10px', display: 'flex', alignItems: 'center', gap: 5 }}>
                {local.logo_url && <img src={local.logo_url} alt="" style={{ height: 22, objectFit: 'contain' }} />}
                {local.show_site_name !== false && <div style={{ width: 64, height: 7, background: 'rgba(255,255,255,0.7)', borderRadius: 3 }} />}
              </div>
            )}
            {/* Nav bar */}
            <div style={{ background: local.nav_bg_image_url ? `url(${local.nav_bg_image_url}) center/cover` : 'rgba(0,0,0,0.18)', padding: '9px 10px', display: 'flex', gap: 7 }}>
              {[32,22,32,18].map((w, i) => <div key={i} style={{ width: w, height: 7, background: 'rgba(255,255,255,0.65)', borderRadius: 3 }} />)}
            </div>
          </Zone>

          {/* Body blocks */}
          {[false, true, false].map((alt, bi) => (
            <Zone
              key={bi}
              bgWidth={local.body_bg_width}
              contentWidth={local.body_content_width}
              bgColor={alt
                ? (local.bg_color === '#FFFFFF' || local.bg_color === '#ffffff' ? '#F3F4F6' : (local.bg_color || '#fff') + 'dd')
                : (local.bg_color || '#fff')}
              labelRow={bi === 1
                ? <LabelBar left={`Body BG: ${local.body_bg_width || '100%'}`} right={`Text: ${local.body_content_width || '100%'}`} />
                : null}
            >
              <div style={{ padding: '14px 10px' }}>
                <div style={{ height: 9, background: (local.text_color || '#111') + '55', borderRadius: 3, marginBottom: 5 }} />
                <div style={{ height: 6, background: (local.text_color || '#111') + '33', borderRadius: 3, marginBottom: 5 }} />
                <div style={{ height: 6, background: (local.text_color || '#111') + '22', borderRadius: 3, width: '75%' }} />
              </div>
            </Zone>
          ))}

          {/* Footer */}
          <Zone
            bgWidth={local.footer_bg_width}
            contentWidth={local.footer_content_width}
            bgColor={local.footer_bg_color || local.primary_color}
            labelRow={<LabelBar dark left={`Footer BG: ${local.footer_bg_width || '100%'}`} right={`Content: ${local.footer_content_width || '100%'}`} />}
          >
            {local.footer_bg_image_url ? (
              <div style={{ position: 'relative' }}>
                {/* Full image at natural aspect ratio — no cropping */}
                <img src={local.footer_bg_image_url} alt="" style={{ width: '100%', display: 'block' }} />
                {/* Content overlay */}
                <div style={{ position: 'absolute', inset: 0, background: (local.footer_bg_color || local.primary_color) + 'aa', padding: '14px 10px 10px' }}>
                  <div style={{ height: 7, background: 'rgba(255,255,255,0.4)', borderRadius: 3, marginBottom: 5 }} />
                  <div style={{ height: 7, background: 'rgba(255,255,255,0.25)', borderRadius: 3, width: '55%', marginBottom: 10 }} />
                  <div style={{ borderTop: '1px solid rgba(255,255,255,0.2)', paddingTop: 6, display: 'flex', justifyContent: 'space-between' }}>
                    <div style={{ height: 5, width: '28%', background: 'rgba(255,255,255,0.3)', borderRadius: 2 }} />
                    <div style={{ height: 5, width: '22%', background: 'rgba(255,255,255,0.2)', borderRadius: 2 }} />
                  </div>
                </div>
              </div>
            ) : (
              <div style={{ padding: '14px 10px 10px' }}>
                <div style={{ height: 7, background: 'rgba(255,255,255,0.4)', borderRadius: 3, marginBottom: 5 }} />
                <div style={{ height: 7, background: 'rgba(255,255,255,0.25)', borderRadius: 3, width: '55%', marginBottom: 10 }} />
                <div style={{ borderTop: '1px solid rgba(255,255,255,0.2)', paddingTop: 6, display: 'flex', justifyContent: 'space-between' }}>
                  <div style={{ height: 5, width: '28%', background: 'rgba(255,255,255,0.3)', borderRadius: 2 }} />
                  <div style={{ height: 5, width: '22%', background: 'rgba(255,255,255,0.2)', borderRadius: 2 }} />
                </div>
              </div>
            )}
          </Zone>

        </div>
      </div>
      <p style={{ fontSize: 9, color: '#9CA3AF', textAlign: 'center', marginTop: 4 }}>
        Live mockup · 1600px reference · dashed lines show content width
      </p>
    </div>
  );
}

function WidthControl({ label, hint, value, onChange }) {
  const isCustom = value && !WIDTH_PRESETS.includes(value);
  return (
    <div className="mt-3">
      <label className="block text-sm font-medium text-gray-700 mb-1">{label}</label>
      {hint && <p className="text-xs text-gray-400 mb-2">{hint}</p>}
      <div className="flex flex-wrap gap-1.5 mb-2">
        {WIDTH_PRESETS.map(p => (
          <button key={p} onClick={() => onChange(p)}
            className={`px-2.5 py-1 rounded-lg text-xs font-medium border transition-colors
              ${value === p ? 'bg-[#3D6B34] text-white border-[#3D6B34]' : 'border-gray-200 text-gray-600 hover:border-gray-400'}`}>
            {p}
          </button>
        ))}
      </div>
      <div className="flex items-center gap-2">
        <input
          type="text"
          value={isCustom ? value : ''}
          placeholder="Custom (e.g. 1050px or 70%)"
          onChange={e => onChange(e.target.value)}
          className="flex-1 border border-gray-200 rounded-lg px-3 py-1.5 text-xs focus:outline-none focus:ring-2 focus:ring-green-300"
        />
        {isCustom && <span className="text-xs text-[#3D6B34] font-medium">✓ {value}</span>}
      </div>
      <p className="text-xs text-gray-400 mt-1">On mobile devices, always 100% width regardless of this setting.</p>
    </div>
  );
}

// ── Page Management Dashboard ─────────────────────────────────────
function PageManagementView({ pages, onMovePage, onReorderPages, onTogglePublished, onSetHome, onDelete, onSetParent, onRename, onAddPage, onSelectPage }) {
  const [editingId, setEditingId] = useState(null);
  const [editingName, setEditingName] = useState('');
  const [newPageName, setNewPageName] = useState('');
  const [newPageParent, setNewPageParent] = useState('');
  const [addingType, setAddingType] = useState(null);
  const [dragSrcId, setDragSrcId] = useState(null);
  const [dragOverId, setDragOverId] = useState(null);

  // Build ordered tree: top-level sorted, each with sorted children
  const topLevel = [...pages.filter(p => !p.parent_page_id)].sort((a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0));
  const headings = topLevel.filter(p => p.is_nav_heading);
  const childrenOf = parentId => [...pages.filter(p => p.parent_page_id === parentId)].sort((a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0));

  const rows = [];
  topLevel.forEach(p => {
    rows.push({ page: p, depth: 0 });
    childrenOf(p.page_id).forEach(c => rows.push({ page: c, depth: 1 }));
  });

  // Drag-and-drop: reorder within the same sibling group
  const handleDragStart = (e, pageId) => {
    setDragSrcId(pageId);
    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/plain', String(pageId));
  };
  const handleDragOver = (e, pageId) => {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
    if (pageId !== dragSrcId) setDragOverId(pageId);
  };
  const handleDrop = (e, targetPageId) => {
    e.preventDefault();
    const srcId = dragSrcId;
    setDragSrcId(null);
    setDragOverId(null);
    if (!srcId || srcId === targetPageId) return;
    const srcPage = pages.find(p => p.page_id === srcId);
    const tgtPage = pages.find(p => p.page_id === targetPageId);
    if (!srcPage || !tgtPage) return;
    // Only allow reorder within same parent group
    if (srcPage.parent_page_id !== tgtPage.parent_page_id) return;
    const siblings = (srcPage.parent_page_id
      ? pages.filter(p => p.parent_page_id === srcPage.parent_page_id)
      : pages.filter(p => !p.parent_page_id)
    ).sort((a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0));
    const srcIdx = siblings.findIndex(p => p.page_id === srcId);
    const tgtIdx = siblings.findIndex(p => p.page_id === targetPageId);
    if (srcIdx === -1 || tgtIdx === -1) return;
    const reordered = [...siblings];
    reordered.splice(srcIdx, 1);
    reordered.splice(tgtIdx, 0, srcPage);
    onReorderPages(reordered.map(p => p.page_id));
  };
  const handleDragEnd = () => { setDragSrcId(null); setDragOverId(null); };

  const commitRename = (pageId) => {
    onRename(pageId, editingName);
    setEditingId(null);
  };

  const handleAdd = async () => {
    if (!newPageName.trim()) return;
    const isHeading = addingType === 'heading';
    await onAddPage(newPageName, newPageParent ? parseInt(newPageParent) : null, isHeading);
    setNewPageName('');
    setNewPageParent('');
    setAddingType(null);
  };

  const btnBase = {
    padding: '3px 8px', fontSize: 11, borderRadius: 5,
    border: '1px solid #e5e7eb', cursor: 'pointer',
    background: '#fff', color: '#374151', whiteSpace: 'nowrap',
  };

  return (
    <div style={{ background: '#fff', borderRadius: 12, border: '1px solid #e5e7eb', boxShadow: '0 1px 4px rgba(0,0,0,0.06)', overflow: 'hidden' }}>
      {/* Header */}
      <div style={{ padding: '16px 20px 12px', borderBottom: '1px solid #f3f4f6', display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 10, flexWrap: 'wrap' }}>
        <div>
          <h2 style={{ margin: 0, fontSize: 16, fontWeight: 700, color: '#111827' }}>Page Management</h2>
          <p style={{ margin: '2px 0 0', fontSize: 12, color: '#6b7280' }}>Click a name to rename · Drag rows to reorder</p>
        </div>
        <div style={{ display: 'flex', gap: 8 }}>
          <button onClick={() => setAddingType(t => t === 'heading' ? null : 'heading')}
            style={{ padding: '7px 14px', background: addingType === 'heading' ? '#7C5CBF' : '#f3f4f6', color: addingType === 'heading' ? '#fff' : '#374151', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
            + Nav Heading
          </button>
          <button onClick={() => setAddingType(t => t === 'page' ? null : 'page')}
            style={{ padding: '7px 14px', background: addingType === 'page' ? '#3D6B34' : '#3D6B34', color: '#fff', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
            + Add Page
          </button>
        </div>
      </div>

      {/* Add form (shared for page and heading) */}
      {addingType && (
        <div style={{ padding: '12px 20px', background: addingType === 'heading' ? '#f5f3ff' : '#f0fdf4', borderBottom: `1px solid ${addingType === 'heading' ? '#ddd6fe' : '#d1fae5'}`, display: 'flex', gap: 8, alignItems: 'center', flexWrap: 'wrap' }}>
          <span style={{ fontSize: 12, fontWeight: 600, color: addingType === 'heading' ? '#7C5CBF' : '#3D6B34', whiteSpace: 'nowrap' }}>
            {addingType === 'heading' ? '📌 New nav heading:' : '📄 New page:'}
          </span>
          <input
            autoFocus
            value={newPageName}
            onChange={e => setNewPageName(e.target.value)}
            onKeyDown={e => { if (e.key === 'Enter') handleAdd(); if (e.key === 'Escape') setAddingType(null); }}
            placeholder={addingType === 'heading' ? 'Heading label…' : 'Page name…'}
            style={{ flex: '1 1 160px', border: `1px solid ${addingType === 'heading' ? '#c4b5fd' : '#6ee7b7'}`, borderRadius: 6, padding: '6px 10px', fontSize: 13 }}
          />
          {addingType === 'page' && (
            <select value={newPageParent} onChange={e => setNewPageParent(e.target.value)}
              style={{ flex: '1 1 160px', border: '1px solid #6ee7b7', borderRadius: 6, padding: '6px 10px', fontSize: 13, background: '#fff' }}>
              <option value="">Top-level page</option>
              {headings.map(h => <option key={h.page_id} value={h.page_id}>Under heading: {h.page_name}</option>)}
              {topLevel.filter(p => !p.is_nav_heading).map(p => <option key={p.page_id} value={p.page_id}>Under page: {p.page_name}</option>)}
            </select>
          )}
          <button onClick={handleAdd}
            style={{ padding: '6px 16px', background: addingType === 'heading' ? '#7C5CBF' : '#3D6B34', color: '#fff', border: 'none', borderRadius: 6, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
            Add
          </button>
          <button onClick={() => { setAddingType(null); setNewPageName(''); setNewPageParent(''); }}
            style={{ padding: '6px 10px', background: 'none', border: 'none', cursor: 'pointer', fontSize: 18, color: '#9ca3af', lineHeight: 1 }}>
            ×
          </button>
        </div>
      )}

      {/* Column headers */}
      <div style={{ display: 'grid', gridTemplateColumns: '28px 1fr 200px 90px 72px 60px', padding: '6px 16px', background: '#f9fafb', borderBottom: '1px solid #f3f4f6' }}>
        {['', 'Name', 'Under Heading / Group', 'Visible', 'Home', 'Actions'].map(h => (
          <span key={h} style={{ fontSize: 10, fontWeight: 600, color: '#9ca3af', textTransform: 'uppercase', letterSpacing: '0.05em' }}>{h}</span>
        ))}
      </div>

      {/* Rows */}
      {rows.map(({ page, depth }) => {
        const isEditing = editingId === page.page_id;
        const isHeading = page.is_nav_heading;
        const isDragging = dragSrcId === page.page_id;
        const isOver    = dragOverId === page.page_id;

        return (
          <div key={page.page_id}
            draggable
            onDragStart={e => handleDragStart(e, page.page_id)}
            onDragOver={e => handleDragOver(e, page.page_id)}
            onDrop={e => handleDrop(e, page.page_id)}
            onDragEnd={handleDragEnd}
            style={{
              display: 'grid',
              gridTemplateColumns: '28px 1fr 200px 90px 72px 60px',
              padding: '8px 16px',
              borderBottom: '1px solid #f9fafb',
              alignItems: 'center',
              background: isDragging ? '#e0f2fe' : isOver ? '#fef9c3' : isHeading ? '#faf5ff' : depth === 1 ? '#fafafa' : '#fff',
              borderLeft: isHeading ? '3px solid #7C5CBF' : depth === 0 ? '3px solid #3D6B34' : '3px solid #d1fae5',
              opacity: isDragging ? 0.5 : 1,
              outline: isOver ? '2px dashed #f59e0b' : 'none',
              cursor: 'grab',
              transition: 'background 0.1s',
            }}
          >
            {/* Drag handle */}
            <div style={{ color: '#d1d5db', fontSize: 14, cursor: 'grab', userSelect: 'none', textAlign: 'center' }} title="Drag to reorder">⠿</div>

            {/* Name */}
            <div style={{ display: 'flex', alignItems: 'center', gap: 6, minWidth: 0 }}>
              {depth === 1 && <span style={{ color: '#d1d5db', fontSize: 12, flexShrink: 0 }}>└</span>}
              {isHeading && <span style={{ fontSize: 10, background: '#ede9fe', color: '#7C5CBF', borderRadius: 4, padding: '1px 5px', fontWeight: 700, flexShrink: 0 }}>HEADING</span>}
              {isEditing ? (
                <div style={{ display: 'flex', gap: 4, flex: 1 }}>
                  <input autoFocus value={editingName}
                    onChange={e => setEditingName(e.target.value)}
                    onKeyDown={e => { if (e.key === 'Enter') commitRename(page.page_id); if (e.key === 'Escape') setEditingId(null); }}
                    style={{ flex: 1, border: '1px solid #3b82f6', borderRadius: 5, padding: '3px 7px', fontSize: 13 }} />
                  <button onClick={() => commitRename(page.page_id)} style={{ ...btnBase, background: '#3b82f6', color: '#fff', border: 'none' }}>✓</button>
                  <button onClick={() => setEditingId(null)} style={{ ...btnBase, color: '#9ca3af' }}>✕</button>
                </div>
              ) : (
                <button onClick={() => { setEditingId(page.page_id); setEditingName(page.page_name); }}
                  style={{ background: 'none', border: 'none', cursor: 'pointer', textAlign: 'left', padding: '2px 4px', borderRadius: 4, fontSize: 13, fontWeight: isHeading || depth === 0 ? 600 : 400, color: isHeading ? '#7C5CBF' : '#111827', flex: 1, minWidth: 0, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}
                  title="Click to rename">
                  {page.page_name}
                  {page.is_home_page && <span style={{ marginLeft: 6, fontSize: 10, background: '#fef9c3', color: '#92400e', borderRadius: 4, padding: '1px 5px', fontWeight: 600 }}>HOME</span>}
                </button>
              )}
            </div>

            {/* Menu group (parent) — headings are always top-level */}
            {isHeading ? (
              <span style={{ fontSize: 12, color: '#9ca3af', fontStyle: 'italic' }}>— top level —</span>
            ) : (
              <select
                value={page.parent_page_id || ''}
                onChange={e => onSetParent(page.page_id, e.target.value ? parseInt(e.target.value) : null)}
                style={{ fontSize: 12, border: '1px solid #e5e7eb', borderRadius: 5, padding: '3px 6px', background: '#fff', color: '#374151', width: '100%' }}
              >
                <option value="">— Top level —</option>
                {topLevel.filter(p => p.page_id !== page.page_id).map(p => (
                  <option key={p.page_id} value={p.page_id}>{p.is_nav_heading ? '📌 ' : ''}{p.page_name}</option>
                ))}
              </select>
            )}

            {/* Visible toggle — headings are always visible */}
            {isHeading ? (
              <span style={{ fontSize: 12, color: '#9ca3af', fontStyle: 'italic' }}>always</span>
            ) : (
              <button onClick={() => onTogglePublished(page)}
                style={{ ...btnBase, background: page.is_published ? '#dcfce7' : '#f3f4f6', color: page.is_published ? '#166534' : '#6b7280', border: `1px solid ${page.is_published ? '#86efac' : '#e5e7eb'}`, fontWeight: 600, textAlign: 'center' }}>
                {page.is_published ? '● Visible' : '○ Hidden'}
              </button>
            )}

            {/* Home — headings can't be home */}
            {isHeading ? (
              <span />
            ) : (
              <button onClick={() => !page.is_home_page && onSetHome(page.page_id)}
                title={page.is_home_page ? 'This is the home page' : 'Set as home page'}
                style={{ ...btnBase, background: page.is_home_page ? '#fef9c3' : 'transparent', color: page.is_home_page ? '#92400e' : '#d1d5db', border: `1px solid ${page.is_home_page ? '#fde68a' : '#e5e7eb'}`, fontSize: 15, textAlign: 'center', cursor: page.is_home_page ? 'default' : 'pointer' }}>
                {page.is_home_page ? '★' : '☆'}
              </button>
            )}

            {/* Actions */}
            <div style={{ display: 'flex', gap: 3 }}>
              {!isHeading && (
                <button onClick={() => onSelectPage(page)} title="Edit page content"
                  style={{ ...btnBase, background: '#eff6ff', color: '#2563eb', border: '1px solid #bfdbfe', padding: '3px 7px' }}>
                  ✏️
                </button>
              )}
              <button onClick={() => onDelete(page.page_id)} title="Delete"
                style={{ ...btnBase, background: '#fef2f2', color: '#dc2626', border: '1px solid #fecaca', padding: '3px 7px' }}>
                🗑
              </button>
            </div>
          </div>
        );
      })}

      {rows.length === 0 && (
        <div style={{ padding: '3rem', textAlign: 'center', color: '#9ca3af', fontSize: 14 }}>
          No pages yet. Use the buttons above to add a nav heading or a page.
        </div>
      )}
    </div>
  );
}

// ── Design full view ──────────────────────────────────────────────
function DesignView({ site, onSave, saving }) {
  const [local, setLocal] = useState({
    primary_color:      site.primary_color      || '#3D6B34',
    secondary_color:    site.secondary_color    || '#819360',
    accent_color:       site.accent_color       || '#FFC567',
    bg_color:           site.bg_color           || '#FFFFFF',
    text_color:         site.text_color         || '#111827',
    font_family:        site.font_family        || 'Inter, sans-serif',
    logo_url:           site.logo_url           || '',
    nav_text_color:     site.nav_text_color     || '#FFFFFF',
    footer_bg_color:    site.footer_bg_color    || site.primary_color || '#3D6B34',
    copyright_text:     site.copyright_text     || '',
    // Top bar
    top_bar_enabled:    site.top_bar_enabled    || false,
    top_bar_html:       site.top_bar_html       || '',
    top_bar_bg_color:   site.top_bar_bg_color   || '#f8f5ef',
    top_bar_text_color: site.top_bar_text_color || '#333333',
    top_bar_align:      site.top_bar_align      || 'right',
    // Header banner
    header_banner_url:  site.header_banner_url  || '',
    header_height:      site.header_height      || 120,
    show_site_name:     site.show_site_name !== false, // default true
    // Nav bar
    nav_bg_image_url:   site.nav_bg_image_url   || '',
    // Width controls
    header_bg_width:      site.header_bg_width      || '100%',
    header_content_width: site.header_content_width || '100%',
    body_content_width:   site.body_content_width   || '100%',
    body_bg_width:        site.body_bg_width        || '100%',
    footer_content_width: site.footer_content_width || '100%',
    footer_bg_width:      site.footer_bg_width      || '100%',
    // Footer
    footer_bg_image_url:   site.footer_bg_image_url   || '',
    footer_html:           site.footer_html           || '',
    footer_height:         Number(site.footer_height)  || 200,
    copyright_bar_bg_color: site.copyright_bar_bg_color || '',
    // Header banner background (blank = use primary_color)
    header_banner_bg_color: site.header_banner_bg_color || '',
    // Page background
    bg_image_url:        site.bg_image_url        || '',
    bg_gradient:         site.bg_gradient         || '',
    // Local-only UI state for the page background picker
    bg_mode: (() => {
      if (site.bg_gradient && site.bg_gradient.includes('gradient')) return 'gradient';
      if (site.bg_color && site.bg_color !== '#FFFFFF' && site.bg_color !== '#ffffff') return 'solid';
      return 'none';
    })(),
    bg_gradient_color1: (() => {
      const m = (site.bg_gradient || '').match(/#[0-9a-fA-F]{3,6}/g);
      return m && m[0] ? m[0] : '#e8f5e9';
    })(),
    bg_gradient_color2: (() => {
      const m = (site.bg_gradient || '').match(/#[0-9a-fA-F]{3,6}/g);
      return m && m[1] ? m[1] : '#ffffff';
    })(),
    // Typography / type scale
    h1_size:          site.h1_size          || '40px',
    h1_weight:        site.h1_weight        || '800',
    h1_color:         site.h1_color         || '',
    h1_align:         site.h1_align         || 'left',
    h1_underline:     !!site.h1_underline,
    h1_rule:          !!site.h1_rule,
    h1_rule_color:    site.h1_rule_color    || '',
    h1_margin_top:    site.h1_margin_top    ?? 0,
    h1_margin_bottom: site.h1_margin_bottom ?? 8,
    h1_font:          site.h1_font          || '',
    h2_size:          site.h2_size          || '29px',
    h2_weight:        site.h2_weight        || '700',
    h2_color:         site.h2_color         || '',
    h2_align:         site.h2_align         || 'left',
    h2_underline:     !!site.h2_underline,
    h2_rule:          !!site.h2_rule,
    h2_rule_color:    site.h2_rule_color    || '',
    h2_margin_top:    site.h2_margin_top    ?? 0,
    h2_margin_bottom: site.h2_margin_bottom ?? 8,
    h2_font:          site.h2_font          || '',
    h3_size:          site.h3_size          || '21px',
    h3_weight:        site.h3_weight        || '600',
    h3_color:         site.h3_color         || '',
    h3_align:         site.h3_align         || 'left',
    h3_underline:     !!site.h3_underline,
    h3_rule:          !!site.h3_rule,
    h3_rule_color:    site.h3_rule_color    || '',
    h3_margin_top:    site.h3_margin_top    ?? 0,
    h3_margin_bottom: site.h3_margin_bottom ?? 6,
    h3_font:          site.h3_font          || '',
    h4_size:          site.h4_size          || '17px',
    h4_weight:        site.h4_weight        || '600',
    h4_color:         site.h4_color         || '',
    h4_align:         site.h4_align         || 'left',
    h4_underline:     !!site.h4_underline,
    h4_rule:          !!site.h4_rule,
    h4_rule_color:    site.h4_rule_color    || '',
    h4_margin_top:    site.h4_margin_top    ?? 0,
    h4_margin_bottom: site.h4_margin_bottom ?? 4,
    h4_font:          site.h4_font          || '',
    body_size:        site.body_size        || '16px',
    body_line_height: site.body_line_height || '1.75',
    body_color:       site.body_color       || '',
    body_align:       site.body_align       || 'left',
    body_underline:   !!site.body_underline,
    body_margin_top:    site.body_margin_top    ?? 0,
    body_margin_bottom: site.body_margin_bottom ?? 12,
    body_font:          site.body_font          || '',
    link_color:       site.link_color       || '',
    link_underline:   site.link_underline !== false,
  });

  const set = (key, val) => setLocal(p => ({ ...p, [key]: val }));
  const [designTab, setDesignTab] = useState('colors');

  const paletteColors = [local.primary_color, local.secondary_color, local.accent_color, local.bg_color, local.text_color, local.nav_text_color, local.footer_bg_color].filter(Boolean);

  const ColorRow = ({ label, field, hint }) => (
    <div className="flex items-center justify-between py-3 border-b border-gray-50 last:border-0">
      <div>
        <span className="text-sm font-medium text-gray-700">{label}</span>
        {hint && <p className="text-xs text-gray-400 mt-0.5">{hint}</p>}
      </div>
      <InlineColorPicker value={local[field]} onChange={v => set(field, v)} paletteColors={paletteColors} />
    </div>
  );

  // Checkerboard = transparent indicator
  const checkered = 'linear-gradient(45deg,#ccc 25%,transparent 25%),linear-gradient(-45deg,#ccc 25%,transparent 25%),linear-gradient(45deg,transparent 75%,#ccc 75%),linear-gradient(-45deg,transparent 75%,#ccc 75%)';

  // Transparent-aware color picker row: shows color picker + "Transparent" toggle
  const ColorRowTransparent = ({ label, field, hint, fallback }) => {
    const isTransp = local[field] === 'transparent';
    return (
      <div className="flex items-center justify-between py-3 border-b border-gray-50 last:border-0">
        <div>
          <span className="text-sm font-medium text-gray-700">{label}</span>
          {hint && <p className="text-xs text-gray-400 mt-0.5">{hint}</p>}
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          {!isTransp && (
            <InlineColorPicker value={local[field] || fallback} onChange={v => set(field, v)} paletteColors={paletteColors} />
          )}
          <button
            onClick={() => set(field, isTransp ? (fallback || '#ffffff') : 'transparent')}
            style={{
              display: 'flex', alignItems: 'center', gap: 5, fontSize: 11, padding: '4px 9px',
              borderRadius: 6, cursor: 'pointer', fontWeight: 500,
              border: isTransp ? '1.5px solid #3b82f6' : '1px solid #d1d5db',
              background: isTransp ? '#eff6ff' : '#fff',
              color: isTransp ? '#2563eb' : '#6b7280',
            }}
          >
            <span style={{ width: 12, height: 12, borderRadius: 2, display: 'inline-block', border: '1px solid #d1d5db',
              background: checkered, backgroundSize: '6px 6px',
              backgroundPosition: '0 0,0 3px,3px -3px,-3px 0' }} />
            {isTransp ? 'Transparent ✓' : 'Transparent'}
          </button>
        </div>
      </div>
    );
  };

  // ── Live header preview (all three zones) — called as function, not component ──
  const renderHeaderPreview = () => {
    const bgW = local.header_bg_width || '100%';
    const cW  = local.header_content_width || '100%';
    const transpTile = ['linear-gradient(45deg,#d1d5db 25%,transparent 25%)','linear-gradient(-45deg,#d1d5db 25%,transparent 25%)','linear-gradient(45deg,transparent 75%,#d1d5db 75%)','linear-gradient(-45deg,transparent 75%,#d1d5db 75%)'].join(',');
    const transpStyle = { backgroundImage: transpTile, backgroundSize: '14px 14px', backgroundPosition: '0 0,0 7px,7px -7px,-7px 0', backgroundColor: '#f9fafb' };
    const isTranspTopBar = local.top_bar_bg_color === 'transparent';
    const isTranspBanner = local.header_banner_bg_color === 'transparent';
    return (
      <div style={{ borderRadius: 8, overflow: 'hidden', marginTop: '0.75rem', border: '1px solid #e5e7eb', background: 'transparent', display: 'flex', justifyContent: 'center' }}>
        {/* Each zone carries its own background — outer band is transparent so transparent zones show page bg */}
        <div style={{ width: '100%', maxWidth: bgW, display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
          {local.top_bar_enabled && (
            <div style={{ width: '100%', maxWidth: cW, padding: '4px 10px', textAlign: local.top_bar_align,
              ...(isTranspTopBar ? transpStyle : { background: local.top_bar_bg_color || '#f8f5ef' }) }}>
              <span style={{ fontSize: 11, color: isTranspTopBar ? '#374151' : local.top_bar_text_color, fontFamily: local.font_family }}
                dangerouslySetInnerHTML={{ __html: local.top_bar_html || '<em>your-email@example.com | 555-123-4567</em>' }} />
            </div>
          )}
          {/* Banner constrained to header_content_width */}
          <div style={{ width: '100%', maxWidth: cW, position: 'relative' }}>
            {local.header_banner_url ? (
              <img src={local.header_banner_url} alt="" style={{ width: '100%', display: 'block' }} />
            ) : (
              <div style={{ height: Number(local.header_height) || 120,
                ...(isTranspBanner ? transpStyle : { background: local.header_banner_bg_color || local.primary_color }) }} />
            )}
            <div style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0, display: 'flex', alignItems: 'center', padding: '0 1rem', gap: '0.75rem' }}>
              {local.logo_url && (
                <img src={local.logo_url} alt="" style={{ height: 52, objectFit: 'contain', borderRadius: 4 }} />
              )}
              {local.show_site_name !== false && (
                <span style={{ fontWeight: 800, color: local.nav_text_color, fontFamily: local.font_family, fontSize: '1.25rem', textShadow: local.header_banner_url ? '1px 1px 4px rgba(0,0,0,0.55)' : 'none' }}>{site.site_name}</span>
              )}
            </div>
          </div>
          {/* Nav constrained to header_content_width */}
          <div style={{ width: '100%', maxWidth: cW, background: local.nav_bg_image_url ? `url(${local.nav_bg_image_url}) center/cover no-repeat` : local.primary_color, padding: '0 1rem', height: 38, display: 'flex', alignItems: 'center', gap: '1.25rem' }}>
            {['Home', 'About Us', 'Services', 'Contact'].map(n => (
              <span key={n} style={{ color: local.nav_text_color, fontSize: '0.72rem', fontWeight: 600, letterSpacing: '0.01em' }}>{n}</span>
            ))}
          </div>
        </div>
      </div>
    );
  };

  // Called as a function (not <FooterPreview />) to avoid React unmount/remount on every
  // DesignView render, which would cause stale closure snapshots of `local`.
  const renderFooterPreview = () => {
    const hasBgImage = !!local.footer_bg_image_url;
    const footerHeight = Number(local.footer_height) || 200;
    const bgW = local.footer_bg_width || '100%';
    const cW  = local.footer_content_width || '100%';
    const copyrightBg       = local.copyright_bar_bg_color; // '' | 'transparent' | hex
    const isTranspCopyright = copyrightBg === 'transparent';
    const isTranspFooter    = local.footer_bg_color === 'transparent';

    // Checkerboard tile — makes transparent areas visually obvious in preview
    const transpTile = [
      'linear-gradient(45deg,#d1d5db 25%,transparent 25%)',
      'linear-gradient(-45deg,#d1d5db 25%,transparent 25%)',
      'linear-gradient(45deg,transparent 75%,#d1d5db 75%)',
      'linear-gradient(-45deg,transparent 75%,#d1d5db 75%)',
    ].join(',');
    const transpStyle = { backgroundImage: transpTile, backgroundSize: '14px 14px', backgroundPosition: '0 0,0 7px,7px -7px,-7px 0', backgroundColor: '#f9fafb' };

    // Footer content area — independent background, checkerboard if transparent
    const footerContentStyle = isTranspFooter
      ? transpStyle
      : { background: local.footer_bg_color || local.primary_color || '#3D6B34' };

    // Copyright strip — independent background, checkerboard if transparent
    const copyrightStripStyle = isTranspCopyright
      ? transpStyle
      : { background: copyrightBg || 'rgba(0,0,0,0.15)' };

    const copyrightStrip = (
      <div style={{ ...copyrightStripStyle }}>
        <div style={{ maxWidth: cW, margin: '0 auto', padding: '0.5rem 1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <span style={{ fontSize: '0.68rem', color: isTranspCopyright ? '#374151' : 'rgba(255,255,255,0.65)' }}>
            {local.copyright_text || `© ${new Date().getFullYear()} ${site.site_name}`}
          </span>
          <a href="https://www.OatmealFarmNetwork.com" target="_blank" rel="noopener noreferrer"
            style={{ fontSize: '0.65rem', color: isTranspCopyright ? '#6b7280' : 'rgba(255,255,255,0.35)', textDecoration: 'none' }}>
            Powered by Oatmeal Farm Network
          </a>
        </div>
      </div>
    );

    return (
      <div style={{ borderRadius: 8, overflow: 'hidden', marginTop: '0.75rem', display: 'flex', justifyContent: 'center', fontFamily: local.font_family, border: '1px solid #e5e7eb' }}>
        {/* Outer band — no background; footer content and copyright each carry their own */}
        <div style={{ width: '100%', maxWidth: bgW }}>
          {hasBgImage ? (
            /* Image case: image as bg, copyright below */
            <>
              <img src={local.footer_bg_image_url} alt="" style={{ width: '100%', display: 'block' }} />
              {copyrightStrip}
            </>
          ) : (
            /* No image: plain block siblings — minHeight on footer content drives the height slider */
            <>
              <div style={{ minHeight: footerHeight, ...footerContentStyle }}>
                <div style={{ maxWidth: cW, margin: '0 auto' }}>
                  {local.footer_html ? (
                    <div style={{ padding: '1rem', color: isTranspFooter ? '#374151' : '#fff', fontSize: '0.82rem', lineHeight: 1.6 }}
                      dangerouslySetInnerHTML={{ __html: local.footer_html }} />
                  ) : (
                    <div style={{ padding: '1rem', color: isTranspFooter ? '#9ca3af' : 'rgba(255,255,255,0.35)', fontSize: '0.75rem', fontStyle: 'italic' }}>
                      No footer content — add some in the Footer Content box below.
                    </div>
                  )}
                </div>
              </div>
              {copyrightStrip}
            </>
          )}
        </div>
      </div>
    );
  };

  return (
    <div>
      <div className="flex items-center justify-between mb-1">
        <h2 className="text-lg font-bold text-gray-900">Design</h2>
        <button onClick={() => onSave(local)} disabled={saving}
          className="regsubmit2 px-6 py-2 text-sm disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Design'}
        </button>
      </div>
      <p className="text-sm text-gray-500 mb-4">Customize the look, colors, fonts, header, and footer of your website.</p>

      {/* ── Tab bar ── */}
      <div className="flex gap-1 mb-5 bg-gray-100 rounded-xl p-1">
        {[['colors','Colors & Widths'],['typography','Typography'],['header','Header & Footer']].map(([id, label]) => (
          <button key={id} onClick={() => setDesignTab(id)}
            className={`flex-1 py-2 rounded-lg text-sm font-medium transition-colors
              ${designTab === id ? 'bg-white text-gray-900 shadow-sm' : 'text-gray-500 hover:text-gray-700'}`}>
            {label}
          </button>
        ))}
      </div>

      {/* ══ COLORS TAB ══ */}
      {designTab === 'colors' && (
        <div>
          {/* Colors: palettes + page colors */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 mb-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Colors</h3>
            <p className="text-xs text-gray-400 mb-4">Apply a preset palette or fine-tune individual colors by clicking any swatch.</p>
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3 mb-5">
              {TEMPLATES.map(t => {
                const active = local.primary_color === t.primary_color && local.secondary_color === t.secondary_color;
                return (
                  <button key={t.id}
                    onClick={() => setLocal(p => ({ ...p, primary_color: t.primary_color, secondary_color: t.secondary_color, accent_color: t.accent_color, bg_color: t.bg_color, text_color: t.text_color, nav_text_color: t.nav_text_color, footer_bg_color: t.footer_bg_color, font_family: t.font_family }))}
                    className={`rounded-xl border-2 overflow-hidden text-left transition-all ${active ? 'border-[#3D6B34] shadow-md ring-2 ring-[#3D6B34]/20' : 'border-gray-100 hover:border-gray-300'}`}>
                    <div className="flex h-7">{[t.primary_color, t.secondary_color, t.accent_color, t.bg_color].map((c, i) => <div key={i} className="flex-1" style={{ background: c }} />)}</div>
                    <div className="px-2 py-1" style={{ background: t.primary_color }}><span className="text-xs font-bold truncate block" style={{ color: t.nav_text_color, fontFamily: t.font_family }}>{t.name}</span></div>
                    <div className="px-2 py-1" style={{ background: t.bg_color }}><span className="text-xs truncate block" style={{ color: t.text_color, fontFamily: t.font_family }}>Sample text</span></div>
                  </button>
                );
              })}
            </div>
            <div className="border-t border-gray-100 pt-4">
              <p className="text-xs font-semibold text-gray-500 mb-3">Page Colors</p>
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
                {[
                  { label: 'Secondary / Accent', field: 'secondary_color', hint: 'Hover states and accents' },
                  { label: 'Button / Highlight', field: 'accent_color',    hint: 'CTA buttons and highlights' },
                  { label: 'Section Background', field: 'bg_color',        hint: 'Content sections and cards' },
                  { label: 'Body Text',          field: 'text_color',      hint: 'Main text color' },
                ].map(({ label, field, hint }) => (
                  <div key={field} className="flex flex-col gap-1">
                    <span className="text-xs font-semibold text-gray-700 leading-tight">{label}</span>
                    <span className="text-[10px] text-gray-400 leading-tight">{hint}</span>
                    <InlineColorPicker value={local[field]} onChange={v => set(field, v)} paletteColors={paletteColors} />
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* Content Widths */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 mb-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Content Widths</h3>
            <p className="text-xs text-gray-400 mb-4">Control how wide the background band and inner content are for each zone. All zones are centered on the page.</p>
            <div className="flex flex-col lg:flex-row gap-6">
              <div className="flex flex-col gap-4 flex-1">
                <div className="border-l-4 pl-3" style={{ borderColor: local.primary_color }}>
                  <p className="text-xs font-semibold text-gray-500 mb-1">Header</p>
                  <WidthControl label="Header Background Width" hint="How wide the header color/image band spans." value={local.header_bg_width} onChange={v => set('header_bg_width', v)} />
                  <WidthControl label="Header Content Width" hint="Width of the logo, site name, and nav bar within the header band." value={local.header_content_width} onChange={v => set('header_content_width', v)} />
                </div>
                <div className="border-l-4 pl-3" style={{ borderColor: local.secondary_color }}>
                  <p className="text-xs font-semibold text-gray-500 mb-1">Body</p>
                  <WidthControl label="Body Background Width" hint="Width of the color band behind each content block." value={local.body_bg_width} onChange={v => set('body_bg_width', v)} />
                  <WidthControl label="Body Text Width" hint="Width of the text/content inside each block (must be ≤ background width)." value={local.body_content_width} onChange={v => set('body_content_width', v)} />
                </div>
                <div className="border-l-4 pl-3" style={{ borderColor: local.footer_bg_color }}>
                  <p className="text-xs font-semibold text-gray-500 mb-1">Footer</p>
                  <WidthControl label="Footer Background Width" hint="How wide the footer color/image band spans." value={local.footer_bg_width} onChange={v => set('footer_bg_width', v)} />
                  <WidthControl label="Footer Content Width" hint="Width of the footer text and copyright bar within the footer band." value={local.footer_content_width} onChange={v => set('footer_content_width', v)} />
                </div>
              </div>
              <div className="flex-1 min-w-0 lg:min-w-72">
                <p className="text-xs font-semibold text-gray-500 mb-2">Live Preview</p>
                <WidthDiagram local={local} />
              </div>
            </div>
          </div>

          {/* Page Background */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Page Background</h3>
            <p className="text-xs text-gray-400 mb-4">Sets the background behind all page content. An image overrides the color or gradient.</p>
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">Background Type</label>
              <div className="flex gap-2">
                {[['none','None'],['solid','Solid Color'],['gradient','Vertical Gradient']].map(([mode, label]) => (
                  <button key={mode} onClick={() => {
                    if (mode === 'none') setLocal(p => ({ ...p, bg_mode: 'none', bg_gradient: '', bg_color: '#FFFFFF' }));
                    else if (mode === 'solid') setLocal(p => ({ ...p, bg_mode: 'solid', bg_gradient: '' }));
                    else { const c1 = local.bg_gradient_color1 || '#e8f5e9'; const c2 = local.bg_gradient_color2 || '#ffffff'; setLocal(p => ({ ...p, bg_mode: 'gradient', bg_gradient: `linear-gradient(to bottom, ${c1}, ${c2})` })); }
                  }}
                    className={`flex-1 py-2 rounded-lg text-xs font-semibold border transition-colors ${local.bg_mode === mode ? 'bg-[#3D6B34] text-white border-[#3D6B34]' : 'border-gray-200 text-gray-600 hover:border-gray-400'}`}>
                    {label}
                  </button>
                ))}
              </div>
            </div>
            {local.bg_mode === 'solid' && (
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">Color</label>
                <InlineColorPicker value={local.bg_color} onChange={v => set('bg_color', v)} paletteColors={[local.primary_color, local.secondary_color, local.accent_color, local.bg_color, local.text_color].filter(Boolean)} />
                <div className="mt-3 h-10 rounded-lg border border-gray-200" style={{ background: local.bg_color }} />
              </div>
            )}
            {local.bg_mode === 'gradient' && (
              <div className="mb-4">
                <div className="flex flex-col gap-3">
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1.5">Top Color</label>
                    <InlineColorPicker value={local.bg_gradient_color1} onChange={v => { const c2 = local.bg_gradient_color2 || '#ffffff'; setLocal(p => ({ ...p, bg_gradient_color1: v, bg_gradient: `linear-gradient(to bottom, ${v}, ${c2})` })); }} paletteColors={[local.primary_color, local.secondary_color, local.accent_color, local.bg_color, local.text_color].filter(Boolean)} />
                  </div>
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1.5">Bottom Color</label>
                    <InlineColorPicker value={local.bg_gradient_color2} onChange={v => { const c1 = local.bg_gradient_color1 || '#e8f5e9'; setLocal(p => ({ ...p, bg_gradient_color2: v, bg_gradient: `linear-gradient(to bottom, ${c1}, ${v})` })); }} paletteColors={[local.primary_color, local.secondary_color, local.accent_color, local.bg_color, local.text_color].filter(Boolean)} />
                  </div>
                </div>
                <div className="mt-3">
                  <p className="text-xs text-gray-400 mb-2">Presets</p>
                  <div className="flex flex-wrap gap-1.5">
                    {[['Warm Sand','#fdf6e3','#e8d5b7'],['Soft Sky','#e0f2fe','#bae6fd'],['Meadow','#f0fdf4','#bbf7d0'],['Sunset','#fff7ed','#fed7aa'],['Slate','#f8fafc','#e2e8f0'],['Lavender','#faf5ff','#e9d5ff']].map(([name,c1,c2]) => (
                      <button key={name} onClick={() => setLocal(p => ({ ...p, bg_gradient_color1: c1, bg_gradient_color2: c2, bg_gradient: `linear-gradient(to bottom, ${c1}, ${c2})` }))}
                        className="px-2.5 py-1.5 rounded-lg text-xs border border-gray-200 hover:border-gray-400 transition-colors font-medium" style={{ background: `linear-gradient(to bottom, ${c1}, ${c2})` }}>
                        {name}
                      </button>
                    ))}
                  </div>
                </div>
                {local.bg_gradient && <div className="mt-3 h-14 rounded-lg border border-gray-200" style={{ background: local.bg_gradient }} />}
              </div>
            )}
            <div className={local.bg_mode !== 'none' ? 'mt-2 pt-4 border-t border-gray-100' : ''}>
              <ImageUploadField label="Background Image" value={local.bg_image_url} onChange={url => set('bg_image_url', url)} hint="Overrides the color or gradient above. Leave blank to use the color/gradient setting." />
            </div>
          </div>
        </div>
      )}

      {/* ══ TYPOGRAPHY TAB ══ */}
      {designTab === 'typography' && (
        <div>
          {/* Base font */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 mb-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Base Font</h3>
            <p className="text-xs text-gray-400 mb-3">The default font used across the entire site. Individual heading levels can override this below.</p>
            <FontPickerDropdown
              value={local.font_family}
              onChange={v => set('font_family', v)}
              dark={false}
            />
            <div className="mt-3 p-4 rounded-lg border border-gray-100 grid grid-cols-2 gap-4" style={{ background: local.bg_color, fontFamily: local.font_family }}>
              <div>
                <p style={{ color: local.text_color, fontWeight: 800, fontSize: '1.5rem', margin: '0 0 2px 0', lineHeight: 1.2 }}>Heading</p>
                <p style={{ color: local.text_color, fontSize: '0.9rem', margin: 0, opacity: 0.75, lineHeight: 1.6 }}>Body paragraph text. The quick brown fox jumps over the lazy dog.</p>
              </div>
              <div style={{ textAlign: 'right' }}>
                <p style={{ color: local.text_color, fontWeight: 600, fontSize: '1rem', margin: '0 0 2px 0' }}>Subheading</p>
                <p style={{ color: local.link_color || local.accent_color, fontSize: '0.9rem', margin: 0, textDecoration: local.link_underline !== false ? 'underline' : 'none' }}>Link example</p>
                <p style={{ color: local.text_color, fontSize: '0.75rem', margin: '4px 0 0 0', opacity: 0.5 }}>0 1 2 3 4 5 6 7 8 9</p>
              </div>
            </div>
          </div>

          {/* Type scale */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 mb-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Type Scale</h3>
            <p className="text-xs text-gray-400 mb-4">Set size, weight, and color for each heading and text level. Click a color swatch to change it.</p>

            {[
              { key: 'h1',   label: 'H1',        sample: 'Page Title',           defaultSize: '40px', defaultWeight: '800', hasRule: true },
              { key: 'h2',   label: 'H2',        sample: 'Section Heading',      defaultSize: '29px', defaultWeight: '700', hasRule: true },
              { key: 'h3',   label: 'H3',        sample: 'Sub Heading',          defaultSize: '21px', defaultWeight: '600', hasRule: true },
              { key: 'h4',   label: 'H4 / Lead', sample: 'Card Title',           defaultSize: '17px', defaultWeight: '600', hasRule: true },
              { key: 'body', label: 'Body',       sample: 'Paragraph body text — the main content of your pages.', defaultSize: '16px', defaultWeight: '400', hasRule: false },
            ].map(({ key, label, sample, defaultSize, defaultWeight, hasRule }) => {
              const sizeKey        = `${key}_size`;
              const weightKey      = `${key}_weight`;
              const colorKey       = `${key}_color`;
              const alignKey       = `${key}_align`;
              const underlineKey   = `${key}_underline`;
              const ruleKey        = `${key}_rule`;
              const ruleColorKey   = `${key}_rule_color`;
              const marginTopKey   = `${key}_margin_top`;
              const marginBotKey   = `${key}_margin_bottom`;
              const fontKey        = `${key}_font`;
              const color     = local[colorKey] || local.text_color || '#111827';
              const align     = local[alignKey] || 'left';
              const ruleColor = local[ruleColorKey] || local.text_color || '#111827';
              const ALIGN_LABELS = { left: 'Left', center: 'Center', right: 'Right', justify: 'Justify' };
              return (
                <div key={key} className="py-3 border-b border-gray-50 last:border-0">
                  {/* Row 1: Level | Preview | Size | Weight | Color */}
                  <div className="grid items-center gap-2 mb-2" style={{ gridTemplateColumns: '64px 1fr 80px 110px auto' }}>
                    <span className="text-xs font-bold text-gray-500">{label}</span>
                    <div className="min-w-0 overflow-hidden">
                      <p className="truncate m-0" style={{
                        fontFamily: local[fontKey] || local.font_family,
                        fontSize: local[sizeKey] || defaultSize,
                        fontWeight: local[weightKey] || defaultWeight,
                        color,
                        lineHeight: 1.3,
                        textAlign: align,
                        textDecoration: local[underlineKey] ? 'underline' : 'none',
                        borderBottom: hasRule && local[ruleKey] ? `2px solid ${ruleColor}` : 'none',
                        paddingBottom: hasRule && local[ruleKey] ? 4 : 0,
                        display: 'inline-block',
                        width: '100%',
                      }}>
                        {sample}
                      </p>
                    </div>
                    {/* Size: single dropdown showing current value */}
                    <select
                      value={local[sizeKey] || defaultSize}
                      onChange={e => set(sizeKey, e.target.value)}
                      className="border border-gray-200 rounded-lg px-1 py-1 text-xs focus:outline-none focus:ring-1 focus:ring-green-300 w-full"
                    >
                      {!['8px','9px','10px','11px','12px','13px','14px','15px','16px','17px','18px','20px','22px','24px'].includes(local[sizeKey] || defaultSize) && (
                        <option value={local[sizeKey] || defaultSize}>{local[sizeKey] || defaultSize}</option>
                      )}
                      {['8px','9px','10px','11px','12px','13px','14px','15px','16px','17px','18px','20px','22px','24px'].map(s => <option key={s} value={s}>{s}</option>)}
                    </select>
                    <select value={local[weightKey] || defaultWeight} onChange={e => set(weightKey, e.target.value)}
                      className="border border-gray-200 rounded-lg px-1.5 py-1 text-xs focus:outline-none focus:ring-1 focus:ring-green-300">
                      <option value="400">Normal (400)</option>
                      <option value="500">Medium (500)</option>
                      <option value="600">Semibold (600)</option>
                      <option value="700">Bold (700)</option>
                      <option value="800">Extra Bold (800)</option>
                    </select>
                    <InlineColorPicker value={color} onChange={v => set(colorKey, v)} paletteColors={paletteColors} popupAlign="right" />
                  </div>
                  {/* Row 2: Align | Underline | Rule (headings only) */}
                  <div className="flex items-center gap-3 pl-16 flex-wrap">
                    <div className="flex gap-1">
                      {['left','center','right','justify'].map(a => (
                        <button key={a} onClick={() => set(alignKey, a)} title={ALIGN_LABELS[a]}
                          className={`w-7 h-7 rounded text-xs flex items-center justify-center border transition-colors ${align === a ? 'bg-blue-50 border-blue-400 text-blue-600' : 'border-gray-200 text-gray-400 hover:border-gray-400'}`}>
                          {a === 'left' ? '▤' : a === 'center' ? '▥' : a === 'right' ? '▦' : '▪'}
                        </button>
                      ))}
                    </div>
                    <div className="w-px h-5 bg-gray-200" />
                    <label className="flex items-center gap-1.5 cursor-pointer select-none">
                      <input type="checkbox" checked={!!local[underlineKey]} onChange={e => set(underlineKey, e.target.checked)} className="w-3.5 h-3.5 accent-blue-500" />
                      <span className="text-xs text-gray-500" style={{ textDecoration: 'underline' }}>Underline</span>
                    </label>
                    {hasRule && (
                      <>
                        <div className="w-px h-5 bg-gray-200" />
                        <label className="flex items-center gap-1.5 cursor-pointer select-none">
                          <input type="checkbox" checked={!!local[ruleKey]} onChange={e => set(ruleKey, e.target.checked)} className="w-3.5 h-3.5 accent-blue-500" />
                          <span className="text-xs text-gray-500">Rule</span>
                        </label>
                        {local[ruleKey] && (
                          <div className="flex items-center gap-1.5">
                            <span className="text-xs text-gray-400">Color</span>
                            <InlineColorPicker value={ruleColor} onChange={v => set(ruleColorKey, v)} paletteColors={paletteColors} popupAlign="right" />
                          </div>
                        )}
                      </>
                    )}
                    <div className="w-px h-5 bg-gray-200" />
                    <div className="flex items-center gap-1.5">
                      <span className="text-xs text-gray-400">Margin</span>
                      <span className="text-xs text-gray-400">↑</span>
                      <input type="number" min="0" max="200" value={local[marginTopKey] ?? 0}
                        onChange={e => set(marginTopKey, Number(e.target.value))}
                        className="w-12 border border-gray-200 rounded px-1 py-0.5 text-xs text-center focus:outline-none focus:ring-1 focus:ring-green-300" />
                      <span className="text-xs text-gray-400">↓</span>
                      <input type="number" min="0" max="200" value={local[marginBotKey] ?? 0}
                        onChange={e => set(marginBotKey, Number(e.target.value))}
                        className="w-12 border border-gray-200 rounded px-1 py-0.5 text-xs text-center focus:outline-none focus:ring-1 focus:ring-green-300" />
                      <span className="text-xs text-gray-400">px</span>
                    </div>
                    <div className="w-px h-5 bg-gray-200" />
                    <div className="flex items-center gap-1.5">
                      <span className="text-xs text-gray-400">Font</span>
                      <FontPickerDropdown
                        value={local[fontKey] || ''}
                        onChange={v => set(fontKey, v)}
                        globalFont={local.font_family}
                        dark={false}
                      />
                    </div>
                  </div>
                </div>
              );
            })}

            {/* Body line height row */}
            <div className="flex items-center gap-3 pt-3 border-t border-gray-100 mt-1">
              <span className="text-xs font-bold text-gray-500 w-16 shrink-0">Body Line Height</span>
              <input type="text" value={local.body_line_height || '1.75'} onChange={e => set('body_line_height', e.target.value)}
                className="w-20 border border-gray-200 rounded-lg px-2 py-1 text-xs font-mono text-center focus:outline-none focus:ring-1 focus:ring-green-300" />
              <span className="text-xs text-gray-400">e.g. 1.5, 1.75, 2 — controls spacing between body text lines</span>
            </div>
          </div>

          {/* Links */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Links</h3>
            <p className="text-xs text-gray-400 mb-4">Style for hyperlinks within body content.</p>
            <div className="flex items-center gap-4">
              <div className="flex-1 p-3 rounded-lg border border-gray-100" style={{ background: local.bg_color }}>
                <span style={{
                  fontFamily: local.font_family,
                  fontSize: local.body_size || '1rem',
                  color: local.link_color || local.accent_color || '#FFC567',
                  textDecoration: local.link_underline !== false ? 'underline' : 'none',
                }}>
                  Click here to learn more
                </span>
              </div>
              <div className="flex flex-col gap-3 shrink-0">
                <div className="flex items-center gap-2">
                  <label className="text-xs font-medium text-gray-600 w-12">Color</label>
                  <InlineColorPicker value={local.link_color || local.accent_color || '#FFC567'} onChange={v => set('link_color', v)} paletteColors={paletteColors} />
                </div>
                <label className="flex items-center gap-2 cursor-pointer">
                  <input type="checkbox" checked={local.link_underline !== false} onChange={e => set('link_underline', e.target.checked)} className="w-4 h-4 accent-green-600" />
                  <span className="text-xs font-medium text-gray-600" style={{ textDecoration: 'underline' }}>Underline links</span>
                </label>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ══ HEADER TAB ══ */}
      {designTab === 'header' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
          {/* Top Bar */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
            <div className="flex items-center justify-between pb-2 border-b border-gray-100 mb-3">
              <div>
                <h3 className="font-bold text-gray-800">Top Bar</h3>
                <p className="text-xs text-gray-400 mt-0.5">Optional strip above the header — great for contact info or announcements.</p>
              </div>
              <label className="flex items-center gap-2 cursor-pointer">
                <input type="checkbox" checked={!!local.top_bar_enabled} onChange={e => set('top_bar_enabled', e.target.checked)} className="w-4 h-4 accent-green-600" />
                <span className="text-sm font-medium text-gray-700">Enabled</span>
              </label>
            </div>
            {local.top_bar_enabled && (
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div className="sm:col-span-2">
                  <label className="block text-sm font-medium text-gray-700 mb-1">Content</label>
                  <TopBarEditor value={local.top_bar_html} onChange={v => set('top_bar_html', v)} bgColor={local.top_bar_bg_color}
                    paletteColors={[local.primary_color, local.secondary_color, local.accent_color, local.bg_color, local.text_color, local.nav_text_color, local.footer_bg_color, local.top_bar_bg_color, local.top_bar_text_color].filter(Boolean)} />
                  <p className="text-xs text-gray-400 mt-1">Highlight text to apply formatting. Use 🔗 to insert a link or email address.</p>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">Background Color</label>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8, flexWrap: 'wrap' }}>
                    {local.top_bar_bg_color !== 'transparent' && (
                      <InlineColorPicker value={local.top_bar_bg_color || '#f8f5ef'} onChange={v => set('top_bar_bg_color', v)} paletteColors={paletteColors} />
                    )}
                    <button
                      onClick={() => set('top_bar_bg_color', local.top_bar_bg_color === 'transparent' ? '#f8f5ef' : 'transparent')}
                      style={{ display:'flex', alignItems:'center', gap:5, fontSize:11, padding:'4px 9px', borderRadius:6, cursor:'pointer', fontWeight:500,
                        border: local.top_bar_bg_color === 'transparent' ? '1.5px solid #3b82f6' : '1px solid #d1d5db',
                        background: local.top_bar_bg_color === 'transparent' ? '#eff6ff' : '#fff',
                        color: local.top_bar_bg_color === 'transparent' ? '#2563eb' : '#6b7280' }}>
                      <span style={{ width:12, height:12, borderRadius:2, display:'inline-block', border:'1px solid #d1d5db',
                        background: checkered, backgroundSize:'6px 6px', backgroundPosition:'0 0,0 3px,3px -3px,-3px 0' }} />
                      {local.top_bar_bg_color === 'transparent' ? 'Transparent ✓' : 'Transparent'}
                    </button>
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Text Color</label>
                  <InlineColorPicker value={local.top_bar_text_color} onChange={v => set('top_bar_text_color', v)} paletteColors={paletteColors} />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Alignment</label>
                  <div className="flex gap-2">
                    {[['left','Left'],['center','Center'],['right','Right']].map(([v,l]) => (
                      <button key={v} onClick={() => set('top_bar_align', v)}
                        className={`flex-1 py-1.5 rounded-lg text-xs font-medium border transition-colors ${local.top_bar_align === v ? 'bg-[#3D6B34] text-white border-[#3D6B34]' : 'border-gray-200 text-gray-600 hover:border-gray-300'}`}>
                        {l}
                      </button>
                    ))}
                  </div>
                </div>
              </div>
            )}
          </div>

          {/* Header Banner */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Header Banner</h3>
            <p className="text-xs text-gray-400 mb-3">Large image area above the navigation — contains your logo and site name.</p>
            <HeaderImagesManager websiteId={site.website_id} hideTitle />
            <div className="mt-4 pt-4 border-t border-gray-100">
              <FormField label="Banner Height (px)">
                <div className="flex items-center gap-3">
                  <input type="range" min={60} max={400} value={local.header_height || 120} onChange={e => set('header_height', Number(e.target.value))} className="flex-1 accent-green-600" />
                  <span className="text-sm font-mono text-gray-600 w-12">{local.header_height || 120}px</span>
                </div>
              </FormField>
              <div className="mt-3">
                <ImageUploadField label="Logo" value={local.logo_url} onChange={url => set('logo_url', url)} hint="Appears in the banner. Recommended: PNG with transparent background." />
              </div>
              <ColorRowTransparent label="Banner Background Color" field="header_banner_bg_color" fallback={local.primary_color || '#3D6B34'} hint="Solid color shown when no banner image is uploaded. Transparent shows nothing behind the logo." />
              <ColorRow label="Site Name / Logo Text Color" field="nav_text_color" hint="Color of the site name displayed in the banner" />
              <div className="flex items-center justify-between py-3 border-t border-gray-50 mt-1">
                <div>
                  <span className="text-sm font-medium text-gray-700">Show Site Name</span>
                  <p className="text-xs text-gray-400 mt-0.5">Hide if your logo already contains your site name</p>
                </div>
                <label className="flex items-center gap-2 cursor-pointer">
                  <input type="checkbox" checked={local.show_site_name !== false} onChange={e => set('show_site_name', e.target.checked)} className="w-4 h-4 accent-green-600" />
                  <span className="text-sm text-gray-600">{local.show_site_name !== false ? 'Visible' : 'Hidden'}</span>
                </label>
              </div>
            </div>
          </div>

          {/* Navigation Bar */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Navigation Bar</h3>
            <p className="text-xs text-gray-400 mb-3">The bar containing your site's navigation links.</p>
            <div className="mb-3">
              <ImageUploadField label="Nav Bar Background Image" value={local.nav_bg_image_url} onChange={url => set('nav_bg_image_url', url)} hint="Optional texture or image behind the nav links. Leave blank to use the solid color below." />
            </div>
            <ColorRow label="Nav Background Color" field="primary_color" hint="Solid color — used when no background image is set, or as overlay" />
            <ColorRow label="Nav Link Color" field="nav_text_color" hint="Color of the navigation links" />
            <p className="text-xs text-gray-400 mt-3">Live preview below shows top bar + banner + nav together.</p>
            {renderHeaderPreview()}
          </div>

          {/* ── Footer ── */}
          <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
            <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Footer</h3>
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mt-3">
              <div>
                <div className="mb-3">
                  <ImageUploadField label="Background Image" value={local.footer_bg_image_url} onChange={url => set('footer_bg_image_url', url)} hint="Optional texture or image. Leave blank to use the solid color." />
                </div>
                <ColorRowTransparent label="Footer Background Color" field="footer_bg_color" fallback={local.primary_color || '#3D6B34'} hint="Used when no background image is set" />
                <ColorRowTransparent label="Copyright Bar Background" field="copyright_bar_bg_color" fallback="rgba(0,0,0,0.15)" hint="Strip at the very bottom containing the copyright line" />
                <div className="mt-3">
                  <label className="block text-sm font-medium text-gray-700 mb-1">Footer Height (px)</label>
                  <div className="flex items-center gap-3">
                    <input type="range" min={80} max={600} value={local.footer_height || 200} onChange={e => set('footer_height', Number(e.target.value))} className="flex-1 accent-green-600" />
                    <span className="text-sm font-mono text-gray-600 w-12">{local.footer_height || 200}px</span>
                  </div>
                </div>
              </div>
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-1">Copyright Text</label>
                <p className="text-xs text-gray-400 mb-2">Always displayed in the lower-left corner of the footer.</p>
                <input className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-300"
                  placeholder={`© ${new Date().getFullYear()} ${site.site_name} · All rights reserved`}
                  value={local.copyright_text} onChange={e => set('copyright_text', e.target.value)} />
                <p className="text-xs text-gray-400 mt-1">Leave blank to use the default copyright line.</p>
              </div>
            </div>
            <div className="mt-4">
              <div className="flex items-center justify-between mb-2">
                <div>
                  <label className="block text-sm font-semibold text-gray-700">Footer Content</label>
                  <p className="text-xs text-gray-400 mt-0.5">Displayed above the copyright bar. Clear all text to remove.</p>
                </div>
                {local.footer_html && (
                  <button onClick={() => set('footer_html', '')} className="text-xs text-red-500 border border-red-200 rounded-lg px-3 py-1 hover:bg-red-50 transition-colors">
                    Remove Content
                  </button>
                )}
              </div>
              <TopBarEditor value={local.footer_html} onChange={v => set('footer_html', v)}
                bgColor={local.footer_bg_image_url ? undefined : local.footer_bg_color}
                paletteColors={[local.primary_color, local.secondary_color, local.accent_color, local.bg_color, local.text_color, local.nav_text_color, local.footer_bg_color].filter(Boolean)} />
            </div>
            <div className="mt-4">
              <p className="text-xs text-gray-400 mb-2 font-medium">Preview</p>
              {renderFooterPreview()}
            </div>
          </div>
        </div>
      )}

      {/* Always visible: palette strip + save */}
      <div className="mt-5 flex justify-end">
        <button onClick={() => onSave(local)} disabled={saving}
          className="regsubmit2 px-8 py-2.5 text-sm disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Design'}
        </button>
      </div>
    </div>
  );
}

// ── Version History panel ─────────────────────────────────────────
function VersionHistoryPanel({ websiteId }) {
  const [versions, setVersions]   = useState([]);
  const [label, setLabel]         = useState('');
  const [saving, setSaving]       = useState(false);
  const [restoring, setRestoring] = useState(false);

  const load = () => {
    fetch(`${API}/api/website/versions/${websiteId}`, { headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` } })
      .then(r => r.json()).then(d => setVersions(Array.isArray(d) ? d : [])).catch(() => {});
  };
  useEffect(() => { if (websiteId) load(); }, [websiteId]);

  const save = async () => {
    setSaving(true);
    try {
      await fetch(`${API}/api/website/versions`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${localStorage.getItem('access_token')}` },
        body: JSON.stringify({ website_id: websiteId, version_label: label || undefined }),
      });
      setLabel('');
      load();
    } catch { alert('Could not save version.'); }
    finally { setSaving(false); }
  };

  const restore = async (vid, lbl) => {
    if (!window.confirm(`Restore version "${lbl}"? Your current site will be replaced.`)) return;
    setRestoring(vid);
    try {
      await fetch(`${API}/api/website/versions/${vid}/restore`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
      });
      window.location.reload();
    } catch { alert('Could not restore version.'); }
    finally { setRestoring(false); }
  };

  return (
    <div>
      <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Version History</h3>
      <p className="text-xs text-gray-400 mb-3">Save a snapshot of your site to roll back later.</p>
      <div className="flex gap-2 mb-4">
        <input className="flex-1 border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-300"
          placeholder="Version label (Optional)"
          value={label} onChange={e => setLabel(e.target.value)} />
        <button onClick={save} disabled={saving}
          className="bg-[#3D6B34] text-white text-sm font-semibold px-4 rounded-lg hover:bg-[#2d5226] transition-colors disabled:opacity-50">
          {saving ? '…' : 'Save Version'}
        </button>
      </div>
      {versions.length === 0
        ? <p className="text-xs text-gray-400">No saved versions yet.</p>
        : (
          <div className="space-y-2">
            {versions.map(v => (
              <div key={v.version_id} className="flex items-center justify-between bg-gray-50 rounded-xl px-4 py-3 border border-gray-100">
                <div>
                  <p className="text-sm font-medium text-gray-800">{v.version_label || `Version ${v.version_id}`}</p>
                  <p className="text-xs text-gray-400 mt-0.5">{new Date(v.created_at).toLocaleString()}</p>
                </div>
                <button onClick={() => restore(v.version_id, v.version_label || `Version ${v.version_id}`)}
                  disabled={restoring === v.version_id}
                  className="text-xs font-medium text-[#3D6B34] border border-[#3D6B34]/30 px-3 py-1.5 rounded-lg hover:bg-green-50 transition-colors disabled:opacity-50">
                  {restoring === v.version_id ? 'Restoring…' : 'Restore'}
                </button>
              </div>
            ))}
          </div>
        )
      }
    </div>
  );
}

// ── Settings full view ────────────────────────────────────────────
function SettingsView({ site, onSave, saving, onDelete }) {
  const [local, setLocal] = useState({
    site_name:     site.site_name     || '',
    slug:          site.slug          || '',
    tagline:       site.tagline       || '',
    phone:         site.phone         || '',
    email:         site.email         || '',
    address:       site.address       || '',
    facebook_url:  site.facebook_url  || '',
    instagram_url: site.instagram_url || '',
    twitter_url:   site.twitter_url   || '',
    meta_title:    site.meta_title    || '',
    canonical_url: site.canonical_url || '',
    og_image_url:  site.og_image_url  || '',
    seo_extras_json: site.seo_extras_json || '{}',
  });

  const fi = (key, label, placeholder = '', type = 'text') => (
    <FormField label={label}>
      <input type={type} className={inp} value={local[key]} placeholder={placeholder}
        onChange={e => setLocal(p => ({ ...p, [key]: e.target.value }))} />
    </FormField>
  );

  return (
    <div>
      <h2 className="text-lg font-bold text-gray-900 mb-1">Settings</h2>
      <p className="text-sm text-gray-500 mb-5">Update your site name, contact information, and social links.</p>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
          <h3 className="font-bold text-gray-800 mb-4 pb-2 border-b border-gray-100">Site Info</h3>
          {fi('site_name', 'Site Name')}
          <FormField label="URL Slug">
            <div className="flex items-center gap-2">
              <span className="text-sm text-gray-400 shrink-0">/sites/</span>
              <input className={inp} value={local.slug} placeholder="my-farm"
                onChange={e => setLocal(p => ({ ...p, slug: slugify(e.target.value) }))} />
            </div>
          </FormField>
          {fi('tagline', 'Tagline', 'Fresh, local, sustainably grown.')}
        </div>

        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
          <h3 className="font-bold text-gray-800 mb-4 pb-2 border-b border-gray-100">Contact Info</h3>
          {fi('phone', 'Phone', '(555) 000-0000', 'tel')}
          {fi('email', 'Email', 'hello@yourfarm.com', 'email')}
          {fi('address', 'Address', '123 Farm Rd, Town, ST 12345')}
        </div>

        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
          <h3 className="font-bold text-gray-800 mb-4 pb-2 border-b border-gray-100">Social Media</h3>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            {fi('facebook_url',  'Facebook URL',  'https://facebook.com/yourpage')}
            {fi('instagram_url', 'Instagram URL', 'https://instagram.com/yourhandle')}
            {fi('twitter_url',   'X / Twitter URL', 'https://x.com/yourhandle')}
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
          <h3 className="font-bold text-gray-800 mb-4 pb-2 border-b border-gray-100">SEO &amp; Metadata</h3>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <FormField label="Meta Title (Optional)">
              <input className={inp} value={local.meta_title} placeholder={local.site_name}
                onChange={e => setLocal(p => ({ ...p, meta_title: e.target.value }))} />
              <p className="text-xs text-gray-400 mt-1">Shown in browser tab and Google results. Defaults to site name.</p>
            </FormField>
            <FormField label="Canonical URL (Optional)">
              <input className={inp} value={local.canonical_url} placeholder="https://yourfarm.com"
                onChange={e => setLocal(p => ({ ...p, canonical_url: e.target.value }))} />
              <p className="text-xs text-gray-400 mt-1">Your primary domain if using a custom domain.</p>
            </FormField>
            <FormField label="Social Share Image URL (Optional)">
              <input className={inp} value={local.og_image_url} placeholder="https://…/og-image.jpg"
                onChange={e => setLocal(p => ({ ...p, og_image_url: e.target.value }))} />
              <p className="text-xs text-gray-400 mt-1">Image shown when sharing on Facebook, Twitter, etc. Recommended: 1200×630px.</p>
            </FormField>
            <FormField label="Schema / Structured Data (JSON-LD, Optional)">
              <textarea className={`${inp} font-mono text-xs min-h-[80px] resize-y`}
                value={(() => { try { const p = JSON.parse(local.seo_extras_json || '{}'); return p.schema_jsonld || ''; } catch { return ''; } })()}
                placeholder={'{\n  "@context": "https://schema.org",\n  "@type": "LocalBusiness",\n  "name": "Your Farm"\n}'}
                onChange={e => {
                  try {
                    const parsed = JSON.parse(local.seo_extras_json || '{}');
                    setLocal(p => ({ ...p, seo_extras_json: JSON.stringify({ ...parsed, schema_jsonld: e.target.value }) }));
                  } catch { setLocal(p => ({ ...p, seo_extras_json: JSON.stringify({ schema_jsonld: e.target.value }) })); }
                }} />
              <p className="text-xs text-gray-400 mt-1">Structured data helps search engines understand your business.</p>
            </FormField>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
          <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Custom Domain</h3>
          <DomainInstructions siteSlug={site.slug} />
        </div>

        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
          <VersionHistoryPanel websiteId={site.website_id} />
        </div>
      </div>

      <div className="mt-5 flex items-center justify-between">
        <button onClick={onDelete}
          className="text-sm text-red-500 border border-red-200 rounded-xl px-4 py-2.5 hover:bg-red-50 transition-colors">
          Delete Website
        </button>
        <button onClick={() => onSave(local)} disabled={saving}
          className="regsubmit2 px-8 py-2.5 text-sm disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Settings'}
        </button>
      </div>
    </div>
  );
}

// ── Domain connection instructions ───────────────────────────────
function DomainInstructions({ siteSlug }) {
  const [registrar, setRegistrar] = useState('godaddy');
  const [domain, setDomain] = useState('');
  const [copied, setCopied] = useState(null);

  const CNAME_TARGET = 'oatmealfarmnetwork-802455386518.us-central1.run.app';
  const PUBLIC_URL   = `https://oatmealfarmnetwork.com/sites/${siteSlug}`;

  const copy = (text, key) => {
    navigator.clipboard.writeText(text);
    setCopied(key);
    setTimeout(() => setCopied(null), 2000);
  };

  const CopyBtn = ({ text, id }) => (
    <button onClick={() => copy(text, id)}
      className={`ml-2 px-2 py-0.5 text-xs rounded font-medium transition-colors ${copied === id ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
      {copied === id ? '✓ Copied' : 'Copy'}
    </button>
  );

  const CodeLine = ({ label, value, id }) => (
    <div className="flex items-center justify-between py-2 border-b border-gray-50 last:border-0">
      <span className="text-xs font-semibold text-gray-500 w-24 shrink-0">{label}</span>
      <span className="flex-grow font-mono text-sm text-gray-800 bg-gray-50 rounded px-2 py-1 mx-2 break-all">{value}</span>
      <CopyBtn text={value} id={id} />
    </div>
  );

  return (
    <div className="mt-3">
      <p className="text-sm text-gray-600 mb-4">
        Connect a custom domain (e.g. <strong>yourfarm.com</strong>) to your website. Your site is currently accessible at:
        <a href={PUBLIC_URL} target="_blank" rel="noreferrer" className="ml-1 text-[#3D6B34] underline break-all">{PUBLIC_URL}</a>
      </p>

      <div className="flex gap-2 mb-5 flex-wrap">
        {[
          { id: 'godaddy',    label: '🐢 GoDaddy' },
          { id: 'namecheap',  label: 'Namecheap' },
          { id: 'cloudflare', label: 'Cloudflare' },
          { id: 'other',      label: 'Other Registrar' },
        ].map(r => (
          <button key={r.id} onClick={() => setRegistrar(r.id)}
            className={`px-4 py-2 rounded-lg text-sm font-medium border transition-colors ${registrar === r.id ? 'bg-[#3D6B34] text-white border-[#3D6B34]' : 'bg-white text-gray-600 border-gray-200 hover:border-gray-300'}`}>
            {r.label}
          </button>
        ))}
      </div>

      <div className="mb-5">
        <label className="block text-sm font-semibold text-gray-700 mb-1">Your Domain Name</label>
        <input className={inp + ' max-w-sm'} placeholder="yourfarm.com" value={domain}
          onChange={e => setDomain(e.target.value.toLowerCase().replace(/^https?:\/\//, '').replace(/\/$/, ''))} />
      </div>

      {registrar === 'godaddy' && (
        <div>
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 mb-4">
            <p className="text-sm font-semibold text-amber-800 mb-1">GoDaddy — Step by Step</p>
            <p className="text-xs text-amber-700">Follow these steps in your GoDaddy account. DNS changes can take up to 48 hours to propagate.</p>
          </div>
          <ol className="flex flex-col gap-4">
            <li className="flex gap-3">
              <span className="w-6 h-6 rounded-full bg-[#3D6B34] text-white text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">1</span>
              <div><p className="text-sm font-semibold text-gray-800">Log in to GoDaddy</p><p className="text-xs text-gray-500 mt-0.5">Go to <a href="https://dcc.godaddy.com/manage/dns" target="_blank" rel="noreferrer" className="text-[#3D6B34] underline">GoDaddy DNS Manager</a> and select <strong>{domain || 'your domain'}</strong>.</p></div>
            </li>
            <li className="flex gap-3">
              <span className="w-6 h-6 rounded-full bg-[#3D6B34] text-white text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">2</span>
              <div>
                <p className="text-sm font-semibold text-gray-800">Add a CNAME record for <code className="bg-gray-100 px-1 rounded">www</code></p>
                <div className="mt-2 bg-white border border-gray-200 rounded-lg px-3 py-1">
                  <CodeLine label="Type"  value="CNAME"        id="gd-type" />
                  <CodeLine label="Name"  value="www"          id="gd-name" />
                  <CodeLine label="Value" value={CNAME_TARGET} id="gd-value" />
                  <CodeLine label="TTL"   value="1 Hour"       id="gd-ttl" />
                </div>
              </div>
            </li>
            <li className="flex gap-3">
              <span className="w-6 h-6 rounded-full bg-[#3D6B34] text-white text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">3</span>
              <div>
                <p className="text-sm font-semibold text-gray-800">Redirect the root domain to www</p>
                <div className="mt-2 bg-white border border-gray-200 rounded-lg px-3 py-1">
                  <CodeLine label="Forward" value={domain ? `http://${domain}` : 'http://yourdomain.com'} id="gd-fwd-from" />
                  <CodeLine label="To"      value={domain ? `https://www.${domain}` : 'https://www.yourdomain.com'} id="gd-fwd-to" />
                  <CodeLine label="Type"    value="Permanent (301)" id="gd-fwd-type" />
                </div>
              </div>
            </li>
            <li className="flex gap-3">
              <span className="w-6 h-6 rounded-full bg-[#3D6B34] text-white text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">4</span>
              <div><p className="text-sm font-semibold text-gray-800">Contact us to complete setup</p><p className="text-xs text-gray-500 mt-0.5">Email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline">john@oatmealfarmnetwork.com</a> with your domain name so we can configure SSL and routing on our end.</p></div>
            </li>
          </ol>
        </div>
      )}

      {registrar === 'namecheap' && (
        <div className="flex flex-col gap-4">
          <div className="bg-blue-50 border border-blue-200 rounded-xl p-4">
            <p className="text-sm font-semibold text-blue-800 mb-1">Namecheap — DNS Records</p>
            <p className="text-xs text-blue-700">Go to <strong>Domain List → Manage → Advanced DNS</strong> and add these records.</p>
          </div>
          <div className="bg-white border border-gray-200 rounded-lg px-3 py-1">
            <CodeLine label="Type"  value="CNAME"        id="nc-type" />
            <CodeLine label="Host"  value="www"          id="nc-host" />
            <CodeLine label="Value" value={CNAME_TARGET} id="nc-value" />
            <CodeLine label="TTL"   value="Automatic"    id="nc-ttl" />
          </div>
          <p className="text-xs text-gray-500">Then email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline">john@oatmealfarmnetwork.com</a> with your domain to complete SSL setup.</p>
        </div>
      )}

      {registrar === 'cloudflare' && (
        <div className="flex flex-col gap-4">
          <div className="bg-orange-50 border border-orange-200 rounded-xl p-4">
            <p className="text-sm font-semibold text-orange-800 mb-1">Cloudflare — DNS Records</p>
            <p className="text-xs text-orange-700">In Cloudflare, go to your domain → <strong>DNS → Records → Add record</strong>. Set the proxy to <strong>DNS only</strong> (grey cloud) initially.</p>
          </div>
          <div className="bg-white border border-gray-200 rounded-lg px-3 py-1">
            <CodeLine label="Type"   value="CNAME"        id="cf-type" />
            <CodeLine label="Name"   value="www"          id="cf-name" />
            <CodeLine label="Target" value={CNAME_TARGET} id="cf-target" />
            <CodeLine label="Proxy"  value="DNS only (grey cloud)" id="cf-proxy" />
          </div>
          <p className="text-xs text-gray-500">Then email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline">john@oatmealfarmnetwork.com</a> with your domain to complete SSL setup.</p>
        </div>
      )}

      {registrar === 'other' && (
        <div className="flex flex-col gap-4">
          <div className="bg-gray-50 border border-gray-200 rounded-xl p-4">
            <p className="text-sm font-semibold text-gray-800 mb-1">Any Registrar — CNAME Record</p>
            <p className="text-xs text-gray-600">Log in to your domain registrar and add the following DNS record. The exact steps vary by provider.</p>
          </div>
          <div className="bg-white border border-gray-200 rounded-lg px-3 py-1">
            <CodeLine label="Type"          value="CNAME"        id="oth-type" />
            <CodeLine label="Name / Host"   value="www"          id="oth-name" />
            <CodeLine label="Value / Points to" value={CNAME_TARGET} id="oth-value" />
          </div>
          <p className="text-xs text-gray-500">After adding the DNS record, email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline">john@oatmealfarmnetwork.com</a> with your domain name. We'll configure SSL and routing on our servers — usually within 1 business day.</p>
        </div>
      )}

      <div className="mt-5 p-4 rounded-xl bg-[#3D6B34]/5 border border-[#3D6B34]/20">
        <p className="text-sm font-semibold text-[#3D6B34] mb-1">Need help?</p>
        <p className="text-xs text-gray-600">
          Email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline font-medium">john@oatmealfarmnetwork.com</a> with:
          <br />• Your domain name (e.g. {domain || 'yourfarm.com'})
          <br />• Your registrar (GoDaddy, Namecheap, etc.)
          <br />We'll handle the rest and have your domain live within 1 business day.
        </p>
      </div>
    </div>
  );
}
