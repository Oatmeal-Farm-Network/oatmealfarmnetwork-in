import { useCallback, useEffect, useRef, useState } from 'react';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const fmt = (n) => (n == null ? '—' : Number(n).toLocaleString(undefined, { maximumFractionDigits: 0 }));
const fmtPct = (n) => (n == null ? '—' : `${Math.round(n * 100)}%`);
const fmtDate = (s) => {
  if (!s) return '—';
  try {
    return new Date(s).toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
  } catch {
    return s;
  }
};

function AnalysisCard({ title, data, thumb, loading, onRun, runLabel, uploadSlot }) {
  return (
    <div className="flex-1 min-w-0 bg-white border border-gray-200 rounded-lg p-3">
      <div className="flex items-center justify-between mb-2">
        <div className="text-xs font-semibold text-gray-700 uppercase tracking-wide">{title}</div>
        {onRun && (
          <button
            onClick={onRun}
            disabled={loading}
            className="text-xs px-2.5 py-1 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 disabled:bg-gray-300 disabled:cursor-not-allowed font-medium"
          >
            {loading ? 'Analyzing…' : runLabel}
          </button>
        )}
      </div>

      {data ? (
        <>
          {thumb && (
            <img
              src={thumb}
              alt={title}
              className="w-full aspect-video object-cover rounded mb-2 border border-gray-100"
              onError={(e) => { e.currentTarget.style.display = 'none'; }}
            />
          )}
          <div className="text-2xl font-bold text-gray-900 leading-tight">
            {fmt(data.biomass_kg_per_ha)}
            <span className="text-sm font-normal text-gray-500 ml-1">kg DM/ha</span>
          </div>
          <div className="mt-1 text-xs text-gray-500">
            Confidence {fmtPct(data.confidence)} · {fmtDate(data.captured_at)}
          </div>
          {data.model_version && (
            <div className="text-[10px] text-gray-400 mt-0.5">model {data.model_version}</div>
          )}
        </>
      ) : (
        <div className="text-xs text-gray-400 italic py-3">
          {loading ? 'Analyzing…' : 'No analysis yet'}
        </div>
      )}

      {uploadSlot}
    </div>
  );
}

