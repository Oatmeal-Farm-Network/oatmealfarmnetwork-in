import React, { useMemo, useRef, useLayoutEffect, useEffect, useState } from 'react';
import { useFrame } from '@react-three/fiber';
import * as THREE from 'three';
import {
  buildPlantGrid,
  sampleElevation,
  sampleGridValue,
  canopyParamsFromNdvi,
  mulberry32,
  extractOuterRings,
  lngLatToLocal,
} from './coords';
import { parseBoundary } from '../terrain/geojson';
import { resolveCropStyle } from './cropCatalog';
import { getCropPlantGeometry } from './cropGeometry';
import { maxInstancesForQuality } from './twinQuality';

const TILE_SIZE_M = 25;
/** Camera-distance LOD bands (meters from tile center). */
const LOD_NEAR_M = 70;
const LOD_MID_M = 150;
const LOD_FAR_M = 320;

/** Bucket plant samples into ~25 m spatial tiles for real frustum culling. */
function tilePositions(positions, tileSize = TILE_SIZE_M) {
  const map = new Map();
  for (let i = 0; i < positions.length; i++) {
    const p = positions[i];
    const tx = Math.floor(p.x / tileSize);
    const tz = Math.floor(p.z / tileSize);
    const key = `${tx},${tz}`;
    let bucket = map.get(key);
    if (!bucket) {
      bucket = [];
      map.set(key, bucket);
    }
    bucket.push(p);
  }
  return Array.from(map.entries()).map(([key, plants], idx) => ({
    key: `${key}-${idx}`,
    plants,
  }));
}

function buildCarpetShape(boundary, origin, positions, style) {
  let ySum = 0;
  let rSum = 0;
  let gSum = 0;
  let bSum = 0;
  let colorN = 0;
  for (const p of positions) {
    ySum += p.y;
    if (p.color) {
      rSum += p.color.r;
      gSum += p.color.g;
      bSum += p.color.b;
      colorN += 1;
    }
  }
  const carpetColor = colorN
    ? new THREE.Color(rSum / colorN, gSum / colorN, bSum / colorN)
    : new THREE.Color(style.color);
  const y = positions.length ? ySum / positions.length + 0.08 : 0.08;

  const rings = extractOuterRings(boundary);
  if (rings.length && origin) {
    // Outer rings only — MultiPolygon parts are separate shapes (not holes).
    const shapes = rings.map((ring) => {
      const shape = new THREE.Shape();
      ring.forEach((coord, i) => {
        const [lng, lat] = coord;
        const { x, z } = lngLatToLocal(lng, lat, origin);
        if (i === 0) shape.moveTo(x, -z);
        else shape.lineTo(x, -z);
      });
      shape.closePath();
      return shape;
    });
    const geometries = shapes.map((shape) => {
      const g = new THREE.ShapeGeometry(shape);
      g.rotateX(-Math.PI / 2);
      return g;
    });
    const geometry = geometries.length === 1
      ? geometries[0]
      : (() => {
        const merged = new THREE.BufferGeometry();
        // Simple merge without BufferGeometryUtils dependency
        const positions = [];
        const indices = [];
        let indexOffset = 0;
        for (const g of geometries) {
          const pos = g.getAttribute('position');
          const idx = g.index;
          for (let i = 0; i < pos.count; i++) {
            positions.push(pos.getX(i), pos.getY(i), pos.getZ(i));
          }
          if (idx) {
            for (let i = 0; i < idx.count; i++) {
              indices.push(idx.getX(i) + indexOffset);
            }
          }
          indexOffset += pos.count;
          g.dispose();
        }
        merged.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));
        if (indices.length) merged.setIndex(indices);
        merged.computeVertexNormals();
        return merged;
      })();
    return { geometry, y, color: carpetColor, clipped: true };
  }

  // Fallback AABB only when no polygon is available
  let minX = Infinity;
  let maxX = -Infinity;
  let minZ = Infinity;
  let maxZ = -Infinity;
  for (const p of positions) {
    minX = Math.min(minX, p.x);
    maxX = Math.max(maxX, p.x);
    minZ = Math.min(minZ, p.z);
    maxZ = Math.max(maxZ, p.z);
  }
  return {
    geometry: new THREE.PlaneGeometry(Math.max(8, maxX - minX), Math.max(8, maxZ - minZ)),
    y,
    color: carpetColor,
    clipped: false,
    cx: (minX + maxX) / 2,
    cz: (minZ + maxZ) / 2,
  };
}

