import React, { useState, useEffect, useRef } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_URL = import.meta.env.VITE_API_URL;

const CI = ({ children }) => (
  <svg width="12" height="12" viewBox="0 0 16 16" fill="none" stroke="currentColor"
    strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" style={{ display: 'inline-block', flexShrink: 0 }}>
    {children}
  </svg>
);

const CATEGORIES = [
  { value: 'Observation',       tKey: 'cat_observation',       icon: <CI><ellipse cx="8" cy="8" rx="6" ry="4"/><circle cx="8" cy="8" r="2"/><circle cx="8" cy="8" r="0.8" fill="currentColor" stroke="none"/></CI>,  color: '#6D8E22', bg: '#f0f5e8' },
  { value: 'Planting',          tKey: 'cat_planting',          icon: <CI><path d="M8 14V9"/><path d="M4 6c0-2.5 2-4 4-4s4 1.5 4 4-2 3-4 3-4-.5-4-3z"/></CI>,  color: '#2E7D32', bg: '#e8f5e9' },
  { value: 'Spray Application', tKey: 'cat_spray_application', icon: <CI><path d="M4 13V7a4 4 0 0 1 8 0v6"/><line x1="6" y1="7" x2="10" y2="7"/><path d="M8 4V2"/><line x1="6" y1="13" x2="10" y2="13"/></CI>,  color: '#1565C0', bg: '#e3f2fd' },
  { value: 'Irrigation',        tKey: 'cat_irrigation',        icon: <CI><path d="M8 2c0 4-5 6-5 9a5 5 0 0 0 10 0c0-3-5-5-5-9z"/></CI>,  color: '#0277BD', bg: '#e1f5fe' },
  { value: 'Harvest',           tKey: 'cat_harvest',           icon: <CI><path d="M2 12c2-2 4-2 6 0s4 2 6 0"/><path d="M5 9a3 3 0 0 1 6 0"/><line x1="8" y1="6" x2="8" y2="2"/></CI>,  color: '#F57F17', bg: '#fffde7' },
  { value: 'Scouting',          tKey: 'cat_scouting',          icon: <CI><circle cx="6.5" cy="6.5" r="4"/><line x1="10" y1="10" x2="14" y2="14"/></CI>,  color: '#6A1B9A', bg: '#f3e5f5' },
  { value: 'Pest',              tKey: 'cat_pest',              icon: <CI><ellipse cx="8" cy="9" rx="3" ry="4"/><circle cx="8" cy="4" r="2"/><path d="M5 6l-2-2M11 6l2-2M5 10l-2 1M11 10l2 1"/></CI>,  color: '#B71C1C', bg: '#ffebee' },
  { value: 'Disease',           tKey: 'cat_disease',           icon: <CI><circle cx="8" cy="8" r="5"/><circle cx="6" cy="7" r="1" fill="currentColor" stroke="none"/><circle cx="10" cy="7" r="1" fill="currentColor" stroke="none"/><circle cx="8" cy="10" r="1" fill="currentColor" stroke="none"/></CI>,  color: '#AD1457', bg: '#fce4ec' },
  { value: 'Weed',              tKey: 'cat_weed',              icon: <CI><path d="M8 14V8"/><path d="M8 10c0-3 3-5 5-4"/><path d="M8 8c0-3-3-5-5-4"/></CI>,  color: '#388E3C', bg: '#e8f5e9' },
  { value: 'Nutrient',          tKey: 'cat_nutrient',          icon: <CI><path d="M6 2h4l1 4H5z"/><path d="M5 6l-1 7h8l-1-7"/></CI>, color: '#5D4037', bg: '#efebe9' },
  { value: 'Equipment',         tKey: 'cat_equipment',         icon: <CI><path d="M13 3a3.5 3.5 0 0 0-4.2 3.5L2.5 12.5a1.5 1.5 0 1 0 2 2L10 9a3.5 3.5 0 1 0 3-6z"/><circle cx="12.5" cy="3.5" r="1"/></CI>,  color: '#4E342E', bg: '#efebe9' },
  { value: 'Weather',           tKey: 'cat_weather',           icon: <CI><path d="M11 6a3 3 0 0 0-6 0 2.5 2.5 0 0 0 0 5h6a2.5 2.5 0 0 0 0-5z"/></CI>, color: '#0288D1', bg: '#e1f5fe' },
  { value: 'General',           tKey: 'cat_general',           icon: <CI><rect x="4" y="2" width="8" height="12" rx="1"/><path d="M6 2V1h4v1"/><line x1="6" y1="6" x2="10" y2="6"/><line x1="6" y1="8.5" x2="10" y2="8.5"/></CI>,  color: '#546E7A', bg: '#eceff1' },
];

