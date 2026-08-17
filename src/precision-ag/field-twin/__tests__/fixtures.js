/** Shared twin-snapshot fixtures for Field Twin integration tests. */

const BOUNDARY = {
  type: 'Polygon',
  coordinates: [[
    [-93.51, 41.49],
    [-93.49, 41.49],
    [-93.49, 41.51],
    [-93.51, 41.51],
    [-93.51, 41.49],
  ]],
};

const BASE_FIELD = {
  field_id: 36,
  business_id: 1,
  name: 'North Forty',
  latitude: 41.5,
  longitude: -93.5,
  boundary: BOUNDARY,
  crop_type: 'Corn',
  provenance: 'observed',
  confidence: 'high',
};

const TERRAIN = {
  available: true,
  provenance: 'derived',
  confidence: 'high',
  grid: { bbox: [-93.51, 41.49, -93.49, 41.51], width: 64, height: 64 },
  texture: { available: true, year_matched: true, acquired_at: '2026-06-01T00:00:00Z' },
  assets: {
    elevation: '/api/fields/36/terrain/elevation?grid=64&format=json',
    texture: '/api/fields/36/terrain/texture?grid=64',
    ndvi_json: '/api/fields/36/terrain/overlay/ndvi?grid=64&format=json',
  },
  overlays_available: ['ndvi', 'ndwi'],
};

export function makeSnapshot(overrides = {}) {
  const year = overrides.selection?.effective_year ?? 2026;
  const isHistorical = overrides.selection?.is_historical
    ?? (year !== 2026);
  return {
    contract_version: '1.3.0',
    selection: {
      requested_year: year,
      effective_year: year,
      is_historical: isHistorical,
      ...(overrides.selection || {}),
    },
    field: { ...BASE_FIELD, ...(overrides.field || {}) },
    local_origin: { longitude: -93.5, latitude: 41.5, crs: 'local-meters-from-wgs84' },
    crop: {
      crop_type: 'Corn',
      recorded_crop_type: 'Corn',
      detected_crop_type: 'Corn',
      detected_year: 2024,
      crop_key: 'corn',
      selected_source: 'field_record',
      confirmed: false,
      candidates: {
        rotation: { crop: 'Corn', crop_key: 'corn' },
        field_record: { crop: 'Corn', crop_key: 'corn' },
        cdl: { crop: 'Corn', crop_key: 'corn', year: 2024, code: 1 },
      },
      growth: { stage: 'vegetative', provenance: 'modeled', confidence: 'medium' },
      validation: { status: 'matched', requires_confirmation: false, note: null },
      ...(overrides.crop || {}),
    },
    timeline: overrides.timeline !== undefined ? overrides.timeline : [
      { year: 2026, recorded: { crop: 'Corn' }, cdl: { crop: 'Corn' } },
      { year: 2025, recorded: { crop: 'Soybeans' }, cdl: { crop: 'Soybeans' }, decision: { selected_crop: 'Soybeans' } },
      { year: 2024, recorded: null, cdl: { crop: 'Wheat' } },
    ],
    crop_history: overrides.crop_history !== undefined ? overrides.crop_history : {
      available: true,
      cdl_years: [
        { year: 2024, crop: 'Wheat' },
        { year: 2023, crop: 'Corn' },
      ],
      rotation_years: [
        { year: 2025, crop: 'Soybeans' },
        { year: 2026, crop: 'Corn' },
      ],
    },
    terrain: { ...TERRAIN, ...(overrides.terrain || {}) },
    vegetation: {
      available: true,
      provenance: 'derived',
      confidence: 'high',
      acquired_at: '2026-06-01T00:00:00Z',
      assets: { ndvi_json: TERRAIN.assets.ndvi_json },
      ...(overrides.vegetation || {}),
    },
    soil_samples: {
      available: true,
      count: 2,
      located_count: 1,
      unlocated_count: 1,
      samples: [
        {
          sample_id: 1,
          sample_label: 'Core A',
          latitude: 41.5005,
          longitude: -93.5005,
          location_status: 'located',
          depth_cm: 30,
          ph: 6.4,
          organic_matter: 3.1,
          provenance: 'observed',
        },
        {
          sample_id: 2,
          sample_label: 'Core B (no GPS)',
          latitude: null,
          longitude: null,
          location_status: 'unlocated',
          depth_cm: 20,
          ph: 6.1,
          organic_matter: 2.8,
          provenance: 'observed',
        },
      ],
      unlocated_samples: [
        {
          sample_id: 2,
          sample_label: 'Core B (no GPS)',
          latitude: null,
          longitude: null,
          location_status: 'unlocated',
          depth_cm: 20,
          ph: 6.1,
          organic_matter: 2.8,
        },
      ],
      note: '1 sample(s) lack coordinates and are listed only — not pinned on the twin.',
      ...(overrides.soil_samples || {}),
    },
    soil_cutaway: {
      available: true,
      mode: 'measured_and_grids',
      layers: [
        {
          label: '0-5 cm',
          top_cm: 0,
          bottom_cm: 5,
          thickness_m: 0.05,
          ph: 6.4,
          clay_pct: 28,
          sand_pct: 35,
          organic_matter_pct: 3.1,
          provenance: 'derived',
          source: 'soilgrids',
          confidence: 'medium',
        },
        {
          label: '5-15 cm',
          top_cm: 5,
          bottom_cm: 15,
          thickness_m: 0.1,
          ph: 6.2,
          clay_pct: 30,
          provenance: 'derived',
          source: 'soilgrids',
          confidence: 'medium',
        },
      ],
      measured_summary: { sample_count: 2, ph_mean: 6.25, organic_matter_mean: 2.95 },
      note: 'SoilGrids depth bands are estimates at the field centroid — not a dug pedon.',
      ...(overrides.soil_cutaway || {}),
    },
    weather: { available: false },
    irrigation: { recommendation: 'monitor' },
    soil_moisture: { level: 'adequate', provenance: 'modeled' },
    availability: {
      boundary: true,
      terrain: true,
      texture: true,
      vegetation_grid: true,
      soil_samples: true,
      ...(overrides.availability || {}),
    },
    rendering_hints: {
      labels: {
        observed: 'Lab / grower observation',
        derived: 'Satellite or model product',
        modeled: 'Illustrative / screening',
        recorded: 'Grower record',
      },
    },
    ...Object.fromEntries(
      Object.entries(overrides).filter(([k]) => ![
        'selection', 'field', 'crop', 'timeline', 'crop_history', 'terrain',
        'vegetation', 'soil_samples', 'soil_cutaway', 'availability',
      ].includes(k)),
    ),
  };
}

