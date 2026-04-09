import React, { useState, useEffect, useRef } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL;

const CATEGORIES = [
  { value: 'Observation',       label: 'Observation',       icon: '👁️',  color: '#6D8E22', bg: '#f0f5e8' },
  { value: 'Planting',          label: 'Planting',          icon: '🌱',  color: '#2E7D32', bg: '#e8f5e9' },
  { value: 'Spray Application', label: 'Spray Application', icon: '🧪',  color: '#1565C0', bg: '#e3f2fd' },
  { value: 'Irrigation',        label: 'Irrigation',        icon: '💧',  color: '#0277BD', bg: '#e1f5fe' },
  { value: 'Harvest',           label: 'Harvest',           icon: '🌾',  color: '#F57F17', bg: '#fffde7' },
  { value: 'Scouting',          label: 'Scouting',          icon: '🔍',  color: '#6A1B9A', bg: '#f3e5f5' },
  { value: 'Equipment',         label: 'Equipment',         icon: '🔧',  color: '#4E342E', bg: '#efebe9' },
  { value: 'Weather',           label: 'Weather',           icon: '🌤️', color: '#0288D1', bg: '#e1f5fe' },
  { value: 'General',           label: 'General',           icon: '📋',  color: '#546E7A', bg: '#eceff1' },
];

const EMPTY_FORM = {
  note_date: new Date().toISOString().slice(0, 10),
  category:  'Observation',
  title:     '',
  content:   '',
};

function getCat(value) {
  return CATEGORIES.find(c => c.value === value) || CATEGORIES[CATEGORIES.length - 1];
}

function formatDate(dateStr) {
  if (!dateStr) return '';
  const d = new Date(dateStr + 'T12:00:00');
  return d.toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
}

function groupByDate(notes) {
  const groups = {};
  notes.forEach(n => {
    const key = n.note_date || 'Unknown';
    if (!groups[key]) groups[key] = [];
    groups[key].push(n);
  });
  return Object.entries(groups).sort(([a], [b]) => b.localeCompare(a));
}

// ─── NoteForm ─────────────────────────────────────────────────────────────────
function NoteForm({ fields, initialFieldId, businessId, peopleId, editNote, onSave, onCancel }) {
  const [form, setForm] = useState(
    editNote
      ? { note_date: editNote.note_date, category: editNote.category, title: editNote.title, content: editNote.content }
      : EMPTY_FORM
  );
  const [fieldId, setFieldId] = useState(initialFieldId || (fields[0] ? String(fields[0].fieldid ?? fields[0].id) : ''));
  const [saving, setSaving]   = useState(false);
  const [error, setError]     = useState('');
  const textareaRef = useRef(null);

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.style.height = 'auto';
      textareaRef.current.style.height = textareaRef.current.scrollHeight + 'px';
    }
  }, [form.content]);

  const handleChange = e => setForm(p => ({ ...p, [e.target.name]: e.target.value }));

  const handleSubmit = async e => {
    e.preventDefault();
    if (!form.title.trim() || !form.content.trim()) { setError('Title and content are required.'); return; }
    setSaving(true); setError('');
    try {
      const url    = editNote ? `${API_URL}/api/notes/${editNote.note_id}` : `${API_URL}/api/notes`;
      const method = editNote ? 'PUT' : 'POST';
      const body   = editNote
        ? { note_date: form.note_date, category: form.category, title: form.title, content: form.content }
        : { ...form, field_id: parseInt(fieldId), business_id: parseInt(businessId), people_id: peopleId ? parseInt(peopleId) : null };
      const res = await fetch(url, { method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body) });
      if (!res.ok) throw new Error((await res.json()).detail || 'Save failed');
      const saved = await res.json();
      onSave(saved, !!editNote);
    } catch (err) {
      setError(err.message);
    } finally {
      setSaving(false);
    }
  };

  const inputCls = 'w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#6D8E22] transition';

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      {error && <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-2 rounded-lg text-sm">{error}</div>}

      {!editNote && (
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Field</label>
          <select value={fieldId} onChange={e => setFieldId(e.target.value)} className={inputCls} required>
            <option value="">— Select a field —</option>
            {fields.map(f => {
              const id = f.fieldid ?? f.id;
              return <option key={id} value={id}>{f.name}</option>;
            })}
          </select>
        </div>
      )}

      <div className="grid grid-cols-2 gap-3">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Date</label>
          <input type="date" name="note_date" value={form.note_date} onChange={handleChange} className={inputCls} required />
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Category</label>
          <select name="category" value={form.category} onChange={handleChange} className={inputCls}>
            {CATEGORIES.map(c => (
              <option key={c.value} value={c.value}>{c.icon} {c.label}</option>
            ))}
          </select>
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">Title</label>
        <input type="text" name="title" value={form.title} onChange={handleChange}
          placeholder="e.g. First signs of aphid pressure on north edge"
          className={inputCls} required />
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">Journal Entry</label>
        <textarea
          ref={textareaRef}
          name="content"
          value={form.content}
          onChange={handleChange}
          placeholder="Record what you observed, applied, or decided today. Include rates, equipment settings, field conditions, or anything you'd want to remember next season..."
          className={`${inputCls} resize-none overflow-hidden min-h-[120px]`}
          required
        />
        <div className="text-xs text-gray-400 mt-1 text-right">{form.content.length} characters</div>
      </div>

      <div className="flex justify-end gap-3 pt-1">
        <button type="button" onClick={onCancel}
          className="px-5 py-2 rounded-lg border border-gray-200 text-gray-600 text-sm font-medium hover:bg-gray-50 transition">
          Cancel
        </button>
        <button type="submit" disabled={saving}
          className="px-6 py-2 rounded-lg text-white text-sm font-semibold transition disabled:opacity-50"
          style={{ background: '#819360' }}>
          {saving ? 'Saving…' : editNote ? 'Save Changes' : 'Add Entry'}
        </button>
      </div>
    </form>
  );
}

