import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';

export default function Footer() {
  const { t } = useTranslation();
  const isLoggedIn = !!localStorage.getItem('access_token');

  if (isLoggedIn) {
    return (
      <footer className="bg-[#1a1a1a] text-white py-4 mt-12">
        <div className="text-center">
          <p className="text-gray-500 text-xs tracking-[0.2em]">{t('footer.copyright', { year: new Date().getFullYear() })}</p>
        </div>
      </footer>
    );
  }

  return (
    <footer className="bg-[#1a1a1a] text-white py-12 mt-12">
      <div className="max-w-7xl mx-auto px-4">

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">

          {/* Brand */}
          <div>
            <img
              src="/images/Oatmeal-Farm-Network-logo-horizontal-white.webp"
              alt="Oatmeal Farm Network"
              className="h-10 mb-4"
            />
            <p className="text-gray-400 text-sm leading-relaxed">
              {t('footer.tagline')}
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="footer">{t('footer.explore')}</h3>
            <ul className="space-y-2 text-sm">
              <li><Link to="/directory" className="footer">{t('footer.food_directory')}</Link></li>
              <li><Link to="/plants" className="footer">{t('footer.plant_kb')}</Link></li>
              <li><Link to="/livestock" className="footer">{t('footer.livestock_db')}</Link></li>
              <li><Link to="/ingredients" className="footer">{t('footer.ingredient_kb')}</Link></li>
              <li><Link to="/marketplaces/livestock" className="footer">{t('footer.livestock_marketplace')}</Link></li>
            </ul>
          </div>

          {/* Company */}
          <div>
            <h3 className="footer">{t('footer.company')}</h3>
            <ul className="space-y-2 text-sm">
              <li><Link to="/about" className="footer">{t('footer.about_us')}</Link></li>
              <li><Link to="/saige" className="footer">{t('footer.saige_ai')}</Link></li>
              <li><Link to="/login" className="footer">{t('footer.login')}</Link></li>
              <li><Link to="/signup" className="footer">{t('footer.signup')}</Link></li>
            </ul>
          </div>

        </div>

        <div className="border-t border-gray-800 pt-6 text-center">
          <p className="text-gray-500 text-xs tracking-[0.2em]">{t('footer.copyright', { year: new Date().getFullYear() })}</p>
        </div>

      </div>
    </footer>
  );
}
