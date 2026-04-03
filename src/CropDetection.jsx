import React, { useState, useEffect, useRef, useCallback } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import maplibregl from 'maplibre-gl';
import { Protocol, PMTiles } from 'pmtiles';
import 'maplibre-gl/dist/maplibre-gl.css';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

// ─── CONFIG ───────────────────────────────────────────────────────────────────
const GCP_API = 'https://us-central1-animated-flare-421518.cloudfunctions.net/analyze-field';
const FIELD_API = 'https://crop-detection-dcecevhvh5ard2ah.eastus-01.azurewebsites.net/api';
const CURRENT_YEAR = 2024;
const PMTILES_2024 = 'pmtiles://https://storage.googleapis.com/pmt_tiles/pmtiles/crop_2024.pmtiles';

// ─── CROP LOOKUP ──────────────────────────────────────────────────────────────
const CROP_LOOKUP = {
  1:'Corn',2:'Cotton',3:'Rice',4:'Sorghum',5:'Soybeans',6:'Sunflower',10:'Peanuts',
  11:'Tobacco',12:'Sweet Corn',13:'Pop/Orn Corn',14:'Mint',21:'Barley',
  22:'Durum Wheat',23:'Spring Wheat',24:'Winter Wheat',25:'Other Small Grains',
  26:'Dbl Crop WinWht/Soybeans',27:'Rye',28:'Oats',29:'Millet',30:'Speltz',
  31:'Canola',32:'Flaxseed',33:'Safflower',34:'Rape Seed',35:'Mustard',
  36:'Alfalfa',37:'Other Hay/Non Alfalfa',41:'Sugarbeets',42:'Dry Beans',
  43:'Potatoes',44:'Other Crops',45:'Sugarcane',46:'Sweet Potatoes',
  47:'Misc Vegs & Fruits',48:'Watermelons',49:'Onions',50:'Cucumbers',
  51:'Chick Peas',52:'Lentils',53:'Peas',54:'Tomatoes',55:'Caneberries',
  56:'Hops',57:'Herbs',58:'Clover/Wildflowers',59:'Sod/Grass Seed',
  60:'Switchgrass',61:'Fallow/Idle Cropland',63:'Forest',64:'Shrubland',
  65:'Barren',66:'Cherries',67:'Peaches',68:'Apples',69:'Grapes',
  70:'Christmas Trees',71:'Other Tree Crops',72:'Citrus',74:'Pecans',
  75:'Almonds',76:'Walnuts',77:'Pears',111:'Open Water',
  121:'Developed/Open Space',122:'Developed/Low Intensity',
  123:'Developed/Med Intensity',124:'Developed/High Intensity',152:'Shrubland',
  176:'Grassland/Pasture',190:'Woody Wetlands',195:'Herbaceous Wetlands',
  204:'Pistachios',205:'Triticale',206:'Carrots',207:'Asparagus',208:'Garlic',
  209:'Cantaloupes',210:'Prunes',211:'Olives',212:'Oranges',
  213:'Honeydew Melons',214:'Broccoli',216:'Peppers',217:'Pomegranates',
  218:'Nectarines',219:'Greens',220:'Plums',221:'Strawberries',222:'Squash',
  223:'Apricots',224:'Vetch',225:'Dbl Crop WinWht/Corn',226:'Dbl Crop Oats/Corn',
  227:'Lettuce',228:'Dbl Crop Triticale/Corn',229:'Pumpkins',
  230:'Dbl Crop Lettuce/Durum Wht',231:'Dbl Crop Lettuce/Cantaloupe',
  232:'Dbl Crop Lettuce/Cotton',233:'Dbl Crop Lettuce/Barley',
  234:'Dbl Crop Durum Wht/Sorghum',235:'Dbl Crop Barley/Sorghum',
  236:'Dbl Crop WinWht/Sorghum',237:'Dbl Crop Barley/Corn',
  238:'Dbl Crop WinWht/Cotton',239:'Dbl Crop Soybeans/Cotton',
  240:'Dbl Crop Soybeans/Oats',241:'Dbl Crop Corn/Soybeans',242:'Blueberries',
  243:'Cabbage',244:'Cauliflower',245:'Celery',246:'Radishes',247:'Turnips',
  248:'Eggplants',249:'Gourds',250:'Cranberries',254:'Dbl Crop Barley/Soybeans',
};

const CROP_COLORS = {
  '1':'#F4D03F','5':'#229954','24':'#A04000','36':'#2ECC71',
  '176':'#CDDC39','61':'#BDBDBD','66':'#C2185B','69':'#7B1FA2',
  '75':'#D7CCC8','77':'#AED581','228':'#546E7A','33':'#FF5722',
  '71':'#BCAAA4','204':'#009688','212':'#FF9800','250':'#C0392B',
};

// ─── DATA HELPERS ─────────────────────────────────────────────────────────────
const getTextureClass = (sand, clay) => {
  const s = sand || 0; const c = clay || 0;
  if (s + c === 0) return 'Unknown';
  if (c >= 40) return 'Clay';
  if (s > 45) return 'Sandy Loam';
  return 'Loam';
};

const getHealthScore = (soil) => {
  if (!soil) return { score: 75, issues: [], strengths: [{ message: 'Using regional data' }] };
  const ph = soil.ph || 6.5; const soc = soil.soc || 20; const nitrogen = soil.nitrogen || 2.5;
  let score = 100; const issues = []; const strengths = [];
  if (ph < 6.0) { score -= 15; issues.push({ message: `Acidic Soil (pH ${ph.toFixed(1)})`, severity: 'medium' }); }
  else if (ph > 7.5) { score -= 15; issues.push({ message: `Alkaline Soil (pH ${ph.toFixed(1)})`, severity: 'medium' }); }
  else { strengths.push({ message: 'pH is in optimal range' }); }
  if (soc < 15) { score -= 20; issues.push({ message: 'Low organic matter', severity: 'high' }); }
  else { strengths.push({ message: 'Good organic matter' }); }
  if (nitrogen < 2.0) { score -= 15; issues.push({ message: 'Low Nitrogen', severity: 'medium' }); }
  return { score: Math.max(0, score), issues, strengths };
};

const getFertilizerPlan = (soil) => {
  if (!soil) return [];
  const plan = []; const ph = soil.ph || 6.5; const nitrogen = soil.nitrogen || 2.5;
  if (nitrogen < 2.0) plan.push({ nutrient: 'Nitrogen (N)', priority: 'HIGH', amount: '80-100 lbs/ac', fertilizer: 'Urea (46-0-0)', current: nitrogen.toFixed(2), target: '3.5', timing: 'Split application at planting' });
  if (ph < 6.0) plan.push({ nutrient: 'pH Adjustment', priority: 'HIGH', amount: '2-3 tons/ac', fertilizer: 'Ag Limestone', current: ph.toFixed(1), target: '6.5', timing: 'Fall application' });
  return plan;
};

