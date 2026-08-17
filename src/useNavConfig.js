// India stack: full nav visible; enable flags gate clicks / widgets.
import { isNavEnabled, isNavVisible } from './ofnNavConfig';

export function useNavConfig() {
  const isNavActive = (key) => isNavEnabled(key);
  const isNavShown = (_key) => isNavVisible();
  return { isNavActive, isNavShown };
}
