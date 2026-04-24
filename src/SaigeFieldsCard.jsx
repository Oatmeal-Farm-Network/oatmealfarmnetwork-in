import React, { useEffect, useState } from 'react';

const SAIGE_API = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8001/saige';

function authHeaders() {
  const token = localStorage.getItem('access_token') || localStorage.getItem('AccessToken');
  return token ? { Authorization: `Bearer ${token}` } : {};
}

function ndviColor(v) {
  if (v == null) return '#9CA3AF';
  if (v < 0.3) return '#EF4444';
  if (v < 0.45) return '#F97316';
  if (v < 0.6) return '#EAB308';
  if (v < 0.7) return '#84CC16';
  return '#22C55E';
}

function ndviLabel(v) {
  if (v == null) return 'No data';
  if (v < 0.3) return 'Poor';
  if (v < 0.45) return 'Stressed';
  if (v < 0.6) return 'Moderate';
  if (v < 0.7) return 'Good';
  return 'Excellent';
}

const SEV_STYLE = {
  critical: { bg: '#FEF2F2', text: '#991B1B', label: 'Critical' },
  high:     { bg: '#FFF7ED', text: '#9A3412', label: 'High' },
  medium:   { bg: '#FFFBEB', text: '#92400E', label: 'Medium' },
  low:      { bg: '#F0FDF4', text: '#166534', label: 'Low' },
};

const URGENCY_STYLE = {
  high:   { bg: '#FEF2F2', border: '#FECACA', text: '#991B1B', icon: '🚨', msg: 'Irrigate now — water deficit critical' },
  medium: { bg: '#FFFBEB', border: '#FDE68A', text: '#92400E', icon: '💧', msg: 'Consider irrigating within 2–3 days' },
  low:    { bg: '#F0FDF4', border: '#BBF7D0', text: '#166534', icon: '✅', msg: 'No irrigation needed' },
};

function NDVIMiniBar({ value }) {
  if (value == null) return (
    <span style={{ fontSize: 11, color: '#9CA3AF', fontFamily: 'var(--font-mont, sans-serif)' }}>—</span>
  );
  const color = ndviColor(value);
  const pct = Math.max(6, Math.min(100, (value / 1) * 100));
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
      <div style={{ flex: 1, background: '#F3F4F6', borderRadius: 999, height: 6, overflow: 'hidden', minWidth: 40 }}>
        <div style={{ width: `${pct}%`, height: '100%', background: color, borderRadius: 999 }} />
      </div>
      <span style={{ fontSize: 11, fontFamily: 'var(--font-mont, sans-serif)', color, fontWeight: 700, minWidth: 36 }}>
        {value.toFixed(3)}
      </span>
    </div>
  );
}

