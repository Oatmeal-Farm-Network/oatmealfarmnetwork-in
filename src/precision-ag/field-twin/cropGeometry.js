/**
 * Procedural crop plant geometries for Field Twin instancing.
 * Unit plant: height ≈ 1, origin at ground. Instance scale.y sets modeled height.
 * Vertex colors bake stem/leaf/head contrast; per-instance color multiplies vigor.
 */
import * as THREE from 'three';

const _geoCache = new Map();

function mergeGeometries(parts) {
  // Manual merge to avoid drei/BufferGeometryUtils dependency churn.
  let vertCount = 0;
  let idxCount = 0;
  for (const g of parts) {
    vertCount += g.getAttribute('position').count;
    const idx = g.getIndex();
    idxCount += idx ? idx.count : g.getAttribute('position').count;
  }
  const positions = new Float32Array(vertCount * 3);
  const normals = new Float32Array(vertCount * 3);
  const colors = new Float32Array(vertCount * 3);
  const indices = new Uint32Array(idxCount);
  let vOffset = 0;
  let iOffset = 0;
  let indexBase = 0;
  for (const g of parts) {
    const pos = g.getAttribute('position');
    const nor = g.getAttribute('normal');
    const col = g.getAttribute('color');
    for (let i = 0; i < pos.count; i += 1) {
      positions[(vOffset + i) * 3] = pos.getX(i);
      positions[(vOffset + i) * 3 + 1] = pos.getY(i);
      positions[(vOffset + i) * 3 + 2] = pos.getZ(i);
      if (nor) {
        normals[(vOffset + i) * 3] = nor.getX(i);
        normals[(vOffset + i) * 3 + 1] = nor.getY(i);
        normals[(vOffset + i) * 3 + 2] = nor.getZ(i);
      } else {
        normals[(vOffset + i) * 3 + 1] = 1;
      }
      if (col) {
        colors[(vOffset + i) * 3] = col.getX(i);
        colors[(vOffset + i) * 3 + 1] = col.getY(i);
        colors[(vOffset + i) * 3 + 2] = col.getZ(i);
      } else {
        colors[(vOffset + i) * 3] = 0.4;
        colors[(vOffset + i) * 3 + 1] = 0.65;
        colors[(vOffset + i) * 3 + 2] = 0.3;
      }
    }
    const idx = g.getIndex();
    if (idx) {
      for (let i = 0; i < idx.count; i += 1) {
        indices[iOffset + i] = idx.getX(i) + indexBase;
      }
      iOffset += idx.count;
    } else {
      for (let i = 0; i < pos.count; i += 1) {
        indices[iOffset + i] = i + indexBase;
      }
      iOffset += pos.count;
    }
    indexBase += pos.count;
    vOffset += pos.count;
  }
  const merged = new THREE.BufferGeometry();
  merged.setAttribute('position', new THREE.BufferAttribute(positions, 3));
  merged.setAttribute('normal', new THREE.BufferAttribute(normals, 3));
  merged.setAttribute('color', new THREE.BufferAttribute(colors, 3));
  merged.setIndex(new THREE.BufferAttribute(indices, 1));
  merged.computeBoundingSphere();
  return merged;
}

function tintGeometry(geo, hex) {
  const c = new THREE.Color(hex);
  const count = geo.getAttribute('position').count;
  const colors = new Float32Array(count * 3);
  for (let i = 0; i < count; i += 1) {
    colors[i * 3] = c.r;
    colors[i * 3 + 1] = c.g;
    colors[i * 3 + 2] = c.b;
  }
  geo.setAttribute('color', new THREE.BufferAttribute(colors, 3));
  return geo;
}

function stem(radius, height, color, segments = 5) {
  const g = new THREE.CylinderGeometry(radius * 0.7, radius, height, segments, 1);
  g.translate(0, height / 2, 0);
  return tintGeometry(g, color);
}

function leafBlade(width, length, color, angle = 0, y = 0.4, lean = 0.35) {
  const g = new THREE.PlaneGeometry(width, length, 1, 2);
  g.rotateX(-Math.PI / 2 + lean);
  g.rotateY(angle);
  g.translate(Math.sin(angle) * length * 0.25, y, Math.cos(angle) * length * 0.25);
  return tintGeometry(g, color);
}

function headSphere(radius, color, y) {
  const g = new THREE.SphereGeometry(radius, 6, 4);
  g.translate(0, y, 0);
  return tintGeometry(g, color);
}

