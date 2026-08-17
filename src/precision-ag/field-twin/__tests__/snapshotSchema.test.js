/**
 * Unit tests for twin-snapshot runtime shape validation.
 */
import { describe, it, expect } from 'vitest';
import { validateTwinSnapshot, SNAPSHOT_SHAPE_ERROR, NO_BOUNDARY_ERROR } from '../snapshotSchema.js';
import { makeSnapshot } from './fixtures.js';

describe('validateTwinSnapshot', () => {
  it('accepts a valid fixture unchanged', () => {
    const snap = makeSnapshot();
    expect(validateTwinSnapshot(snap)).toEqual({ ok: true });
  });

  it('rejects a snapshot missing crop_key with a distinct error', () => {
    const snap = makeSnapshot();
    delete snap.crop.crop_key;
    const result = validateTwinSnapshot(snap);
    expect(result.ok).toBe(false);
    expect(result.error).toBe(SNAPSHOT_SHAPE_ERROR);
  });

  it('rejects a snapshot with renamed validation.status', () => {
    const snap = makeSnapshot();
    snap.crop.validation = { state: 'matched' };
    const result = validateTwinSnapshot(snap);
    expect(result.ok).toBe(false);
    expect(result.error).toBe(SNAPSHOT_SHAPE_ERROR);
  });

  it('rejects missing local_origin latitude/longitude', () => {
    const snap = makeSnapshot({ local_origin: { crs: 'local' } });
    // makeSnapshot spreads overrides at top level for selection/field/crop, not local_origin —
    // force a broken origin explicitly:
    snap.local_origin = { crs: 'local' };
    const result = validateTwinSnapshot(snap);
    expect(result.ok).toBe(false);
    expect(result.error).toBe(SNAPSHOT_SHAPE_ERROR);
  });

  it('accepts terrain.boundary when field.boundary is absent', () => {
    const snap = makeSnapshot();
    const boundary = snap.field.boundary;
    delete snap.field.boundary;
    snap.terrain.boundary = boundary;
    expect(validateTwinSnapshot(snap)).toEqual({ ok: true });
  });

  it('explains missing boundary instead of generic support copy', () => {
    const snap = makeSnapshot();
    delete snap.field.boundary;
    if (snap.terrain) delete snap.terrain.boundary;
    snap.availability = { ...(snap.availability || {}), boundary: false };
    const result = validateTwinSnapshot(snap);
    expect(result.ok).toBe(false);
    expect(result.error).toBe(NO_BOUNDARY_ERROR);
  });
});
