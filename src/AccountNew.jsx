import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';
const OTF_API = import.meta.env.VITE_OTF_API_URL || import.meta.env.VITE_API_URL || '';
const FORM_MAX_WIDTH = '640px';

async function createOTFCommunity(businessId, businessName) {
  try {
    const token   = localStorage.getItem('access_token') || '';
    const peopleId = localStorage.getItem('people_id') || '0';
    await fetch(`${OTF_API}/api/admin/mill/communities`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}`, 'x-people-id': peopleId },
      body: JSON.stringify({ name: businessName, linkedType: 'business', linkedId: businessId }),
    });
  } catch { /* non-blocking */ }
}

const money = (n, ccy = 'USD') =>
  new Intl.NumberFormat(undefined, { style: 'currency', currency: ccy }).format(Number(n) || 0);

export default function AccountNew() {
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [businessTypes, setBusinessTypes] = useState([]);
  const [countries, setCountries] = useState([]);
  const [states, setStates] = useState([]);
  const [errors, setErrors] = useState({});
  const [submitting, setSubmitting] = useState(false);

  // Plan picker state (steps 2 & 3). Packages come from the SubscriptionPackage
  // table managed by the oatmeal_main admin (http://localhost:8080/app/admin/subscriptions).
  const [plans, setPlans] = useState([]);
  const [plansMode, setPlansMode] = useState(null); // 'test' | 'live'
  const [plansLoading, setPlansLoading] = useState(false);
  const [selectedPlanId, setSelectedPlanId] = useState(null);
  const [createdBusinessId, setCreatedBusinessId] = useState(null);
  const [paying, setPaying] = useState(false);

  const [form, setForm] = useState({
    BusinessTypeID: '',
    BusinessName: '',
    BusinessWebsite: '',
    AddressStreet: '',
    AddressApt: '',
    AddressCity: '',
    StateIndex: '',
    AddressZip: '',
    PeoplePhone: '',
    Permission: true,
    LivestockLegalDisclaimer: false,
    SalesLegalDisclaimer: false,
  });

  const peopleId = localStorage.getItem('people_id');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }

    fetch(`${API_URL}/api/businesses/types`)
      .then(r => r.json())
      .then(data => setBusinessTypes(Array.isArray(data) ? data : []))
      .catch(() => {});

    fetch(`${API_URL}/api/businesses/countries`)
      .then(r => r.json())
      .then(data => setCountries(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, [navigate]);

  useEffect(() => {
    fetch(`${API_URL}/api/businesses/states?country=USA`)
      .then(r => r.json())
      .then(data => setStates(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, []);

  // Load packages when user reaches the plan step. Filter by the chosen
  // business type so sellers don't see irrelevant offerings.
  useEffect(() => {
    if (step !== 2 || plans.length > 0) return;
    setPlansLoading(true);
    const url = new URL(`${API_URL}/api/platform-subscriptions/packages`);
    if (form.BusinessTypeID) url.searchParams.set('business_type_id', form.BusinessTypeID);
    fetch(url.toString())
      .then(r => r.json())
      .then(data => {
        setPlansMode(data.mode || 'test');
        setPlans(Array.isArray(data.packages) ? data.packages : []);
      })
      .catch(() => setErrors(e => ({ ...e, plans: 'Could not load plans.' })))
      .finally(() => setPlansLoading(false));
  }, [step, plans.length, form.BusinessTypeID]);

  const update = (field, value) => setForm(f => ({ ...f, [field]: value }));

  const validateDetails = () => {
    const e = {};
    if (!form.BusinessTypeID) e.BusinessTypeID = 'Please select an account type.';
    if (!form.StateIndex) e.StateIndex = 'Please select a state/province.';
    if (!form.PeoplePhone) e.PeoplePhone = 'Phone is required.';
    if (form.BusinessTypeID === '8') {
      if (!form.LivestockLegalDisclaimer) e.LivestockLegalDisclaimer = 'You must accept the Livestock Legal Disclaimer.';
      if (!form.SalesLegalDisclaimer) e.SalesLegalDisclaimer = 'You must accept the Sales Legal Disclaimer.';
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
        createOTFCommunity(data.BusinessID, form.BusinessName || '');
        setStep(2);
      } else {
        setErrors({ submit: data.detail || 'An error occurred. Please try again.' });
      }
    } catch {
      setErrors({ submit: 'An error occurred. Please try again.' });
    } finally {
      setSubmitting(false);
    }
  };

  const handleChoosePlan = (plan) => {
    if (!plan) return;
    setSelectedPlanId(plan.PackageID);
    setStep(3);
  };

  const handlePay = async () => {
    if (!selectedPlanId || !createdBusinessId) return;
    setPaying(true);
    setErrors({});
    const authHeaders = {
      Authorization: `Bearer ${localStorage.getItem('access_token')}`,
      'Content-Type': 'application/json',
    };
    try {
      if (plansMode === 'test') {
        const res = await fetch(`${API_URL}/api/platform-subscriptions/assign-package/${createdBusinessId}`, {
          method: 'POST',
          headers: authHeaders,
          body: JSON.stringify({ package_id: selectedPlanId, billing_cycle: 'monthly' }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.detail || 'Could not activate subscription.');
        navigate(`/account?PeopleID=${peopleId}&BusinessID=${createdBusinessId}`);
      } else {
        setErrors({ pay: 'Live Stripe checkout for subscription packages is not yet available. Ask an admin to enable Test Mode at /app/admin/payment-settings.' });
        setPaying(false);
      }
    } catch (e) {
      setErrors({ pay: e.message || 'Payment failed. Please try again.' });
      setPaying(false);
    }
  };

  const inputClass = "w-full border border-gray-300 rounded px-3 py-2 text-sm focus:outline-none focus:border-[#819360]";
  const labelClass = "block text-sm font-medium text-gray-700 mb-1";
  const errorClass = "text-red-600 text-xs mt-1";

  const selectedPlan = plans.find(p => p.PackageID === selectedPlanId);

  const stepTitle = {
    1: 'Add An Account',
    2: 'Choose a Subscription',
    3: plansMode === 'test' ? 'Confirm Subscription' : 'Payment',
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
        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'My Accounts', to: '/accounts' }, { label: 'Add Account' }]} />
        <div className="bg-white rounded-xl shadow border border-gray-100 p-8">

          <h1 className="text-2xl font-bold text-gray-800 mb-2">{stepTitle}</h1>

          {/* 3-segment step indicator */}
          <div className="flex items-center gap-2 mb-6">
            {[1, 2, 3].map((n, i) => (
              <React.Fragment key={n}>
                <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${step >= n ? 'bg-[#819360] text-white' : 'bg-gray-200 text-gray-500'}`}>{n}</div>
                {i < 2 && <div className={`flex-1 h-1 rounded ${step > n ? 'bg-[#819360]' : 'bg-gray-200'}`} />}
              </React.Fragment>
            ))}
          </div>

          {/* STEP 1 — account type + details (combined) */}
          {step === 1 && (
            <div className="space-y-5">
              <div>
                <label className={labelClass}>Account Type</label>
                <select
                  value={form.BusinessTypeID}
                  onChange={e => update('BusinessTypeID', e.target.value)}
                  className={inputClass}
                >
                  <option value="">Select an account type...</option>
                  {businessTypes.map(t => (
                    <option key={t.BusinessTypeID} value={t.BusinessTypeID}>{t.BusinessType}</option>
                  ))}
                </select>
                {errors.BusinessTypeID && <p className={errorClass}>{errors.BusinessTypeID}</p>}
              </div>

              <div>
                <label className={labelClass}>Business / Org. Name <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input
                  type="text"
                  value={form.BusinessName}
                  onChange={e => update('BusinessName', e.target.value)}
                  className={inputClass}
                  placeholder="Your farm or business name"
                />
              </div>

              <div>
                <label className={labelClass}>Website <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input
                  type="text"
                  value={form.BusinessWebsite}
                  onChange={e => update('BusinessWebsite', e.target.value)}
                  className={inputClass}
                  placeholder="https://yourwebsite.com"
                />
              </div>

              <div>
                <label className={labelClass}>Street <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="text" value={form.AddressStreet} onChange={e => update('AddressStreet', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>Address Line 2 <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="text" value={form.AddressApt} onChange={e => update('AddressApt', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>City <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="text" value={form.AddressCity} onChange={e => update('AddressCity', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>State / Province</label>
                <select value={form.StateIndex} onChange={e => update('StateIndex', e.target.value)} className={inputClass}>
                  <option value="">Select...</option>
                  {states.map(s => (
                    <option key={s.StateIndex} value={s.StateIndex}>{s.name}</option>
                  ))}
                </select>
                {errors.StateIndex && <p className={errorClass}>{errors.StateIndex}</p>}
              </div>

              <div>
                <label className={labelClass}>Postal Code <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="text" value={form.AddressZip} onChange={e => update('AddressZip', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>Phone</label>
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
                Yes, you have my permission to share my listings in mass emails and on social media.
              </label>

              {String(form.BusinessTypeID) === '8' && (
                <>
                  <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                    <input type="checkbox" checked={form.LivestockLegalDisclaimer} onChange={e => update('LivestockLegalDisclaimer', e.target.checked)} className="mt-1" />
                    <span><strong>Livestock Legal Disclaimer:</strong> I acknowledge and agree that I am solely responsible for negotiating all livestock sales. Global Grange Inc. bears no legal responsibility for any facet of such sales as well as any ensuing consequences arising from said transactions.</span>
                  </label>
                  {errors.LivestockLegalDisclaimer && <p className={errorClass}>{errors.LivestockLegalDisclaimer}</p>}

                  <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                    <input type="checkbox" checked={form.SalesLegalDisclaimer} onChange={e => update('SalesLegalDisclaimer', e.target.checked)} className="mt-1" />
                    <span><strong>Sales Legal Disclaimer:</strong> I acknowledge and agree that Global Grange Inc. bears no legal responsibility for any facet of sales, including but not limited to the sale of livestock, eggs, fiber/wool, products, and services, as well as any ensuing consequences arising from said transactions.</span>
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
                  {submitting ? 'Creating...' : createdBusinessId ? 'Continue →' : 'Create Account →'}
                </button>
              </div>
            </div>
          )}

          {/* STEP 2 — plan picker */}
          {step === 2 && (
            <div className="space-y-4">
              <p className="text-sm text-gray-600">
                Pick the plan that best fits your operation. You can change or cancel any time from your account settings.
              </p>

              {plansMode === 'test' && (
                <div className="bg-yellow-50 border border-yellow-300 text-yellow-800 rounded px-4 py-2 text-xs">
                  Test mode is enabled — no payment will be collected on the next step.
                </div>
              )}

              {errors.plans && (
                <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm">
                  {errors.plans}
                </div>
              )}

              {plansLoading ? (
                <div className="text-center py-8 text-gray-400">Loading plans…</div>
              ) : plans.length === 0 ? (
                <div className="text-center py-8 text-gray-500 border border-dashed border-gray-300 rounded-lg">
                  No subscription plans are configured yet.
                </div>
              ) : (
                <div className="grid gap-3">
                  {plans.map(p => {
                    const isSelected = selectedPlanId === p.PackageID;
                    return (
                      <button
                        key={p.PackageID}
                        type="button"
                        onClick={() => setSelectedPlanId(p.PackageID)}
                        className={`text-left rounded-lg border p-4 transition ${
                          isSelected ? 'border-[#3D6B34] ring-2 ring-[#3D6B34]/30 bg-green-50/40' : 'border-gray-200 hover:border-gray-300'
                        }`}
                      >
                        <div className="flex items-start justify-between gap-2">
                          <div>
                            <div className="font-bold text-gray-800">{p.PackageName || `Plan ${p.PackageID}`}</div>
                            {p.Description && (
                              <div className="text-sm text-gray-600 mt-1 leading-relaxed">{p.Description}</div>
                            )}
                          </div>
                          <div className="text-right whitespace-nowrap">
                            <div className="text-xl font-bold text-gray-900">{money(p.MonthlyPrice)}</div>
                            <div className="text-xs text-gray-500">/ mo</div>
                          </div>
                        </div>
                      </button>
                    );
                  })}
                </div>
              )}

              <div className="flex justify-end gap-3 mt-4">
                <button onClick={() => setStep(1)} className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-600 hover:bg-gray-50">
                  ← Back
                </button>
                <button
                  onClick={() => selectedPlanId && handleChoosePlan(plans.find(p => p.PackageID === selectedPlanId))}
                  disabled={!selectedPlanId}
                  className="regsubmit2 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Next →
                </button>
              </div>
            </div>
          )}

          {/* STEP 3 — payment / confirm */}
          {step === 3 && (
            <div className="space-y-4">
              {selectedPlan && (
                <div className="bg-gray-50 border border-gray-200 rounded-lg p-4">
                  <div className="text-sm text-gray-500 mb-1">You selected</div>
                  <div className="flex items-center justify-between">
                    <div className="font-bold text-gray-800">{selectedPlan.PackageName}</div>
                    <div className="text-lg font-bold text-gray-900">
                      {money(selectedPlan.MonthlyPrice)}<span className="text-xs font-normal text-gray-500"> / mo</span>
                    </div>
                  </div>
                </div>
              )}

              {plansMode === 'test' ? (
                <div className="bg-yellow-50 border border-yellow-300 text-yellow-900 rounded px-4 py-3 text-sm">
                  <strong>Test mode.</strong> Your subscription will be activated immediately without
                  processing a real payment.
                </div>
              ) : (
                <p className="text-sm text-gray-600">
                  Click below to continue to Stripe and complete payment securely. You'll be returned
                  here when you're done.
                </p>
              )}

              {errors.pay && (
                <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm">
                  {errors.pay}
                </div>
              )}

              <div className="flex justify-end gap-3 mt-4">
                <button onClick={() => setStep(2)} className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-600 hover:bg-gray-50">
                  ← Back
                </button>
                <button onClick={handlePay} disabled={paying} className="regsubmit2">
                  {paying
                    ? (plansMode === 'test' ? 'Activating…' : 'Redirecting…')
                    : (plansMode === 'test' ? 'Confirm Subscription' : 'Continue to Payment')}
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
