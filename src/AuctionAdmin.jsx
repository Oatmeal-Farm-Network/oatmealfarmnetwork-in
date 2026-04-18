import React, { useEffect, useState } from 'react';
import { useParams, useSearchParams, Link } from 'react-router-dom';
import RichTextEditor from './RichTextEditor';
import EventAdminLayout from './EventAdminLayout';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";
const btnGhost = "px-4 py-1.5 text-sm border border-gray-300 rounded-lg";

const AUCTION_TYPES = ['Live', 'Silent', 'Online', 'Stud'];
const LOT_TYPES = ['Animal', 'Fleece', 'Item', 'StudService', 'Package'];
const LOT_STATUSES = ['open', 'closed', 'passed', 'withdrawn'];

function ConfigTab({ eventId }) {
  const [cfg, setCfg] = useState(null);
  const [msg, setMsg] = useState('');
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/auction/config`).then(r => r.json()).then(setCfg);
  }, [eventId]);
  if (!cfg) return <div className="p-4 text-sm text-gray-500">Loading…</div>;
  const set = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value }));
  const setNum = (k) => (e) => setCfg(c => ({ ...c, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  const save = async () => {
    setMsg('');
    const r = await fetch(`${API}/api/events/${eventId}/auction/config`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(cfg),
    });
    setMsg(r.ok ? 'Saved.' : 'Save failed');
  };
  return (
    <div className="space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Auction type</label>
          <select value={cfg.AuctionType || 'Live'} onChange={set('AuctionType')} className={inp}>
            {AUCTION_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
          </select></div>
        <div><label className={lbl}>Buyer premium %</label>
          <input type="number" step="0.01" value={cfg.BuyerPremiumPercent ?? ''} onChange={setNum('BuyerPremiumPercent')} className={inp} /></div>
        <div><label className={lbl}>Min bid increment</label>
          <input type="number" step="0.01" value={cfg.MinBidIncrement ?? ''} onChange={setNum('MinBidIncrement')} className={inp} /></div>
        <div><label className={lbl}>Bidding opens</label>
          <input type="datetime-local" value={(cfg.BidOpenDate || '').toString().substring(0, 16)} onChange={set('BidOpenDate')} className={inp} /></div>
        <div><label className={lbl}>Bidding closes</label>
          <input type="datetime-local" value={(cfg.BidCloseDate || '').toString().substring(0, 16)} onChange={set('BidCloseDate')} className={inp} /></div>
        <div className="flex items-end">
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={!!cfg.IsActive}
              onChange={(e) => setCfg(c => ({ ...c, IsActive: e.target.checked }))} />
            Auction is active
          </label>
        </div>
      </div>
      <div><label className={lbl}>Description</label>
        <RichTextEditor value={cfg.Description || ''}
          onChange={(v) => setCfg(c => ({ ...c, Description: v }))} minHeight={180} />
      </div>
      <div><label className={lbl}>Payment terms</label>
        <RichTextEditor value={cfg.PaymentTerms || ''}
          onChange={(v) => setCfg(c => ({ ...c, PaymentTerms: v }))} minHeight={120} />
      </div>
      <div className="flex justify-start items-center gap-3 pt-2">
        <button onClick={save} className={btn}>Save Config</button>
        {msg && <span className="text-xs text-gray-500">{msg}</span>}
      </div>
    </div>
  );
}

function LotForm({ initial, onSave, onCancel }) {
  const [form, setForm] = useState({
    LotNumber: '', LotType: 'Item', Title: '', Description: '', PhotoURL: '',
    SellerName: '', AnimalID: '', StartingBid: 0, ReserveBid: '', MinIncrement: '',
    DisplayOrder: 0, Status: 'open', ...initial,
  });
  const set = (k) => (e) => setForm(f => ({ ...f, [k]: e.target.value }));
  return (
    <form onSubmit={(e) => { e.preventDefault(); onSave(form); }}
      className="bg-gray-50 border border-gray-200 rounded-lg p-4 space-y-3">
      <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Lot #</label>
          <input value={form.LotNumber} onChange={set('LotNumber')} className={inp} placeholder="1A" /></div>
        <div><label className={lbl}>Lot type</label>
          <select value={form.LotType} onChange={set('LotType')} className={inp}>
            {LOT_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
          </select></div>
        <div><label className={lbl}>Order</label>
          <input type="number" value={form.DisplayOrder} onChange={set('DisplayOrder')} className={inp} /></div>
      </div>
      <div><label className={lbl}>Title</label>
        <input required value={form.Title} onChange={set('Title')} className={inp}
          placeholder="Snowmass Royal Fawn — 2023 Huacaya Herdsire" /></div>
      <div><label className={lbl}>Description</label>
        <RichTextEditor value={form.Description || ''}
          onChange={(v) => setForm(f => ({ ...f, Description: v }))} minHeight={150} />
      </div>
      <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
        <div><label className={lbl}>Photo URL</label>
          <input value={form.PhotoURL || ''} onChange={set('PhotoURL')} className={inp} /></div>
        <div><label className={lbl}>Seller name</label>
          <input value={form.SellerName || ''} onChange={set('SellerName')} className={inp} /></div>
        <div><label className={lbl}>Animal ID (optional)</label>
          <input value={form.AnimalID || ''} onChange={set('AnimalID')} className={inp} /></div>
      </div>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
        <div><label className={lbl}>Starting bid</label>
          <input type="number" step="0.01" value={form.StartingBid || 0} onChange={set('StartingBid')} className={inp} /></div>
        <div><label className={lbl}>Reserve (optional)</label>
          <input type="number" step="0.01" value={form.ReserveBid || ''} onChange={set('ReserveBid')} className={inp} /></div>
        <div><label className={lbl}>Min increment (optional)</label>
          <input type="number" step="0.01" value={form.MinIncrement || ''} onChange={set('MinIncrement')} className={inp} /></div>
        <div><label className={lbl}>Status</label>
          <select value={form.Status} onChange={set('Status')} className={inp}>
            {LOT_STATUSES.map(s => <option key={s} value={s}>{s}</option>)}
          </select></div>
      </div>
      <div className="flex justify-start gap-2">
        <button type="submit" className={btn}>Save Lot</button>
        <button type="button" onClick={onCancel} className={btnGhost}>Cancel</button>
      </div>
    </form>
  );
}

function LotsTab({ eventId }) {
  const [lots, setLots] = useState([]);
  const [editing, setEditing] = useState(null);
  const [adding, setAdding] = useState(false);
  const [err, setErr] = useState('');
  const load = () => fetch(`${API}/api/events/${eventId}/auction/lots`).then(r => r.json()).then(setLots);
  useEffect(() => { load(); }, [eventId]);

  const save = async (form) => {
    setErr('');
    const url = editing ? `${API}/api/events/auction/lots/${editing.LotID}`
      : `${API}/api/events/${eventId}/auction/lots`;
    const body = { ...form,
      StartingBid: Number(form.StartingBid || 0),
      ReserveBid: form.ReserveBid ? Number(form.ReserveBid) : null,
      MinIncrement: form.MinIncrement ? Number(form.MinIncrement) : null,
      AnimalID: form.AnimalID ? Number(form.AnimalID) : null,
      DisplayOrder: Number(form.DisplayOrder || 0),
    };
    const r = await fetch(url, {
      method: editing ? 'PUT' : 'POST',
      headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body),
    });
    if (!r.ok) { setErr('Save failed'); return; }
    setAdding(false); setEditing(null); load();
  };
  const remove = async (l) => {
    if (!confirm(`Delete lot "${l.Title}"? This also deletes all bids.`)) return;
    await fetch(`${API}/api/events/auction/lots/${l.LotID}`, { method: 'DELETE' });
    load();
  };
  const close = async (l) => {
    if (!confirm(`Close lot "${l.Title}" and award to highest bidder?`)) return;
    const r = await fetch(`${API}/api/events/auction/lots/${l.LotID}/close`, { method: 'POST' });
    const j = await r.json();
    if (j.status === 'passed') alert(j.reason ? `Passed: ${j.reason}` : 'No bids — lot passed');
    load();
  };

  return (
    <div className="space-y-3">
      {err && <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3">{err}</div>}
      <div className="flex justify-between items-center">
        <h3 className="text-sm font-bold text-gray-500 uppercase tracking-wide">Lots ({lots.length})</h3>
        {!adding && !editing && <button onClick={() => setAdding(true)} className={btn}>+ Add Lot</button>}
      </div>
      {(adding || editing) && (
        <LotForm initial={editing || {}} onSave={save}
          onCancel={() => { setAdding(false); setEditing(null); }} />
      )}
      <div className="space-y-2">
        {lots.map(l => (
          <div key={l.LotID} className="bg-white border border-gray-200 rounded-lg p-3">
            <div className="flex items-start justify-between gap-3">
              <div className="flex-1">
                <div className="flex items-center gap-2 flex-wrap">
                  {l.LotNumber && <span className="text-xs font-mono bg-gray-100 px-2 py-0.5 rounded">#{l.LotNumber}</span>}
                  <span className="text-[11px] px-2 py-0.5 rounded bg-blue-100 text-blue-700">{l.LotType}</span>
                  <span className={`text-[11px] px-2 py-0.5 rounded ${
                    l.Status === 'open' ? 'bg-green-100 text-green-700'
                    : l.Status === 'closed' ? 'bg-gray-200 text-gray-700'
                    : 'bg-yellow-100 text-yellow-700'}`}>{l.Status}</span>
                </div>
                <div className="font-medium mt-1">{l.Title}</div>
                {l.SellerName && <div className="text-xs text-gray-500">Seller: {l.SellerName}</div>}
                {l.Description && <div className="text-xs text-gray-600 mt-1 line-clamp-2">{l.Description}</div>}
              </div>
              <div className="text-right text-sm">
                <div className="text-xs text-gray-500">Starting ${Number(l.StartingBid || 0).toFixed(2)}</div>
                {l.ReserveBid && <div className="text-xs text-gray-500">Reserve ${Number(l.ReserveBid).toFixed(2)}</div>}
                {l.CurrentBid > 0 && (
                  <div className="font-bold text-[#3D6B34]">Current ${Number(l.CurrentBid).toFixed(2)}</div>
                )}
                {l.Status === 'closed' && l.WinnerBid && (
                  <div className="font-bold text-green-700">Sold ${Number(l.WinnerBid).toFixed(2)}</div>
                )}
                <div className="flex gap-2 mt-2 justify-end">
                  {l.Status === 'open' && (
                    <button onClick={() => close(l)} className="text-xs text-green-600 hover:text-green-800">Close & award</button>
                  )}
                  <button onClick={() => { setEditing(l); setAdding(false); }} className="text-xs text-gray-500 hover:text-gray-800">Edit</button>
                  <button onClick={() => remove(l)} className="text-xs text-red-500 hover:text-red-700">Delete</button>
                </div>
              </div>
            </div>
          </div>
        ))}
        {lots.length === 0 && <div className="text-sm text-gray-500">No lots yet.</div>}
      </div>
    </div>
  );
}

function BidsTab({ eventId }) {
  const [lots, setLots] = useState([]);
  const [selected, setSelected] = useState(null);
  const [bids, setBids] = useState([]);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}/auction/lots`).then(r => r.json()).then(setLots);
  }, [eventId]);
  const loadBids = (lid) => {
    setSelected(lid);
    fetch(`${API}/api/events/${eventId}/auction/lots/${lid}/bids`).then(r => r.json()).then(setBids);
  };
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div className="md:col-span-1">
        <div className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-2">Lots</div>
        <div className="bg-white border border-gray-200 rounded-lg max-h-[500px] overflow-y-auto">
          {lots.map(l => (
            <button key={l.LotID} onClick={() => loadBids(l.LotID)}
              className={`w-full text-left px-3 py-2 text-sm border-b hover:bg-gray-50 ${selected === l.LotID ? 'bg-[#3D6B34]/10 font-semibold' : ''}`}>
              <div className="font-medium">
                {l.LotNumber && <span className="font-mono text-xs mr-1">#{l.LotNumber}</span>}
                {l.Title}
              </div>
              <div className="text-xs text-gray-500">
                Current: ${Number(l.CurrentBid || 0).toFixed(2)} · {l.Status}
              </div>
            </button>
          ))}
        </div>
      </div>
      <div className="md:col-span-2">
        {!selected && <div className="text-sm text-gray-500">Select a lot to see bid history.</div>}
        {selected && bids.length === 0 && <div className="text-sm text-gray-500">No bids on this lot yet.</div>}
        <div className="bg-white border border-gray-200 rounded-lg overflow-hidden">
          {bids.length > 0 && (
            <table className="w-full text-sm">
              <thead className="bg-gray-50 text-xs text-gray-500">
                <tr><th className="text-left p-2">Bidder</th><th className="text-left p-2">Amount</th><th className="text-left p-2">Time</th><th className="text-left p-2"></th></tr>
              </thead>
              <tbody>
                {bids.map((b, i) => (
                  <tr key={b.BidID} className={`border-t ${i === 0 ? 'bg-green-50' : ''}`}>
                    <td className="p-2">{b.BidderName || `Person #${b.PeopleID}`}</td>
                    <td className="p-2 font-bold">${Number(b.BidAmount).toFixed(2)}</td>
                    <td className="p-2 text-xs text-gray-500">{new Date(b.BidTime).toLocaleString()}</td>
                    <td className="p-2">{b.IsWinning && <span className="text-xs text-green-700 font-semibold">WINNER</span>}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  );
}

export default function AuctionAdmin() {
  const { eventId } = useParams();
  const [params] = useSearchParams();
  const BusinessID = params.get('BusinessID');
  const [tab, setTab] = useState(params.get('tab') || 'config');
  const [event, setEvent] = useState(null);
  useEffect(() => {
    fetch(`${API}/api/events/${eventId}`).then(r => r.json()).then(setEvent);
  }, [eventId]);

  const tabs = [['config', 'Config'], ['lots', 'Lots'], ['bids', 'Bids']];

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-6xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Auction Admin</h1>
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
        {tab === 'lots' && <LotsTab eventId={eventId} />}
        {tab === 'bids' && <BidsTab eventId={eventId} />}
      </div>
    </EventAdminLayout>
  );
}
