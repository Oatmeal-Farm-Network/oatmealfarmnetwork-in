import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import { useAccount } from './AccountContext';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

const EMPTY_ENTRY = {
  FleeceName: '',
  Breed: '',
  Color: '',
  Micron: '',
  StapleLength: '',
  SourceAnimalID: '',
  DivisionID: '',
  Description: '',
};

function EntryForm({ initial, onSave, onCancel, animals, divisions, saving }) {
  const [form, setForm] = useState(initial || EMPTY_ENTRY);
  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  return (
    <form onSubmit={(e) => { e.preventDefault(); onSave(form); }} className="space-y-4 bg-gray-50 border border-gray-200 rounded-lg p-4">
      <div>
        <label className={lbl}>Fleece / animal name</label>
        <input value={form.FleeceName} onChange={set('FleeceName')} required className={inp} placeholder="e.g. Aspen's 2026 blanket" />
      </div>
      {divisions.length > 0 && (
        <div>
          <label className={lbl}>Division</label>
          <select value={form.DivisionID} onChange={set('DivisionID')} className={inp}>
            <option value="">-- None --</option>
            {divisions.map(d_ => (
              <option key={d_.DivisionID} value={d_.DivisionID}>
                {d_.DivisionName}
                {d_.BreedGroup && ` — ${d_.BreedGroup}`}
                {d_.AgeGroup && ` (${d_.AgeGroup})`}
              </option>
            ))}
          </select>
        </div>
      )}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div>
          <label className={lbl}>Breed</label>
          <input value={form.Breed} onChange={set('Breed')} className={inp} placeholder="Huacaya, Suri, Merino…" />
        </div>
        <div>
          <label className={lbl}>Color</label>
          <input value={form.Color} onChange={set('Color')} className={inp} placeholder="White, Fawn, Black…" />
        </div>
        <div>
          <label className={lbl}>Source animal (optional)</label>
          <select value={form.SourceAnimalID} onChange={set('SourceAnimalID')} className={inp}>
            <option value="">-- None --</option>
            {animals.map(a => <option key={a.ID ?? a.AnimalID} value={a.ID ?? a.AnimalID}>{a.FullName || a.AnimalName}</option>)}
          </select>
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <div>
          <label className={lbl}>Micron (optional)</label>
          <input value={form.Micron} onChange={set('Micron')} className={inp} placeholder="e.g. 22.4" />
        </div>
        <div>
          <label className={lbl}>Staple length (optional)</label>
          <input value={form.StapleLength} onChange={set('StapleLength')} className={inp} placeholder='e.g. 4.5"' />
        </div>
      </div>
      <div>
        <label className={lbl}>Notes</label>
        <RichTextEditor value={form.Description || ''}
          onChange={(v) => setForm(f => ({ ...f, Description: v }))} minHeight={120} />
      </div>
      <div className="flex justify-end gap-2">
        <button type="button" onClick={onCancel} className="px-4 py-1.5 text-sm border border-gray-300 rounded-lg">Cancel</button>
        <button type="submit" disabled={saving} className="px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg disabled:opacity-50">
          {saving ? 'Saving…' : 'Save Fleece'}
        </button>
      </div>
    </form>
  );
}

