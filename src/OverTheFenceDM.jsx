import React, { useState, useEffect, useRef, useCallback } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const OTF_API = import.meta.env.VITE_OTF_API_URL || import.meta.env.VITE_API_URL || '';
const MILL    = `${OTF_API}/api/admin/mill`;
const POLL_MS = 5000;
const NAV_BG  = '#516234';   // sidebar header + primary buttons

function authHeaders() {
  const token = localStorage.getItem('access_token') || '';
  const pid   = localStorage.getItem('people_id')    || '';
  const lvl   = localStorage.getItem('access_level') || '0';
  return { 'Content-Type': 'application/json', Authorization: `Bearer ${token}`, 'x-people-id': pid, 'x-access-level': lvl };
}
const ME = () => parseInt(localStorage.getItem('people_id') || '0', 10);

function fmtTime(iso) {
  if (!iso) return '';
  const d   = new Date(iso);
  const now = new Date();
  if (d.toDateString() === now.toDateString())
    return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  return d.toLocaleDateString([], { month: 'short', day: 'numeric' });
}

function chanName(ch) {
  if (!ch) return '';
  if (ch.ChannelType === 'group_dm') return ch.Name || ch.DmPartnerNames || 'Group OTF DM';
  if (ch.ChannelType === 'dm')       return ch.DmPartnerNames || 'OTF DM';
  return `#${ch.Name}`;
}

// ── Login gate ────────────────────────────────────────────────────────────────
function LoginGate() {
  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <Header />
      <div className="max-w-md mx-auto px-4 py-20 text-center">
        <img
          src="/images/Over-the-Fence-LogIcon.webp"
          alt="Over The Fence DM"
          className="mx-auto mb-4 rounded-xl"
          style={{ height: 64, width: 'auto', objectFit: 'contain' }}
          onError={e => { e.target.style.display = 'none'; }}
        />
        <h1 className="font-bold text-2xl text-gray-900 mb-2" style={{ fontFamily: "'Lora','Times New Roman',serif" }}>
          Over The Fence DM
        </h1>
        <p className="text-gray-600 mb-6">You need to be logged in to send and receive messages.</p>
        <div className="flex gap-3 justify-center">
          <Link to="/login"  className="px-5 py-2.5 rounded-lg text-white font-bold text-sm shadow" style={{ backgroundColor: NAV_BG }}>Sign In</Link>
          <Link to="/signup" className="px-5 py-2.5 rounded-lg font-bold border-2 text-sm" style={{ color: NAV_BG, borderColor: NAV_BG }}>Create Account</Link>
        </div>
      </div>
      <Footer />
    </div>
  );
}

// ── Main page ─────────────────────────────────────────────────────────────────
export default function OverTheFenceDM() {
  const token = localStorage.getItem('access_token');
  if (!token) return <LoginGate />;
  return <DMApp />;
}

