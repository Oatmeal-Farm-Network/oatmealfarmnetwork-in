/**
 * Boundary / GeoJSON helpers for the 3D terrain viewer.
 */

export function parseBoundary(raw) {
  if (!raw) return null;
  let gj = raw;
  if (typeof raw === 'string') {
    try { gj = JSON.parse(raw); } catch { return null; }
  }
  if (!gj || typeof gj !== 'object') return null;

  if (gj.type === 'FeatureCollection' && Array.isArray(gj.features)) {
    return gj;
  }
  if (gj.type === 'Feature' && gj.geometry) {
    return { type: 'FeatureCollection', features: [gj] };
  }
  if (gj.type === 'Polygon' || gj.type === 'MultiPolygon') {
    return {
      type: 'FeatureCollection',
      features: [{ type: 'Feature', properties: {}, geometry: gj }],
    };
  }
  return null;
}

/** [west, south, east, north] from a FeatureCollection / Feature / geometry. */
export function boundsFromGeoJSON(gj) {
  const fc = parseBoundary(gj);
  if (!fc) return null;
  let minLon = Infinity, minLat = Infinity, maxLon = -Infinity, maxLat = -Infinity;
  const walk = (coords) => {
    if (!Array.isArray(coords)) return;
    if (typeof coords[0] === 'number' && typeof coords[1] === 'number') {
      const [lon, lat] = coords;
      if (lon < minLon) minLon = lon;
      if (lat < minLat) minLat = lat;
      if (lon > maxLon) maxLon = lon;
      if (lat > maxLat) maxLat = lat;
      return;
    }
    coords.forEach(walk);
  };
  for (const f of fc.features || []) {
    if (f?.geometry?.coordinates) walk(f.geometry.coordinates);
  }
  if (!Number.isFinite(minLon)) return null;
  return [minLon, minLat, maxLon, maxLat];
}

export function padBounds(bounds, padFrac = 0.08) {
  if (!bounds) return null;
  const [w, s, e, n] = bounds;
  const dx = (e - w) * padFrac;
  const dy = (n - s) * padFrac;
  return [w - dx, s - dy, e + dx, n + dy];
}

/** Build a bbox rectangle FeatureCollection from [w,s,e,n]. */
export function bboxPolygon(bounds) {
  if (!bounds) return null;
  const [w, s, e, n] = bounds;
  return {
    type: 'FeatureCollection',
    features: [{
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'Polygon',
        coordinates: [[[w, s], [e, s], [e, n], [w, n], [w, s]]],
      },
    }],
  };
}
