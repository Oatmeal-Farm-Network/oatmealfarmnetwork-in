import React, { useMemo } from 'react';
import { lngLatToLocal, sampleElevation } from './coords';

/**
 * Scout observation markers in the twin scene, placed on the DEM surface.
 */
export default function Observations({
  scouts = [],
  origin,
  elevation = null,
  bbox = null,
  elevMin = 0,
  exaggeration = 2.5,
  onPick,
}) {
  const markers = useMemo(() => {
    if (!origin?.latitude) return [];
    return (scouts || [])
      .filter((s) => s.latitude != null && s.longitude != null)
      .map((s) => {
        const { x, z } = lngLatToLocal(s.longitude, s.latitude, origin);
        const el = sampleElevation(elevation?.values, bbox, s.longitude, s.latitude);
        const y = ((el ?? elevMin) - elevMin) * exaggeration + 1.2;
        return { ...s, x, z, y };
      });
  }, [scouts, origin, elevation, bbox, elevMin, exaggeration]);

  const colorFor = (severity) => {
    const s = (severity || '').toLowerCase();
    if (s === 'critical' || s === 'high') return '#DC2626';
    if (s === 'medium') return '#D97706';
    return '#DB2777';
  };

  return (
    <group>
      {markers.map((s) => (
        <mesh
          key={s.scout_id || `${s.x}-${s.z}`}
          position={[s.x, s.y, s.z]}
          onClick={(e) => {
            e.stopPropagation();
            onPick?.({
              kind: 'scout',
              label: s.category || 'Scout observation',
              severity: s.severity,
              notes: s.notes,
              observed_at: s.observed_at,
              provenance: 'observed',
              confidence: 'high',
            });
          }}
        >
          <octahedronGeometry args={[0.4, 0]} />
          <meshStandardMaterial
            color={colorFor(s.severity)}
            emissive={colorFor(s.severity)}
            emissiveIntensity={0.3}
          />
        </mesh>
      ))}
    </group>
  );
}
