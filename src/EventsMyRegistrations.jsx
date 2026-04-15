import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL || '';

function formatDate(d) {
  if (!d) return '';
  return new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
}

export default function EventsMyRegistrations() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [regs, setRegs] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!PeopleID) return;
    if (BusinessID) LoadBusiness(BusinessID);
    fetch(`${API}/api/my-registrations?people_id=${PeopleID}`)
      .then(r => r.json()).then(d => { setRegs(Array.isArray(d) ? d : []); setLoading(false); })
      .catch(() => setLoading(false));
  }, [PeopleID]);

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="My Registrations" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Events' }, { label: 'My Registrations' }]}>
      <div className="max-w-4xl mx-auto space-y-6">

        <div className="flex items-center justify-between flex-wrap gap-3">
          <h1 className="text-2xl font-bold text-gray-800">My Event Registrations</h1>
          <Link to="/events" className="text-sm text-[#3D6B34] hover:underline">Browse Events →</Link>
        </div>

        {loading ? (
          <div className="text-center py-12 text-gray-400">Loading…</div>
        ) : regs.length === 0 ? (
          <div className="bg-white rounded-xl border border-gray-200 p-12 text-center text-gray-400">
            <div className="text-4xl mb-3">🎟️</div>
            <p className="mb-4">You haven't registered for any events yet.</p>
            <Link to="/events" className="text-[#3D6B34] hover:underline text-sm">Browse Upcoming Events</Link>
          </div>
        ) : (
          <div className="space-y-4">
            {regs.map(reg => (
              <div key={reg.RegID} className="bg-white rounded-xl border border-gray-200 p-5 flex gap-4">
                {reg.EventImage ? (
                  <img src={reg.EventImage} alt={reg.EventName}
                    className="w-16 h-16 rounded-lg object-cover shrink-0"
                    onError={e => e.target.style.display = 'none'} />
                ) : (
                  <div className="w-16 h-16 rounded-lg bg-[#3D6B34]/10 flex items-center justify-center shrink-0 text-xl">🎪</div>
                )}
                <div className="flex-grow min-w-0">
                  <div className="flex items-start justify-between gap-2 flex-wrap">
                    <div>
                      <Link to={`/events/${reg.EventID}`} className="font-bold text-gray-800 hover:text-[#3D6B34] no-underline">
                        {reg.EventName}
                      </Link>
                      <p className="text-xs text-gray-500 mt-0.5">Hosted by {reg.OrganizerName}</p>
                    </div>
                    <span className={`text-xs font-semibold px-2 py-0.5 rounded-full shrink-0 ${
                      reg.PaymentStatus === 'paid' ? 'bg-green-100 text-green-700'
                      : 'bg-amber-100 text-amber-700'
                    }`}>
                      {reg.PaymentStatus}
                    </span>
                  </div>
                  <div className="flex items-center gap-4 text-xs text-gray-500 mt-2 flex-wrap">
                    {reg.EventStartDate && (
                      <span>📅 {formatDate(reg.EventStartDate)}{reg.EventEndDate && reg.EventEndDate !== reg.EventStartDate ? ` – ${formatDate(reg.EventEndDate)}` : ''}</span>
                    )}
                    {(reg.EventLocationCity || reg.EventLocationState) && (
                      <span>📍 {[reg.EventLocationCity, reg.EventLocationState].filter(Boolean).join(', ')}</span>
                    )}
                    <span>Reg #{reg.RegID} · {new Date(reg.RegDate).toLocaleDateString()}</span>
                  </div>
                </div>
                <div className="text-right shrink-0">
                  {parseFloat(reg.TotalAmount) > 0 && (
                    <p className="font-bold text-[#3D6B34]">${parseFloat(reg.TotalAmount).toFixed(2)}</p>
                  )}
                  {parseFloat(reg.TotalAmount) === 0 && (
                    <p className="text-xs text-green-600 font-semibold">Free</p>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