export function mismatchSnapshotEmptyHistory() {
  return makeSnapshot({
    timeline: [],
    crop_history: { available: false, cdl_years: [], rotation_years: [] },
    crop: {
      crop_type: 'Corn',
      recorded_crop_type: 'Corn',
      detected_crop_type: 'Soybeans',
      crop_key: 'corn',
      selected_source: 'field_record',
      confirmed: false,
      candidates: {
        rotation: null,
        field_record: { crop: 'Corn', crop_key: 'corn' },
        cdl: { crop: 'Soybeans', crop_key: 'soybean', year: 2024, code: 5 },
      },
      validation: {
        status: 'mismatch',
        requires_confirmation: true,
        note: 'Recorded crop and CDL disagree. Confirm which source the twin should use.',
      },
    },
  });
}

export function soilGridsOnlySnapshot() {
  return makeSnapshot({
    soil_samples: {
      available: false,
      count: 0,
      located_count: 0,
      unlocated_count: 0,
      samples: [],
      unlocated_samples: [],
      note: null,
    },
    soil_cutaway: {
      available: true,
      mode: 'grids_only',
      layers: [
        {
          label: '0-5 cm',
          top_cm: 0,
          bottom_cm: 5,
          thickness_m: 0.05,
          ph: 6.4,
          clay_pct: 28,
          provenance: 'derived',
          source: 'soilgrids',
          confidence: 'medium',
        },
      ],
      measured_summary: null,
      note: 'SoilGrids depth bands are estimates — no measured lab cores for this field.',
    },
  });
}

export const ELEVATION_JSON = {
  values: Array.from({ length: 8 }, () => Array.from({ length: 8 }, () => 300)),
  grid: { bbox: [-93.51, 41.49, -93.49, 41.51], width: 8, height: 8 },
};

export const SCENARIO_HOTSPOTS = [
  {
    row: 2,
    col: 3,
    index: 1,
    latitude: 41.5002,
    longitude: -93.5002,
    risk: 0.82,
    band: 'severe',
  },
  {
    row: 4,
    col: 5,
    index: 2,
    latitude: 41.5008,
    longitude: -93.4995,
    risk: 0.55,
    band: 'moderate',
  },
];

export const SCENARIO_RESULT = {
  scenario: {
    rainfall_mm: 40,
    irrigation_mm: 12,
    duration_hours: 6,
  },
  summary: { access_risk: 'elevated' },
  confidence: { grade: 'screening' },
  accuracy_statement: 'Modeled relative water-risk — not flood depth.',
};
