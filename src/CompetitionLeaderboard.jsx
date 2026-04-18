import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';

const API = import.meta.env.VITE_API_URL || '';

const MEDALS = { 1: '🥇', 2: '🥈', 3: '🥉' };

export default function CompetitionLeaderboard() {
  const { eventId } = useParams();
  const [event, setEvent] = useState(null);
  const [cfg, setCfg] = useState(null);
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent).catch(() => {});
    fetch(`${API}/api/events/${eventId}/competition/config`).then(r => r.json()).then(setCfg).catch(() => {});
    fetch(`${API}/api/events/${eventId}/competition/leaderboard`)
      .then(r => r.json()).then(setData).catch(() => setData(null))
      .finally(() => setLoading(false));
  }, [eventId]);

  if (loading) return <div className="min-h-screen bg-[#FAF7EE] flex items-center justify-center text-sm text-gray-500">Loading…</div>;

  if (cfg && cfg.PublishLeaderboard === false) {
    return (
      <div className="min-h-screen bg-[#FAF7EE] flex items-center justify-center p-4">
        <div className="bg-white rounded-xl shadow p-6 max-w-md text-center">
          <div className="text-lg font-semibold text-[#3D6B34] mb-2">Leaderboard not published</div>
          <p className="text-sm text-gray-600">The organizer has not published results for this competition.</p>
          <Link to={`/events/${eventId}`} className="inline-block mt-4 text-sm text-[#3D6B34] hover:underline">
            ← Back to event
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#FAF7EE] py-8 px-4">
      <div className="max-w-4xl mx-auto">
        <Link to={`/events/${eventId}`} className="text-xs text-gray-500 hover:text-[#3D6B34]">← Back to event</Link>
        <h1 className="text-3xl font-semibold text-[#3D6B34] mt-2 mb-1">
          {event?.EventName || 'Competition'} — Results
        </h1>
        {data?.DropHighLow && (
          <div className="text-xs text-gray-500 mb-6">Scoring drops high + low judge scores when 3+ judges score an entry.</div>
        )}

        {(!data || data.Leaderboard.length === 0) && (
          <div className="bg-white rounded-xl shadow p-6 text-sm text-gray-500">
            No results yet.
          </div>
        )}

        {data?.Leaderboard.map(cat => (
          <div key={cat.CategoryID} className="mb-6 bg-white rounded-xl shadow overflow-hidden">
            <div className="bg-[#3D6B34] text-white px-5 py-3 font-semibold">
              {cat.CategoryName}
            </div>
            {cat.Entries.length === 0 ? (
              <div className="p-5 text-sm text-gray-500">No entries.</div>
            ) : (
              <table className="w-full text-sm">
                <thead className="text-xs text-gray-500 uppercase border-b border-gray-100">
                  <tr>
                    <th className="py-2 px-5 text-left w-20">Place</th>
                    <th className="py-2 px-5 text-left">Entrant</th>
                    <th className="py-2 px-5 text-right w-24">Judges</th>
                    <th className="py-2 px-5 text-right w-24">Score</th>
                  </tr>
                </thead>
                <tbody>
                  {cat.Entries.map(e => (
                    <tr key={e.EntryID} className="border-b border-gray-50 last:border-0">
                      <td className="py-3 px-5 text-lg">
                        {e.Disqualified ? (
                          <span className="text-red-500 text-xs font-semibold">DQ</span>
                        ) : e.Rank ? (
                          <span>{MEDALS[e.Rank] || e.Rank}</span>
                        ) : (
                          <span className="text-gray-300">—</span>
                        )}
                      </td>
                      <td className="py-3 px-5">
                        <div className="font-medium text-gray-800">{e.EntrantName}</div>
                        {e.EntryTitle && <div className="text-xs text-gray-500">{e.EntryTitle}</div>}
                      </td>
                      <td className="py-3 px-5 text-right text-xs text-gray-500">{e.JudgeCount || 0}</td>
                      <td className="py-3 px-5 text-right font-mono text-sm">
                        {e.FinalScore != null ? Number(e.FinalScore).toFixed(2) : '—'}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
