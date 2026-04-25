import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

// ─── Print stylesheet ───────────────────────────────────────────────────────
// Hides ALL site chrome and isolates the report. Uses visibility tricks
// because some sidebars are plain <div>s (not <aside>) and we can't rely on
// element selectors alone.
function PrintStyles() {
  return (
    <style>{`
      @media print {
        @page { margin: 0.5in; size: letter; }
        html, body { background: white !important; margin: 0 !important; padding: 0 !important; }

        /* Hide every visual element on the page... */
        body * { visibility: hidden !important; }

        /* ...then re-show only the report and its descendants. */
        .printable-report, .printable-report * { visibility: visible !important; }

        /* Pull the report out of any sidebar-padded shell so it fills the page. */
        .printable-report {
          position: absolute !important;
          top: 0 !important;
          left: 0 !important;
          right: 0 !important;
          width: 100% !important;
          max-width: none !important;
          margin: 0 !important;
          padding: 0 !important;
        }

        /* The card itself: drop shadow/border/rounded, full bleed. */
        .report-page {
          box-shadow: none !important;
          border: none !important;
          border-radius: 0 !important;
          padding: 0 !important;
          margin: 0 !important;
          width: 100% !important;
          max-width: none !important;
        }

        .report-section { break-inside: avoid; page-break-inside: avoid; }
        .report-h1 { font-size: 22pt; }
        .report-h2 { font-size: 13pt; }
        a { color: black !important; text-decoration: none !important; }

        /* Belt-and-suspenders: anything explicitly tagged no-print stays gone. */
        .no-print { display: none !important; }
      }
    `}</style>
  );
}

// ─── Tiny presentational helpers ────────────────────────────────────────────
function SectionTitle({ children }) {
  return (
    <h2 className="report-h2 font-lora text-lg font-bold text-gray-900 mb-2 mt-6 border-b border-gray-300 pb-1">
      {children}
    </h2>
  );
}

function Bullet({ children }) {
  return (
    <li className="text-sm text-gray-800 flex items-start gap-2 leading-relaxed">
      <span className="mt-1 text-[#3D6B34]">•</span>
      <span>{children}</span>
    </li>
  );
}

function PriorityBadge({ priority }) {
  const map = {
    high:   { bg: '#FEE2E2', fg: '#991B1B', label: 'High' },
    medium: { bg: '#FEF3C7', fg: '#92400E', label: 'Medium' },
    low:    { bg: '#DCFCE7', fg: '#166534', label: 'Low' },
  };
  const s = map[(priority || '').toLowerCase()] || map.medium;
  return (
    <span
      className="inline-block text-[10px] uppercase tracking-wide font-bold px-2 py-0.5 rounded-full"
      style={{ background: s.bg, color: s.fg }}
    >
      {s.label}
    </span>
  );
}

function HealthBadge({ value }) {
  const map = {
    good:    { bg: '#DCFCE7', fg: '#166534' },
    fair:    { bg: '#FEF3C7', fg: '#92400E' },
    poor:    { bg: '#FEE2E2', fg: '#991B1B' },
    unknown: { bg: '#E5E7EB', fg: '#374151' },
  };
  const s = map[(value || '').toLowerCase()] || map.unknown;
  return (
    <span
      className="inline-block text-xs font-semibold px-2.5 py-1 rounded-full"
      style={{ background: s.bg, color: s.fg }}
    >
      {(value || 'Unknown').toUpperCase()}
    </span>
  );
}

// ─── Section renderers ──────────────────────────────────────────────────────
function ExecSummary({ summary, confidence }) {
  return (
    <div className="report-section bg-[#F8F4EA] border border-[#E8DDC2] rounded-xl p-5">
      <div className="flex items-start justify-between flex-wrap gap-3">
        <h2 className="report-h2 font-lora text-lg font-bold text-gray-900">Executive Summary</h2>
        {confidence && (
          <span className="text-xs text-gray-500 font-mont">
            Confidence: <span className="font-bold uppercase">{confidence}</span>
          </span>
        )}
      </div>
      <p className="mt-2 text-[15px] leading-relaxed text-gray-800">{summary}</p>
    </div>
  );
}

