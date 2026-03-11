'use client';

import { useState, useEffect, useCallback, useRef } from 'react';
import type { Message, Quiz, ThreadSummary } from '@/lib/types';
import { saveThread, getLocalThreads, getLocalMessages, deleteLocalThread, saveQuiz, getLocalQuiz } from '@/lib/storage';
import Sidebar from './sidebar';
import ChatArea from './chat-area';

const WELCOME_MESSAGE: Message = {
  role: 'assistant',
  content: "Hello! I'm your AI agricultural assistant. How can I help you today?",
};

function generateThreadId() {
  return `thread_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
}

/** Merge API threads with localStorage threads (local fills gaps, API takes priority) */
function mergeThreads(apiThreads: ThreadSummary[], localThreads: ThreadSummary[]): ThreadSummary[] {
  const seen = new Set<string>();
  const merged: ThreadSummary[] = [];

  // API threads first (authoritative)
  for (const t of apiThreads) {
    seen.add(t.thread_id);
    merged.push(t);
  }
  // Local threads that aren't in API
  for (const t of localThreads) {
    if (!seen.has(t.thread_id)) {
      merged.push(t);
    }
  }
  // Sort by most recent
  merged.sort((a, b) => new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime());
  return merged;
}

/** In-memory message cache to avoid redundant Firestore round-trips on repeated switches */
const _msgCache = new Map<string, { messages: Message[]; ts: number }>();

export default function Advisor() {
  // Active conversation state
  const [activeThreadId, setActiveThreadId] = useState('');
  const [activeChat, setActiveChat] = useState<Message[]>([WELCOME_MESSAGE]);
  const [quiz, setQuiz] = useState<Quiz | null>(null);
  const [selectedOption, setSelectedOption] = useState('');
  const [customAnswer, setCustomAnswer] = useState('');
  const [isThinking, setIsThinking] = useState(false);
  const [input, setInput] = useState('');
  const [processingStage, setProcessingStage] = useState<string>('default');

  // Sidebar state
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);
  const [threads, setThreads] = useState<ThreadSummary[]>([]);
  const [threadsLoading, setThreadsLoading] = useState(false);

  // Track last advisory_type for localStorage saves
  const advisoryTypeRef = useRef<string | null>(null);

  // Guard against double-click on thread switch
  const switchingRef = useRef(false);

  // AbortController to cancel stale thread-message fetches during rapid switching
  const abortRef = useRef<AbortController | null>(null);

  // Generate thread ID on mount
  useEffect(() => {
    if (!activeThreadId) {
      setActiveThreadId(generateThreadId());
    }
  }, [activeThreadId]);

  // Collapse sidebar on narrow screens
  useEffect(() => {
    if (window.innerWidth < 768) {
      setSidebarCollapsed(true);
    }
  }, []);

  // Save active chat to localStorage whenever it changes
  useEffect(() => {
    if (activeThreadId && activeChat.length > 0) {
      saveThread(activeThreadId, activeChat, 'active', advisoryTypeRef.current);
    }
  }, [activeThreadId, activeChat]);

  // Persist quiz state whenever it changes
  useEffect(() => {
    if (activeThreadId) {
      saveQuiz(activeThreadId, quiz);
    }
  }, [activeThreadId, quiz]);

  // Fetch thread list — merges API + localStorage
  const fetchThreads = useCallback(async () => {
    setThreadsLoading(true);
    const localThreads = getLocalThreads();
    let apiThreads: ThreadSummary[] = [];

    try {
      const res = await fetch('/api/threads?user_id=anonymous');
      if (res.ok) {
        const data = await res.json();
        apiThreads = data.threads || [];
      }
    } catch {
      // Backend unavailable — localStorage is the only source
    }

    setThreads(mergeThreads(apiThreads, localThreads));
    setThreadsLoading(false);
  }, []);

  // Load threads on mount
  useEffect(() => {
    fetchThreads();
  }, [fetchThreads]);

  // ---- Thread management ----

  async function handleSelectThread(threadId: string) {
    if (threadId === activeThreadId) return;
    if (switchingRef.current) return; // prevent double-click race
    switchingRef.current = true;

    // Abort any in-flight thread-message fetch from a previous switch
    if (abortRef.current) abortRef.current.abort();
    const ctrl = new AbortController();
    abortRef.current = ctrl;

    try {
      let messages: Message[] = [];
      let source = 'none';

      // Use cache if available and < 30s old to avoid redundant API calls
      const cached = _msgCache.get(threadId);
      const cacheAge = cached ? Date.now() - cached.ts : -1;

      if (cached && cacheAge < 30000) {
        messages = cached.messages;
        source = `cache(${messages.length})`;
      } else {
        try {
          const res = await fetch(`/api/threads/${threadId}/messages?user_id=anonymous`, { signal: ctrl.signal });
          if (res.ok) {
            const data = await res.json();
            messages = (data.messages || []).map((m: Record<string, unknown>) => ({
              role: m.role as 'user' | 'assistant',
              content: m.content as string,
            }));
            source = `api(${messages.length})`;
            _msgCache.set(threadId, { messages, ts: Date.now() });
          }
        } catch (e: unknown) {
          if (e instanceof DOMException && e.name === 'AbortError') {
            return; // exit cleanly — a newer switch superseded this one
          }
          source = 'api_error';
        }
      }

      // Fallback to localStorage
      if (messages.length === 0) {
        messages = getLocalMessages(threadId);
        source = `local(${messages.length})`;
      }

      // Restore quiz state for this thread
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

  async function handleDeleteThread(threadId: string) {
    // Delete from localStorage
    deleteLocalThread(threadId);

    // Also try to delete from backend
    try {
      await fetch(`/api/threads/${threadId}?user_id=anonymous`, { method: 'DELETE' });
    } catch {
      // Backend unavailable — local delete is enough
    }

    if (activeThreadId === threadId) {
      setActiveThreadId(generateThreadId());
      setActiveChat([WELCOME_MESSAGE]);
      setQuiz(null);
      setSelectedOption('');
      setCustomAnswer('');
      setInput('');
    }
    fetchThreads();
  }

  function handleNewChat() {
    setActiveThreadId(generateThreadId());
    setActiveChat([WELCOME_MESSAGE]);
    setQuiz(null);
    setSelectedOption('');
    setCustomAnswer('');
    setInput('');
    advisoryTypeRef.current = null;
    setProcessingStage('default');
    fetchThreads();
  }

  // ---- Chat logic ----

  async function sendMessage(val: string, options?: { showUserBubble?: boolean }) {
    if (!activeThreadId) return;

    const showUserBubble = options?.showUserBubble ?? true;
    if (showUserBubble) {
      setActiveChat(prev => [...prev, { role: 'user', content: val }]);
    }

    setInput('');
    // Try to detect stage early from user input for better UX
    const userInputLower = val.toLowerCase();
    let earlyStage = 'default';
    if (userInputLower.includes('weather') || userInputLower.includes('temperature') || userInputLower.includes('forecast') || userInputLower.includes('rain') || userInputLower.includes('climate')) {
      earlyStage = 'weather';
    } else if (userInputLower.includes('cattle') || userInputLower.includes('cow') || userInputLower.includes('sheep') || userInputLower.includes('goat') || userInputLower.includes('livestock') || userInputLower.includes('animal') || userInputLower.includes('breed')) {
      earlyStage = 'livestock';
    } else if (userInputLower.includes('crop') || userInputLower.includes('plant') || userInputLower.includes('wheat') || userInputLower.includes('rice') || userInputLower.includes('corn') || userInputLower.includes('tomato') || userInputLower.includes('guava') || userInputLower.includes('orange')) {
      earlyStage = 'crops';
    }
    setProcessingStage(earlyStage); // Set early stage detection
    setIsThinking(true);
    setQuiz(null);

    try {
      const res = await fetch('/api/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ user_input: val, thread_id: activeThreadId }),
      });

      if (!res.ok) throw new Error(`Server error (${res.status})`);
      const data = await res.json();
      
      // Set processing stage if provided by API (this will update the messages immediately)
      if (data.processing_stage && data.processing_stage !== 'default') {
        setProcessingStage(data.processing_stage);
      }
      // If no stage provided or it's default, keep the early detection we set earlier

      setSelectedOption('');
      setCustomAnswer('');

      if (data.status === 'requires_input') {
        setQuiz(data.ui);
      } else if (data.status === 'complete') {
        let responseContent = '';

        // Check if diagnosis exists and is not empty
        if (data.diagnosis && data.diagnosis.trim()) {
          responseContent = data.diagnosis
            .replace(/\*\*/g, '')
            .replace(/##\s+/g, '')
            .replace(/\*/g, '')
            .trim();
        }

        if (data.recommendations?.length > 0) {
          const hasEmbeddedRecs = data.recommendations.some((rec: string) =>
            responseContent.toLowerCase().includes(rec.toLowerCase().substring(0, 30))
          );
          if (!hasEmbeddedRecs) {
            responseContent += '\n\nQuick Tips:\n';
            data.recommendations.slice(0, 3).forEach((rec: string) => {
              const cleanRec = rec.replace(/\*\*/g, '').replace(/\*/g, '').trim();
              responseContent += `\n${cleanRec}`;
            });
          }
        }

        // Fallback message if response is still empty
        if (!responseContent || !responseContent.trim()) {
          console.warn('[Frontend] Empty response received from API:', data);
          responseContent = data.diagnosis || 'I received your request but encountered an issue generating a response. Please try again.';
        }

        advisoryTypeRef.current = data.advisory_type || null;
        setActiveChat(prev => {
          const updated = [...prev, { role: 'assistant' as const, content: responseContent }];
          // Mark complete in localStorage
          saveThread(activeThreadId, updated, 'complete', data.advisory_type || null);
          return updated;
        });
        fetchThreads();
      } else if (data.status === 'error') {
        setActiveChat(prev => [
          ...prev,
          { role: 'assistant', content: `Sorry, an error occurred: ${data.message || 'Please try again.'}` },
        ]);
      } else {
        setActiveChat(prev => [
          ...prev,
          { role: 'assistant', content: 'Thank you for using the agricultural assistant!' },
        ]);
      }
    } catch (error) {
      console.error('Chat error:', error);
      setActiveChat(prev => [
        ...prev,
        { role: 'assistant', content: 'Sorry, I could not connect to the server. Please make sure the backend is running and try again.' },
      ]);
    } finally {
      setIsThinking(false);
    }
  }

  function handleSubmitQuiz() {
    const answer = customAnswer.trim() || selectedOption;
    if (!answer || !quiz) return;

    const currentQuiz = quiz;
    setActiveChat(prev => [
      ...prev,
      { role: 'assistant', content: `${currentQuiz.question}\n\nAnswer submitted: ${answer}` },
    ]);

    setSelectedOption('');
    setCustomAnswer('');
    sendMessage(answer, { showUserBubble: false });
  }

  // ---- Render ----

  return (
    <div className="relative flex h-screen bg-gray-900 text-white">
      <Sidebar
        threads={threads}
        activeThreadId={activeThreadId}
        isCollapsed={sidebarCollapsed}
        isLoading={threadsLoading}
        onToggle={() => setSidebarCollapsed(prev => !prev)}
        onSelectThread={handleSelectThread}
        onDeleteThread={handleDeleteThread}
        onNewChat={handleNewChat}
      />
      <ChatArea
        messages={activeChat}
        quiz={quiz}
        isThinking={isThinking}
        processingStage={processingStage}
        input={input}
        selectedOption={selectedOption}
        customAnswer={customAnswer}
        onInputChange={setInput}
        onSendMessage={(val) => sendMessage(val)}
        onSubmitQuiz={handleSubmitQuiz}
        onSelectedOptionChange={setSelectedOption}
        onCustomAnswerChange={setCustomAnswer}
      />
    </div>
  );
}
