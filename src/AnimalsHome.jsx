import React, { useEffect, useState } from 'react';
import { useSearchParams, Link, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

export default function AnimalsHome() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();
  const [Animals, setAnimals] = useState([]);
  const [Loading, setLoading] = useState(true);
  const [Error, setError] = useState(false);
  const [search, setSearch] = useState('');

  useEffect(() => {
    LoadBusiness(BusinessID);

    const token = localStorage.getItem('access_token');
    const apiBase = import.meta.env.VITE_API_URL || '';
    fetch(`${apiBase}/auth/animals?BusinessID=${BusinessID}`, {
      headers: { Authorization: `Bearer ${token}` },
    })
      .then(res => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.json();
      })
      .then(data => { setAnimals(data); setLoading(false); })
      .catch(() => { setError(true); setLoading(false); });
  }, [BusinessID]);

  const FormatCurrency = (Amount) => {
    if (!Amount || Amount === 0) return '';
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(Amount);
  };

  const filtered = search.trim()
    ? Animals.filter(a =>
        (a.FullName || '').toLowerCase().includes(search.toLowerCase()) ||
        (a.SpeciesName || '').toLowerCase().includes(search.toLowerCase())
      )
    : Animals;

  if (!Business || Loading) return <div className="p-8 text-gray-500">Loading...</div>;
  if (Error) return <div className="p-8 text-red-600">Error loading animals.</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="My Animals" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Livestock' }, { label: 'My Animals' }]}>

      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-2xl font-bold text-green-700">My Animals</h2>
          <Link
            to={`/animals/add?BusinessID=${BusinessID}&PeopleID=${PeopleID}`}
            className="regsubmit2">
            Add Animal
          </Link>
        </div>

        {Animals.length > 0 && (
          <div className="mb-4">
            <input
              type="text"
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Search by name or species…"
              className="w-full md:w-80 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:border-green-600"
            />
            {search && (
              <span className="ml-3 text-sm text-gray-500">
                {filtered.length} of {Animals.length} animals
              </span>
            )}
          </div>
        )}

        {Animals.length === 0 ? (
          <p className="text-gray-500 text-sm">
            You do not have any animals listed.{' '}
            <Link to={`/animals/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">
              Click here to add one.
            </Link>
          </p>
        ) : filtered.length === 0 ? (
          <p className="text-gray-500 text-sm">No animals match "<strong>{search}</strong>".</p>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b-2 border-gray-300">
                  <th className="text-left py-3 px-2 text-gray-600 font-semibold">Listing</th>
                  <th className="text-left py-3 px-2 text-gray-600 font-semibold hidden md:table-cell">Species</th>
                  <th className="text-right py-3 px-2 text-gray-600 font-semibold">Price</th>
                  <th className="text-right py-3 px-2 text-gray-600 font-semibold hidden md:table-cell">Stud Fee</th>
                  <th className="text-center py-3 px-2 text-gray-600 font-semibold hidden md:table-cell">Options</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((Animal) => (
                  <React.Fragment key={Animal.AnimalID}>
                    <tr className="border-b border-gray-100 hover:bg-gray-50">
                      <td className="py-3 px-2">
                        <span
                          onClick={() => navigate(`/animals/edit?BusinessID=${BusinessID}&AnimalID=${Animal.AnimalID}`)}
                          className="cursor-pointer text-[#5a3e2b] underline hover:text-[#3a2010]"
                        >
                          {Animal.FullName || <span className="text-gray-400 italic">Unnamed</span>}
                        </span>
                      </td>
                      <td className="py-3 px-2 hidden md:table-cell text-gray-600">
                        {Animal.SpeciesName}
                      </td>
                      <td className="py-3 px-2 text-right text-gray-600">
                        {FormatCurrency(Animal.Price)}
                        {Animal.SalePrice > 0 && (
                          <span className="text-red-500 ml-1">({FormatCurrency(Animal.SalePrice)})</span>
                        )}
                      </td>
                      <td className="py-3 px-2 text-right text-gray-600 hidden md:table-cell">
                        {Animal.StudFee > 0 ? FormatCurrency(Animal.StudFee) : 'N/A'}
                      </td>
                      <td className="py-3 px-2 text-center hidden md:table-cell">
                        <div className="flex justify-center gap-3 items-center">
                          <button
                            onClick={() => navigate(`/animals/edit?BusinessID=${BusinessID}&AnimalID=${Animal.AnimalID}`)}
                            className="text-[#5a3e2b] hover:underline text-xs font-medium"
                          >
                            Edit
                          </button>
                          <span className="text-gray-300">|</span>
                          <Link to={`/animals/delete?BusinessID=${BusinessID}&AnimalID=${Animal.AnimalID}`} className="text-red-500 hover:underline text-xs">Delete</Link>
                        </div>
                      </td>
                    </tr>
                  </React.Fragment>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

    </AccountLayout>
  );
}