const normalizeSoilLayer = (layer) => {
  if (!layer) return null;
  const ph = layer.phh2o ?? layer.ph;
  const soc = layer.soc_g_per_kg ?? layer.soc;
  const sand = layer.sand_pct ?? layer.sand;
  const clay = layer.clay_pct ?? layer.clay;
  const phN = ph != null ? Number(ph) : null;
  const socN = soc != null ? Number(soc) : null;
  const sandN = sand != null ? Number(sand) : null;
  const clayN = clay != null ? Number(clay) : null;
  return {
    ph:       Number.isFinite(phN)   ? phN   : 6.5,
    soc:      Number.isFinite(socN)  ? socN  : 20,
    sand:     Number.isFinite(sandN) ? sandN : 35,
    clay:     Number.isFinite(clayN) ? clayN : 25,
    nitrogen: layer.nitrogen != null ? Number(layer.nitrogen) : 2.5,
    silt:     Number.isFinite(sandN) && Number.isFinite(clayN)
                ? Math.max(0, 100 - sandN - clayN) : null,
  };
};

// Calculate polygon area in acres using the Shoelace formula (approximate)
const calcPolygonAcres = (coords) => {
  if (!coords || coords.length < 3) return 0;
  // Convert degrees to approximate meters, then to acres
  const R = 6371000;
  let area = 0;
  for (let i = 0; i < coords.length; i++) {
    const j = (i + 1) % coords.length;
    const xi = coords[i][0] * (Math.PI / 180) * R * Math.cos(coords[i][1] * Math.PI / 180);
    const yi = coords[i][1] * (Math.PI / 180) * R;
    const xj = coords[j][0] * (Math.PI / 180) * R * Math.cos(coords[j][1] * Math.PI / 180);
    const yj = coords[j][1] * (Math.PI / 180) * R;
    area += xi * yj - xj * yi;
  }
  const sqMeters = Math.abs(area / 2);
  return (sqMeters / 4046.86).toFixed(2); // convert m² to acres
};

// ─── SOIL PIE CHART ───────────────────────────────────────────────────────────
function SoilPie({ soil }) {
  const sand = soil.sand || 0; const silt = soil.silt || 0; const clay = soil.clay || 0;
  const total = sand + silt + clay;
  if (total === 0) return null;
  let angle = -90;
  const slices = [
    { val: sand, color: '#f59e0b', label: 'Sand' },
    { val: silt, color: '#a16207', label: 'Silt' },
    { val: clay, color: '#78350f', label: 'Clay' },
  ].map(s => {
    const sweep = (s.val / total) * 360;
    const a1 = angle; angle += sweep;
    const r = 80;
    const x1 = 100 + r * Math.cos((a1 * Math.PI) / 180);
    const y1 = 100 + r * Math.sin((a1 * Math.PI) / 180);
    const x2 = 100 + r * Math.cos(((a1 + sweep) * Math.PI) / 180);
    const y2 = 100 + r * Math.sin(((a1 + sweep) * Math.PI) / 180);
    return { ...s, d: `M 100 100 L ${x1} ${y1} A ${r} ${r} 0 ${sweep > 180 ? 1 : 0} 1 ${x2} ${y2} Z` };
  });
  return (
    <div style={{ display: 'flex', gap: 20, alignItems: 'center', justifyContent: 'center', marginBottom: 16 }}>
      <svg viewBox="0 0 200 200" style={{ width: 110, height: 110, flexShrink: 0, transform: 'rotate(-90deg)' }}>
        {slices.map((s, i) => <path key={i} d={s.d} fill={s.color} stroke="white" strokeWidth="1" />)}
      </svg>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 5 }}>
        {slices.map(s => (
          <div key={s.label} style={{ display: 'flex', alignItems: 'center', gap: 8, fontSize: 12, color: '#4b5563', fontWeight: 500 }}>
            <span style={{ width: 10, height: 10, borderRadius: '50%', background: s.color, flexShrink: 0 }} />
            {s.label}: {s.val.toFixed(1)}%
          </div>
        ))}
      </div>
    </div>
  );
}