// ─── NoteCard ─────────────────────────────────────────────────────────────────
function NoteCard({ note, fieldName, onEdit, onDelete }) {
  const [expanded,      setExpanded]      = useState(false);
  const [confirmDelete, setConfirmDelete] = useState(false);
  const cat    = getCat(note.category);
  const isLong = note.content.length > 220;

  return (
    <div className="bg-white rounded-xl border border-gray-100 shadow-sm hover:shadow-md transition-all">
      <div className="p-5">
        <div className="flex items-start justify-between gap-3 mb-2">
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2 mb-1.5 flex-wrap">
              <span className="text-xs font-semibold px-2.5 py-0.5 rounded-full font-mont"
                style={{ background: cat.bg, color: cat.color }}>
                {cat.icon} {cat.label}
              </span>
              {fieldName && (
                <span className="text-xs text-gray-400 font-mont">📍 {fieldName}</span>
              )}
            </div>
            <h3 className="font-lora font-bold text-gray-900 text-base leading-snug">{note.title}</h3>
          </div>
          <div className="flex items-center gap-1 shrink-0">
            <button onClick={() => onEdit(note)}
              className="w-7 h-7 flex items-center justify-center rounded-full text-gray-400 hover:bg-gray-100 hover:text-gray-700 transition text-sm"
              title="Edit">✏️</button>
            {confirmDelete ? (
              <div className="flex items-center gap-1">
                <button onClick={() => onDelete(note.note_id)}
                  className="text-xs px-2 py-1 bg-red-600 text-white rounded-lg font-medium">Delete</button>
                <button onClick={() => setConfirmDelete(false)}
                  className="text-xs px-2 py-1 border border-gray-200 rounded-lg text-gray-500">Cancel</button>
              </div>
            ) : (
              <button onClick={() => setConfirmDelete(true)}
                className="w-7 h-7 flex items-center justify-center rounded-full text-gray-400 hover:bg-red-50 hover:text-red-500 transition text-sm"
                title="Delete">🗑</button>
            )}
          </div>
        </div>

        <p className="text-sm text-gray-600 font-mont leading-relaxed whitespace-pre-wrap">
          {!expanded && isLong ? note.content.slice(0, 220) + '…' : note.content}
        </p>
        {isLong && (
          <button onClick={() => setExpanded(p => !p)}
            className="mt-1.5 text-xs text-[#6D8E22] font-mont font-semibold hover:underline">
            {expanded ? 'Show less' : 'Read more'}
          </button>
        )}
      </div>
    </div>
  );
}

