/**
 * Atmosphere — main render path + zero-wind edge case.
 */
import React from 'react';
import { describe, it, expect, vi } from 'vitest';
import { render } from '@testing-library/react';

vi.mock('@react-three/drei', () => {
  const Stub = () => null;
  return { Sky: Stub, Cloud: Stub, Stars: Stub, Clouds: Stub };
});

vi.mock('@react-three/fiber', () => ({
  useFrame: () => {},
  useThree: () => ({ clock: { elapsedTime: 0 } }),
}));

import Atmosphere from '../Atmosphere.jsx';

describe('Atmosphere', () => {
  it('renders day sky without crashing for typical weather', () => {
    const { container } = render(
      <Atmosphere
        weather={{
          current: {
            wind_mph: 8,
            precip_in: 0,
            weather_code: 1,
          },
        }}
        timeOfDay="auto"
      />,
    );
    expect(container.querySelector('hemisphereLight')).toBeTruthy();
    expect(container.querySelector('directionalLight')).toBeTruthy();
  });

  it('handles zero-wind weather without throwing', () => {
    expect(() => {
      render(
        <Atmosphere
          weather={{
            current: {
              wind_mph: 0,
              precip_in: 0,
              weather_code: 0,
            },
          }}
          timeOfDay="noon"
          stormActive={false}
          stormProgress={0}
        />,
      );
    }).not.toThrow();
  });
});
