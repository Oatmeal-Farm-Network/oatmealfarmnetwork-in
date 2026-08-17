/**
 * TwinInspector — main render path + empty pick edge case.
 */
import React from 'react';
import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import TwinInspector from '../TwinInspector.jsx';
import { makeSnapshot } from './fixtures.js';

describe('TwinInspector', () => {
  it('renders field overview from snapshot when no pick is selected', () => {
    const snap = makeSnapshot();
    render(<TwinInspector pick={null} snapshot={snap} />);
    expect(screen.getByText('Field overview')).toBeTruthy();
    expect(screen.getAllByText(/Derived|Observed|Estimated|Modeled|Recorded/i).length).toBeGreaterThan(0);
  });

  it('renders pick label and clears when Clear is clicked', async () => {
    const user = userEvent.setup();
    const onClose = vi.fn();
    const snap = makeSnapshot();
    render(
      <TwinInspector
        pick={{
          kind: 'scout',
          label: 'Scout observation',
          provenance: 'observed',
          confidence: 'high',
          notes: 'Leaf spotting',
        }}
        snapshot={snap}
        onClose={onClose}
      />,
    );
    expect(screen.getByText('Scout observation')).toBeTruthy();
    await user.click(screen.getByRole('button', { name: /clear/i }));
    expect(onClose).toHaveBeenCalledTimes(1);
  });

  it('returns null when both pick and snapshot are absent', () => {
    const { container } = render(<TwinInspector pick={null} snapshot={null} />);
    expect(container.firstChild).toBeNull();
  });
});
