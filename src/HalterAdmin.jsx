import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";
const btnGhost = "px-4 py-1.5 text-sm border border-gray-300 rounded-lg";

const PLACEMENTS = ['', '1st', '2nd', '3rd', '4th', '5th', '6th',
  'Champion', 'Reserve Champion', 'Honorable Mention', 'Disqualified'];
const BREEDS = ['Huacaya', 'Suri', 'Paco-Vicuna', 'Llama', 'Sheep', 'Goat', 'Other'];
const GENDERS = ['Female', 'Male', 'Gelding', 'Unknown'];
const CLASS_TYPES = ['Halter', 'Production', 'Get of Sire', 'Produce of Dam', 'Color Championship'];

function ConfigTab({ eventId }) {
  const [cfg, setCfg] = useState(null);
  const [saving, setSaving] = useState(false);
  const [msg, setMsg] = useState('');
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/halter/config`).then(r => r.json()).then(setCfg);
  }, [eventId]);
  if (!cfg) return <div className="p-4 text-sm text-gray-500">Loading…</div>;
  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setNum = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  const save = async () => {
    setSaving(true); setMsg('');
    try {
      const r = await fetch(`${API}/api/events/${eventId}/halter/config`, {
        method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(cfg),
      });
      if (!r.ok) throw new Error('save failed');
      setMsg('Saved.');
    } catch { setMsg('Save failed'); }
    finally { setSaving(false); }
  };
  return (
    <div className="space-y-4">
      <div>
        <label className={lbl}>Description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={160} />
      </div>
      <h3 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Fees</h3>
      <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Fee per animal</label>
          <input type="number" step="0.01" value={cfg.FeePerAnimal ?? ''} onChange={setNum('FeePerAnimal')} className={inp} /></div>
        <div><label className={lbl}>Discount fee per animal</label>
          <input type="number" step="0.01" value={cfg.DiscountFeePerAnimal ?? ''} onChange={setNum('DiscountFeePerAnimal')} className={inp} /></div>
        <div><label className={lbl}>Discount ends</label>
          <input type="date" value={(cfg.DiscountEndDate || '').toString().substring(0, 10)} onChange={set('DiscountEndDate')} className={inp} /></div>
        <div><label className={lbl}>Production class fee</label>
          <input type="number" step="0.01" value={cfg.FeePerProductionAnimal ?? ''} onChange={setNum('FeePerProductionAnimal')} className={inp} /></div>
        <div><label className={lbl}>Fee per pen</label>
          <input type="number" step="0.01" value={cfg.FeePerPen ?? ''} onChange={setNum('FeePerPen')} className={inp} /></div>
        <div><label className={lbl}>Vet check fee</label>
          <input type="number" step="0.01" value={cfg.VetCheckFee ?? ''} onChange={setNum('VetCheckFee')} className={inp} /></div>
        <div><label className={lbl}>Electricity fee</label>
          <input type="number" step="0.01" value={cfg.ElectricityFee ?? ''} onChange={setNum('ElectricityFee')} className={inp} /></div>
        <div><label className={lbl}>Stall mat fee</label>
          <input type="number" step="0.01" value={cfg.StallMatFee ?? ''} onChange={setNum('StallMatFee')} className={inp} /></div>
      </div>
      <h3 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Limits & Deadlines</h3>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
        <div><label className={lbl}>Max pens per farm</label>
          <input type="number" value={cfg.MaxPensPerFarm ?? ''} onChange={setNum('MaxPensPerFarm')} className={inp} /></div>
        <div><label className={lbl}>Max juveniles/pen</label>
          <input type="number" value={cfg.MaxJuvenilesPerPen ?? ''} onChange={setNum('MaxJuvenilesPerPen')} className={inp} /></div>
        <div><label className={lbl}>Max adults/pen</label>
          <input type="number" value={cfg.MaxAdultsPerPen ?? ''} onChange={setNum('MaxAdultsPerPen')} className={inp} /></div>
        <div><label className={lbl}>Registration closes</label>
          <input type="date" value={(cfg.RegistrationEndDate || '').toString().substring(0, 10)} onChange={set('RegistrationEndDate')} className={inp} /></div>
      </div>
      <label className="flex items-center gap-2 text-sm">
        <input type="checkbox" checked={!!cfg.IsActive} onChange={(e) => setCfg(c => ({ ...c, IsActive: e.target.checked }))} />
        Show is active
      </label>
      <div className="flex justify-start items-center gap-3 pt-2">
        <button onClick={save} disabled={saving} className={btn}>{saving ? 'Saving…' : 'Save Config'}</button>
        {msg && <span className="text-xs text-gray-500">{msg}</span>}
      </div>
    </div>
  );
}

function ClassesTab({ eventId }) {
  const [classes, setClasses] = useState([]);
  const [editing, setEditing] = useState(null);
  const [adding, setAdding] = useState(false);
  const [seedBreed, setSeedBreed] = useState('Huacaya');
  const [seeding, setSeeding] = useState(false);
  const [err, setErr] = useState('');
  const load = () => fetch(`${API}/api/events/${eventId}/halter/classes`)
    .then(r => r.json()).then(setClasses);
  useEffect(() => { load(); }, [eventId]);

  const save = async (form) => {
    setErr('');
    const url = editing
      ? `${API}/api/events/halter/classes/${editing.ClassID}`
      : `${API}/api/events/${eventId}/halter/classes`;
    const r = await fetch(url, {
      method: editing ? 'PUT' : 'POST',
      headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(form),
    });
    if (!r.ok) { setErr('Save failed'); return; }
    setEditing(null); setAdding(false); load();
  };

  const remove = async (c) => {
    if (!confirm(`Delete class "${c.ClassName}"?`)) return;
    await fetch(`${API}/api/events/halter/classes/${c.ClassID}`, { method: 'DELETE' });
    load();
  };

  const seed = async () => {
    if (!confirm(`Seed standard ${seedBreed} halter classes (17 colors × 4 ages × 2 genders = 136 classes)?`)) return;
    setSeeding(true); setErr('');
    try {
      const r = await fetch(`${API}/api/events/${eventId}/halter/classes/bulk-seed`, {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ Breed: seedBreed, Template: 'alpaca-standard' }),
      });
      if (!r.ok) { const j = await r.json().catch(() => ({})); throw new Error(j.detail || 'seed failed'); }
      load();
    } catch (ex) { setErr(ex.message); }
    finally { setSeeding(false); }
  };

  const grouped = classes.reduce((acc, c) => {
    const b = c.Breed || 'Other';
    (acc[b] ||= []).push(c);
    return acc;
  }, {});

  return (
    <div className="space-y-4">
      {err && <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3">{err}</div>}

      <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 flex flex-wrap items-center gap-2">
        <span className="text-sm text-blue-800 mr-2">Quick seed standard alpaca classes:</span>
        <select value={seedBreed} onChange={(e) => setSeedBreed(e.target.value)} className={inp + " max-w-[160px]"}>
          {['Huacaya', 'Suri', 'Paco-Vicuna'].map(b => <option key={b} value={b}>{b}</option>)}
        </select>
        <button onClick={seed} disabled={seeding} className={btn}>{seeding ? 'Seeding…' : `Seed ${seedBreed}`}</button>
      </div>

      <div className="flex justify-between items-center">
        <h3 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Classes ({classes.length})</h3>
        {!adding && !editing && (
          <button onClick={() => setAdding(true)} className={btn}>+ Add Class</button>
        )}
      </div>

      {(adding || editing) && (
        <ClassForm
          initial={editing || {}}
          onSave={save}
          onCancel={() => { setAdding(false); setEditing(null); }}
        />
      )}

      {Object.entries(grouped).map(([breed, list]) => (
        <div key={breed}>
          <div className="text-xs font-semibold text-gray-500 uppercase mt-3 mb-1">{breed} ({list.length})</div>
          <div className="bg-white border border-gray-200 rounded-lg overflow-hidden">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 text-xs text-gray-500">
                <tr><th className="text-left p-2">Order</th><th className="text-left p-2">Class</th><th className="text-left p-2">Code</th><th className="text-left p-2">Gender</th><th className="text-left p-2">Age</th><th className="text-left p-2">Type</th><th></th></tr>
              </thead>
              <tbody>
                {list.map(c => (
                  <tr key={c.ClassID} className="border-t">
                    <td className="p-2 text-gray-500">{c.DisplayOrder}</td>
                    <td className="p-2 font-medium">{c.ClassName}</td>
                    <td className="p-2 font-mono text-xs">{c.ClassCode}</td>
                    <td className="p-2">{c.Gender}</td>
                    <td className="p-2">{c.AgeGroup}</td>
                    <td className="p-2">{c.ClassType}</td>
                    <td className="p-2 text-right">
                      <button onClick={() => { setEditing(c); setAdding(false); }} className="text-xs text-gray-500 hover:text-gray-800 mr-2">Edit</button>
                      <button onClick={() => remove(c)} className="text-xs text-red-500 hover:text-red-700">Delete</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      ))}
      {classes.length === 0 && <div className="text-sm text-gray-500">No classes yet. Seed or add manually.</div>}
    </div>
  );
}

function ClassForm({ initial, onSave, onCancel }) {
  const [form, setForm] = useState({
    ClassName: initial.ClassName || '', ClassCode: initial.ClassCode || '',
    ShornCode: initial.ShornCode || '', Breed: initial.Breed || 'Huacaya',
    Gender: initial.Gender || 'Female', AgeGroup: initial.AgeGroup || '',
    ClassType: initial.ClassType || 'Halter', DisplayOrder: initial.DisplayOrder || 0,
  });
  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  return (
    <form onSubmit={(e) => { e.preventDefault(); onSave(form); }}
      className="bg-gray-50 border border-gray-200 rounded-lg p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <div><label className={lbl}>Class name</label>
          <input required value={form.ClassName} onChange={set('ClassName')} className={inp} placeholder="e.g. White Juvenile Female" /></div>
        <div><label className={lbl}>Class code</label>
          <input value={form.ClassCode} onChange={set('ClassCode')} className={inp} placeholder="H-WH-JF" /></div>
        <div><label className={lbl}>Shorn code (optional)</label>
          <input value={form.ShornCode} onChange={set('ShornCode')} className={inp} /></div>
        <div><label className={lbl}>Breed</label>
          <select value={form.Breed} onChange={set('Breed')} className={inp}>
            {BREEDS.map(b => <option key={b} value={b}>{b}</option>)}
          </select></div>
        <div><label className={lbl}>Gender</label>
          <select value={form.Gender} onChange={set('Gender')} className={inp}>
            {GENDERS.map(g => <option key={g} value={g}>{g}</option>)}
          </select></div>
        <div><label className={lbl}>Age group</label>
          <input value={form.AgeGroup} onChange={set('AgeGroup')} className={inp} placeholder="6-12 months" /></div>
        <div><label className={lbl}>Class type</label>
          <select value={form.ClassType} onChange={set('ClassType')} className={inp}>
            {CLASS_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
          </select></div>
        <div><label className={lbl}>Display order</label>
          <input type="number" value={form.DisplayOrder} onChange={set('DisplayOrder')} className={inp} /></div>
      </div>
      <div className="flex justify-start gap-2">
        <button type="submit" className={btn}>Save</button>
        <button type="button" onClick={onCancel} className={btnGhost}>Cancel</button>
      </div>
    </form>
  );
}

function RegistrationsTab({ eventId }) {
  const [regs, setRegs] = useState([]);
  const load = () => fetch(`${API}/api/events/${eventId}/halter/registrations`)
    .then(r => r.json()).then(setRegs);
  useEffect(() => { load(); }, [eventId]);

  const togglePaid = async (r) => {
    await fetch(`${API}/api/events/halter/registrations/${r.RegID}`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...r, PaidStatus: r.PaidStatus === 'paid' ? 'pending' : 'paid' }),
    });
    load();
  };
  const toggleCheckin = async (r) => {
    await fetch(`${API}/api/events/halter/registrations/${r.RegID}`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...r, IsCheckedIn: !r.IsCheckedIn }),
    });
    load();
  };

  const totalFee = regs.reduce((s, r) => s + Number(r.Fee || 0), 0);
  const byFarm = regs.reduce((acc, r) => {
    const key = r.BusinessName || `${r.FirstName || ''} ${r.LastName || ''}`.trim() || 'Unknown';
    (acc[key] ||= []).push(r);
    return acc;
  }, {});

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap gap-3 text-sm">
        <div className="bg-white border border-gray-200 rounded-lg px-3 py-2">
          <div className="text-xs text-gray-500">Total animals</div>
          <div className="font-bold text-gray-900">{regs.length}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg px-3 py-2">
          <div className="text-xs text-gray-500">Checked in</div>
          <div className="font-bold text-gray-900">{regs.filter(r => r.IsCheckedIn).length}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg px-3 py-2">
          <div className="text-xs text-gray-500">Paid</div>
          <div className="font-bold text-green-700">{regs.filter(r => r.PaidStatus === 'paid').length}</div>
        </div>
        <div className="bg-white border border-gray-200 rounded-lg px-3 py-2">
          <div className="text-xs text-gray-500">Total fees</div>
          <div className="font-bold text-[#3D6B34]">${totalFee.toFixed(2)}</div>
        </div>
      </div>

      {Object.entries(byFarm).map(([farm, list]) => (
        <div key={farm} className="bg-white border border-gray-200 rounded-lg overflow-hidden">
          <div className="bg-gray-50 px-3 py-2 text-sm font-semibold text-gray-700">{farm} ({list.length})</div>
          <table className="w-full text-sm">
            <thead className="text-xs text-gray-500 border-t">
              <tr>
                <th className="text-left p-2">Animal</th><th className="text-left p-2">Type</th>
                <th className="text-left p-2">Classes</th><th className="text-left p-2">Fee</th>
                <th className="text-center p-2">Check-in</th><th className="text-center p-2">Paid</th>
              </tr>
            </thead>
            <tbody>
              {list.map(r => (
                <tr key={r.RegID} className="border-t">
                  <td className="p-2">
                    <div className="font-medium">{r.AnimalName || `Animal #${r.AnimalID}`}</div>
                    {r.RegisteredName && <div className="text-xs text-gray-500">{r.RegisteredName}</div>}
                  </td>
                  <td className="p-2">
                    <div>{r.RegistrationType}</div>
                    {r.IsShorn && <div className="text-xs text-gray-500">shorn</div>}
                  </td>
                  <td className="p-2 text-xs">
                    {(r.classes || []).map(c => (
                      <div key={c.EntryID}>
                        {c.ClassName}
                        {c.Placement && <span className="ml-1 text-[#3D6B34] font-semibold">• {c.Placement}</span>}
                      </div>
                    ))}
                    {(r.classes || []).length === 0 && <span className="text-gray-400">—</span>}
                  </td>
                  <td className="p-2">${Number(r.Fee || 0).toFixed(2)}</td>
                  <td className="p-2 text-center">
                    <button onClick={() => toggleCheckin(r)}
                      className={`text-[11px] px-2 py-0.5 rounded ${r.IsCheckedIn ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'}`}>
                      {r.IsCheckedIn ? 'Checked in' : 'Check in'}
                    </button>
                  </td>
                  <td className="p-2 text-center">
                    <button onClick={() => togglePaid(r)}
                      className={`text-[11px] px-2 py-0.5 rounded ${r.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                      {r.PaidStatus}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ))}
      {regs.length === 0 && <div className="text-sm text-gray-500">No registrations yet.</div>}
    </div>
  );
}

function JudgingTab({ eventId }) {
  const [classes, setClasses] = useState([]);
  const [selected, setSelected] = useState(null);
  const [entries, setEntries] = useState([]);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/halter/classes`).then(r => r.json()).then(setClasses);
  }, [eventId]);
  const loadEntries = (cid) => {
    setSelected(cid);
    fetch(`${API}/api/events/${eventId}/halter/classes/${cid}/entries`).then(r => r.json()).then(setEntries);
  };
  const save = async (e, patch) => {
    await fetch(`${API}/api/events/halter/entries/${e.EntryID}/judge`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...e, ...patch }),
    });
    loadEntries(selected);
  };
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div className="md:col-span-1">
        <div className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-2">Classes</div>
        <div className="bg-white border border-gray-200 rounded-lg max-h-[500px] overflow-y-auto">
          {classes.map(c => (
            <button key={c.ClassID} onClick={() => loadEntries(c.ClassID)}
              className={`w-full text-left px-3 py-2 text-sm border-b hover:bg-gray-50 ${selected === c.ClassID ? 'bg-[#3D6B34]/10 font-semibold' : ''}`}>
              <div>{c.ClassName}</div>
              <div className="text-xs text-gray-500">{c.Breed} · {c.ClassCode}</div>
            </button>
          ))}
        </div>
      </div>
      <div className="md:col-span-2">
        {!selected && <div className="text-sm text-gray-500">Select a class to judge entries.</div>}
        {selected && entries.length === 0 && <div className="text-sm text-gray-500">No entries in this class.</div>}
        <div className="space-y-2">
          {entries.map(e => (
            <div key={e.EntryID} className="bg-white border border-gray-200 rounded-lg p-3">
              <div className="flex items-start justify-between gap-3">
                <div className="flex-1">
                  <div className="font-medium">{e.AnimalName}</div>
                  <div className="text-xs text-gray-500">
                    {e.BusinessName || `${e.FirstName || ''} ${e.LastName || ''}`.trim()}
                    {e.IsShorn && ' · shorn'}
                    {!e.IsCheckedIn && <span className="text-red-500"> · NOT checked in</span>}
                  </div>
                </div>
                <div className="w-48">
                  <select value={e.Placement || ''}
                    onChange={(ev) => save(e, { Placement: ev.target.value || null })} className={inp}>
                    {PLACEMENTS.map(p => <option key={p} value={p}>{p || '— placement —'}</option>)}
                  </select>
                </div>
              </div>
              <div className="mt-2">
                <label className={lbl}>Judge notes</label>
                <RichTextEditor value={e.JudgeNotes || ''}
                  onChange={(v) => { if (v !== (e.JudgeNotes || '')) save(e, { JudgeNotes: v }); }}
                  minHeight={90} />
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

export default function HalterAdmin() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const BusinessID = params.get('BusinessID');
  const [tab, setTab] = useState(params.get('tab') || 'config');
  const [event, setEvent] = useState(null);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent);
  }, [eventId]);

  const tabs = [
    ['config', 'Config'], ['classes', 'Classes'],
    ['registrations', 'Registrations'], ['judging', 'Judging'],
  ];

  return (
    <div className="max-w-6xl mx-auto px-4 py-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Halter Show Admin</h1>
          <p className="text-sm text-gray-500 mt-1">{event?.EventName || 'Event'}</p>
        </div>
        <Link to={`/events/manage${BusinessID ? `?BusinessID=${BusinessID}` : ''}`}
          className="text-sm text-gray-500 hover:text-gray-700">← Back</Link>
      </div>

      <div className="flex gap-1 border-b border-gray-200 mb-5">
        {tabs.map(([k, label]) => (
          <button key={k} onClick={() => setTab(k)}
            className={`px-4 py-2 text-sm font-medium border-b-2 -mb-px ${tab === k ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
            {label}
          </button>
        ))}
      </div>

      {tab === 'config' && <ConfigTab eventId={eventId} />}
      {tab === 'classes' && <ClassesTab eventId={eventId} />}
      {tab === 'registrations' && <RegistrationsTab eventId={eventId} />}
      {tab === 'judging' && <JudgingTab eventId={eventId} />}
    </div>
  );
}
