import React, { useEffect, useState } from 'react';

const API = import.meta.env.VITE_API_URL || '';

function authHeaders() {
  const t = localStorage.getItem('access_token');
  return t ? { Authorization: `Bearer ${t}` } : {};
}

const ROLES = [
  { value: 'exhibitor', label: 'Exhibitor' },
  { value: 'youth',     label: 'Youth / Junior' },
  { value: 'child',     label: 'Child' },
  { value: 'guest',     label: 'Guest / Spectator' },
  { value: 'other',     label: 'Other' },
];

/**
 * Group registration step. Lets the payer add additional people who will be
 * counted in the registration (e.g. parent paying for kids in a junior show,
 * farm registering multiple exhibitors).
 *
 * Props:
 *   cartId    — required, the active cart
 *   payer     — {FirstName, LastName, Email} (read-only display)
 *   onNext / onBack
 */
export default function WizardAttendeesStep({ cartId, payer, businessId, onNext, onBack }) {
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(null);
  const [teamOpen, setTeamOpen] = useState(false);

  const load = () => {
    if (!cartId) return;
    setLoading(true);
    fetch(`${API}/api/events/cart/${cartId}/attendees`, { headers: authHeaders() })
      .then(r => r.json())
      .then(d => setRows(Array.isArray(d) ? d : []))
      .finally(() => setLoading(false));
  };
  useEffect(load, [cartId]);

  const save = async (a) => {
    const isNew = !a.AttendeeID;
    const url = isNew
      ? `${API}/api/events/cart/${cartId}/attendees`
      : `${API}/api/events/cart/attendees/${a.AttendeeID}`;
    const res = await fetch(url, {
      method: isNew ? 'POST' : 'PUT',
      headers: { 'Content-Type': 'application/json', ...authHeaders() },
      body: JSON.stringify(a),
    });
    if (!res.ok) { alert('Save failed'); return; }
    setEditing(null);
    load();
  };

  const remove = async (a) => {
    if (!confirm(`Remove ${a.FirstName || 'attendee'} from this registration?`)) return;
    await fetch(`${API}/api/events/cart/attendees/${a.AttendeeID}`, {
      method: 'DELETE', headers: authHeaders(),
    });
    load();
  };

  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
      <h2 className="text-xl font-semibold text-gray-800 mb-1">Who else is coming?</h2>
      <p className="text-sm text-gray-500 mb-5">
        If you're registering more than one person (kids, family members, employees),
        add them here. Leave blank if it's just you.
      </p>

      <div className="bg-gray-50 border border-gray-200 rounded-lg p-3 mb-5 text-sm">
        <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold mb-1">Payer</div>
        <div className="text-gray-800">
          {[payer?.FirstName, payer?.LastName].filter(Boolean).join(' ') || 'You'}
          {payer?.Email && <span className="text-gray-500"> · {payer.Email}</span>}
        </div>
      </div>

      {loading ? (
        <div className="text-sm text-gray-500 py-4">Loading…</div>
      ) : (
        <div className="space-y-2 mb-4">
          {rows.map(a => (
            <div key={a.AttendeeID} className="border border-gray-200 rounded-lg p-3 flex items-start justify-between gap-3">
              <div className="min-w-0">
                <div className="text-sm font-medium text-gray-800">
                  {[a.FirstName, a.LastName].filter(Boolean).join(' ') || 'Unnamed attendee'}
                  {a.Role && (
                    <span className="ml-2 text-[10px] uppercase bg-gray-100 text-gray-600 rounded px-2 py-0.5">
                      {a.Role}
                    </span>
                  )}
                </div>
                {a.Email && <div className="text-xs text-gray-500">{a.Email}</div>}
                {a.NameTagTitle && <div className="text-xs text-gray-500">Badge: {a.NameTagTitle}</div>}
              </div>
              <div className="flex gap-2 shrink-0">
                <button onClick={() => setEditing(a)} className="text-xs text-[#3D6B34] hover:underline">Edit</button>
                <button onClick={() => remove(a)} className="text-xs text-red-600 hover:underline">Remove</button>
              </div>
            </div>
          ))}
          {rows.length === 0 && (
            <div className="text-sm text-gray-400 py-2 text-center italic">
              No additional attendees yet.
            </div>
          )}
        </div>
      )}

      <div className="flex gap-2">
        <button onClick={() => setEditing({ Role: 'exhibitor' })}
          className="flex-1 border-2 border-dashed border-gray-300 rounded-lg py-3 text-sm text-gray-600 hover:border-[#3D6B34] hover:text-[#3D6B34]">
          + Add another attendee
        </button>
        {businessId && (
          <button onClick={() => setTeamOpen(true)}
            className="px-4 border border-gray-300 rounded-lg text-sm text-gray-700 hover:border-[#3D6B34] hover:text-[#3D6B34]">
            👥 Import from my team
          </button>
        )}
      </div>

      {editing && <AttendeeEditor a={editing} onSave={save} onClose={() => setEditing(null)} />}
      {teamOpen && (
        <TeamPicker
          businessId={businessId}
          existing={rows}
          onPick={async (people) => {
            for (const p of people) {
              await fetch(`${API}/api/events/cart/${cartId}/attendees`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', ...authHeaders() },
                body: JSON.stringify({
                  PeopleID:  p.PeopleID,
                  FirstName: p.FirstName,
                  LastName:  p.LastName,
                  Email:     p.Email,
                  Phone:     p.Phone,
                  Role:      'exhibitor',
                }),
              });
            }
            setTeamOpen(false);
            load();
          }}
          onClose={() => setTeamOpen(false)}
        />
      )}

      <div className="flex justify-between mt-6 pt-4 border-t">
        <button onClick={onBack} className="px-5 py-2 text-sm border border-gray-300 rounded-lg hover:bg-gray-50">
          Back
        </button>
        <button onClick={onNext} className="px-6 py-2 text-sm rounded-lg bg-[#3D6B34] text-white hover:bg-[#2f5226]">
          Continue
        </button>
      </div>
    </div>
  );
}

