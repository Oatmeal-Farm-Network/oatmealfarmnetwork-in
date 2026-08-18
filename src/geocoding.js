/**
 * Shared address search / geocoding for Precision Ag maps.
 * Prefer the India backend proxy (no browser CORS). Fall back to Photon + Open-Meteo.
 */

import { API_URL } from './precisionAgUtils';

export const isIndiaStack = () => {
  if (import.meta.env.VITE_OFN_STACK === 'india') return true;
  try {
    const host = window.location.hostname || '';
    if (host.includes('oatmealfarmnetwork-in') || host.includes('asia-south1')) return true;
  } catch { /* */ }
  return false;
};

export function defaultMapCenter() {
  if (isIndiaStack()) {
    return { lat: 20.5937, lon: 78.9629, zoom: 5 };
  }
  return { lat: 39.8283, lon: -98.5795, zoom: 4 };
}

const INDIA_BBOX = { minLon: 68.0, minLat: 6.5, maxLon: 97.5, maxLat: 35.7 };

function inIndia(lat, lon) {
  return lat >= INDIA_BBOX.minLat && lat <= INDIA_BBOX.maxLat
    && lon >= INDIA_BBOX.minLon && lon <= INDIA_BBOX.maxLon;
}

function dedupeResults(rows) {
  const seen = new Set();
  return rows.filter((r) => {
    if (!Number.isFinite(r.lat) || !Number.isFinite(r.lon)) return false;
    if (isIndiaStack() && !inIndia(r.lat, r.lon)) return false;
    const key = `${r.lat.toFixed(4)},${r.lon.toFixed(4)}`;
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

async function queryBackend(val, limit) {
  try {
    const url = `${API_URL}/api/geocode/search?q=${encodeURIComponent(val)}&limit=${limit}`;
    const res = await fetch(url, { headers: { Accept: 'application/json' } });
    if (!res.ok) return [];
    const data = await res.json();
    const rows = Array.isArray(data?.results) ? data.results : (Array.isArray(data) ? data : []);
    return rows.map((item) => ({
      display_name: item.display_name,
      lat: parseFloat(item.lat),
      lon: parseFloat(item.lon),
      source: item.source || 'backend',
    })).filter((r) => Number.isFinite(r.lat) && Number.isFinite(r.lon));
  } catch {
    return [];
  }
}

async function queryPhoton(val, limit = 8) {
  try {
    let url = `https://photon.komoot.io/api/?q=${encodeURIComponent(val)}&limit=${limit}&lang=en`;
    if (isIndiaStack()) {
      const { minLon, minLat, maxLon, maxLat } = INDIA_BBOX;
      url += `&bbox=${minLon},${minLat},${maxLon},${maxLat}`;
    }
    const res = await fetch(url, { headers: { Accept: 'application/json' } });
    const data = await res.json();
    const features = data?.features || [];
    return features.map((f) => {
      const p = f.properties || {};
      const [lon, lat] = f.geometry?.coordinates || [];
      const parts = [
        p.name,
        p.street,
        p.city || p.district || p.county,
        p.state,
        p.postcode,
        p.country,
      ].filter(Boolean);
      return {
        display_name: parts.join(', ') || p.name || val,
        lat: parseFloat(lat),
        lon: parseFloat(lon),
        source: 'photon',
      };
    }).filter((r) => Number.isFinite(r.lat) && Number.isFinite(r.lon));
  } catch {
    return [];
  }
}

async function queryOpenMeteoGeocode(val, limit = 5) {
  try {
    const name = String(val).split(',')[0].trim();
    if (name.length < 2) return [];
    const country = isIndiaStack() ? '&countryCode=IN' : '';
    const url = `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(name)}&count=${limit}&language=en&format=json${country}`;
    const res = await fetch(url, { headers: { Accept: 'application/json' } });
    const data = await res.json();
    return (data?.results || []).map((r) => ({
      display_name: [r.name, r.admin1, r.country_code?.toUpperCase()].filter(Boolean).join(', '),
      lat: r.latitude,
      lon: r.longitude,
      source: 'openmeteo',
    }));
  } catch {
    return [];
  }
}

function searchVariants(val) {
  const q = (val || '').trim();
  if (!q) return [];
  const out = [q];
  const first = q.split(',')[0].trim();
  if (first && first !== q) out.push(first);
  const pin = q.match(/\b\d{6}\b/);
  if (pin) out.push(`${pin[0]}, India`);
  if (isIndiaStack() && !/india/i.test(q)) out.push(`${q}, India`);
  return out;
}

export async function searchAddressSuggestions(val, { limit = 6 } = {}) {
  if (!val || val.length < 2) return [];

  const backend = await queryBackend(val, limit);
  if (backend.length) return backend.slice(0, limit);

  let merged = [];
  for (const variant of searchVariants(val)) {
    const [photonRes, meteoRes] = await Promise.all([
      queryPhoton(variant, 8),
      queryOpenMeteoGeocode(variant, 5),
    ]);
    merged = dedupeResults([...merged, ...photonRes, ...meteoRes]);
    if (merged.length >= limit) break;
  }

  const lower = val.toLowerCase().split(',')[0].trim();
  return merged
    .map((r) => ({
      ...r,
      rankScore: (r.display_name || '').toLowerCase().includes(lower) ? 100 : 0,
    }))
    .sort((a, b) => b.rankScore - a.rankScore)
    .slice(0, limit);
}

export async function geocodeOne(query) {
  const rows = await searchAddressSuggestions(query, { limit: 1 });
  return rows[0] || null;
}

export async function reverseGeocodeAddress(lat, lon) {
  try {
    const res = await fetch(
      `${API_URL}/api/geocode/search?q=${encodeURIComponent(`${lat},${lon}`)}&limit=1`,
    );
    if (res.ok) {
      const data = await res.json();
      const name = data?.results?.[0]?.display_name;
      if (name) return name;
    }
  } catch { /* */ }
  try {
    const res = await fetch(
      `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}&zoom=14&addressdetails=1`,
      { headers: { Accept: 'application/json' } },
    );
    const data = await res.json();
    if (!data?.address) return data?.display_name || null;
    const a = data.address;
    const parts = [
      a.road || a.neighbourhood || a.suburb || a.village || a.hamlet,
      a.city || a.town || a.village || a.county || a.state_district,
      a.state,
      a.postcode,
      a.country,
    ].filter(Boolean);
    return parts.join(', ');
  } catch {
    return null;
  }
}

export function geocodeCountrySuffix() {
  return isIndiaStack() ? 'India' : 'USA';
}
