import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useFields, API_URL, calcHaFromGeojson } from './precisionAgUtils';

// Lazy-load Leaflet + leaflet-draw to avoid SSR issues
let L = null;
async function getLeaflet() {
  if (L) return L;
  L = await import('leaflet');
  await import('leaflet-draw');
  return L;
}

export default function PrecisionAgBoundaryMap() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const fields = useFields(BusinessID);
  const [selectedFieldId, setSelectedFieldId] = useState('');
  const [fieldData, setFieldData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  const mapRef   = useRef(null);
  const mapInst  = useRef(null);
  const drawnRef = useRef(null);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  useEffect(() => {
    if (fields.length > 0 && !selectedFieldId)
      setSelectedFieldId(String(fields[0].fieldid || fields[0].id));
  }, [fields]);

  const loadBoundary = useCallback(async () => {
    if (!selectedFieldId) return;
    setLoading(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/boundary`);
      setFieldData(r.ok ? await r.json() : null);
    } catch { setFieldData(null); }
    setLoading(false);
  }, [selectedFieldId]);

  useEffect(() => { loadBoundary(); setSaved(false); }, [loadBoundary]);

  // Initialize / update map when fieldData changes
  useEffect(() => {
    if (!mapRef.current || loading) return;
    let mounted = true;

    getLeaflet().then(LLib => {
      if (!mounted || !mapRef.current) return;
      const Lf = LLib.default || LLib;

      // destroy old map
      if (mapInst.current) {
        mapInst.current.remove();
        mapInst.current = null;
      }

      const lat = fieldData?.latitude  ?? 39.5;
      const lon = fieldData?.longitude ?? -98.35;
      const zoom = fieldData?.boundary ? 14 : 12;

      const map = Lf.map(mapRef.current, { zoomControl: true }).setView([lat, lon], zoom);
      mapInst.current = map;

      Lf.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors',
        maxZoom: 19,
      }).addTo(map);

      // Draw controls
      const drawnItems = new Lf.FeatureGroup();
      map.addLayer(drawnItems);
      drawnRef.current = drawnItems;

      const drawControl = new Lf.Control.Draw({
        edit: { featureGroup: drawnItems },
        draw: {
          polygon:   { shapeOptions: { color: '#6D8E22', fillOpacity: 0.2 } },
          rectangle: { shapeOptions: { color: '#6D8E22', fillOpacity: 0.2 } },
          polyline:  false,
          circle:    false,
          marker:    false,
          circlemarker: false,
        },
      });
      map.addControl(drawControl);

      // Load existing boundary
      if (fieldData?.boundary) {
        try {
          const layer = Lf.geoJSON(fieldData.boundary, {
            style: { color: '#6D8E22', weight: 2, fillOpacity: 0.15 },
          });
          layer.addTo(drawnItems);
          map.fitBounds(layer.getBounds(), { padding: [30, 30] });
        } catch (err) {
          console.warn('Could not parse boundary GeoJSON', err);
        }
      }

      // Draw events
      map.on(Lf.Draw.Event.CREATED, (e) => {
        drawnItems.clearLayers();
        drawnItems.addLayer(e.layer);
      });
    });

    return () => { mounted = false; };
  }, [fieldData, loading]);

  // Cleanup on unmount
  useEffect(() => () => { if (mapInst.current) { mapInst.current.remove(); mapInst.current = null; } }, []);

  const saveBoundary = async () => {
    if (!drawnRef.current) return;
    setSaving(true);
    try {
      const layers = drawnRef.current.getLayers();
      if (layers.length === 0) {
        alert('Draw a boundary on the map first.');
        setSaving(false);
        return;
      }
      const geojson = layers[0].toGeoJSON().geometry;
      const ha = calcHaFromGeojson(geojson);
      const body = { boundary: geojson };
      if (ha) body.field_size_hectares = parseFloat(ha.toFixed(2));

      const r = await fetch(`${API_URL}/api/fields/${selectedFieldId}/boundary`, {
        method: 'PUT', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
      });
      if (r.ok) {
        setSaved(true);
        loadBoundary();
      } else {
        alert('Save failed: ' + (await r.text()));
      }
    } finally { setSaving(false); }
  };

  const clearBoundary = async () => {
    if (!confirm('Remove this field boundary?')) return;
    await fetch(`${API_URL}/api/fields/${selectedFieldId}/boundary`, {
      method: 'PUT', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ boundary: null }),
    });
    loadBoundary();
    setSaved(false);
  };

  const selectedField = fields.find(f => String(f.fieldid||f.id) === selectedFieldId);
  const ha = fieldData?.boundary ? calcHaFromGeojson(fieldData.boundary) : null;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={localStorage.getItem('people_id')}
      pageTitle="Boundary Map" breadcrumbs={[{ label:'Dashboard', to:'/dashboard' }, { label:'Precision Ag' }, { label:'Boundary Map' }]}>
      {/* Leaflet CSS */}
      <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
      <link rel="stylesheet" href="https://unpkg.com/leaflet-draw@1.0.4/dist/leaflet.draw.css" />

      <div className="max-w-full mx-auto space-y-5">
        <div className="flex items-start justify-between flex-wrap gap-3">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900 mb-1">Field Boundary Map</h1>
            <p className="font-mont text-sm text-gray-500">
              Draw or update your field boundary. Used to improve zoning accuracy and area calculations.
            </p>
          </div>
          <div className="flex gap-2">
            {fieldData?.boundary && (
              <button onClick={clearBoundary}
                className="px-4 py-2 text-sm font-mont text-red-600 border border-red-200 rounded-lg hover:bg-red-50">
                Clear Boundary
              </button>
            )}
            <button onClick={saveBoundary} disabled={saving}
              className="px-5 py-2 bg-[#6D8E22] text-white text-sm font-mont font-semibold rounded-lg hover:bg-[#5a7519] disabled:opacity-50">
              {saving ? 'Saving…' : saved ? '✓ Saved' : 'Save Boundary'}
            </button>
          </div>
        </div>

        {/* Field selector */}
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex gap-4 flex-wrap items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs font-semibold font-mont text-gray-500">Field</label>
            <select value={selectedFieldId} onChange={e => setSelectedFieldId(e.target.value)}
              className="border border-gray-300 rounded-lg text-sm font-mont px-3 py-2 min-w-52">
              {fields.map(f => <option key={f.fieldid||f.id} value={String(f.fieldid||f.id)}>{f.name}</option>)}
            </select>
          </div>
          {ha && (
            <div className="font-mont text-sm text-gray-500 self-end pb-2">
              Area: <strong>{ha.toFixed(2)} ha</strong> ({(ha * 2.47105).toFixed(1)} ac)
            </div>
          )}
          {fieldData?.boundary && !ha && (
            <div className="font-mont text-xs text-gray-400 self-end pb-2">Boundary saved</div>
          )}
        </div>

        {/* Instructions */}
        <div className="bg-[#6D8E22]/5 border border-[#6D8E22]/20 rounded-xl p-4 font-mont text-xs text-gray-600 space-y-1">
          <p><strong>To draw a boundary:</strong> Use the polygon tool (pentagon icon) in the top-left toolbar of the map.</p>
          <p><strong>To edit:</strong> Use the edit tool (pencil icon) to adjust existing boundary points.</p>
          <p><strong>To delete:</strong> Use the trash icon to remove a drawn shape, then draw a new one.</p>
          <p className="text-gray-400">Click <strong>Save Boundary</strong> above after drawing to persist your changes.</p>
        </div>

        {/* Map */}
        <div className="bg-white rounded-xl border border-gray-200 overflow-hidden" style={{ height: 520 }}>
          {loading ? (
            <div className="h-full flex items-center justify-center text-gray-400 font-mont text-sm animate-pulse">
              Loading map…
            </div>
          ) : (
            <div ref={mapRef} style={{ width: '100%', height: '100%' }} />
          )}
        </div>
      </div>
    </AccountLayout>
  );
}