function buildCorn(stageBucket) {
  const parts = [stem(0.038, 0.88, '#2f6b24', 7)];
  const leafCount = stageBucket === 'germination' ? 2 : stageBucket === 'vegetative' ? 5 : 7;
  for (let i = 0; i < leafCount; i += 1) {
    const a = (i / leafCount) * Math.PI * 2;
    const y = 0.18 + (i / leafCount) * 0.58;
    parts.push(leafBlade(0.09, 0.5, '#3d8c2e', a, y, 0.58));
  }
  if (stageBucket === 'reproductive' || stageBucket === 'mature' || stageBucket === 'senescence') {
    // Tassel
    const tasselColor = stageBucket === 'senescence' ? '#a8892a' : '#c9a227';
    parts.push(headSphere(0.045, tasselColor, 0.94));
    for (let i = 0; i < 5; i += 1) {
      const a = (i / 5) * Math.PI * 2;
      const tassel = new THREE.CylinderGeometry(0.008, 0.004, 0.12, 4);
      tassel.rotateZ(0.55);
      tassel.rotateY(a);
      tassel.translate(Math.sin(a) * 0.04, 0.98, Math.cos(a) * 0.04);
      parts.push(tintGeometry(tassel, tasselColor));
    }
    // Two ears
    for (const side of [-1, 1]) {
      const ear = new THREE.CylinderGeometry(0.045, 0.038, 0.2, 7);
      ear.rotateZ(side * 0.55);
      ear.translate(side * 0.1, 0.52, 0);
      parts.push(tintGeometry(ear, '#d4a017'));
      const husk = new THREE.ConeGeometry(0.05, 0.1, 5);
      husk.rotateZ(side * 0.55);
      husk.translate(side * 0.14, 0.62, 0);
      parts.push(tintGeometry(husk, '#4a8c32'));
    }
  }
  return mergeGeometries(parts);
}

function buildCereal(stageBucket) {
  // Wheat/oat archetype: tillers + flag leaves + bearded spike (awns), not bare twigs.
  const parts = [];
  const tillers = stageBucket === 'germination' ? 1 : stageBucket === 'vegetative' ? 3 : 5;
  const stemColor = stageBucket === 'senescence' ? '#b8a04a' : '#6a9a30';
  const leafColor = stageBucket === 'senescence' ? '#c4b06a' : '#8fbf4a';
  const headColor = stageBucket === 'senescence' ? '#d4b05a' : '#c4a84a';

  for (let t = 0; t < tillers; t += 1) {
    const ox = (t - (tillers - 1) / 2) * 0.045;
    const oz = ((t % 2) - 0.5) * 0.02;
    const stemG = stem(0.014, 0.88, stemColor, 5);
    stemG.translate(ox, 0, oz);
    parts.push(stemG);
    // Lower + mid leaf, and a flag leaf near the head
    parts.push(leafBlade(0.04, 0.32, leafColor, t * 1.1, 0.28 + t * 0.04, 0.65));
    parts.push(leafBlade(0.032, 0.28, leafColor, t * 1.1 + Math.PI, 0.5 + t * 0.03, 0.55));
    if (stageBucket !== 'germination') {
      parts.push(leafBlade(0.028, 0.22, leafColor, t * 0.7, 0.72, 0.35));
    }
  }

  if (stageBucket === 'reproductive' || stageBucket === 'mature' || stageBucket === 'senescence') {
    // Compact spike of stacked spikelets
    for (let s = 0; s < 6; s += 1) {
      const y = 0.86 + s * 0.028;
      const spikelet = new THREE.SphereGeometry(0.018 + (s % 2) * 0.003, 5, 4);
      spikelet.translate(0, y, 0);
      parts.push(tintGeometry(spikelet, headColor));
      // Awns (beard)
      if (stageBucket !== 'reproductive' || s > 1) {
        for (const side of [-1, 1]) {
          const awn = new THREE.CylinderGeometry(0.003, 0.0015, 0.1, 3);
          awn.rotateZ(side * 0.35);
          awn.translate(side * 0.03, y + 0.05, 0);
          parts.push(tintGeometry(awn, headColor));
        }
      }
    }
  }
  return mergeGeometries(parts);
}

function buildBroadleaf(stageBucket) {
  const parts = [stem(0.02, 0.7, '#3a7a30', 5)];
  const layers = stageBucket === 'germination' ? 1 : stageBucket === 'vegetative' ? 2 : 3;
  for (let L = 0; L < layers; L += 1) {
    const y = 0.25 + L * 0.18;
    for (let i = 0; i < 3; i += 1) {
      const a = (i / 3) * Math.PI * 2 + L;
      const leaf = new THREE.CircleGeometry(0.08, 5);
      leaf.rotateX(-Math.PI / 2.4);
      leaf.rotateY(a);
      leaf.translate(Math.sin(a) * 0.1, y, Math.cos(a) * 0.1);
      parts.push(tintGeometry(leaf, '#4a9e3e'));
    }
  }
  if (stageBucket === 'reproductive' || stageBucket === 'mature') {
    for (let i = 0; i < 3; i += 1) {
      const a = (i / 3) * Math.PI * 2;
      const pod = new THREE.CylinderGeometry(0.015, 0.012, 0.08, 5);
      pod.rotateZ(1.2);
      pod.translate(Math.sin(a) * 0.08, 0.55, Math.cos(a) * 0.08);
      parts.push(tintGeometry(pod, '#6b8f2e'));
    }
  }
  return mergeGeometries(parts);
}

