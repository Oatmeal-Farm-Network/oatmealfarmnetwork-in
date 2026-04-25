import React, { useState, useEffect } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const API_BASE_URL = import.meta.env.VITE_API_URL;

class ApiClient {
  constructor() { this.token = localStorage.getItem('access_token'); }
  async request(endpoint, options = {}) {
    const headers = { 'Content-Type': 'application/json', ...options.headers };
    if (this.token) headers['Authorization'] = `Bearer ${this.token}`;
    const response = await fetch(`${API_BASE_URL}${endpoint}`, { ...options, headers });
    if (response.status === 401) { window.location.href = '/login'; }
    if (!response.ok) { const error = await response.json().catch(() => ({ detail: 'Request failed' })); throw new Error(error.detail || 'Request failed'); }
    return response.json();
  }
  getDashboardSummary(businessId) { return this.request(`/api/dashboard/summary?business_id=${businessId}`); }
  getFields(businessId) { return this.request(`/api/fields?business_id=${businessId}`); }
}

const api = new ApiClient();

function SummaryCard({ title, value, bg }) {
  return (
    <div className="flex-1 rounded-[12px] shadow-lg" style={{ height: 140, background: bg }}>
      <div className="h-full px-6 py-4 flex flex-col justify-center gap-[10px]">
        <div className="text-[18px] font-semibold text-black">{title}</div>
        <div className="text-[36px] font-bold text-black">{value}</div>
      </div>
    </div>
  );
}

export default function OatSense() {
  const [searchParams] = useSearchParams();
  // searchParams.get can return the literal string 'null' if a Link was
  // generated with a null BusinessID — coerce to a real positive int or null.
  const rawBusinessID = searchParams.get('BusinessID');
  const BusinessID = (() => {
    if (!rawBusinessID || rawBusinessID === 'null' || rawBusinessID === 'undefined') return null;
    const n = parseInt(rawBusinessID, 10);
    return Number.isFinite(n) && n > 0 ? n : null;
  })();
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  const [summary, setSummary] = useState(null);
  const [fields, setFields] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => { if (BusinessID) LoadBusiness(BusinessID); }, [BusinessID]);

  useEffect(() => {
    if (!BusinessID) return;
    setLoading(true);
    Promise.all([api.getDashboardSummary(BusinessID), api.getFields(BusinessID)])
      .then(([summaryData, fieldsData]) => { setSummary(summaryData); setFields(fieldsData); })
      .catch(err => console.error(err))
      .finally(() => setLoading(false));
  }, [BusinessID]);

  if (!Business) return <div className="p-8 text-gray-500">Loading...</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="OatSense" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'OatSense' }]}>
      <h1 className="text-3xl font-bold text-gray-900 mb-6">OatSense Dashboard</h1>

      {/* Summary Cards */}
      <div className="flex gap-6 mb-8">
        <SummaryCard title="Total Fields" value={summary?.field_count || 0} bg="#6D8E2299" />
        <SummaryCard title="Analyses" value={summary?.analysis_count || 0} bg="#FFC567" />
        <SummaryCard title="Open Alerts" value={summary?.open_alerts || 0} bg="#FF6767" />
        <SummaryCard title="Avg Health" value={summary?.average_health ?? 'N/A'} bg="#2AB9CF" />
      </div>

      {/* Fields List */}
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-xl font-bold text-gray-900">Your Fields</h2>
        <Link
          to={`/precision-ag/fields?BusinessID=${BusinessID}&view=create-field`}
          className="regsubmit2"
        >
          + Add Field
        </Link>
      </div>

      {loading ? (
        <div className="text-gray-500">Loading fields...</div>
      ) : fields.length === 0 ? (
        <div className="text-center py-12 text-gray-500">
         
          <p className="mb-4">No fields yet. Add your first field to get started.</p>
          <Link to={`/precision-ag/fields?BusinessID=${BusinessID}&view=create-field`} className="regsubmit2">
            + Add Field
          </Link>
        </div>
      ) : (
        <div className="flex flex-col gap-4">
          {fields.map(field => (
            <Link
              key={field.fieldid}
              to={`/precision-ag/fields?BusinessID=${BusinessID}&fieldid=${field.fieldid}`}
              className="bg-[#D9D9D9] rounded-[12px] shadow hover:shadow-md transition cursor-pointer block"
              style={{ minHeight: 100 }}
            >
              <div className="h-full px-8 py-4 flex items-center justify-between gap-4">
                <div className="min-w-0 flex-1">
                  <div className="font-bold text-[18px] text-black">{field.name}</div>
                  <div className="flex items-center gap-2 mt-1">
                    <span className="text-red-600 shrink-0">📍</span>
                    <span className="font-semibold text-[16px] text-black shrink-0">Location:</span>
                    <span className="text-[16px] text-black truncate">{field.address}</span>
                  </div>
                </div>
                <div className="bg-white px-4 py-1 rounded-md font-semibold text-black shadow shrink-0 text-[14px]">
                  {field.monitoring_enabled ? 'Active' : 'Inactive'}
                </div>
              </div>
            </Link>
          ))}
        </div>
      )}

      {/* Quick Links */}
      <div className="mt-8 flex gap-3 flex-wrap">
        <Link to={`/oatsense/crop-rotation?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Crop Rotation</Link>
        <Link to={`/oatsense/notes?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Notes</Link>
      </div>
    </AccountLayout>
  );
}
