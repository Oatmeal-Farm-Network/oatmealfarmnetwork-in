/**
 * Observations — main render path + empty scouts edge case.
 */
import React from 'react';
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render } from '@testing-library/react';

vi.mock('@react-three/fiber', () => ({
  useFrame: () => {},
  useThree: () => ({ clock: { elapsedTime: 0 } }),
}));

// Lightweight R3F host stubs so <mesh>/<group> render as DOM nodes in jsdom.
beforeEach(() => {
  // no-op — React 19 accepts unknown intrinsic elements in tests
});

import Observations from '../Observations.jsx';

const ORIGIN = { latitude: 41.5, longitude: -93.5 };

describe('Observations', () => {
  it('renders nothing for an empty scouts list', () => {
    const { container } = render(
      <Observations scouts={[]} origin={ORIGIN} elevMin={0} exaggeration={2.5} />,
    );
    // group with no children
    expect(container.querySelectorAll('mesh').length).toBe(0);
  });

  it('places located scouts and ignores entries without coordinates', () => {
    const onPick = vi.fn();
    const { container } = render(
      <Observations
        scouts={[
          {
            scout_id: 1,
            latitude: 41.501,
            longitude: -93.501,
            category: 'Pest',
            severity: 'high',
            notes: 'Aphids',
          },
          {
            scout_id: 2,
            latitude: null,
            longitude: null,
            category: 'Unlocated',
            severity: 'low',
          },
        ]}
        origin={ORIGIN}
        elevMin={100}
        exaggeration={2.5}
        onPick={onPick}
      />,
    );
    const meshes = container.querySelectorAll('mesh');
    expect(meshes.length).toBe(1);
  });
});
