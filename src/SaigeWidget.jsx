/**
 * SaigeWidget — floating Saige chat bubble.
 *
 * Mount on any page:
 *   <SaigeWidget businessId={BusinessID} pageContext="Precision Ag" />
 *
 * Bottom-right launcher icon opens a popup; click expand for full-page mode.
 * Messages are kept in component state (not persisted — Saige uses server-side
 * thread storage via the /chat endpoint).
 */
import React, { useCallback, useEffect, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { useAccount } from './AccountContext';
import { useLanguage } from './LanguageContext';

const SAIGE_API   = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8000/saige';
const SAIGE_GREEN = '#3D6B34';
const SAIGE_LIGHT = '#f0f7ee';
const HEADER_H    = 72; // px — matches AppShell padding-top

function authHeaders() {
  const token = localStorage.getItem('access_token') || localStorage.getItem('AccessToken');
  return {
    'Content-Type': 'application/json',
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };
}

function getPeopleId() {
  return localStorage.getItem('people_id') || localStorage.getItem('PeopleID') || '';
}

// ── Message bubble ────────────────────────────────────────────────────────────

function Bubble({ role, content }) {
  const isUser = role === 'user';
  return (
    <div style={{ display: 'flex', justifyContent: isUser ? 'flex-end' : 'flex-start', marginBottom: 8 }}>
      <div style={{
        maxWidth: '85%',
        padding: '8px 12px',
        borderRadius: 12,
        fontSize: 13.5,
        lineHeight: 1.5,
        whiteSpace: 'pre-wrap',
        wordBreak: 'break-word',
        background: isUser ? SAIGE_GREEN : SAIGE_LIGHT,
        color: isUser ? '#fff' : '#111827',
        border: isUser ? 'none' : `1px solid #c7dfc2`,
      }}>
        {content}
      </div>
    </div>
  );
}

// ── Chat panel ────────────────────────────────────────────────────────────────

function ChatPanel({ businessId, fieldId, pageContext, language, onClose, onToggleFullscreen, fullscreen, sidebarWidth }) {
  const { t } = useTranslation();
  const [messages, setMessages] = useState([]);
  const [input, setInput]       = useState('');
  const [sending, setSending]   = useState(false);
  const [error, setError]       = useState('');
  const [threadId]              = useState(() => {
    const pid = getPeopleId();
    const stored = localStorage.getItem(`saige_widget_thread_${pid}_${businessId || 0}`);
    if (stored) return stored;
    const newTid = `saige_w_${Date.now()}_${Math.random().toString(36).slice(2, 9)}`;
    localStorage.setItem(`saige_widget_thread_${pid}_${businessId || 0}`, newTid);
    return newTid;
  });
  const scrollRef = useRef(null);

  useEffect(() => {
    const el = scrollRef.current;
    if (el) el.scrollTop = el.scrollHeight;
  }, [messages, sending]);

  const send = useCallback(async (text) => {
    const val = (text || input).trim();
    if (!val || sending) return;
    setError('');
    const nextMsgs = [...messages, { role: 'user', content: val }];
    setMessages(nextMsgs);
    setInput('');
    setSending(true);
    try {
      // Prepend page/field context so Saige can pick the right tools without
      // the user having to repeat "field 13" every turn.
      const fieldHint = fieldId ? `[Field #${fieldId}]` : '';
      const pageHint  = pageContext ? `[Page: ${pageContext}]` : '';
      const userInputWithHints = [fieldHint, pageHint, val].filter(Boolean).join(' ').trim();

      const res = await fetch(`${SAIGE_API}/chat`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({
          user_input: userInputWithHints,
          thread_id: threadId,
          business_id: businessId ? String(businessId) : null,
          field_id: fieldId ? String(fieldId) : null,
          language: language || 'en',
        }),
      });
      if (!res.ok) throw new Error(`Server error (${res.status})`);
      const data = await res.json();
      let reply = '';
      if (data.status === 'complete') {
        reply = (data.diagnosis || '').replace(/\*\*/g, '').replace(/##\s+/g, '').replace(/\*/g, '').trim();
        if (data.recommendations?.length > 0 && !data.recommendations.every(r => reply.includes(r.slice(0, 30)))) {
          reply += '\n\n' + data.recommendations.map(r => `• ${r}`).join('\n');
        }
      } else if (data.status === 'requires_input') {
        const q = (data.ui?.question || '').trim();
        const opts = Array.isArray(data.ui?.options) ? data.ui.options : [];
        reply = q;
        if (opts.length > 0) reply += '\n\n' + opts.map(o => `• ${o}`).join('\n');
      } else if (data.status === 'error') {
        reply = data.message || t('saige_widget.err_something_wrong');
      } else {
        reply = data.diagnosis || data.response || t('saige_widget.no_response');
      }
      setMessages([...nextMsgs, { role: 'assistant', content: reply || t('saige_widget.no_response') }]);
    } catch (e) {
      setError(e.message);
      setMessages([...nextMsgs, { role: 'assistant', content: t('saige_widget.err_send', { msg: e.message }) }]);
    } finally {
      setSending(false);
    }
  }, [input, messages, sending, threadId, businessId, fieldId, pageContext, language]);

  const onKey = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); send(); }
  };

  const panelStyle = fullscreen
    ? {
        position: 'fixed',
        top: HEADER_H,
        left: sidebarWidth,
        width: `calc(100vw - ${sidebarWidth}px)`,
        height: `calc(100vh - ${HEADER_H}px)`,
        zIndex: 9999,
        borderRadius: 0,
        background: '#fff',
        display: 'flex',
        flexDirection: 'column',
        boxShadow: 'none',
      }
    : {
        position: 'fixed',
        bottom: 90,
        right: 20,
        width: 'min(380px, 94vw)',
        height: 'min(540px, 78vh)',
        zIndex: 9999,
        borderRadius: 14,
        background: '#fff',
        display: 'flex',
        flexDirection: 'column',
        boxShadow: '0 10px 40px -8px rgba(0,0,0,0.30)',
        border: '1px solid #d1e8cc',
      };

  const welcomeContext = pageContext ? t('saige_widget.welcome_context', { page: pageContext }) : '';

  return createPortal(
    <div style={panelStyle}>
      {/* Header */}
      <div style={{
        background: SAIGE_GREEN,
        color: '#fff',
        padding: '10px 14px',
        display: 'flex',
        alignItems: 'center',
        gap: 10,
        flexShrink: 0,
      }}>
        <img src="/images/SaigeIcon.png" alt="Saige" style={{ width: 28, height: 28, borderRadius: '50%', objectFit: 'cover' }} />
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontWeight: 700, fontSize: 15, fontFamily: 'Lora, serif' }}>Saige</div>
          <div style={{ fontSize: 11, opacity: 0.85, fontFamily: 'Montserrat, sans-serif' }}>
            {t('saige_widget.subtitle')}
          </div>
        </div>
        <button onClick={onToggleFullscreen} style={hdrBtn} title={fullscreen ? t('saige_widget.btn_exit_fullscreen') : t('saige_widget.btn_expand')}>
          {fullscreen ? '⤢' : '⤡'}
        </button>
        <button onClick={onClose} style={hdrBtn} title={t('saige_widget.btn_close')}>×</button>
      </div>

      {/* Messages */}
      <div ref={scrollRef} style={{
        flex: 1,
        padding: '12px 12px 8px',
        overflowY: 'auto',
        background: '#fafdf9',
      }}>
        {messages.length === 0 && (
          <div style={{ fontSize: 13, color: '#4b5563', padding: '12px 4px', lineHeight: 1.65, fontFamily: 'Montserrat, sans-serif' }}>
            {welcomeContext
              ? t('saige_widget.welcome_with_context', { context: welcomeContext })
              : t('saige_widget.welcome')}
          </div>
        )}
        {messages.map((m, i) => <Bubble key={i} role={m.role} content={m.content} />)}
        {sending && (
          <div style={{ fontSize: 12, color: '#6b7280', fontStyle: 'italic', fontFamily: 'Montserrat, sans-serif' }}>
            {t('saige_widget.thinking')}
          </div>
        )}
        {error && (
          <div style={{ fontSize: 11, color: '#991b1b', marginTop: 4 }}>{error}</div>
        )}
      </div>

      {/* Quick prompts — shown until first message sent */}
      {messages.length === 0 && (
        <div style={{ padding: '4px 10px 6px', display: 'flex', flexWrap: 'wrap', gap: 6, flexShrink: 0, borderTop: '1px solid #e5f0e2' }}>
          {quickPrompts(pageContext, t).map(p => (
            <button key={p} onClick={() => send(p)} style={chipStyle}>
              {p}
            </button>
          ))}
        </div>
      )}

      {/* Composer */}
      <div style={{
        padding: 10,
        borderTop: '1px solid #e5e7eb',
        background: '#fff',
        display: 'flex',
        gap: 8,
        alignItems: 'flex-end',
        flexShrink: 0,
      }}>
        <textarea
          rows={fullscreen ? 2 : 1}
          value={input}
          onChange={e => setInput(e.target.value)}
          onKeyDown={onKey}
          placeholder={t("saige_widget.placeholder")}
          style={{
            flex: 1,
            resize: 'none',
            border: '1px solid #d1d5db',
            borderRadius: 8,
            padding: '8px 10px',
            fontSize: 13.5,
            fontFamily: 'Montserrat, sans-serif',
            outline: 'none',
            minHeight: 36,
          }}
        />
        <button
          onClick={() => send()}
          disabled={!input.trim() || sending}
          style={{
            padding: '8px 14px',
            background: SAIGE_GREEN,
            color: '#fff',
            border: 'none',
            borderRadius: 8,
            fontSize: 13,
            fontWeight: 600,
            cursor: input.trim() && !sending ? 'pointer' : 'not-allowed',
            opacity: input.trim() && !sending ? 1 : 0.55,
            fontFamily: 'Montserrat, sans-serif',
          }}
        >
          {t('saige_widget.btn_send')}
        </button>
      </div>
    </div>,
    document.body,
  );
}

