import React, { useEffect, useMemo, useState } from 'react';
import { useParams, useSearchParams, Link, useNavigate } from 'react-router-dom';
import { useAccount } from './AccountContext';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import AnimalPickerStep from './AnimalPickerStep';
import WizardPayStep from './WizardPayStep';
import WizardAttendeesStep from './WizardAttendeesStep';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#3D6B34]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

// Maps EventFeatures FeatureKey → wizard step
const FEATURE_STEPS = {
  halter_module:     { key: 'halter',     label: 'Halter Classes' },
  fleece_module:     { key: 'fleece',     label: 'Fleece Entries' },
  spinoff_module:    { key: 'spinoff',    label: 'Spin-Off Entries' },
  fiber_arts_module: { key: 'fiber_arts', label: 'Fiber Arts Entries' },
  vendor_fair_module:{ key: 'vendor',     label: 'Vendor Stall' },
};

function formatDate(d) {
  if (!d) return '';
  return new Date(d).toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
}

function StepHeader({ stepIndex, steps }) {
  return (
    <div className="flex items-center gap-1 mb-6 text-xs overflow-x-auto">
      {steps.map((s, i) => (
        <React.Fragment key={s.key}>
          <div className={`flex items-center gap-1.5 whitespace-nowrap ${i === stepIndex ? 'text-[#3D6B34] font-semibold' : i < stepIndex ? 'text-green-700' : 'text-gray-400'}`}>
            <div className={`w-6 h-6 rounded-full flex items-center justify-center text-[11px] font-bold border-2 ${
              i < stepIndex ? 'bg-green-600 border-green-600 text-white'
              : i === stepIndex ? 'border-[#3D6B34] text-[#3D6B34]'
              : 'border-gray-300 text-gray-400'
            }`}>{i < stepIndex ? '✓' : i + 1}</div>
            <span className="hidden sm:inline">{s.label}</span>
          </div>
          {i < steps.length - 1 && <div className={`h-px flex-1 min-w-[12px] ${i < stepIndex ? 'bg-green-300' : 'bg-gray-200'}`} />}
        </React.Fragment>
      ))}
    </div>
  );
}

function InfoStep({ form, setForm, onNext }) {
  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  const ready = form.AttendeeFirstName && form.AttendeeLastName && form.AttendeeEmail;
  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Your Information</h2>
      <p className="text-xs text-gray-500 mb-5">We use this for registration confirmations and on-site check-in.</p>
      <div className="grid grid-cols-2 gap-3 mb-3">
        <div><label className={lbl}>First Name</label>
          <input value={form.AttendeeFirstName} onChange={set('AttendeeFirstName')} className={inp} /></div>
        <div><label className={lbl}>Last Name</label>
          <input value={form.AttendeeLastName} onChange={set('AttendeeLastName')} className={inp} /></div>
      </div>
      <div className="grid grid-cols-2 gap-3 mb-3">
        <div><label className={lbl}>Email</label>
          <input type="email" value={form.AttendeeEmail} onChange={set('AttendeeEmail')} className={inp} /></div>
        <div><label className={lbl}>Phone <span className="text-gray-400 font-normal">(Optional)</span></label>
          <input value={form.AttendeePhone} onChange={set('AttendeePhone')} className={inp} /></div>
      </div>
      <div className="flex justify-end mt-5">
        <button disabled={!ready} onClick={onNext}
          className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226] disabled:opacity-50">
          Continue →
        </button>
      </div>
    </div>
  );
}