function PlantTile({
  plants,
  plantGeometry,
  visualScale,
  style,
  quality,
  viewPreset,
  opacityScale,
  windUniforms,
  onPickPlant,
}) {
  const meshRef = useRef();
  const materialRef = useRef();
  const dummy = useMemo(() => new THREE.Object3D(), []);

  useLayoutEffect(() => {
    const mesh = meshRef.current;
    if (!mesh || !plants.length) return;
    const { height, radius } = visualScale;
    const colors = new THREE.InstancedBufferAttribute(new Float32Array(plants.length * 3), 3);
    const fallback = new THREE.Color(style.stemColor || style.color).multiplyScalar(0.85);

    let minX = Infinity;
    let maxX = -Infinity;
    let minY = Infinity;
    let maxY = -Infinity;
    let minZ = Infinity;
    let maxZ = -Infinity;

    for (let i = 0; i < plants.length; i++) {
      const p = plants[i];
      const h = height * (p.heightScale || 1);
      const r = Math.max(1.1, radius * 10 * (p.radiusScale || 1));
      dummy.position.set(p.x, p.y, p.z);
      dummy.scale.set(r, h, r);
      dummy.rotation.set(0, (i % 7) * 0.3, 0);
      dummy.updateMatrix();
      mesh.setMatrixAt(i, dummy.matrix);
      if (p.color) {
        colors.setXYZ(i, p.color.r * 0.9, p.color.g * 0.9, p.color.b * 0.85);
      } else {
        colors.setXYZ(i, fallback.r, fallback.g, fallback.b);
      }
      minX = Math.min(minX, p.x - r);
      maxX = Math.max(maxX, p.x + r);
      minY = Math.min(minY, p.y);
      maxY = Math.max(maxY, p.y + h);
      minZ = Math.min(minZ, p.z - r);
      maxZ = Math.max(maxZ, p.z + r);
    }
    mesh.count = plants.length;
    mesh.instanceMatrix.needsUpdate = true;
    mesh.instanceColor = colors;
    // Prefer an explicit per-tile sphere (shared plantGeometry must not own this).
    const cx = (minX + maxX) / 2;
    const cy = (minY + maxY) / 2;
    const cz = (minZ + maxZ) / 2;
    const radiusBound = Math.sqrt(
      (maxX - minX) ** 2 + (maxY - minY) ** 2 + (maxZ - minZ) ** 2,
    ) * 0.55 + 2;
    mesh.boundingSphere = new THREE.Sphere(new THREE.Vector3(cx, cy, cz), radiusBound);
    mesh.frustumCulled = true;
    mesh.userData.fullCount = plants.length;
  }, [plants, visualScale, dummy, style, plantGeometry]);

  // Distance LOD: hide far tiles; thin mid-distance instance counts.
  useFrame(({ camera }) => {
    const mesh = meshRef.current;
    if (!mesh?.boundingSphere) return;
    const full = mesh.userData.fullCount || plants.length;
    const dist = camera.position.distanceTo(mesh.boundingSphere.center);
    if (dist > LOD_FAR_M) {
      mesh.visible = false;
      return;
    }
    mesh.visible = true;
    if (dist > LOD_MID_M) {
      mesh.count = Math.max(1, Math.ceil(full / 4));
    } else if (dist > LOD_NEAR_M) {
      mesh.count = Math.max(1, Math.ceil(full / 2));
    } else {
      mesh.count = full;
    }
  });

  useLayoutEffect(() => {
    const mat = materialRef.current;
    if (!mat || !windUniforms) return undefined;
    mat.onBeforeCompile = (shader) => {
      shader.uniforms.uWindTime = windUniforms.uWindTime;
      shader.uniforms.uWindAmp = windUniforms.uWindAmp;
      shader.uniforms.uWindDir = windUniforms.uWindDir;
      shader.vertexShader = `
        uniform float uWindTime;
        uniform float uWindAmp;
        uniform vec2 uWindDir;
        ${shader.vertexShader}
      `.replace(
        '#include <begin_vertex>',
        `#include <begin_vertex>
        float hNorm = max(transformed.y, 0.0);
        float phase = uWindTime * 1.55 + instanceMatrix[3].x * 0.12 + instanceMatrix[3].z * 0.1;
        float sway = sin(phase) * uWindAmp * hNorm;
        transformed.x += sway * uWindDir.x;
        transformed.z += sway * uWindDir.y;`,
      );
      mat.userData.shader = shader;
    };
    mat.needsUpdate = true;
    return () => {
      mat.onBeforeCompile = () => {};
    };
  }, [windUniforms]);

  return (
    <instancedMesh
      ref={meshRef}
      args={[plantGeometry, undefined, Math.max(1, plants.length)]}
      castShadow={quality === 'high' && viewPreset === 'canopy'}
      receiveShadow={false}
      frustumCulled
      onClick={(e) => {
        e.stopPropagation();
        const idx = e.instanceId;
        onPickPlant?.(idx != null ? plants[idx] : null);
      }}
    >
      <meshStandardMaterial
        ref={materialRef}
        vertexColors
        color="#ffffff"
        roughness={0.82}
        metalness={0.03}
        side={THREE.DoubleSide}
        transparent={opacityScale < 0.99}
        opacity={Math.max(0.05, Math.min(1, opacityScale))}
        depthWrite={opacityScale >= 0.99}
      />
    </instancedMesh>
  );
}

