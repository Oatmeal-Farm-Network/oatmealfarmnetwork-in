/** Shared timing for Field Twin scenario cinematic playback. */
export const SCENARIO_PLAYBACK_MS = 8000;
/** Progress when risk map drapes onto the field */
export const RISK_MAP_AT = 0.38;
/** Progress when hotspot markers appear */
export const HOTSPOTS_AT = 0.7;

export function clampProgress(progress) {
  const value = Number(progress);
  if (!Number.isFinite(value)) return 0;
  return Math.max(0, Math.min(1, value));
}

export function playbackPhaseLabel(progress) {
  const p = clampProgress(progress);
  if (p < 0.15) return 'Storm building…';
  if (p < RISK_MAP_AT) return 'Rain on the field…';
  if (p < HOTSPOTS_AT) return 'Water risk appearing…';
  if (p < 1) return 'Result settling…';
  return 'Scenario complete';
}

/**
 * Visual storm envelope: build, hold, then clear before the final result.
 * This prevents the old behavior where the sky became darkest at the end and
 * abruptly snapped back to daylight.
 */
export function stormVisualIntensity(progress, active = true) {
  if (!active) return 0;
  const p = clampProgress(progress);
  if (p >= 1) return 0;
  if (p < 0.15) return p / 0.15;
  if (p < 0.55) return 1;
  if (p < 0.9) return 1 - ((p - 0.55) / 0.35) * 0.85;
  return Math.max(0, 0.15 - ((p - 0.9) / 0.1) * 0.15);
}

export function isRiskMapVisible(progress) {
  return clampProgress(progress) >= RISK_MAP_AT;
}

export function areHotspotsVisible(progress) {
  return clampProgress(progress) >= HOTSPOTS_AT;
}

/**
 * Hotspots only after the cinematic gate (or when playback finished).
 * Manual Scenario risk selection before a completed playthrough stays gated.
 */
export function shouldShowScenarioHotspots({
  hasOverlay = false,
  hotspotCount = 0,
  active = false,
  progress = 0,
  surfaceLayer = 'natural',
} = {}) {
  if (!hasOverlay || !hotspotCount) return false;
  if (active) return areHotspotsVisible(progress);
  return surfaceLayer === 'scenario' && clampProgress(progress) >= 1;
}
