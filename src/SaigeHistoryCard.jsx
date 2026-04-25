import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

const SAIGE_API = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8000/saige';

const TYPE_META = {
  pest:  { label: 'Pest scan',     color: '#991b1b', to: '/saige/pest-detection' },
  soil:  { label: 'Soil test',     color: '#854d0e', to: '/saige/soil-challenges' },
  price: { label: 'Price forecast',color: '#0f766e', to: '/saige/price-forecast' },
};

function summarize(e) {
  const p = e.payload || {};
  if (e.type === 'pest')  return `${p.diagnosis || 'unknown'} (${p.confidence || '—'})`;
  if (e.type === 'soil')  return p.headline || `${(p.challenges || []).length} challenges`;
  if (e.type === 'price') return `${p.commodity || '?'} — ${p.confidence || '—'} confidence`;
  return '';
}

export default function SaigeHistoryCard({ limit = 5 }) {
  const [entries, setEntries] = useState(null);

  useEffect(() => {
    const uid = String(JSON.parse(localStorage.getItem('ofnUser') || '{}')?.PeopleID || '');
    if (!uid) { setEntries([]); return; }
    fetch(`${SAIGE_API}/history/${encodeURIComponent(uid)}?limit=${limit}`)
      .then(r => r.json())
      .then(j => setEntries(j?.entries || []))
      .catch(() => setEntries([]));
  }, [limit]);

  if (entries === null) {
    return <div style={{ fontSize: 13, color: '#6b7280' }}>Loading Saige history…</div>;
  }
  if (entries.length === 0) {
    return (
      <div style={{ fontSize: 13, color: '#6b7280' }}>
        No Saige history yet — run a <Link to="/saige/pest-detection">pest scan</Link>,{' '}
        <Link to="/saige/soil-challenges">soil test</Link>, or{' '}
        <Link to="/saige/price-forecast">price forecast</Link> to start building one.
      </div>
    );
  }

  return (
    <div style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12, padding: 14 }}>
      <div style={{ fontSize: 14, fontWeight: 700, color: '#14532d', marginBottom: 8 }}>Recent Saige activity</div>
      <div style={{ display: 'grid', gap: 8 }}>
        {entries.map(e => {
          const meta = TYPE_META[e.type] || { label: e.type, color: '#4b5563', to: '/saige' };
          const when = e.created_at ? new Date(e.created_at).toLocaleString() : '';
          return (
            <Link
              key={e.id}
              to={meta.to}
              style={{ display: 'block', padding: '8px 10px', border: '1px solid #e5e7eb', borderRadius: 8, textDecoration: 'none', color: 'inherit' }}
            >
              <div style={{ display: 'flex', gap: 8, alignItems: 'baseline', flexWrap: 'wrap' }}>
                <span style={{ fontWeight: 700, fontSize: 12, color: meta.color }}>{meta.label}</span>
                <span style={{ fontSize: 13, color: '#111827' }}>{summarize(e)}</span>
                <span style={{ marginLeft: 'auto', fontSize: 11, color: '#6b7280' }}>{when}</span>
              </div>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
