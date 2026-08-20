/**
 * ISRO Bhuvan LULC (Land Use / Land Cover) for India Crop Detection.
 * National 250K via our backend proxy (Bhuvan has no CORS) — no API key.
 */

import { API_URL } from './precisionAgUtils';

export const BHUVAN_LULC_YEAR_LABEL = '2024–25';

/** Proxied official legend (avoids browser CORS block on NRSC). */
export const BHUVAN_LEGEND_URL = `${API_URL}/api/bhuvan/legend.png`;

/** Approximate NRSC LULC palette for the sidebar (visual guide). */
export const BHUVAN_LULC_LEGEND = [
  { label: 'Built-up', color: '#c0392b' },
  { label: 'Agricultural land', color: '#f4d03f' },
  { label: 'Plantation / Orchard', color: '#27ae60' },
  { label: 'Forest', color: '#145a32' },
  { label: 'Grass / Grazing', color: '#82e0aa' },
  { label: 'Wasteland / Barren', color: '#d5d8dc' },
  { label: 'Water bodies', color: '#2980b9' },
  { label: 'Wetlands', color: '#5dade2' },
  { label: 'Snow / Glacier', color: '#f5f5f5' },
];

/**
 * Add Bhuvan LULC raster source/layer. Tiles come from our FastAPI proxy
 * (no custom MapLibre protocol needed).
 */
export function ensureBhuvanOnMap(map) {
  if (!map) return false;
  const tiles = [`${API_URL}/api/bhuvan/tile/{z}/{x}/{y}.png`];
  if (!map.getSource('bhuvan-lulc')) {
    map.addSource('bhuvan-lulc', {
      type: 'raster',
      tiles,
      tileSize: 256,
      attribution: 'ISRO Bhuvan LULC 250K',
      maxzoom: 14,
    });
  }
  if (!map.getLayer('bhuvan-lulc-layer')) {
    const beforeId = map.getLayer('draw-polygon-fill')
      ? 'draw-polygon-fill'
      : undefined;
    map.addLayer({
      id: 'bhuvan-lulc-layer',
      type: 'raster',
      source: 'bhuvan-lulc',
      paint: { 'raster-opacity': 0.72 },
    }, beforeId);
  }
  return true;
}

/**
 * Identify LULC class at lon/lat via backend → Bhuvan GetFeatureInfo.
 */
export async function queryBhuvanLulcAt(lon, lat) {
  try {
    const qs = new URLSearchParams({
      lon: String(lon),
      lat: String(lat),
    });
    const res = await fetch(`${API_URL}/api/bhuvan/identify?${qs.toString()}`);
    if (!res.ok) return null;
    const data = await res.json();
    if (!data?.class_name) return null;
    return data;
  } catch {
    return null;
  }
}
