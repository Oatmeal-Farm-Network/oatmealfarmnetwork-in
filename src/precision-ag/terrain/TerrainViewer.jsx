import React, { useEffect, useRef, useState, useCallback } from 'react';
import { parseBoundary, boundsFromGeoJSON, padBounds } from './geojson';
import { fetchTerrainImageBlob, terrainAssetUrl } from './useTerrainData';

const OVERLAYS = [
  { id: 'rgb', label: 'Crop / natural color', kind: 'texture' },
  { id: 'ndvi', label: 'NDVI', kind: 'overlay', layer: 'ndvi' },
  { id: 'ndwi', label: 'NDWI', kind: 'overlay', layer: 'ndwi' },
  { id: 'rvi', label: 'Radar RVI', kind: 'overlay', layer: 'rvi' },
  { id: 'zones', label: 'Management zones', kind: 'overlay', layer: 'zones' },
  { id: 'slope', label: 'Slope', kind: 'overlay', layer: 'slope' },
  { id: 'aspect', label: 'Aspect', kind: 'overlay', layer: 'aspect' },
  { id: 'hillshade', label: 'Hillshade', kind: 'overlay', layer: 'hillshade' },
  { id: 'wetness-risk', label: 'Wetness risk', kind: 'overlay', layer: 'wetness-risk' },
];

/**
 * Custom MapLibre v5 layer: DEM mesh in mercator space, textured with crop imagery.
 * MapLibre 5 uses a WebGL2 context — shaders must be GLSL ES 3.00 (#version 300 es).
 * Projection matrix: prefer defaultProjectionData.mainMatrix (official custom-layer example).
 */
