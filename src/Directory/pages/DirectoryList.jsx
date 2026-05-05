import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import Header from '../../Header';
import Footer from '../../Footer';
import PageMeta from '../../PageMeta';
import Breadcrumbs from '../../Breadcrumbs';

// Directory category images — served from /public/images (WebP)
const agriAssociaImg      = '/images/AgriculturalAssociations.webp';
const artisianImg         = '/images/ArtisanProducers.webp';
const brImg               = '/images/BusinessResourcesDirectoryImage.webp';
const crafOrgImg          = '/images/CrafterOrganizations.webp';
const farmersMarketImg    = '/images/FarmersMarket.webp';
const farmsRanchesImg     = '/images/Farm.webp';
const fiberImg            = '/images/FiberCooperatives.webp';
const fiberMillsImg       = '/images/FiberMill.webp';
const fisheriesImg        = '/images/Fishery.webp';
const fishermenImg        = '/images/Fishermen.webp';
const foodAggregatorsImg  = '/images/FoodAggregators.webp';
const foodCopImg          = '/images/FoodCooperatives.webp';
const foodHubImg          = '/images/FoodHubs.webp';
const groceryStoreImg     = '/images/GroceryStores.webp';
const herbTeaImg          = '/images/Herbs.webp';
const hungerReliefImg     = '/images/HumanReleafOrganization.webp';
const manfacImg           = '/images/Manufacturers.webp';
const marinasImg          = '/images/Marina.webp';
const meatImg             = '/images/MeatWholesalers.webp';
const realEstateImg       = '/images/RealEstateAgents.webp';
const restaurantsImg      = '/images/Restaurants.webp';
const retailersImg        = '/images/Retailers.webp';
const serviceProvidersImg = '/images/ServiceProviders.webp';
const transporterImg      = '/images/207851Transporter.webp';
const universitiesImg     = '/images/University.webp';
const vetImg              = '/images/Vetrinarians.webp';
const vineyardsImg        = '/images/Vineyard.webp';
const wineriesImg         = '/images/Winery.webp';
const othersImg           = '/icons/Other.png';

// Categories surfaced in the public directory. Sourced from the
// `businesstypelookup` table (excluding the "N/A" placeholder row) and
// ordered alphabetically by BusinessType to match GET /api/businesses/types.
const CATEGORIES_BASE = [
  { slug: 'agricultural-associations', img: agriAssociaImg },
  { slug: 'artisan-producers',         img: artisianImg },
  { slug: 'business-resources',        img: brImg },
  { slug: 'crafter-organizations',     img: crafOrgImg },
  { slug: 'farmers-markets',           img: farmersMarketImg },
  { slug: 'farms-ranches',             img: farmsRanchesImg },
  { slug: 'fiber-cooperatives',        img: fiberImg },
  { slug: 'fiber-mills',               img: fiberMillsImg },
  { slug: 'fisheries',                 img: fisheriesImg },
  { slug: 'fishermen',                 img: fishermenImg },
  { slug: 'food-aggregators',          img: foodAggregatorsImg },
  { slug: 'food-cooperatives',         img: foodCopImg },
  { slug: 'food-hubs',                 img: foodHubImg },
  { slug: 'grocery-stores',            img: groceryStoreImg },
  { slug: 'herb-and-tea-producers',    img: herbTeaImg },
  { slug: 'hunger-relief-organizations', img: hungerReliefImg },
  { slug: 'manufacturers',             img: manfacImg },
  { slug: 'marinas',                   img: marinasImg },
  { slug: 'meat-wholesalers',          img: meatImg },
  { slug: 'real-estate-agents',        img: realEstateImg },
  { slug: 'restaurants',               img: restaurantsImg },
  { slug: 'retailers',                 img: retailersImg },
  { slug: 'service-providers',         img: serviceProvidersImg },
  { slug: 'transporters',              img: transporterImg },
  { slug: 'universities',              img: universitiesImg },
  { slug: 'veterinarians',             img: vetImg },
  { slug: 'vineyards',                 img: vineyardsImg },
  { slug: 'wineries',                  img: wineriesImg },
  // "Other" is intentionally pinned to the bottom rather than sorted in.
  { slug: 'others',                    img: othersImg },
];

const EAGER_COUNT = 4;

