import React, { useEffect, useState, useRef } from 'react';
import { useSearchParams } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import RichTextEditor from './RichTextEditor';

export default function TestimonialsManage() {
  const { t } = useTranslation();
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  const [testimonials, setTestimonials] = useState([]);
  const [loading, setLoading] = useState(true);

  const today = new Date().toISOString().split('T')[0];

  const [showForm, setShowForm] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [authorName, setAuthorName] = useState('');
  const [city, setCity] = useState('');
  const [state, setState] = useState('');
  const [organization, setOrganization] = useState('');
  const [website, setWebsite] = useState('');
  const [testimonialDate, setTestimonialDate] = useState(today);
  const [content, setContent] = useState('');
  const [rating, setRating] = useState('');
  const [selectedPeopleID, setSelectedPeopleID] = useState(null);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState(null);
  // Key to force re-mount RichTextEditor when editing different testimonials
  const [editorKey, setEditorKey] = useState(0);

  // People search
  const [peopleQuery, setPeopleQuery] = useState('');
  const [peopleResults, setPeopleResults] = useState([]);
  const [peopleSearching, setPeopleSearching] = useState(false);
  const [showPeopleDropdown, setShowPeopleDropdown] = useState(false);
  const searchTimeout = useRef(null);
  const dropdownRef = useRef(null);

  const apiBase = import.meta.env.VITE_API_URL || '';
  const token = localStorage.getItem('access_token');

  const loadTestimonials = () => {
    fetch(`${apiBase}/auth/testimonials?BusinessID=${BusinessID}`, {
      headers: { Authorization: `Bearer ${token}` },
    })
      .then(res => res.ok ? res.json() : [])
      .then(data => { setTestimonials(data); setLoading(false); })
      .catch(() => setLoading(false));
  };

  useEffect(() => {
    LoadBusiness(BusinessID);
    loadTestimonials();
  }, [BusinessID]);

  // Close dropdown on outside click
  useEffect(() => {
    const handler = (e) => {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target)) {
        setShowPeopleDropdown(false);
      }
    };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, []);

  const searchPeople = (query) => {
    setPeopleQuery(query);
    setSelectedPeopleID(null);
    if (searchTimeout.current) clearTimeout(searchTimeout.current);
    if (!query.trim() || query.trim().length < 2) {
      setPeopleResults([]);
      setShowPeopleDropdown(false);
      return;
    }
    searchTimeout.current = setTimeout(async () => {
      setPeopleSearching(true);
      try {
        const res = await fetch(`${apiBase}/auth/people/search?q=${encodeURIComponent(query.trim())}`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        if (res.ok) {
          const data = await res.json();
          setPeopleResults(data);
          setShowPeopleDropdown(data.length > 0);
        }
      } catch { /* ignore */ }
      finally { setPeopleSearching(false); }
    }, 300);
  };

  const selectPerson = (person) => {
    setAuthorName([person.PeopleFirstName, person.PeopleLastName].filter(Boolean).join(' '));
    setCity(person.City || '');
    setState(person.State || '');
    setOrganization(person.BusinessName || '');
    setWebsite(person.Website || '');
    setSelectedPeopleID(person.PeopleID);
    setPeopleQuery([person.PeopleFirstName, person.PeopleLastName].filter(Boolean).join(' '));
    setShowPeopleDropdown(false);
  };

  const clearForm = () => {
    setAuthorName('');
    setCity('');
    setState('');
    setOrganization('');
    setWebsite('');
    setTestimonialDate(today);
    setContent('');
    setRating('');
    setSelectedPeopleID(null);
    setPeopleQuery('');
    setPeopleResults([]);
    setEditingId(null);
    setSaveError(null);
    setEditorKey(k => k + 1);
  };

  const startEdit = (item) => {
    setEditingId(item.TestimonialsID);
    setAuthorName(item.AuthorName || '');
    setCity(item.City || '');
    setState(item.State || '');
    setOrganization(item.Organization || '');
    setWebsite(item.Website || '');
    setTestimonialDate(item.TestimonialDate ? item.TestimonialDate.split('T')[0] : today);
    setContent(item.Content || '');
    setRating(item.Rating ? String(item.Rating) : '');
    setSelectedPeopleID(item.PeopleID || null);
    setPeopleQuery('');
    setSaveError(null);
    setShowForm(true);
    setEditorKey(k => k + 1);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handleSave = async (e) => {
    e.preventDefault();
    setSaving(true);
    setSaveError(null);
    const url = editingId
      ? `${apiBase}/auth/testimonials/update`
      : `${apiBase}/auth/testimonials/add`;
    try {
      const res = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
        body: JSON.stringify({
          TestimonialsID: editingId,
          BusinessID,
          AuthorName: authorName,
          City: city,
          State: state,
          Organization: organization,
          Website: website,
          Content: content,
          TestimonialDate: testimonialDate,
          Rating: rating ? Number(rating) : null,
          PeopleID: selectedPeopleID,
        }),
      });
      if (!res.ok) throw new Error(t('testimonials.err_save_failed'));
      clearForm();
      setShowForm(false);
      loadTestimonials();
    } catch (err) {
      setSaveError(err.message);
    } finally {
      setSaving(false);
    }
  };

  if (!Business || loading) return <div className="p-8 text-gray-500">{t('testimonials.loading')}</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle={t('testimonials.page_title')} breadcrumbs={[{ label: t('testimonials.breadcrumb_dashboard'), to: '/dashboard' }, { label: t('testimonials.breadcrumb_testimonials') }, { label: t('testimonials.breadcrumb_manage') }]}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-2xl font-bold text-green-700">{t('testimonials.heading')}</h2>
          <button onClick={() => { if (showForm) { clearForm(); setShowForm(false); } else { clearForm(); setShowForm(true); } }} className="regsubmit2">
            {showForm ? t('testimonials.btn_cancel') : t('testimonials.btn_add')}
          </button>
        </div>

        {showForm && (
          <form onSubmit={handleSave} className="mb-6 border border-gray-200 rounded-lg p-4 bg-gray-50 space-y-4">
            <h3 className="text-lg font-semibold text-[#5a3e2b]">
              {editingId ? t('testimonials.form_heading_edit') : t('testimonials.form_heading_new')}
            </h3>

            {saveError && (
              <div className="p-3 bg-red-50 text-red-700 rounded-lg text-sm">{saveError}</div>
            )}

            {/* People search */}
            <div ref={dropdownRef} className="relative max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_search_people')}</label>
              <input
                type="text"
                value={peopleQuery}
                onChange={e => searchPeople(e.target.value)}
                onFocus={() => { if (peopleResults.length > 0) setShowPeopleDropdown(true); }}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder={t('testimonials.placeholder_search')}
              />
              {peopleSearching && <span className="absolute right-3 top-8 text-xs text-gray-400">{t('testimonials.searching')}</span>}
              {showPeopleDropdown && (
                <div className="absolute z-10 w-full mt-1 bg-white border border-gray-200 rounded-lg shadow-lg max-h-48 overflow-y-auto">
                  {peopleResults.map(p => (
                    <button
                      key={p.PeopleID}
                      type="button"
                      onClick={() => selectPerson(p)}
                      className="w-full text-left px-3 py-2 hover:bg-green-50 text-sm border-b border-gray-50 last:border-b-0"
                    >
                      <span className="font-medium text-[#5a3e2b]">{p.PeopleFirstName} {p.PeopleLastName}</span>
                      {p.BusinessName && <span className="text-gray-500 ml-2">— {p.BusinessName}</span>}
                      {(p.City || p.State) && (
                        <span className="text-gray-400 ml-2">{[p.City, p.State].filter(Boolean).join(', ')}</span>
                      )}
                    </button>
                  ))}
                </div>
              )}
            </div>

            <hr className="border-gray-200" />

            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_author_name')}</label>
              <input
                type="text"
                value={authorName}
                onChange={e => setAuthorName(e.target.value)}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="Jane Smith"
              />
            </div>

            <div className="grid grid-cols-2 gap-4 max-w-lg">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_city')}</label>
                <input
                  type="text"
                  value={city}
                  onChange={e => setCity(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                  placeholder="Denver"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_state')}</label>
                <input
                  type="text"
                  value={state}
                  onChange={e => setState(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                  placeholder="CO"
                />
              </div>
            </div>

            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_organization')}</label>
              <input
                type="text"
                value={organization}
                onChange={e => setOrganization(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="Happy Acres Farm"
              />
            </div>

            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_website')}</label>
              <input
                type="url"
                value={website}
                onChange={e => setWebsite(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="https://example.com"
              />
            </div>

            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_date')}</label>
              <input
                type="date"
                value={testimonialDate}
                onChange={e => setTestimonialDate(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_content')}</label>
              <RichTextEditor key={editorKey} value={content} onChange={setContent} minHeight={180} />
            </div>

            <div className="max-w-lg">
              <label className="block text-sm font-medium text-gray-700 mb-1">{t('testimonials.lbl_rating')}</label>
              <select
                value={rating}
                onChange={e => setRating(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
              >
                <option value="">{t('testimonials.rating_none')}</option>
                <option value="5">{t('testimonials.rating_5')}</option>
                <option value="4">{t('testimonials.rating_4')}</option>
                <option value="3">{t('testimonials.rating_3')}</option>
                <option value="2">{t('testimonials.rating_2')}</option>
                <option value="1">{t('testimonials.rating_1')}</option>
              </select>
            </div>

            <div className="flex justify-end">
              <button type="submit" disabled={saving} className="regsubmit2">
                {saving ? t('testimonials.btn_saving') : editingId ? t('testimonials.btn_update') : t('testimonials.btn_save')}
              </button>
            </div>
          </form>
        )}

        {testimonials.length === 0 && !showForm ? (
          <p className="text-gray-500 text-sm">{t('testimonials.empty')}</p>
        ) : (
          <div className="space-y-4">
            {testimonials.map((item, i) => (
              <div key={item.TestimonialsID || i} className="border border-gray-100 rounded-lg p-4">
                <div className="text-gray-700" dangerouslySetInnerHTML={{ __html: item.Content }} />
                <div className="flex items-center justify-between mt-2">
                  <div>
                    <p className="text-sm text-gray-500">— {item.AuthorName || t('testimonials.anonymous')}</p>
                    {(item.Organization || item.City || item.State) && (
                      <p className="text-xs text-gray-400">
                        {[item.Organization, [item.City, item.State].filter(Boolean).join(', ')].filter(Boolean).join(' | ')}
                      </p>
                    )}
                    {item.TestimonialDate && (
                      <p className="text-xs text-gray-400">{new Date(item.TestimonialDate).toLocaleDateString()}</p>
                    )}
                  </div>
                  <div className="flex items-center gap-3">
                    {item.Rating > 0 && (
                      <span className="text-sm text-yellow-500">
                        {'★'.repeat(item.Rating)}{'☆'.repeat(5 - item.Rating)}
                      </span>
                    )}
                    <button
                      onClick={() => startEdit(item)}
                      className="text-xs text-[#5a3e2b] hover:underline font-medium"
                    >
                      {t('testimonials.btn_edit')}
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