function createTerrainMeshLayer({ id, bbox, elevations, textureUrl, exaggeration, maplibregl }) {
  let map = null;
  let gl = null;
  let program = null;
  let buffers = null;
  let vao = null;
  let texture = null;
  let textureReady = false;
  let currentExag = exaggeration;

  // WebGL2 / GLSL 300 ES (required by MapLibre 5)
  const vs = `#version 300 es
    uniform mat4 u_matrix;
    in vec2 a_pos;
    in float a_elev;
    in vec2 a_uv;
    out vec2 v_uv;
    out float v_elev;
    uniform float u_exag;
    uniform float u_elev_min;
    uniform float u_meter;
    void main() {
      v_uv = a_uv;
      v_elev = a_elev;
      float z = (a_elev - u_elev_min) * u_exag * u_meter;
      gl_Position = u_matrix * vec4(a_pos.x, a_pos.y, z, 1.0);
    }
  `;
  const fs = `#version 300 es
    precision mediump float;
    in vec2 v_uv;
    in float v_elev;
    uniform sampler2D u_tex;
    uniform float u_has_tex;
    uniform float u_elev_min;
    uniform float u_elev_range;
    out vec4 fragColor;
    void main() {
      if (u_has_tex > 0.5) {
        vec4 c = texture(u_tex, v_uv);
        // Keep nearly-transparent crop pixels visible as tinted terrain
        if (c.a < 0.02) {
          float t = clamp((v_elev - u_elev_min) / max(u_elev_range, 1.0), 0.0, 1.0);
          fragColor = vec4(0.15 + t * 0.35, 0.40 + t * 0.35, 0.18, 1.0);
        } else {
          fragColor = vec4(c.rgb, 1.0);
        }
      } else {
        float t = clamp((v_elev - u_elev_min) / max(u_elev_range, 1.0), 0.0, 1.0);
        fragColor = vec4(0.18 + t * 0.45, 0.42 + t * 0.40, 0.20, 1.0);
      }
    }
  `;

  function compile(type, src) {
    const s = gl.createShader(type);
    gl.shaderSource(s, src);
    gl.compileShader(s);
    if (!gl.getShaderParameter(s, gl.COMPILE_STATUS)) {
      console.warn('[terrain] shader', gl.getShaderInfoLog(s));
    }
    return s;
  }

  function buildGeometry() {
    const [w, s, e, n] = bbox;
    const rows = elevations.length;
    const cols = elevations[0]?.length || 0;
    if (!rows || !cols) return null;

    const positions = [];
    const elevs = [];
    const uvs = [];
    const indices = [];
    let elevMin = Infinity;
    let elevMax = -Infinity;
    const midLng = (w + e) / 2;
    const midLat = (s + n) / 2;

    for (let r = 0; r < rows; r++) {
      const lat = n - ((r + 0.5) / rows) * (n - s);
      for (let c = 0; c < cols; c++) {
        const lng = w + ((c + 0.5) / cols) * (e - w);
        const mc = maplibregl.MercatorCoordinate.fromLngLat({ lng, lat });
        positions.push(mc.x, mc.y);
        let el = elevations[r][c];
        if (el == null || Number.isNaN(el)) el = elevMin === Infinity ? 0 : elevMin;
        elevs.push(el);
        if (el < elevMin) elevMin = el;
        if (el > elevMax) elevMax = el;
        uvs.push(c / (cols - 1 || 1), r / (rows - 1 || 1));
      }
    }
    // Replace nulls that were filled before elevMin was known
    for (let i = 0; i < elevs.length; i++) {
      if (elevs[i] == null || Number.isNaN(elevs[i])) elevs[i] = elevMin;
    }
    for (let r = 0; r < rows - 1; r++) {
      for (let c = 0; c < cols - 1; c++) {
        const i = r * cols + c;
        indices.push(i, i + cols, i + 1);
        indices.push(i + 1, i + cols, i + cols + 1);
      }
    }
    const meter = maplibregl.MercatorCoordinate.fromLngLat({ lng: midLng, lat: midLat })
      .meterInMercatorCoordinateUnits();
    return {
      positions,
      elevs,
      uvs,
      indices,
      elevMin: Number.isFinite(elevMin) ? elevMin : 0,
      elevMax: Number.isFinite(elevMax) ? elevMax : 1,
      meter,
    };
  }

  function loadTexture(url) {
    if (!gl || !texture || !url) return;
    const img = new Image();
    img.crossOrigin = 'anonymous';
    img.onload = () => {
      try {
        gl.bindTexture(gl.TEXTURE_2D, texture);
        gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, false);
        gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, img);
        textureReady = true;
        map?.triggerRepaint();
      } catch (err) {
        console.warn('[terrain] texture upload failed', err);
      }
    };
    img.onerror = () => console.warn('[terrain] texture image failed to load');
    img.src = url;
  }

  return {
    id,
    type: 'custom',
    renderingMode: '3d',
    onAdd(m, glCtx) {
      map = m;
      gl = glCtx;
      program = gl.createProgram();
      gl.attachShader(program, compile(gl.VERTEX_SHADER, vs));
      gl.attachShader(program, compile(gl.FRAGMENT_SHADER, fs));
      gl.linkProgram(program);
      if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        console.warn('[terrain] program', gl.getProgramInfoLog(program));
      }

      const geo = buildGeometry();
      if (!geo) return;
      const useUint32 = geo.indices.length > 65535;
      buffers = {
        pos: gl.createBuffer(),
        elev: gl.createBuffer(),
        uv: gl.createBuffer(),
        idx: gl.createBuffer(),
        indexCount: geo.indices.length,
        indexType: useUint32 ? gl.UNSIGNED_INT : gl.UNSIGNED_SHORT,
        elevMin: geo.elevMin,
        elevMax: geo.elevMax,
        meter: geo.meter,
      };
      gl.bindBuffer(gl.ARRAY_BUFFER, buffers.pos);
      gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(geo.positions), gl.STATIC_DRAW);
      gl.bindBuffer(gl.ARRAY_BUFFER, buffers.elev);
      gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(geo.elevs), gl.STATIC_DRAW);
      gl.bindBuffer(gl.ARRAY_BUFFER, buffers.uv);
      gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(geo.uvs), gl.STATIC_DRAW);
      gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, buffers.idx);
      gl.bufferData(
        gl.ELEMENT_ARRAY_BUFFER,
        useUint32 ? new Uint32Array(geo.indices) : new Uint16Array(geo.indices),
        gl.STATIC_DRAW,
      );

      // Own VAO so MapLibre's bound VAO doesn't swallow our attrib pointers
      vao = gl.createVertexArray();
      gl.bindVertexArray(vao);
      const aPos = gl.getAttribLocation(program, 'a_pos');
      const aElev = gl.getAttribLocation(program, 'a_elev');
      const aUv = gl.getAttribLocation(program, 'a_uv');
      gl.bindBuffer(gl.ARRAY_BUFFER, buffers.pos);
      gl.enableVertexAttribArray(aPos);
      gl.vertexAttribPointer(aPos, 2, gl.FLOAT, false, 0, 0);
      gl.bindBuffer(gl.ARRAY_BUFFER, buffers.elev);
      gl.enableVertexAttribArray(aElev);
      gl.vertexAttribPointer(aElev, 1, gl.FLOAT, false, 0, 0);
      gl.bindBuffer(gl.ARRAY_BUFFER, buffers.uv);
      gl.enableVertexAttribArray(aUv);
      gl.vertexAttribPointer(aUv, 2, gl.FLOAT, false, 0, 0);
      gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, buffers.idx);
      gl.bindVertexArray(null);

      texture = gl.createTexture();
      gl.bindTexture(gl.TEXTURE_2D, texture);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, 1, 1, 0, gl.RGBA, gl.UNSIGNED_BYTE, new Uint8Array([55, 120, 45, 255]));

      if (textureUrl) loadTexture(textureUrl);
      map.triggerRepaint();
    },
    render(glCtx, args) {
      if (!program || !buffers || !vao) return;
      gl = glCtx || gl;

      // Official MapLibre 5 custom-layer example uses defaultProjectionData.mainMatrix
      const mvp = args?.defaultProjectionData?.mainMatrix
        || args?.modelViewProjectionMatrix
        || null;
      if (!mvp) {
        console.warn('[terrain] missing projection matrix from MapLibre', args);
        return;
      }

      gl.useProgram(program);
      gl.uniformMatrix4fv(gl.getUniformLocation(program, 'u_matrix'), false, mvp);
      gl.uniform1f(gl.getUniformLocation(program, 'u_exag'), currentExag);
      gl.uniform1f(gl.getUniformLocation(program, 'u_elev_min'), buffers.elevMin || 0);
      gl.uniform1f(gl.getUniformLocation(program, 'u_elev_range'), Math.max(1, (buffers.elevMax || 1) - (buffers.elevMin || 0)));
      gl.uniform1f(gl.getUniformLocation(program, 'u_meter'), buffers.meter || 1e-7);
      gl.uniform1f(gl.getUniformLocation(program, 'u_has_tex'), textureReady ? 1 : 0);

      gl.activeTexture(gl.TEXTURE0);
      gl.bindTexture(gl.TEXTURE_2D, texture);
      gl.uniform1i(gl.getUniformLocation(program, 'u_tex'), 0);

      gl.disable(gl.STENCIL_TEST);
      gl.disable(gl.CULL_FACE);
      gl.enable(gl.DEPTH_TEST);
      gl.depthFunc(gl.LEQUAL);
      gl.depthMask(true);
      gl.enable(gl.BLEND);
      gl.blendFunc(gl.ONE, gl.ONE_MINUS_SRC_ALPHA);

      gl.bindVertexArray(vao);
      gl.drawElements(gl.TRIANGLES, buffers.indexCount, buffers.indexType, 0);
      gl.bindVertexArray(null);
    },
    onRemove() {
      try {
        if (gl && vao) gl.deleteVertexArray(vao);
        if (gl && buffers) {
          gl.deleteBuffer(buffers.pos);
          gl.deleteBuffer(buffers.elev);
          gl.deleteBuffer(buffers.uv);
          gl.deleteBuffer(buffers.idx);
        }
        if (gl && texture) gl.deleteTexture(texture);
        if (gl && program) gl.deleteProgram(program);
      } catch { /* ignore */ }
    },
    updateTexture(url) {
      loadTexture(url);
    },
    setExaggeration(v) {
      currentExag = v;
      map?.triggerRepaint();
    },
  };
}

