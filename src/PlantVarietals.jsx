import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

export default function PlantVarietals() {
  const { plantId } = useParams();
  const [plantName, setPlantName] = useState('');
  const [varietals, setVarietals] = useState([]);
  const [loading, setLoading] = useState(true);
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    setIsLoggedIn(Boolean(token));

    fetch(`${API_URL}/api/plant-knowledgebase/varietals/${plantId}`)
      .then(r => r.ok ? r.json() : { plant_name: '', varietals: [] })
      .then(data => {
        setPlantName(data.plant_name || '');
        setVarietals(data.varietals || []);
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [plantId]);

  const na = v => (v === null || v === undefined || v === '') ? 'N/A' : v;
  const water = (min, max) => (min == null || max == null) ? 'N/A' : `${min} - ${max}`;

  return (
    <div className="min-h-screen bg-white font-sans">
      <PageMeta
        title={plantName ? `${plantName} Varietals | Plant Knowledgebase` : 'Plant Varietals | Plant Knowledgebase'}
        description={plantName ? `Browse all known varietals of ${plantName} including growing requirements, soil preferences, water needs, and nutritional profiles.` : 'Browse plant varietals in the Oatmeal Farm Network plant knowledgebase.'}
      />
     <Header />

      <div style={{ maxWidth: '1000px', margin: '0 auto', padding: '1rem 1rem 3rem' }}>
        <h1 className="text-2xl font-bold text-gray-900 mb-2">{plantName} Varietals</h1>
        <p className="text-gray-700 mb-6">
          Below is a list of all known varietals for {plantName}. Click on a varietal name to view more detailed information.
        </p>

        {loading ? (
          <div className="text-gray-400 py-12 text-center">Loading...</div>
        ) : varietals.length === 0 ? (
          <div className="text-gray-500 py-8 text-center">No varietals found for {plantName}.</div>
        ) : (
          <div className="overflow-x-auto rounded border border-gray-200 shadow-sm">
            <table className="w-full text-sm border-collapse" style={{ minWidth: '800px' }}>
              <thead>
                <tr className="bg-gray-50 text-gray-600 text-xs uppercase tracking-wide">
                  <th className="px-4 py-3 text-left border-b border-gray-200">Varietal Name</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Description</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Soil Texture</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">pH Range</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Organic Matter</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Salinity Level</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Hardiness Zone</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Humidity</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Water (in/wk)</th>
                  <th className="px-4 py-3 text-left border-b border-gray-200">Primary Nutrient</th>
                </tr>
              </thead>
              <tbody>
                {varietals.map((v, i) => (
                  <tr key={v.plant_variety_id} className={i % 2 === 0 ? 'bg-white' : 'bg-gray-50'}>
                    <td className="px-4 py-3 border-b border-gray-100">
                      <Link
                        to={`/plant-knowledgebase/varietal-detail/${v.plant_variety_id}`}
                        className="hover:underline"
                        style={{ color: '#3D6B34' }}
                      >
                        {v.plant_variety_name}
                      </Link>
                    </td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700" style={{ maxWidth: '220px' }}>
                      {na(v.plant_variety_description)}
                    </td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{na(v.soil_texture)}</td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{na(v.ph_range)}</td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{na(v.organic_matter)}</td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{na(v.salinity_level)}</td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{na(v.zone)}</td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{na(v.humidity)}</td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{water(v.water_min, v.water_max)}</td>
                    <td className="px-4 py-3 border-b border-gray-100 text-gray-700">{na(v.primary_nutrient)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <Footer />
    </div>
  );
}