function AttendeeEditor({ a, onSave, onClose }) {
  const [d, setD] = useState({ ...a });
  const set = (k, v) => setD(p => ({ ...p, [k]: v }));
  return (
    <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-xl max-w-lg w-full p-5">
        <h3 className="text-lg font-semibold text-[#3D6B34] mb-3">
          {a.AttendeeID ? 'Edit attendee' : 'Add attendee'}
        </h3>
        <div className="grid grid-cols-2 gap-3 text-sm">
          <input className="border rounded px-3 py-2" placeholder="First name"
            value={d.FirstName || ''} onChange={e => set('FirstName', e.target.value)} />
          <input className="border rounded px-3 py-2" placeholder="Last name"
            value={d.LastName || ''} onChange={e => set('LastName', e.target.value)} />
          <input className="border rounded px-3 py-2 col-span-2" placeholder="Email (optional)"
            value={d.Email || ''} onChange={e => set('Email', e.target.value)} />
          <input className="border rounded px-3 py-2" placeholder="Phone (optional)"
            value={d.Phone || ''} onChange={e => set('Phone', e.target.value)} />
          <select className="border rounded px-3 py-2" value={d.Role || 'exhibitor'}
            onChange={e => set('Role', e.target.value)}>
            {ROLES.map(r => <option key={r.value} value={r.value}>{r.label}</option>)}
          </select>
          <input className="border rounded px-3 py-2 col-span-2"
            placeholder="Badge / nametag title (optional)"
            value={d.NameTagTitle || ''} onChange={e => set('NameTagTitle', e.target.value)} />
          <input className="border rounded px-3 py-2" type="date"
            value={(d.DateOfBirth || '').substring(0, 10)}
            onChange={e => set('DateOfBirth', e.target.value)}
            placeholder="Date of birth (for youth divisions)" />
          <input className="border rounded px-3 py-2" placeholder="Notes"
            value={d.Notes || ''} onChange={e => set('Notes', e.target.value)} />
        </div>
        <div className="flex justify-end gap-2 mt-5">
          <button onClick={onClose} className="text-sm px-4 py-2 rounded border border-gray-300">Cancel</button>
          <button onClick={() => onSave(d)} className="text-sm px-4 py-2 rounded bg-[#3D6B34] text-white">
            {a.AttendeeID ? 'Save' : 'Add'}
          </button>
        </div>
      </div>
    </div>
  );
}

function TeamPicker({ businessId, existing, onPick, onClose }) {
  const [team, setTeam] = useState([]);
  const [loading, setLoading] = useState(true);
  const [picked, setPicked] = useState({});
  const existingEmails = new Set((existing || []).map(a => (a.Email || '').toLowerCase()).filter(Boolean));

  useEffect(() => {
    fetch(`${API}/api/businesses/${businessId}/team`, { headers: authHeaders() })
      .then(r => r.ok ? r.json() : [])
      .then(d => setTeam(Array.isArray(d) ? d : []))
      .finally(() => setLoading(false));
  }, [businessId]);

  const toggle = (pid) => setPicked(p => ({ ...p, [pid]: !p[pid] }));
  const chosen = team.filter(t => picked[t.PeopleID]);

  return (
    <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-xl max-w-lg w-full p-5">
        <h3 className="text-lg font-semibold text-[#3D6B34] mb-2">Import from my team</h3>
        <p className="text-xs text-gray-500 mb-3">
          People with access to this business. Already-added attendees are dimmed.
        </p>
        {loading ? (
          <div className="py-6 text-center text-sm text-gray-500">Loading…</div>
        ) : team.length === 0 ? (
          <div className="py-6 text-center text-sm text-gray-500">No team members found.</div>
        ) : (
          <div className="max-h-72 overflow-y-auto border border-gray-200 rounded-lg">
            {team.map(p => {
              const already = existingEmails.has((p.Email || '').toLowerCase());
              return (
                <label key={p.PeopleID}
                  className={`flex items-center gap-3 px-3 py-2 border-b border-gray-100 text-sm
                    ${already ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer hover:bg-gray-50'}`}>
                  <input type="checkbox" disabled={already}
                    checked={!!picked[p.PeopleID]}
                    onChange={() => !already && toggle(p.PeopleID)} />
                  <div className="min-w-0 flex-1">
                    <div className="text-gray-800">
                      {[p.FirstName, p.LastName].filter(Boolean).join(' ') || '(no name)'}
                      {already && <span className="ml-2 text-[10px] text-gray-400">already added</span>}
                    </div>
                    {p.Email && <div className="text-xs text-gray-500">{p.Email}</div>}
                  </div>
                </label>
              );
            })}
          </div>
        )}
        <div className="flex justify-end gap-2 mt-4">
          <button onClick={onClose}
            className="text-sm px-4 py-2 rounded border border-gray-300">Cancel</button>
          <button onClick={() => onPick(chosen)}
            disabled={chosen.length === 0}
            className="text-sm px-4 py-2 rounded bg-[#3D6B34] text-white disabled:opacity-50">
            Add {chosen.length || ''}
          </button>
        </div>
      </div>
    </div>
  );
}
