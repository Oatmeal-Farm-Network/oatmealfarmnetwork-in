import React, { useMemo, useEffect, useState, useRef } from 'react';
import * as THREE from 'three';
import { lngLatToLocal, pointInBoundary, sampleGridValue } from './coords';
import { moistureShaderParams } from './cropCatalog';

/** RdYlGn-ish NDVI: red (stressed) → yellow → green (healthy). */
function ndviToColor(v) {
  const t = Math.max(0, Math.min(1, (Number(v) + 0.2) / 1.0)); // -0.2..0.8
  const c = new THREE.Color();
  if (t < 0.5) {
    c.setRGB(0.85, 0.15 + t * 1.2, 0.08);
  } else {
    const u = (t - 0.5) * 2;
    c.setRGB(0.85 - u * 0.7, 0.75 + u * 0.15, 0.08 + u * 0.25);
  }
  return c;
}

/** RdYlBu-ish NDWI: brown/dry → cyan → blue/wet. */
function ndwiToColor(v) {
  const t = Math.max(0, Math.min(1, (Number(v) + 0.6) / 1.2)); // -0.6..0.6
  const c = new THREE.Color();
  if (t < 0.5) {
    const u = t * 2;
    c.setRGB(0.55 + u * 0.2, 0.25 + u * 0.45, 0.1 + u * 0.2);
  } else {
    const u = (t - 0.5) * 2;
    c.setRGB(0.2 - u * 0.15, 0.55 + u * 0.15, 0.55 + u * 0.4);
  }
  return c;
}

/**
 * DEM terrain mesh in local meters, clipped to field boundary when available,
 * textured with crop imagery (falls back to tinted dirt/crop colors).
 * When indexGrid + indexKind are set (ndvi/ndwi), paints clear cell colors on
 * the DEM — matching the Field Twin “clear overlay” look.
 */