export default function DirectoryList() {
  const { t } = useTranslation();
  const CATEGORIES = CATEGORIES_BASE.map(c => {
    const k = c.slug.replace(/-/g, '_');
    return { ...c, title: t(`directory_list.cat_${k}_title`), desc: t(`directory_list.cat_${k}_desc`) };
  });
  return (
    <div className="min-h-screen font-sans" style={{ backgroundColor: '#f7f2e8' }}>
      <PageMeta
        title="Farm & Food Business Directory | Find Local Farms & Producers"
        description="Find farms, food hubs, farmers markets, restaurants, processors, artisan producers, and more in our comprehensive farm and food business directory."
        keywords="farm directory, food business directory, local farms, farmers markets, food hubs, restaurants, artisan producers, agricultural businesses, farm listings"
        canonical="https://oatmealfarmnetwork.com/directory"
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'CollectionPage',
          name: 'Farm & Food Business Directory',
          description: 'Comprehensive directory of farms, food producers, markets, and agricultural businesses.',
          url: 'https://oatmealfarmnetwork.com/directory',
        }}
      />
      <Header />

      <div className="mx-auto px-4 pt-4" style={{ maxWidth: '1300px' }}>
        <Breadcrumbs items={[
          { label: t('directory_list.breadcrumb_home'), to: '/' },
          { label: t('directory_list.breadcrumb_directory') },
        ]} />
      </div>

      {/* ── Hero ── */}
      <div className="mx-auto px-4 pt-2" style={{ maxWidth: '1300px' }}>
        <div className="relative w-full overflow-hidden rounded-xl">
          <img
            src="/images/DirectoryHeaderImage.webp"
            alt="Food System & Beyond Directory"
            className="w-full object-cover"
            style={{ height: '250px', display: 'block' }}
            loading="eager"
          />
          {/* Gradient overlay */}
          <div
            className="absolute inset-0"
            style={{ background: 'linear-gradient(to right, rgba(255,255,255,0.88) 0%, rgba(255,255,255,0.72) 45%, rgba(255,255,255,0) 75%)' }}
          />
          {/* Text */}
          <div className="absolute inset-0 flex flex-col justify-center px-8 py-6" style={{ maxWidth: '780px' }}>
            <h1
              style={{
                color: '#000000',
                fontFamily: "'Lora','Times New Roman',serif",
                fontSize: '2rem',
                fontWeight: 'bold',
                margin: '0 0 12px',
                lineHeight: 1.2,
              }}
            >
              {t('directory_list.hero_heading')}
            </h1>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: '0 0 8px', lineHeight: 1.6 }}
              dangerouslySetInnerHTML={{ __html: t('directory_list.hero_body1') }}
            />
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: 0, lineHeight: 1.6 }}>
              {t('directory_list.hero_body2')}{' '}
              <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>{t('directory_list.hero_contact_us')}</Link>
              {' '}{t('directory_list.hero_body3')}
            </p>
          </div>
        </div>
      </div>

      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        {/* ── Section heading ── */}
        <h2 className="text-lg font-bold text-gray-900 mb-5">{t('directory_list.section_heading')}</h2>

        {/* ── 2-column grid of horizontal cards ── */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
          {CATEGORIES.map((cat, index) => (
            <div
              key={cat.slug}
              className="flex bg-white rounded-xl overflow-hidden shadow-sm border border-gray-200 hover:shadow-md hover:border-[#819360] transition-all duration-200"
            >
              {/* Left: square image */}
              <Link to={`/directory/${cat.slug}`} className="shrink-0 overflow-hidden" style={{ width: '155px', height: '155px' }}>
                <img
                  src={cat.img}
                  alt={cat.title}
                  width="155"
                  height="155"
                  loading={index < EAGER_COUNT ? 'eager' : 'lazy'}
                  decoding={index < EAGER_COUNT ? 'sync' : 'async'}
                  className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                  onError={e => { e.target.src = '/images/DirectoryHome.webp'; }}
                />
              </Link>

              {/* Right: text content */}
              <div className="flex flex-col justify-between px-5 py-4 flex-1 min-w-0">
                <div>
                  <Link
                    to={`/directory/${cat.slug}`}
                    className="font-bold text-sm hover:underline"
                    style={{ color: '#3D6B34' }}
                  >
                    {cat.title}
                  </Link>
                  <p className="text-xs text-gray-600 leading-relaxed mt-1">{cat.desc}</p>
                </div>
                <div className="mt-3">
                  <Link
                    to={`/directory/${cat.slug}`}
                    className="text-xs font-bold hover:underline"
                    style={{ color: '#3D6B34' }}
                  >
                    {t('directory_list.btn_explore')}
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>

      </div>

      <Footer />
    </div>
  );
}
