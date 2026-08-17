/** WhatsApp / clipboard card for a field — crop, season, satellite age, water, next action. */

export function formatMm(mm, digits = 0) {
  if (mm == null || Number.isNaN(Number(mm))) return '—';
  return `${Number(mm).toFixed(digits)} mm`;
}

export function openWhatsAppText(text) {
  if (!text) return;
  window.open(`https://wa.me/?text=${encodeURIComponent(text)}`, '_blank', 'noopener,noreferrer');
}

export function formatFieldStatusShare({
  name,
  crop,
  seasonLabel,
  plantingDate,
  cropConfirmed,
  satelliteAgeDays,
  deficitMm,
  nextAction,
  note,
} = {}) {
  const sat = satelliteAgeDays == null
    ? 'No satellite yet'
    : (Number(satelliteAgeDays) > 14
      ? `Satellite ${Number(satelliteAgeDays)}d stale — do not spray from this map`
      : `Satellite ${Number(satelliteAgeDays)}d old`);
  const water = deficitMm != null && Number(deficitMm) >= 4
    ? `${Number(deficitMm).toFixed(0)} mm short (estimate, not a schedule)`
    : 'Water about even (estimate)';
  const cropLine = [
    crop || 'Crop not recorded',
    seasonLabel || null,
    plantingDate ? `planted ${plantingDate}` : null,
    cropConfirmed ? 'confirmed' : 'needs confirm',
  ].filter(Boolean).join(' · ');
  return [
    `OFN field card — ${name || 'Field'}`,
    cropLine,
    sat,
    water,
    nextAction ? `Next: ${nextAction}` : null,
    note || 'Verify on site before spray, traffic, or canal/borewell changes.',
  ].filter(Boolean).join('\n');
}

export function shareFromSnapshot(snapshot, nextText) {
  const veg = snapshot?.vegetation || {};
  const irrig = snapshot?.irrigation || {};
  const deficit = irrig.deficit_mm ?? irrig.cumulative_deficit_mm;
  return formatFieldStatusShare({
    name: snapshot?.field?.name,
    crop: snapshot?.crop?.crop_type,
    seasonLabel: snapshot?.selection?.india_season?.label,
    plantingDate: snapshot?.crop?.planting_date || snapshot?.field?.planting_date,
    cropConfirmed: Boolean(snapshot?.crop?.confirmed),
    satelliteAgeDays: veg.age_days,
    deficitMm: deficit,
    nextAction: nextText,
  });
}

export function shareFromFieldRow(field) {
  const ageDays = field?.latest_analysis_date
    ? Math.round((Date.now() - new Date(field.latest_analysis_date).getTime()) / 86400000)
    : null;
  const stale = ageDays == null || ageDays > 14;
  const noBoundary = !field?.boundary_geojson;
  let next = 'Open Field Twin';
  if (noBoundary) next = 'Draw a boundary';
  else if (!field?.crop_type && !field?.rotation_crop) next = 'Record this season’s crop';
  else if (!field?.crop_confirmed) next = 'Confirm crop on Field Twin';
  else if (stale) next = 'Walk the field — satellite is stale';
  return formatFieldStatusShare({
    name: field?.name,
    crop: field?.season_crop || field?.rotation_crop || field?.crop_type,
    seasonLabel: field?.india_season?.label,
    plantingDate: field?.season_planting_date || field?.planting_date,
    cropConfirmed: Boolean(field?.crop_confirmed),
    satelliteAgeDays: ageDays,
    deficitMm: null,
    nextAction: next,
  });
}
