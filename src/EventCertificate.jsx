import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';

const API = import.meta.env.VITE_API_URL || '';

export default function EventCertificate() {
  const { eventId } = useParams();
  const [sp] = useSearchParams();
  const name = sp.get('name') || '';
  const regId = sp.get('reg') || '';
  const [event, setEvent] = useState(null);
  const [cfg, setCfg] = useState(null);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
    fetch(`${API}/api/events/${eventId}/simple/config`).then(r => r.json()).then(setCfg).catch(() => {});
  }, [eventId]);

  const issueDate = new Date();
  const startDate = event?.EventStartDate ? new Date(event.EventStartDate) : null;

  return (
    <div className="min-h-screen bg-gray-100 py-8 px-4 print:bg-white print:p-0">
      <div className="max-w-3xl mx-auto mb-4 print:hidden flex items-center justify-between">
        <Link to={`/events/${eventId}`} className="text-xs text-gray-500 hover:text-[#3D6B34]">← Back to event</Link>
        <button onClick={() => window.print()} className="px-4 py-2 bg-[#3D6B34] text-white text-sm rounded-lg hover:bg-[#2d5025]">
          Print / Save as PDF
        </button>
      </div>

      {cfg && !cfg.CertificateEnabled ? (
        <div className="max-w-md mx-auto bg-white rounded-xl shadow p-6 text-center">
          <div className="text-lg font-semibold text-gray-700">Certificates not enabled</div>
          <p className="text-sm text-gray-500 mt-1">The organizer has not enabled certificates for this event.</p>
        </div>
      ) : (
        <div className="max-w-3xl mx-auto bg-white shadow-xl print:shadow-none border-8 border-double border-[#3D6B34] p-12 text-center"
             style={{ aspectRatio: '11 / 8.5', fontFamily: 'Georgia, serif' }}>
          <div className="text-xs uppercase tracking-[0.3em] text-[#819360] mb-2">Certificate of Completion</div>
          <div className="w-24 h-0.5 bg-[#3D6B34] mx-auto mb-8" />
          <div className="text-sm text-gray-500">This is to certify that</div>
          <div className="text-4xl font-semibold text-[#3D6B34] my-4">{name || '— attendee name —'}</div>
          <div className="text-sm text-gray-500">has successfully completed</div>
          <div className="text-2xl font-medium text-gray-800 my-3">{event?.EventName || 'Event'}</div>
          {cfg?.SpeakerName && (
            <div className="text-sm text-gray-600 italic">presented by {cfg.SpeakerName}</div>
          )}
          {cfg?.SkillLevel && (
            <div className="text-xs text-gray-500 mt-2">{cfg.SkillLevel}</div>
          )}
          <div className="w-full mt-10 pt-6 border-t border-gray-200 grid grid-cols-3 text-xs text-gray-500">
            <div>
              <div className="font-medium text-gray-700">
                {startDate ? startDate.toLocaleDateString([], { month: 'long', day: 'numeric', year: 'numeric' }) : ''}
              </div>
              <div>Event date</div>
            </div>
            <div>
              <div className="font-medium text-gray-700">
                {issueDate.toLocaleDateString([], { month: 'long', day: 'numeric', year: 'numeric' })}
              </div>
              <div>Issued</div>
            </div>
            <div>
              <div className="font-medium text-gray-700 font-mono">{regId || '—'}</div>
              <div>Ref #</div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
