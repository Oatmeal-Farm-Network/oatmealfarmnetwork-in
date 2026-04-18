import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';

const API = import.meta.env.VITE_API_URL || '';

function authHeaders() {
  const t = localStorage.getItem('access_token');
  return t ? { Authorization: `Bearer ${t}` } : {};
}

const CATEGORY_ORDER = [
  { title: 'Registrations & Payments', keys: ['registrations-carts', 'simple-registrations',
    'conference-attendees', 'dining-registrations', 'tour-registrations', 'vendor-applications'] },
  { title: 'Show Entries', keys: ['halter-entries', 'fleece-entries', 'spinoff-entries', 'fiber-arts-entries',
    'competition-entries'] },
  { title: 'Schedules & Results', keys: ['halter-schedule', 'conference-schedule', 'competition-leaderboard'] },
  { title: 'Food', keys: ['meal-tickets'] },
  { title: 'Communications', keys: ['mailing-list', 'all-emails'] },
];

export default function EventExportsHub() {
  const { eventId } = useParams();
  const [manifest, setManifest] = useState(null);
  const [loading, setLoading] = useState(true);
  const [err, setErr] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/exports/manifest`, { headers: authHeaders() })
      .then(r => r.ok ? r.json() : Promise.reject(`HTTP ${r.status}`))
      .then(setManifest)
      .catch(e => setErr(String(e)))
      .finally(() => setLoading(false));
  }, [eventId]);

  const byKey = {};
  (manifest?.exports || []).forEach(e => { byKey[e.key] = e; });

  const download = (exp) => {
    const url = `${API}${exp.url}`;
    window.open(url, '_blank');
  };

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-4xl">
        <h1 className="text-2xl font-semibold text-[#3D6B34]">Exports & Schedules</h1>
        <p className="text-sm text-gray-600 mt-1 mb-6">
          Download spreadsheets (CSV) for any part of this event. CSV files open directly in
          Excel and Google Sheets — no conversion needed. Use them for schedules, attendee
          lists, results, and accounting.
        </p>

        {loading && <div className="text-sm text-gray-500">Loading available exports…</div>}
        {err && <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded p-3">{err}</div>}

        {!loading && manifest && CATEGORY_ORDER.map(cat => {
          const items = cat.keys.map(k => byKey[k]).filter(Boolean);
          if (items.length === 0) return null;
          return (
            <div key={cat.title} className="mb-6">
              <div className="text-xs uppercase tracking-wide text-gray-500 font-medium mb-2">{cat.title}</div>
              <div className="bg-white rounded-xl shadow divide-y divide-gray-100">
                {items.map(exp => (
                  <div key={exp.key} className="p-4 flex items-center justify-between gap-3">
                    <div className="min-w-0 flex-1">
                      <div className="text-sm font-medium text-gray-800">{exp.label}</div>
                      <div className="text-xs text-gray-500 mt-0.5 font-mono truncate">{exp.url}</div>
                    </div>
                    <button onClick={() => download(exp)}
                      className="text-xs px-3 py-1.5 rounded-lg bg-[#3D6B34] text-white hover:bg-[#2f5226] whitespace-nowrap">
                      ⬇ Download CSV
                    </button>
                  </div>
                ))}
              </div>
            </div>
          );
        })}

        {!loading && manifest && manifest.exports?.length === 0 && (
          <div className="bg-white rounded-xl shadow p-6 text-sm text-gray-500">
            No exports available yet. Enable feature modules (halter show, fleece show, conference, etc.)
            or take some registrations to populate exports.
          </div>
        )}

        <div className="mt-6 bg-amber-50 border border-amber-200 rounded-lg p-4 text-xs text-amber-800">
          <div className="font-semibold mb-1">Tip: Google Sheets</div>
          To open in Google Sheets: download the CSV, then File → Import → Upload in a new Sheet.
          Or File → Open → Upload. To convert to XLSX: open the CSV in Excel, then Save As → .xlsx.
        </div>
      </div>
    </EventAdminLayout>
  );
}
