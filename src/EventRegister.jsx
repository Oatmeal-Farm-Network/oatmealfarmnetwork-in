import React, { useEffect, useState } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API = import.meta.env.VITE_API_URL || '';

export default function EventRegister() {
  const { eventId } = useParams();
  const navigate = useNavigate();
  const PeopleID = localStorage.getItem('people_id');

  const [ev, setEv] = useState(null);
  const [loading, setLoading] = useState(true);
  const [qtys, setQtys] = useState({});
  const [form, setForm] = useState({
    AttendeeFirstName: '', AttendeeLastName: '', AttendeeEmail: '', AttendeePhone: '', Notes: '',
  });
  const [submitting, setSubmitting] = useState(false);
  const [done, setDone] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`)
      .then(r => r.ok ? r.json() : null)
      .then(d => {
        setEv(d);
        if (d?.options) {
          const init = {};
          d.options.forEach(o => { init[o.OptionID] = 0; });
          setQtys(init);
        }
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, [eventId]);

  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  const setQty = (id, val) => setQtys(q => ({ ...q, [id]: Math.max(0, parseInt(val) || 0) }));

  const total = ev?.options?.reduce((sum, opt) => {
    return sum + (parseFloat(opt.Price) || 0) * (qtys[opt.OptionID] || 0);
  }, 0) || 0;

  const hasOptions = ev?.options?.length > 0;

  const submit = async (e) => {
    e.preventDefault();
    setError('');
    if (!form.AttendeeFirstName || !form.AttendeeLastName || !form.AttendeeEmail) {
      setError('Please fill in your first name, last name, and email.');
      return;
    }

    setSubmitting(true);
    try {
      const items = (ev.options || [])
        .filter(opt => (qtys[opt.OptionID] || 0) > 0)
        .map(opt => ({
          OptionID: opt.OptionID,
          OptionName: opt.OptionName,
          Quantity: qtys[opt.OptionID],
          UnitPrice: parseFloat(opt.Price) || 0,
        }));

      const res = await fetch(`${API}/api/events/${eventId}/register`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          ...form,
          PeopleID: PeopleID ? parseInt(PeopleID) : null,
          items,
        }),
      });
      const data = await res.json();
      if (data.RegID) {
        setDone(data);
      } else {
        setError('Registration failed. Please try again.');
      }
    } catch {
      setError('Something went wrong. Please try again.');
    }
    setSubmitting(false);
  };

  if (loading) return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      <div className="max-w-2xl mx-auto px-4 py-16 text-center text-gray-400">Loading…</div>
      <Footer />
    </div>
  );

  if (!ev) return (
    <div className="min-h-screen bg-white font-sans">
      <Header />
      <div className="max-w-2xl mx-auto px-4 py-16 text-center">
        <p className="text-gray-500 mb-4">Event not found.</p>
        <Link to="/events" className="text-[#3D6B34] hover:underline">← Back to Events</Link>
      </div>
      <Footer />
    </div>
  );

  if (done) return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <Header />
      <div className="max-w-xl mx-auto px-4 py-16 text-center">
        <div className="bg-white rounded-2xl border border-gray-200 p-10 shadow-sm">
          <div className="text-5xl mb-4">✅</div>
          <h1 className="text-2xl font-bold text-gray-800 mb-2">You're Registered!</h1>
          <p className="text-gray-500 mb-1">Registration #{done.RegID}</p>
          <p className="text-gray-700 font-medium mb-4">{ev.EventName}</p>
          {done.TotalAmount > 0 && (
            <p className="text-lg font-bold text-[#3D6B34] mb-6">Total: ${parseFloat(done.TotalAmount).toFixed(2)}</p>
          )}
          <p className="text-sm text-gray-500 mb-6">
            A confirmation will be sent to <strong>{form.AttendeeEmail}</strong>. Contact the organizer with any questions.
          </p>
          <div className="flex gap-3 justify-center">
            <Link to={`/events/${eventId}`} className="text-[#3D6B34] hover:underline text-sm">← Back to Event</Link>
            <Link to="/events" className="text-[#3D6B34] hover:underline text-sm">All Events</Link>
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );

  const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#3D6B34]";
  const lbl = "block text-xs font-medium text-gray-500 mb-1";

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <Header />

      <div className="max-w-2xl mx-auto px-4 py-8">
        {/* Breadcrumb */}
        <div className="text-sm text-gray-500 mb-5 flex items-center gap-1">
          <Link to="/events" className="hover:text-[#3D6B34] hover:underline no-underline text-gray-500">Events</Link>
          <span>/</span>
          <Link to={`/events/${eventId}`} className="hover:text-[#3D6B34] hover:underline no-underline text-gray-500">{ev.EventName}</Link>
          <span>/</span>
          <span className="text-gray-700">Register</span>
        </div>

        <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
          <h1 className="text-xl font-bold text-gray-800 mb-1">Register for Event</h1>
          <p className="text-sm text-gray-500 mb-6">{ev.EventName}</p>

          {error && (
            <div className="bg-red-50 border border-red-200 rounded-lg px-4 py-3 text-sm text-red-700 mb-5">{error}</div>
          )}

          <form onSubmit={submit}>

            {/* Attendee info */}
            <div className="mb-6">
              <h2 className="text-sm font-bold text-gray-600 uppercase tracking-wide mb-3">Your Information</h2>
              <div className="grid grid-cols-2 gap-3 mb-3">
                <div>
                  <label className={lbl}>First Name *</label>
                  <input value={form.AttendeeFirstName} onChange={set('AttendeeFirstName')} className={inp} required />
                </div>
                <div>
                  <label className={lbl}>Last Name *</label>
                  <input value={form.AttendeeLastName} onChange={set('AttendeeLastName')} className={inp} required />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-3 mb-3">
                <div>
                  <label className={lbl}>Email *</label>
                  <input type="email" value={form.AttendeeEmail} onChange={set('AttendeeEmail')} className={inp} required />
                </div>
                <div>
                  <label className={lbl}>Phone</label>
                  <input value={form.AttendeePhone} onChange={set('AttendeePhone')} className={inp} placeholder="Optional" />
                </div>
              </div>
              <div>
                <label className={lbl}>Notes / Special Requests</label>
                <textarea value={form.Notes} onChange={set('Notes')} className={inp} rows={3} placeholder="Any dietary restrictions, accessibility needs, etc." />
              </div>
            </div>

            {/* Options */}
            {hasOptions && (
              <div className="mb-6">
                <h2 className="text-sm font-bold text-gray-600 uppercase tracking-wide mb-3">Registration Options</h2>
                <div className="divide-y divide-gray-100 border border-gray-200 rounded-xl overflow-hidden">
                  {ev.options.map(opt => (
                    <div key={opt.OptionID} className="p-4 flex items-center justify-between gap-4">
                      <div className="flex-grow">
                        <p className="font-medium text-sm text-gray-800">{opt.OptionName}</p>
                        {opt.OptionDescription && <p className="text-xs text-gray-500 mt-0.5">{opt.OptionDescription}</p>}
                        <p className="text-sm font-bold text-[#3D6B34] mt-1">
                          {parseFloat(opt.Price) === 0 ? 'Free' : `$${parseFloat(opt.Price).toFixed(2)}`}
                          {opt.MaxQty && <span className="text-gray-400 font-normal text-xs ml-1">(limit {opt.MaxQty})</span>}
                        </p>
                      </div>
                      <div className="flex items-center gap-2 shrink-0">
                        <button type="button" onClick={() => setQty(opt.OptionID, (qtys[opt.OptionID] || 0) - 1)}
                          className="w-7 h-7 rounded-full border border-gray-300 text-gray-600 hover:bg-gray-50 flex items-center justify-center text-sm">−</button>
                        <span className="w-6 text-center text-sm font-medium">{qtys[opt.OptionID] || 0}</span>
                        <button type="button" onClick={() => setQty(opt.OptionID, (qtys[opt.OptionID] || 0) + 1)}
                          className="w-7 h-7 rounded-full border border-gray-300 text-gray-600 hover:bg-gray-50 flex items-center justify-center text-sm">+</button>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Total */}
            {hasOptions && (
              <div className="flex items-center justify-between py-3 border-t border-gray-200 mb-5">
                <span className="font-bold text-gray-700">Total</span>
                <span className="font-bold text-xl text-[#3D6B34]">${total.toFixed(2)}</span>
              </div>
            )}

            <div className="flex gap-3">
              <button type="submit" disabled={submitting}
                className="flex-grow bg-[#3D6B34] text-white font-bold py-3 rounded-xl hover:bg-[#2d5226] disabled:opacity-50 transition-colors">
                {submitting ? 'Submitting…' : 'Complete Registration'}
              </button>
              <Link to={`/events/${eventId}`}
                className="px-5 py-3 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50 no-underline flex items-center">
                Cancel
              </Link>
            </div>
          </form>
        </div>
      </div>

      <Footer />
    </div>
  );
}
