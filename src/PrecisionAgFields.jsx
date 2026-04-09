import React, { useState, useEffect, useRef } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import 'leaflet/dist/leaflet.css';
import 'leaflet-draw/dist/leaflet.draw.css';
import L from 'leaflet';
import 'leaflet-draw';

// Fix Leaflet default marker icons broken by Vite/Webpack
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
  iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
  shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
});

const API_URL = import.meta.env.VITE_API_URL;

// ─── API helpers ──────────────────────────────────────────────────────────────

async function getFields(businessId) {
  const res = await fetch(`${API_URL}/api/fields?business_id=${businessId}`);
  if (!res.ok) throw new Error('Failed to load fields');
  return res.json();
}

async function createField(data) {
  const res = await fetch(`${API_URL}/api/fields`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data),
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw new Error(err.detail || 'Failed to create field');
  }
  return res.json();
}

async function updateField(fieldId, data) {
  const res = await fetch(`${API_URL}/api/fields/${fieldId}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data),
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw new Error(err.detail || 'Failed to update field');
  }
  return res.json();
}

// ─── CreateFieldView ──────────────────────────────────────────────────────────

function CreateFieldView({ businessId, onBack, onCreated, initialLat, initialLon }) {
  const [formData, setFormData] = useState({
    name: '',
    address: '',
    latitude: initialLat || '',
    longitude: initialLon || '',
    field_size_hectares: '',
    crop_type: '',
    planting_date: '',
    boundary_geojson: '',
    monitoring_interval_days: 5,
    alert_threshold_health: 50,
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const mapRef = useRef(null);
  const drawnItemsRef = useRef(null);
  const mapContainerRef = useRef(null);

  // Reverse geocode coordinates to fill address when coming from CropDetection
  useEffect(() => {
    if (!initialLat || !initialLon || formData.address) return;
    fetch(
      `https://nominatim.openstreetmap.org/reverse?format=json&lat=${initialLat}&lon=${initialLon}&zoom=14&addressdetails=1`,
      { headers: { 'User-Agent': 'OatmealFarmNetwork/1.0' } }
    )
      .then(r => r.json())
      .then(data => {
        if (data?.address) {
          const a = data.address;
          const parts = [a.road, a.city || a.town || a.village || a.county, a.state, a.postcode].filter(Boolean);
          setFormData(prev => ({ ...prev, address: parts.join(', ') }));
        }
      })
      .catch(() => {});
  }, [initialLat, initialLon]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await createField({ ...formData, business_id: businessId });
      onCreated();
    } catch (err) {
      setError(err.message || 'Failed to create field. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (mapRef.current) return;

    const mapCenter = (initialLat && initialLon)
      ? [parseFloat(initialLat), parseFloat(initialLon)]
      : [37.5, -121.9];
    const map = L.map(mapContainerRef.current).setView(mapCenter, 14);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '© OpenStreetMap contributors',
    }).addTo(map);

    const drawnItems = new L.FeatureGroup();
    map.addLayer(drawnItems);
    drawnItemsRef.current = drawnItems;

    const drawControl = new L.Control.Draw({
      draw: {
        polygon: true,
        rectangle: true,
        circle: false,
        marker: false,
        polyline: false,
        circlemarker: false,
      },
      edit: { featureGroup: drawnItems },
    });
    map.addControl(drawControl);

    map.on(L.Draw.Event.CREATED, (e) => {
      drawnItems.clearLayers();
      drawnItems.addLayer(e.layer);

      const geojson = e.layer.toGeoJSON().geometry;
      const center = e.layer.getBounds().getCenter();

      setFormData((prev) => ({
        ...prev,
        boundary_geojson: JSON.stringify(geojson),
        latitude: center.lat.toFixed(6),
        longitude: center.lng.toFixed(6),
      }));
    });

    mapRef.current = map;

    return () => {
      map.remove();
      mapRef.current = null;
    };
  }, []);

  const inputClass =
    'w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#6D8E22] focus:border-transparent transition';

  const labelClass = 'block text-sm font-medium text-gray-700 mb-1';

  return (
    <div className="pb-16">
      <button
        onClick={onBack}
        className="mb-6 text-green-600 hover:text-green-700 font-medium flex items-center gap-1"
      >
        ← Back to Fields
      </button>

      <div className="bg-white rounded-lg shadow-sm p-8">
        <h2 className="text-2xl font-bold text-gray-900 mb-6">Add New Field</h2>

        {error && (
          <div className="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Field Name */}
          <div>
            <label className={labelClass}>Field Name</label>
            <input
              type="text"
              name="name"
              value={formData.name}
              onChange={handleChange}
              required
              placeholder="e.g. North Pasture"
              className={inputClass}
            />
          </div>

          {/* Address */}
          <div>
            <label className={labelClass}>Address</label>
            <input
              type="text"
              name="address"
              value={formData.address}
              onChange={handleChange}
              placeholder="Street address or nearest town"
              className={inputClass}
            />
          </div>

          {/* Lat / Lng */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className={labelClass}>Latitude</label>
              <input
                type="number"
                step="any"
                name="latitude"
                value={formData.latitude}
                onChange={handleChange}
                placeholder="Auto-filled from map"
                className={inputClass}
              />
            </div>
            <div>
              <label className={labelClass}>Longitude</label>
              <input
                type="number"
                step="any"
                name="longitude"
                value={formData.longitude}
                onChange={handleChange}
                placeholder="Auto-filled from map"
                className={inputClass}
              />
            </div>
          </div>

          {/* Map */}
          <div>
            <label className={labelClass}>
              Draw Field Boundary{' '}
              <span className="text-gray-400 font-normal">(use the polygon or rectangle tool)</span>
            </label>
            <div
              ref={mapContainerRef}
              style={{ height: '320px', width: '100%' }}
              className="rounded-lg border border-gray-200 z-0"
            />
            {formData.boundary_geojson && (
              <p className="mt-1 text-xs text-green-700 font-medium">
                ✓ Boundary captured — centre set to {formData.latitude}, {formData.longitude}
              </p>
            )}
          </div>

          {/* Field Size & Crop */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className={labelClass}>Field Size (hectares)</label>
              <input
                type="number"
                step="0.01"
                min="0"
                name="field_size_hectares"
                value={formData.field_size_hectares}
                onChange={handleChange}
                placeholder="e.g. 12.5"
                className={inputClass}
              />
            </div>
            <div>
              <label className={labelClass}>Crop Type</label>
              <input
                type="text"
                name="crop_type"
                value={formData.crop_type}
                onChange={handleChange}
                placeholder="e.g. Oats, Wheat, Corn"
                className={inputClass}
              />
            </div>
          </div>

          {/* Planting Date */}
          <div>
            <label className={labelClass}>Planting Date</label>
            <input
              type="date"
              name="planting_date"
              value={formData.planting_date}
              onChange={handleChange}
              className={inputClass}
            />
          </div>

          {/* Monitoring Interval */}
          <div>
            <label className={labelClass}>
              Monitoring Interval —{' '}
              <span className="text-[#6D8E22] font-semibold">
                every {formData.monitoring_interval_days} days
              </span>
            </label>
            <input
              type="range"
              name="monitoring_interval_days"
              min="1"
              max="30"
              value={formData.monitoring_interval_days}
              onChange={handleChange}
              className="w-full accent-[#6D8E22]"
            />
            <div className="flex justify-between text-xs text-gray-400 mt-0.5">
              <span>1 day</span>
              <span>30 days</span>
            </div>
          </div>

          {/* Health Alert Threshold */}
          <div>
            <label className={labelClass}>
              Alert Threshold —{' '}
              <span className="text-[#6D8E22] font-semibold">
                health below {formData.alert_threshold_health}%
              </span>
            </label>
            <input
              type="range"
              name="alert_threshold_health"
              min="0"
              max="100"
              value={formData.alert_threshold_health}
              onChange={handleChange}
              className="w-full accent-[#6D8E22]"
            />
            <div className="flex justify-between text-xs text-gray-400 mt-0.5">
              <span>0%</span>
              <span>100%</span>
            </div>
          </div>

          {/* Submit */}
          <div className="pt-2 flex justify-end">
            <button
              type="submit"
              disabled={loading}
              className="px-8 py-2.5 bg-[#819360] hover:bg-[#3D6B35] disabled:opacity-60 disabled:cursor-not-allowed text-white rounded-lg font-medium transition-colors text-sm"
            >
              {loading ? 'Adding…' : 'Add Field'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// ─── EditFieldView ────────────────────────────────────────────────────────────

function EditFieldView({ businessId, fieldId, onBack, onSaved }) {
  const [formData, setFormData] = useState(null);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [fetching, setFetching] = useState(true);

  const mapRef = useRef(null);
  const drawnItemsRef = useRef(null);
  const mapContainerRef = useRef(null);

  useEffect(() => {
    fetch(`${API_URL}/api/fields?business_id=${businessId}`)
      .then(r => r.json())
      .then(fields => {
        const field = fields.find(f => (f.fieldid || f.id) === parseInt(fieldId));
        if (!field) throw new Error('Field not found');
        setFormData({
          name: field.name || '',
          address: field.address || '',
          latitude: field.latitude ?? '',
          longitude: field.longitude ?? '',
          field_size_hectares: field.field_size_hectares ?? '',
          crop_type: field.crop_type || '',
          planting_date: field.planting_date || '',
          boundary_geojson: '',
          monitoring_interval_days: field.monitoring_interval_days ?? 5,
          alert_threshold_health: field.alert_threshold_health ?? 50,
        });
      })
      .catch(err => setError(err.message || 'Could not load field.'))
      .finally(() => setFetching(false));
  }, [businessId, fieldId]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await updateField(fieldId, { ...formData, business_id: businessId });
      onSaved();
    } catch (err) {
      setError(err.message || 'Failed to update field. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!formData || mapRef.current) return;

    const mapCenter = (formData.latitude && formData.longitude)
      ? [parseFloat(formData.latitude), parseFloat(formData.longitude)]
      : [37.5, -121.9];
    const map = L.map(mapContainerRef.current).setView(mapCenter, 14);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '© OpenStreetMap contributors',
    }).addTo(map);

    const drawnItems = new L.FeatureGroup();
    map.addLayer(drawnItems);
    drawnItemsRef.current = drawnItems;

    const drawControl = new L.Control.Draw({
      draw: {
        polygon: true,
        rectangle: true,
        circle: false,
        marker: false,
        polyline: false,
        circlemarker: false,
      },
      edit: { featureGroup: drawnItems },
    });
    map.addControl(drawControl);

    map.on(L.Draw.Event.CREATED, (e) => {
      drawnItems.clearLayers();
      drawnItems.addLayer(e.layer);
      const geojson = e.layer.toGeoJSON().geometry;
      const center = e.layer.getBounds().getCenter();
      setFormData(prev => ({
        ...prev,
        boundary_geojson: JSON.stringify(geojson),
        latitude: center.lat.toFixed(6),
        longitude: center.lng.toFixed(6),
      }));
    });

    mapRef.current = map;
    return () => {
      map.remove();
      mapRef.current = null;
    };
  }, [formData]);

  const inputClass =
    'w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#6D8E22] focus:border-transparent transition';
  const labelClass = 'block text-sm font-medium text-gray-700 mb-1';

  if (fetching) return <div className="p-8 text-gray-500">Loading field…</div>;
  if (!formData) return <div className="p-8 text-red-500">{error || 'Field not found.'}</div>;

  return (
    <div className="pb-16">
      <button
        onClick={onBack}
        className="mb-6 text-green-600 hover:text-green-700 font-medium flex items-center gap-1"
      >
        ← Back to Fields
      </button>

      <div className="bg-white rounded-lg shadow-sm p-8">
        <h2 className="text-2xl font-bold text-gray-900 mb-6">Edit Field</h2>

        {error && (
          <div className="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label className={labelClass}>Field Name</label>
            <input type="text" name="name" value={formData.name} onChange={handleChange} required placeholder="e.g. North Pasture" className={inputClass} />
          </div>

          <div>
            <label className={labelClass}>Address</label>
            <input type="text" name="address" value={formData.address} onChange={handleChange} placeholder="Street address or nearest town" className={inputClass} />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className={labelClass}>Latitude</label>
              <input type="number" step="any" name="latitude" value={formData.latitude} onChange={handleChange} placeholder="Auto-filled from map" className={inputClass} />
            </div>
            <div>
              <label className={labelClass}>Longitude</label>
              <input type="number" step="any" name="longitude" value={formData.longitude} onChange={handleChange} placeholder="Auto-filled from map" className={inputClass} />
            </div>
          </div>

          <div>
            <label className={labelClass}>
              Draw Field Boundary{' '}
              <span className="text-gray-400 font-normal">(optional — redraw to update)</span>
            </label>
            <div ref={mapContainerRef} style={{ height: '320px', width: '100%' }} className="rounded-lg border border-gray-200 z-0" />
            {formData.boundary_geojson && (
              <p className="mt-1 text-xs text-green-700 font-medium">
                ✓ New boundary captured — centre set to {formData.latitude}, {formData.longitude}
              </p>
            )}
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className={labelClass}>Field Size (hectares)</label>
              <input type="number" step="0.01" min="0" name="field_size_hectares" value={formData.field_size_hectares} onChange={handleChange} placeholder="e.g. 12.5" className={inputClass} />
            </div>
            <div>
              <label className={labelClass}>Crop Type</label>
              <input type="text" name="crop_type" value={formData.crop_type} onChange={handleChange} placeholder="e.g. Oats, Wheat, Corn" className={inputClass} />
            </div>
          </div>

          <div>
            <label className={labelClass}>Planting Date</label>
            <input type="date" name="planting_date" value={formData.planting_date} onChange={handleChange} className={inputClass} />
          </div>

          <div>
            <label className={labelClass}>
              Monitoring Interval —{' '}
              <span className="text-[#6D8E22] font-semibold">every {formData.monitoring_interval_days} days</span>
            </label>
            <input type="range" name="monitoring_interval_days" min="1" max="30" value={formData.monitoring_interval_days} onChange={handleChange} className="w-full accent-[#6D8E22]" />
            <div className="flex justify-between text-xs text-gray-400 mt-0.5"><span>1 day</span><span>30 days</span></div>
          </div>

          <div>
            <label className={labelClass}>
              Alert Threshold —{' '}
              <span className="text-[#6D8E22] font-semibold">health below {formData.alert_threshold_health}%</span>
            </label>
            <input type="range" name="alert_threshold_health" min="0" max="100" value={formData.alert_threshold_health} onChange={handleChange} className="w-full accent-[#6D8E22]" />
            <div className="flex justify-between text-xs text-gray-400 mt-0.5"><span>0%</span><span>100%</span></div>
          </div>

          <div className="pt-2 flex justify-end">
            <button
              type="submit"
              disabled={loading}
              className="px-8 py-2.5 bg-[#819360] hover:bg-[#3D6B35] disabled:opacity-60 disabled:cursor-not-allowed text-white rounded-lg font-medium transition-colors text-sm"
            >
              {loading ? 'Saving…' : 'Save Changes'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// ─── FieldList ────────────────────────────────────────────────────────────────

function FieldList({ businessId, onCreateNew }) {
  const [fields, setFields] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [confirmDeleteId, setConfirmDeleteId] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    if (!businessId) return;
    getFields(businessId)
      .then(setFields)
      .catch((err) => setError(err.message || 'Could not load fields.'))
      .finally(() => setLoading(false));
  }, [businessId]);

  const handleDelete = async (fieldId) => {
    setDeleting(true);
    try {
      const res = await fetch(`${API_URL}/api/fields/${fieldId}`, { method: 'DELETE' });
      if (!res.ok) throw new Error('Failed to delete');
      setFields(prev => prev.filter(f => (f.fieldid || f.id) !== fieldId));
      setConfirmDeleteId(null);
    } catch (err) {
      setError('Failed to delete field. Please try again.');
    } finally {
      setDeleting(false);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center py-24 text-gray-400 text-sm">
        Loading fields…
      </div>
    );
  }

  return (
    <div>
      {/* Confirm delete modal */}
      {confirmDeleteId && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40">
          <div className="bg-white rounded-xl shadow-xl p-6 max-w-sm w-full mx-4">
            <h3 className="text-lg font-bold text-gray-900 mb-2">Delete Field?</h3>
            <p className="text-sm text-gray-500 mb-6">
              This will permanently delete the field and all its analysis data. This cannot be undone.
            </p>
            <div className="flex gap-3 justify-end">
              <button
                onClick={() => setConfirmDeleteId(null)}
                className="px-4 py-2 rounded-lg border border-gray-200 text-gray-600 text-sm font-medium hover:bg-gray-50 transition"
              >
                Cancel
              </button>
              <button
                onClick={() => handleDelete(confirmDeleteId)}
                disabled={deleting}
                className="px-4 py-2 rounded-lg text-white text-sm font-medium transition disabled:opacity-50" style={{ background: '#C0382B' }}
              >
                {deleting ? 'Deleting…' : 'Delete Field'}
              </button>
            </div>
          </div>
        </div>
      )}

      <div className="flex items-center justify-between mb-6">
        <h2 className="text-2xl font-bold text-gray-900">Fields</h2>
        <button
          onClick={onCreateNew}
          className="px-5 py-2 bg-[#819360] hover:bg-[#3D6B35] text-white rounded-lg font-medium text-sm transition-colors"
        >
          + Add Field
        </button>
      </div>

      {error && (
        <div className="mb-4 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {fields.length === 0 ? (
        <div className="text-center py-24 text-gray-400">
          <p className="text-lg mb-2">No fields yet</p>
          <p className="text-sm">Click "Add Field" to get started.</p>
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {fields.map((field) => {
            const fieldId = field.fieldid || field.id;
            return (
              <div
                key={fieldId}
                className="bg-white rounded-lg shadow-sm p-5 border border-gray-100 hover:shadow-md hover:border-[#6D8E22] transition-all relative group"
              >
                <div
                  className="cursor-pointer"
                  onClick={() => navigate(`/precision-ag/analyses?BusinessID=${businessId}&FieldID=${fieldId}`)}
                >
                  <h3 className="font-semibold text-gray-900 mb-1 pr-8">{field.name}</h3>
                  {field.crop_type && (
                    <p className="text-sm text-gray-500 mb-1">🌱 {field.crop_type}</p>
                  )}
                  {field.field_size_hectares && (
                    <p className="text-xs text-gray-400">📏 {field.field_size_hectares} ha</p>
                  )}
                  {field.address && (
                    <p className="text-xs text-gray-400 mt-1 truncate">📍 {field.address}</p>
                  )}
                </div>
                <button
                  onClick={(e) => { e.stopPropagation(); setConfirmDeleteId(fieldId); }}
                  className="absolute top-3 right-3 w-7 h-7 flex items-center justify-center rounded-full text-gray-300 hover:bg-red-50 hover:text-red-500 transition-all opacity-0 group-hover:opacity-100"
                  title="Delete field"
                >
                  🗑
                </button>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

// ─── PrecisionAgFields (root) ─────────────────────────────────────────────────

function PrecisionAgFields({ businessId: propBusinessId }) {
  const [searchParams] = useSearchParams();
  const businessId = propBusinessId || searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID') || localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  const initialView = searchParams.get('view') === 'create-field'
    ? 'create'
    : searchParams.get('view') === 'edit-field'
    ? 'edit'
    : 'list';
  const [view, setView] = useState(initialView);
  const initialLat = searchParams.get('lat');
  const initialLon = searchParams.get('lon');
  const editFieldId = searchParams.get('FieldID');
  const [loadError, setLoadError] = useState(false);
  const loadTimeoutRef = useRef(null);

  useEffect(() => {
    if (!businessId) { setLoadError(true); return; }
    setLoadError(false);
    LoadBusiness(businessId);
    if (!Business) {
      loadTimeoutRef.current = setTimeout(() => setLoadError(true), 10000);
    }
    return () => clearTimeout(loadTimeoutRef.current);
  }, [businessId]);

  // Cancel timeout and clear error once Business is confirmed loaded
  useEffect(() => {
    if (Business) {
      clearTimeout(loadTimeoutRef.current);
      setLoadError(false);
    }
  }, [Business]);

  if (!Business && !loadError) return <div className="p-8 text-gray-500">Loading...</div>;
  if (loadError || !Business) return <div className="p-8 text-red-500">Could not load account. Please go back and try again.</div>;

  return (
    <AccountLayout Business={Business} BusinessID={businessId} PeopleID={PeopleID}>
      <div className="max-w-5xl mx-auto">
        {view === 'list' && (
          <FieldList
            businessId={businessId}
            onCreateNew={() => setView('create')}
          />
        )}
        {view === 'create' && (
          <CreateFieldView
            businessId={businessId}
            onBack={() => setView('list')}
            onCreated={() => setView('list')}
            initialLat={initialLat}
            initialLon={initialLon}
          />
        )}
        {view === 'edit' && editFieldId && (
          <EditFieldView
            businessId={businessId}
            fieldId={editFieldId}
            onBack={() => setView('list')}
            onSaved={() => setView('list')}
          />
        )}
      </div>
    </AccountLayout>
  );
}

export default PrecisionAgFields;
export { CreateFieldView, FieldList };