/**
 * AggregatorSales — B2B accounts + orders, plus D2C orders across channels.
 *
 * Three tabs:
 *  - B2B Accounts : Reliance / Star Bazaar / restaurant chains / institutions
 *  - B2B Orders   : POs against those accounts with invoice + payment status
 *  - D2C Orders   : own storefront + Zepto / Swiggy / Blinkit / Amazon, etc.
 */
import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";
const btnGhost = "px-3 py-1.5 text-sm border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50";

const BUYER_TYPES   = ['retail', 'restaurant', 'distributor', 'institution'];
const ACCOUNT_STATS = ['active', 'on_hold', 'churned'];
const B2B_STATUSES  = ['placed', 'picking', 'dispatched', 'delivered', 'cancelled'];
const PAY_STATUSES  = ['unpaid', 'partial', 'paid'];
const D2C_CHANNELS  = ['own_app', 'zepto', 'swiggy', 'blinkit', 'amazon', 'other'];
const D2C_STATUSES  = ['placed', 'picking', 'out_for_delivery', 'delivered', 'refunded'];

const CHANNEL_ICON = {
  own_app: '📱', zepto: '⚡', swiggy: '🛵', blinkit: '🟡', amazon: '📦', other: '🔗',
};

const fmt$  = (n) => Number(n || 0).toLocaleString(undefined, { maximumFractionDigits: 2 });
const todayISO = () => new Date().toISOString().slice(0, 10);

