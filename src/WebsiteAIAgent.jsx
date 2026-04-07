import React, { useState, useEffect, useRef, useCallback } from 'react';
import { useAccount } from './AccountContext';

const API = import.meta.env.VITE_API_URL;
const AGENT_NAME = 'Lavendir';
const AVATAR_COLOR = '#7C5CBF';
const HEADER_H = 72; // px — matches AccountLayout header height

// ── Lavendir branch icon ──────────────────────────────────────────
function LavenderBranchIcon({ size = 24 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="16" cy="16" r="15" fill="rgba(255,255,255,0.22)" />
      <path d="M16 27 Q15.5 20 16 8" stroke="#E8D5FF" strokeWidth="1.6" strokeLinecap="round" />
      <path d="M16 22 Q13 20 11 18" stroke="#E8D5FF" strokeWidth="1.3" strokeLinecap="round" />
      <path d="M16 18 Q13 16 11 14" stroke="#E8D5FF" strokeWidth="1.3" strokeLinecap="round" />
      <path d="M16 14 Q13.5 12 12 10" stroke="#E8D5FF" strokeWidth="1.2" strokeLinecap="round" />
      <path d="M16 22 Q19 20 21 18" stroke="#E8D5FF" strokeWidth="1.3" strokeLinecap="round" />
      <path d="M16 18 Q19 16 21 14" stroke="#E8D5FF" strokeWidth="1.3" strokeLinecap="round" />
      <path d="M16 14 Q18.5 12 20 10" stroke="#E8D5FF" strokeWidth="1.2" strokeLinecap="round" />
      <ellipse cx="11" cy="17.5" rx="1.8" ry="2.4" fill="#D4AAFF" transform="rotate(-20 11 17.5)" />
      <ellipse cx="11" cy="13.5" rx="1.8" ry="2.4" fill="#C496FF" transform="rotate(-25 11 13.5)" />
      <ellipse cx="12" cy="9.5"  rx="1.6" ry="2.2" fill="#B882FF" transform="rotate(-30 12 9.5)" />
      <ellipse cx="21" cy="17.5" rx="1.8" ry="2.4" fill="#D4AAFF" transform="rotate(20 21 17.5)" />
      <ellipse cx="21" cy="13.5" rx="1.8" ry="2.4" fill="#C496FF" transform="rotate(25 21 13.5)" />
      <ellipse cx="20" cy="9.5"  rx="1.6" ry="2.2" fill="#B882FF" transform="rotate(30 20 9.5)" />
      <ellipse cx="16" cy="7.5" rx="1.5" ry="2.2" fill="#A86EFF" />
    </svg>
  );
}

function authHeaders() {
  const token = localStorage.getItem('access_token');
  return { 'Content-Type': 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) };
}

const STORAGE_MIC = 'lavendir_mic_device_id';
const STORAGE_TTS = 'lavendir_tts_voice';
const SpeechRecognitionAPI = typeof window !== 'undefined'
  ? (window.SpeechRecognition || window.webkitSpeechRecognition)
  : null;

