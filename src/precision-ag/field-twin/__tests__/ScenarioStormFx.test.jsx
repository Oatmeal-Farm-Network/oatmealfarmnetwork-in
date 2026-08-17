/**
 * ScenarioStormFx — active storm path + inactive/zero-intensity edge case.
 */
import React from 'react';
import { describe, it, expect, vi } from 'vitest';
import { render } from '@testing-library/react';

vi.mock('@react-three/fiber', () => ({
  useFrame: () => {},
  useThree: () => ({ clock: { elapsedTime: 0 } }),
}));

import ScenarioStormFx from '../ScenarioStormFx.jsx';

describe('ScenarioStormFx', () => {
  it('returns null when inactive', () => {
    const { container } = render(
      <ScenarioStormFx active={false} progress={0.5} rainfallMm={40} />,
    );
    expect(container.firstChild).toBeNull();
  });

  it('renders rain points when active with rainfall', () => {
    const { container } = render(
      <ScenarioStormFx
        active
        progress={0.6}
        rainfallMm={45}
        irrigationMm={0}
        extent={80}
      />,
    );
    expect(container.querySelector('points')).toBeTruthy();
  });

  it('returns null at near-zero intensity even when active', () => {
    const { container } = render(
      <ScenarioStormFx active progress={0} rainfallMm={0} irrigationMm={0} />,
    );
    expect(container.firstChild).toBeNull();
  });
});
