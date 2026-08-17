import { useEffect, useRef, useState } from 'react';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import 'leaflet-draw/dist/leaflet.draw.css';
import 'leaflet-draw';

// Vite breaks Leaflet's default icon URLs — same fix as PrecisionAgFields.
if (L?.Icon?.Default?.prototype) {
  delete L.Icon.Default.prototype._getIconUrl;
  L.Icon.Default.mergeOptions({
    iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
    iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
    shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
  });
}

const DEFAULT_CENTER = [37.5, -121.9];

/**
 * Leaflet + Draw map for capturing a field boundary on Field Twin when none exists.
 *
 * Important: Leaflet's map.remove() detaches its container from the DOM. If that
 * container is the React ref node, React then crashes with removeChild → blank page.
 * We mount Leaflet into a child we create, so remove() only drops that child.
 */
export default function BoundaryDrawMap({
  lat = null,
  lon = null,
  address = null,
  height = 420,
  onPolygon,
}) {
  const hostRef = useRef(null);
  const mapRef = useRef(null);
  const onPolygonRef = useRef(onPolygon);
  const [mapError, setMapError] = useState(null);
  const [geoHint, setGeoHint] = useState('');

  useEffect(() => {
    onPolygonRef.current = onPolygon;
  }, [onPolygon]);

  useEffect(() => {
    const host = hostRef.current;
    if (!host || mapRef.current) return undefined;

    let cancelled = false;
    let map = null;

    const start = async () => {
      let center = DEFAULT_CENTER;
      let zoom = 14;

      const hasCoords = Number.isFinite(Number(lat)) && Number.isFinite(Number(lon));
      if (hasCoords) {
        center = [Number(lat), Number(lon)];
      } else if (address && String(address).trim()) {
        setGeoHint('Looking up address on the map…');
        try {
          const q = encodeURIComponent(String(address).trim());
          const res = await fetch(
            `https://nominatim.openstreetmap.org/search?format=json&limit=1&q=${q}`,
            { headers: { 'User-Agent': 'OatmealFarmNetwork/1.0' } },
          );
          const rows = res.ok ? await res.json() : [];
          if (cancelled) return;
          if (rows?.[0]?.lat != null && rows?.[0]?.lon != null) {
            center = [parseFloat(rows[0].lat), parseFloat(rows[0].lon)];
            zoom = 15;
            setGeoHint('');
          } else {
            setGeoHint('Address not found — pan the map and draw the field outline.');
          }
        } catch {
          if (!cancelled) {
            setGeoHint('Could not look up address — pan the map and draw the field outline.');
          }
        }
      } else {
        setGeoHint('No coordinates yet — pan to the field and draw the outline.');
        zoom = 5;
      }

      if (cancelled || !hostRef.current) return;

      try {
        // Child node Leaflet owns — React only owns `host`.
        const leafletEl = document.createElement('div');
        leafletEl.style.width = '100%';
        leafletEl.style.height = '100%';
        host.innerHTML = '';
        host.appendChild(leafletEl);

        map = L.map(leafletEl).setView(center, zoom);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
          maxZoom: 19,
          attribution: '© OpenStreetMap contributors',
        }).addTo(map);

        if (hasCoords) {
          L.marker(center).addTo(map);
        }

        const drawnItems = new L.FeatureGroup();
        map.addLayer(drawnItems);

        const drawControl = new L.Control.Draw({
          draw: {
            polygon: true,
            rectangle: true,
            circle: false,
            marker: false,
            polyline: false,
            circlemarker: false,
          },
          edit: { featureGroup: drawnItems },
        });
        map.addControl(drawControl);

        map.on(L.Draw.Event.CREATED, (e) => {
          drawnItems.clearLayers();
          drawnItems.addLayer(e.layer);
          const geojson = e.layer.toGeoJSON().geometry;
          const c = e.layer.getBounds().getCenter();
          onPolygonRef.current?.(geojson, { lat: c.lat, lng: c.lng });
        });

        map.on(L.Draw.Event.DELETED, () => {
          onPolygonRef.current?.(null, null);
        });

        mapRef.current = map;
        setTimeout(() => {
          try { map?.invalidateSize(); } catch { /* */ }
        }, 80);
      } catch (err) {
        if (!cancelled) setMapError(String(err?.message || err));
      }
    };

    start();

    return () => {
      cancelled = true;
      const active = mapRef.current;
      mapRef.current = null;
      if (active) {
        try {
          active.off();
          active.remove(); // removes leafletEl only — host stays for React
        } catch { /* */ }
      }
      if (host) {
        try { host.innerHTML = ''; } catch { /* */ }
      }
    };
  }, [lat, lon, address]);

  return (
    <div data-testid="twin-boundary-draw-map" className="space-y-2">
      {geoHint ? (
        <p className="font-mont text-xs text-amber-800/90">{geoHint}</p>
      ) : null}
      {mapError ? (
        <p className="font-mont text-xs text-red-700">{mapError}</p>
      ) : null}
      <div
        ref={hostRef}
        className="rounded-lg overflow-hidden border border-amber-200 bg-white"
        style={{ height, width: '100%' }}
      />
      <p className="font-mont text-[11px] text-amber-900/70">
        Use the polygon or rectangle tool, then click Save boundary.
      </p>
    </div>
  );
}
