/**
 * SaigeWidget — floating Saige chat bubble with voice (STT + TTS).
 *
 * Mount on any page:
 *   <SaigeWidget businessId={BusinessID} pageContext="Herd Health" />
 *
 * Bottom-right launcher icon opens a popup.
 * Expand (⤡) navigates to the full /saige page which has the chat history sidebar.
 * Voice: mic button for speech-to-text, 🔊 per-bubble for text-to-speech,
 *        auto-speak toggle in the header.
 */
import React, { useCallback, useEffect, useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAccount } from './AccountContext';
import { useLanguage } from './LanguageContext';

const SAIGE_API   = import.meta.env.VITE_SAIGE_API_URL || 'http://localhost:8000/saige';
const SAIGE_GREEN = '#3D6B34';
const SAIGE_DARK  = '#2c4f25';
const SAIGE_LIGHT = '#f0f7ee';
const SAIGE_BORDER = '#c7dfc2';
const FONT_BODY   = 'Montserrat, system-ui, sans-serif';
const AUTOSPEAK_KEY = 'saige_widget_autospeak';

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

// Strip markdown so TTS doesn't read "asterisk asterisk bold".
function cleanForSpeech(text) {
  return (text || '')
    .replace(/```[\s\S]*?```/g, ' code block. ')
    .replace(/\*\*(.*?)\*\*/g, '$1')
    .replace(/\*(.*?)\*/g, '$1')
    .replace(/#{1,6}\s/g, '')
    .replace(/[•▪–—]/g, ',')
    .replace(/\n{2,}/g, '. ')
    .replace(/\n/g, ' ')
    .replace(/\s{2,}/g, ' ')
    .trim()
    .substring(0, 2000);
}

// ── Message bubble ────────────────────────────────────────────────────────────
function Bubble({ role, content, ttsSupported, onSpeak }) {
  const isUser = role === 'user';
  return (
    <div style={{ display: 'flex', justifyContent: isUser ? 'flex-end' : 'flex-start', marginBottom: 8 }}>
      {!isUser && (
        <div style={{
          width: 26, height: 26, borderRadius: '50%', flexShrink: 0,
          marginRight: 6, marginTop: 2, background: SAIGE_GREEN,
          overflow: 'hidden', display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}>
          <img src="/images/SaigeIcon.png" alt="" style={{ width: 26, height: 26, objectFit: 'cover' }} />
        </div>
      )}
      <div style={{ position: 'relative', maxWidth: '82%' }}>
        <div style={{
          padding: '8px 12px',
          paddingRight: !isUser && ttsSupported ? '28px' : '12px',
          borderRadius: 12,
          fontSize: 13.5,
          lineHeight: 1.5,
          whiteSpace: 'pre-wrap',
          wordBreak: 'break-word',
          fontFamily: FONT_BODY,
          background: isUser ? SAIGE_GREEN : SAIGE_LIGHT,
          color: isUser ? '#fff' : '#111827',
          border: isUser ? 'none' : `1px solid ${SAIGE_BORDER}`,
        }}>
          {content}
        </div>
        {!isUser && ttsSupported && (
          <button
            onClick={() => onSpeak(content)}
            title="Read aloud"
            style={{
              position: 'absolute', top: 5, right: 5,
              background: 'transparent', border: 'none',
              color: SAIGE_GREEN, fontSize: 12, cursor: 'pointer',
              padding: '2px 3px', lineHeight: 1,
            }}
          >🔊</button>
        )}
      </div>
    </div>
  );
}

// ── Quick prompts ─────────────────────────────────────────────────────────────
function quickPrompts(ctx) {
  const c = (ctx || '').toLowerCase();
  if (c.includes('herd health') || c.includes('herd') || c.includes('livestock')) {
    return [
      'Any withdrawal alerts?',
      'Vaccinations overdue?',
      'Animals in quarantine?',
      'Medication inventory low?',
      'When are my next animals due to calve?',
    ];
  }
  if (c.includes('precision') || c.includes('field') || c.includes('crop')) {
    return ['Check my fields', 'Any pest alerts?', 'Irrigation needed?', 'Crop benchmark'];
  }
  return ['Livestock health tips', 'Crop advice', 'Weather impacts', 'Ask anything'];
}

const chipStyle = {
  background: SAIGE_LIGHT,
  color: SAIGE_GREEN,
  border: `1px solid ${SAIGE_BORDER}`,
  borderRadius: 999,
  padding: '3px 10px',
  fontSize: 11,
  fontFamily: FONT_BODY,
  fontWeight: 600,
  cursor: 'pointer',
  whiteSpace: 'nowrap',
};

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
  fontFamily: FONT_BODY,
};

// ── Parse + fire MAP_CMD embedded in Saige's reply ────────────────────────────
function extractMapCmd(text) {
  const m = (text || '').match(/\[MAP_CMD:\s*([^\]]+)\]/);
  if (!m) return text;
  const params = {};
  m[1].trim().split(/\s+/).forEach(part => {
    const eq = part.indexOf('=');
    if (eq > -1) {
      const k = part.slice(0, eq);
      const v = part.slice(eq + 1).replace(/^"|"$/g, '');
      params[k] = isNaN(v) ? v : parseFloat(v);
    }
  });
  if (params.lat && params.lon) {
    window.dispatchEvent(new CustomEvent('saige:map-command', {
      detail: { action: params.action || 'flyTo', lat: params.lat, lon: params.lon, zoom: params.zoom || 12 },
    }));
  }
  return text.replace(/\[MAP_CMD:[^\]]+\]/g, '').trim();
}

