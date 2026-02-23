import React from 'react';
import { useSearchParams } from 'react-router-dom';
import HeaderGated from './HeaderGated';
import Footer from './Footer';

export default function CropRotation() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <HeaderGated />
      <div className="max-w-7xl mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-gray-900">Crop Rotation</h1>
      </div>
      <Footer />
    </div>
  );
}