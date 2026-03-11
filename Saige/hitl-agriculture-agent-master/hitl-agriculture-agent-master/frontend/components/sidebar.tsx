'use client';

import type { ThreadSummary } from '@/lib/types';

interface SidebarProps {
  threads: ThreadSummary[];
  activeThreadId: string;
  isCollapsed: boolean;
  isLoading: boolean;
  onToggle: () => void;
  onSelectThread: (threadId: string) => void;
  onDeleteThread: (threadId: string) => void;
  onNewChat: () => void;
}

function formatRelativeTime(isoString: string): string {
  const now = Date.now();
  const then = new Date(isoString).getTime();
  const diffMs = now - then;
  const diffMin = Math.floor(diffMs / 60000);
  if (diffMin < 1) return 'just now';
  if (diffMin < 60) return `${diffMin}m ago`;
  const diffHr = Math.floor(diffMin / 60);
  if (diffHr < 24) return `${diffHr}h ago`;
  const diffDay = Math.floor(diffHr / 24);
  if (diffDay < 7) return `${diffDay}d ago`;
  const d = new Date(isoString);
  return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
}

const ADVISORY_COLORS: Record<string, string> = {
  weather: 'bg-sky-600/20 text-sky-400',
  livestock: 'bg-amber-600/20 text-amber-400',
  crops: 'bg-green-600/20 text-green-400',
  mixed: 'bg-purple-600/20 text-purple-400',
};

export default function Sidebar({
  threads,
  activeThreadId,
  isCollapsed,
  isLoading,
  onToggle,
  onSelectThread,
  onDeleteThread,
  onNewChat,
}: SidebarProps) {
  return (
    <>
      {/* Toggle button — always visible */}
      <button
        onClick={onToggle}
        className={`absolute top-3 z-20 p-2 rounded-lg bg-gray-800 hover:bg-gray-700 text-gray-400 hover:text-white transition-colors ${
          isCollapsed ? 'left-3' : 'left-[17rem]'
        }`}
        aria-label={isCollapsed ? 'Open sidebar' : 'Close sidebar'}
      >
        {isCollapsed ? (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        ) : (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
          </svg>
        )}
      </button>

      {/* Sidebar panel */}
      <nav
        aria-label="Conversation history"
        className={`flex flex-col h-full border-r border-gray-700 bg-gray-900 transition-all duration-300 ease-in-out ${
          isCollapsed ? 'w-0 min-w-0 overflow-hidden' : 'w-72 min-w-[18rem]'
        }`}
      >
        {/* Header */}
        <div className="flex items-center justify-between px-4 pt-4 pb-2">
          <span className="text-sm font-semibold text-gray-300 truncate">History</span>
        </div>

        {/* New Chat button */}
        <div className="px-3 pb-3">
          <button
            onClick={onNewChat}
            className="w-full flex items-center justify-center gap-2 px-3 py-2 bg-blue-600 hover:bg-blue-700 rounded-lg text-sm font-medium transition-colors"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
            </svg>
            New Chat
          </button>
        </div>

        {/* Thread list */}
        <div className="flex-1 overflow-y-auto px-2 space-y-1">
          {isLoading && threads.length === 0 && (
            <p className="text-center text-gray-500 text-sm py-8">Loading...</p>
          )}

          {!isLoading && threads.length === 0 && (
            <p className="text-center text-gray-500 text-sm py-8 px-2">
              No past conversations yet. Start a new chat to see your history here.
            </p>
          )}

          {threads.map((thread) => {
            const isSelected = thread.thread_id === activeThreadId;
            const badgeColor = thread.advisory_type
              ? ADVISORY_COLORS[thread.advisory_type] || 'bg-gray-600/20 text-gray-400'
              : null;

            return (
              <div
                key={thread.thread_id}
                role="button"
                tabIndex={0}
                onClick={() => onSelectThread(thread.thread_id)}
                onKeyDown={(e) => {
                  if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    onSelectThread(thread.thread_id);
                  }
                }}
                className={`group relative flex flex-col gap-1 px-3 py-2.5 rounded-lg cursor-pointer transition-colors ${
                  isSelected
                    ? 'bg-gray-800 text-white'
                    : 'text-gray-300 hover:bg-gray-800/60'
                }`}
              >
                {/* Preview text */}
                <span className="text-sm truncate pr-6">
                  {thread.preview || 'Empty conversation'}
                </span>

                {/* Metadata row */}
                <div className="flex items-center gap-2 text-xs">
                  {/* Status dot */}
                  <span
                    className={`w-1.5 h-1.5 rounded-full flex-shrink-0 ${
                      thread.status === 'complete' ? 'bg-green-500' : 'bg-yellow-500'
                    }`}
                  />

                  {/* Advisory type badge */}
                  {badgeColor && thread.advisory_type && (
                    <span className={`px-1.5 py-0.5 rounded-full text-[10px] font-medium ${badgeColor}`}>
                      {thread.advisory_type}
                    </span>
                  )}

                  {/* Timestamp */}
                  <span className="text-gray-500 ml-auto">
                    {formatRelativeTime(thread.updated_at)}
                  </span>
                </div>

                {/* Delete button (hover) */}
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    onDeleteThread(thread.thread_id);
                  }}
                  className="absolute top-2.5 right-2 p-1 rounded opacity-0 group-hover:opacity-100 hover:bg-red-600/20 text-gray-500 hover:text-red-400 transition-all"
                  aria-label="Delete thread"
                >
                  <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                  </svg>
                </button>
              </div>
            );
          })}
        </div>
      </nav>
    </>
  );
}
