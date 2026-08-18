/**
 * Shared address search / geocoding for Precision Ag maps.
 * India-wide (any state). Instant local farm matches + Photon + backend proxy.
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

/** Public research / village farms in three states — quick picks, not a search filter. */
export const INDIA_EXAMPLE_FARMS = [
  {
    name: 'Somashettihalli',
    subtitle: 'Arodi, Koratagere, Tumakuru, Karnataka 572121',
    display_name: 'Somashettihalli, Arodi, Koratagere, Tumakuru, Karnataka 572121, India',
    lat: 13.54967,
    lon: 77.33739,
    source: 'farm',
    aliases: 'somashettihalli somashetti arodi koratagere tumakuru tumkur 572121 karnataka',
  },
  {
    name: 'ICRISAT Patancheru',
    subtitle: 'Patancheru, Hyderabad, Telangana 502324',
    display_name: 'ICRISAT, Patancheru, Hyderabad, Telangana 502324, India',
    lat: 17.5116,
    lon: 78.2752,
    source: 'farm',
    aliases: 'icrisat patancheru hyderabad telangana 502324',
  },
  {
    name: 'Punjab Agricultural University',
    subtitle: 'Ludhiana, Punjab 141004',
    display_name: 'Punjab Agricultural University, Ludhiana, Punjab 141004, India',
    lat: 30.9010,
    lon: 75.8072,
    source: 'farm',
    aliases: 'pau ludhiana punjab 141004 agricultural university',
  },
];

function inIndia(lat, lon) {
  return lat >= INDIA_BBOX.minLat && lat <= INDIA_BBOX.maxLat
    && lon >= INDIA_BBOX.minLon && lon <= INDIA_BBOX.maxLon;
}

function shape(row) {
  const display = row.display_name || row.name || '';
  const name = row.name || display.split(',')[0].trim();
  const subtitle = row.subtitle || display.split(',').slice(1).join(',').trim();
  return {
    ...row,
    name,
    subtitle,
    display_name: display || [name, subtitle].filter(Boolean).join(', '),
  };
}

function haystack(row) {
  return `${row.name || ''} ${row.subtitle || ''} ${row.display_name || ''} ${row.aliases || ''}`.toLowerCase();
}

export function matchLocalFarms(val) {
  const q = (val || '').trim().toLowerCase();
  if (!q) return INDIA_EXAMPLE_FARMS.map(shape);
  return INDIA_EXAMPLE_FARMS.filter((f) => haystack(f).includes(q)).map(shape);
}

function rankScore(row, val) {
  const q = (val || '').trim().toLowerCase();
  const token = q.split(',')[0].trim();
  const name = (row.name || '').toLowerCase();
  const full = haystack(row);
  const pin = (val || '').match(/\b\d{6}\b/);
  let s = 0;
  if (token && name.startsWith(token)) s += 220;
  else if (token && name.includes(token)) s += 90;
  else if (token && full.includes(token)) s += 45;
  if (row.source === 'farm') s += 25;
  if (pin && full.includes(pin[0])) s += 80;
  if ((row.subtitle || '').toLowerCase().includes('india') || full.includes('india')) s += 5;
  return s;
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

function rankAndSlice(rows, val, limit) {
  return dedupeResults(rows)
    .map((r) => ({ ...shape(r), rankScore: rankScore(r, val) }))
    .sort((a, b) => b.rankScore - a.rankScore)
    .slice(0, limit);
}

async function queryBackend(val, limit) {
  try {
    const url = `${API_URL}/api/geocode/search?q=${encodeURIComponent(val)}&limit=${limit}`;
    const res = await fetch(url, { headers: { Accept: 'application/json' } });
    if (!res.ok) return [];
    const data = await res.json();
    const rows = Array.isArray(data?.results) ? data.results : (Array.isArray(data) ? data : []);
    return rows.map((item) => shape({
      name: item.name,
      subtitle: item.subtitle,
      display_name: item.display_name,
      lat: parseFloat(item.lat),
      lon: parseFloat(item.lon),
      source: item.source || 'backend',
    })).filter((r) => Number.isFinite(r.lat) && Number.isFinite(r.lon));
  } catch {
    return [];
  }
}

async function queryPhoton(val, limit = 10) {
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
      const name = p.name || p.street || val;
      const subtitle = [
        p.street && p.street !== name ? p.street : null,
        p.city || p.district || p.county,
        p.state,
        p.postcode,
        p.country,
      ].filter(Boolean).join(', ');
      return shape({
        name,
        subtitle,
        display_name: [name, subtitle].filter(Boolean).join(', '),
        lat: parseFloat(lat),
        lon: parseFloat(lon),
        source: 'photon',
      });
    }).filter((r) => Number.isFinite(r.lat) && Number.isFinite(r.lon));
  } catch {
    return [];
  }
}

async function queryOpenMeteoGeocode(val, limit = 6) {
  try {
    const name = String(val).split(',')[0].trim();
    if (name.length < 2) return [];
    const country = isIndiaStack() ? '&countryCode=IN' : '';
    const url = `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(name)}&count=${limit}&language=en&format=json${country}`;
    const res = await fetch(url, { headers: { Accept: 'application/json' } });
    const data = await res.json();
    return (data?.results || []).map((r) => {
      const title = r.name;
      const subtitle = [r.admin2, r.admin1, r.country_code?.toUpperCase()].filter(Boolean).join(', ');
      return shape({
        name: title,
        subtitle,
        display_name: [title, subtitle].filter(Boolean).join(', '),
        lat: r.latitude,
        lon: r.longitude,
        source: 'openmeteo',
      });
    });
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

export async function searchAddressSuggestions(val, { limit = 8 } = {}) {
  if (!val || val.trim().length < 1) return matchLocalFarms('');
  const q = val.trim();
  const local = matchLocalFarms(q);

  const first = searchVariants(q)[0];
  const [backend, photonRes, meteoRes] = await Promise.all([
    queryBackend(q, limit),
    queryPhoton(first, 10),
    queryOpenMeteoGeocode(first, 6),
  ]);

  let merged = [...local, ...backend, ...photonRes, ...meteoRes];
  if (merged.length < 4) {
    for (const variant of searchVariants(q).slice(1, 3)) {
      const [p2, m2] = await Promise.all([
        queryPhoton(variant, 8),
        queryOpenMeteoGeocode(variant, 5),
      ]);
      merged = [...merged, ...p2, ...m2];
      if (dedupeResults(merged).length >= limit) break;
    }
  }

  return rankAndSlice(merged, q, limit);
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
