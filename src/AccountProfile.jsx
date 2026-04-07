import React, { useEffect, useState } from 'react';
import { useNavigate, useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function AccountProfile() {
  const [searchParams] = useSearchParams();
  const businessId = searchParams.get('BusinessID');
  const navigate = useNavigate();
  const { Business, LoadBusiness } = useAccount();

  const [form, setForm] = useState(null);
  const [states, setStates] = useState([]);
  const [saving, setSaving] = useState(false);
  const [success, setSuccess] = useState(false);
  const [errors, setErrors] = useState({});

  const peopleId = localStorage.getItem('people_id');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }
    if (!businessId) { navigate('/dashboard'); return; }

    LoadBusiness(businessId);

    fetch(`${API_URL}/api/businesses/profile/${businessId}`)
      .then(r => r.json())
      .then(data => {
        setForm(data);
        const country = data.country_name || 'USA';
        return fetch(`${API_URL}/api/businesses/states?country=${encodeURIComponent(country)}`);
      })
      .then(r => r.json())
      .then(data => setStates(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, [businessId]);

  const update = (field, value) => {
    setForm(f => ({ ...f, [field]: value }));
    setSuccess(false);
  };

  const handleCountryChange = (country) => {
    update('country_name', country);
    update('StateIndex', '');
    fetch(`${API_URL}/api/businesses/states?country=${encodeURIComponent(country)}`)
      .then(r => r.json())
      .then(data => setStates(Array.isArray(data) ? data : []))
      .catch(() => setStates([]));
  };

  const validate = () => {
    const e = {};
    if (!form.BusinessName?.trim()) e.BusinessName = 'Business name is required.';
    if (!form.ContactEmail?.trim()) e.ContactEmail = 'Email is required.';
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleSave = async () => {
    if (!validate()) return;
    setSaving(true);
    setSuccess(false);
    try {
      const res = await fetch(`${API_URL}/api/businesses/profile/${businessId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${localStorage.getItem('access_token')}`,
        },
        body: JSON.stringify(form),
      });
      if (res.ok) {
        setSuccess(true);
        LoadBusiness(businessId, true);
        window.scrollTo(0, 0);
      } else {
        const data = await res.json();
        setErrors({ submit: data.detail || 'An error occurred.' });
      }
    } catch {
      setErrors({ submit: 'An error occurred. Please try again.' });
    } finally {
      setSaving(false);
    }
  };

  const inputClass = "w-full border border-gray-300 rounded px-3 py-2 text-sm focus:outline-none focus:border-[#819360]";
  const labelClass = "block text-sm font-medium text-gray-600 mb-1";
  const errorClass = "text-red-500 text-xs mt-1";

  if (!form || !Business) return (
    <AccountLayout Business={Business} BusinessID={businessId} PeopleID={peopleId}>
      <div className="text-center py-20 text-gray-400">Loading...</div>
    </AccountLayout>
  );

  return (
    <AccountLayout Business={Business} BusinessID={businessId} PeopleID={peopleId}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6 mx-auto" max-w-full>

        <h1 className="text-2xl font-bold text-gray-800 mb-6">Account Profile</h1>

        {success && (
          <div className="bg-green-50 border border-green-300 text-green-700 rounded px-4 py-3 text-sm mb-6">
            Profile updated successfully.
          </div>
        )}

        {errors.submit && (
          <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm mb-6">
            {errors.submit}
          </div>
        )}

        <div className="space-y-5">

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className={labelClass}>First Name <span className="text-gray-400 font-normal">(Optional)</span></label>
              <input type="text" value={form.ContactFirstName || ''} onChange={e => update('ContactFirstName', e.target.value)} className={inputClass} />
            </div>
            <div>
              <label className={labelClass}>Last Name <span className="text-gray-400 font-normal">(Optional)</span></label>
              <input type="text" value={form.ContactLastName || ''} onChange={e => update('ContactLastName', e.target.value)} className={inputClass} />
            </div>
          </div>

          <div>
            <label className={labelClass}>Business / Organization Name</label>
            <input type="text" value={form.BusinessName || ''} onChange={e => update('BusinessName', e.target.value)} className={inputClass} maxLength={100} />
            {errors.BusinessName && <p className={errorClass}>{errors.BusinessName}</p>}
          </div>

          <div>
            <label className={labelClass}>Website <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="text" value={form.BusinessWebsite || ''} onChange={e => update('BusinessWebsite', e.target.value)} className={inputClass} placeholder="https://yourwebsite.com" />
          </div>

          <div>
            <label className={labelClass}>Email</label>
            <input type="email" value={form.ContactEmail || ''} onChange={e => update('ContactEmail', e.target.value)} className={inputClass} />
            {errors.ContactEmail && <p className={errorClass}>{errors.ContactEmail}</p>}
          </div>

          <hr className="border-gray-100" />

          <div>
            <label className={labelClass}>Mailing Address <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="text" value={form.AddressStreet || ''} onChange={e => update('AddressStreet', e.target.value)} className={inputClass} />
          </div>

          <div>
            <label className={labelClass}>Apartment / Suite <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="text" value={form.AddressApt || ''} onChange={e => update('AddressApt', e.target.value)} className={inputClass} />
          </div>

          <div>
            <label className={labelClass}>City <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="text" value={form.AddressCity || ''} onChange={e => update('AddressCity', e.target.value)} className={inputClass} />
          </div>

          <div>
            <label className={labelClass}>Country <span className="text-gray-400 font-normal">(Optional)</span></label>
            <select value={form.country_name || 'USA'} onChange={e => handleCountryChange(e.target.value)} className={inputClass}>
              <option value="USA">USA</option>
              <option value="Canada">Canada</option>
            </select>
          </div>

          <div>
            <label className={labelClass}>State / Province <span className="text-gray-400 font-normal">(Optional)</span></label>
            <select value={form.StateIndex || ''} onChange={e => update('StateIndex', e.target.value)} className={inputClass}>
              <option value="">Select...</option>
              {states.map(s => (
                <option key={s.StateIndex} value={s.StateIndex}>{s.name}</option>
              ))}
            </select>
          </div>

          <div>
            <label className={labelClass}>Postal Code <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="text" value={form.AddressZip || ''} onChange={e => update('AddressZip', e.target.value)} className={inputClass} maxLength={10} />
          </div>

          <hr className="border-gray-100" />

          <div>
            <label className={labelClass}>Phone <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="tel" value={form.BusinessPhone || ''} onChange={e => update('BusinessPhone', e.target.value.replace(/[^0-9().\-\s+]/g, ''))} className={inputClass} />
          </div>

          <div>
            <label className={labelClass}>Cell <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="tel" value={form.BusinessCell || ''} onChange={e => update('BusinessCell', e.target.value.replace(/[^0-9().\-\s+]/g, ''))} className={inputClass} />
          </div>

          <div>
            <label className={labelClass}>Fax <span className="text-gray-400 font-normal">(Optional)</span></label>
            <input type="tel" value={form.BusinessFax || ''} onChange={e => update('BusinessFax', e.target.value.replace(/[^0-9().\-\s+]/g, ''))} className={inputClass} />
          </div>

          <div className="pt-4">
            <button onClick={handleSave} disabled={saving} className="regsubmit2 w-full">
              {saving ? 'Saving...' : 'Update Account'}
            </button>
          </div>

        </div>
      </div>
    </AccountLayout>
  );
}