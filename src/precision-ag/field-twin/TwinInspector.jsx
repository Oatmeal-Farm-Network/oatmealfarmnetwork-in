import React from 'react';

const PROVENANCE_STYLES = {
  observed: { bg: '#DCFCE7', color: '#166534', label: 'Observed' },
  derived: { bg: '#DBEAFE', color: '#1E40AF', label: 'Derived' },
  modeled: { bg: '#FEF3C7', color: '#92400E', label: 'Estimated' },
  estimated: { bg: '#FEF3C7', color: '#92400E', label: 'Estimated' },
  recorded: { bg: '#EDE9FE', color: '#5B21B6', label: 'Recorded' },
  none: { bg: '#F3F4F6', color: '#6B7280', label: 'Unavailable' },
};

function Badge({ provenance }) {
  const s = PROVENANCE_STYLES[provenance] || PROVENANCE_STYLES.none;
  return (
    <span
      className="inline-block px-2 py-0.5 rounded-full text-[10px] font-mont font-bold uppercase tracking-wide"
      style={{ background: s.bg, color: s.color }}
    >
      {s.label}
    </span>
  );
}

function Row({ label, value, unit }) {
  if (value == null || value === '') return null;
  return (
    <div className="flex justify-between gap-3 py-1 border-b border-gray-100 last:border-0">
      <span className="font-mont text-xs text-gray-500">{label}</span>
      <span className="font-mont text-xs font-semibold text-gray-800 text-right">
        {typeof value === 'number' && Number.isFinite(value)
          ? (Number.isInteger(value) ? value : value.toFixed?.(2) ?? value)
          : value}
        {unit ? ` ${unit}` : ''}
      </span>
    </div>
  );
}

/** Prefer hotspot GPS; fall back to field center and mark approximate. */
export function enrichHotspotPick(pick, snapshot) {
  const lat = Number(pick?.latitude);
  const lon = Number(pick?.longitude);
  if (Number.isFinite(lat) && Number.isFinite(lon)) {
    return { ...pick, latitude: lat, longitude: lon, coords_approx: false };
  }
  const flat = Number(snapshot?.field?.latitude ?? snapshot?.local_origin?.latitude);
  const flon = Number(snapshot?.field?.longitude ?? snapshot?.local_origin?.longitude);
  if (Number.isFinite(flat) && Number.isFinite(flon)) {
    return {
      ...pick,
      latitude: flat,
      longitude: flon,
      coords_approx: true,
    };
  }
  return { ...pick, coords_approx: true };
}

/**
 * Side panel for selected features — always shows provenance + confidence.
 */
