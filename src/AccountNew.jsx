import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';
const OTF_API = import.meta.env.VITE_OTF_API_URL || import.meta.env.VITE_API_URL || '';
const FORM_MAX_WIDTH = '780px';

const SAGE = '#4A5C43';
const SAGE_BG = '#EEF1EC';
const SAGE_BORDER = '#C8D5C2';

// ── Inline Cassia chat for the plan-selection step ──────────────────────────
function CassiaChat({ businessId, peopleId, onSkip }) {
  const [msgs, setMsgs] = React.useState([]);
  const [history, setHistory] = React.useState([]);
  const [input, setInput] = React.useState('');
  const [loading, setLoading] = React.useState(false);
  const [rec, setRec] = React.useState(null); // recommendation data
  const [paying, setPaying] = React.useState(false);
  const [err, setErr] = React.useState('');
  const bottomRef = React.useRef(null);

  const cassiaHeaders = React.useMemo(() => ({
    'Content-Type':   'application/json',
    'x-people-id':    String(peopleId || localStorage.getItem('people_id') || '0'),
    'x-access-level': localStorage.getItem('access_level') || '1',
    'x-business-id':  String(businessId || '0'),
  }), [businessId, peopleId]);

  const send = React.useCallback(async (userText, isOpening = false) => {
    const trimmed = userText.trim();
    if (!trimmed) return;
    if (!isOpening) setMsgs(m => [...m, { role: 'user', content: trimmed }]);
    setLoading(true);
    setErr('');
    try {
      const res = await fetch(`${OTF_API}/api/cassia/chat`, {
        method: 'POST',
        headers: cassiaHeaders,
        body: JSON.stringify({ messages: history, userMessage: trimmed }),
      });
      if (!res.ok) throw new Error('Cassia is unavailable right now.');
      const data = await res.json();
      setMsgs(m => [...m, { role: 'assistant', content: data.message }]);
      setHistory(h => [
        ...h,
        { role: 'user', content: trimmed },
        data.assistantMessage || { role: 'assistant', content: data.message },
      ]);
      if (data.action === 'show_recommendation' || data.action === 'ready_to_checkout') {
        if (data.data) setRec(data.data);
      }
    } catch (e) {
      setErr(e.message);
    } finally {
      setLoading(false);
    }
  }, [history, cassiaHeaders]);

  // Opening greeting on mount
  React.useEffect(() => { send('<<START>>', true); }, []);

  React.useEffect(() => { bottomRef.current?.scrollIntoView({ behavior: 'smooth' }); }, [msgs, loading]);

  const handleCheckout = async () => {
    if (!rec) return;
    setPaying(true);
    setErr('');
    try {
      const returnBase = window.location.origin;
      const res = await fetch(`${OTF_API}/api/cassia/checkout`, {
        method: 'POST',
        headers: cassiaHeaders,
        body: JSON.stringify({
          tier:        rec.tier,
          categories:  rec.categories || [],
          lineItems:   rec.lineItems  || [],
          monthlyTotal: rec.monthlyTotal || 0,
          successUrl: `${returnBase}/account?PeopleID=${peopleId}&BusinessID=${businessId}&subscribed=1`,
          cancelUrl:  `${returnBase}/accounts/new?PeopleID=${peopleId}&cancelled=1`,
        }),
      });
      if (!res.ok) throw new Error('Could not create checkout session.');
      const { stripeUrl, token } = await res.json();
      if (stripeUrl) {
        window.location.href = stripeUrl;
      } else {
        // Free plan — just navigate back to account
        window.location.href = `${returnBase}/account?PeopleID=${peopleId}&BusinessID=${businessId}&subscribed=1`;
      }
    } catch (e) {
      setErr(e.message);
      setPaying(false);
    }
  };

  const TIER_COLORS = {
    hobby:      { bg: '#eff6ff', color: '#3b82f6', border: '#bfdbfe' },
    starter:    { bg: '#dcfce7', color: '#16a34a', border: '#86efac' },
    business:   { bg: '#f3e8ff', color: '#7c3aed', border: '#d8b4fe' },
    enterprise: { bg: '#fef3c7', color: '#d97706', border: '#fde68a' },
  };
  const TIER_LABELS = { hobby: 'Hobby (Free)', starter: 'Starter', business: 'Business', enterprise: 'Enterprise' };

  const tc = rec ? (TIER_COLORS[rec.tier] || TIER_COLORS.starter) : TIER_COLORS.starter;

  return (
    <div style={{ display: 'flex', gap: '1rem', alignItems: 'flex-start' }}>

      {/* Chat pane */}
      <div style={{ flex: 1, minWidth: 0, display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>

        {/* Header */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 10,
          background: SAGE, borderRadius: 10, padding: '0.75rem 1rem', color: '#fff' }}>
          <div style={{ width: 32, height: 32, borderRadius: '50%', background: '#fff',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: '0.9rem', fontWeight: 700, color: SAGE, flexShrink: 0 }}>C</div>
          <div>
            <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Cassia</div>
            <div style={{ fontSize: '0.7rem', opacity: 0.85 }}>Your Oatmeal Farm Network guide</div>
          </div>
          <button onClick={onSkip}
            style={{ marginLeft: 'auto', background: 'rgba(255,255,255,0.15)', border: 'none',
              color: '#fff', borderRadius: 6, fontSize: '0.72rem', padding: '0.2rem 0.6rem',
              cursor: 'pointer', opacity: 0.8 }}>
            Skip →
          </button>
        </div>

        {/* Messages */}
        <div style={{ maxHeight: 320, overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: 8 }}>
          {msgs.map((m, i) => (
            <div key={i} style={{ display: 'flex', justifyContent: m.role === 'user' ? 'flex-end' : 'flex-start' }}>
              <div style={{
                maxWidth: '85%', padding: '0.55rem 0.8rem', borderRadius: 12,
                fontSize: '0.84rem', lineHeight: 1.5,
                background: m.role === 'user' ? SAGE : SAGE_BG,
                color: m.role === 'user' ? '#fff' : '#1f2937',
                border: m.role === 'assistant' ? `1px solid ${SAGE_BORDER}` : 'none',
              }}>
                {m.content}
              </div>
            </div>
          ))}
          {loading && (
            <div style={{ display: 'flex' }}>
              <div style={{ padding: '0.55rem 0.8rem', background: SAGE_BG, border: `1px solid ${SAGE_BORDER}`,
                borderRadius: 12, fontSize: '0.84rem', color: '#6b7280' }}>
                Cassia is thinking…
              </div>
            </div>
          )}
          {err && <div style={{ color: '#dc2626', fontSize: '0.78rem', padding: '0.25rem 0.5rem' }}>{err}</div>}
          <div ref={bottomRef} />
        </div>

        {/* Input */}
        <div style={{ display: 'flex', gap: 6 }}>
          <input
            value={input}
            onChange={e => setInput(e.target.value)}
            onKeyDown={e => { if (e.key === 'Enter' && !e.shiftKey && input.trim()) { send(input); setInput(''); } }}
            placeholder="Type your reply…"
            disabled={loading}
            style={{ flex: 1, border: `1px solid ${SAGE_BORDER}`, borderRadius: 8,
              padding: '0.5rem 0.75rem', fontSize: '0.85rem',
              outline: 'none', background: '#fff' }}
          />
          <button
            onClick={() => { if (input.trim()) { send(input); setInput(''); } }}
            disabled={loading || !input.trim()}
            style={{ background: SAGE, color: '#fff', border: 'none', borderRadius: 8,
              padding: '0.5rem 0.9rem', fontWeight: 700, cursor: 'pointer',
              fontSize: '0.85rem', opacity: (loading || !input.trim()) ? 0.5 : 1 }}>
            Send
          </button>
        </div>
      </div>

      {/* Recommendation panel — appears once Cassia has a suggestion */}
      {rec && (
        <div style={{ width: 260, flexShrink: 0, background: '#fff',
          border: `1px solid ${SAGE_BORDER}`, borderRadius: 12, padding: '1rem', fontSize: '0.82rem' }}>

          <div style={{ fontWeight: 700, color: SAGE, marginBottom: 8, fontSize: '0.8rem',
            textTransform: 'uppercase', letterSpacing: '0.05em' }}>Cassia's Recommendation</div>

          <span style={{ padding: '2px 10px', borderRadius: 12, fontWeight: 700, fontSize: '0.75rem',
            textTransform: 'uppercase', letterSpacing: '0.04em',
            background: tc.bg, color: tc.color, border: `1px solid ${tc.border}`,
            display: 'inline-block', marginBottom: 8 }}>
            {TIER_LABELS[rec.tier] || rec.tier}
          </span>

          {rec.reasoning && (
            <p style={{ color: '#4b5563', lineHeight: 1.5, marginBottom: 8 }}>{rec.reasoning}</p>
          )}

          {rec.lineItems?.length > 0 && (
            <div style={{ borderTop: `1px solid ${SAGE_BORDER}`, paddingTop: 8, marginBottom: 8 }}>
              {rec.lineItems.map((item, i) => (
                <div key={i} style={{ display: 'flex', justifyContent: 'space-between',
                  gap: 6, marginBottom: 4, color: '#374151' }}>
                  <span style={{ flex: 1 }}>{item.name}</span>
                  <span style={{ fontWeight: 600, color: item.price === 0 ? '#16a34a' : '#111827', flexShrink: 0 }}>
                    {item.price === 0 ? 'Free' : `$${Number(item.price).toFixed(2)}`}
                  </span>
                </div>
              ))}
              <div style={{ display: 'flex', justifyContent: 'space-between',
                borderTop: `1px solid ${SAGE_BORDER}`, paddingTop: 6, marginTop: 4,
                fontWeight: 700, color: SAGE }}>
                <span>Total/mo</span>
                <span>{rec.monthlyTotal === 0 ? 'Free' : `$${Number(rec.monthlyTotal).toFixed(2)}`}</span>
              </div>
            </div>
          )}

          {err && <div style={{ color: '#dc2626', fontSize: '0.75rem', marginBottom: 6 }}>{err}</div>}

          <button onClick={handleCheckout} disabled={paying}
            style={{ width: '100%', padding: '0.6rem', background: SAGE, color: '#fff',
              border: 'none', borderRadius: 8, fontWeight: 700, fontSize: '0.85rem',
              cursor: paying ? 'not-allowed' : 'pointer', opacity: paying ? 0.7 : 1 }}>
            {paying ? 'Processing…' : rec.monthlyTotal === 0
              ? 'Activate Free Plan →'
              : `Pay $${Number(rec.monthlyTotal).toFixed(2)}/mo →`}
          </button>
        </div>
      )}
    </div>
  );
}

async function createOTFCommunity(businessId, businessName, knownPeopleId) {
  try {
    const token    = localStorage.getItem('access_token') || '';
    // Accept the caller's known peopleId, or fall back to either localStorage key
    const peopleId = String(
      knownPeopleId ||
      localStorage.getItem('people_id') ||
      localStorage.getItem('PeopleID') ||
      new URLSearchParams(window.location.search).get('PeopleID') ||
      '0'
    );
    if (!peopleId || peopleId === '0') {
      console.warn('[OTF] skipping community creation — no people_id available');
      return;
    }
    const res = await fetch(`${OTF_API}/api/admin/mill/communities`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}`, 'x-people-id': peopleId },
      body: JSON.stringify({
        name: `${businessName || 'My Org'} — Over The Fence`,
        linkedBusinessId: businessId,
        isPublic: false,
        iconEmoji: '🌾',
      }),
    });
    const data = await res.json().catch(() => ({}));
    if (!res.ok) {
      console.warn('[OTF] community creation failed:', res.status, data);
    } else {
      console.log('[OTF] community created:', data);
    }
  } catch (e) {
    console.warn('[OTF] community creation error:', e);
  }
}

export default function AccountNew() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [businessTypes, setBusinessTypes] = useState([]);
  const [countries, setCountries] = useState([]);
  const [states, setStates] = useState([]);
  const [errors, setErrors] = useState({});
  const [submitting, setSubmitting] = useState(false);
  const [createdBusinessId, setCreatedBusinessId] = useState(null);

  const [form, setForm] = useState({
    BusinessTypeID: '',
    BusinessName: '',
    BusinessWebsite: '',
    AddressStreet: '',
    AddressApt: '',
    AddressCity: '',
    country_id: '',
    country: '',
    StateIndex: '',
    AddressZip: '',
    PeoplePhone: '',
    Permission: true,
    LivestockLegalDisclaimer: false,
    SalesLegalDisclaimer: false,
  });

  const peopleId = localStorage.getItem('people_id') ||
                   localStorage.getItem('PeopleID') ||
                   new URLSearchParams(window.location.search).get('PeopleID');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }

    fetch(`${API_URL}/api/businesses/types`)
      .then(r => r.json())
      .then(data => setBusinessTypes(Array.isArray(data) ? data : []))
      .catch(() => {});

    fetch(`${API_URL}/api/businesses/countries`)
      .then(r => r.json())
      .then(data => {
        const list = Array.isArray(data) ? data : [];
        setCountries(list);
        // Default to United States on first load
        const us = list.find(c => c.name === 'USA' || c.name === 'United States');
        if (us) setForm(f => ({ ...f, country_id: us.country_id, country: us.name }));
      })
      .catch(() => {});
  }, [navigate]);

  useEffect(() => {
    if (!form.country) return;
    setStates([]);
    fetch(`${API_URL}/api/businesses/states?country=${encodeURIComponent(form.country)}`)
      .then(r => r.json())
      .then(data => setStates(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, [form.country]);

  const update = (field, value) => setForm(f => ({ ...f, [field]: value }));

  const validateDetails = () => {
    const e = {};
    if (!form.BusinessTypeID) e.BusinessTypeID = t('account_new.err_type');
    if (!form.StateIndex) e.StateIndex = t('account_new.err_state');
    if (!form.PeoplePhone) e.PeoplePhone = t('account_new.err_phone');
    if (form.BusinessTypeID === '8') {
      if (!form.LivestockLegalDisclaimer) e.LivestockLegalDisclaimer = t('account_new.err_livestock_disclaimer');
      if (!form.SalesLegalDisclaimer) e.SalesLegalDisclaimer = t('account_new.err_sales_disclaimer');
    }
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleCreateAccount = async () => {
    if (!validateDetails()) return;
    if (createdBusinessId) { setStep(2); return; }
    setSubmitting(true);
    try {
      const res = await fetch(`${API_URL}/api/businesses/create`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${localStorage.getItem('access_token')}` },
        body: JSON.stringify({ ...form, PeopleID: peopleId }),
      });
      const data = await res.json();
      if (res.ok) {
        setCreatedBusinessId(data.BusinessID);
        createOTFCommunity(data.BusinessID, form.BusinessName || '', peopleId);
        setStep(2);
      } else {
        setErrors({ submit: data.detail || t('account_new.err_generic') });
      }
    } catch {
      setErrors({ submit: t('account_new.err_generic') });
    } finally {
      setSubmitting(false);
    }
  };

  const inputClass = "w-full border border-gray-300 rounded px-3 py-2 text-sm focus:outline-none focus:border-[#819360]";
  const labelClass = "block text-sm font-medium text-gray-700 mb-1";
  const errorClass = "text-red-600 text-xs mt-1";

  const stepTitle = {
    1: t('account_new.step1_title') || 'Account Details',
    2: 'Choose Your Plan with Cassia',
  }[step];

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <PageMeta
        title="Add an Account | Oatmeal Farm Network"
        description="Create a new farm, ranch, or business account on Oatmeal Farm Network."
        noIndex
      />
      <Header />

      <div style={{ maxWidth: FORM_MAX_WIDTH, margin: '2rem auto', padding: '0 1rem 3rem' }}>
        <Breadcrumbs items={[{ label: t('nav.home'), to: '/' }, { label: t('accounts.heading'), to: '/accounts' }, { label: t('account_new.breadcrumb') }]} />
        <div className="bg-white rounded-xl shadow border border-gray-100 p-8">

          <h1 className="text-2xl font-bold text-gray-800 mb-2">{stepTitle}</h1>

          {/* 2-segment step indicator */}
          <div className="flex items-center gap-2 mb-6">
            {[1, 2].map((n, i) => (
              <React.Fragment key={n}>
                <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${step >= n ? 'bg-[#819360] text-white' : 'bg-gray-200 text-gray-500'}`}>{n}</div>
                {i < 1 && <div className={`flex-1 h-1 rounded ${step > n ? 'bg-[#819360]' : 'bg-gray-200'}`} />}
              </React.Fragment>
            ))}
          </div>

          {/* STEP 1 — account type + details (combined) */}
          {step === 1 && (
            <div className="space-y-5">
              <div>
                <label className={labelClass}>{t('account_new.label_type')}</label>
                <select
                  value={form.BusinessTypeID}
                  onChange={e => update('BusinessTypeID', e.target.value)}
                  className={inputClass}
                >
                  <option value="">{t('account_new.select_type')}</option>
                  {businessTypes.map(bType => (
                    <option key={bType.BusinessTypeID} value={bType.BusinessTypeID}>{bType.BusinessType}</option>
                  ))}
                </select>
                {errors.BusinessTypeID && <p className={errorClass}>{errors.BusinessTypeID}</p>}
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_name')} <span className="text-gray-400 font-normal">({t('account_new.optional')})</span></label>
                <input
                  type="text"
                  value={form.BusinessName}
                  onChange={e => update('BusinessName', e.target.value)}
                  className={inputClass}
                  placeholder={t('account_new.placeholder_name')}
                />
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_website')} <span className="text-gray-400 font-normal">({t('account_new.optional')})</span></label>
                <input
                  type="text"
                  value={form.BusinessWebsite}
                  onChange={e => update('BusinessWebsite', e.target.value)}
                  className={inputClass}
                  placeholder="https://yourwebsite.com"
                />
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_street')} <span className="text-gray-400 font-normal">({t('account_new.optional')})</span></label>
                <input type="text" value={form.AddressStreet} onChange={e => update('AddressStreet', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_apt')} <span className="text-gray-400 font-normal">({t('account_new.optional')})</span></label>
                <input type="text" value={form.AddressApt} onChange={e => update('AddressApt', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_city')} <span className="text-gray-400 font-normal">({t('account_new.optional')})</span></label>
                <input type="text" value={form.AddressCity} onChange={e => update('AddressCity', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_country')}</label>
                <select
                  value={form.country_id}
                  onChange={e => {
                    const chosen = countries.find(c => String(c.country_id) === e.target.value);
                    setForm(f => ({ ...f, country_id: e.target.value, country: chosen ? chosen.name : '', StateIndex: '' }));
                  }}
                  className={inputClass}
                >
                  <option value="">{t('account_new.select_country')}</option>
                  {countries.map(c => (
                    <option key={c.country_id} value={c.country_id}>{c.name}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_state')}</label>
                <select
                  value={form.StateIndex}
                  onChange={e => update('StateIndex', e.target.value)}
                  className={inputClass}
                  disabled={!form.country}
                >
                  <option value="">{form.country ? t('account_new.select_state') : t('account_new.select_country_first')}</option>
                  {states.map(s => (
                    <option key={s.StateIndex} value={s.StateIndex}>{s.name}</option>
                  ))}
                </select>
                {errors.StateIndex && <p className={errorClass}>{errors.StateIndex}</p>}
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_zip')} <span className="text-gray-400 font-normal">({t('account_new.optional')})</span></label>
                <input type="text" value={form.AddressZip} onChange={e => update('AddressZip', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>{t('account_new.label_phone')}</label>
                <input
                  type="text"
                  value={form.PeoplePhone}
                  onChange={e => update('PeoplePhone', e.target.value.replace(/[^0-9()-.\s]/g, ''))}
                  className={inputClass}
                  placeholder="(555) 555-5555"
                />
                {errors.PeoplePhone && <p className={errorClass}>{errors.PeoplePhone}</p>}
              </div>

              <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                <input type="checkbox" checked={form.Permission} onChange={e => update('Permission', e.target.checked)} className="mt-1" />
                {t('account_new.permission_text')}
              </label>

              {String(form.BusinessTypeID) === '8' && (
                <>
                  <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                    <input type="checkbox" checked={form.LivestockLegalDisclaimer} onChange={e => update('LivestockLegalDisclaimer', e.target.checked)} className="mt-1" />
                    <span><strong>{t('account_new.livestock_disclaimer_title')}</strong> {t('account_new.livestock_disclaimer_body')}</span>
                  </label>
                  {errors.LivestockLegalDisclaimer && <p className={errorClass}>{errors.LivestockLegalDisclaimer}</p>}

                  <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                    <input type="checkbox" checked={form.SalesLegalDisclaimer} onChange={e => update('SalesLegalDisclaimer', e.target.checked)} className="mt-1" />
                    <span><strong>{t('account_new.sales_disclaimer_title')}</strong> {t('account_new.sales_disclaimer_body')}</span>
                  </label>
                  {errors.SalesLegalDisclaimer && <p className={errorClass}>{errors.SalesLegalDisclaimer}</p>}
                </>
              )}

              {errors.submit && (
                <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm">
                  {errors.submit}
                </div>
              )}

              <div className="flex justify-end gap-3 mt-4">
                <button onClick={handleCreateAccount} disabled={submitting} className="regsubmit2">
                  {submitting ? t('account_new.btn_creating') : createdBusinessId ? t('account_new.btn_continue') : t('account_new.btn_create')}
                </button>
              </div>
            </div>
          )}

          {/* STEP 2 — Cassia subscription guide */}
          {step === 2 && (
            <div>
              <p className="text-sm text-gray-500 mb-4">
                Chat with Cassia to find the right plan for your operation — she'll ask a few quick questions and build a custom quote.
              </p>
              <CassiaChat
                businessId={createdBusinessId}
                peopleId={peopleId}
                onSkip={() => navigate(`/account?PeopleID=${peopleId}&BusinessID=${createdBusinessId}`)}
              />
              <div className="mt-4 flex justify-start">
                <button onClick={() => setStep(1)} className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-600 hover:bg-gray-50">
                  ← Back
                </button>
              </div>
            </div>
          )}

        </div>
      </div>

      <Footer />
    </div>
  );
}
