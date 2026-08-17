/**
 * Lightweight runtime shape check for the Field Twin snapshot contract.
 * Hand-written type guard — no zod dependency.
 */

const SNAPSHOT_SHAPE_ERROR =
  'Unexpected snapshot format — contact support';

const NO_BOUNDARY_ERROR =
  'This field has no boundary polygon. Draw the outline on the map below (or open Field Detail), then save to load Field Twin.';

function isFiniteNumber(v) {
  return typeof v === 'number' && Number.isFinite(v);
}

function hasBoundary(snap) {
  const fieldBoundary = snap?.field?.boundary;
  const terrainBoundary = snap?.terrain?.boundary;
  return Boolean(fieldBoundary || terrainBoundary);
}

/**
 * @param {unknown} snap
 * @returns {{ ok: true } | { ok: false, error: string }}
 */
export function validateTwinSnapshot(snap) {
  if (!snap || typeof snap !== 'object') {
    return { ok: false, error: SNAPSHOT_SHAPE_ERROR };
  }

  if (!hasBoundary(snap)) {
    // Prefer a clear agronomic action over a generic "contact support" string.
    // Backend may still return a valid crop/origin payload for centroid-only fields.
    if (snap.availability?.boundary === false || snap.field) {
      return { ok: false, error: NO_BOUNDARY_ERROR };
    }
    return { ok: false, error: SNAPSHOT_SHAPE_ERROR };
  }

  const origin = snap.local_origin;
  if (
    !origin
    || typeof origin !== 'object'
    || !isFiniteNumber(origin.latitude)
    || !isFiniteNumber(origin.longitude)
  ) {
    return { ok: false, error: SNAPSHOT_SHAPE_ERROR };
  }

  const crop = snap.crop;
  if (!crop || typeof crop !== 'object' || typeof crop.crop_key !== 'string' || !crop.crop_key) {
    return { ok: false, error: SNAPSHOT_SHAPE_ERROR };
  }

  const status = crop.validation?.status;
  if (typeof status !== 'string' || !status) {
    return { ok: false, error: SNAPSHOT_SHAPE_ERROR };
  }

  return { ok: true };
}

export { SNAPSHOT_SHAPE_ERROR, NO_BOUNDARY_ERROR };
