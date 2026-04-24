import React, { useRef, useState } from 'react';
import { Link } from 'react-router-dom';
import RelatedSuggestions from './RelatedSuggestions.jsx';

const SAIGE_API = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8001/saige';

function confidenceColor(c) {
  if (c === 'high') return { bg: '#ecfdf5', border: '#86efac', color: '#065f46' };
  if (c === 'medium') return { bg: '#fefce8', border: '#fde047', color: '#854d0e' };
  return { bg: '#fef2f2', border: '#fca5a5', color: '#991b1b' };
}

export default function PestDetection() {
  const [preview, setPreview] = useState(null);
  const [notes, setNotes] = useState('');
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState('');
  const fileInput = useRef(null);

  const pickFile = (file) => {
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => setPreview(reader.result);
    reader.readAsDataURL(file);
  };

  const detect = async () => {
    if (!preview) return;
    setLoading(true);
    setResult(null);
    setErr('');
    try {
      const r = await fetch(`${SAIGE_API}/pest/detect`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          image_base64: preview,
          notes,
          user_id: String(JSON.parse(localStorage.getItem('ofnUser') || '{}')?.PeopleID || 'anon'),
        }),
      });
      const j = await r.json();
      if (j?.status === 'ok') setResult(j);
      else setErr(j?.message || 'Detection failed.');
    } catch {
      setErr('Could not reach detection service.');
    } finally {
      setLoading(false);
    }
  };

  const c = result ? confidenceColor(result.confidence) : null;

  return (
    <div style={{ maxWidth: 900, margin: '0 auto', padding: '24px 20px', fontFamily: 'Inter, system-ui, sans-serif' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 6 }}>
        <img src="/images/AI-agent-logo-saige.svg" alt="" style={{ width: 36, height: 36 }} />
        <h1 style={{ margin: 0, fontSize: 26, fontWeight: 800, color: '#14532d' }}>Pest & Disease Detection</h1>
      </div>
      <p style={{ color: '#4b5563', marginTop: 4, marginBottom: 18 }}>
        Upload a close-up photo of a leaf, stem, fruit, or whole plant. We'll identify
        likely pests, diseases, or deficiencies and suggest next steps. For confirmed
        diagnoses, also consult your local extension office.
        <Link to="/saige"> Ask Saige</Link> for deeper follow-up questions.
      </p>

      <div style={{ background: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: 12, padding: 16, marginBottom: 14 }}>
        <input
          ref={fileInput}
          type="file"
          accept="image/*"
          capture="environment"
          onChange={(e) => pickFile(e.target.files?.[0])}
          style={{ display: 'block', marginBottom: 12 }}
        />
        {preview && (
          <img src={preview} alt="preview" style={{ maxWidth: '100%', maxHeight: 320, borderRadius: 8, marginBottom: 12 }} />
        )}
        <label style={{ fontSize: 13, color: '#374151' }}>Notes (optional — symptoms, crop, when it started)</label>
        <textarea
          value={notes}
          onChange={(e) => setNotes(e.target.value)}
          rows={3}
          placeholder="e.g., Yellowing started 3 days ago after heavy rain, corn seedlings"
          style={{ display: 'block', width: '100%', padding: '8px 10px', border: '1px solid #d1d5db', borderRadius: 8, marginTop: 4 }}
        />
        <button
          onClick={detect}
          disabled={!preview || loading}
          style={{ marginTop: 12, padding: '10px 20px', background: '#14532d', color: '#fff', border: 'none', borderRadius: 8, cursor: (!preview || loading) ? 'not-allowed' : 'pointer', opacity: (!preview || loading) ? 0.5 : 1 }}
        >{loading ? 'Analyzing photo…' : 'Identify problem'}</button>
      </div>

      {err && <div style={{ background: '#fef2f2', border: '1px solid #fca5a5', color: '#991b1b', padding: 10, borderRadius: 8 }}>{err}</div>}

      {result && (
        <div style={{ background: c.bg, border: `1px solid ${c.border}`, borderRadius: 12, padding: 16 }}>
          <div style={{ fontSize: 18, fontWeight: 700, color: c.color, textTransform: 'capitalize' }}>
            {result.diagnosis} <span style={{ fontSize: 14, fontWeight: 400 }}>({result.category}, confidence: {result.confidence})</span>
          </div>
          {result.crop_identified && result.crop_identified !== 'unknown' && (
            <div style={{ fontSize: 13, color: '#6b7280', marginTop: 2 }}>Crop identified: {result.crop_identified}</div>
          )}
          {result.symptoms_observed?.length > 0 && (
            <>
              <div style={{ marginTop: 12, fontWeight: 600 }}>Symptoms observed</div>
              <ul style={{ margin: '4px 0 0 0', paddingLeft: 22, lineHeight: 1.5 }}>
                {result.symptoms_observed.map((s, i) => <li key={i}>{s}</li>)}
              </ul>
            </>
          )}
          {result.recommended_actions?.length > 0 && (
            <>
              <div style={{ marginTop: 12, fontWeight: 600 }}>Recommended actions</div>
              <ul style={{ margin: '4px 0 0 0', paddingLeft: 22, lineHeight: 1.5 }}>
                {result.recommended_actions.map((s, i) => <li key={i}>{s}</li>)}
              </ul>
            </>
          )}
          {result.look_alikes?.length > 0 && (
            <div style={{ marginTop: 12, fontSize: 13 }}>
              <strong>Rule out:</strong> {result.look_alikes.join(', ')}
            </div>
          )}
          {result.notes && (
            <div style={{ marginTop: 10, fontSize: 13, color: '#4b5563' }}>
              <strong>Notes:</strong> {result.notes}
            </div>
          )}
          <RelatedSuggestions
            heading="Companion plants that may help"
            items={result.related_suggestions || []}
          />
          <div style={{ marginTop: 14 }}>
            <Link
              to={`/saige?prompt=${encodeURIComponent(
                `I just ran a pest-scan photo and Saige diagnosed "${result.diagnosis}" (${result.confidence} confidence) on ${result.crop_identified || 'my crop'}. ` +
                (notes ? `My notes: ${notes}. ` : '') +
                `What should I do next — especially organic or IPM options? Any timing advice given current season?`
              )}`}
              style={{ display: 'inline-block', padding: '10px 18px', background: '#0f766e', color: '#fff', borderRadius: 8, textDecoration: 'none', fontWeight: 600 }}
            >
              Ask Saige about this diagnosis →
            </Link>
          </div>
        </div>
      )}
    </div>
  );
}
