import React, { useMemo } from 'react';
import { lngLatToLocal, extractOuterRings, mulberry32 } from './coords';

/**
 * Lightweight farm-set dressing: fence posts along the boundary, distant
 * shelterbelt trees, and a few field-edge props so the twin feels like a parcel
 * rather than a floating green slab.
 */
export default function FarmAmbience({
  boundary,
  origin,
  bbox,
  elevation = null,
  exaggeration = 2.5,
  flatFallback = false,
}) {
  const fence = useMemo(
    () => buildFencePosts(boundary, origin, elevation, bbox, exaggeration),
    [boundary, origin, elevation, bbox, exaggeration],
  );
  const trees = useMemo(
    () => buildShelterbelt(boundary, origin, bbox, elevation, exaggeration, flatFallback),
    [boundary, origin, bbox, elevation, exaggeration, flatFallback],
  );

  if (!origin?.latitude || !bbox) return null;

  return (
    <group>
      {fence.map((p, i) => (
        <group key={`fence-${i}`} position={[p.x, p.y, p.z]}>
          <mesh position={[0, 0.55, 0]} castShadow>
            <cylinderGeometry args={[0.07, 0.09, 1.1, 5]} />
            <meshStandardMaterial color="#6b4f2a" roughness={0.95} />
          </mesh>
          {i % 2 === 0 && (
            <mesh position={[0.55, 0.7, 0]} rotation={[0, 0, Math.PI / 2]}>
              <cylinderGeometry args={[0.025, 0.025, 1.1, 4]} />
              <meshStandardMaterial color="#8a7350" roughness={0.9} metalness={0.15} />
            </mesh>
          )}
        </group>
      ))}
      {trees.map((t, i) => (
        <group key={`tree-${i}`} position={[t.x, t.y, t.z]} scale={t.scale}>
          <mesh position={[0, 0.7, 0]} castShadow>
            <cylinderGeometry args={[0.12, 0.18, 1.4, 5]} />
            <meshStandardMaterial color="#5c4030" roughness={1} />
          </mesh>
          <mesh position={[0, 2.1, 0]} castShadow>
            <coneGeometry args={[1.1, 2.4, 7]} />
            <meshStandardMaterial color={t.color} roughness={0.9} />
          </mesh>
        </group>
      ))}
    </group>
  );
}

function sampleY(elevation, bbox, lng, lat, exaggeration) {
  const values = elevation?.values;
  if (!values?.length || !bbox) return 0;
  const [w, s, e, n] = bbox;
  const rows = values.length;
  const cols = values[0]?.length || 0;
  if (!cols) return 0;
  const u = (lng - w) / Math.max(1e-9, e - w);
  const v = (n - lat) / Math.max(1e-9, n - s);
  const c = Math.min(cols - 1, Math.max(0, Math.floor(u * cols)));
  const r = Math.min(rows - 1, Math.max(0, Math.floor(v * rows)));
  let min = Infinity;
  for (const row of values) {
    for (const val of row || []) {
      if (val != null && val < min) min = val;
    }
  }
  if (!Number.isFinite(min)) min = 0;
  const el = values[r]?.[c];
  return (((el ?? min) - min) * exaggeration);
}

function buildFencePosts(boundary, origin, elevation, bbox, exaggeration) {
  if (!boundary || !origin?.latitude) return [];
  const rings = extractOuterRings(boundary);
  const ring = rings[0];
  if (!ring || ring.length < 3) return [];
  const posts = [];
  const stepM = 14;
  for (let i = 0; i < ring.length - 1; i++) {
    const [lng0, lat0] = ring[i];
    const [lng1, lat1] = ring[i + 1];
    const p0 = lngLatToLocal(lng0, lat0, origin);
    const p1 = lngLatToLocal(lng1, lat1, origin);
    const dx = p1.x - p0.x;
    const dz = p1.z - p0.z;
    const len = Math.hypot(dx, dz);
    if (len < 2) continue;
    const n = Math.max(1, Math.floor(len / stepM));
    for (let k = 0; k <= n; k++) {
      const t = k / n;
      const lng = lng0 + (lng1 - lng0) * t;
      const lat = lat0 + (lat1 - lat0) * t;
      const { x, z } = lngLatToLocal(lng, lat, origin);
      posts.push({
        x,
        y: sampleY(elevation, bbox, lng, lat, exaggeration),
        z,
      });
    }
  }
  // Cap posts for performance on large parcels
  if (posts.length > 180) {
    const keep = [];
    const every = Math.ceil(posts.length / 180);
    for (let i = 0; i < posts.length; i += every) keep.push(posts[i]);
    return keep;
  }
  return posts;
}

function buildShelterbelt(boundary, origin, bbox, elevation, exaggeration, flatFallback) {
  if (!origin?.latitude || !bbox) return [];
  const [w, s, e, n] = bbox;
  const seed = Math.round((origin.latitude + origin.longitude) * 10000);
  const rand = mulberry32(seed ^ 0xC0FFEE);
  const count = flatFallback ? 28 : 18;
  const trees = [];
  const colors = ['#2f5e2e', '#3d6b34', '#456f3a', '#2a5230'];

  // Prefer just outside the boundary bbox edges (shelterbelt look)
  for (let i = 0; i < count; i++) {
    const edge = i % 4;
    let lng;
    let lat;
    const padLon = (e - w) * 0.04;
    const padLat = (n - s) * 0.04;
    if (edge === 0) {
      lng = w - padLon - rand() * padLon * 2;
      lat = s + rand() * (n - s);
    } else if (edge === 1) {
      lng = e + padLon + rand() * padLon * 2;
      lat = s + rand() * (n - s);
    } else if (edge === 2) {
      lng = w + rand() * (e - w);
      lat = s - padLat - rand() * padLat * 2;
    } else {
      lng = w + rand() * (e - w);
      lat = n + padLat + rand() * padLat * 2;
    }
    const { x, z } = lngLatToLocal(lng, lat, origin);
    trees.push({
      x,
      y: sampleY(elevation, bbox, lng, lat, exaggeration),
      z,
      scale: 0.85 + rand() * 0.7,
      color: colors[Math.floor(rand() * colors.length)],
    });
  }
  return trees;
}
