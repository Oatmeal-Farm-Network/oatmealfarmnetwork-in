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

const selectStyle = { ...inputStyle };

const Field = ({ label, error, children, hint }) => (
  <div style={{ marginBottom: 18 }}>
    <label style={{ display: 'block', fontWeight: 600, fontSize: 13, color: '#5a3e2b', marginBottom: 5 }}>
      {label}
    </label>
    {children}
    {hint && <div style={{ fontSize: 12, color: '#a08060', marginTop: 4 }}>{hint}</div>}
    {error && <div style={{ fontSize: 12, color: '#c0392b', marginTop: 4 }}>{error}</div>}
  </div>
);

export default function ServicesAdd() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [categories, setCategories] = useState([]);
  const [subCategories, setSubCategories] = useState([]);
  const [form, setForm] = useState({
    ServiceTitle: '',
    ServiceCategoryID: '',
    ServiceSubCategoryID: '',
    ServicePrice: '',
    ServiceAvailable: '',
    ServiceContactForPrice: '0',
    ServicePhone: '',
    Servicewebsite: '',
    Serviceemail: '',
    ServicesDescription: '',
  });
  const [saving, setSaving] = useState(false);
  const [errors, setErrors] = useState({});

  useEffect(() => {
    if (!BusinessID) return;
    LoadBusiness(BusinessID);
    fetch(`${apiBase}/api/services/categories`)
      .then(r => r.json())
      .then(d => setCategories(Array.isArray(d) ? d : []))
      .catch(() => {});
  }, [BusinessID]);

  useEffect(() => {
    if (!form.ServiceCategoryID) { setSubCategories([]); return; }
    fetch(`${apiBase}/api/services/categories/${form.ServiceCategoryID}/subcategories`)
      .then(r => r.json())
      .then(d => setSubCategories(Array.isArray(d) ? d : []))
      .catch(() => setSubCategories([]));
  }, [form.ServiceCategoryID]);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const validate = () => {
    const e = {};
    if (!form.ServiceTitle.trim()) e.ServiceTitle = 'Please enter a service title.';
    if (!form.ServiceCategoryID) e.ServiceCategoryID = 'Please select a category.';
    return e;
  };

  const submit = async () => {
    const e = validate();
    if (Object.keys(e).length > 0) { setErrors(e); return; }
    setErrors({});
    setSaving(true);
    try {
      const res = await fetch(`${apiBase}/api/services/add`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${localStorage.getItem('access_token')}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ ...form, BusinessID }),
      });
      const data = await res.json();
      if (data.ServicesID) {
        navigate(`/services/edit?BusinessID=${BusinessID}&ServicesID=${data.ServicesID}`);
      }
    } catch (err) {
      console.error('Error adding service:', err);
    }
    setSaving(false);
  };

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Add Service" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Services' }, { label: 'My Services', to: `/services?BusinessID=${BusinessID}` }, { label: 'Add' }]}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6" style={{ maxWidth: 600 }}>

        <div style={{ fontFamily: 'Georgia, serif', fontWeight: 700, fontSize: 22, color: '#2c1a0e', marginBottom: 6 }}>
          Add a Service
        </div>
        <p style={{ color: '#7a6a5a', fontSize: 14, marginBottom: 24 }}>
          Fill in the details below. You can add photos and more details after saving.
        </p>

        <Field label="Service Title" error={errors.ServiceTitle} hint="Max 50 characters">
          <input
            value={form.ServiceTitle}
            onChange={e => set('ServiceTitle', e.target.value)}
            maxLength={50}
            style={inputStyle}
            placeholder="e.g. Farrier Services, Horse Training..."
          />
        </Field>

        <Field label="Category" error={errors.ServiceCategoryID}>
          <select
            value={form.ServiceCategoryID}
            onChange={e => { set('ServiceCategoryID', e.target.value); set('ServiceSubCategoryID', ''); }}
            style={selectStyle}
          >
            <option value="">Select a category…</option>
            {categories.map(c => (
              <option key={c.ServiceCategoryID} value={c.ServiceCategoryID}>{c.ServicesCategory}</option>
            ))}
          </select>
        </Field>

        {subCategories.length > 0 && (
          <Field label="Sub-Category">
            <select
              value={form.ServiceSubCategoryID}
              onChange={e => set('ServiceSubCategoryID', e.target.value)}
              style={selectStyle}
            >
              <option value="">Select a sub-category…</option>
              {subCategories.map(s => (
                <option key={s.ServiceSubCategoryID} value={s.ServiceSubCategoryID}>{s.ServiceSubCategoryName}</option>
              ))}
            </select>
          </Field>
        )}

        <Field label="Price / Rate" hint="Leave blank if you prefer 'Contact for Price'">
          <input
            type="number"
            value={form.ServicePrice}
            onChange={e => set('ServicePrice', e.target.value)}
            style={{ ...inputStyle, maxWidth: 180 }}
            placeholder="0.00"
          />
        </Field>

        <Field label="Contact for Price?">
          <div style={{ display: 'flex', gap: 24 }}>
            {['Yes', 'No'].map(v => (
              <label key={v} style={{ display: 'flex', alignItems: 'center', gap: 6, cursor: 'pointer', fontSize: 14 }}>
                <input
                  type="radio"
                  name="ServiceContactForPrice"
                  value={v === 'Yes' ? '1' : '0'}
                  checked={form.ServiceContactForPrice === (v === 'Yes' ? '1' : '0')}
                  onChange={() => set('ServiceContactForPrice', v === 'Yes' ? '1' : '0')}
                />
                {v}
              </label>
            ))}
          </div>
        </Field>

        <Field label="Availability">
          <input
            value={form.ServiceAvailable}
            onChange={e => set('ServiceAvailable', e.target.value)}
            style={inputStyle}
            placeholder="e.g. Weekdays, By appointment..."
          />
        </Field>

        <Field label="Description">
          <textarea
            value={form.ServicesDescription}
            onChange={e => set('ServicesDescription', e.target.value)}
            rows={5}
            style={{ ...inputStyle, resize: 'vertical' }}
            placeholder="Describe your service..."
          />
        </Field>

        <div style={{
          background: '#f9f6f2', border: '1px solid #e8e0d5',
          borderRadius: 8, padding: '16px 18px', marginBottom: 18,
        }}>
          <div style={{ fontWeight: 700, fontSize: 14, color: '#5a3e2b', marginBottom: 12 }}>
            Contact Info <span style={{ fontWeight: 400, color: '#9ca3af', fontSize: 12 }}>(optional)</span>
          </div>
          <Field label="Phone">
            <input value={form.ServicePhone} onChange={e => set('ServicePhone', e.target.value)} style={inputStyle} placeholder="e.g. 555-123-4567" />
          </Field>
          <Field label="Website">
            <input value={form.Servicewebsite} onChange={e => set('Servicewebsite', e.target.value)} style={inputStyle} placeholder="e.g. www.yoursite.com" />
          </Field>
          <Field label="Email">
            <input type="email" value={form.Serviceemail} onChange={e => set('Serviceemail', e.target.value)} style={inputStyle} placeholder="e.g. info@yourfarm.com" />
          </Field>
        </div>

        <p style={{ fontSize: 13, color: '#8b7355', marginBottom: 24 }}>
          Don't see your category?{' '}
          <a href={`/services/suggest-category?BusinessID=${BusinessID}`} style={{ color: '#5a3e2b', textDecoration: 'underline' }}>
            Suggest a new category
          </a>
        </p>

        <div style={{ display: 'flex', gap: 12, alignItems: 'center', justifyContent: 'flex-end' }}>
          <button
            onClick={() => navigate(`/services?BusinessID=${BusinessID}`)}
            style={{
              background: 'none', border: '1px solid #d5c9bc', borderRadius: 6,
              padding: '10px 20px', fontWeight: 600, fontSize: 14,
              color: '#8b7355', cursor: 'pointer',
            }}
          >
            Cancel
          </button>
          <button
            onClick={submit}
            disabled={saving}
            style={{
              background: saving ? '#9ab' : '#5a3e2b',
              color: '#fff', border: 'none', borderRadius: 6,
              padding: '10px 28px', fontWeight: 700, fontSize: 15,
              cursor: saving ? 'not-allowed' : 'pointer',
            }}
          >
            {saving ? 'Saving…' : 'Save & Continue to Edit'}
          </button>
        </div>

      </div>
    </AccountLayout>
  );
}