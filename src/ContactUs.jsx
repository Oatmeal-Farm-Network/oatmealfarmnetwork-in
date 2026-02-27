import React, { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const CONTACT_RECIPIENT_EMAIL =
  import.meta.env.VITE_CONTACT_RECIPIENT_EMAIL || 'change-this-contact@oatmeal-ai.com';

const newQuestion = () => {
  const left = Math.floor(Math.random() * 10);
  const right = Math.floor(Math.random() * 10);
  return { left, right, answer: left + right };
};

export default function ContactUs() {
  const navigate = useNavigate();
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

  const canSubmit = useMemo(
    () =>
      formData.FName.trim() &&
      formData.LName.trim() &&
      formData.Email.trim() &&
      formData.CommentText.trim() &&
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
      <Header />
      <main className="max-w-3xl mx-auto px-4 py-8 md:py-12">
        <section className="bg-white p-6 md:p-10 rounded-2xl shadow-[0_10px_25px_rgba(74,92,67,0.08)]">
          <header className="mb-6">
            <h1 className="text-3xl md:text-4xl font-bold text-[#4A5C43] mb-2">
              Contact The Oatmeal Farm Network
            </h1>
            <div className="text-sm text-gray-600 border-l-[3px] border-[#4A5C43] pl-4 mb-4">
              <strong>Oatmeal-AI.com</strong>
              <br />
              Medford, Oregon
            </div>
            <p className="text-gray-700">
              Have questions about the Oatmeal Farm Network or our upcoming AI virtual consultants?
              Complete the form below and our team will get back to you shortly.
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
                  First Name <span className="text-red-600">*</span>
                </label>
                <input
                  type="text"
                  name="FName"
                  value={formData.FName}
                  onChange={handleChange}
                  placeholder="First Name"
                  className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-2">
                  Last Name <span className="text-red-600">*</span>
                </label>
                <input
                  type="text"
                  name="LName"
                  value={formData.LName}
                  onChange={handleChange}
                  placeholder="Last Name"
                  className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                  required
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-2">Organization / Farm Name</label>
              <input
                type="text"
                name="BizName"
                value={formData.BizName}
                onChange={handleChange}
                placeholder="e.g. Sunny Valley Farm"
                className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
              />
            </div>

            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-2">
                Email Address <span className="text-red-600">*</span>
              </label>
              <input
                type="email"
                name="Email"
                value={formData.Email}
                onChange={handleChange}
                placeholder="you@example.com"
                className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-2">
                How can we help? <span className="text-red-600">*</span>
              </label>
              <textarea
                name="CommentText"
                value={formData.CommentText}
                onChange={handleChange}
                placeholder="Tell us about your needs or questions."
                rows={5}
                className="w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-[#4A5C43] focus:outline-none focus:ring-2 focus:ring-[#4A5C43]/20"
                required
              />
            </div>

            <div className="bg-gray-100 rounded-xl p-5">
              <label className="block text-sm font-bold text-gray-800 mb-2">Human Verification</label>
              <p className="text-sm text-gray-600 mb-3">Please answer the simple math question below.</p>
              <label className="block text-sm font-semibold text-gray-700 mb-2">
                What is {captcha.left} + {captcha.right}? <span className="text-red-600">*</span>
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

            <button
              type="submit"
              disabled={loading || !canSubmit}
              className="w-full rounded-lg bg-[#4A5C43] text-white font-semibold py-3 px-6 hover:bg-[#3e4d37] transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
            >
              {loading ? 'Sending...' : 'Send Message'}
            </button>
          </form>
        </section>
      </main>
      <Footer />
    </div>
  );
}
