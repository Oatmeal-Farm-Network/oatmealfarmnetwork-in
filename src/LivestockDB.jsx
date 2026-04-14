import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';
import PageMeta from './PageMeta';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';

const SPECIES = [
  { slug: 'alpacas',           label: 'Alpacas',                  img: '/images/Alpaca.webp',           desc: 'Alpacas are soft-fleeced South American camelids raised primarily for their fiber.' },
  { slug: 'bison',             label: 'Bison',                    img: '/images/Bison.webp',             desc: 'Bison are large, shaggy North American bovines raised for lean, flavorful meat.' },
  { slug: 'buffalo',           label: 'Buffalo',                  img: '/images/Buffalo.webp',           desc: 'Buffalo are raised for their milk, meat, and as draft animals in many parts of Asia.' },
  { slug: 'camels',            label: 'Camels',                   img: '/images/Camels.webp',            desc: 'Camels are raised for milk, meat, wool, and transport in arid regions worldwide.' },
  { slug: 'cattle',            label: 'Cattle',                   img: '/images/Cattle.webp',            desc: 'Cattle are raised for beef, veal, dairy products, leather, and as draft animals.' },
  { slug: 'chickens',          label: 'Chickens',                 img: '/images/Chicken.webp',           desc: 'Chickens are the most widely kept fowl, raised for their meat and eggs.' },
  { slug: 'crocodiles',        label: 'Crocodiles & Alligators',  img: '/images/Alligator.webp',         desc: 'Crocodilians are raised for their leather hides and meat.' },
  { slug: 'deer',              label: 'Deer',                     img: '/images/deer.webp',              desc: 'Deer are raised for their meat, antlers, and hides.' },
  { slug: 'dogs',              label: 'Working Dogs',             img: '/images/Dogs.webp',              desc: 'Working dogs are bred and trained for specific tasks such as herding, guarding, and assistance.' },
  { slug: 'donkeys',           label: 'Donkeys',                  img: '/images/Donkeys.webp',           desc: 'Donkeys are hardy working animals used for transport, agriculture, and companionship.' },
  { slug: 'ducks',             label: 'Ducks',                    img: '/images/Duck.webp',              desc: 'Ducks are raised for their meat, eggs, and down feathers.' },
  { slug: 'emus',              label: 'Emus',                     img: '/images/Emu.webp',               desc: 'Emus are large flightless birds raised for their oil, meat, and leather.' },
  { slug: 'geese',             label: 'Geese',                    img: '/images/Geese.webp',             desc: 'Geese are raised for meat, foie gras, down feathers, and as guard animals.' },
  { slug: 'goats',             label: 'Goats',                    img: '/images/Goats.webp',             desc: 'Goats are raised for their milk, meat, fiber, and hides.' },
  { slug: 'guinea-fowl',       label: 'Guinea Fowl',              img: '/images/Guineafowl.webp',        desc: 'Guinea fowl are prized for their delicious meat and flavorful eggs.' },
  { slug: 'honey-bees',        label: 'Honey Bees',               img: '/images/HoneyBees.webp',         desc: 'Honey bees are kept for honey, beeswax, pollination, and other hive products.' },
  { slug: 'horses',            label: 'Horses',                   img: '/images/cowboy2.webp',           desc: 'Horses are large, powerful animals known for their speed, grace, and beauty.' },
  { slug: 'llamas',            label: 'Llamas',                   img: '/images/Llama2.webp',            desc: 'Llamas are South American camelids used as pack animals and for their fiber.' },
  { slug: 'musk-ox',           label: 'Musk Ox',                  img: '/images/muskox.webp',            desc: 'The musk ox is a large Arctic-dwelling mammal known for its shaggy coat and qiviut fiber.' },
  { slug: 'ostriches',         label: 'Ostriches',                img: '/images/Ostrich.webp',           desc: 'Ostriches are the largest bird in the world, raised for meat, leather, feathers, and eggs.' },
  { slug: 'pheasants',         label: 'Pheasants',                img: '/images/Pheasant.webp',          desc: 'Pheasants are widely kept for hunting and as ornamental birds.' },
  { slug: 'pigs',              label: 'Pigs',                     img: '/images/Pig.webp',               desc: 'Pigs are raised for their meat and are one of the most commonly farmed animals in the world.' },
  { slug: 'pigeons',           label: 'Pigeons',                  img: '/images/Pigeon.webp',            desc: 'Pigeons are raised for their meat, known as squab, considered a delicacy worldwide.' },
  { slug: 'quails',            label: 'Quails',                   img: '/images/Quail.webp',             desc: 'Quails are small game birds prized for their delicate, rich, and gamey flavor.' },
  { slug: 'rabbits',           label: 'Rabbits',                  img: '/images/Rabitts.webp',           desc: 'Rabbits are kept as pets, for their fur, and for their meat.' },
  { slug: 'sheep',             label: 'Sheep',                    img: '/images/Sheepbreeds.webp',       desc: 'Sheep are raised for their wool, meat (lamb), and milk.' },
  { slug: 'snails',            label: 'Snails',                   img: '/images/Snail.webp',             desc: 'Snails have been eaten for millennia and are consumed as a delicacy in many cultures.' },
  { slug: 'turkeys',           label: 'Turkeys',                  img: '/images/Turkey.webp',            desc: 'Turkeys are large ground-dwelling birds raised for their meat, a staple of holiday meals.' },
  { slug: 'yaks',              label: 'Yaks',                     img: '/images/Yak.webp',               desc: 'Yaks are large, hardy animals well-adapted to high, cold mountains of Central Asia.' },
];

