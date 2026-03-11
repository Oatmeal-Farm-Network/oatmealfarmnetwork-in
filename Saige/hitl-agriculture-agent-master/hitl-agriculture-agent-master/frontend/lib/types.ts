export interface Message {
  role: 'user' | 'assistant';
  content: string;
}

export interface Quiz {
  question: string;
  options: string[];
}

export interface ThreadSummary {
  thread_id: string;
  preview: string;
  status: string;
  advisory_type: string | null;
  updated_at: string;
}

