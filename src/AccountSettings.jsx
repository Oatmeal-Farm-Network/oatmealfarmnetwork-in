import React, { useState, useEffect, useRef } from 'react';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';
const STORAGE_MIC  = 'lavendir_mic_device_id';
const STORAGE_SPK  = 'lavendir_spk_device_id';
const STORAGE_TTS  = 'lavendir_tts_voice';

// ── Audio helpers ──────────────────────────────────────────────────────────────

function AudioSection() {
  const [mics,      setMics]      = useState([]);
  const [spks,      setSpks]      = useState([]);
  const [voices,    setVoices]    = useState([]);
  const [selMic,    setSelMic]    = useState(localStorage.getItem(STORAGE_MIC)  || '');
  const [selSpk,    setSelSpk]    = useState(localStorage.getItem(STORAGE_SPK)  || '');
  const [selVoice,  setSelVoice]  = useState(localStorage.getItem(STORAGE_TTS)  || '');
  const [micLevel,  setMicLevel]  = useState(0);
  const [testingMic, setTestingMic] = useState(false);
  const [testingSpk, setTestingSpk] = useState(false);
  const [permError,  setPermError]  = useState('');
  const [saved,      setSaved]      = useState(false);

  const animRef    = useRef(null);
  const streamRef  = useRef(null);

  useEffect(() => {
    async function loadDevices() {
      try {
        await navigator.mediaDevices.getUserMedia({ audio: true }).then(s => s.getTracks().forEach(t => t.stop()));
        const devices = await navigator.mediaDevices.enumerateDevices();
        setMics(devices.filter(d => d.kind === 'audioinput'));
        setSpks(devices.filter(d => d.kind === 'audiooutput'));
        setPermError('');
      } catch {
        setPermError('Microphone permission denied. Please allow microphone access in your browser settings.');
      }
    }
    loadDevices();

    const loadVoices = () => {
      const v = window.speechSynthesis?.getVoices() || [];
      const en = v.filter(v => v.lang.startsWith('en'));
      setVoices(en);
      if (!localStorage.getItem(STORAGE_TTS) && en.length) {
        const google = en.find(v => v.name.includes('Google US English'));
        setSelVoice(google?.name || en[0]?.name || '');
      }
    };
    loadVoices();
    window.speechSynthesis.onvoiceschanged = loadVoices;
    return () => { window.speechSynthesis.onvoiceschanged = null; };
  }, []);

  const startMicTest = async () => {
    setTestingMic(true);
    setMicLevel(0);
    try {
      const stream = await navigator.mediaDevices.getUserMedia(
        { audio: selMic ? { deviceId: { exact: selMic } } : true }
      );
      streamRef.current = stream;
      const ctx      = new AudioContext();
      const src      = ctx.createMediaStreamSource(stream);
      const analyser = ctx.createAnalyser();
      analyser.fftSize = 256;
      src.connect(analyser);
      const data = new Uint8Array(analyser.frequencyBinCount);
      const tick = () => {
        analyser.getByteFrequencyData(data);
        const avg = data.reduce((a, b) => a + b, 0) / data.length;
        setMicLevel(Math.min(100, avg * 2.5));
        animRef.current = requestAnimationFrame(tick);
      };
      tick();
    } catch (e) {
      setPermError('Could not access microphone: ' + e.message);
      setTestingMic(false);
    }
  };

  const stopMicTest = () => {
    cancelAnimationFrame(animRef.current);
    streamRef.current?.getTracks().forEach(t => t.stop());
    streamRef.current = null;
    setMicLevel(0);
    setTestingMic(false);
  };

  const testSpeaker = () => {
    setTestingSpk(true);
    const utt = new SpeechSynthesisUtterance('Hello! This is Lavendir. Your audio is working.');
    if (selVoice) {
      const voice = window.speechSynthesis.getVoices().find(v => v.name === selVoice);
      if (voice) utt.voice = voice;
    }
    utt.lang = 'en-US';
    utt.onend = () => setTestingSpk(false);
    window.speechSynthesis.cancel();
    window.speechSynthesis.speak(utt);
  };

  const saveAudio = () => {
    localStorage.setItem(STORAGE_MIC,  selMic);
    localStorage.setItem(STORAGE_SPK,  selSpk);
    localStorage.setItem(STORAGE_TTS,  selVoice);
    setSaved(true);
    setTimeout(() => setSaved(false), 2500);
  };

  const selectClass = 'w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-purple-300 bg-white';

  return (
    <div>
      <h2 className="text-xl font-bold text-gray-800 mb-1">Audio Settings</h2>
      <p className="text-sm text-gray-500 mb-5">Configure microphone and speaker for Lavendir, your AI website assistant.</p>

      {permError && (
        <div className="mb-5 bg-red-50 border border-red-200 rounded-xl px-4 py-3 text-sm text-red-700">{permError}</div>
      )}

      {/* Microphone */}
      <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-6 mb-5">
        <div className="flex items-center gap-2 mb-4 pb-3 border-b border-gray-100">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#7C5CBF" strokeWidth="2">
            <path d="M12 1a3 3 0 0 0-3 3v8a3 3 0 0 0 6 0V4a3 3 0 0 0-3-3z"/>
            <path d="M19 10v2a7 7 0 0 1-14 0v-2"/><line x1="12" y1="19" x2="12" y2="23"/><line x1="8" y1="23" x2="16" y2="23"/>
          </svg>
          <h3 className="font-bold text-gray-800">Microphone</h3>
        </div>

        <div className="mb-5">
          <label className="block text-sm font-semibold text-gray-700 mb-1">Select Microphone</label>
          <select className={selectClass} value={selMic} onChange={e => setSelMic(e.target.value)}>
            <option value="">System Default</option>
            {mics.map(d => <option key={d.deviceId} value={d.deviceId}>{d.label || `Device ${d.deviceId.slice(0, 8)}`}</option>)}
          </select>
        </div>

        <div className="mb-4">
          <div className="flex items-center justify-between mb-1.5">
            <span className="text-xs text-gray-500">Input Level</span>
            {testingMic && <span className="text-xs text-purple-600 animate-pulse">● Recording…</span>}
          </div>
          <div className="w-full h-3 bg-gray-100 rounded-full overflow-hidden">
            <div className="h-full rounded-full transition-all duration-75"
              style={{ width: `${micLevel}%`, background: micLevel > 70 ? '#EF4444' : micLevel > 40 ? '#F59E0B' : '#7C5CBF' }} />
          </div>
        </div>

        <button
          onClick={testingMic ? stopMicTest : startMicTest}
          className={`px-4 py-2 rounded-xl text-sm font-semibold border transition-colors ${
            testingMic ? 'bg-red-50 text-red-600 border-red-200 hover:bg-red-100'
                       : 'bg-purple-50 text-purple-700 border-purple-200 hover:bg-purple-100'}`}
        >
          {testingMic ? '⏹ Stop Test' : '▶ Test Microphone'}
        </button>
        <p className="text-xs text-gray-400 mt-2">Speak into your microphone — the level bar should move.</p>
      </div>

      {/* Speaker & Voice */}
      <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-6 mb-5">
        <div className="flex items-center gap-2 mb-4 pb-3 border-b border-gray-100">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#7C5CBF" strokeWidth="2">
            <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/>
            <path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/>
          </svg>
          <h3 className="font-bold text-gray-800">Speaker &amp; Voice</h3>
        </div>

        {spks.length > 0 && (
          <div className="mb-5">
            <label className="block text-sm font-semibold text-gray-700 mb-1">Output Device</label>
            <select className={selectClass} value={selSpk} onChange={e => setSelSpk(e.target.value)}>
              <option value="">System Default</option>
              {spks.map(d => <option key={d.deviceId} value={d.deviceId}>{d.label || `Device ${d.deviceId.slice(0, 8)}`}</option>)}
            </select>
          </div>
        )}

        <div className="mb-5">
          <label className="block text-sm font-semibold text-gray-700 mb-1">Lavendir's Voice</label>
          <select className={selectClass} value={selVoice} onChange={e => setSelVoice(e.target.value)}>
            <option value="">Browser Default</option>
            {voices.map(v => <option key={v.name} value={v.name}>{v.name}{v.name.includes('Google') ? ' ⭐' : ''}</option>)}
          </select>
          <p className="text-xs text-gray-400 mt-1">Voices marked ⭐ are high-quality Google voices (Chrome only).</p>
        </div>

        <button
          onClick={testSpeaker}
          disabled={testingSpk}
          className="px-4 py-2 rounded-xl text-sm font-semibold bg-purple-50 text-purple-700 border border-purple-200 hover:bg-purple-100 transition-colors disabled:opacity-50"
        >
          {testingSpk ? '🔊 Playing…' : '▶ Test Speaker'}
        </button>
      </div>

      <div className="bg-purple-50 border border-purple-100 rounded-xl p-4 mb-6">
        <p className="text-sm font-semibold text-purple-800 mb-2">Tips for best results with Lavendir</p>
        <ul className="text-xs text-purple-700 space-y-1 list-disc list-inside">
          <li>Use <strong>Google Chrome</strong> for the best voice quality and speech recognition</li>
          <li>Select <strong>Google US English</strong> as the voice for natural-sounding responses</li>
          <li>Use a headset to prevent echo when voice is enabled</li>
        </ul>
      </div>

      <div className="flex items-center gap-3">
        <button onClick={saveAudio} className="regsubmit2 px-8 py-2.5 text-sm">
          Save Audio Settings
        </button>
        {saved && <span className="text-sm text-green-600 font-medium animate-pulse">✓ Saved!</span>}
      </div>
    </div>
  );
}

