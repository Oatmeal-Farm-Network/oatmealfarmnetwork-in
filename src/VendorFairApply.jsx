import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import { useAccount } from './AccountContext';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";
const btnGhost = "px-4 py-1.5 text-sm border border-gray-300 rounded-lg";

const BOOTH_SIZES = ['Small', 'Medium', 'Large'];

function ApplyForm({ cfg, initial, onSave, onCancel, saving }) {
  const [form, setForm] = useState({
    BusinessName: '', ContactName: '', ContactEmail: '', ContactPhone: '',
    BoothSize: 'Medium', ProductCategories: '', Description: '', WebsiteURL: '',
    NeedsElectricity: false, NeedsTable: false, RequestedLocation: '', ...initial,
  });
  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));

  const fee = (() => {
    const size = (form.BoothSize || 'Medium').toLowerCase();
    let base = 0;
    if (size === 'small') base = Number(cfg?.BoothFeeSmall || 0);
    else if (size === 'large') base = Number(cfg?.BoothFeeLarge || cfg?.BoothFeeMedium || 0);
    else base = Number(cfg?.BoothFeeMedium || cfg?.BoothFeeSmall || 0);
    return base
      + (form.NeedsElectricity ? Number(cfg?.ElectricityFee || 0) : 0)
      + (form.NeedsTable ? Number(cfg?.TableFee || 0) : 0);
  })();

  return (
    <form onSubmit={(e) => { e.preventDefault(); onSave(form); }}
      className="bg-gray-50 border border-gray-200 rounded-lg p-4 space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <div><label className={lbl}>Business name *</label>
          <input required value={form.BusinessName} onChange={set('BusinessName')} className={inp} /></div>
        <div><label className={lbl}>Website (optional)</label>
          <input value={form.WebsiteURL} onChange={set('WebsiteURL')} className={inp} placeholder="https://" /></div>
        <div><label className={lbl}>Contact name</label>
          <input value={form.ContactName} onChange={set('ContactName')} className={inp} /></div>
        <div><label className={lbl}>Contact email</label>
          <input type="email" value={form.ContactEmail} onChange={set('ContactEmail')} className={inp} /></div>
        <div><label className={lbl}>Contact phone</label>
          <input value={form.ContactPhone} onChange={set('ContactPhone')} className={inp} /></div>
        <div><label className={lbl}>Booth size</label>
          <select value={form.BoothSize} onChange={set('BoothSize')} className={inp}>
            {BOOTH_SIZES.map(s => <option key={s} value={s}>{s}</option>)}
          </select></div>
      </div>
      <div><label className={lbl}>Product categories</label>
        <input value={form.ProductCategories} onChange={set('ProductCategories')} className={inp}
          placeholder="Yarn, Fiber, Alpaca Products, Jewelry…" /></div>
      <div><label className={lbl}>Description</label>
        <RichTextEditor value={form.Description || ''}
          onChange={(v) => setForm(f => ({ ...f, Description: v }))} minHeight={150} />
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" checked={form.NeedsElectricity}
            onChange={(e) => setForm(f => ({ ...f, NeedsElectricity: e.target.checked }))} />
          Need electricity (+${Number(cfg?.ElectricityFee || 0).toFixed(2)})
        </label>
        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" checked={form.NeedsTable}
            onChange={(e) => setForm(f => ({ ...f, NeedsTable: e.target.checked }))} />
          Need table rental (+${Number(cfg?.TableFee || 0).toFixed(2)})
        </label>
        <div><label className={lbl}>Requested location (optional)</label>
          <input value={form.RequestedLocation} onChange={set('RequestedLocation')} className={inp}
            placeholder="Corner spot, near entrance, by spinning demo…" /></div>
      </div>
      <div className="flex justify-between items-center flex-wrap gap-3">
        <div className="flex gap-2">
          <button type="submit" disabled={saving} className={btn}>
            {saving ? 'Submitting…' : 'Submit Application'}
          </button>
          <button type="button" onClick={onCancel} className={btnGhost}>Cancel</button>
        </div>
        <div className="text-sm">Estimated booth fee: <span className="font-bold text-[#3D6B34]">${fee.toFixed(2)}</span></div>
      </div>
    </form>
  );
}

