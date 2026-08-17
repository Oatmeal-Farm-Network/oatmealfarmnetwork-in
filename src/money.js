// India money + GST helpers. UI stays English; amounts are INR.

export const DEFAULT_CURRENCY = 'INR';
export const DEFAULT_LOCALE = 'en-IN';

/** Typical GST slabs. Fresh farm produce is often 0%; processed / packaged goods 5–18%. */
export const GST_RATES = [0, 0.05, 0.12, 0.18, 0.28];
export const DEFAULT_GST_RATE = 0.05;

export function formatMoney(n, { currency = DEFAULT_CURRENCY, digits = 0, locale = DEFAULT_LOCALE } = {}) {
  const num = Number(n);
  if (!Number.isFinite(num)) return '—';
  return num.toLocaleString(locale, {
    style: 'currency',
    currency,
    maximumFractionDigits: digits,
    minimumFractionDigits: digits,
  });
}

export function formatInr(n, opts = {}) {
  return formatMoney(n, { currency: 'INR', ...opts });
}

export function gstAmount(taxable, rate = DEFAULT_GST_RATE) {
  const n = Number(taxable) || 0;
  const r = Number(rate) || 0;
  return Math.round(n * r * 100) / 100;
}

export function withGst(taxable, rate = DEFAULT_GST_RATE) {
  const n = Number(taxable) || 0;
  return n + gstAmount(n, rate);
}
