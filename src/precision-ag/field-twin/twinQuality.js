/**
 * Device capability probe for Field Twin rendering quality.
 * Prefer GPU / memory signals over viewport width alone; re-check on resize.
 */

function gpuTierHint() {
  try {
    const canvas = document.createElement('canvas');
    const gl = canvas.getContext('webgl2') || canvas.getContext('webgl');
    if (!gl) return { tier: 'none', renderer: '' };
    const dbg = gl.getExtension('WEBGL_debug_renderer_info');
    const renderer = dbg
      ? String(gl.getParameter(dbg.UNMASKED_RENDERER_WEBGL) || '')
      : '';
    const lower = renderer.toLowerCase();
    // Integrated / mobile GPUs → stay conservative
    if (
      /swiftshader|llvmpipe|microsoft basic|mali|adreno|powervr|intel hd|uhd graphics|apple gpu/.test(lower)
    ) {
      return { tier: 'low', renderer };
    }
    if (/rtx|radeon rx|geforce gtx|geforce rtx|apple m[1-9]|arc a/.test(lower)) {
      return { tier: 'high', renderer };
    }
    return { tier: 'medium', renderer };
  } catch {
    return { tier: 'medium', renderer: '' };
  }
}

function memoryHintGb() {
  try {
    const dm = navigator.deviceMemory;
    if (typeof dm === 'number' && Number.isFinite(dm)) return dm;
  } catch { /* */ }
  return null;
}

/**
 * @returns {'low'|'medium'|'high'}
 */
export function detectTwinQuality({
  width = typeof window !== 'undefined' ? window.innerWidth : 1280,
  preferReducedMotion = false,
} = {}) {
  if (preferReducedMotion) return 'low';
  const mem = memoryHintGb();
  const { tier } = gpuTierHint();
  const narrow = width < 768;
  const midWidth = width < 1100;
  let cores = null;
  try {
    if (typeof navigator !== 'undefined' && typeof navigator.hardwareConcurrency === 'number') {
      cores = navigator.hardwareConcurrency;
    }
  } catch { /* */ }

  if (tier === 'none') return 'low';
  if (narrow || (mem != null && mem <= 4) || tier === 'low' || (cores != null && cores <= 4)) {
    return 'low';
  }
  if (midWidth || (mem != null && mem <= 8) || tier === 'medium' || (cores != null && cores <= 6)) {
    return 'medium';
  }
  return 'high';
}

/** Suggested max DPR for the Twin canvas. */
export function twinMaxDpr(quality) {
  if (quality === 'low') return 1;
  if (quality === 'medium') return 1.25;
  return 1.75;
}

export function twinShadowsEnabled(quality) {
  return quality === 'high';
}

/**
 * Truck / phone-friendly layout: coarse pointer or narrow viewport.
 * Prefer this for larger tap targets and hiding WASD walk.
 */
export function isTruckMode({
  width = typeof window !== 'undefined' ? window.innerWidth : 1280,
} = {}) {
  if (width < 900) return true;
  try {
    if (typeof window !== 'undefined' && window.matchMedia?.('(pointer: coarse)').matches) {
      return true;
    }
  } catch { /* */ }
  return false;
}

/**
 * Hard cap on canopy InstancedMesh samples by device tier.
 * Aligns with backend rendering_hints.quality_presets when present.
 */
export function maxInstancesForQuality(quality) {
  if (quality === 'low') return 5000;
  if (quality === 'high') return 18000;
  return 12000;
}

/**
 * Growth stage / plant stature is estimated unless the snapshot marks it observed.
 * Missing stage, low confidence, or modeled provenance → show Estimated badge.
 */
export function isGrowthEstimated(growth) {
  if (!growth || typeof growth !== 'object') return true;
  const stage = String(growth.stage || 'unknown').toLowerCase();
  if (!stage || stage === 'unknown') return true;
  const provenance = String(growth.provenance || '').toLowerCase();
  if (provenance === 'observed' || provenance === 'measured') return false;
  if (provenance === 'modeled' || provenance === 'estimated' || !provenance) return true;
  const confidence = String(growth.confidence || '').toLowerCase();
  if (confidence === 'low') return true;
  return provenance !== 'derived';
}