// ── Chat panel ────────────────────────────────────────────────────────────────
function ChatPanel({ businessId, fieldId, pageContext, language, onClose, onFullPage }) {
  const [messages, setMessages] = useState([]);
  const [input, setInput]       = useState('');
  const [sending, setSending]   = useState(false);
  const [error, setError]       = useState('');
  const [threadId]              = useState(() => {
    const pid = getPeopleId();
    const k = `saige_widget_thread_${pid}_${businessId || 0}`;
    const stored = localStorage.getItem(k);
    if (stored) return stored;
    const newTid = `saige_w_${Date.now()}_${Math.random().toString(36).slice(2, 9)}`;
    localStorage.setItem(k, newTid);
    return newTid;
  });

  // ── Voice state ──────────────────────────────────────────────────────────────
  const ttsSupported = typeof window !== 'undefined' && typeof Audio !== 'undefined';
  const sttSupported = typeof window !== 'undefined' &&
    Boolean(window.SpeechRecognition || window.webkitSpeechRecognition);

  const [autoSpeak, setAutoSpeak] = useState(() => {
    try { const s = localStorage.getItem(AUTOSPEAK_KEY); return s === 'true'; } catch { return false; }
  });
  const [speaking,  setSpeaking]  = useState(false);
  const [recording, setRecording] = useState(false);
  const [voiceErr,  setVoiceErr]  = useState(null);

  const recRef        = useRef(null);
  const isRecRef      = useRef(false);
  const transcriptRef = useRef('');
  const pausedTtsRef  = useRef(false);
  const sendRef       = useRef(() => {});
  const audioRef      = useRef(null);

  const showVoiceErr = (msg) => { setVoiceErr(msg); setTimeout(() => setVoiceErr(null), 4000); };

  const stopTTS = useCallback(() => {
    if (audioRef.current) {
      audioRef.current.pause();
      if (audioRef.current._objectUrl) URL.revokeObjectURL(audioRef.current._objectUrl);
      audioRef.current = null;
    }
    setSpeaking(false);
    if (pausedTtsRef.current && recRef.current && isRecRef.current) {
      pausedTtsRef.current = false;
      setTimeout(() => { try { recRef.current?.start(); } catch {} }, 350);
    } else {
      pausedTtsRef.current = false;
    }
  }, []);

  const playTTS = useCallback(async (text) => {
    if (!ttsSupported) return;
    const cleaned = cleanForSpeech(text);
    if (!cleaned) return;
    if (recRef.current && isRecRef.current) {
      pausedTtsRef.current = true;
      try { recRef.current.stop(); } catch {}
    }
    if (audioRef.current) {
      audioRef.current.pause();
      if (audioRef.current._objectUrl) URL.revokeObjectURL(audioRef.current._objectUrl);
      audioRef.current = null;
    }
    setSpeaking(true);
    try {
      const res = await fetch(`${SAIGE_API}/tts`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({ text: cleaned }),
      });
      if (!res.ok) throw new Error(`TTS ${res.status}`);
      const blob = await res.blob();
      const objectUrl = URL.createObjectURL(blob);
      const audio = new Audio(objectUrl);
      audio._objectUrl = objectUrl;
      audioRef.current = audio;
      audio.onended = () => {
        URL.revokeObjectURL(objectUrl);
        audioRef.current = null;
        setSpeaking(false);
        if (pausedTtsRef.current && recRef.current && isRecRef.current) {
          pausedTtsRef.current = false;
          setTimeout(() => { try { recRef.current?.start(); } catch {} }, 350);
        } else {
          pausedTtsRef.current = false;
        }
      };
      audio.onerror = () => {
        URL.revokeObjectURL(objectUrl);
        audioRef.current = null;
        setSpeaking(false);
        pausedTtsRef.current = false;
      };
      await audio.play();
    } catch (e) {
      setSpeaking(false);
      pausedTtsRef.current = false;
      console.warn('[TTS]', e);
    }
  }, [ttsSupported]);

  const saveAutoSpeak = (v) => {
    setAutoSpeak(v);
    try { localStorage.setItem(AUTOSPEAK_KEY, String(v)); } catch {}
    if (!v && speaking) stopTTS();
  };

  const stopRecording = useCallback(() => {
    isRecRef.current = false;
    if (recRef.current) { try { recRef.current.stop(); } catch {} recRef.current = null; }
    const text = transcriptRef.current.trim();
    transcriptRef.current = '';
    setInput('');
    setRecording(false);
    if (text) sendRef.current(text);
  }, []);

  const startRecording = useCallback(() => {
    if (recording || !sttSupported) return;
    const SpeechRec = window.SpeechRecognition || window.webkitSpeechRecognition;
    try {
      const rec = new SpeechRec();
      rec.continuous = true; rec.interimResults = true; rec.lang = 'en-US';
      let finalText = '';
      let silenceTimer = null;
      const submitIfReady = () => {
        const text = transcriptRef.current.trim();
        if (!text) return;
        transcriptRef.current = ''; finalText = '';
        setInput('');
        sendRef.current(text);
      };
      rec.onresult = (e) => {
        if (silenceTimer) clearTimeout(silenceTimer);
        silenceTimer = setTimeout(submitIfReady, 1500);
        let interim = '';
        for (let i = e.resultIndex; i < e.results.length; i++) {
          if (e.results[i].isFinal) finalText += e.results[i][0].transcript + ' ';
          else interim += e.results[i][0].transcript;
        }
        const combined = finalText + interim;
        transcriptRef.current = combined;
        setInput(combined);
      };
      rec.onend = () => { if (isRecRef.current && !pausedTtsRef.current) { try { rec.start(); } catch {} } };
      rec.onerror = (e) => {
        if (e.error === 'no-speech' || e.error === 'aborted') return;
        if (e.error === 'not-allowed') showVoiceErr('Microphone access denied. Check browser permissions.');
        else showVoiceErr(`Mic error: ${e.error}`);
        stopRecording();
      };
      rec.start();
      recRef.current = rec;
      isRecRef.current = true;
      setRecording(true);
    } catch { showVoiceErr('Could not start microphone.'); }
  }, [recording, sttSupported, stopRecording]);

  useEffect(() => () => {
    isRecRef.current = false;
    if (recRef.current) { try { recRef.current.stop(); } catch {} }
    if (audioRef.current) {
      try { audioRef.current.pause(); } catch {}
      if (audioRef.current._objectUrl) { try { URL.revokeObjectURL(audioRef.current._objectUrl); } catch {} }
    }
  }, []);

  const scrollRef = useRef(null);
  useEffect(() => {
    const el = scrollRef.current;
    if (el) el.scrollTop = el.scrollHeight;
  }, [messages, sending]);

  const send = useCallback(async (text) => {
    const val = (text || input).trim();
    if (!val || sending) return;
    setError('');
    const fieldHint = fieldId ? `[Field #${fieldId}]` : '';
    const pageHint  = pageContext ? `[Page: ${pageContext}]` : '';
    const userInput = [fieldHint, pageHint, val].filter(Boolean).join(' ').trim();
    const body = JSON.stringify({
      user_input: userInput,
      thread_id: threadId,
      business_id: businessId ? String(businessId) : null,
      field_id: fieldId ? String(fieldId) : null,
      language: language || 'en',
    });

    const nextMsgs = [...messages, { role: 'user', content: val }];
    setMessages(nextMsgs);
    setInput('');
    setSending(true);

    // ── Try streaming endpoint first ─────────────────────────────────────────
    let streamOk = false;
    try {
      const res = await fetch(`${SAIGE_API}/chat/stream`, {
        method: 'POST',
        headers: authHeaders(),
        body,
      });
      if (res.ok && res.body) {
        streamOk = true;
        const reader = res.body.getReader();
        const decoder = new TextDecoder();
        let partial = '';
        let streamedReply = '';
        // Insert a placeholder assistant bubble; we'll update it token-by-token
        setMessages([...nextMsgs, { role: 'assistant', content: '' }]);

        outer: while (true) {
          const { done, value } = await reader.read();
          if (done) break;
          partial += decoder.decode(value, { stream: true });
          const lines = partial.split('\n');
          partial = lines.pop();
          for (const line of lines) {
            if (!line.startsWith('data: ')) continue;
            let evt;
            try { evt = JSON.parse(line.slice(6)); } catch { continue; }
            if (evt.type === 'token') {
              streamedReply += evt.content;
              setMessages(prev => {
                const upd = [...prev];
                upd[upd.length - 1] = { role: 'assistant', content: streamedReply };
                return upd;
              });
            } else if (evt.type === 'done') {
              // Fire map command from diagnosis (LLM text doesn't echo [MAP_CMD])
              if (evt.diagnosis) extractMapCmd(evt.diagnosis);
              const cleaned = extractMapCmd(
                streamedReply.replace(/\*\*/g, '').replace(/##\s+/g, '').replace(/\*/g, '').trim()
              );
              // If no tokens were streamed (e.g. all iterations consumed by tool calls),
              // fall back to the text portion of the server diagnosis (before any MAP_CMD).
              const diagText = evt.diagnosis
                ? extractMapCmd(evt.diagnosis.replace(/\*\*/g, '').replace(/\*/g, '').trim())
                : '';
              const finalReply = cleaned || diagText || 'No response received.';
              setMessages(prev => {
                const upd = [...prev];
                upd[upd.length - 1] = { role: 'assistant', content: finalReply };
                return upd;
              });
              if (autoSpeak && finalReply) playTTS(finalReply);
              break outer;
            }
          }
        }
      }
    } catch (_streamErr) {
      // Fall through to non-streaming fallback
      streamOk = false;
    }

    // ── Fallback: non-streaming /chat ────────────────────────────────────────
    if (!streamOk) {
      try {
        const res = await fetch(`${SAIGE_API}/chat`, {
          method: 'POST',
          headers: authHeaders(),
          body,
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
          reply = data.message || 'Something went wrong. Please try again.';
        } else {
          reply = data.diagnosis || data.response || 'No response received.';
        }
        reply = extractMapCmd(reply);
        const finalReply = reply || 'No response received.';
        setMessages([...nextMsgs, { role: 'assistant', content: finalReply }]);
        if (autoSpeak) playTTS(finalReply);
      } catch (e) {
        setError(e.message);
        setMessages([...nextMsgs, { role: 'assistant', content: `Error: ${e.message}` }]);
      }
    }

    setSending(false);
  }, [input, messages, sending, threadId, businessId, fieldId, pageContext, language, autoSpeak, playTTS]);

  sendRef.current = send;

  const onKey = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); send(); }
  };

  const prompts = quickPrompts(pageContext);

  return (
    <div style={{
      position: 'fixed',
      bottom: 90,
      right: 20,
      width: 'min(390px, 94vw)',
      height: 'min(560px, 80vh)',
      zIndex: 9999,
      borderRadius: 16,
      background: '#fff',
      display: 'flex',
      flexDirection: 'column',
      boxShadow: '0 12px 44px -8px rgba(0,0,0,0.32)',
      border: `1px solid ${SAIGE_BORDER}`,
      overflow: 'hidden',
    }}>
      {/* Header */}
      <div style={{
        background: SAIGE_GREEN,
        color: '#fff',
        padding: '10px 12px',
        display: 'flex',
        alignItems: 'center',
        gap: 9,
        flexShrink: 0,
      }}>
        <img src="/images/SaigeIcon.png" alt="Saige" style={{ width: 28, height: 28, borderRadius: '50%', objectFit: 'cover', border: '2px solid rgba(255,255,255,0.4)' }} />
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontWeight: 700, fontSize: 15, fontFamily: 'Lora, serif' }}>Saige</div>
          <div style={{ fontSize: 10, opacity: 0.85, fontFamily: FONT_BODY }}>AI Livestock & Farm Assistant</div>
        </div>
        {/* Auto-speak toggle */}
        {ttsSupported && (
          <button
            onClick={() => saveAutoSpeak(!autoSpeak)}
            title={autoSpeak ? 'Auto-speak on — click to mute' : 'Auto-speak off — click to enable'}
            style={{ ...hdrBtn, background: autoSpeak ? 'rgba(255,255,255,0.9)' : 'rgba(255,255,255,0.18)', color: autoSpeak ? SAIGE_DARK : '#fff', padding: '4px 7px', fontSize: 12 }}
          >
            {autoSpeak ? '🔊' : '🔇'}
          </button>
        )}
        {/* Open full page */}
        <button
          onClick={onFullPage}
          title="Open full Saige (with chat history)"
          style={hdrBtn}
        >
          <svg width="13" height="13" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M15 3h6v6M9 21H3v-6M21 3l-7 7M3 21l7-7"/>
          </svg>
        </button>
        <button onClick={onClose} style={hdrBtn} title="Close">×</button>
      </div>

      {/* Speaking indicator */}
      {speaking && (
        <div style={{
          background: SAIGE_LIGHT, borderBottom: `1px solid ${SAIGE_BORDER}`,
          padding: '5px 12px', display: 'flex', alignItems: 'center', gap: 8,
          fontSize: 11, fontFamily: FONT_BODY, color: SAIGE_DARK,
        }}>
          <span style={{ display: 'inline-flex', gap: 2, alignItems: 'flex-end', height: 12 }}>
            {[0, 0.15, 0.3].map((d, i) => (
              <span key={i} style={{ display: 'inline-block', width: 2.5, height: 4, background: SAIGE_GREEN, borderRadius: 2, animation: 'saige-wave 1s ease-in-out infinite', animationDelay: `${d}s` }} />
            ))}
          </span>
          <span>Speaking…</span>
          <button onClick={stopTTS} style={{ marginLeft: 4, padding: '2px 8px', borderRadius: 999, background: SAIGE_GREEN, border: 'none', color: '#fff', fontSize: 10, fontWeight: 600, cursor: 'pointer' }}>Stop</button>
        </div>
      )}

      {/* Messages */}
      <div ref={scrollRef} style={{ flex: 1, padding: '12px 12px 8px', overflowY: 'auto', background: '#fafdf9' }}>
        {messages.length === 0 && (
          <div style={{ fontSize: 13, color: '#4b5563', padding: '8px 4px', lineHeight: 1.65, fontFamily: FONT_BODY }}>
            Hi! I'm Saige. Ask me about your livestock health, treatments, vaccinations, breeding records — or anything about your farm.
          </div>
        )}
        {messages.map((m, i) => (
          <Bubble key={i} role={m.role} content={m.content} ttsSupported={ttsSupported} onSpeak={playTTS} />
        ))}
        {sending && (
          <div style={{ fontSize: 12, color: '#6b7280', fontStyle: 'italic', fontFamily: FONT_BODY, padding: '4px 0' }}>
            Saige is thinking…
          </div>
        )}
        {error && <div style={{ fontSize: 11, color: '#991b1b', marginTop: 4 }}>{error}</div>}
      </div>

      {/* Quick prompts — shown until first message */}
      {messages.length === 0 && (
        <div style={{ padding: '4px 10px 6px', display: 'flex', flexWrap: 'wrap', gap: 5, flexShrink: 0, borderTop: `1px solid #e5f0e2` }}>
          {prompts.map(p => (
            <button key={p} onClick={() => send(p)} style={chipStyle}>{p}</button>
          ))}
        </div>
      )}

      {/* Composer */}
      <div style={{ padding: '8px 10px 10px', borderTop: '1px solid #e5e7eb', background: '#fff', flexShrink: 0 }}>
        <div style={{ display: 'flex', gap: 7, alignItems: 'center' }}>
          {sttSupported && (
            <button
              onClick={() => recording ? stopRecording() : startRecording()}
              title={recording ? 'Stop recording' : 'Speak to Saige'}
              style={{
                width: 36, height: 36, flexShrink: 0,
                borderRadius: '50%', border: 'none', cursor: 'pointer',
                background: recording ? 'linear-gradient(135deg,#ef4444,#b91c1c)' : SAIGE_LIGHT,
                color: recording ? '#fff' : SAIGE_DARK,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 16, transition: 'all 0.15s',
                animation: recording ? 'saige-rec-pulse 1.4s ease-in-out infinite' : 'none',
                boxShadow: recording ? 'none' : `inset 0 0 0 1px ${SAIGE_BORDER}`,
              }}
            >
              {recording ? '■' : '🎤'}
            </button>
          )}
          <textarea
            rows={1}
            value={input}
            onChange={e => setInput(e.target.value)}
            onKeyDown={onKey}
            placeholder={recording ? 'Listening…' : 'Ask Saige about your herd…'}
            style={{
              flex: 1,
              resize: 'none',
              border: `1px solid ${recording ? '#ef4444' : '#d1d5db'}`,
              borderRadius: 8,
              padding: '8px 10px',
              fontSize: 13.5,
              fontFamily: FONT_BODY,
              outline: 'none',
              minHeight: 36,
              lineHeight: 1.4,
            }}
          />
          <button
            onClick={() => send()}
            disabled={!input.trim() || sending}
            aria-label="Send message"
            title="Send message"
            style={{
              padding: '8px 13px',
              background: SAIGE_GREEN,
              color: '#fff',
              border: 'none',
              borderRadius: 8,
              fontSize: 13,
              fontWeight: 600,
              cursor: input.trim() && !sending ? 'pointer' : 'not-allowed',
              opacity: input.trim() && !sending ? 1 : 0.5,
              fontFamily: FONT_BODY,
              flexShrink: 0,
            }}
          >
            <svg width="14" height="14" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
            </svg>
          </button>
        </div>
        {voiceErr && (
          <div style={{ marginTop: 5, fontSize: 11, color: '#991b1b', fontFamily: FONT_BODY }}>{voiceErr}</div>
        )}
      </div>

      <style>{`
        @keyframes saige-wave {
          0%, 100% { height: 4px; }
          50% { height: 13px; }
        }
        @keyframes saige-rec-pulse {
          0%, 100% { box-shadow: 0 0 0 0 rgba(239,68,68,0.55); }
          50% { box-shadow: 0 0 0 7px rgba(239,68,68,0); }
        }
      `}</style>
    </div>
  );
}

