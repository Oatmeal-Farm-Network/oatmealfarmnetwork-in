import React, { useEffect, useState, useCallback } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import ThaiymeChat from './ThaiymeChat';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

// ─── helpers ────────────────────────────────────────────────────

function authHeaders() {
  return {
    'Content-Type': 'application/json',
    Authorization: `Bearer ${localStorage.getItem('access_token') || ''}`,
  };
}

function fmt(n) {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(n || 0);
}

function fmtDate(d) {
  if (!d) return '—';
  return new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
}

const TABS = ['Dashboard', 'Invoices', 'Customers', 'Vendors', 'Bills', 'Expenses', 'Accounts', 'Reports', 'Payments'];

const statusColor = {
  Draft: 'bg-gray-100 text-gray-700',
  Sent: 'bg-blue-100 text-blue-700',
  Partial: 'bg-yellow-100 text-yellow-700',
  Paid: 'bg-green-100 text-green-700',
  Void: 'bg-red-100 text-red-700',
  Open: 'bg-blue-100 text-blue-700',
  Overdue: 'bg-red-100 text-red-700',
};

// ─── modals ────────────────────────────────────────────────────

function Modal({ title, onClose, children }) {
  return (
    <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-2xl max-h-[90vh] overflow-y-auto">
        <div className="flex items-center justify-between p-5 border-b">
          <h3 className="text-lg font-bold text-gray-900">{title}</h3>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-700 text-2xl leading-none">&times;</button>
        </div>
        <div className="p-5">{children}</div>
      </div>
    </div>
  );
}

function Field({ label, children }) {
  return (
    <div>
      <label className="block text-xs font-semibold text-gray-500 mb-1">{label}</label>
      {children}
    </div>
  );
}

const input = 'w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-500';
const btn   = 'px-4 py-2 rounded-lg text-sm font-semibold transition';
const btnGreen  = `${btn} bg-green-700 text-white hover:bg-green-800`;
const btnWhite  = `${btn} border border-gray-300 text-gray-700 hover:bg-gray-50`;

// ─── PAYMENTS (Stripe + refund model) ──────────────────────────

