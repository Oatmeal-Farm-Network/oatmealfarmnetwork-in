/**
 * Crop catalog — procedural plant params (no external GLTF required).
 * Visual style is driven by crop_key + growth stage; always treat height/color
 * as modeled when source confidence is not high.
 *
 * habit: 'forage' = low carpet field · 'row' = cultivated rows · 'canopy' = taller crop
 */

export const CROP_CATALOG = {
  corn: {
    label: 'Corn',
    color: '#3d8c2e',
    matureColor: '#c9a227',
    stemColor: '#2f6b24',
    baseHeight: 1.8,
    canopyRadius: 0.12,
    rowSpacingHint: 0.76,
    habit: 'row',
    archetype: 'corn',
  },
  maize: {
    label: 'Maize',
    color: '#3d8c2e',
    matureColor: '#c9a227',
    stemColor: '#2f6b24',
    baseHeight: 1.8,
    canopyRadius: 0.12,
    rowSpacingHint: 0.76,
    habit: 'row',
    archetype: 'corn',
  },
  wheat: {
    label: 'Wheat',
    color: '#8fbf4a',
    matureColor: '#d4b05a',
    stemColor: '#6a9a30',
    baseHeight: 0.7,
    canopyRadius: 0.06,
    rowSpacingHint: 0.2,
    habit: 'forage',
    archetype: 'cereal',
  },
  soy: {
    label: 'Soybean',
    color: '#4a9e3e',
    matureColor: '#6b8f2e',
    stemColor: '#3a7a30',
    baseHeight: 0.7,
    canopyRadius: 0.12,
    rowSpacingHint: 0.4,
    habit: 'row',
    archetype: 'broadleaf',
  },
  soybean: {
    label: 'Soybean',
    color: '#4a9e3e',
    matureColor: '#6b8f2e',
    stemColor: '#3a7a30',
    baseHeight: 0.7,
    canopyRadius: 0.12,
    rowSpacingHint: 0.4,
    habit: 'row',
    archetype: 'broadleaf',
  },
  oats: {
    label: 'Oats',
    color: '#9cc45a',
    matureColor: '#cbb56a',
    stemColor: '#6f9a38',
    baseHeight: 0.75,
    canopyRadius: 0.07,
    rowSpacingHint: 0.2,
    habit: 'forage',
    archetype: 'cereal',
  },
  alfalfa: {
    label: 'Alfalfa',
    color: '#4f9a3c',
    matureColor: '#6a8f38',
    stemColor: '#3d7a30',
    baseHeight: 0.45,
    canopyRadius: 0.1,
    rowSpacingHint: 0.18,
    habit: 'forage',
    archetype: 'forage_cluster',
  },
  hay: {
    label: 'Hay',
    color: '#7a9e42',
    matureColor: '#c4b05a',
    stemColor: '#5a7a30',
    baseHeight: 0.5,
    canopyRadius: 0.09,
    rowSpacingHint: 0.2,
    habit: 'forage',
    archetype: 'forage_cluster',
  },
  grass: {
    label: 'Grass',
    color: '#5a9e48',
    matureColor: '#8a9e40',
    stemColor: '#3d7a32',
    baseHeight: 0.4,
    canopyRadius: 0.08,
    rowSpacingHint: 0.15,
    habit: 'forage',
    archetype: 'forage_cluster',
  },
  cotton: {
    label: 'Cotton',
    color: '#5a9e4a',
    matureColor: '#e8e8e0',
    stemColor: '#3d7a32',
    baseHeight: 0.95,
    canopyRadius: 0.16,
    rowSpacingHint: 1.0,
    habit: 'row',
    archetype: 'cotton',
  },
  sorghum: {
    label: 'Sorghum',
    color: '#6a9e38',
    matureColor: '#c4a03a',
    stemColor: '#4a7a28',
    baseHeight: 1.2,
    canopyRadius: 0.1,
    rowSpacingHint: 0.7,
    habit: 'row',
    archetype: 'sorghum',
  },
  barley: {
    label: 'Barley',
    color: '#8fbf4a',
    matureColor: '#d4b05a',
    stemColor: '#6a9a30',
    baseHeight: 0.65,
    canopyRadius: 0.06,
    rowSpacingHint: 0.2,
    habit: 'forage',
    archetype: 'cereal',
  },
  rice: {
    label: 'Rice',
    color: '#5a9e48',
    matureColor: '#cbb56a',
    stemColor: '#3d7a32',
    baseHeight: 0.7,
    canopyRadius: 0.08,
    rowSpacingHint: 0.25,
    habit: 'forage',
    archetype: 'cereal',
  },
  sugarcane: {
    label: 'Sugarcane',
    color: '#3d8c3a',
    matureColor: '#c9b227',
    stemColor: '#2f6b24',
    baseHeight: 2.4,
    canopyRadius: 0.14,
    rowSpacingHint: 0.9,
    habit: 'canopy',
    archetype: 'sorghum',
  },
  chickpea: {
    label: 'Chickpea',
    color: '#6a9e38',
    matureColor: '#c4a03a',
    stemColor: '#4a7a28',
    baseHeight: 0.5,
    canopyRadius: 0.1,
    rowSpacingHint: 0.3,
    habit: 'row',
    archetype: 'broadleaf',
  },
  pigeon_pea: {
    label: 'Pigeon pea',
    color: '#4f9a3c',
    matureColor: '#8a9e40',
    stemColor: '#3d7a30',
    baseHeight: 1.4,
    canopyRadius: 0.14,
    rowSpacingHint: 0.6,
    habit: 'row',
    archetype: 'broadleaf',
  },
  groundnut: {
    label: 'Groundnut',
    color: '#5a9e4a',
    matureColor: '#c4b05a',
    stemColor: '#3d7a32',
    baseHeight: 0.45,
    canopyRadius: 0.12,
    rowSpacingHint: 0.3,
    habit: 'row',
    archetype: 'broadleaf',
  },
  mustard: {
    label: 'Mustard',
    color: '#7a9e32',
    matureColor: '#e8d24a',
    stemColor: '#5a7a28',
    baseHeight: 0.9,
    canopyRadius: 0.11,
    rowSpacingHint: 0.3,
    habit: 'row',
    archetype: 'canola',
  },
  millet: {
    label: 'Millet',
    color: '#8fbf4a',
    matureColor: '#d4b05a',
    stemColor: '#6a9a30',
    baseHeight: 0.85,
    canopyRadius: 0.07,
    rowSpacingHint: 0.25,
    habit: 'forage',
    archetype: 'cereal',
  },
  potato: {
    label: 'Potato',
    color: '#4a9e3e',
    matureColor: '#6b8f2e',
    stemColor: '#3a7a30',
    baseHeight: 0.55,
    canopyRadius: 0.14,
    rowSpacingHint: 0.6,
    habit: 'row',
    archetype: 'broadleaf',
  },
  canola: {
    label: 'Canola',
    color: '#7a9e32',
    matureColor: '#e8d24a',
    stemColor: '#5a7a28',
    baseHeight: 0.85,
    canopyRadius: 0.12,
    rowSpacingHint: 0.3,
    habit: 'row',
    archetype: 'canola',
  },
  default: {
    label: 'Crop',
    color: '#5a8f42',
    matureColor: '#7a9e3a',
    stemColor: '#3d6b2a',
    baseHeight: 0.65,
    canopyRadius: 0.1,
    rowSpacingHint: 0.45,
    habit: 'forage',
    archetype: 'cereal',
  },
};

