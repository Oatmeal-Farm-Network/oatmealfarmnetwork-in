/**
 * Session cache for last-good Field Twin snapshots.
 * Speeds reopen / quality switches; never stores DEM grids or blob URLs.
 */

const PREFIX = 'oft:twin-snap:v5:';

function cacheKey(fieldId, year) {
  const y = year == null || year === '' ? 'current' : String(year);
  return `${PREFIX}${fieldId}:${y}`;
}

/** Drop bulky / non-serializable blobs before writing. */
export function slimTwinSnapshot(snap) {
  if (!snap || typeof snap !== 'object') return null;
  try {
    // structuredClone fails on some exotic values — JSON round-trip is enough
    const copy = JSON.parse(JSON.stringify(snap));
    if (copy.terrain?.grid?.values) delete copy.terrain.grid.values;
    if (copy.vegetation?.grid?.values) delete copy.vegetation.grid.values;
    return copy;
  } catch {
    return null;
  }
}

export function readTwinSnapshotCache(fieldId, year = null) {
  if (fieldId == null || typeof sessionStorage === 'undefined') return null;
  try {
    const raw = sessionStorage.getItem(cacheKey(fieldId, year));
    if (!raw) return null;
    const parsed = JSON.parse(raw);
    if (!parsed?.snapshot || typeof parsed.snapshot !== 'object') return null;
    // Soft TTL: 6 hours
    if (parsed.savedAt && Date.now() - Number(parsed.savedAt) > 6 * 60 * 60 * 1000) {
      sessionStorage.removeItem(cacheKey(fieldId, year));
      return null;
    }
    return parsed.snapshot;
  } catch {
    return null;
  }
}

export function writeTwinSnapshotCache(fieldId, year, snap) {
  if (fieldId == null || typeof sessionStorage === 'undefined') return;
  const slim = slimTwinSnapshot(snap);
  if (!slim) return;
  try {
    sessionStorage.setItem(
      cacheKey(fieldId, year),
      JSON.stringify({ savedAt: Date.now(), snapshot: slim }),
    );
  } catch {
    // Quota / private mode — ignore
  }
}
