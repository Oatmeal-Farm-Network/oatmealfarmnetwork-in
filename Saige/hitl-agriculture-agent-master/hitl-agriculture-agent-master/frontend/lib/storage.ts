import type { Message, Quiz, ThreadSummary } from './types';

const THREADS_KEY = 'charlie_threads';
const MESSAGES_PREFIX = 'charlie_messages_';
const QUIZ_PREFIX = 'charlie_quiz_';

interface StoredThread {
  thread_id: string;
  preview: string;
  status: string;
  advisory_type: string | null;
  updated_at: string;
}

/** Save (or update) a thread and its messages in localStorage */
export function saveThread(
  threadId: string,
  messages: Message[],
  status: string,
  advisoryType: string | null
): void {
  try {
    // Save messages
    localStorage.setItem(MESSAGES_PREFIX + threadId, JSON.stringify(messages));

    // Update thread index
    const threads = getStoredThreads();
    const preview =
      messages
        .filter((m) => m.role === 'user')
        .pop()?.content?.slice(0, 80) || 'New conversation';

    const existing = threads.findIndex((t) => t.thread_id === threadId);
    const entry: StoredThread = {
      thread_id: threadId,
      preview,
      status,
      advisory_type: advisoryType,
      updated_at: new Date().toISOString(),
    };

    if (existing >= 0) {
      threads[existing] = entry;
    } else {
      threads.unshift(entry);
    }

    localStorage.setItem(THREADS_KEY, JSON.stringify(threads));
  } catch (err) {
    console.warn('Failed to save thread to localStorage', err);
  }
}

/** Get all thread summaries from localStorage */
export function getLocalThreads(): ThreadSummary[] {
  return getStoredThreads();
}

/** Get messages for a specific thread from localStorage */
export function getLocalMessages(threadId: string): Message[] {
  try {
    const raw = localStorage.getItem(MESSAGES_PREFIX + threadId);
    if (!raw) return [];
    return JSON.parse(raw) as Message[];
  } catch {
    return [];
  }
}

/** Save the active quiz state for a thread */
export function saveQuiz(threadId: string, quiz: Quiz | null): void {
  try {
    if (quiz) {
      localStorage.setItem(QUIZ_PREFIX + threadId, JSON.stringify(quiz));
    } else {
      localStorage.removeItem(QUIZ_PREFIX + threadId);
    }
  } catch (err) {
    console.warn('Failed to save quiz to localStorage', err);
  }
}

/** Get the saved quiz state for a thread */
export function getLocalQuiz(threadId: string): Quiz | null {
  try {
    const raw = localStorage.getItem(QUIZ_PREFIX + threadId);
    if (!raw) return null;
    return JSON.parse(raw) as Quiz;
  } catch {
    return null;
  }
}

/** Delete a thread and its messages from localStorage */
export function deleteLocalThread(threadId: string): void {
  try {
    localStorage.removeItem(MESSAGES_PREFIX + threadId);
    localStorage.removeItem(QUIZ_PREFIX + threadId);

    const threads = getStoredThreads().filter((t) => t.thread_id !== threadId);
    localStorage.setItem(THREADS_KEY, JSON.stringify(threads));
  } catch (err) {
    console.warn('Failed to delete thread from localStorage', err);
  }
}

// ---- internal helper ----

function getStoredThreads(): StoredThread[] {
  try {
    const raw = localStorage.getItem(THREADS_KEY);
    if (!raw) return [];
    return JSON.parse(raw) as StoredThread[];
  } catch {
    return [];
  }
}

