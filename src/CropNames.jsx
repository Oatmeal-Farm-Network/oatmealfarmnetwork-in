import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

const SAIGE_API = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8001';

export default function CropNames() {
  const [crops, setCrops] = useState([]);
  const [query, setQuery] = useState('');
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState('');

  useEffect(() => {
    fetch(`${SAIGE_API}/crop-names`)
      .then(r => r.json())
      .then(j => setCrops(j?.crops || []))
      .catch(() => setErr('Could not reach service.'));
  }, []);

  const search = async (name) => {
    const q = (name || query).trim();
    if (!q) return;
    setLoading(true);
    setResult(null);
    setErr('');
    try {
      const r = await fetch(`${SAIGE_API}/crop-names/${encodeURIComponent(q)}`);
      const j = await r.json();
      if (j?.status === 'ok') setResult(j.record);
      else setErr(`No traditional-name data for "${q}".`);
    } catch {
      setErr('Lookup failed.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ maxWidth: 1000, margin: '0 auto', padding: '24px 20px', fontFamily: 'Inter, system-ui, sans-serif' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 6 }}>
        <img src="/images/AI-agent-logo-saige.svg" alt="" style={{ width: 36, height: 36 }} />
        <h1 style={{ margin: 0, fontSize: 26, fontWeight: 800, color: '#14532d' }}>Traditional & Local Crop Names</h1>
      </div>
      <p style={{ color: '#4b5563', marginTop: 4, marginBottom: 18 }}>
        Translate crop names across languages and regions. Type a local name
        ("brinjal", "melongene", "courgette") or a scientific name
        (<em>Solanum lycopersicum</em>) and see all known variants.{' '}
        <Link to="/saige">Ask Saige</Link> for deeper advice.
      </p>

      <div style={{ display: 'flex', gap: 8, marginBottom: 14 }}>
        <input
          list="known-crops"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onKeyDown={(e) => { if (e.key === 'Enter') search(); }}
          placeholder="e.g., brinjal, maize, ñame, gajar"
          style={{ flex: 1, padding: '10px 12px', border: '1px solid #d1d5db', borderRadius: 8 }}
        />
        <button
          onClick={() => search()}
          disabled={!query || loading}
          style={{ padding: '10px 18px', background: '#14532d', color: '#fff', border: 'none', borderRadius: 8, cursor: (!query || loading) ? 'not-allowed' : 'pointer', opacity: (!query || loading) ? 0.5 : 1 }}
        >{loading ? 'Looking…' : 'Translate'}</button>
      </div>

      <datalist id="known-crops">
        {crops.map(c => <option key={c} value={c} />)}
      </datalist>

      {err && <div style={{ background: '#fef2f2', border: '1px solid #fca5a5', color: '#991b1b', padding: 10, borderRadius: 8, marginBottom: 12 }}>{err}</div>}

      {result && (
        <div style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18 }}>
          <div style={{ fontSize: 18, fontWeight: 700, textTransform: 'capitalize', marginBottom: 2 }}>
            {result.canonical}
          </div>
          <div style={{ color: '#6b7280', fontStyle: 'italic', marginBottom: 14 }}>{result.scientific}</div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: 10 }}>
            {Object.entries(result.names || {}).map(([region, variants]) => (
              <div key={region} style={{ background: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: 8, padding: 10 }}>
                <div style={{ fontSize: 12, fontWeight: 700, color: '#0f766e', textTransform: 'uppercase', letterSpacing: 0.5 }}>{region}</div>
                <div style={{ marginTop: 4 }}>{variants.join(', ')}</div>
              </div>
            ))}
          </div>
        </div>
      )}

      <div style={{ marginTop: 22, background: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: 12, padding: 14 }}>
        <div style={{ fontWeight: 700, marginBottom: 8 }}>All canonical crops ({crops.length})</div>
        <div>
          {crops.map(c => (
            <button key={c} onClick={() => { setQuery(c); search(c); }} style={{ background: '#e2e8f0', border: 'none', padding: '4px 10px', borderRadius: 999, marginRight: 6, marginBottom: 6, cursor: 'pointer', textTransform: 'capitalize', fontSize: 13 }}>
              {c}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}
