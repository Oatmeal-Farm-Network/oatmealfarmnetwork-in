import React, { useMemo } from 'react';
import { Sky, Cloud, Stars } from '@react-three/drei';
import { mulberry32 } from './coords';

/**
 * Weather-driven lighting / sky for immersion.
 * stormProgress (0–1) darkens the sky during scenario playback.
 */
export default function Atmosphere({
  weather,
  timeOfDay = 'auto',
  stormProgress = 0,
  stormActive = false,
}) {
  const current = weather?.current || {};
  const windMph = current.wind_mph ?? ((current.wind_kmh ?? 8) * 0.621);
  const precip = current.precip_in ?? ((current.precip_mm ?? 0) / 25.4);
  const code = current.weather_code ?? 0;

  const sunPos = useMemo(() => {
    if (timeOfDay === 'dusk') return [40, 12, -20];
    if (timeOfDay === 'night') return [0, -4, 30];
    if (timeOfDay === 'noon') return [8, 60, 8];
    return [45, 35, 15];
  }, [timeOfDay]);

  const isNight = timeOfDay === 'night';
  const storm = stormActive ? Math.max(0, Math.min(1, stormProgress)) : 0;
  const cloudy = code >= 2 || precip > 0.01 || storm > 0.08;
  const fairDay = !isNight && !cloudy && storm < 0.08;
  const bg = isNight
    ? '#0b1220'
    : storm > 0.2
      ? `rgb(${Math.round(110 - storm * 40)},${Math.round(125 - storm * 35)},${Math.round(140 - storm * 20)})`
      : cloudy ? '#9eb4c8' : '#87CEEB';

  const sunIntensity = isNight
    ? 0.08
    : cloudy
      ? 0.95 - storm * 0.55
      : 1.55 - storm * 0.9;

  return (
    <>
      <color attach="background" args={[bg]} />
      <fog attach="fog" args={[bg, fairDay ? 220 : 180 + storm * 40, fairDay ? 1600 : 1200]} />
      <hemisphereLight
        args={[
          isNight ? '#1a2030' : storm > 0.25 ? '#8a9aaa' : '#d6ecff',
          isNight ? '#0a0c10' : '#8a9a6a',
          isNight ? 0.28 : 0.7 - storm * 0.25,
        ]}
      />
      <ambientLight intensity={isNight ? 0.18 : cloudy ? 0.5 : 0.65 - storm * 0.2} />
      <directionalLight
        castShadow
        position={sunPos}
        intensity={Math.max(0.2, sunIntensity)}
        shadow-mapSize-width={1024}
        shadow-mapSize-height={1024}
        shadow-camera-far={600}
        shadow-camera-left={-250}
        shadow-camera-right={250}
        shadow-camera-top={250}
        shadow-camera-bottom={-250}
      />
      {!isNight && (
        <directionalLight position={[-35, 18, -40]} intensity={0.3 - storm * 0.15} color="#b8d4ef" />
      )}
      {!isNight && (
        <Sky
          distance={450000}
          sunPosition={sunPos}
          inclination={0.52}
          azimuth={0.25}
          turbidity={cloudy || storm > 0.1 ? 8 + storm * 6 : 2.8}
          rayleigh={cloudy ? 1.4 : 2.8}
          mieCoefficient={0.0035 + storm * 0.004}
          mieDirectionalG={0.82}
        />
      )}
      {isNight && <Stars radius={200} depth={60} count={2500} factor={3.5} fade speed={0.5} />}
      {/* Soft fair-weather cumulus so clear days still feel outdoors */}
      {fairDay && (
        <>
          <Cloud position={[-70, 62, -90]} opacity={0.22} speed={0.06 + windMph * 0.004} segments={10} />
          <Cloud position={[80, 70, -50]} opacity={0.18} speed={0.05 + windMph * 0.003} segments={8} />
        </>
      )}
      {(cloudy || storm > 0.05) && !isNight && (
        <>
          <Cloud position={[-50, 55, -60]} opacity={0.4 + storm * 0.35} speed={0.12 + windMph * 0.008 + storm * 0.15} segments={16} />
          <Cloud position={[55, 60, -35]} opacity={0.32 + storm * 0.4} speed={0.1 + windMph * 0.006 + storm * 0.12} segments={12} />
          <Cloud position={[10, 48, -80]} opacity={0.25 + storm * 0.35} speed={0.08 + windMph * 0.005 + storm * 0.1} segments={10} />
        </>
      )}
      {!stormActive && precip > 0.05 && <RainHint intensity={Math.min(1, precip)} />}
    </>
  );
}

function RainHint({ intensity = 0.3 }) {
  const count = Math.floor(120 * intensity);
  const positions = useMemo(() => {
    const rand = mulberry32(42);
    const arr = new Float32Array(count * 3);
    for (let i = 0; i < count; i++) {
      arr[i * 3] = (rand() - 0.5) * 120;
      arr[i * 3 + 1] = rand() * 30 + 2;
      arr[i * 3 + 2] = (rand() - 0.5) * 120;
    }
    return arr;
  }, [count]);

  return (
    <points>
      <bufferGeometry>
        <bufferAttribute attach="attributes-position" count={count} array={positions} itemSize={3} />
      </bufferGeometry>
      <pointsMaterial color="#b8d4ef" size={0.18} transparent opacity={0.55} />
    </points>
  );
}
