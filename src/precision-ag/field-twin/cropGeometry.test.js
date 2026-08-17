/**
 * cropGeometry unit tests.
 * Run with: node src/precision-ag/field-twin/cropGeometry.test.js
 */
import { getCropPlantGeometry, glbPathForCrop, CROP_GLB_STAGE_PATHS } from './cropGeometry.js';
import { resolveCropStyle } from './cropCatalog.js';

function assert(cond, msg) {
  if (!cond) throw new Error(msg || 'assertion failed');
}

export function runCropGeometryTests() {
  const corn = getCropPlantGeometry('corn', 'mature', 'medium');
  assert(corn.getAttribute('position').count > 20, 'corn mature has vertices');
  assert(corn.getAttribute('color'), 'corn has vertex colors');
  assert(corn.getIndex(), 'corn has index buffer');

  // Cache hit returns same geometry instance
  const corn2 = getCropPlantGeometry('corn', 'mature', 'medium');
  assert(corn === corn2, 'geometry cache returns same object');

  const unknown = getCropPlantGeometry('totally-unknown-crop', 'vegetative', 'low');
  assert(unknown.getAttribute('position').count > 5, 'unknown crop falls back to cereal');

  const soy = getCropPlantGeometry('broadleaf', 'emergence', 'low');
  assert(soy.getAttribute('position').count > 5, 'broadleaf builds');

  assert(glbPathForCrop('corn', 'vegetative') === CROP_GLB_STAGE_PATHS.corn.vegetative, 'glb path corn');
  assert(glbPathForCrop('wheat', 'mature') == null, 'no glb for wheat');

  // Phase 2 DoD: ≥3 crop types × ≥3 growth stages (procedural stand-ins; mobile/low quality)
  const crops = [
    { key: 'corn', archetype: 'corn' },
    { key: 'wheat', archetype: 'cereal' },
    { key: 'soybean', archetype: 'broadleaf' },
  ];
  const stages = ['emergence', 'vegetative', 'mature'];
  for (const crop of crops) {
    for (const stage of stages) {
      const style = resolveCropStyle(crop.key, stage, null);
      assert(style.stage === stage, `${crop.key} ${stage} stage`);
      assert(style.height > 0, `${crop.key} ${stage} height`);
      assert(style.provenance === 'modeled', `${crop.key} stature modeled`);
      const geo = getCropPlantGeometry(style.archetype, stage, 'low');
      assert(geo.getAttribute('position').count > 5, `${crop.key} ${stage} low-tier geometry`);
      if (stage === 'emergence') {
        const mature = resolveCropStyle(crop.key, 'mature', null);
        assert(style.height < mature.height, `${crop.key} emergence shorter than mature`);
      }
    }
  }

  console.log('cropGeometry.test.js: ok');
  return { ok: true };
}

const isMain = process.argv[1] && process.argv[1].replace(/\\/g, '/').endsWith('cropGeometry.test.js');
if (isMain) runCropGeometryTests();
