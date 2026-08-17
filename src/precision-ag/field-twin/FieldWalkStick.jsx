import React, { useCallback, useRef } from 'react';

/** On-screen walk stick for phones. Writes {x, z} in [-1, 1] to stickRef. */
export default function FieldWalkStick({ stickRef, visible }) {
  const wrapRef = useRef(null);
  const knobRef = useRef(null);

  const setFromPointer = useCallback((clientX, clientY) => {
    const el = wrapRef.current;
    if (!el || !stickRef?.current) return;
    const r = el.getBoundingClientRect();
    const cx = r.left + r.width / 2;
    const cy = r.top + r.height / 2;
    const dx = (clientX - cx) / (r.width / 2);
    const dy = (clientY - cy) / (r.height / 2);
    const x = Math.max(-1, Math.min(1, dx));
    const z = Math.max(-1, Math.min(1, -dy));
    stickRef.current.x = x;
    stickRef.current.z = z;
    if (knobRef.current) {
      knobRef.current.style.transform = `translate(${x * 22}px, ${-z * 22}px)`;
    }
  }, [stickRef]);

  const clear = useCallback(() => {
    if (stickRef?.current) {
      stickRef.current.x = 0;
      stickRef.current.z = 0;
    }
    if (knobRef.current) knobRef.current.style.transform = 'translate(0, 0)';
  }, [stickRef]);

  if (!visible) return null;

  return (
    <div
      ref={wrapRef}
      className="absolute bottom-16 left-4 z-30 w-24 h-24 rounded-full bg-black/35 border border-white/40 touch-none"
      onPointerDown={(e) => {
        e.currentTarget.setPointerCapture(e.pointerId);
        setFromPointer(e.clientX, e.clientY);
      }}
      onPointerMove={(e) => {
        if (e.buttons || e.pressure > 0) setFromPointer(e.clientX, e.clientY);
      }}
      onPointerUp={clear}
      onPointerCancel={clear}
      data-testid="field-walk-stick"
    >
      <div
        ref={knobRef}
        className="absolute left-1/2 top-1/2 w-10 h-10 -ml-5 -mt-5 rounded-full bg-white/90 shadow"
      />
    </div>
  );
}
