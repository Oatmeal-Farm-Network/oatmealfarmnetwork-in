import React from 'react';
import { Link } from 'react-router-dom';
import { indiaSeasonFromDate } from './indiaSeason';
import { openWhatsAppText, shareFromFieldRow } from './fieldStatusShare';

/**
 * Kharif/Rabi/Zaid + crop + planting date — India crop map is the rotation / field record.
 */
export default function SeasonCropCard({ field, businessId, compact = false }) {
  if (!field) return null;
  const season = field.india_season || indiaSeasonFromDate();
  const crop = field.season_crop || field.rotation_crop || field.crop_type;
  const planted = field.season_planting_date || field.planting_date;
  const confirmed = Boolean(field.crop_confirmed);
  const fieldId = field.fieldid || field.id;
  const twinHref = businessId && fieldId
    ? `/precision-ag/geospatial?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(fieldId)}&tab=twin`
    : null;

  return (
    <div
      className={`rounded-xl border border-emerald-100 bg-emerald-50/70 ${compact ? 'px-2.5 py-2' : 'p-3'}`}
      data-testid="season-crop-card"
    >
      <div className="font-mont text-[10px] uppercase tracking-wide text-emerald-800 font-semibold">
        {season.label} · {season.months}
      </div>
      <div className={`font-lora font-bold text-gray-900 ${compact ? 'text-sm' : 'text-base'}`}>
        {crop || 'No crop recorded'}
      </div>
      <div className="font-mont text-[11px] text-gray-600 mt-0.5">
        {planted ? `Planted ${planted}` : 'No planting date'}
        {' · '}
        {confirmed ? 'Confirmed' : 'Needs confirm'}
      </div>
      {!compact && (
        <div className="flex flex-wrap gap-2 mt-2">
          {twinHref && (
            <Link
              to={twinHref}
              className="px-2.5 py-1 rounded-lg text-[11px] font-mont font-semibold bg-[#1E3A5F] text-white"
            >
              Open Field Twin
            </Link>
          )}
          <button
            type="button"
            className="px-2.5 py-1 rounded-lg text-[11px] font-mont font-semibold border border-emerald-300 text-emerald-950 bg-white"
            onClick={() => openWhatsAppText(shareFromFieldRow(field))}
          >
            WhatsApp card
          </button>
        </div>
      )}
    </div>
  );
}
