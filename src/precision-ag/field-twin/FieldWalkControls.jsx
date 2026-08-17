import { useEffect, useRef } from 'react';
import { useFrame, useThree } from '@react-three/fiber';
import * as THREE from 'three';
import { sampleElevation } from './coords';

const MOVE_SPEED = 9; // m/s
const LOOK_SPEED = 0.0022;
const EYE_HEIGHT = 1.7;
const MOVE_CODES = new Set([
  'KeyW', 'KeyA', 'KeyS', 'KeyD',
  'ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight',
  'Space', 'ShiftLeft', 'ShiftRight',
]);

/**
 * First-person walk on the twin: WASD / arrows move, drag to look, Space/Shift up-down nudge.
 * Y is clamped to DEM (or flat) so the farmer stands on the field.
 */
export default function FieldWalkControls({
  active,
  elevation,
  bbox,
  origin,
  extent = 80,
  exaggeration = 3.2,
  onExit,
  stickRef = null,
}) {
  const { camera, gl } = useThree();
  const onExitRef = useRef(onExit);
  onExitRef.current = onExit;
  const held = useRef(new Set());
  const yaw = useRef(0);
  const pitch = useRef(0.05);
  const dragging = useRef(false);
  const last = useRef([0, 0]);
  const pos = useRef({ x: 0, z: extent * 0.08 });
  const primed = useRef(false);

  useEffect(() => {
    if (!active) {
      held.current.clear();
      primed.current = false;
      return undefined;
    }

    const el = gl.domElement;
    const clearKeys = () => { held.current.clear(); };

    const onKeyDown = (e) => {
      if (e.code === 'Escape') {
        e.preventDefault();
        clearKeys();
        onExitRef.current?.();
        return;
      }
      if (!MOVE_CODES.has(e.code)) return;
      e.preventDefault();
      held.current.add(e.code);
    };
    const onKeyUp = (e) => {
      held.current.delete(e.code);
    };
    const onDown = (e) => {
      dragging.current = true;
      last.current = [e.clientX, e.clientY];
    };
    const onUp = () => { dragging.current = false; };
    const onMove = (e) => {
      if (!dragging.current) return;
      const dx = e.clientX - last.current[0];
      const dy = e.clientY - last.current[1];
      last.current = [e.clientX, e.clientY];
      yaw.current -= dx * LOOK_SPEED;
      pitch.current = Math.max(-1.2, Math.min(1.2, pitch.current - dy * LOOK_SPEED));
    };
    const onBlur = () => clearKeys();
    const onVisibility = () => {
      if (document.hidden) clearKeys();
    };

    window.addEventListener('keydown', onKeyDown, { passive: false });
    window.addEventListener('keyup', onKeyUp);
    window.addEventListener('blur', onBlur);
    document.addEventListener('visibilitychange', onVisibility);
    el.addEventListener('pointerdown', onDown);
    window.addEventListener('pointerup', onUp);
    window.addEventListener('pointermove', onMove);

    return () => {
      window.removeEventListener('keydown', onKeyDown);
      window.removeEventListener('keyup', onKeyUp);
      window.removeEventListener('blur', onBlur);
      document.removeEventListener('visibilitychange', onVisibility);
      el.removeEventListener('pointerdown', onDown);
      window.removeEventListener('pointerup', onUp);
      window.removeEventListener('pointermove', onMove);
      clearKeys();
    };
  }, [active, gl]);

  useFrame((_, dt) => {
    if (!active) return;

    // Seed walk pose from the orbit camera so W matches the look direction
    // (orbit usually looks toward −Z; default yaw 0 looks +Z and felt like reverse).
    if (!primed.current) {
      pos.current.x = camera.position.x;
      pos.current.z = camera.position.z;
      const dir = new THREE.Vector3();
      camera.getWorldDirection(dir);
      yaw.current = Math.atan2(dir.x, dir.z);
      pitch.current = Math.asin(Math.max(-1, Math.min(1, dir.y)));
      primed.current = true;
    }

    const down = (code) => held.current.has(code);
    const stickX = Number(stickRef?.current?.x) || 0;
    const stickZ = Number(stickRef?.current?.z) || 0;
    const forward = (down('KeyW') || down('ArrowUp') ? 1 : 0)
      - (down('KeyS') || down('ArrowDown') ? 1 : 0)
      + stickZ;
    const strafe = (down('KeyD') || down('ArrowRight') ? 1 : 0)
      - (down('KeyA') || down('ArrowLeft') ? 1 : 0)
      + stickX;
    const cos = Math.cos(yaw.current);
    const sin = Math.sin(yaw.current);
    const step = MOVE_SPEED * Math.min(dt, 0.05);
    if (forward !== 0 || strafe !== 0) {
      pos.current.x += (sin * forward + cos * strafe) * step;
      pos.current.z += (cos * forward - sin * strafe) * step;
    }
    const limit = Math.max(20, extent * 0.55);
    pos.current.x = Math.max(-limit, Math.min(limit, pos.current.x));
    pos.current.z = Math.max(-limit, Math.min(limit, pos.current.z));

    let groundY = 0;
    if (origin?.latitude && bbox) {
      const mLon = 111320 * Math.cos((origin.latitude * Math.PI) / 180);
      const lng = origin.longitude + pos.current.x / Math.max(1e-6, mLon);
      const lat = origin.latitude - pos.current.z / 111320;
      const el = sampleElevation(elevation?.values, bbox, lng, lat);
      let min = Infinity;
      for (const row of elevation?.values || []) {
        for (const v of row || []) {
          if (v != null && v < min) min = v;
        }
      }
      if (!Number.isFinite(min)) min = 0;
      groundY = ((el ?? min) - min) * Math.max(0.5, Number(exaggeration) || 1);
    }
    if (down('Space')) groundY += 1.2;
    if (down('ShiftLeft') || down('ShiftRight')) groundY -= 0.4;

    camera.position.set(pos.current.x, groundY + EYE_HEIGHT, pos.current.z);
    const lookX = pos.current.x + Math.sin(yaw.current) * Math.cos(pitch.current);
    const lookY = groundY + EYE_HEIGHT + Math.sin(pitch.current);
    const lookZ = pos.current.z + Math.cos(yaw.current) * Math.cos(pitch.current);
    camera.lookAt(lookX, lookY, lookZ);
  });

  return null;
}