function HalterStep({ eventId, cartId, pickedAnimals, entries, setEntries, onNext, onBack, businessId, peopleId }) {
  const [classes, setClasses] = useState([]);
  const [cfg, setCfg] = useState(null);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/halter/classes`).then(r => r.json()).then(setClasses).catch(() => setClasses([]));
    fetch(`${API}/api/events/${eventId}/halter/config`).then(r => r.json()).then(setCfg).catch(() => {});
  }, [eventId]);

  const entryForAnimal = (animalId) => entries.find(e => e.AnimalID === animalId) || { AnimalID: animalId, ClassIDs: [] };
  const toggleClass = (animalId, classId) => {
    setEntries(prev => {
      const existing = prev.find(e => e.AnimalID === animalId);
      if (existing) {
        const has = existing.ClassIDs.includes(classId);
        const next = { ...existing, ClassIDs: has ? existing.ClassIDs.filter(x => x !== classId) : [...existing.ClassIDs, classId] };
        return prev.map(e => e.AnimalID === animalId ? next : e);
      }
      return [...prev, { AnimalID: animalId, ClassIDs: [classId] }];
    });
  };

  const feePerClass = Number(cfg?.CurrentFee || cfg?.FeePerClass || 0);
  const totalClasses = entries.reduce((s, e) => s + e.ClassIDs.length, 0);

  if (!pickedAnimals.length) {
    return (
      <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
        <h2 className="font-bold text-gray-800 mb-1">Halter Classes</h2>
        <p className="text-sm text-gray-500 mb-4">Go back and pick at least one animal to enter in halter classes, or skip this step.</p>
        <div className="flex justify-between">
          <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
          <button onClick={onNext} className="px-5 py-2.5 rounded-xl border border-gray-300 text-sm text-gray-600 hover:bg-gray-50">Skip halter →</button>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Halter Classes</h2>
      <p className="text-xs text-gray-500 mb-4">Select classes for each animal. Fee: ${feePerClass.toFixed(2)} per class.</p>

      {classes.length === 0 && <div className="text-sm text-gray-500">No halter classes defined yet.</div>}

      {pickedAnimals.map(a => {
        const e = entryForAnimal(a.ID ?? a.AnimalID);
        const aid = a.ID ?? a.AnimalID;
        return (
          <div key={aid} className="border border-gray-200 rounded-xl p-4 mb-3">
            <div className="font-semibold text-gray-800 mb-2">{a.FullName || a.AnimalName}</div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-1">
              {classes.map(c => (
                <label key={c.ClassID} className="flex items-center gap-2 text-sm py-1">
                  <input type="checkbox" checked={e.ClassIDs.includes(c.ClassID)}
                    onChange={() => toggleClass(aid, c.ClassID)} className="accent-green-600" />
                  <span>{c.ClassName}{c.Description && <span className="text-gray-400"> — {c.Description}</span>}</span>
                </label>
              ))}
            </div>
          </div>
        );
      })}

      <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100 text-sm">
        <div className="text-gray-600">{totalClasses} class entries × ${feePerClass.toFixed(2)}</div>
        <div className="font-bold text-[#3D6B34]">${(totalClasses * feePerClass).toFixed(2)}</div>
      </div>

      <div className="flex justify-between mt-5">
        <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
        <button onClick={onNext} className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226]">Continue →</button>
      </div>
    </div>
  );
}

function FleeceStep({ eventId, entries, setEntries, onNext, onBack, pickedAnimals }) {
  const [cfg, setCfg] = useState(null);
  const [divisions, setDivisions] = useState([]);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/fleece/config`).then(r => r.json()).then(setCfg).catch(() => {});
    fetch(`${API}/api/events/${eventId}/fleece/divisions`).then(r => r.ok ? r.json() : []).then(d => setDivisions(Array.isArray(d) ? d : [])).catch(() => {});
  }, [eventId]);

  const add = () => setEntries([...entries, { FleeceName: '', Breed: '', Color: '', SourceAnimalID: '', DivisionID: '', Description: '' }]);
  const upd = (i, k, v) => setEntries(entries.map((e, idx) => idx === i ? { ...e, [k]: v } : e));
  const remove = (i) => setEntries(entries.filter((_, idx) => idx !== i));

  const fee = Number(cfg?.CurrentFee || cfg?.FeePerFleece || 0);

  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Fleece Entries</h2>
      <p className="text-xs text-gray-500 mb-4">One row per fleece. Fee: ${fee.toFixed(2)} per fleece.</p>

      {entries.map((e, i) => (
        <div key={i} className="border border-gray-200 rounded-xl p-4 mb-3 space-y-2">
          <div className="flex items-center justify-between">
            <div className="font-semibold text-gray-700 text-sm">Fleece #{i + 1}</div>
            <button onClick={() => remove(i)} className="text-xs text-red-500 hover:text-red-700">Remove</button>
          </div>
          <div className="grid grid-cols-2 gap-2">
            <div><label className={lbl}>Fleece name</label>
              <input className={inp} value={e.FleeceName} onChange={ev => upd(i, 'FleeceName', ev.target.value)} /></div>
            <div><label className={lbl}>Source animal (optional)</label>
              <select className={inp} value={e.SourceAnimalID} onChange={ev => upd(i, 'SourceAnimalID', ev.target.value)}>
                <option value="">— none —</option>
                {pickedAnimals.map(a => <option key={a.ID ?? a.AnimalID} value={a.ID ?? a.AnimalID}>{a.FullName || a.AnimalName}</option>)}
              </select>
            </div>
          </div>
          <div className="grid grid-cols-3 gap-2">
            <div><label className={lbl}>Breed</label><input className={inp} value={e.Breed} onChange={ev => upd(i, 'Breed', ev.target.value)} /></div>
            <div><label className={lbl}>Color</label><input className={inp} value={e.Color} onChange={ev => upd(i, 'Color', ev.target.value)} /></div>
            {divisions.length > 0 && (
              <div><label className={lbl}>Division</label>
                <select className={inp} value={e.DivisionID} onChange={ev => upd(i, 'DivisionID', ev.target.value)}>
                  <option value="">— none —</option>
                  {divisions.map(d => <option key={d.DivisionID} value={d.DivisionID}>{d.DivisionName}</option>)}
                </select>
              </div>
            )}
          </div>
        </div>
      ))}

      <button onClick={add} className="text-sm text-[#3D6B34] border border-[#3D6B34] rounded-lg px-3 py-1.5 hover:bg-green-50">+ Add fleece</button>

      <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100 text-sm">
        <div className="text-gray-600">{entries.length} fleeces × ${fee.toFixed(2)}</div>
        <div className="font-bold text-[#3D6B34]">${(entries.length * fee).toFixed(2)}</div>
      </div>

      <div className="flex justify-between mt-5">
        <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
        <button onClick={onNext} className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226]">Continue →</button>
      </div>
    </div>
  );
}