export default function FleeceRegister() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const { BusinessID: ctxBusinessID } = useAccount() || {};
  const BusinessID = params.get('BusinessID') || ctxBusinessID;
  const peopleId = Number(localStorage.getItem('people_id')) || null;

  const [event, setEvent] = useState(null);
  const [cfg, setCfg] = useState(null);
  const [entries, setEntries] = useState([]);
  const [animals, setAnimals] = useState([]);
  const [divisions, setDivisions] = useState([]);
  const [adding, setAdding] = useState(false);
  const [editing, setEditing] = useState(null);
  const [saving, setSaving] = useState(false);
  const [err, setErr] = useState('');

  const loadEntries = () => peopleId
    ? fetch(`${API}/api/events/${eventId}/fleece/entries?people_id=${peopleId}`).then(r => r.json()).then(setEntries).catch(() => {})
    : Promise.resolve();

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
    fetch(`${API}/api/events/${eventId}/fleece/config`).then(r => r.json()).then(setCfg).catch(() => {});
    fetch(`${API}/api/events/${eventId}/fleece/divisions`).then(r => r.ok ? r.json() : []).then(d_ => setDivisions(Array.isArray(d_) ? d_ : [])).catch(() => {});
    loadEntries();
    if (BusinessID) {
      fetch(`${API}/auth/animals?BusinessID=${BusinessID}`)
        .then(r => r.ok ? r.json() : [])
        .then(a => setAnimals(Array.isArray(a) ? a : []))
        .catch(() => {});
    }
  }, [eventId, BusinessID, peopleId]);

  const save = async (form) => {
    setErr('');
    setSaving(true);
    try {
      const body = {
        ...form,
        SourceAnimalID: form.SourceAnimalID ? Number(form.SourceAnimalID) : null,
        DivisionID: form.DivisionID ? Number(form.DivisionID) : null,
        PeopleID: peopleId,
        BusinessID: BusinessID ? Number(BusinessID) : null,
      };
      const r = editing
        ? await fetch(`${API}/api/events/fleece/entries/${editing.EntryID}`, {
            method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body),
          })
        : await fetch(`${API}/api/events/${eventId}/fleece/entries`, {
            method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body),
          });
      if (!r.ok) {
        const j = await r.json().catch(() => ({}));
        throw new Error(j.detail || 'Save failed');
      }
      setAdding(false);
      setEditing(null);
      loadEntries();
    } catch (ex) {
      setErr(ex.message);
    } finally {
      setSaving(false);
    }
  };

  const remove = async (entry) => {
    if (!confirm(`Remove "${entry.FleeceName || 'fleece'}"?`)) return;
    await fetch(`${API}/api/events/fleece/entries/${entry.EntryID}`, { method: 'DELETE' });
    loadEntries();
  };

  const total = entries.reduce((s, e) => s + Number(e.EntryFee || 0), 0);
  const configured = cfg?.configured;
  const closed = configured && cfg?.RegistrationEndDate && new Date(cfg.RegistrationEndDate) < new Date();
  const notYetOpen = configured && cfg?.RegistrationStartDate && new Date(cfg.RegistrationStartDate) > new Date();

  return (
    <div className="max-w-4xl mx-auto px-4 py-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Enter the Fleece Show</h1>
          <p className="text-sm text-gray-500 mt-1">
            {event?.EventName || 'Event'}
            {event?.EventLocationCity && ` — ${event.EventLocationCity}, ${event.EventLocationState}`}
          </p>
        </div>
        <Link to={`/events/${eventId}`} className="text-sm text-gray-500 hover:text-gray-700">← Back to Event</Link>
      </div>

      {!configured && (
        <div className="bg-yellow-50 border border-yellow-200 text-yellow-800 text-sm rounded-lg p-4 mb-4">
          The fleece show has not yet been configured by the organizer.
        </div>
      )}

      {configured && (
        <>
          {cfg.Description && (
            <div className="bg-white border border-gray-200 rounded-xl p-4 mb-4 whitespace-pre-wrap text-sm text-gray-700">
              {cfg.Description}
            </div>
          )}

          <div className="grid grid-cols-2 sm:grid-cols-4 gap-2 mb-4 text-xs">
            <div className="bg-white border border-gray-200 rounded-lg p-3">
              <div className="text-gray-500">Fee per fleece</div>
              <div className="font-semibold text-gray-900 text-base">${Number(cfg.CurrentFee || cfg.FeePerFleece || 0).toFixed(2)}</div>
              {cfg.DiscountFeePerFleece != null && cfg.DiscountEndDate && (
                <div className="text-[11px] text-gray-400">
                  discount ends {String(cfg.DiscountEndDate).substring(0, 10)}
                </div>
              )}
            </div>
            {cfg.MaxFleecesPerRegistrant && (
              <div className="bg-white border border-gray-200 rounded-lg p-3">
                <div className="text-gray-500">Max per registrant</div>
                <div className="font-semibold text-gray-900 text-base">{entries.length} / {cfg.MaxFleecesPerRegistrant}</div>
              </div>
            )}
            {cfg.RegistrationEndDate && (
              <div className="bg-white border border-gray-200 rounded-lg p-3">
                <div className="text-gray-500">Registration closes</div>
                <div className="font-semibold text-gray-900 text-base">{String(cfg.RegistrationEndDate).substring(0, 10)}</div>
              </div>
            )}
            <div className="bg-white border border-gray-200 rounded-lg p-3">
              <div className="text-gray-500">Your total</div>
              <div className="font-semibold text-[#3D6B34] text-base">${total.toFixed(2)}</div>
            </div>
          </div>

          {notYetOpen && (
            <div className="bg-blue-50 border border-blue-200 text-blue-700 text-sm rounded-lg p-3 mb-4">
              Registration opens {String(cfg.RegistrationStartDate).substring(0, 10)}.
            </div>
          )}
          {closed && (
            <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">
              Registration for this fleece show has closed.
            </div>
          )}

          {err && <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">{err}</div>}

          <div className="flex justify-between items-center mb-3">
            <h2 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Your fleeces</h2>
            {!adding && !editing && !closed && !notYetOpen && peopleId && (
              <button onClick={() => setAdding(true)} className="text-sm bg-[#3D6B34] text-white px-4 py-1.5 rounded-lg hover:bg-[#2d5226]">
                + Add Fleece
              </button>
            )}
          </div>

          {!peopleId && (
            <div className="bg-yellow-50 border border-yellow-200 text-yellow-800 text-sm rounded-lg p-3 mb-3">
              Please <Link to="/login" className="underline">log in</Link> to submit fleeces.
            </div>
          )}

          {(adding || editing) && (
            <EntryForm
              initial={editing || EMPTY_ENTRY}
              onSave={save}
              onCancel={() => { setAdding(false); setEditing(null); }}
              animals={animals}
              divisions={divisions}
              saving={saving}
            />
          )}

          <div className="space-y-2 mt-3">
            {entries.length === 0 && !adding && peopleId && (
              <div className="text-sm text-gray-500">You have no fleeces entered yet.</div>
            )}
            {entries.map(e => (
              <div key={e.EntryID} className="bg-white border border-gray-200 rounded-lg p-3">
                <div className="flex items-start justify-between gap-3">
                  <div className="flex-1">
                    <div className="font-medium text-gray-900">{e.FleeceName || e.AnimalName}</div>
                    <div className="text-xs text-gray-500 mt-0.5">
                      {[e.DivisionName, e.Breed, e.Color, e.Micron && `${e.Micron}μ`, e.StapleLength].filter(Boolean).join(' • ')}
                    </div>
                    {e.Description && <div className="text-xs text-gray-600 mt-1">{e.Description}</div>}
                    {e.Placement && <div className="text-xs font-semibold text-[#3D6B34] mt-1">🏆 {e.Placement}{e.Score != null && ` • Score ${e.Score}`}</div>}
                    {e.JudgeNotes && <div className="text-xs italic text-gray-500 mt-0.5">Judge: {e.JudgeNotes}</div>}
                  </div>
                  <div className="flex flex-col items-end gap-1">
                    <div className="text-sm font-medium">${Number(e.EntryFee || 0).toFixed(2)}</div>
                    <div className={`text-[11px] px-2 py-0.5 rounded ${e.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                      {e.PaidStatus || 'pending'}
                    </div>
                    {!closed && (
                      <div className="flex gap-2 mt-1">
                        <button onClick={() => { setEditing(e); setAdding(false); }} className="text-xs text-gray-500 hover:text-gray-800">Edit</button>
                        <button onClick={() => remove(e)} className="text-xs text-red-500 hover:text-red-700">Remove</button>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
