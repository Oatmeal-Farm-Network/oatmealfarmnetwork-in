import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { useAccount } from './AccountContext';
import HerdHealthLayout from './HerdHealthLayout';

const API = import.meta.env.VITE_API_URL;
const ACCENT = '#3D6B34';

function StatCard({ label, value, sub, color }) {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4">
      <div className="font-mont text-xs text-gray-500 mb-1">{label}</div>
      <div className="font-lora text-2xl font-bold" style={{ color: color || '#1F2937' }}>{value ?? '—'}</div>
      {sub && <div className="font-mont text-xs text-gray-400 mt-0.5">{sub}</div>}
    </div>
  );
}

export default function HerdHealthReports() {
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const { Business, LoadBusiness } = useAccount();
  const [summary, setSummary] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => { LoadBusiness(BusinessID); }, [BusinessID]);
  const load = useCallback(() => {
    if (!BusinessID) return;
    setLoading(true);
    fetch(`${API}/api/herd-health/dashboard?business_id=${BusinessID}`)
      .then(r => r.ok ? r.json() : null).then(setSummary).catch(() => setSummary(null))
      .finally(() => setLoading(false));
  }, [BusinessID]);
  useEffect(() => { load(); }, [load]);

  const sections = [
    {
      title: 'Vaccination Compliance',
      icon: '💉',
      description: 'View overdue vaccinations and upcoming due dates.',
      link: `/herd-health/vaccinations?BusinessID=${BusinessID}`,
      stat: summary ? `${summary.overdue_vaccinations ?? 0} overdue` : null,
      statColor: summary?.overdue_vaccinations > 0 ? '#EF4444' : '#10B981',
    },
    {
      title: 'Active Withdrawals',
      icon: '⏱',
      description: 'Animals currently under meat or milk withdrawal periods.',
      link: `/herd-health/treatments?BusinessID=${BusinessID}`,
      stat: summary ? `${summary.active_withdrawals ?? 0} active` : null,
      statColor: summary?.active_withdrawals > 0 ? '#EF4444' : '#10B981',
    },
    {
      title: 'Medication Inventory',
      icon: '💊',
      description: 'Items expiring within 30 days or below reorder point.',
      link: `/herd-health/medications?BusinessID=${BusinessID}`,
      stat: summary ? `${(summary.expiring_medications ?? 0) + (summary.low_stock_medications ?? 0)} alerts` : null,
      statColor: ((summary?.expiring_medications ?? 0) + (summary?.low_stock_medications ?? 0)) > 0 ? '#F59E0B' : '#10B981',
    },
    {
      title: 'Active Quarantine',
      icon: '🔒',
      description: 'Animals currently in isolation or quarantine.',
      link: `/herd-health/quarantine?BusinessID=${BusinessID}`,
      stat: summary ? `${summary.active_quarantine ?? 0} animals` : null,
      statColor: summary?.active_quarantine > 0 ? '#EF4444' : '#10B981',
    },
    {
      title: 'Open Health Events',
      icon: '📋',
      description: 'Unresolved health events requiring attention.',
      link: `/herd-health/events?BusinessID=${BusinessID}`,
      stat: summary ? `${summary.open_events ?? 0} open` : null,
      statColor: summary?.open_events > 0 ? '#F59E0B' : '#10B981',
    },
    {
      title: 'Pending Lab Results',
      icon: '🔬',
      description: 'Lab results awaiting results or vet review.',
      link: `/herd-health/lab-results?BusinessID=${BusinessID}`,
      stat: null,
    },
    {
      title: 'Parasite Pressure',
      icon: '🐛',
      description: 'FAMACHA scores and recent fecal egg count trends.',
      link: `/herd-health/parasites?BusinessID=${BusinessID}`,
      stat: null,
    },
    {
      title: 'Mortality Summary',
      icon: '📉',
      description: 'Year-to-date mortality count by cause.',
      link: `/herd-health/mortality?BusinessID=${BusinessID}`,
      stat: null,
    },
    {
      title: 'Biosecurity Log',
      icon: '🛡',
      description: 'Recent visitor and delivery entries, incident history.',
      link: `/herd-health/biosecurity?BusinessID=${BusinessID}`,
      stat: null,
    },
    {
      title: 'Weight & BCS Trends',
      icon: '⚖️',
      description: 'Body condition score distribution and weight change over time.',
      link: `/herd-health/weight?BusinessID=${BusinessID}`,
      stat: null,
    },
  ];

  return (
    <HerdHealthLayout Business={Business} BusinessID={BusinessID}
      PeopleID={localStorage.getItem('people_id')} pageTitle="Reports"
      breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Herd Health', to: `/herd-health?BusinessID=${BusinessID}` }, { label: 'Reports' }]}>
      <div className="space-y-6 max-w-4xl">
        <div>
          <h1 className="font-lora text-xl font-bold text-gray-900">Herd Health Reports</h1>
          <p className="font-mont text-xs text-gray-500">Summary view of all herd health metrics and quick links to each section.</p>
        </div>

        {loading ? (
          <div className="text-center py-8 font-mont text-sm text-gray-400 animate-pulse">Loading summary…</div>
        ) : summary && (
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
            <StatCard label="Open Events" value={summary.open_events} color={summary.open_events > 0 ? '#F59E0B' : '#10B981'} />
            <StatCard label="Active Quarantine" value={summary.active_quarantine} color={summary.active_quarantine > 0 ? '#EF4444' : '#10B981'} />
            <StatCard label="Overdue Vaccinations" value={summary.overdue_vaccinations} color={summary.overdue_vaccinations > 0 ? '#EF4444' : '#10B981'} />
            <StatCard label="Active Withdrawals" value={summary.active_withdrawals} color={summary.active_withdrawals > 0 ? '#EF4444' : '#10B981'} />
          </div>
        )}

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {sections.map(s => (
            <Link key={s.title} to={s.link}
              className="bg-white rounded-xl border border-gray-200 p-4 flex items-start gap-3 hover:border-green-400 hover:shadow-sm transition-all duration-150 group">
              <div className="text-2xl shrink-0 mt-0.5">{s.icon}</div>
              <div className="min-w-0 flex-1">
                <div className="flex items-center justify-between gap-2">
                  <div className="font-mont font-semibold text-sm text-gray-900 group-hover:text-green-700">{s.title}</div>
                  {s.stat && <div className="font-mont text-xs font-semibold shrink-0" style={{ color: s.statColor }}>{s.stat}</div>}
                </div>
                <div className="font-mont text-xs text-gray-500 mt-0.5">{s.description}</div>
              </div>
              <div className="text-gray-300 group-hover:text-green-500 shrink-0 mt-1">→</div>
            </Link>
          ))}
        </div>
      </div>
    </HerdHealthLayout>
  );
}
