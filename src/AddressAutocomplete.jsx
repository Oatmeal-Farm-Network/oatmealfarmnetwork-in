import React, { useEffect, useRef, useState } from 'react';
import { INDIA_EXAMPLE_FARMS, matchLocalFarms, searchAddressSuggestions } from './geocoding';

function highlight(text, q) {
  if (!text) return null;
  const token = (q || '').trim().split(',')[0].trim();
  if (!token) return text;
  const i = text.toLowerCase().indexOf(token.toLowerCase());
  if (i < 0) return text;
  return (
    <>
      {text.slice(0, i)}
      <strong>{text.slice(i, i + token.length)}</strong>
      {text.slice(i + token.length)}
    </>
  );
}

const PinIcon = () => (
  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
    <circle cx="12" cy="10" r="3" />
  </svg>
);

/**
 * Google Maps–style India address box: instant farm chips, ranked dropdown,
 * keyboard (↑ ↓ Enter Esc). Works for any village / city / PIN in India.
 */
export default function AddressAutocomplete({
  value,
  onChange,
  onSelect,
  placeholder = 'Search any village, city, or PIN in India',
  variant = 'form',
  autoFocus = false,
}) {
  const [suggestions, setSuggestions] = useState([]);
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [active, setActive] = useState(0);
  const [focused, setFocused] = useState(false);
  const seq = useRef(0);
  const timer = useRef(null);
  const boxRef = useRef(null);
  const isPanel = variant === 'panel';

  useEffect(() => () => { if (timer.current) clearTimeout(timer.current); }, []);

  useEffect(() => {
    const onDoc = (e) => {
      if (boxRef.current && !boxRef.current.contains(e.target)) setOpen(false);
    };
    document.addEventListener('mousedown', onDoc);
    return () => document.removeEventListener('mousedown', onDoc);
  }, []);

  const pick = (sug) => {
    onChange(sug.display_name || sug.name || '');
    setOpen(false);
    setSuggestions([]);
    onSelect(sug);
  };

  const runSearch = (val) => {
    const q = (val || '').trim();
    const local = matchLocalFarms(q);
    if (local.length) {
      setSuggestions(local);
      setOpen(true);
      setActive(0);
    }
    if (q.length < 2) {
      if (!local.length) {
        setSuggestions([]);
        setOpen(false);
      }
      setLoading(false);
      return;
    }
    const id = ++seq.current;
    setLoading(true);
    searchAddressSuggestions(val, { limit: 8 }).then((rows) => {
      if (id !== seq.current) return;
      setSuggestions(rows);
      setOpen(rows.length > 0);
      setActive(0);
      setLoading(false);
    }).catch(() => {
      if (id !== seq.current) return;
      setLoading(false);
    });
  };

  const handleChange = (val) => {
    onChange(val);
    const local = matchLocalFarms(val);
    if (local.length) {
      setSuggestions(local);
      setOpen(true);
      setActive(0);
    } else if ((val || '').trim().length < 2) {
      setSuggestions([]);
      setOpen(false);
    }
    if (timer.current) clearTimeout(timer.current);
    timer.current = setTimeout(() => runSearch(val), 160);
  };

  const onKeyDown = (e) => {
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      if (!open && suggestions.length) setOpen(true);
      setActive((i) => Math.min(i + 1, Math.max(0, suggestions.length - 1)));
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      setActive((i) => Math.max(i - 1, 0));
    } else if (e.key === 'Escape') {
      setOpen(false);
    } else if (e.key === 'Enter') {
      e.preventDefault();
      if (open && suggestions[active]) pick(suggestions[active]);
      else runSearch(value);
    }
  };

  const showChips = focused && !(value || '').trim();

  return (
    <div ref={boxRef} style={{ position: 'relative' }}>
      <div style={isPanel ? {
        display: 'flex', alignItems: 'center', gap: 8, border: '2px solid #e2e8f0',
        borderRadius: 10, padding: '10px 12px', background: 'white',
      } : {
        display: 'flex', alignItems: 'center', gap: 8,
        border: '1px solid #d1d5db', borderRadius: 8,
        padding: '8px 12px', background: 'white',
      }}>
        <span style={{ color: '#64748b', display: 'inline-flex', flexShrink: 0 }}><PinIcon /></span>
        <input
          type="text"
          value={value}
          autoFocus={autoFocus}
          autoComplete="off"
          spellCheck={false}
          placeholder={placeholder}
          onChange={(e) => handleChange(e.target.value)}
          onFocus={() => {
            setFocused(true);
            if ((value || '').trim() && suggestions.length) setOpen(true);
          }}
          onBlur={() => setFocused(false)}
          onKeyDown={onKeyDown}
          className={isPanel ? undefined : 'w-full'}
          style={isPanel
            ? { border: 'none', background: 'transparent', flex: 1, outline: 'none', fontSize: 13, color: '#1e293b' }
            : { border: 'none', background: 'transparent', flex: 1, outline: 'none', fontSize: 14, color: '#111827' }}
        />
        {loading && <span style={{ fontSize: 11, color: '#94a3b8' }}>⟳</span>}
        {value && !loading && (
          <button
            type="button"
            onClick={() => { onChange(''); setSuggestions([]); setOpen(false); }}
            style={{ cursor: 'pointer', color: '#94a3b8', fontSize: 15, lineHeight: 1, background: 'none', border: 'none' }}
          >✕</button>
        )}
      </div>

      {showChips && (
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginTop: 8 }}>
          {INDIA_EXAMPLE_FARMS.map((f) => (
            <button
              key={f.name}
              type="button"
              onMouseDown={(e) => { e.preventDefault(); pick(f); }}
              style={{
                fontSize: 11, padding: '4px 8px', borderRadius: 999,
                border: '1px solid #d1d5db', background: '#f8fafc', color: '#334155',
                cursor: 'pointer',
              }}
              title={f.display_name}
            >
              {f.name}
            </button>
          ))}
        </div>
      )}

      {open && suggestions.length > 0 && (
        <div style={{
          position: 'absolute', top: '100%', left: 0, right: 0, marginTop: 4,
          background: 'white', border: '1px solid #e2e8f0', borderRadius: 10,
          boxShadow: '0 10px 40px rgba(0,0,0,0.12)', zIndex: 100,
          maxHeight: 320, overflowY: 'auto',
        }}>
          {suggestions.map((sug, i) => (
            <div
              key={`${sug.lat}-${sug.lon}-${i}`}
              onMouseDown={(e) => { e.preventDefault(); pick(sug); }}
              onMouseEnter={() => setActive(i)}
              style={{
                padding: '10px 12px', cursor: 'pointer',
                background: i === active ? '#f0f5e8' : 'white',
                borderBottom: '1px solid #f1f5f9',
                display: 'flex', gap: 10, alignItems: 'flex-start',
              }}
            >
              <span style={{ color: sug.source === 'farm' ? '#6D8E22' : '#64748b', marginTop: 2, flexShrink: 0 }}>
                <PinIcon />
              </span>
              <div style={{ minWidth: 0 }}>
                <div style={{ fontWeight: 600, fontSize: 13, color: '#0f172a' }}>
                  {highlight(sug.name || sug.display_name, value)}
                </div>
                {(sug.subtitle || sug.display_name?.includes(',')) && (
                  <div style={{ fontSize: 11, color: '#64748b', marginTop: 2, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                    {highlight(sug.subtitle || sug.display_name.split(',').slice(1).join(','), value)}
                  </div>
                )}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
