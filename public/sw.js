/* Oatmeal Farm Network — Unified Service Worker.
 *
 * Combines:
 *   - Web push notifications (preserves the prior push-sw.js behavior)
 *   - App-shell precache (HTML + manifest so cold-load works offline)
 *   - Runtime cache for static assets (stale-while-revalidate)
 *   - Runtime cache for safe API GETs (network-first, cache fallback)
 *   - Background-sync queue for offline POSTs (lead scans, scouting notes)
 */

const VERSION         = 'ofn-sw-v3';
const SHELL_CACHE     = `${VERSION}-shell`;
const STATIC_CACHE    = `${VERSION}-static`;
const RUNTIME_CACHE   = `${VERSION}-runtime`;
const API_CACHE       = `${VERSION}-api`;

/** Files that constitute the minimum offline-bootable shell. */
const SHELL_URLS = [
  '/',
  '/index.html',
  '/manifest.webmanifest',
  '/images/OFNFavico.png',
];

/** API GET prefixes we're willing to cache for read-only offline reads. */
const API_CACHE_PREFIXES = [
  '/api/events/',          // event detail + sponsors + floor plan booths
  '/api/fields',           // field list
  '/api/notifications',    // bell inbox
];

/** API path-substring fragments to NEVER cache (real-time only). */
const API_NEVER_CACHE = [
  '/auth/',
  '/login',
  '/_internal/',
  '/checkin/',          // attendance status must always be fresh
  '/leads/scan',        // explicitly handled via bg-sync below
];

/* ──────────────────────────────────────────────────────────────────────────
 * IndexedDB helpers — used by the bg-sync queue
 * ──────────────────────────────────────────────────────────────────────── */

const DB_NAME       = 'ofn-bg-sync';
const STORE_QUEUE   = 'queue';

function openDB() {
  return new Promise((resolve, reject) => {
    const req = indexedDB.open(DB_NAME, 1);
    req.onupgradeneeded = () => {
      const db = req.result;
      if (!db.objectStoreNames.contains(STORE_QUEUE)) {
        db.createObjectStore(STORE_QUEUE, { keyPath: 'id', autoIncrement: true });
      }
    };
    req.onsuccess = () => resolve(req.result);
    req.onerror   = () => reject(req.error);
  });
}

async function queuePut(item) {
  const db = await openDB();
  return new Promise((resolve, reject) => {
    const tx = db.transaction(STORE_QUEUE, 'readwrite');
    tx.objectStore(STORE_QUEUE).add({ ...item, queuedAt: Date.now() });
    tx.oncomplete = () => resolve();
    tx.onerror    = () => reject(tx.error);
  });
}

async function queueAll() {
  const db = await openDB();
  return new Promise((resolve, reject) => {
    const tx = db.transaction(STORE_QUEUE, 'readonly');
    const store = tx.objectStore(STORE_QUEUE);
    const req = store.getAll();
    req.onsuccess = () => resolve(req.result || []);
    req.onerror   = () => reject(req.error);
  });
}

async function queueDelete(id) {
  const db = await openDB();
  return new Promise((resolve, reject) => {
    const tx = db.transaction(STORE_QUEUE, 'readwrite');
    tx.objectStore(STORE_QUEUE).delete(id);
    tx.oncomplete = () => resolve();
    tx.onerror    = () => reject(tx.error);
  });
}

/* ──────────────────────────────────────────────────────────────────────────
 * Lifecycle
 * ──────────────────────────────────────────────────────────────────────── */

self.addEventListener('install', (event) => {
  self.skipWaiting();
  event.waitUntil(
    caches.open(SHELL_CACHE).then(cache =>
      cache.addAll(SHELL_URLS.map(u => new Request(u, { cache: 'reload' })))
        .catch(() => {/* shell precache best-effort */})
    )
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    // Drop old version caches
    const keep = new Set([SHELL_CACHE, STATIC_CACHE, RUNTIME_CACHE, API_CACHE]);
    const names = await caches.keys();
    await Promise.all(names.filter(n => !keep.has(n)).map(n => caches.delete(n)));
    await self.clients.claim();
  })());
});

/* ──────────────────────────────────────────────────────────────────────────
 * Fetch — runtime caching strategies
 * ──────────────────────────────────────────────────────────────────────── */

self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;  // POST/PUT/DELETE handled separately (bg-sync)

  const url = new URL(req.url);
  if (url.origin !== self.location.origin && !url.host.endsWith('googleusercontent.com')
      && !url.host.endsWith('storage.googleapis.com')) {
    return; // don't intercept third-party (analytics, fonts, etc.)
  }

  // Navigation requests → app shell fallback
  if (req.mode === 'navigate') {
    event.respondWith(networkFirstWithShellFallback(req));
    return;
  }

  const path = url.pathname;

  // API GET: network-first with cache fallback (only for whitelisted prefixes)
  if (path.startsWith('/api/')) {
    if (API_NEVER_CACHE.some(seg => path.includes(seg))) return; // always live
    if (API_CACHE_PREFIXES.some(p => path.startsWith(p))) {
      event.respondWith(networkFirstWithCacheFallback(req, API_CACHE, 5_000));
    }
    return;
  }

  // Static assets (JS bundles, CSS, images) → stale-while-revalidate
  if (path.startsWith('/assets/') || path.startsWith('/images/')
      || path.endsWith('.js') || path.endsWith('.css')
      || path.endsWith('.svg') || path.endsWith('.webp')
      || path.endsWith('.png') || path.endsWith('.jpg')) {
    event.respondWith(staleWhileRevalidate(req, STATIC_CACHE));
    return;
  }
});

