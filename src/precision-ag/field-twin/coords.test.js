/**
 * Lightweight unit tests for field-twin coordinate / clipping / NDVI helpers.
 * Run with: node src/precision-ag/field-twin/coords.test.js
 */
import {
  metersPerDegLon,
  lngLatToLocal,
  localToLngLat,
  pointInRing,
  pointInBoundary,
  buildPlantGrid,
  sampleElevation,
  sampleGridValue,
  canopyParamsFromNdvi,
  placeScenarioHotspots,
  mulberry32,
} from './coords.js';

function assert(cond, msg) {
  if (!cond) throw new Error(msg || 'assertion failed');
}

export function runFieldTwinCoordTests() {
  const origin = { latitude: 41.5, longitude: -93.5 };

  // Round-trip projection
  const p = lngLatToLocal(-93.49, 41.51, origin);
  const back = localToLngLat(p.x, p.z, origin);
  assert(Math.abs(back.lng - (-93.49)) < 1e-6, 'lng round-trip');
  assert(Math.abs(back.lat - 41.51) < 1e-6, 'lat round-trip');

  assert(metersPerDegLon(0) > metersPerDegLon(60), 'meters/lon shrinks with latitude');

  const square = [
    [-93.51, 41.49],
    [-93.49, 41.49],
    [-93.49, 41.51],
    [-93.51, 41.51],
    [-93.51, 41.49],
  ];
  assert(pointInRing(-93.50, 41.50, square), 'inside square');
  assert(!pointInRing(-93.52, 41.50, square), 'outside square');

  const boundary = { type: 'Polygon', coordinates: [square] };
  assert(pointInBoundary(-93.50, 41.50, boundary), 'boundary inside');
  assert(pointInBoundary(-93.50, 41.50, null), 'null boundary allows planting');

  const bbox = [-93.51, 41.49, -93.49, 41.51];
  const grid = buildPlantGrid({
    boundary: null,
    origin,
    bbox,
    spacingM: 10,
    maxInstances: 500,
    seed: 42,
  });
  assert(grid.length > 0, 'plant grid without boundary still fills bbox');

  const values = [
    [100, 110],
    [120, 130],
  ];
  const mid = sampleElevation(values, bbox, -93.50, 41.50);
  assert(mid != null && mid > 100 && mid < 130, 'bilinear elev sample');

  // Elevation tolerates partial nulls (nearest valid)
  const elevPartial = [
    [100, null],
    [120, 130],
  ];
  const elevNear = sampleElevation(elevPartial, bbox, -93.505, 41.505);
  assert(elevNear != null, 'elevation nearest-valid on partial null');

  // NDVI sampling must NOT invent values from partial no-data
  const ndviPartial = [
    [0.6, null],
    [0.5, 0.4],
  ];
  const ndviStrict = sampleGridValue(ndviPartial, bbox, -93.505, 41.505, { nullIfPartial: true });
  assert(ndviStrict == null, 'NDVI nullIfPartial rejects incomplete neighborhood');

  const ndviFull = [
    [0.2, 0.3],
    [0.7, 0.8],
  ];
  const ndviMid = sampleGridValue(ndviFull, bbox, -93.50, 41.50);
  assert(ndviMid != null && ndviMid > 0.2 && ndviMid < 0.8, 'NDVI bilinear mid');

  // No-data → no canopy params (do not invent healthy crops)
  assert(canopyParamsFromNdvi(null) == null, 'null NDVI → no canopy');
  assert(canopyParamsFromNdvi(Number.NaN) == null, 'NaN NDVI → no canopy');

  const stressed = canopyParamsFromNdvi(0.18);
  const healthy = canopyParamsFromNdvi(0.75);
  assert(stressed && healthy, 'NDVI canopy params exist');
  assert(stressed.heightScale < healthy.heightScale, 'healthy taller than stressed');
  assert(stressed.keepProbability < healthy.keepProbability, 'healthy denser than stressed');
  assert(healthy.color.g > stressed.color.g, 'healthy greener than stressed');
  assert(stressed.provenance === 'modeled', 'canopy height is modeled');
  assert(/illustrative|not measured/i.test(stressed.note), 'height disclaimer present');

  const placed = placeScenarioHotspots({
    hotspots: [
      { row: 0, col: 0, latitude: 41.50, longitude: -93.50, risk: 0.82, band: 'high' },
      { row: 1, col: 1, latitude: null, longitude: -93.50, risk: 0.9, band: 'severe' },
      { row: 48, col: 48, latitude: null, longitude: null, risk: 0.7, band: 'high', grid_rows: 96, grid_cols: 96 },
    ],
    origin,
    elevation: { values },
    bbox,
    exaggeration: 2,
  });
  assert(placed.length === 3, 'lat/lon hotspot + row/col hotspots place');
  assert(placed[0].provenance === 'modeled', 'hotspot provenance modeled');
  assert(Number.isFinite(placed[0].x) && Number.isFinite(placed[0].z), 'hotspot local xz');
  assert(placed[0].y >= 1.4, 'hotspot lifted above surface');
  assert(Number.isFinite(placed[1].latitude) && Number.isFinite(placed[1].longitude), 'partial coords + row/col → lat/lon');
  assert(Number.isFinite(placed[2].latitude) && Number.isFinite(placed[2].longitude), 'row/col → lat/lon');

  const r = mulberry32(1);
  assert(r() !== r(), 'prng advances');

  // Cap should subsample across the field, not only fill from the north edge
  const capped = buildPlantGrid({
    boundary: { type: 'Polygon', coordinates: [square] },
    origin,
    bbox: [-93.51, 41.49, -93.49, 41.51],
    spacingM: 5,
    maxInstances: 12,
    seed: 7,
  });
  assert(capped.length <= 12, 'respects maxInstances');
  if (capped.length >= 4) {
    const zs = capped.map((p) => p.z);
    const spread = Math.max(...zs) - Math.min(...zs);
    assert(spread > 20, 'capped grid spans field depth, not north edge only');
  }

  return { ok: true, plantCount: grid.length, ndviMid, hotspotCount: placed.length };
}

// Allow direct node execution
if (typeof process !== 'undefined' && process.argv?.[1]?.includes('coords.test')) {
  const result = runFieldTwinCoordTests();
  console.log('field-twin coords tests OK', result);
}
