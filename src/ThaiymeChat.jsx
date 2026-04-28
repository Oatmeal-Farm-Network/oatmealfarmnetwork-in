// src/ThaiymeChat.jsx
// Thaiyme — Business Operations AI agent.
// Floating bubble (bottom-right) mounted on Accounting + Event Registration pages.
// Backend: POST /api/thaiyme/chat   GET/DELETE /api/thaiyme/history
// Sensitive data is redacted server-side before reaching the LLM.

import React, { useState, useEffect, useRef, useCallback } from 'react';
import { createPortal } from 'react-dom';
import { useLanguage } from './LanguageContext';

const API = import.meta.env.VITE_API_URL || '';
const AGENT_NAME   = 'Thaiyme';
const ACCENT_COLOR = '#7A5A3D';   // warm spice/thyme brown
const ICON_SRC     = '/images/ThaiymeIcon.png';

function authHeaders() {
  const token = localStorage.getItem('access_token');
  return { 'Content-Type': 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) };
}

// ── Icon ─────────────────────────────────────────────────────────
function ThaiymeIcon({ size = 24 }) {
  return (
    <img
      src={ICON_SRC}
      alt="Thaiyme"
      width={size}
      height={size}
      style={{ display: 'block', flexShrink: 0 }}
    />
  );
}

