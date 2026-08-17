/**
 * Local-meter projection and polygon helpers for the Field Twin scene.
 * Origin is WGS84 lon/lat; X = east meters, Z = south meters (Three.js Y-up).
 */

const DEG2RAD = Math.PI / 180;
const METERS_PER_DEG_LAT = 111320;

export function metersPerDegLon(lat) {
  return METERS_PER_DEG_LAT * Math.cos(lat * DEG2RAD);
}

export function lngLatToLocal(lng, lat, origin) {
  const oLat = origin.latitude;
  const oLon = origin.longitude;
  const x = (lng - oLon) * metersPerDegLon(oLat);
  const z = (oLat - lat) * METERS_PER_DEG_LAT; // +Z = south
  return { x, z };
}

export function localToLngLat(x, z, origin) {
  const lat = origin.latitude - z / METERS_PER_DEG_LAT;
  const lng = origin.longitude + x / metersPerDegLon(origin.latitude);
  return { lng, lat };
}

/** Ray-cast point-in-polygon. ring = [[lng,lat], ...] */
export function pointInRing(lng, lat, ring) {
  if (!ring || ring.length < 3) return false;
  let inside = false;
  for (let i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    const xi = ring[i][0];
    const yi = ring[i][1];
    const xj = ring[j][0];
    const yj = ring[j][1];
    const intersect = ((yi > lat) !== (yj > lat))
      && (lng < ((xj - xi) * (lat - yi)) / ((yj - yi) || 1e-12) + xi);
    if (intersect) inside = !inside;
  }
  return inside;
}

export function extractOuterRings(boundary) {
  if (!boundary) return [];
  let geom = boundary;
  if (boundary.type === 'FeatureCollection') {
    geom = boundary.features?.[0]?.geometry;
  } else if (boundary.type === 'Feature') {
    geom = boundary.geometry;
  }
  if (!geom) return [];
  if (geom.type === 'Polygon') return [geom.coordinates[0]];
  if (geom.type === 'MultiPolygon') return geom.coordinates.map((p) => p[0]);
  return [];
}

export function pointInBoundary(lng, lat, boundary) {
  const rings = extractOuterRings(boundary);
  // No usable polygon → treat the whole bbox as plantable (caller still limits by bbox).
  if (!rings.length) return true;
  return rings.some((ring) => pointInRing(lng, lat, ring));
}

/** Deterministic PRNG (mulberry32). */
export function mulberry32(seed) {
  let t = seed >>> 0;
  return () => {
    t += 0x6D2B79F5;
    let r = Math.imul(t ^ (t >>> 15), 1 | t);
    r ^= r + Math.imul(r ^ (r >>> 7), 61 | r);
    return ((r ^ (r >>> 14)) >>> 0) / 4294967296;
  };
}

/**
 * Build a regular plant grid in local meters, clipped to the field polygon.
 * Returns [{x,z,lng,lat}] — elev filled later by DEM sampler.
 * When the field exceeds maxInstances, samples uniformly across the parcel
 * (does not fill only from the northern edge).
 */
export function buildPlantGrid({
  boundary,
  origin,
  bbox, // [w,s,e,n] lon/lat
  spacingM = 1.5,
  maxInstances = 40000,
  seed = 1,
}) {
  if (!origin?.latitude || !origin?.longitude || !bbox) return [];
  const [w, s, e, n] = bbox;
  const rand = mulberry32(seed);
  const mLon = metersPerDegLon(origin.latitude);
  const stepLon = spacingM / mLon;
  const stepLat = spacingM / METERS_PER_DEG_LAT;

  const cols = Math.max(1, Math.ceil(Math.abs(e - w) / stepLon));
  const rows = Math.max(1, Math.ceil(Math.abs(n - s) / stepLat));
  const estimated = cols * rows;
  const keepEvery = Math.max(1, Math.ceil(estimated / Math.max(1, maxInstances)));

  const positions = [];
  let candidateIdx = 0;
  for (let lat = n - stepLat * 0.5; lat >= s; lat -= stepLat) {
    const rowJitter = (rand() - 0.5) * spacingM * 0.15;
    for (let lng = w + stepLon * 0.5; lng <= e; lng += stepLon) {
      const colJitter = (rand() - 0.5) * spacingM * 0.2;
      const jLng = lng + colJitter / mLon;
      const jLat = lat + rowJitter / METERS_PER_DEG_LAT;
      if (!pointInBoundary(jLng, jLat, boundary)) continue;
      const keep = (candidateIdx++ % keepEvery) === 0;
      if (!keep) continue;
      const { x, z } = lngLatToLocal(jLng, jLat, origin);
      positions.push({ x, z, lng: jLng, lat: jLat });
      if (positions.length >= maxInstances) return positions;
    }
  }
  return positions;
}

/** Bilinear sample of a north-to-south elevation grid over a lon/lat bbox. */
export function sampleElevation(values, bbox, lng, lat) {
  return sampleGridValue(values, bbox, lng, lat, { nullIfPartial: false });
}