function DMApp() {
  const [channels,   setChannels]   = useState([]);
  const [active,     setActive]     = useState(null);
  const [messages,   setMessages]   = useState([]);
  const [body,       setBody]       = useState('');
  const [sending,    setSending]    = useState(false);
  const [showNew,    setShowNew]    = useState(false);
  const [people,     setPeople]     = useState([]);
  const [search,     setSearch]     = useState('');
  const [selected,   setSelected]   = useState([]);
  const [loadingMsg, setLoadingMsg] = useState(false);
  const bottomRef = useRef(null);
  const pollRef   = useRef(null);

  const loadChannels = useCallback(async () => {
    try {
      const r    = await fetch(`${MILL}/channels`, { headers: authHeaders() });
      if (!r.ok) return;
      const data = await r.json();
      const list = (data.channels || data || [])
        .filter(c => c.ChannelType === 'dm' || c.ChannelType === 'group_dm')
        .sort((a, b) => new Date(b.LastMessageAt || 0) - new Date(a.LastMessageAt || 0));
      setChannels(list);
    } catch {}
  }, []);

  const loadMessages = useCallback(async (channelId) => {
    if (!channelId) return;
    try {
      const r    = await fetch(`${MILL}/channels/${channelId}/messages`, { headers: authHeaders() });
      if (!r.ok) return;
      const data = await r.json();
      setMessages(data.messages || data || []);
    } catch {}
  }, []);

  useEffect(() => { loadChannels(); }, [loadChannels]);

  useEffect(() => {
    pollRef.current = setInterval(() => {
      loadChannels();
      if (active) loadMessages(active.ChannelID);
    }, POLL_MS);
    return () => clearInterval(pollRef.current);
  }, [active, loadChannels, loadMessages]);

  useEffect(() => {
    if (!active) { setMessages([]); return; }
    setLoadingMsg(true);
    loadMessages(active.ChannelID).finally(() => setLoadingMsg(false));
  }, [active, loadMessages]);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const sendMessage = async (e) => {
    e.preventDefault();
    if (!body.trim() || !active || sending) return;
    setSending(true);
    try {
      const r = await fetch(`${MILL}/channels/${active.ChannelID}/messages`, {
        method: 'POST', headers: authHeaders(),
        body: JSON.stringify({ body: body.trim() }),
      });
      if (r.ok) {
        setBody('');
        await loadMessages(active.ChannelID);
        await loadChannels();
      }
    } catch {}
    setSending(false);
  };

  const loadPeople = async () => {
    try {
      const r = await fetch(`${OTF_API}/api/admin/mill/people`, { headers: authHeaders() });
      if (r.ok) { const d = await r.json(); setPeople(d.people || d || []); }
    } catch {}
  };

  const startDM = async () => {
    if (!selected.length) return;
    try {
      const endpoint    = selected.length === 1 ? `${MILL}/dm` : `${MILL}/group-dm`;
      const bodyPayload = selected.length === 1
        ? { targetPeopleId: selected[0].PeopleID }
        : { memberIds: selected.map(p => p.PeopleID), name: selected.map(p => p.Name.split(' ')[0]).join(', ') };
      const r = await fetch(endpoint, { method: 'POST', headers: authHeaders(), body: JSON.stringify(bodyPayload) });
      if (r.ok) {
        const data = await r.json();
        setShowNew(false); setSelected([]); setSearch('');
        await loadChannels();
        setActive(data.channel || data);
      }
    } catch {}
  };

  const filtered = people.filter(p =>
    p.PeopleID !== ME() && (p.Name || '').toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="font-sans flex flex-col" style={{ backgroundColor: '#f7f2e8', height: '100vh' }}>
      <PageMeta
        title="Over The Fence DM | Oatmeal Farm Network"
        description="Private messages with anyone on the Oatmeal Farm Network."
      />
      <Header />

      {/* Main chat layout — fills the remaining viewport below the fixed header */}
      <div className="flex flex-1 overflow-hidden" style={{ paddingTop: 72 }}>
        <div className="flex w-full overflow-hidden" style={{ height: 'calc(100vh - 72px)' }}>

          {/* ── Left panel: conversation list ──────────────────────── */}
          <div
            className="flex flex-col border-r border-gray-200 bg-white shrink-0"
            style={{ width: 300, minWidth: 260 }}
          >
            {/* Panel header */}
            <div
              className="flex items-center justify-between px-4 py-3 shrink-0"
              style={{ backgroundColor: NAV_BG }}
            >
              <div className="flex items-center gap-2 min-w-0">
                <img
                  src="/images/Over-the-Fence-LogIcon.webp"
                  alt="Over The Fence DM"
                  style={{ height: 28, width: 'auto', objectFit: 'contain', borderRadius: 6, flexShrink: 0 }}
                  onError={e => { e.target.style.display = 'none'; }}
                />
                <span className="text-white font-bold text-sm truncate">Over The Fence DM</span>
              </div>
              <button
                onClick={() => { setShowNew(true); loadPeople(); }}
                title="New OTF DM"
                className="text-white hover:bg-white/20 rounded-full p-1 transition shrink-0 ml-2"
              >
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                  <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
              </button>
            </div>

            {/* Channel list */}
            <div className="flex-1 overflow-y-auto">
              {channels.length === 0 && (
                <div className="px-4 py-8 text-center text-sm text-gray-400">
                  <p>No messages yet.</p>
                  <button
                    onClick={() => { setShowNew(true); loadPeople(); }}
                    className="mt-3 text-xs font-bold underline"
                    style={{ color: NAV_BG }}
                  >
                    Start a conversation
                  </button>
                </div>
              )}
              {channels.map(ch => (
                <button
                  key={ch.ChannelID}
                  onClick={() => setActive(ch)}
                  className="w-full text-left px-4 py-3 flex items-start gap-3 hover:bg-gray-50 transition border-b border-gray-50"
                  style={active?.ChannelID === ch.ChannelID ? { backgroundColor: '#e9edef' } : {}}
                >
                  <div
                    className="w-10 h-10 rounded-full flex items-center justify-center text-white font-bold text-sm shrink-0"
                    style={{ backgroundColor: NAV_BG }}
                  >
                    {(chanName(ch) || '?')[0].toUpperCase()}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex justify-between items-baseline">
                      <span className="font-semibold text-sm text-gray-900 truncate">{chanName(ch)}</span>
                      <span className="text-[10px] text-gray-400 shrink-0 ml-2">{fmtTime(ch.LastMessageAt)}</span>
                    </div>
                    <div className="text-xs text-gray-500 truncate">{ch.LastMessage || ''}</div>
                  </div>
                  {ch.UnreadCount > 0 && (
                    <span
                      className="rounded-full text-[10px] font-bold text-white shrink-0"
                      style={{ backgroundColor: '#25d366', minWidth: 18, padding: '2px 6px', textAlign: 'center' }}
                    >
                      {ch.UnreadCount}
                    </span>
                  )}
                </button>
              ))}
            </div>
          </div>

          {/* ── Right panel: message thread ─────────────────────────── */}
          <div className="flex flex-col flex-1 overflow-hidden">
            {!active ? (
              /* Empty state */
              <div
                className="flex-1 flex flex-col items-center justify-center text-center p-8"
                style={{ backgroundColor: '#efeae2' }}
              >
                <img
                  src="/images/Over-the-Fence-LogIcon.webp"
                  alt="Over The Fence DM"
                  className="mx-auto mb-4 opacity-60"
                  style={{ height: 72, width: 'auto', objectFit: 'contain' }}
                  onError={e => { e.target.style.display = 'none'; }}
                />
                <h2
                  className="font-bold text-xl text-gray-700 mb-2"
                  style={{ fontFamily: "'Lora','Times New Roman',serif" }}
                >
                  Over The Fence DM
                </h2>
                <p className="text-gray-500 text-sm max-w-xs">
                  Select a conversation or start a new one. Messages are shared across all Oatmeal Farm Network sites.
                </p>
                <button
                  onClick={() => { setShowNew(true); loadPeople(); }}
                  className="mt-5 px-5 py-2.5 rounded-lg text-white font-bold text-sm"
                  style={{ backgroundColor: NAV_BG }}
                >
                  New OTF DM
                </button>
              </div>
            ) : (
              <>
                {/* Thread header */}
                <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-200 bg-white shrink-0">
                  <div
                    className="w-9 h-9 rounded-full flex items-center justify-center text-white font-bold text-sm shrink-0"
                    style={{ backgroundColor: NAV_BG }}
                  >
                    {(chanName(active) || '?')[0].toUpperCase()}
                  </div>
                  <div>
                    <div className="font-semibold text-sm text-gray-900">{chanName(active)}</div>
                    <div className="text-xs text-gray-500">Private conversation</div>
                  </div>
                </div>

                {/* Messages */}
                <div
                  className="flex-1 overflow-y-auto px-4 py-4 space-y-2"
                  style={{ backgroundColor: '#efeae2' }}
                >
                  {loadingMsg && <div className="text-center text-xs text-gray-400 py-4">Loading…</div>}
                  {messages.map(msg => {
                    const mine = msg.SenderID === ME();
                    return (
                      <div key={msg.MessageID} className={`flex ${mine ? 'justify-end' : 'justify-start'}`}>
                        <div className="max-w-[72%]">
                          {!mine && (
                            <div className="text-[10px] font-semibold mb-0.5 ml-1" style={{ color: NAV_BG }}>
                              {msg.SenderName}
                            </div>
                          )}
                          <div
                            className="px-3 py-2 text-sm shadow-sm"
                            style={{
                              backgroundColor: mine ? '#d9fdd3' : '#ffffff',
                              color: '#111b21',
                              borderRadius: mine ? '12px 4px 12px 12px' : '4px 12px 12px 12px',
                            }}
                          >
                            {msg.IsDeleted ? <em className="text-gray-400">Message deleted</em> : msg.Body}
                          </div>
                          <div className={`text-[10px] text-gray-400 mt-0.5 ${mine ? 'text-right mr-1' : 'ml-1'}`}>
                            {fmtTime(msg.CreatedAt)}
                          </div>
                        </div>
                      </div>
                    );
                  })}
                  <div ref={bottomRef} />
                </div>

                {/* Message input */}
                <form onSubmit={sendMessage} className="px-4 py-3 flex gap-2 bg-white border-t border-gray-200 shrink-0">
                  <input
                    className="flex-1 border border-gray-200 rounded-full px-4 py-2 text-sm focus:outline-none"
                    style={{ backgroundColor: '#f0f2f5' }}
                    placeholder="Message…"
                    value={body}
                    onChange={e => setBody(e.target.value)}
                  />
                  <button
                    type="submit"
                    disabled={!body.trim() || sending}
                    className="w-9 h-9 rounded-full flex items-center justify-center text-white transition disabled:opacity-40 shrink-0"
                    style={{ backgroundColor: NAV_BG }}
                  >
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                      <line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/>
                    </svg>
                  </button>
                </form>
              </>
            )}
          </div>
        </div>
      </div>

      {/* ── New DM modal ─────────────────────────────────────────────── */}
      {showNew && (
        <div className="fixed inset-0 z-50 flex items-center justify-center" style={{ backgroundColor: 'rgba(0,0,0,0.45)' }}>
          <div className="bg-white rounded-xl shadow-xl w-full max-w-sm mx-4 overflow-hidden">
            {/* Modal header */}
            <div
              className="flex items-center justify-between px-4 py-3"
              style={{ backgroundColor: NAV_BG }}
            >
              <span className="text-white font-bold text-sm">New Over The Fence DM</span>
              <button
                onClick={() => { setShowNew(false); setSelected([]); setSearch(''); }}
                className="text-white hover:bg-white/20 rounded-full p-1"
              >
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                  <line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/>
                </svg>
              </button>
            </div>

            <div className="p-4">
              <input
                className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm mb-3 focus:outline-none focus:border-green-700"
                placeholder="Search people…"
                value={search}
                onChange={e => setSearch(e.target.value)}
              />

              {selected.length > 0 && (
                <div className="flex flex-wrap gap-1 mb-3">
                  {selected.map(p => (
                    <span
                      key={p.PeopleID}
                      className="flex items-center gap-1 text-xs rounded-full px-2 py-0.5"
                      style={{ backgroundColor: '#e8f0e4', color: NAV_BG }}
                    >
                      {p.Name}
                      <button
                        onClick={() => setSelected(s => s.filter(x => x.PeopleID !== p.PeopleID))}
                        className="hover:text-red-600"
                      >
                        ×
                      </button>
                    </span>
                  ))}
                </div>
              )}

              <div className="max-h-52 overflow-y-auto border border-gray-100 rounded-lg divide-y divide-gray-50">
                {filtered.length === 0 && (
                  <div className="px-3 py-3 text-sm text-gray-400 text-center">No results</div>
                )}
                {filtered.slice(0, 20).map(p => {
                  const sel = selected.some(s => s.PeopleID === p.PeopleID);
                  return (
                    <button
                      key={p.PeopleID}
                      onClick={() => setSelected(s => sel ? s.filter(x => x.PeopleID !== p.PeopleID) : [...s, p])}
                      className="w-full text-left px-3 py-2 flex items-center gap-2 text-sm hover:bg-gray-50 transition"
                      style={sel ? { backgroundColor: '#e8f0e4' } : {}}
                    >
                      <div
                        className="w-7 h-7 rounded-full flex items-center justify-center text-white text-xs font-bold shrink-0"
                        style={{ backgroundColor: NAV_BG }}
                      >
                        {(p.Name || '?')[0].toUpperCase()}
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="font-medium truncate">{p.Name}</div>
                        {p.TeamCompany && <div className="text-xs text-gray-400 truncate">{p.TeamCompany}</div>}
                      </div>
                      {sel && (
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={NAV_BG} strokeWidth="3">
                          <polyline points="20 6 9 17 4 12"/>
                        </svg>
                      )}
                    </button>
                  );
                })}
              </div>

              <button
                onClick={startDM}
                disabled={!selected.length}
                className="w-full mt-3 py-2.5 rounded-lg text-white font-bold text-sm transition disabled:opacity-40"
                style={{ backgroundColor: NAV_BG }}
              >
                Start OTF DM {selected.length > 1 ? '(Group)' : ''}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