// ── Speech-to-text hook ───────────────────────────────────────────
// start(continuous=false) — false: stops after natural pause (conversation mode)
//                         — true:  keeps listening until stop() called (manual mode)
function useSpeechRecognition(onResult, onError) {
  const recRef = useRef(null);
  const [listening, setListening] = useState(false);
  const shouldRestartRef = useRef(false);
  const onResultRef = useRef(onResult);
  const onErrorRef  = useRef(onError);
  useEffect(() => { onResultRef.current = onResult; }, [onResult]);
  useEffect(() => { onErrorRef.current  = onError;  }, [onError]);

  const warmUp = useCallback(async () => {
    const deviceId = localStorage.getItem(STORAGE_MIC);
    try {
      const stream = await navigator.mediaDevices.getUserMedia(
        { audio: deviceId ? { deviceId: { exact: deviceId } } : true }
      );
      stream.getTracks().forEach(t => t.stop());
      return true;
    } catch (e) {
      const msg = e.name === 'NotAllowedError'
        ? 'Microphone access denied. Allow it in browser settings.'
        : `Microphone error: ${e.message}`;
      onErrorRef.current?.(msg);
      return false;
    }
  }, []);

  const startRec = useCallback((continuous) => {
    if (!SpeechRecognitionAPI) {
      onErrorRef.current?.('Speech recognition not supported. Please use Chrome.');
      return;
    }
    const rec = new SpeechRecognitionAPI();
    rec.continuous     = continuous;
    rec.interimResults = false;
    rec.lang           = 'en-US';

    rec.onresult = (e) => {
      const transcript = Array.from(e.results)
        .filter(r => r.isFinal)
        .map(r => r[0].transcript)
        .join(' ')
        .trim();
      if (transcript) onResultRef.current?.(transcript);
    };
    rec.onerror = (e) => {
      if (e.error === 'not-allowed') {
        onErrorRef.current?.('Microphone access denied.');
      } else if (e.error !== 'no-speech') {
        onErrorRef.current?.(`Speech error: ${e.error}`);
      }
      shouldRestartRef.current = false;
      setListening(false);
    };
    rec.onend = () => {
      // Auto-restart only in continuous (manual) mode; conversation mode restarts via TTS onEnd
      if (shouldRestartRef.current && recRef.current) {
        try { recRef.current.start(); }
        catch { setListening(false); shouldRestartRef.current = false; }
      } else {
        recRef.current = null;
        setListening(false);
      }
    };

    recRef.current = rec;
    try {
      rec.start();
      setListening(true);
    } catch {
      onErrorRef.current?.('Could not start speech recognition.');
    }
  }, []);

  const start = useCallback(async (continuous = false) => {
    if (listening) return;
    const ok = await warmUp();
    if (!ok) return;
    shouldRestartRef.current = continuous;
    startRec(continuous);
  }, [listening, warmUp, startRec]);

  const stop = useCallback(() => {
    shouldRestartRef.current = false;
    recRef.current?.stop();
    recRef.current = null;
    setListening(false);
  }, []);

  const toggle = useCallback(async () => {
    if (listening) stop();
    else await start(true); // manual mode = continuous
  }, [listening, start, stop]);

  return { listening, start, stop, toggle, supported: !!SpeechRecognitionAPI };
}

// ── TTS helpers ───────────────────────────────────────────────────
const PREFERRED_VOICES = [
  'Google US English',
  'Microsoft Jenny Online (Natural) - English (United States)',
  'Microsoft Zira - English (United States)',
  'Samantha',
];

function pickVoice() {
  const voices = window.speechSynthesis.getVoices();
  if (!voices.length) return null;
  const saved = localStorage.getItem(STORAGE_TTS);
  if (saved) {
    const pref = voices.find(v => v.name === saved);
    if (pref) return pref;
  }
  for (const name of PREFERRED_VOICES) {
    const v = voices.find(v => v.name === name);
    if (v) return v;
  }
  const googleUS = voices.find(v => v.name.includes('Google') && v.lang.startsWith('en-US'));
  if (googleUS) return googleUS;
  return voices.find(v => v.lang === 'en-US') || null;
}