const EAGER_COUNT = 4;

export default function LivestockDB() {
  const [counts, setCounts] = useState({});
  const [total, setTotal] = useState(0);

  useEffect(() => {
    window.scrollTo(0, 0);
    fetch(`${API_URL}/api/livestock/counts`)
      .then(r => r.ok ? r.json() : {})
      .then(data => {
        setCounts(data.counts || {});
        setTotal(data.total || 0);
      })
      .catch(() => {});
  }, []);

  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Livestock Database | 2,000+ Breeds Across 28 Species"
        description="Explore over 2,000 livestock breeds across 28 species including cattle, pigs, sheep, goats, chickens, alpacas, and more. Find breed characteristics, origins, and farming information."
        canonical="https://oatmealfarmnetwork.com/livestock"
      />
      <Header />

      {/* ── Hero ── */}
      <div className="mx-auto px-4 pt-2 md:pt-6" style={{ maxWidth: '1300px' }}>

        {/* Image — shorter on mobile, taller on desktop */}
        <div className="relative w-full overflow-hidden rounded-xl rounded-b-none md:rounded-b-xl">
          <img
            src="/images/HomepageLivestockDB.webp"
            alt="Livestock Database"
            className="w-full object-cover block h-[160px] md:h-[250px]"
            loading="eager"
          />
          {/* Gradient + text overlay — desktop only */}
          <div className="hidden md:block absolute inset-0" style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }} />
          <div className="hidden md:flex absolute inset-0 flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '2rem', fontWeight: 'bold', margin: '0 0 12px', lineHeight: 1.2 }}>
              Livestock Database
            </h1>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: '0 0 8px', lineHeight: 1.6 }}>
              There are thousands of breeds of livestock, we have documented{' '}
              <strong>{total > 0 ? `${total.toLocaleString()} Breeds` : '…'}</strong>{' '}
              so far. We have the mission to list them all here.
            </p>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: 0, lineHeight: 1.6 }}>
              We are consistently adding more information and photos to the list. If you would like to help out with photos,
              descriptions, or correcting errors please{' '}
              <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>
              {' '}and let us know — the more people we have helping, the more complete the information.
            </p>
          </div>
        </div>

        {/* Text below image — mobile only */}
        <div className="md:hidden bg-white px-5 py-4 rounded-b-xl border border-t-0 border-gray-200">
          <h1 style={{ color: '#000000', fontFamily: "'Lora','Times New Roman',serif", fontSize: '1.4rem', fontWeight: 'bold', margin: '0 0 8px', lineHeight: 1.2 }}>
            Livestock Database
          </h1>
          <p style={{ color: '#111111', fontSize: '0.85rem', margin: '0 0 6px', lineHeight: 1.6 }}>
            There are thousands of breeds of livestock, we have documented{' '}
            <strong>{total > 0 ? `${total.toLocaleString()} Breeds` : '…'}</strong>{' '}
            so far.
          </p>
          <p style={{ color: '#111111', fontSize: '0.85rem', margin: 0, lineHeight: 1.6 }}>
            If you'd like to help with photos or descriptions, please{' '}
            <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>.
          </p>
        </div>

      </div>

      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        {/* ── Section heading ── */}
        <h2 className="text-lg font-bold text-gray-900 mb-5">Species of Livestock</h2>

        {/* ── 2-column grid of horizontal cards ── */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
          {SPECIES.map((s, index) => {
            const count = counts[s.slug] || 0;
            return (
              <div
                key={s.slug}
                className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200"
              >
                {/* Left: square image */}
                <Link to={`/livestock/${s.slug}`} className="shrink-0 overflow-hidden" style={{ width: '155px', height: '155px' }}>
                  <img
                    src={s.img}
                    alt={s.label}
                    width="155"
                    height="155"
                    loading={index < EAGER_COUNT ? 'eager' : 'lazy'}
                    decoding={index < EAGER_COUNT ? 'sync' : 'async'}
                    className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                    onError={e => { e.target.src = '/images/HomepageLivestockDB.webp'; }}
                  />
                </Link>

                {/* Right: text content */}
                <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                  <div>
                    <Link
                      to={`/livestock/${s.slug}`}
                      className="font-bold text-sm hover:underline"
                      style={{ color: '#3D6B34' }}
                    >
                      {s.label}
                    </Link>
                    <p
                      className="text-xs font-semibold mt-0.5 mb-2"
                      style={{ color: '#819360' }}
                    >
                      {count > 0 ? `${count.toLocaleString()} Breeds` : '—'}
                    </p>
                    <p className="text-xs text-gray-600 leading-relaxed">{s.desc}</p>
                  </div>
                  <div className="mt-3">
                    <Link
                      to={`/livestock/${s.slug}`}
                      className="text-xs font-bold hover:underline"
                      style={{ color: '#3D6B34' }}
                    >
                      EXPLORE →
                    </Link>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

      </div>

      <Footer />
    </div>
  );
}
