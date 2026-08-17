/**
 * Soil sample helpers — Phase 3 unit tests.
 * Run with: node src/precision-ag/field-twin/SoilCutaway.test.js
 */
import { filterLocatedSoilSamples, SOIL_SAMPLE_INFLUENCE_M } from './soilSamples.js';

function assert(cond, msg) {
  if (!cond) throw new Error(msg || 'assertion failed');
}

export function runSoilCutawayTests() {
  assert(SOIL_SAMPLE_INFLUENCE_M === 30, 'defensible radius is 30 m');

  const mixed = [
    { sample_id: 1, latitude: 41.5, longitude: -93.5, ph: 6.2 },
    { sample_id: 2, latitude: null, longitude: -93.5, ph: 6.5 },
    { sample_id: 3, latitude: 41.5, longitude: null, ph: 6.8 },
    { sample_id: 4, ph: 7.0 },
  ];
  const located = filterLocatedSoilSamples(mixed);
  assert(located.length === 1, 'only GPS-complete samples pass');
  assert(located[0].sample_id === 1, 'keeps located sample');
  assert(filterLocatedSoilSamples([]).length === 0, 'empty ok');
  assert(filterLocatedSoilSamples(null).length === 0, 'null ok');

  return { ok: true };
}

const isMain = process.argv[1] && process.argv[1].replace(/\\/g, '/').endsWith('SoilCutaway.test.js');
if (isMain) {
  console.log('SoilCutaway.test.js: ok', runSoilCutawayTests());
}