/**
 * Visible crop canopy: instanced visual samples + soft carpet.
 * When a spatial NDVI grid is present, height/color/density follow NDVI;
 * no-data pixels do not invent healthy crops. Geometry remains illustrative.
 */
export default function CropCanopy({
  snapshot,
  elevation,
  ndviGrid,
  bbox,
  origin,
  quality = 'medium',
  exaggeration = 2.5,
  windMph = 5,
  windDirDeg = 180,
  visible = true,
  hasImagery = false,
  hideCarpet = false,
  opacityScale = 1,
  viewPreset = 'overview',
  onPick,
  onStats,
}) {
  const [tabVisible, setTabVisible] = useState(
    () => typeof document === 'undefined' || document.visibilityState !== 'hidden',
  );

  useEffect(() => {
    if (typeof document === 'undefined') return undefined;
    const onVis = () => setTabVisible(document.visibilityState !== 'hidden');
    document.addEventListener('visibilitychange', onVis);
    return () => document.removeEventListener('visibilitychange', onVis);
  }, []);

  const style = useMemo(() => {
    const cropKey = snapshot?.crop?.crop_key || 'default';
    const stage = snapshot?.crop?.growth?.stage;
    const indices = snapshot?.analysis?.data?.vegetation_indices || [];
    const ndvi = indices.find((i) => (i.index_type || '').toUpperCase() === 'NDVI');
    return resolveCropStyle(cropKey, stage, ndvi?.mean);
  }, [snapshot]);

  const boundary = useMemo(
    () => parseBoundary(snapshot?.field?.boundary || snapshot?.terrain?.boundary),
    [snapshot],
  );

  const ndviValues = ndviGrid?.values || null;
  const ndviBbox = ndviGrid?.grid?.bbox || bbox;
  const hasSpatialNdvi = Array.isArray(ndviValues) && ndviValues.length > 0;

  const positions = useMemo(() => {
    if (!snapshot || !origin || !bbox) return [];
    const presets = snapshot.rendering_hints?.quality_presets || {};
    const hints = presets[quality] || presets.medium || {
      plant_spacing_m: 1.5,
      max_instances: 40000,
    };
    const [w, s, e, n] = bbox;
    const widthM = Math.abs(e - w) * (111320 * Math.cos((origin.latitude * Math.PI) / 180));
    const depthM = Math.abs(n - s) * 111320;
    const extentM = Math.max(widthM, depthM, 40);
    const adaptive = Math.max(1.6, Math.min(5.5, extentM / 70));
    const habitMul = (style.habit === 'forage') ? 1.15 : 1.05;
    const rowHint = style.rowSpacingHint || 0.45;
    const overviewMul = viewPreset === 'canopy' ? 1.35 : 0.85;
    const flatMul = elevation?.flat_fallback ? 0.72 : 1; // denser stand on flat DEM so the parcel reads as crop
    const spacing = Math.max(
      1.15,
      Math.min(
        4.2,
        Math.max(adaptive * habitMul * overviewMul * flatMul, rowHint * (style.habit === 'forage' ? 3.2 : 2.2)),
      ),
    );
    const seed = (snapshot.field?.field_id || 1) * 9973;
    const rand = mulberry32(seed ^ 0xA5A5);
    const tierCap = maxInstancesForQuality(quality);
    const presetCap = Number(hints.max_instances) || tierCap;
    // Canopy close-up: slightly fewer instances for readability; overview can use the full tier budget.
    const viewCap = viewPreset === 'canopy'
      ? Math.min(tierCap, Math.round(tierCap * 0.85))
      : tierCap;
    const grid = buildPlantGrid({
      boundary,
      origin,
      bbox,
      spacingM: spacing,
      maxInstances: Math.min(presetCap, viewCap),
      seed,
    });
    let elevMin = Infinity;
    for (const row of elevation?.values || []) {
      for (const v of row || []) {
        if (v != null && v < elevMin) elevMin = v;
      }
    }
    if (!Number.isFinite(elevMin)) elevMin = 0;

    const out = [];
    let skippedNoData = 0;
    let skippedSparse = 0;
    for (const p of grid) {
      const el = sampleElevation(elevation?.values, bbox, p.lng, p.lat);
      const y = ((el ?? elevMin) - elevMin) * exaggeration;

      let canopy = null;
      if (hasSpatialNdvi) {
        const ndvi = sampleGridValue(ndviValues, ndviBbox, p.lng, p.lat);
        canopy = canopyParamsFromNdvi(ndvi);
        if (!canopy) {
          skippedNoData += 1;
          continue;
        }
        if (rand() > canopy.keepProbability) {
          skippedSparse += 1;
          continue;
        }
      }

      out.push({
        ...p,
        y,
        canopy,
        heightScale: canopy?.heightScale ?? 1,
        radiusScale: canopy?.radiusScale ?? 1,
        color: canopy?.color || null,
        ndvi: canopy?.ndvi ?? null,
      });
    }
    out._meta = { skippedNoData, skippedSparse, spatialNdvi: hasSpatialNdvi };
    return out;
  }, [snapshot, elevation, bbox, origin, quality, exaggeration, boundary, hasSpatialNdvi, ndviValues, ndviBbox, style.habit, style.rowSpacingHint, viewPreset, elevation?.flat_fallback]);

  const tiles = useMemo(
    () => (positions.length ? tilePositions(positions) : []),
    [positions],
  );

  const plantGeometry = useMemo(
    () => getCropPlantGeometry(style.archetype, style.stage, quality),
    [style.archetype, style.stage, quality],
  );

  const visualScale = useMemo(() => {
    const base = style.height || 0.7;
    const habit = style.habit || 'forage';
    const stage = style.stage || 'unknown';
    const minH = (stage === 'germination' || stage === 'emergence')
      ? (habit === 'forage' ? 0.12 : 0.18)
      : (habit === 'forage' ? 0.35 : 0.55);
    const readability = viewPreset === 'canopy' ? 1.15 : (habit === 'forage' ? 3.6 : 2.4);
    const modeledHeight = habit === 'forage'
      ? Math.min(0.85, Math.max(minH, base))
      : Math.min(2.2, Math.max(minH, base));
    const displayHeight = Math.min(
      habit === 'forage' ? 2.8 : 4.5,
      modeledHeight * readability,
    );
    const radius = habit === 'forage'
      ? Math.max(0.14, (style.canopyRadius || 0.1) * 2.2)
      : Math.max(0.14, (style.canopyRadius || 0.12) * 2.0);
    return {
      height: displayHeight,
      modeledHeight,
      radius,
      readability,
    };
  }, [style, viewPreset]);

  const ndviSummary = useMemo(() => {
    if (!hasSpatialNdvi || !positions.length) return null;
    let sum = 0;
    let n = 0;
    let min = Infinity;
    let max = -Infinity;
    for (const p of positions) {
      if (p.ndvi == null) continue;
      sum += p.ndvi;
      n += 1;
      min = Math.min(min, p.ndvi);
      max = Math.max(max, p.ndvi);
    }
    if (!n) return null;
    return { mean: sum / n, min, max, samples: n };
  }, [positions, hasSpatialNdvi]);

  useLayoutEffect(() => {
    if (!onStats) return;
    onStats({
      visualSampleCount: positions.length,
      plantCount: positions.length,
      cropLabel: style.label,
      stage: style.stage,
      spatialNdvi: hasSpatialNdvi,
      ndviSummary,
      skippedNoData: positions._meta?.skippedNoData || 0,
      vegetationAcquiredAt: snapshot?.vegetation?.acquired_at || null,
      displayHeightM: visualScale.height,
      modeledHeightM: visualScale.modeledHeight,
      tileCount: tiles.length,
    });
  }, [positions, style.label, style.stage, onStats, hasSpatialNdvi, ndviSummary, snapshot, visualScale, tiles.length]);

  const windUniforms = useMemo(() => ({
    uWindTime: { value: 0 },
    uWindAmp: { value: 0 },
    uWindDir: { value: new THREE.Vector2(0, 1) },
  }), []);

  useLayoutEffect(() => {
    const rad = ((windDirDeg || 180) * Math.PI) / 180;
    windUniforms.uWindDir.value.set(Math.sin(rad), Math.cos(rad));
    windUniforms.uWindAmp.value = quality === 'low'
      ? 0
      : Math.min(0.12, (windMph || 0) * 0.008 + 0.025);
  }, [windDirDeg, windMph, quality, windUniforms]);

  useFrame(({ clock }) => {
    if (!tabVisible || !visible || quality === 'low') {
      windUniforms.uWindAmp.value = 0;
      return;
    }
    windUniforms.uWindTime.value = clock.elapsedTime;
    windUniforms.uWindAmp.value = Math.min(0.12, (windMph || 0) * 0.008 + 0.025);
  });

  const carpet = useMemo(() => {
    if (!positions.length) return null;
    return buildCarpetShape(boundary, origin, positions, style);
  }, [positions, boundary, origin, style]);

  if (!visible || !positions.length) return null;

  const veg = snapshot?.vegetation || {};
  const pickNote = hasSpatialNdvi
    ? (veg.note
      || 'Visual samples scaled by spatial NDVI. Height is modeled, not measured plant stature.')
    : (snapshot?.crop?.growth?.note
      || 'Visual samples are illustrative — no spatial NDVI grid was available.');

  const onPickPlant = (p) => {
    onPick?.({
      kind: 'crop',
      label: `${style.label} visual sample`,
      stage: style.stage,
      modeled_height_m: (visualScale.modeledHeight ?? visualScale.height) * (p?.heightScale || 1),
      visual_sample_count: positions.length,
      ndvi: p?.ndvi,
      ndvi_mean: ndviSummary?.mean,
      provenance: 'modeled',
      confidence: veg.confidence || snapshot?.crop?.growth?.confidence || 'medium',
      source: veg.source,
      acquired_at: veg.acquired_at,
      spatial_resolution_m: veg.spatial_resolution_m,
      note: pickNote,
    });
  };

  return (
    <group>
      {carpet && (!hideCarpet || viewPreset === 'overview') && (
        <mesh
          geometry={carpet.geometry}
          position={carpet.clipped
            ? [0, carpet.y + (hideCarpet ? 0.12 : 0.05), 0]
            : [carpet.cx, carpet.y + (hideCarpet ? 0.12 : 0.05), carpet.cz]}
          rotation={carpet.clipped ? [0, 0, 0] : [-Math.PI / 2, 0, 0]}
          receiveShadow={quality === 'high'}
          onClick={(e) => {
            e.stopPropagation();
            onPick?.({
              kind: 'crop',
              label: `${style.label} canopy (visual)`,
              stage: style.stage,
              modeled_height_m: visualScale.modeledHeight ?? visualScale.height,
              visual_sample_count: positions.length,
              ndvi_mean: ndviSummary?.mean,
              provenance: hasSpatialNdvi ? 'modeled' : style.provenance,
              confidence: veg.confidence || snapshot?.crop?.growth?.confidence || 'medium',
              source: veg.source,
              acquired_at: veg.acquired_at,
              spatial_resolution_m: veg.spatial_resolution_m,
              note: pickNote,
            });
          }}
        >
          <meshStandardMaterial
            color={carpet.color}
            roughness={0.95}
            metalness={0.02}
            transparent
            opacity={hideCarpet
              ? 0.28
              : (hasImagery ? 0.42 : 0.68)}
            side={THREE.DoubleSide}
            depthWrite={false}
          />
        </mesh>
      )}

      {tiles.map((tile) => (
        <PlantTile
          key={`${style.archetype}-${style.stage}-${quality}-${viewPreset}-${tile.key}`}
          plants={tile.plants}
          plantGeometry={plantGeometry}
          visualScale={visualScale}
          style={style}
          quality={quality}
          viewPreset={viewPreset}
          opacityScale={opacityScale}
          windUniforms={windUniforms}
          onPickPlant={onPickPlant}
        />
      ))}
    </group>
  );
}