// ─── Main page ────────────────────────────────────────────────────────────────
export default function OatSenseNotes() {
  const [searchParams, setSearchParams] = useSearchParams();
  const navigate    = useNavigate();
  const businessId  = searchParams.get('BusinessID');
  const initFieldId = searchParams.get('FieldID');
  const PeopleID    = localStorage.getItem('PeopleID') || localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [fields,       setFields]       = useState([]);
  const [notes,        setNotes]        = useState([]);
  const [activeField,  setActiveField]  = useState(initFieldId || 'all');
  const [catFilter,    setCatFilter]    = useState('all');
  const [showForm,     setShowForm]     = useState(false);
  const [editNote,     setEditNote]     = useState(null);
  const [loadingNotes, setLoadingNotes] = useState(false);
  const [error,        setError]        = useState('');

  useEffect(() => { if (businessId) LoadBusiness(businessId); }, [businessId]);

  useEffect(() => {
    if (!businessId) return;
    fetch(`${API_URL}/api/fields?business_id=${businessId}`)
      .then(r => r.json())
      .then(data => setFields(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, [businessId]);

  useEffect(() => {
    if (!businessId) return;
    setLoadingNotes(true);
    const params = new URLSearchParams({ business_id: businessId });
    if (activeField && activeField !== 'all') params.set('field_id', activeField);
    if (catFilter   && catFilter   !== 'all') params.set('category', catFilter);
    fetch(`${API_URL}/api/notes?${params}`)
      .then(r => r.json())
      .then(data => { setNotes(Array.isArray(data) ? data : []); setError(''); })
      .catch(() => setError('Could not load notes.'))
      .finally(() => setLoadingNotes(false));
  }, [businessId, activeField, catFilter]);

  useEffect(() => {
    const next = new URLSearchParams(searchParams);
    if (activeField && activeField !== 'all') next.set('FieldID', activeField);
    else next.delete('FieldID');
    setSearchParams(next, { replace: true });
  }, [activeField]);

  const getFieldName = id => {
    const f = fields.find(f => String(f.fieldid ?? f.id) === String(id));
    return f?.name ?? '';
  };

  const handleSave = (saved, isEdit) => {
    if (isEdit) {
      setNotes(prev => prev.map(n => n.note_id === saved.note_id ? saved : n));
    } else {
      setNotes(prev => [saved, ...prev]);
    }
    setShowForm(false);
    setEditNote(null);
  };

  const handleDelete = async noteId => {
    try {
      await fetch(`${API_URL}/api/notes/${noteId}`, { method: 'DELETE' });
      setNotes(prev => prev.filter(n => n.note_id !== noteId));
    } catch {}
  };

  const handleEdit = note => {
    setEditNote(note);
    setShowForm(true);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const openNew  = () => { setEditNote(null); setShowForm(true); };
  const closeForm = () => { setShowForm(false); setEditNote(null); };

  const grouped = groupByDate(notes);
  const activeFieldObj = activeField !== 'all'
    ? fields.find(f => String(f.fieldid ?? f.id) === String(activeField))
    : null;

  if (!Business) return <div className="p-8 text-gray-500 font-mont">Loading…</div>;

  return (
    <AccountLayout Business={Business} BusinessID={businessId} PeopleID={PeopleID}>
      <div className="max-w-4xl mx-auto pb-20">

        {/* Page header */}
        <div className="flex items-start justify-between mb-6">
          <div>
            <h1 className="font-lora text-3xl font-bold text-gray-900">Field Journal</h1>
            <p className="text-gray-500 font-mont text-sm mt-1">
              Record observations, applications, and decisions for every field.
            </p>
          </div>
          <button onClick={openNew}
            className="px-5 py-2.5 rounded-lg font-mont font-semibold text-white text-sm shadow-sm transition-all hover:opacity-90"
            style={{ background: '#819360' }}>
            + New Entry
          </button>
        </div>

        {/* Slide-down form */}
        {showForm && (
          <div className="bg-white rounded-xl border-2 border-[#6D8E22] shadow-lg p-6 mb-8">
            <h2 className="font-lora font-bold text-gray-900 text-lg mb-4">
              {editNote ? `Editing — ${editNote.title}` : 'New Journal Entry'}
            </h2>
            <NoteForm
              fields={fields}
              initialFieldId={activeField !== 'all' ? activeField : initFieldId || ''}
              businessId={businessId}
              peopleId={PeopleID}
              editNote={editNote}
              onSave={handleSave}
              onCancel={closeForm}
            />
          </div>
        )}

        {/* Filter bar */}
        <div className="bg-white rounded-xl border border-gray-100 shadow-sm px-5 py-4 mb-6 space-y-3">
          {/* Field selector */}
          <div className="flex items-center gap-3">
            <span className="text-xs font-mont font-semibold text-gray-400 uppercase tracking-wide w-12">Field</span>
            <select
              value={activeField}
              onChange={e => setActiveField(e.target.value)}
              className="border border-gray-200 rounded-lg px-3 py-1.5 text-sm font-mont focus:outline-none focus:ring-2 focus:ring-[#6D8E22] transition flex-1 max-w-xs"
            >
              <option value="all">All Fields</option>
              {fields.map(f => {
                const id = f.fieldid ?? f.id;
                return <option key={id} value={id}>{f.name}</option>;
              })}
            </select>
            {activeFieldObj && (
              <button
                onClick={() => navigate(`/precision-ag/analyses?BusinessID=${businessId}&FieldID=${activeField}`)}
                className="text-xs font-mont font-semibold text-[#6D8E22] hover:underline ml-auto">
                View Field Analysis →
              </button>
            )}
          </div>

          {/* Category pills */}
          <div className="flex items-center gap-1.5 flex-wrap">
            <span className="text-xs font-mont font-semibold text-gray-400 uppercase tracking-wide w-12">Type</span>
            <button
              onClick={() => setCatFilter('all')}
              className={`px-3 py-1 rounded-full text-xs font-mont font-semibold transition ${catFilter === 'all' ? 'bg-gray-800 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
              All
            </button>
            {CATEGORIES.map(c => (
              <button key={c.value}
                onClick={() => setCatFilter(catFilter === c.value ? 'all' : c.value)}
                className="px-3 py-1 rounded-full text-xs font-mont font-semibold transition"
                style={catFilter === c.value
                  ? { background: c.color, color: 'white' }
                  : { background: c.bg, color: c.color }}>
                {c.icon} {c.label}
              </button>
            ))}
          </div>
        </div>

        {/* Active field banner */}
        {activeFieldObj && (
          <div className="flex items-center gap-3 bg-[#f0f5e8] border border-[#c5d98a] rounded-xl px-5 py-3 mb-6 flex-wrap">
            <span className="text-[#6D8E22] font-lora font-bold">📍 {activeFieldObj.name}</span>
            {activeFieldObj.crop_type && (
              <span className="text-sm text-gray-500 font-mont">🌱 {activeFieldObj.crop_type}</span>
            )}
            {activeFieldObj.field_size_hectares && (
              <span className="text-sm text-gray-500 font-mont">📏 {activeFieldObj.field_size_hectares} ha</span>
            )}
          </div>
        )}

        {/* Notes timeline */}
        {loadingNotes ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm">Loading entries…</div>
        ) : error ? (
          <div className="text-center py-16 text-red-500 font-mont text-sm">{error}</div>
        ) : notes.length === 0 ? (
          <div className="text-center py-24">
            <div className="text-6xl mb-4">📓</div>
            <div className="font-lora text-2xl text-gray-700 mb-2">No entries yet</div>
            <div className="font-mont text-sm text-gray-400 mb-6">
              {catFilter !== 'all' || activeField !== 'all'
                ? 'No entries match the current filters.'
                : 'Start recording observations, spray applications, and field decisions.'}
            </div>
            {catFilter === 'all' && activeField === 'all' && (
              <button onClick={openNew}
                className="px-6 py-2.5 rounded-lg text-white font-mont font-semibold text-sm"
                style={{ background: '#819360' }}>
                Write Your First Entry
              </button>
            )}
          </div>
        ) : (
          <div className="space-y-8">
            {grouped.map(([dateKey, dayNotes]) => (
              <div key={dateKey}>
                <div className="flex items-center gap-3 mb-3">
                  <div className="h-px flex-1 bg-gray-200" />
                  <span className="font-lora font-bold text-gray-400 text-sm whitespace-nowrap">
                    {formatDate(dateKey)}
                  </span>
                  <div className="h-px flex-1 bg-gray-200" />
                </div>
                <div className="space-y-3">
                  {dayNotes.map(note => (
                    <NoteCard
                      key={note.note_id}
                      note={note}
                      fieldName={activeField === 'all' ? getFieldName(note.field_id) : ''}
                      onEdit={handleEdit}
                      onDelete={handleDelete}
                    />
                  ))}
                </div>
              </div>
            ))}
            <div className="text-center text-xs text-gray-300 font-mont pt-4">
              {notes.length} {notes.length === 1 ? 'entry' : 'entries'} total
            </div>
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
