import React, { useEffect, useState, useRef } from 'react';
import { useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function TestimonialsManage() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  const [testimonials, setTestimonials] = useState([]);
  const [loading, setLoading] = useState(true);

  const [showForm, setShowForm] = useState(false);
  const [authorName, setAuthorName] = useState('');
  const [city, setCity] = useState('');
  const [state, setState] = useState('');
  const [organization, setOrganization] = useState('');
  const [website, setWebsite] = useState('');
  const [content, setContent] = useState('');
  const [rating, setRating] = useState('');
  const [selectedPeopleID, setSelectedPeopleID] = useState(null);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState(null);

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
    setContent('');
    setRating('');
    setSelectedPeopleID(null);
    setPeopleQuery('');
    setPeopleResults([]);
  };

  const handleAdd = async (e) => {
    e.preventDefault();
    setSaving(true);
    setSaveError(null);
    try {
      const res = await fetch(`${apiBase}/auth/testimonials/add`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
        body: JSON.stringify({
          BusinessID,
          AuthorName: authorName,
          City: city,
          State: state,
          Organization: organization,
          Website: website,
          Content: content,
          Rating: rating ? Number(rating) : null,
          PeopleID: selectedPeopleID,
        }),
      });
      if (!res.ok) throw new Error('Failed to save testimonial');
      clearForm();
      setShowForm(false);
      loadTestimonials();
    } catch (err) {
      setSaveError(err.message);
    } finally {
      setSaving(false);
    }
  };

  if (!Business || loading) return <div className="p-8 text-gray-500">Loading...</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="Manage Testimonials" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Testimonials' }, { label: 'Manage' }]}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-2xl font-bold text-green-700">Manage Testimonials</h2>
          <button onClick={() => { setShowForm(f => !f); if (showForm) clearForm(); }} className="regsubmit2">
            {showForm ? 'Cancel' : 'Add Testimonial'}
          </button>
        </div>

        {showForm && (
          <form onSubmit={handleAdd} className="mb-6 border border-gray-200 rounded-lg p-4 bg-gray-50 space-y-4 max-w-lg">
            <h3 className="text-lg font-semibold text-[#5a3e2b]">New Testimonial</h3>

            {saveError && (
              <div className="p-3 bg-red-50 text-red-700 rounded-lg text-sm">{saveError}</div>
            )}

            {/* People search */}
            <div ref={dropdownRef} className="relative">
              <label className="block text-sm font-medium text-gray-700 mb-1">Search People in Database</label>
              <input
                type="text"
                value={peopleQuery}
                onChange={e => searchPeople(e.target.value)}
                onFocus={() => { if (peopleResults.length > 0) setShowPeopleDropdown(true); }}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="Type a name to search..."
              />
              {peopleSearching && <span className="absolute right-3 top-8 text-xs text-gray-400">Searching...</span>}
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

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Author Name</label>
              <input
                type="text"
                value={authorName}
                onChange={e => setAuthorName(e.target.value)}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="Jane Smith"
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">City</label>
                <input
                  type="text"
                  value={city}
                  onChange={e => setCity(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                  placeholder="Denver"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">State</label>
                <input
                  type="text"
                  value={state}
                  onChange={e => setState(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                  placeholder="CO"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Organization</label>
              <input
                type="text"
                value={organization}
                onChange={e => setOrganization(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="Happy Acres Farm"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Website</label>
              <input
                type="url"
                value={website}
                onChange={e => setWebsite(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="https://example.com"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Testimonial</label>
              <textarea
                value={content}
                onChange={e => setContent(e.target.value)}
                required
                rows={4}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
                placeholder="Write the testimonial here..."
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Rating (optional)</label>
              <select
                value={rating}
                onChange={e => setRating(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
              >
                <option value="">No rating</option>
                <option value="5">5 Stars</option>
                <option value="4">4 Stars</option>
                <option value="3">3 Stars</option>
                <option value="2">2 Stars</option>
                <option value="1">1 Star</option>
              </select>
            </div>

            <button type="submit" disabled={saving} className="regsubmit2">
              {saving ? 'Saving...' : 'Save Testimonial'}
            </button>
          </form>
        )}

        {testimonials.length === 0 && !showForm ? (
          <p className="text-gray-500 text-sm">You don't have any testimonials yet. Add one or request some from your customers!</p>
        ) : (
          <div className="space-y-4">
            {testimonials.map((t, i) => (
              <div key={t.TestimonialID || i} className="border border-gray-100 rounded-lg p-4">
                <p className="text-gray-700 italic">"{t.Content}"</p>
                <div className="flex items-center justify-between mt-2">
                  <div>
                    <p className="text-sm text-gray-500">— {t.AuthorName || 'Anonymous'}</p>
                    {(t.Organization || t.City || t.State) && (
                      <p className="text-xs text-gray-400">
                        {[t.Organization, [t.City, t.State].filter(Boolean).join(', ')].filter(Boolean).join(' | ')}
                      </p>
                    )}
                  </div>
                  {t.Rating && (
                    <span className="text-sm text-yellow-500">
                      {'★'.repeat(t.Rating)}{'☆'.repeat(5 - t.Rating)}
                    </span>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </AccountLayout>
  );
}