// Scouting-style categories surface severity/GPS/photo inputs and a severity badge.
const SCOUTING_CATEGORIES = new Set(['Scouting', 'Pest', 'Disease', 'Weed', 'Nutrient', 'Irrigation', 'Weather']);

const SEVERITIES = ['Low', 'Medium', 'High', 'Critical'];
const SEV_COLOR  = { Low: '#10B981', Medium: '#F59E0B', High: '#F97316', Critical: '#EF4444' };

const EMPTY_FORM = {
  note_date: new Date().toISOString().slice(0, 10),
  category:  'Observation',
  title:     '',
  content:   '',
  severity:  '',
  latitude:  '',
  longitude: '',
  image_url: '',
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
  const { t } = useTranslation();
  const [form, setForm] = useState(
    editNote
      ? {
          note_date: editNote.note_date,
          category:  editNote.category,
          title:     editNote.title,
          content:   editNote.content,
          severity:  editNote.severity  ?? '',
          latitude:  editNote.latitude  ?? '',
          longitude: editNote.longitude ?? '',
          image_url: editNote.image_url ?? '',
        }
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
    if (!form.title.trim() || !form.content.trim()) { setError(t('oatsense_notes.form_error_required')); return; }
    setSaving(true); setError('');
    try {
      const url    = editNote ? `${API_URL}/api/notes/${editNote.note_id}` : `${API_URL}/api/notes`;
      const method = editNote ? 'PUT' : 'POST';
      const isScouting = SCOUTING_CATEGORIES.has(form.category);
      const sharedFields = {
        note_date: form.note_date,
        category:  form.category,
        title:     form.title,
        content:   form.content,
        severity:  isScouting && form.severity ? form.severity : null,
        latitude:  form.latitude  !== '' ? parseFloat(form.latitude)  : null,
        longitude: form.longitude !== '' ? parseFloat(form.longitude) : null,
        image_url: form.image_url || null,
      };
      const body = editNote
        ? sharedFields
        : { ...sharedFields, field_id: parseInt(fieldId), business_id: parseInt(businessId), people_id: peopleId ? parseInt(peopleId) : null };
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
          <label className="block text-sm font-medium text-gray-700 mb-1">{t('oatsense_notes.form_label_field')}</label>
          <select value={fieldId} onChange={e => setFieldId(e.target.value)} className={inputCls} required>
            <option value="">{t('oatsense_notes.form_select_field')}</option>
            {fields.map(f => {
              const id = f.fieldid ?? f.id;
              return <option key={id} value={id}>{f.name}</option>;
            })}
          </select>
        </div>
      )}

      <div className="grid grid-cols-2 gap-3">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">{t('oatsense_notes.form_label_date')}</label>
          <input type="date" name="note_date" value={form.note_date} onChange={handleChange} className={inputCls} required />
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">{t('oatsense_notes.form_label_category')}</label>
          <select name="category" value={form.category} onChange={handleChange} className={inputCls}>
            {CATEGORIES.map(c => (
              <option key={c.value} value={c.value}>{c.icon} {t('oatsense_notes.' + c.tKey)}</option>
            ))}
          </select>
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">{t('oatsense_notes.form_label_title')}</label>
        <input type="text" name="title" value={form.title} onChange={handleChange}
          placeholder={t('oatsense_notes.form_title_placeholder')}
          className={inputCls} required />
      </div>

      {SCOUTING_CATEGORIES.has(form.category) && (
        <div className="rounded-lg border border-gray-200 bg-gray-50 p-3 space-y-3">
          <div className="text-xs font-semibold font-mont text-gray-500 uppercase tracking-wide">{t('oatsense_notes.form_scouting_details')}</div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">{t('oatsense_notes.form_label_severity')}</label>
              <select name="severity" value={form.severity} onChange={handleChange} className={inputCls}>
                <option value="">{t('oatsense_notes.form_severity_none')}</option>
                {SEVERITIES.map(s => <option key={s} value={s}>{t('oatsense_notes.sev_' + s.toLowerCase())}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">{t('oatsense_notes.form_label_photo_url')}</label>
              <input type="url" name="image_url" value={form.image_url} onChange={handleChange}
                placeholder="https://…"
                className={inputCls} />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">{t('oatsense_notes.form_label_latitude')}</label>
              <input type="number" step="any" name="latitude" value={form.latitude} onChange={handleChange}
                placeholder="e.g. 42.34521"
                className={inputCls} />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">{t('oatsense_notes.form_label_longitude')}</label>
              <input type="number" step="any" name="longitude" value={form.longitude} onChange={handleChange}
                placeholder="e.g. -85.12734"
                className={inputCls} />
            </div>
          </div>
        </div>
      )}

      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">{t('oatsense_notes.form_label_content')}</label>
        <textarea
          ref={textareaRef}
          name="content"
          value={form.content}
          onChange={handleChange}
          placeholder={t('oatsense_notes.form_content_placeholder')}
          className={`${inputCls} resize-none overflow-hidden min-h-[120px]`}
          required
        />
        <div className="text-xs text-gray-400 mt-1 text-right">{t('oatsense_notes.form_char_count', { count: form.content.length })}</div>
      </div>

      <div className="flex justify-end gap-3 pt-1">
        <button type="button" onClick={onCancel}
          className="px-5 py-2 rounded-lg border border-gray-200 text-gray-600 text-sm font-medium hover:bg-gray-50 transition">
          {t('oatsense_notes.btn_cancel')}
        </button>
        <button type="submit" disabled={saving}
          className="px-6 py-2 rounded-lg text-white text-sm font-semibold transition disabled:opacity-50"
          style={{ background: '#819360' }}>
          {saving ? t('oatsense_notes.btn_saving') : editNote ? t('oatsense_notes.btn_save_changes') : t('oatsense_notes.btn_add_entry')}
        </button>
      </div>
    </form>
  );
}

// ─── NoteCard ─────────────────────────────────────────────────────────────────
function NoteCard({ note, fieldName, onEdit, onDelete }) {
  const { t } = useTranslation();
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
                style={{ background: cat.bg, color: cat.color, display: 'inline-flex', alignItems: 'center', gap: 3 }}>
                {cat.icon} {t('oatsense_notes.' + cat.tKey)}
              </span>
              {note.severity && (
                <span className="text-xs font-bold px-2 py-0.5 rounded-full font-mont"
                  style={{ background: (SEV_COLOR[note.severity] || '#9CA3AF') + '22', color: SEV_COLOR[note.severity] || '#374151' }}>
                  {note.severity}
                </span>
              )}
              {fieldName && (
                <span className="text-xs text-gray-400 font-mont">📍 {fieldName}</span>
              )}
              {(note.latitude != null && note.longitude != null) && (
                <span className="text-xs text-gray-400 font-mont">
                  {Number(note.latitude).toFixed(5)}, {Number(note.longitude).toFixed(5)}
                </span>
              )}
            </div>
            <h3 className="font-lora font-bold text-gray-900 text-base leading-snug">{note.title}</h3>
          </div>
          <div className="flex items-center gap-1 shrink-0">
            <button onClick={() => onEdit(note)}
              className="w-7 h-7 flex items-center justify-center rounded-full text-gray-400 hover:bg-gray-100 hover:text-gray-700 transition"
              title={t('oatsense_notes.card_edit_title')}>
              <svg width="13" height="13" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M11 2l3 3-8 8H3v-3z"/></svg>
            </button>
            {confirmDelete ? (
              <div className="flex items-center gap-1">
                <button onClick={() => onDelete(note.note_id)}
                  className="text-xs px-2 py-1 bg-red-600 text-white rounded-lg font-medium">{t('oatsense_notes.btn_delete')}</button>
                <button onClick={() => setConfirmDelete(false)}
                  className="text-xs px-2 py-1 border border-gray-200 rounded-lg text-gray-500">{t('oatsense_notes.btn_cancel_delete')}</button>
              </div>
            ) : (
              <button onClick={() => setConfirmDelete(true)}
                className="w-7 h-7 flex items-center justify-center rounded-full text-gray-400 hover:bg-red-50 hover:text-red-500 transition"
                title={t('oatsense_notes.card_delete_title')}>
                <svg width="13" height="13" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><polyline points="2 4 4 4 14 4"/><path d="M5 4V2.5h6V4"/><path d="M4 4l1 9h6l1-9"/></svg>
              </button>
            )}
          </div>
        </div>

        <p className="text-sm text-gray-600 font-mont leading-relaxed whitespace-pre-wrap">
          {!expanded && isLong ? note.content.slice(0, 220) + '…' : note.content}
        </p>
        {isLong && (
          <button onClick={() => setExpanded(p => !p)}
            className="mt-1.5 text-xs text-[#6D8E22] font-mont font-semibold hover:underline">
            {expanded ? t('oatsense_notes.btn_show_less') : t('oatsense_notes.btn_read_more')}
          </button>
        )}
        {note.image_url && (
          <img src={note.image_url} alt="Note attachment"
            className="mt-3 w-48 h-32 object-cover rounded-lg border border-gray-100"
            alt={t('oatsense_notes.img_alt')}
            onError={e => e.currentTarget.style.display = 'none'} />
        )}
      </div>
    </div>
  );
}