export default function TwinInspector({
  pick,
  snapshot,
  onClose,
  businessId = null,
  fieldId = null,
  onHotspotAction = null,
}) {
  if (!pick && !snapshot) return null;

  const labels = snapshot?.rendering_hints?.labels || {};
  const growth = snapshot?.crop?.growth;
  const weather = snapshot?.weather?.current;
  const irrigation = snapshot?.irrigation;
  const moisture = snapshot?.soil_moisture;
  const vegetation = snapshot?.vegetation;
  const waterUse = snapshot?.water_use;
  const validation = snapshot?.crop?.validation;
  const recordedCrop = snapshot?.crop?.recorded_crop_type || snapshot?.crop?.crop_type;

  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4 space-y-3 xl:sticky xl:top-3 max-h-[640px] overflow-y-auto">
      <div className="flex items-start justify-between gap-2">
        <div>
          <div className="font-lora text-base font-bold text-gray-900">
            {pick?.label || 'Field overview'}
          </div>
          <div className="mt-1 flex items-center gap-2">
            <Badge provenance={pick?.provenance || 'derived'} />
            {pick?.confidence && (
              <span className="font-mont text-[10px] text-gray-400 uppercase">
                confidence: {pick.confidence}
              </span>
            )}
          </div>
        </div>
        {onClose && pick && (
          <button
            type="button"
            onClick={onClose}
            className="text-gray-400 hover:text-gray-700 font-mont text-xs"
          >
            Clear
          </button>
        )}
      </div>

      {pick?.note && (
        <p className="font-mont text-xs text-amber-800 bg-amber-50 border border-amber-100 rounded-lg p-2">
          {pick.note}
        </p>
      )}

      {pick?.kind === 'soil_horizon' && (
        <div>
          <Row label="Depth band" value={pick.label} />
          <Row label="Top" value={pick.top_cm} unit="cm" />
          <Row label="Bottom" value={pick.bottom_cm} unit="cm" />
          <Row label="Thickness" value={pick.depth_m != null ? pick.depth_m * 100 : null} unit="cm" />
          <Row label="pH" value={pick.ph} />
          <Row label="Organic matter" value={pick.organic_matter_pct} unit="%" />
          <Row label="Clay" value={pick.clay_pct} unit="%" />
          <Row label="Sand" value={pick.sand_pct} unit="%" />
          <Row label="Silt" value={pick.silt_pct} unit="%" />
          <Row label="Source" value={pick.source} />
        </div>
      )}

      {pick?.kind === 'soil_sample' && (
        <div className="space-y-2">
          <Row label="Sample date" value={pick.sample_date} />
          <Row label="Depth" value={pick.depth_cm} unit="cm" />
          <Row label="pH" value={pick.ph} />
          <Row label="Organic matter" value={pick.organic_matter} unit="%" />
          <Row label="N" value={pick.nitrogen} />
          <Row label="P" value={pick.phosphorus} />
          <Row label="K" value={pick.potassium} />
          {fieldId && businessId && (
            <a
              href={`/precision-ag/soil-samples?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(fieldId)}`}
              className="inline-flex px-2.5 py-1.5 rounded-lg text-[11px] font-mont font-semibold bg-amber-50 text-amber-950 border border-amber-200"
            >
              Open soil samples
            </a>
          )}
        </div>
      )}

      {pick?.kind === 'scout' && (
        <div>
          <Row label="Severity" value={pick.severity} />
          <Row label="Observed" value={pick.observed_at} />
          <Row label="Notes" value={pick.notes} />
        </div>
      )}

      {pick?.kind === 'scenario_hotspot' && (
        <div className="space-y-2">
          <Row label="Relative risk" value={pick.risk} />
          <Row label="Band" value={pick.band} />
          <Row label="Latitude" value={pick.latitude} />
          <Row label="Longitude" value={pick.longitude} />
          <Row label="Rainfall" value={pick.rainfall_mm} unit="mm" />
          <Row label="Irrigation" value={pick.irrigation_mm} unit="mm" />
          <Row label="Duration" value={pick.duration_hours} unit="h" />
          <Row label="Access risk" value={pick.access_risk} />
          <p className="font-mont text-[11px] text-amber-800 bg-amber-50 border border-amber-100 rounded-lg p-2 mt-2">
            Screening-grade modeled hotspot — not flood depth. Verify on site before changing traffic or irrigation.
          </p>
          {onHotspotAction && (
            <div className="flex flex-wrap gap-2 pt-1">
              <button
                type="button"
                className="px-2.5 py-1.5 rounded-lg text-[11px] font-mont font-semibold bg-[#6D8E22] text-white"
                onClick={() => onHotspotAction({
                  type: 'scout',
                  pick: enrichHotspotPick(pick, snapshot),
                })}
              >
                Create scout here
              </button>
              <button
                type="button"
                className="px-2.5 py-1.5 rounded-lg text-[11px] font-mont font-semibold border border-gray-300 text-gray-800"
                onClick={() => onHotspotAction({
                  type: 'work_order',
                  pick: enrichHotspotPick(pick, snapshot),
                })}
                disabled={!businessId}
                title={businessId ? undefined : 'Business ID required'}
              >
                Draft work order
              </button>
              <button
                type="button"
                className="px-2.5 py-1.5 rounded-lg text-[11px] font-mont font-semibold border border-sky-300 text-sky-900 bg-sky-50"
                onClick={() => onHotspotAction({
                  type: 'irrigate',
                  pick: enrichHotspotPick(pick, snapshot),
                })}
                disabled={!businessId}
                title={businessId ? undefined : 'Business ID required'}
              >
                Draft canal/borewell check
              </button>
            </div>
          )}
        </div>
      )}

      {pick?.kind === 'crop' && (
        <div>
          <Row label="Growth stage" value={pick.stage} />
          <Row label="Modeled height" value={pick.modeled_height_m ?? pick.height_m} unit="m" />
          <Row label="Visual samples" value={pick.visual_sample_count ?? pick.count} />
          <Row label="NDVI (sample)" value={pick.ndvi} />
          <Row label="NDVI mean (samples)" value={pick.ndvi_mean} />
          <Row label="Source" value={pick.source} />
          <Row label="Acquired" value={pick.acquired_at} />
          <Row label="Resolution" value={pick.spatial_resolution_m} unit="m" />
        </div>
      )}

      {!pick && snapshot && (
        <div className="space-y-2">
          <div className="font-mont text-xs font-semibold text-gray-600 uppercase tracking-wide">
            Field snapshot
          </div>
          <Row label="Recorded crop" value={recordedCrop} />
          <Row label="Canopy crop" value={snapshot.crop?.crop_type} />
          <Row label="Crop source" value={snapshot.crop?.selected_source} />
          <Row label="Season" value={
            snapshot.selection?.india_season?.label
              ? `${snapshot.selection.india_season.label} (${snapshot.selection.india_season.months})`
              : snapshot.selection?.effective_year
          } />
          <div className="flex justify-between items-center py-1">
            <span className="font-mont text-xs text-gray-500">Crop status</span>
            <Badge provenance={validation?.provenance || 'recorded'} />
          </div>
          {validation?.note && (
            <p className="font-mont text-[11px] text-violet-800 bg-violet-50 border border-violet-100 rounded-lg p-2">
              {validation.note}
            </p>
          )}
          {(snapshot.crop_history?.cdl_years || []).length > 0 && (
            <>
              <div className="font-mont text-xs font-semibold text-gray-600 uppercase tracking-wide pt-2">
                Recent CDL years
              </div>
              {(snapshot.crop_history.cdl_years || []).slice(0, 6).map((row) => (
                <Row key={row.year} label={String(row.year)} value={row.crop} />
              ))}
            </>
          )}
          <Row label="Growth stage" value={growth?.stage} />
          <div className="flex justify-between items-center py-1">
            <span className="font-mont text-xs text-gray-500">Growth provenance</span>
            <Badge provenance={growth?.provenance || 'modeled'} />
          </div>
          <Row label="Soil moisture" value={moisture?.level} />
          <div className="flex justify-between items-center py-1">
            <span className="font-mont text-xs text-gray-500">Moisture provenance</span>
            <Badge provenance={moisture?.provenance || 'none'} />
          </div>
          {(snapshot.soil_cutaway?.available || snapshot.soil_samples?.count > 0) && (
            <>
              <div className="font-mont text-xs font-semibold text-gray-600 uppercase tracking-wide pt-2">
                Lab soil first
              </div>
              <Row label="Lab samples" value={snapshot.soil_samples?.count} />
              <Row label="Located samples" value={snapshot.soil_samples?.located_count} />
              <Row label="Unlocated samples" value={snapshot.soil_samples?.unlocated_count} />
              <Row label="pH (lab)" value={snapshot.soil_cutaway?.measured_summary?.ph_mean} />
              <Row label="OM (lab)" value={snapshot.soil_cutaway?.measured_summary?.organic_matter_mean} unit="%" />
              <p className="font-mont text-[11px] text-gray-500">
                SoilGrids is a regional estimate ({(snapshot.soil_cutaway?.layers || []).length} bands) — not a substitute for GPS lab cores.
              </p>
              {snapshot.soil_cutaway?.note && (
                <p className="font-mont text-[11px] text-gray-500">{snapshot.soil_cutaway.note}</p>
              )}
              {(snapshot.soil_samples?.unlocated_samples || []).length > 0 && (
                <>
                  <div className="font-mont text-xs font-semibold text-gray-600 uppercase tracking-wide pt-2">
                    Unlocated lab samples
                  </div>
                  <p className="font-mont text-[11px] text-amber-800 bg-amber-50 border border-amber-100 rounded-lg p-2">
                    These samples have no GPS pin and are not shown on the twin.
                  </p>
                  {(snapshot.soil_samples.unlocated_samples || []).slice(0, 8).map((s) => (
                    <Row
                      key={s.sample_id}
                      label={s.sample_label || s.sample_date || `Sample ${s.sample_id}`}
                      value={[
                        s.ph != null ? `pH ${s.ph}` : null,
                        s.organic_matter != null ? `OM ${s.organic_matter}%` : null,
                        s.depth_cm != null ? `${s.depth_cm} cm` : null,
                      ].filter(Boolean).join(' · ') || '—'}
                    />
                  ))}
                </>
              )}
            </>
          )}
          <Row label="Air temp" value={weather?.temp_c ?? weather?.temp_f} unit={weather?.temp_c != null ? '°C' : '°F'} />
          <Row label="Wind" value={weather?.wind_kmh ?? weather?.wind_mph} unit={weather?.wind_kmh != null ? 'km/h' : 'mph'} />
          {snapshot.weather?.fetched_at && (
            <Row label="Weather fetched" value={snapshot.weather.fetched_at} />
          )}
          {snapshot.weather?.coverage && (
            <Row label="Weather coverage" value={snapshot.weather.coverage} />
          )}
          <Row label="Irrigation" value={irrigation?.recommendation} />
          <Row label="Water deficit" value={irrigation?.cumulative_deficit_mm ?? irrigation?.cumulative_deficit_in} unit={irrigation?.units || 'mm'} />
          {vegetation?.available && (
            <>
              <div className="font-mont text-xs font-semibold text-gray-600 uppercase tracking-wide pt-2">
                Vegetation grid
              </div>
              <Row label="Source" value={vegetation.source} />
              <Row label="Acquired" value={vegetation.acquired_at} />
              <Row label="Cloud cover" value={vegetation.cloud_percent} unit="%" />
              <Row label="Grid resolution" value={vegetation.spatial_resolution_m} unit="m" />
              <div className="flex justify-between items-center py-1">
                <span className="font-mont text-xs text-gray-500">Vegetation provenance</span>
                <Badge provenance={vegetation.provenance || 'derived'} />
              </div>
            </>
          )}
          {!vegetation?.available && (
            <p className="font-mont text-[11px] text-amber-800 bg-amber-50 border border-amber-100 rounded-lg p-2">
              No spatial NDVI/NDWI grid — canopy is illustrative only.
            </p>
          )}
          {waterUse?.available && (
            <>
              <div className="font-mont text-xs font-semibold text-gray-600 uppercase tracking-wide pt-2">
                Water use (satellite)
              </div>
              <Row label="ETa" value={waterUse.eta_mm} unit="mm" />
              <Row label="Period" value={waterUse.period_date} />
              <Row label="Source" value={waterUse.source} />
              <div className="flex justify-between items-center py-1">
                <span className="font-mont text-xs text-gray-500">ET provenance</span>
                <Badge provenance={waterUse.provenance || 'derived'} />
              </div>
              {waterUse.note && (
                <p className="font-mont text-[11px] text-gray-500">{waterUse.note}</p>
              )}
            </>
          )}
          {growth?.note && (
            <p className="font-mont text-[11px] text-gray-500 mt-1">{growth.note}</p>
          )}
          {moisture?.note && (
            <p className="font-mont text-[11px] text-gray-500">{moisture.note}</p>
          )}
          {snapshot.weather?.note && (
            <p className="font-mont text-[11px] text-gray-500">{snapshot.weather.note}</p>
          )}
          {snapshot.rendering_hints?.canopy?.note && (
            <p className="font-mont text-[11px] text-gray-500">
              {snapshot.rendering_hints.canopy.note}
            </p>
          )}
        </div>
      )}

      <div className="pt-2 border-t border-gray-100 space-y-1">
        <div className="font-mont text-[10px] text-gray-400 uppercase tracking-wide">Legend</div>
        {Object.entries(labels).map(([k, v]) => (
          <div key={k} className="flex items-start gap-2">
            <Badge provenance={k} />
            <span className="font-mont text-[10px] text-gray-500">{v}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
