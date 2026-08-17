/**
 * Field Twin — React integration tests (network mocked, full UI chrome).
 */
import React from 'react';
import {
  describe, it, expect, vi, beforeEach, afterEach,
} from 'vitest';
import {
  render, screen, waitFor,
} from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { makeSnapshot, ELEVATION_JSON } from './fixtures.js';
import { NO_BOUNDARY_ERROR } from '../snapshotSchema.js';

vi.mock('@react-three/fiber', async () => {
  const React = await import('react');
  return {
    Canvas: ({ children }) => React.createElement('div', { 'data-testid': 'r3f-canvas' }, children),
    useFrame: () => {},
    useThree: () => ({
      clock: { elapsedTime: 0 },
      camera: {},
      gl: { setClearColor: () => {}, toneMapping: 0, toneMappingExposure: 1 },
      size: { width: 800, height: 600 },
    }),
  };
});

vi.mock('@react-three/drei', async () => {
  const React = await import('react');
  const Stub = () => null;
  return {
    OrbitControls: Stub,
    PerspectiveCamera: Stub,
    ContactShadows: Stub,
    Sky: Stub,
    Stars: Stub,
    Cloud: Stub,
    Html: ({ children }) => React.createElement('div', { 'data-testid': 'r3f-html' }, children),
  };
});

vi.mock('../Atmosphere.jsx', () => ({ default: () => null }));
vi.mock('../TerrainMesh.jsx', () => ({ default: () => null }));
vi.mock('../CropCanopy.jsx', () => ({ default: () => null }));
vi.mock('../ScenarioStormFx.jsx', () => ({ default: () => null }));
vi.mock('../Observations.jsx', () => ({ default: () => null }));
vi.mock('../ScenarioHotspots.jsx', () => ({ default: () => null }));
vi.mock('../SoilCutaway.jsx', () => ({
  default: () => null,
  filterLocatedSoilSamples: (soilSamples = []) => (
    (soilSamples || []).filter((s) => s.latitude != null && s.longitude != null)
  ),
  SOIL_SAMPLE_INFLUENCE_M: 30,
}));
vi.mock('../TwinInspector.jsx', async () => {
  const React = await import('react');
  return {
    default: function TwinInspectorStub() {
      return React.createElement('div', { 'data-testid': 'twin-inspector' }, 'Inspector');
    },
  };
});
vi.mock('../../terrain/TerrainViewer.jsx', async () => {
  const React = await import('react');
  return {
    default: function TerrainViewerStub() {
      return React.createElement('div', { 'data-testid': 'maplibre-terrain-viewer' }, 'MapLibre');
    },
  };
});
vi.mock('../../terrain/useTerrainData.js', () => ({
  useTerrainData: () => ({
    meta: { field_id: 36 },
    elevation: ELEVATION_JSON,
    soil: [],
    scouts: [],
    loading: false,
    error: null,
  }),
  fetchTerrainImageBlob: async () => 'blob:mock-texture',
}));

vi.mock('../BoundaryDrawMap.jsx', async () => {
  const React = await import('react');
  return {
    default: function BoundaryDrawMapStub({ onPolygon }) {
      return React.createElement(
        'div',
        { 'data-testid': 'twin-boundary-draw-map' },
        React.createElement(
          'button',
          {
            type: 'button',
            'data-testid': 'twin-boundary-draw-stub',
            onClick: () => onPolygon?.(
              {
                type: 'Polygon',
                coordinates: [[
                  [-93.51, 41.49], [-93.49, 41.49], [-93.49, 41.51], [-93.51, 41.51], [-93.51, 41.49],
                ]],
              },
              { lat: 41.5, lng: -93.5 },
            ),
          },
          'Stub draw polygon',
        ),
      );
    },
  };
});

import FieldTwinViewer from '../FieldTwinViewer.jsx';

function jsonResponse(body, status = 200) {
  return {
    ok: status >= 200 && status < 300,
    status,
    json: async () => body,
    text: async () => (typeof body === 'string' ? body : JSON.stringify(body)),
    blob: async () => new Blob(['x'], { type: 'image/png' }),
  };
}

function installWebglOk() {
  HTMLCanvasElement.prototype.getContext = vi.fn((type) => {
    if (type === 'webgl' || type === 'webgl2') {
      return { getExtension: () => null, getParameter: () => 'Fake GPU' };
    }
    return null;
  });
}

function installWebglFail() {
  HTMLCanvasElement.prototype.getContext = vi.fn(() => null);
}

function renderTwin(ui) {
  return render(<MemoryRouter>{ui}</MemoryRouter>);
}