async function networkFirstWithShellFallback(req) {
  try {
    const fresh = await fetch(req);
    return fresh;
  } catch {
    const shell = await caches.match('/index.html')
                || await caches.match('/');
    return shell || new Response('Offline', { status: 503, headers: { 'Content-Type': 'text/plain' } });
  }
}

async function networkFirstWithCacheFallback(req, cacheName, timeoutMs = 5000) {
  const cache = await caches.open(cacheName);
  try {
    const fresh = await Promise.race([
      fetch(req),
      new Promise((_, reject) => setTimeout(() => reject(new Error('timeout')), timeoutMs)),
    ]);
    if (fresh && fresh.ok) {
      cache.put(req, fresh.clone()).catch(() => {});
    }
    return fresh;
  } catch {
    const cached = await cache.match(req);
    if (cached) return cached;
    return new Response(JSON.stringify({ error: 'offline', cached: false }), {
      status: 503, headers: { 'Content-Type': 'application/json' },
    });
  }
}

async function staleWhileRevalidate(req, cacheName) {
  const cache = await caches.open(cacheName);
  const cached = await cache.match(req);
  const networkPromise = fetch(req).then(resp => {
    if (resp && resp.ok) cache.put(req, resp.clone()).catch(() => {});
    return resp;
  }).catch(() => null);
  return cached || networkPromise || new Response('Offline', { status: 503 });
}

/* ──────────────────────────────────────────────────────────────────────────
 * Background-sync queue
 *
 * Triggered by the page calling navigator.serviceWorker.controller.postMessage
 * with {type: 'bg-queue', payload: {url, method, headers, body}}, OR when a
 * page calls registration.sync.register('ofn-bg-sync') after stashing items
 * into IndexedDB. The browser fires our 'sync' event when it gets connectivity.
 * ──────────────────────────────────────────────────────────────────────── */

self.addEventListener('message', (event) => {
  const { type, payload } = event.data || {};
  if (type === 'bg-queue' && payload?.url) {
    event.waitUntil(queuePut(payload).then(() => {
      try { self.registration.sync.register('ofn-bg-sync'); } catch {}
    }));
  } else if (type === 'flush-queue') {
    event.waitUntil(flushQueue().then(r => event.source?.postMessage({ type: 'queue-flushed', ...r })));
  }
});

self.addEventListener('sync', (event) => {
  if (event.tag === 'ofn-bg-sync') {
    event.waitUntil(flushQueue());
  }
});

async function flushQueue() {
  const items = await queueAll();
  let ok = 0, failed = 0;
  for (const it of items) {
    try {
      const resp = await fetch(it.url, {
        method:  it.method || 'POST',
        headers: it.headers || { 'Content-Type': 'application/json' },
        body:    typeof it.body === 'string' ? it.body : JSON.stringify(it.body || {}),
      });
      if (resp.ok) {
        await queueDelete(it.id);
        ok++;
      } else if (resp.status >= 400 && resp.status < 500) {
        // Client error — drop it, won't succeed on retry
        await queueDelete(it.id);
        failed++;
      } else {
        failed++;
      }
    } catch {
      failed++;
    }
  }
  return { ok, failed };
}

/* ──────────────────────────────────────────────────────────────────────────
 * Push notifications (preserved from push-sw.js)
 * ──────────────────────────────────────────────────────────────────────── */

self.addEventListener('push', (event) => {
  let data = {};
  try {
    data = event.data ? event.data.json() : {};
  } catch (e) {
    data = { title: 'Oatmeal Farm Network', body: event.data ? event.data.text() : '' };
  }
  const title = data.title || 'Oatmeal Farm Network';
  const options = {
    body:     data.body || '',
    icon:     data.icon  || '/images/OFNFavico.png',
    badge:    data.badge || '/images/OFNFavico.png',
    data:     { url: data.url || '/', ...data },
    tag:      data.tag   || 'ofn-generic',
    renotify: true,
  };
  event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  const targetUrl = (event.notification.data && event.notification.data.url) || '/';
  event.waitUntil((async () => {
    const allClients = await self.clients.matchAll({ type: 'window', includeUncontrolled: true });
    for (const client of allClients) {
      if (client.url.includes(targetUrl) && 'focus' in client) {
        return client.focus();
      }
    }
    if (self.clients.openWindow) return self.clients.openWindow(targetUrl);
  })());
});
