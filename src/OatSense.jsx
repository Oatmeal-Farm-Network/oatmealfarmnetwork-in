import React from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import HeaderGated from './HeaderGated';
import Footer from './Footer';

export default function OatSense() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <HeaderGated />

      <div className="max-w-7xl mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-gray-900 mb-6">OatSense Dashboard</h1>
        <div className="flex flex-col gap-3 max-w-xs">
          <Link to={`/oatsense/crop-rotation?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Crop Rotation</Link>
          <Link to={`/oatsense/notes?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Notes</Link>
        </div>
      </div>

      <Footer />
    </div>
  );
}