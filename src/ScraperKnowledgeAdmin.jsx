import React, { useEffect, useState, useCallback } from 'react';

const API = import.meta.env.VITE_API_URL;
const KB = `${API}/api/scraper-knowledge`;

function authHeaders() {
  const token = localStorage.getItem('access_token');
  return { 'Content-Type': 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) };
}

function relativeTime(iso) {
  if (!iso) return '';
  const t = typeof iso === 'string' ? Date.parse(iso) : iso;
  if (!t) return '';
  const diff = Math.max(0, Math.floor((Date.now() - t) / 1000));
  if (diff < 60)     return `${diff}s ago`;
  if (diff < 3600)   return `${Math.floor(diff / 60)}m ago`;
  if (diff < 86400)  return `${Math.floor(diff / 3600)}h ago`;
  return `${Math.floor(diff / 86400)}d ago`;
}

const OUTCOME_COLORS = {
  success:       'text-emerald-700 bg-emerald-50 border-emerald-200',
  failure:       'text-rose-700 bg-rose-50 border-rose-200',
  new_pattern:   'text-purple-700 bg-purple-50 border-purple-200',
  new_platform:  'text-blue-700 bg-blue-50 border-blue-200',
};

const RULE_TYPES = [
  { value: 'meta_generator', label: 'meta[name=generator] contains…' },
  { value: 'script_src',     label: '<script src> contains…' },
  { value: 'link_href',      label: '<link href> contains…' },
  { value: 'body_class',     label: 'body class contains…' },
  { value: 'html_attr',      label: '<html> has attribute…' },
  { value: 'html_comment',   label: 'HTML comment contains…' },
];

