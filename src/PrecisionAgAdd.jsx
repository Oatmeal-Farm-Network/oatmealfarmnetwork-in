import React from 'react';
import { useSearchParams } from 'react-router-dom';
import HeaderGated from './HeaderGated';
import Footer from './Footer';

export default function PrecisionAgAdd() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <HeaderGated />
      <div className="max-w-7xl mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-gray-900">Add Field</h1>
      </div>
      <Footer />
    </div>
  );
}