/**
 * Bilinear sample of any numeric grid aligned to bbox [w,s,e,n].
 * When nullIfPartial is true (NDVI/NDWI), any null neighbor → null so callers
 * do not invent healthy canopy from incomplete pixels.
 */
export function sampleGridValue(values, bbox, lng, lat, { nullIfPartial = true } = {}) {
  if (!values?.length || !bbox) return null;
  const [w, s, e, n] = bbox;
  const rows = values.length;
  const cols = values[0]?.length || 0;
  if (!cols) return null;
  const u = (lng - w) / ((e - w) || 1e-12);
  const v = (n - lat) / ((n - s) || 1e-12);
  if (u < 0 || u > 1 || v < 0 || v > 1) return null;
  const c = u * (cols - 1);
  const r = v * (rows - 1);
  const c0 = Math.floor(c);
  const r0 = Math.floor(r);
  const c1 = Math.min(cols - 1, c0 + 1);
  const r1 = Math.min(rows - 1, r0 + 1);
  const tc = c - c0;
  const tr = r - r0;
  const v00 = values[r0][c0];
  const v10 = values[r0][c1];
  const v01 = values[r1][c0];
  const v11 = values[r1][c1];
  const samples = [v00, v10, v01, v11];
  if (samples.some((x) => x == null || Number.isNaN(x))) {
    if (nullIfPartial) return null;
    return v00 ?? v10 ?? v01 ?? v11 ?? null;
  }
  const a = v00 * (1 - tc) + v10 * tc;
  const b = v01 * (1 - tc) + v11 * tc;
  const out = a * (1 - tr) + b * tr;
  return Number.isFinite(out) ? out : null;
}

/**
 * Map NDVI → illustrative canopy visual params.
 * Returns null when NDVI is missing — caller must not invent healthy crops.
 */
export function canopyParamsFromNdvi(ndvi) {
  if (ndvi == null || !Number.isFinite(ndvi)) return null;
  // Typical crop NDVI roughly 0.15–0.85; clamp visual response
  const t = Math.max(0, Math.min(1, (ndvi - 0.12) / 0.68));
  // Density keep probability — stressed stands look sparser
  const keepProbability = 0.18 + t * 0.82;
  // Height & radius scale relative to catalog base
  const heightScale = 0.18 + t * 0.7;
  const radiusScale = 0.3 + t * 0.7;
  // Green (healthy) → yellow-brown (stressed)
  const healthy = { r: 0.24, g: 0.55, b: 0.18 };
  const stressed = { r: 0.72, g: 0.62, b: 0.22 };
  const bare = { r: 0.55, g: 0.48, b: 0.32 };
  const low = ndvi < 0.2 ? bare : stressed;
  const color = {
    r: low.r + (healthy.r - low.r) * t,
    g: low.g + (healthy.g - low.g) * t,
    b: low.b + (healthy.b - low.b) * t,
  };
  return {
    ndvi,
    t,
    keepProbability,
    heightScale,
    radiusScale,
    color,
    provenance: 'modeled',
    note: 'Height/color are illustrative, driven by derived NDVI — not measured plant stature.',
  };
}

/**
 * Place scenario water-risk hotspots in local meters on the DEM surface.
 * Pure helper shared by the R3F marker component and unit tests.
 */
export function placeScenarioHotspots({
  hotspots = [],
  origin,
  elevation,
  bbox,
  exaggeration = 2.5,
}) {
  if (!origin?.latitude || !origin?.longitude || !bbox) return [];
  let elevMin = Infinity;
  for (const row of elevation?.values || []) {
    for (const v of row || []) {
      if (v != null && Number.isFinite(v) && v < elevMin) elevMin = v;
    }
  }
  if (!Number.isFinite(elevMin)) elevMin = 0;

  const [west, south, east, north] = bbox;

  return (hotspots || [])
    .map((h) => {
      let lat = h?.latitude != null ? Number(h.latitude) : null;
      let lon = h?.longitude != null ? Number(h.longitude) : null;
      // Screening fallbacks often only have grid indices — map onto the field bbox.
      if ((!Number.isFinite(lat) || !Number.isFinite(lon))
        && h?.row != null && h?.col != null
        && Number.isFinite(west) && Number.isFinite(north)) {
        const rows = Math.max(1, Number(h.grid_rows) || 96);
        const cols = Math.max(1, Number(h.grid_cols) || 96);
        lon = west + ((Number(h.col) + 0.5) / cols) * (east - west);
        lat = north - ((Number(h.row) + 0.5) / rows) * (north - south);
      }
      if (!Number.isFinite(lat) || !Number.isFinite(lon)) return null;
      return { ...h, latitude: lat, longitude: lon };
    })
    .filter(Boolean)
    .map((h, i) => {
      const { x, z } = lngLatToLocal(h.longitude, h.latitude, origin);
      const el = sampleElevation(elevation?.values, bbox, h.longitude, h.latitude);
      const y = ((el ?? elevMin) - elevMin) * exaggeration;
      return {
        ...h,
        index: i + 1,
        x,
        y: y + 1.4,
        z,
        provenance: 'modeled',
      };
    });
}