// ─────────────────────────────────────────────────────────────────
// B2B Accounts
// ─────────────────────────────────────────────────────────────────
function AccountForm({ acct, onSave, onCancel }) {
  const [s, setS] = useState(acct || {
    BuyerName: '', BuyerType: 'retail',
    ContactName: '', ContactPhone: '', ContactEmail: '',
    DeliveryAddress: '', NetTermsDays: 30, CreditLimit: '',
    Status: 'active', Notes: '',
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div className="md:col-span-2"><label className={lbl}>Buyer name *</label><input className={inp} placeholder="Reliance Retail / Star Bazaar / Bombay Canteen" value={s.BuyerName} onChange={set('BuyerName')} /></div>
        <div><label className={lbl}>Type</label>
          <select className={inp} value={s.BuyerType} onChange={set('BuyerType')}>
            {BUYER_TYPES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Contact name</label><input className={inp} value={s.ContactName || ''} onChange={set('ContactName')} /></div>
        <div><label className={lbl}>Phone</label><input className={inp} value={s.ContactPhone || ''} onChange={set('ContactPhone')} /></div>
        <div><label className={lbl}>Email</label><input className={inp} value={s.ContactEmail || ''} onChange={set('ContactEmail')} /></div>
        <div className="md:col-span-3"><label className={lbl}>Delivery address</label><input className={inp} value={s.DeliveryAddress || ''} onChange={set('DeliveryAddress')} /></div>
        <div><label className={lbl}>Net terms (days)</label><input className={inp} type="number" value={s.NetTermsDays ?? 30} onChange={setNum('NetTermsDays')} /></div>
        <div><label className={lbl}>Credit limit ($)</label><input className={inp} type="number" step="0.01" value={s.CreditLimit ?? ''} onChange={setNum('CreditLimit')} /></div>
        <div><label className={lbl}>Status</label>
          <select className={inp} value={s.Status} onChange={set('Status')}>
            {ACCOUNT_STATS.map(x => <option key={x}>{x}</option>)}
          </select></div>
      </div>
      <div><label className={lbl}>Notes</label><textarea className={inp} rows={2} value={s.Notes || ''} onChange={set('Notes')} /></div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} disabled={!s.BuyerName} className={btn}>Save</button>
      </div>
    </div>
  );
}

function B2BAccountsTab({ businessId }) {
  const [list, setList]    = useState([]);
  const [editing, setEdit] = useState(null);
  const [adding, setAdd]   = useState(false);

  const refresh = () => fetch(`${API}/api/aggregator/${businessId}/b2b/accounts`).then(r => r.json()).then(setList);
  useEffect(refresh, [businessId]);

  const save = async (a) => {
    const isEdit = !!a.AccountID;
    const url = isEdit ? `${API}/api/aggregator/b2b/accounts/${a.AccountID}` : `${API}/api/aggregator/${businessId}/b2b/accounts`;
    const r = await fetch(url, { method: isEdit ? 'PUT' : 'POST',
                                 headers: { 'Content-Type': 'application/json' },
                                 body: JSON.stringify(a) });
    if (r.ok) { setEdit(null); setAdd(false); refresh(); } else alert('Save failed');
  };
  const del = async (id) => {
    if (!window.confirm('Delete this account? Linked orders will become orphaned.')) return;
    await fetch(`${API}/api/aggregator/b2b/accounts/${id}`, { method: 'DELETE' });
    refresh();
  };

  return (
    <div className="space-y-3">
      <div className="flex items-center justify-between flex-wrap gap-3">
        <span className="text-sm text-gray-500">{list.length} account{list.length === 1 ? '' : 's'}</span>
        <button onClick={() => setAdd(true)} className={btn}>+ Add account</button>
      </div>
      {adding && <AccountForm onSave={save} onCancel={() => setAdd(false)} />}
      {list.length === 0 && <div className="text-sm text-gray-500 italic">No B2B accounts yet — add the retail chains, distributors, restaurants and institutions you sell to.</div>}

      <div className="space-y-2">
        {list.map(a => editing?.AccountID === a.AccountID ? (
          <AccountForm key={a.AccountID} acct={editing} onSave={save} onCancel={() => setEdit(null)} />
        ) : (
          <div key={a.AccountID} className="bg-white border border-gray-200 rounded-xl p-3 flex items-start gap-3">
            <div className="text-2xl shrink-0">🏬</div>
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <strong className="text-gray-900">{a.BuyerName}</strong>
                <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-blue-100 text-blue-800 font-semibold uppercase">{a.BuyerType}</span>
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${a.Status === 'active' ? 'bg-emerald-100 text-emerald-800' : 'bg-gray-200 text-gray-700'}`}>{a.Status}</span>
              </div>
              <div className="text-xs text-gray-600 mt-0.5">
                {a.ContactName && `${a.ContactName} · `}
                {a.ContactPhone}
                {a.NetTermsDays != null && ` · net ${a.NetTermsDays}d`}
                {a.CreditLimit != null && ` · credit $${fmt$(a.CreditLimit)}`}
              </div>
              {a.DeliveryAddress && <div className="text-xs text-gray-500 mt-0.5">📍 {a.DeliveryAddress}</div>}
            </div>
            <button onClick={() => setEdit(a)} className={btnGhost}>Edit</button>
            <button onClick={() => del(a.AccountID)} className="text-xs text-red-600 hover:underline">Delete</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// B2B Orders
// ─────────────────────────────────────────────────────────────────
function B2BOrderForm({ order, accounts, onSave, onCancel }) {
  const [s, setS] = useState(order || {
    AccountID: accounts[0]?.AccountID || '', OrderDate: todayISO(),
    CropType: '', QuantityKg: '', PricePerKg: '', TotalValue: '',
    DeliveryDate: '', Status: 'placed',
    InvoiceNumber: '', PaymentStatus: 'unpaid', Notes: '',
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  useEffect(() => {
    if (s.QuantityKg != null && s.PricePerKg != null && s.QuantityKg !== '' && s.PricePerKg !== '') {
      const t = Number(s.QuantityKg) * Number(s.PricePerKg);
      if (!Number.isNaN(t)) setS(prev => ({ ...prev, TotalValue: t }));
    }
  }, [s.QuantityKg, s.PricePerKg]);
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Account *</label>
          <select className={inp} value={s.AccountID} onChange={set('AccountID')}>
            <option value="">— select —</option>
            {accounts.map(a => <option key={a.AccountID} value={a.AccountID}>{a.BuyerName}</option>)}
          </select></div>
        <div><label className={lbl}>Order date</label><input className={inp} type="date" value={s.OrderDate || ''} onChange={set('OrderDate')} /></div>
        <div><label className={lbl}>Delivery date</label><input className={inp} type="date" value={s.DeliveryDate || ''} onChange={set('DeliveryDate')} /></div>
        <div><label className={lbl}>Crop</label><input className={inp} value={s.CropType || ''} onChange={set('CropType')} /></div>
        <div><label className={lbl}>Quantity (kg)</label><input className={inp} type="number" step="0.01" value={s.QuantityKg ?? ''} onChange={setNum('QuantityKg')} /></div>
        <div><label className={lbl}>Price per kg ($)</label><input className={inp} type="number" step="0.01" value={s.PricePerKg ?? ''} onChange={setNum('PricePerKg')} /></div>
        <div><label className={lbl}>Total ($)</label><input className={inp} type="number" step="0.01" value={s.TotalValue ?? ''} onChange={setNum('TotalValue')} /></div>
        <div><label className={lbl}>Status</label>
          <select className={inp} value={s.Status} onChange={set('Status')}>
            {B2B_STATUSES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Payment</label>
          <select className={inp} value={s.PaymentStatus} onChange={set('PaymentStatus')}>
            {PAY_STATUSES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div className="md:col-span-2"><label className={lbl}>Invoice #</label><input className={inp} value={s.InvoiceNumber || ''} onChange={set('InvoiceNumber')} /></div>
      </div>
      <div><label className={lbl}>Notes</label><textarea className={inp} rows={2} value={s.Notes || ''} onChange={set('Notes')} /></div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} disabled={!s.AccountID} className={btn}>Save</button>
      </div>
    </div>
  );
}

function B2BOrdersTab({ businessId, accounts }) {
  const [list, setList]    = useState([]);
  const [editing, setEdit] = useState(null);
  const [adding, setAdd]   = useState(false);

  const refresh = () => fetch(`${API}/api/aggregator/${businessId}/b2b/orders`).then(r => r.json()).then(setList);
  useEffect(refresh, [businessId]);

  const save = async (o) => {
    const isEdit = !!o.OrderID;
    const url = isEdit ? `${API}/api/aggregator/b2b/orders/${o.OrderID}` : `${API}/api/aggregator/${businessId}/b2b/orders`;
    const r = await fetch(url, { method: isEdit ? 'PUT' : 'POST',
                                 headers: { 'Content-Type': 'application/json' },
                                 body: JSON.stringify(o) });
    if (r.ok) { setEdit(null); setAdd(false); refresh(); } else alert('Save failed');
  };
  const del = async (id) => {
    if (!window.confirm('Delete this order?')) return;
    await fetch(`${API}/api/aggregator/b2b/orders/${id}`, { method: 'DELETE' });
    refresh();
  };

  const total      = list.reduce((acc, r) => acc + Number(r.TotalValue || 0), 0);
  const unpaid     = list.filter(r => r.PaymentStatus !== 'paid').reduce((acc, r) => acc + Number(r.TotalValue || 0), 0);
  const statusColor = (st) => st === 'delivered' ? 'bg-emerald-100 text-emerald-800'
                            : st === 'dispatched' ? 'bg-blue-100 text-blue-800'
                            : st === 'cancelled' ? 'bg-red-100 text-red-800'
                            : 'bg-gray-100 text-gray-700';

  return (
    <div className="space-y-3">
      <div className="bg-white border border-gray-200 rounded-xl p-3 grid grid-cols-3 gap-3 text-sm">
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Orders</div><div className="text-xl font-bold">{list.length}</div></div>
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Total billed</div><div className="text-xl font-bold">${fmt$(total)}</div></div>
        <div><div className="text-[10px] uppercase text-gray-500 font-semibold">Outstanding A/R</div><div className={`text-xl font-bold ${unpaid > 0 ? 'text-amber-600' : ''}`}>${fmt$(unpaid)}</div></div>
      </div>

      <div className="flex items-center justify-between gap-3 flex-wrap">
        <span className="text-sm text-gray-500">B2B sales orders</span>
        <button onClick={() => setAdd(true)} disabled={accounts.length === 0} className={btn}>+ New B2B order</button>
      </div>
      {accounts.length === 0 && <div className="text-sm text-gray-500 italic">Add at least one B2B account first.</div>}
      {adding && <B2BOrderForm accounts={accounts} onSave={save} onCancel={() => setAdd(false)} />}

      <div className="space-y-2">
        {list.map(o => editing?.OrderID === o.OrderID ? (
          <B2BOrderForm key={o.OrderID} order={editing} accounts={accounts} onSave={save} onCancel={() => setEdit(null)} />
        ) : (
          <div key={o.OrderID} className="bg-white border border-gray-200 rounded-xl p-3 flex items-start gap-3">
            <div className="text-2xl shrink-0">🧾</div>
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <strong className="text-gray-900">{o.BuyerName || `Account #${o.AccountID}`}</strong>
                {o.CropType && <span className="text-sm text-gray-700">— {o.CropType}</span>}
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${statusColor(o.Status)}`}>{o.Status}</span>
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${o.PaymentStatus === 'paid' ? 'bg-emerald-100 text-emerald-800' : o.PaymentStatus === 'partial' ? 'bg-amber-100 text-amber-800' : 'bg-gray-100 text-gray-700'}`}>{o.PaymentStatus}</span>
              </div>
              <div className="text-xs text-gray-600 mt-0.5">
                {o.QuantityKg != null && `${o.QuantityKg} kg`}
                {o.PricePerKg != null && ` @ $${fmt$(o.PricePerKg)}/kg`}
                {o.TotalValue != null && ` = $${fmt$(o.TotalValue)}`}
                {o.OrderDate && ` · ${(o.OrderDate || '').slice(0,10)}`}
                {o.DeliveryDate && ` → deliver ${(o.DeliveryDate || '').slice(0,10)}`}
                {o.InvoiceNumber && ` · INV ${o.InvoiceNumber}`}
              </div>
            </div>
            <button onClick={() => setEdit(o)} className={btnGhost}>Edit</button>
            <button onClick={() => del(o.OrderID)} className="text-xs text-red-600 hover:underline">Delete</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// D2C Orders
// ─────────────────────────────────────────────────────────────────
function D2COrderForm({ order, onSave, onCancel }) {
  const [s, setS] = useState(order || {
    Channel: 'own_app', ExternalOrderID: '',
    CustomerName: '', CustomerPhone: '', DeliveryAddress: '',
    CropType: '', QuantityKg: '', TotalValue: '',
    OrderDate: new Date().toISOString().slice(0,16),
    DeliverySLAMinutes: 30, Status: 'placed',
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Channel</label>
          <select className={inp} value={s.Channel} onChange={set('Channel')}>
            {D2C_CHANNELS.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Channel order #</label><input className={inp} value={s.ExternalOrderID || ''} onChange={set('ExternalOrderID')} placeholder="reference from Zepto / Swiggy / etc." /></div>
        <div><label className={lbl}>Status</label>
          <select className={inp} value={s.Status} onChange={set('Status')}>
            {D2C_STATUSES.map(x => <option key={x}>{x}</option>)}
          </select></div>
        <div><label className={lbl}>Customer name</label><input className={inp} value={s.CustomerName || ''} onChange={set('CustomerName')} /></div>
        <div><label className={lbl}>Customer phone</label><input className={inp} value={s.CustomerPhone || ''} onChange={set('CustomerPhone')} /></div>
        <div><label className={lbl}>Delivery SLA (min)</label><input className={inp} type="number" value={s.DeliverySLAMinutes ?? ''} onChange={setNum('DeliverySLAMinutes')} /></div>
        <div className="md:col-span-3"><label className={lbl}>Delivery address</label><input className={inp} value={s.DeliveryAddress || ''} onChange={set('DeliveryAddress')} /></div>
        <div><label className={lbl}>Crop</label><input className={inp} value={s.CropType || ''} onChange={set('CropType')} /></div>
        <div><label className={lbl}>Qty (kg)</label><input className={inp} type="number" step="0.01" value={s.QuantityKg ?? ''} onChange={setNum('QuantityKg')} /></div>
        <div><label className={lbl}>Total ($)</label><input className={inp} type="number" step="0.01" value={s.TotalValue ?? ''} onChange={setNum('TotalValue')} /></div>
        <div><label className={lbl}>Order time</label><input className={inp} type="datetime-local" value={(s.OrderDate || '').slice(0,16)} onChange={set('OrderDate')} /></div>
      </div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} className={btn}>Save</button>
      </div>
    </div>
  );
}

function D2COrdersTab({ businessId }) {
  const [list, setList]    = useState([]);
  const [editing, setEdit] = useState(null);
  const [adding, setAdd]   = useState(false);
  const [channelF, setCh]  = useState('');

  const refresh = () => {
    const qs = channelF ? `?channel=${channelF}` : '';
    fetch(`${API}/api/aggregator/${businessId}/d2c/orders${qs}`).then(r => r.json()).then(setList);
  };
  useEffect(refresh, [businessId, channelF]);

  const save = async (o) => {
    const isEdit = !!o.OrderID;
    const url = isEdit ? `${API}/api/aggregator/d2c/orders/${o.OrderID}` : `${API}/api/aggregator/${businessId}/d2c/orders`;
    const r = await fetch(url, { method: isEdit ? 'PUT' : 'POST',
                                 headers: { 'Content-Type': 'application/json' },
                                 body: JSON.stringify(o) });
    if (r.ok) { setEdit(null); setAdd(false); refresh(); } else alert('Save failed');
  };
  const del = async (id) => {
    if (!window.confirm('Delete this order?')) return;
    await fetch(`${API}/api/aggregator/d2c/orders/${id}`, { method: 'DELETE' });
    refresh();
  };

  // Channel breakdown summary (computed locally over filtered list)
  const byChannel = list.reduce((acc, r) => {
    const ch = r.Channel || 'other';
    if (!acc[ch]) acc[ch] = { count: 0, revenue: 0 };
    acc[ch].count   += 1;
    acc[ch].revenue += Number(r.TotalValue || 0);
    return acc;
  }, {});

  const statusColor = (st) => st === 'delivered' ? 'bg-emerald-100 text-emerald-800'
                          : st === 'out_for_delivery' ? 'bg-blue-100 text-blue-800'
                          : st === 'refunded' ? 'bg-red-100 text-red-800'
                          : 'bg-gray-100 text-gray-700';

  return (
    <div className="space-y-3">
      {Object.keys(byChannel).length > 0 && (
        <div className="bg-white border border-gray-200 rounded-xl p-3">
          <div className="text-[10px] uppercase text-gray-500 font-semibold mb-2">By channel (filtered)</div>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-2">
            {Object.entries(byChannel).map(([ch, v]) => (
              <div key={ch} className="border border-gray-100 rounded-lg p-2 text-xs">
                <div className="font-semibold text-gray-700">{CHANNEL_ICON[ch] || '🔗'} {ch}</div>
                <div className="text-gray-500">{v.count} · ${fmt$(v.revenue)}</div>
              </div>
            ))}
          </div>
        </div>
      )}

      <div className="flex items-center gap-3 flex-wrap">
        <select className={inp + ' max-w-xs'} value={channelF} onChange={e => setCh(e.target.value)}>
          <option value="">All channels</option>
          {D2C_CHANNELS.map(c => <option key={c}>{c}</option>)}
        </select>
        <span className="text-sm text-gray-500">{list.length} order{list.length === 1 ? '' : 's'}</span>
        <div className="flex-1" />
        <button onClick={() => setAdd(true)} className={btn}>+ Record D2C order</button>
      </div>
      {adding && <D2COrderForm onSave={save} onCancel={() => setAdd(false)} />}
      {list.length === 0 && <div className="text-sm text-gray-500 italic">No D2C orders yet. Wire up your storefront and instant-commerce channels here.</div>}

      <div className="space-y-2">
        {list.map(o => editing?.OrderID === o.OrderID ? (
          <D2COrderForm key={o.OrderID} order={editing} onSave={save} onCancel={() => setEdit(null)} />
        ) : (
          <div key={o.OrderID} className="bg-white border border-gray-200 rounded-xl p-3 flex items-start gap-3">
            <div className="text-2xl shrink-0">{CHANNEL_ICON[o.Channel] || '🔗'}</div>
            <div className="flex-1 min-w-0">
              <div className="flex items-center gap-2 flex-wrap">
                <strong className="text-gray-900">{o.Channel}</strong>
                {o.ExternalOrderID && <span className="text-xs text-gray-500">#{o.ExternalOrderID}</span>}
                {o.CustomerName && <span className="text-sm text-gray-700">— {o.CustomerName}</span>}
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-semibold uppercase ${statusColor(o.Status)}`}>{o.Status}</span>
              </div>
              <div className="text-xs text-gray-600 mt-0.5">
                {o.CropType && `${o.CropType} · `}
                {o.QuantityKg != null && `${o.QuantityKg} kg · `}
                {o.TotalValue != null && `$${fmt$(o.TotalValue)}`}
                {o.DeliverySLAMinutes != null && ` · SLA ${o.DeliverySLAMinutes}m`}
              </div>
              {o.DeliveryAddress && <div className="text-xs text-gray-500 mt-0.5">📍 {o.DeliveryAddress}</div>}
            </div>
            <button onClick={() => setEdit(o)} className={btnGhost}>Edit</button>
            <button onClick={() => del(o.OrderID)} className="text-xs text-red-600 hover:underline">Delete</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────────
// Page
// ─────────────────────────────────────────────────────────────────
const TABS = [
  { key: 'b2b_accounts', label: 'B2B Accounts' },
  { key: 'b2b_orders',   label: 'B2B Orders'   },
  { key: 'd2c',          label: 'D2C Orders'   },
];

export default function AggregatorSales() {
  const [params] = useSearchParams();
  const { BusinessID: ctxBID } = useAccount();
  const BusinessID = params.get('BusinessID') || ctxBID;
  const [tab, setTab] = useState('b2b_accounts');
  const [accounts, setAccounts] = useState([]);
  useEffect(() => {
    if (!BusinessID) return;
    fetch(`${API}/api/aggregator/${BusinessID}/b2b/accounts`).then(r => r.json()).then(setAccounts);
  }, [BusinessID, tab]);

  if (!BusinessID) {
    return (
      <AccountLayout pageTitle="Sales">
        <div className="p-6 text-sm text-gray-500">Pick a business from the account picker.</div>
      </AccountLayout>
    );
  }

  return (
    <AccountLayout
      pageTitle="Sales"
      breadcrumbs={[
        { label: 'Account', to: '/account' },
        { label: 'Food Aggregation', to: `/aggregator?BusinessID=${BusinessID}` },
        { label: 'Sales' },
      ]}
    >
      <div className="max-w-6xl mx-auto p-5 space-y-4">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">Sales</h1>
            <p className="text-sm text-gray-500 mt-1">B2B accounts (retail chains, distributors, restaurants), B2B orders against them, and D2C orders across your own app and instant-commerce channels.</p>
          </div>
          <Link to={`/aggregator?BusinessID=${BusinessID}`} className={btnGhost}>← Hub</Link>
        </div>

        <div className="border-b border-gray-200">
          <div className="flex gap-1">
            {TABS.map(t => (
              <button key={t.key}
                      onClick={() => setTab(t.key)}
                      className={`px-4 py-2 text-sm font-medium ${tab === t.key
                        ? 'border-b-2 border-[#3D6B34] text-[#3D6B34]'
                        : 'text-gray-500 hover:text-gray-700'}`}>
                {t.label}
              </button>
            ))}
          </div>
        </div>

        {tab === 'b2b_accounts' && <B2BAccountsTab businessId={BusinessID} />}
        {tab === 'b2b_orders'   && <B2BOrdersTab businessId={BusinessID} accounts={accounts} />}
        {tab === 'd2c'          && <D2COrdersTab businessId={BusinessID} />}
      </div>
    </AccountLayout>
  );
}