export default function SaigeFieldsCard() {
  const [state, setState] = useState({ loading: true, data: null, error: false });

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch(`${SAIGE_API}/precision-ag/dashboard`, { headers: authHeaders() });
        const json = res.ok ? await res.json() : null;
        if (cancelled) return;
        setState({ loading: false, data: json?.status === 'ok' ? json : null, error: !res.ok });
      } catch {
        if (!cancelled) setState({ loading: false, data: null, error: true });
      }
    })();
    return () => { cancelled = true; };
  }, []);

  if (state.loading) {
    return (
      <div style={{ fontSize: 13, color: '#6B7280', fontFamily: 'var(--font-mont, sans-serif)' }}>
        Loading your fields…
      </div>
    );
  }

  const data = state.data;

  if (!data || !data.fields || data.fields.length === 0) {
    return (
      <div style={{ fontSize: 13, color: '#6B7280', fontFamily: 'var(--font-mont, sans-serif)' }}>
        No monitored fields on your account yet. Set one up in the Crop Monitor dashboard to have Saige track NDVI trends for you.
      </div>
    );
  }

  const { fields, alerts = {}, irrigation_urgency } = data;
  const totalAlerts = Object.values(alerts).reduce((s, v) => s + v, 0);
  const hasCritical = (alerts.critical || 0) > 0;
  const hasHigh = (alerts.high || 0) > 0;
  const sortedFields = [...fields].sort((a, b) => (b.ndvi ?? -1) - (a.ndvi ?? -1));
  const bestField = sortedFields[0];
  const maxNDVI = bestField?.ndvi ?? 1;
  const urgencyStyle = irrigation_urgency ? URGENCY_STYLE[irrigation_urgency] : null;

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
      {/* Irrigation urgency banner — only show high/medium */}
      {urgencyStyle && irrigation_urgency !== 'low' && (
        <div style={{
          background: urgencyStyle.bg,
          border: `1px solid ${urgencyStyle.border}`,
          borderRadius: 8,
          padding: '8px 12px',
          display: 'flex',
          alignItems: 'center',
          gap: 8,
        }}>
          <span style={{ fontSize: 16 }}>{urgencyStyle.icon}</span>
          <span style={{ fontSize: 12, fontWeight: 700, color: urgencyStyle.text, fontFamily: 'var(--font-mont, sans-serif)' }}>
            {urgencyStyle.msg}
            {bestField && ` — ${bestField.name}`}
          </span>
        </div>
      )}

      {/* Alert severity pills */}
      {totalAlerts > 0 && (
        <div style={{
          background: hasCritical ? '#FEF2F2' : hasHigh ? '#FFF7ED' : '#FFFBEB',
          border: `1px solid ${hasCritical ? '#FECACA' : hasHigh ? '#FED7AA' : '#FDE68A'}`,
          borderRadius: 8,
          padding: '8px 12px',
        }}>
          <div style={{
            fontSize: 12,
            fontWeight: 700,
            color: hasCritical ? '#991B1B' : '#92400E',
            fontFamily: 'var(--font-mont, sans-serif)',
            marginBottom: 6,
          }}>
            {hasCritical ? '🚨' : '⚠️'} {totalAlerts} active alert{totalAlerts !== 1 ? 's' : ''}
          </div>
          <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap' }}>
            {['critical', 'high', 'medium', 'low'].map(sev => {
              const count = alerts[sev] || 0;
              if (!count) return null;
              const s = SEV_STYLE[sev];
              return (
                <span key={sev} style={{
                  background: s.bg,
                  color: s.text,
                  border: `1px solid ${s.text}33`,
                  borderRadius: 999,
                  padding: '2px 8px',
                  fontSize: 11,
                  fontWeight: 700,
                  fontFamily: 'var(--font-mont, sans-serif)',
                }}>
                  {count} {s.label}
                </span>
              );
            })}
          </div>
        </div>
      )}

      {/* Fields table */}
      <div style={{
        background: '#fff',
        border: '1px solid #E5E7EB',
        borderRadius: 10,
        overflow: 'hidden',
      }}>
        <div style={{
          padding: '8px 12px',
          borderBottom: '1px solid #F3F4F6',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
        }}>
          <span style={{ fontSize: 13, fontWeight: 700, color: '#14532D', fontFamily: 'var(--font-lora, serif)' }}>
            My fields
          </span>
          <span style={{ fontSize: 11, color: '#9CA3AF', fontFamily: 'var(--font-mont, sans-serif)' }}>
            {fields.length} field{fields.length !== 1 ? 's' : ''}
          </span>
        </div>
        {sortedFields.slice(0, 6).map((f, i) => {
          const color = ndviColor(f.ndvi);
          const barPct = f.ndvi != null ? Math.max(4, Math.min(100, (f.ndvi / Math.max(maxNDVI, 0.01)) * 100)) : 0;
          const isTop = i === 0 && f.ndvi != null;
          return (
            <div key={f.field_id} style={{
              padding: '9px 12px',
              borderTop: i === 0 ? 'none' : '1px solid #F9FAFB',
              background: isTop ? '#F0FDF4' : '#fff',
              display: 'grid',
              gridTemplateColumns: '1fr auto',
              gap: '4px 12px',
              alignItems: 'center',
            }}>
              <div>
                <div style={{
                  fontSize: 12,
                  fontWeight: 700,
                  color: '#111827',
                  fontFamily: 'var(--font-mont, sans-serif)',
                  display: 'flex',
                  alignItems: 'center',
                  gap: 5,
                }}>
                  {isTop && <span style={{ fontSize: 12 }}>🏆</span>}
                  {f.name}
                  {f.crop_type && (
                    <span style={{ fontSize: 10, color: '#6B7280', fontWeight: 400 }}>
                      · {f.crop_type}
                    </span>
                  )}
                </div>
                <div style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: 6,
                  marginTop: 4,
                }}>
                  <div style={{
                    flex: 1,
                    background: '#F3F4F6',
                    borderRadius: 999,
                    height: 5,
                    overflow: 'hidden',
                    minWidth: 60,
                  }}>
                    <div style={{ width: `${barPct}%`, height: '100%', background: color + 'CC', borderRadius: 999 }} />
                  </div>
                  <span style={{
                    fontSize: 10,
                    color,
                    fontWeight: 700,
                    fontFamily: 'var(--font-mont, sans-serif)',
                    minWidth: 40,
                  }}>
                    {f.ndvi != null ? `${f.ndvi.toFixed(3)}` : '—'}
                  </span>
                  <span style={{
                    fontSize: 10,
                    color: '#9CA3AF',
                    fontFamily: 'var(--font-mont, sans-serif)',
                  }}>
                    {ndviLabel(f.ndvi)}
                  </span>
                </div>
              </div>
              {!f.monitoring_enabled && (
                <span style={{ fontSize: 10, color: '#9CA3AF', fontFamily: 'var(--font-mont, sans-serif)' }}>
                  off
                </span>
              )}
            </div>
          );
        })}
        {fields.length > 6 && (
          <div style={{
            padding: '8px 12px',
            borderTop: '1px solid #F3F4F6',
            fontSize: 11,
            color: '#9CA3AF',
            fontFamily: 'var(--font-mont, sans-serif)',
            textAlign: 'center',
          }}>
            +{fields.length - 6} more fields — ask me about them
          </div>
        )}
      </div>

      {/* Quick-start suggestions */}
      <div style={{ fontSize: 11, color: '#9CA3AF', fontFamily: 'var(--font-mont, sans-serif)', lineHeight: 1.5 }}>
        Try: "How is my {bestField?.name || 'top field'} doing?" · "Any fields need irrigation?" · "Show me a benchmark"
      </div>
    </div>
  );
}
