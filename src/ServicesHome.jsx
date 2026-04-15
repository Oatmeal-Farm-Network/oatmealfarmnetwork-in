import React, { useEffect, useState } from 'react';
import { useSearchParams, Link, useNavigate } from 'react-router-dom';
import AccountLayout from './AccountLayout';
import { useAccount } from './AccountContext';

const apiBase = import.meta.env.VITE_API_URL || '';

export default function ServicesHome() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const BusinessID = searchParams.get('BusinessID');
  const PeopleID = localStorage.getItem('people_id');
  const { Business, LoadBusiness } = useAccount();

  const [Services, setServices] = useState([]);
  const [Loading, setLoading] = useState(true);
  const [hasError, setHasError] = useState(false);

  useEffect(() => {
    if (!BusinessID) return;
    LoadBusiness(BusinessID);

    fetch(`${apiBase}/api/services?BusinessID=${BusinessID}`, {
      headers: { Authorization: `Bearer ${localStorage.getItem('access_token')}` },
    })
      .then(res => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.json();
      })
      .then(data => {
        setServices(Array.isArray(data) ? data : []);
        setLoading(false);
      })
      .catch(err => {
        console.error('Error fetching services:', err);
        setHasError(true);
        setLoading(false);
      });
  }, [BusinessID]);

  if (!Business || Loading) return <div className="p-8 text-gray-500">Loading...</div>;
  if (hasError) return <div className="p-8 text-red-600">Error loading services.</div>;

  return (
    <AccountLayout Business={Business} BusinessID={BusinessID} PeopleID={PeopleID} pageTitle="My Services" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'Services' }, { label: 'My Services' }]}>
      <div className="bg-white rounded-2xl shadow border border-gray-200 p-6">

        {/* Header */}
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold text-green-700">My Services</h2>
          <Link
            to={`/services/add?BusinessID=${BusinessID}`}
            className="regsubmit2"
          >
            Add Service
          </Link>
        </div>

        {/* Empty state */}
        {Services.length === 0 ? (
          <p className="text-gray-500 text-sm">
            You do not have any services listed.{' '}
            <Link
              to={`/services/add?BusinessID=${BusinessID}`}
              className="text-[#3D6B34] hover:underline"
            >
              Click here to add one.
            </Link>
          </p>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b-2 border-gray-300">
                  <th className="text-left py-3 px-2 text-gray-600 font-semibold">Service</th>
                  <th className="text-left py-3 px-2 text-gray-600 font-semibold hidden md:table-cell">Available</th>
                  <th className="text-left py-3 px-2 text-gray-600 font-semibold hidden md:table-cell">Price / Rate</th>
                  <th className="text-right py-3 px-2 text-gray-600 font-semibold">Options</th>
                </tr>
              </thead>
              <tbody>
                {Services.map(Service => (
                  <React.Fragment key={Service.ServicesID}>
                    <tr className="border-b border-gray-100 hover:bg-gray-50">

                      {/* Title */}
                      <td className="py-3 px-2">
                        <span
                          onClick={() => navigate(`/services/edit?BusinessID=${BusinessID}&ServicesID=${Service.ServicesID}`)}
                          className="cursor-pointer text-[#5a3e2b] underline hover:text-[#3a2010]"
                        >
                          {Service.ServiceTitle}
                        </span>
                      </td>

                      {/* Available */}
                      <td className="py-3 px-2 hidden md:table-cell text-gray-600">
                        {Service.ServiceAvailable || '—'}
                      </td>

                      {/* Price */}
                      <td className="py-3 px-2 hidden md:table-cell text-gray-600">
                        {Service.ServicePrice
                          ? `$${parseFloat(Service.ServicePrice).toLocaleString()}`
                          : Service.ServiceContactForPrice === 'Yes'
                          ? 'Contact for price'
                          : '—'}
                      </td>

                      {/* Options */}
                      <td className="py-3 px-2 text-right">
                        <div className="flex justify-end gap-3 items-center">
                          <button
                            onClick={() => navigate(`/services/edit?BusinessID=${BusinessID}&ServicesID=${Service.ServicesID}`)}
                            className="text-[#5a3e2b] hover:underline text-xs font-medium"
                          >
                            Edit
                          </button>
                          <span className="text-gray-300">|</span>
                          <Link
                            to={`/services/photos?BusinessID=${BusinessID}&ServicesID=${Service.ServicesID}`}
                            className="text-[#3D6B34] hover:underline text-xs"
                          >
                            Photos
                          </Link>
                          <span className="text-gray-300">|</span>
                          <Link
                            to={`/services/delete?BusinessID=${BusinessID}&ServicesID=${Service.ServicesID}`}
                            className="text-red-500 hover:underline text-xs"
                          >
                            Delete
                          </Link>
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