function SpinOffStep({ eventId, entries, setEntries, onNext, onBack, pickedAnimals }) {
  const [cfg, setCfg] = useState(null);
  const [categories, setCategories] = useState([]);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/spinoff/config`).then(r => r.json()).then(setCfg).catch(() => {});
    fetch(`${API}/api/events/${eventId}/spinoff/categories`).then(r => r.ok ? r.json() : []).then(c => setCategories(Array.isArray(c) ? c : [])).catch(() => {});
  }, [eventId]);

  const add = () => setEntries([...entries, { EntryTitle: '', SpinnerName: '', FiberType: '', FiberSource: '', SourceAnimalID: '', CategoryID: '', Description: '' }]);
  const upd = (i, k, v) => setEntries(entries.map((e, idx) => idx === i ? { ...e, [k]: v } : e));
  const remove = (i) => setEntries(entries.filter((_, idx) => idx !== i));
  const fee = Number(cfg?.CurrentFee || cfg?.FeePerEntry || 0);

  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Spin-Off Entries</h2>
      <p className="text-xs text-gray-500 mb-4">Fee: ${fee.toFixed(2)} per entry.</p>

      {entries.map((e, i) => (
        <div key={i} className="border border-gray-200 rounded-xl p-4 mb-3 space-y-2">
          <div className="flex items-center justify-between">
            <div className="font-semibold text-gray-700 text-sm">Entry #{i + 1}</div>
            <button onClick={() => remove(i)} className="text-xs text-red-500 hover:text-red-700">Remove</button>
          </div>
          <div><label className={lbl}>Entry title</label>
            <input className={inp} value={e.EntryTitle} onChange={ev => upd(i, 'EntryTitle', ev.target.value)} /></div>
          <div className="grid grid-cols-2 gap-2">
            <div><label className={lbl}>Spinner name</label>
              <input className={inp} value={e.SpinnerName} onChange={ev => upd(i, 'SpinnerName', ev.target.value)} /></div>
            <div><label className={lbl}>Fiber type</label>
              <input className={inp} value={e.FiberType} onChange={ev => upd(i, 'FiberType', ev.target.value)} /></div>
          </div>
          {categories.length > 0 && (
            <div><label className={lbl}>Category</label>
              <select className={inp} value={e.CategoryID} onChange={ev => upd(i, 'CategoryID', ev.target.value)}>
                <option value="">— none —</option>
                {categories.map(c => <option key={c.CategoryID} value={c.CategoryID}>{c.CategoryName}</option>)}
              </select>
            </div>
          )}
        </div>
      ))}

      <button onClick={add} className="text-sm text-[#3D6B34] border border-[#3D6B34] rounded-lg px-3 py-1.5 hover:bg-green-50">+ Add entry</button>

      <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100 text-sm">
        <div className="text-gray-600">{entries.length} entries × ${fee.toFixed(2)}</div>
        <div className="font-bold text-[#3D6B34]">${(entries.length * fee).toFixed(2)}</div>
      </div>

      <div className="flex justify-between mt-5">
        <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
        <button onClick={onNext} className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226]">Continue →</button>
      </div>
    </div>
  );
}

function FiberArtsStep({ eventId, entries, setEntries, onNext, onBack }) {
  const [cfg, setCfg] = useState(null);
  const [cats, setCats] = useState([]);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/fiber-arts/config`).then(r => r.json()).then(setCfg).catch(() => {});
    fetch(`${API}/api/events/${eventId}/fiber-arts/categories`).then(r => r.ok ? r.json() : []).then(c => setCats(Array.isArray(c) ? c : [])).catch(() => {});
  }, [eventId]);

  const add = () => setEntries([...entries, { EntryTitle: '', CategoryID: '', Description: '' }]);
  const upd = (i, k, v) => setEntries(entries.map((e, idx) => idx === i ? { ...e, [k]: v } : e));
  const remove = (i) => setEntries(entries.filter((_, idx) => idx !== i));
  const fee = Number(cfg?.CurrentFee || cfg?.FeePerEntry || 0);

  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Fiber Arts Entries</h2>
      <p className="text-xs text-gray-500 mb-4">Fee: ${fee.toFixed(2)} per entry.</p>

      {entries.map((e, i) => (
        <div key={i} className="border border-gray-200 rounded-xl p-4 mb-3 space-y-2">
          <div className="flex items-center justify-between">
            <div className="font-semibold text-gray-700 text-sm">Entry #{i + 1}</div>
            <button onClick={() => remove(i)} className="text-xs text-red-500 hover:text-red-700">Remove</button>
          </div>
          <div><label className={lbl}>Entry title</label>
            <input className={inp} value={e.EntryTitle} onChange={ev => upd(i, 'EntryTitle', ev.target.value)} /></div>
          {cats.length > 0 && (
            <div><label className={lbl}>Category</label>
              <select className={inp} value={e.CategoryID} onChange={ev => upd(i, 'CategoryID', ev.target.value)}>
                <option value="">— none —</option>
                {cats.map(c => <option key={c.CategoryID} value={c.CategoryID}>{c.CategoryName}</option>)}
              </select>
            </div>
          )}
        </div>
      ))}

      <button onClick={add} className="text-sm text-[#3D6B34] border border-[#3D6B34] rounded-lg px-3 py-1.5 hover:bg-green-50">+ Add entry</button>

      <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100 text-sm">
        <div className="text-gray-600">{entries.length} entries × ${fee.toFixed(2)}</div>
        <div className="font-bold text-[#3D6B34]">${(entries.length * fee).toFixed(2)}</div>
      </div>

      <div className="flex justify-between mt-5">
        <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
        <button onClick={onNext} className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226]">Continue →</button>
      </div>
    </div>
  );
}

