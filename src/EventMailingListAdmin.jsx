import React, { useEffect, useRef, useState } from 'react';
import { useParams } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';

const API = import.meta.env.VITE_API_URL || '';

function authHeaders() {
  const t = localStorage.getItem('access_token');
  return t ? { Authorization: `Bearer ${t}` } : {};
}

function fmtDate(iso) {
  if (!iso) return '';
  const dt = new Date(iso);
  return isNaN(dt) ? String(iso) : dt.toLocaleDateString();
}

export default function EventMailingListAdmin() {
  const { eventId } = useParams();
  const [rows, setRows] = useState([]);
  const [stats, setStats] = useState({ total: 0, active: 0, opted_out: 0 });
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState('all');
  const [addOpen, setAddOpen] = useState(false);
  const [newEntry, setNewEntry] = useState({ Email: '', Name: '', Tags: '' });
  const fileRef = useRef(null);
  const [importResult, setImportResult] = useState(null);
  const [importing, setImporting] = useState(false);

  const load = () => {
    setLoading(true);
    Promise.all([
      fetch(`${API}/api/events/${eventId}/mailing-list`, { headers: authHeaders() }).then(r => r.json()),
      fetch(`${API}/api/events/${eventId}/mailing-list/stats`, { headers: authHeaders() }).then(r => r.json()),
    ]).then(([rs, st]) => {
      setRows(Array.isArray(rs) ? rs : []);
      setStats(st || { total: 0, active: 0, opted_out: 0 });
    }).catch(() => {
      setRows([]);
    }).finally(() => setLoading(false));
  };

  useEffect(load, [eventId]);

  const visible = filter === 'active'
    ? rows.filter(r => !r.OptedOutDate)
    : filter === 'opted_out'
    ? rows.filter(r => !!r.OptedOutDate)
    : rows;

  const addOne = async () => {
    if (!newEntry.Email || !newEntry.Email.includes('@')) {
      alert('Enter a valid email'); return;
    }
    const res = await fetch(`${API}/api/events/${eventId}/mailing-list`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', ...authHeaders() },
      body: JSON.stringify(newEntry),
    });
    if (!res.ok) { alert('Failed to add'); return; }
    setNewEntry({ Email: '', Name: '', Tags: '' });
    setAddOpen(false);
    load();
  };

  const toggleOptOut = async (r) => {
    const url = r.OptedOutDate
      ? `${API}/api/events/mailing-list/${r.RowID}/re-subscribe`
      : `${API}/api/events/mailing-list/${r.RowID}/opt-out`;
    await fetch(url, { method: 'POST', headers: authHeaders() });
    load();
  };

  const removeRow = async (r) => {
    if (!confirm(`Remove ${r.Email} from the mailing list?`)) return;
    await fetch(`${API}/api/events/mailing-list/${r.RowID}`, {
      method: 'DELETE', headers: authHeaders(),
    });
    load();
  };

  const handleImport = async (file) => {
    if (!file) return;
    setImporting(true);
    setImportResult(null);
    const fd = new FormData();
    fd.append('file', file);
    fd.append('source', 'csv-import');
    try {
      const res = await fetch(`${API}/api/events/${eventId}/mailing-list/import`, {
        method: 'POST', headers: authHeaders(), body: fd,
      });
      if (!res.ok) {
        const t = await res.text();
        alert(`Import failed: ${t}`);
      } else {
        const j = await res.json();
        setImportResult(j);
        load();
      }
    } catch (e) {
      alert(`Import error: ${e.message || e}`);
    } finally {
      setImporting(false);
      if (fileRef.current) fileRef.current.value = '';
    }
  };

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl">
        <div className="flex items-start justify-between gap-4 mb-2">
          <div>
            <h1 className="text-2xl font-semibold text-[#3D6B34]">Mailing List</h1>
            <p className="text-sm text-gray-600 mt-1">
              Subscribers get included in every broadcast you send for this event
              (alongside registered attendees). Upload a CSV to bulk-import past attendees,
              newsletter sign-ups, or imported lists.
            </p>
          </div>
          <a href={`${API}/api/events/${eventId}/exports/mailing-list.csv`}
             target="_blank" rel="noopener"
             className="text-xs px-3 py-1.5 rounded-lg border border-gray-300 bg-white hover:bg-gray-50 whitespace-nowrap">
            ⬇ Export CSV
          </a>
        </div>

        <div className="grid grid-cols-3 gap-3 mb-5">
          <Stat label="Total"      value={stats.total || 0} />
          <Stat label="Active"     value={stats.active || 0} color="text-green-700" />
          <Stat label="Opted out"  value={stats.opted_out || 0} color="text-gray-500" />
        </div>

        <div className="bg-white rounded-xl shadow p-4 mb-5">
          <div className="flex items-center justify-between gap-3 mb-3">
            <div>
              <div className="text-sm font-medium text-gray-800">Import from CSV</div>
              <div className="text-xs text-gray-500 mt-0.5">
                CSV must include an <span className="font-mono">email</span> column. Optional:
                {' '}<span className="font-mono">name</span>, <span className="font-mono">tags</span>.
              </div>
            </div>
            <input
              ref={fileRef}
              type="file" accept=".csv,text/csv"
              onChange={e => handleImport(e.target.files?.[0])}
              className="text-xs"
              disabled={importing}
            />
          </div>
          {importing && <div className="text-xs text-gray-500">Uploading…</div>}
          {importResult && (
            <div className="bg-green-50 border border-green-200 text-green-800 rounded p-2 text-xs mt-2">
              Added {importResult.added}, updated {importResult.updated}, skipped {importResult.skipped ?? 0}.
            </div>
          )}

          <div className="border-t mt-3 pt-3 flex items-center justify-between gap-3">
            <div>
              <div className="text-sm font-medium text-gray-800">One-click import from your contacts</div>
              <div className="text-xs text-gray-500 mt-0.5">
                Pulls emails from your team, past event attendees, and marketplace customers.
              </div>
            </div>
            <button
              onClick={async () => {
                setImporting(true); setImportResult(null);
                try {
                  const r = await fetch(`${API}/api/events/${eventId}/mailing-list/import-contacts`, {
                    method: 'POST', headers: authHeaders(),
                  });
                  if (r.ok) { setImportResult(await r.json()); load(); }
                  else alert('Import failed');
                } finally { setImporting(false); }
              }}
              disabled={importing}
              className="text-xs px-3 py-1.5 rounded-lg bg-gray-800 text-white hover:bg-gray-700 disabled:opacity-50 whitespace-nowrap">
              👥 Import contacts
            </button>
          </div>
        </div>

        <div className="flex items-center justify-between gap-3 mb-3">
          <div className="flex gap-2">
            {[['all', `All (${rows.length})`],
              ['active', `Active (${stats.active || 0})`],
              ['opted_out', `Opted out (${stats.opted_out || 0})`]].map(([k, label]) => (
              <button key={k} onClick={() => setFilter(k)}
                className={`text-xs px-3 py-1.5 rounded-full border ${filter === k
                  ? 'bg-[#3D6B34] text-white border-[#3D6B34]'
                  : 'border-gray-300 text-gray-700 bg-white hover:bg-gray-50'}`}>
                {label}
              </button>
            ))}
          </div>
          <button onClick={() => setAddOpen(v => !v)}
            className="text-xs px-3 py-1.5 rounded-lg bg-[#3D6B34] text-white hover:bg-[#2f5226]">
            {addOpen ? 'Close' : '+ Add subscriber'}
          </button>
        </div>

        {addOpen && (
          <div className="bg-white rounded-xl shadow p-4 mb-4 grid grid-cols-1 md:grid-cols-4 gap-3">
            <input className="border rounded px-3 py-2 text-sm md:col-span-2" placeholder="email@example.com"
              value={newEntry.Email} onChange={e => setNewEntry(v => ({ ...v, Email: e.target.value }))} />
            <input className="border rounded px-3 py-2 text-sm" placeholder="Name (optional)"
              value={newEntry.Name} onChange={e => setNewEntry(v => ({ ...v, Name: e.target.value }))} />
            <input className="border rounded px-3 py-2 text-sm" placeholder="Tags (optional)"
              value={newEntry.Tags} onChange={e => setNewEntry(v => ({ ...v, Tags: e.target.value }))} />
            <div className="md:col-span-4 flex justify-end gap-2">
              <button onClick={() => setAddOpen(false)} className="text-xs px-3 py-1.5 rounded border border-gray-300">Cancel</button>
              <button onClick={addOne} className="text-xs px-3 py-1.5 rounded bg-[#3D6B34] text-white">Add</button>
            </div>
          </div>
        )}

        {loading ? (
          <div className="bg-white rounded-xl shadow p-6 text-sm text-gray-500">Loading…</div>
        ) : visible.length === 0 ? (
          <div className="bg-white rounded-xl shadow p-8 text-center text-sm text-gray-500">
            No subscribers{filter !== 'all' ? ` (${filter})` : ''} yet.
          </div>
        ) : (
          <div className="bg-white rounded-xl shadow overflow-hidden">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 text-[10px] uppercase text-gray-500">
                <tr>
                  <th className="text-left px-4 py-2 font-semibold">Email</th>
                  <th className="text-left px-4 py-2 font-semibold">Name</th>
                  <th className="text-left px-4 py-2 font-semibold">Source</th>
                  <th className="text-left px-4 py-2 font-semibold">Added</th>
                  <th className="text-left px-4 py-2 font-semibold">Status</th>
                  <th className="text-right px-4 py-2 font-semibold">Actions</th>
                </tr>
              </thead>
              <tbody>
                {visible.map(r => (
                  <tr key={r.RowID} className="border-t border-gray-100">
                    <td className="px-4 py-2 text-gray-800">{r.Email}</td>
                    <td className="px-4 py-2 text-gray-700">{r.Name || '—'}</td>
                    <td className="px-4 py-2 text-gray-500 text-xs">{r.Source || '—'}</td>
                    <td className="px-4 py-2 text-gray-500 text-xs">{fmtDate(r.AddedDate)}</td>
                    <td className="px-4 py-2">
                      {r.OptedOutDate ? (
                        <span className="text-xs text-gray-500">Opted out</span>
                      ) : (
                        <span className="text-xs text-green-700">Active</span>
                      )}
                    </td>
                    <td className="px-4 py-2 text-right whitespace-nowrap">
                      <button onClick={() => toggleOptOut(r)}
                        className="text-xs text-amber-700 hover:underline mr-3">
                        {r.OptedOutDate ? 'Re-subscribe' : 'Opt out'}
                      </button>
                      <button onClick={() => removeRow(r)}
                        className="text-xs text-red-600 hover:underline">
                        Delete
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </EventAdminLayout>
  );
}

function Stat({ label, value, color = 'text-[#3D6B34]' }) {
  return (
    <div className="bg-white rounded-xl shadow p-4">
      <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">{label}</div>
      <div className={`text-2xl font-semibold mt-1 ${color}`}>{value}</div>
    </div>
  );
}