const STAGE_SCALE = {
  unknown: 0.55,
  germination: 0.12,
  emergence: 0.2,
  vegetative: 0.55,
  reproductive: 0.85,
  mature: 1.0,
  senescence: 0.9,
};

const STAGE_ALIASES = {
  germ: 'germination',
  sprout: 'emergence',
  sprouting: 'emergence',
  seedling: 'emergence',
  veg: 'vegetative',
  flowering: 'reproductive',
  bloom: 'reproductive',
  fruiting: 'reproductive',
  ripe: 'mature',
  harvest: 'mature',
  drydown: 'senescence',
  senescing: 'senescence',
};

const CROP_ALIASES = {
  oat: 'oats',
  rapeseed: 'canola',
  rape: 'canola',
  beans: 'soybean',
  soya: 'soybean',
  soybeans: 'soybean',
  maize: 'maize',
  corn: 'maize',
  paddy: 'rice',
  gram: 'chickpea',
  chana: 'chickpea',
  tur: 'pigeon_pea',
  arhar: 'pigeon_pea',
  peanut: 'groundnut',
  bajra: 'millet',
  jowar: 'sorghum',
  cane: 'sugarcane',
};

export function normalizeCropKey(cropKey) {
  const raw = String(cropKey || 'default').toLowerCase().trim();
  if (CROP_CATALOG[raw]) return raw;
  if (CROP_ALIASES[raw]) return CROP_ALIASES[raw];
  return raw || 'default';
}

export function normalizeGrowthStage(growthStage) {
  const raw = String(growthStage || 'unknown').toLowerCase().trim();
  if (STAGE_SCALE[raw] != null) return raw;
  if (STAGE_ALIASES[raw]) return STAGE_ALIASES[raw];
  return 'unknown';
}

export function resolveCropStyle(cropKey, growthStage, ndviMean) {
  const key = normalizeCropKey(cropKey);
  const cat = CROP_CATALOG[key] || CROP_CATALOG.default;
  const stage = normalizeGrowthStage(growthStage);
  let scale = STAGE_SCALE[stage] ?? 0.55;
  // Nudge scale from NDVI when available (derived)
  if (typeof ndviMean === 'number' && Number.isFinite(ndviMean)) {
    const ndviFactor = Math.max(0.35, Math.min(1.05, (ndviMean + 0.1) / 0.7));
    scale *= ndviFactor;
  }
  const matureBias = stage === 'mature' || stage === 'senescence' ? 1 : 0;
  const color = matureBias ? cat.matureColor : cat.color;
  // Hard cap so large fields never inflate samples into "forest" trees
  const height = Math.min(cat.habit === 'forage' ? 0.85 : 2.1, cat.baseHeight * scale);
  const radiusScale = stage === 'germination' || stage === 'emergence'
    ? 0.45
    : stage === 'vegetative'
      ? 0.75
      : 1;
  return {
    ...cat,
    cropKey: key,
    height,
    color,
    canopyRadius: (cat.canopyRadius || 0.1) * radiusScale,
    stage,
    scale,
    archetype: cat.archetype || (cat.habit === 'forage' ? 'cereal' : 'row'),
    provenance: 'modeled',
  };
}

export function moistureShaderParams(level) {
  // roughness↑ and darken when wetter (as plan described)
  switch (level) {
    case 'high':
      return { roughness: 0.92, metalness: 0.02, colorMul: 0.72 };
    case 'moderate':
      return { roughness: 0.82, metalness: 0.04, colorMul: 0.88 };
    case 'low':
      return { roughness: 0.7, metalness: 0.06, colorMul: 1.05 };
    default:
      return { roughness: 0.78, metalness: 0.04, colorMul: 0.95 };
  }
}