function VendorStep({ eventId, booth, setBooth, onNext, onBack }) {
  const [cfg, setCfg] = useState(null);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/vendor-fair/config`).then(r => r.json()).then(setCfg).catch(() => {});
  }, [eventId]);
  const fee = Number(cfg?.BoothFee || 0);
  const set = (k) => (e) => setBooth({ ...booth, [k]: e.target.value });
  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Vendor Stall</h2>
      <p className="text-xs text-gray-500 mb-4">Booth fee: ${fee.toFixed(2)}. Leave blank to skip.</p>
      <label className="flex items-center gap-2 text-sm mb-3">
        <input type="checkbox" checked={!!booth.include} onChange={e => setBooth({ ...booth, include: e.target.checked })} className="accent-green-600" />
        I want a vendor stall at this event
      </label>
      {booth.include && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
          <div><label className={lbl}>Business / stall name</label>
            <input className={inp} value={booth.BusinessName || ''} onChange={set('BusinessName')} /></div>
          <div><label className={lbl}>Products you'll sell</label>
            <input className={inp} value={booth.Products || ''} onChange={set('Products')} /></div>
          <div className="md:col-span-2"><label className={lbl}>Special requests</label>
            <textarea rows={2} className={inp} value={booth.Notes || ''} onChange={set('Notes')} /></div>
        </div>
      )}
      <div className="flex justify-between mt-5">
        <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
        <button onClick={onNext} className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226]">Continue →</button>
      </div>
    </div>
  );
}

function MealsStep({ eventId, sessions, selections, setSelections, onNext, onBack }) {
  const setQty = (sid, qty) => setSelections({ ...selections, [sid]: { ...selections[sid], Quantity: Math.max(0, qty) } });
  const setDiet = (sid, diet) => setSelections({ ...selections, [sid]: { ...selections[sid], DietaryNotes: diet } });
  const total = sessions.reduce((s, x) => s + (selections[x.SessionID]?.Quantity || 0) * Number(x.Price || 0), 0);

  if (sessions.length === 0) return null;

  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Meal Tickets</h2>
      <p className="text-xs text-gray-500 mb-4">Add meal sessions to your registration. Note dietary restrictions per session.</p>
      {sessions.map(s => {
        const sel = selections[s.SessionID] || { Quantity: 0, DietaryNotes: '' };
        const remaining = s.MaxTickets ? s.MaxTickets - (s.SoldCount || 0) : null;
        const soldOut = remaining !== null && remaining <= 0;
        return (
          <div key={s.SessionID} className="border border-gray-200 rounded-xl p-4 mb-3">
            <div className="flex items-start justify-between gap-4">
              <div className="flex-1">
                <div className="font-semibold text-gray-800">{s.SessionName}</div>
                <div className="text-xs text-gray-500">
                  {s.SessionDate && new Date(s.SessionDate).toLocaleDateString()}
                  {s.SessionTime && ` • ${s.SessionTime}`}
                </div>
                {s.Description && <div className="text-xs text-gray-600 mt-1">{s.Description}</div>}
                <div className="text-sm font-bold text-[#3D6B34] mt-1">${Number(s.Price || 0).toFixed(2)}</div>
                {remaining !== null && <div className="text-[11px] text-gray-400 mt-0.5">{soldOut ? 'Sold out' : `${remaining} left`}</div>}
              </div>
              <div className="flex items-center gap-2 shrink-0">
                <button disabled={soldOut} onClick={() => setQty(s.SessionID, (sel.Quantity || 0) - 1)}
                  className="w-7 h-7 rounded-full border border-gray-300 hover:bg-gray-50 disabled:opacity-40">−</button>
                <span className="w-6 text-center text-sm font-medium">{sel.Quantity || 0}</span>
                <button disabled={soldOut} onClick={() => setQty(s.SessionID, (sel.Quantity || 0) + 1)}
                  className="w-7 h-7 rounded-full border border-gray-300 hover:bg-gray-50 disabled:opacity-40">+</button>
              </div>
            </div>
            {(sel.Quantity || 0) > 0 && (
              <div className="mt-3">
                <label className={lbl}>Dietary notes for this session</label>
                <input className={inp} placeholder="Vegetarian, gluten-free, allergies…"
                  value={sel.DietaryNotes || ''} onChange={e => setDiet(s.SessionID, e.target.value)} />
              </div>
            )}
          </div>
        );
      })}
      <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100 text-sm">
        <div className="text-gray-600">Meals subtotal</div>
        <div className="font-bold text-[#3D6B34]">${total.toFixed(2)}</div>
      </div>
      <div className="flex justify-between mt-5">
        <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
        <button onClick={onNext} className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226]">Continue →</button>
      </div>
    </div>
  );
}

function ReviewStep({ cart, items, onBack, onPay, submitting }) {
  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="font-bold text-gray-800 mb-1">Review Your Registration</h2>
      <p className="text-xs text-gray-500 mb-4">Check everything before payment.</p>

      <div className="divide-y divide-gray-100 border border-gray-200 rounded-xl overflow-hidden mb-4">
        {items.length === 0 && <div className="px-4 py-6 text-sm text-center text-gray-400">No items yet.</div>}
        {items.map((it, i) => (
          <div key={i} className="flex items-center justify-between px-4 py-2 text-sm">
            <div>
              <span className="text-xs uppercase text-gray-400 mr-2">{it.FeatureKey}</span>
              <span className="font-medium">{it.Label}</span>
              {it.Quantity > 1 && <span className="text-gray-400 ml-1">× {it.Quantity}</span>}
            </div>
            <div className="font-semibold">${Number(it.LineAmount ?? (it.Quantity * it.UnitAmount)).toFixed(2)}</div>
          </div>
        ))}
        <div className="flex items-center justify-between px-4 py-2.5 bg-gray-50 text-sm">
          <span>Subtotal</span>
          <span className="font-semibold">${Number(cart?.Subtotal || 0).toFixed(2)}</span>
        </div>
        {Number(cart?.PlatformFeeAmount || 0) > 0 && (
          <div className="flex items-center justify-between px-4 py-2 bg-gray-50 text-xs text-gray-500">
            <span>Platform fee</span>
            <span>${Number(cart.PlatformFeeAmount).toFixed(2)}</span>
          </div>
        )}
        <div className="flex items-center justify-between px-4 py-3 bg-gray-100">
          <span className="font-bold">Total</span>
          <span className="font-bold text-lg text-[#3D6B34]">${Number(cart?.Total || 0).toFixed(2)}</span>
        </div>
      </div>

      <div className="flex justify-between">
        <button onClick={onBack} className="px-5 py-2.5 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">← Back</button>
        <button onClick={onPay} disabled={submitting}
          className="bg-[#3D6B34] text-white font-bold px-6 py-2.5 rounded-xl hover:bg-[#2d5226] disabled:opacity-50">
          {submitting ? 'Preparing…' : (Number(cart?.Total || 0) > 0 ? 'Continue to Payment →' : 'Complete Registration')}
        </button>
      </div>
    </div>
  );
}

export default function EventRegisterWizard() {
  const { eventId } = useParams();
  const [qs] = useSearchParams();
  const navigate = useNavigate();
  const { BusinessID: ctxBusinessID } = useAccount() || {};
  const BusinessID = qs.get('BusinessID') || ctxBusinessID;
  const peopleId = Number(localStorage.getItem('people_id')) || null;

  const [event, setEvent] = useState(null);
  const [features, setFeatures] = useState([]);
  const [mealSessions, setMealSessions] = useState([]);
  const [cart, setCart] = useState(null);  // server cart record
  const [items, setItems] = useState([]);  // server line items
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');

  const [form, setForm] = useState({
    AttendeeFirstName: '', AttendeeLastName: '', AttendeeEmail: '', AttendeePhone: '',
  });
  const [animals, setAnimals] = useState([]); // chosen animals (may include newly-created ones)
  const [halterEntries, setHalterEntries] = useState([]); // [{AnimalID, ClassIDs:[]}]
  const [fleeceEntries, setFleeceEntries] = useState([]);
  const [spinoffEntries, setSpinoffEntries] = useState([]);
  const [fiberEntries, setFiberEntries] = useState([]);
  const [vendor, setVendor] = useState({ include: false });
  const [mealSel, setMealSel] = useState({});

  useEffect(() => {
    Promise.all([
      fetch(`${API}/api/events/${eventId}`).then(r => r.json()),
      fetch(`${API}/api/events/${eventId}/features`).then(r => r.json()),
      fetch(`${API}/api/events/${eventId}/meals/sessions`).then(r => r.ok ? r.json() : []),
    ]).then(([ev, feats, meals]) => {
      setEvent(ev);
      setFeatures(feats?.features || []);
      setMealSessions(Array.isArray(meals) ? meals : []);
      setLoading(false);
    }).catch(e => { setError(e.message); setLoading(false); });
  }, [eventId]);

  // Prefill form from stored people profile
  useEffect(() => {
    if (!peopleId) return;
    fetch(`${API}/auth/people/${peopleId}`).then(r => r.ok ? r.json() : null).then(p => {
      if (!p) return;
      setForm(f => ({
        AttendeeFirstName: f.AttendeeFirstName || p.PeopleFirstName || '',
        AttendeeLastName:  f.AttendeeLastName  || p.PeopleLastName  || '',
        AttendeeEmail:     f.AttendeeEmail     || p.PeopleEmail     || '',
        AttendeePhone:     f.AttendeePhone     || p.PeoplePhone     || '',
      }));
    }).catch(() => {});
  }, [peopleId]);

  // Compute which feature steps exist based on event features
  const featureSteps = useMemo(() => {
    const keys = new Set((features || []).map(f => f.FeatureKey));
    return Object.entries(FEATURE_STEPS)
      .filter(([fk]) => keys.has(fk))
      .map(([_, s]) => s);
  }, [features]);

  const steps = useMemo(() => {
    const s = [{ key: 'info', label: 'Your Info' }];
    s.push({ key: 'attendees', label: 'Attendees' });
    // Halter needs animals; put animal picker right before it.
    if (featureSteps.some(f => f.key === 'halter')) {
      s.push({ key: 'animals', label: 'Your Animals' });
    }
    featureSteps.forEach(f => s.push(f));
    if (mealSessions.length > 0) s.push({ key: 'meals', label: 'Meal Tickets' });
    s.push({ key: 'review', label: 'Review' });
    s.push({ key: 'pay', label: 'Payment' });
    s.push({ key: 'done', label: 'Done' });
    return s;
  }, [featureSteps, mealSessions]);

  const [stepIndex, setStepIndex] = useState(0);
  const current = steps[stepIndex];

  const goNext = () => setStepIndex(i => Math.min(i + 1, steps.length - 1));
  const goBack = () => setStepIndex(i => Math.max(i - 1, 0));

  // Persist cart when leaving info step
  const ensureCart = async () => {
    if (cart?.CartID) return cart;
    const res = await fetch(`${API}/api/events/${eventId}/cart`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        PeopleID: peopleId,
        BusinessID: BusinessID ? Number(BusinessID) : null,
        ...form,
      }),
    });
    const j = await res.json();
    const full = await fetch(`${API}/api/events/cart/${j.CartID}`).then(r => r.json());
    setCart(full);
    return full;
  };

  // Recompute review items from in-memory entries + server fees
  const buildReviewItems = async () => {
    const c = await ensureCart();
    const out = [];

    // Halter: fetch class list to get names, config for fee
    if (halterEntries.length && featureSteps.some(f => f.key === 'halter')) {
      const [classes, cfg] = await Promise.all([
        fetch(`${API}/api/events/${eventId}/halter/classes`).then(r => r.json()).catch(() => []),
        fetch(`${API}/api/events/${eventId}/halter/config`).then(r => r.json()).catch(() => ({})),
      ]);
      const fee = Number(cfg?.CurrentFee || cfg?.FeePerClass || 0);
      const classNameById = Object.fromEntries((classes || []).map(c => [c.ClassID, c.ClassName]));
      halterEntries.forEach(he => {
        const a = animals.find(x => (x.ID ?? x.AnimalID) === he.AnimalID);
        he.ClassIDs.forEach(cid => {
          out.push({ FeatureKey: 'halter', Label: `${a?.FullName || a?.AnimalName || 'Animal'} — ${classNameById[cid] || `Class ${cid}`}`, Quantity: 1, UnitAmount: fee, LineAmount: fee });
        });
      });
    }

    if (fleeceEntries.length) {
      const cfg = await fetch(`${API}/api/events/${eventId}/fleece/config`).then(r => r.json()).catch(() => ({}));
      const fee = Number(cfg?.CurrentFee || cfg?.FeePerFleece || 0);
      fleeceEntries.forEach(e => out.push({ FeatureKey: 'fleece', Label: e.FleeceName || 'Fleece entry', Quantity: 1, UnitAmount: fee, LineAmount: fee }));
    }
    if (spinoffEntries.length) {
      const cfg = await fetch(`${API}/api/events/${eventId}/spinoff/config`).then(r => r.json()).catch(() => ({}));
      const fee = Number(cfg?.CurrentFee || cfg?.FeePerEntry || 0);
      spinoffEntries.forEach(e => out.push({ FeatureKey: 'spinoff', Label: e.EntryTitle || 'Spin-Off entry', Quantity: 1, UnitAmount: fee, LineAmount: fee }));
    }
    if (fiberEntries.length) {
      const cfg = await fetch(`${API}/api/events/${eventId}/fiber-arts/config`).then(r => r.json()).catch(() => ({}));
      const fee = Number(cfg?.CurrentFee || cfg?.FeePerEntry || 0);
      fiberEntries.forEach(e => out.push({ FeatureKey: 'fiber-arts', Label: e.EntryTitle || 'Fiber-arts entry', Quantity: 1, UnitAmount: fee, LineAmount: fee }));
    }
    if (vendor.include) {
      const cfg = await fetch(`${API}/api/events/${eventId}/vendor-fair/config`).then(r => r.json()).catch(() => ({}));
      const fee = Number(cfg?.BoothFee || 0);
      out.push({ FeatureKey: 'vendor', Label: `Vendor stall${vendor.BusinessName ? ` — ${vendor.BusinessName}` : ''}`, Quantity: 1, UnitAmount: fee, LineAmount: fee });
    }
    mealSessions.forEach(s => {
      const sel = mealSel[s.SessionID];
      if (sel?.Quantity > 0) {
        const price = Number(s.Price || 0);
        out.push({ FeatureKey: 'meal', SourceTable: 'OFNEventMealSessions', SourceID: s.SessionID,
          Label: `${s.SessionName}${sel.DietaryNotes ? ` (${sel.DietaryNotes})` : ''}`,
          Quantity: sel.Quantity, UnitAmount: price, LineAmount: price * sel.Quantity });
      }
    });

    // Persist to server cart (replaces items; recomputes total + fee)
    const totals = await fetch(`${API}/api/events/cart/${c.CartID}/items`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ items: out }),
    }).then(r => r.json());

    setItems(out);
    setCart(cu => ({ ...cu, ...totals }));
    return { cart: { ...c, ...totals }, items: out };
  };

  // When moving into the review step, push items up to the server.
  useEffect(() => {
    if (current?.key === 'review') {
      buildReviewItems().catch(e => setError(e.message));
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [stepIndex]);

  // When moving to pay, also POST the actual feature entries so they exist
  // with a CartID. This means "pending_payment" state: rows are in the DB
  // but marked unpaid until Stripe confirms.
  const finalizeFeatureEntries = async () => {
    const c = await ensureCart();
    const link = (table, id) => fetch(`${API}/api/events/cart/${c.CartID}/link`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ SourceTable: table, SourceID: id, IDColumn: 'EntryID' }),
    });

    // Halter
    for (const he of halterEntries) {
      for (const classId of he.ClassIDs) {
        const r = await fetch(`${API}/api/events/${eventId}/halter/entries`, {
          method: 'POST', headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            ClassID: classId, AnimalID: he.AnimalID,
            PeopleID: peopleId, BusinessID: BusinessID ? Number(BusinessID) : null,
          }),
        });
        const j = await r.json().catch(() => ({}));
        if (j?.EntryID) await link('OFNEventHalterEntries', j.EntryID);
      }
    }
    // Fleece
    for (const fe of fleeceEntries) {
      const r = await fetch(`${API}/api/events/${eventId}/fleece/entries`, {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...fe,
          SourceAnimalID: fe.SourceAnimalID ? Number(fe.SourceAnimalID) : null,
          DivisionID: fe.DivisionID ? Number(fe.DivisionID) : null,
          PeopleID: peopleId, BusinessID: BusinessID ? Number(BusinessID) : null }),
      });
      const j = await r.json().catch(() => ({}));
      if (j?.EntryID) await link('OFNEventFleeceEntries', j.EntryID);
    }
    for (const se of spinoffEntries) {
      const r = await fetch(`${API}/api/events/${eventId}/spinoff/entries`, {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...se,
          SourceAnimalID: se.SourceAnimalID ? Number(se.SourceAnimalID) : null,
          CategoryID: se.CategoryID ? Number(se.CategoryID) : null,
          PeopleID: peopleId, BusinessID: BusinessID ? Number(BusinessID) : null }),
      });
      const j = await r.json().catch(() => ({}));
      if (j?.EntryID) await link('OFNEventSpinOffEntries', j.EntryID);
    }
    for (const fe of fiberEntries) {
      const r = await fetch(`${API}/api/events/${eventId}/fiber-arts/entries`, {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...fe,
          CategoryID: fe.CategoryID ? Number(fe.CategoryID) : null,
          PeopleID: peopleId, BusinessID: BusinessID ? Number(BusinessID) : null }),
      });
      const j = await r.json().catch(() => ({}));
      if (j?.EntryID) await link('OFNEventFiberArtsEntries', j.EntryID);
    }
    if (vendor.include) {
      const r = await fetch(`${API}/api/events/${eventId}/vendor-fair/booths`, {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...vendor,
          PeopleID: peopleId, BusinessID: BusinessID ? Number(BusinessID) : null }),
      });
      const j = await r.json().catch(() => ({}));
      if (j?.BoothID) await link('OFNEventVendorFairBooths', j.BoothID);
    }
    // Meal tickets
    for (const [sid, sel] of Object.entries(mealSel)) {
      if (!sel?.Quantity) continue;
      const r = await fetch(`${API}/api/events/${eventId}/meals/tickets`, {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          SessionID: Number(sid), Quantity: sel.Quantity,
          DietaryNotes: sel.DietaryNotes || null,
          AttendeeName: `${form.AttendeeFirstName} ${form.AttendeeLastName}`.trim(),
          CartID: c.CartID, PeopleID: peopleId,
          BusinessID: BusinessID ? Number(BusinessID) : null,
        }),
      });
      // No link needed — ticket row already has CartID
      await r.json().catch(() => null);
    }
  };

  const goToPay = async () => {
    setSubmitting(true); setError('');
    try {
      await finalizeFeatureEntries();
      goNext();
    } catch (e) {
      setError(e.message || 'Could not finalize registration');
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50"><Header />
        <div className="max-w-2xl mx-auto px-4 py-16 text-center text-gray-400">Loading…</div>
        <Footer />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <PageMeta title={`Register for ${event?.EventName || 'Event'}`} canonical={`https://oatmealfarmnetwork.com/events/${eventId}/register`} noIndex />
      <Header />
      <div className="max-w-3xl mx-auto px-4 py-6">
        <Breadcrumbs items={[
          { label: 'Events', to: '/events' },
          { label: event?.EventName || 'Event', to: `/events/${eventId}` },
          { label: 'Register' },
        ]} />
        <div className="mb-2">
          <h1 className="text-2xl font-bold text-gray-900">Register — {event?.EventName}</h1>
          {event?.EventStartDate && <div className="text-sm text-gray-500">{formatDate(event.EventStartDate)}</div>}
        </div>

        <StepHeader stepIndex={stepIndex} steps={steps} />

        {error && <div className="bg-red-50 border border-red-200 rounded-lg px-4 py-3 text-sm text-red-700 mb-4">{error}</div>}

        {current.key === 'info' && (
          <InfoStep form={form} setForm={setForm} onNext={async () => { await ensureCart(); goNext(); }} />
        )}
        {current.key === 'attendees' && (
          <WizardAttendeesStep
            cartId={cart?.CartID}
            businessId={BusinessID}
            payer={{ FirstName: form.AttendeeFirstName, LastName: form.AttendeeLastName, Email: form.AttendeeEmail }}
            onNext={async () => { await ensureCart(); goNext(); }}
            onBack={goBack}
          />
        )}
        {current.key === 'animals' && (
          <AnimalPickerStep
            businessId={BusinessID}
            peopleId={peopleId}
            picked={animals}
            setPicked={setAnimals}
            onNext={goNext}
            onBack={goBack}
          />
        )}
        {current.key === 'halter' && (
          <HalterStep eventId={eventId} cartId={cart?.CartID} pickedAnimals={animals} entries={halterEntries} setEntries={setHalterEntries} onNext={goNext} onBack={goBack} businessId={BusinessID} peopleId={peopleId} />
        )}
        {current.key === 'fleece' && (
          <FleeceStep eventId={eventId} entries={fleeceEntries} setEntries={setFleeceEntries} onNext={goNext} onBack={goBack} pickedAnimals={animals} />
        )}
        {current.key === 'spinoff' && (
          <SpinOffStep eventId={eventId} entries={spinoffEntries} setEntries={setSpinoffEntries} onNext={goNext} onBack={goBack} pickedAnimals={animals} />
        )}
        {current.key === 'fiber_arts' && (
          <FiberArtsStep eventId={eventId} entries={fiberEntries} setEntries={setFiberEntries} onNext={goNext} onBack={goBack} />
        )}
        {current.key === 'vendor' && (
          <VendorStep eventId={eventId} booth={vendor} setBooth={setVendor} onNext={goNext} onBack={goBack} />
        )}
        {current.key === 'meals' && (
          <MealsStep eventId={eventId} sessions={mealSessions} selections={mealSel} setSelections={setMealSel} onNext={goNext} onBack={goBack} />
        )}
        {current.key === 'review' && (
          <ReviewStep cart={cart} items={items} onBack={goBack} onPay={goToPay} submitting={submitting} />
        )}
        {current.key === 'pay' && cart && (
          <WizardPayStep cartId={cart.CartID} total={cart.Total} eventId={eventId} hostBusinessId={event?.BusinessID} onPaid={() => goNext()} onBack={goBack} />
        )}
        {current.key === 'done' && cart && (
          <div className="bg-white rounded-2xl border border-gray-200 p-10 shadow-sm text-center">
            <div className="text-5xl mb-4">✅</div>
            <h1 className="text-2xl font-bold text-gray-800 mb-2">You're Registered!</h1>
            <p className="text-gray-500 mb-4">Registration #{cart.CartID}</p>
            <div className="flex gap-3 justify-center">
              <Link to={`/my-registrations`} className="text-[#3D6B34] hover:underline text-sm">My Registrations</Link>
              <Link to={`/events/${eventId}`} className="text-[#3D6B34] hover:underline text-sm">Back to Event</Link>
            </div>
          </div>
        )}
      </div>
      <Footer />
    </div>
  );
}
