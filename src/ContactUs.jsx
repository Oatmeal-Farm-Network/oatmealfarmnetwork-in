import React, { useMemo, useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';
import Breadcrumbs from './Breadcrumbs';

const CONTACT_RECIPIENT_EMAIL =
  import.meta.env.VITE_CONTACT_RECIPIENT_EMAIL || 'livestockoftheworld@gmail.com';

const newQuestion = () => {
  const left = Math.floor(Math.random() * 10);
  const right = Math.floor(Math.random() * 10);
  return { left, right, answer: left + right };
};

export default function ContactUs() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [captcha, setCaptcha] = useState(() => newQuestion());
  const [formData, setFormData] = useState({
    FName: '',
    LName: '',
    BizName: '',
    Email: '',
    CommentText: '',
    fieldX: '',
    shoesize: '',
  });

  useEffect(() => {
    const token = localStorage.getItem('access_token');
    setIsLoggedIn(Boolean(token));
  }, []);

  const canSubmit = useMemo(
    () =>
      formData.FName.trim() &&
      formData.LName.trim() &&
      formData.Email.trim() &&
      formData.fieldX.trim(),
    [formData]
  );

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');

    if (formData.shoesize.trim().length > 0) {
      setError('Submission blocked.');
      return;
    }

    if (Number(formData.fieldX) !== captcha.answer) {
      setError('Please answer the math question correctly.');
      setCaptcha(newQuestion());
      setFormData((prev) => ({ ...prev, fieldX: '' }));
      return;
    }

    try {
      setLoading(true);
      const payload = {
        FName: formData.FName.trim(),
        LName: formData.LName.trim(),
        BizName: formData.BizName.trim(),
        Email: formData.Email.trim(),
        CommentText: formData.CommentText.trim(),
      };

      const postData = new FormData();
      postData.append('_subject', `Contact Form: ${payload.FName} ${payload.LName}`);
      postData.append('_captcha', 'false');
      postData.append('First Name', payload.FName);
      postData.append('Last Name', payload.LName);
      postData.append('Organization / Farm Name', payload.BizName || 'N/A');
      postData.append('Email', payload.Email);
      postData.append('Message', payload.CommentText);

      const response = await fetch(`https://formsubmit.co/ajax/${CONTACT_RECIPIENT_EMAIL}`, {
        method: 'POST',
        body: postData,
      });
      const result = await response.json();

      if (!response.ok || (result.success !== 'true' && result.success !== true)) {
        throw new Error(result.message || 'Unable to send message at this time.');
      }

      navigate('/contact-us/confirm', {
        state: {
          submittedAt: new Date().toISOString(),
          payload,
        },
      });
    } catch (submitError) {
      setError(submitError?.message || 'Unable to send message at this time.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#FBF9F4]">
      <PageMeta
        title="Contact Us | Oatmeal Farm Network"
        description="Get in touch with the Oatmeal Farm Network team. We're here to help with questions about your farm listing, marketplace, or platform features."
        keywords="contact oatmeal farm network, support, farm platform help, get listed, farm directory contact"
        canonical="https://oatmealfarmnetwork.com/contact-us"
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'ContactPage',
          name: 'Contact Oatmeal Farm Network',
          url: 'https://oatmealfarmnetwork.com/contact-us',
        }}
      />
       <Header />
      <main className="max-w-3xl mx-auto px-4 py-8 md:py-12">
        <Breadcrumbs items={[
          { label: 'Home', to: '/' },
          { label: 'Contact Us' },
        ]} />
        <section className="bg-white p-6 md:p-10 rounded-2xl shadow-[0_10px_25px_rgba(74,92,67,0.08)]">
          <header className="mb-6">
            <h1 className="text-3xl md:text-4xl font-bold text-[#4A5C43] mb-2">
              {t('contact.title')}
            </h1>
            <p className="text-gray-700">
              {t('contact.subtitle')}
            </p>
          </header>

          {error && (
            <div className="mb-4 rounded-md border border-red-300 bg-red-50 px-4 py-3 text-red-700">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-2">
                  {t('auth.field_first_name')}
                </label>
                <input
                  type="text"
                  name="FName"
                  value={formData.FName}
                  onChange={handleChange}
                  placeholder={t('auth.field_first_name')}
                  className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-2">
                  {t('auth.field_last_name')}
                </label>
                <input
                  type="text"
                  name="LName"
                  value={formData.LName}
                  onChange={handleChange}
                  placeholder={t('auth.field_last_name')}
                  className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                  required
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-2">{t('contact.field_org')} <span className="text-gray-400 font-normal">{t('contact.org_optional')}</span></label>
              <input
                type="text"
                name="BizName"
                value={formData.BizName}
                onChange={handleChange}
                placeholder={t('contact.org_placeholder')}
                className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
              />
            </div>

            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-2">
                {t('auth.field_email')}
              </label>
              <input
                type="email"
                name="Email"
                value={formData.Email}
                onChange={handleChange}
                placeholder={t('auth.email_placeholder')}
                className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-2">
                {t('contact.field_message')} <span className="text-gray-400 font-normal">{t('contact.org_optional')}</span>
              </label>
              <textarea
                name="CommentText"
                value={formData.CommentText}
                onChange={handleChange}
                placeholder={t('contact.message_placeholder')}
                rows={5}
                className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
              />
            </div>

            <div className="bg-gray-100 rounded-xl p-5">
              <label className="block text-sm font-bold text-gray-800 mb-2">{t('contact.captcha_title')}</label>
              <p className="text-sm text-gray-600 mb-3">{t('contact.captcha_subtitle')}</p>
              <label className="block text-sm font-semibold text-gray-700 mb-2">
                {t('contact.captcha_q', { left: captcha.left, right: captcha.right })}
              </label>
              <input
                type="text"
                name="fieldX"
                value={formData.fieldX}
                onChange={handleChange}
                className="w-24 rounded-lg border border-gray-300 px-3 py-2 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                required
              />
            </div>

            <input
              type="text"
              name="shoesize"
              value={formData.shoesize}
              onChange={handleChange}
              tabIndex={-1}
              autoComplete="off"
              className="hidden"
            />

            <div className="flex justify-end">
              <button
                type="submit"
                disabled={loading || !canSubmit}
                className="rounded-lg bg-[#4A5C43] text-white font-semibold py-3 px-10 hover:bg-[#3e4d37] transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
              >
                {loading ? t('contact.sending') : t('contact.send_btn')}
              </button>
            </div>
          </form>
        </section>
      </main>
      <Footer />
    </div>
  );
}
