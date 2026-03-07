import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from './Header';
import Footer from './Footer';

const SPECIES = [
  { slug: 'alpacas',           label: 'Alpacas',                  img: 'Alpaca.webp',           desc: 'Alpacas are soft-fleeced South American camelids raised primarily for their fiber.' },
  { slug: 'bison',             label: 'Bison',                    img: 'Bison.webp',             desc: 'Bison are large, shaggy North American bovines raised for lean, flavorful meat.' },
  { slug: 'buffalo',           label: 'Buffalo',                  img: 'Buffalo.webp',           desc: 'Buffalo are raised for their milk, meat, and as draft animals in many parts of Asia.' },
  { slug: 'camels',            label: 'Camels',                   img: 'Camels.webp',            desc: 'Camels are raised for milk, meat, wool, and transport in arid regions worldwide.' },
  { slug: 'cattle',            label: 'Cattle',                   img: 'Cattle.webp',            desc: 'Cattle are raised for beef, veal, dairy products, leather, and as draft animals.' },
  { slug: 'chickens',          label: 'Chickens',                 img: 'Chicken.webp',           desc: 'Chickens are the most widely kept fowl, raised for their meat and eggs.' },
  { slug: 'crocodiles',        label: 'Crocodiles & Alligators',  img: 'Alligator.webp',         desc: 'Crocodilians are raised for their leather hides and meat.' },
  { slug: 'deer',              label: 'Deer',                     img: 'deer.webp',              desc: 'Deer are raised for their meat, antlers, and hides.' },
  { slug: 'dogs',              label: 'Working Dogs',             img: 'Dogs.webp',              desc: 'Working dogs are bred and trained for specific tasks such as herding, guarding, and assistance.' },
  { slug: 'donkeys',           label: 'Donkeys',                  img: 'Donkeys.webp',           desc: 'Donkeys are hardy working animals used for transport, agriculture, and companionship.' },
  { slug: 'ducks',             label: 'Ducks',                    img: 'Duck.webp',              desc: 'Ducks are raised for their meat, eggs, and down feathers.' },
  { slug: 'emus',              label: 'Emus',                     img: 'Emu.webp',               desc: 'Emus are large flightless birds raised for their oil, meat, and leather.' },
  { slug: 'geese',             label: 'Geese',                    img: 'Geese.webp',             desc: 'Geese are raised for meat, foie gras, down feathers, and as guard animals.' },
  { slug: 'goats',             label: 'Goats',                    img: 'Goats.webp',             desc: 'Goats are raised for their milk, meat, fiber, and hides.' },
  { slug: 'guinea-fowl',       label: 'Guinea Fowl',              img: 'Guineafowl.webp',        desc: 'Guinea fowl are prized for their delicious meat and flavorful eggs.' },
  { slug: 'honey-bees',        label: 'Honey Bees',               img: 'HoneyBees.webp',         desc: 'Honey bees are kept for honey, beeswax, pollination, and other hive products.' },
  { slug: 'horses',            label: 'Horses',                   img: 'cowboy2.webp',           desc: 'Horses are large, powerful animals known for their speed, grace, and beauty.' },
  { slug: 'llamas',            label: 'Llamas',                   img: 'Llama2.webp',            desc: 'Llamas are South American camelids used as pack animals and for their fiber.' },
  { slug: 'musk-ox',           label: 'Musk Ox',                  img: 'muskox.webp',            desc: 'The musk ox is a large Arctic-dwelling mammal known for its shaggy coat and qiviut fiber.' },
  { slug: 'ostriches',         label: 'Ostriches',                img: 'Ostrich.webp',           desc: 'Ostriches are the largest bird in the world, raised for meat, leather, feathers, and eggs.' },
  { slug: 'pheasants',         label: 'Pheasants',                img: 'Pheasant.webp',          desc: 'Pheasants are widely kept for hunting and as ornamental birds.' },
  { slug: 'pigs',              label: 'Pigs',                     img: 'Pig.webp',               desc: 'Pigs are raised for their meat and are one of the most commonly farmed animals in the world.' },
  { slug: 'pigeons',           label: 'Pigeons',                  img: 'Pigeon.webp',            desc: 'Pigeons are raised for their meat, known as squab, considered a delicacy worldwide.' },
  { slug: 'quails',            label: 'Quails',                   img: 'Quail.webp',             desc: 'Quails are small game birds prized for their delicate, rich, and gamey flavor.' },
  { slug: 'rabbits',           label: 'Rabbits',                  img: 'Rabitts.webp',           desc: 'Rabbits are kept as pets, for their fur, and for their meat.' },
  { slug: 'sheep',             label: 'Sheep',                    img: 'Sheepbreeds.webp',       desc: 'Sheep are raised for their wool, meat (lamb), and milk.' },
  { slug: 'snails',            label: 'Snails',                   img: 'Snail.webp',             desc: 'Snails have been eaten for millennia and are consumed as a delicacy in many cultures.' },
  { slug: 'turkeys',           label: 'Turkeys',                  img: 'Turkey.webp',            desc: 'Turkeys are large ground-dwelling birds raised for their meat, a staple of holiday meals.' },
  
  { slug: 'yaks',              label: 'Yaks',                     img: 'Yak.webp',               desc: 'Yaks are large, hardy animals well-adapted to high, cold mountains of Central Asia.' },
];