export default function ScraperKnowledgeAdmin() {
  const [stats, setStats]         = useState(null);
  const [loading, setLoading]     = useState(true);
  const [error, setError]         = useState('');

  // Prune form state
  const [minAttempts, setMinAttempts]       = useState(10);
  const [minFailureRatio, setMinFailureRatio] = useState(0.8);
  const [includeSeed, setIncludeSeed]       = useState(false);
  const [pruneResult, setPruneResult]       = useState(null);
  const [pruning, setPruning]               = useState(false);

  // Signature authoring state
  const [signatures, setSignatures]         = useState([]);
  const [sigFilter, setSigFilter]           = useState('');
  const [sigForm, setSigForm]               = useState({
    platform_key: '', platform_name: '', rule_type: 'meta_generator',
    rule_value: '', confidence_weight: 70, notes: '',
  });
  const [sigError, setSigError]             = useState('');
  const [sigSaving, setSigSaving]           = useState(false);

  const loadStats = useCallback(async () => {
    setLoading(true); setError('');
    try {
      const r = await fetch(`${KB}/stats`, { headers: authHeaders() });
      if (!r.ok) throw new Error(`stats HTTP ${r.status}`);
      setStats(await r.json());
    } catch (e) {
      setError(e.message || 'Failed to load stats');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { loadStats(); }, [loadStats]);

  const loadSignatures = useCallback(async () => {
    try {
      const qs = sigFilter ? `?platform_key=${encodeURIComponent(sigFilter)}` : '';
      const r = await fetch(`${KB}/signatures${qs}`, { headers: authHeaders() });
      if (!r.ok) throw new Error(`signatures HTTP ${r.status}`);
      setSignatures(await r.json());
    } catch (e) {
      setSigError(e.message || 'Failed to load signatures');
    }
  }, [sigFilter]);

  useEffect(() => { loadSignatures(); }, [loadSignatures]);

  const submitSignature = async (e) => {
    e.preventDefault();
    setSigError(''); setSigSaving(true);
    try {
      const r = await fetch(`${KB}/signatures`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({
          ...sigForm,
          confidence_weight: Number(sigForm.confidence_weight),
          notes: sigForm.notes || null,
        }),
      });
      const data = await r.json();
      if (!r.ok) throw new Error(data?.detail || 'Failed to save');
      setSigForm(f => ({ ...f, rule_value: '', notes: '' }));
      await loadSignatures();
    } catch (err) {
      setSigError(err.message);
    } finally {
      setSigSaving(false);
    }
  };

  const toggleSignature = async (id) => {
    try {
      await fetch(`${KB}/signatures/${id}/toggle`, { method: 'POST', headers: authHeaders() });
      await loadSignatures();
    } catch {}
  };

  const deleteSignature = async (id) => {
    if (!window.confirm('Permanently delete this signature?')) return;
    try {
      await fetch(`${KB}/signatures/${id}`, { method: 'DELETE', headers: authHeaders() });
      await loadSignatures();
    } catch {}
  };

  const runPrune = async (dryRun) => {
    setPruning(true); setPruneResult(null);
    try {
      const r = await fetch(`${KB}/prune`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({
          min_attempts:      Number(minAttempts),
          min_failure_ratio: Number(minFailureRatio),
          include_seed:      Boolean(includeSeed),
          dry_run:           Boolean(dryRun),
        }),
      });
      const data = await r.json();
      if (!r.ok) throw new Error(data?.detail || data?.error || 'Prune failed');
      setPruneResult(data);
      if (!dryRun) await loadStats();
    } catch (e) {
      setPruneResult({ error: e.message });
    } finally {
      setPruning(false);
    }
  };

  const unprune = async (patternId) => {
    try {
      await fetch(`${KB}/unprune/${patternId}`, { method: 'POST', headers: authHeaders() });
      setPruneResult(pr => pr && pr.candidates
        ? { ...pr, candidates: pr.candidates.filter(c => c.PatternID !== patternId) }
        : pr);
      await loadStats();
    } catch {}
  };

  return (
    <div className="min-h-screen bg-gray-50 py-8 px-4">
      <div className="max-w-6xl mx-auto">
        <header className="mb-6 flex items-end justify-between">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Scraper Knowledge Flywheel</h1>
            <p className="text-sm text-gray-600 mt-1">
              Patterns and platforms learned by Lavendir and Chearvil — with prune controls.
            </p>
          </div>
          <button
            onClick={loadStats}
            className="text-sm px-3 py-1.5 rounded-lg border border-gray-300 bg-white hover:bg-gray-100"
          >
            Refresh
          </button>
        </header>

        {loading && <p className="text-sm text-gray-500">Loading…</p>}
        {error   && <p className="text-sm text-rose-700 bg-rose-50 border border-rose-200 rounded-lg p-3">{error}</p>}

        {/* Platforms ───────────────────────────────────── */}
        {stats && (
          <section className="bg-white rounded-xl border border-gray-200 shadow-sm mb-6">
            <div className="px-4 py-3 border-b border-gray-100 flex items-center justify-between">
              <h2 className="text-sm font-semibold text-gray-800">Platforms</h2>
              <span className="text-xs text-gray-500">{stats.platforms?.length || 0} total</span>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead className="bg-gray-50 text-xs uppercase tracking-wide text-gray-500">
                  <tr>
                    <th className="px-4 py-2 text-left">Platform</th>
                    <th className="px-4 py-2 text-left">Key</th>
                    <th className="px-4 py-2 text-right">Patterns</th>
                    <th className="px-4 py-2 text-right">Successes</th>
                    <th className="px-4 py-2 text-right">Failures</th>
                    <th className="px-4 py-2 text-right">Success rate</th>
                  </tr>
                </thead>
                <tbody>
                  {(stats.platforms || []).map((p) => {
                    const s = Number(p.TotalSuccesses || 0);
                    const f = Number(p.TotalFailures  || 0);
                    const rate = s + f > 0 ? Math.round((s / (s + f)) * 100) : null;
                    return (
                      <tr key={p.PlatformKey} className="border-t border-gray-100">
                        <td className="px-4 py-2 font-medium text-gray-800">{p.PlatformName || '—'}</td>
                        <td className="px-4 py-2 font-mono text-xs text-gray-500">{p.PlatformKey}</td>
                        <td className="px-4 py-2 text-right">{p.PatternCount}</td>
                        <td className="px-4 py-2 text-right text-emerald-700">{s}</td>
                        <td className="px-4 py-2 text-right text-rose-700">{f}</td>
                        <td className="px-4 py-2 text-right">{rate === null ? '—' : `${rate}%`}</td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </section>
        )}

        {/* Recent activity ───────────────────────────────── */}
        {stats && (
          <section className="bg-white rounded-xl border border-gray-200 shadow-sm mb-6">
            <div className="px-4 py-3 border-b border-gray-100">
              <h2 className="text-sm font-semibold text-gray-800">Recent learning activity</h2>
            </div>
            <div className="max-h-96 overflow-y-auto divide-y divide-gray-100">
              {(stats.recent_log || []).map((r, i) => {
                const cls = OUTCOME_COLORS[r.Outcome] || 'text-gray-700 bg-gray-50 border-gray-200';
                return (
                  <div key={i} className="px-4 py-2 text-xs flex items-center gap-3">
                    <span className={`px-1.5 py-0.5 rounded border text-[10px] font-semibold uppercase ${cls}`}>
                      {r.Outcome}
                    </span>
                    <span className="text-gray-500 w-20 shrink-0">{r.AgentName}</span>
                    <span className="text-gray-700 w-32 shrink-0 truncate" title={r.PlatformKey}>{r.PlatformKey}</span>
                    <span className="text-gray-700 w-32 shrink-0 truncate" title={r.FieldName}>{r.FieldName}</span>
                    <span className="font-mono text-purple-700 flex-1 truncate" title={r.SelectorUsed}>{r.SelectorUsed}</span>
                    <span className="text-gray-400 shrink-0 tabular-nums">{relativeTime(r.CreatedAt)}</span>
                  </div>
                );
              })}
              {(!stats.recent_log || stats.recent_log.length === 0) && (
                <p className="px-4 py-6 text-sm text-gray-500 text-center">No activity yet.</p>
              )}
            </div>
          </section>
        )}

        {/* Prune controls ────────────────────────────────── */}
        <section className="bg-white rounded-xl border border-gray-200 shadow-sm">
          <div className="px-4 py-3 border-b border-gray-100">
            <h2 className="text-sm font-semibold text-gray-800">Prune low-performing patterns</h2>
            <p className="text-xs text-gray-500 mt-1">
              Disables patterns with a high failure ratio so future probes skip them. Seeded rows are protected unless <em>Include seed</em> is checked.
            </p>
          </div>
          <div className="p-4 grid grid-cols-1 md:grid-cols-4 gap-3 text-sm">
            <label className="flex flex-col gap-1">
              <span className="text-xs text-gray-600">Min attempts</span>
              <input
                type="number" min={1}
                value={minAttempts}
                onChange={e => setMinAttempts(e.target.value)}
                className="border border-gray-300 rounded px-2 py-1.5"
              />
            </label>
            <label className="flex flex-col gap-1">
              <span className="text-xs text-gray-600">Min failure ratio</span>
              <input
                type="number" min={0} max={1} step={0.05}
                value={minFailureRatio}
                onChange={e => setMinFailureRatio(e.target.value)}
                className="border border-gray-300 rounded px-2 py-1.5"
              />
            </label>
            <label className="flex items-center gap-2 md:col-span-2 mt-5">
              <input
                type="checkbox"
                checked={includeSeed}
                onChange={e => setIncludeSeed(e.target.checked)}
              />
              <span className="text-xs text-gray-700">Include seeded rows (dangerous)</span>
            </label>
          </div>
          <div className="px-4 pb-4 flex gap-2 justify-end">
            <button
              onClick={() => runPrune(true)}
              disabled={pruning}
              className="px-3 py-1.5 text-sm rounded-lg border border-gray-300 bg-white hover:bg-gray-100 disabled:opacity-50"
            >
              {pruning ? 'Working…' : 'Preview (dry run)'}
            </button>
            <button
              onClick={() => {
                if (!pruneResult?.candidates?.length) {
                  if (!window.confirm('Run prune without a dry-run preview first?')) return;
                } else if (!window.confirm(`Disable ${pruneResult.candidates.length} pattern(s)?`)) {
                  return;
                }
                runPrune(false);
              }}
              disabled={pruning}
              className="px-3 py-1.5 text-sm rounded-lg text-white bg-rose-600 hover:bg-rose-700 disabled:opacity-50"
            >
              {pruning ? 'Working…' : 'Apply prune'}
            </button>
          </div>

          {pruneResult && (
            <div className="border-t border-gray-100 p-4">
              {pruneResult.error ? (
                <p className="text-sm text-rose-700">{pruneResult.error}</p>
              ) : (
                <>
                  <p className="text-xs text-gray-600 mb-2">
                    {pruneResult.dry_run ? 'Dry run — nothing changed.' : `Disabled ${pruneResult.disabled} pattern(s).`}
                    {' '}Matched {pruneResult.matched} at min_attempts ≥ {pruneResult.min_attempts}, failure ratio ≥ {pruneResult.min_failure_ratio}.
                  </p>
                  {pruneResult.candidates && pruneResult.candidates.length > 0 && (
                    <div className="overflow-x-auto">
                      <table className="w-full text-xs">
                        <thead className="bg-gray-50 text-[10px] uppercase tracking-wide text-gray-500">
                          <tr>
                            <th className="px-3 py-1.5 text-left">Platform</th>
                            <th className="px-3 py-1.5 text-left">Field</th>
                            <th className="px-3 py-1.5 text-left">Selector</th>
                            <th className="px-3 py-1.5 text-right">Success</th>
                            <th className="px-3 py-1.5 text-right">Failure</th>
                            <th className="px-3 py-1.5 text-right">Ratio</th>
                            <th className="px-3 py-1.5 text-left">Source</th>
                            <th className="px-3 py-1.5"></th>
                          </tr>
                        </thead>
                        <tbody>
                          {pruneResult.candidates.map(c => (
                            <tr key={c.PatternID} className="border-t border-gray-100">
                              <td className="px-3 py-1.5 text-gray-700">{c.PlatformKey}</td>
                              <td className="px-3 py-1.5 text-gray-700">{c.FieldName}</td>
                              <td className="px-3 py-1.5 font-mono text-purple-700 truncate max-w-[240px]" title={c.SelectorValue}>{c.SelectorValue}</td>
                              <td className="px-3 py-1.5 text-right text-emerald-700">{c.SuccessCount}</td>
                              <td className="px-3 py-1.5 text-right text-rose-700">{c.FailureCount}</td>
                              <td className="px-3 py-1.5 text-right">{(Number(c.FailureRatio) * 100).toFixed(0)}%</td>
                              <td className="px-3 py-1.5 text-gray-500">{c.CreatedBy}</td>
                              <td className="px-3 py-1.5 text-right">
                                {!pruneResult.dry_run && (
                                  <button
                                    onClick={() => unprune(c.PatternID)}
                                    className="text-[11px] text-purple-700 hover:underline"
                                  >
                                    Undo
                                  </button>
                                )}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  )}
                </>
              )}
            </div>
          )}
        </section>

        {/* Signature authoring ──────────────────────────── */}
        <section className="bg-white rounded-xl border border-gray-200 shadow-sm mt-6">
          <div className="px-4 py-3 border-b border-gray-100 flex items-center justify-between">
            <div>
              <h2 className="text-sm font-semibold text-gray-800">Platform signatures</h2>
              <p className="text-xs text-gray-500 mt-1">
                Fingerprint rules used by <code>/detect</code>. Adding a rule invalidates the host-detection cache.
              </p>
            </div>
            <input
              type="text"
              value={sigFilter}
              onChange={e => setSigFilter(e.target.value)}
              placeholder="Filter by platform_key"
              className="border border-gray-300 rounded px-2 py-1 text-xs"
            />
          </div>

          <form onSubmit={submitSignature} className="p-4 border-b border-gray-100 grid grid-cols-1 md:grid-cols-6 gap-2 text-sm items-end">
            <label className="flex flex-col gap-1 md:col-span-1">
              <span className="text-xs text-gray-600">Platform key</span>
              <input
                required
                value={sigForm.platform_key}
                onChange={e => setSigForm(f => ({ ...f, platform_key: e.target.value }))}
                placeholder="e.g. wix"
                className="border border-gray-300 rounded px-2 py-1.5 text-xs font-mono"
              />
            </label>
            <label className="flex flex-col gap-1 md:col-span-1">
              <span className="text-xs text-gray-600">Platform name</span>
              <input
                required
                value={sigForm.platform_name}
                onChange={e => setSigForm(f => ({ ...f, platform_name: e.target.value }))}
                placeholder="Wix"
                className="border border-gray-300 rounded px-2 py-1.5 text-xs"
              />
            </label>
            <label className="flex flex-col gap-1 md:col-span-2">
              <span className="text-xs text-gray-600">Rule type</span>
              <select
                value={sigForm.rule_type}
                onChange={e => setSigForm(f => ({ ...f, rule_type: e.target.value }))}
                className="border border-gray-300 rounded px-2 py-1.5 text-xs"
              >
                {RULE_TYPES.map(r => <option key={r.value} value={r.value}>{r.label}</option>)}
              </select>
            </label>
            <label className="flex flex-col gap-1 md:col-span-1">
              <span className="text-xs text-gray-600">Rule value</span>
              <input
                required
                value={sigForm.rule_value}
                onChange={e => setSigForm(f => ({ ...f, rule_value: e.target.value }))}
                placeholder="e.g. Wix.com"
                className="border border-gray-300 rounded px-2 py-1.5 text-xs font-mono"
              />
            </label>
            <label className="flex flex-col gap-1 md:col-span-1">
              <span className="text-xs text-gray-600">Weight (1-100)</span>
              <input
                type="number" min={1} max={100}
                value={sigForm.confidence_weight}
                onChange={e => setSigForm(f => ({ ...f, confidence_weight: e.target.value }))}
                className="border border-gray-300 rounded px-2 py-1.5 text-xs"
              />
            </label>
            <label className="flex flex-col gap-1 md:col-span-5">
              <span className="text-xs text-gray-600">Notes (optional)</span>
              <input
                value={sigForm.notes}
                onChange={e => setSigForm(f => ({ ...f, notes: e.target.value }))}
                placeholder="Why this rule matters"
                className="border border-gray-300 rounded px-2 py-1.5 text-xs"
              />
            </label>
            <div className="md:col-span-1 flex justify-end">
              <button
                type="submit"
                disabled={sigSaving}
                className="px-3 py-1.5 text-sm rounded-lg text-white bg-purple-600 hover:bg-purple-700 disabled:opacity-50"
              >
                {sigSaving ? 'Saving…' : 'Add signature'}
              </button>
            </div>
            {sigError && (
              <p className="md:col-span-6 text-xs text-rose-700">{sigError}</p>
            )}
          </form>

          <div className="overflow-x-auto max-h-96">
            <table className="w-full text-xs">
              <thead className="bg-gray-50 text-[10px] uppercase tracking-wide text-gray-500 sticky top-0">
                <tr>
                  <th className="px-3 py-1.5 text-left">Platform</th>
                  <th className="px-3 py-1.5 text-left">Key</th>
                  <th className="px-3 py-1.5 text-left">Rule</th>
                  <th className="px-3 py-1.5 text-left">Value</th>
                  <th className="px-3 py-1.5 text-right">Weight</th>
                  <th className="px-3 py-1.5 text-left">Notes</th>
                  <th className="px-3 py-1.5"></th>
                </tr>
              </thead>
              <tbody>
                {signatures.map(s => (
                  <tr key={s.SignatureID} className={`border-t border-gray-100 ${s.Enabled ? '' : 'opacity-50'}`}>
                    <td className="px-3 py-1.5 text-gray-800">{s.PlatformName}</td>
                    <td className="px-3 py-1.5 font-mono text-gray-500">{s.PlatformKey}</td>
                    <td className="px-3 py-1.5 text-gray-700">{s.RuleType}</td>
                    <td className="px-3 py-1.5 font-mono text-purple-700 truncate max-w-[260px]" title={s.RuleValue}>{s.RuleValue}</td>
                    <td className="px-3 py-1.5 text-right">{s.ConfidenceWeight}</td>
                    <td className="px-3 py-1.5 text-gray-500 truncate max-w-[240px]" title={s.Notes || ''}>{s.Notes || '—'}</td>
                    <td className="px-3 py-1.5 text-right whitespace-nowrap">
                      <button onClick={() => toggleSignature(s.SignatureID)} className="text-[11px] text-purple-700 hover:underline mr-2">
                        {s.Enabled ? 'Disable' : 'Enable'}
                      </button>
                      <button onClick={() => deleteSignature(s.SignatureID)} className="text-[11px] text-rose-700 hover:underline">
                        Delete
                      </button>
                    </td>
                  </tr>
                ))}
                {signatures.length === 0 && (
                  <tr><td colSpan={7} className="px-3 py-6 text-center text-gray-500">No signatures match.</td></tr>
                )}
              </tbody>
            </table>
          </div>
        </section>
      </div>
    </div>
  );
}
