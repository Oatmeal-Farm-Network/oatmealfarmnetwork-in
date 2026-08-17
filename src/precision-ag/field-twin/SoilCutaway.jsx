import React, { useMemo } from 'react';
import { Html } from '@react-three/drei';
import { Link } from 'react-router-dom';
import { lngLatToLocal, sampleElevation } from './coords';
import { filterLocatedSoilSamples, SOIL_SAMPLE_INFLUENCE_M } from './soilSamples';

export { filterLocatedSoilSamples, SOIL_SAMPLE_INFLUENCE_M } from './soilSamples';

function sampleColor(sample) {
  const ph = Number(sample?.ph);
  if (Number.isFinite(ph)) {
    if (ph < 5.8) return '#B45309';
    if (ph > 7.4) return '#7C3AED';
  }
  return '#D97706';
}

/**
 * Measured soil cores only — no decorative SoilGrids geology.
 * Underground with no GPS samples shows the same empty-state card as the product UI.
 */
export default function SoilCutaway({
  origin,
  bbox,
  elevation = null,
  elevMin = 0,
  exaggeration = 2.5,
  soilSamples = [],
  underground = false,
  businessId = null,
  fieldId = null,
  onPick,
}) {
  const sampleMarkers = useMemo(() => {
    if (!origin?.latitude) return [];
    return filterLocatedSoilSamples(soilSamples)
      .map((s) => {
        const { x, z } = lngLatToLocal(s.longitude, s.latitude, origin);
        const el = sampleElevation(elevation?.values, bbox, s.longitude, s.latitude);
        const surfaceY = ((el ?? elevMin) - elevMin) * exaggeration;
        const depthM = Math.max(0.15, (Number(s.depth_cm) || 30) / 100);
        return {
          ...s,
          x,
          z,
          surfaceY,
          depthM,
          coreY: surfaceY - depthM / 2,
        };
      });
  }, [soilSamples, origin, elevation, bbox, elevMin, exaggeration]);

  if (!origin?.latitude) return null;

  // Match product empty state: message in the scene, never invent soil layers.
  if (underground && sampleMarkers.length === 0) {
    const href = businessId && fieldId
      ? `/precision-ag/soil-samples?BusinessID=${encodeURIComponent(businessId)}&FieldID=${encodeURIComponent(fieldId)}`
      : '/precision-ag/soil-samples';
    return (
      <Html position={[0, 1.5, 0]} center>
        <div className="bg-white/95 border border-amber-200 text-amber-900 font-mont text-xs px-3 py-2 rounded-lg max-w-[260px] text-center shadow space-y-2">
          <div>
            No GPS soil lab tests on this field yet — add a soil test so fertility isn’t guesswork.
          </div>
          <Link
            to={href}
            className="inline-flex items-center px-2.5 py-1 rounded-md bg-[#92400E] text-white text-[10px] font-semibold hover:bg-[#78350F]"
          >
            Log a soil sample
          </Link>
        </div>
      </Html>
    );
  }

  if (sampleMarkers.length === 0) return null;

  return (
    <group>
      {sampleMarkers.map((s) => (
        <group key={s.sample_id || `${s.x}-${s.z}-${s.sample_date || ''}`}>
          {underground && (
            <mesh
              rotation={[-Math.PI / 2, 0, 0]}
              position={[s.x, s.surfaceY - 0.02, s.z]}
              onClick={(e) => {
                e.stopPropagation();
                onPick?.({
                  kind: 'soil_influence',
                  label: 'Sample influence radius',
                  provenance: 'modeled',
                  confidence: 'low',
                  radius_m: SOIL_SAMPLE_INFLUENCE_M,
                  note: `Interpolation is limited to ~${SOIL_SAMPLE_INFLUENCE_M} m of a measured core — not a field-wide soil map.`,
                });
              }}
            >
              <circleGeometry args={[SOIL_SAMPLE_INFLUENCE_M, 48]} />
              <meshStandardMaterial
                color="#92400E"
                transparent
                opacity={0.18}
                depthWrite={false}
                side={2}
              />
            </mesh>
          )}

          <mesh
            position={[s.x, underground ? s.coreY : s.surfaceY + s.depthM / 2, s.z]}
            onClick={(e) => {
              e.stopPropagation();
              onPick?.({
                kind: 'soil_sample',
                label: s.sample_label || 'Soil sample',
                provenance: 'observed',
                confidence: 'high',
                sample_date: s.sample_date,
                depth_cm: s.depth_cm,
                ph: s.ph,
                organic_matter: s.organic_matter,
                nitrogen: s.nitrogen,
                phosphorus: s.phosphorus,
                potassium: s.potassium,
                note: s.notes || 'Lab-measured soil core at recorded GPS location.',
              });
            }}
          >
            <cylinderGeometry args={[0.28, 0.32, s.depthM, 10]} />
            <meshStandardMaterial
              color={sampleColor(s)}
              emissive={sampleColor(s)}
              emissiveIntensity={underground ? 0.2 : 0.28}
              roughness={0.75}
            />
          </mesh>

          <mesh position={[s.x, s.surfaceY + 0.35, s.z]}>
            <sphereGeometry args={[0.22, 10, 10]} />
            <meshStandardMaterial color="#F59E0B" emissive="#B45309" emissiveIntensity={0.35} />
          </mesh>

          {underground && (
            <Html position={[s.x, s.surfaceY + 1.1, s.z]} center distanceFactor={40} style={{ pointerEvents: 'none' }}>
              <div className="bg-black/75 text-white font-mont text-[10px] px-2 py-1 rounded-lg whitespace-nowrap shadow">
                {s.sample_label || 'Sample'}
                {s.depth_cm != null ? ` · ${s.depth_cm} cm` : ''}
                {s.sample_date ? ` · ${String(s.sample_date).slice(0, 10)}` : ''}
              </div>
            </Html>
          )}
        </group>
      ))}
    </group>
  );
}
