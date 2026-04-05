import React, { useState, useEffect, useRef, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
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
  about:          { heading: 'About Us', body: 'Tell your story here...', image_url: '', image_position: 'right' },
  content:        { heading: '', body: '', image_url: '', image_position: 'right' },
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

const FONTS = [
  'Inter, sans-serif', 'Georgia, serif', 'Merriweather, serif',
  'Playfair Display, serif', 'Lato, sans-serif', 'Montserrat, sans-serif',
  'Raleway, sans-serif', 'Open Sans, sans-serif',
];

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
const inp    = "w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-300";
const inpSm  = "w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-300";
const ta     = `${inp} resize-y min-h-[80px]`;

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
function HeaderImagesManager({ websiteId }) {
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
      <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Header Images</h3>
      <p className="text-xs text-gray-400 mb-3">
        Add one or more rotating header images. If using multiple, assign start/end dates with no gaps between them.
      </p>

      {error && (
        <div className="mb-3 bg-amber-50 border border-amber-300 text-amber-700 rounded-lg px-3 py-2 text-xs">{error}</div>
      )}

      {loading ? (
        <p className="text-xs text-gray-400">Loading…</p>
      ) : (
        <div className="space-y-3 mb-3">
          {sorted.map((img, i) => (
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

// ── Block editor form ─────────────────────────────────────────────
function BlockEditorForm({ blockType, data, onChange }) {
  const set = (key, val) => onChange({ ...data, [key]: val });
  const fi = (key, label, type = 'text', placeholder = '') => (
    <FormField label={label}>
      <input type={type} className={inp} value={data[key] ?? ''} placeholder={placeholder}
        onChange={e => set(key, type === 'number' ? Number(e.target.value) : e.target.value)} />
    </FormField>
  );
  const fta = (key, label, placeholder = '') => (
    <FormField label={label}>
      <textarea className={ta} value={data[key] ?? ''} placeholder={placeholder}
        onChange={e => set(key, e.target.value)} />
    </FormField>
  );
  const fcheck = (key, label) => (
    <FormField label={label}>
      <label className="flex items-center gap-2 cursor-pointer">
        <input type="checkbox" checked={!!data[key]} onChange={e => set(key, e.target.checked)}
          className="w-4 h-4 accent-green-600" />
        <span className="text-sm text-gray-700">Enabled</span>
      </label>
    </FormField>
  );
  const fsel = (key, label, opts) => (
    <FormField label={label}>
      <select className={inp} value={data[key] ?? opts[0].value} onChange={e => set(key, e.target.value)}>
        {opts.map(o => <option key={o.value} value={o.value}>{o.label}</option>)}
      </select>
    </FormField>
  );

  const widthRow = (
    <FormField label="Block Width">
      <div className="flex gap-2">
        {[['full','Full Width'],['half','Half Width'],['third','One Third']].map(([v,l]) => (
          <button key={v} type="button"
            onClick={() => set('col_span', v)}
            className={`flex-1 py-2 rounded-lg text-xs font-medium border transition-colors
              ${(data.col_span || 'full') === v ? 'bg-[#3D6B34] text-white border-[#3D6B34]' : 'border-gray-200 text-gray-600 hover:border-gray-300'}`}>
            {l}
          </button>
        ))}
      </div>
    </FormField>
  );

  switch (blockType) {
    case 'hero': return (<>
      {widthRow}
      {fi('headline', 'Headline')}
      {fta('subtext', 'Sub-text')}
      {fi('image_url', 'Background Image URL')}
      {fi('cta_text', 'Button Text')}
      {fi('cta_link', 'Button Link (URL or #section)')}
      {fcheck('overlay', 'Dark overlay on image')}
      {fsel('align', 'Text Alignment', [{ value: 'left', label: 'Left' }, { value: 'center', label: 'Center' }, { value: 'right', label: 'Right' }])}
    </>);
    case 'about': return (<>
      {widthRow}
      {fi('heading', 'Heading')}
      {fta('body', 'Body Text')}
      {fi('image_url', 'Image URL')}
      {fsel('image_position', 'Image Position', [{ value: 'right', label: 'Right' }, { value: 'left', label: 'Left' }, { value: 'none', label: 'No Image' }])}
    </>);
    case 'content': return (<>
      {widthRow}
      {fi('heading', 'Heading (Optional)')}
      {fta('body', 'Body Text')}
      {fi('image_url', 'Image URL (Optional)')}
      {fsel('image_position', 'Image Position', [{ value: 'right', label: 'Right' }, { value: 'left', label: 'Left' }, { value: 'top', label: 'Top' }, { value: 'none', label: 'No Image' }])}
    </>);
    case 'livestock':
    case 'studs': return (<>
      {widthRow}
      {fi('heading', 'Heading')}
      {fcheck('show_for_sale', 'Show Animals For Sale')}
      {fcheck('show_studs', 'Show Stud Services')}
      {fi('max_items', 'Max Items to Show', 'number')}
    </>);
    case 'produce':
    case 'meat':
    case 'processed_food':
    case 'services':
    case 'marketplace': return (<>
      {widthRow}
      {fi('heading', 'Heading')}
      {fi('max_items', 'Max Items to Show', 'number')}
    </>);
    case 'gallery': return (<>
      {widthRow}
      {fi('heading', 'Heading')}
      {fsel('columns', 'Columns', [{ value: 2, label: '2 Columns' }, { value: 3, label: '3 Columns' }, { value: 4, label: '4 Columns' }])}
    </>);
    case 'blog': return (<>
      {widthRow}
      {fi('heading', 'Heading')}
      {fi('max_posts', 'Max Posts to Show', 'number')}
    </>);
    case 'contact': return (<>
      {widthRow}
      {fi('heading', 'Heading')}
      {fta('custom_message', 'Custom Message (Optional)')}
      {fcheck('show_form', 'Show Contact Form')}
    </>);
    case 'divider': return (<>{widthRow}{fi('height', 'Height (px)', 'number')}</>);
    default: return <p className="text-gray-400 text-sm">No settings for this block type.</p>;
  }
}

// ── Block card ────────────────────────────────────────────────────
function BlockCard({ block, onEdit, onDelete, onMoveUp, onMoveDown, isFirst, isLast, onDragStart, onDragOver, onDrop, isDragging }) {
  const bt = BLOCK_TYPES.find(b => b.type === block.block_type) || { icon: '📦', label: block.block_type };
  const preview = block.block_data?.headline || block.block_data?.heading || block.block_data?.body?.slice(0, 80) || '';
  const widthLabel = { full: 'Full', half: '½ Width', third: '⅓ Width' }[block.block_data?.col_span] || 'Full';
  return (
    <div
      draggable
      onDragStart={onDragStart}
      onDragOver={onDragOver}
      onDrop={onDrop}
      className={`flex items-center gap-3 bg-white border rounded-xl px-4 py-3.5 shadow-sm transition-all
        ${isDragging ? 'opacity-40 border-dashed border-[#3D6B34]' : 'border-gray-100 hover:border-gray-200'}`}
    >
      {/* Drag handle */}
      <div className="shrink-0 cursor-grab active:cursor-grabbing text-gray-300 hover:text-gray-400 pr-1" title="Drag to reorder">
        <svg width="12" height="18" viewBox="0 0 12 18" fill="currentColor">
          <circle cx="3" cy="3" r="1.5"/><circle cx="9" cy="3" r="1.5"/>
          <circle cx="3" cy="9" r="1.5"/><circle cx="9" cy="9" r="1.5"/>
          <circle cx="3" cy="15" r="1.5"/><circle cx="9" cy="15" r="1.5"/>
        </svg>
      </div>
      <span className="text-xl shrink-0">{bt.icon}</span>
      <div className="flex-grow min-w-0">
        <div className="font-semibold text-sm text-gray-800">{bt.label}</div>
        <div className="flex items-center gap-2 mt-0.5">
          {preview && <span className="text-xs text-gray-400 truncate">{preview}</span>}
          <span className="text-xs text-gray-300 shrink-0">{widthLabel}</span>
        </div>
      </div>
      <div className="flex items-center gap-1 shrink-0">
        <button onClick={onMoveUp} disabled={isFirst} title="Move up"
          className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-400 disabled:opacity-20 disabled:cursor-not-allowed transition-colors">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M18 15l-6-6-6 6"/></svg>
        </button>
        <button onClick={onMoveDown} disabled={isLast} title="Move down"
          className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-400 disabled:opacity-20 disabled:cursor-not-allowed transition-colors">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M6 9l6 6 6-6"/></svg>
        </button>
        <button onClick={onEdit}
          className="px-2.5 py-1.5 text-xs font-medium text-[#3D6B34] border border-[#3D6B34]/30 rounded-lg hover:bg-green-50 transition-colors">
          Edit
        </button>
        <button onClick={onDelete}
          className="px-2.5 py-1.5 text-xs font-medium text-red-500 border border-red-200 rounded-lg hover:bg-red-50 transition-colors">
          Del
        </button>
      </div>
    </div>
  );
}

// ── Main component ────────────────────────────────────────────────
export default function WebsiteBuilder() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();

  const [site, setSite]             = useState(null);
  const [pages, setPages]           = useState([]);
  const [activePage, setActivePage] = useState(null);  // page object or 'design' | 'settings'
  const [blocks, setBlocks]         = useState([]);
  const [loading, setLoading]       = useState(true);
  const [saving, setSaving]         = useState(false);
  const [setupMode, setSetupMode]   = useState(false);

  // Page sidebar UI
  const [showNewPage, setShowNewPage]       = useState(false);
  const [newPageName, setNewPageName]       = useState('');
  const [editingPageId, setEditingPageId]   = useState(null);
  const [editingPageName, setEditingPageName] = useState('');

  // Block modals
  const [showBlockPicker, setShowBlockPicker] = useState(false);
  const [editingBlock, setEditingBlock]       = useState(null);
  const [editBlockData, setEditBlockData]     = useState({});

  // Drag-to-reorder
  const dragIdx = useRef(null);
  const [draggingId, setDraggingId] = useState(null);

  // Responsive preview
  const [previewMode, setPreviewMode] = useState('desktop'); // 'desktop' | 'tablet' | 'mobile'

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

  const paramPage = searchParams.get('page');   // page_id from sidebar link
  const paramView = searchParams.get('view');   // 'design' | 'settings' from sidebar link

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => { if (BusinessID) loadSite(); }, [BusinessID]);

  // React to sidebar link changes without remounting
  useEffect(() => {
    if (!site) return;
    if (paramView === 'design' || paramView === 'settings') {
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
      if (!data) {
        setSetupMode(true);
      } else {
        setSite(data);
        await loadPages(data.website_id);
      }
    } catch { setSetupMode(true); }
    finally { setLoading(false); }
  };

  // Pre-fill setup when Business loads
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
    // If sidebar sent a view param, honour it
    if (paramView === 'design' || paramView === 'settings') {
      setActivePage(paramView);
      return;
    }
    if (ps.length > 0) {
      // If sidebar sent a specific page_id, jump straight to it
      const target = paramPage ? ps.find(p => p.page_id === parseInt(paramPage)) : null;
      const chosen = target || ps.find(p => p.is_home_page) || ps[0];
      setActivePage(chosen);
      await loadBlocks(chosen.page_id);
    }
  };

  const loadBlocks = async (pageId) => {
    const bs = await apiFetch(`/api/website/blocks/${pageId}`);
    setBlocks(bs);
  };

  const selectPage = async (page) => {
    setActivePage(page);
    setBlocks([]);
    setShowBlockPicker(false);
    setEditingBlock(null);
    await loadBlocks(page.page_id);
  };

  // ── Site creation ─────────────────────────────────────────────
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

      // Check what content the business already has
      const content = await apiFetch(`/api/website/content/check?business_id=${bid}`).catch(() => ({}));

      let order = 0;

      const homePage = await mkPage('Home', 'home', true, order++);
      await mkBlock(homePage.page_id, 'hero', { headline: `Welcome to ${setupData.site_name}`, subtext: setupData.tagline || 'Fresh, local, and sustainably grown.', image_url: '', cta_text: 'Learn More', cta_link: '#about', overlay: true, align: 'center' }, 0);
      await mkBlock(homePage.page_id, 'content', { heading: 'What We Offer', body: 'We are a local farm dedicated to bringing you the finest quality produce, livestock, and products. Browse our offerings below.', image_url: '', image_position: 'none' }, 1);

      const aboutPage = await mkPage('About Us', 'about', false, order++);
      await mkBlock(aboutPage.page_id, 'hero', { headline: 'About Us', subtext: `Learn more about ${setupData.site_name}`, image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
      await mkBlock(aboutPage.page_id, 'about', { heading: 'Our Story', body: 'Tell visitors who you are, where you are located, and what makes your farm special. Share your history, your values, and your commitment to quality.', image_url: '', image_position: 'right' }, 1);
      await mkBlock(aboutPage.page_id, 'content', { heading: 'Our Mission', body: 'We believe in sustainable agriculture and bringing the freshest products directly from our farm to your table.', image_url: '', image_position: 'none' }, 2);

      // Auto-generate content pages based on what the business has
      if (content.livestock_for_sale) {
        const p = await mkPage('Livestock For Sale', 'livestock-for-sale', false, order++);
        await mkBlock(p.page_id, 'hero', { headline: 'Livestock For Sale', subtext: 'Browse our available animals.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
        await mkBlock(p.page_id, 'livestock', { heading: 'Animals For Sale', show_for_sale: true, show_studs: false, max_items: 12 }, 1);
      }

      if (content.studs) {
        const p = await mkPage('Stud Services', 'stud-services', false, order++);
        await mkBlock(p.page_id, 'hero', { headline: 'Stud Services', subtext: 'Premium breeding genetics available.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
        await mkBlock(p.page_id, 'studs', { heading: 'Stud Animals', show_for_sale: false, show_studs: true, max_items: 12 }, 1);
      }

      if (content.produce) {
        const p = await mkPage('Fresh Produce', 'produce', false, order++);
        await mkBlock(p.page_id, 'hero', { headline: 'Fresh Produce', subtext: 'Farm-fresh fruits and vegetables.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
        await mkBlock(p.page_id, 'produce', { heading: 'What We Grow', max_items: 20 }, 1);
      }

      if (content.meat) {
        const p = await mkPage('Meat', 'meat', false, order++);
        await mkBlock(p.page_id, 'hero', { headline: 'Farm-Raised Meat', subtext: 'Pasture-raised, humanely harvested.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
        await mkBlock(p.page_id, 'meat', { heading: 'Available Cuts', max_items: 20 }, 1);
      }

      if (content.processed_food) {
        const p = await mkPage('Farm Products', 'farm-products', false, order++);
        await mkBlock(p.page_id, 'hero', { headline: 'Farm Products', subtext: 'Handcrafted goods from our farm.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
        await mkBlock(p.page_id, 'processed_food', { heading: 'Our Products', max_items: 20 }, 1);
      }

      if (content.services) {
        const p = await mkPage('Services', 'services', false, order++);
        await mkBlock(p.page_id, 'hero', { headline: 'Our Services', subtext: 'See what we offer.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
        await mkBlock(p.page_id, 'services', { heading: 'What We Do', max_items: 20 }, 1);
      }

      if (content.marketplace) {
        const p = await mkPage('Shop', 'shop', false, order++);
        await mkBlock(p.page_id, 'hero', { headline: 'Shop Our Store', subtext: 'All of our listings in one place.', image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
        await mkBlock(p.page_id, 'marketplace', { heading: 'All Listings', max_items: 24 }, 1);
      }

      const contactPage = await mkPage('Contact Us', 'contact', false, order++);
      await mkBlock(contactPage.page_id, 'hero', { headline: 'Contact Us', subtext: "We'd love to hear from you.", image_url: '', cta_text: '', cta_link: '', overlay: true, align: 'center' }, 0);
      await mkBlock(contactPage.page_id, 'contact', { heading: 'Get In Touch', custom_message: "Have a question about our products, want to place a bulk order, or just want to say hello? Fill out the form below and we'll get back to you as soon as possible.", show_form: true }, 1);

      await loadPages(data.website_id);
      setActivePage('design');
    } catch (e) { alert(e.message); }
    finally { setSaving(false); }
  };

  // ── Site update ───────────────────────────────────────────────
  const saveSite = async (updates) => {
    if (!site) return;
    setSaving(true);
    try {
      const updated = await apiFetch(`/api/website/site/${site.website_id}`, { method: 'PUT', body: JSON.stringify(updates) });
      setSite(updated);
    } catch (e) { alert(e.message); }
    finally { setSaving(false); }
  };

  const togglePublish = async () => {
    await saveSite({ is_published: !site.is_published });
  };

  const deleteSite = async () => {
    if (!site) return;
    if (!window.confirm(`Delete "${site.site_name}"? This will permanently remove the website, all pages, and all content. This cannot be undone.`)) return;
    try {
      await apiFetch(`/api/website/site/${site.website_id}`, { method: 'DELETE' });
      setSite(null);
      setSetupMode(true);
    } catch (e) { alert(e.message); }
  };

  // ── Page CRUD ─────────────────────────────────────────────────
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

  const deletePage = async (pageId) => {
    if (!confirm('Delete this page and all its blocks?')) return;
    try {
      await apiFetch(`/api/website/pages/${pageId}`, { method: 'DELETE' });
      const remaining = pages.filter(p => p.page_id !== pageId);
      setPages(remaining);
      if (activePage?.page_id === pageId) {
        if (remaining.length > 0) { await selectPage(remaining[0]); }
        else { setActivePage(null); setBlocks([]); }
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

  // ── Block CRUD ────────────────────────────────────────────────
  const addBlock = async (blockType) => {
    setShowBlockPicker(false);
    if (!activePage || typeof activePage === 'string') return;
    try {
      const block = await apiFetch('/api/website/blocks', { method: 'POST', body: JSON.stringify({ page_id: activePage.page_id, block_type: blockType, block_data: defaultBlockData[blockType] || {}, sort_order: blocks.length }) });
      setBlocks(prev => [...prev, block]);
    } catch (e) { alert(e.message); }
  };

  const saveEditBlock = async () => {
    if (!editingBlock) return;
    setSaving(true);
    try {
      const updated = await apiFetch(`/api/website/blocks/${editingBlock.block_id}`, { method: 'PUT', body: JSON.stringify({ block_data: editBlockData }) });
      setBlocks(prev => prev.map(b => b.block_id === editingBlock.block_id ? updated : b));
      setEditingBlock(null);
    } catch (e) { alert(e.message); }
    finally { setSaving(false); }
  };

  const deleteBlock = async (blockId) => {
    if (!confirm('Delete this block?')) return;
    try {
      await apiFetch(`/api/website/blocks/${blockId}`, { method: 'DELETE' });
      setBlocks(prev => prev.filter(b => b.block_id !== blockId));
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

  // ── Drag-to-reorder handlers ──────────────────────────────────
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

  // ── Render guards ─────────────────────────────────────────────
  const PeopleID = localStorage.getItem('people_id');

  if (loading) return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div className="p-8 text-gray-400">Loading website builder…</div>
    </AccountLayout>
  );

  // ── Setup wizard ──────────────────────────────────────────────
  if (setupMode) return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div style={{ maxWidth: 700, margin: '0 auto' }}>
        <h1 className="text-2xl font-bold text-gray-900 mb-1">Create Your Website</h1>
        <p className="text-gray-500 text-sm mb-6">Set up your public business website. You can change everything later.</p>

        {/* Template picker */}
        <div className="bg-white rounded-xl border border-gray-100 shadow p-6 mb-4">
          <h2 className="text-base font-bold text-gray-800 mb-1">Choose a Starting Design</h2>
          <p className="text-xs text-gray-400 mb-4">Pick a color scheme to start with. You can customize every detail afterwards.</p>
          <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
            {TEMPLATES.map(t => (
              <button
                key={t.id}
                onClick={() => setSetupData(p => ({ ...p,
                  primary_color:   t.primary_color,
                  secondary_color: t.secondary_color,
                  accent_color:    t.accent_color,
                  bg_color:        t.bg_color,
                  text_color:      t.text_color,
                  nav_text_color:  t.nav_text_color,
                  footer_bg_color: t.footer_bg_color,
                  font_family:     t.font_family,
                }))}
                className={`rounded-xl border-2 overflow-hidden text-left transition-all
                  ${setupData.primary_color === t.primary_color
                    ? 'border-[#3D6B34] shadow-md'
                    : 'border-gray-100 hover:border-gray-300'}`}
              >
                {/* Color swatch strip */}
                <div className="flex h-8">
                  {[t.primary_color, t.secondary_color, t.accent_color, t.bg_color].map((c, i) => (
                    <div key={i} className="flex-1" style={{ background: c }} />
                  ))}
                </div>
                {/* Nav preview */}
                <div className="px-2 py-1" style={{ background: t.primary_color }}>
                  <span className="text-xs font-bold" style={{ color: t.nav_text_color, fontFamily: t.font_family }}>
                    {t.name}
                  </span>
                </div>
                <div className="px-2 py-1.5" style={{ background: t.bg_color }}>
                  <span className="text-xs" style={{ color: t.text_color, fontFamily: t.font_family }}>
                    Sample text
                  </span>
                </div>
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
          <FormField label="Primary Color (Optional)">
            <div className="flex items-center gap-3">
              <input type="color" value={setupData.primary_color} onChange={e => setSetupData(p => ({ ...p, primary_color: e.target.value }))}
                className="w-10 h-10 rounded cursor-pointer border border-gray-200" />
              <span className="text-sm text-gray-500">{setupData.primary_color}</span>
            </div>
          </FormField>
          <button onClick={createSite} disabled={saving || !setupData.site_name || !setupData.slug}
            className="regsubmit2 w-full py-3 text-base mt-2 disabled:opacity-50">
            {saving ? 'Creating your site…' : 'Create My Website →'}
          </button>
        </div>
      </div>
    </AccountLayout>
  );

  // ── Main builder UI ───────────────────────────────────────────
  const isDesign   = activePage === 'design';
  const isSettings = activePage === 'settings';
  const isPage     = activePage && typeof activePage === 'object';

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
              : <span className="text-gray-400">○ Unpublished</span>
            }
            <span className="ml-2">/sites/{site.slug}</span>
          </p>
          {showNewPage ? (
            <div className="flex gap-1 mt-2">
              <input className="border border-gray-200 rounded px-2 py-1 text-xs"
                placeholder="Page name" value={newPageName}
                onChange={e => setNewPageName(e.target.value)}
                onKeyDown={e => { if (e.key === 'Enter') addPage(); if (e.key === 'Escape') { setShowNewPage(false); setNewPageName(''); } }}
                autoFocus />
              <button onClick={addPage} className="text-xs bg-[#3D6B34] text-white px-2 rounded">+</button>
              <button onClick={() => { setShowNewPage(false); setNewPageName(''); }} className="text-xs text-gray-400 px-2">✕</button>
            </div>
          ) : (
            <button onClick={() => setShowNewPage(true)}
              className="mt-1.5 text-xs text-[#3D6B34] hover:underline">
              + Add Page
            </button>
          )}
        </div>
        <div className="flex items-center gap-2">
          {/* Responsive preview toggle */}
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

      {/* ── Main content area ── */}
      <div style={{ minHeight: 'calc(100vh - 230px)' }}>
        {/* Responsive preview wrapper */}
        <div className={`transition-all mx-auto ${
          previewMode === 'tablet' ? 'max-w-[768px]' :
          previewMode === 'mobile' ? 'max-w-[390px]' : 'max-w-none'
        }`}>

          {/* ── PAGE EDITOR ── */}
          {isPage && (
            <div className="flex flex-col gap-4">
              <div className="flex items-center justify-between">
                <div>
                  <h2 className="text-lg font-bold text-gray-900">{activePage.page_name}</h2>
                  <p className="text-xs text-gray-400 mt-0.5">/sites/{site.slug}/{activePage.slug}</p>
                </div>
                <div className="flex items-center gap-2">
                  <span className={`text-xs font-medium px-3 py-1 rounded-full ${activePage.is_published ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                    {activePage.is_published ? 'Visible' : 'Hidden'}
                  </span>
                  <button onClick={() => setShowBlockPicker(true)}
                    className="bg-[#3D6B34] text-white text-sm font-semibold px-5 py-2 rounded-xl hover:bg-[#2d5226] transition-colors flex items-center gap-2">
                    + Add Block
                  </button>
                </div>
              </div>

              {blocks.length === 0 ? (
                <div className="flex flex-col items-center justify-center gap-4 bg-white rounded-xl border border-dashed border-gray-200 p-16 text-center">
                  <div className="text-4xl">📄</div>
                  <p className="text-gray-500 font-medium">This page has no blocks yet.</p>
                  <p className="text-gray-400 text-sm">Add blocks to build your page content.</p>
                  <button onClick={() => setShowBlockPicker(true)} className="regsubmit2">
                    + Add Your First Block
                  </button>
                </div>
              ) : (
                <div className="flex flex-col gap-2">
                  {blocks.map((block, idx) => (
                    <BlockCard key={block.block_id} block={block}
                      onEdit={() => { setEditingBlock(block); setEditBlockData({ ...block.block_data }); }}
                      onDelete={() => deleteBlock(block.block_id)}
                      onMoveUp={() => moveBlock(idx, -1)}
                      onMoveDown={() => moveBlock(idx, 1)}
                      isFirst={idx === 0} isLast={idx === blocks.length - 1}
                      isDragging={draggingId === block.block_id}
                      onDragStart={(e) => handleDragStart(e, idx)}
                      onDragOver={(e) => handleDragOver(e, idx)}
                      onDrop={handleDrop}
                    />
                  ))}
                  <button onClick={() => setShowBlockPicker(true)}
                    className="mt-1 w-full text-sm text-[#3D6B34] border border-dashed border-[#3D6B34]/40 rounded-xl py-3 hover:bg-green-50 transition-colors">
                    + Add Block
                  </button>
                </div>
              )}
            </div>
          )}

          {/* ── DESIGN PAGE ── */}
          {isDesign && (
            <DesignView site={site} onSave={saveSite} saving={saving} onDelete={deleteSite} />
          )}

          {/* ── SETTINGS PAGE ── */}
          {isSettings && (
            <SettingsView site={site} onSave={saveSite} saving={saving} onDelete={deleteSite} />
          )}

          {/* ── No page selected ── */}
          {!isPage && !isDesign && !isSettings && (
            <div className="flex items-center justify-center h-full bg-white rounded-xl border border-gray-100 text-gray-400 p-12">
              Select a page from the sidebar to start editing.
            </div>
          )}

        </div>{/* end preview wrapper */}
      </div>

      {/* ── Block picker modal ── */}
      {showBlockPicker && (
        <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center p-4" onClick={() => setShowBlockPicker(false)}>
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-2xl max-h-[80vh] overflow-y-auto" onClick={e => e.stopPropagation()}>
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100">
              <h3 className="text-lg font-bold text-gray-900">Add a Block</h3>
              <button onClick={() => setShowBlockPicker(false)} className="text-gray-400 hover:text-gray-600 text-2xl leading-none">×</button>
            </div>
            <div className="p-6 grid grid-cols-2 gap-2">
              {BLOCK_TYPES.map(bt => (
                <button key={bt.type} onClick={() => addBlock(bt.type)}
                  className="flex items-start gap-3 p-4 rounded-xl border border-gray-100 hover:border-green-200 hover:bg-green-50/50 text-left transition-all group">
                  <span className="text-2xl shrink-0">{bt.icon}</span>
                  <div>
                    <div className="font-semibold text-sm text-gray-800 group-hover:text-[#3D6B34]">{bt.label}</div>
                    <div className="text-xs text-gray-400 mt-0.5">{bt.desc}</div>
                  </div>
                </button>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* ── Block edit modal ── */}
      {editingBlock && (
        <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[85vh] overflow-y-auto">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100">
              <h3 className="text-lg font-bold text-gray-900">
                {BLOCK_TYPES.find(b => b.type === editingBlock.block_type)?.label || 'Edit Block'}
              </h3>
              <button onClick={() => setEditingBlock(null)} className="text-gray-400 hover:text-gray-600 text-2xl leading-none">×</button>
            </div>
            <div className="p-6">
              <BlockEditorForm blockType={editingBlock.block_type} data={editBlockData} onChange={setEditBlockData} />
              <div className="flex gap-2 pt-4 border-t border-gray-100">
                <button onClick={saveEditBlock} disabled={saving} className="flex-1 regsubmit2 disabled:opacity-50">
                  {saving ? 'Saving…' : 'Save Block'}
                </button>
                <button onClick={() => setEditingBlock(null)}
                  className="flex-1 border border-gray-200 rounded-xl py-2 text-sm text-gray-600 hover:bg-gray-50 transition-colors">
                  Cancel
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

    </AccountLayout>

    {/* ── Lavendir AI Agent — rendered outside AccountLayout so fixed positioning is unclipped ── */}
    {site && (
      <WebsiteAIAgent
        websiteId={site.website_id}
        businessId={parseInt(BusinessID)}
        currentView={isDesign ? 'design' : isSettings ? 'settings' : activePage?.page_name || 'page'}
      />
    )}
    </>
  );
}

// ── Design full view ──────────────────────────────────────────────
function DesignView({ site, onSave, saving }) {

  const [local, setLocal] = useState({
    primary_color:   site.primary_color   || '#3D6B34',
    secondary_color: site.secondary_color || '#819360',
    accent_color:    site.accent_color    || '#FFC567',
    bg_color:        site.bg_color        || '#FFFFFF',
    text_color:      site.text_color      || '#111827',
    font_family:     site.font_family     || 'Inter, sans-serif',
    logo_url:        site.logo_url        || '',
    nav_text_color:  site.nav_text_color  || '#FFFFFF',
    footer_bg_color: site.footer_bg_color || site.primary_color || '#3D6B34',
    copyright_text:  site.copyright_text  || '',
  });

  const ColorRow = ({ label, field, hint }) => (
    <div className="flex items-center justify-between py-3 border-b border-gray-50 last:border-0">
      <div>
        <span className="text-sm font-medium text-gray-700">{label}</span>
        {hint && <p className="text-xs text-gray-400 mt-0.5">{hint}</p>}
      </div>
      <div className="flex items-center gap-2">
        <div className="w-7 h-7 rounded-md border border-gray-200 shadow-sm" style={{ background: local[field] }} />
        <input type="color" value={local[field]}
          onChange={e => setLocal(p => ({ ...p, [field]: e.target.value }))}
          className="w-8 h-8 rounded-md cursor-pointer border border-gray-200 p-0.5" />
        <input type="text" value={local[field]} maxLength={7}
          onChange={e => setLocal(p => ({ ...p, [field]: e.target.value }))}
          className="w-20 border border-gray-200 rounded-lg px-2 py-1 text-xs font-mono" />
      </div>
    </div>
  );

  // Live header preview
  const HeaderPreview = () => (
    <div style={{ background: local.primary_color, borderRadius: 8, padding: '0 1rem', height: 48, display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginTop: '0.75rem' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
        {local.logo_url && <img src={local.logo_url} alt="" style={{ height: 28, width: 28, objectFit: 'contain', borderRadius: 4 }} />}
        <span style={{ fontWeight: 800, color: local.nav_text_color, fontFamily: local.font_family, fontSize: '0.9rem' }}>{site.site_name}</span>
      </div>
      <div style={{ display: 'flex', gap: '0.5rem' }}>
        {['Home', 'About Us', 'Contact Us'].map(n => (
          <span key={n} style={{ color: local.nav_text_color, fontSize: '0.75rem', opacity: 0.85 }}>{n}</span>
        ))}
      </div>
    </div>
  );

  // Live footer preview
  const FooterPreview = () => (
    <div style={{ background: local.footer_bg_color, borderRadius: 8, padding: '0.75rem 1rem', marginTop: '0.75rem' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '0.5rem' }}>
        <span style={{ fontWeight: 700, color: '#fff', fontFamily: local.font_family, fontSize: '0.85rem' }}>{site.site_name}</span>
        <span style={{ color: 'rgba(255,255,255,0.7)', fontSize: '0.7rem' }}>{local.copyright_text || `© ${new Date().getFullYear()} ${site.site_name}`}</span>
      </div>
    </div>
  );

  return (
    <div>
      <h2 className="text-lg font-bold text-gray-900 mb-1">Design</h2>
      <p className="text-sm text-gray-500 mb-5">Customize the look, colors, fonts, header, and footer of your website.</p>

      {/* ── Palette switcher ── */}
      <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 mb-5">
        <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Color Palettes</h3>
        <p className="text-xs text-gray-400 mb-4">Apply a preset palette — you can still fine-tune individual colors below.</p>
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
          {TEMPLATES.map(t => {
            const active = local.primary_color === t.primary_color && local.secondary_color === t.secondary_color;
            return (
              <button
                key={t.id}
                onClick={() => setLocal(p => ({ ...p,
                  primary_color:   t.primary_color,
                  secondary_color: t.secondary_color,
                  accent_color:    t.accent_color,
                  bg_color:        t.bg_color,
                  text_color:      t.text_color,
                  nav_text_color:  t.nav_text_color,
                  footer_bg_color: t.footer_bg_color,
                  font_family:     t.font_family,
                }))}
                className={`rounded-xl border-2 overflow-hidden text-left transition-all
                  ${active ? 'border-[#3D6B34] shadow-md ring-2 ring-[#3D6B34]/20' : 'border-gray-100 hover:border-gray-300'}`}
              >
                {/* Color swatch strip */}
                <div className="flex h-7">
                  {[t.primary_color, t.secondary_color, t.accent_color, t.bg_color].map((c, i) => (
                    <div key={i} className="flex-1" style={{ background: c }} />
                  ))}
                </div>
                {/* Nav preview */}
                <div className="px-2 py-1" style={{ background: t.primary_color }}>
                  <span className="text-xs font-bold truncate block" style={{ color: t.nav_text_color, fontFamily: t.font_family }}>
                    {t.name}
                  </span>
                </div>
                <div className="px-2 py-1" style={{ background: t.bg_color }}>
                  <span className="text-xs truncate block" style={{ color: t.text_color, fontFamily: t.font_family }}>
                    Sample text
                  </span>
                </div>
              </button>
            );
          })}
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">

        {/* Header */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
          <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Header / Navigation</h3>
          <ColorRow label="Header Background"  field="primary_color"   hint="Background color of the navigation bar" />
          <ColorRow label="Header Text Color"  field="nav_text_color"  hint="Color of the site name and nav links" />
          <div className="mt-3">
            <ImageUploadField
              label="Logo"
              value={local.logo_url}
              onChange={url => setLocal(p => ({ ...p, logo_url: url }))}
              hint="Appears in the navigation bar. Recommended: square PNG with transparent background."
            />
          </div>
          <HeaderPreview />
        </div>

        {/* Header Images */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
          <HeaderImagesManager websiteId={site.website_id} />
        </div>

        {/* Footer */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
          <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Footer</h3>
          <ColorRow label="Footer Background" field="footer_bg_color" hint="Leave matching header for a consistent look" />
          <div className="mt-3">
            <label className="block text-sm font-medium text-gray-700 mb-1">Copyright / Footer Text</label>
            <input className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm"
              placeholder={`© ${new Date().getFullYear()} ${site.site_name} · All rights reserved`}
              value={local.copyright_text}
              onChange={e => setLocal(p => ({ ...p, copyright_text: e.target.value }))} />
            <p className="text-xs text-gray-400 mt-1">Leave blank to use the default copyright line.</p>
          </div>
          <FooterPreview />
        </div>

        {/* Page Colors */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
          <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Page Colors</h3>
          <ColorRow label="Secondary / Accent"  field="secondary_color" hint="Used for hover states and accents" />
          <ColorRow label="Button / Highlight"  field="accent_color"    hint="CTA buttons and highlights" />
          <ColorRow label="Page Background"     field="bg_color"        hint="Main content area background" />
          <ColorRow label="Body Text"           field="text_color"      hint="Main text color" />
        </div>

        {/* Font */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
          <h3 className="font-bold text-gray-800 mb-3 pb-2 border-b border-gray-100">Font</h3>
          <select className="w-full border border-gray-200 rounded-lg px-3 py-2.5 text-sm"
            value={local.font_family} onChange={e => setLocal(p => ({ ...p, font_family: e.target.value }))}>
            {FONTS.map(f => <option key={f} value={f} style={{ fontFamily: f }}>{f.split(',')[0]}</option>)}
          </select>
          <div className="mt-3 p-4 rounded-lg border border-gray-100" style={{ background: local.bg_color }}>
            <p style={{ fontFamily: local.font_family, color: local.text_color, fontWeight: 700, fontSize: '1rem', margin: 0 }}>The quick brown fox</p>
            <p style={{ fontFamily: local.font_family, color: local.text_color, fontSize: '0.85rem', marginTop: 4, opacity: 0.7 }}>Jumps over the lazy dog. 0123456789</p>
          </div>
        </div>

      </div>

      {/* Full palette strip */}
      <div className="mt-5 rounded-xl overflow-hidden border border-gray-100 shadow-sm">
        <div className="h-10 flex">
          {[local.primary_color, local.footer_bg_color, local.secondary_color, local.accent_color, local.bg_color, local.text_color].map((c, i) => (
            <div key={i} className="flex-1" style={{ background: c }} title={c} />
          ))}
        </div>
        <div className="px-4 py-2 bg-white text-xs text-gray-400">Full color palette preview</div>
      </div>

      <div className="mt-5">
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
  const [versions, setVersions]     = useState([]);
  const [label, setLabel]           = useState('');
  const [saving, setSaving]         = useState(false);
  const [restoring, setRestoring]   = useState(false);

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

        {/* SEO & Metadata */}
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

        {/* Domain connection */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
          <h3 className="font-bold text-gray-800 mb-1 pb-2 border-b border-gray-100">Custom Domain</h3>
          <DomainInstructions siteSlug={site.slug} />
        </div>

        {/* Version History */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-5 lg:col-span-2">
          <VersionHistoryPanel websiteId={site.website_id} />
        </div>

      </div>

      <div className="mt-5 flex items-center justify-between">
        <button onClick={() => onSave(local)} disabled={saving}
          className="regsubmit2 px-8 py-2.5 text-sm disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Settings'}
        </button>
        <button onClick={onDelete}
          className="text-sm text-red-500 border border-red-200 rounded-xl px-4 py-2.5 hover:bg-red-50 transition-colors">
          Delete Website
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

  // These are the values the DNS records need to point to
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

      {/* Registrar selector */}
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

      {/* Domain input */}
      <div className="mb-5">
        <label className="block text-sm font-semibold text-gray-700 mb-1">Your Domain Name</label>
        <input className={inp + ' max-w-sm'} placeholder="yourfarm.com" value={domain}
          onChange={e => setDomain(e.target.value.toLowerCase().replace(/^https?:\/\//, '').replace(/\/$/, ''))} />
      </div>

      {/* GoDaddy instructions */}
      {registrar === 'godaddy' && (
        <div>
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 mb-4">
            <p className="text-sm font-semibold text-amber-800 mb-1">GoDaddy — Step by Step</p>
            <p className="text-xs text-amber-700">Follow these steps in your GoDaddy account. DNS changes can take up to 48 hours to propagate.</p>
          </div>

          <ol className="flex flex-col gap-4">
            <li className="flex gap-3">
              <span className="w-6 h-6 rounded-full bg-[#3D6B34] text-white text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">1</span>
              <div>
                <p className="text-sm font-semibold text-gray-800">Log in to GoDaddy</p>
                <p className="text-xs text-gray-500 mt-0.5">Go to <a href="https://dcc.godaddy.com/manage/dns" target="_blank" rel="noreferrer" className="text-[#3D6B34] underline">GoDaddy DNS Manager</a> and select <strong>{domain || 'your domain'}</strong>.</p>
              </div>
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
                <p className="text-xs text-gray-500 mt-0.5">In GoDaddy, go to <strong>Forwarding</strong> and add a domain forward:</p>
                <div className="mt-2 bg-white border border-gray-200 rounded-lg px-3 py-1">
                  <CodeLine label="Forward" value={domain ? `http://${domain}` : 'http://yourdomain.com'} id="gd-fwd-from" />
                  <CodeLine label="To"      value={domain ? `https://www.${domain}` : 'https://www.yourdomain.com'} id="gd-fwd-to" />
                  <CodeLine label="Type"    value="Permanent (301)" id="gd-fwd-type" />
                </div>
              </div>
            </li>
            <li className="flex gap-3">
              <span className="w-6 h-6 rounded-full bg-[#3D6B34] text-white text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">4</span>
              <div>
                <p className="text-sm font-semibold text-gray-800">Contact us to complete setup</p>
                <p className="text-xs text-gray-500 mt-0.5">Email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline">john@oatmealfarmnetwork.com</a> with your domain name so we can configure SSL and routing on our end.</p>
              </div>
            </li>
          </ol>
        </div>
      )}

      {/* Namecheap */}
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

      {/* Cloudflare */}
      {registrar === 'cloudflare' && (
        <div className="flex flex-col gap-4">
          <div className="bg-orange-50 border border-orange-200 rounded-xl p-4">
            <p className="text-sm font-semibold text-orange-800 mb-1">Cloudflare — DNS Records</p>
            <p className="text-xs text-orange-700">In Cloudflare, go to your domain → <strong>DNS → Records → Add record</strong>. Set the proxy to <strong>DNS only</strong> (grey cloud) initially.</p>
          </div>
          <div className="bg-white border border-gray-200 rounded-lg px-3 py-1">
            <CodeLine label="Type"  value="CNAME"        id="cf-type" />
            <CodeLine label="Name"  value="www"          id="cf-name" />
            <CodeLine label="Target" value={CNAME_TARGET} id="cf-target" />
            <CodeLine label="Proxy" value="DNS only (grey cloud)" id="cf-proxy" />
          </div>
          <p className="text-xs text-gray-500">Then email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline">john@oatmealfarmnetwork.com</a> with your domain to complete SSL setup.</p>
        </div>
      )}

      {/* Other */}
      {registrar === 'other' && (
        <div className="flex flex-col gap-4">
          <div className="bg-gray-50 border border-gray-200 rounded-xl p-4">
            <p className="text-sm font-semibold text-gray-800 mb-1">Any Registrar — CNAME Record</p>
            <p className="text-xs text-gray-600">Log in to your domain registrar and add the following DNS record. The exact steps vary by provider.</p>
          </div>
          <div className="bg-white border border-gray-200 rounded-lg px-3 py-1">
            <CodeLine label="Type"  value="CNAME"        id="oth-type" />
            <CodeLine label="Name / Host" value="www"    id="oth-name" />
            <CodeLine label="Value / Points to" value={CNAME_TARGET} id="oth-value" />
          </div>
          <p className="text-xs text-gray-500">After adding the DNS record, email <a href="mailto:john@oatmealfarmnetwork.com" className="text-[#3D6B34] underline">john@oatmealfarmnetwork.com</a> with your domain name. We'll configure SSL and routing on our servers — usually within 1 business day.</p>
        </div>
      )}

      {/* Always-visible summary */}
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
