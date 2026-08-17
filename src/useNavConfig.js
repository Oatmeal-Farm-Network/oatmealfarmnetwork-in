// Shared hook for OFN nav/widget visibility config.
// Fetches from the OAT backend once per page load (module-level cache).
import { useState, useEffect } from 'react';
import { DEFAULT_OFN_NAV_KEYS, fetchOfnNavKeys } from './ofnNavConfig';

let cache = null;       // Set<string> of active NavKeys, or null if not yet fetched
let fetchPromise = null; // in-flight fetch so multiple components don't duplicate it

function fetchConfig() {
  if (fetchPromise) return fetchPromise;
  fetchPromise = fetchOfnNavKeys()
    .then((keys) => {
      cache = keys;
      return cache;
    })
    .catch(() => {
      fetchPromise = null;
      cache = new Set(DEFAULT_OFN_NAV_KEYS);
      return cache;
    });
  return fetchPromise;
}

export function useNavConfig() {
  const [activeKeys, setActiveKeys] = useState(cache);

  useEffect(() => {
    if (cache !== null) { setActiveKeys(cache); return; }
    fetchConfig().then((keys) => { if (keys) setActiveKeys(keys); });
  }, []);

  const isNavActive = (key) => !activeKeys || activeKeys.has(key);
  return { isNavActive };
}