export default function BiomassPanel({ fieldId, onClose }) {
  const [state, setState] = useState({ satellite: null, upload: null, history: [] });
  const [loadingSat, setLoadingSat] = useState(false);
  const [loadingUpload, setLoadingUpload] = useState(false);
  const [loadingResolve, setLoadingResolve] = useState(false);
  const [resolved, setResolved] = useState(null);
  const [error, setError] = useState('');
  const fileInputRef = useRef(null);

  const refresh = useCallback(async () => {
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/biomass`);
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      const data = await r.json();
      setState({
        satellite: data.satellite || null,
        upload: data.upload || null,
        history: data.history || [],
      });
    } catch (e) {
      console.warn('[BiomassPanel] refresh failed:', e);
    }
  }, [fieldId]);

  useEffect(() => {
    refresh();
  }, [refresh]);

  const runSatellite = async () => {
    setError('');
    setLoadingSat(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/biomass/satellite`, { method: 'POST' });
      if (!r.ok) {
        const txt = await r.text();
        throw new Error(txt || `HTTP ${r.status}`);
      }
      await refresh();
    } catch (e) {
      setError(`Satellite analysis failed: ${e.message || e}`);
    } finally {
      setLoadingSat(false);
    }
  };

  const runUpload = async (file) => {
    if (!file) return;
    setError('');
    setLoadingUpload(true);
    try {
      const fd = new FormData();
      fd.append('file', file);
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/biomass/upload`, {
        method: 'POST',
        body: fd,
      });
      if (!r.ok) {
        const txt = await r.text();
        throw new Error(txt || `HTTP ${r.status}`);
      }
      await refresh();
    } catch (e) {
      setError(`Upload analysis failed: ${e.message || e}`);
    } finally {
      setLoadingUpload(false);
      if (fileInputRef.current) fileInputRef.current.value = '';
    }
  };

  const resolveConfidence = async () => {
    setError('');
    setLoadingResolve(true);
    try {
      const r = await fetch(`${API_URL}/api/fields/${fieldId}/biomass/resolve`, { method: 'POST' });
      if (!r.ok) {
        const txt = await r.text();
        throw new Error(txt || `HTTP ${r.status}`);
      }
      const data = await r.json();
      setResolved(data);
      await refresh();
    } catch (e) {
      setError(`Could not improve confidence: ${e.message || e}`);
    } finally {
      setLoadingResolve(false);
    }
  };

  const bothExist = state.satellite && state.upload;
  const lowConfidence = state.satellite && state.satellite.confidence != null && state.satellite.confidence < 0.4;

  return (
    <div className="bg-gray-50 border border-gray-200 rounded-lg p-3 mt-3">
      <div className="flex items-center justify-between mb-3">
        <div className="font-semibold text-sm text-gray-800 flex items-center gap-1.5">
          <svg width="14" height="14" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" className="text-[#3D6B34]"><path d="M8 14V9"/><path d="M4 6c0-2.5 2-4 4-4s4 1.5 4 4-2 3-4 3-4-.5-4-3z"/></svg>
          Biomass Estimate
        </div>
        {onClose && (
          <button onClick={onClose} className="text-xs text-gray-500 hover:text-gray-700">
            Close
          </button>
        )}
      </div>

      {error && (
        <div className="mb-3 text-xs bg-red-50 border border-red-200 text-red-700 rounded px-2 py-1.5">
          {error}
        </div>
      )}

      <div className="flex flex-col sm:flex-row gap-3">
        <AnalysisCard
          title="Satellite"
          data={state.satellite}
          thumb={state.satellite?.image_url}
          loading={loadingSat}
          onRun={runSatellite}
          runLabel={state.satellite ? 'Re-run' : 'Analyze'}
        />
        <AnalysisCard
          title="Your photo"
          data={state.upload}
          thumb={state.upload?.image_url}
          loading={loadingUpload}
          uploadSlot={
            <div className="mt-2">
              <input
                ref={fileInputRef}
                type="file"
                accept="image/*"
                onChange={(e) => runUpload(e.target.files?.[0])}
                className="hidden"
                id={`biomass-upload-${fieldId}`}
              />
              <label
                htmlFor={`biomass-upload-${fieldId}`}
                className={`block w-full text-center text-xs px-2.5 py-1.5 rounded-md font-medium cursor-pointer ${
                  loadingUpload
                    ? 'bg-gray-300 text-gray-500 cursor-not-allowed'
                    : 'bg-indigo-600 text-white hover:bg-indigo-700'
                }`}
              >
                {loadingUpload ? 'Analyzing…' : (state.upload ? 'Upload another' : 'Upload photo')}
              </label>
            </div>
          }
        />
      </div>

      {bothExist && (
        <div className="mt-3 text-xs text-gray-600 bg-white border border-gray-200 rounded px-2.5 py-2">
          <span className="font-semibold">Combined:</span>{' '}
          avg {fmt((state.satellite.biomass_kg_per_ha + state.upload.biomass_kg_per_ha) / 2)} kg DM/ha
          {' · '}
          Δ {fmt(Math.abs(state.satellite.biomass_kg_per_ha - state.upload.biomass_kg_per_ha))} kg/ha between methods
        </div>
      )}

      {lowConfidence && (
        <div className="mt-3 text-xs bg-amber-50 border border-amber-200 text-amber-900 rounded px-2.5 py-2">
          <div className="flex items-start justify-between gap-3">
            <div>
              <div className="font-semibold mb-1 flex items-center gap-1">
                <svg width="13" height="13" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M8 2L1 14h14z"/><line x1="8" y1="7" x2="8" y2="10"/><circle cx="8" cy="12.5" r="0.6" fill="currentColor" stroke="none"/></svg>
                Low satellite confidence ({fmtPct(state.satellite.confidence)})
              </div>
              <div className="leading-relaxed">
                The NDVI signal is weak — usually because the canopy is sparse or the latest cloud-free
                pass was suboptimal. Averaging several recent satellite passes will reduce the noise and
                raise confidence.
              </div>
            </div>
            <button
              onClick={resolveConfidence}
              disabled={loadingResolve}
              className="shrink-0 text-xs px-2.5 py-1.5 rounded-md bg-amber-600 text-white hover:bg-amber-700 disabled:bg-gray-300 disabled:cursor-not-allowed font-medium"
            >
              {loadingResolve ? 'Working…' : 'Improve confidence'}
            </button>
          </div>
        </div>
      )}

      {resolved && (
        <div className="mt-3 text-xs bg-emerald-50 border border-emerald-200 text-emerald-900 rounded px-2.5 py-2">
          <div className="font-semibold mb-1 flex items-center gap-1">
            <svg width="13" height="13" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><polyline points="3,8 6,11 13,4"/></svg>
            Combined estimate from {resolved.n_samples} pass(es)
          </div>
          <div>
            {fmt(resolved.averaged_biomass_kg_per_ha)} kg DM/ha · confidence {fmtPct(resolved.averaged_confidence)}
          </div>
        </div>
      )}
    </div>
  );
}
