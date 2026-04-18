import React, { useEffect, useMemo, useState } from 'react';
import { useParams, Link } from 'react-router-dom';

const API = import.meta.env.VITE_API_URL || '';

function fmtTime(iso) {
  if (!iso) return '';
  const dt = new Date(iso);
  if (isNaN(dt)) return String(iso);
  return dt.toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });
}
function dayKey(iso) {
  if (!iso) return '';
  const dt = new Date(iso);
  if (isNaN(dt)) return '';
  return dt.toLocaleDateString([], { weekday: 'long', month: 'short', day: 'numeric' });
}

export default function ConferenceAgenda() {
  const { eventId } = useParams();
  const [event, setEvent] = useState(null);
  const [sessions, setSessions] = useState([]);
  const [tracks, setTracks] = useState([]);
  const [filterTrack, setFilterTrack] = useState('');

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
    fetch(`${API}/api/events/${eventId}/conference/sessions`).then(r => r.json()).then(setSessions).catch(() => {});
    fetch(`${API}/api/events/${eventId}/conference/tracks`).then(r => r.json()).then(setTracks).catch(() => {});
  }, [eventId]);

  const byDay = useMemo(() => {
    const filtered = filterTrack
      ? sessions.filter(s => String(s.TrackID) === filterTrack)
      : sessions;
    const map = new Map();
    for (const s of filtered) {
      const d = dayKey(s.SessionStart);
      if (!map.has(d)) map.set(d, []);
      map.get(d).push(s);
    }
    for (const arr of map.values()) {
      arr.sort((a, b) => new Date(a.SessionStart) - new Date(b.SessionStart));
    }
    return Array.from(map.entries());
  }, [sessions, filterTrack]);

  return (
    <div className="min-h-screen bg-[#FAF7EE] py-8 px-4">
      <div className="max-w-4xl mx-auto">
        <Link to={`/events/${eventId}`} className="text-xs text-gray-500 hover:text-[#3D6B34]">← Back to event</Link>
        <h1 className="text-3xl font-semibold text-[#3D6B34] mt-2 mb-1">
          {event?.EventName || 'Conference'} Agenda
        </h1>
        <div className="text-sm text-gray-500 mb-6">
          {sessions.length} session{sessions.length === 1 ? '' : 's'}
          {tracks.length > 0 && ` across ${tracks.length} track${tracks.length === 1 ? '' : 's'}`}
        </div>

        {tracks.length > 1 && (
          <div className="flex flex-wrap gap-2 mb-6">
            <button onClick={() => setFilterTrack('')}
              className={`text-xs px-3 py-1.5 rounded-full border ${filterTrack === ''
                ? 'bg-[#3D6B34] text-white border-[#3D6B34]'
                : 'border-gray-300 text-gray-700 bg-white'}`}>
              All tracks
            </button>
            {tracks.map(t => (
              <button key={t.TrackID} onClick={() => setFilterTrack(String(t.TrackID))}
                className={`text-xs px-3 py-1.5 rounded-full border flex items-center gap-1.5 ${
                  filterTrack === String(t.TrackID)
                    ? 'text-white border-transparent'
                    : 'border-gray-300 text-gray-700 bg-white'}`}
                style={filterTrack === String(t.TrackID) ? { background: t.TrackColor || '#3D6B34' } : {}}>
                <span className="inline-block w-2 h-2 rounded-full" style={{ background: t.TrackColor || '#3D6B34' }} />
                {t.TrackName}
              </button>
            ))}
          </div>
        )}

        {byDay.length === 0 && (
          <div className="bg-white rounded-xl shadow p-6 text-sm text-gray-500">
            Agenda has not been published yet.
          </div>
        )}

        {byDay.map(([day, items]) => (
          <div key={day} className="mb-6">
            <div className="text-sm font-semibold text-[#3D6B34] mb-3">{day}</div>
            <div className="bg-white rounded-xl shadow divide-y divide-gray-100">
              {items.map(s => (
                <div key={s.SessionID} className="p-4 flex gap-4">
                  <div className="w-20 shrink-0 text-xs text-gray-500 pt-0.5">
                    {fmtTime(s.SessionStart)}
                    <div className="text-gray-400">{s.DurationMin}m</div>
                  </div>
                  {s.TrackColor && (
                    <span className="w-1 rounded shrink-0" style={{ background: s.TrackColor, minHeight: 40 }} />
                  )}
                  <div className="flex-1 min-w-0">
                    <div className="font-medium text-gray-800">{s.Title}</div>
                    <div className="text-xs text-gray-500 mt-0.5">
                      {s.SessionType}
                      {s.TrackName && ` · ${s.TrackName}`}
                      {s.RoomName && ` · ${s.RoomName}`}
                    </div>
                    {s.Speakers && s.Speakers.length > 0 && (
                      <div className="text-xs text-gray-600 mt-1">
                        {s.Speakers.map(sp => sp.SpeakerName).join(', ')}
                      </div>
                    )}
                    {s.Description && (
                      <div className="text-sm text-gray-700 mt-2">{s.Description}</div>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