export default function TerrainViewer({
  fieldId,
  meta,
  elevation,
  soil = [],
  scouts = [],
  height = 480,
  scenarioOverlayUrl = null,
  scenarioHotspots = [],
  selectedHotspot = null,
  onSelectHotspot,
}) {
  const containerRef = useRef(null);
  const mapRef = useRef(null);
  const layerRef = useRef(null);
  const blobUrlsRef = useRef([]);
  const [overlayId, setOverlayId] = useState('rgb');
  const [exaggeration, setExaggeration] = useState(2.5);
  const [pitch, setPitch] = useState(55);
  const [webglFailed, setWebglFailed] = useState(false);
  const [fallback2d, setFallback2d] = useState(false);
  const [status, setStatus] = useState('');
  const [inspector, setInspector] = useState(null);

  const overlayOptions = scenarioOverlayUrl
    ? [...OVERLAYS, { id: 'scenario-risk', label: 'Scenario risk', kind: 'scenario' }]
    : OVERLAYS;

  // Auto-switch to scenario layer when a new overlay arrives
  useEffect(() => {
    if (scenarioOverlayUrl) setOverlayId('scenario-risk');
    else if (overlayId === 'scenario-risk') setOverlayId('rgb');
  }, [scenarioOverlayUrl]); // eslint-disable-line react-hooks/exhaustive-deps

  const cleanupBlobs = () => {
    blobUrlsRef.current.forEach((u) => { try { URL.revokeObjectURL(u); } catch { /* */ } });
    blobUrlsRef.current = [];
  };

  const loadOverlayBlob = useCallback(async (id, signal) => {
    if (id === 'scenario-risk' && scenarioOverlayUrl) {
      return scenarioOverlayUrl;
    }
    const cfg = OVERLAYS.find((o) => o.id === id) || OVERLAYS[0];
    const path = cfg.kind === 'texture'
      ? terrainAssetUrl(fieldId, 'texture', meta?.grid?.width || 128)
      : terrainAssetUrl(fieldId, 'overlay', meta?.grid?.width || 128, cfg.layer);
    const url = await fetchTerrainImageBlob(path, signal);
    blobUrlsRef.current.push(url);
    return url;
  }, [fieldId, meta, scenarioOverlayUrl]);

  // Init map
  useEffect(() => {
    if (!containerRef.current || !meta || !elevation?.values || fallback2d) return undefined;
    let cancelled = false;
    const ctrl = new AbortController();

    (async () => {
      try {
        setStatus('Loading field…');
        const maplibregl = (await import('maplibre-gl')).default;
        await import('maplibre-gl/dist/maplibre-gl.css');
        if (cancelled || !containerRef.current) return;

        const boundary = parseBoundary(meta.boundary);
        const bounds = padBounds(
          boundsFromGeoJSON(boundary) || meta.grid?.bbox,
          0.08,
        );
        if (!bounds) throw new Error('No field bounds');

        const map = new maplibregl.Map({
          container: containerRef.current,
          // Field-only scene: no OSM/Google basemap — just the DEM mesh.
          style: {
            version: 8,
            sources: {},
            layers: [
              {
                id: 'background',
                type: 'background',
                paint: { 'background-color': '#1a2a1c' },
              },
            ],
          },
          bounds,
          fitBoundsOptions: { padding: 56, maxZoom: 18 },
          pitch,
          bearing: -25,
          maxPitch: 75,
          maxTileCacheSize: 16,
          attributionControl: false,
          // MSAA helps custom 3D layers look clean (MapLibre custom-layer docs)
          canvasContextAttributes: { antialias: true },
        });
        map.addControl(new maplibregl.NavigationControl({ visualizePitch: true, showCompass: true }), 'top-right');
        mapRef.current = map;

        map.on('error', (e) => {
          const msg = String(e?.error?.message || e?.error || '');
          console.warn('[terrain map]', msg);
          if (msg.toLowerCase().includes('webgl')) {
            setWebglFailed(true);
            setFallback2d(true);
          }
        });

        await new Promise((resolve) => map.once('load', resolve));
        if (cancelled) return;

        // Field boundary outline so the parcel is always visible
        if (boundary) {
          map.addSource('field-boundary', { type: 'geojson', data: boundary });
          map.addLayer({
            id: 'field-fill',
            type: 'fill',
            source: 'field-boundary',
            paint: { 'fill-color': '#3D6B34', 'fill-opacity': 0.25 },
          });
          map.addLayer({
            id: 'field-line',
            type: 'line',
            source: 'field-boundary',
            paint: { 'line-color': '#B8E986', 'line-width': 2.5 },
          });
        }

        // Point overlays
        const points = {
          type: 'FeatureCollection',
          features: [
            ...soil.filter((s) => s.Latitude != null && s.Longitude != null).map((s) => ({
              type: 'Feature',
              properties: {
                kind: 'soil',
                label: s.SampleLabel || 'Soil sample',
                detail: `pH ${s.pH ?? '—'} · OM ${s.OrganicMatter ?? '—'}%`,
                date: s.SampleDate,
              },
              geometry: { type: 'Point', coordinates: [Number(s.Longitude), Number(s.Latitude)] },
            })),
            ...scouts.filter((s) => s.Latitude != null && s.Longitude != null).map((s) => ({
              type: 'Feature',
              properties: {
                kind: 'scout',
                label: s.Category || 'Scout',
                detail: s.Notes || s.Severity || '',
                date: s.ObservedAt,
              },
              geometry: { type: 'Point', coordinates: [Number(s.Longitude), Number(s.Latitude)] },
            })),
          ],
        };
        map.addSource('field-points', { type: 'geojson', data: points });
        map.addLayer({
          id: 'field-points-circle',
          type: 'circle',
          source: 'field-points',
          paint: {
            'circle-radius': 6,
            'circle-color': [
              'match', ['get', 'kind'],
              'soil', '#D97706',
              'scout', '#DB2777',
              '#6B7280',
            ],
            'circle-stroke-width': 1.5,
            'circle-stroke-color': '#fff',
          },
        });
        map.on('click', 'field-points-circle', (e) => {
          const f = e.features?.[0];
          if (!f) return;
          setInspector({
            title: f.properties.label,
            body: f.properties.detail,
            date: f.properties.date,
            kind: f.properties.kind,
          });
        });
        map.on('mouseenter', 'field-points-circle', () => { map.getCanvas().style.cursor = 'pointer'; });
        map.on('mouseleave', 'field-points-circle', () => { map.getCanvas().style.cursor = ''; });

        setStatus('Building field surface…');
        let texUrl = null;
        try {
          texUrl = await loadOverlayBlob(overlayId, ctrl.signal);
        } catch (texErr) {
          console.warn('[terrain] texture fetch failed, showing elevation colors', texErr);
        }
        if (cancelled) return;

        const layer = createTerrainMeshLayer({
          id: 'field-terrain-mesh',
          bbox: meta.grid?.bbox || bounds,
          elevations: elevation.values,
          textureUrl: texUrl,
          exaggeration,
          maplibregl,
        });
        map.addLayer(layer);
        layerRef.current = layer;
        map.triggerRepaint();
        // Keep rendering a few frames so the mesh + texture settle
        let frames = 0;
        const kick = () => {
          map.triggerRepaint();
          if (++frames < 30) requestAnimationFrame(kick);
        };
        requestAnimationFrame(kick);
        setStatus('');
      } catch (err) {
        console.error(err);
        setWebglFailed(true);
        setFallback2d(true);
        setStatus(String(err.message || err));
      }
    })();

    return () => {
      cancelled = true;
      ctrl.abort();
      cleanupBlobs();
      try {
        if (mapRef.current) {
          mapRef.current.remove();
          mapRef.current = null;
        }
      } catch { /* */ }
      layerRef.current = null;
    };
    // Re-init only when field/meta/elevation identity changes
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [fieldId, meta, elevation, fallback2d]);

  // Overlay / exaggeration updates without full remount
  useEffect(() => {
    if (!mapRef.current || !layerRef.current || !meta) return undefined;
    const ctrl = new AbortController();
    (async () => {
      try {
        const url = await loadOverlayBlob(overlayId, ctrl.signal);
        layerRef.current.updateTexture?.(url);
      } catch { /* ignore abort */ }
    })();
    return () => ctrl.abort();
  }, [overlayId, loadOverlayBlob, meta, scenarioOverlayUrl]);

  // Hotspot markers for scenario results
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !map.isStyleLoaded?.()) return undefined;
    const fc = {
      type: 'FeatureCollection',
      features: (scenarioHotspots || []).map((h, i) => ({
        type: 'Feature',
        properties: {
          kind: 'hotspot',
          label: `Risk hotspot #${i + 1}`,
          detail: `Relative risk ${h.risk} (${h.band}) — modeled screening`,
          risk: h.risk,
          band: h.band,
          row: h.row,
          col: h.col,
        },
        geometry: { type: 'Point', coordinates: [h.longitude, h.latitude] },
      })),
    };
    try {
      if (map.getSource('scenario-hotspots')) {
        map.getSource('scenario-hotspots').setData(fc);
      } else if (scenarioHotspots?.length) {
        map.addSource('scenario-hotspots', { type: 'geojson', data: fc });
        map.addLayer({
          id: 'scenario-hotspots-circle',
          type: 'circle',
          source: 'scenario-hotspots',
          paint: {
            'circle-radius': 7,
            'circle-color': '#DC2626',
            'circle-stroke-width': 2,
            'circle-stroke-color': '#fff',
          },
        });
        map.on('click', 'scenario-hotspots-circle', (e) => {
          const f = e.features?.[0];
          if (!f) return;
          const p = f.properties || {};
          onSelectHotspot?.({
            row: Number(p.row),
            col: Number(p.col),
            latitude: f.geometry.coordinates[1],
            longitude: f.geometry.coordinates[0],
            risk: Number(p.risk),
            band: p.band,
          });
          setInspector({
            kind: 'hotspot',
            title: p.label,
            body: p.detail,
          });
        });
      }
    } catch { /* map may be tearing down */ }
    return undefined;
  }, [scenarioHotspots, onSelectHotspot, meta, elevation]);

  useEffect(() => {
    layerRef.current?.setExaggeration?.(exaggeration);
  }, [exaggeration]);

  useEffect(() => {
    mapRef.current?.easeTo({ pitch, duration: 400 });
  }, [pitch]);

  const resetCamera = () => {
    const bounds = padBounds(
      boundsFromGeoJSON(parseBoundary(meta?.boundary)) || meta?.grid?.bbox,
      0.12,
    );
    if (bounds && mapRef.current) {
      mapRef.current.fitBounds(bounds, { padding: 40, pitch: 55, bearing: -20, duration: 600 });
      setPitch(55);
    }
  };

  const elevSummary = meta?.elevation?.summary;
  const slopeSummary = meta?.slope;

  if (fallback2d) {
    return (
      <div className="space-y-3" role="region" aria-label="Terrain 2D fallback">
        <div className="bg-amber-50 border border-amber-200 text-amber-900 rounded-lg p-3 text-sm font-mont">
          {webglFailed
            ? 'WebGL 3D view unavailable on this device — showing elevation summary instead.'
            : 'Showing 2D fallback.'}
          {' '}
          <button type="button" className="underline font-semibold" onClick={() => { setFallback2d(false); setWebglFailed(false); }}>
            Retry 3D
          </button>
        </div>
        <TerrainSummaryCard meta={meta} elevSummary={elevSummary} slopeSummary={slopeSummary} />
        {scenarioOverlayUrl && overlayId === 'scenario-risk' ? (
          <div className="rounded-xl overflow-hidden border border-gray-200" style={{ height: 280 }}>
            <img src={scenarioOverlayUrl} alt="Scenario water-risk overlay" className="w-full h-full object-contain bg-gray-50" />
            <p className="text-[11px] font-mont text-amber-800 bg-amber-50 px-2 py-1">Modeled relative water-risk (2D fallback)</p>
          </div>
        ) : elevation?.values ? (
          <ElevationHeatmap values={elevation.values} height={280} />
        ) : null}
      </div>
    );
  }

  return (
    <div className="space-y-3" role="region" aria-label="3D terrain viewer">
      {/* Controls */}
      <div className="flex flex-wrap gap-2 items-center">
        <span className="text-xs font-semibold font-mont text-gray-500 mr-1">Texture</span>
        {overlayOptions.map((o) => {
          const available = o.id === 'scenario-risk'
            ? Boolean(scenarioOverlayUrl)
            : o.id === 'rgb'
              ? meta?.texture?.available !== false
              : (meta?.overlays_available || []).includes(o.id) || (meta?.overlays_available || []).includes(o.layer);
          return (
            <button
              key={o.id}
              type="button"
              disabled={!available && o.id !== 'rgb'}
              aria-pressed={overlayId === o.id}
              onClick={() => setOverlayId(o.id)}
              className="px-2.5 py-1.5 rounded-full text-xs font-mont font-semibold border transition-all disabled:opacity-40"
              style={{
                background: overlayId === o.id ? (o.id === 'scenario-risk' ? '#DC2626' : '#6D8E22') : 'white',
                borderColor: overlayId === o.id ? (o.id === 'scenario-risk' ? '#DC2626' : '#6D8E22') : '#E5E7EB',
                color: overlayId === o.id ? 'white' : '#6B7280',
              }}
            >
              {o.label}
            </button>
          );
        })}
      </div>

      <div className="flex flex-wrap gap-4 items-center text-xs font-mont text-gray-600">
        <label className="flex items-center gap-2">
          Exaggeration
          <input
            type="range" min="0.5" max="6" step="0.1"
            value={exaggeration}
            onChange={(e) => setExaggeration(Number(e.target.value))}
            aria-label="Vertical exaggeration"
          />
          <span className="font-mono w-8">{exaggeration.toFixed(1)}×</span>
        </label>
        <label className="flex items-center gap-2">
          Pitch
          <input
            type="range" min="0" max="70" step="1"
            value={pitch}
            onChange={(e) => setPitch(Number(e.target.value))}
            aria-label="Camera pitch"
          />
        </label>
        <button type="button" onClick={resetCamera}
          className="px-3 py-1.5 rounded-lg border border-gray-300 font-semibold hover:bg-gray-50">
          Reset camera
        </button>
        <button type="button" onClick={() => setFallback2d(true)}
          className="px-3 py-1.5 rounded-lg border border-gray-300 font-semibold hover:bg-gray-50">
          View as 2D
        </button>
      </div>

      <div
        ref={containerRef}
        className="w-full rounded-xl overflow-hidden border border-gray-200 bg-gray-100 relative"
        style={{ height: `min(${height}px, 70vh)`, minHeight: 320 }}
      />
      {status && (
        <p className="font-mont text-xs text-gray-400 animate-pulse" aria-live="polite">{status}</p>
      )}

      <TerrainSummaryCard meta={meta} elevSummary={elevSummary} slopeSummary={slopeSummary} />

      {inspector && (
        <div className="bg-white border border-gray-200 rounded-lg p-3 text-sm font-mont">
          <div className="flex justify-between">
            <span className="font-semibold text-gray-800">
              {inspector.kind === 'soil' ? 'Soil sample'
                : inspector.kind === 'hotspot' ? 'Modeled hotspot'
                  : 'Scouting'} — {inspector.title}
            </span>
            <button type="button" className="text-gray-400 hover:text-gray-700" onClick={() => setInspector(null)}>✕</button>
          </div>
          <p className="text-gray-600 mt-1">{inspector.body}</p>
          {inspector.date && <p className="text-xs text-gray-400 mt-1">{String(inspector.date).slice(0, 10)}</p>}
          <p className="text-[11px] text-gray-400 mt-1">
            {inspector.kind === 'hotspot'
              ? 'Modeled screening location — not a measured flood depth.'
              : 'Observation point — not satellite-derived.'}
          </p>
        </div>
      )}

      <div className="bg-slate-50 border border-slate-200 rounded-lg p-3 text-[11px] font-mont text-slate-600 space-y-1">
        <p className="font-semibold text-slate-700">Field-only view · data provenance</p>
        <p>
          Camera is locked to this field&apos;s boundary — no Google/OSM basemap.
          Elevation: {meta?.elevation?.source || '—'} (~{meta?.elevation?.native_resolution_m || 30} m,
          {' '}{meta?.elevation?.vertical_datum || 'EGM2008'}). Surface may include vegetation/structures.
        </p>
        <p>
          Default texture: Sentinel-2 crop / natural color
          {meta?.texture?.acquired_at ? ` · ${meta.texture.acquired_at}` : ''}.
          NDVI/RVI show relative canopy response — not a diagnosis.
        </p>
        <p>
          Wetness risk and the storm simulator are topographic screening only (not measured flood depth).
        </p>
      </div>
    </div>
  );
}

