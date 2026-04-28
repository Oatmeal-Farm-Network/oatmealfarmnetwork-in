import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';

export default function AccountNav({ Business, BusinessID, PeopleID }) {
  const { t } = useTranslation();
  const BT = Business?.BusinessTypeID;

  return (
    <table className="w-full border-collapse">
      <tbody>

        {/* Produce - BusinessTypeID 8, 10, 14, 26, 29, 31 */}
        {[8, 10, 14, 26, 29, 31].includes(BT) && (
          <tr className="border-b border-gray-200">
            <td className="w-20 py-3 pr-4">
              <img src="/icons/produce.webp" alt={t('account_nav.sec_produce')} className="w-10 h-10" />
            </td>
            <td className="py-3">
              <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_produce')}</p>
              <ul className="flex flex-wrap gap-3 text-sm">
                <li><Link to={`/produce/inventory?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.inventory')}</Link></li>
              </ul>
            </td>
          </tr>
        )}

        {/* Precision Ag - BusinessTypeID 8 only */}
        {BT === 8 && (
          <tr className="border-b border-gray-200">
            <td className="w-20 py-3 pr-4">
              <img alt={t('account_nav.sec_precision_ag')} className="w-10 h-10" />
            </td>
            <td className="py-3">
              <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_precision_ag')}</p>
              <ul className="flex flex-wrap gap-3 text-sm">
                <li><Link to={`/precision-ag/fields?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.dashboard')}</Link></li>
                <li><Link to={`/precision-ag/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.add_field')}</Link></li>
                <li><Link to={`/precision-ag/analyses?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.analyses')}</Link></li>
                <li><Link to={`/oatsense/crop-rotation?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.crop_rotation')}</Link></li>
                <li><Link to={`/oatsense/notes?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.notes')}</Link></li>
              </ul>
            </td>
          </tr>
        )}

        {/* Livestock - BusinessTypeID 8 only */}
        {BT === 8 && (
          <tr className="border-b border-gray-200">
            <td className="w-20 py-3 pr-4">
              <img src="/icons/Livestock.svg" alt={t('account_nav.sec_livestock')} className="w-10 h-10" />
            </td>
            <td className="py-3">
              <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_livestock')}</p>
              <ul className="flex flex-wrap gap-3 text-sm">
                <li><Link to={`/animals?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.animals_list')}</Link></li>
                <li><Link to={`/animals/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.add')}</Link></li>
                <li><Link to={`/animals/delete?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.delete')}</Link></li>
                <li><Link to={`/animals/transfer?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.transfer')}</Link></li>
                <li><Link to={`/animals/stats?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.statistics')}</Link></li>
              </ul>
            </td>
          </tr>
        )}

        {/* Products - all types */}
        <tr className="border-b border-gray-200">
          <td className="w-20 py-3 pr-4">
            <img src="/icons/Products.svg" alt={t('account_nav.sec_products')} className="w-10 h-10" />
          </td>
          <td className="py-3">
            <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_products')}</p>
            <ul className="flex flex-wrap gap-3 text-sm">
              <li><Link to={`/products?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.list')}</Link></li>
              <li><Link to={`/products/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.add')}</Link></li>
              <li><Link to={`/products/settings?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.settings')}</Link></li>
            </ul>
          </td>
        </tr>

        {/* Services - all types */}
        <tr className="border-b border-gray-200">
          <td className="w-20 py-3 pr-4">
            <img src="/icons/Services.svg" alt={t('account_nav.sec_services')} className="w-10 h-10" />
          </td>
          <td className="py-3">
            <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_services')}</p>
            <ul className="flex flex-wrap gap-3 text-sm">
              <li><Link to={`/services?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.list')}</Link></li>
              <li><Link to={`/services/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.add')}</Link></li>
              <li><Link to={`/services/delete?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.delete')}</Link></li>
              <li><Link to={`/services/suggest-category?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.suggest_category')}</Link></li>
            </ul>
          </td>
        </tr>

        {/* Properties - BusinessTypeID 8 or 30 */}
        {[8, 30].includes(BT) && (
          <tr className="border-b border-gray-200">
            <td className="w-20 py-3 pr-4">
              <img src="/icons/RealEstate.svg" alt={t('account_nav.sec_properties')} className="w-10 h-10" />
            </td>
            <td className="py-3">
              <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_properties')}</p>
              <ul className="flex flex-wrap gap-3 text-sm">
                <li><Link to={`/properties?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.properties_list')}</Link></li>
                <li><Link to={`/properties/add?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.add_property')}</Link></li>
              </ul>
            </td>
          </tr>
        )}

        {/* Associations - BusinessTypeID 1 */}
        {BT === 1 && (
          <tr className="border-b border-gray-200">
            <td className="w-20 py-3 pr-4">
              <img src="/icons/Assoc-administration-icon.svg" alt={t('account_nav.sec_associations')} className="w-10 h-10" />
            </td>
            <td className="py-3">
              <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_associations')}</p>
              <ul className="flex flex-wrap gap-3 text-sm">
                <li><Link to={`/association/create?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.create_account')}</Link></li>
                <li><Link to={`/association/delete?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.delete_account')}</Link></li>
              </ul>
            </td>
          </tr>
        )}

        {/* My Website - all types */}
        <tr>
          <td className="w-20 py-3 pr-4">
            <img src="/icons/Website.svg" alt={t('account_nav.sec_website')} className="w-10 h-10" />
          </td>
          <td className="py-3">
            <p className="font-bold text-gray-800 mb-1">{t('account_nav.sec_website')}</p>
            <ul className="flex flex-wrap gap-3 text-sm">
              <li><Link to={`/website/design?BusinessID=${BusinessID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.graphic_design')}</Link></li>
              <li><Link to={`/website/home?BusinessID=${BusinessID}&PeopleID=${PeopleID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.home_page')}</Link></li>
              <li><Link to={`/website/about?BusinessID=${BusinessID}&PeopleID=${PeopleID}`} className="text-[#3D6B34] hover:underline">{t('account_nav.about_page')}</Link></li>
            </ul>
          </td>
        </tr>

      </tbody>
    </table>
  );
}
