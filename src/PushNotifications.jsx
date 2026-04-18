import React, { useEffect, useState } from 'react';
import { useUserProfile } from './useUserProfile.js';

const SAIGE_API = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8001';

function urlBase64ToUint8Array(base64String) {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding).replace(/-/g, '+').replace(/_/g, '/');
  const raw = atob(base64);
  const out = new Uint8Array(raw.length);
  for (let i = 0; i < raw.length; ++i) out[i] = raw.charCodeAt(i);
  return out;
}

export default function PushNotifications() {
  const { profile } = useUserProfile();
  const [supported, setSupported] = useState(false);
  const [permission, setPermission] = useState('default');
  const [subscribed, setSubscribed] = useState(false);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState('');
  const [pub, setPub] = useState('');
  const [configured, setConfigured] = useState(null);
  const [locLabel, setLocLabel] = useState(profile.label || '');
  const [locCoords, setLocCoords] = useState(
    profile.lat && profile.lon ? { lat: profile.lat, lon: profile.lon } : null
  );
  const [geoBusy, setGeoBusy] = useState(false);

  useEffect(() => {
    const ok = 'serviceWorker' in navigator && 'PushManager' in window;
    setSupported(ok);
    setPermission(typeof Notification !== 'undefined' ? Notification.permission : 'unsupported');

    fetch(`${SAIGE_API}/push/public-key`).then(r => r.json()).then(j => {
      setConfigured(!!j?.configured);
      setPub(j?.public_key || '');
    }).catch(() => setConfigured(false));

    if (ok) {
      navigator.serviceWorker.getRegistration('/push-sw.js').then(reg => {
        if (reg) reg.pushManager.getSubscription().then(s => setSubscribed(!!s));
      });
    }
  }, []);

  const subscribe = async () => {
    setErr('');
    if (!supported) return setErr('Push not supported in this browser.');
    if (!configured) return setErr('Server has no VAPID keys configured.');
    setBusy(true);
    try {
      const reg = await navigator.serviceWorker.register('/push-sw.js');
      await navigator.serviceWorker.ready;
      const perm = await Notification.requestPermission();
      setPermission(perm);
      if (perm !== 'granted') throw new Error('Permission denied.');

      const sub = await reg.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: urlBase64ToUint8Array(pub),
      });

      const userId = (JSON.parse(localStorage.getItem('ofnUser') || '{}')?.PeopleID) || 'anon';
      const location = locCoords
        ? { label: locLabel || null, lat: locCoords.lat, lon: locCoords.lon }
        : (locLabel ? { label: locLabel } : null);
      const res = await fetch(`${SAIGE_API}/push/subscribe`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ user_id: String(userId), subscription: sub, tags: ['farm-alerts'], location }),
      });
      const j = await res.json();
      if (j?.status !== 'ok') throw new Error(j?.message || 'Server rejected subscription.');
      setSubscribed(true);
    } catch (e) {
      setErr(e.message || String(e));
    } finally {
      setBusy(false);
    }
  };

  const unsubscribe = async () => {
    setBusy(true);
    try {
      const reg = await navigator.serviceWorker.getRegistration('/push-sw.js');
      const sub = reg ? await reg.pushManager.getSubscription() : null;
      if (sub) {
        await fetch(`${SAIGE_API}/push/unsubscribe`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ endpoint: sub.endpoint }),
        });
        await sub.unsubscribe();
      }
      setSubscribed(false);
    } catch (e) {
      setErr(e.message || String(e));
    } finally {
      setBusy(false);
    }
  };

  const useMyLocation = () => {
    if (!navigator.geolocation) return setErr('Geolocation not supported.');
    setGeoBusy(true);
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        setLocCoords({ lat: +pos.coords.latitude.toFixed(4), lon: +pos.coords.longitude.toFixed(4) });
        setGeoBusy(false);
      },
      (e) => { setErr(e.message || 'Location denied.'); setGeoBusy(false); },
      { maximumAge: 600000, timeout: 10000 }
    );
  };

  const testSend = async () => {
    setBusy(true);
    try {
      const userId = (JSON.parse(localStorage.getItem('ofnUser') || '{}')?.PeopleID) || 'anon';
      await fetch(`${SAIGE_API}/push/test`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ user_id: String(userId) }),
      });
    } finally {
      setBusy(false);
    }
  };

  return (
    <div style={{ maxWidth: 720, margin: '0 auto', padding: '24px 20px', fontFamily: 'Inter, system-ui, sans-serif' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 6 }}>
        <img src="/images/AI-agent-logo-saige.svg" alt="" style={{ width: 36, height: 36 }} />
        <h1 style={{ margin: 0, fontSize: 26, fontWeight: 800, color: '#14532d' }}>Farm Alerts (Push Notifications)</h1>
      </div>
      <p style={{ color: '#4b5563', marginTop: 4, marginBottom: 18 }}>
        Get notifications on this device when weather events, market-price triggers, or
        livestock alerts happen. Works on Chrome, Edge, Firefox, and (with the site
        installed to Home Screen) iOS Safari 16.4+.
      </p>

      <div style={{ background: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: 10, padding: 14, marginBottom: 14 }}>
        <div>Browser support: <strong>{supported ? 'Yes' : 'No'}</strong></div>
        <div>Notification permission: <strong>{permission}</strong></div>
        <div>Server configured: <strong>{configured === null ? 'checking…' : configured ? 'yes' : 'no (missing VAPID keys)'}</strong></div>
        <div>Subscribed on this device: <strong>{subscribed ? 'yes' : 'no'}</strong></div>
      </div>

      {!subscribed && (
        <div style={{ background: '#fff', border: '1px solid #e5e7eb', borderRadius: 10, padding: 14, marginBottom: 14 }}>
          <div style={{ fontWeight: 600, color: '#14532d', marginBottom: 8 }}>
            Farm location <span style={{ fontWeight: 400, color: '#6b7280', fontSize: 13 }}>(used for frost / heat / storm alerts)</span>
          </div>
          <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap', alignItems: 'center' }}>
            <input
              value={locLabel}
              onChange={(e) => setLocLabel(e.target.value)}
              placeholder="City, state — e.g. Topeka, KS"
              style={{ flex: '1 1 220px', padding: '8px 10px', border: '1px solid #d1d5db', borderRadius: 8 }}
            />
            <button onClick={useMyLocation} disabled={geoBusy} style={{ padding: '8px 14px', background: '#0f766e', color: '#fff', border: 'none', borderRadius: 8, cursor: 'pointer' }}>
              {geoBusy ? 'Locating…' : 'Use my location'}
            </button>
          </div>
          {locCoords && (
            <div style={{ marginTop: 6, fontSize: 12, color: '#4b5563' }}>
              Coordinates: {locCoords.lat}, {locCoords.lon}
            </div>
          )}
        </div>
      )}

      {err && <div style={{ background: '#fef2f2', border: '1px solid #fca5a5', color: '#991b1b', padding: 10, borderRadius: 8, marginBottom: 12 }}>{err}</div>}

      <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap' }}>
        {!subscribed ? (
          <button onClick={subscribe} disabled={busy || !supported || !configured} style={{ padding: '10px 20px', background: '#14532d', color: '#fff', border: 'none', borderRadius: 8, cursor: (busy || !supported || !configured) ? 'not-allowed' : 'pointer', opacity: (busy || !supported || !configured) ? 0.5 : 1 }}>
            {busy ? 'Working…' : 'Enable farm alerts'}
          </button>
        ) : (
          <>
            <button onClick={unsubscribe} disabled={busy} style={{ padding: '10px 20px', background: '#991b1b', color: '#fff', border: 'none', borderRadius: 8, cursor: busy ? 'not-allowed' : 'pointer' }}>
              {busy ? 'Working…' : 'Disable on this device'}
            </button>
            <button onClick={testSend} disabled={busy} style={{ padding: '10px 20px', background: '#0f766e', color: '#fff', border: 'none', borderRadius: 8, cursor: busy ? 'not-allowed' : 'pointer' }}>
              Send test notification
            </button>
          </>
        )}
      </div>

      <div style={{ marginTop: 22, fontSize: 13, color: '#6b7280' }}>
        To add this site to your phone's home screen: Chrome/Edge menu → "Install app";
        iOS Safari share sheet → "Add to Home Screen".
      </div>
    </div>
  );
}
