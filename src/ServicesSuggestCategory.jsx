import React, { useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const apiBase = import.meta.env.VITE_API_URL || '';

export default function ServicesSuggestCategory() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [form, setForm] = useState({
    Categories: '',
    SubCategories: '',
  });
  const [submitted, setSubmitted] = useState(false);
  const [saving, setSaving] = useState(false);

  React.useEffect(() => {
    if (BusinessID) LoadBusiness(BusinessID);
  }, [BusinessID]);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const submit = async () => {
    if (!form.Categories.trim()) return;
    setSaving(true);
    try {
      await fetch(`${apiBase}/api/services/suggest-category`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${localStorage.getItem('access_token')}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          BusinessID,
          BusinessName: Business?.BusinessName || '',
          Email: localStorage.getItem('email') || '',
          Categories: form.Categories,
          SubCategories: form.SubCategories,
        }),
      });
      setSubmitted(true);
    } catch (err) {
      console.error('Error submitting suggestion:', err);
    }
    setSaving(false);
  };

  const inputStyle = {
    display: 'block', width: '100%', padding: '8px 12px',
    border: '1px solid #d5c9bc', borderRadius: 6, fontSize: 14,
    color: '#2c1a0e', background: '#fff', boxSizing: 'border-box',
    fontFamily: 'inherit',
  };

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Suggest Category" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Services' }, { label: 'Suggest Category' }]}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6" style={{ maxWidth: 1300 }}>

        <div style={{ fontFamily: 'Georgia, serif', fontWeight: 700, fontSize: 22, color: '#2c1a0e', marginBottom: 6 }}>
          Suggest a New Service Category
        </div>
        <p style={{ color: '#7a6a5a', fontSize: 14, marginBottom: 24 }}>
          If you can't find the right category for your service, let us know what you'd like added. We'll review your suggestion and notify you if it's added.
        </p>

        {submitted ? (
          <div style={{
            background: '#f0f7ee', border: '1px solid #b7d9b0',
            borderRadius: 8, padding: '20px 24px', marginBottom: 24,
          }}>
            <div style={{ fontWeight: 700, color: '#4a7c3f', fontSize: 15, marginBottom: 4 }}>
              ✓ Thanks for your suggestion!
            </div>
            <p style={{ color: '#5a7a54', fontSize: 14, margin: 0 }}>
              We'll review it and let you know if we add the category.
            </p>
          </div>
        ) : (
          <>
            {/* Business name (read-only) */}
            <div style={{ marginBottom: 16 }}>
              <label style={{ display: 'block', fontWeight: 600, fontSize: 13, color: '#5a3e2b', marginBottom: 5 }}>
                Business Name
              </label>
              <input
                value={Business?.BusinessName || ''}
                readOnly
                style={{ ...inputStyle, background: '#f9f6f2', color: '#8b7355' }}
              />
            </div>

            {/* Suggested Categories */}
            <div style={{ marginBottom: 16 }}>
              <label style={{ display: 'block', fontWeight: 600, fontSize: 13, color: '#5a3e2b', marginBottom: 5 }}>
                Suggested Categories
              </label>
              <textarea
                value={form.Categories}
                onChange={e => set('Categories', e.target.value)}
                rows={3}
                placeholder="e.g. Equine Therapy, Agritourism..."
                style={{ ...inputStyle, resize: 'vertical' }}
              />
            </div>

            {/* Suggested Sub-Categories */}
            <div style={{ marginBottom: 24 }}>
              <label style={{ display: 'block', fontWeight: 600, fontSize: 13, color: '#5a3e2b', marginBottom: 5 }}>
                Suggested Sub-Categories
              </label>
              <textarea
                value={form.SubCategories}
                onChange={e => set('SubCategories', e.target.value)}
                rows={3}
                placeholder="e.g. Trail Rides, Farm Tours..."
                style={{ ...inputStyle, resize: 'vertical' }}
              />
            </div>

            {/* Actions */}
            <div style={{ display: 'flex', gap: 12, justifyContent: 'flex-end' }}>
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
                disabled={saving || !form.Categories.trim()}
                style={{
                  background: saving || !form.Categories.trim() ? '#9ab' : '#5a3e2b',
                  color: '#fff', border: 'none', borderRadius: 6,
                  padding: '10px 28px', fontWeight: 700, fontSize: 15,
                  cursor: saving || !form.Categories.trim() ? 'not-allowed' : 'pointer',
                }}
              >
                {saving ? 'Sending…' : 'Send Suggestion'}
              </button>
            </div>
          </>
        )}

        {submitted && (
          <button
            onClick={() => navigate(`/services?BusinessID=${BusinessID}`)}
            style={{
              background: '#5a3e2b', color: '#fff', border: 'none', borderRadius: 6,
              padding: '10px 24px', fontWeight: 700, fontSize: 14, cursor: 'pointer',
            }}
          >
            Back to Services
          </button>
        )}

      </div>
    </AccountLayout>
  );
}