// ── Quick prompts per page context ────────────────────────────────────────────

function quickPrompts(ctx, t) {
  const c = (ctx || '').toLowerCase();
  if (c.includes('precision') || c.includes('field') || c.includes('crop monitor')) {
    return [t('saige_widget.prompt_fields'), t('saige_widget.prompt_alerts'), t('saige_widget.prompt_irrigate'), t('saige_widget.prompt_benchmark')];
  }
  if (c.includes('livestock')) {
    return [t('saige_widget.prompt_list_animals'), t('saige_widget.prompt_animal_counts'), t('saige_widget.prompt_animal_info')];
  }
  if (c.includes('farm 2 table') || c.includes('marketplace')) {
    return [t('saige_widget.prompt_marketplace'), t('saige_widget.prompt_in_season'), t('saige_widget.prompt_draft_listing')];
  }
  return [t('saige_widget.prompt_fields_short'), t('saige_widget.prompt_alerts_short'), t('saige_widget.prompt_marketplace_short')];
}

const hdrBtn = {
  background: 'rgba(255,255,255,0.18)',
  color: '#fff',
  border: 'none',
  borderRadius: 6,
  padding: '4px 9px',
  fontSize: 13,
  cursor: 'pointer',
  fontWeight: 700,
  lineHeight: 1,
};