// ── Markdown renderer (light) ───────────────────────────────────
function MessageContent({ text }) {
  const escapeHtml = (s) =>
    s.replace(/&/g, '&amp;')
     .replace(/</g, '&lt;')
     .replace(/>/g, '&gt;')
     .replace(/"/g, '&quot;')
     .replace(/'/g, '&#39;');

  const html = escapeHtml(text || '')
    .replace(/^#{1,6}\s+(.+)$/gm, '<strong>$1</strong>')
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.*?)\*/g, '<em>$1</em>')
    .replace(/`(.*?)`/g, '<code style="background:#fdf6ed;color:#7A5A3D;padding:0 3px;border-radius:3px;">$1</code>')
    .split('\n').join('<br />');

  return (
    <span
      style={{ fontFamily: 'Verdana, Geneva, sans-serif', fontSize: '12pt', lineHeight: 1.45, display: 'block' }}
      dangerouslySetInnerHTML={{ __html: html }}
    />
  );
}

// ── Storage key (per user + scope so threads stay separate) ─────
function _storageKey({ businessId, eventId }) {
  const pid = localStorage.getItem('people_id') || 'anon';
  const scope = eventId ? `event:${eventId}` : (businessId ? `biz:${businessId}` : 'global');
  return `thaiyme:msgs:${pid}:${scope}`;
}

function _loadStored(scope) {
  try { return JSON.parse(localStorage.getItem(scope) || '[]'); } catch { return []; }
}
function _saveStored(scope, msgs) {
  try { localStorage.setItem(scope, JSON.stringify((msgs || []).slice(-100))); } catch {}
}

// ── Main widget ─────────────────────────────────────────────────
export default function ThaiymeChat({ businessId, eventId, page }) {
  const { language } = useLanguage();
  const storageKey = _storageKey({ businessId, eventId });

  const [open, setOpen]                 = useState(false);
  const [expanded, setExpanded]         = useState(false);
  const [messages, setMessages]         = useState(() => _loadStored(storageKey));
  const [input, setInput]               = useState('');
  const [loading, setLoading]           = useState(false);
  const [error, setError]               = useState('');
  const [chips, setChips]               = useState([]);
  const bottomRef = useRef(null);
  const greetedRef = useRef(false);

  // ── Persist + reset on scope change ───────────────────────────
  useEffect(() => { _saveStored(storageKey, messages); }, [messages, storageKey]);
  useEffect(() => {
    setMessages(_loadStored(storageKey));
    greetedRef.current = false;
  }, [storageKey]);

  // ── Hydrate from server on first open ─────────────────────────
  useEffect(() => {
    if (!open) return;
    const params = new URLSearchParams();
    if (businessId) params.set('business_id', businessId);
    if (eventId)    params.set('event_id', eventId);
    if (page)       params.set('page', page);

    fetch(`${API}/api/thaiyme/history?${params.toString()}`, { headers: authHeaders() })
      .then(r => r.ok ? r.json() : { messages: [] })
      .then(data => {
        if (Array.isArray(data?.messages) && data.messages.length) {
          setMessages(data.messages);
        }
      })
      .catch(() => {});

    fetch(`${API}/api/thaiyme/suggestions?${params.toString()}`, { headers: authHeaders() })
      .then(r => r.ok ? r.json() : { suggestions: [] })
      .then(data => setChips(Array.isArray(data?.suggestions) ? data.suggestions : []))
      .catch(() => setChips([]));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open]);

  // ── Greeting on first open with empty thread ─────────────────
  useEffect(() => {
    if (open && messages.length === 0 && !greetedRef.current) {
      greetedRef.current = true;
      const where = eventId
        ? "this event's registrations"
        : (businessId && page === 'accounting'
            ? "your books"
            : "your business");
      setMessages([{
        role: 'assistant',
        content: `Hi! I'm **${AGENT_NAME}** — your business-ops assistant. I can help you make sense of ${where}, suggest next steps, and (for events) make small changes to registrations on your behalf. What would you like to look at?`,
      }]);
    }
  }, [open, messages.length, businessId, eventId, page]);

  // ── Auto-scroll ──────────────────────────────────────────────
  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, loading]);

  // ── Send ─────────────────────────────────────────────────────
  const sendMessage = useCallback(async (text) => {
    const userText = (typeof text === 'string' ? text : input).trim();
    if (!userText || loading) return;
    setInput('');
    setError('');
    const next = [...messages, { role: 'user', content: userText }];
    setMessages(next);
    setLoading(true);
    try {
      const res = await fetch(`${API}/api/thaiyme/chat`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({
          business_id: businessId || null,
          event_id:    eventId || null,
          page:        page || null,
          messages:    next,
          language:    language || 'en',
        }),
      });
      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        throw new Error(body?.detail || `Chat failed (${res.status})`);
      }
      const data = await res.json();
      const proposals = Array.isArray(data?.proposals) ? data.proposals : [];
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: data.content,
        proposals: proposals.length ? proposals : undefined,
      }]);
    } catch (e) {
      setError(e.message || 'Network error.');
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: "I couldn't reach the backend just now — please try again in a moment.",
      }]);
    } finally {
      setLoading(false);
    }
  }, [input, loading, messages, businessId, eventId, page, language]);

  // ── Confirm / cancel a proposed mutation ─────────────────────
  const confirmProposal = useCallback(async (msgIdx, proposalIdx) => {
    const msg = messages[msgIdx];
    const p = msg?.proposals?.[proposalIdx];
    if (!p) return;
    setLoading(true);
    setError('');
    try {
      const res = await fetch(`${API}/api/thaiyme/confirm`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify(p),
      });
      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        throw new Error(body?.detail || `Confirm failed (${res.status})`);
      }
      setMessages(prev => prev.map((m, i) => {
        if (i !== msgIdx) return m;
        const remaining = (m.proposals || []).map((pp, pi) =>
          pi === proposalIdx ? { ...pp, _executed: true } : pp
        );
        return { ...m, proposals: remaining };
      }));
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: `Done — ${p.summary}`,
      }]);
    } catch (e) {
      setError(e.message || 'Network error.');
    } finally {
      setLoading(false);
    }
  }, [messages]);

  const dismissProposal = useCallback((msgIdx, proposalIdx) => {
    setMessages(prev => prev.map((m, i) => {
      if (i !== msgIdx) return m;
      const remaining = (m.proposals || []).map((pp, pi) =>
        pi === proposalIdx ? { ...pp, _dismissed: true } : pp
      );
      return { ...m, proposals: remaining };
    }));
  }, []);

  const handleKey = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage(); }
  };

  const clearChat = async () => {
    setMessages([]);
    greetedRef.current = false;
    try { localStorage.removeItem(storageKey); } catch {}
    const params = new URLSearchParams();
    if (businessId) params.set('business_id', businessId);
    if (eventId)    params.set('event_id', eventId);
    try {
      await fetch(`${API}/api/thaiyme/history?${params.toString()}`, {
        method: 'DELETE',
        headers: authHeaders(),
      });
    } catch {}
  };

  // ── Floating button ──────────────────────────────────────────
  if (!open) {
    return createPortal(
      <button
        onClick={() => setOpen(true)}
        title={`Chat with ${AGENT_NAME}`}
        className="fixed bottom-6 right-6 z-50 flex items-center justify-center transition-all hover:scale-110 active:scale-95"
        style={{ background: 'transparent', border: 'none', padding: 0 }}
      >
        <ThaiymeIcon size={64} />
      </button>,
      document.body,
    );
  }

  // ── Panel geometry ───────────────────────────────────────────
  const panelStyle = expanded
    ? { top: 72, left: 0, width: '100vw', height: 'calc(100vh - 72px)', zIndex: 9999, borderRadius: 0 }
    : { width: 360, height: 540, bottom: 24, right: 24, zIndex: 50, borderRadius: '1rem' };

  return createPortal(
    <div
      className="fixed flex flex-col shadow-2xl overflow-hidden"
      style={{ background: '#fff', border: '1px solid #e5e7eb', ...panelStyle }}
    >
      {/* Header */}
      <div className="flex items-center gap-3 px-4 py-3 shrink-0" style={{ background: ACCENT_COLOR }}>
        <ThaiymeIcon size={28} />
        <div className="flex-1 min-w-0">
          <p className="text-white font-bold text-sm leading-none">{AGENT_NAME}</p>
          <p className="text-white/80 text-xs mt-0.5">Business Operations Assistant</p>
        </div>
        <div className="flex items-center gap-1">
          <button
            onClick={() => setExpanded(v => !v)}
            title={expanded ? 'Collapse panel' : 'Expand to full page'}
            className="p-1.5 rounded-lg text-white/70 hover:text-white hover:bg-white/20 transition-colors"
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              {expanded
                ? <><polyline points="4 14 10 14 10 20"/><polyline points="20 10 14 10 14 4"/><line x1="10" y1="14" x2="3" y2="21"/><line x1="21" y1="3" x2="14" y2="10"/></>
                : <><polyline points="15 3 21 3 21 9"/><polyline points="9 21 3 21 3 15"/><line x1="21" y1="3" x2="14" y2="10"/><line x1="3" y1="21" x2="10" y2="14"/></>
              }
            </svg>
          </button>
          <button onClick={clearChat} title="Clear chat" className="p-1.5 rounded-lg text-white/70 hover:text-white hover:bg-white/20 transition-colors">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"/>
            </svg>
          </button>
          <button
            onClick={() => { setOpen(false); setExpanded(false); }}
            className="p-1.5 rounded-lg text-white/70 hover:text-white hover:bg-white/20 transition-colors text-lg leading-none"
          >×</button>
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto px-4 py-3 space-y-3" style={{ background: '#fdfaf3' }}>
        {messages.map((m, i) => (
          <div key={i} className={`flex ${m.role === 'user' ? 'justify-end' : 'justify-start'} items-end gap-2`}>
            {m.role === 'assistant' && <ThaiymeIcon size={22} />}
            <div
              className={`rounded-2xl px-3 py-2 text-sm leading-relaxed ${expanded ? 'max-w-[55%]' : 'max-w-[80%]'} ${
                m.role === 'user'
                  ? 'bg-gray-800 text-white rounded-br-sm'
                  : 'bg-white border border-amber-100 text-gray-800 rounded-bl-sm shadow-sm'
              }`}
            >
              <MessageContent text={m.content} />
              {m.role === 'assistant' && Array.isArray(m.proposals) && m.proposals.map((p, pi) => (
                p._dismissed ? null : (
                  <div key={pi} className="mt-2 border border-amber-300 rounded-lg p-2.5 bg-amber-50">
                    <div className="text-xs font-semibold text-[#7A5A3D] mb-1">
                      {p._executed ? 'Done' : 'Confirm action'}
                    </div>
                    <div className="text-xs text-gray-700 mb-2">{p.summary}</div>
                    {!p._executed && (
                      <div className="flex gap-2 justify-end">
                        <button
                          onClick={() => dismissProposal(i, pi)}
                          disabled={loading}
                          className="text-xs px-2.5 py-1 rounded border border-gray-300 hover:bg-white disabled:opacity-50"
                        >
                          No
                        </button>
                        <button
                          onClick={() => confirmProposal(i, pi)}
                          disabled={loading}
                          className="text-xs px-2.5 py-1 rounded text-white disabled:opacity-50"
                          style={{ background: ACCENT_COLOR }}
                        >
                          Yes, do it
                        </button>
                      </div>
                    )}
                  </div>
                )
              ))}
            </div>
          </div>
        ))}

        {loading && (
          <div className="flex items-end gap-2 justify-start">
            <ThaiymeIcon size={22} />
            <div className="bg-white border border-amber-100 rounded-2xl rounded-bl-sm px-4 py-3 shadow-sm">
              <div className="flex gap-1 items-center">
                <span className="w-1.5 h-1.5 rounded-full animate-bounce" style={{ background: ACCENT_COLOR, animationDelay: '0ms' }} />
                <span className="w-1.5 h-1.5 rounded-full animate-bounce" style={{ background: ACCENT_COLOR, animationDelay: '150ms' }} />
                <span className="w-1.5 h-1.5 rounded-full animate-bounce" style={{ background: ACCENT_COLOR, animationDelay: '300ms' }} />
              </div>
            </div>
          </div>
        )}

        <div ref={bottomRef} />
      </div>

      {/* Error */}
      {error && (
        <div className="px-3 py-2 bg-red-50 border-t border-red-200 text-xs text-red-700 shrink-0">
          {error}
        </div>
      )}

      {/* Suggestion chips (only on the first turn) */}
      {chips.length > 0 && messages.length <= 1 && (
        <div className="px-3 py-2 border-t border-amber-100 bg-amber-50/40 shrink-0 flex flex-wrap gap-1.5">
          {chips.map((c, i) => (
            <button
              key={i}
              onClick={() => sendMessage(c)}
              className="text-xs px-2 py-1 rounded-full border border-amber-200 bg-white text-[#7A5A3D] hover:bg-amber-100 transition-colors"
            >
              {c}
            </button>
          ))}
        </div>
      )}

      {/* Input */}
      <div className="border-t border-gray-100 px-3 py-2.5 flex items-end gap-2 bg-white shrink-0">
        <textarea
          value={input}
          onChange={e => setInput(e.target.value)}
          onKeyDown={handleKey}
          rows={1}
          placeholder="Ask Thaiyme about your books or this event…"
          className="flex-1 resize-none border border-gray-200 rounded-xl px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-amber-300"
          style={{ maxHeight: 120 }}
          disabled={loading}
        />
        <button
          onClick={() => sendMessage()}
          disabled={loading || !input.trim()}
          className="px-3 py-2 rounded-xl text-white text-sm font-semibold disabled:opacity-50"
          style={{ background: ACCENT_COLOR }}
        >
          Send
        </button>
      </div>
    </div>,
    document.body,
  );
}
