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
  const t = parseFloat(temp);
  const lo = parseFloat(min);
  const hi = parseFloat(max);
  const ok = t >= lo && t <= hi;
  return (
    <span className={`inline-block px-2 py-0.5 rounded text-xs font-semibold ${ok ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
      {fmtTemp(t)} {ok ? '✓' : '⚠ Out of range'}
    </span>
  );
}

const BLANK_VEHICLE = { VehicleName: '', LicensePlate: '', DriverName: '', DriverPhone: '', MinTempC: -2, MaxTempC: 7 };
const BLANK_READING = { TempC: '', Humidity: '', LocationDesc: '', Notes: '' };

export default function ColdChain() {
  const [params] = useSearchParams();
  const navigate = useNavigate();
  const businessId = params.get('BusinessID');

  const [vehicles, setVehicles] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState(null); // vehicle object
  const [readings, setReadings] = useState([]);
  const [readingsLoading, setReadingsLoading] = useState(false);

  const [showVehicleForm, setShowVehicleForm] = useState(false);
  const [vehicleForm, setVehicleForm] = useState(BLANK_VEHICLE);
  const [editingVehicleId, setEditingVehicleId] = useState(null);
  const [vehicleSaving, setVehicleSaving] = useState(false);

  const [showReadingForm, setShowReadingForm] = useState(false);
  const [readingForm, setReadingForm] = useState(BLANK_READING);
  const [readingSaving, setReadingSaving] = useState(false);

  const [error, setError] = useState('');

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

  const selectVehicle = (v) => {
    setSelected(v);
    setReadings([]);
    setShowReadingForm(false);
    loadReadings(v.VehicleID);
  };

  const openAddVehicle = () => {
    setVehicleForm(BLANK_VEHICLE);
    setEditingVehicleId(null);
    setShowVehicleForm(true);
  };

  const openEditVehicle = (v) => {
    setVehicleForm({
      VehicleName: v.VehicleName || '',
      LicensePlate: v.LicensePlate || '',
      DriverName: v.DriverName || '',
      DriverPhone: v.DriverPhone || '',
      MinTempC: v.MinTempC ?? -2,
      MaxTempC: v.MaxTempC ?? 7,
    });
    setEditingVehicleId(v.VehicleID);
    setShowVehicleForm(true);
  };

  const saveVehicle = async () => {
    if (!vehicleForm.VehicleName.trim()) { setError('Vehicle name is required.'); return; }
    setVehicleSaving(true);
    setError('');
    try {
      const url = editingVehicleId
        ? `${API}/api/cold-chain/vehicles/${editingVehicleId}`
        : `${API}/api/cold-chain/vehicles`;
      const method = editingVehicleId ? 'PUT' : 'POST';
      const body = editingVehicleId ? vehicleForm : { ...vehicleForm, BusinessID: parseInt(businessId) };
      const res = await fetch(url, { method, headers: authHeaders(), body: JSON.stringify(body) });
      if (!res.ok) throw new Error('Save failed');
      setShowVehicleForm(false);
      await loadVehicles();
      if (selected && editingVehicleId === selected.VehicleID) {
        setSelected(prev => ({ ...prev, ...vehicleForm }));
      }
    } catch (e) { setError(e.message || 'Save failed.'); }
    finally { setVehicleSaving(false); }
  };

  const deleteVehicle = async (vehicleId) => {
    if (!window.confirm('Delete this vehicle and all its readings?')) return;
    try {
      await fetch(`${API}/api/cold-chain/vehicles/${vehicleId}`, { method: 'DELETE', headers: authHeaders() });
      if (selected?.VehicleID === vehicleId) setSelected(null);
      await loadVehicles();
    } catch { setError('Delete failed.'); }
  };

  const saveReading = async () => {
    if (!readingForm.TempC && readingForm.TempC !== 0) { setError('Temperature is required.'); return; }
    setReadingSaving(true);
    setError('');
    try {
      const res = await fetch(`${API}/api/cold-chain/vehicles/${selected.VehicleID}/readings`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({
          TempC: parseFloat(readingForm.TempC),
          Humidity: readingForm.Humidity ? parseFloat(readingForm.Humidity) : null,
          LocationDesc: readingForm.LocationDesc || null,
          Notes: readingForm.Notes || null,
        }),
      });
      if (!res.ok) throw new Error('Save failed');
      setReadingForm(BLANK_READING);
      setShowReadingForm(false);
      await loadReadings(selected.VehicleID);
      await loadVehicles();
    } catch (e) { setError(e.message || 'Save failed.'); }
    finally { setReadingSaving(false); }
  };

  return (
    <div className="min-h-screen font-sans">
      <PageMeta title="Cold Chain Tracking | Oatmeal Farm Network" description="Monitor vehicle temperatures and GPS for cold chain logistics." noIndex />
      <Header />
      <div className="container mx-auto px-4 py-8" style={{ maxWidth: 1300 }}>
        <Breadcrumbs items={[{ label: 'Home', to: '/' }, { label: 'Cold Chain Tracking' }]} />
        <div className="flex items-center justify-between mb-6 pb-3 border-b-2 border-gray-200">
          <h2 className="text-2xl font-bold text-gray-800">Cold Chain & Logistics Tracking</h2>
          <button onClick={openAddVehicle} className="regsubmit2" style={{ fontSize: '0.85rem', padding: '0.4rem 1rem' }}>
            + Add Vehicle
          </button>
        </div>

        {error && (
          <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-2 text-sm mb-4">
            {error} <button onClick={() => setError('')} className="ml-2 font-bold">✕</button>
          </div>
        )}

        <div className="flex gap-6" style={{ alignItems: 'flex-start' }}>
          {/* Vehicle list */}
          <div style={{ width: 320, flexShrink: 0 }}>
            <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Vehicles</h3>
            {loading ? (
              <p className="text-gray-400 text-sm">Loading…</p>
            ) : vehicles.length === 0 ? (
              <p className="text-gray-400 text-sm">No vehicles yet. Add one above.</p>
            ) : (
              <div className="space-y-2">
                {vehicles.map(v => (
                  <div
                    key={v.VehicleID}
                    onClick={() => selectVehicle(v)}
                    className={`rounded-lg border p-3 cursor-pointer transition-all ${selected?.VehicleID === v.VehicleID ? 'border-[#3D6B34] bg-green-50' : 'border-gray-200 bg-white hover:border-gray-300'}`}
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <p className="font-semibold text-gray-800 text-sm">{v.VehicleName}</p>
                        {v.LicensePlate && <p className="text-xs text-gray-500">{v.LicensePlate}</p>}
                        {v.DriverName && <p className="text-xs text-gray-500">Driver: {v.DriverName}</p>}
                      </div>
                      <div className="flex gap-1 flex-shrink-0">
                        <button onClick={e => { e.stopPropagation(); openEditVehicle(v); }} className="text-gray-400 hover:text-gray-700 text-xs px-1">Edit</button>
                        <button onClick={e => { e.stopPropagation(); deleteVehicle(v.VehicleID); }} className="text-red-400 hover:text-red-600 text-xs px-1">Del</button>
                      </div>
                    </div>
                    <div className="mt-2">
                      <TempBadge temp={v.LatestTempC} min={v.MinTempC} max={v.MaxTempC} />
                      {v.LatestReadingAt && <p className="text-xs text-gray-400 mt-1">{fmtDateTime(v.LatestReadingAt)}</p>}
                    </div>
                    <p className="text-xs text-gray-400 mt-1">Range: {fmtTemp(v.MinTempC)} – {fmtTemp(v.MaxTempC)}</p>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Right panel */}
          <div className="flex-1">
            {!selected ? (
              <div className="text-center py-20 text-gray-400">
                <p>Select a vehicle to view its readings</p>
              </div>
            ) : (
              <>
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-lg font-bold text-gray-800">{selected.VehicleName} — Readings</h3>
                  <button onClick={() => setShowReadingForm(f => !f)} className="regsubmit2" style={{ fontSize: '0.82rem', padding: '0.35rem 0.9rem' }}>
                    + Log Reading
                  </button>
                </div>

                {showReadingForm && (
                  <div className="bg-gray-50 border border-gray-200 rounded-lg p-4 mb-4">
                    <h4 className="text-sm font-semibold text-gray-700 mb-3">New Reading</h4>
                    <div className="grid grid-cols-2 gap-3 mb-3">
                      <div>
                        <label className="block text-xs font-medium text-gray-600 mb-1">Temperature (°C) *</label>
                        <input type="number" step="0.1" value={readingForm.TempC}
                          onChange={e => setReadingForm(f => ({ ...f, TempC: e.target.value }))}
                          className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
                      </div>
                      <div>
                        <label className="block text-xs font-medium text-gray-600 mb-1">Humidity (%)</label>
                        <input type="number" step="0.1" value={readingForm.Humidity}
                          onChange={e => setReadingForm(f => ({ ...f, Humidity: e.target.value }))}
                          className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
                      </div>
                    </div>
                    <div className="mb-3">
                      <label className="block text-xs font-medium text-gray-600 mb-1">Location / Stop Description</label>
                      <input type="text" value={readingForm.LocationDesc}
                        onChange={e => setReadingForm(f => ({ ...f, LocationDesc: e.target.value }))}
                        className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" placeholder="e.g. Distribution center, Mile 12 on Hwy 1" />
                    </div>
                    <div className="mb-3">
                      <label className="block text-xs font-medium text-gray-600 mb-1">Notes</label>
                      <textarea value={readingForm.Notes}
                        onChange={e => setReadingForm(f => ({ ...f, Notes: e.target.value }))}
                        rows={2} className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
                    </div>
                    <div className="flex gap-2">
                      <button onClick={saveReading} disabled={readingSaving}
                        className="regsubmit2 disabled:opacity-50" style={{ fontSize: '0.82rem', padding: '0.35rem 0.9rem' }}>
                        {readingSaving ? 'Saving…' : 'Save Reading'}
                      </button>
                      <button onClick={() => setShowReadingForm(false)}
                        className="border border-gray-300 rounded px-3 py-1.5 text-sm text-gray-600 hover:bg-gray-50">
                        Cancel
                      </button>
                    </div>
                  </div>
                )}

                {readingsLoading ? (
                  <p className="text-gray-400 text-sm">Loading readings…</p>
                ) : readings.length === 0 ? (
                  <p className="text-gray-400 text-sm">No readings yet for this vehicle.</p>
                ) : (
                  <div className="overflow-auto rounded-lg border border-gray-200">
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                      <thead>
                        <tr className="bg-gray-50">
                          {['Recorded At', 'Temp', 'Humidity', 'Status', 'Location', 'Notes'].map(h => (
                            <th key={h} style={{ padding: '0.6rem 0.75rem', textAlign: 'left', fontSize: '0.72rem', fontWeight: 600, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.05em', borderBottom: '1px solid #E5E7EB' }}>{h}</th>
                          ))}
                        </tr>
                      </thead>
                      <tbody>
                        {readings.map((r, i) => {
                          const t = parseFloat(r.TempC);
                          const ok = t >= parseFloat(selected.MinTempC) && t <= parseFloat(selected.MaxTempC);
                          return (
                            <tr key={r.ReadingID} style={{ backgroundColor: i % 2 === 0 ? '#fff' : '#fafafa', borderBottom: '1px solid #F3F4F6' }}>
                              <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.82rem', color: '#374151' }}>{fmtDateTime(r.RecordedAt)}</td>
                              <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.82rem', fontWeight: 600, color: ok ? '#15803d' : '#dc2626' }}>{fmtTemp(r.TempC)}</td>
                              <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.82rem', color: '#6B7280' }}>{r.Humidity != null ? `${r.Humidity}%` : '—'}</td>
                              <td style={{ padding: '0.6rem 0.75rem' }}>
                                <span className={`inline-block px-1.5 py-0.5 rounded text-xs font-semibold ${ok ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                                  {ok ? 'OK' : 'Alert'}
                                </span>
                              </td>
                              <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.82rem', color: '#6B7280', maxWidth: 180 }}>{r.LocationDesc || '—'}</td>
                              <td style={{ padding: '0.6rem 0.75rem', fontSize: '0.82rem', color: '#6B7280', maxWidth: 200 }}>{r.Notes || '—'}</td>
                            </tr>
                          );
                        })}
                      </tbody>
                    </table>
                  </div>
                )}
              </>
            )}
          </div>
        </div>
      </div>

      {/* Vehicle form modal */}
      {showVehicleForm && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4" onClick={() => !vehicleSaving && setShowVehicleForm(false)}>
          <div className="bg-white rounded-xl shadow-xl max-w-md w-full p-6" onClick={e => e.stopPropagation()}>
            <h3 className="text-lg font-bold text-gray-900 mb-4">{editingVehicleId ? 'Edit Vehicle' : 'Add Vehicle'}</h3>
            <div className="space-y-3">
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1">Vehicle Name *</label>
                <input type="text" value={vehicleForm.VehicleName}
                  onChange={e => setVehicleForm(f => ({ ...f, VehicleName: e.target.value }))}
                  className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" placeholder="e.g. Truck 1 – Refrigerated" />
              </div>
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1">License Plate</label>
                <input type="text" value={vehicleForm.LicensePlate}
                  onChange={e => setVehicleForm(f => ({ ...f, LicensePlate: e.target.value }))}
                  className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-medium text-gray-600 mb-1">Driver Name</label>
                  <input type="text" value={vehicleForm.DriverName}
                    onChange={e => setVehicleForm(f => ({ ...f, DriverName: e.target.value }))}
                    className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-gray-600 mb-1">Driver Phone</label>
                  <input type="text" value={vehicleForm.DriverPhone}
                    onChange={e => setVehicleForm(f => ({ ...f, DriverPhone: e.target.value }))}
                    className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-medium text-gray-600 mb-1">Min Temp (°C)</label>
                  <input type="number" step="0.5" value={vehicleForm.MinTempC}
                    onChange={e => setVehicleForm(f => ({ ...f, MinTempC: e.target.value }))}
                    className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-gray-600 mb-1">Max Temp (°C)</label>
                  <input type="number" step="0.5" value={vehicleForm.MaxTempC}
                    onChange={e => setVehicleForm(f => ({ ...f, MaxTempC: e.target.value }))}
                    className="border border-gray-300 rounded px-3 py-1.5 text-sm w-full" />
                </div>
              </div>
            </div>
            <div className="flex justify-end gap-2 mt-5">
              <button onClick={() => setShowVehicleForm(false)} disabled={vehicleSaving}
                className="border border-gray-300 rounded px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50">
                Cancel
              </button>
              <button onClick={saveVehicle} disabled={vehicleSaving}
                className="regsubmit2 disabled:opacity-50" style={{ fontSize: '0.85rem', padding: '0.4rem 1.2rem' }}>
                {vehicleSaving ? 'Saving…' : 'Save'}
              </button>
            </div>
          </div>
        </div>
      )}

      <Footer />
    </div>
  );
}
