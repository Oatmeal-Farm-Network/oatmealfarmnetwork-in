import React, { useEffect, useState } from 'react';

const SAIGE_API = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8001';

function authHeaders() {
  const token = localStorage.getItem('access_token') || localStorage.getItem('AccessToken');
  return token ? { Authorization: `Bearer ${token}` } : {};
}

export default function SaigeFieldsCard() {
  const [state, setState] = useState({ loading: true, summary: '', alerts: '' });

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const [fRes, aRes] = await Promise.all([
          fetch(`${SAIGE_API}/precision-ag/fields`, { headers: authHeaders() }),
          fetch(`${SAIGE_API}/precision-ag/alerts`, { headers: authHeaders() }),
        ]);
        const fJson = fRes.ok ? await fRes.json() : null;
        const aJson = aRes.ok ? await aRes.json() : null;
        if (cancelled) return;
        setState({
          loading: false,
          summary: fJson?.summary || '',
          alerts: aJson?.summary || '',
        });
      } catch {
        if (!cancelled) setState({ loading: false, summary: '', alerts: '' });
      }
    })();
    return () => { cancelled = true; };
  }, []);

  if (state.loading) {
    return <div style={{ fontSize: 13, color: '#6b7280' }}>Loading your fields…</div>;
  }

  const hasFields = state.summary && !/no fields/i.test(state.summary);
  const hasAlerts = state.alerts && !/no active alerts/i.test(state.alerts) && !/^all clear/i.test(state.alerts);

  if (!hasFields) {
    return (
      <div style={{ fontSize: 13, color: '#6b7280' }}>
        No monitored fields on your account yet. Set one up in the Crop Monitor dashboard to have Saige track NDVI trends for you.
      </div>
    );
  }

  return (
    <div style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 12, padding: 14 }}>
      <div style={{ fontSize: 14, fontWeight: 700, color: '#14532d', marginBottom: 8 }}>My fields</div>
      <pre style={{ whiteSpace: 'pre-wrap', fontFamily: 'inherit', fontSize: 13, color: '#111827', margin: 0 }}>
        {state.summary}
      </pre>
      {hasAlerts && (
        <div style={{ marginTop: 10, padding: 10, background: '#fef2f2', border: '1px solid #fecaca', borderRadius: 8 }}>
          <div style={{ fontSize: 13, fontWeight: 700, color: '#991b1b', marginBottom: 4 }}>⚠ Active alerts</div>
          <pre style={{ whiteSpace: 'pre-wrap', fontFamily: 'inherit', fontSize: 12, color: '#7f1d1d', margin: 0 }}>
            {state.alerts}
          </pre>
        </div>
      )}
    </div>
  );
}
