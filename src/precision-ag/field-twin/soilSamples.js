/**
 * Pure helpers for Phase 3 soil layer (no React / Three dependency).
 */

/** Defensible influence radius (m) around a measured core. */
export const SOIL_SAMPLE_INFLUENCE_M = 30;

/** Only samples with real coordinates may become twin pins/cores. */
export function filterLocatedSoilSamples(soilSamples = []) {
  return (soilSamples || []).filter((s) => s.latitude != null && s.longitude != null);
}
