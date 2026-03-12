import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function AccountNew() {
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [businessTypes, setBusinessTypes] = useState([]);
  const [countries, setCountries] = useState([]);
  const [states, setStates] = useState([]);
  const [errors, setErrors] = useState({});
  const [submitting, setSubmitting] = useState(false);

  const [form, setForm] = useState({
    // Step 1
    BusinessTypeID: '',
    BusinessName: '',
    BusinessWebsite: '',
    // Step 2
    AddressStreet: '',
    AddressApt: '',
    AddressCity: '',
    StateIndex: '',
    AddressZip: '',
    PeoplePhone: '',
    Permission: true,
    LivestockLegalDisclaimer: false,
    SalesLegalDisclaimer: false,
  });

  const peopleId = localStorage.getItem('people_id');

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (!token) { navigate('/login'); return; }

    // Load business types
    fetch(`${API_URL}/api/businesses/types`)
      .then(r => r.json())
      .then(data => setBusinessTypes(Array.isArray(data) ? data : []))
      .catch(() => {});

    // Load countries
    fetch(`${API_URL}/api/businesses/countries`)
      .then(r => r.json())
      .then(data => setCountries(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, [navigate]);

  // Load states when country changes (default USA)
  useEffect(() => {
    fetch(`${API_URL}/api/businesses/states?country=USA`)
      .then(r => r.json())
      .then(data => setStates(Array.isArray(data) ? data : []))
      .catch(() => {});
  }, []);

  const update = (field, value) => setForm(f => ({ ...f, [field]: value }));

  const validateStep1 = () => {
    const e = {};
    if (!form.BusinessTypeID) e.BusinessTypeID = 'Please select an account type.';
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const validateStep2 = () => {
    const e = {};
    if (!form.AddressStreet) e.AddressStreet = 'Street is required.';
    if (!form.AddressCity) e.AddressCity = 'City is required.';
    if (!form.StateIndex) e.StateIndex = 'Please select a state/province.';
    if (!form.PeoplePhone) e.PeoplePhone = 'Phone is required.';
    if (form.BusinessTypeID === '8') {
      if (!form.LivestockLegalDisclaimer) e.LivestockLegalDisclaimer = 'You must accept the Livestock Legal Disclaimer.';
      if (!form.SalesLegalDisclaimer) e.SalesLegalDisclaimer = 'You must accept the Sales Legal Disclaimer.';
    }
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleNext = () => {
    if (validateStep1()) setStep(2);
  };

  const handleSubmit = async () => {
    if (!validateStep2()) return;
    setSubmitting(true);
    try {
      const res = await fetch(`${API_URL}/api/businesses/create`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${localStorage.getItem('access_token')}` },
        body: JSON.stringify({ ...form, PeopleID: peopleId }),
      });
      const data = await res.json();
      if (res.ok) {
        navigate(`/account?PeopleID=${peopleId}&BusinessID=${data.BusinessID}`);
      } else {
        setErrors({ submit: data.detail || 'An error occurred. Please try again.' });
      }
    } catch {
      setErrors({ submit: 'An error occurred. Please try again.' });
    } finally {
      setSubmitting(false);
    }
  };

  const inputClass = "w-full border border-gray-300 rounded px-3 py-2 text-sm focus:outline-none focus:border-[#819360]";
  const labelClass = "block text-sm font-medium text-gray-700 mb-1";
  const errorClass = "text-red-600 text-xs mt-1";

  const selectedType = businessTypes.find(t => String(t.BusinessTypeID) === String(form.BusinessTypeID));

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <Header />

      <div style={{ maxWidth: '500px', margin: '2rem auto', padding: '0 1rem 3rem' }}>
        <div className="bg-white rounded-xl shadow border border-gray-100 p-8">

          <h1 className="text-2xl font-bold text-gray-800 mb-2">
            {step === 1 ? 'Add An Account' : 'Account Details'}
          </h1>

          {/* Step indicator */}
          <div className="flex items-center gap-2 mb-6">
            <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${step >= 1 ? 'bg-[#819360] text-white' : 'bg-gray-200 text-gray-500'}`}>1</div>
            <div className={`flex-1 h-1 rounded ${step >= 2 ? 'bg-[#819360]' : 'bg-gray-200'}`} />
            <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${step >= 2 ? 'bg-[#819360] text-white' : 'bg-gray-200 text-gray-500'}`}>2</div>
          </div>

          {/* STEP 1 */}
          {step === 1 && (
            <div className="space-y-5">
              <div>
                <label className={labelClass}>Account Type <span className="text-red-500">*</span></label>
                <select
                  value={form.BusinessTypeID}
                  onChange={e => update('BusinessTypeID', e.target.value)}
                  className={inputClass}
                >
                  <option value="">Select an account type...</option>
                  {businessTypes.map(t => (
                    <option key={t.BusinessTypeID} value={t.BusinessTypeID}>{t.BusinessType}</option>
                  ))}
                </select>
                {errors.BusinessTypeID && <p className={errorClass}>{errors.BusinessTypeID}</p>}
              </div>

              <div>
                <label className={labelClass}>Business / Org. Name <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input
                  type="text"
                  value={form.BusinessName}
                  onChange={e => update('BusinessName', e.target.value)}
                  className={inputClass}
                  placeholder="Your farm or business name"
                />
              </div>

              <div>
                <label className={labelClass}>Website <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input
                  type="text"
                  value={form.BusinessWebsite}
                  onChange={e => update('BusinessWebsite', e.target.value)}
                  className={inputClass}
                  placeholder="https://yourwebsite.com"
                />
              </div>

              <button onClick={handleNext} className="regsubmit2 w-full mt-4">
                Next →
              </button>
            </div>
          )}

          {/* STEP 2 */}
          {step === 2 && (
            <div className="space-y-5">
              {selectedType && (
                <p className="text-sm text-gray-500 bg-gray-50 rounded px-3 py-2">
                  Account type: <strong>{selectedType.BusinessType}</strong>
                  {form.BusinessName && <> · <strong>{form.BusinessName}</strong></>}
                </p>
              )}

              <div>
                <label className={labelClass}>Street <span className="text-red-500">*</span></label>
                <input type="text" value={form.AddressStreet} onChange={e => update('AddressStreet', e.target.value)} className={inputClass} />
                {errors.AddressStreet && <p className={errorClass}>{errors.AddressStreet}</p>}
              </div>

              <div>
                <label className={labelClass}>Address Line 2 <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="text" value={form.AddressApt} onChange={e => update('AddressApt', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>City <span className="text-red-500">*</span></label>
                <input type="text" value={form.AddressCity} onChange={e => update('AddressCity', e.target.value)} className={inputClass} />
                {errors.AddressCity && <p className={errorClass}>{errors.AddressCity}</p>}
              </div>

              <div>
                <label className={labelClass}>State / Province <span className="text-red-500">*</span></label>
                <select value={form.StateIndex} onChange={e => update('StateIndex', e.target.value)} className={inputClass}>
                  <option value="">Select...</option>
                  {states.map(s => (
                    <option key={s.StateIndex} value={s.StateIndex}>{s.name}</option>
                  ))}
                </select>
                {errors.StateIndex && <p className={errorClass}>{errors.StateIndex}</p>}
              </div>

              <div>
                <label className={labelClass}>Postal Code <span className="text-gray-400 font-normal">(Optional)</span></label>
                <input type="text" value={form.AddressZip} onChange={e => update('AddressZip', e.target.value)} className={inputClass} />
              </div>

              <div>
                <label className={labelClass}>Phone <span className="text-red-500">*</span></label>
                <input
                  type="text"
                  value={form.PeoplePhone}
                  onChange={e => update('PeoplePhone', e.target.value.replace(/[^0-9()-.\s]/g, ''))}
                  className={inputClass}
                  placeholder="(555) 555-5555"
                />
                {errors.PeoplePhone && <p className={errorClass}>{errors.PeoplePhone}</p>}
              </div>

           

              {/* Permission checkbox */}
              <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                <input type="checkbox" checked={form.Permission} onChange={e => update('Permission', e.target.checked)} className="mt-1" />
                Yes, you have my permission to share my listings in mass emails and on social media.
              </label>

              {/* Livestock disclaimers for type 8 */}
              {String(form.BusinessTypeID) === '8' && (
                <>
                  <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                    <input type="checkbox" checked={form.LivestockLegalDisclaimer} onChange={e => update('LivestockLegalDisclaimer', e.target.checked)} className="mt-1" />
                    <span><strong>Livestock Legal Disclaimer:</strong> I acknowledge and agree that I am solely responsible for negotiating all livestock sales. Global Grange Inc. bears no legal responsibility for any facet of such sales as well as any ensuing consequences arising from said transactions.</span>
                  </label>
                  {errors.LivestockLegalDisclaimer && <p className={errorClass}>{errors.LivestockLegalDisclaimer}</p>}

                  <label className="flex items-start gap-2 text-sm text-gray-700 cursor-pointer">
                    <input type="checkbox" checked={form.SalesLegalDisclaimer} onChange={e => update('SalesLegalDisclaimer', e.target.checked)} className="mt-1" />
                    <span><strong>Sales Legal Disclaimer:</strong> I acknowledge and agree that Global Grange Inc. bears no legal responsibility for any facet of sales, including but not limited to the sale of livestock, eggs, fiber/wool, products, and services, as well as any ensuing consequences arising from said transactions.</span>
                  </label>
                  {errors.SalesLegalDisclaimer && <p className={errorClass}>{errors.SalesLegalDisclaimer}</p>}
                </>
              )}

              {errors.submit && (
                <div className="bg-red-50 border border-red-300 text-red-700 rounded px-4 py-3 text-sm">
                  {errors.submit}
                </div>
              )}

              <div className="flex gap-3 mt-4">
                <button onClick={() => setStep(1)} className="flex-1 border border-gray-300 rounded px-4 py-2 text-sm text-gray-600 hover:bg-gray-50">
                  ← Back
                </button>
                <button onClick={handleSubmit} disabled={submitting} className="regsubmit2 flex-1">
                  {submitting ? 'Creating...' : 'Create Account'}
                </button>
              </div>
            </div>
          )}

        </div>
      </div>

      <Footer />
    </div>
  );
}
