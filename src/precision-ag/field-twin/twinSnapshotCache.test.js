/**
 * Run with: node src/precision-ag/field-twin/twinSnapshotCache.test.js
 */
import { slimTwinSnapshot } from './twinSnapshotCache.js';

function assert(cond, msg) {
  if (!cond) throw new Error(msg || 'assertion failed');
}

export function runTwinSnapshotCacheTests() {
  const slim = slimTwinSnapshot({
    field: { name: 'A' },
    terrain: { grid: { values: [[1, 2], [3, 4]], bbox: [0, 0, 1, 1] } },
    vegetation: { grid: { values: [9] } },
  });
  assert(slim.field.name === 'A', 'keeps field');
  assert(slim.terrain.grid.bbox, 'keeps bbox');
  assert(slim.terrain.grid.values == null, 'strips DEM values');
  assert(slim.vegetation.grid.values == null, 'strips NDVI values');
  assert(slimTwinSnapshot(null) === null, 'null → null');
  return { ok: true };
}

const isMain = process.argv[1] && process.argv[1].replace(/\\/g, '/').endsWith('twinSnapshotCache.test.js');
if (isMain) {
  console.log('twinSnapshotCache.test.js: ok', runTwinSnapshotCacheTests());
}
