import React, { useEffect, useState } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import PageMeta from './PageMeta';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const STATUS_STYLES = {
  active:   { label: 'Active',   bg: 'bg-green-50',  text: 'text-green-700',  border: 'border-green-200'  },
  trialing: { label: 'Trialing', bg: 'bg-blue-50',   text: 'text-blue-700',   border: 'border-blue-200'   },
  past_due: { label: 'Past Due', bg: 'bg-amber-50',  text: 'text-amber-800',  border: 'border-amber-300'  },
  cancelled:{ label: 'Cancelled',bg: 'bg-gray-100',  text: 'text-gray-700',   border: 'border-gray-300'   },
  unpaid:   { label: 'Unpaid',   bg: 'bg-red-50',    text: 'text-red-700',    border: 'border-red-200'    },
};

const money = (n, ccy = 'USD') =>
  new Intl.NumberFormat(undefined, { style: 'currency', currency: ccy }).format(Number(n) || 0);

export default function AccountSubscription() {
  const [searchParams, setSearchParams] = useSearchParams();
  const businessId = searchParams.get('BusinessID');
  const sessionId = searchParams.get('session_id');
  const cancelled = searchParams.get('cancelled');
  const navigate = useNavigate();
  const { Business, LoadBusiness } = useAccount();
  const peopleId = localStorage.getItem('PeopleID');

  const [mode, setMode] = useState(null);
  const [plans, setPlans] = useState([]);
  const [current, setCurrent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [busyId, setBusyId] = useState(null);
  const [portalBusy, setPortalBusy] = useState(false);
  const [banner, setBanner] = useState(
    sessionId ? 'Thanks! Your subscription is being activated. This page will refresh automatically.'
    : cancelled ? 'Checkout cancelled. No charges were made.'
    : null
  );

  const token = localStorage.getItem('access_token');
  const authHeaders = { Authorization: `Bearer ${token}` };

  const loadAll = async () => {
    if (!businessId) return;
    setLoading(true);
    setError(null);
    try {
      const [plansRes, currentRes] = await Promise.all([
        fetch(`${API_URL}/api/platform-subscriptions/plans`),
        fetch(`${API_URL}/api/platform-subscriptions/current/${businessId}`, { headers: authHeaders }),
      ]);
      if (!plansRes.ok) throw new Error((await plansRes.json()).detail || 'Could not load plans');
      if (!currentRes.ok) throw new Error((await currentRes.json()).detail || 'Could not load subscription');
      const plansData = await plansRes.json();
      setMode(plansData.mode);
      setPlans(plansData.plans || []);
      setCurrent(await currentRes.json());
    } catch (e) {
      setError(e.message || 'Something went wrong.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!token) { navigate('/login'); return; }
    if (!businessId) { navigate('/dashboard'); return; }
    LoadBusiness(businessId);
    loadAll();
  }, [businessId]);

  // Refresh once after returning from Stripe so the webhook has a moment to arrive.
  useEffect(() => {
    if (!sessionId) return;
    const t = setTimeout(() => {
      loadAll();
      const next = new URLSearchParams(searchParams);
      next.delete('session_id');
      setSearchParams(next, { replace: true });
    }, 2500);
    return () => clearTimeout(t);
  }, [sessionId]);

  const startCheckout = async (plan) => {
    setBusyId(plan.SubscriptionID);
    setError(null);
    try {
      const res = await fetch(`${API_URL}/api/platform-subscriptions/checkout/${businessId}`, {
        method: 'POST',
        headers: { ...authHeaders, 'Content-Type': 'application/json' },
        body: JSON.stringify({ subscription_id: plan.SubscriptionID }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.detail || 'Could not start checkout.');
      window.location.href = data.checkout_url;
    } catch (e) {
      setError(e.message);
      setBusyId(null);
    }
  };

  const openPortal = async () => {
    setPortalBusy(true);
    setError(null);
    try {
      const res = await fetch(`${API_URL}/api/platform-subscriptions/portal/${businessId}`, {
        method: 'POST',
        headers: authHeaders,
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.detail || 'Could not open billing portal.');
      window.location.href = data.portal_url;
    } catch (e) {
      setError(e.message);
      setPortalBusy(false);
    }
  };

  const currentLevelId = current?.SubscriptionLevel ?? null;
  const statusKey = (current?.SubscriptionStatus || '').toLowerCase();
  const statusStyle = STATUS_STYLES[statusKey] || null;
  const hasActiveSub = ['active', 'trialing', 'past_due'].includes(statusKey);

  return (
    <AccountLayout
      Business={Business}
      BusinessID={businessId}
      PeopleID={peopleId}
      pageTitle="Subscription"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Account Settings' }, { label: 'Subscription' }]}
    >
      <PageMeta title="Subscription | Oatmeal Farm Network" noIndex />

      <div className="max-w-4xl mx-auto">
        <h1 className="text-2xl font-bold text-gray-800 mb-2">Subscription</h1>
        <p className="text-sm text-gray-500 mb-6">
          Manage your OFN membership for <strong>{current?.BusinessName || '…'}</strong>.
          {mode === 'test' && (
            <span className="ml-2 inline-block bg-yellow-50 text-yellow-800 border border-yellow-300 rounded px-2 py-0.5 text-xs">
              Test Mode
            </span>
          )}
        </p>

        {banner && (
          <div className="mb-4 bg-blue-50 border border-blue-200 text-blue-800 rounded px-4 py-3 text-sm">
            {banner}
          </div>
        )}
        {error && (
          <div className="mb-4 bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm">
            {error}
          </div>
        )}

        {/* Current subscription card */}
        {hasActiveSub && current && (
          <div className={`mb-8 rounded-xl border ${statusStyle?.border || 'border-gray-200'} ${statusStyle?.bg || 'bg-white'} p-6`}>
            <div className="flex items-start justify-between gap-4">
              <div>
                <div className="flex items-center gap-3 mb-1">
                  <span className={`text-xs font-bold uppercase tracking-wide px-2 py-0.5 rounded ${statusStyle?.text}`}>
                    {statusStyle?.label || statusKey}
                  </span>
                  <h2 className="text-lg font-bold text-gray-800">
                    {current.SubscriptionTitle || 'Current Plan'}
                  </h2>
                </div>
                {current.SubscriptionMonthlyRate != null && (
                  <p className="text-sm text-gray-600">
                    {money(current.SubscriptionMonthlyRate)} / month
                  </p>
                )}
                {current.SubscriptionEndDate && (
                  <p className="text-xs text-gray-500 mt-1">
                    Next billing / renewal: {new Date(current.SubscriptionEndDate).toLocaleDateString()}
                  </p>
                )}
              </div>
              <button
                onClick={openPortal}
                disabled={portalBusy}
                className="bg-gray-800 hover:bg-gray-900 text-white text-sm font-semibold px-4 py-2 rounded-lg disabled:opacity-50 whitespace-nowrap"
              >
                {portalBusy ? 'Opening…' : 'Manage Billing'}
              </button>
            </div>
            {statusKey === 'past_due' && (
              <p className="mt-3 text-sm text-amber-800">
                Your last payment failed. Use <strong>Manage Billing</strong> to update your payment method.
              </p>
            )}
          </div>
        )}

        {/* Plan picker */}
        <h2 className="text-lg font-bold text-gray-800 mb-3">
          {hasActiveSub ? 'Change Plan' : 'Choose a Plan'}
        </h2>

        {loading ? (
          <div className="text-center py-10 text-gray-400">Loading plans…</div>
        ) : plans.length === 0 ? (
          <div className="text-center py-10 text-gray-500 border border-dashed border-gray-300 rounded-lg">
            No subscription plans are configured yet.
          </div>
        ) : (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {plans.map(p => {
              const isCurrent = currentLevelId === p.SubscriptionID;
              return (
                <div
                  key={p.SubscriptionID}
                  className={`bg-white rounded-xl border ${isCurrent ? 'border-[#3D6B34] ring-2 ring-[#3D6B34]/30' : 'border-gray-200'} shadow-sm p-5 flex flex-col`}
                >
                  <div className="flex items-start justify-between gap-2 mb-2">
                    <h3 className="font-bold text-gray-800">{p.SubscriptionTitle || `Plan ${p.SubscriptionID}`}</h3>
                    {isCurrent && <span className="text-xs font-bold text-[#3D6B34]">CURRENT</span>}
                  </div>
                  <p className="text-2xl font-bold text-gray-900">
                    {money(p.SubscriptionMonthlyRate)}
                    <span className="text-sm font-normal text-gray-500"> / mo</span>
                  </p>
                  {p.SubscriptionDescription && (
                    <p className="text-sm text-gray-600 mt-2 leading-relaxed grow">
                      {p.SubscriptionDescription}
                    </p>
                  )}
                  <button
                    onClick={() => startCheckout(p)}
                    disabled={isCurrent || !p.selectable || busyId === p.SubscriptionID}
                    className={`mt-4 w-full text-sm font-semibold px-4 py-2 rounded-lg transition-colors ${
                      isCurrent
                        ? 'bg-gray-100 text-gray-400 cursor-default'
                        : p.selectable
                          ? 'bg-[#3D6B34] hover:bg-[#2f5528] text-white disabled:opacity-50'
                          : 'bg-gray-100 text-gray-400 cursor-not-allowed'
                    }`}
                  >
                    {isCurrent
                      ? 'Current Plan'
                      : !p.selectable
                        ? 'Coming Soon'
                        : busyId === p.SubscriptionID
                          ? 'Redirecting…'
                          : hasActiveSub ? 'Switch to this Plan' : 'Subscribe'}
                  </button>
                </div>
              );
            })}
          </div>
        )}

        <div className="mt-8 text-xs text-gray-500">
          Payments are processed securely by Stripe. You can cancel or change your plan at any time from the billing portal.
        </div>
      </div>
    </AccountLayout>
  );
}