// ─── SAVE FIELD MODAL ─────────────────────────────────────────────────────────
function SaveFieldModal({ open, onClose, onSave, fieldData, drawnPolygon, businessId, peopleId }) {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (open) {
      setName(fieldData?.cropName ? `${fieldData.cropName} Field` : '');
      setDescription('');
      setError('');
    }
  }, [open, fieldData]);

  const handleSave = async () => {
    if (!name.trim()) { setError('Field name is required'); return; }
    if (!drawnPolygon || drawnPolygon.length < 3) { setError('No field boundary drawn'); return; }
    setSaving(true);
    setError('');

    const coords = drawnPolygon;
    const centroidLat = coords.reduce((s, c) => s + c[1], 0) / coords.length;
    const centroidLon = coords.reduce((s, c) => s + c[0], 0) / coords.length;
    const acres = parseFloat(calcPolygonAcres(coords));
    const hectares = acres * 0.404686;

    // Close the polygon (GeoJSON requires first === last)
    const ring = [...coords];
    if (ring[0][0] !== ring[ring.length - 1][0] || ring[0][1] !== ring[ring.length - 1][1]) {
      ring.push(ring[0]);
    }

    const payload = {
      name: name.trim(),
      fieldDescription: description.trim() || null,
      latitude: centroidLat,
      longitude: centroidLon,
      fieldSizeHectares: hectares,
      cropType: fieldData?.cropName || 'Unknown',
      address: fieldData?.county ? `${fieldData.county} County` : name.trim(),
      businessId: businessId ? parseInt(businessId) : 1,
      createdByPeopleId: peopleId ? parseInt(peopleId) : 1,
      monitoringEnabled: false,
      monitoringIntervalDays: 5,
      alertThresholdHealth: 50,
      plantingDate: '2024-01-01',
      area: `${acres} ac`,
      boundaryGeoJSON: {
        type: 'Feature',
        geometry: { type: 'Polygon', coordinates: [ring] },
        properties: {},
      },
    };

    try {
      const res = await fetch(`${FIELD_API}/api/fields`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
      if (!res.ok) {
        const err = await res.json().catch(() => ({}));
        throw new Error(err.detail || res.statusText);
      }
      const data = await res.json();
      onSave(data.id);
      onClose();
    } catch (e) {
      setError(e.message || 'Save failed');
    } finally {
      setSaving(false);
    }
  };

  if (!open) return null;
  return (
    <div style={{
      position: 'fixed', inset: 0, zIndex: 9999,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      background: 'rgba(0,0,0,0.45)', backdropFilter: 'blur(4px)',
    }}>
      <div style={{
        background: 'white', borderRadius: 16, padding: 32, width: 420, maxWidth: '90vw',
        boxShadow: '0 24px 60px rgba(0,0,0,0.2)',
      }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 24 }}>
          <h2 style={{ fontSize: 20, fontWeight: 700, color: '#111827', margin: 0 }}>💾 Save Field</h2>
          <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', fontSize: 20, color: '#6b7280' }}>✕</button>
        </div>

        {drawnPolygon?.length > 2 && (
          <div style={{ background: '#f0fdf4', border: '1px solid #86efac', borderRadius: 8, padding: '10px 14px', marginBottom: 16, fontSize: 13, color: '#166534' }}>
            ✓ Field boundary drawn — {calcPolygonAcres(drawnPolygon)} acres
          </div>
        )}

        <div style={{ marginBottom: 16 }}>
          <label style={{ display: 'block', fontSize: 12, fontWeight: 600, color: '#374151', marginBottom: 6 }}>Field Name *</label>
          <input
            value={name} onChange={e => setName(e.target.value)}
            placeholder="e.g. North Corn Field"
            style={{ width: '100%', padding: '10px 12px', border: '2px solid #e5e7eb', borderRadius: 8, fontSize: 14, outline: 'none', boxSizing: 'border-box' }}
          />
        </div>

        <div style={{ marginBottom: 20 }}>
          <label style={{ display: 'block', fontSize: 12, fontWeight: 600, color: '#374151', marginBottom: 6 }}>Description (optional)</label>
          <textarea
            value={description} onChange={e => setDescription(e.target.value)}
            placeholder="Notes about this field…"
            rows={3}
            style={{ width: '100%', padding: '10px 12px', border: '2px solid #e5e7eb', borderRadius: 8, fontSize: 14, outline: 'none', resize: 'vertical', boxSizing: 'border-box' }}
          />
        </div>

        {error && (
          <div style={{ background: '#fef2f2', border: '1px solid #fca5a5', borderRadius: 8, padding: '10px 14px', marginBottom: 16, fontSize: 13, color: '#991b1b' }}>
            ⚠ {error}
          </div>
        )}

        <div style={{ display: 'flex', gap: 10 }}>
          <button onClick={onClose} style={{ flex: 1, padding: '12px', background: '#f3f4f6', border: 'none', borderRadius: 8, cursor: 'pointer', fontWeight: 600, fontSize: 14, color: '#374151' }}>
            Cancel
          </button>
          <button onClick={handleSave} disabled={saving} style={{
            flex: 2, padding: '12px', background: saving ? '#93c5fd' : '#1e40af',
            border: 'none', borderRadius: 8, cursor: saving ? 'not-allowed' : 'pointer',
            fontWeight: 600, fontSize: 14, color: 'white',
          }}>
            {saving ? '⟳ Saving…' : '💾 Save Field'}
          </button>
        </div>
      </div>
    </div>
  );
}