const chipStyle = {
  background: SAIGE_LIGHT,
  color: SAIGE_GREEN,
  border: `1px solid #c7dfc2`,
  borderRadius: 999,
  padding: '3px 10px',
  fontSize: 11,
  fontFamily: 'Montserrat, sans-serif',
  fontWeight: 600,
  cursor: 'pointer',
  whiteSpace: 'nowrap',
};

// ── Main export ───────────────────────────────────────────────────────────────

export default function SaigeWidget({ businessId, fieldId, pageContext }) {
  const { t } = useTranslation();
  const { Expanded: sidebarExpanded } = useAccount();
  const { language } = useLanguage();
  const sidebarWidth = sidebarExpanded ? 208 : 64;
  const [open, setOpen]           = useState(false);
  const [fullscreen, setFullscreen] = useState(false);

  useEffect(() => {
    if (!fullscreen) return;
    const onEsc = (e) => { if (e.key === 'Escape') setFullscreen(false); };
    window.addEventListener('keydown', onEsc);
    return () => window.removeEventListener('keydown', onEsc);
  }, [fullscreen]);

  return (
    <>
      {/* FAB launcher — portal so AppShell layout rules don't affect it */}
      {createPortal(
        <button
          onClick={() => setOpen(v => !v)}
          aria-label={t('saige_widget.launcher_aria')}
          title={t('saige_widget.launcher_title')}
          style={{
            position: 'fixed',
            bottom: 20,
            right: 20,
            zIndex: 9998,
            width: 62,
            height: 62,
            borderRadius: '50%',
            border: 'none',
            padding: 0,
            cursor: 'pointer',
            background: 'transparent',
            boxShadow: '0 6px 20px -4px rgba(0,0,0,0.35)',
            transition: 'transform 0.15s',
          }}
          onMouseEnter={e => e.currentTarget.style.transform = 'scale(1.1)'}
          onMouseLeave={e => e.currentTarget.style.transform = 'scale(1)'}
        >
          <img
            src="/images/SaigeIcon.png"
            alt="Saige"
            style={{ width: 62, height: 62, borderRadius: '50%', objectFit: 'cover', display: 'block' }}
          />
        </button>,
        document.body,
      )}

      {open && (
        <ChatPanel
          businessId={businessId}
          fieldId={fieldId}
          pageContext={pageContext}
          language={language}
          fullscreen={fullscreen}
          sidebarWidth={sidebarWidth}
          onClose={() => { setOpen(false); setFullscreen(false); }}
          onToggleFullscreen={() => setFullscreen(v => !v)}
        />
      )}
    </>
  );
}
