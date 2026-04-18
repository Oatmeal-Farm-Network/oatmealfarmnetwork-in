import React, { useEffect, useState } from 'react';
import { useSearchParams, useNavigate, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

const EMPTY_FORM = {
  EventName: '', EventDescription: '', EventType: '', EventStartDate: '', EventEndDate: '',
  EventImage: '', EventLocationName: '', EventLocationStreet: '', EventLocationCity: '',
  EventLocationState: '', EventLocationZip: '', EventContactEmail: '', EventPhone: '',
  EventWebsite: '', IsPublished: true, IsFree: true, RegistrationRequired: false, MaxAttendees: '',
};

export default function EventAddDetails() {
  const [params] = useSearchParams();
  const navigate = useNavigate();
  const BusinessID = params.get('BusinessID');
  const typeFromUrl = params.get('type') || '';

  const [form, setForm] = useState({ ...EMPTY_FORM, EventType: typeFromUrl });
  const [saving, setSaving] = useState(false);
  const [err, setErr] = useState(null);

  useEffect(() => {
    if (!typeFromUrl) {
      navigate(`/events/add?BusinessID=${BusinessID || ''}`, { replace: true });
    }
  }, [typeFromUrl, BusinessID, navigate]);

  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  const setB = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.checked }));

  const save = async (e) => {
    e.preventDefault();
    setErr(null);
    if (!BusinessID) { setErr('Missing BusinessID in URL'); return; }
    if (!form.EventName || !form.EventType) { setErr('Event Name and Event Type are required'); return; }
    setSaving(true);
    try {
      const peopleId = localStorage.getItem('people_id');
      const r = await fetch(`${API}/api/events`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, BusinessID: Number(BusinessID), PeopleID: peopleId ? Number(peopleId) : null }),
      });
      if (!r.ok) throw new Error((await r.json().catch(() => ({}))).detail || 'Save failed');
      const { EventID } = await r.json();
      navigate(`/events/${EventID}/dashboard`);
    } catch (ex) {
      setErr(ex.message);
    } finally {
      setSaving(false);
    }
  };

  const backToPicker = `/events/add?BusinessID=${BusinessID || ''}`;

  return (
    <AccountLayout>
      <div className="max-w-4xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6 flex-wrap gap-3">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Add Event — Details</h1>
            <p className="text-sm text-gray-500 mt-1">
              <span className="text-[#3D6B34] font-semibold">Step 2 of 2</span> · Enter the details for your new event.
            </p>
          </div>
          <Link to={backToPicker} className="text-sm text-gray-500 hover:text-gray-700">
            ← Back to type picker
          </Link>
        </div>

        {/* Selected type banner */}
        <div className="bg-[#f6f8f3] border border-[#3D6B34]/20 rounded-lg px-4 py-3 flex items-center gap-3 mb-6">
          <div className="flex-1 min-w-0">
            <div className="text-xs text-gray-500 uppercase tracking-wide">Event Type</div>
            <div className="font-semibold text-gray-800">{form.EventType}</div>
          </div>
          <Link to={backToPicker} className="text-xs text-[#3D6B34] hover:underline font-semibold shrink-0">
            Change type
          </Link>
        </div>

        <section className="bg-white border border-gray-200 rounded-xl p-6">
          {err && (
            <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">
              {err}
            </div>
          )}
          <form onSubmit={save} className="space-y-5">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="md:col-span-2">
                <label className={lbl}>Event Name</label>
                <input value={form.EventName} onChange={set('EventName')} className={inp} required placeholder="e.g. Summer Farm Tour" />
              </div>
              <div className="md:col-span-2">
                <label className={lbl}>Event Image URL</label>
                <input value={form.EventImage} onChange={set('EventImage')} className={inp} placeholder="https://…" />
              </div>
              <div>
                <label className={lbl}>Start Date</label>
                <input type="date" value={form.EventStartDate ? form.EventStartDate.substring(0,10) : ''} onChange={set('EventStartDate')} className={inp} />
              </div>
              <div>
                <label className={lbl}>End Date</label>
                <input type="date" value={form.EventEndDate ? form.EventEndDate.substring(0,10) : ''} onChange={set('EventEndDate')} className={inp} />
              </div>
              <div className="md:col-span-2">
                <label className={lbl}>Description</label>
                <RichTextEditor value={form.EventDescription}
                  onChange={(v) => setForm(f => ({ ...f, EventDescription: v }))} minHeight={200} />
              </div>
            </div>

            <div>
              <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-3">Location</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                <div className="md:col-span-2">
                  <label className={lbl}>Venue Name</label>
                  <input value={form.EventLocationName} onChange={set('EventLocationName')} className={inp} />
                </div>
                <div className="md:col-span-2">
                  <label className={lbl}>Street Address</label>
                  <input value={form.EventLocationStreet} onChange={set('EventLocationStreet')} className={inp} />
                </div>
                <div>
                  <label className={lbl}>City</label>
                  <input value={form.EventLocationCity} onChange={set('EventLocationCity')} className={inp} />
                </div>
                <div>
                  <label className={lbl}>State</label>
                  <input value={form.EventLocationState} onChange={set('EventLocationState')} className={inp} placeholder="e.g. OR" />
                </div>
                <div>
                  <label className={lbl}>ZIP</label>
                  <input value={form.EventLocationZip} onChange={set('EventLocationZip')} className={inp} />
                </div>
              </div>
            </div>

            <div>
              <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-3">Contact</h3>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                <div>
                  <label className={lbl}>Email</label>
                  <input type="email" value={form.EventContactEmail} onChange={set('EventContactEmail')} className={inp} />
                </div>
                <div>
                  <label className={lbl}>Phone</label>
                  <input value={form.EventPhone} onChange={set('EventPhone')} className={inp} />
                </div>
                <div>
                  <label className={lbl}>Website</label>
                  <input value={form.EventWebsite} onChange={set('EventWebsite')} className={inp} placeholder="https://…" />
                </div>
              </div>
            </div>

            <div>
              <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-3">Settings</h3>
              <div className="flex flex-wrap gap-6">
                <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
                  <input type="checkbox" checked={form.IsPublished} onChange={setB('IsPublished')} className="w-4 h-4 accent-green-600" />
                  Published (visible to public)
                </label>
                <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
                  <input type="checkbox" checked={form.IsFree} onChange={setB('IsFree')} className="w-4 h-4 accent-green-600" />
                  Free Event
                </label>
                <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
                  <input type="checkbox" checked={form.RegistrationRequired} onChange={setB('RegistrationRequired')} className="w-4 h-4 accent-green-600" />
                  Registration Required
                </label>
                <div>
                  <label className={lbl}>Max Attendees</label>
                  <input type="number" min="1" value={form.MaxAttendees} onChange={set('MaxAttendees')} className={`${inp} w-28`} placeholder="Unlimited" />
                </div>
              </div>
            </div>

            <div className="flex justify-end items-center gap-3 pt-2">
              <Link to={backToPicker}
                className="px-5 py-2 rounded-lg border border-gray-200 text-sm text-gray-600 hover:bg-gray-50 no-underline">
                Cancel
              </Link>
              <button type="submit" disabled={saving}
                className="bg-[#3D6B34] text-white font-semibold px-6 py-2 rounded-lg hover:bg-[#2d5226] disabled:opacity-50">
                {saving ? 'Saving…' : 'Save Event'}
              </button>
            </div>
          </form>
        </section>
      </div>
    </AccountLayout>
  );
}