// ─── ANALYSIS DRAWER ─────────────────────────────────────────────────────────
function AnalysisDrawer({ open, fieldData, onClose, onSaveField, drawnPolygon, businessID }) {
  const navigate = useNavigate();
  const scoreColor = !fieldData?.healthData ? '#9ca3af'
    : fieldData.healthData.score > 75 ? '#10b981'
    : fieldData.healthData.score > 50 ? '#f59e0b' : '#ef4444';

  return (
    <div style={{
      position: 'absolute', top: 0, right: 0, bottom: 0, width: 420,
      background: 'white', boxShadow: '-4px 0 20px rgba(0,0,0,0.12)',
      transform: open ? 'translateX(0)' : 'translateX(100%)',
      transition: 'transform 0.3s cubic-bezier(0.4,0,0.2,1)',
      zIndex: 30, display: 'flex', flexDirection: 'column',
    }}>
      {/* Close */}
      <button onClick={onClose} style={{
        position: 'absolute', top: 16, right: 16, width: 32, height: 32,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        background: 'white', border: '1px solid #e5e7eb', borderRadius: 8,
        cursor: 'pointer', zIndex: 50, fontSize: 16, color: '#64748b',
        boxShadow: '0 2px 6px rgba(0,0,0,0.1)',
      }}>✕</button>

      {fieldData ? (
        <div style={{ overflowY: 'auto', padding: '28px 22px 40px', flex: 1 }}>

          {/* Header */}
          <div style={{ marginBottom: 20 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 6 }}>
              <h2 style={{ fontSize: 22, fontWeight: 700, color: '#111827', margin: 0 }}>{fieldData.cropName}</h2>
              <span style={{ padding: '3px 10px', background: '#f3f4f6', borderRadius: 6, fontSize: 11, fontWeight: 600, color: '#6b7280' }}>{fieldData.texture} Soil</span>
            </div>
            <div style={{ fontSize: 12, color: '#9ca3af', display: 'flex', alignItems: 'center', gap: 4, flexWrap: 'wrap' }}>
              📍 {fieldData.location.lat.toFixed(4)}°, {fieldData.location.lon.toFixed(4)}°
              <span style={{ margin: '0 4px' }}>•</span>
              {fieldData.acres} Acres
              {fieldData.county && <><span style={{ margin: '0 4px' }}>•</span>{fieldData.county} County</>}
            </div>
          </div>

          {/* Add to Account Button — always shown when a field is selected */}
          <button
            onClick={() => navigate(`/precision-ag/fields?BusinessID=${businessID}&view=create-field&lat=${fieldData.location.lat}&lon=${fieldData.location.lon}`)}
            style={{
              width: '100%', padding: '12px 16px', marginBottom: 10,
              background: 'linear-gradient(135deg,#1a237e,#283593)',
              color: 'white', border: 'none', borderRadius: 10,
              cursor: 'pointer', fontWeight: 700, fontSize: 14,
              display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
              boxShadow: '0 4px 12px rgba(26,35,126,0.3)',
            }}
          >
            ➕ Add Field to My Account
          </button>

          {/* Save Field Button — shown when a polygon has been drawn */}
          {drawnPolygon?.length > 2 && (
            <button
              onClick={onSaveField}
              style={{
                width: '100%', padding: '12px 16px', marginBottom: 16,
                background: 'linear-gradient(135deg,#166534,#15803d)',
                color: 'white', border: 'none', borderRadius: 10,
                cursor: 'pointer', fontWeight: 700, fontSize: 14,
                display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
                boxShadow: '0 4px 12px rgba(21,128,61,0.3)',
              }}
            >
              💾 Save This Field ({calcPolygonAcres(drawnPolygon)} ac)
            </button>
          )}

          {/* Health */}
          {fieldData.healthData && (
            <div style={{ background: 'linear-gradient(135deg,#f0f9ff,#e0f2fe)', border: '1px solid #bae6fd', borderRadius: 12, padding: 18, marginBottom: 14 }}>
              <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 14, display: 'flex', alignItems: 'center', gap: 6 }}>
                ⚡ Soil Health Analysis
              </div>
              <div style={{ display: 'flex', gap: 16 }}>
                <div style={{ width: 96, height: 96, borderRadius: '50%', border: `6px solid ${scoreColor}`, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', background: 'white', flexShrink: 0 }}>
                  <span style={{ fontSize: 26, fontWeight: 800, color: '#111827', lineHeight: 1 }}>{fieldData.healthData.score.toFixed(0)}</span>
                  <span style={{ fontSize: 10, color: '#6b7280', fontWeight: 600, marginTop: 2 }}>
                    {fieldData.healthData.score > 75 ? 'Excellent' : fieldData.healthData.score > 50 ? 'Fair' : 'Poor'}
                  </span>
                </div>
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: 6 }}>
                  {fieldData.healthData.strengths?.map((s, i) => (
                    <div key={i} style={{ display: 'flex', gap: 8, alignItems: 'center', background: '#d1fae5', color: '#065f46', padding: '6px 10px', borderRadius: 6, fontSize: 12 }}>✓ {s.message}</div>
                  ))}
                  {fieldData.healthData.issues?.map((issue, i) => (
                    <div key={i} style={{ display: 'flex', gap: 8, alignItems: 'center', background: '#fef3c7', color: '#92400e', padding: '6px 10px', borderRadius: 6, fontSize: 12 }}>⚠ {issue.message}</div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {/* Per-depth soil composition cards */}
          {fieldData.depthSummaries?.length > 0 && fieldData.depthSummaries.map((entry, idx) => (
            <div key={`${entry.depth}-${idx}`} style={{ background: 'white', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18, marginBottom: 14 }}>
              <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 14, display: 'flex', alignItems: 'center', gap: 6 }}>
                🥧 Soil Composition <span style={{ fontWeight: 500, textTransform: 'none', color: '#6b7280' }}>({entry.depth})</span>
              </div>
              <SoilPie soil={entry.soil} />
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3,1fr)', gap: 10 }}>
                {[
                  ['💧', 'pH Level', entry.soil.ph?.toFixed(1) || '—', '#3b82f6'],
                  ['🌿', 'Carbon', `${entry.soil.soc?.toFixed(1) || '—'} g/kg`, '#10b981'],
                  ['📊', 'Clay', `${entry.soil.clay?.toFixed(1) || '—'}%`, '#8b5cf6'],
                ].map(([icon, label, val]) => (
                  <div key={label} style={{ background: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: 8, padding: '10px 8px', textAlign: 'center' }}>
                    <div style={{ fontSize: 16 }}>{icon}</div>
                    <div style={{ fontSize: 10, color: '#9ca3af', fontWeight: 500, marginTop: 2 }}>{label}</div>
                    <div style={{ fontSize: 15, fontWeight: 700, color: '#111827', marginTop: 2 }}>{val}</div>
                  </div>
                ))}
              </div>
            </div>
          ))}

          {/* Fertilizer */}
          {fieldData.fertilizerPlan?.length > 0 && (
            <div style={{ background: 'white', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18, marginBottom: 14 }}>
              <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 14 }}>🧫 Fertilizer Recommendations</div>
              {fieldData.fertilizerPlan.map((plan, i) => (
                <div key={i} style={{ background: '#fefce8', border: '1px solid #fde68a', borderRadius: 8, padding: 14, marginBottom: i < fieldData.fertilizerPlan.length - 1 ? 10 : 0 }}>
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}>
                    <span style={{ fontSize: 14, fontWeight: 700, color: '#78350f' }}>{plan.nutrient}</span>
                    <span style={{ background: '#fee2e2', color: '#991b1b', padding: '2px 8px', borderRadius: 4, fontSize: 10, fontWeight: 700 }}>{plan.priority}</span>
                  </div>
                  <div style={{ display: 'flex', gap: 16, marginBottom: 8, fontSize: 12, color: '#78350f' }}>
                    <span>Current: <strong>{plan.current}</strong></span>
                    <span>Target: <strong>{plan.target}</strong></span>
                  </div>
                  <div style={{ fontSize: 12, color: '#92400e', lineHeight: 1.5 }}>
                    <strong>Apply:</strong> {plan.amount} of {plan.fertilizer}<br />
                    <em>Timing: {plan.timing}</em>
                  </div>
                </div>
              ))}
            </div>
          )}

          {/* Crop Recommendations */}
          {fieldData.recommendations?.length > 0 && (
            <div style={{ background: 'white', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18, marginBottom: 14 }}>
              <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 14 }}>📈 Best Crop Matches</div>
              {fieldData.recommendations.slice(0, 5).map((rec, i) => (
                <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '9px 12px', background: '#f9fafb', border: '1px solid #f3f4f6', borderRadius: 8, marginBottom: 6 }}>
                  <div style={{ width: 22, height: 22, background: '#1a237e', color: 'white', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 10, fontWeight: 700, flexShrink: 0 }}>#{i + 1}</div>
                  <div style={{ flex: 1 }}>
                    <div style={{ fontSize: 13, fontWeight: 600, color: '#1f2937' }}>{rec.name}</div>
                    <div style={{ fontSize: 11, color: '#6b7280' }}>{rec.reason || 'Suitable for soil conditions'}</div>
                  </div>
                  <div style={{
                    padding: '3px 8px', borderRadius: 4, fontSize: 12, fontWeight: 700,
                    background: rec.score > 80 ? '#dcfce7' : rec.score > 60 ? '#fef3c7' : '#fee2e2',
                    color: rec.score > 80 ? '#166534' : rec.score > 60 ? '#92400e' : '#991b1b',
                  }}>{rec.score.toFixed(0)}%</div>
                </div>
              ))}
            </div>
          )}

          {/* Crop History */}
          {fieldData.history && Object.keys(fieldData.history).length > 0 && (
            <div style={{ background: 'white', border: '1px solid #e5e7eb', borderRadius: 12, padding: 18 }}>
              <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 14 }}>🌾 Crop Rotation History (2009–2024)</div>
              <div style={{ maxHeight: 300, overflowY: 'auto', paddingRight: 8, display: 'flex', flexDirection: 'column', gap: 6 }}>
                {Object.entries(fieldData.history).sort(([a], [b]) => parseInt(b) - parseInt(a)).map(([year, info]) => (
                  <div key={year} style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                    <span style={{ width: 36, fontSize: 12, fontWeight: 600, color: '#9ca3af', flexShrink: 0 }}>{year}</span>
                    <div style={{
                      flex: 1, display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                      padding: '7px 12px', borderRadius: 6, fontSize: 13, fontWeight: 500, color: '#1f2937',
                      background: CROP_COLORS[String(info.code)] || '#e5e7eb',
                      borderLeft: `4px solid ${CROP_COLORS[String(info.code)] ? '#00000033' : '#9ca3af'}`,
                    }}>
                      <span>{info.crop}</span>
                      {info.acres && <span style={{ fontSize: 11, opacity: 0.7 }}>{parseFloat(info.acres).toFixed(0)} ac</span>}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      ) : null}
    </div>
  );
}

