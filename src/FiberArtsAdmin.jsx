import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

const PLACEMENTS = ['', '1st', '2nd', '3rd', '4th', '5th', '6th', 'Champion', 'Reserve Champion', 'Honorable Mention', 'Disqualified'];

const EMPTY_CONFIG = {
  Description: '',
  FeePerEntry: 0,
  DiscountFeePerEntry: '',
  DiscountEndDate: '',
  MaxEntriesPerRegistrant: '',
  MaxEntriesTotal: '',
  RegistrationEndDate: '',
  IsActive: true,
};

function d(val) { return val ? String(val).substring(0, 10) : ''; }

function ConfigTab({ eventId }) {
  const [cfg, setCfg] = useState(EMPTY_CONFIG);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/fiber-arts/config`)
      .then(r => r.json())
      .then(d_ => {
        if (d_?.configured) {
          setCfg({
            Description: d_.Description || '',
            FeePerEntry: d_.FeePerEntry || 0,
            DiscountFeePerEntry: d_.DiscountFeePerEntry ?? '',
            DiscountEndDate: d(d_.DiscountEndDate),
            MaxEntriesPerRegistrant: d_.MaxEntriesPerRegistrant ?? '',
            MaxEntriesTotal: d_.MaxEntriesTotal ?? '',
            RegistrationEndDate: d(d_.RegistrationEndDate),
            IsActive: !!d_.IsActive,
          });
        }
      })
      .catch(() => {});
  }, [eventId]);

  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setB = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.checked }));

  const save = async (e) => {
    e.preventDefault();
    setSaving(true);
    setMsg('');
    try {
      const r = await fetch(`${API}/api/events/${eventId}/fiber-arts/config`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...cfg,
          FeePerEntry: Number(cfg.FeePerEntry) || 0,
          DiscountFeePerEntry: cfg.DiscountFeePerEntry === '' ? null : Number(cfg.DiscountFeePerEntry),
          MaxEntriesPerRegistrant: cfg.MaxEntriesPerRegistrant === '' ? null : Number(cfg.MaxEntriesPerRegistrant),
          MaxEntriesTotal: cfg.MaxEntriesTotal === '' ? null : Number(cfg.MaxEntriesTotal),
        }),
      });
      if (!r.ok) throw new Error('Save failed');
      setMsg('Saved');
    } catch (ex) {
      setMsg(ex.message);
    } finally {
      setSaving(false);
      setTimeout(() => setMsg(''), 3000);
    }
  };

  return (
    <form onSubmit={save} className="space-y-5">
      <div>
        <label className={lbl}>Show Description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={200} />
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label className={lbl}>Fee per entry ($)</label>
          <input type="number" step="0.01" value={cfg.FeePerEntry} onChange={set('FeePerEntry')} className={inp} />
        </div>
        <div>
          <label className={lbl}>Discount fee per entry ($)</label>
          <input type="number" step="0.01" value={cfg.DiscountFeePerEntry} onChange={set('DiscountFeePerEntry')} className={inp} placeholder="Optional" />
        </div>
        <div>
          <label className={lbl}>Discount ends</label>
          <input type="date" value={cfg.DiscountEndDate} onChange={set('DiscountEndDate')} className={inp} />
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label className={lbl}>Max entries per registrant</label>
          <input type="number" min="1" value={cfg.MaxEntriesPerRegistrant} onChange={set('MaxEntriesPerRegistrant')} className={inp} placeholder="Unlimited" />
        </div>
        <div>
          <label className={lbl}>Max entries total</label>
          <input type="number" min="1" value={cfg.MaxEntriesTotal} onChange={set('MaxEntriesTotal')} className={inp} placeholder="Unlimited" />
        </div>
        <div>
          <label className={lbl}>Registration closes</label>
          <input type="date" value={cfg.RegistrationEndDate} onChange={set('RegistrationEndDate')} className={inp} />
        </div>
      </div>
      <label className="flex items-center gap-2 text-sm text-gray-700">
        <input type="checkbox" checked={cfg.IsActive} onChange={setB('IsActive')} className="w-4 h-4 accent-green-600" />
        Show is active (attendees can enter)
      </label>
      <div className="flex items-center justify-end gap-3 pt-2">
        {msg && <span className="text-sm text-gray-500 mr-auto">{msg}</span>}
        <button type="submit" disabled={saving} className="bg-[#3D6B34] text-white font-semibold px-6 py-2 rounded-lg hover:bg-[#2d5226] disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Configuration'}
        </button>
      </div>
    </form>
  );
}

function CategoriesTab({ eventId }) {
  const [cats, setCats] = useState([]);
  const [adding, setAdding] = useState(false);
  const [draft, setDraft] = useState({ CategoryName: '', CategoryDescription: '', DisplayOrder: 0 });
  const [editingId, setEditingId] = useState(null);

  const load = () => fetch(`${API}/api/events/${eventId}/fiber-arts/categories`).then(r => r.json()).then(setCats).catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const save = async () => {
    if (!draft.CategoryName) return;
    const url = editingId
      ? `${API}/api/events/fiber-arts/categories/${editingId}`
      : `${API}/api/events/${eventId}/fiber-arts/categories`;
    const method = editingId ? 'PUT' : 'POST';
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(draft) });
    setDraft({ CategoryName: '', CategoryDescription: '', DisplayOrder: 0 });
    setAdding(false);
    setEditingId(null);
    load();
  };

  const remove = async (id) => {
    if (!confirm('Delete this category?')) return;
    await fetch(`${API}/api/events/fiber-arts/categories/${id}`, { method: 'DELETE' });
    load();
  };

  const startEdit = (c) => {
    setEditingId(c.CategoryID);
    setDraft({ CategoryName: c.CategoryName, CategoryDescription: c.CategoryDescription || '', DisplayOrder: c.DisplayOrder || 0 });
    setAdding(true);
  };

  const seedDefaults = async () => {
    if (!confirm('Seed 9 standard cottage-industry categories (Handspun Yarn, Knitted Garment, Woven, Felted, etc.)? Existing categories with the same names are skipped.')) return;
    const r = await fetch(`${API}/api/events/${eventId}/fiber-arts/categories/bulk-seed`, { method: 'POST' });
    if (r.ok) load();
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <p className="text-sm text-gray-600">Define judging categories (e.g., "Handspun Yarn", "Felted Goods", "Finished Garments").</p>
        <div className="flex gap-2">
          {cats.length === 0 && (
            <button onClick={seedDefaults} className="text-sm border border-[#3D6B34] text-[#3D6B34] px-4 py-1.5 rounded-lg hover:bg-green-50">
              Seed defaults
            </button>
          )}
          {!adding && (
            <button onClick={() => setAdding(true)} className="text-sm bg-[#3D6B34] text-white px-4 py-1.5 rounded-lg hover:bg-[#2d5226]">
              + Add Category
            </button>
          )}
        </div>
      </div>

      {adding && (
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-4 mb-4 space-y-3">
          <div>
            <label className={lbl}>Category name</label>
            <input value={draft.CategoryName} onChange={e => setDraft(d => ({ ...d, CategoryName: e.target.value }))} className={inp} />
          </div>
          <div>
            <label className={lbl}>Description (optional)</label>
            <RichTextEditor value={draft.CategoryDescription || ''}
              onChange={(v) => setDraft(d => ({ ...d, CategoryDescription: v }))} minHeight={110} />
          </div>
          <div>
            <label className={lbl}>Display order</label>
            <input type="number" value={draft.DisplayOrder} onChange={e => setDraft(d => ({ ...d, DisplayOrder: Number(e.target.value) || 0 }))} className={`${inp} w-28`} />
          </div>
          <div className="flex justify-end gap-2">
            <button onClick={() => { setAdding(false); setEditingId(null); setDraft({ CategoryName: '', CategoryDescription: '', DisplayOrder: 0 }); }} className="px-4 py-1.5 text-sm border border-gray-300 rounded-lg">Cancel</button>
            <button onClick={save} className="px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg">{editingId ? 'Update' : 'Add'}</button>
          </div>
        </div>
      )}

      <div className="space-y-2">
        {cats.length === 0 && <div className="text-sm text-gray-500">No categories yet.</div>}
        {cats.map(c => (
          <div key={c.CategoryID} className="flex items-start justify-between bg-white border border-gray-200 rounded-lg p-3">
            <div className="flex-1">
              <div className="font-medium text-gray-900">{c.CategoryName}</div>
              {c.CategoryDescription && <div className="text-xs text-gray-500 mt-0.5">{c.CategoryDescription}</div>}
              <div className="text-[11px] text-gray-400 mt-1">Order {c.DisplayOrder}</div>
            </div>
            <div className="flex gap-2">
              <button onClick={() => startEdit(c)} className="text-xs text-gray-500 hover:text-gray-800">Edit</button>
              <button onClick={() => remove(c.CategoryID)} className="text-xs text-red-500 hover:text-red-700">Delete</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function EntriesTab({ eventId }) {
  const [entries, setEntries] = useState([]);
  const [judgingId, setJudgingId] = useState(null);
  const [judgeDraft, setJudgeDraft] = useState({ Placement: '', JudgeNotes: '' });

  const load = () => fetch(`${API}/api/events/${eventId}/fiber-arts/entries`).then(r => r.json()).then(setEntries).catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const startJudge = (e) => {
    setJudgingId(e.EntryID);
    setJudgeDraft({ Placement: e.Placement || '', JudgeNotes: e.JudgeNotes || '' });
  };

  const saveJudge = async () => {
    await fetch(`${API}/api/events/fiber-arts/entries/${judgingId}/judge`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(judgeDraft),
    });
    setJudgingId(null);
    load();
  };

  const togglePaid = async (e) => {
    const next = e.PaidStatus === 'paid' ? 'pending' : 'paid';
    await fetch(`${API}/api/events/fiber-arts/entries/${e.EntryID}/paid`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ PaidStatus: next }),
    });
    load();
  };

  const byCat = entries.reduce((acc, e) => {
    const key = e.CategoryName || 'Uncategorized';
    (acc[key] ||= []).push(e);
    return acc;
  }, {});

  return (
    <div>
      <div className="mb-4 text-sm text-gray-600">
        {entries.length} {entries.length === 1 ? 'entry' : 'entries'} from {new Set(entries.map(e => e.PeopleID)).size} registrants.
      </div>
      {Object.entries(byCat).map(([cat, list]) => (
        <div key={cat} className="mb-6">
          <h3 className="text-sm font-bold text-gray-600 uppercase tracking-wide mb-2">{cat}</h3>
          <div className="space-y-2">
            {list.map(e => (
              <div key={e.EntryID} className="bg-white border border-gray-200 rounded-lg p-3">
                {judgingId === e.EntryID ? (
                  <div className="space-y-3">
                    <div className="font-medium">{e.EntryTitle}</div>
                    <div>
                      <label className={lbl}>Placement</label>
                      <select value={judgeDraft.Placement} onChange={ev => setJudgeDraft(d => ({ ...d, Placement: ev.target.value }))} className={inp}>
                        {PLACEMENTS.map(p => <option key={p} value={p}>{p || '— none —'}</option>)}
                      </select>
                    </div>
                    <div>
                      <label className={lbl}>Judge notes</label>
                      <RichTextEditor value={judgeDraft.JudgeNotes || ''}
                        onChange={(v) => setJudgeDraft(d => ({ ...d, JudgeNotes: v }))} minHeight={130} />
                    </div>
                    <div className="flex justify-end gap-2">
                      <button onClick={() => setJudgingId(null)} className="px-3 py-1 text-sm border border-gray-300 rounded-lg">Cancel</button>
                      <button onClick={saveJudge} className="px-3 py-1 text-sm bg-[#3D6B34] text-white rounded-lg">Save</button>
                    </div>
                  </div>
                ) : (
                  <div className="flex items-start justify-between gap-3">
                    <div className="flex-1">
                      <div className="font-medium text-gray-900">{e.EntryTitle}</div>
                      <div className="text-xs text-gray-500 mt-0.5">
                        {[e.PeopleFirstName, e.PeopleLastName].filter(Boolean).join(' ')}
                        {e.BusinessName && ` • ${e.BusinessName}`}
                        {e.FiberType && ` • ${e.FiberType}`}
                      </div>
                      {e.Description && <div className="text-xs text-gray-600 mt-1">{e.Description}</div>}
                      {e.Placement && <div className="text-xs font-semibold text-[#3D6B34] mt-1">🏆 {e.Placement}</div>}
                      {e.JudgeNotes && <div className="text-xs italic text-gray-500 mt-0.5">Judge: {e.JudgeNotes}</div>}
                    </div>
                    <div className="flex flex-col items-end gap-1">
                      <div className="text-xs text-gray-600">${Number(e.EntryFee || 0).toFixed(2)}</div>
                      <button onClick={() => togglePaid(e)} className={`text-[11px] px-2 py-0.5 rounded ${e.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                        {e.PaidStatus || 'pending'}
                      </button>
                      <button onClick={() => startJudge(e)} className="text-xs text-blue-600 hover:text-blue-800">Judge</button>
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}

export default function FiberArtsAdmin() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const BusinessID = params.get('BusinessID');
  const [tab, setTab] = useState(params.get('tab') || 'config');
  const [event, setEvent] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
  }, [eventId]);

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">
              Cottage Industry / Fiber Arts Show
            </h1>
            <p className="text-sm text-gray-500 mt-1">
              {event?.EventName || 'Event'} — admin console
            </p>
          </div>
          <Link to={`/events/manage?BusinessID=${BusinessID || ''}`} className="text-sm text-gray-500 hover:text-gray-700">
            ← Back to My Events
          </Link>
        </div>

        <div className="flex gap-1 border-b border-gray-200 mb-6">
          {['config', 'categories', 'entries'].map(t => (
            <button
              key={t}
              onClick={() => setTab(t)}
              className={`px-4 py-2 text-sm font-medium border-b-2 -mb-px ${tab === t ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}
            >
              {t === 'config' ? 'Configuration' : t === 'categories' ? 'Categories' : 'Entries & Judging'}
            </button>
          ))}
        </div>

        {tab === 'config' && <ConfigTab eventId={eventId} />}
        {tab === 'categories' && <CategoriesTab eventId={eventId} />}
        {tab === 'entries' && <EntriesTab eventId={eventId} />}
      </div>
    </EventAdminLayout>
  );
}
