import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const API = import.meta.env.VITE_API_URL || '';
const GREEN = '#3D6B34';

function authHeaders() {
  const t = localStorage.getItem('access_token') || '';
  return { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` };
}

function fmtDate(d) {
  if (!d) return '—';
  return new Date(d).toLocaleDateString([], { month: 'short', day: 'numeric', year: 'numeric' });
}

function fmtDateTime(d) {
  if (!d) return '—';
  return new Date(d).toLocaleString([], { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' });
}

function fmtTemp(c) {
  if (c == null) return '—';
  return `${parseFloat(c).toFixed(1)} °C`;
}

function TempBadge({ temp, min, max }) {
  if (temp == null) return <span className="text-gray-400 text-xs">No reading</span>;
  const t = parseFloat(temp), lo = parseFloat(min), hi = parseFloat(max);
  const ok = t >= lo && t <= hi;
  return (
    <span className={`inline-block px-2 py-0.5 rounded text-xs font-semibold ${ok ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
      {fmtTemp(t)} {ok ? '✓' : '⚠ Out of range'}
    </span>
  );
}

const STATUS_COLORS = {
  completed:  'bg-green-100 text-green-700',
  in_transit: 'bg-blue-100 text-blue-700',
  planned:    'bg-gray-100 text-gray-600',
  cancelled:  'bg-red-100 text-red-700',
};

const BLANK_VEHICLE  = { VehicleName: '', LicensePlate: '', DriverName: '', DriverPhone: '', MinTempC: -2, MaxTempC: 7 };
const BLANK_READING  = { TempC: '', Humidity: '', LocationDesc: '', Notes: '' };
const BLANK_SHIPMENT = { RunDate: '', RouteLabel: '', Status: 'completed', DriverName: '', DepartedAt: '', ArrivedAt: '', TotalMiles: '', Notes: '' };
const BLANK_MAINT    = { ServiceDate: '', ServiceType: '', ServiceProvider: '', Technician: '', Cost: '', OdometerMiles: '', Notes: '', NextServiceDate: '' };

const SERVICE_TYPES = [
  'Refrigeration Calibration', 'Refrigeration Service', 'Compressor Inspection',
  'Temperature Sensor Calibration', 'Door Seal Replacement', 'Electrical / Wiring',
  'Oil Change', 'Brake Inspection', 'Tire Rotation', 'Annual Safety Inspection',
  'Engine Tune-Up', 'Other',
];

export default function ColdChain() {
  const [params] = useSearchParams();
  const navigate = useNavigate();
  const businessId = params.get('BusinessID');

  const [vehicles, setVehicles]         = useState([]);
  const [loading, setLoading]           = useState(true);
  const [selected, setSelected]         = useState(null);
  const [detailTab, setDetailTab]       = useState('readings');
  const [error, setError]               = useState('');

  // Readings
  const [readings, setReadings]         = useState([]);
  const [readingsLoading, setReadingsLoading] = useState(false);

  // Shipments
  const [shipments, setShipments]       = useState([]);
  const [shipmentsLoading, setShipmentsLoading] = useState(false);
  const [expandedShipment, setExpandedShipment] = useState(null);
  const [shipmentDetail, setShipmentDetail]     = useState({});

  // Maintenance
  const [maintenance, setMaintenance]   = useState([]);
  const [maintLoading, setMaintLoading] = useState(false);

  // Forms
  const [showVehicleForm, setShowVehicleForm]   = useState(false);
  const [vehicleForm, setVehicleForm]           = useState(BLANK_VEHICLE);
  const [editingVehicleId, setEditingVehicleId] = useState(null);
  const [vehicleSaving, setVehicleSaving]       = useState(false);

  const [showReadingForm, setShowReadingForm]   = useState(false);
  const [readingForm, setReadingForm]           = useState(BLANK_READING);
  const [readingSaving, setReadingSaving]       = useState(false);

  const [showShipmentForm, setShowShipmentForm] = useState(false);
  const [shipmentForm, setShipmentForm]         = useState(BLANK_SHIPMENT);
  const [shipmentItems, setShipmentItems]       = useState([{ ProductName: '', Quantity: '', Unit: 'cases', Recipient: '', Notes: '' }]);
  const [shipmentSaving, setShipmentSaving]     = useState(false);

  const [showMaintForm, setShowMaintForm]       = useState(false);
  const [maintForm, setMaintForm]               = useState(BLANK_MAINT);
  const [maintSaving, setMaintSaving]           = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }
    if (!businessId) return;
    loadVehicles();
  }, [businessId]);

  const loadVehicles = useCallback(async () => {
    setLoading(true);
    try {
      const res = await fetch(`${API}/api/cold-chain/vehicles?business_id=${businessId}`, { headers: authHeaders() });
      if (res.ok) setVehicles(await res.json());
    } catch { setError('Failed to load vehicles.'); }
    finally { setLoading(false); }
  }, [businessId]);

  const loadReadings = useCallback(async (vehicleId) => {
    setReadingsLoading(true);
    try {
      const res = await fetch(`${API}/api/cold-chain/vehicles/${vehicleId}/readings`, { headers: authHeaders() });
      if (res.ok) setReadings(await res.json());
    } catch { setError('Failed to load readings.'); }
    finally { setReadingsLoading(false); }
  }, []);

  const loadShipments = useCallback(async (vehicleId) => {
    setShipmentsLoading(true);
    try {
      const res = await fetch(`${API}/api/cold-chain/vehicles/${vehicleId}/shipments`, { headers: authHeaders() });
      if (res.ok) setShipments(await res.json());
    } catch { setError('Failed to load shipments.'); }
    finally { setShipmentsLoading(false); }
  }, []);

  const loadMaintenance = useCallback(async (vehicleId) => {
    setMaintLoading(true);
    try {
      const res = await fetch(`${API}/api/cold-chain/vehicles/${vehicleId}/maintenance`, { headers: authHeaders() });
      if (res.ok) setMaintenance(await res.json());
    } catch { setError('Failed to load maintenance records.'); }
    finally { setMaintLoading(false); }
  }, []);

  const loadShipmentDetail = async (shipmentId) => {
    if (shipmentDetail[shipmentId]) { setExpandedShipment(shipmentId); return; }
    try {
      const res = await fetch(`${API}/api/cold-chain/shipments/${shipmentId}`, { headers: authHeaders() });
      if (res.ok) {
        const d = await res.json();
        setShipmentDetail(prev => ({ ...prev, [shipmentId]: d }));
        setExpandedShipment(shipmentId);
      }
    } catch { setError('Failed to load shipment detail.'); }
  };

  const selectVehicle = (v) => {
    setSelected(v);
    setDetailTab('readings');
    setReadings([]); setShipments([]); setMaintenance([]);
    setExpandedShipment(null); setShipmentDetail({});
    setShowReadingForm(false); setShowShipmentForm(false); setShowMaintForm(false);
    loadReadings(v.VehicleID);
  };

  const handleTabChange = (tab) => {
    setDetailTab(tab);
    if (!selected) return;
    if (tab === 'readings'    && readings.length === 0)    loadReadings(selected.VehicleID);
    if (tab === 'shipments'   && shipments.length === 0)   loadShipments(selected.VehicleID);
    if (tab === 'maintenance' && maintenance.length === 0)  loadMaintenance(selected.VehicleID);
  };

  // ── Vehicle save ────────────────────────────────────────────────────────────
  const saveVehicle = async () => {
    if (!vehicleForm.VehicleName.trim()) { setError('Vehicle name is required.'); return; }
    setVehicleSaving(true); setError('');
    try {
      const url    = editingVehicleId ? `${API}/api/cold-chain/vehicles/${editingVehicleId}` : `${API}/api/cold-chain/vehicles`;
      const method = editingVehicleId ? 'PUT' : 'POST';
      const body   = editingVehicleId ? vehicleForm : { ...vehicleForm, BusinessID: parseInt(businessId) };
      const res = await fetch(url, { method, headers: authHeaders(), body: JSON.stringify(body) });
      if (!res.ok) throw new Error('Save failed');
      setShowVehicleForm(false);
      await loadVehicles();
      if (selected && editingVehicleId === selected.VehicleID)
        setSelected(prev => ({ ...prev, ...vehicleForm }));
    } catch (e) { setError(e.message || 'Save failed.'); }
    finally { setVehicleSaving(false); }
  };

  const deleteVehicle = async (vehicleId) => {
    if (!window.confirm('Delete this vehicle and ALL its data (readings, shipments, maintenance)?')) return;
    try {
      await fetch(`${API}/api/cold-chain/vehicles/${vehicleId}`, { method: 'DELETE', headers: authHeaders() });
      if (selected?.VehicleID === vehicleId) setSelected(null);
      await loadVehicles();
    } catch { setError('Delete failed.'); }
  };

  // ── Reading save ─────────────────────────────────────────────────────────────
  const saveReading = async () => {
    if (!readingForm.TempC && readingForm.TempC !== 0) { setError('Temperature is required.'); return; }
    setReadingSaving(true); setError('');
    try {
      const res = await fetch(`${API}/api/cold-chain/vehicles/${selected.VehicleID}/readings`, {
        method: 'POST', headers: authHeaders(),
        body: JSON.stringify({
          TempC:       parseFloat(readingForm.TempC),
          Humidity:    readingForm.Humidity ? parseFloat(readingForm.Humidity) : null,
          LocationDesc: readingForm.LocationDesc || null,
          Notes:       readingForm.Notes || null,
        }),
      });
      if (!res.ok) throw new Error('Save failed');
      setReadingForm(BLANK_READING); setShowReadingForm(false);
      await loadReadings(selected.VehicleID);
      await loadVehicles();
    } catch (e) { setError(e.message || 'Save failed.'); }
    finally { setReadingSaving(false); }
  };

  // ── Shipment save ─────────────────────────────────────────────────────────────
  const addShipmentItemRow = () =>
    setShipmentItems(prev => [...prev, { ProductName: '', Quantity: '', Unit: 'cases', Recipient: '', Notes: '' }]);

  const updateShipmentItem = (idx, field, val) =>
    setShipmentItems(prev => prev.map((r, i) => i === idx ? { ...r, [field]: val } : r));

  const removeShipmentItem = (idx) =>
    setShipmentItems(prev => prev.filter((_, i) => i !== idx));

  const saveShipment = async () => {
    if (!shipmentForm.RunDate) { setError('Run date is required.'); return; }
    setShipmentSaving(true); setError('');
    try {
      const items = shipmentItems.filter(r => r.ProductName.trim());
      const res = await fetch(`${API}/api/cold-chain/vehicles/${selected.VehicleID}/shipments`, {
        method: 'POST', headers: authHeaders(),
        body: JSON.stringify({
          ...shipmentForm,
          BusinessID: parseInt(businessId),
          TotalMiles: shipmentForm.TotalMiles ? parseFloat(shipmentForm.TotalMiles) : null,
          DepartedAt: shipmentForm.DepartedAt || null,
          ArrivedAt:  shipmentForm.ArrivedAt  || null,
          Items: items.map(r => ({
            ...r,
            Quantity: r.Quantity ? parseFloat(r.Quantity) : null,
          })),
        }),
      });
      if (!res.ok) throw new Error('Save failed');
      setShipmentForm(BLANK_SHIPMENT);
      setShipmentItems([{ ProductName: '', Quantity: '', Unit: 'cases', Recipient: '', Notes: '' }]);
      setShowShipmentForm(false);
      await loadShipments(selected.VehicleID);
    } catch (e) { setError(e.message || 'Save failed.'); }
    finally { setShipmentSaving(false); }
  };

  // ── Maintenance save ──────────────────────────────────────────────────────────
  const saveMaintenance = async () => {
    if (!maintForm.ServiceDate || !maintForm.ServiceType) { setError('Service date and type are required.'); return; }
    setMaintSaving(true); setError('');
    try {
      const res = await fetch(`${API}/api/cold-chain/vehicles/${selected.VehicleID}/maintenance`, {
        method: 'POST', headers: authHeaders(),
        body: JSON.stringify({
          ...maintForm,
          BusinessID:    parseInt(businessId),
          Cost:          maintForm.Cost          ? parseFloat(maintForm.Cost) : null,
          OdometerMiles: maintForm.OdometerMiles ? parseInt(maintForm.OdometerMiles) : null,
          NextServiceDate: maintForm.NextServiceDate || null,
        }),
      });
      if (!res.ok) throw new Error('Save failed');
      setMaintForm(BLANK_MAINT); setShowMaintForm(false);
      await loadMaintenance(selected.VehicleID);
    } catch (e) { setError(e.message || 'Save failed.'); }
    finally { setMaintSaving(false); }
  };

  const deleteMaintenance = async (mid) => {
    if (!window.confirm('Delete this maintenance record?')) return;
    try {
      await fetch(`${API}/api/cold-chain/maintenance/${mid}`, { method: 'DELETE', headers: authHeaders() });
      await loadMaintenance(selected.VehicleID);
    } catch { setError('Delete failed.'); }
  };

  const deleteShipment = async (sid) => {
    if (!window.confirm('Delete this shipment run and all its items?')) return;
    try {
      await fetch(`${API}/api/cold-chain/shipments/${sid}`, { method: 'DELETE', headers: authHeaders() });
      setShipmentDetail(prev => { const n = { ...prev }; delete n[sid]; return n; });
      await loadShipments(selected.VehicleID);
    } catch { setError('Delete failed.'); }
  };

  // ── Render helpers ────────────────────────────────────────────────────────────
  const inputCls = 'border border-gray-300 rounded px-3 py-1.5 text-sm w-full';
  const labelCls = 'block text-xs font-medium text-gray-600 mb-1';

  const TAB_COUNTS = {
    readings:    readings.length    || '',
    shipments:   shipments.length   || '',
    maintenance: maintenance.length || '',
  };

  return (
    <div className="min-h-screen font-sans">
      <PageMeta title="Cold Chain Tracking | Oatmeal Farm Network" description="Monitor vehicle temperatures, shipment manifests, and maintenance records." noIndex />
      <Header />
      <div className="container mx-auto px-4 py-8" style={{ maxWidth: 1300 }}>
        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'Cold Chain Tracking' }]} />
        <div className="flex items-center justify-between mb-6 pb-3 border-b-2 border-gray-200">
          <h2 className="text-2xl font-bold text-gray-800">Cold Chain & Logistics Tracking</h2>
          <button onClick={() => { setVehicleForm(BLANK_VEHICLE); setEditingVehicleId(null); setShowVehicleForm(true); }}
            className="regsubmit2" style={{ fontSize: '0.85rem', padding: '0.4rem 1rem' }}>
            + Add Vehicle
          </button>
        </div>

        {error && (
          <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-2 text-sm mb-4">
            {error} <button onClick={() => setError('')} className="ml-2 font-bold">✕</button>
          </div>
        )}

        <div className="flex gap-6" style={{ alignItems: 'flex-start' }}>

          {/* ── Vehicle list ──────────────────────────────────────────────── */}
          <div style={{ width: 300, flexShrink: 0 }}>
            <h3 className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">Vehicles</h3>
            {loading ? <p className="text-gray-400 text-sm">Loading…</p> :
              vehicles.length === 0 ? <p className="text-gray-400 text-sm">No vehicles yet.</p> : (
              <div className="space-y-2">
                {vehicles.map(v => (
                  <div key={v.VehicleID} onClick={() => selectVehicle(v)}
                    className={`rounded-lg border p-3 cursor-pointer transition-all ${selected?.VehicleID === v.VehicleID ? 'border-[#3D6B34] bg-green-50' : 'border-gray-200 bg-white hover:border-gray-300'}`}>
                    <div className="flex items-start justify-between gap-2">
                      <div className="min-w-0">
                        <p className="font-semibold text-gray-800 text-sm truncate">{v.VehicleName}</p>
                        {v.LicensePlate && <p className="text-xs text-gray-500">{v.LicensePlate}</p>}
                        {v.DriverName   && <p className="text-xs text-gray-500">Driver: {v.DriverName}</p>}
                      </div>
                      <div className="flex gap-1 shrink-0">
                        <button onClick={e => { e.stopPropagation(); setVehicleForm({ VehicleName: v.VehicleName || '', LicensePlate: v.LicensePlate || '', DriverName: v.DriverName || '', DriverPhone: v.DriverPhone || '', MinTempC: v.MinTempC ?? -2, MaxTempC: v.MaxTempC ?? 7 }); setEditingVehicleId(v.VehicleID); setShowVehicleForm(true); }}
                          className="text-gray-400 hover:text-gray-700 text-xs px-1">Edit</button>
                        <button onClick={e => { e.stopPropagation(); deleteVehicle(v.VehicleID); }}
                          className="text-red-400 hover:text-red-600 text-xs px-1">Del</button>
                      </div>
                    </div>
                    <div className="mt-2">
                      <TempBadge temp={v.LatestTempC} min={v.MinTempC} max={v.MaxTempC} />
                      {v.LatestReadingAt && <p className="text-xs text-gray-400 mt-0.5">{fmtDateTime(v.LatestReadingAt)}</p>}
                    </div>
                    <p className="text-xs text-gray-400 mt-1">Range: {fmtTemp(v.MinTempC)} – {fmtTemp(v.MaxTempC)}</p>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* ── Right detail panel ────────────────────────────────────────── */}
          <div className="flex-1 min-w-0">
            {!selected ? (
              <div className="text-center py-20 text-gray-400">
                <p className="text-lg">Select a vehicle to view its data</p>
                <p className="text-sm mt-1">Readings, shipment manifests, and maintenance history</p>
              </div>
            ) : (
              <>
                {/* Tab bar */}
                <div className="flex items-center justify-between mb-4 border-b border-gray-200">
                  <div className="flex gap-0">
                    {[['readings', 'Readings Log'], ['shipments', 'Shipments'], ['maintenance', 'Maintenance']].map(([key, label]) => (
                      <button key={key} onClick={() => handleTabChange(key)}
                        className={`px-4 py-2.5 text-sm font-semibold border-b-2 -mb-px transition-colors ${detailTab === key ? 'border-[#3D6B34] text-[#3D6B34]' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
                        {label}{TAB_COUNTS[key] ? <span className="ml-1.5 text-xs bg-gray-100 text-gray-500 rounded-full px-1.5 py-0.5">{TAB_COUNTS[key]}</span> : null}
                      </button>
                    ))}
                  </div>
                  <span className="text-sm font-semibold text-gray-700">{selected.VehicleName}</span>
                </div>

                {/* ── Readings tab ───────────────────────────────────────── */}
                {detailTab === 'readings' && (
                  <>
                    <div className="flex justify-end mb-3">
                      <button onClick={() => setShowReadingForm(f => !f)}
                        className="regsubmit2" style={{ fontSize: '0.82rem', padding: '0.35rem 0.9rem' }}>
                        + Log Reading
                      </button>
                    </div>
                    {showReadingForm && (
                      <div className="bg-gray-50 border border-gray-200 rounded-lg p-4 mb-4">
                        <h4 className="text-sm font-semibold text-gray-700 mb-3">New Reading</h4>
                        <div className="grid grid-cols-2 gap-3 mb-3">
                          <div><label className={labelCls}>Temperature (°C) *</label>
                            <input type="number" step="0.1" value={readingForm.TempC} onChange={e => setReadingForm(f => ({ ...f, TempC: e.target.value }))} className={inputCls} /></div>
                          <div><label className={labelCls}>Humidity (%)</label>
                            <input type="number" step="0.1" value={readingForm.Humidity} onChange={e => setReadingForm(f => ({ ...f, Humidity: e.target.value }))} className={inputCls} /></div>
                        </div>
                        <div className="mb-3"><label className={labelCls}>Location / Stop</label>
                          <input type="text" value={readingForm.LocationDesc} onChange={e => setReadingForm(f => ({ ...f, LocationDesc: e.target.value }))} className={inputCls} placeholder="e.g. Distribution center" /></div>
                        <div className="mb-3"><label className={labelCls}>Notes</label>
                          <textarea value={readingForm.Notes} onChange={e => setReadingForm(f => ({ ...f, Notes: e.target.value }))} rows={2} className={inputCls} /></div>
                        <div className="flex gap-2">
                          <button onClick={saveReading} disabled={readingSaving} className="regsubmit2 disabled:opacity-50" style={{ fontSize: '0.82rem', padding: '0.35rem 0.9rem' }}>
                            {readingSaving ? 'Saving…' : 'Save Reading'}</button>
                          <button onClick={() => setShowReadingForm(false)} className="border border-gray-300 rounded px-3 py-1.5 text-sm text-gray-600 hover:bg-gray-50">Cancel</button>
                        </div>
                      </div>
                    )}
                    {readingsLoading ? <p className="text-gray-400 text-sm">Loading…</p> :
                      readings.length === 0 ? <p className="text-gray-400 text-sm py-8 text-center">No readings yet for this vehicle.</p> : (
                      <div className="overflow-auto rounded-lg border border-gray-200">
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                          <thead>
                            <tr className="bg-gray-50">
                              {['Recorded At', 'Temp', 'Humidity', 'Status', 'Location', 'Notes'].map(h => (
                                <th key={h} style={{ padding: '0.55rem 0.75rem', textAlign: 'left', fontSize: '0.7rem', fontWeight: 600, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.05em', borderBottom: '1px solid #E5E7EB' }}>{h}</th>
                              ))}
                            </tr>
                          </thead>
                          <tbody>
                            {readings.map((r, i) => {
                              const t = parseFloat(r.TempC);
                              const ok = t >= parseFloat(selected.MinTempC) && t <= parseFloat(selected.MaxTempC);
                              return (
                                <tr key={r.ReadingID} style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa', borderBottom: '1px solid #F3F4F6' }}>
                                  <td style={{ padding: '0.5rem 0.75rem', fontSize: '0.8rem', color: '#374151' }}>{fmtDateTime(r.RecordedAt)}</td>
                                  <td style={{ padding: '0.5rem 0.75rem', fontSize: '0.8rem', fontWeight: 600, color: ok ? '#15803d' : '#dc2626' }}>{fmtTemp(r.TempC)}</td>
                                  <td style={{ padding: '0.5rem 0.75rem', fontSize: '0.8rem', color: '#6B7280' }}>{r.Humidity != null ? `${r.Humidity}%` : '—'}</td>
                                  <td style={{ padding: '0.5rem 0.75rem' }}>
                                    <span className={`inline-block px-1.5 py-0.5 rounded text-xs font-semibold ${ok ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>{ok ? 'OK' : 'Alert'}</span>
                                  </td>
                                  <td style={{ padding: '0.5rem 0.75rem', fontSize: '0.8rem', color: '#6B7280', maxWidth: 180 }}>{r.LocationDesc || '—'}</td>
                                  <td style={{ padding: '0.5rem 0.75rem', fontSize: '0.8rem', color: '#6B7280', maxWidth: 180 }}>{r.Notes || '—'}</td>
                                </tr>
                              );
                            })}
                          </tbody>
                        </table>
                      </div>
                    )}
                  </>
                )}

                {/* ── Shipments tab ──────────────────────────────────────── */}
                {detailTab === 'shipments' && (
                  <>
                    <div className="flex justify-end mb-3">
                      <button onClick={() => { setShipmentForm({ ...BLANK_SHIPMENT, DriverName: selected.DriverName || '' }); setShipmentItems([{ ProductName: '', Quantity: '', Unit: 'cases', Recipient: '', Notes: '' }]); setShowShipmentForm(true); }}
                        className="regsubmit2" style={{ fontSize: '0.82rem', padding: '0.35rem 0.9rem' }}>
                        + Log Shipment Run
                      </button>
                    </div>
                    {shipmentsLoading ? <p className="text-gray-400 text-sm">Loading…</p> :
                      shipments.length === 0 ? <p className="text-gray-400 text-sm py-8 text-center">No shipment runs logged yet.</p> : (
                      <div className="space-y-3">
                        {shipments.map(s => {
                          const isOpen = expandedShipment === s.ShipmentID;
                          const detail = shipmentDetail[s.ShipmentID];
                          return (
                            <div key={s.ShipmentID} className="bg-white rounded-xl border border-gray-200 overflow-hidden">
                              <div className="flex items-center justify-between px-4 py-3 cursor-pointer hover:bg-gray-50"
                                onClick={() => isOpen ? setExpandedShipment(null) : loadShipmentDetail(s.ShipmentID)}>
                                <div className="flex items-center gap-3 min-w-0">
                                  <span className="text-sm font-bold text-gray-800 shrink-0">{fmtDate(s.RunDate)}</span>
                                  <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${STATUS_COLORS[s.Status] || 'bg-gray-100 text-gray-600'}`}>
                                    {s.Status.replace('_', ' ')}
                                  </span>
                                  {s.RouteLabel && <span className="text-sm text-gray-600 truncate">{s.RouteLabel}</span>}
                                </div>
                                <div className="flex items-center gap-4 shrink-0">
                                  <div className="text-right hidden sm:block">
                                    {s.DriverName && <p className="text-xs text-gray-500">{s.DriverName}</p>}
                                    {s.TotalMiles  && <p className="text-xs text-gray-400">{s.TotalMiles} mi</p>}
                                    <p className="text-xs text-gray-400">{s.ItemCount} item{s.ItemCount !== 1 ? 's' : ''}</p>
                                  </div>
                                  <div className="flex gap-1">
                                    <button onClick={e => { e.stopPropagation(); deleteShipment(s.ShipmentID); }}
                                      className="text-red-400 hover:text-red-600 text-xs px-1">Del</button>
                                    <span className="text-gray-400 text-xs">{isOpen ? '▲' : '▼'}</span>
                                  </div>
                                </div>
                              </div>
                              {isOpen && detail && (
                                <div className="border-t border-gray-100 px-4 py-3 bg-gray-50">
                                  <div className="flex flex-wrap gap-4 text-xs text-gray-500 mb-3">
                                    {detail.DepartedAt && <span>Departed: {fmtDateTime(detail.DepartedAt)}</span>}
                                    {detail.ArrivedAt  && <span>Arrived: {fmtDateTime(detail.ArrivedAt)}</span>}
                                    {detail.TotalMiles && <span>{detail.TotalMiles} miles</span>}
                                  </div>
                                  {detail.Notes && <p className="text-xs text-gray-600 mb-3 italic">{detail.Notes}</p>}
                                  {detail.Items?.length > 0 ? (
                                    <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.8rem' }}>
                                      <thead>
                                        <tr>
                                          {['Product', 'Qty', 'Unit', 'Recipient', 'Notes'].map(h => (
                                            <th key={h} style={{ padding: '0.35rem 0.5rem', textAlign: 'left', fontSize: '0.68rem', fontWeight: 600, color: '#9CA3AF', textTransform: 'uppercase', borderBottom: '1px solid #E5E7EB' }}>{h}</th>
                                          ))}
                                        </tr>
                                      </thead>
                                      <tbody>
                                        {detail.Items.map(item => (
                                          <tr key={item.ItemID}>
                                            <td style={{ padding: '0.35rem 0.5rem', color: '#374151', fontWeight: 500 }}>{item.ProductName}</td>
                                            <td style={{ padding: '0.35rem 0.5rem', color: '#6B7280' }}>{item.Quantity ?? '—'}</td>
                                            <td style={{ padding: '0.35rem 0.5rem', color: '#6B7280' }}>{item.Unit || '—'}</td>
                                            <td style={{ padding: '0.35rem 0.5rem', color: '#6B7280' }}>{item.Recipient || '—'}</td>
                                            <td style={{ padding: '0.35rem 0.5rem', color: '#9CA3AF' }}>{item.Notes || '—'}</td>
                                          </tr>
                                        ))}
                                      </tbody>
                                    </table>
                                  ) : <p className="text-xs text-gray-400">No items recorded.</p>}
                                </div>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    )}
                  </>
                )}

                {/* ── Maintenance tab ────────────────────────────────────── */}
                {detailTab === 'maintenance' && (
                  <>
                    <div className="flex justify-end mb-3">
                      <button onClick={() => { setMaintForm(BLANK_MAINT); setShowMaintForm(true); }}
                        className="regsubmit2" style={{ fontSize: '0.82rem', padding: '0.35rem 0.9rem' }}>
                        + Log Service
                      </button>
                    </div>
                    {maintLoading ? <p className="text-gray-400 text-sm">Loading…</p> :
                      maintenance.length === 0 ? <p className="text-gray-400 text-sm py-8 text-center">No maintenance records yet.</p> : (
                      <div className="space-y-3">
                        {maintenance.map(m => (
                          <div key={m.MaintenanceID} className="bg-white rounded-xl border border-gray-200 p-4">
                            <div className="flex items-start justify-between gap-3">
                              <div className="min-w-0 flex-1">
                                <div className="flex items-center gap-2 flex-wrap">
                                  <span className="font-bold text-gray-800 text-sm">{m.ServiceType}</span>
                                  <span className="text-xs text-gray-400">{fmtDate(m.ServiceDate)}</span>
                                </div>
                                <div className="flex flex-wrap gap-3 mt-1 text-xs text-gray-500">
                                  {m.ServiceProvider && <span>{m.ServiceProvider}</span>}
                                  {m.Technician      && <span>Tech: {m.Technician}</span>}
                                  {m.OdometerMiles   && <span>{m.OdometerMiles.toLocaleString()} mi</span>}
                                  {m.Cost != null    && <span className="font-semibold text-gray-700">${parseFloat(m.Cost).toFixed(2)}</span>}
                                </div>
                                {m.Notes && <p className="text-xs text-gray-500 mt-1.5 italic">{m.Notes}</p>}
                                {m.NextServiceDate && (
                                  <p className="text-xs mt-1.5">
                                    <span className="font-semibold text-amber-700">Next service: </span>
                                    <span className="text-amber-600">{fmtDate(m.NextServiceDate)}</span>
                                  </p>
                                )}
                              </div>
                              <button onClick={() => deleteMaintenance(m.MaintenanceID)}
                                className="text-red-400 hover:text-red-600 text-xs shrink-0">Del</button>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                  </>
                )}
              </>
            )}
          </div>
        </div>
      </div>

      {/* ── Vehicle form modal ─────────────────────────────────────────────── */}
      {showVehicleForm && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4" onClick={() => !vehicleSaving && setShowVehicleForm(false)}>
          <div className="bg-white rounded-xl shadow-xl max-w-md w-full p-6" onClick={e => e.stopPropagation()}>
            <h3 className="text-lg font-bold text-gray-900 mb-4">{editingVehicleId ? 'Edit Vehicle' : 'Add Vehicle'}</h3>
            <div className="space-y-3">
              <div><label className={labelCls}>Vehicle Name *</label>
                <input type="text" value={vehicleForm.VehicleName} onChange={e => setVehicleForm(f => ({ ...f, VehicleName: e.target.value }))} className={inputCls} placeholder="e.g. Truck 1 – Refrigerated" /></div>
              <div><label className={labelCls}>License Plate</label>
                <input type="text" value={vehicleForm.LicensePlate} onChange={e => setVehicleForm(f => ({ ...f, LicensePlate: e.target.value }))} className={inputCls} /></div>
              <div className="grid grid-cols-2 gap-3">
                <div><label className={labelCls}>Driver Name</label>
                  <input type="text" value={vehicleForm.DriverName} onChange={e => setVehicleForm(f => ({ ...f, DriverName: e.target.value }))} className={inputCls} /></div>
                <div><label className={labelCls}>Driver Phone</label>
                  <input type="text" value={vehicleForm.DriverPhone} onChange={e => setVehicleForm(f => ({ ...f, DriverPhone: e.target.value }))} className={inputCls} /></div>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div><label className={labelCls}>Min Temp (°C)</label>
                  <input type="number" step="0.5" value={vehicleForm.MinTempC} onChange={e => setVehicleForm(f => ({ ...f, MinTempC: e.target.value }))} className={inputCls} /></div>
                <div><label className={labelCls}>Max Temp (°C)</label>
                  <input type="number" step="0.5" value={vehicleForm.MaxTempC} onChange={e => setVehicleForm(f => ({ ...f, MaxTempC: e.target.value }))} className={inputCls} /></div>
              </div>
            </div>
            <div className="flex justify-end gap-2 mt-5">
              <button onClick={() => setShowVehicleForm(false)} disabled={vehicleSaving} className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50">Cancel</button>
              <button onClick={saveVehicle} disabled={vehicleSaving} className="regsubmit2 disabled:opacity-50" style={{ fontSize: '0.85rem', padding: '0.4rem 1.2rem' }}>
                {vehicleSaving ? 'Saving…' : 'Save'}</button>
            </div>
          </div>
        </div>
      )}

      {/* ── Shipment form modal ────────────────────────────────────────────── */}
      {showShipmentForm && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4" onClick={() => !shipmentSaving && setShowShipmentForm(false)}>
          <div className="bg-white rounded-xl shadow-xl w-full max-w-2xl p-6 max-h-[90vh] overflow-y-auto" onClick={e => e.stopPropagation()}>
            <h3 className="text-lg font-bold text-gray-900 mb-4">Log Shipment Run — {selected?.VehicleName}</h3>
            <div className="grid grid-cols-2 gap-3 mb-3">
              <div><label className={labelCls}>Run Date *</label>
                <input type="date" value={shipmentForm.RunDate} onChange={e => setShipmentForm(f => ({ ...f, RunDate: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Status</label>
                <select value={shipmentForm.Status} onChange={e => setShipmentForm(f => ({ ...f, Status: e.target.value }))} className={inputCls}>
                  <option value="completed">Completed</option>
                  <option value="in_transit">In Transit</option>
                  <option value="planned">Planned</option>
                  <option value="cancelled">Cancelled</option>
                </select></div>
              <div className="col-span-2"><label className={labelCls}>Route Label</label>
                <input type="text" value={shipmentForm.RouteLabel} onChange={e => setShipmentForm(f => ({ ...f, RouteLabel: e.target.value }))} className={inputCls} placeholder="e.g. Restaurant Route A, CSA Monday Run" /></div>
              <div><label className={labelCls}>Driver</label>
                <input type="text" value={shipmentForm.DriverName} onChange={e => setShipmentForm(f => ({ ...f, DriverName: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Total Miles</label>
                <input type="number" step="0.1" value={shipmentForm.TotalMiles} onChange={e => setShipmentForm(f => ({ ...f, TotalMiles: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Departed</label>
                <input type="datetime-local" value={shipmentForm.DepartedAt} onChange={e => setShipmentForm(f => ({ ...f, DepartedAt: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Arrived</label>
                <input type="datetime-local" value={shipmentForm.ArrivedAt} onChange={e => setShipmentForm(f => ({ ...f, ArrivedAt: e.target.value }))} className={inputCls} /></div>
              <div className="col-span-2"><label className={labelCls}>Notes</label>
                <textarea value={shipmentForm.Notes} onChange={e => setShipmentForm(f => ({ ...f, Notes: e.target.value }))} rows={2} className={inputCls} /></div>
            </div>

            <h4 className="text-sm font-semibold text-gray-700 mt-4 mb-2">Load Manifest</h4>
            <div className="space-y-2 mb-2">
              {shipmentItems.map((item, idx) => (
                <div key={idx} className="grid gap-2 items-center" style={{ gridTemplateColumns: '2fr 1fr 1fr 2fr auto' }}>
                  <input placeholder="Product *" value={item.ProductName} onChange={e => updateShipmentItem(idx, 'ProductName', e.target.value)} className={inputCls} />
                  <input placeholder="Qty" type="number" value={item.Quantity} onChange={e => updateShipmentItem(idx, 'Quantity', e.target.value)} className={inputCls} />
                  <input placeholder="Unit" value={item.Unit} onChange={e => updateShipmentItem(idx, 'Unit', e.target.value)} className={inputCls} />
                  <input placeholder="Recipient" value={item.Recipient} onChange={e => updateShipmentItem(idx, 'Recipient', e.target.value)} className={inputCls} />
                  <button onClick={() => removeShipmentItem(idx)} className="text-red-400 hover:text-red-600 text-lg font-bold px-1">×</button>
                </div>
              ))}
            </div>
            <button onClick={addShipmentItemRow} className="text-sm text-green-700 hover:underline font-semibold mb-4">+ Add item</button>

            <div className="flex justify-end gap-2 mt-2">
              <button onClick={() => setShowShipmentForm(false)} disabled={shipmentSaving} className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50">Cancel</button>
              <button onClick={saveShipment} disabled={shipmentSaving} className="regsubmit2 disabled:opacity-50" style={{ fontSize: '0.85rem', padding: '0.4rem 1.2rem' }}>
                {shipmentSaving ? 'Saving…' : 'Save Run'}</button>
            </div>
          </div>
        </div>
      )}

      {/* ── Maintenance form modal ─────────────────────────────────────────── */}
      {showMaintForm && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4" onClick={() => !maintSaving && setShowMaintForm(false)}>
          <div className="bg-white rounded-xl shadow-xl max-w-lg w-full p-6" onClick={e => e.stopPropagation()}>
            <h3 className="text-lg font-bold text-gray-900 mb-4">Log Service — {selected?.VehicleName}</h3>
            <div className="grid grid-cols-2 gap-3">
              <div><label className={labelCls}>Service Date *</label>
                <input type="date" value={maintForm.ServiceDate} onChange={e => setMaintForm(f => ({ ...f, ServiceDate: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Service Type *</label>
                <select value={maintForm.ServiceType} onChange={e => setMaintForm(f => ({ ...f, ServiceType: e.target.value }))} className={inputCls}>
                  <option value="">Select…</option>
                  {SERVICE_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
                </select></div>
              <div><label className={labelCls}>Service Provider</label>
                <input type="text" value={maintForm.ServiceProvider} onChange={e => setMaintForm(f => ({ ...f, ServiceProvider: e.target.value }))} className={inputCls} placeholder="Shop / company name" /></div>
              <div><label className={labelCls}>Technician</label>
                <input type="text" value={maintForm.Technician} onChange={e => setMaintForm(f => ({ ...f, Technician: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Cost ($)</label>
                <input type="number" step="0.01" value={maintForm.Cost} onChange={e => setMaintForm(f => ({ ...f, Cost: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Odometer (miles)</label>
                <input type="number" value={maintForm.OdometerMiles} onChange={e => setMaintForm(f => ({ ...f, OdometerMiles: e.target.value }))} className={inputCls} /></div>
              <div><label className={labelCls}>Next Service Date</label>
                <input type="date" value={maintForm.NextServiceDate} onChange={e => setMaintForm(f => ({ ...f, NextServiceDate: e.target.value }))} className={inputCls} /></div>
              <div className="col-span-2"><label className={labelCls}>Notes</label>
                <textarea value={maintForm.Notes} onChange={e => setMaintForm(f => ({ ...f, Notes: e.target.value }))} rows={3} className={inputCls} placeholder="Work performed, parts replaced, findings…" /></div>
            </div>
            <div className="flex justify-end gap-2 mt-5">
              <button onClick={() => setShowMaintForm(false)} disabled={maintSaving} className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50">Cancel</button>
              <button onClick={saveMaintenance} disabled={maintSaving} className="regsubmit2 disabled:opacity-50" style={{ fontSize: '0.85rem', padding: '0.4rem 1.2rem' }}>
                {maintSaving ? 'Saving…' : 'Save Record'}</button>
            </div>
          </div>
        </div>
      )}

      <Footer />
    </div>
  );
}
