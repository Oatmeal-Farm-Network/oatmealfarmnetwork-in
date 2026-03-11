'use client';

import { useEffect, useState } from 'react';
import type { Message, Quiz } from '@/lib/types';

const STAGE_MESSAGES: Record<string, string[]> = {
  default: [
    '🔍 Analyzing your question...',
    '📋 Assessment in process...',
    '🌱 Growing ideas...',
    '🚜 Harvesting knowledge...',
    '🧑‍🌾 Preparing your advice...',
  ],
  weather: [
    '🌦️ Checking weather conditions...',
    '☀️ Analyzing climate data...',
    '🌧️ Processing weather forecast...',
  ],
  livestock: [
    '🐄 Checking livestock knowledge base...',
    '🐑 Retrieving breed database...',
    '🐓 Consulting veterinary experts...',
  ],
  crops: [
    '🌾 Consulting crop experts...',
    '🌿 Analyzing soil & plant health...',
    '🪴 Processing crop recommendations...',
  ],
  mixed: [
    '🌾🐄 Analyzing integrated farm data...',
    '📋 Processing mixed advisory...',
    '🧑‍🌾 Preparing comprehensive advice...',
  ],
};

interface ChatAreaProps {
  messages: Message[];
  quiz: Quiz | null;
  isThinking: boolean;
  processingStage?: string;
  input: string;
  selectedOption: string;
  customAnswer: string;
  onInputChange: (value: string) => void;
  onSendMessage: (value: string) => void;
  onSubmitQuiz: () => void;
  onSelectedOptionChange: (value: string) => void;
  onCustomAnswerChange: (value: string) => void;
}

export default function ChatArea({
  messages,
  quiz,
  isThinking,
  processingStage = 'default',
  input,
  selectedOption,
  customAnswer,
  onInputChange,
  onSendMessage,
  onSubmitQuiz,
  onSelectedOptionChange,
  onCustomAnswerChange,
}: ChatAreaProps) {
  const [thinkingMessage, setThinkingMessage] = useState('');

  useEffect(() => {
    if (!isThinking) {
      setThinkingMessage('');
      return;
    }
    const msgs = STAGE_MESSAGES[processingStage] || STAGE_MESSAGES['default'];
    let idx = 0;
    setThinkingMessage(msgs[0]);
    const interval = setInterval(() => {
      idx = (idx + 1) % msgs.length;
      setThinkingMessage(msgs[idx]);
    }, 1500);
    return () => clearInterval(interval);
  }, [isThinking, processingStage]);

  return (
    <div className="flex flex-col flex-1 h-full min-w-0">
      {/* Chat messages */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {messages.map((message, index) => (
          <div
            key={index}
            className={`flex ${message.role === 'user' ? 'justify-end' : 'justify-start'}`}
          >
            <div
              className={`max-w-[80%] rounded-lg px-4 py-2 ${
                message.role === 'user'
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-800 text-gray-100'
              }`}
            >
              <p className="whitespace-pre-wrap">{message.content}</p>
            </div>
          </div>
        ))}

        {/* Thinking indicator */}
        {isThinking && (
          <div className="flex justify-start">
            <div className="max-w-[80%] rounded-lg px-4 py-3 bg-gradient-to-r from-gray-800 to-gray-750 text-gray-100 shadow-lg">
              <div className="flex items-center space-x-3">
                <svg
                  className="animate-spin h-5 w-5 text-blue-400"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                  <path
                    className="opacity-75"
                    fill="currentColor"
                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                  />
                </svg>
                <span className="text-sm font-medium text-gray-200 animate-pulse">
                  {thinkingMessage || 'Processing...'}
                </span>
              </div>
            </div>
          </div>
        )}

        {/* Quiz form */}
        {quiz && !isThinking && (
          <div className="flex justify-start">
            <div className="max-w-[80%] rounded-lg px-4 py-4 bg-gray-800 text-gray-100">
              <div className="space-y-4">
                <p className="text-sm text-gray-300 mb-2">{quiz.question}</p>

                <div className="space-y-3">
                  {quiz.options.map((opt: string) => (
                    <label
                      key={opt}
                      className="flex items-center space-x-3 cursor-pointer hover:bg-gray-700 rounded p-2 -m-2"
                    >
                      <input
                        type="radio"
                        name="quiz-option"
                        value={opt}
                        checked={selectedOption === opt}
                        onChange={(e) => {
                          onSelectedOptionChange(e.target.value);
                          onCustomAnswerChange('');
                        }}
                        className="w-4 h-4 text-blue-600 bg-gray-700 border-gray-600 focus:ring-blue-500 focus:ring-2"
                      />
                      <span className="text-sm">{opt}</span>
                    </label>
                  ))}
                </div>

                <div className="pt-2 border-t border-gray-700">
                  <label className="block text-sm text-gray-400 mb-2">
                    Or write your own answer...
                  </label>
                  <input
                    type="text"
                    value={customAnswer}
                    onChange={(e) => {
                      onCustomAnswerChange(e.target.value);
                      onSelectedOptionChange('');
                    }}
                    onKeyDown={(e) => {
                      if (e.key === 'Enter' && (customAnswer.trim() || selectedOption)) {
                        onSubmitQuiz();
                      }
                    }}
                    className="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Type your answer..."
                  />
                </div>

                <button
                  onClick={onSubmitQuiz}
                  disabled={!selectedOption && !customAnswer.trim()}
                  className="w-full px-4 py-2 bg-gray-700 hover:bg-gray-600 disabled:bg-gray-800 disabled:text-gray-500 disabled:cursor-not-allowed rounded transition-colors text-sm font-medium"
                >
                  Submit
                </button>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Input footer */}
      {!quiz && !isThinking && (
        <div className="border-t border-gray-700 p-4">
          <div className="flex items-center space-x-2 max-w-2xl mx-auto">
            <input
              value={input}
              onChange={(e) => onInputChange(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === 'Enter' && input.trim()) {
                  onSendMessage(input);
                }
              }}
              className="flex-1 px-4 py-2 bg-gray-800 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="Type your message..."
            />
            <button
              onClick={() => input.trim() && onSendMessage(input)}
              disabled={!input.trim()}
              className="px-4 py-2 bg-blue-600 hover:bg-blue-700 disabled:bg-gray-700 disabled:text-gray-500 disabled:cursor-not-allowed rounded-lg transition-colors"
              aria-label="Send message"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
              </svg>
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
