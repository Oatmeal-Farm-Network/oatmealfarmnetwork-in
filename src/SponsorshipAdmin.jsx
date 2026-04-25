import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';
import RichTextEditor from './RichTextEditor';

const API = import.meta.env.VITE_API_URL || '';
const inp = "border border-gray-300 rounded-lg px-3 py-2 text-sm w-full focus:outline-none focus:border-[#819360]";
const lbl = "block text-xs font-medium text-gray-500 mb-1";
const btn = "px-4 py-1.5 text-sm bg-[#3D6B34] text-white rounded-lg hover:bg-[#2d5226] disabled:opacity-50";
const btnGhost = "px-3 py-1.5 text-sm border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50";

const STATUS_OPTIONS = ['pending', 'confirmed', 'declined'];
const PAID_OPTIONS   = ['unpaid', 'partial', 'paid', 'refunded'];
const ZONE_OPTIONS   = [
  { key: 'website',  label: 'Public website' },
  { key: 'badges',   label: 'Attendee badges' },
  { key: 'signage',  label: 'On-site signage' },
  { key: 'emails',   label: 'Marketing emails' },
  { key: 'sessions', label: 'Sponsored sessions' },
];

function StatusBadge({ value }) {
  const colors = {
    pending:   'bg-amber-100 text-amber-800 border-amber-200',
    confirmed: 'bg-green-100 text-green-800 border-green-200',
    declined:  'bg-gray-100 text-gray-700 border-gray-200',
    unpaid:    'bg-red-100 text-red-800 border-red-200',
    partial:   'bg-amber-100 text-amber-800 border-amber-200',
    paid:      'bg-green-100 text-green-800 border-green-200',
    refunded:  'bg-blue-100 text-blue-800 border-blue-200',
  };
  return (
    <span className={`inline-block text-[10px] px-2 py-0.5 rounded-full border font-medium uppercase tracking-wide ${colors[value] || 'bg-gray-100 text-gray-700 border-gray-200'}`}>
      {value}
    </span>
  );
}

