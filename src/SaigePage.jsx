import React, { useEffect, useState, useCallback, useRef } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

// ─── CONFIG ───────────────────────────────────────────────────────────────────
const SAIGE_API = 'https://saige-backend-802455386518.us-central1.run.app';

// ─── TYPES ────────────────────────────────────────────────────────────────────
// Message:      { role: 'user' | 'assistant', content: string }
// Quiz:         { question: string, options: string[] }
// ThreadSummary:{ thread_id, preview, status, advisory_type, updated_at }

// ─── STORAGE HELPERS ─────────────────────────────────────────────────────────
const THREADS_KEY = 'saige_threads';
const MSG_PREFIX  = 'saige_messages_';
const QUIZ_PREFIX = 'saige_quiz_';

function saveThread(threadId, messages, status, advisoryType) {
  try {
    localStorage.setItem(MSG_PREFIX + threadId, JSON.stringify(messages));
    const threads = getStoredThreads();
    const preview = messages.filter(m => m.role === 'user').pop()?.content?.slice(0, 80) || 'New conversation';
    const entry = { thread_id: threadId, preview, status, advisory_type: advisoryType, updated_at: new Date().toISOString() };
    const idx = threads.findIndex(t => t.thread_id === threadId);
    if (idx >= 0) threads[idx] = entry; else threads.unshift(entry);
    localStorage.setItem(THREADS_KEY, JSON.stringify(threads));
  } catch (e) { console.warn('saveThread failed', e); }
}

function getLocalThreads() { return getStoredThreads(); }

function getLocalMessages(threadId) {
  try { const r = localStorage.getItem(MSG_PREFIX + threadId); return r ? JSON.parse(r) : []; }
  catch { return []; }
}

function saveQuiz(threadId, quiz) {
  try {
    if (quiz) localStorage.setItem(QUIZ_PREFIX + threadId, JSON.stringify(quiz));
    else localStorage.removeItem(QUIZ_PREFIX + threadId);
  } catch (e) { console.warn('saveQuiz failed', e); }
}

function getLocalQuiz(threadId) {
  try { const r = localStorage.getItem(QUIZ_PREFIX + threadId); return r ? JSON.parse(r) : null; }
  catch { return null; }
}

function deleteLocalThread(threadId) {
  try {
    localStorage.removeItem(MSG_PREFIX + threadId);
    localStorage.removeItem(QUIZ_PREFIX + threadId);
    const threads = getStoredThreads().filter(t => t.thread_id !== threadId);
    localStorage.setItem(THREADS_KEY, JSON.stringify(threads));
  } catch (e) { console.warn('deleteLocalThread failed', e); }
}

function getStoredThreads() {
  try { const r = localStorage.getItem(THREADS_KEY); return r ? JSON.parse(r) : []; }
  catch { return []; }
}

