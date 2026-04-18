import React, { useEffect, useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

export default function EventClone() {
  const { eventId } = useParams();
  const navigate = useNavigate();
  const [src, setSrc] = useState(null);
  const [loading, setLoading] = useState(true);
  const [err, setErr] = useState(null);
  const [newName, setNewName] = useState('');
  const [newStart, setNewStart] = useState('');
  const [newEnd, setNewEnd] = useState('');
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`)
      .then(r => r.ok ? r.json() : Promise.reject(new Error('Event not found')))
      .then(d => {
        setSrc(d);
        setNewName(`${d.EventName} (Copy)`);
      })
      .catch(e => setErr(e.message))
      .finally(() => setLoading(false));
  }, [eventId]);

  const submit = async (e) => {
    e.preventDefault();
    setErr(null);
    setSaving(true);
    try {
      const body = { EventName: newName };
      if (newStart) body.EventStartDate = newStart;
      if (newEnd)   body.EventEndDate = newEnd;
      const r = await fetch(`${API}/api/events/${eventId}/clone`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      });
      if (!r.ok) throw new Error((await r.json().catch(() => ({}))).detail || 'Clone failed');
      const { EventID } = await r.json();
      navigate(`/events/${EventID}/dashboard`);
    } catch (ex) {
      setErr(ex.message);
    } finally {
      setSaving(false);
    }
  };

  return (
    <AccountLayout>
      <div className="max-w-2xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6 flex-wrap gap-3">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Clone Event</h1>
            <p className="text-sm text-gray-500 mt-1">
              Duplicate this event and all its configuration (classes, options, menu, slots, lots, etc.).
              The new event starts unpublished.
            </p>
          </div>
          <Link to={`/events/${eventId}/dashboard`} className="text-sm text-gray-500 hover:text-gray-700">
            ← Back to dashboard
          </Link>
        </div>

        {loading && <div className="text-sm text-gray-500">Loading…</div>}

        {src && (
          <section className="bg-white border border-gray-200 rounded-xl p-6">
            <div className="bg-[#f6f8f3] border border-[#3D6B34]/20 rounded-lg px-4 py-3 mb-6">
              <div className="text-xs text-gray-500 uppercase tracking-wide">Source event</div>
              <div className="font-semibold text-gray-800">{src.EventName}</div>
              <div className="text-xs text-gray-500 mt-1">{src.EventType}</div>
            </div>

            {err && (
              <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">
                {err}
              </div>
            )}

            <form onSubmit={submit} className="space-y-5">
              <div>
                <label className={lbl}>New Event Name</label>
                <input value={newName} onChange={(e) => setNewName(e.target.value)}
                       className={inp} required />
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className={lbl}>Start Date (optional — reuses source if blank)</label>
                  <input type="date" value={newStart} onChange={(e) => setNewStart(e.target.value)} className={inp} />
                </div>
                <div>
                  <label className={lbl}>End Date (optional)</label>
                  <input type="date" value={newEnd} onChange={(e) => setNewEnd(e.target.value)} className={inp} />
                </div>
              </div>

              <div className="bg-amber-50 border border-amber-200 rounded-lg p-3 text-xs text-amber-700">
                <strong>What's copied:</strong> event details, configuration, classes, options, menu, slots, lots — everything except registrations. The copy is saved as unpublished so you can tweak it before going live.
              </div>

              <div className="flex justify-end items-center gap-3 pt-2">
                <Link to={`/events/${eventId}/dashboard`}
                      className="px-5 py-2 rounded-lg border border-gray-200 text-sm text-gray-600 hover:bg-gray-50 no-underline">
                  Cancel
                </Link>
                <button type="submit" disabled={saving || !newName.trim()}
                        className="bg-[#3D6B34] text-white font-semibold px-6 py-2 rounded-lg hover:bg-[#2d5226] disabled:opacity-50">
                  {saving ? 'Cloning…' : 'Clone Event'}
                </button>
              </div>
            </form>
          </section>
        )}
      </div>
    </AccountLayout>
  );
}
