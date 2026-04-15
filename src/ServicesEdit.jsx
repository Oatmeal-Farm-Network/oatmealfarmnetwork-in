import React, { useEffect, useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const apiBase = import.meta.env.VITE_API_URL || '';

const inputStyle = {
  display: 'block', width: '100%', padding: '8px 12px',
  border: '1px solid #d5c9bc', borderRadius: 6, fontSize: 14,
  color: '#2c1a0e', background: '#fff', boxSizing: 'border-box',
  fontFamily: 'inherit',
};

const Field = ({ label, hint, children }) => (
  <div style={{ marginBottom: 16 }}>
    <label style={{ display: 'block', fontWeight: 600, fontSize: 13, color: '#5a3e2b', marginBottom: 5 }}>
      {label}
    </label>
    {children}
    {hint && <div style={{ fontSize: 12, color: '#a08060', marginTop: 4 }}>{hint}</div>}
  </div>
);

const SaveBar = ({ saving, saved, onSave }) => (
  <div style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: 12, marginTop: 24 }}>
    {saved && <span style={{ color: '#4a7c3f', fontWeight: 600, fontSize: 14 }}>✓ Saved!</span>}
    <button
      onClick={onSave}
      disabled={saving}
      style={{
        background: saving ? '#9ab' : '#5a3e2b', color: '#fff',
        border: 'none', borderRadius: 6, padding: '10px 28px',
        fontWeight: 700, fontSize: 15, cursor: saving ? 'not-allowed' : 'pointer',
      }}
    >
      {saving ? 'Saving…' : 'Save Changes'}
    </button>
  </div>
);

