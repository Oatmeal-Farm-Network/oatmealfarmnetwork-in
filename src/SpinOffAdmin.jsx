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
  DiscountStartDate: '',
  DiscountEndDate: '',
  RegistrationStartDate: '',
  RegistrationEndDate: '',
  MaxEntriesPerRegistrant: '',
  IsActive: true,
};

function d(val) { return val ? String(val).substring(0, 10) : ''; }

function ConfigTab({ eventId }) {
  const [cfg, setCfg] = useState(EMPTY_CONFIG);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/spinoff/config`)
      .then(r => r.json())
      .then(d_ => {
        if (d_?.configured) {
          setCfg({
            Description: d_.Description || '',
            FeePerEntry: d_.FeePerEntry || 0,
            DiscountFeePerEntry: d_.DiscountFeePerEntry ?? '',
            DiscountStartDate: d(d_.DiscountStartDate),
            DiscountEndDate: d(d_.DiscountEndDate),
            RegistrationStartDate: d(d_.RegistrationStartDate),
            RegistrationEndDate: d(d_.RegistrationEndDate),
            MaxEntriesPerRegistrant: d_.MaxEntriesPerRegistrant ?? '',
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
      const r = await fetch(`${API}/api/events/${eventId}/spinoff/config`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...cfg,
          FeePerEntry: Number(cfg.FeePerEntry) || 0,
          DiscountFeePerEntry: cfg.DiscountFeePerEntry === '' ? null : Number(cfg.DiscountFeePerEntry),
          MaxEntriesPerRegistrant: cfg.MaxEntriesPerRegistrant === '' ? null : Number(cfg.MaxEntriesPerRegistrant),
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
        <label className={lbl}>Spin-Off Description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={200} />
      </div>

      <h3 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Fees</h3>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label className={lbl}>Fee per Spin-Off entry ($)</label>
          <input type="number" step="0.01" value={cfg.FeePerEntry} onChange={set('FeePerEntry')} className={inp} />
        </div>
        <div>
          <label className={lbl}>Discount fee per entry ($)</label>
          <input type="number" step="0.01" value={cfg.DiscountFeePerEntry} onChange={set('DiscountFeePerEntry')} className={inp} placeholder="Optional" />
        </div>
        <div>
          <label className={lbl}>Max entries per registrant</label>
          <input type="number" min="1" value={cfg.MaxEntriesPerRegistrant} onChange={set('MaxEntriesPerRegistrant')} className={inp} placeholder="Unlimited" />
        </div>
      </div>

      <h3 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Registration Window</h3>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label className={lbl}>Registration opens</label>
          <input type="date" value={cfg.RegistrationStartDate} onChange={set('RegistrationStartDate')} className={inp} />
        </div>
        <div>
          <label className={lbl}>Registration closes</label>
          <input type="date" value={cfg.RegistrationEndDate} onChange={set('RegistrationEndDate')} className={inp} />
        </div>
      </div>

      <h3 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Discount Window</h3>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label className={lbl}>Discount starts</label>
          <input type="date" value={cfg.DiscountStartDate} onChange={set('DiscountStartDate')} className={inp} />
        </div>
        <div>
          <label className={lbl}>Discount ends</label>
          <input type="date" value={cfg.DiscountEndDate} onChange={set('DiscountEndDate')} className={inp} />
        </div>
      </div>

      <label className="flex items-center gap-2 text-sm text-gray-700">
        <input type="checkbox" checked={cfg.IsActive} onChange={setB('IsActive')} className="w-4 h-4 accent-green-600" />
        Spin-Off is active (attendees can register)
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
  const [editingId, setEditingId] = useState(null);
  const EMPTY = { CategoryName: '', SkillLevel: '', Description: '', DisplayOrder: 0 };
  const [draft, setDraft] = useState(EMPTY);

  const load = () => fetch(`${API}/api/events/${eventId}/spinoff/categories`).then(r => r.json()).then(setCats).catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const save = async () => {
    if (!draft.CategoryName) return;
    const url = editingId
      ? `${API}/api/events/spinoff/categories/${editingId}`
      : `${API}/api/events/${eventId}/spinoff/categories`;
    const method = editingId ? 'PUT' : 'POST';
    await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(draft) });
    setDraft(EMPTY);
    setAdding(false);
    setEditingId(null);
    load();
  };

  const remove = async (id) => {
    if (!confirm('Delete this category?')) return;
    await fetch(`${API}/api/events/spinoff/categories/${id}`, { method: 'DELETE' });
    load();
  };

  const startEdit = (c) => {
    setEditingId(c.CategoryID);
    setDraft({
      CategoryName: c.CategoryName,
      SkillLevel: c.SkillLevel || '',
      Description: c.Description || '',
      DisplayOrder: c.DisplayOrder || 0,
    });
    setAdding(true);
  };

  const seedDefaults = async () => {
    if (!confirm('Seed 8 standard Spin-Off categories (Novice/Intermediate/Advanced/Youth spinners + Camelid, Sheep, Luxury, Art Yarn)? Existing categories with the same names are skipped.')) return;
    const r = await fetch(`${API}/api/events/${eventId}/spinoff/categories/bulk-seed`, { method: 'POST' });
    if (r.ok) load();
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <p className="text-sm text-gray-600">Define Spin-Off categories (e.g., "Novice Spinner", "Advanced", "Art Yarn"). Entries can be grouped by category for judging.</p>
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
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div>
              <label className={lbl}>Category name *</label>
              <input value={draft.CategoryName} onChange={e => setDraft(d => ({ ...d, CategoryName: e.target.value }))} className={inp} />
            </div>
            <div>
              <label className={lbl}>Skill level</label>
              <select value={draft.SkillLevel} onChange={e => setDraft(d => ({ ...d, SkillLevel: e.target.value }))} className={inp}>
                <option value="">— none —</option>
                <option value="Novice">Novice</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Advanced">Advanced</option>
                <option value="Youth">Youth</option>
                <option value="Open">Open</option>
              </select>
            </div>
          </div>
          <div>
            <label className={lbl}>Description (optional)</label>
            <RichTextEditor value={draft.Description || ''}
              onChange={(v) => setDraft(d => ({ ...d, Description: v }))} minHeight={110} />
          </div>
          <div>
            <label className={lbl}>Display order</label>
            <input type="number" value={draft.DisplayOrder} onChange={e => setDraft(d => ({ ...d, DisplayOrder: Number(e.target.value) || 0 }))} className={`${inp} w-28`} />
          </div>
          <div className="flex justify-end gap-2">
            <button onClick={() => { setAdding(false); setEditingId(null); setDraft(EMPTY); }} className="px-4 py-1.5 text-sm border border-gray-300 rounded-lg">Cancel</button>
            <button onClick={save} className="px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg">{editingId ? 'Update' : 'Add'}</button>
          </div>
        </div>
      )}

      <div className="space-y-2">
        {cats.length === 0 && <div className="text-sm text-gray-500">No categories yet. Categories are optional — entries can be submitted without one.</div>}
        {cats.map(c => (
          <div key={c.CategoryID} className="flex items-start justify-between bg-white border border-gray-200 rounded-lg p-3">
            <div className="flex-1">
              <div className="font-medium text-gray-900">{c.CategoryName}</div>
              {c.SkillLevel && <div className="text-xs text-gray-500 mt-0.5">Skill: {c.SkillLevel}</div>}
              {c.Description && <div className="text-xs text-gray-500 mt-0.5">{c.Description}</div>}
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

  const load = () => fetch(`${API}/api/events/${eventId}/spinoff/entries`)
    .then(r => r.json()).then(setEntries).catch(() => setEntries([]));
  useEffect(() => { load(); }, [eventId]);

  const togglePaid = async (e) => {
    const next = e.PaidStatus === 'paid' ? 'pending' : 'paid';
    await fetch(`${API}/api/events/spinoff/entries/${e.EntryID}/paid`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ PaidStatus: next }),
    });
    load();
  };

  const totalFee = entries.reduce((s, e) => s + Number(e.EntryFee || 0), 0);
  const byFarm = entries.reduce((acc, e) => {
    const key = e.BusinessName || [e.PeopleFirstName, e.PeopleLastName].filter(Boolean).join(' ') || 'Unknown';
    (acc[key] ||= []).push(e);
    return acc;
  }, {});

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap gap-3 text-sm">
        <div className="bg-white border border-gray-200 rounded-lg px-3 py-2">
          <div className="text-xs text-gray-500">Total entries</div>
          <div className="font-bold text-gray-900">{entries.length}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg px-3 py-2">
          <div className="text-xs text-gray-500">Paid</div>
          <div className="font-bold text-green-700">{entries.filter(e => e.PaidStatus === 'paid').length}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg px-3 py-2">
          <div className="text-xs text-gray-500">Total fees</div>
          <div className="font-bold text-[#3D6B34]">${totalFee.toFixed(2)}</div>
        </div>
      </div>

      {entries.length === 0 && <div className="text-sm text-gray-500">No Spin-Off entries yet.</div>}

      {Object.entries(byFarm).map(([farm, list]) => (
        <div key={farm} className="bg-white border border-gray-200 rounded-lg overflow-hidden">
          <div className="bg-gray-50 px-3 py-2 text-sm font-semibold text-gray-700">{farm} ({list.length})</div>
          <table className="w-full text-sm">
            <thead className="text-xs text-gray-500 border-t">
              <tr>
                <th className="text-left p-2">Entry</th>
                <th className="text-left p-2">Fiber Source</th>
                <th className="text-left p-2">Spinner</th>
                <th className="text-right p-2">Fee</th>
                <th className="text-center p-2">Paid</th>
              </tr>
            </thead>
            <tbody>
              {list.map(e => (
                <tr key={e.EntryID} className="border-t">
                  <td className="p-2 font-medium">{e.EntryTitle || `Entry #${e.EntryID}`}</td>
                  <td className="p-2">{e.FiberSource || e.AnimalName || '—'}</td>
                  <td className="p-2">{e.SpinnerName || [e.PeopleFirstName, e.PeopleLastName].filter(Boolean).join(' ') || '—'}</td>
                  <td className="p-2 text-right">${Number(e.EntryFee || 0).toFixed(2)}</td>
                  <td className="p-2 text-center">
                    <button onClick={() => togglePaid(e)}
                      className={`text-[11px] px-2 py-0.5 rounded ${e.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                      {e.PaidStatus || 'pending'}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ))}
    </div>
  );
}

function JudgingTab({ eventId }) {
  const [entries, setEntries] = useState([]);
  const [judgingId, setJudgingId] = useState(null);
  const [draft, setDraft] = useState({ Placement: '', JudgeNotes: '', Score: '' });

  const load = () => fetch(`${API}/api/events/${eventId}/spinoff/entries`)
    .then(r => r.json()).then(setEntries).catch(() => setEntries([]));
  useEffect(() => { load(); }, [eventId]);

  const start = (e) => {
    setJudgingId(e.EntryID);
    setDraft({ Placement: e.Placement || '', JudgeNotes: e.JudgeNotes || '', Score: e.Score ?? '' });
  };

  const save = async () => {
    await fetch(`${API}/api/events/spinoff/entries/${judgingId}/judge`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        ...draft,
        Score: draft.Score === '' ? null : Number(draft.Score),
      }),
    });
    setJudgingId(null);
    load();
  };

  return (
    <div className="space-y-2">
      {entries.length === 0 && <div className="text-sm text-gray-500">No Spin-Off entries to judge yet.</div>}
      {entries.map(e => (
        <div key={e.EntryID} className="bg-white border border-gray-200 rounded-lg p-3">
          {judgingId === e.EntryID ? (
            <div className="space-y-3">
              <div className="font-medium">{e.EntryTitle || `Entry #${e.EntryID}`}</div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                <div>
                  <label className={lbl}>Placement</label>
                  <select value={draft.Placement} onChange={ev => setDraft(d => ({ ...d, Placement: ev.target.value }))} className={inp}>
                    {PLACEMENTS.map(p => <option key={p} value={p}>{p || '— none —'}</option>)}
                  </select>
                </div>
                <div>
                  <label className={lbl}>Score (optional)</label>
                  <input type="number" step="0.01" value={draft.Score} onChange={ev => setDraft(d => ({ ...d, Score: ev.target.value }))} className={inp} />
                </div>
              </div>
              <div>
                <label className={lbl}>Judge notes</label>
                <RichTextEditor value={draft.JudgeNotes || ''}
                  onChange={(v) => setDraft(d => ({ ...d, JudgeNotes: v }))} minHeight={130} />
              </div>
              <div className="flex justify-end gap-2">
                <button onClick={() => setJudgingId(null)} className="px-3 py-1 text-sm border border-gray-300 rounded-lg">Cancel</button>
                <button onClick={save} className="px-3 py-1 text-sm bg-[#3D6B34] text-white rounded-lg">Save</button>
              </div>
            </div>
          ) : (
            <div className="flex items-start justify-between gap-3">
              <div className="flex-1">
                <div className="font-medium text-gray-900">{e.EntryTitle || `Entry #${e.EntryID}`}</div>
                <div className="text-xs text-gray-500 mt-0.5">
                  {[e.PeopleFirstName, e.PeopleLastName].filter(Boolean).join(' ')}
                  {e.BusinessName && ` • ${e.BusinessName}`}
                  {e.FiberSource && ` • ${e.FiberSource}`}
                </div>
                {e.Placement && <div className="text-xs font-semibold text-[#3D6B34] mt-1">🏆 {e.Placement}{e.Score != null && ` • Score ${e.Score}`}</div>}
                {e.JudgeNotes && <div className="text-xs italic text-gray-500 mt-0.5">Judge: {e.JudgeNotes}</div>}
              </div>
              <button onClick={() => start(e)} className="text-xs text-blue-600 hover:text-blue-800 shrink-0">Judge</button>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}

export default function SpinOffAdmin() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const BusinessID = params.get('BusinessID');
  const [tab, setTab] = useState(params.get('tab') || 'config');
  const [event, setEvent] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
  }, [eventId]);

  const TABS = [
    ['config', 'Configuration'],
    ['categories', 'Categories'],
    ['entries', 'Spin-Off Entries'],
    ['judging', 'Judging & Results'],
  ];

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Spin-Off</h1>
            <p className="text-sm text-gray-500 mt-1">
              {event?.EventName || 'Event'} — admin console
            </p>
          </div>
          <Link to={`/events/manage?BusinessID=${BusinessID || ''}`} className="text-sm text-gray-500 hover:text-gray-700">
            ← Back to My Events
          </Link>
        </div>

        <div className="flex gap-1 border-b border-gray-200 mb-6">
          {TABS.map(([id, label]) => (
            <button key={id} onClick={() => setTab(id)}
              className={`px-4 py-2 text-sm font-medium border-b-2 -mb-px ${tab === id ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
              {label}
            </button>
          ))}
        </div>

        {tab === 'config' && <ConfigTab eventId={eventId} />}
        {tab === 'categories' && <CategoriesTab eventId={eventId} />}
        {tab === 'entries' && <EntriesTab eventId={eventId} />}
        {tab === 'judging' && <JudgingTab eventId={eventId} />}
      </div>
    </EventAdminLayout>
  );
}
