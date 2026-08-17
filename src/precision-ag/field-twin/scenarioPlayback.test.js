/**
 * Lightweight tests for the Field Twin playback timeline.
 * Run with: node src/precision-ag/field-twin/scenarioPlayback.test.js
 */
import {
  RISK_MAP_AT,
  HOTSPOTS_AT,
  clampProgress,
  playbackPhaseLabel,
  stormVisualIntensity,
  isRiskMapVisible,
  areHotspotsVisible,
  shouldShowScenarioHotspots,
} from './scenarioPlayback.js';

function assert(condition, message) {
  if (!condition) throw new Error(message || 'assertion failed');
}

export function runScenarioPlaybackTests() {
  assert(clampProgress(-1) === 0, 'negative progress clamps to zero');
  assert(clampProgress(2) === 1, 'progress above one clamps to one');
  assert(clampProgress(Number.NaN) === 0, 'invalid progress becomes zero');

  assert(playbackPhaseLabel(0).includes('building'), 'starts by building storm');
  assert(playbackPhaseLabel(RISK_MAP_AT).includes('risk'), 'risk phase starts at map reveal');
  assert(playbackPhaseLabel(1) === 'Scenario complete', 'ends complete');

  assert(stormVisualIntensity(0, true) === 0, 'storm starts clear');
  assert(stormVisualIntensity(0.2, true) === 1, 'storm reaches peak');
  assert(stormVisualIntensity(0.75, true) < 1, 'storm clears during result');
  assert(stormVisualIntensity(1, true) === 0, 'storm ends clear');
  assert(stormVisualIntensity(0.3, false) === 0, 'inactive playback has no storm');

  assert(!isRiskMapVisible(RISK_MAP_AT - 0.01), 'risk map hidden before reveal');
  assert(isRiskMapVisible(RISK_MAP_AT), 'risk map visible at reveal');
  assert(!areHotspotsVisible(HOTSPOTS_AT - 0.01), 'hotspots hidden before threshold');
  assert(areHotspotsVisible(HOTSPOTS_AT), 'hotspots visible at threshold');

  assert(
    !shouldShowScenarioHotspots({
      hasOverlay: true,
      hotspotCount: 3,
      active: false,
      progress: 0,
      surfaceLayer: 'scenario',
    }),
    'manual scenario before complete playthrough hides hotspots',
  );
  assert(
    shouldShowScenarioHotspots({
      hasOverlay: true,
      hotspotCount: 3,
      active: false,
      progress: 1,
      surfaceLayer: 'scenario',
    }),
    'completed playback shows hotspots',
  );
  assert(
    shouldShowScenarioHotspots({
      hasOverlay: true,
      hotspotCount: 3,
      active: true,
      progress: HOTSPOTS_AT,
      surfaceLayer: 'ndvi',
    }),
    'active playback shows hotspots at threshold',
  );

  return { ok: true, riskAt: RISK_MAP_AT, hotspotsAt: HOTSPOTS_AT };
}

if (typeof process !== 'undefined' && process.argv?.[1]?.includes('scenarioPlayback.test')) {
  console.log('field-twin playback tests OK', runScenarioPlaybackTests());
}