function PaymentsTab() {
  const [cfg, setCfg] = useState(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');

  const authFetch = useCallback(async (path, opts = {}) => {
    const res = await fetch(`${API_URL}${path}`, {
      ...opts,
      headers: { ...authHeaders(), ...(opts.headers || {}) },
    });
    if (!res.ok) {
      const t = await res.text().catch(() => '');
      throw new Error(t || res.statusText);
    }
    return res.json();
  }, []);

  useEffect(() => {
    authFetch('/api/platform/settings')
      .then(d => { setCfg(d); setLoading(false); })
      .catch(e => { setMsg(e.message); setLoading(false); });
  }, [authFetch]);

  const save = async () => {
    setSaving(true); setMsg('');
    try {
      await authFetch('/api/platform/settings', {
        method: 'PUT',
        body: JSON.stringify(cfg),
      });
      const fresh = await authFetch('/api/platform/settings');
      setCfg(fresh);
      setMsg('Saved');
    } catch (e) {
      setMsg(e.message || 'Save failed');
    } finally {
      setSaving(false);
      setTimeout(() => setMsg(''), 4000);
    }
  };

  if (loading) return <div className="text-sm text-gray-400 p-6">Loading payments settings…</div>;
  if (!cfg) return <div className="text-sm text-red-600 p-6">Could not load settings. {msg}</div>;

  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setB = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.checked }));

  return (
    <div className="space-y-4">
      <div className="bg-white rounded-xl border border-gray-200 p-5">
        <div className="flex items-start justify-between mb-4">
          <div>
            <h2 className="font-semibold text-gray-900">Stripe Payment Processing</h2>
            <p className="text-xs text-gray-500 mt-1">
              These credentials power event registration checkout, farm-to-table orders, and refunds.
              {cfg.StripeConfigured ? ' Stripe is configured.' : ' Stripe is NOT configured — checkout is disabled.'}
            </p>
          </div>
          <div className={`text-xs px-2 py-1 rounded ${cfg.StripeConfigured ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
            {cfg.StripeConfigured ? 'Connected' : 'Not configured'}
          </div>
        </div>

        {!cfg.IsAdmin && (
          <div className="bg-yellow-50 border border-yellow-200 text-yellow-800 text-xs rounded-lg p-3 mb-4">
            You can view these settings but only a platform administrator can modify them. Ask an admin to set <code>PLATFORM_ADMIN_IDS</code> in the backend environment.
          </div>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <Field label="Publishable Key (pk_...)">
            <input className={input} value={cfg.StripePublishableKey || ''} onChange={set('StripePublishableKey')} placeholder="pk_test_..." disabled={!cfg.IsAdmin} />
          </Field>
          <Field label="Secret Key (sk_...)">
            <input className={input} value={cfg.StripeSecretKey || cfg.StripeSecretKeyMasked || ''}
              onChange={e => setCfg(c => ({ ...c, StripeSecretKey: e.target.value }))}
              placeholder={cfg.StripeSecretKeyMasked || 'sk_test_...'} disabled={!cfg.IsAdmin} />
            <div className="text-[11px] text-gray-400 mt-1">Leave as shown (masked) to keep existing value.</div>
          </Field>
          <Field label="Webhook Signing Secret (whsec_...)">
            <input className={input} value={cfg.StripeWebhookSecret || cfg.StripeWebhookSecretMasked || ''}
              onChange={e => setCfg(c => ({ ...c, StripeWebhookSecret: e.target.value }))}
              placeholder={cfg.StripeWebhookSecretMasked || 'whsec_...'} disabled={!cfg.IsAdmin} />
          </Field>
          <Field label="Mode">
            <label className="flex items-center gap-2 text-sm mt-2">
              <input type="checkbox" checked={!!cfg.StripeTestMode} onChange={setB('StripeTestMode')} disabled={!cfg.IsAdmin} />
              <span>Test mode</span>
            </label>
          </Field>
        </div>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-5">
        <h2 className="font-semibold text-gray-900 mb-1">Refund Model</h2>
        <p className="text-xs text-gray-500 mb-4">Controls when funds are captured from attendees and when refunds can be issued.</p>

        <div className="space-y-3 mb-4">
          <label className={`flex items-start gap-3 border rounded-lg p-3 cursor-pointer ${cfg.RefundModel === 'immediate_charge' ? 'border-green-600 bg-green-50' : 'border-gray-200'}`}>
            <input type="radio" name="refundModel" value="immediate_charge"
              checked={cfg.RefundModel === 'immediate_charge'}
              onChange={e => setCfg(c => ({ ...c, RefundModel: e.target.value }))}
              disabled={!cfg.IsAdmin} className="mt-1" />
            <div>
              <div className="font-medium text-sm">Immediate charge + refund window</div>
              <div className="text-xs text-gray-500 mt-0.5">Charge the attendee's card at registration. Allow full refunds until the event date (or configurable deadline). Simplest; works past Stripe's 7-day auth hold.</div>
            </div>
          </label>
          <label className={`flex items-start gap-3 border rounded-lg p-3 cursor-pointer ${cfg.RefundModel === 'manual_capture' ? 'border-green-600 bg-green-50' : 'border-gray-200'}`}>
            <input type="radio" name="refundModel" value="manual_capture"
              checked={cfg.RefundModel === 'manual_capture'}
              onChange={e => setCfg(c => ({ ...c, RefundModel: e.target.value }))}
              disabled={!cfg.IsAdmin} className="mt-1" />
            <div>
              <div className="font-medium text-sm">Authorize at registration, capture after event</div>
              <div className="text-xs text-gray-500 mt-0.5">Card is authorized (held) at registration and only charged when the organizer captures after the event. Cancellations cost $0 (no refund needed). Capped at 7 days by Stripe — good for short-horizon events only.</div>
            </div>
          </label>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <Field label="Refund deadline (days before event)">
            <input type="number" className={input} value={cfg.RefundDeadlineDays || 0}
              onChange={e => setCfg(c => ({ ...c, RefundDeadlineDays: Number(e.target.value) || 0 }))}
              disabled={!cfg.IsAdmin} />
            <div className="text-[11px] text-gray-400 mt-1">0 = allow refunds up to event start date.</div>
          </Field>
          <Field label="Platform fee %">
            <input type="number" step="0.01" className={input} value={cfg.PlatformFeePercent || 0}
              onChange={e => setCfg(c => ({ ...c, PlatformFeePercent: Number(e.target.value) || 0 }))}
              disabled={!cfg.IsAdmin} />
          </Field>
          <Field label="Currency">
            <input className={input} value={cfg.CurrencyCode || 'USD'} onChange={set('CurrencyCode')} disabled={!cfg.IsAdmin} />
          </Field>
        </div>
      </div>

      {cfg.IsAdmin && (
        <div className="flex items-center justify-end gap-3">
          {msg && <span className="text-sm text-gray-500 mr-auto">{msg}</span>}
          <button onClick={save} disabled={saving} className={btnGreen}>{saving ? 'Saving…' : 'Save Payment Settings'}</button>
        </div>
      )}
    </div>
  );
}


// ─── main component ────────────────────────────────────────────

export default function Accounting() {
  const [searchParams] = useSearchParams();
  const businessId = searchParams.get('BusinessID');
  const peopleId   = localStorage.getItem('PeopleID');

  const [tab, setTab] = useState('Dashboard');
  const [business, setBusiness] = useState(null);
  const [isSetup, setIsSetup] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // data states
  const [dashboard, setDashboard]   = useState(null);
  const [invoices, setInvoices]     = useState([]);
  const [customers, setCustomers]   = useState([]);
  const [vendors, setVendors]       = useState([]);
  const [bills, setBills]           = useState([]);
  const [expenses, setExpenses]     = useState([]);
  const [accounts, setAccounts]     = useState([]);

  // report states
  const [reportType, setReportType]   = useState('profit-loss');
  const [reportData, setReportData]   = useState(null);
  const [reportDates, setReportDates] = useState({
    startDate: `${new Date().getFullYear()}-01-01`,
    endDate: new Date().toISOString().slice(0, 10),
    asOfDate: new Date().toISOString().slice(0, 10),
  });

  // modal states
  const [showInvoiceModal,  setShowInvoiceModal]  = useState(false);
  const [showCustomerModal, setShowCustomerModal] = useState(false);
  const [showVendorModal,   setShowVendorModal]   = useState(false);
  const [showBillModal,     setShowBillModal]      = useState(false);
  const [showExpenseModal,  setShowExpenseModal]   = useState(false);

  const qs = `?business_id=${businessId}`;

  // ── fetch helpers ──────────────────────────────────────────

  const apiFetch = useCallback(async (path, opts = {}) => {
    const res = await fetch(`${API_URL}/api/accounting${path}${path.includes('?') ? '&' : '?'}business_id=${businessId}`, {
      ...opts,
      headers: { ...authHeaders(), ...(opts.headers || {}) },
    });
    if (!res.ok) throw new Error(await res.text());
    return res.json();
  }, [businessId]);

  // ── init ──────────────────────────────────────────────────

  useEffect(() => {
    if (!businessId) return;
    (async () => {
      try {
        const biz = await apiFetch('/business-info');
        setBusiness(biz);

        // Check if chart of accounts exists
        const accts = await apiFetch('/accounts');
        setIsSetup(accts.accounts.length > 0);
        setAccounts(accts.accounts);
      } catch (e) {
        setError(e.message);
      } finally {
        setLoading(false);
      }
    })();
  }, [businessId, apiFetch]);

  // ── tab data ──────────────────────────────────────────────

  useEffect(() => {
    if (!businessId || !isSetup) return;
    (async () => {
      try {
        if (tab === 'Dashboard') {
          const d = await apiFetch('/dashboard');
          setDashboard(d);
        } else if (tab === 'Invoices') {
          const d = await apiFetch('/invoices');
          setInvoices(d.invoices);
        } else if (tab === 'Customers') {
          const d = await apiFetch('/customers');
          setCustomers(d.customers);
        } else if (tab === 'Vendors') {
          const d = await apiFetch('/vendors');
          setVendors(d.vendors);
        } else if (tab === 'Bills') {
          const d = await apiFetch('/bills');
          setBills(d.bills);
        } else if (tab === 'Expenses') {
          const d = await apiFetch('/expenses');
          setExpenses(d.expenses);
        } else if (tab === 'Accounts') {
          const d = await apiFetch('/accounts');
          setAccounts(d.accounts);
        }
      } catch (e) {
        console.error(e);
      }
    })();
  }, [tab, businessId, isSetup, apiFetch]);

  // ── setup ─────────────────────────────────────────────────

  async function handleSetup() {
    try {
      await apiFetch('/setup', { method: 'POST' });
      const accts = await apiFetch('/accounts');
      setAccounts(accts.accounts);
      setIsSetup(true);
    } catch (e) {
      alert('Setup failed: ' + e.message);
    }
  }

  // ── report fetch ──────────────────────────────────────────

  async function fetchReport() {
    try {
      let path = `/reports/${reportType}`;
      if (['profit-loss', 'cash-flow'].includes(reportType)) {
        path += `?start_date=${reportDates.startDate}&end_date=${reportDates.endDate}`;
      } else {
        path += `?as_of_date=${reportDates.asOfDate}`;
      }
      const d = await apiFetch(path);
      setReportData(d);
    } catch (e) {
      alert('Report failed: ' + e.message);
    }
  }

  // ── renders ───────────────────────────────────────────────

  if (loading) return (
    <AccountLayout BusinessID={businessId} PeopleID={peopleId} pageTitle="Accounting">
      <div className="p-8 text-gray-500">Loading accounting...</div>
      <ThaiymeChat businessId={businessId} page="accounting" />
    </AccountLayout>
  );

  if (error) return (
    <AccountLayout BusinessID={businessId} PeopleID={peopleId} pageTitle="Accounting">
      <div className="p-8 text-red-600">Error: {error}<br />
        <span className="text-sm text-gray-500">Make sure you have AccessLevelID &ge; 3 for this business.</span>
      </div>
    </AccountLayout>
  );

  if (!isSetup) return (
    <AccountLayout BusinessID={businessId} PeopleID={peopleId} pageTitle="Accounting">
      <div className="max-w-lg mx-auto mt-16 text-center">
        <div className="flex justify-center mb-4 text-gray-300">
          <svg width="56" height="56" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="0.9" strokeLinecap="round" strokeLinejoin="round"><rect x="1" y="6" width="3" height="8"/><rect x="6.5" y="3" width="3" height="11"/><rect x="12" y="1" width="3" height="13"/></svg>
        </div>
        <h2 className="text-2xl font-bold text-gray-900 mb-2">Set up Accounting</h2>
        <p className="text-gray-500 mb-6">
          Initialize the chart of accounts and fiscal periods for <strong>{business?.BusinessName}</strong>.
          This creates your default account structure and current fiscal year.
        </p>
        <button onClick={handleSetup} className={btnGreen}>Initialize Accounting</button>
      </div>
    </AccountLayout>
  );

  return (
    <AccountLayout BusinessID={businessId} PeopleID={peopleId} pageTitle="Accounting">
      <div className="max-w-full space-y-4">

        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-green-700">{business?.BusinessName} — Accounting</h1>
            <p className="text-sm text-gray-500">Full double-entry accounting system</p>
          </div>
        </div>

        {/* Tab bar */}
        <div className="flex gap-1 bg-gray-100 p-1 rounded-xl overflow-x-auto">
          {TABS.map(t => (
            <button key={t}
              onClick={() => setTab(t)}
              className={`px-3 py-1.5 rounded-lg text-sm font-medium whitespace-nowrap transition
                ${tab === t ? 'bg-white text-green-700 shadow-sm' : 'text-gray-600 hover:text-gray-900'}`}
            >
              {t}
            </button>
          ))}
        </div>

        {/* ── DASHBOARD ── */}
        {tab === 'Dashboard' && dashboard && (
          <div className="space-y-4">
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              {[
                { label: 'Accounts Receivable', value: fmt(dashboard.ar?.TotalAR), sub: `${dashboard.ar?.OpenCount || 0} open invoices`, color: 'text-blue-600' },
                { label: 'Overdue AR',           value: fmt(dashboard.ar?.OverdueAR), sub: 'Past due', color: 'text-red-600' },
                { label: 'Accounts Payable',     value: fmt(dashboard.ap?.TotalAP), sub: `${dashboard.ap?.OpenCount || 0} open bills`, color: 'text-orange-600' },
                { label: 'Overdue AP',           value: fmt(dashboard.ap?.OverdueAP), sub: 'Past due', color: 'text-red-600' },
              ].map(card => (
                <div key={card.label} className="bg-white rounded-xl border border-gray-200 p-4">
                  <p className="text-xs text-gray-500 font-medium mb-1">{card.label}</p>
                  <p className={`text-2xl font-bold ${card.color}`}>{card.value}</p>
                  <p className="text-xs text-gray-400 mt-1">{card.sub}</p>
                </div>
              ))}
            </div>

            <div className="grid md:grid-cols-2 gap-4">
              {/* Recent Payments */}
              <div className="bg-white rounded-xl border border-gray-200 p-4">
                <h3 className="font-semibold text-gray-800 mb-3">Recent Payments</h3>
                {dashboard.recentPayments?.length ? (
                  <table className="w-full text-sm">
                    <thead><tr className="text-left text-xs text-gray-400 border-b">
                      <th className="pb-2">Customer</th><th className="pb-2">Date</th><th className="pb-2 text-right">Amount</th>
                    </tr></thead>
                    <tbody>
                      {dashboard.recentPayments.map(p => (
                        <tr key={p.PaymentID} className="border-b last:border-0">
                          <td className="py-1.5 text-gray-700">{p.CustomerName}</td>
                          <td className="py-1.5 text-gray-500">{fmtDate(p.PaymentDate)}</td>
                          <td className="py-1.5 text-right text-green-700 font-medium">{fmt(p.Amount)}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                ) : <p className="text-sm text-gray-400">No payments yet.</p>}
              </div>

              {/* Overdue Invoices */}
              <div className="bg-white rounded-xl border border-gray-200 p-4">
                <h3 className="font-semibold text-gray-800 mb-3">Overdue Invoices</h3>
                {dashboard.overdueInvoices?.length ? (
                  <table className="w-full text-sm">
                    <thead><tr className="text-left text-xs text-gray-400 border-b">
                      <th className="pb-2">Customer</th><th className="pb-2">Due</th><th className="pb-2 text-right">Balance</th>
                    </tr></thead>
                    <tbody>
                      {dashboard.overdueInvoices.map(inv => (
                        <tr key={inv.InvoiceID} className="border-b last:border-0">
                          <td className="py-1.5 text-gray-700">{inv.CustomerName}</td>
                          <td className="py-1.5 text-red-500">{fmtDate(inv.DueDate)}</td>
                          <td className="py-1.5 text-right text-red-600 font-medium">{fmt(inv.BalanceDue)}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                ) : <p className="text-sm text-gray-400">No overdue invoices.</p>}
              </div>
            </div>
          </div>
        )}

        {/* ── INVOICES ── */}
        {tab === 'Invoices' && (
          <div className="bg-white rounded-xl border border-gray-200">
            <div className="flex items-center justify-between p-4 border-b">
              <h2 className="font-semibold text-gray-900">Invoices</h2>
              <button onClick={() => setShowInvoiceModal(true)} className={btnGreen}>+ New Invoice</button>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                  {['Invoice #','Customer','Date','Due','Total','Balance','Status'].map(h => (
                    <th key={h} className="px-4 py-3 font-semibold">{h}</th>
                  ))}
                </tr></thead>
                <tbody>
                  {invoices.length === 0 && (
                    <tr><td colSpan={7} className="px-4 py-8 text-center text-gray-400">No invoices yet.</td></tr>
                  )}
                  {invoices.map(inv => (
                    <tr key={inv.InvoiceID} className="border-b hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium text-green-700">{inv.InvoiceNumber}</td>
                      <td className="px-4 py-3">{inv.CustomerName}</td>
                      <td className="px-4 py-3 text-gray-500">{fmtDate(inv.InvoiceDate)}</td>
                      <td className="px-4 py-3 text-gray-500">{fmtDate(inv.DueDate)}</td>
                      <td className="px-4 py-3">{fmt(inv.TotalAmount)}</td>
                      <td className="px-4 py-3 font-medium">{fmt(inv.BalanceDue)}</td>
                      <td className="px-4 py-3">
                        <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${statusColor[inv.Status] || 'bg-gray-100 text-gray-600'}`}>
                          {inv.Status}
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* ── CUSTOMERS ── */}
        {tab === 'Customers' && (
          <div className="bg-white rounded-xl border border-gray-200">
            <div className="flex items-center justify-between p-4 border-b">
              <h2 className="font-semibold text-gray-900">Customers</h2>
              <button onClick={() => setShowCustomerModal(true)} className={btnGreen}>+ New Customer</button>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                  {['Name','Email','Phone','Payment Terms','Open Balance'].map(h => (
                    <th key={h} className="px-4 py-3 font-semibold">{h}</th>
                  ))}
                </tr></thead>
                <tbody>
                  {customers.length === 0 && (
                    <tr><td colSpan={5} className="px-4 py-8 text-center text-gray-400">No customers yet.</td></tr>
                  )}
                  {customers.map(c => (
                    <tr key={c.CustomerID} className="border-b hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium">{c.DisplayName}</td>
                      <td className="px-4 py-3 text-gray-500">{c.Email || '—'}</td>
                      <td className="px-4 py-3 text-gray-500">{c.Phone || '—'}</td>
                      <td className="px-4 py-3 text-gray-500">{c.PaymentTerms}</td>
                      <td className="px-4 py-3 font-medium text-blue-700">{fmt(c.OpenBalance)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* ── VENDORS ── */}
        {tab === 'Vendors' && (
          <div className="bg-white rounded-xl border border-gray-200">
            <div className="flex items-center justify-between p-4 border-b">
              <h2 className="font-semibold text-gray-900">Vendors</h2>
              <button onClick={() => setShowVendorModal(true)} className={btnGreen}>+ New Vendor</button>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                  {['Name','Email','Phone','Payment Terms','Open Balance','1099'].map(h => (
                    <th key={h} className="px-4 py-3 font-semibold">{h}</th>
                  ))}
                </tr></thead>
                <tbody>
                  {vendors.length === 0 && (
                    <tr><td colSpan={6} className="px-4 py-8 text-center text-gray-400">No vendors yet.</td></tr>
                  )}
                  {vendors.map(v => (
                    <tr key={v.VendorID} className="border-b hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium">{v.DisplayName}</td>
                      <td className="px-4 py-3 text-gray-500">{v.Email || '—'}</td>
                      <td className="px-4 py-3 text-gray-500">{v.Phone || '—'}</td>
                      <td className="px-4 py-3 text-gray-500">{v.PaymentTerms}</td>
                      <td className="px-4 py-3 font-medium text-orange-700">{fmt(v.OpenBalance)}</td>
                      <td className="px-4 py-3">{v.Is1099 ? '✓' : '—'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* ── BILLS ── */}
        {tab === 'Bills' && (
          <div className="bg-white rounded-xl border border-gray-200">
            <div className="flex items-center justify-between p-4 border-b">
              <h2 className="font-semibold text-gray-900">Bills (Accounts Payable)</h2>
              <button onClick={() => setShowBillModal(true)} className={btnGreen}>+ New Bill</button>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                  {['Bill #','Vendor','Date','Due','Total','Balance','Status'].map(h => (
                    <th key={h} className="px-4 py-3 font-semibold">{h}</th>
                  ))}
                </tr></thead>
                <tbody>
                  {bills.length === 0 && (
                    <tr><td colSpan={7} className="px-4 py-8 text-center text-gray-400">No bills yet.</td></tr>
                  )}
                  {bills.map(b => (
                    <tr key={b.BillID} className="border-b hover:bg-gray-50">
                      <td className="px-4 py-3 font-medium text-green-700">{b.BillNumber || '—'}</td>
                      <td className="px-4 py-3">{b.VendorName}</td>
                      <td className="px-4 py-3 text-gray-500">{fmtDate(b.BillDate)}</td>
                      <td className="px-4 py-3 text-gray-500">{fmtDate(b.DueDate)}</td>
                      <td className="px-4 py-3">{fmt(b.TotalAmount)}</td>
                      <td className="px-4 py-3 font-medium">{fmt(b.BalanceDue)}</td>
                      <td className="px-4 py-3">
                        <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${statusColor[b.Status] || 'bg-gray-100 text-gray-600'}`}>
                          {b.Status}
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* ── EXPENSES ── */}
        {tab === 'Expenses' && (
          <div className="bg-white rounded-xl border border-gray-200">
            <div className="flex items-center justify-between p-4 border-b">
              <h2 className="font-semibold text-gray-900">Expenses</h2>
              <button onClick={() => setShowExpenseModal(true)} className={btnGreen}>+ New Expense</button>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                  {['Date','Vendor','Method','Total','Notes'].map(h => (
                    <th key={h} className="px-4 py-3 font-semibold">{h}</th>
                  ))}
                </tr></thead>
                <tbody>
                  {expenses.length === 0 && (
                    <tr><td colSpan={5} className="px-4 py-8 text-center text-gray-400">No expenses yet.</td></tr>
                  )}
                  {expenses.map(e => (
                    <tr key={e.ExpenseID} className="border-b hover:bg-gray-50">
                      <td className="px-4 py-3 text-gray-500">{fmtDate(e.ExpenseDate)}</td>
                      <td className="px-4 py-3">{e.VendorName || '—'}</td>
                      <td className="px-4 py-3 text-gray-500">{e.PaymentMethod}</td>
                      <td className="px-4 py-3 font-medium">{fmt(e.TotalAmount)}</td>
                      <td className="px-4 py-3 text-gray-400 truncate max-w-xs">{e.Notes || '—'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* ── CHART OF ACCOUNTS ── */}
        {tab === 'Accounts' && (
          <div className="bg-white rounded-xl border border-gray-200">
            <div className="flex items-center justify-between p-4 border-b">
              <h2 className="font-semibold text-gray-900">Chart of Accounts</h2>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                  {['#','Account Name','Type','Statement','Active'].map(h => (
                    <th key={h} className="px-4 py-3 font-semibold">{h}</th>
                  ))}
                </tr></thead>
                <tbody>
                  {accounts.map(a => (
                    <tr key={a.AccountID} className="border-b hover:bg-gray-50">
                      <td className="px-4 py-3 font-mono text-gray-500">{a.AccountNumber}</td>
                      <td className="px-4 py-3 font-medium">{a.AccountName}</td>
                      <td className="px-4 py-3 text-gray-500">{a.AccountTypeName}</td>
                      <td className="px-4 py-3 text-gray-400">{a.FinancialStatement}</td>
                      <td className="px-4 py-3">{a.IsActive ? '✓' : '—'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* ── REPORTS ── */}
        {tab === 'Reports' && (
          <div className="space-y-4">
            <div className="bg-white rounded-xl border border-gray-200 p-5">
              <h2 className="font-semibold text-gray-900 mb-4">Financial Reports</h2>
              <div className="flex flex-wrap gap-3 mb-4">
                {[
                  { key: 'profit-loss',   label: 'Profit & Loss' },
                  { key: 'balance-sheet', label: 'Balance Sheet' },
                  { key: 'ar-aging',      label: 'AR Aging' },
                  { key: 'ap-aging',      label: 'AP Aging' },
                  { key: 'cash-flow',     label: 'Cash Flow' },
                  { key: 'trial-balance', label: 'Trial Balance' },
                  { key: 'general-ledger',label: 'General Ledger' },
                ].map(r => (
                  <button key={r.key}
                    onClick={() => { setReportType(r.key); setReportData(null); }}
                    className={`${btn} text-sm ${reportType === r.key ? 'bg-green-700 text-white' : 'border border-gray-300 text-gray-700 hover:bg-gray-50'}`}
                  >
                    {r.label}
                  </button>
                ))}
              </div>

              {/* Date pickers */}
              {['profit-loss', 'cash-flow'].includes(reportType) && (
                <div className="flex gap-3 mb-4">
                  <div>
                    <label className="text-xs text-gray-500 block mb-1">Start Date</label>
                    <input type="date" className={input + ' w-auto'} value={reportDates.startDate}
                      onChange={e => setReportDates(d => ({ ...d, startDate: e.target.value }))} />
                  </div>
                  <div>
                    <label className="text-xs text-gray-500 block mb-1">End Date</label>
                    <input type="date" className={input + ' w-auto'} value={reportDates.endDate}
                      onChange={e => setReportDates(d => ({ ...d, endDate: e.target.value }))} />
                  </div>
                </div>
              )}
              {['balance-sheet', 'trial-balance'].includes(reportType) && (
                <div className="mb-4">
                  <label className="text-xs text-gray-500 block mb-1">As Of Date</label>
                  <input type="date" className={input + ' w-auto'} value={reportDates.asOfDate}
                    onChange={e => setReportDates(d => ({ ...d, asOfDate: e.target.value }))} />
                </div>
              )}

              <button onClick={fetchReport} className={btnGreen}>Run Report</button>
            </div>

            {/* Report output */}
            {reportData && (
              <div className="bg-white rounded-xl border border-gray-200 p-5">
                {/* Profit & Loss */}
                {reportType === 'profit-loss' && (
                  <div>
                    <h3 className="font-bold text-lg text-gray-900 mb-4">
                      Profit & Loss — {fmtDate(reportDates.startDate)} to {fmtDate(reportDates.endDate)}
                    </h3>
                    {[
                      { title: 'Revenue', rows: reportData.revenue, total: reportData.totalRevenue, color: 'text-green-700' },
                      { title: 'Cost of Goods', rows: reportData.cogs, total: reportData.totalCOGS, color: 'text-orange-700' },
                      { title: 'Expenses', rows: reportData.expenses, total: reportData.totalExpenses, color: 'text-red-700' },
                    ].map(section => (
                      <div key={section.title} className="mb-4">
                        <p className="font-semibold text-gray-700 mb-1">{section.title}</p>
                        {section.rows.map(r => (
                          <div key={r.AccountNumber} className="flex justify-between text-sm py-0.5 text-gray-600">
                            <span>{r.AccountNumber} — {r.AccountName}</span>
                            <span className={section.color}>{fmt(r.Balance)}</span>
                          </div>
                        ))}
                        <div className="flex justify-between text-sm font-semibold border-t mt-1 pt-1">
                          <span>Total {section.title}</span>
                          <span className={section.color}>{fmt(section.total)}</span>
                        </div>
                      </div>
                    ))}
                    <div className="flex justify-between text-base font-bold border-t-2 pt-2 mt-4">
                      <span>Net Income</span>
                      <span className={reportData.netIncome >= 0 ? 'text-green-700' : 'text-red-600'}>{fmt(reportData.netIncome)}</span>
                    </div>
                  </div>
                )}

                {/* Balance Sheet */}
                {reportType === 'balance-sheet' && (
                  <div>
                    <h3 className="font-bold text-lg text-gray-900 mb-4">Balance Sheet — As of {fmtDate(reportDates.asOfDate)}</h3>
                    {[
                      { title: 'Assets', rows: reportData.assets, total: reportData.totalAssets, color: 'text-blue-700' },
                      { title: 'Liabilities', rows: reportData.liabilities, total: reportData.totalLiabilities, color: 'text-orange-700' },
                      { title: 'Equity', rows: reportData.equity, total: reportData.totalEquity, color: 'text-green-700' },
                    ].map(section => (
                      <div key={section.title} className="mb-4">
                        <p className="font-semibold text-gray-700 mb-1">{section.title}</p>
                        {section.rows.map(r => (
                          <div key={r.AccountNumber} className="flex justify-between text-sm py-0.5 text-gray-600">
                            <span>{r.AccountNumber} — {r.AccountName}</span>
                            <span className={section.color}>{fmt(r.Balance)}</span>
                          </div>
                        ))}
                        <div className="flex justify-between text-sm font-semibold border-t mt-1 pt-1">
                          <span>Total {section.title}</span>
                          <span className={section.color}>{fmt(section.total)}</span>
                        </div>
                      </div>
                    ))}
                  </div>
                )}

                {/* AR/AP Aging */}
                {['ar-aging', 'ap-aging'].includes(reportType) && (
                  <div>
                    <h3 className="font-bold text-lg text-gray-900 mb-4">
                      {reportType === 'ar-aging' ? 'Accounts Receivable' : 'Accounts Payable'} Aging
                    </h3>
                    <table className="w-full text-sm">
                      <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                        {[reportType === 'ar-aging' ? 'Customer' : 'Vendor', 'Invoice/Bill', 'Due', 'Total', 'Balance', 'Bucket'].map(h => (
                          <th key={h} className="px-3 py-2 font-semibold">{h}</th>
                        ))}
                      </tr></thead>
                      <tbody>
                        {reportData.aging.map((r, i) => (
                          <tr key={i} className="border-b">
                            <td className="px-3 py-2">{r.CustomerName || r.VendorName}</td>
                            <td className="px-3 py-2 text-gray-500">{r.InvoiceNumber || r.BillNumber}</td>
                            <td className="px-3 py-2 text-gray-500">{fmtDate(r.DueDate)}</td>
                            <td className="px-3 py-2">{fmt(r.TotalAmount)}</td>
                            <td className="px-3 py-2 font-medium">{fmt(r.BalanceDue)}</td>
                            <td className="px-3 py-2">
                              <span className={`px-2 py-0.5 rounded-full text-xs font-medium
                                ${r.AgingBucket === 'Current' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                                {r.AgingBucket}
                              </span>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                )}

                {/* Cash Flow */}
                {reportType === 'cash-flow' && (
                  <div>
                    <h3 className="font-bold text-lg text-gray-900 mb-4">
                      Cash Flow — {fmtDate(reportDates.startDate)} to {fmtDate(reportDates.endDate)}
                    </h3>
                    <div className="space-y-2 text-sm">
                      {[
                        { label: 'Cash In (Payments Received)', value: reportData.cashIn, color: 'text-green-700' },
                        { label: 'Bill Payments Made', value: -reportData.billPayments, color: 'text-red-600' },
                        { label: 'Expenses', value: -reportData.expenses, color: 'text-red-600' },
                      ].map(row => (
                        <div key={row.label} className="flex justify-between">
                          <span className="text-gray-600">{row.label}</span>
                          <span className={row.color + ' font-medium'}>{fmt(row.value)}</span>
                        </div>
                      ))}
                      <div className="flex justify-between font-bold border-t pt-2 text-base">
                        <span>Net Cash</span>
                        <span className={reportData.netCash >= 0 ? 'text-green-700' : 'text-red-600'}>{fmt(reportData.netCash)}</span>
                      </div>
                    </div>
                  </div>
                )}

                {/* Trial Balance */}
                {reportType === 'trial-balance' && (
                  <div>
                    <h3 className="font-bold text-lg text-gray-900 mb-4">Trial Balance — As of {fmtDate(reportDates.asOfDate)}</h3>
                    <table className="w-full text-sm">
                      <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                        {['#','Account','Type','Debits','Credits','Net'].map(h => (
                          <th key={h} className="px-3 py-2 font-semibold">{h}</th>
                        ))}
                      </tr></thead>
                      <tbody>
                        {reportData.accounts.map((a, i) => (
                          <tr key={i} className="border-b">
                            <td className="px-3 py-2 font-mono text-gray-400">{a.AccountNumber}</td>
                            <td className="px-3 py-2">{a.AccountName}</td>
                            <td className="px-3 py-2 text-gray-500">{a.AccountType}</td>
                            <td className="px-3 py-2 text-right">{fmt(a.TotalDebits)}</td>
                            <td className="px-3 py-2 text-right">{fmt(a.TotalCredits)}</td>
                            <td className="px-3 py-2 text-right font-medium">{fmt(a.NetBalance)}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                )}

                {/* General Ledger */}
                {reportType === 'general-ledger' && (
                  <div>
                    <h3 className="font-bold text-lg text-gray-900 mb-4">General Ledger</h3>
                    <table className="w-full text-sm">
                      <thead><tr className="text-left text-xs text-gray-500 border-b bg-gray-50">
                        {['Date','Entry #','Account','Description','Debit','Credit'].map(h => (
                          <th key={h} className="px-3 py-2 font-semibold">{h}</th>
                        ))}
                      </tr></thead>
                      <tbody>
                        {reportData.entries.map((e, i) => (
                          <tr key={i} className="border-b">
                            <td className="px-3 py-2 text-gray-500">{fmtDate(e.EntryDate)}</td>
                            <td className="px-3 py-2 font-mono">{e.EntryNumber}</td>
                            <td className="px-3 py-2">{e.AccountNumber} {e.AccountName}</td>
                            <td className="px-3 py-2 text-gray-500 max-w-xs truncate">{e.LineDescription || e.JEDescription}</td>
                            <td className="px-3 py-2 text-right">{e.DebitAmount > 0 ? fmt(e.DebitAmount) : ''}</td>
                            <td className="px-3 py-2 text-right">{e.CreditAmount > 0 ? fmt(e.CreditAmount) : ''}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                )}
              </div>
            )}
          </div>
        )}

        {/* ── PAYMENTS / STRIPE SETTINGS ── */}
        {tab === 'Payments' && <PaymentsTab apiFetch={apiFetch} />}
      </div>

      {/* ── MODALS ── */}

      {showCustomerModal && (
        <CustomerModal
          onClose={() => setShowCustomerModal(false)}
          onSave={async data => {
            await apiFetch('/customers', { method: 'POST', body: JSON.stringify(data) });
            const d = await apiFetch('/customers');
            setCustomers(d.customers);
            setShowCustomerModal(false);
          }}
        />
      )}

      {showVendorModal && (
        <VendorModal
          onClose={() => setShowVendorModal(false)}
          onSave={async data => {
            await apiFetch('/vendors', { method: 'POST', body: JSON.stringify(data) });
            const d = await apiFetch('/vendors');
            setVendors(d.vendors);
            setShowVendorModal(false);
          }}
        />
      )}

      {showInvoiceModal && (
        <InvoiceModal
          customers={customers}
          onClose={() => setShowInvoiceModal(false)}
          onSave={async data => {
            await apiFetch('/invoices', { method: 'POST', body: JSON.stringify(data) });
            const d = await apiFetch('/invoices');
            setInvoices(d.invoices);
            setShowInvoiceModal(false);
          }}
          apiFetch={apiFetch}
        />
      )}

      {showBillModal && (
        <BillModal
          vendors={vendors}
          onClose={() => setShowBillModal(false)}
          onSave={async data => {
            await apiFetch('/bills', { method: 'POST', body: JSON.stringify(data) });
            const d = await apiFetch('/bills');
            setBills(d.bills);
            setShowBillModal(false);
          }}
        />
      )}

      {showExpenseModal && (
        <ExpenseModal
          vendors={vendors}
          accounts={accounts}
          onClose={() => setShowExpenseModal(false)}
          onSave={async data => {
            await apiFetch('/expenses', { method: 'POST', body: JSON.stringify(data) });
            const d = await apiFetch('/expenses');
            setExpenses(d.expenses);
            setShowExpenseModal(false);
          }}
        />
      )}
      <ThaiymeChat businessId={businessId} page="accounting" />
    </AccountLayout>
  );
}

// ─── CUSTOMER MODAL ────────────────────────────────────────────

function CustomerModal({ onClose, onSave }) {
  const [form, setForm] = useState({ DisplayName: '', CompanyName: '', FirstName: '', LastName: '', Email: '', Phone: '', BillingAddress1: '', BillingCity: '', BillingState: '', BillingZip: '', PaymentTerms: 'Net30', Notes: '' });
  const set = k => e => setForm(f => ({ ...f, [k]: e.target.value }));
  return (
    <Modal title="New Customer" onClose={onClose}>
      <div className="grid grid-cols-2 gap-4">
        <Field label="Display Name *"><input className={input} value={form.DisplayName} onChange={set('DisplayName')} /></Field>
        <Field label="Company Name"><input className={input} value={form.CompanyName} onChange={set('CompanyName')} /></Field>
        <Field label="First Name"><input className={input} value={form.FirstName} onChange={set('FirstName')} /></Field>
        <Field label="Last Name"><input className={input} value={form.LastName} onChange={set('LastName')} /></Field>
        <Field label="Email"><input type="email" className={input} value={form.Email} onChange={set('Email')} /></Field>
        <Field label="Phone"><input className={input} value={form.Phone} onChange={set('Phone')} /></Field>
        <Field label="Billing Address"><input className={input} value={form.BillingAddress1} onChange={set('BillingAddress1')} /></Field>
        <Field label="City"><input className={input} value={form.BillingCity} onChange={set('BillingCity')} /></Field>
        <Field label="State"><input className={input} value={form.BillingState} onChange={set('BillingState')} /></Field>
        <Field label="ZIP"><input className={input} value={form.BillingZip} onChange={set('BillingZip')} /></Field>
        <Field label="Payment Terms">
          <select className={input} value={form.PaymentTerms} onChange={set('PaymentTerms')}>
            {['Due on Receipt','Net15','Net30','Net45','Net60'].map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="Notes"><input className={input} value={form.Notes} onChange={set('Notes')} /></Field>
      </div>
      <div className="flex justify-end gap-2 mt-4">
        <button onClick={onClose} className={btnWhite}>Cancel</button>
        <button onClick={() => onSave(form)} className={btnGreen} disabled={!form.DisplayName}>Save Customer</button>
      </div>
    </Modal>
  );
}

// ─── VENDOR MODAL ─────────────────────────────────────────────

function VendorModal({ onClose, onSave }) {
  const [form, setForm] = useState({ DisplayName: '', CompanyName: '', FirstName: '', LastName: '', Email: '', Phone: '', Address1: '', City: '', State: '', Zip: '', PaymentTerms: 'Net30', Is1099: false, Notes: '' });
  const set = k => e => setForm(f => ({ ...f, [k]: e.target.value }));
  return (
    <Modal title="New Vendor" onClose={onClose}>
      <div className="grid grid-cols-2 gap-4">
        <Field label="Display Name *"><input className={input} value={form.DisplayName} onChange={set('DisplayName')} /></Field>
        <Field label="Company Name"><input className={input} value={form.CompanyName} onChange={set('CompanyName')} /></Field>
        <Field label="First Name"><input className={input} value={form.FirstName} onChange={set('FirstName')} /></Field>
        <Field label="Last Name"><input className={input} value={form.LastName} onChange={set('LastName')} /></Field>
        <Field label="Email"><input type="email" className={input} value={form.Email} onChange={set('Email')} /></Field>
        <Field label="Phone"><input className={input} value={form.Phone} onChange={set('Phone')} /></Field>
        <Field label="Address"><input className={input} value={form.Address1} onChange={set('Address1')} /></Field>
        <Field label="City"><input className={input} value={form.City} onChange={set('City')} /></Field>
        <Field label="State"><input className={input} value={form.State} onChange={set('State')} /></Field>
        <Field label="ZIP"><input className={input} value={form.Zip} onChange={set('Zip')} /></Field>
        <Field label="Payment Terms">
          <select className={input} value={form.PaymentTerms} onChange={set('PaymentTerms')}>
            {['Due on Receipt','Net15','Net30','Net45','Net60'].map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="1099 Vendor">
          <input type="checkbox" checked={form.Is1099} onChange={e => setForm(f => ({ ...f, Is1099: e.target.checked }))} className="mt-2" />
        </Field>
      </div>
      <div className="flex justify-end gap-2 mt-4">
        <button onClick={onClose} className={btnWhite}>Cancel</button>
        <button onClick={() => onSave(form)} className={btnGreen} disabled={!form.DisplayName}>Save Vendor</button>
      </div>
    </Modal>
  );
}

// ─── INVOICE MODAL ────────────────────────────────────────────

function InvoiceModal({ customers, onClose, onSave, apiFetch }) {
  const today = new Date().toISOString().slice(0, 10);
  const due30 = new Date(Date.now() + 30 * 86400000).toISOString().slice(0, 10);
  const [form, setForm] = useState({ CustomerID: '', InvoiceDate: today, DueDate: due30, PaymentTerms: 'Net30', Notes: '', Lines: [{ Description: '', Quantity: 1, UnitPrice: 0, TaxAmount: 0 }] });
  const set = k => e => setForm(f => ({ ...f, [k]: e.target.value }));

  function setLine(i, k, v) {
    setForm(f => { const ls = [...f.Lines]; ls[i] = { ...ls[i], [k]: v }; return { ...f, Lines: ls }; });
  }
  function addLine() { setForm(f => ({ ...f, Lines: [...f.Lines, { Description: '', Quantity: 1, UnitPrice: 0, TaxAmount: 0 }] })); }
  function removeLine(i) { setForm(f => ({ ...f, Lines: f.Lines.filter((_, idx) => idx !== i) })); }

  const subTotal = form.Lines.reduce((s, l) => s + (parseFloat(l.Quantity) * parseFloat(l.UnitPrice || 0)), 0);
  const taxTotal = form.Lines.reduce((s, l) => s + parseFloat(l.TaxAmount || 0), 0);

  return (
    <Modal title="New Invoice" onClose={onClose}>
      <div className="grid grid-cols-2 gap-4 mb-4">
        <Field label="Customer *">
          <select className={input} value={form.CustomerID} onChange={set('CustomerID')}>
            <option value="">— select —</option>
            {customers.map(c => <option key={c.CustomerID} value={c.CustomerID}>{c.DisplayName}</option>)}
          </select>
        </Field>
        <Field label="Payment Terms">
          <select className={input} value={form.PaymentTerms} onChange={set('PaymentTerms')}>
            {['Due on Receipt','Net15','Net30','Net45','Net60'].map(t => <option key={t}>{t}</option>)}
          </select>
        </Field>
        <Field label="Invoice Date"><input type="date" className={input} value={form.InvoiceDate} onChange={set('InvoiceDate')} /></Field>
        <Field label="Due Date"><input type="date" className={input} value={form.DueDate} onChange={set('DueDate')} /></Field>
      </div>

      <p className="text-xs font-semibold text-gray-500 mb-2">LINE ITEMS</p>
      <table className="w-full text-sm mb-2">
        <thead><tr className="text-left text-xs text-gray-400 border-b">
          <th className="pb-1 flex-1">Description</th><th className="pb-1 w-16">Qty</th><th className="pb-1 w-24">Unit Price</th><th className="pb-1 w-20">Tax</th><th className="pb-1 w-8"></th>
        </tr></thead>
        <tbody>
          {form.Lines.map((l, i) => (
            <tr key={i} className="border-b">
              <td className="py-1 pr-2"><input className={input} value={l.Description} onChange={e => setLine(i, 'Description', e.target.value)} placeholder="Description" /></td>
              <td className="py-1 pr-2"><input type="number" className={input} value={l.Quantity} onChange={e => setLine(i, 'Quantity', e.target.value)} min="0" /></td>
              <td className="py-1 pr-2"><input type="number" className={input} value={l.UnitPrice} onChange={e => setLine(i, 'UnitPrice', e.target.value)} min="0" step="0.01" /></td>
              <td className="py-1 pr-2"><input type="number" className={input} value={l.TaxAmount} onChange={e => setLine(i, 'TaxAmount', e.target.value)} min="0" step="0.01" /></td>
              <td className="py-1"><button onClick={() => removeLine(i)} className="text-red-400 hover:text-red-600">✕</button></td>
            </tr>
          ))}
        </tbody>
      </table>
      <button onClick={addLine} className="text-sm text-green-700 hover:underline mb-4">+ Add Line</button>

      <div className="text-right text-sm space-y-1 mb-4">
        <div className="text-gray-500">Subtotal: <strong>{new Intl.NumberFormat('en-US',{style:'currency',currency:'USD'}).format(subTotal)}</strong></div>
        <div className="text-gray-500">Tax: <strong>{new Intl.NumberFormat('en-US',{style:'currency',currency:'USD'}).format(taxTotal)}</strong></div>
        <div className="font-bold text-gray-900">Total: {new Intl.NumberFormat('en-US',{style:'currency',currency:'USD'}).format(subTotal + taxTotal)}</div>
      </div>

      <Field label="Notes"><textarea className={input} rows={2} value={form.Notes} onChange={set('Notes')} /></Field>
      <div className="flex justify-end gap-2 mt-4">
        <button onClick={onClose} className={btnWhite}>Cancel</button>
        <button onClick={() => onSave(form)} className={btnGreen} disabled={!form.CustomerID}>Create Invoice</button>
      </div>
    </Modal>
  );
}

// ─── BILL MODAL ───────────────────────────────────────────────

function BillModal({ vendors, onClose, onSave }) {
  const today = new Date().toISOString().slice(0, 10);
  const due30 = new Date(Date.now() + 30 * 86400000).toISOString().slice(0, 10);
  const [form, setForm] = useState({ VendorID: '', BillNumber: '', BillDate: today, DueDate: due30, Notes: '', Lines: [{ Description: '', Quantity: 1, UnitPrice: 0, TaxAmount: 0 }] });
  const set = k => e => setForm(f => ({ ...f, [k]: e.target.value }));
  function setLine(i, k, v) { setForm(f => { const ls = [...f.Lines]; ls[i] = { ...ls[i], [k]: v }; return { ...f, Lines: ls }; }); }
  function addLine() { setForm(f => ({ ...f, Lines: [...f.Lines, { Description: '', Quantity: 1, UnitPrice: 0, TaxAmount: 0 }] })); }

  return (
    <Modal title="New Bill" onClose={onClose}>
      <div className="grid grid-cols-2 gap-4 mb-4">
        <Field label="Vendor *">
          <select className={input} value={form.VendorID} onChange={set('VendorID')}>
            <option value="">— select —</option>
            {vendors.map(v => <option key={v.VendorID} value={v.VendorID}>{v.DisplayName}</option>)}
          </select>
        </Field>
        <Field label="Bill #"><input className={input} value={form.BillNumber} onChange={set('BillNumber')} /></Field>
        <Field label="Bill Date"><input type="date" className={input} value={form.BillDate} onChange={set('BillDate')} /></Field>
        <Field label="Due Date"><input type="date" className={input} value={form.DueDate} onChange={set('DueDate')} /></Field>
      </div>
      <p className="text-xs font-semibold text-gray-500 mb-2">LINE ITEMS</p>
      <table className="w-full text-sm mb-2">
        <thead><tr className="text-left text-xs text-gray-400 border-b">
          <th className="pb-1">Description</th><th className="pb-1 w-16">Qty</th><th className="pb-1 w-24">Unit Price</th><th className="pb-1 w-20">Tax</th>
        </tr></thead>
        <tbody>
          {form.Lines.map((l, i) => (
            <tr key={i} className="border-b">
              <td className="py-1 pr-2"><input className={input} value={l.Description} onChange={e => setLine(i, 'Description', e.target.value)} /></td>
              <td className="py-1 pr-2"><input type="number" className={input} value={l.Quantity} onChange={e => setLine(i, 'Quantity', e.target.value)} /></td>
              <td className="py-1 pr-2"><input type="number" className={input} value={l.UnitPrice} onChange={e => setLine(i, 'UnitPrice', e.target.value)} step="0.01" /></td>
              <td className="py-1 pr-2"><input type="number" className={input} value={l.TaxAmount} onChange={e => setLine(i, 'TaxAmount', e.target.value)} step="0.01" /></td>
            </tr>
          ))}
        </tbody>
      </table>
      <button onClick={addLine} className="text-sm text-green-700 hover:underline mb-4">+ Add Line</button>
      <Field label="Notes"><textarea className={input} rows={2} value={form.Notes} onChange={set('Notes')} /></Field>
      <div className="flex justify-end gap-2 mt-4">
        <button onClick={onClose} className={btnWhite}>Cancel</button>
        <button onClick={() => onSave(form)} className={btnGreen} disabled={!form.VendorID}>Create Bill</button>
      </div>
    </Modal>
  );
}

// ─── EXPENSE MODAL ────────────────────────────────────────────

function ExpenseModal({ vendors, accounts, onClose, onSave }) {
  const today = new Date().toISOString().slice(0, 10);
  const [form, setForm] = useState({ VendorID: '', ExpenseDate: today, PaymentMethod: 'Credit Card', Reference: '', Notes: '', Lines: [{ AccountID: '', Description: '', Amount: 0, IsBillable: false }] });
  const set = k => e => setForm(f => ({ ...f, [k]: e.target.value }));
  function setLine(i, k, v) { setForm(f => { const ls = [...f.Lines]; ls[i] = { ...ls[i], [k]: v }; return { ...f, Lines: ls }; }); }
  function addLine() { setForm(f => ({ ...f, Lines: [...f.Lines, { AccountID: '', Description: '', Amount: 0, IsBillable: false }] })); }

  return (
    <Modal title="New Expense" onClose={onClose}>
      <div className="grid grid-cols-2 gap-4 mb-4">
        <Field label="Vendor">
          <select className={input} value={form.VendorID} onChange={set('VendorID')}>
            <option value="">— optional —</option>
            {vendors.map(v => <option key={v.VendorID} value={v.VendorID}>{v.DisplayName}</option>)}
          </select>
        </Field>
        <Field label="Payment Method">
          <select className={input} value={form.PaymentMethod} onChange={set('PaymentMethod')}>
            {['Credit Card','Debit Card','Cash','Check','ACH','Wire Transfer'].map(m => <option key={m}>{m}</option>)}
          </select>
        </Field>
        <Field label="Expense Date"><input type="date" className={input} value={form.ExpenseDate} onChange={set('ExpenseDate')} /></Field>
        <Field label="Reference"><input className={input} value={form.Reference} onChange={set('Reference')} /></Field>
      </div>
      <p className="text-xs font-semibold text-gray-500 mb-2">EXPENSE LINES</p>
      <table className="w-full text-sm mb-2">
        <thead><tr className="text-left text-xs text-gray-400 border-b">
          <th className="pb-1">Account</th><th className="pb-1">Description</th><th className="pb-1 w-24">Amount</th>
        </tr></thead>
        <tbody>
          {form.Lines.map((l, i) => (
            <tr key={i} className="border-b">
              <td className="py-1 pr-2">
                <select className={input} value={l.AccountID} onChange={e => setLine(i, 'AccountID', e.target.value)}>
                  <option value="">— account —</option>
                  {accounts.filter(a => a.FinancialStatement === 'Income Statement').map(a => (
                    <option key={a.AccountID} value={a.AccountID}>{a.AccountNumber} {a.AccountName}</option>
                  ))}
                </select>
              </td>
              <td className="py-1 pr-2"><input className={input} value={l.Description} onChange={e => setLine(i, 'Description', e.target.value)} /></td>
              <td className="py-1 pr-2"><input type="number" className={input} value={l.Amount} onChange={e => setLine(i, 'Amount', e.target.value)} step="0.01" /></td>
            </tr>
          ))}
        </tbody>
      </table>
      <button onClick={addLine} className="text-sm text-green-700 hover:underline mb-4">+ Add Line</button>
      <Field label="Notes"><textarea className={input} rows={2} value={form.Notes} onChange={set('Notes')} /></Field>
      <div className="flex justify-end gap-2 mt-4">
        <button onClick={onClose} className={btnWhite}>Cancel</button>
        <button onClick={() => onSave(form)} className={btnGreen}>Save Expense</button>
      </div>
    </Modal>
  );
}