// ── Main export ───────────────────────────────────────────────────────────────
export default function SaigeWidget({ businessId: propBusinessId, fieldId, pageContext }) {
  const { Expanded: sidebarExpanded, BusinessID: contextBusinessId } = useAccount();
  // Prefer the explicit prop (passed from the URL), fall back to the currently-selected
  // business from AccountContext so Saige knows the business on pages without ?BusinessID=
  const businessId = propBusinessId ?? contextBusinessId ?? null;
  const { language } = useLanguage();
  const navigate = useNavigate();
  const [open, setOpen] = useState(false);

  // Close on Escape
  useEffect(() => {
    if (!open) return;
    const onEsc = (e) => { if (e.key === 'Escape') setOpen(false); };
    window.addEventListener('keydown', onEsc);
    return () => window.removeEventListener('keydown', onEsc);
  }, [open]);

  const goFullPage = () => {
    setOpen(false);
    const qs = businessId ? `?BusinessID=${businessId}` : '';
    navigate(`/saige${qs}`);
  };

  return (
    <>
      {/* FAB launcher */}
      {createPortal(
        <button
          onClick={() => setOpen(v => !v)}
          aria-label="Open Saige AI assistant"
          title="Ask Saige"
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

      {/* Chat panel */}
      {open && createPortal(
        <ChatPanel
          businessId={businessId}
          fieldId={fieldId}
          pageContext={pageContext}
          language={language}
          onClose={() => setOpen(false)}
          onFullPage={goFullPage}
        />,
        document.body,
      )}
    </>
  );
}
