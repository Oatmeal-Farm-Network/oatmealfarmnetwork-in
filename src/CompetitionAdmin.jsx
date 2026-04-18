import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
function d(v) { return v ? String(v).substring(0, 10) : ''; }

function ConfigTab({ eventId }) {
  const [cfg, setCfg] = useState({
    Description: '', EntryFee: 0, SpectatorFee: 0, EntryDeadline: '',
    MaxEntriesPerPerson: '', JudgingStyle: 'rubric', DropHighLow: false,
    PublishLeaderboard: true, AwardTiers: '', RulesText: '', IsActive: true,
  });
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/competition/config`).then(r => r.json()).then(x => {
      if (x) setCfg({
        Description: x.Description || '',
        EntryFee: x.EntryFee ?? 0,
        SpectatorFee: x.SpectatorFee ?? 0,
        EntryDeadline: d(x.EntryDeadline),
        MaxEntriesPerPerson: x.MaxEntriesPerPerson ?? '',
        JudgingStyle: x.JudgingStyle || 'rubric',
        DropHighLow: !!x.DropHighLow,
        PublishLeaderboard: x.PublishLeaderboard !== false,
        AwardTiers: x.AwardTiers || '',
        RulesText: x.RulesText || '',
        IsActive: x.IsActive !== false,
      });
    }).catch(() => {});
  }, [eventId]);

  const save = async (e) => {
    e.preventDefault(); setSaving(true); setMsg('');
    try {
      const r = await fetch(`${API}/api/events/${eventId}/competition/config`, {
        method: 'PUT', headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
          ...cfg,
          EntryFee: Number(cfg.EntryFee) || 0,
          SpectatorFee: Number(cfg.SpectatorFee) || 0,
          MaxEntriesPerPerson: cfg.MaxEntriesPerPerson === '' ? null : Number(cfg.MaxEntriesPerPerson),
        }),
      });
      if (!r.ok) throw new Error('Save failed');
      setMsg('Saved');
    } catch (ex) { setMsg(ex.message); }
    finally { setSaving(false); setTimeout(() => setMsg(''), 3000); }
  };

  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setB = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.checked }));

  return (
    <form onSubmit={save} className="space-y-5">
      <div>
        <label className={lbl}>Description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={140} />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-3">
        <div>
          <label className={lbl}>Entry fee</label>
          <input className={inp} type="number" step="0.01" value={cfg.EntryFee} onChange={set('EntryFee')} />
        </div>
        <div>
          <label className={lbl}>Spectator fee</label>
          <input className={inp} type="number" step="0.01" value={cfg.SpectatorFee} onChange={set('SpectatorFee')} />
        </div>
        <div>
          <label className={lbl}>Entry deadline</label>
          <input className={inp} type="date" value={cfg.EntryDeadline} onChange={set('EntryDeadline')} />
        </div>
        <div>
          <label className={lbl}>Max entries / person</label>
          <input className={inp} type="number" value={cfg.MaxEntriesPerPerson} onChange={set('MaxEntriesPerPerson')} />
        </div>
      </div>

      <div className="bg-gray-50 rounded-lg p-4 space-y-3">
        <div className="font-medium text-sm text-[#3D6B34]">Judging</div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
          <div>
            <label className={lbl}>Style</label>
            <select className={inp} value={cfg.JudgingStyle} onChange={set('JudgingStyle')}>
              <option value="rubric">Rubric (scored criteria)</option>
              <option value="placement">Placement (1st, 2nd, 3rd)</option>
            </select>
          </div>
          <div className="flex items-end">
            <label className="flex items-center gap-2 text-sm pb-2">
              <input type="checkbox" checked={!!cfg.DropHighLow} onChange={setB('DropHighLow')} />
              <span>Drop high + low when 3+ judges</span>
            </label>
          </div>
        </div>
        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" checked={!!cfg.PublishLeaderboard} onChange={setB('PublishLeaderboard')} />
          <span>Publish leaderboard publicly</span>
        </label>
      </div>

      <div>
        <label className={lbl}>Award tiers (e.g. Best in Show, Reserve Champion)</label>
        <textarea className={inp} rows={2} value={cfg.AwardTiers} onChange={set('AwardTiers')} />
      </div>
      <div>
        <label className={lbl}>Rules</label>
        <RichTextEditor value={cfg.RulesText || ''}
          onChange={(v) => setCfg(c => ({ ...c, RulesText: v }))} minHeight={140} />
      </div>

      <label className="flex items-center gap-2 text-sm">
        <input type="checkbox" checked={!!cfg.IsActive} onChange={setB('IsActive')} />
        <span>Active</span>
      </label>

      <div className="flex items-center gap-3 justify-start">
        <button type="submit" disabled={saving}
          className="bg-[#3D6B34] hover:bg-[#2D5228] text-white text-sm px-5 py-2 rounded-lg disabled:opacity-50">
          {saving ? 'Saving…' : 'Save configuration'}
        </button>
        <Link to="/account/events" className="text-sm px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-50">Cancel</Link>
        {msg && <span className="text-sm text-[#3D6B34]">{msg}</span>}
      </div>
    </form>
  );
}

function CategoriesTab({ eventId }) {
  const [categories, setCategories] = useState([]);
  const [criteriaByCat, setCriteriaByCat] = useState({});
  const [catForm, setCatForm] = useState({});
  const [critForm, setCritForm] = useState({}); // { [categoryId]: formState }

  const loadCats = () => fetch(`${API}/api/events/${eventId}/competition/categories`)
    .then(r => r.json()).then(async cats => {
      setCategories(cats || []);
      const map = {};
      for (const c of (cats || [])) {
        const res = await fetch(`${API}/api/events/competition/categories/${c.CategoryID}/criteria`).then(r => r.json());
        map[c.CategoryID] = res || [];
      }
      setCriteriaByCat(map);
    }).catch(() => {});
  useEffect(() => { loadCats(); }, [eventId]);

  const saveCategory = async (e) => {
    e.preventDefault();
    if (!catForm.CategoryName) return;
    const editing = catForm.CategoryID;
    const url = editing
      ? `${API}/api/events/competition/categories/${editing}`
      : `${API}/api/events/${eventId}/competition/categories`;
    await fetch(url, {
      method: editing ? 'PUT' : 'POST', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ ...catForm, MaxEntries: catForm.MaxEntries ? Number(catForm.MaxEntries) : null }),
    });
    setCatForm({}); loadCats();
  };
  const deleteCategory = async (c) => {
    if (!confirm(`Delete "${c.CategoryName}" and its rubric?`)) return;
    await fetch(`${API}/api/events/competition/categories/${c.CategoryID}`, { method: 'DELETE' });
    loadCats();
  };

  const saveCriterion = async (categoryId) => {
    const f = critForm[categoryId] || {};
    if (!f.CriterionName) return;
    const editing = f.CriterionID;
    const url = editing
      ? `${API}/api/events/competition/criteria/${editing}`
      : `${API}/api/events/competition/categories/${categoryId}/criteria`;
    await fetch(url, {
      method: editing ? 'PUT' : 'POST', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        ...f,
        MaxPoints: Number(f.MaxPoints) || 10,
        Weight: Number(f.Weight) || 1,
      }),
    });
    setCritForm(s => ({ ...s, [categoryId]: {} }));
    loadCats();
  };
  const deleteCriterion = async (categoryId, crit) => {
    if (!confirm(`Delete "${crit.CriterionName}"?`)) return;
    await fetch(`${API}/api/events/competition/criteria/${crit.CriterionID}`, { method: 'DELETE' });
    loadCats();
  };

  return (
    <div className="space-y-5">
      <form onSubmit={saveCategory} className="bg-gray-50 rounded-lg p-4 grid grid-cols-1 md:grid-cols-4 gap-3 items-end">
        <div className="md:col-span-2">
          <label className={lbl}>Category name *</label>
          <input className={inp} required value={catForm.CategoryName || ''}
            onChange={e => setCatForm(s => ({ ...s, CategoryName: e.target.value }))} />
        </div>
        <div>
          <label className={lbl}>Max entries</label>
          <input className={inp} type="number" value={catForm.MaxEntries || ''}
            onChange={e => setCatForm(s => ({ ...s, MaxEntries: e.target.value }))} />
        </div>
        <div className="flex gap-2">
          <button type="submit" className="bg-[#3D6B34] hover:bg-[#2D5228] text-white text-sm px-4 py-2 rounded-lg">
            {catForm.CategoryID ? 'Save' : 'Add category'}
          </button>
          {catForm.CategoryID && (
            <button type="button" onClick={() => setCatForm({})} className="text-sm px-4 py-2 rounded-lg border border-gray-300">Cancel</button>
          )}
        </div>
      </form>

      {categories.map(cat => {
        const rubric = criteriaByCat[cat.CategoryID] || [];
        const f = critForm[cat.CategoryID] || {};
        return (
          <div key={cat.CategoryID} className="border border-gray-200 rounded-lg p-4">
            <div className="flex items-center justify-between mb-3">
              <div>
                <div className="font-medium text-sm text-[#3D6B34]">{cat.CategoryName}</div>
                {cat.MaxEntries && <div className="text-xs text-gray-500">Max {cat.MaxEntries} entries</div>}
              </div>
              <div className="flex gap-2">
                <button onClick={() => setCatForm(cat)} className="text-xs text-[#3D6B34] hover:underline">Edit</button>
                <button onClick={() => deleteCategory(cat)} className="text-xs text-red-600 hover:underline">Delete</button>
              </div>
            </div>

            <div className="text-xs uppercase text-gray-500 mb-2">Rubric</div>
            <div className="space-y-1 mb-3">
              {rubric.length === 0 && <div className="text-xs text-gray-400">No criteria yet.</div>}
              {rubric.map(c => (
                <div key={c.CriterionID} className="flex items-center gap-2 text-sm">
                  <div className="flex-1">
                    <span className="font-medium">{c.CriterionName}</span>
                    <span className="text-xs text-gray-500 ml-2">max {c.MaxPoints} · weight {c.Weight}</span>
                  </div>
                  <button onClick={() => setCritForm(s => ({ ...s, [cat.CategoryID]: c }))}
                    className="text-xs text-[#3D6B34] hover:underline">Edit</button>
                  <button onClick={() => deleteCriterion(cat.CategoryID, c)}
                    className="text-xs text-red-600 hover:underline">Delete</button>
                </div>
              ))}
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-2 items-end">
              <div className="md:col-span-2">
                <label className={lbl}>Criterion</label>
                <input className={inp} value={f.CriterionName || ''}
                  onChange={e => setCritForm(s => ({ ...s, [cat.CategoryID]: { ...(s[cat.CategoryID] || {}), CriterionName: e.target.value } }))} />
              </div>
              <div>
                <label className={lbl}>Max points</label>
                <input className={inp} type="number" step="0.01" value={f.MaxPoints ?? 10}
                  onChange={e => setCritForm(s => ({ ...s, [cat.CategoryID]: { ...(s[cat.CategoryID] || {}), MaxPoints: e.target.value } }))} />
              </div>
              <div>
                <label className={lbl}>Weight</label>
                <input className={inp} type="number" step="0.01" value={f.Weight ?? 1}
                  onChange={e => setCritForm(s => ({ ...s, [cat.CategoryID]: { ...(s[cat.CategoryID] || {}), Weight: e.target.value } }))} />
              </div>
              <div className="md:col-span-4 flex gap-2">
                <button type="button" onClick={() => saveCriterion(cat.CategoryID)}
                  className="text-xs bg-[#3D6B34] hover:bg-[#2D5228] text-white px-3 py-1.5 rounded">
                  {f.CriterionID ? 'Save criterion' : 'Add criterion'}
                </button>
                {f.CriterionID && (
                  <button type="button" onClick={() => setCritForm(s => ({ ...s, [cat.CategoryID]: {} }))}
                    className="text-xs px-3 py-1.5 rounded border border-gray-300">Cancel</button>
                )}
              </div>
            </div>
          </div>
        );
      })}
    </div>
  );
}

function JudgesTab({ eventId }) {
  const [judges, setJudges] = useState([]);
  const [categories, setCategories] = useState([]);
  const [form, setForm] = useState({});
  const [copiedId, setCopiedId] = useState(null);

  const copyInvite = async (j) => {
    const url = `${window.location.origin}/judge/${j.AccessCode}`;
    try { await navigator.clipboard.writeText(url); }
    catch { window.prompt('Copy this judge link:', url); }
    setCopiedId(j.JudgeID);
    setTimeout(() => setCopiedId(id => id === j.JudgeID ? null : id), 1500);
  };

  const load = () => Promise.all([
    fetch(`${API}/api/events/${eventId}/competition/judges`).then(r => r.json()),
    fetch(`${API}/api/events/${eventId}/competition/categories`).then(r => r.json()),
  ]).then(([j, c]) => { setJudges(j || []); setCategories(c || []); }).catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const save = async (e) => {
    e.preventDefault();
    if (!form.JudgeName) return;
    const editing = form.JudgeID;
    const url = editing
      ? `${API}/api/events/competition/judges/${editing}`
      : `${API}/api/events/${eventId}/competition/judges`;
    await fetch(url, {
      method: editing ? 'PUT' : 'POST', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ ...form, CategoryID: form.CategoryID || null }),
    });
    setForm({}); load();
  };
  const remove = async (j) => {
    if (!confirm(`Remove ${j.JudgeName}?`)) return;
    await fetch(`${API}/api/events/competition/judges/${j.JudgeID}`, { method: 'DELETE' });
    load();
  };

  return (
    <div className="space-y-4">
      <form onSubmit={save} className="bg-gray-50 rounded-lg p-4 grid grid-cols-1 md:grid-cols-4 gap-3 items-end">
        <div>
          <label className={lbl}>Judge name *</label>
          <input className={inp} required value={form.JudgeName || ''}
            onChange={e => setForm(s => ({ ...s, JudgeName: e.target.value }))} />
        </div>
        <div>
          <label className={lbl}>Email</label>
          <input className={inp} type="email" value={form.Email || ''}
            onChange={e => setForm(s => ({ ...s, Email: e.target.value }))} />
        </div>
        <div>
          <label className={lbl}>Category (or all)</label>
          <select className={inp} value={form.CategoryID || ''}
            onChange={e => setForm(s => ({ ...s, CategoryID: e.target.value }))}>
            <option value="">All categories</option>
            {categories.map(c => <option key={c.CategoryID} value={c.CategoryID}>{c.CategoryName}</option>)}
          </select>
        </div>
        <div>
          <label className={lbl}>Credentials</label>
          <input className={inp} value={form.Credentials || ''}
            onChange={e => setForm(s => ({ ...s, Credentials: e.target.value }))} />
        </div>
        <div className="md:col-span-4 flex gap-2">
          <button type="submit" className="bg-[#3D6B34] hover:bg-[#2D5228] text-white text-sm px-4 py-2 rounded-lg">
            {form.JudgeID ? 'Save' : 'Add judge'}
          </button>
          {form.JudgeID && (
            <button type="button" onClick={() => setForm({})} className="text-sm px-4 py-2 rounded-lg border border-gray-300">Cancel</button>
          )}
        </div>
      </form>

      <div className="border border-gray-200 rounded-lg divide-y divide-gray-100">
        {judges.length === 0 && <div className="p-4 text-sm text-gray-500">No judges yet.</div>}
        {judges.map(j => {
          const cat = categories.find(c => c.CategoryID === j.CategoryID);
          return (
            <div key={j.JudgeID} className="p-3 flex items-center justify-between">
              <div>
                <div className="text-sm font-medium">{j.JudgeName}</div>
                <div className="text-xs text-gray-500">
                  {cat?.CategoryName || 'All categories'}{j.Email ? ` · ${j.Email}` : ''}
                  {j.Credentials && ` · ${j.Credentials}`}
                </div>
                <div className="text-xs text-gray-400 font-mono mt-0.5">Code: {j.AccessCode}</div>
              </div>
              <div className="flex gap-2">
                <button onClick={() => copyInvite(j)} className="text-xs text-[#3D6B34] hover:underline">
                  {copiedId === j.JudgeID ? 'Copied ✓' : 'Copy invite'}
                </button>
                <button onClick={() => setForm(j)} className="text-xs text-[#3D6B34] hover:underline">Edit</button>
                <button onClick={() => remove(j)} className="text-xs text-red-600 hover:underline">Delete</button>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}

function EntriesTab({ eventId }) {
  const [entries, setEntries] = useState([]);
  const [categories, setCategories] = useState([]);
  const [filter, setFilter] = useState('');
  const [form, setForm] = useState({});
  const [scoring, setScoring] = useState(null); // { entry, judges, criteria, scores }

  const load = () => Promise.all([
    fetch(`${API}/api/events/${eventId}/competition/entries`).then(r => r.json()),
    fetch(`${API}/api/events/${eventId}/competition/categories`).then(r => r.json()),
  ]).then(([e, c]) => { setEntries(e || []); setCategories(c || []); }).catch(() => {});
  useEffect(() => { load(); }, [eventId]);

  const save = async (e) => {
    e.preventDefault();
    if (!form.EntrantName || !form.CategoryID) return;
    const editing = form.EntryID;
    const url = editing
      ? `${API}/api/events/competition/entries/${editing}`
      : `${API}/api/events/${eventId}/competition/entries`;
    await fetch(url, {
      method: editing ? 'PUT' : 'POST', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(form),
    });
    setForm({}); load();
  };
  const toggleCheckin = async (en) => {
    await fetch(`${API}/api/events/competition/entries/${en.EntryID}/checkin`, {
      method: 'PUT', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ CheckedIn: !en.CheckedIn }),
    });
    load();
  };
  const remove = async (en) => {
    if (!confirm(`Delete entry for ${en.EntrantName}?`)) return;
    await fetch(`${API}/api/events/competition/entries/${en.EntryID}`, { method: 'DELETE' });
    load();
  };

  const openScore = async (entry) => {
    const [judges, criteria, scores] = await Promise.all([
      fetch(`${API}/api/events/${eventId}/competition/judges`).then(r => r.json()),
      fetch(`${API}/api/events/competition/categories/${entry.CategoryID}/criteria`).then(r => r.json()),
      fetch(`${API}/api/events/competition/entries/${entry.EntryID}/scores`).then(r => r.json()),
    ]);
    const eligibleJudges = (judges || []).filter(j => !j.CategoryID || j.CategoryID === entry.CategoryID);
    setScoring({ entry, judges: eligibleJudges, criteria: criteria || [], scores: scores || [] });
  };

  const filtered = filter ? entries.filter(e => String(e.CategoryID) === filter) : entries;

  return (
    <div className="space-y-4">
      <form onSubmit={save} className="bg-gray-50 rounded-lg p-4 grid grid-cols-1 md:grid-cols-3 gap-3 items-end">
        <div>
          <label className={lbl}>Entrant name *</label>
          <input className={inp} required value={form.EntrantName || ''}
            onChange={e => setForm(s => ({ ...s, EntrantName: e.target.value }))} />
        </div>
        <div>
          <label className={lbl}>Category *</label>
          <select className={inp} required value={form.CategoryID || ''}
            onChange={e => setForm(s => ({ ...s, CategoryID: e.target.value }))}>
            <option value="">—</option>
            {categories.map(c => <option key={c.CategoryID} value={c.CategoryID}>{c.CategoryName}</option>)}
          </select>
        </div>
        <div>
          <label className={lbl}>Entry #</label>
          <input className={inp} value={form.EntryNumber || ''}
            onChange={e => setForm(s => ({ ...s, EntryNumber: e.target.value }))} />
        </div>
        <div>
          <label className={lbl}>Email</label>
          <input className={inp} value={form.EntrantEmail || ''}
            onChange={e => setForm(s => ({ ...s, EntrantEmail: e.target.value }))} />
        </div>
        <div>
          <label className={lbl}>Phone</label>
          <input className={inp} value={form.EntrantPhone || ''}
            onChange={e => setForm(s => ({ ...s, EntrantPhone: e.target.value }))} />
        </div>
        <div>
          <label className={lbl}>Entry title</label>
          <input className={inp} value={form.EntryTitle || ''}
            onChange={e => setForm(s => ({ ...s, EntryTitle: e.target.value }))} />
        </div>
        <div className="md:col-span-3 flex gap-2">
          <button type="submit" className="bg-[#3D6B34] hover:bg-[#2D5228] text-white text-sm px-4 py-2 rounded-lg">
            {form.EntryID ? 'Save entry' : 'Add entry'}
          </button>
          {form.EntryID && (
            <button type="button" onClick={() => setForm({})} className="text-sm px-4 py-2 rounded-lg border border-gray-300">Cancel</button>
          )}
        </div>
      </form>

      <div>
        <label className={lbl}>Filter by category</label>
        <select className={inp + ' max-w-sm'} value={filter} onChange={e => setFilter(e.target.value)}>
          <option value="">All</option>
          {categories.map(c => <option key={c.CategoryID} value={c.CategoryID}>{c.CategoryName}</option>)}
        </select>
      </div>

      <div className="border border-gray-200 rounded-lg overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 text-xs text-gray-500 uppercase">
            <tr>
              <th className="py-2 px-3 text-left">#</th>
              <th className="py-2 px-3 text-left">Entrant</th>
              <th className="py-2 px-3 text-left">Category</th>
              <th className="py-2 px-3 text-left">Check-in</th>
              <th className="py-2 px-3 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filtered.map(en => {
              const cat = categories.find(c => c.CategoryID === en.CategoryID);
              return (
                <tr key={en.EntryID} className={`border-t border-gray-100 ${en.Disqualified ? 'bg-red-50' : ''}`}>
                  <td className="py-2 px-3 font-mono text-xs">{en.EntryNumber || en.EntryID}</td>
                  <td className="py-2 px-3">
                    <div className="font-medium">{en.EntrantName}</div>
                    {en.EntryTitle && <div className="text-xs text-gray-500">{en.EntryTitle}</div>}
                  </td>
                  <td className="py-2 px-3 text-xs">{cat?.CategoryName}</td>
                  <td className="py-2 px-3">
                    <button onClick={() => toggleCheckin(en)}
                      className={`text-xs px-2 py-1 rounded ${en.CheckedIn ? 'bg-[#3D6B34] text-white' : 'bg-gray-100 text-gray-600'}`}>
                      {en.CheckedIn ? 'In' : 'Check in'}
                    </button>
                  </td>
                  <td className="py-2 px-3 text-xs">
                    <button onClick={() => openScore(en)} className="text-[#3D6B34] hover:underline mr-2">Score</button>
                    <button onClick={() => setForm(en)} className="text-[#3D6B34] hover:underline mr-2">Edit</button>
                    <button onClick={() => remove(en)} className="text-red-600 hover:underline">Delete</button>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>

      {scoring && <ScoreModal data={scoring} onClose={() => { setScoring(null); load(); }} />}
    </div>
  );
}

function ScoreModal({ data, onClose }) {
  const { entry, judges, criteria } = data;
  const [scores, setScores] = useState({});
  const [comments, setComments] = useState({});

  useEffect(() => {
    const s = {}; const c = {};
    (data.scores || []).forEach(r => {
      s[`${r.JudgeID}:${r.CriterionID}`] = r.Points;
      c[`${r.JudgeID}:${r.CriterionID}`] = r.Comment || '';
    });
    setScores(s); setComments(c);
  }, [data]);

  const [activeJudge, setActiveJudge] = useState(judges[0]?.JudgeID || null);
  useEffect(() => { if (!activeJudge && judges[0]) setActiveJudge(judges[0].JudgeID); }, [judges]);

  const save = async (crit) => {
    if (!activeJudge) return;
    const key = `${activeJudge}:${crit.CriterionID}`;
    await fetch(`${API}/api/events/competition/entries/${entry.EntryID}/scores`, {
      method: 'POST', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        JudgeID: activeJudge, CriterionID: crit.CriterionID,
        Points: Number(scores[key] || 0), Comment: comments[key] || '',
      }),
    });
  };

  if (!judges.length) return (
    <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-xl p-5 max-w-md">
        <div className="text-sm">No judges assigned to this category yet.</div>
        <button onClick={onClose} className="mt-3 text-sm px-4 py-2 rounded-lg border border-gray-300">Close</button>
      </div>
    </div>
  );

  return (
    <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-xl p-5 max-w-2xl w-full max-h-[90vh] overflow-auto">
        <div className="flex items-center justify-between mb-3">
          <div>
            <div className="text-lg font-semibold text-[#3D6B34]">Score: {entry.EntrantName}</div>
            {entry.EntryTitle && <div className="text-xs text-gray-500">{entry.EntryTitle}</div>}
          </div>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600">✕</button>
        </div>

        <div className="flex gap-2 mb-4 flex-wrap">
          {judges.map(j => (
            <button key={j.JudgeID} onClick={() => setActiveJudge(j.JudgeID)}
              className={`text-xs px-3 py-1 rounded-full border ${activeJudge === j.JudgeID
                ? 'bg-[#3D6B34] text-white border-[#3D6B34]'
                : 'border-gray-300 text-gray-700'}`}>
              {j.JudgeName}
            </button>
          ))}
        </div>

        <div className="space-y-3">
          {criteria.length === 0 && <div className="text-sm text-gray-500">No rubric criteria defined.</div>}
          {criteria.map(crit => {
            const key = `${activeJudge}:${crit.CriterionID}`;
            return (
              <div key={crit.CriterionID} className="border border-gray-200 rounded-lg p-3">
                <div className="flex items-baseline justify-between mb-1">
                  <div className="font-medium text-sm">{crit.CriterionName}</div>
                  <div className="text-xs text-gray-500">max {crit.MaxPoints} · weight {crit.Weight}</div>
                </div>
                <div className="flex gap-2 items-center">
                  <input type="number" step="0.01" min="0" max={crit.MaxPoints}
                    className={inp + ' max-w-[120px]'}
                    value={scores[key] ?? ''}
                    onChange={e => setScores(s => ({ ...s, [key]: e.target.value }))}
                    onBlur={() => save(crit)} />
                  <input className={inp} placeholder="Comment"
                    value={comments[key] || ''}
                    onChange={e => setComments(s => ({ ...s, [key]: e.target.value }))}
                    onBlur={() => save(crit)} />
                </div>
              </div>
            );
          })}
        </div>

        <div className="flex justify-start mt-4">
          <button onClick={onClose} className="bg-[#3D6B34] hover:bg-[#2D5228] text-white text-sm px-5 py-2 rounded-lg">Done</button>
        </div>
      </div>
    </div>
  );
}

function LeaderboardTab({ eventId }) {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/competition/leaderboard`)
      .then(r => r.json()).then(setData).catch(() => setData(null));
  }, [eventId]);

  if (!data) return <div className="text-sm text-gray-500">Loading…</div>;

  return (
    <div className="space-y-5">
      {data.DropHighLow && <div className="text-xs text-gray-500">Using drop-high-low scoring (3+ judges)</div>}
      {data.Leaderboard.length === 0 && <div className="text-sm text-gray-500">No categories yet.</div>}
      {data.Leaderboard.map(cat => (
        <div key={cat.CategoryID} className="border border-gray-200 rounded-lg p-4">
          <div className="font-medium text-sm text-[#3D6B34] mb-3">{cat.CategoryName}</div>
          {cat.Entries.length === 0 ? (
            <div className="text-xs text-gray-500">No entries.</div>
          ) : (
            <table className="w-full text-sm">
              <thead className="text-xs text-gray-500 uppercase">
                <tr>
                  <th className="py-1 text-left w-12">Rank</th>
                  <th className="py-1 text-left">Entrant</th>
                  <th className="py-1 text-right w-24">Judges</th>
                  <th className="py-1 text-right w-24">Score</th>
                </tr>
              </thead>
              <tbody>
                {cat.Entries.map(e => (
                  <tr key={e.EntryID} className="border-t border-gray-100">
                    <td className="py-2 font-semibold">
                      {e.Disqualified ? <span className="text-red-500 text-xs">DQ</span> : (e.Rank || '—')}
                    </td>
                    <td className="py-2">
                      <div>{e.EntrantName}</div>
                      {e.EntryTitle && <div className="text-xs text-gray-500">{e.EntryTitle}</div>}
                    </td>
                    <td className="py-2 text-right text-xs">{e.JudgeCount}</td>
                    <td className="py-2 text-right font-mono">
                      {e.FinalScore != null ? Number(e.FinalScore).toFixed(2) : '—'}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      ))}
    </div>
  );
}

export default function CompetitionAdmin() {
  const { eventId } = useParams();
  const [sp, setSp] = useSearchParams();
  const tab = sp.get('tab') || 'config';
  const [ev, setEv] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEv).catch(() => {});
  }, [eventId]);

  const setTab = (t) => setSp({ tab: t });

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-6xl mx-auto p-4 md:p-6">
        <div className="mb-4">
          <Link to="/account/events" className="text-xs text-gray-500 hover:text-[#3D6B34]">← Events</Link>
          <h1 className="text-2xl font-semibold text-[#3D6B34] mt-1">
            {ev?.EventName || 'Competition'} <span className="text-sm text-gray-400 font-normal">— Competition / Judging</span>
          </h1>
        </div>

        <div className="flex gap-1 border-b border-gray-200 mb-5 overflow-x-auto">
          {[
            ['config', 'Configuration'],
            ['categories', 'Categories + Rubric'],
            ['judges', 'Judges'],
            ['entries', 'Entries + Scoring'],
            ['leaderboard', 'Leaderboard'],
          ].map(([k, label]) => (
            <button key={k} onClick={() => setTab(k)}
              className={`px-4 py-2 text-sm -mb-px border-b-2 whitespace-nowrap ${tab === k ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
              {label}
            </button>
          ))}
        </div>

        {tab === 'config'      && <ConfigTab eventId={eventId} />}
        {tab === 'categories'  && <CategoriesTab eventId={eventId} />}
        {tab === 'judges'      && <JudgesTab eventId={eventId} />}
        {tab === 'entries'     && <EntriesTab eventId={eventId} />}
        {tab === 'leaderboard' && <LeaderboardTab eventId={eventId} />}
      </div>
    </EventAdminLayout>
  );
}