function generateThreadId() {
  return `thread_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
}

function mergeThreads(apiThreads, localThreads) {
  const seen = new Set();
  const merged = [];
  for (const t of apiThreads) { seen.add(t.thread_id); merged.push(t); }
  for (const t of localThreads) { if (!seen.has(t.thread_id)) merged.push(t); }
  merged.sort((a, b) => new Date(b.updated_at) - new Date(a.updated_at));
  return merged;
}

function formatRelativeTime(isoString) {
  const diffMs = Date.now() - new Date(isoString).getTime();
  const diffMin = Math.floor(diffMs / 60000);
  if (diffMin < 1) return 'just now';
  if (diffMin < 60) return `${diffMin}m ago`;
  const diffHr = Math.floor(diffMin / 60);
  if (diffHr < 24) return `${diffHr}h ago`;
  const diffDay = Math.floor(diffHr / 24);
  if (diffDay < 7) return `${diffDay}d ago`;
  return new Date(isoString).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
}

// ─── CONSTANTS ────────────────────────────────────────────────────────────────
const WELCOME_MESSAGE = {
  role: 'assistant',
  content: "Hello! I'm Saige, your AI agricultural assistant. Ask me about crops, livestock, soil health, weather impacts, or any farming question.",
};

const STAGE_MESSAGES = {
  default:   ['🔍 Analyzing your question...', '📋 Assessment in process...', '🌱 Growing ideas...', '🚜 Harvesting knowledge...', '🧑‍🌾 Preparing your advice...'],
  weather:   ['🌦️ Checking weather conditions...', '☀️ Analyzing climate data...', '🌧️ Processing weather forecast...'],
  livestock: ['🐄 Checking livestock knowledge base...', '🐑 Retrieving breed database...', '🐓 Consulting veterinary experts...'],
  crops:     ['🌾 Consulting crop experts...', '🌿 Analyzing soil & plant health...', '🪴 Processing crop recommendations...'],
  mixed:     ['🌾🐄 Analyzing integrated farm data...', '📋 Processing mixed advisory...', '🧑‍🌾 Preparing comprehensive advice...'],
};

const ADVISORY_COLORS = {
  weather:   { bg: 'rgba(14,165,233,0.15)', text: '#38bdf8' },
  livestock: { bg: 'rgba(245,158,11,0.15)', text: '#fbbf24' },
  crops:     { bg: 'rgba(34,197,94,0.15)',  text: '#4ade80' },
  mixed:     { bg: 'rgba(168,85,247,0.15)', text: '#c084fc' },
};

// ─── THINKING INDICATOR ───────────────────────────────────────────────────────
function ThinkingDots({ stage }) {
  const [msgIdx, setMsgIdx] = useState(0);
  const msgs = STAGE_MESSAGES[stage] || STAGE_MESSAGES.default;

  useEffect(() => {
    setMsgIdx(0);
    const iv = setInterval(() => setMsgIdx(i => (i + 1) % msgs.length), 1500);
    return () => clearInterval(iv);
  }, [stage, msgs.length]);

  return (
    <div style={{ display: 'flex', justifyContent: 'flex-start', marginBottom: 12 }}>
      <div style={{
        maxWidth: '80%', borderRadius: 12, padding: '12px 16px',
        background: 'linear-gradient(135deg,#1e293b,#0f172a)',
        border: '1px solid #334155', color: '#e2e8f0',
        display: 'flex', alignItems: 'center', gap: 10,
      }}>
        <svg style={{ width: 18, height: 18, flexShrink: 0, animation: 'saige-spin 1s linear infinite' }}
          fill="none" viewBox="0 0 24 24" stroke="#60a5fa" strokeWidth={2}>
          <path strokeLinecap="round" strokeLinejoin="round"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
        </svg>
        <span style={{ fontSize: 13, color: '#94a3b8', fontStyle: 'italic' }}>{msgs[msgIdx]}</span>
      </div>
    </div>
  );
}

// ─── CHAT BUBBLE ─────────────────────────────────────────────────────────────
function ChatBubble({ message }) {
  const isUser = message.role === 'user';
  return (
    <div style={{ display: 'flex', justifyContent: isUser ? 'flex-end' : 'flex-start', marginBottom: 12 }}>
      {!isUser && (
        <div style={{
          width: 32, height: 32, borderRadius: '50%', flexShrink: 0, marginRight: 8, marginTop: 2,
          background: 'linear-gradient(135deg,#16a34a,#15803d)',
          display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16,
        }}>🌾</div>
      )}
      <div style={{
        maxWidth: '75%', borderRadius: isUser ? '16px 16px 4px 16px' : '16px 16px 16px 4px',
        padding: '10px 14px',
        background: isUser
          ? 'linear-gradient(135deg,#1d4ed8,#1e40af)'
          : 'linear-gradient(135deg,#1e293b,#0f172a)',
        border: isUser ? 'none' : '1px solid #334155',
        color: '#f1f5f9', fontSize: 14, lineHeight: 1.6,
        boxShadow: '0 2px 8px rgba(0,0,0,0.2)',
      }}>
        <p style={{ margin: 0, whiteSpace: 'pre-wrap' }}>{message.content}</p>
      </div>
    </div>
  );
}

// ─── QUIZ CARD ────────────────────────────────────────────────────────────────
function QuizCard({ quiz, selectedOption, customAnswer, onOptionChange, onCustomChange, onSubmit }) {
  const canSubmit = selectedOption || customAnswer.trim();
  return (
    <div style={{ display: 'flex', justifyContent: 'flex-start', marginBottom: 12 }}>
      <div style={{
        maxWidth: '80%', borderRadius: 12, padding: '16px 18px',
        background: 'linear-gradient(135deg,#1e293b,#0f172a)',
        border: '1px solid #334155', color: '#e2e8f0',
      }}>
        <p style={{ fontSize: 14, color: '#cbd5e1', marginBottom: 14, lineHeight: 1.5 }}>{quiz.question}</p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8, marginBottom: 14 }}>
          {quiz.options.map(opt => (
            <label key={opt} style={{
              display: 'flex', alignItems: 'center', gap: 10, cursor: 'pointer',
              padding: '8px 10px', borderRadius: 8, fontSize: 13,
              background: selectedOption === opt ? 'rgba(29,78,216,0.3)' : 'rgba(255,255,255,0.04)',
              border: `1px solid ${selectedOption === opt ? '#3b82f6' : '#334155'}`,
              transition: 'all 0.15s',
            }}>
              <input type="radio" name="saige-quiz" value={opt}
                checked={selectedOption === opt}
                onChange={e => { onOptionChange(e.target.value); onCustomChange(''); }}
                style={{ accentColor: '#3b82f6' }}
              />
              {opt}
            </label>
          ))}
        </div>
        <div style={{ borderTop: '1px solid #334155', paddingTop: 12, marginBottom: 12 }}>
          <p style={{ fontSize: 12, color: '#64748b', marginBottom: 8 }}>Or write your own answer...</p>
          <input type="text" value={customAnswer}
            onChange={e => { onCustomChange(e.target.value); onOptionChange(''); }}
            onKeyDown={e => { if (e.key === 'Enter' && canSubmit) onSubmit(); }}
            placeholder="Type your answer..."
            style={{
              width: '100%', padding: '8px 12px', borderRadius: 8, fontSize: 13,
              background: '#0f172a', border: '1px solid #334155', color: '#f1f5f9',
              outline: 'none', boxSizing: 'border-box',
            }}
          />
        </div>
        <button onClick={onSubmit} disabled={!canSubmit} style={{
          width: '100%', padding: '10px', borderRadius: 8, border: 'none',
          background: canSubmit ? '#1d4ed8' : '#1e293b',
          color: canSubmit ? 'white' : '#475569',
          cursor: canSubmit ? 'pointer' : 'not-allowed',
          fontWeight: 600, fontSize: 13, transition: 'background 0.15s',
        }}>Submit Answer</button>
      </div>
    </div>
  );
}

// ─── SIDEBAR ─────────────────────────────────────────────────────────────────
function ChatSidebar({ threads, activeThreadId, isCollapsed, isLoading, onToggle, onSelect, onDelete, onNewChat }) {
  return (
    <div style={{
      width: isCollapsed ? 0 : 260, minWidth: isCollapsed ? 0 : 260,
      overflow: 'hidden', transition: 'all 0.3s ease',
      background: '#0f172a', borderRight: '1px solid #1e293b',
      display: 'flex', flexDirection: 'column', position: 'relative', flexShrink: 0,
    }}>
      <div style={{ padding: '16px 14px 10px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', borderBottom: '1px solid #1e293b' }}>
        <span style={{ fontSize: 13, fontWeight: 700, color: '#94a3b8', textTransform: 'uppercase', letterSpacing: 1 }}>History</span>
      </div>
      <div style={{ padding: '10px 10px 6px' }}>
        <button onClick={onNewChat} style={{
          width: '100%', padding: '9px 12px', borderRadius: 8, border: 'none',
          background: 'linear-gradient(135deg,#16a34a,#15803d)', color: 'white',
          cursor: 'pointer', fontWeight: 600, fontSize: 13,
          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
        }}>
          <span style={{ fontSize: 16 }}>+</span> New Chat
        </button>
      </div>
      <div style={{ flex: 1, overflowY: 'auto', padding: '4px 8px' }}>
        {isLoading && threads.length === 0 && (
          <p style={{ textAlign: 'center', color: '#475569', fontSize: 12, padding: '20px 0' }}>Loading...</p>
        )}
        {!isLoading && threads.length === 0 && (
          <p style={{ textAlign: 'center', color: '#475569', fontSize: 12, padding: '20px 8px', lineHeight: 1.5 }}>
            No past conversations yet. Start a new chat!
          </p>
        )}
        {threads.map(t => {
          const isActive = t.thread_id === activeThreadId;
          const color = t.advisory_type ? ADVISORY_COLORS[t.advisory_type] : null;
          return (
            <div key={t.thread_id} onClick={() => onSelect(t.thread_id)}
              style={{
                position: 'relative', padding: '9px 10px', borderRadius: 8, marginBottom: 3,
                cursor: 'pointer', transition: 'background 0.15s',
                background: isActive ? '#1e293b' : 'transparent',
                border: isActive ? '1px solid #334155' : '1px solid transparent',
              }}
              onMouseEnter={e => { if (!isActive) e.currentTarget.style.background = 'rgba(255,255,255,0.04)'; }}
              onMouseLeave={e => { if (!isActive) e.currentTarget.style.background = 'transparent'; }}
            >
              <p style={{ margin: '0 0 4px', fontSize: 13, color: '#e2e8f0', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', paddingRight: 20 }}>
                {t.preview || 'Empty conversation'}
              </p>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <span style={{ width: 6, height: 6, borderRadius: '50%', background: t.status === 'complete' ? '#22c55e' : '#eab308', flexShrink: 0 }} />
                {color && (
                  <span style={{ padding: '1px 6px', borderRadius: 10, fontSize: 10, fontWeight: 600, background: color.bg, color: color.text }}>
                    {t.advisory_type}
                  </span>
                )}
                <span style={{ fontSize: 11, color: '#475569', marginLeft: 'auto' }}>{formatRelativeTime(t.updated_at)}</span>
              </div>
              <button onClick={e => { e.stopPropagation(); onDelete(t.thread_id); }}
                style={{
                  position: 'absolute', top: 8, right: 6, padding: '3px', borderRadius: 4,
                  background: 'none', border: 'none', cursor: 'pointer', color: '#475569',
                  opacity: 0, transition: 'opacity 0.15s',
                }}
                onMouseEnter={e => { e.currentTarget.style.opacity = 1; e.currentTarget.style.color = '#f87171'; }}
                onMouseLeave={e => { e.currentTarget.style.opacity = 0; e.currentTarget.style.color = '#475569'; }}
              >✕</button>
            </div>
          );
        })}
      </div>
    </div>
  );
}

// ─── MESSAGE CACHE ────────────────────────────────────────────────────────────
const _msgCache = new Map();

// ─── MAIN COMPONENT ───────────────────────────────────────────────────────────
export default function SaigePage() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  useEffect(() => { if (BusinessID) LoadBusiness(BusinessID); }, [BusinessID]);

  const [activeThreadId, setActiveThreadId] = useState('');
  const [activeChat, setActiveChat]         = useState([WELCOME_MESSAGE]);
  const [quiz, setQuiz]                     = useState(null);
  const [selectedOption, setSelectedOption] = useState('');
  const [customAnswer, setCustomAnswer]     = useState('');
  const [isThinking, setIsThinking]         = useState(false);
  const [input, setInput]                   = useState('');
  const [processingStage, setProcessingStage] = useState('default');
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);
  const [threads, setThreads]                   = useState([]);
  const [threadsLoading, setThreadsLoading]     = useState(false);

  const advisoryTypeRef = useRef(null);
  const switchingRef    = useRef(false);
  const abortRef        = useRef(null);
  const inputRef        = useRef(null);

  useEffect(() => {
    if (!activeThreadId) setActiveThreadId(generateThreadId());
  }, [activeThreadId]);

  useEffect(() => {
    if (window.innerWidth < 900) setSidebarCollapsed(true);
  }, []);


  useEffect(() => {
    if (activeThreadId && activeChat.length > 0) {
      saveThread(activeThreadId, activeChat, 'active', advisoryTypeRef.current);
    }
  }, [activeThreadId, activeChat]);

  useEffect(() => {
    if (activeThreadId) saveQuiz(activeThreadId, quiz);
  }, [activeThreadId, quiz]);

  const fetchThreads = useCallback(async () => {
    setThreadsLoading(true);
    const localThreads = getLocalThreads();
    let apiThreads = [];
    try {
      const res = await fetch(`${SAIGE_API}/threads?user_id=anonymous`);
      if (res.ok) { const d = await res.json(); apiThreads = d.threads || []; }
    } catch { /* backend unavailable */ }
    setThreads(mergeThreads(apiThreads, localThreads));
    setThreadsLoading(false);
  }, []);

  useEffect(() => { fetchThreads(); }, [fetchThreads]);

  async function handleSelectThread(threadId) {
    if (threadId === activeThreadId || switchingRef.current) return;
    switchingRef.current = true;
    if (abortRef.current) abortRef.current.abort();
    const ctrl = new AbortController();
    abortRef.current = ctrl;
    try {
      let messages = [];
      const cached = _msgCache.get(threadId);
      if (cached && Date.now() - cached.ts < 30000) {
        messages = cached.messages;
      } else {
        try {
          const res = await fetch(`${SAIGE_API}/threads/${threadId}/messages?user_id=anonymous`, { signal: ctrl.signal });
          if (res.ok) {
            const d = await res.json();
            messages = (d.messages || []).map(m => ({ role: m.role, content: m.content }));
            _msgCache.set(threadId, { messages, ts: Date.now() });
          }
        } catch (e) {
          if (e instanceof DOMException && e.name === 'AbortError') return;
        }
      }
      if (messages.length === 0) messages = getLocalMessages(threadId);
      const savedQuiz = getLocalQuiz(threadId);
      setActiveThreadId(threadId);
      setActiveChat(messages.length > 0 ? messages : [WELCOME_MESSAGE]);
      setQuiz(savedQuiz);
      setSelectedOption('');
      setCustomAnswer('');
      setInput('');
    } finally {
      switchingRef.current = false;
    }
  }

  async function handleDeleteThread(threadId) {
    deleteLocalThread(threadId);
    try { await fetch(`${SAIGE_API}/threads/${threadId}?user_id=anonymous`, { method: 'DELETE' }); } catch { /* ok */ }
    if (activeThreadId === threadId) {
      setActiveThreadId(generateThreadId());
      setActiveChat([WELCOME_MESSAGE]);
      setQuiz(null); setSelectedOption(''); setCustomAnswer(''); setInput('');
    }
    fetchThreads();
  }

  function handleNewChat() {
    setActiveThreadId(generateThreadId());
    setActiveChat([WELCOME_MESSAGE]);
    setQuiz(null); setSelectedOption(''); setCustomAnswer(''); setInput('');
    advisoryTypeRef.current = null;
    setProcessingStage('default');
    fetchThreads();
  }

  async function sendMessage(val, options = {}) {
    if (!activeThreadId || !val?.trim()) return;
    const showBubble = options.showUserBubble ?? true;
    if (showBubble) setActiveChat(prev => [...prev, { role: 'user', content: val }]);
    setInput('');

    const lower = val.toLowerCase();
    let earlyStage = 'default';
    if (['weather','temperature','forecast','rain','climate'].some(w => lower.includes(w))) earlyStage = 'weather';
    else if (['cattle','cow','sheep','goat','livestock','animal','breed'].some(w => lower.includes(w))) earlyStage = 'livestock';
    else if (['crop','plant','wheat','rice','corn','tomato','guava','orange','soy'].some(w => lower.includes(w))) earlyStage = 'crops';

    setProcessingStage(earlyStage);
    setIsThinking(true);
    setQuiz(null);

    try {
      const res = await fetch(`${SAIGE_API}/chat`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ user_input: val, thread_id: activeThreadId }),
      });

      if (!res.ok) throw new Error(`Server error (${res.status})`);
      const data = await res.json();

      if (data.processing_stage && data.processing_stage !== 'default') {
        setProcessingStage(data.processing_stage);
      }

      setSelectedOption('');
      setCustomAnswer('');

      if (data.status === 'requires_input') {
        setQuiz(data.ui);
      } else if (data.status === 'complete') {
        let content = '';
        if (data.diagnosis?.trim()) {
          content = data.diagnosis.replace(/\*\*/g, '').replace(/##\s+/g, '').replace(/\*/g, '').trim();
        }
        if (data.recommendations?.length > 0) {
          const embedded = data.recommendations.some(r =>
            content.toLowerCase().includes(r.toLowerCase().substring(0, 30))
          );
          if (!embedded) {
            content += '\n\nQuick Tips:\n';
            data.recommendations.slice(0, 3).forEach(r => {
              content += `\n${r.replace(/\*\*/g, '').replace(/\*/g, '').trim()}`;
            });
          }
        }
        if (!content?.trim()) {
          content = data.diagnosis || 'I received your request but encountered an issue. Please try again.';
        }
        advisoryTypeRef.current = data.advisory_type || null;
        setActiveChat(prev => {
          const updated = [...prev, { role: 'assistant', content }];
          saveThread(activeThreadId, updated, 'complete', data.advisory_type || null);
          return updated;
        });
        fetchThreads();
      } else if (data.status === 'error') {
        setActiveChat(prev => [...prev, { role: 'assistant', content: `Sorry, an error occurred: ${data.message || 'Please try again.'}` }]);
      } else {
        setActiveChat(prev => [...prev, { role: 'assistant', content: 'Thank you for using Saige!' }]);
      }
    } catch (error) {
      console.error('Chat error:', error);
      setActiveChat(prev => [...prev, { role: 'assistant', content: 'Sorry, I could not connect to the server. Please try again.' }]);
    } finally {
      setIsThinking(false);
      setTimeout(() => inputRef.current?.focus(), 100);
    }
  }

  function handleSubmitQuiz() {
    const answer = customAnswer.trim() || selectedOption;
    if (!answer || !quiz) return;
    setActiveChat(prev => [...prev, { role: 'assistant', content: `${quiz.question}\n\nAnswer submitted: ${answer}` }]);
    setSelectedOption('');
    setCustomAnswer('');
    sendMessage(answer, { showUserBubble: false });
  }

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div style={{ margin: '-24px', display: 'flex', flexDirection: 'column', height: 'calc(100vh - 64px)' }}>

        <div style={{
          padding: '10px 20px', background: 'white', borderBottom: '1px solid #e8e0d5',
          display: 'flex', alignItems: 'center', gap: 10, flexShrink: 0,
        }}>
          <button
            onClick={() => setSidebarCollapsed(p => !p)}
            style={{ background: 'none', border: 'none', cursor: 'pointer', padding: 6, borderRadius: 6, color: '#6b7280', fontSize: 18 }}
            title={sidebarCollapsed ? 'Show history' : 'Hide history'}
          >☰</button>
          <span style={{ fontSize: 22 }}>🌾</span>
          <div>
            <div style={{ fontFamily: 'Georgia,serif', fontWeight: 700, fontSize: 17, color: '#2c1a0e' }}>Saige</div>
            <div style={{ fontSize: 11, color: '#8b7355' }}>AI Agricultural Assistant — crops, livestock, soil, weather & more</div>
          </div>
        </div>

        <div style={{ flex: 1, display: 'flex', overflow: 'hidden', background: '#0f172a' }}>
          <ChatSidebar
            threads={threads}
            activeThreadId={activeThreadId}
            isCollapsed={sidebarCollapsed}
            isLoading={threadsLoading}
            onToggle={() => setSidebarCollapsed(p => !p)}
            onSelect={handleSelectThread}
            onDelete={handleDeleteThread}
            onNewChat={handleNewChat}
          />

          <div style={{ flex: 1, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
            <div style={{ flex: 1, overflowY: 'auto', padding: '20px 24px 8px' }}>
              {activeChat.map((msg, i) => <ChatBubble key={i} message={msg} />)}
              {isThinking && <ThinkingDots stage={processingStage} />}
              {quiz && !isThinking && (
                <QuizCard
                  quiz={quiz}
                  selectedOption={selectedOption}
                  customAnswer={customAnswer}
                  onOptionChange={setSelectedOption}
                  onCustomChange={setCustomAnswer}
                  onSubmit={handleSubmitQuiz}
                />
              )}
            </div>


            {!quiz && !isThinking && (
              <div style={{ padding: '12px 20px 16px', borderTop: '1px solid #1e293b', background: '#0f172a' }}>
                <div style={{ display: 'flex', gap: 10, maxWidth: 800, margin: '0 auto' }}>
                  <input
                    ref={inputRef}
                    value={input}
                    onChange={e => setInput(e.target.value)}
                    onKeyDown={e => { if (e.key === 'Enter' && input.trim()) sendMessage(input); }}
                    placeholder="Ask about crops, livestock, weather, soil health..."
                    style={{
                      flex: 1, padding: '11px 16px', borderRadius: 10,
                      background: '#1e293b', border: '1px solid #334155',
                      color: '#f1f5f9', fontSize: 14, outline: 'none',
                    }}
                  />
                  <button
                    onClick={() => input.trim() && sendMessage(input)}
                    disabled={!input.trim()}
                    style={{
                      padding: '11px 18px', borderRadius: 10, border: 'none',
                      background: input.trim() ? 'linear-gradient(135deg,#16a34a,#15803d)' : '#1e293b',
                      color: input.trim() ? 'white' : '#475569',
                      cursor: input.trim() ? 'pointer' : 'not-allowed',
                      fontWeight: 600, fontSize: 14, transition: 'all 0.15s',
                      display: 'flex', alignItems: 'center', gap: 6,
                    }}
                  >
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                    </svg>
                    Send
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      <style>{`@keyframes saige-spin { 100% { transform: rotate(360deg); } }`}</style>
    </AccountLayout>
  );
}