function buildCotton(stageBucket) {
  const parts = [stem(0.025, 0.75, '#3d7a32', 5)];
  for (let i = 0; i < 5; i += 1) {
    const a = (i / 5) * Math.PI * 2;
    parts.push(leafBlade(0.1, 0.28, '#5a9e4a', a, 0.35 + (i % 3) * 0.1, 0.4));
  }
  if (stageBucket === 'reproductive') {
    parts.push(headSphere(0.04, '#f0e8c0', 0.7));
  }
  if (stageBucket === 'mature' || stageBucket === 'senescence') {
    for (let i = 0; i < 4; i += 1) {
      const a = (i / 4) * Math.PI * 2;
      const boll = headSphere(0.045, '#f5f5f0', 0.55 + (i % 2) * 0.12);
      boll.translate(Math.sin(a) * 0.08, 0, Math.cos(a) * 0.08);
      parts.push(boll);
    }
  }
  return mergeGeometries(parts);
}

function buildSorghum(stageBucket) {
  const parts = [stem(0.03, 0.9, '#4a7a28', 6)];
  for (let i = 0; i < 4; i += 1) {
    parts.push(leafBlade(0.07, 0.4, '#6a9e38', i * 1.5, 0.3 + i * 0.12, 0.5));
  }
  if (stageBucket !== 'germination' && stageBucket !== 'vegetative') {
    parts.push(headSphere(0.08, '#c4a03a', 0.95));
  }
  return mergeGeometries(parts);
}

function buildCanola(stageBucket) {
  const parts = [stem(0.018, 0.8, '#5a7a28', 5)];
  for (let i = 0; i < 4; i += 1) {
    parts.push(leafBlade(0.06, 0.25, '#7a9e32', i * 1.4, 0.3 + i * 0.08, 0.45));
  }
  if (stageBucket === 'reproductive' || stageBucket === 'mature') {
    for (let i = 0; i < 6; i += 1) {
      const a = (i / 6) * Math.PI * 2;
      const flower = new THREE.SphereGeometry(0.025, 5, 4);
      flower.translate(Math.sin(a) * 0.06, 0.85, Math.cos(a) * 0.06);
      parts.push(tintGeometry(flower, '#e8d24a'));
    }
  }
  return mergeGeometries(parts);
}

function buildForageCluster(stageBucket) {
  const parts = [];
  const stems = stageBucket === 'germination' ? 2 : 6;
  for (let i = 0; i < stems; i += 1) {
    const a = (i / stems) * Math.PI * 2;
    const r = 0.04;
    const g = stem(0.01, 0.7 + (i % 3) * 0.05, '#3d7a30', 4);
    g.translate(Math.sin(a) * r, 0, Math.cos(a) * r);
    parts.push(g);
    parts.push(leafBlade(0.04, 0.22, '#4f9a3c', a, 0.35, 0.65));
  }
  return mergeGeometries(parts);
}

function stageBucket(stage) {
  const s = String(stage || 'unknown').toLowerCase();
  if (s === 'germination' || s === 'emergence') return 'germination';
  if (s === 'vegetative') return 'vegetative';
  if (s === 'reproductive') return 'reproductive';
  if (s === 'senescence') return 'senescence';
  if (s === 'mature') return 'mature';
  return 'vegetative';
}

/**
 * Returns a unit plant BufferGeometry for the crop archetype + growth stage.
 * Cached per (archetype, stageBucket, quality).
 */
export function getCropPlantGeometry(archetype, stage, quality = 'medium') {
  const bucket = stageBucket(stage);
  const detail = quality === 'low' ? 'low' : 'med';
  const key = `${archetype || 'cereal'}|${bucket}|${detail}`;
  if (_geoCache.has(key)) return _geoCache.get(key);

  let geo;
  switch (archetype) {
    case 'corn':
      geo = buildCorn(bucket);
      break;
    case 'broadleaf':
      geo = buildBroadleaf(bucket);
      break;
    case 'cotton':
      geo = buildCotton(bucket);
      break;
    case 'sorghum':
      geo = buildSorghum(bucket);
      break;
    case 'canola':
      geo = buildCanola(bucket);
      break;
    case 'forage_cluster':
      geo = buildForageCluster(bucket);
      break;
    case 'cereal':
    default:
      geo = buildCereal(bucket);
      break;
  }

  // Low quality: simplify by dropping color attribute is already fine; keep mesh.
  _geoCache.set(key, geo);
  return geo;
}

/** Optional GLB path map — used when assets exist under public/models/crops/. */
export const CROP_GLB_STAGE_PATHS = {
  corn: {
    germination: '/models/crops/corn_stage1.glb',
    emergence: '/models/crops/corn_stage1.glb',
    vegetative: '/models/crops/corn_stage2.glb',
    reproductive: '/models/crops/corn_stage3.glb',
    mature: '/models/crops/corn_stage4.glb',
    senescence: '/models/crops/corn_stage5.glb',
  },
};

export function glbPathForCrop(cropKey, stage) {
  const map = CROP_GLB_STAGE_PATHS[cropKey];
  if (!map) return null;
  const bucket = stageBucket(stage);
  return map[bucket] || map.vegetative || null;
}
