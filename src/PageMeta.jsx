/**
 * PageMeta — sets <title>, meta description, Open Graph, and Twitter Card tags
 * by directly manipulating the DOM head. No external library needed.
 *
 * Usage:
 *   <PageMeta
 *     title="Page Title | Oatmeal Farm Network"
 *     description="Page description for search engines."
 *     image="/images/og-default.jpg"   // optional, absolute URL or path
 *     canonical="https://oatmealfarmnetwork.com/some-path"  // optional
 *     noIndex={false}  // optional, defaults to false
 *   />
 */
import { useEffect } from 'react';

const SITE_NAME   = 'Oatmeal Farm Network';
const DEFAULT_IMG = 'https://oatmealfarmnetwork.com/images/Oatmeal-Farm-Network-og-default.jpg';
const BASE_URL    = 'https://oatmealfarmnetwork.com';

function setMeta(name, content) {
  if (!content) return;
  let el = document.querySelector(`meta[name="${name}"]`);
  if (!el) { el = document.createElement('meta'); el.setAttribute('name', name); document.head.appendChild(el); }
  el.setAttribute('content', content);
}

function setOG(property, content) {
  if (!content) return;
  let el = document.querySelector(`meta[property="${property}"]`);
  if (!el) { el = document.createElement('meta'); el.setAttribute('property', property); document.head.appendChild(el); }
  el.setAttribute('content', content);
}

function setCanonical(href) {
  let el = document.querySelector('link[rel="canonical"]');
  if (!el) { el = document.createElement('link'); el.setAttribute('rel', 'canonical'); document.head.appendChild(el); }
  el.setAttribute('href', href);
}

export default function PageMeta({ title, description, image, canonical, noIndex = false, ogType = 'website' }) {
  useEffect(() => {
    const fullTitle = title
      ? (title.includes(SITE_NAME) ? title : `${title} | ${SITE_NAME}`)
      : SITE_NAME;
    const img    = image || DEFAULT_IMG;
    const canon  = canonical || (BASE_URL + window.location.pathname);
    const desc   = description || '';

    document.title = fullTitle;

    // Standard meta
    setMeta('description', desc);
    setMeta('robots', noIndex ? 'noindex,nofollow' : 'index,follow');

    // Open Graph
    setOG('og:type',        ogType);
    setOG('og:title',       fullTitle);
    setOG('og:description', desc);
    setOG('og:image',       img);
    setOG('og:url',         canon);
    setOG('og:site_name',   SITE_NAME);

    // Twitter Card
    setMeta('twitter:card',        'summary_large_image');
    setMeta('twitter:title',       fullTitle);
    setMeta('twitter:description', desc);
    setMeta('twitter:image',       img);

    setCanonical(canon);
  }, [title, description, image, canonical, noIndex, ogType]);

  return null;
}
