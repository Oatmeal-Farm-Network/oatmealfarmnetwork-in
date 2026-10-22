import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { API_URL, CROP_API_URL, authHeaders, safeFetch } from './precisionAgUtils';
import { BHUVAN_LULC_YEAR_LABEL } from './bhuvanLulc';

function Stat({ label, value, sub }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4">
      <div className="text-xs text-gray-500 uppercase tracking-wide">{label}</div>
      <div className="text-xl font-bold text-gray-900 mt-1">{value ?? '—'}</div>
      {sub && <div className="text-xs text-gray-500 mt-1">{sub}</div>}
    </div>
  );
}

export function FieldSatelliteHealthPanel({ fieldId, latestAnalysis, onRunAnalysis, analyzing }) {
  const [snap, setSnap] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      setLoading(true);
      const data = await safeFetch(`${CROP_API_URL}/api/fields/${fieldId}/crop-monitor`);
      if (!cancelled) {
        setSnap(data);
        setLoading(false);
      }
    })();
    return () => { cancelled = true; };
  }, [fieldId, latestAnalysis?.analysis_id]);

  const bhuvan = snap?.bhuvan;
  const primary = snap?.primary_source;
  const ndvi = latestAnalysis?.vegetation_indices?.find((i) => i.index_type === 'NDVI');

  return (
    <div className="bg-gradient-to-br from-emerald-50 to-white border border-emerald-200 rounded-xl p-5 mb-6">
      <div className="flex items-start justify-between gap-4 mb-4">
        <div>
          <h3 className="font-lora text-lg font-bold text-gray-900">Satellite & Land-Use Health</h3>
          <p className="text-sm text-gray-600 mt-1">
            <strong>Primary:</strong> ISRO Bhuvan LULC ({BHUVAN_LULC_YEAR_LABEL})
            {' · '}
            <strong>Backup:</strong> Copernicus Sentinel-2 NDVI
          </p>
        </div>
        <button
          type="button"
          onClick={onRunAnalysis}
          disabled={analyzing}
          className="px-3 py-2 rounded-lg text-sm font-semibold text-white disabled:opacity-50"
          style={{ background: '#819360' }}
        >
          {analyzing ? 'Running…' : 'Run Analysis'}
        </button>
      </div>

      {loading ? (
        <p className="text-sm text-gray-500">Loading Bhuvan land-use…</p>
      ) : (
        <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
          <Stat
            label="Bhuvan land use"
            value={bhuvan?.class_name || 'Unavailable'}
            sub={bhuvan?.class_name ? 'ISRO Bhuvan' : 'Will use Sentinel on Run Analysis'}
          />
          <Stat
            label="LULC health hint"
            value={snap?.lulc_status ? `${snap.lulc_health_score}%` : '—'}
            sub={snap?.lulc_status || '—'}
          />
          <Stat
            label="NDVI (Sentinel)"
            value={ndvi?.mean != null ? Number(ndvi.mean).toFixed(2) : '—'}
            sub={latestAnalysis?.satellite_acquired_at ? `Scene ${String(latestAnalysis.satellite_acquired_at).slice(0, 10)}` : 'Run analysis'}
          />
          <Stat
            label="Active source"
            value={primary === 'bhuvan-lulc-250k' ? 'Bhuvan' : primary === 'copernicus-sentinel2' ? 'Sentinel-2' : '—'}
            sub={latestAnalysis?.source || snap?.fallback_note?.slice(0, 60)}
          />
        </div>
      )}
    </div>
  );
}

export function FieldTraceabilityPanel({ fieldId, businessId, fieldName }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      setLoading(true);
      const res = await safeFetch(`${CROP_API_URL}/api/fields/${fieldId}/traceability-summary`);
      if (!cancelled) {
        setData(res);
        setLoading(false);
      }
    })();
    return () => { cancelled = true; };
  }, [fieldId]);

  if (loading) return <p className="text-sm text-gray-500 p-4">Loading traceability…</p>;

  const sprays = data?.spray_applications || [];
  const lots = data?.harvest_lots || [];
  const compliance = data?.trace_compliance || [];

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap gap-2">
        <Link to={`/spray-applications?BusinessID=${businessId}`} className="text-sm px-3 py-1.5 rounded-lg border border-blue-200 text-blue-800 bg-blue-50">Spray log</Link>
        <Link to="/perishable-trace" className="text-sm px-3 py-1.5 rounded-lg border border-purple-200 text-purple-800 bg-purple-50">Full traceability</Link>
        <Link to={`/packhouse?BusinessID=${businessId}`} className="text-sm px-3 py-1.5 rounded-lg border border-green-200 text-green-800 bg-green-50">Packhouse QC</Link>
      </div>

      <section>
        <h4 className="font-semibold text-gray-800 mb-2">Spray & input applications</h4>
        {sprays.length === 0 ? (
          <p className="text-sm text-gray-500">No spray records for {fieldName || 'this field'} yet.</p>
        ) : (
          <ul className="space-y-2">
            {sprays.map((s) => (
              <li key={s.id} className="text-sm border border-gray-200 rounded-lg p-3 bg-white">
                <strong>{String(s.date || '').slice(0, 10)}</strong> — {s.crop || 'Crop'} · {s.pest || 'Application'}
                {s.phi_date && <span className="text-gray-500"> · PHI until {String(s.phi_date).slice(0, 10)}</span>}
              </li>
            ))}
          </ul>
        )}
      </section>

      <section>
        <h4 className="font-semibold text-gray-800 mb-2">Harvest lots</h4>
        {lots.length === 0 ? (
          <p className="text-sm text-gray-500">No harvest lots linked to this field.</p>
        ) : (
          <ul className="space-y-2">
            {lots.map((l) => (
              <li key={l.lot_id} className="text-sm border border-gray-200 rounded-lg p-3 bg-white">
                <strong>{l.lot_number || `Lot ${l.lot_id}`}</strong> — {l.crop} · {l.quantity} {l.unit}
                <span className="text-gray-500"> · {String(l.harvest_date || '').slice(0, 10)}</span>
              </li>
            ))}
          </ul>
        )}
      </section>

      <section>
        <h4 className="font-semibold text-gray-800 mb-2">Trace compliance (pesticide / fertilizer)</h4>
        {compliance.length === 0 ? (
          <p className="text-sm text-gray-500">No compliance rows for this field block.</p>
        ) : (
          <ul className="space-y-2">
            {compliance.map((c) => (
              <li key={c.id} className="text-sm border border-gray-200 rounded-lg p-3 bg-white">
                <strong>{c.type}</strong> — {c.product} · {String(c.date || '').slice(0, 10)}
                {c.phi_days != null && <span className="text-gray-500"> · {c.phi_days}d withholding</span>}
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}