// ── Login info section ─────────────────────────────────────────────────────────

function LoginSection() {
  const [form,    setForm]    = useState({ first_name: '', last_name: '', email: '', current_password: '', new_password: '', confirm_password: '' });
  const [loading, setLoading] = useState(true);
  const [saving,  setSaving]  = useState(false);
  const [success, setSuccess] = useState('');
  const [error,   setError]   = useState('');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    fetch(`${API_URL}/auth/me`, { headers: { Authorization: `Bearer ${token}` } })
      .then(r => r.ok ? r.json() : null)
      .then(data => {
        if (data) setForm(f => ({
          ...f,
          first_name: data.PeopleFirstName || '',
          last_name:  data.PeopleLastName  || '',
          email:      data.PeopleEmail     || '',
        }));
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, []);

  const update = (field, value) => {
    setForm(f => ({ ...f, [field]: value }));
    setSuccess('');
    setError('');
  };

  const handleSave = async () => {
    if (form.new_password && form.new_password !== form.confirm_password) {
      setError('New passwords do not match.');
      return;
    }
    if (form.new_password && !form.current_password) {
      setError('Please enter your current password to set a new one.');
      return;
    }
    setSaving(true);
    setError('');
    setSuccess('');
    try {
      const token = localStorage.getItem('access_token');
      const payload = {
        first_name: form.first_name,
        last_name:  form.last_name,
        email:      form.email,
      };
      if (form.new_password) {
        payload.current_password = form.current_password;
        payload.new_password     = form.new_password;
      }
      const res = await fetch(`${API_URL}/auth/update-login`, {
        method:  'PUT',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
        body:    JSON.stringify(payload),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.detail || 'An error occurred.');
      } else {
        setSuccess('Settings saved successfully.');
        localStorage.setItem('first_name', data.PeopleFirstName);
        localStorage.setItem('last_name',  data.PeopleLastName);
        setForm(f => ({ ...f, current_password: '', new_password: '', confirm_password: '' }));
      }
    } catch {
      setError('An error occurred. Please try again.');
    } finally {
      setSaving(false);
    }
  };

  const inputClass = 'w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-[#819360] focus:ring-1 focus:ring-[#819360]';
  const labelClass = 'block text-sm font-medium text-gray-600 mb-1';

  if (loading) return <div className="text-gray-400 text-sm py-4">Loading…</div>;

  return (
    <div>
      <h2 className="text-xl font-bold text-gray-800 mb-1">Login &amp; Account</h2>
      <p className="text-sm text-gray-500 mb-5">Update your name, email address, or password.</p>

      {success && (
        <div className="mb-5 bg-green-50 border border-green-300 text-green-700 rounded-lg px-4 py-3 text-sm">{success}</div>
      )}
      {error && (
        <div className="mb-5 bg-red-50 border border-red-300 text-red-700 rounded-lg px-4 py-3 text-sm">{error}</div>
      )}

      <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-6 mb-5 space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className={labelClass}>First Name</label>
            <input type="text" className={inputClass} value={form.first_name} onChange={e => update('first_name', e.target.value)} />
          </div>
          <div>
            <label className={labelClass}>Last Name</label>
            <input type="text" className={inputClass} value={form.last_name} onChange={e => update('last_name', e.target.value)} />
          </div>
        </div>
        <div>
          <label className={labelClass}>Email Address</label>
          <input type="email" className={inputClass} value={form.email} onChange={e => update('email', e.target.value)} />
        </div>
      </div>

      <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-6 mb-6 space-y-4">
        <p className="text-sm font-semibold text-gray-700">Change Password <span className="font-normal text-gray-400">(leave blank to keep current password)</span></p>
        <div>
          <label className={labelClass}>Current Password</label>
          <input type="password" className={inputClass} value={form.current_password} onChange={e => update('current_password', e.target.value)} autoComplete="current-password" />
        </div>
        <div>
          <label className={labelClass}>New Password</label>
          <input type="password" className={inputClass} value={form.new_password} onChange={e => update('new_password', e.target.value)} autoComplete="new-password" />
        </div>
        <div>
          <label className={labelClass}>Confirm New Password</label>
          <input type="password" className={inputClass} value={form.confirm_password} onChange={e => update('confirm_password', e.target.value)} autoComplete="new-password" />
        </div>
      </div>

      <div className="flex items-center gap-3">
        <button onClick={handleSave} disabled={saving} className="regsubmit2 px-8 py-2.5 text-sm disabled:opacity-60">
          {saving ? 'Saving…' : 'Save Login Settings'}
        </button>
        {success && <span className="text-sm text-green-600 font-medium animate-pulse">✓ Saved!</span>}
      </div>
    </div>
  );
}

// ── Main page ──────────────────────────────────────────────────────────────────

const TABS = ['Login & Account', 'Audio Settings'];

export default function AccountSettings() {
  const { Business, LoadBusiness } = useAccount();
  const PeopleID  = localStorage.getItem('people_id');
  const [tab, setTab] = useState('Login & Account');

  return (
    <AccountLayout Business={Business} BusinessID={null} PeopleID={PeopleID} pageTitle="Settings" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Settings' }]}>
      <div style={{ maxWidth: 680, margin: '0 auto' }}>

        <div className="mb-6">
          <h1 className="text-2xl font-bold text-gray-900 mb-1">Settings</h1>
          <p className="text-sm text-gray-500">Manage your login information and audio preferences.</p>
        </div>

        {/* Tab bar */}
        <div className="flex gap-1 mb-6 bg-gray-100 rounded-xl p-1 w-fit">
          {TABS.map(t => (
            <button
              key={t}
              onClick={() => setTab(t)}
              className={`px-4 py-2 rounded-lg text-sm font-semibold transition-colors ${
                tab === t ? 'bg-white text-gray-900 shadow-sm' : 'text-gray-500 hover:text-gray-700'
              }`}
            >
              {t}
            </button>
          ))}
        </div>

        {tab === 'Login & Account' && <LoginSection />}
        {tab === 'Audio Settings'  && <AudioSection />}

      </div>
    </AccountLayout>
  );
}