function speak(text, onEnd) {
  if (!window.speechSynthesis) { onEnd?.(); return; }
  window.speechSynthesis.cancel();

  const clean = text
    .replace(/\*\*(.*?)\*\*/g, '$1')
    .replace(/\*(.*?)\*/g, '$1')
    .replace(/#{1,6}\s/g, '')
    .replace(/`/g, '')
    .replace(/\bLavendir\b/gi, 'Lavender');

  const doSpeak = () => {
    const utt = new SpeechSynthesisUtterance(clean);
    const voice = pickVoice();
    if (voice) utt.voice = voice;
    utt.lang  = 'en-US';
    utt.rate  = 1.0;
    utt.pitch = 1.0;
    utt.onend  = () => onEnd?.();
    utt.onerror = () => onEnd?.();
    window.speechSynthesis.speak(utt);
  };

  if (window.speechSynthesis.getVoices().length > 0) {
    doSpeak();
  } else {
    window.speechSynthesis.onvoiceschanged = () => {
      window.speechSynthesis.onvoiceschanged = null;
      doSpeak();
    };
  }
}

// ── Markdown renderer ─────────────────────────────────────────────
function MessageContent({ text }) {
  const html = text
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.*?)\*/g, '<em>$1</em>')
    .replace(/`(.*?)`/g, '<code class="bg-purple-50 text-purple-700 px-1 rounded text-xs">$1</code>')
    .split('\n').join('<br />');
  return <span dangerouslySetInnerHTML={{ __html: html }} />;
}

// ── Main component ────────────────────────────────────────────────
export default function WebsiteAIAgent({ websiteId, businessId, currentView }) {
  const { Expanded: sidebarExpanded } = useAccount();
  const sidebarWidth = sidebarExpanded ? 208 : 64;

  const [open, setOpen]                   = useState(false);
  const [panelExpanded, setPanelExpanded] = useState(false);
  const [messages, setMessages]           = useState([]);
  const [input, setInput]                 = useState('');
  const [loading, setLoading]             = useState(false);
  const [ttsEnabled, setTtsEnabled]       = useState(false);
  const [suggestions, setSuggestions]     = useState([]);
  const [pendingAction, setPendingAction] = useState(null);
  const [confirming, setConfirming]       = useState(false);
  const [sttError, setSttError]           = useState('');
  const [conversationMode, setConversationMode] = useState(false);

  const conversationModeRef = useRef(false);
  const sendMessageRef      = useRef(null);
  const startRef            = useRef(null);
  const bottomRef           = useRef(null);
  const hasGreetedRef       = useRef(false);

  // STT result handler — uses refs to avoid stale closure
  const onSttResult = useCallback((transcript) => {
    if (conversationModeRef.current) {
      sendMessageRef.current?.(transcript);
    } else {
      setInput(t => t ? `${t} ${transcript}` : transcript);
    }
  }, []);

  const onSttError = useCallback((err) => setSttError(err), []);

  const { listening, start, stop, toggle: toggleListening, supported: sttSupported } =
    useSpeechRecognition(onSttResult, onSttError);

  // Keep start ref current so TTS onEnd can restart listening
  useEffect(() => { startRef.current = start; }, [start]);

  // ── Greeting ──────────────────────────────────────────────────
  useEffect(() => {
    if (open && messages.length === 0 && !hasGreetedRef.current) {
      hasGreetedRef.current = true;
      const greeting = {
        role: 'assistant',
        content: `Hi! I'm **${AGENT_NAME}**, your website design assistant. 🌿 What would you like to work on today?`,
      };
      setMessages([greeting]);
      if (ttsEnabled) speak(greeting.content);
    }
  }, [open]);

  // ── Suggestions ───────────────────────────────────────────────
  useEffect(() => {
    if (!open || !websiteId) return;
    fetch(`${API}/api/lavendir/suggestions/${websiteId}`, { headers: authHeaders() })
      .then(r => r.json())
      .then(data => setSuggestions(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, [open, websiteId]);

  // ── Auto-scroll ───────────────────────────────────────────────
  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, loading]);

  // ── Send message ──────────────────────────────────────────────
  // NOTE: reassigned every render so sendMessageRef always has the latest closure
  const sendMessage = async (text) => {
    const userText = (typeof text === 'string' ? text : input).trim();
    if (!userText || loading) return;
    setInput('');
    setPendingAction(null);

    const newMessages = [...messages, { role: 'user', content: userText }];
    setMessages(newMessages);
    setLoading(true);

    const isConv = conversationModeRef.current;

    try {
      const res = await fetch(`${API}/api/lavendir/chat`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({
          website_id: websiteId,
          business_id: businessId,
          messages: newMessages,
          current_page: currentView,
        }),
      });
      if (!res.ok) throw new Error('Chat failed');
      const data = await res.json();
      const responseText = data.content;
      setMessages(prev => [...prev, { role: 'assistant', content: responseText }]);
      if (data.pending_action) setPendingAction(data.pending_action);

      if (isConv) {
        // Conversation mode: speak → then restart listening
        speak(responseText, () => {
          if (conversationModeRef.current) startRef.current?.(false);
        });
      } else if (ttsEnabled) {
        speak(responseText);
      }
    } catch {
      const errMsg = "I'm having trouble connecting right now. Please try again in a moment.";
      setMessages(prev => [...prev, { role: 'assistant', content: errMsg }]);
      if (isConv) {
        speak(errMsg, () => {
          if (conversationModeRef.current) startRef.current?.(false);
        });
      }
    } finally {
      setLoading(false);
    }
  };

  // Keep ref up-to-date on every render
  sendMessageRef.current = sendMessage;

  const handleKey = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage(); }
  };

  const clearChat = () => { setMessages([]); setPendingAction(null); };

  // ── Conversation mode toggle ──────────────────────────────────
  const handleMicClick = async () => {
    if (conversationMode) {
      // Exit conversation mode
      setConversationMode(false);
      conversationModeRef.current = false;
      stop();
      window.speechSynthesis?.cancel();
    } else {
      // Enter conversation mode — continuous=false so browser stops after natural pause
      setSttError('');
      setConversationMode(true);
      conversationModeRef.current = true;
      await start(false);
    }
  };

  // ── Confirm action ────────────────────────────────────────────
  const confirmAction = async (confirmed) => {
    if (!pendingAction) return;
    setConfirming(true);
    const action = pendingAction;
    setPendingAction(null);
    const isConv = conversationModeRef.current;
    try {
      const res = await fetch(`${API}/api/lavendir/confirm`, {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({
          website_id: websiteId,
          business_id: businessId,
          action: action.action,
          params: action.params,
          confirmed,
        }),
      });
      const data = await res.json();
      setMessages(prev => [...prev, { role: 'assistant', content: data.content }]);
      if (isConv) {
        speak(data.content, () => {
          if (conversationModeRef.current) startRef.current?.(false);
        });
      } else if (ttsEnabled) {
        speak(data.content);
      }
    } catch {
      setMessages(prev => [...prev, { role: 'assistant', content: 'Something went wrong. Please try again.' }]);
    } finally {
      setConfirming(false);
    }
  };

  const handleClose = () => {
    setOpen(false);
    setPanelExpanded(false);
    setConversationMode(false);
    conversationModeRef.current = false;
    stop();
    window.speechSynthesis?.cancel();
  };

  // ── Floating button ───────────────────────────────────────────
  if (!open) {
    return (
      <button
        onClick={() => setOpen(true)}
        title={`Chat with ${AGENT_NAME}`}
        className="fixed bottom-6 right-6 z-50 w-14 h-14 rounded-full shadow-2xl flex items-center justify-center transition-all hover:scale-110 active:scale-95"
        style={{ background: AVATAR_COLOR }}
      >
        <LavenderBranchIcon size={32} />
      </button>
    );
  }

  // Panel geometry: small (default) vs full-page
  const panelStyle = panelExpanded
    ? { top: HEADER_H, left: sidebarWidth, right: 0, bottom: 0, zIndex: 45, borderRadius: 0 }
    : { width: 360, height: 540, bottom: 24, right: 24, zIndex: 50, borderRadius: '1rem' };

  // ── Chat panel ────────────────────────────────────────────────
  return (
    <div
      className="fixed flex flex-col shadow-2xl overflow-hidden"
      style={{ background: '#fff', border: '1px solid #e5e7eb', ...panelStyle }}
    >
      {/* Header */}
      <div className="flex items-center gap-3 px-4 py-3 shrink-0" style={{ background: AVATAR_COLOR }}>
        <div className="w-8 h-8 rounded-full flex items-center justify-center shrink-0" style={{ background: 'rgba(255,255,255,0.18)' }}>
          <LavenderBranchIcon size={20} />
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-white font-bold text-sm leading-none">{AGENT_NAME}</p>
          <p className="text-purple-200 text-xs mt-0.5">
            {conversationMode
              ? <span className="flex items-center gap-1.5">
                  <span className="w-1.5 h-1.5 rounded-full bg-green-300 inline-block animate-pulse" />
                  Conversation mode active
                </span>
              : 'Website Design Assistant'
            }
          </p>
        </div>
        <div className="flex items-center gap-1">
          {/* TTS toggle — hidden in conversation mode (always on) */}
          {!conversationMode && (
            <button
              onClick={() => { setTtsEnabled(v => !v); if (ttsEnabled) window.speechSynthesis?.cancel(); }}
              title={ttsEnabled ? 'Mute voice' : 'Enable voice'}
              className={`p-1.5 rounded-lg transition-colors ${ttsEnabled ? 'bg-white/30 text-white' : 'text-white/60 hover:text-white hover:bg-white/20'}`}
            >
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                {ttsEnabled
                  ? <><path d="M11 5L6 9H2v6h4l5 4V5z"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/></>
                  : <><path d="M11 5L6 9H2v6h4l5 4V5z"/><line x1="23" y1="9" x2="17" y2="15"/><line x1="17" y1="9" x2="23" y2="15"/></>
                }
              </svg>
            </button>
          )}
          {/* Expand / collapse */}
          <button
            onClick={() => setPanelExpanded(v => !v)}
            title={panelExpanded ? 'Collapse panel' : 'Expand to full page'}
            className="p-1.5 rounded-lg text-white/60 hover:text-white hover:bg-white/20 transition-colors"
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              {panelExpanded
                ? <><polyline points="4 14 10 14 10 20"/><polyline points="20 10 14 10 14 4"/><line x1="10" y1="14" x2="3" y2="21"/><line x1="21" y1="3" x2="14" y2="10"/></>
                : <><polyline points="15 3 21 3 21 9"/><polyline points="9 21 3 21 3 15"/><line x1="21" y1="3" x2="14" y2="10"/><line x1="3" y1="21" x2="10" y2="14"/></>
              }
            </svg>
          </button>
          {/* Clear chat */}
          <button onClick={clearChat} title="Clear chat" className="p-1.5 rounded-lg text-white/60 hover:text-white hover:bg-white/20 transition-colors">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"/>
            </svg>
          </button>
          {/* Close */}
          <button onClick={handleClose} className="p-1.5 rounded-lg text-white/60 hover:text-white hover:bg-white/20 transition-colors text-lg leading-none">×</button>
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto px-4 py-3 space-y-3" style={{ background: '#faf9ff' }}>
        {messages.map((msg, i) => (
          <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'} items-end gap-2`}>
            {msg.role === 'assistant' && (
              <div className="w-6 h-6 rounded-full flex items-center justify-center shrink-0 mb-0.5" style={{ background: AVATAR_COLOR }}>
                <LavenderBranchIcon size={16} />
              </div>
            )}
            <div
              className={`rounded-2xl px-3 py-2 text-sm leading-relaxed ${panelExpanded ? 'max-w-[55%]' : 'max-w-[80%]'} ${
                msg.role === 'user'
                  ? 'bg-gray-800 text-white rounded-br-sm'
                  : 'bg-white border border-purple-100 text-gray-800 rounded-bl-sm shadow-sm'
              }`}
            >
              <MessageContent text={msg.content} />
            </div>
          </div>
        ))}

        {loading && (
          <div className="flex items-end gap-2 justify-start">
            <div className="w-6 h-6 rounded-full flex items-center justify-center shrink-0" style={{ background: AVATAR_COLOR }}>
              <LavenderBranchIcon size={16} />
            </div>
            <div className="bg-white border border-purple-100 rounded-2xl rounded-bl-sm px-4 py-3 shadow-sm">
              <div className="flex gap-1 items-center">
                <span className="w-1.5 h-1.5 rounded-full animate-bounce" style={{ background: AVATAR_COLOR, animationDelay: '0ms' }} />
                <span className="w-1.5 h-1.5 rounded-full animate-bounce" style={{ background: AVATAR_COLOR, animationDelay: '150ms' }} />
                <span className="w-1.5 h-1.5 rounded-full animate-bounce" style={{ background: AVATAR_COLOR, animationDelay: '300ms' }} />
              </div>
            </div>
          </div>
        )}

        {messages.length === 1 && suggestions.length > 0 && (
          <div className="flex flex-col gap-1.5 mt-1">
            <p className="text-xs text-purple-400 pl-8">Quick suggestions:</p>
            {suggestions.map((s, i) => (
              <button key={i} onClick={() => sendMessage(s.text)}
                className="ml-8 text-left text-xs text-purple-700 bg-purple-50 border border-purple-100 rounded-xl px-3 py-2 hover:bg-purple-100 transition-colors">
                {s.text}
              </button>
            ))}
          </div>
        )}

        <div ref={bottomRef} />
      </div>

      {/* Confirmation banner */}
      {(pendingAction || confirming) && (
        <div className="border-t border-purple-100 px-3 py-3 bg-purple-50 shrink-0">
          {confirming ? (
            <p className="text-xs text-purple-500 text-center animate-pulse">Applying changes…</p>
          ) : (
            <>
              <p className="text-xs font-semibold text-purple-800 mb-2">Confirm change:</p>
              <p className="text-xs text-purple-700 mb-3 leading-relaxed">{pendingAction.description}</p>
              <div className="flex gap-2">
                <button onClick={() => confirmAction(true)}
                  className="flex-1 py-1.5 rounded-lg text-xs font-bold text-white transition-colors"
                  style={{ background: AVATAR_COLOR }}>
                  Yes, do it
                </button>
                <button onClick={() => confirmAction(false)}
                  className="flex-1 py-1.5 rounded-lg text-xs font-medium text-gray-600 border border-gray-200 hover:bg-gray-50 transition-colors">
                  No, cancel
                </button>
              </div>
            </>
          )}
        </div>
      )}

      {/* Input bar */}
      <div className="border-t border-gray-100 px-3 py-2.5 flex items-end gap-2 bg-white shrink-0 relative">
        {sttError && (
          <div className="absolute bottom-full left-3 right-3 mb-1 bg-red-50 border border-red-200 text-red-700 text-xs rounded-lg px-3 py-2 z-10">
            {sttError}
            <button onClick={() => setSttError('')} className="ml-2 text-red-400 hover:text-red-600">✕</button>
          </div>
        )}
        {sttSupported && (
          <button
            onClick={handleMicClick}
            title={conversationMode ? 'End conversation' : 'Start conversation mode'}
            className={`p-2 rounded-xl transition-all shrink-0 relative ${
              conversationMode || listening
                ? 'text-white shadow-lg'
                : 'text-gray-400 hover:text-purple-600 hover:bg-purple-50'
            }`}
            style={(conversationMode || listening) ? { background: AVATAR_COLOR } : {}}
          >
            {(conversationMode || listening) && (
              <span className="absolute inset-0 rounded-xl animate-ping opacity-40" style={{ background: AVATAR_COLOR }} />
            )}
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="relative z-10">
              <path d="M12 1a3 3 0 0 0-3 3v8a3 3 0 0 0 6 0V4a3 3 0 0 0-3-3z"/>
              <path d="M19 10v2a7 7 0 0 1-14 0v-2"/>
              <line x1="12" y1="19" x2="12" y2="23"/>
              <line x1="8" y1="23" x2="16" y2="23"/>
            </svg>
          </button>
        )}
        <textarea
          value={input}
          onChange={e => setInput(e.target.value)}
          onKeyDown={handleKey}
          placeholder={
            conversationMode && listening ? '🎙 Listening… speak now'
            : conversationMode && loading  ? '⏳ Processing…'
            : conversationMode             ? '🎙 Click mic to stop conversation'
            : listening                    ? '🎙 Listening… click mic to stop'
            : `Ask ${AGENT_NAME} anything…`
          }
          rows={1}
          className="flex-1 resize-none border border-gray-200 rounded-xl px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:border-purple-300"
          style={{ maxHeight: 96, '--tw-ring-color': '#C4AAFF' }}
        />
        <button
          onClick={() => sendMessage()}
          disabled={!input.trim() || loading}
          className="p-2 rounded-xl transition-colors shrink-0 disabled:opacity-40"
          style={{ background: AVATAR_COLOR, color: '#fff' }}
        >
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
            <line x1="22" y1="2" x2="11" y2="13"/>
            <polygon points="22 2 15 22 11 13 2 9 22 2"/>
          </svg>
        </button>
      </div>
    </div>
  );
}