function TerrainSummaryCard({ meta, elevSummary, slopeSummary }) {
  return (
    <div className="grid grid-cols-2 sm:grid-cols-4 gap-2" aria-label="Elevation and slope summary">
      {[
        { label: 'Min elev', value: elevSummary?.min != null ? `${elevSummary.min} m` : '—' },
        { label: 'Max elev', value: elevSummary?.max != null ? `${elevSummary.max} m` : '—' },
        { label: 'Relief', value: elevSummary?.relief != null ? `${elevSummary.relief} m` : '—' },
        { label: 'Mean slope', value: slopeSummary?.mean != null ? `${slopeSummary.mean}°` : '—' },
      ].map((s) => (
        <div key={s.label} className="bg-gray-50 border border-gray-100 rounded-lg px-3 py-2">
          <div className="text-[10px] uppercase text-gray-400 font-mont">{s.label}</div>
          <div className="font-lora text-lg font-bold text-gray-800">{s.value}</div>
        </div>
      ))}
      {meta?.crop_type && (
        <div className="col-span-2 sm:col-span-4 text-xs font-mont text-gray-500">
          Field: <span className="font-semibold text-gray-700">{meta.field_name || '—'}</span>
          {' · '}Crop: <span className="font-semibold text-gray-700">{meta.crop_type}</span>
          {' · '}Grid: {meta.grid?.width}×{meta.grid?.height}
          {' · '}~{meta.grid?.resolution_m_approx} m/cell
        </div>
      )}
    </div>
  );
}