export default function VendorFairApply() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const { BusinessID: ctxBusinessID, Business } = useAccount() || {};
  const BusinessID = params.get('BusinessID') || ctxBusinessID;
  const peopleId = Number(localStorage.getItem('people_id')) || null;

  const [event, setEvent] = useState(null);
  const [cfg, setCfg] = useState(null);
  const [apps, setApps] = useState([]);
  const [adding, setAdding] = useState(false);
  const [saving, setSaving] = useState(false);
  const [err, setErr] = useState('');

  const load = () => peopleId
    ? fetch(`${API}/api/events/${eventId}/vendor-fair/applications?people_id=${peopleId}`)
        .then(r => r.json()).then(setApps).catch(() => {})
    : Promise.resolve();

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent);
    fetch(`${API}/api/events/${eventId}/vendor-fair/config`).then(r => r.json()).then(setCfg);
    load();
  }, [eventId, peopleId]);

  const apply = async (form) => {
    setErr(''); setSaving(true);
    try {
      const r = await fetch(`${API}/api/events/${eventId}/vendor-fair/applications`, {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form,
          PeopleID: peopleId,
          BusinessID: BusinessID ? Number(BusinessID) : null,
        }),
      });
      if (!r.ok) { const j = await r.json().catch(() => ({})); throw new Error(j.detail || 'Apply failed'); }
      setAdding(false); load();
    } catch (ex) { setErr(ex.message); }
    finally { setSaving(false); }
  };

  const withdraw = async (a) => {
    if (!confirm(`Withdraw application for ${a.BusinessName}?`)) return;
    await fetch(`${API}/api/events/vendor-fair/applications/${a.AppID}`, { method: 'DELETE' });
    load();
  };

  const configured = cfg?.configured;
  const closed = configured && cfg?.ApplicationEndDate && new Date(cfg.ApplicationEndDate) < new Date();

  const initialFormValues = Business ? {
    BusinessName: Business.BusinessName || '',
    WebsiteURL: Business.WebsiteURL || '',
  } : {};

  return (
    <div className="max-w-4xl mx-auto px-4 py-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Vendor Application</h1>
          <p className="text-sm text-gray-500 mt-1">
            {event?.EventName || 'Event'}
            {event?.EventLocationCity && ` — ${event.EventLocationCity}, ${event.EventLocationState}`}
          </p>
        </div>
        <Link to={`/events/${eventId}`} className="text-sm text-gray-500 hover:text-gray-700">← Back to Event</Link>
      </div>

      {!configured && (
        <div className="bg-yellow-50 border border-yellow-200 text-yellow-800 text-sm rounded-lg p-4 mb-4">
          The vendor fair has not yet been set up by the organizer.
        </div>
      )}

      {configured && cfg.Description && (
        <div className="bg-white border border-gray-200 rounded-xl p-4 mb-4 whitespace-pre-wrap text-sm text-gray-700">
          {cfg.Description}
        </div>
      )}

      {configured && (
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 mb-4 text-xs">
          {cfg.BoothFeeSmall > 0 && (
            <div className="bg-white border border-gray-200 rounded-lg p-3">
              <div className="text-gray-500">Small booth</div>
              <div className="font-semibold text-gray-900 text-base">${Number(cfg.BoothFeeSmall).toFixed(2)}</div>
            </div>
          )}
          {cfg.BoothFeeMedium > 0 && (
            <div className="bg-white border border-gray-200 rounded-lg p-3">
              <div className="text-gray-500">Medium booth</div>
              <div className="font-semibold text-gray-900 text-base">${Number(cfg.BoothFeeMedium).toFixed(2)}</div>
            </div>
          )}
          {cfg.BoothFeeLarge > 0 && (
            <div className="bg-white border border-gray-200 rounded-lg p-3">
              <div className="text-gray-500">Large booth</div>
              <div className="font-semibold text-gray-900 text-base">${Number(cfg.BoothFeeLarge).toFixed(2)}</div>
            </div>
          )}
          {cfg.ApplicationEndDate && (
            <div className="bg-white border border-gray-200 rounded-lg p-3">
              <div className="text-gray-500">Applications close</div>
              <div className="font-semibold text-gray-900 text-base">{String(cfg.ApplicationEndDate).substring(0, 10)}</div>
            </div>
          )}
        </div>
      )}

      {closed && (
        <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">
          Applications for this vendor fair have closed.
        </div>
      )}

      {err && <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">{err}</div>}

      {!peopleId && (
        <div className="bg-yellow-50 border border-yellow-200 text-yellow-800 text-sm rounded-lg p-3 mb-3">
          Please <Link to="/login" className="underline">log in</Link> to apply as a vendor.
        </div>
      )}

      <div className="flex justify-between items-center mb-3">
        <h2 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Your applications ({apps.length})</h2>
        {!adding && !closed && peopleId && configured && (
          <button onClick={() => setAdding(true)} className={btn}>+ Apply</button>
        )}
      </div>

      {adding && (
        <ApplyForm cfg={cfg} initial={initialFormValues} saving={saving}
          onSave={apply} onCancel={() => setAdding(false)} />
      )}

      <div className="space-y-2 mt-3">
        {apps.length === 0 && !adding && peopleId && (
          <div className="text-sm text-gray-500">You haven't applied yet.</div>
        )}
        {apps.map(a => (
          <div key={a.AppID} className="bg-white border border-gray-200 rounded-lg p-3">
            <div className="flex items-start justify-between gap-3">
              <div className="flex-1">
                <div className="flex items-center gap-2 flex-wrap">
                  <span className="font-medium">{a.BusinessName}</span>
                  <span className="text-[11px] px-2 py-0.5 rounded bg-blue-100 text-blue-700">{a.BoothSize}</span>
                  <span className={`text-[11px] px-2 py-0.5 rounded ${
                    a.Status === 'approved' ? 'bg-green-100 text-green-700'
                    : a.Status === 'rejected' ? 'bg-red-100 text-red-700'
                    : 'bg-yellow-100 text-yellow-700'}`}>{a.Status}</span>
                  {a.BoothNumber && <span className="text-xs font-mono bg-gray-100 px-2 py-0.5 rounded">booth {a.BoothNumber}</span>}
                </div>
                {a.ProductCategories && <div className="text-xs text-gray-600 mt-1">{a.ProductCategories}</div>}
                {a.OrganizerNotes && (
                  <div className="text-xs italic text-gray-500 mt-1">Organizer: {a.OrganizerNotes}</div>
                )}
              </div>
              <div className="text-right">
                <div className="text-sm font-bold">${Number(a.Fee || 0).toFixed(2)}</div>
                <div className={`text-[11px] px-2 py-0.5 rounded ${a.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                  {a.PaidStatus}
                </div>
                {a.Status === 'pending' && !closed && (
                  <button onClick={() => withdraw(a)} className="text-xs text-red-500 hover:text-red-700 mt-1">Withdraw</button>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
