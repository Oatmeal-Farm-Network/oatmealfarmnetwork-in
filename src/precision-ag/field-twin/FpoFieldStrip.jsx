import React, { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { indiaSeasonFromDate } from './indiaSeason';
import { openWhatsAppText, shareFromFieldRow } from './fieldStatusShare';

function fieldIssues(f) {
  const health = f.latest_health_score;
  const ageDays = f.latest_analysis_date
    ? Math.round((Date.now() - new Date(f.latest_analysis_date).getTime()) / 86400000)
    : null;
  const stale = ageDays == null || ageDays > 14;
  const noBoundary = !f.boundary_geojson;
  const noCrop = !(f.season_crop || f.rotation_crop || f.crop_type);
  let n = 0;
  if (noBoundary) n += 40;
  if (stale) n += 25;
  if (noCrop) n += 20;
  if (!f.crop_confirmed) n += 10;
  if (health == null) n += 15;
  else n += Math.max(0, 70 - Number(health));
  return { n, stale, ageDays, noBoundary, noCrop };
}

/**
 * Work queue: missing boundary, stale satellite (>14d), unconfirmed crop, then health.
 */
export default function FpoFieldStrip({
  fields = [],
  selectedFieldId,
  onSelectField,
  businessId = null,
  title = 'Work queue',
}) {
  const ranked = useMemo(() => {
    const list = [...(fields || [])];
    return list.sort((a, b) => fieldIssues(b).n - fieldIssues(a).n);
  }, [fields]);

  if (!ranked.length) return null;

  return (
    <div className="bg-white rounded-xl border border-gray-200 p-3" data-testid="fpo-field-strip">
      <div className="font-mont text-[10px] uppercase tracking-wide text-gray-500 font-semibold">
        {title}
      </div>
      <p className="font-mont text-[11px] text-gray-500 mt-0.5 mb-2">
        Fields that need a boundary, crop confirm, or a walk because satellite is older than 14 days.
      </p>
      <div className="flex gap-2 overflow-x-auto pb-1">
        {ranked.map((f) => {
          const id = String(f.fieldid || f.id);
          const active = String(selectedFieldId) === id;
          const { stale, ageDays, noBoundary, noCrop } = fieldIssues(f);
          const season = f.india_season || indiaSeasonFromDate();
          const crop = f.season_crop || f.rotation_crop || f.crop_type;
          const twinHref = businessId
            ? `/precision-ag/geospatial?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(id)}&tab=twin`
            : null;
          return (
            <div
              key={id}
              className={`shrink-0 min-w-[168px] rounded-lg border px-2.5 py-2 text-left ${
                active ? 'border-emerald-500 bg-emerald-50 ring-1 ring-emerald-400' : 'border-gray-200 bg-gray-50'
              }`}
            >
              <button
                type="button"
                onClick={() => onSelectField?.(id)}
                className="w-full text-left"
              >
                <div className="font-mont text-xs font-semibold text-gray-900 truncate">
                  {f.name || `Field ${id}`}
                </div>
                <div className="font-mont text-[10px] text-gray-500 mt-0.5">
                  {season.label} · {crop || 'No crop'}
                  {f.crop_confirmed ? '' : ' · unconfirmed'}
                </div>
                <div className={`font-mont text-[10px] mt-0.5 ${noBoundary || stale || noCrop ? 'text-amber-800' : 'text-emerald-800'}`}>
                  {noBoundary ? 'Draw boundary'
                    : noCrop ? 'Record crop'
                    : stale ? (ageDays == null ? 'No satellite yet' : `Satellite ${ageDays}d old`)
                    : `Image ${ageDays}d`}
                </div>
              </button>
              <div className="flex gap-1 mt-1.5">
                {twinHref && (
                  <Link
                    to={twinHref}
                    className="px-1.5 py-0.5 rounded text-[10px] font-mont font-semibold bg-[#1E3A5F] text-white"
                  >
                    Twin
                  </Link>
                )}
                <button
                  type="button"
                  className="px-1.5 py-0.5 rounded text-[10px] font-mont font-semibold border border-emerald-200 text-emerald-900 bg-white"
                  onClick={() => openWhatsAppText(shareFromFieldRow(f))}
                >
                  WhatsApp
                </button>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
