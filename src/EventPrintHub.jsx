import React from 'react';
import { useParams, Link } from 'react-router-dom';
import EventAdminLayout from './EventAdminLayout';

const CARDS = [
  {
    key: 'nametags',
    icon: '🏷️',
    title: 'Nametags',
    desc: 'Printable nametags for every paid attendee. Avery 5163 (2" × 4") layout, 10 per sheet.',
  },
  {
    key: 'barn-cards',
    icon: '🐑',
    title: 'Barn Cards',
    desc: 'One card per registered animal with owner, classes entered, and IDs. Tape to each stall.',
  },
  {
    key: 'class-sheets',
    icon: '📋',
    title: 'Judge\u2019s Class Sheets',
    desc: 'One page per halter class, with back numbers and placement columns for the judge.',
  },
];

export default function EventPrintHub() {
  const { eventId } = useParams();
  return (
    <EventAdminLayout eventId={eventId}>
      <div className="max-w-4xl">
        <h1 className="text-2xl font-semibold text-[#3D6B34]">Printouts</h1>
        <p className="text-sm text-gray-600 mt-1 mb-6">
          Pre-event and show-day print materials. Each page uses your browser\u2019s print dialog \u2014
          set margins to <strong>None</strong> and paper size to <strong>Letter</strong>.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {CARDS.map(c => (
            <Link key={c.key}
              to={`/events/${eventId}/admin/print/${c.key}`}
              className="bg-white rounded-xl shadow p-5 hover:shadow-md hover:border-[#3D6B34] border border-transparent transition">
              <div className="text-3xl mb-2">{c.icon}</div>
              <div className="font-semibold text-gray-800 mb-1">{c.title}</div>
              <div className="text-xs text-gray-500 leading-relaxed">{c.desc}</div>
            </Link>
          ))}
        </div>
      </div>
    </EventAdminLayout>
  );
}
