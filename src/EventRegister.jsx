import React, { useEffect, useState } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';
import RichTextEditor from './RichTextEditor';
import ThaiymeChat from './ThaiymeChat';

const API = import.meta.env.VITE_API_URL || '';

function formatDate(d) {
  if (!d) return '';
  return new Date(d).toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
}

const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#3D6B34]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";

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
  const [step, setStep] = useState(1); // 1 = fill form, 2 = review, 3 = done
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

  const selectedItems = (ev?.options || []).filter(opt => (qtys[opt.OptionID] || 0) > 0);
  const total = selectedItems.reduce((sum, opt) => sum + (parseFloat(opt.Price) || 0) * (qtys[opt.OptionID] || 0), 0);
  const hasOptions = ev?.options?.length > 0;

  const goToReview = (e) => {
    e.preventDefault();
    setError('');
    if (!form.AttendeeFirstName || !form.AttendeeLastName || !form.AttendeeEmail) {
      setError('Please fill in your first name, last name, and email.');
      return;
    }
    setStep(2);
    window.scrollTo(0, 0);
  };

  const submit = async () => {
    setError('');
    setSubmitting(true);
    try {
      const items = selectedItems.map(opt => ({
        OptionID: opt.OptionID,
        OptionName: opt.OptionName,
        Quantity: qtys[opt.OptionID],
        UnitPrice: parseFloat(opt.Price) || 0,
      }));
      const res = await fetch(`${API}/api/events/${eventId}/register`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, PeopleID: PeopleID ? parseInt(PeopleID) : null, items }),
      });
      const data = await res.json();
      if (data.RegID) {
        setDone(data);
        setStep(3);
        window.scrollTo(0, 0);
      } else {
        setError('Registration failed. Please try again.');
        setStep(1);
      }
    } catch {
      setError('Something went wrong. Please try again.');
      setStep(1);
    }
    setSubmitting(false);
  };

  if (loading) return (
    <div className="min-h-screen font-sans"><Header />
      <div className="max-w-2xl mx-auto px-4 py-16 text-center text-gray-400">Loading…</div>
      <Footer />
    </div>
  );

  if (!ev) return (
    <div className="min-h-screen font-sans"><Header />
      <div className="max-w-2xl mx-auto px-4 py-16 text-center">
        <p className="text-gray-500 mb-4">Event not found.</p>
        <Link to="/events" className="text-[#3D6B34] hover:underline">← Back to Events</Link>
      </div>
      <Footer />
    </div>
  );

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <PageMeta
        title={`Register for ${ev.EventName}`}
        description={`Register for ${ev.EventName} on Oatmeal Farm Network.`}
        canonical={`https://oatmealfarmnetwork.com/events/${eventId}/register`}
        noIndex
      />
      <Header />

      <div className="max-w-2xl mx-auto px-4 py-8">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Events', to: '/events' },
          { label: ev.EventName, to: `/events/${eventId}` },
          { label: 'Register' },
        ]} />

        {/* Step indicator */}
        <div className="flex items-center gap-2 mb-6">
          {['Your Info', 'Review Order', 'Confirmed'].map((label, i) => (
            <React.Fragment key={i}>
              <div className={`flex items-center gap-2 ${step === i + 1 ? 'text-[#3D6B34]' : step > i + 1 ? 'text-green-600' : 'text-gray-400'}`}>
                <div className={`w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold border-2 ${
                  step > i + 1 ? 'bg-green-600 border-green-600 text-white'
                  : step === i + 1 ? 'border-[#3D6B34] text-[#3D6B34]'
                  : 'border-gray-300 text-gray-400'
                }`}>
                  {step > i + 1 ? '✓' : i + 1}
                </div>
                <span className="text-xs font-medium hidden sm:inline">{label}</span>
              </div>
              {i < 2 && <div className={`flex-1 h-px ${step > i + 1 ? 'bg-green-300' : 'bg-gray-200'}`} />}
            </React.Fragment>
          ))}
        </div>

        {error && (
          <div className="bg-red-50 border border-red-200 rounded-lg px-4 py-3 text-sm text-red-700 mb-5">{error}</div>
        )}

        {/* ── STEP 1: Fill out form ── */}
        {step === 1 && (
          <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
            <h1 className="text-xl font-bold text-gray-800 mb-1">Register for Event</h1>
            <p className="text-sm text-gray-500 mb-6">{ev.EventName}</p>

            <form onSubmit={goToReview}>
              {/* Attendee info */}
              <div className="mb-6">
                <h2 className="text-sm font-bold text-gray-600 uppercase tracking-wide mb-3">Your Information</h2>
                <div className="grid grid-cols-2 gap-3 mb-3">
                  <div>
                    <label className={lbl}>First Name</label>
                    <input value={form.AttendeeFirstName} onChange={set('AttendeeFirstName')} className={inp} required />
                  </div>
                  <div>
                    <label className={lbl}>Last Name</label>
                    <input value={form.AttendeeLastName} onChange={set('AttendeeLastName')} className={inp} required />
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-3 mb-3">
                  <div>
                    <label className={lbl}>Email</label>
                    <input type="email" value={form.AttendeeEmail} onChange={set('AttendeeEmail')} className={inp} required />
                  </div>
                  <div>
                    <label className={lbl}>Phone <span className="text-gray-400 font-normal">(Optional)</span></label>
                    <input value={form.AttendeePhone} onChange={set('AttendeePhone')} className={inp} />
                  </div>
                </div>
                <div>
                  <label className={lbl}>Notes / Special Requests <span className="text-gray-400 font-normal">(Optional)</span></label>
                  <RichTextEditor value={form.Notes || ''}
                    onChange={(v) => setForm(f => ({ ...f, Notes: v }))} minHeight={120} />
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

              {hasOptions && (
                <div className="flex items-center justify-between py-3 border-t border-gray-200 mb-5">
                  <span className="font-bold text-gray-700">Order Total</span>
                  <span className="font-bold text-xl text-[#3D6B34]">${total.toFixed(2)}</span>
                </div>
              )}

              <div className="flex justify-end gap-3">
                <Link to={`/events/${eventId}`}
                  className="px-5 py-3 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50 no-underline flex items-center">
                  Cancel
                </Link>
                <button type="submit"
                  className="bg-[#3D6B34] text-white font-bold px-8 py-3 rounded-xl hover:bg-[#2d5226] transition-colors">
                  Review Order →
                </button>
              </div>
            </form>
          </div>
        )}

        {/* ── STEP 2: Review order ── */}
        {step === 2 && (
          <div className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
            <h1 className="text-xl font-bold text-gray-800 mb-1">Review Your Order</h1>
            <p className="text-sm text-gray-500 mb-6">Please confirm the details below before completing your registration.</p>

            {/* Event info */}
            <div className="bg-gray-50 rounded-xl p-4 mb-5">
              <p className="font-bold text-gray-800">{ev.EventName}</p>
              {ev.EventStartDate && <p className="text-sm text-gray-500 mt-0.5">{formatDate(ev.EventStartDate)}</p>}
              {(ev.EventLocationName || ev.EventLocationCity) && (
                <p className="text-sm text-gray-500">{[ev.EventLocationName, ev.EventLocationCity, ev.EventLocationState].filter(Boolean).join(', ')}</p>
              )}
            </div>

            {/* Registrant info */}
            <div className="mb-5">
              <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-2">Registrant</h3>
              <p className="text-sm font-medium text-gray-800">{form.AttendeeFirstName} {form.AttendeeLastName}</p>
              <p className="text-sm text-gray-600">{form.AttendeeEmail}</p>
              {form.AttendeePhone && <p className="text-sm text-gray-600">{form.AttendeePhone}</p>}
              {form.Notes && (
                <div className="mt-2 bg-amber-50 border border-amber-100 rounded-lg px-3 py-2">
                  <p className="text-xs text-amber-700"><strong>Notes:</strong> {form.Notes}</p>
                </div>
              )}
            </div>

            {/* Items */}
            {hasOptions && (
              <div className="mb-5">
                <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-2">Registration Items</h3>
                {selectedItems.length === 0 ? (
                  <p className="text-sm text-gray-400 italic">No items selected (free registration)</p>
                ) : (
                  <div className="divide-y divide-gray-100 border border-gray-200 rounded-xl overflow-hidden">
                    {selectedItems.map(opt => (
                      <div key={opt.OptionID} className="flex items-center justify-between px-4 py-3 text-sm">
                        <div>
                          <span className="font-medium text-gray-800">{opt.OptionName}</span>
                          <span className="text-gray-500 ml-2">× {qtys[opt.OptionID]}</span>
                        </div>
                        <span className="font-bold text-gray-700">
                          {parseFloat(opt.Price) === 0 ? 'Free' : `$${(parseFloat(opt.Price) * qtys[opt.OptionID]).toFixed(2)}`}
                        </span>
                      </div>
                    ))}
                    <div className="flex items-center justify-between px-4 py-3 bg-gray-50">
                      <span className="font-bold text-gray-700">Total</span>
                      <span className="font-bold text-lg text-[#3D6B34]">${total.toFixed(2)}</span>
                    </div>
                  </div>
                )}
              </div>
            )}

            {total === 0 && !hasOptions && (
              <div className="mb-5 bg-green-50 border border-green-200 rounded-lg px-4 py-3 text-sm text-green-700 font-medium">
                ✓ This is a free event — no payment required.
              </div>
            )}

            {total > 0 && (
              <div className="mb-5 bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 text-sm text-blue-700">
                <strong>Payment:</strong> The organizer will contact you with payment instructions after registration.
              </div>
            )}

            <div className="flex justify-end gap-3">
              <button onClick={() => { setStep(1); window.scrollTo(0,0); }}
                className="px-5 py-3 rounded-xl border border-gray-200 text-sm text-gray-600 hover:bg-gray-50">
                ← Back
              </button>
              <button onClick={submit} disabled={submitting}
                className="bg-[#3D6B34] text-white font-bold px-8 py-3 rounded-xl hover:bg-[#2d5226] disabled:opacity-50 transition-colors">
                {submitting ? 'Submitting…' : 'Confirm Registration'}
              </button>
            </div>
          </div>
        )}

        {/* ── STEP 3: Confirmation ── */}
        {step === 3 && done && (
          <div className="bg-white rounded-2xl border border-gray-200 p-10 shadow-sm text-center">
            <div className="text-5xl mb-4">✅</div>
            <h1 className="text-2xl font-bold text-gray-800 mb-2">You're Registered!</h1>
            <p className="text-gray-500 mb-1">Registration #{done.RegID}</p>
            <p className="text-gray-700 font-medium mb-2">{ev.EventName}</p>
            {ev.EventStartDate && <p className="text-sm text-gray-500 mb-4">{formatDate(ev.EventStartDate)}</p>}
            {done.TotalAmount > 0 && (
              <p className="text-lg font-bold text-[#3D6B34] mb-4">Total: ${parseFloat(done.TotalAmount).toFixed(2)}</p>
            )}
            <p className="text-sm text-gray-500 mb-4">
              A confirmation has been noted for <strong>{form.AttendeeEmail}</strong>.
              {done.TotalAmount > 0 && ' The organizer will contact you with payment details.'}
            </p>
            <div className="flex flex-col items-center mb-6">
              <img
                src={`https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=${encodeURIComponent(String(done.RegID))}`}
                alt="Check-in QR code"
                width="180" height="180"
                className="border border-gray-200 rounded-lg p-2 bg-white"
              />
              <div className="text-xs text-gray-500 mt-2">Show this at check-in</div>
            </div>
            <div className="flex gap-3 justify-center">
              <Link to={`/events/${eventId}`} className="text-[#3D6B34] hover:underline text-sm">← Back to Event</Link>
              <Link to="/events" className="text-[#3D6B34] hover:underline text-sm">All Events</Link>
            </div>
          </div>
        )}
      </div>

      <Footer />
      <ThaiymeChat eventId={Number(eventId) || null} page="event_register" />
    </div>
  );
}