// ─── BASICS TAB ──────────────────────────────────────────────────────────────
function BasicsTab({ ServicesID, BusinessID }) {
  const [form, setForm] = useState(null);
  const [categories, setCategories] = useState([]);
  const [subCategories, setSubCategories] = useState([]);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  useEffect(() => {
    if (!ServicesID) return;
    fetch(`${apiBase}/api/services/${ServicesID}`, {
      headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
    })
      .then(r => r.json())
      .then(d => {
        setForm(d);
        fetch(`${apiBase}/api/services/categories`)
          .then(r => r.json()).then(setCategories).catch(() => {});
        if (d.ServiceCategoryID) {
          fetch(`${apiBase}/api/services/categories/${d.ServiceCategoryID}/subcategories`)
            .then(r => r.json()).then(setSubCategories).catch(() => {});
        }
      });
  }, [ServicesID]);

  useEffect(() => {
    if (!form?.ServiceCategoryID) { setSubCategories([]); return; }
    fetch(`${apiBase}/api/services/categories/${form.ServiceCategoryID}/subcategories`)
      .then(r => r.json()).then(d => setSubCategories(Array.isArray(d) ? d : [])).catch(() => {});
  }, [form?.ServiceCategoryID]);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const save = async () => {
    setSaving(true);
    try {
      await fetch(`${apiBase}/api/services/${ServicesID}/update`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${localStorage.getItem('access_token')}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(form),
      });
      setSaved(true);
      setTimeout(() => setSaved(false), 3000);
    } catch (e) { console.error(e); }
    setSaving(false);
  };

  if (!form) return <div style={{ padding: '40px 0', textAlign: 'center', color: '#8b7355' }}>Loading…</div>;

  return (
    <div>
      <div style={{ fontFamily: 'Georgia, serif', fontWeight: 700, fontSize: 17, color: '#2c1a0e', borderBottom: '1px solid #e8e0d5', paddingBottom: 8, marginBottom: 20 }}>
        Basic Facts
      </div>

      <Field label="Service Title">
        <input value={form.ServiceTitle || ''} onChange={e => set('ServiceTitle', e.target.value)} maxLength={50} style={inputStyle} />
      </Field>

      <Field label="Category">
        <select
          value={form.ServiceCategoryID || ''}
          onChange={e => { set('ServiceCategoryID', e.target.value); set('ServiceSubCategoryID', ''); }}
          style={inputStyle}
        >
          <option value="">Select a category…</option>
          {categories.map(c => (
            <option key={c.ServiceCategoryID} value={c.ServiceCategoryID}>{c.ServicesCategory}</option>
          ))}
        </select>
      </Field>

      {subCategories.length > 0 && (
        <Field label="Sub-Category">
          <select value={form.ServiceSubCategoryID || ''} onChange={e => set('ServiceSubCategoryID', e.target.value)} style={inputStyle}>
            <option value="">Select…</option>
            {subCategories.map(s => (
              <option key={s.ServiceSubCategoryID} value={s.ServiceSubCategoryID}>{s.ServiceSubCategoryName}</option>
            ))}
          </select>
        </Field>
      )}

      <Field label="Price / Rate">
        <input type="number" value={form.ServicePrice || ''} onChange={e => set('ServicePrice', e.target.value)} style={{ ...inputStyle, maxWidth: 180 }} placeholder="0.00" />
      </Field>

      <Field label="Contact for Price?">
        <div style={{ display: 'flex', gap: 24 }}>
          {['Yes', 'No'].map(v => (
            <label key={v} style={{ display: 'flex', alignItems: 'center', gap: 6, cursor: 'pointer', fontSize: 14 }}>
              <input
                type="radio"
                name="ServiceContactForPrice"
                checked={String(form.ServiceContactForPrice) === (v === 'Yes' ? '1' : '0')}
                onChange={() => set('ServiceContactForPrice', v === 'Yes' ? '1' : '0')}
              />
              {v}
            </label>
          ))}
        </div>
      </Field>

      <Field label="Availability">
        <input value={form.ServiceAvailable || ''} onChange={e => set('ServiceAvailable', e.target.value)} style={inputStyle} placeholder="e.g. Weekdays, By appointment..." />
      </Field>

      <Field label="Description">
        <textarea value={form.ServicesDescription || ''} onChange={e => set('ServicesDescription', e.target.value)} rows={6} style={{ ...inputStyle, resize: 'vertical' }} />
      </Field>

      <div style={{ background: '#f9f6f2', border: '1px solid #e8e0d5', borderRadius: 8, padding: '16px 18px', marginBottom: 16 }}>
        <div style={{ fontWeight: 700, fontSize: 14, color: '#5a3e2b', marginBottom: 12 }}>
          Contact Info <span style={{ fontWeight: 400, color: '#9ca3af', fontSize: 12 }}>(optional)</span>
        </div>
        <Field label="Phone">
          <input value={form.ServicePhone || ''} onChange={e => set('ServicePhone', e.target.value)} style={inputStyle} placeholder="555-123-4567" />
        </Field>
        <Field label="Website">
          <input value={form.Servicewebsite || ''} onChange={e => set('Servicewebsite', e.target.value)} style={inputStyle} placeholder="www.yoursite.com" />
        </Field>
        <Field label="Email">
          <input type="email" value={form.Serviceemail || ''} onChange={e => set('Serviceemail', e.target.value)} style={inputStyle} placeholder="info@yourfarm.com" />
        </Field>
      </div>

      <SaveBar saving={saving} saved={saved} onSave={save} />
    </div>
  );
}

