import React, { useMemo, useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import { mulberry32 } from './coords';
import { stormVisualIntensity } from './scenarioPlayback';

/**
 * Cinematic storm / irrigation FX for scenario playback (progress 0-1).
 * Visual only — not a physics flood model.
 *
 * Particle count is fixed so intensity changes do not rebuild geometry (that
 * looked like a broken / flickering storm).
 */
export default function ScenarioStormFx({
  active = false,
  progress = 0,
  rainfallMm = 0,
  irrigationMm = 0,
  extent = 80,
}) {
  const rainStrength = Math.min(1, (Number(rainfallMm) || 0) / 55);
  const irrigStrength = Math.min(1, (Number(irrigationMm) || 0) / 35);
  const envelope = stormVisualIntensity(progress, active);

  const intensity = Math.max(rainStrength, irrigStrength * 0.5) * envelope;
  if (!active || intensity < 0.01) return null;

  return (
    <group>
      <FallingRain intensity={intensity} extent={extent} />
      {irrigationMm > 0 && intensity > 0.15 && (
        <IrrigationMist intensity={irrigStrength * envelope} extent={extent} />
      )}
    </group>
  );
}

function FallingRain({ intensity = 0.4, extent = 80 }) {
  const ref = useRef();
  // Fixed count — never recreate the buffer mid-storm
  const count = 220;
  const span = Math.max(40, extent * 1.15);

  const positions = useMemo(() => {
    const rand = mulberry32(91);
    const arr = new Float32Array(count * 3);
    for (let i = 0; i < count; i++) {
      arr[i * 3] = (rand() - 0.5) * span;
      arr[i * 3 + 1] = rand() * 28 + 4;
      arr[i * 3 + 2] = (rand() - 0.5) * span;
    }
    return arr;
  }, [span]);

  const intensityRef = useRef(intensity);

  useFrame((_, dt) => {
    intensityRef.current = intensity;
    const mesh = ref.current;
    if (!mesh) return;
    const attr = mesh.geometry.attributes.position;
    const arr = attr.array;
    const i = intensityRef.current;
    const speed = 14 + i * 18;
    for (let n = 0; n < count; n++) {
      arr[n * 3 + 1] -= speed * dt * (0.75 + (n % 5) * 0.06);
      if (arr[n * 3 + 1] < 0.15) {
        arr[n * 3 + 1] = 20 + (n % 10);
        arr[n * 3] = (Math.random() - 0.5) * span;
        arr[n * 3 + 2] = (Math.random() - 0.5) * span;
      }
    }
    attr.needsUpdate = true;
    if (mesh.material) {
      mesh.material.opacity = 0.25 + i * 0.45;
      mesh.material.size = 0.18 + i * 0.1;
    }
  });

  return (
    <points ref={ref}>
      <bufferGeometry>
        <bufferAttribute attach="attributes-position" count={count} array={positions} itemSize={3} />
      </bufferGeometry>
      <pointsMaterial
        color="#c5d9ef"
        size={0.22}
        transparent
        opacity={0.45}
        depthWrite={false}
        sizeAttenuation
      />
    </points>
  );
}

function IrrigationMist({ intensity = 0.3, extent = 80 }) {
  const ref = useRef();
  const count = 70;
  const span = Math.max(30, extent * 0.85);

  const positions = useMemo(() => {
    const rand = mulberry32(203);
    const arr = new Float32Array(count * 3);
    for (let i = 0; i < count; i++) {
      arr[i * 3] = (rand() - 0.5) * span;
      arr[i * 3 + 1] = rand() * 4 + 0.5;
      arr[i * 3 + 2] = (rand() - 0.5) * span;
    }
    return arr;
  }, [span]);

  useFrame(({ clock }) => {
    const mesh = ref.current;
    if (!mesh) return;
    mesh.rotation.y = clock.elapsedTime * 0.04;
    if (mesh.material) mesh.material.opacity = 0.12 + intensity * 0.2;
  });

  return (
    <points ref={ref}>
      <bufferGeometry>
        <bufferAttribute attach="attributes-position" count={count} array={positions} itemSize={3} />
      </bufferGeometry>
      <pointsMaterial
        color="#a8c8e0"
        size={0.5}
        transparent
        opacity={0.2}
        depthWrite={false}
        sizeAttenuation
      />
    </points>
  );
}
