const KEY = (fieldId) => `oft:twin-play:v1:${fieldId}`;

export function saveTwinPlay(fieldId, payload) {
  if (!fieldId || !payload) return;
  try {
    localStorage.setItem(KEY(fieldId), JSON.stringify({
      rainfall_mm: Number(payload.rainfall_mm) || 0,
      irrigation_mm: Number(payload.irrigation_mm) || 0,
      duration_hours: Number(payload.duration_hours) || 6,
      infiltration_class: payload.infiltration_class || 'moderate',
      antecedent: payload.antecedent || 'wet',
      label: payload.label || payload.preset_id || 'saved_play',
      saved_at: new Date().toISOString(),
    }));
  } catch { /* ignore quota */ }
}

export function loadTwinPlay(fieldId) {
  if (!fieldId) return null;
  try {
    const raw = localStorage.getItem(KEY(fieldId));
    if (!raw) return null;
    const j = JSON.parse(raw);
    if (!j || (Number(j.rainfall_mm) + Number(j.irrigation_mm) <= 0)) return null;
    return j;
  } catch {
    return null;
  }
}

export function playLabel(play) {
  if (!play) return '';
  const rain = Number(play.rainfall_mm) || 0;
  const irrig = Number(play.irrigation_mm) || 0;
  if (irrig > 0 && rain <= 15) return `Canal/borewell ~${irrig.toFixed(0)} mm`;
  if (rain >= 70) return `Monsoon ~${rain.toFixed(0)} mm`;
  return `Rain ~${rain.toFixed(0)} mm` + (irrig ? ` + irrigate ${irrig.toFixed(0)} mm` : '');
}
