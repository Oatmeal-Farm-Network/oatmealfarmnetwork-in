import React, { useState, useEffect, useRef } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const STORAGE_MIC  = 'lavendir_mic_device_id';
const STORAGE_SPK  = 'lavendir_spk_device_id';
const STORAGE_TTS  = 'lavendir_tts_voice';

export default function AudioSettings() {
  const [searchParams]  = useSearchParams();
  const BusinessID      = searchParams.get('BusinessID');
  const PeopleID        = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);

  const [mics,    setMics]    = useState([]);
  const [spks,    setSpks]    = useState([]);
  const [voices,  setVoices]  = useState([]);
  const [selMic,  setSelMic]  = useState(localStorage.getItem(STORAGE_MIC)  || '');
  const [selSpk,  setSelSpk]  = useState(localStorage.getItem(STORAGE_SPK)  || '');
  const [selVoice,setSelVoice]= useState(localStorage.getItem(STORAGE_TTS)  || '');
  const [micLevel, setMicLevel] = useState(0);
  const [testingMic, setTestingMic] = useState(false);
  const [testingSpk, setTestingSpk] = useState(false);
  const [permError,  setPermError]  = useState('');
  const [saved, setSaved] = useState(false);

  const animRef  = useRef(null);
  const streamRef = useRef(null);
  const analyserRef = useRef(null);

  // Load available devices
  useEffect(() => {
    async function loadDevices() {
      try {
        // Request permission first so labels appear
        await navigator.mediaDevices.getUserMedia({ audio: true }).then(s => s.getTracks().forEach(t => t.stop()));
        const devices = await navigator.mediaDevices.enumerateDevices();
        setMics(devices.filter(d => d.kind === 'audioinput'));
        setSpks(devices.filter(d => d.kind === 'audiooutput'));
        setPermError('');
      } catch (e) {
        setPermError('Microphone permission denied. Please allow microphone access in your browser settings.');
      }
    }
    loadDevices();

    // Load TTS voices
    const loadVoices = () => {
      const v = window.speechSynthesis?.getVoices() || [];
      const enVoices = v.filter(v => v.lang.startsWith('en'));
      setVoices(enVoices);
      if (!localStorage.getItem(STORAGE_TTS) && enVoices.length) {
        const google = enVoices.find(v => v.name.includes('Google US English'));
        setSelVoice(google?.name || enVoices[0]?.name || '');
      }
    };
    loadVoices();
    window.speechSynthesis.onvoiceschanged = loadVoices;
    return () => { window.speechSynthesis.onvoiceschanged = null; };
  }, []);

  // Mic level meter
  const startMicTest = async () => {
    setTestingMic(true);
    setMicLevel(0);
    try {
      const constraints = { audio: selMic ? { deviceId: { exact: selMic } } : true };
      const stream = await navigator.mediaDevices.getUserMedia(constraints);
      streamRef.current = stream;
      const ctx = new AudioContext();
      const src = ctx.createMediaStreamSource(stream);
      const analyser = ctx.createAnalyser();
      analyser.fftSize = 256;
      src.connect(analyser);
      analyserRef.current = analyser;

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

  // Speaker test
  const testSpeaker = async () => {
    setTestingSpk(true);
    try {
      const utt = new SpeechSynthesisUtterance("Hello! This is Lavendir. Your audio is working.");
      if (selVoice) {
        const voice = window.speechSynthesis.getVoices().find(v => v.name === selVoice);
        if (voice) utt.voice = voice;
      }
      utt.lang  = 'en-US';
      utt.rate  = 1.0;
      utt.pitch = 1.0;
      utt.onend = () => setTestingSpk(false);
      window.speechSynthesis.cancel();
      window.speechSynthesis.speak(utt);
    } catch { setTestingSpk(false); }
  };

  const save = () => {
    localStorage.setItem(STORAGE_MIC,  selMic);
    localStorage.setItem(STORAGE_SPK,  selSpk);
    localStorage.setItem(STORAGE_TTS,  selVoice);
    setSaved(true);
    setTimeout(() => setSaved(false), 2500);
  };

  const DeviceSelect = ({ label, value, onChange, options, placeholder }) => (
    <div className="mb-5">
      <label className="block text-sm font-semibold text-gray-700 mb-1">{label}</label>
      <select
        className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-purple-300 bg-white"
        value={value}
        onChange={e => onChange(e.target.value)}
      >
        <option value="">{placeholder}</option>
        {options.map(d => (
          <option key={d.deviceId} value={d.deviceId}>
            {d.label || `Device ${d.deviceId.slice(0, 8)}`}
          </option>
        ))}
      </select>
    </div>
  );

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>
      <div style={{ maxWidth: 680, margin: '0 auto' }}>
        <div className="mb-6">
          <h1 className="text-2xl font-bold text-gray-900 mb-1">Audio Settings</h1>
          <p className="text-sm text-gray-500">Configure microphone and speaker for Lavendir, your AI website assistant.</p>
        </div>

        {permError && (
          <div className="mb-5 bg-red-50 border border-red-200 rounded-xl px-4 py-3 text-sm text-red-700">
            {permError}
          </div>
        )}

        {/* Microphone */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-6 mb-5">
          <div className="flex items-center gap-2 mb-4 pb-3 border-b border-gray-100">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#7C5CBF" strokeWidth="2">
              <path d="M12 1a3 3 0 0 0-3 3v8a3 3 0 0 0 6 0V4a3 3 0 0 0-3-3z"/>
              <path d="M19 10v2a7 7 0 0 1-14 0v-2"/><line x1="12" y1="19" x2="12" y2="23"/><line x1="8" y1="23" x2="16" y2="23"/>
            </svg>
            <h2 className="font-bold text-gray-800">Microphone</h2>
          </div>

          <DeviceSelect
            label="Select Microphone"
            value={selMic}
            onChange={setSelMic}
            options={mics}
            placeholder="System Default"
          />

          {/* Level meter */}
          <div className="mb-4">
            <div className="flex items-center justify-between mb-1.5">
              <span className="text-xs text-gray-500">Input Level</span>
              {testingMic && <span className="text-xs text-purple-600 animate-pulse">● Recording…</span>}
            </div>
            <div className="w-full h-3 bg-gray-100 rounded-full overflow-hidden">
              <div
                className="h-full rounded-full transition-all duration-75"
                style={{
                  width: `${micLevel}%`,
                  background: micLevel > 70 ? '#EF4444' : micLevel > 40 ? '#F59E0B' : '#7C5CBF'
                }}
              />
            </div>
          </div>

          <button
            onClick={testingMic ? stopMicTest : startMicTest}
            className={`px-4 py-2 rounded-xl text-sm font-semibold transition-colors border ${
              testingMic
                ? 'bg-red-50 text-red-600 border-red-200 hover:bg-red-100'
                : 'bg-purple-50 text-purple-700 border-purple-200 hover:bg-purple-100'
            }`}
          >
            {testingMic ? '⏹ Stop Test' : '▶ Test Microphone'}
          </button>
          <p className="text-xs text-gray-400 mt-2">
            Speak into your microphone — the level bar should move. If it doesn't, check your device or browser permissions.
          </p>
        </div>

        {/* Speaker / TTS Voice */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm p-6 mb-5">
          <div className="flex items-center gap-2 mb-4 pb-3 border-b border-gray-100">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#7C5CBF" strokeWidth="2">
              <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/>
              <path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/>
            </svg>
            <h2 className="font-bold text-gray-800">Speaker &amp; Voice</h2>
          </div>

          {spks.length > 0 && (
            <DeviceSelect
              label="Output Device"
              value={selSpk}
              onChange={setSelSpk}
              options={spks}
              placeholder="System Default"
            />
          )}

          <div className="mb-5">
            <label className="block text-sm font-semibold text-gray-700 mb-1">Lavendir's Voice</label>
            <select
              className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-purple-300 bg-white"
              value={selVoice}
              onChange={e => setSelVoice(e.target.value)}
            >
              <option value="">Browser Default</option>
              {voices.map(v => (
                <option key={v.name} value={v.name}>
                  {v.name} {v.name.includes('Google') ? '⭐' : ''}
                </option>
              ))}
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

        {/* Tips */}
        <div className="bg-purple-50 border border-purple-100 rounded-xl p-4 mb-6">
          <p className="text-sm font-semibold text-purple-800 mb-2">Tips for best results with Lavendir</p>
          <ul className="text-xs text-purple-700 space-y-1 list-disc list-inside">
            <li>Use <strong>Google Chrome</strong> for the best voice quality and speech recognition</li>
            <li>Select <strong>Google US English</strong> as the voice for natural-sounding responses</li>
            <li>Use a headset or headphones to prevent echo when voice is enabled</li>
            <li>Click the mic button once to start listening, click again to stop</li>
            <li>If speech recognition stops working, refresh the page and try again</li>
          </ul>
        </div>

        {/* Save */}
        <div className="flex justify-end items-center gap-3">
          <button
            onClick={save}
            className="regsubmit2 px-8 py-2.5 text-sm"
          >
            Save Audio Settings
          </button>
          {saved && (
            <span className="text-sm text-green-600 font-medium animate-pulse">✓ Saved!</span>
          )}
        </div>
      </div>
    </AccountLayout>
  );
}
