/**
 * Crop catalog + procedural geometry smoke tests.
 * Run with: node src/precision-ag/field-twin/cropCatalog.test.js
 */
import {
  normalizeCropKey,
  normalizeGrowthStage,
  resolveCropStyle,
} from './cropCatalog.js';
import { getCropPlantGeometry } from './cropGeometry.js';

function assert(cond, msg) {
  if (!cond) throw new Error(msg || 'assertion failed');
}

export function runCropCatalogTests() {
  assert(normalizeCropKey('Oat') === 'oats', 'oat alias');
  assert(normalizeCropKey('Rapeseed') === 'canola', 'rapeseed alias');
  assert(normalizeCropKey('Soybeans') === 'soybean' || normalizeCropKey('soy') === 'soybean', 'soy key');
  assert(normalizeGrowthStage('Vegetative') === 'vegetative', 'stage lowercased');
  assert(normalizeGrowthStage('germ') === 'germination', 'germ alias');
  assert(normalizeGrowthStage('Flowering') === 'reproductive', 'flowering alias');

  const emergence = resolveCropStyle('corn', 'emergence', null);
  const mature = resolveCropStyle('corn', 'mature', null);
  assert(emergence.height < mature.height, 'corn emergence shorter than mature');
  assert(emergence.archetype === 'corn', 'corn archetype');
  assert(resolveCropStyle('wheat', 'vegetative', null).archetype === 'cereal', 'wheat cereal');

  const geo = getCropPlantGeometry('corn', 'mature', 'medium');
  assert(geo.getAttribute('position').count > 20, 'corn geo has vertices');
  assert(geo.getAttribute('color'), 'corn geo has vertex colors');

  const cereal = getCropPlantGeometry('cereal', 'emergence', 'low');
  assert(cereal.getAttribute('position').count > 5, 'cereal geo builds');

  console.log('cropCatalog.test.js: ok');
}

const isMain = process.argv[1] && process.argv[1].replace(/\\/g, '/').endsWith('cropCatalog.test.js');
if (isMain) runCropCatalogTests();