// ─── MAIN COMPONENT ───────────────────────────────────────────────────────────
export default function CropDetection() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [address, setAddress] = useState('');
  const [suggestions, setSuggestions] = useState([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [isSearching, setIsSearching] = useState(false);
  const [showAnalytics, setShowAnalytics] = useState(false);
  const [fieldData, setFieldData] = useState(null);
  const [loading, setLoading] = useState(false);

  // ─── Field Drawing State ───────────────────────────────────────────────────
  const [drawMode, setDrawMode] = useState(false);           // actively drawing
  const [drawnPolygon, setDrawnPolygon] = useState([]);      // array of [lng, lat]
  const [showSaveModal, setShowSaveModal] = useState(false);
  const [savedFieldId, setSavedFieldId] = useState(null);

  const mapContainer = useRef(null);
  const map = useRef(null);
  const marker = useRef(null);
  const popup = useRef(null);
  const searchTimeout = useRef(null);
  const mapInitialized = useRef(false);
  const protocolRegistered = useRef(false);
  const protocolRef = useRef(null);
  const didFitBounds = useRef(false);

  // Drawing refs (avoid stale closures)
  const drawModeRef = useRef(false);
  const drawnPointsRef = useRef([]);
  const drawMarkersRef = useRef([]);
  const drawLineSourceRef = useRef(null);

  useEffect(() => { if (BusinessID) LoadBusiness(BusinessID); }, [BusinessID]);

  // ─── Sync drawMode to ref ─────────────────────────────────────────────────
  useEffect(() => {
    drawModeRef.current = drawMode;
    if (map.current) {
      map.current.getCanvas().style.cursor = drawMode ? 'crosshair' : '';
    }
  }, [drawMode]);

  // ─── Draw helpers ─────────────────────────────────────────────────────────
  const clearDrawing = useCallback(() => {
    drawMarkersRef.current.forEach(m => m.remove());
    drawMarkersRef.current = [];
    drawnPointsRef.current = [];
    setDrawnPolygon([]);
    if (map.current) {
      if (map.current.getSource('draw-polygon')) {
        map.current.getSource('draw-polygon').setData({ type: 'Feature', geometry: { type: 'Polygon', coordinates: [[]] }, properties: {} });
      }
      if (map.current.getSource('draw-line')) {
        map.current.getSource('draw-line').setData({ type: 'Feature', geometry: { type: 'LineString', coordinates: [] }, properties: {} });
      }
    }
  }, []);

  const updateDrawLayers = useCallback(() => {
    if (!map.current) return;
    const pts = drawnPointsRef.current;

    // Update preview line
    if (map.current.getSource('draw-line')) {
      map.current.getSource('draw-line').setData({
        type: 'Feature',
        geometry: { type: 'LineString', coordinates: pts },
        properties: {},
      });
    }

    // Update filled polygon when we have 3+ points
    if (pts.length >= 3 && map.current.getSource('draw-polygon')) {
      const ring = [...pts, pts[0]];
      map.current.getSource('draw-polygon').setData({
        type: 'Feature',
        geometry: { type: 'Polygon', coordinates: [ring] },
        properties: {},
      });
    }
  }, []);

  const finishDrawing = useCallback(() => {
    const pts = drawnPointsRef.current;
    if (pts.length < 3) {
      alert('Draw at least 3 points to define a field boundary.');
      return;
    }
    setDrawnPolygon([...pts]);
    setDrawMode(false);
    drawModeRef.current = false;
    // Finalize polygon fill
    if (map.current && map.current.getSource('draw-polygon')) {
      const ring = [...pts, pts[0]];
      map.current.getSource('draw-polygon').setData({
        type: 'Feature',
        geometry: { type: 'Polygon', coordinates: [ring] },
        properties: {},
      });
    }
    if (map.current && map.current.getSource('draw-line')) {
      map.current.getSource('draw-line').setData({ type: 'Feature', geometry: { type: 'LineString', coordinates: [] }, properties: {} });
    }
  }, []);

  // ─── Analysis fetch ───────────────────────────────────────────────────────
  const fetchAnalysis = useCallback(async (lat, lon, cropName, props) => {
    setLoading(true);
    setShowAnalytics(true);
    try {
      const res = await fetch(`${GCP_API}?lat=${lat}&lon=${lon}`);
      if (!res.ok) throw new Error(res.statusText);
      const data = await res.json();
      const history = data.history || {};

      let soil = { ph: 6.5, soc: 20, sand: 35, clay: 25, silt: 40, nitrogen: 2.5 };
      let depthSummaries = [];
      let depthKeys = [];
      let topDepthKey = null;

      if (data.soil?.status === 'ok' && data.soil?.depths) {
        const depths = data.soil.depths;
        depthKeys = Object.keys(depths);
        topDepthKey = depthKeys.includes('0-5 cm') ? '0-5 cm'
          : depthKeys.includes('0-5cm') ? '0-5cm'
          : depthKeys[0] || null;
        const topLayer = depths[topDepthKey] || Object.values(depths)[0];
        if (topLayer) soil = normalizeSoilLayer(topLayer) || soil;
        depthSummaries = depthKeys
          .map(key => ({ depth: key, soil: normalizeSoilLayer(depths[key]) }))
          .filter(e => e.soil);
      }

      setFieldData({
        cropName, county: props.CNTY, acres: props.CSBACRES,
        history, soil, depthKeys, topDepthKey, depthSummaries,
        recommendations: data.recommendations || [],
        texture: getTextureClass(soil.sand, soil.clay),
        healthData: getHealthScore(soil),
        fertilizerPlan: getFertilizerPlan(soil),
        location: { lat, lon },
      });
    } catch (e) {
      console.error('Analysis error:', e);
      alert('Analysis failed. Ensure the Cloud Function is active.');
    } finally {
      setLoading(false);
    }
  }, []);

  // ─── Map click handler ────────────────────────────────────────────────────
  const handleMapClick = useCallback((e) => {
    if (!map.current) return;

    // ── DRAW MODE: add a point ──
    if (drawModeRef.current) {
      const { lng, lat } = e.lngLat;
      drawnPointsRef.current = [...drawnPointsRef.current, [lng, lat]];

      // Add a small marker dot
      const el = document.createElement('div');
      el.style.cssText = 'width:10px;height:10px;border-radius:50%;background:#1e40af;border:2px solid white;box-shadow:0 0 4px rgba(0,0,0,0.4)';
      const m = new maplibregl.Marker({ element: el }).setLngLat([lng, lat]).addTo(map.current);
      drawMarkersRef.current.push(m);

      updateDrawLayers();
      return;
    }

    // ── NORMAL MODE: field analysis ──
    const features = map.current.queryRenderedFeatures(e.point, { layers: ['visual-layer'] });
    if (!features?.length) return;
    const props = features[0].properties;
    const lat = e.lngLat.lat; const lon = e.lngLat.lng;
    const cropName = CROP_LOOKUP[props.CROP_TYPE] || 'Unknown';
    const acres = props.CSBACRES ? parseFloat(props.CSBACRES).toFixed(2) : 'N/A';
    if (popup.current) popup.current.remove();

    const el = document.createElement('div');
    el.style.cssText = 'padding:16px;font-family:system-ui,sans-serif;min-width:220px';
    el.innerHTML = `
      <h3 style="margin:0 0 10px;color:#1e293b;font-size:17px;font-weight:700">${cropName}</h3>
      <div style="font-size:13px;color:#64748b;margin-bottom:14px">
        <div><strong style="color:#475569">Acres:</strong> ${acres}</div>
        <div><strong style="color:#475569">County:</strong> ${props.CNTY || 'N/A'}</div>
      </div>
    `;
    const btn = document.createElement('button');
    btn.innerText = 'Run Field Analysis';
    btn.style.cssText = 'width:100%;padding:12px 16px;background:#1e40af;color:white;border:none;border-radius:8px;cursor:pointer;font-weight:600;font-size:14px';
    btn.onclick = (ev) => { ev.preventDefault(); fetchAnalysis(lat, lon, cropName, props); };
    el.appendChild(btn);

    popup.current = new maplibregl.Popup({ closeButton: true, maxWidth: '320px', className: 'custom-popup' })
      .setLngLat(e.lngLat).setDOMContent(el).addTo(map.current);
  }, [fetchAnalysis, updateDrawLayers]);

  // ─── Address search ───────────────────────────────────────────────────────
  const handleAddressChange = (val) => {
    setAddress(val);
    if (val.length < 3) { setShowSuggestions(false); return; }
    if (searchTimeout.current) clearTimeout(searchTimeout.current);
    setIsSearching(true);
    searchTimeout.current = setTimeout(async () => {
      try {
        const res = await fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(val)}&countrycodes=us&limit=8&addressdetails=1`, { headers: { 'User-Agent': 'CropDashboard/1.0' } });
        const data = await res.json();
        const ranked = Array.isArray(data)
          ? data.map(item => ({ ...item, rankScore: item.display_name.toLowerCase().startsWith(val.toLowerCase()) ? 100 : 0 }))
              .sort((a, b) => b.rankScore - a.rankScore).slice(0, 5)
          : [];
        setSuggestions(ranked);
        setShowSuggestions(ranked.length > 0);
      } catch { setSuggestions([]); }
      finally { setIsSearching(false); }
    }, 400);
  };

  const selectSuggestion = (sug) => {
    setAddress(sug.display_name.split(',')[0]);
    setShowSuggestions(false);
    if (!map.current) return;
    const lat = parseFloat(sug.lat); const lon = parseFloat(sug.lon);
    if (marker.current) marker.current.remove();
    marker.current = new maplibregl.Marker({ color: '#ef4444' }).setLngLat([lon, lat]).addTo(map.current);
    map.current.flyTo({ center: [lon, lat], zoom: 15, duration: 2000 });
  };

  // ─── Map init ──────────────────────────────────────────────────────────────
  useEffect(() => {
    let mounted = true;
    const init = async () => {
      if (mapInitialized.current || !mapContainer.current) return;
      if (!mounted) return;

      if (!protocolRegistered.current) {
        try {
          const protocol = new Protocol();
          maplibregl.addProtocol('pmtiles', protocol.tile);
          protocolRef.current = protocol;
          protocolRegistered.current = true;
        } catch (e) {
          console.error('PMTiles protocol registration failed:', e.message);
          return;
        }
      }

      mapInitialized.current = true;
      map.current = new maplibregl.Map({
        container: mapContainer.current,
        center: [-98.5795, 39.8283], zoom: 4,
        maxTileCacheSize: 4, fadeDuration: 0, attributionControl: false,
        style: {
          version: 8,
          sources: { osm: { type: 'raster', tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'], tileSize: 256, maxzoom: 19, volatile: true } },
          layers: [{ id: 'osm', type: 'raster', source: 'osm' }],
        },
      });
      map.current.addControl(new maplibregl.NavigationControl({ showCompass: false }), 'top-right');

      map.current.on('load', async () => {
        if (!map.current) return;
        let vectorLayerName = 'crops2024';

        try {
          const rawUrl = PMTILES_2024.replace(/^pmtiles:\/\//, '');
          const pm = new PMTiles(rawUrl);
          const header = await pm.getHeader();
          const metadata = await pm.getMetadata();
          vectorLayerName = metadata?.vector_layers?.[0]?.id || vectorLayerName;
          if (!didFitBounds.current && header?.minLon !== undefined) {
            didFitBounds.current = true;
            map.current.fitBounds(
              [[header.minLon, header.minLat], [header.maxLon, header.maxLat]],
              { padding: 40, duration: 1200 }
            );
          }
        } catch (e) {
          console.warn('PMTiles metadata read failed:', e?.message || e);
        }

        try {
          map.current.addSource('crops2024', { type: 'vector', url: PMTILES_2024, maxzoom: 14 });
        } catch (e) {
          console.error('Error adding vector source:', e.message); return;
        }

        try {
          map.current.addLayer({
            id: 'visual-layer', type: 'fill', source: 'crops2024',
            'source-layer': vectorLayerName,
            paint: {
              'fill-color': [
                'match', ['to-string', ['get', 'CROP_TYPE']],
                '1',   CROP_COLORS['1'],  '5',   CROP_COLORS['5'],
                '24',  CROP_COLORS['24'], '36',  CROP_COLORS['36'],
                '61',  CROP_COLORS['61'], '66',  CROP_COLORS['66'],
                '69',  CROP_COLORS['69'], '75',  CROP_COLORS['75'],
                '77',  CROP_COLORS['77'], '176', CROP_COLORS['176'],
                '204', CROP_COLORS['204'],'212', CROP_COLORS['212'],
                '#cccccc',
              ],
              'fill-opacity': 0.7,
            },
          });

          map.current.addLayer({
            id: 'visual-layer-outline', type: 'line', source: 'crops2024',
            'source-layer': vectorLayerName,
            paint: { 'line-color': '#90EE90', 'line-width': 1, 'line-opacity': 0.6 },
          });
        } catch (e) {
          console.error('Error adding fill layer:', e.message);
        }

        // ── Drawing layers ──
        map.current.addSource('draw-polygon', {
          type: 'geojson',
          data: { type: 'Feature', geometry: { type: 'Polygon', coordinates: [[]] }, properties: {} },
        });
        map.current.addLayer({
          id: 'draw-polygon-fill', type: 'fill', source: 'draw-polygon',
          paint: { 'fill-color': '#1e40af', 'fill-opacity': 0.2 },
        });
        map.current.addLayer({
          id: 'draw-polygon-outline', type: 'line', source: 'draw-polygon',
          paint: { 'line-color': '#1e40af', 'line-width': 2.5, 'line-dasharray': [2, 1] },
        });

        map.current.addSource('draw-line', {
          type: 'geojson',
          data: { type: 'Feature', geometry: { type: 'LineString', coordinates: [] }, properties: {} },
        });
        map.current.addLayer({
          id: 'draw-line-layer', type: 'line', source: 'draw-line',
          paint: { 'line-color': '#1e40af', 'line-width': 2, 'line-dasharray': [3, 2] },
        });

        map.current.on('click', handleMapClick);
        map.current.on('mousemove', 'visual-layer', () => {
          if (map.current && !drawModeRef.current) map.current.getCanvas().style.cursor = 'pointer';
        });
        map.current.on('mouseleave', 'visual-layer', () => {
          if (map.current && !drawModeRef.current) map.current.getCanvas().style.cursor = '';
        });
        map.current.on('error', (e) => {
          if (e.sourceId === 'crops2024') console.error('Tile error:', e.error);
        });
      });
    };

    init();
    return () => {
      mounted = false;
      if (map.current) { map.current.remove(); map.current = null; mapInitialized.current = false; }
    };
  }, []);

  // ─── Drawing toolbar buttons ───────────────────────────────────────────────
  const startDrawing = () => {
    clearDrawing();
    setDrawMode(true);
    if (popup.current) popup.current.remove();
  };

  const cancelDrawing = () => {
    clearDrawing();
    setDrawMode(false);
  };

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div style={{ margin: '-24px', display: 'flex', flexDirection: 'column' }}>

        {/* Title bar */}
        <div style={{ padding: '12px 24px', background: 'white', borderBottom: '1px solid #e8e0d5', display: 'flex', alignItems: 'center', gap: 12, flexShrink: 0 }}>
          <span style={{ fontSize: 22 }}>🌾</span>
          <div>
            <div style={{ fontFamily: 'Georgia,serif', fontWeight: 700, fontSize: 17, color: '#2c1a0e' }}>Crop Detection</div>
            <div style={{ fontSize: 12, color: '#8b7355' }}>Zoom in and click any colored field to analyze soil health, fertilizer needs, and view crop rotation history (2009–2024)</div>
          </div>
        </div>

        {/* Map area */}
        <div style={{ position: 'relative', height: 'calc(100vh - 170px)', minHeight: 480 }}>

          {/* Left sidebar */}
          <div style={{ position: 'absolute', top: 0, left: 0, bottom: 0, width: 300, background: 'white', zIndex: 20, boxShadow: '2px 0 16px rgba(0,0,0,0.08)', display: 'flex', flexDirection: 'column' }}>

            <div style={{ padding: '18px 16px 14px', background: 'linear-gradient(135deg,#1a237e,#283593)', color: 'white', display: 'flex', alignItems: 'center', gap: 10 }}>
              <span style={{ fontSize: 20 }}>🗺</span>
              <div>
                <div style={{ fontWeight: 700, fontSize: 15 }}>Crop & Soil Analytics</div>
                <div style={{ fontSize: 11, opacity: 0.8 }}>USDA Cropland Data 2024</div>
              </div>
            </div>

            <div style={{ padding: '14px 14px 0' }}>
              {/* Search */}
              <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 8, display: 'flex', alignItems: 'center', gap: 5 }}>
                📍 Find Location
              </div>
              <div style={{ position: 'relative' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8, border: '2px solid #e2e8f0', borderRadius: 10, padding: '10px 12px', background: 'white' }}>
                  <span style={{ color: '#64748b', fontSize: 14 }}>🔍</span>
                  <input
                    type="text" placeholder="Search US address…" value={address}
                    onChange={e => handleAddressChange(e.target.value)}
                    onFocus={() => suggestions.length > 0 && setShowSuggestions(true)}
                    style={{ border: 'none', background: 'transparent', flex: 1, outline: 'none', fontSize: 13, color: '#1e293b' }}
                  />
                  {isSearching && <span style={{ fontSize: 11, color: '#94a3b8', animation: 'cdspin 1s linear infinite', display: 'inline-block' }}>⟳</span>}
                  {address && !isSearching && (
                    <span onClick={() => { setAddress(''); setShowSuggestions(false); }} style={{ cursor: 'pointer', color: '#94a3b8', fontSize: 15, lineHeight: 1 }}>✕</span>
                  )}
                </div>
                {showSuggestions && suggestions.length > 0 && (
                  <div style={{ position: 'absolute', top: '100%', left: 0, right: 0, background: 'white', border: '1px solid #e2e8f0', borderRadius: 10, boxShadow: '0 10px 40px rgba(0,0,0,0.12)', zIndex: 100, maxHeight: 300, overflowY: 'auto', marginTop: 4 }}>
                    {suggestions.map((sug, i) => (
                      <div key={i} onClick={() => selectSuggestion(sug)}
                        style={{ padding: '12px 14px', cursor: 'pointer', borderBottom: '1px solid #f1f5f9', fontSize: 13, display: 'flex', alignItems: 'flex-start', gap: 10 }}
                        onMouseEnter={e => e.currentTarget.style.background = '#f8fafc'}
                        onMouseLeave={e => e.currentTarget.style.background = 'white'}
                      >
                        <span style={{ color: '#64748b', flexShrink: 0, marginTop: 1 }}>📍</span>
                        <div>
                          <div style={{ fontWeight: 500, color: '#1e293b' }}>{sug.display_name.split(',')[0]}</div>
                          <div style={{ fontSize: 11, color: '#64748b', marginTop: 2 }}>{sug.display_name.split(',').slice(1, 3).join(',')}</div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {/* ── Field Drawing Controls ── */}
              <div style={{ marginTop: 16, marginBottom: 4 }}>
                <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 8, display: 'flex', alignItems: 'center', gap: 5 }}>
                  ✏️ Define Field Boundary
                </div>

                {!drawMode && drawnPolygon.length === 0 && (
                  <button onClick={startDrawing} style={{
                    width: '100%', padding: '10px 12px', background: '#1e40af', color: 'white',
                    border: 'none', borderRadius: 8, cursor: 'pointer', fontWeight: 600, fontSize: 13,
                    display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
                  }}>
                    ✏️ Draw Field
                  </button>
                )}

                {drawMode && (
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                    <div style={{ background: '#eff6ff', border: '1px solid #bfdbfe', borderRadius: 8, padding: '10px 12px', fontSize: 12, color: '#1e40af', lineHeight: 1.5 }}>
                      <strong>Click on the map</strong> to place boundary points.<br />
                      Place at least 3 points, then click <strong>Finish</strong>.
                    </div>
                    <div style={{ fontSize: 12, color: '#6b7280', textAlign: 'center' }}>
                      {drawnPointsRef.current.length} point{drawnPointsRef.current.length !== 1 ? 's' : ''} placed
                    </div>
                    <div style={{ display: 'flex', gap: 8 }}>
                      <button onClick={cancelDrawing} style={{
                        flex: 1, padding: '9px', background: '#f3f4f6', border: 'none',
                        borderRadius: 8, cursor: 'pointer', fontWeight: 600, fontSize: 12, color: '#374151',
                      }}>✕ Cancel</button>
                      <button onClick={finishDrawing} style={{
                        flex: 2, padding: '9px', background: '#166534', color: 'white',
                        border: 'none', borderRadius: 8, cursor: 'pointer', fontWeight: 600, fontSize: 12,
                      }}>✓ Finish Drawing</button>
                    </div>
                  </div>
                )}

                {!drawMode && drawnPolygon.length > 0 && (
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                    <div style={{ background: '#f0fdf4', border: '1px solid #86efac', borderRadius: 8, padding: '10px 12px', fontSize: 12, color: '#166534' }}>
                      ✓ Field boundary drawn — <strong>{calcPolygonAcres(drawnPolygon)} acres</strong>
                    </div>
                    <div style={{ display: 'flex', gap: 8 }}>
                      <button onClick={startDrawing} style={{
                        flex: 1, padding: '9px', background: '#f3f4f6', border: 'none',
                        borderRadius: 8, cursor: 'pointer', fontWeight: 600, fontSize: 12, color: '#374151',
                      }}>↺ Redraw</button>
                      <button onClick={() => setShowSaveModal(true)} style={{
                        flex: 2, padding: '9px', background: '#166534', color: 'white',
                        border: 'none', borderRadius: 8, cursor: 'pointer', fontWeight: 600, fontSize: 12,
                      }}>💾 Save Field</button>
                    </div>
                  </div>
                )}
              </div>
            </div>

            {/* Legend */}
            <div style={{ flex: 1, overflowY: 'auto', padding: '14px' }}>
              <div style={{ fontSize: 11, fontWeight: 700, color: '#475569', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 10, display: 'flex', alignItems: 'center', gap: 5 }}>
                🌈 Crop Legend (2024)
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '6px 10px' }}>
                {Object.entries(CROP_COLORS).map(([code, color]) => (
                  <div key={code} style={{ display: 'flex', alignItems: 'center', gap: 8, fontSize: 11, color: '#475569', padding: '3px 0' }}>
                    <span style={{ width: 12, height: 12, borderRadius: 3, background: color, flexShrink: 0, boxShadow: '0 1px 3px rgba(0,0,0,0.15)' }} />
                    {CROP_LOOKUP[parseInt(code)] || code}
                  </div>
                ))}
              </div>
            </div>

            <div style={{ padding: '8px 14px', background: '#f9fafb', borderTop: '1px solid #e5e7eb', fontSize: 10, color: '#9ca3af' }}>
              GCP Cloud Functions · USDA CDL 2024 · OpenStreetMap
            </div>
          </div>

          {/* Map canvas */}
          <div style={{ position: 'absolute', inset: 0, left: 300 }}>
            <div ref={mapContainer} style={{ width: '100%', height: '100%' }} />
          </div>

          {/* Draw mode floating hint */}
          {drawMode && (
            <div style={{
              position: 'absolute', bottom: 24, left: '50%', transform: 'translateX(-50%)',
              background: 'rgba(30,64,175,0.92)', color: 'white', padding: '10px 20px',
              borderRadius: 24, fontSize: 13, fontWeight: 600, zIndex: 35,
              boxShadow: '0 4px 16px rgba(0,0,0,0.2)', backdropFilter: 'blur(4px)',
              pointerEvents: 'none',
            }}>
              ✏️ Click to add boundary points · {drawnPointsRef.current.length} placed
            </div>
          )}

          {/* Loading overlay */}
          {loading && (
            <div style={{
              position: 'absolute', inset: 0, left: 300,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              zIndex: 40, pointerEvents: 'none',
            }}>
              <div style={{
                display: 'flex', alignItems: 'center', gap: 16,
                padding: '18px 24px', borderRadius: 14,
                background: 'rgba(255,255,255,0.93)',
                border: '1px solid #e2e8f0',
                boxShadow: '0 20px 50px rgba(15,23,42,0.18)',
                backdropFilter: 'blur(8px)',
              }}>
                <div style={{
                  width: 56, height: 56, borderRadius: '50%',
                  background: 'radial-gradient(circle at 30% 30%,#e0f2fe 0%,#f8fafc 60%,#fff 100%)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  border: '1px solid #dbeafe', fontSize: 28,
                  animation: 'cdspin 1s linear infinite',
                }}>⟳</div>
                <div>
                  <div style={{ fontSize: 15, fontWeight: 700, color: '#0f172a' }}>Analyzing Field</div>
                  <div style={{ fontSize: 12, color: '#64748b', marginTop: 3 }}>Fetching soil & crop data…</div>
                </div>
              </div>
            </div>
          )}

          {/* Analysis drawer */}
          <AnalysisDrawer
            open={showAnalytics}
            fieldData={fieldData}
            onClose={() => setShowAnalytics(false)}
            onSaveField={() => setShowSaveModal(true)}
            drawnPolygon={drawnPolygon}
            businessID={BusinessID}
          />
        </div>
      </div>

      {/* Save Field Modal */}
      <SaveFieldModal
        open={showSaveModal}
        onClose={() => setShowSaveModal(false)}
        onSave={(id) => { setSavedFieldId(id); alert(`✓ Field saved successfully (ID: ${id})`); }}
        fieldData={fieldData}
        drawnPolygon={drawnPolygon}
        businessId={BusinessID}
        peopleId={PeopleID}
      />

      <style>{`@keyframes cdspin { 100% { transform: rotate(360deg); } }`}</style>
    </AccountLayout>
  );
}