// ─── PHOTOS TAB ──────────────────────────────────────────────────────────────
function PhotosTab({ ServicesID }) {
  const [photos, setPhotos] = useState(Array(8).fill(null).map((_, i) => ({ slot: i + 1, url: '', caption: '' })));
  const [uploading, setUploading] = useState(null);
  const [saving, setSaving] = useState(null);

  useEffect(() => {
    if (!ServicesID) return;
    fetch(`${apiBase}/api/services/${ServicesID}/photos`, {
      headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
    })
      .then(r => r.json())
      .then(d => {
        if (Array.isArray(d)) setPhotos(d);
      })
      .catch(() => {});
  }, [ServicesID]);

  const setCaption = (slot, val) => setPhotos(ps => ps.map(p => p.slot === slot ? { ...p, caption: val } : p));

  const uploadPhoto = async (slot, file) => {
    setUploading(slot);
    const fd = new FormData();
    fd.append('file', file);
    fd.append('slot', slot);
    try {
      const res = await fetch(`${apiBase}/api/services/${ServicesID}/photos/upload`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
        body: fd,
      });
      const data = await res.json();
      setPhotos(ps => ps.map(p => p.slot === slot ? { ...p, url: data.url } : p));
    } catch (e) { console.error(e); }
    setUploading(null);
  };

  const removePhoto = async (slot) => {
    try {
      await fetch(`${apiBase}/api/services/${ServicesID}/photos/${slot}/remove`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
      });
      setPhotos(ps => ps.map(p => p.slot === slot ? { ...p, url: '', caption: '' } : p));
    } catch (e) { console.error(e); }
  };

  const saveCaption = async (slot, caption) => {
    setSaving(slot);
    try {
      await fetch(`${apiBase}/api/services/${ServicesID}/photos/${slot}/caption`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${localStorage.getItem('access_token')}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ caption }),
      });
    } catch (e) { console.error(e); }
    setSaving(null);
  };

  return (
    <div>
      <div style={{ fontFamily: 'Georgia, serif', fontWeight: 700, fontSize: 17, color: '#2c1a0e', borderBottom: '1px solid #e8e0d5', paddingBottom: 8, marginBottom: 20 }}>
        Service Photos
      </div>
      <p style={{ color: '#7a6a5a', fontSize: 13, marginBottom: 24 }}>
        Upload up to 8 photos for this service listing.
      </p>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: 20 }}>
        {photos.map(photo => (
          <div key={photo.slot} style={{ border: '1px solid #e8e0d5', borderRadius: 10, padding: 16, background: '#faf7f4' }}>
            <div style={{ fontWeight: 700, fontSize: 13, color: '#5a3e2b', marginBottom: 10 }}>
              Photo {photo.slot}
            </div>

            {/* Preview */}
            <div style={{ width: '100%', height: 160, background: '#f0ebe3', borderRadius: 6, marginBottom: 12, display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden' }}>
              {photo.url ? (
                <img src={photo.url} alt={`Photo ${photo.slot}`} style={{ width: '100%', height: '100%', objectFit: 'cover', borderRadius: 6 }} />
              ) : (
                <span style={{ color: '#c0a882', fontSize: 13 }}>No image</span>
              )}
            </div>

            {/* Upload */}
            <label style={{ display: 'block', marginBottom: 10 }}>
              <div style={{ fontSize: 12, fontWeight: 600, color: '#5a3e2b', marginBottom: 4 }}>Upload Photo</div>
              <input
                type="file"
                accept="image/*"
                onChange={e => e.target.files[0] && uploadPhoto(photo.slot, e.target.files[0])}
                style={{ fontSize: 12, width: '100%' }}
              />
              {uploading === photo.slot && <div style={{ fontSize: 12, color: '#8b7355', marginTop: 4 }}>Uploading…</div>}
            </label>

            {/* Caption */}
            <div style={{ display: 'flex', gap: 6, marginBottom: 8 }}>
              <input
                value={photo.caption || ''}
                onChange={e => setCaption(photo.slot, e.target.value)}
                maxLength={30}
                placeholder="Caption (optional)"
                style={{ ...inputStyle, fontSize: 12, padding: '5px 8px', flex: 1 }}
              />
              <button
                onClick={() => saveCaption(photo.slot, photo.caption)}
                disabled={saving === photo.slot}
                style={{ background: '#5a3e2b', color: '#fff', border: 'none', borderRadius: 5, padding: '5px 10px', fontSize: 12, cursor: 'pointer', whiteSpace: 'nowrap' }}
              >
                {saving === photo.slot ? '…' : 'Save'}
              </button>
            </div>

            {/* Remove */}
            {photo.url && (
              <button
                onClick={() => removePhoto(photo.slot)}
                style={{ background: 'none', border: '1px solid #e0b0b0', borderRadius: 5, padding: '4px 12px', fontSize: 12, color: '#c0392b', cursor: 'pointer', width: '100%' }}
              >
                Remove Image
              </button>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}

// ─── MAIN COMPONENT ──────────────────────────────────────────────────────────
const TABS = [
  { id: 'basics', label: 'Basic Facts' },
  { id: 'photos', label: 'Photos' },
];

export default function ServicesEdit() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const ServicesID = searchParams.get('ServicesID');
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  const [activeTab, setActiveTab] = useState('basics');
  const [serviceTitle, setServiceTitle] = useState('Service');

  useEffect(() => {
    if (BusinessID) LoadBusiness(BusinessID);
    if (!ServicesID) return;
    fetch(`${apiBase}/api/services/${ServicesID}`, {
      headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
    })
      .then(r => r.json())
      .then(d => setServiceTitle(d.ServiceTitle || 'Service'))
      .catch(() => {});
  }, [BusinessID, ServicesID]);

  if (!ServicesID) return (
    <div style={{ padding: 40, textAlign: 'center', color: '#7a6a5a' }}>
      No service selected. <a href={`/services?BusinessID=${BusinessID}`} style={{ color: '#5a3e2b' }}>Back to services</a>
    </div>
  );

  const tabComponents = {
    basics: <BasicsTab ServicesID={ServicesID} BusinessID={BusinessID} />,
    photos: <PhotosTab ServicesID={ServicesID} />,
  };

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Edit Service" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Services' }, { label: 'My Services', to: `/services?BusinessID=${BusinessID}` }, { label: 'Edit' }]}>
      <div style={{ maxWidth: 860, margin: '0 auto', padding: '0 0 60px' }}>

        {/* Breadcrumb */}
        <div style={{ fontSize: 13, color: '#8b7355', marginBottom: 14 }}>
          <span style={{ cursor: 'pointer', textDecoration: 'underline' }} onClick={() => navigate(`/services?BusinessID=${BusinessID}`)}>
            My Services
          </span>
          {' › '}
          <span style={{ color: '#2c1a0e' }}>{serviceTitle}</span>
        </div>

        {/* Header */}
        <div style={{ background: '#fff', border: '1px solid #e8e0d5', borderRadius: 10, padding: '16px 24px', marginBottom: 20, display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: 12 }}>
          <div style={{ fontWeight: 700, fontSize: 20, color: '#2c1a0e', fontFamily: 'Georgia, serif' }}>{serviceTitle}</div>
          <button
            onClick={() => navigate(`/services?BusinessID=${BusinessID}`)}
            style={{ background: 'none', border: '1px solid #d5c9bc', borderRadius: 6, padding: '7px 18px', fontWeight: 600, fontSize: 13, color: '#8b7355', cursor: 'pointer' }}
          >
            ← Back to Services
          </button>
        </div>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: 0, borderBottom: '2px solid #e8e0d5', marginBottom: 28 }}>
          {TABS.map(tab => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              style={{
                background: 'none', border: 'none',
                borderBottom: activeTab === tab.id ? '2px solid #5a3e2b' : '2px solid transparent',
                marginBottom: -2, padding: '10px 24px',
                fontWeight: activeTab === tab.id ? 700 : 500,
                color: activeTab === tab.id ? '#5a3e2b' : '#8b7355',
                fontSize: 14, cursor: 'pointer', whiteSpace: 'nowrap',
              }}
            >
              {tab.label}
            </button>
          ))}
        </div>

        {/* Tab content */}
        <div style={{ background: '#fff', border: '1px solid #e8e0d5', borderRadius: 10, padding: '28px 32px', boxShadow: '0 2px 12px rgba(90,62,43,0.06)' }}>
          {tabComponents[activeTab]}
        </div>

      </div>
    </AccountLayout>
  );
}
