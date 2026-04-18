import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import RichTextEditor from './RichTextEditor';
import EventAdminLayout from './EventAdminLayout';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";

function ConfigTab({ eventId }) {
  const [cfg, setCfg] = useState(null);
  const [msg, setMsg] = useState('');
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/vendor-fair/config`).then(r => r.json()).then(setCfg);
  }, [eventId]);
  if (!cfg) return <div className="p-4 text-sm text-gray-500">Loading…</div>;
  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setNum = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  const save = async () => {
    setMsg('');
    const r = await fetch(`${API}/api/events/${eventId}/vendor-fair/config`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(cfg),
    });
    setMsg(r.ok ? 'Saved.' : 'Save failed');
  };
  return (
    <div className="space-y-4">
      <div><label className={lbl}>Description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={180} />
      </div>
      <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Small booth fee</label>
          <input type="number" step="0.01" value={cfg.BoothFeeSmall ?? ''} onChange={setNum('BoothFeeSmall')} className={inp} /></div>
        <div><label className={lbl}>Medium booth fee</label>
          <input type="number" step="0.01" value={cfg.BoothFeeMedium ?? ''} onChange={setNum('BoothFeeMedium')} className={inp} /></div>
        <div><label className={lbl}>Large booth fee</label>
          <input type="number" step="0.01" value={cfg.BoothFeeLarge ?? ''} onChange={setNum('BoothFeeLarge')} className={inp} /></div>
        <div><label className={lbl}>Electricity add-on</label>
          <input type="number" step="0.01" value={cfg.ElectricityFee ?? ''} onChange={setNum('ElectricityFee')} className={inp} /></div>
        <div><label className={lbl}>Table rental fee</label>
          <input type="number" step="0.01" value={cfg.TableFee ?? ''} onChange={setNum('TableFee')} className={inp} /></div>
        <div><label className={lbl}>Max booths</label>
          <input type="number" value={cfg.MaxBooths ?? ''} onChange={setNum('MaxBooths')} className={inp} /></div>
        <div><label className={lbl}>Applications close</label>
          <input type="date" value={(cfg.ApplicationEndDate || '').toString().substring(0, 10)} onChange={set('ApplicationEndDate')} className={inp} /></div>
      </div>
      <label className="flex items-center gap-2 text-sm">
        <input type="checkbox" checked={!!cfg.IsActive}
          onChange={(e) => setCfg(c => ({ ...c, IsActive: e.target.checked }))} />
        Vendor fair is accepting applications
      </label>
      <div className="flex justify-start items-center gap-3 pt-2">
        <button onClick={save} className={btn}>Save Config</button>
        {msg && <span className="text-xs text-gray-500">{msg}</span>}
      </div>
    </div>
  );
}

function AppsTab({ eventId }) {
  const [apps, setApps] = useState([]);
  const [filter, setFilter] = useState('');
  const load = () => {
    const url = filter
      ? `${API}/api/events/${eventId}/vendor-fair/applications?status=${filter}`
      : `${API}/api/events/${eventId}/vendor-fair/applications`;
    fetch(url).then(r => r.json()).then(setApps);
  };
  useEffect(() => { load(); }, [eventId, filter]);

  const update = async (a, patch) => {
    await fetch(`${API}/api/events/vendor-fair/applications/${a.AppID}`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...a, ...patch }),
    });
    load();
  };
  const remove = async (a) => {
    if (!confirm(`Delete application from ${a.BusinessName}?`)) return;
    await fetch(`${API}/api/events/vendor-fair/applications/${a.AppID}`, { method: 'DELETE' });
    load();
  };

  const counts = apps.reduce((acc, a) => {
    acc[a.Status] = (acc[a.Status] || 0) + 1;
    return acc;
  }, {});

  return (
    <div className="space-y-3">
      <div className="flex flex-wrap gap-2 items-center">
        <span className="text-sm text-gray-500 mr-2">Filter:</span>
        {['', 'pending', 'approved', 'rejected'].map(s => (
          <button key={s} onClick={() => setFilter(s)}
            className={`text-xs px-3 py-1 rounded-full ${filter === s ? 'bg-[#3D6B34] text-white' : 'bg-gray-100 text-gray-600'}`}>
            {s || 'all'} {counts[s] !== undefined && <span className="ml-1 opacity-60">({counts[s]})</span>}
          </button>
        ))}
      </div>

      <div className="space-y-2">
        {apps.map(a => (
          <div key={a.AppID} className="bg-white border border-gray-200 rounded-lg p-3">
            <div className="flex items-start justify-between gap-3">
              <div className="flex-1">
                <div className="flex items-center gap-2 flex-wrap">
                  <span className="font-medium">{a.BusinessName}</span>
                  <span className="text-[11px] px-2 py-0.5 rounded bg-blue-100 text-blue-700">{a.BoothSize}</span>
                  <span className={`text-[11px] px-2 py-0.5 rounded ${
                    a.Status === 'approved' ? 'bg-green-100 text-green-700'
                    : a.Status === 'rejected' ? 'bg-red-100 text-red-700'
                    : 'bg-yellow-100 text-yellow-700'}`}>{a.Status}</span>
                  {a.BoothNumber && <span className="text-xs font-mono bg-gray-100 px-2 py-0.5 rounded">booth {a.BoothNumber}</span>}
                </div>
                <div className="text-xs text-gray-500 mt-0.5">
                  {a.ContactName}{a.ContactEmail && ` · ${a.ContactEmail}`}{a.ContactPhone && ` · ${a.ContactPhone}`}
                </div>
                {a.ProductCategories && <div className="text-xs text-gray-600 mt-1">{a.ProductCategories}</div>}
                {a.Description && <div className="text-xs text-gray-600 mt-1 whitespace-pre-wrap">{a.Description}</div>}
                <div className="text-xs text-gray-500 mt-1">
                  {[a.NeedsElectricity && 'electricity', a.NeedsTable && 'table rental',
                    a.RequestedLocation && `location: ${a.RequestedLocation}`,
                    a.WebsiteURL].filter(Boolean).join(' · ')}
                </div>
              </div>
              <div className="text-right text-sm">
                <div className="font-bold">${Number(a.Fee || 0).toFixed(2)}</div>
                <button onClick={() => update(a, { PaidStatus: a.PaidStatus === 'paid' ? 'pending' : 'paid' })}
                  className={`text-[11px] px-2 py-0.5 rounded ${a.PaidStatus === 'paid' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}`}>
                  {a.PaidStatus}
                </button>
              </div>
            </div>

            <div className="mt-3 flex flex-wrap gap-2 items-center">
              <input placeholder="Booth #" value={a.BoothNumber || ''}
                onChange={(e) => setApps(list => list.map(x => x.AppID === a.AppID ? { ...x, BoothNumber: e.target.value } : x))}
                onBlur={() => update(a, {})}
                className={inp + " max-w-[120px]"} />
              {a.Status !== 'approved' && (
                <button onClick={() => update(a, { Status: 'approved' })} className="text-xs bg-green-600 text-white px-3 py-1 rounded">Approve</button>
              )}
              {a.Status !== 'rejected' && (
                <button onClick={() => update(a, { Status: 'rejected' })} className="text-xs bg-red-600 text-white px-3 py-1 rounded">Reject</button>
              )}
              <button onClick={() => remove(a)} className="text-xs text-red-500 hover:text-red-700 ml-auto">Delete</button>
            </div>

            <div className="mt-2">
              <label className={lbl}>Organizer notes</label>
              <RichTextEditor value={a.OrganizerNotes || ''}
                onChange={(v) => { if (v !== (a.OrganizerNotes || '')) update(a, { OrganizerNotes: v }); }}
                minHeight={90} />
            </div>
          </div>
        ))}
        {apps.length === 0 && <div className="text-sm text-gray-500">No applications{filter && ` in "${filter}"`}.</div>}
      </div>
    </div>
  );
}

export default function VendorFairAdmin() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const BusinessID = params.get('BusinessID');
  const [tab, setTab] = useState(params.get('tab') || 'config');
  const [event, setEvent] = useState(null);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent);
  }, [eventId]);
  const tabs = [['config', 'Config'], ['apps', 'Applications']];
  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-5xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Vendor Fair Admin</h1>
            <p className="text-sm text-gray-500 mt-1">{event?.EventName || 'Event'}</p>
          </div>
          <Link to={`/events/manage${BusinessID ? `?BusinessID=${BusinessID}` : ''}`}
            className="text-sm text-gray-500 hover:text-gray-700">← Back</Link>
        </div>
        <div className="flex gap-1 border-b border-gray-200 mb-5">
          {tabs.map(([k, label]) => (
            <button key={k} onClick={() => setTab(k)}
              className={`px-4 py-2 text-sm font-medium border-b-2 -mb-px ${tab === k ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
              {label}
            </button>
          ))}
        </div>
        {tab === 'config' && <ConfigTab eventId={eventId} />}
        {tab === 'apps' && <AppsTab eventId={eventId} />}
      </div>
    </EventAdminLayout>
  );
}
