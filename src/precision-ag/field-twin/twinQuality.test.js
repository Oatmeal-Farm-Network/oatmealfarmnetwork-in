/**
 * Run with: node src/precision-ag/field-twin/twinQuality.test.js
 */
import {
  detectTwinQuality,
  twinMaxDpr,
  twinShadowsEnabled,
  maxInstancesForQuality,
  isGrowthEstimated,
  isTruckMode,
} from './twinQuality.js';

function assert(cond, msg) {
  if (!cond) throw new Error(msg || 'assertion failed');
}

export function runTwinQualityTests() {
  assert(detectTwinQuality({ width: 400, preferReducedMotion: false }) === 'low', 'narrow → low');
  assert(detectTwinQuality({ width: 1400, preferReducedMotion: true }) === 'low', 'reduced motion → low');
  assert(twinMaxDpr('low') === 1, 'low dpr');
  assert(twinMaxDpr('high') > twinMaxDpr('medium'), 'high dpr > medium');
  assert(twinShadowsEnabled('high') === true, 'high shadows on');
  assert(twinShadowsEnabled('low') === false, 'low shadows off');
  assert(maxInstancesForQuality('low') === 5000, 'low instance cap');
  assert(maxInstancesForQuality('medium') === 12000, 'medium instance cap');
  assert(maxInstancesForQuality('high') === 18000, 'high instance cap');
  assert(maxInstancesForQuality('low') < maxInstancesForQuality('high'), 'caps increase with tier');
  assert(isGrowthEstimated(null) === true, 'missing growth → estimated');
  assert(isGrowthEstimated({ stage: 'unknown', provenance: 'modeled' }) === true, 'unknown → estimated');
  assert(isGrowthEstimated({ stage: 'vegetative', provenance: 'modeled', confidence: 'medium' }) === true, 'modeled → estimated');
  assert(isGrowthEstimated({ stage: 'vegetative', provenance: 'observed', confidence: 'high' }) === false, 'observed → not estimated');
  assert(isTruckMode({ width: 480 }) === true, 'phone width → truck');
  assert(isTruckMode({ width: 1280 }) === false, 'desktop width → not truck');
  return { ok: true };
}

const isMain = process.argv[1] && process.argv[1].replace(/\\/g, '/').endsWith('twinQuality.test.js');
if (isMain) {
  console.log('twinQuality.test.js: ok', runTwinQualityTests());
}
