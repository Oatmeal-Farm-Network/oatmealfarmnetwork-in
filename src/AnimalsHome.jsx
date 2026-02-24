import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';
import { useNavigate } from "react-router-dom";


export default function AnimalsHome() {
  const navigate = useNavigate();
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const { Business, LoadBusiness } = useAccount();
  const [Animals, setAnimals] = useState([]);
  const [Loading, setLoading] = useState(true);
  const [Error, setError] = useState(false);

  useEffect(() => {
    LoadBusiness(BusinessID);

    fetch(`${import.meta.env.VITE_API_URL}/auth/animals?BusinessID=${BusinessID}`)
      .then(Res => Res.json())
      .then(Data => {
        setAnimals(Data);
        setLoading(false);
      })
      .catch(Err => {
        console.error('Error fetching animals:', Err);
        setError(true);
        setLoading(false);
      });
  }, [BusinessID]);

  const FormatCurrency = (Amount) => {
    if (!Amount || Amount === 0) return '';
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(Amount);
  };

  if (!Business || Loading) return <div className="p-8 text-gray-500">Loading...</div>;
  if (Error) return <div className="p-8 text-red-600">Error loading animals.</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID}>

      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold text-green-700">My Animals</h2>
          <Link
            to={`/animals/add?BusinessID=${BusinessID}&PeopleID=${PeopleID}`}
            className="bg-[#819360] hover:bg-[#4d734d] text-white font-bold py-2 px-4 rounded-xl text-sm transition-colors"
          >
            Add Animal
          </Link>
        </div>

        {Animals.length === 0 ? (
          <p className="text-gray-500 text-sm">
            You do not have any animals listed.{' '}
            <Link to={`/animals/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">
              Click here to add one.
            </Link>
          </p>
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
                {Animals.map((Animal) => (
                  <React.Fragment key={Animal.AnimalID}>
                    <tr className="border-b border-gray-100 hover:bg-gray-50">
                      <td className="py-3 px-2">
                        <Link
                          to={`/animals/edit?BusinessID=${BusinessID}&AnimalID=${Animal.AnimalID}`}
                          className="text-[#3D6B34] hover:underline font-medium"
                        >
                          {Animal.FullName} (edit)
                        </Link>
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
                        <div className="flex justify-center gap-3">
                          <Link to={`/animals/edit?BusinessID=${BusinessID}&AnimalID=${Animal.AnimalID}`} className="text-[#3D6B34] hover:underline text-xs">Edit</Link>
                          <span className="text-gray-300">|</span>
                          <Link to={`/animals/photos?BusinessID=${BusinessID}&AnimalID=${Animal.AnimalID}`} className="text-[#3D6B34] hover:underline text-xs">Photos</Link>
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