export default function TerrainMesh({
  elevation,
  bbox,
  origin,
  boundary,
  textureUrl,
  indexGrid = null,
  indexKind = null, // 'ndvi' | 'ndwi' | null
  soilMoistureLevel = 'unknown',
  exaggeration = 2.5,
  cropTint = '#4a8c3a',
  textureProvenance = null,
  textureLabel = null,
  textureNote = null,
  onPick,
}) {
  const elevMin = useMemo(() => {
    const vals = elevation?.values || [];
    let min = Infinity;
    for (const row of vals) {
      for (const v of row || []) {
        if (v != null && Number.isFinite(v) && v < min) min = v;
      }
    }
    return Number.isFinite(min) ? min : 0;
  }, [elevation]);

  const elevMax = useMemo(() => {
    const vals = elevation?.values || [];
    let max = -Infinity;
    for (const row of vals) {
      for (const v of row || []) {
        if (v != null && Number.isFinite(v) && v > max) max = v;
      }
    }
    return Number.isFinite(max) ? max : elevMin + 1;
  }, [elevation, elevMin]);

  const indexValues = indexGrid?.values || indexGrid?.grid?.values || null;
  const indexBbox = indexGrid?.bbox || indexGrid?.grid?.bbox || bbox;
  const useIndexColors = Boolean(
    indexKind
    && (indexKind === 'ndvi' || indexKind === 'ndwi')
    && Array.isArray(indexValues)
    && indexValues.length > 0
    && indexBbox?.length === 4,
  );

  const geometry = useMemo(() => {
    const values = elevation?.values;
    if (!values?.length || !bbox || !origin?.latitude) return null;
    const rows = values.length;
    const cols = values[0]?.length || 0;
    if (!cols) return null;
    const [w, s, e, n] = bbox;
    const hasBoundary = !!boundary;

    const positions = [];
    const uvs = [];
    const colors = [];
    const indices = [];
    const moist = moistureShaderParams(soilMoistureLevel);
    const range = Math.max(1, elevMax - elevMin);
    const tint = new THREE.Color(cropTint || '#4a8c3a');
    const dirt = new THREE.Color(0.42 * moist.colorMul, 0.32 * moist.colorMul, 0.2 * moist.colorMul);
    const flat = Boolean(elevation?.flat_fallback);
    const toColor = indexKind === 'ndwi' ? ndwiToColor : ndviToColor;

    const valid = new Array(rows * cols);
    for (let r = 0; r < rows; r++) {
      const lat = n - ((r + 0.5) / rows) * (n - s);
      for (let c = 0; c < cols; c++) {
        const lng = w + ((c + 0.5) / cols) * (e - w);
        const inside = !hasBoundary || pointInBoundary(lng, lat, boundary);
        valid[r * cols + c] = inside;
        const { x, z } = lngLatToLocal(lng, lat, origin);
        let el = values[r][c];
        if (el == null || Number.isNaN(el)) el = elevMin;
        const y = (el - elevMin) * exaggeration;
        positions.push(x, y, z);
        uvs.push(c / (cols - 1 || 1), 1 - r / (rows - 1 || 1));

        if (useIndexColors) {
          const iv = sampleGridValue(indexValues, indexBbox, lng, lat, { nullIfPartial: false });
          if (iv != null && Number.isFinite(iv)) {
            const col = toColor(iv);
            colors.push(col.r, col.g, col.b);
          } else {
            colors.push(0.22, 0.22, 0.22);
          }
        } else {
          const t = Math.min(1, Math.max(0, (el - elevMin) / range));
          const patch = flat
            ? (Math.sin(r * 0.37 + c * 0.21) * 0.5 + 0.5) * 0.18
            : 0;
          const col = dirt.clone().lerp(tint, 0.35 + t * 0.45 + patch);
          colors.push(col.r, col.g, col.b);
        }
      }
    }

    for (let r = 0; r < rows - 1; r++) {
      for (let c = 0; c < cols - 1; c++) {
        const i = r * cols + c;
        const keep = (valid[i] ? 1 : 0)
          + (valid[i + 1] ? 1 : 0)
          + (valid[i + cols] ? 1 : 0)
          + (valid[i + cols + 1] ? 1 : 0);
        if (keep < 2) continue;
        indices.push(i, i + cols, i + 1);
        indices.push(i + 1, i + cols, i + cols + 1);
      }
    }

    if (!indices.length) {
      for (let r = 0; r < rows - 1; r++) {
        for (let c = 0; c < cols - 1; c++) {
          const i = r * cols + c;
          indices.push(i, i + cols, i + 1);
          indices.push(i + 1, i + cols, i + cols + 1);
        }
      }
    }

    const geo = new THREE.BufferGeometry();
    geo.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));
    geo.setAttribute('uv', new THREE.Float32BufferAttribute(uvs, 2));
    geo.setAttribute('color', new THREE.Float32BufferAttribute(colors, 3));
    geo.setIndex(indices);
    geo.computeVertexNormals();
    return geo;
  }, [
    elevation, bbox, origin, boundary, elevMin, elevMax, exaggeration,
    soilMoistureLevel, cropTint, useIndexColors, indexValues, indexBbox, indexKind,
  ]);

  const geoRef = useRef(null);
  useEffect(() => {
    geoRef.current = geometry;
  }, [geometry]);

  useEffect(() => () => {
    if (geoRef.current) {
      try { geoRef.current.dispose(); } catch { /* */ }
      geoRef.current = null;
    }
  }, []);

  const [texState, setTexState] = useState({ url: null, tex: null, failed: false });
  const liveTexRef = useRef(null);

  // Index surfaces use vertex colors (clear cell look). Skip satellite texture.
  const effectiveTextureUrl = useIndexColors ? null : textureUrl;

  useEffect(() => {
    if (!effectiveTextureUrl) {
      if (liveTexRef.current) {
        try { liveTexRef.current.dispose(); } catch { /* */ }
        liveTexRef.current = null;
      }
      setTexState({ url: null, tex: null, failed: false });
      return undefined;
    }
    let cancelled = false;
    const loader = new THREE.TextureLoader();
    loader.setCrossOrigin('anonymous');
    loader.load(
      effectiveTextureUrl,
      (t) => {
        if (cancelled) {
          try { t.dispose(); } catch { /* */ }
          return;
        }
        t.colorSpace = THREE.SRGBColorSpace;
        t.flipY = true;
        t.anisotropy = 16;
        t.minFilter = THREE.LinearMipmapLinearFilter;
        t.magFilter = THREE.LinearFilter;
        t.generateMipmaps = true;
        t.needsUpdate = true;
        if (liveTexRef.current && liveTexRef.current !== t) {
          try { liveTexRef.current.dispose(); } catch { /* */ }
        }
        liveTexRef.current = t;
        setTexState({ url: effectiveTextureUrl, tex: t, failed: false });
      },
      undefined,
      () => {
        if (!cancelled) {
          if (liveTexRef.current) {
            try { liveTexRef.current.dispose(); } catch { /* */ }
            liveTexRef.current = null;
          }
          setTexState({ url: effectiveTextureUrl, tex: null, failed: true });
          console.warn('[field-twin] terrain texture failed to load');
        }
      },
    );
    return () => { cancelled = true; };
  }, [effectiveTextureUrl]);

  useEffect(() => () => {
    if (liveTexRef.current) {
      try { liveTexRef.current.dispose(); } catch { /* */ }
      liveTexRef.current = null;
    }
  }, []);

  const displayTex = (
    effectiveTextureUrl
    && texState.url === effectiveTextureUrl
    && !texState.failed
    && texState.tex
  ) ? texState.tex : null;
  const moist = moistureShaderParams(soilMoistureLevel);

  if (!geometry) return null;

  return (
    <mesh
      geometry={geometry}
      receiveShadow
      castShadow={false}
      onClick={(e) => {
        e.stopPropagation();
        onPick?.({
          kind: 'terrain',
          point: e.point,
          provenance: textureProvenance || (useIndexColors ? 'derived' : (displayTex ? 'derived' : 'modeled')),
          label: textureLabel || (useIndexColors
            ? `${String(indexKind || 'index').toUpperCase()} surface`
            : (displayTex ? 'Field surface (satellite)' : 'Field surface')),
          note: textureNote || (useIndexColors
            ? `Sentinel ${String(indexKind || '').toUpperCase()} painted on DEM — cell colors are derived, not a photo.`
            : (displayTex
              ? 'Sentinel natural-color imagery draped on DEM.'
              : 'Elevation-tinted surface — satellite texture unavailable.')),
        });
      }}
    >
      <meshStandardMaterial
        map={displayTex || null}
        vertexColors={!displayTex}
        roughness={moist.roughness}
        metalness={moist.metalness}
        side={THREE.DoubleSide}
        color={displayTex ? '#ffffff' : undefined}
      />
    </mesh>
  );
}
