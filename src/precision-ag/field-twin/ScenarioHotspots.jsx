import React, { useMemo } from 'react';
import { Html } from '@react-three/drei';
import { placeScenarioHotspots } from './coords';

function bandColor(band) {
  const b = (band || '').toLowerCase();
  if (b === 'severe') return '#B91C1C';
  if (b === 'high') return '#EA580C';
  if (b === 'moderate') return '#CA8A04';
  return '#2563EB';
}

/**
 * Clickable map-pin markers for modeled water-risk hotspots.
 */
export default function ScenarioHotspots({
  hotspots = [],
  origin,
  elevation,
  bbox,
  exaggeration = 2.5,
  selectedHotspot = null,
  scenarioMeta = null,
  onSelectHotspot,
  onPick,
}) {
  const markers = useMemo(
    () => placeScenarioHotspots({
      hotspots,
      origin,
      elevation,
      bbox,
      exaggeration,
    }).map((h) => ({ ...h, color: bandColor(h.band) })),
    [hotspots, origin, elevation, bbox, exaggeration],
  );

  if (!markers.length) return null;

  return (
    <group>
      {markers.map((h) => {
        const selected = selectedHotspot
          && selectedHotspot.row === h.row
          && selectedHotspot.col === h.col;
        const scale = selected ? 1.25 : 1;
        return (
          <group
            key={`hs-${h.row}-${h.col}-${h.index}`}
            position={[h.x, h.y, h.z]}
            scale={[scale, scale, scale]}
          >
            {/* Pin pole */}
            <mesh position={[0, 0.55, 0]} castShadow>
              <cylinderGeometry args={[0.08, 0.1, 1.1, 8]} />
              <meshStandardMaterial color="#1f2937" roughness={0.7} />
            </mesh>
            {/* Flag head */}
            <mesh
              position={[0, 1.35, 0]}
              onClick={(e) => {
                e.stopPropagation();
                onSelectHotspot?.(h);
                onPick?.({
                  kind: 'scenario_hotspot',
                  label: `Water-risk hotspot #${h.index}`,
                  provenance: 'modeled',
                  confidence: scenarioMeta?.confidence?.grade || 'screening',
                  risk: h.risk,
                  band: h.band,
                  latitude: h.latitude,
                  longitude: h.longitude,
                  rainfall_mm: scenarioMeta?.rainfall_mm,
                  irrigation_mm: scenarioMeta?.irrigation_mm,
                  duration_hours: scenarioMeta?.duration_hours,
                  access_risk: scenarioMeta?.summary?.access_risk,
                  note: (
                    scenarioMeta?.accuracy_statement
                    || 'Modeled relative water-risk hotspot — screening-grade only, verify on site.'
                  ),
                });
              }}
            >
              <sphereGeometry args={[0.42, 16, 16]} />
              <meshStandardMaterial
                color={h.color}
                emissive={h.color}
                emissiveIntensity={selected ? 0.55 : 0.32}
                roughness={0.4}
                metalness={0.12}
              />
            </mesh>
            <Html distanceFactor={48} style={{ pointerEvents: 'none' }} position={[0, 2.0, 0]}>
              <div className="bg-black/75 text-white text-[10px] font-mont px-1.5 py-0.5 rounded whitespace-nowrap shadow">
                #{h.index} · {h.band}
              </div>
            </Html>
          </group>
        );
      })}
    </group>
  );
}
