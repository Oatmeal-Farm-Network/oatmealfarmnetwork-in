/**
 * Shared address search / geocoding for Precision Ag maps.
 * India stack: Photon + Nominatim (IN) + Open-Meteo — no US Census.
 * USA stack: US Census (street) + Nominatim (US).
 */

export const isIndiaStack = () => import.meta.env.VITE_OFN_STACK === 'india';

const NOMINATIM_HEADERS = {
  Accept: 'application/json',
  'User-Agent': 'OatmealFarmNetwork/1.0 (https://oatmealfarmnetwork.com)',
};

export function defaultMapCenter() {
  if (isIndiaStack()) {
    return { lat: 20.5937, lon: 78.9629, zoom: 5 };
  }
  return { lat: 39.8283, lon: -98.5795, zoom: 4 };
}

function dedupeResults(rows) {
  const seen = new Set();
  return rows.filter((r) => {
    if (!Number.isFinite(r.lat) || !Number.isFinite(r.lon)) return false;
    const key = `${r.lat.toFixed(4)},${r.lon.toFixed(4)}`;
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

async function queryNominatim(val, { countryCodes = null, limit = 8 } = {}) {
  try {
    const cc = countryCodes ? `&countrycodes=${countryCodes}` : '';
    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(val)}${cc}&limit=${limit}&addressdetails=1`;
    const res = await fetch(url, { headers: NOMINATIM_HEADERS });
    const data = await res.json();
    if (!Array.isArray(data)) return [];
    return data.map((item) => ({
      display_name: item.display_name,
      lat: parseFloat(item.lat),
      lon: parseFloat(item.lon),
      source: 'nominatim',
    }));
  } catch {
    return [];
  }
}

/** Komoot Photon — strong global/village search, CORS-friendly, no API key. */
async function queryPhoton(val, limit = 8) {
  try {
    const url = `https://photon.komoot.io/api/?q=${encodeURIComponent(val)}&limit=${limit}&lang=en`;
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
    const url = `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(val)}&count=${limit}&language=en&format=json`;
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

async function queryCensus(val) {
  try {
    const url = `https://geocoding.geo.census.gov/geocoder/locations/onelineaddress?address=${encodeURIComponent(val)}&benchmark=Public_AR_Current&format=json`;
    const res = await fetch(url);
    const data = await res.json();
    const matches = data?.result?.addressMatches || [];
    return matches.map((m) => ({
      display_name: m.matchedAddress,
      lat: parseFloat(m.coordinates?.y),
      lon: parseFloat(m.coordinates?.x),
      source: 'census',
    })).filter((r) => Number.isFinite(r.lat) && Number.isFinite(r.lon));
  } catch {
    return [];
  }
}

/**
 * @returns {Promise<Array<{display_name:string, lat:number, lon:number, source:string}>>}
 */
export async function searchAddressSuggestions(val, { limit = 6 } = {}) {
  if (!val || val.length < 3) return [];

  const isStreet = /^\s*\d+\s+\S/.test(val);
  const india = isIndiaStack();

  let merged = [];
  if (india) {
    const [photonRes, nominatimRes, meteoRes] = await Promise.all([
      queryPhoton(val, 8),
      queryNominatim(val, { countryCodes: 'in', limit: 8 }),
      queryOpenMeteoGeocode(val, 5),
    ]);
    merged = dedupeResults([...photonRes, ...nominatimRes, ...meteoRes]);
    // Also try without country lock for hyphenated / partial village names
    if (merged.length < 2) {
      const globalNom = await queryNominatim(val, { countryCodes: null, limit: 6 });
      merged = dedupeResults([...merged, ...globalNom.filter((r) =>
        /india|karnataka|maharashtra|telangana|tamil|andhra|punjab|gujarat|572121/i.test(r.display_name),
      )]);
    }
  } else {
    const [censusRes, nominatimRes] = await Promise.all([
      isStreet ? queryCensus(val) : Promise.resolve([]),
      queryNominatim(val, { countryCodes: 'us', limit: 8 }),
    ]);
    merged = dedupeResults([...censusRes, ...nominatimRes]);
  }

  const lower = val.toLowerCase();
  return merged
    .map((r) => ({
      ...r,
      rankScore: r.display_name.toLowerCase().includes(lower) ? 100 : 0,
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
      `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}&zoom=14&addressdetails=1`,
      { headers: NOMINATIM_HEADERS },
    );
    const data = await res.json();
    if (!data?.address) return null;
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

/** Country suffix for business profile geocoding in add-field mode. */
export function geocodeCountrySuffix() {
  return isIndiaStack() ? 'India' : 'USA';
}