export default function LivestockDB() {
  const [counts, setCounts] = useState({});
  const [total, setTotal] = useState(null);

  useEffect(() => {
    window.scrollTo(0, 0);
    const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000';
    fetch(API_URL + '/api/livestock/counts')
      .then(r => r.json())
      .then(data => {
        setCounts(data.counts || {});
        setTotal(data.total || 0);
      })
      .catch(() => {});
  }, []);

  return (
    <div className="min-h-screen bg-white font-sans">
       <Header />

      <div style={{ maxWidth: '1300px', margin: '0 auto', padding: '1rem 1rem 3rem' }}>
        <h1 className="text-3xl font-bold text-gray-900 mb-3">Livestock Database</h1>

        <video className="w-full object-cover mb-4 rounded" style={{ maxHeight: '400px' }} autoPlay muted loop playsInline>
          <source src="/videos/LivestockHeader.mp4" type="video/mp4" />
        </video>

        <p className="text-sm text-gray-700 mb-1">
          There are thousands of breeds of livestock, we have documented{' '}
          <strong>{total !== null ? total.toLocaleString() : '...'} Breeds</strong> so far. We have the mission to list them all here.
        </p>
        <p className="text-sm text-gray-700 mb-6">
          We are consistently adding more information and photos to the list. If you would like to help out with photos,
          descriptions, or correcting errors please <Link to="/contact-us" style={{ color: '#3D6B34' }}>Contact Us</Link>.
        </p>

        <h2 className="text-xl font-bold text-gray-900 mb-4">Breeds of Livestock</h2>

        <div className="grid grid-cols-2 gap-x-8 gap-y-4">
          {SPECIES.map(s => (
            <div key={s.slug} className="flex gap-4 items-start">
              <Link to={`/livestock/${s.slug}`} className="shrink-0">
                <img
                  src={`/images/${s.img}`}
                  alt={s.label}
                  className="object-cover rounded"
                  loading="lazy"  
                  style={{ width: '150px', height: '150px' }}
                  onError={e => { e.target.src = '/images/HomepageLivestockDB.webp'; }}
                />
              </Link>
              <div className="pt-1">
                <Link to={`/livestock/${s.slug}`} className="text-sm font-medium hover:underline block mb-1" style={{ color: '#3D6B34' }}>
                  {s.label} {counts[s.slug] ? `(${counts[s.slug]} Breeds)` : ''}
                </Link>
                <p className="text-sm text-gray-600 leading-relaxed">{s.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      <Footer />
    </div>
  );
}