function CurrentStatusSection({ data }) {
  if (!data) return null;
  return (
    <div className="report-section">
      <SectionTitle>Current Status</SectionTitle>
      <div className="flex flex-wrap gap-6 mb-3">
        <div>
          <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Growth Stage</div>
          <div className="text-base font-mont text-gray-900 mt-1">{data.growth_stage || '—'}</div>
        </div>
        <div>
          <div className="text-[10px] uppercase tracking-wide text-gray-500 font-semibold">Overall Health</div>
          <div className="mt-1"><HealthBadge value={data.overall_health} /></div>
        </div>
      </div>
      {data.highlights?.length > 0 && (
        <ul className="space-y-1">
          {data.highlights.map((h, i) => <Bullet key={i}>{h}</Bullet>)}
        </ul>
      )}
    </div>
  );
}

function SoilSection({ data }) {
  if (!data) return null;
  return (
    <div className="report-section">
      <SectionTitle>Soil &amp; Nutrients</SectionTitle>
      {data.summary && <p className="text-sm text-gray-800 mb-3 leading-relaxed">{data.summary}</p>}
      {data.concerns?.length > 0 && (
        <>
          <div className="text-[11px] uppercase tracking-wide text-gray-500 font-semibold mt-3 mb-1">Concerns</div>
          <ul className="space-y-1 mb-3">
            {data.concerns.map((c, i) => <Bullet key={i}>{c}</Bullet>)}
          </ul>
        </>
      )}
      {data.recommended_amendments?.length > 0 && (
        <>
          <div className="text-[11px] uppercase tracking-wide text-gray-500 font-semibold mt-3 mb-1">Recommended Amendments</div>
          <table className="w-full text-sm border border-gray-200 rounded">
            <thead className="bg-gray-50 text-gray-600 text-left text-xs">
              <tr>
                <th className="px-3 py-2 font-semibold">Product</th>
                <th className="px-3 py-2 font-semibold">Rate</th>
                <th className="px-3 py-2 font-semibold">Reason</th>
              </tr>
            </thead>
            <tbody>
              {data.recommended_amendments.map((a, i) => (
                <tr key={i} className="border-t border-gray-100">
                  <td className="px-3 py-2 font-medium">{a.product}</td>
                  <td className="px-3 py-2">{a.rate}</td>
                  <td className="px-3 py-2 text-gray-700">{a.reason}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </>
      )}
    </div>
  );
}

function WeatherSection({ data }) {
  if (!data) return null;
  return (
    <div className="report-section">
      <SectionTitle>Weather &amp; Climate Outlook</SectionTitle>
      {data.summary && <p className="text-sm text-gray-800 mb-3 leading-relaxed">{data.summary}</p>}
      {data.key_risks?.length > 0 && (
        <ul className="space-y-1">
          {data.key_risks.map((r, i) => <Bullet key={i}>{r}</Bullet>)}
        </ul>
      )}
    </div>
  );
}

function PlantStatusSection({ data }) {
  if (!data) return null;
  return (
    <div className="report-section">
      <SectionTitle>Plant Status Assessment</SectionTitle>
      {data.summary && <p className="text-sm text-gray-800 mb-3 leading-relaxed">{data.summary}</p>}
      {data.issues_observed?.length > 0 && (
        <>
          <div className="text-[11px] uppercase tracking-wide text-gray-500 font-semibold mt-3 mb-1">Issues Observed</div>
          <ul className="space-y-1">
            {data.issues_observed.map((i, k) => <Bullet key={k}>{i}</Bullet>)}
          </ul>
        </>
      )}
    </div>
  );
}

function TreatmentsSection({ items }) {
  if (!items?.length) return null;
  return (
    <div className="report-section">
      <SectionTitle>Treatment Recommendations</SectionTitle>
      <div className="space-y-2">
        {items.map((t, i) => (
          <div key={i} className="border border-gray-200 rounded-lg p-3 bg-white">
            <div className="flex items-start justify-between gap-3 flex-wrap">
              <div className="flex-1">
                <div className="font-mont font-semibold text-gray-900">{t.action}</div>
                {t.timing && <div className="text-xs text-gray-500 mt-0.5">Timing: {t.timing}</div>}
              </div>
              <PriorityBadge priority={t.priority} />
            </div>
            {t.reason && <p className="text-sm text-gray-700 mt-2 leading-relaxed">{t.reason}</p>}
          </div>
        ))}
      </div>
    </div>
  );
}

function HarvestSection({ data }) {
  if (!data) return null;
  return (
    <div className="report-section">
      <SectionTitle>Harvest / Termination Guidance</SectionTitle>
      <p className="text-sm text-gray-800 leading-relaxed">{data.summary}</p>
      {data.applies && data.specific_dates?.length > 0 && (
        <div className="mt-3">
          <div className="text-[11px] uppercase tracking-wide text-gray-500 font-semibold mb-1">Target Dates</div>
          <div className="flex flex-wrap gap-2">
            {data.specific_dates.map((d, i) => (
              <span key={i} className="px-3 py-1 rounded-full border border-[#3D6B34] text-[#3D6B34] text-sm font-mont font-semibold">
                {d}
              </span>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

function NextCropsSection({ items }) {
  if (!items?.length) return null;
  return (
    <div className="report-section">
      <SectionTitle>Next-Crop Recommendations</SectionTitle>
      <div className="grid md:grid-cols-2 gap-3">
        {items.map((c, i) => (
          <div key={i} className="border border-gray-200 rounded-lg p-3 bg-white">
            <div className="font-mont font-bold text-gray-900">
              {c.crop}
              {c.variety_hint && <span className="text-gray-500 font-normal text-sm"> · {c.variety_hint}</span>}
            </div>
            {c.best_planting_window && (
              <div className="text-xs text-gray-500 mt-0.5">Plant: {c.best_planting_window}</div>
            )}
            {c.rationale && <p className="text-sm text-gray-700 mt-2 leading-relaxed">{c.rationale}</p>}
          </div>
        ))}
      </div>
    </div>
  );
}

function GapsSection({ items }) {
  if (!items?.length) return null;
  return (
    <div className="report-section">
      <SectionTitle>Data Gaps</SectionTitle>
      <p className="text-xs text-gray-500 mb-2 italic">Collecting these will sharpen the next assessment.</p>
      <ul className="space-y-1">
        {items.map((g, i) => <Bullet key={i}>{g}</Bullet>)}
      </ul>
    </div>
  );
}

function ReportHeader({ field, generatedAt }) {
  return (
    <div className="border-b border-gray-300 pb-4 mb-2">
      <div className="flex items-start justify-between flex-wrap gap-3">
        <div>
          <div className="text-xs uppercase tracking-wide text-[#3D6B34] font-bold">Field Assessment Report</div>
          <h1 className="report-h1 font-lora text-3xl font-bold text-gray-900 mt-1">
            {field?.name || `Field ${field?.field_id}`}
          </h1>
          <div className="mt-1 text-sm text-gray-600 font-mont">
            {field?.crop_type || 'No crop on file'}
            {field?.address && <> · {field.address}</>}
            {field?.size_hectares != null && <> · {field.size_hectares} ha</>}
          </div>
        </div>
        <div className="text-right text-xs text-gray-500 font-mont">
          <div>Prepared by <span className="font-bold text-gray-700">Saige</span></div>
          <div>{generatedAt ? new Date(generatedAt).toLocaleString() : ''}</div>
        </div>
      </div>
    </div>
  );
}

// ─── Page ───────────────────────────────────────────────────────────────────
export default function FieldAssessmentReport() {
  const [searchParams] = useSearchParams();
  const fieldId = searchParams.get('FieldID');
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const peopleId = typeof window !== 'undefined' ? localStorage.getItem('people_id') : null;

  // Latest stored report (or selected historical one).
  const [data, setData]       = useState(null);
  const [history, setHistory] = useState([]);
  const [generating, setGenerating] = useState(false);
  const [loadingLatest, setLoadingLatest] = useState(false);
  const [error, setError]     = useState(null);
  const [emptyKnown, setEmptyKnown] = useState(false);  // confirmed no stored report

  useEffect(() => { if (BusinessID) LoadBusiness(BusinessID); }, [BusinessID]);

  async function loadLatest() {
    if (!fieldId) return;
    setLoadingLatest(true);
    setError(null);
    try {
      const res = await fetch(`${API_URL}/api/fields/${fieldId}/assessment-report/latest`);
      if (!res.ok) throw new Error(await res.text() || `HTTP ${res.status}`);
      const payload = await res.json();
      if (payload?.report_id) {
        setData(payload);
        setEmptyKnown(false);
      } else {
        setData(null);
        setEmptyKnown(true);
      }
    } catch (e) {
      setError(e.message || 'Failed to load latest assessment');
    } finally {
      setLoadingLatest(false);
    }
  }

  async function loadHistory() {
    if (!fieldId) return;
    try {
      const res = await fetch(`${API_URL}/api/fields/${fieldId}/assessment-report/history?limit=25`);
      if (!res.ok) return;
      const payload = await res.json();
      setHistory(payload?.items || []);
    } catch { /* non-fatal */ }
  }

  async function loadById(reportId) {
    if (!fieldId || !reportId) return;
    setError(null);
    try {
      const res = await fetch(`${API_URL}/api/fields/${fieldId}/assessment-report/${reportId}`);
      if (!res.ok) throw new Error(await res.text() || `HTTP ${res.status}`);
      setData(await res.json());
      setEmptyKnown(false);
    } catch (e) {
      setError(e.message || 'Failed to load assessment');
    }
  }

  async function generate() {
    if (!fieldId) { setError('Select a field first (?FieldID=...)'); return; }
    setGenerating(true);
    setError(null);
    try {
      const url = new URL(`${API_URL}/api/fields/${fieldId}/assessment-report`);
      if (peopleId) url.searchParams.set('people_id', peopleId);
      const res = await fetch(url.toString(), { method: 'POST' });
      if (!res.ok) throw new Error(await res.text() || `HTTP ${res.status}`);
      const payload = await res.json();
      setData(payload);
      setEmptyKnown(false);
      // refresh history list so the new entry shows up at the top
      loadHistory();
    } catch (e) {
      setError(e.message || 'Failed to generate report');
    } finally {
      setGenerating(false);
    }
  }

  // Load latest + history whenever the field changes.
  useEffect(() => {
    setData(null);
    setEmptyKnown(false);
    setHistory([]);
    if (fieldId) {
      loadLatest();
      loadHistory();
    }
    // eslint-disable-next-line
  }, [fieldId]);

  const report   = data?.report;
  const field    = data?.field;
  const genAt    = data?.generated_at;
  const reportId = data?.report_id;
  const currentIsLatest = history.length > 0 && history[0].report_id === reportId;

  return (
    <AccountLayout
      Business={Business}
      BusinessID={BusinessID}
      PeopleID={peopleId}
      pageTitle="Field Assessment Report"
      breadcrumbs={[
        { label: 'Dashboard', to: '/dashboard' },
        { label: 'Precision Ag' },
        { label: 'Assessment Report' },
      ]}
    >
      <PrintStyles />

      <div className="max-w-4xl mx-auto">
        {/* Toolbar — hidden in print */}
        <div className="no-print flex items-center justify-between flex-wrap gap-3 mb-4 print:hidden">
          <div>
            <h1 className="font-lora text-2xl font-bold text-gray-900">Saige Field Assessment</h1>
            <p className="font-mont text-sm text-gray-500">
              {data && currentIsLatest && genAt && (
                <>Latest assessment generated {new Date(genAt).toLocaleString()}.</>
              )}
              {data && !currentIsLatest && genAt && (
                <>Viewing assessment from {new Date(genAt).toLocaleString()}.</>
              )}
              {!data && !loadingLatest && emptyKnown && (
                <>No assessments yet. Click Generate to create the first one.</>
              )}
              {!data && loadingLatest && <>Loading latest assessment…</>}
            </p>
          </div>
          <div className="flex items-center gap-2 flex-wrap">
            {history.length > 1 && (
              <select
                value={reportId || ''}
                onChange={(e) => loadById(Number(e.target.value))}
                className="px-3 py-2 rounded-lg border border-gray-300 text-sm font-mont text-gray-700 bg-white"
                title="View a past assessment"
              >
                {history.map((h, i) => {
                  const when = h.generated_at ? new Date(h.generated_at).toLocaleDateString() : '';
                  const tag  = i === 0 ? 'Latest' : `#${h.report_id}`;
                  return (
                    <option key={h.report_id} value={h.report_id}>
                      {tag} · {when} · {(h.overall_health || '—').toUpperCase()}
                    </option>
                  );
                })}
              </select>
            )}
            <button
              onClick={generate}
              disabled={generating || !fieldId}
              className="px-4 py-2 rounded-lg bg-[#3D6B34] text-white text-sm font-mont font-semibold hover:bg-[#2F5328] disabled:opacity-50"
            >
              {generating ? 'Generating…' : 'Generate'}
            </button>
            <button
              onClick={() => window.print()}
              disabled={!report}
              className="px-4 py-2 rounded-lg border border-gray-300 text-gray-700 text-sm font-mont font-semibold hover:bg-gray-50 disabled:opacity-40"
            >
              🖨 Print
            </button>
          </div>
        </div>

        {!fieldId && (
          <div className="bg-amber-50 border border-amber-200 text-amber-900 rounded-lg p-4 text-sm">
            No field selected. Open this page from a field's menu to generate a report.
          </div>
        )}

        {generating && (
          <div className="bg-white border border-gray-200 rounded-xl p-8 text-center text-gray-500">
            <div className="animate-pulse">Saige is reading field data, weather, soil, and history…</div>
            <div className="text-xs mt-2 text-gray-400">This usually takes 10–30 seconds.</div>
          </div>
        )}

        {error && (
          <div className="bg-red-50 border border-red-200 text-red-800 rounded-lg p-4 text-sm">
            <div className="font-semibold mb-1">Could not load assessment</div>
            <div className="font-mono text-xs whitespace-pre-wrap">{error}</div>
          </div>
        )}

        {data && !report && data.raw_text && (
          <div className="bg-white border border-gray-200 rounded-xl p-6">
            <div className="text-amber-700 text-sm font-semibold mb-2">Saige replied but the response was not valid JSON.</div>
            <pre className="text-xs whitespace-pre-wrap text-gray-700">{data.raw_text}</pre>
          </div>
        )}

        {report && (
          <div className="printable-report report-page bg-white border border-gray-200 rounded-xl shadow-sm p-8 space-y-2">
            <ReportHeader field={field} generatedAt={genAt} />
            <ExecSummary summary={report.executive_summary} confidence={report.confidence_overall} />
            <CurrentStatusSection data={report.current_status} />
            <SoilSection data={report.soil_and_nutrients} />
            <WeatherSection data={report.weather_and_climate} />
            <PlantStatusSection data={report.plant_status_assessment} />
            <TreatmentsSection items={report.treatment_recommendations} />
            <HarvestSection data={report.harvest_or_termination_guidance} />
            <NextCropsSection items={report.next_crop_recommendations} />
            <GapsSection items={report.data_gaps} />

            <div className="pt-6 mt-6 border-t border-gray-200 text-[10px] text-gray-400 italic text-center">
              Generated by Saige · This report is decision-support only and does not replace on-site agronomic judgment.
            </div>
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