// ─── Main page ────────────────────────────────────────────────────────────────
export default function OatSenseNotes() {
  const { t } = useTranslation();
  const [searchParams, setSearchParams] = useSearchParams();
  const navigate    = useNavigate();
  const businessId  = (() => {
    const raw = searchParams.get('BusinessID');
    if (!raw || raw === 'null' || raw === 'undefined') return null;
    const n = parseInt(raw, 10);
    return Number.isFinite(n) && n > 0 ? n : null;
  })();
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
      .catch(() => setError(t('oatsense_notes.error_load')))
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

  if (!Business) return <div className="p-8 text-gray-500 font-mont">{t('oatsense.loading')}</div>;

  return (
    <AccountLayout Business={Business} BusinessID={businessId} PeopleID={PeopleID} pageTitle={t('oatsense_notes.page_title')} breadcrumbs={[{ label: t('nav.dashboard'), to: '/dashboard' }, { label: t('oatsense_notes.breadcrumb_oatsense') }, { label: t('oatsense_notes.breadcrumb_journal') }]}>
      <div className="max-w-4xl mx-auto pb-20">

        {/* Page header */}
        <div className="flex items-start justify-between mb-6">
          <div>
            <h1 className="font-lora text-3xl font-bold text-gray-900">{t('oatsense_notes.heading')}</h1>
            <p className="text-gray-500 font-mont text-sm mt-1">
              {t('oatsense_notes.subheading')}
            </p>
          </div>
          <button onClick={openNew}
            className="px-5 py-2.5 rounded-lg font-mont font-semibold text-white text-sm shadow-sm transition-all hover:opacity-90"
            style={{ background: '#819360' }}>
            {t('oatsense_notes.btn_new_entry')}
          </button>
        </div>

        {/* Slide-down form */}
        {showForm && (
          <div className="bg-white rounded-xl border-2 border-[#6D8E22] shadow-lg p-6 mb-8">
            <h2 className="font-lora font-bold text-gray-900 text-lg mb-4">
              {editNote ? t('oatsense_notes.editing_title', { title: editNote.title }) : t('oatsense_notes.new_entry_heading')}
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
            <span className="text-xs font-mont font-semibold text-gray-400 uppercase tracking-wide w-12">{t('oatsense_notes.filter_field_label')}</span>
            <select
              value={activeField}
              onChange={e => setActiveField(e.target.value)}
              className="border border-gray-200 rounded-lg px-3 py-1.5 text-sm font-mont focus:outline-none focus:ring-2 focus:ring-[#6D8E22] transition flex-1 max-w-xs"
            >
              <option value="all">{t('oatsense_notes.filter_all_fields')}</option>
              {fields.map(f => {
                const id = f.fieldid ?? f.id;
                return <option key={id} value={id}>{f.name}</option>;
              })}
            </select>
            {activeFieldObj && (
              <button
                onClick={() => navigate(`/precision-ag/analyses?BusinessID=${businessId}&FieldID=${activeField}`)}
                className="text-xs font-mont font-semibold text-[#6D8E22] hover:underline ml-auto">
                {t('oatsense_notes.view_analysis_link')}
              </button>
            )}
          </div>

          {/* Category pills */}
          <div className="flex items-center gap-1.5 flex-wrap">
            <span className="text-xs font-mont font-semibold text-gray-400 uppercase tracking-wide w-12">{t('oatsense_notes.filter_type_label')}</span>
            <button
              onClick={() => setCatFilter('all')}
              className={`px-3 py-1 rounded-full text-xs font-mont font-semibold transition ${catFilter === 'all' ? 'bg-gray-800 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
              {t('oatsense_notes.filter_all')}
            </button>
            {CATEGORIES.map(c => (
              <button key={c.value}
                onClick={() => setCatFilter(catFilter === c.value ? 'all' : c.value)}
                className="px-3 py-1 rounded-full text-xs font-mont font-semibold transition"
                style={catFilter === c.value
                  ? { background: c.color, color: 'white', display: 'inline-flex', alignItems: 'center', gap: 3 }
                  : { background: c.bg, color: c.color, display: 'inline-flex', alignItems: 'center', gap: 3 }}>
                {c.icon} {t('oatsense_notes.' + c.tKey)}
              </button>
            ))}
          </div>
        </div>

        {/* Active field banner */}
        {activeFieldObj && (
          <div className="flex items-center gap-3 bg-[#f0f5e8] border border-[#c5d98a] rounded-xl px-5 py-3 mb-6 flex-wrap">
            <span className="text-[#6D8E22] font-lora font-bold flex items-center gap-1">
              <svg width="13" height="13" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M8 1a4.5 4.5 0 0 0-4.5 4.5C3.5 9 8 15 8 15s4.5-6 4.5-9.5A4.5 4.5 0 0 0 8 1z"/><circle cx="8" cy="5.5" r="1.5"/></svg>
              {activeFieldObj.name}
            </span>
            {activeFieldObj.crop_type && (
              <span className="text-sm text-gray-500 font-mont flex items-center gap-1">
                <svg width="12" height="12" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M8 14V9"/><path d="M4 6c0-2.5 2-4 4-4s4 1.5 4 4-2 3-4 3-4-.5-4-3z"/></svg>
                {activeFieldObj.crop_type}
              </span>
            )}
            {activeFieldObj.field_size_hectares && (
              <span className="text-sm text-gray-500 font-mont">{activeFieldObj.field_size_hectares} ha</span>
            )}
          </div>
        )}

        {/* Notes timeline */}
        {loadingNotes ? (
          <div className="flex items-center justify-center py-24 text-gray-400 font-mont text-sm">{t('oatsense_notes.loading_entries')}</div>
        ) : error ? (
          <div className="text-center py-16 text-red-500 font-mont text-sm">{error}</div>
        ) : notes.length === 0 ? (
          <div className="text-center py-24">
            <div className="flex justify-center mb-4 text-gray-300">
            <svg width="56" height="56" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="0.9" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="1" width="10" height="14" rx="1"/><path d="M5 1V0h6v1"/><line x1="5" y1="5" x2="11" y2="5"/><line x1="5" y1="7.5" x2="11" y2="7.5"/><line x1="5" y1="10" x2="9" y2="10"/></svg>
          </div>
            <div className="font-lora text-2xl text-gray-700 mb-2">{t('oatsense_notes.no_entries_heading')}</div>
            <div className="font-mont text-sm text-gray-400 mb-6">
              {catFilter !== 'all' || activeField !== 'all'
                ? t('oatsense_notes.no_entries_filters')
                : t('oatsense_notes.no_entries_empty')}
            </div>
            {catFilter === 'all' && activeField === 'all' && (
              <button onClick={openNew}
                className="px-6 py-2.5 rounded-lg text-white font-mont font-semibold text-sm"
                style={{ background: '#819360' }}>
                {t('oatsense_notes.btn_first_entry')}
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
              {t(notes.length === 1 ? 'oatsense_notes.entries_count_one' : 'oatsense_notes.entries_count_other', { count: notes.length })}
            </div>
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
