import React, { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import HeaderGated from './HeaderGated';
import Footer from './Footer';

export default function AccountHome() {
  const [SearchParams] = useSearchParams();
  const BusinessID = SearchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('PeopleID');
  const [Business, setBusiness] = useState(null);
  const [Error, setError] = useState(false);

  useEffect(() => {
fetch(`${import.meta.env.VITE_API_URL}/auth/my-businesses?PeopleID=${PeopleID}`)
      .then(Res => Res.json())
      .then(Data => setBusiness(Data))
      .catch(Err => {
        console.error('Error fetching account:', Err);
        setError(true);
      });
  }, [BusinessID]);

  if (Error) return <div className="p-8 text-red-600">Error loading account.</div>;
  if (!Business) return <div className="p-8 text-gray-500">Loading...</div>;

  const BT = Business.BusinessTypeID;

  return (
    <div className="min-h-screen bg-gray-50 font-sans">
      <HeaderGated />

      <div className="max-w-7xl mx-auto px-4 py-8">
        <div className="bg-white rounded-2xl shadow border border-gray-200 p-6 mb-6">

          {/* Top Info Row */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
            <div>
              <h2 className="text-2xl font-bold text-green-700 mb-4 border-b-2 border-green-300 pb-3">
                {Business.BusinessName}
              </h2>
              <p className="text-sm text-gray-700 mb-1">Account Name: <strong>{Business.BusinessName}</strong></p>
              <p className="text-sm text-gray-700 mb-1">Account Type: <strong>{Business.BusinessType}</strong></p>
              <Link to={`/account/change-type?BusinessID=${BusinessID}`} className="text-xs text-[#819360] hover:underline">Change Account Type</Link>
              <p className="text-sm text-gray-700 mt-2 mb-1">Subscription Level: <strong>{Business.SubscriptionLevel}</strong></p>
              <p className="text-sm text-gray-700 mb-1">Subscription Ends: <strong>{Business.SubscriptionEndDate || 'Not Set'}</strong></p>
            </div>
            <div className="flex flex-col gap-2 justify-start pt-8">
              <Link to={`/account/profile?BusinessID=${BusinessID}`} className="text-sm text-[#3D6B34] hover:underline">Account Profile</Link>
              <Link to="/account/renew" className="text-sm text-[#3D6B34] hover:underline">Renew / Upgrade Membership</Link>
              <Link to={`/account/delete?BusinessID=${BusinessID}`} className="text-sm text-red-600 hover:underline">Delete Account</Link>
            </div>
          </div>

          {/* Features Table */}
          <table className="w-full border-collapse">
            <tbody>

              {/* Produce - BusinessTypeID 8, 10, 14, 26, 29, 31 */}
              {[8, 10, 14, 26, 29, 31].includes(BT) && (
                <tr className="border-b border-gray-200">
                  <td className="w-20 py-3 pr-4">
                    <img src="/icons/produce.webp" alt="Produce" className="w-10 h-10" />
                  </td>
                  <td className="py-3">
                    <p className="font-bold text-gray-800 mb-1">Produce</p>
                    <ul className="flex flex-wrap gap-3 text-sm">
                      <li><Link to={`/produce/inventory?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Inventory</Link></li>
                    </ul>
                  </td>
                </tr>
              )}


{/* Precision Ag - BusinessTypeID 8 only */}
{BT === 8 && (
  <tr className="border-b border-gray-200">
    <td className="w-20 py-3 pr-4">
      <img  alt="Precision Ag" className="w-10 h-10" />
    </td>
    <td className="py-3">
      <p className="font-bold text-gray-800 mb-1">Oatsense Precision Ag</p>
      <ul className="flex flex-wrap gap-3 text-sm">
         <li><Link to={`/oatsense?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Dashboard</Link></li>
  <li><Link to={`/precision-ag/fields?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Fields</Link></li>
  <li><Link to={`/precision-ag/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Add Field</Link></li>
  <li><Link to={`/precision-ag/analyses?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Analyses</Link></li>
     <Link to={`/oatsense/crop-rotation?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Crop Rotation</Link>
      <Link to={`/oatsense/notes?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline text-sm">Notes</Link>
 </ul>
    </td>
  </tr>
)}

              {/* Livestock - BusinessTypeID 8 only */}
              {BT === 8 && (
                <tr className="border-b border-gray-200">
                  <td className="w-20 py-3 pr-4">
                    <img src="/icons/Livestock.svg" alt="Livestock" className="w-10 h-10" />
                  </td>
                  <td className="py-3">
                    <p className="font-bold text-gray-800 mb-1">Livestock</p>
                    <ul className="flex flex-wrap gap-3 text-sm">
                      <li><Link to={`/animals?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">List of Animals</Link></li>
                      <li><Link to={`/animals/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Add</Link></li>
                      <li><Link to={`/animals/delete?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Delete</Link></li>
                      <li><Link to={`/animals/transfer?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Transfer</Link></li>
                      <li><Link to={`/animals/stats?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Statistics</Link></li>
                    </ul>
                  </td>
                </tr>
              )}

              {/* Products - all types */}
              <tr className="border-b border-gray-200">
                <td className="w-20 py-3 pr-4">
                  <img src="/icons/Products.svg" alt="Products" className="w-10 h-10" />
                </td>
                <td className="py-3">
                  <p className="font-bold text-gray-800 mb-1">Products</p>
                  <ul className="flex flex-wrap gap-3 text-sm">
                    <li><Link to={`/products?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">List</Link></li>
                    <li><Link to={`/products/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Add</Link></li>
                    <li><Link to={`/products/settings?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Settings</Link></li>
                  </ul>
                </td>
              </tr>

              {/* Services - all types */}
              <tr className="border-b border-gray-200">
                <td className="w-20 py-3 pr-4">
                  <img src="/icons/Services.svg" alt="Services" className="w-10 h-10" />
                </td>
                <td className="py-3">
                  <p className="font-bold text-gray-800 mb-1">Services</p>
                  <ul className="flex flex-wrap gap-3 text-sm">
                    <li><Link to={`/services?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">List</Link></li>
                    <li><Link to={`/services/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Add</Link></li>
                    <li><Link to={`/services/delete?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Delete</Link></li>
                    <li><Link to={`/services/suggest-category?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Suggest Category</Link></li>
                  </ul>
                </td>
              </tr>

              {/* Properties - BusinessTypeID 8 or 30 */}
              {[8, 30].includes(BT) && (
                <tr className="border-b border-gray-200">
                  <td className="w-20 py-3 pr-4">
                    <img src="/icons/RealEstate.svg" alt="Properties" className="w-10 h-10" />
                  </td>
                  <td className="py-3">
                    <p className="font-bold text-gray-800 mb-1">Properties</p>
                    <ul className="flex flex-wrap gap-3 text-sm">
                      <li><Link to={`/properties?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">List of Properties</Link></li>
                      <li><Link to={`/properties/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Add a Property</Link></li>
                    </ul>
                  </td>
                </tr>
              )}

              {/* Associations - BusinessTypeID 1 */}
              {BT === 1 && (
                <tr className="border-b border-gray-200">
                  <td className="w-20 py-3 pr-4">
                    <img src="/icons/Assoc-administration-icon.svg" alt="Associations" className="w-10 h-10" />
                  </td>
                  <td className="py-3">
                    <p className="font-bold text-gray-800 mb-1">Associations</p>
                    <ul className="flex flex-wrap gap-3 text-sm">
                      <li><Link to={`/association/create?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Create Account</Link></li>
                      <li><Link to={`/association/delete?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Delete Account</Link></li>
                    </ul>
                  </td>
                </tr>
              )}

              {/* My Website - all types */}
              <tr>
                <td className="w-20 py-3 pr-4">
                  <img src="/icons/Website.svg" alt="Website" className="w-10 h-10" />
                </td>
                <td className="py-3">
                  <p className="font-bold text-gray-800 mb-1">My Website</p>
                  <ul className="flex flex-wrap gap-3 text-sm">
                    <li><Link to={`/website/design?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">Graphic Design</Link></li>
                    <li><Link to={`/website/home?BusinessID=${BusinessID}&PeopleID=${PeopleID}`} className="text-[#3D6B34] hover:underline">Home Page</Link></li>
                    <li><Link to={`/website/about?BusinessID=${BusinessID}&PeopleID=${PeopleID}`} className="text-[#3D6B34] hover:underline">About Us Page</Link></li>
                  </ul>
                </td>
              </tr>

            </tbody>
          </table>
        </div>
      </div>

      <Footer />
    </div>
  );
}