describe('FieldTwinViewer restored UI', () => {
  let fetchMock;

  beforeEach(() => {
    installWebglOk();
    localStorage.setItem('access_token', 'test-token');
    fetchMock = vi.fn(async (url) => {
      const u = String(url);
      if (u.includes('/twin-snapshot')) return jsonResponse(makeSnapshot());
      if (u.includes('/terrain/elevation')) return jsonResponse(ELEVATION_JSON);
      if (u.includes('/terrain/texture') || u.includes('/terrain/overlay')) {
        return {
          ok: true,
          status: 200,
          blob: async () => new Blob(['x'], { type: 'image/png' }),
          json: async () => ({}),
          text: async () => '',
        };
      }
      return jsonResponse({ detail: `unmocked ${u}` }, 404);
    });
    globalThis.fetch = fetchMock;
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('shows full chrome: inspector, canopy, soil, focus, orbit', async () => {
    renderTwin(<FieldTwinViewer fieldId={36} fieldName="North Forty" height={400} />);

    expect(await screen.findByTestId('field-twin-canvas-wrap')).toBeInTheDocument();
    expect(screen.getByTestId('twin-inspector')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Canopy on|Canopy off/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Soil profile/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Focus view|Exit focus/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Orbit|Close orbit/i })).toBeInTheDocument();
    expect(screen.queryByText(/WebGL is unavailable/i)).not.toBeInTheDocument();
  });

  it('WebGL unavailable silently mounts MapLibre', async () => {
    installWebglFail();
    renderTwin(<FieldTwinViewer fieldId={36} fieldName="North Forty" height={400} />);
    expect(await screen.findByTestId('twin-maplibre-fallback')).toBeInTheDocument();
    expect(screen.queryByText(/WebGL is unavailable/i)).not.toBeInTheDocument();
  });

  it('shows inline boundary map when snapshot has coords but no polygon', async () => {
    fetchMock.mockImplementation(async (url) => {
      const u = String(url);
      if (u.includes('/twin-snapshot')) {
        return jsonResponse({
          ...makeSnapshot(),
          field: {
            ...makeSnapshot().field,
            boundary: null,
            address: '123 Farm Rd',
            latitude: 41.5,
            longitude: -93.5,
          },
          terrain: { ...makeSnapshot().terrain, boundary: null },
          availability: { boundary: false },
        });
      }
      return jsonResponse({ detail: 'skip' }, 404);
    });
    renderTwin(<FieldTwinViewer fieldId={36} businessId={1} height={400} />);
    expect(await screen.findByTestId('twin-boundary-required')).toBeInTheDocument();
    expect(screen.getByText(NO_BOUNDARY_ERROR)).toBeInTheDocument();
    expect(screen.getByTestId('twin-boundary-draw-map')).toBeInTheDocument();
    expect(screen.getByTestId('twin-boundary-save')).toBeDisabled();
    expect(screen.getByText(/Open Field Detail instead/i)).toBeInTheDocument();
  });

  it('falls back to Field Detail link when no coords or address', async () => {
    fetchMock.mockImplementation(async (url) => {
      const u = String(url);
      if (u.includes('/twin-snapshot')) {
        return jsonResponse({
          ...makeSnapshot(),
          field: {
            ...makeSnapshot().field,
            boundary: null,
            address: null,
            latitude: null,
            longitude: null,
          },
          local_origin: { crs: 'local-meters-from-wgs84', latitude: null, longitude: null },
          terrain: { ...makeSnapshot().terrain, boundary: null },
          availability: { boundary: false },
        });
      }
      return jsonResponse({ detail: 'skip' }, 404);
    });
    renderTwin(<FieldTwinViewer fieldId={36} businessId={1} height={400} />);
    expect(await screen.findByText(/Boundary required for Field Twin/i)).toBeInTheDocument();
    expect(screen.queryByTestId('twin-boundary-draw-map')).not.toBeInTheDocument();
    expect(screen.getByText(/Open Field Detail to draw boundary/i)).toBeInTheDocument();
  });

  it('saves drawn boundary then reloads twin snapshot', async () => {
    let snapCalls = 0;
    fetchMock.mockImplementation(async (url, opts = {}) => {
      const u = String(url);
      if (u.includes('/twin-snapshot')) {
        snapCalls += 1;
        if (snapCalls === 1) {
          return jsonResponse({
            ...makeSnapshot(),
            field: {
              ...makeSnapshot().field,
              boundary: null,
              address: '123 Farm Rd',
              latitude: 41.5,
              longitude: -93.5,
            },
            terrain: { ...makeSnapshot().terrain, boundary: null },
            availability: { boundary: false },
          });
        }
        return jsonResponse(makeSnapshot());
      }
      if (opts.method === 'PUT' && u.includes('/api/fields/36')) {
        return jsonResponse({ id: 36, name: 'North Forty' });
      }
      if (u.includes('/terrain/elevation')) return jsonResponse(ELEVATION_JSON);
      if (u.includes('/overlay/ndvi') && u.includes('format=json')) {
        return jsonResponse({ values: [[0.4]], rows: 1, cols: 1, bbox: [-93.51, 41.49, -93.49, 41.51] });
      }
      if (u.includes('/terrain/texture')) return jsonResponse('x');
      return jsonResponse({ detail: 'skip' }, 404);
    });

    const drawBtn = screen.getByTestId('twin-boundary-draw-stub');
    drawBtn.click();
    const saveBtn = screen.getByTestId('twin-boundary-save');
    expect(saveBtn).not.toBeDisabled();
    saveBtn.click();

    await waitFor(() => {
      expect(fetchMock.mock.calls.some(([url, opts]) => (
        String(url).includes('/api/fields/36') && opts?.method === 'PUT'
      ))).toBe(true);
    });
    expect(await screen.findByTestId('field-twin-canvas-wrap')).toBeInTheDocument();
  });
});
