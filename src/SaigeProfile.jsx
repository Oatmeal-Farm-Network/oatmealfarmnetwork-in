import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { useUserProfile } from './useUserProfile.js';

const CLIMATES = [
  'tropical', 'subtropical', 'arid', 'semi_arid',
  'temperate_maritime', 'temperate_continental', 'cold', 'mountain',
];
const ZONES = ['3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'];

export default function SaigeProfile() {
  const { profile, setProfile, clearProfile } = useUserProfile();
  const [city, setCity] = useState(profile.city);
  const [state, setState] = useState(profile.state);
  const [zone, setZone] = useState(profile.zone);
  const [climate, setClimate] = useState(profile.climate);
  const [lat, setLat] = useState(profile.lat || '');
  const [lon, setLon] = useState(profile.lon || '');
  const [crops, setCrops] = useState((profile.crops || []).join(', '));
  const [saved, setSaved] = useState(false);

  const save = () => {
    setProfile({
      city, state, zone, climate,
      lat: lat ? +lat : null,
      lon: lon ? +lon : null,
      crops: crops.split(',').map(s => s.trim()).filter(Boolean),
    });
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  const useMyLocation = () => {
    if (!navigator.geolocation) return;
    navigator.geolocation.getCurrentPosition((pos) => {
      setLat(+pos.coords.latitude.toFixed(4));
      setLon(+pos.coords.longitude.toFixed(4));
    });
  };

  const input = { padding: '8px 10px', border: '1px solid #d1d5db', borderRadius: 8, width: '100%' };
  const label = { fontSize: 13, color: '#374151', marginBottom: 4, display: 'block' };

  return (
    <div style={{ maxWidth: 720, margin: '0 auto', padding: '24px 20px', fontFamily: 'Inter, system-ui, sans-serif' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 6 }}>
        <img src="/images/AI-agent-logo-saige.svg" alt="" style={{ width: 36, height: 36 }} />
        <h1 style={{ margin: 0, fontSize: 26, fontWeight: 800, color: '#14532d' }}>Saige Profile</h1>
      </div>
      <p style={{ color: '#4b5563', marginTop: 4, marginBottom: 18 }}>
        Values saved here pre-fill every Saige tool — region, zone, climate, and
        your active crops. Override anything that auto-populates from your business.
        <Link to="/saige"> Back to Saige</Link>.
      </p>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: 12 }}>
        <div>
          <label style={label}>City</label>
          <input value={city} onChange={e => setCity(e.target.value)} style={input} placeholder="Topeka" />
        </div>
        <div>
          <label style={label}>State</label>
          <input value={state} onChange={e => setState(e.target.value.toUpperCase())} style={input} placeholder="KS" maxLength={2} />
        </div>
        <div>
          <label style={label}>USDA Zone</label>
          <select value={zone} onChange={e => setZone(e.target.value)} style={input}>
            <option value="">—</option>
            {ZONES.map(z => <option key={z} value={z}>{z}</option>)}
          </select>
        </div>
        <div>
          <label style={label}>Climate</label>
          <select value={climate} onChange={e => setClimate(e.target.value)} style={input}>
            <option value="">—</option>
            {CLIMATES.map(c => <option key={c} value={c}>{c.replace(/_/g, ' ')}</option>)}
          </select>
        </div>
        <div>
          <label style={label}>Latitude</label>
          <input value={lat} onChange={e => setLat(e.target.value)} style={input} placeholder="39.0473" />
        </div>
        <div>
          <label style={label}>Longitude</label>
          <input value={lon} onChange={e => setLon(e.target.value)} style={input} placeholder="-95.6752" />
        </div>
      </div>
      <button onClick={useMyLocation} style={{ marginTop: 8, padding: '6px 12px', background: '#fff', border: '1px solid #d1d5db', borderRadius: 6, cursor: 'pointer', fontSize: 12 }}>
        Use my current location
      </button>

      <div style={{ marginTop: 16 }}>
        <label style={label}>Active crops (comma-separated — used to prefill forms)</label>
        <input
          value={crops}
          onChange={e => setCrops(e.target.value)}
          style={input}
          placeholder="corn, soybean, tomato"
        />
      </div>

      <div style={{ marginTop: 20, display: 'flex', gap: 10, alignItems: 'center' }}>
        <button onClick={save} style={{ padding: '10px 20px', background: '#14532d', color: '#fff', border: 'none', borderRadius: 8, cursor: 'pointer' }}>
          Save profile
        </button>
        <button onClick={clearProfile} style={{ padding: '10px 20px', background: '#fff', color: '#991b1b', border: '1px solid #fca5a5', borderRadius: 8, cursor: 'pointer' }}>
          Clear overrides
        </button>
        {saved && <span style={{ color: '#14532d', fontWeight: 600 }}>Saved ✓</span>}
      </div>
    </div>
  );
}