// ─── Tier editor ────────────────────────────────────────────────────────────
function TierForm({ tier, onSave, onCancel }) {
  const [t, setT] = useState(tier || {
    Name: '', Price: 0, MaxSlots: '', BenefitsHTML: '',
    LogoSizePx: 200, DisplayColumns: 3, SortOrder: 100, IsActive: true,
  });
  const set = k => e => setT(s => ({ ...s, [k]: e.target.value }));
  const setNum = k => e => setT(s => ({ ...s, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
        <div><label className={lbl}>Tier Name *</label>
          <input className={inp} placeholder="e.g. Gold" value={t.Name || ''} onChange={set('Name')} /></div>
        <div><label className={lbl}>Price ($)</label>
          <input className={inp} type="number" step="0.01" value={t.Price ?? 0} onChange={setNum('Price')} /></div>
        <div><label className={lbl}>Max slots</label>
          <input className={inp} type="number" value={t.MaxSlots ?? ''} placeholder="unlimited" onChange={setNum('MaxSlots')} /></div>
        <div><label className={lbl}>Sort order</label>
          <input className={inp} type="number" value={t.SortOrder ?? 100} onChange={setNum('SortOrder')} /></div>
        <div><label className={lbl}>Logo size (px)</label>
          <input className={inp} type="number" value={t.LogoSizePx ?? 200} onChange={setNum('LogoSizePx')} /></div>
        <div><label className={lbl}>Display cols (public)</label>
          <input className={inp} type="number" min="1" max="6" value={t.DisplayColumns ?? 3} onChange={setNum('DisplayColumns')} /></div>
        <div className="flex items-end">
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={!!t.IsActive} onChange={e => setT(s => ({ ...s, IsActive: e.target.checked }))} />
            Active
          </label>
        </div>
      </div>
      <div>
        <label className={lbl}>Benefits (HTML — bullet list of perks for this tier)</label>
        <RichTextEditor value={t.BenefitsHTML || ''} onChange={v => setT(s => ({ ...s, BenefitsHTML: v }))} minHeight={120} />
      </div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(t)} disabled={!t.Name} className={btn}>Save Tier</button>
      </div>
    </div>
  );
}

// ─── Sponsor editor ─────────────────────────────────────────────────────────
function SponsorForm({ sponsor, tiers, onSave, onCancel }) {
  const [s, setS] = useState(sponsor || {
    TierID: tiers?.[0]?.TierID || null, BusinessName: '', ContactName: '',
    ContactEmail: '', ContactPhone: '', LogoURL: '', WebsiteURL: '', Tagline: '',
    Status: 'pending', PaidStatus: 'unpaid', AmountPaid: 0,
    DisplayZones: 'website', SortOrder: 100, Notes: '',
  });
  const set = k => e => setS(prev => ({ ...prev, [k]: e.target.value }));
  const setNum = k => e => setS(prev => ({ ...prev, [k]: e.target.value === '' ? null : Number(e.target.value) }));
  const zonesArr = (s.DisplayZones || '').split(',').map(x => x.trim()).filter(Boolean);
  const toggleZone = key => {
    const next = zonesArr.includes(key) ? zonesArr.filter(z => z !== key) : [...zonesArr, key];
    setS(prev => ({ ...prev, DisplayZones: next.join(',') }));
  };

  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 space-y-3">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        <div>
          <label className={lbl}>Tier *</label>
          <select className={inp} value={s.TierID ?? ''} onChange={e => setS(p => ({ ...p, TierID: Number(e.target.value) || null }))}>
            <option value="">— Pick a tier —</option>
            {tiers.map(t => <option key={t.TierID} value={t.TierID}>{t.Name} (${Number(t.Price || 0).toFixed(0)})</option>)}
          </select>
        </div>
        <div><label className={lbl}>Business name *</label>
          <input className={inp} value={s.BusinessName || ''} onChange={set('BusinessName')} /></div>
        <div><label className={lbl}>Business ID (optional)</label>
          <input className={inp} type="number" value={s.BusinessID ?? ''} onChange={setNum('BusinessID')} placeholder="links to OFN business" /></div>
        <div><label className={lbl}>Contact name</label>
          <input className={inp} value={s.ContactName || ''} onChange={set('ContactName')} /></div>
        <div><label className={lbl}>Contact email</label>
          <input className={inp} type="email" value={s.ContactEmail || ''} onChange={set('ContactEmail')} /></div>
        <div><label className={lbl}>Contact phone</label>
          <input className={inp} value={s.ContactPhone || ''} onChange={set('ContactPhone')} /></div>
        <div className="md:col-span-2"><label className={lbl}>Logo URL</label>
          <input className={inp} value={s.LogoURL || ''} onChange={set('LogoURL')} placeholder="https://…" /></div>
        <div><label className={lbl}>Website URL</label>
          <input className={inp} value={s.WebsiteURL || ''} onChange={set('WebsiteURL')} /></div>
        <div className="md:col-span-3"><label className={lbl}>Tagline</label>
          <input className={inp} value={s.Tagline || ''} onChange={set('Tagline')} placeholder="One-line message shown next to the logo" /></div>
        <div>
          <label className={lbl}>Status</label>
          <select className={inp} value={s.Status} onChange={set('Status')}>
            {STATUS_OPTIONS.map(o => <option key={o} value={o}>{o}</option>)}
          </select>
        </div>
        <div>
          <label className={lbl}>Paid status</label>
          <select className={inp} value={s.PaidStatus} onChange={set('PaidStatus')}>
            {PAID_OPTIONS.map(o => <option key={o} value={o}>{o}</option>)}
          </select>
        </div>
        <div><label className={lbl}>Amount paid ($)</label>
          <input className={inp} type="number" step="0.01" value={s.AmountPaid ?? 0} onChange={setNum('AmountPaid')} /></div>
        <div><label className={lbl}>Sort order</label>
          <input className={inp} type="number" value={s.SortOrder ?? 100} onChange={setNum('SortOrder')} /></div>
      </div>
      <div>
        <label className={lbl}>Logo placement zones (where this sponsor's logo appears)</label>
        <div className="flex flex-wrap gap-2">
          {ZONE_OPTIONS.map(z => (
            <label key={z.key} className={`flex items-center gap-1.5 text-xs px-2.5 py-1 rounded-lg border cursor-pointer ${zonesArr.includes(z.key) ? 'bg-[#3D6B34] text-white border-[#3D6B34]' : 'bg-white text-gray-700 border-gray-300'}`}>
              <input type="checkbox" checked={zonesArr.includes(z.key)} onChange={() => toggleZone(z.key)} className="hidden" />
              {z.label}
            </label>
          ))}
        </div>
      </div>
      <div><label className={lbl}>Internal notes</label>
        <textarea className={inp} rows={2} value={s.Notes || ''} onChange={set('Notes')} /></div>
      <div className="flex justify-end gap-2">
        {onCancel && <button onClick={onCancel} className={btnGhost}>Cancel</button>}
        <button onClick={() => onSave(s)} disabled={!s.BusinessName || !s.TierID} className={btn}>Save Sponsor</button>
      </div>
    </div>
  );
}

// ─── Main ───────────────────────────────────────────────────────────────────
export default function SponsorshipAdmin() {
  const { eventId } = useParams();
  const [tab, setTab] = useState('sponsors');
  const [tiers, setTiers] = useState([]);
  const [sponsors, setSponsors] = useState([]);
  const [summary, setSummary] = useState(null);
  const [loading, setLoading] = useState(true);
  const [editingTier, setEditingTier] = useState(null);
  const [editingSponsor, setEditingSponsor] = useState(null);
  const [adding, setAdding] = useState(null); // 'tier' | 'sponsor' | null

  const refresh = () => {
    setLoading(true);
    Promise.all([
      fetch(`${API}/api/events/${eventId}/sponsorship/tiers`).then(r => r.ok ? r.json() : []),
      fetch(`${API}/api/events/${eventId}/sponsors`).then(r => r.ok ? r.json() : []),
      fetch(`${API}/api/events/${eventId}/sponsorship/summary`).then(r => r.ok ? r.json() : null),
    ]).then(([t, s, sum]) => {
      setTiers(t); setSponsors(s); setSummary(sum); setLoading(false);
    });
  };
  useEffect(refresh, [eventId]);

  const saveTier = async (t) => {
    const isEdit = !!t.TierID;
    const url = isEdit
      ? `${API}/api/events/sponsorship/tiers/${t.TierID}`
      : `${API}/api/events/${eventId}/sponsorship/tiers`;
    const r = await fetch(url, {
      method: isEdit ? 'PUT' : 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(t),
    });
    if (r.ok) { setEditingTier(null); setAdding(null); refresh(); }
    else alert('Save failed');
  };

  const deleteTier = async (tierId) => {
    if (!window.confirm('Delete this tier? Sponsors must be reassigned first.')) return;
    const r = await fetch(`${API}/api/events/sponsorship/tiers/${tierId}`, { method: 'DELETE' });
    if (r.ok) refresh();
    else alert((await r.json().catch(() => ({}))).detail || 'Delete failed');
  };

  const saveSponsor = async (s) => {
    const isEdit = !!s.SponsorID;
    const url = isEdit
      ? `${API}/api/events/sponsors/${s.SponsorID}`
      : `${API}/api/events/${eventId}/sponsors`;
    const r = await fetch(url, {
      method: isEdit ? 'PUT' : 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(s),
    });
    if (r.ok) { setEditingSponsor(null); setAdding(null); refresh(); }
    else alert((await r.json().catch(() => ({}))).detail || 'Save failed');
  };

  const deleteSponsor = async (sponsorId) => {
    if (!window.confirm('Delete this sponsor?')) return;
    const r = await fetch(`${API}/api/events/sponsors/${sponsorId}`, { method: 'DELETE' });
    if (r.ok) refresh();
  };

  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-6xl mx-auto p-5 space-y-5">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">Sponsorship</h1>
            <p className="text-sm text-gray-500">Tiers, sponsors, logo placement, and revenue.</p>
          </div>
          <Link to={`/events/${eventId}`} className={btnGhost}>← Event detail</Link>
        </div>

        {/* Summary tiles */}
        {summary && (
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            <div className="bg-white border border-gray-200 rounded-xl p-4">
              <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Revenue</div>
              <div className="text-2xl font-bold text-gray-900 mt-1">${Number(summary.total_revenue || 0).toLocaleString()}</div>
            </div>
            <div className="bg-white border border-gray-200 rounded-xl p-4">
              <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Confirmed</div>
              <div className="text-2xl font-bold text-gray-900 mt-1">{summary.total_confirmed}</div>
            </div>
            <div className="bg-white border border-gray-200 rounded-xl p-4">
              <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">In pipeline</div>
              <div className="text-2xl font-bold text-gray-900 mt-1">{summary.total_pipeline}</div>
            </div>
            <div className="bg-white border border-gray-200 rounded-xl p-4">
              <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Tiers</div>
              <div className="text-2xl font-bold text-gray-900 mt-1">{tiers.length}</div>
            </div>
          </div>
        )}

        {/* Tabs */}
        <div className="border-b border-gray-200 flex gap-4">
          {['sponsors','tiers'].map(t => (
            <button key={t} onClick={() => setTab(t)}
              className={`px-3 py-2 text-sm font-medium ${tab === t ? 'text-[#3D6B34] border-b-2 border-[#3D6B34]' : 'text-gray-500'}`}>
              {t === 'sponsors' ? `Sponsors (${sponsors.length})` : `Tiers (${tiers.length})`}
            </button>
          ))}
        </div>

        {loading && <div className="text-sm text-gray-500">Loading…</div>}

        {/* SPONSORS TAB */}
        {!loading && tab === 'sponsors' && (
          <div className="space-y-3">
            {tiers.length === 0 && (
              <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 text-sm text-amber-800">
                Create at least one tier first (Tiers tab).
              </div>
            )}
            <div className="flex justify-end">
              <button onClick={() => setAdding('sponsor')} disabled={tiers.length === 0} className={btn}>+ Add sponsor</button>
            </div>
            {adding === 'sponsor' && (
              <SponsorForm tiers={tiers} onSave={saveSponsor} onCancel={() => setAdding(null)} />
            )}
            {sponsors.length === 0 && tiers.length > 0 && (
              <div className="text-sm text-gray-500 italic">No sponsors yet. Add your first sponsor above.</div>
            )}
            {sponsors.map(s => editingSponsor?.SponsorID === s.SponsorID ? (
              <SponsorForm key={s.SponsorID} sponsor={editingSponsor} tiers={tiers}
                onSave={saveSponsor} onCancel={() => setEditingSponsor(null)} />
            ) : (
              <div key={s.SponsorID} className="bg-white border border-gray-200 rounded-xl p-4 flex items-center gap-4">
                {s.LogoURL ? (
                  <img src={s.LogoURL} alt={s.BusinessName} style={{ width: 80, height: 60, objectFit: 'contain' }} className="rounded border border-gray-100 bg-gray-50" />
                ) : (
                  <div className="w-20 h-15 bg-gray-100 rounded text-[10px] text-gray-400 flex items-center justify-center" style={{ width: 80, height: 60 }}>No logo</div>
                )}
                <div className="flex-1">
                  <div className="flex items-center gap-2 flex-wrap">
                    <strong>{s.BusinessName}</strong>
                    <span className="text-xs text-gray-500">— {s.TierName || '(no tier)'}</span>
                    <StatusBadge value={s.Status} />
                    <StatusBadge value={s.PaidStatus} />
                  </div>
                  {s.Tagline && <div className="text-xs text-gray-600 mt-0.5">{s.Tagline}</div>}
                  <div className="text-[11px] text-gray-400 mt-0.5 flex flex-wrap gap-x-3">
                    {s.ContactName && <span>{s.ContactName}</span>}
                    {s.ContactEmail && <span>{s.ContactEmail}</span>}
                    {s.WebsiteURL && <a href={s.WebsiteURL} target="_blank" rel="noreferrer" className="text-blue-600 hover:underline">{s.WebsiteURL}</a>}
                    {s.AmountPaid > 0 && <span>Paid: ${Number(s.AmountPaid).toFixed(2)}</span>}
                    {s.DisplayZones && <span>Zones: {s.DisplayZones}</span>}
                  </div>
                </div>
                <button onClick={() => setEditingSponsor(s)} className={btnGhost}>Edit</button>
                <button onClick={() => deleteSponsor(s.SponsorID)} className="text-xs text-red-600 hover:underline">Delete</button>
              </div>
            ))}
          </div>
        )}

        {/* TIERS TAB */}
        {!loading && tab === 'tiers' && (
          <div className="space-y-3">
            <div className="flex justify-end">
              <button onClick={() => setAdding('tier')} className={btn}>+ Add tier</button>
            </div>
            {adding === 'tier' && (
              <TierForm onSave={saveTier} onCancel={() => setAdding(null)} />
            )}
            {tiers.length === 0 && <div className="text-sm text-gray-500 italic">No tiers yet. Add your first tier above.</div>}
            {tiers.map(t => editingTier?.TierID === t.TierID ? (
              <TierForm key={t.TierID} tier={editingTier} onSave={saveTier} onCancel={() => setEditingTier(null)} />
            ) : (
              <div key={t.TierID} className="bg-white border border-gray-200 rounded-xl p-4">
                <div className="flex items-start gap-4">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 flex-wrap">
                      <strong className="text-lg">{t.Name}</strong>
                      <span className="text-gray-500">${Number(t.Price || 0).toLocaleString()}</span>
                      {t.MaxSlots != null && (
                        <span className="text-xs text-gray-500">({t.SlotsTaken || 0}/{t.MaxSlots} slots taken)</span>
                      )}
                      {!t.IsActive && <StatusBadge value="declined" />}
                    </div>
                    {t.BenefitsHTML && (
                      <div className="text-xs text-gray-600 mt-1 prose prose-xs max-w-none" dangerouslySetInnerHTML={{ __html: t.BenefitsHTML }} />
                    )}
                  </div>
                  <button onClick={() => setEditingTier(t)} className={btnGhost}>Edit</button>
                  <button onClick={() => deleteTier(t.TierID)} className="text-xs text-red-600 hover:underline">Delete</button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </EventAdminLayout>
  );
}