function ElevationHeatmap({ values, height }) {
  const rows = values.length;
  const cols = values[0]?.length || 0;
  let min = Infinity; let max = -Infinity;
  values.forEach((row) => row.forEach((v) => {
    if (v != null && !Number.isNaN(v)) {
      if (v < min) min = v;
      if (v > max) max = v;
    }
  }));
  if (!Number.isFinite(min)) return null;
  const cW = 100 / cols; const cH = 100 / rows;
  return (
    <svg viewBox="0 0 100 100" preserveAspectRatio="none" className="w-full rounded-xl border border-gray-200" style={{ height }} aria-label="Elevation heatmap">
      {values.flatMap((row, r) => row.map((v, c) => {
        if (v == null || Number.isNaN(v)) {
          return <rect key={`${r}-${c}`} x={c * cW} y={r * cH} width={cW + 0.1} height={cH + 0.1} fill="#F3F4F6" />;
        }
        const t = (v - min) / (max - min || 1);
        const color = `rgb(${Math.round(40 + t * 180)},${Math.round(120 - t * 40)},${Math.round(80 - t * 40)})`;
        return <rect key={`${r}-${c}`} x={c * cW} y={r * cH} width={cW + 0.1} height={cH + 0.1} fill={color} />;
      }))}
    </svg>
  );
}
