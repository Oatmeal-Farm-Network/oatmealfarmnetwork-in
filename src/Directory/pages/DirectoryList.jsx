import React from 'react';
import { Link } from 'react-router-dom';
import Header from '../../Header';
import Footer from '../../Footer';
import PageMeta from '../../PageMeta';
import Breadcrumbs from '../../Breadcrumbs';

// Directory category images — served from /public/images (WebP)
const agriAssociaImg      = '/images/AgriculturalAssociations.webp';
const artisianImg         = '/images/ArtisanProducers.webp';
const brImg               = '/images/BusinessResources.webp';
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
const transporterImg      = '/images/Transportation.webp';
const universitiesImg     = '/images/University.webp';
const vetImg              = '/images/Vetrinarians.webp';
const vineyardsImg        = '/images/Vineyard.webp';
const wineriesImg         = '/images/Winery.webp';
const othersImg           = '/icons/Other.png';

// Categories surfaced in the public directory. Sourced from the
// `businesstypelookup` table (excluding the "N/A" placeholder row) and
// ordered alphabetically by BusinessType to match GET /api/businesses/types.
const CATEGORIES = [
  {
    title: 'Agricultural Associations',
    slug:  'agricultural-associations',
    img:   agriAssociaImg,
    desc:  'Trade associations, cooperatives, and advocacy groups that support farmers, ranchers, and food producers across all sectors of agriculture.',
  },
  {
    title: 'Artisan Producers',
    slug:  'artisan-producers',
    img:   artisianImg,
    desc:  'Small-batch makers of specialty foods — cheesemakers, bread bakers, jam crafters, and other producers who put craft and care into every product.',
  },
  {
    title: 'Business Resources',
    slug:  'business-resources',
    img:   brImg,
    desc:  'Consultants, lenders, accountants, and support organizations that help farm and food businesses manage finances, compliance, and growth.',
  },
  {
    title: 'Crafter Organizations',
    slug:  'crafter-organizations',
    img:   crafOrgImg,
    desc:  'Guilds, co-ops, and collectives for fiber artists, weavers, knitters, and other crafters who work with natural and farm-sourced materials.',
  },
  {
    title: 'Farmers Markets',
    slug:  'farmers-markets',
    img:   farmersMarketImg,
    desc:  'Outdoor and indoor markets where farmers, growers, and producers sell directly to consumers — the heartbeat of local food communities.',
  },
  {
    title: 'Farms / Ranches',
    slug:  'farms-ranches',
    img:   farmsRanchesImg,
    desc:  'Working farms and ranches growing crops, raising livestock, and producing the raw ingredients that feed families and supply the food chain.',
  },
  {
    title: 'Fiber Cooperatives',
    slug:  'fiber-cooperatives',
    img:   fiberImg,
    desc:  'Member-owned cooperatives that pool fiber resources — raw wool, alpaca, mohair, and more — for processing, marketing, and sale.',
  },
  {
    title: 'Fiber Mills',
    slug:  'fiber-mills',
    img:   fiberMillsImg,
    desc:  'Facilities that wash, card, spin, and process raw animal fiber into yarn and textiles for the handcraft and textile industries.',
  },
  {
    title: 'Fisheries',
    slug:  'fisheries',
    img:   fisheriesImg,
    desc:  'Aquaculture operations and wild-catch fisheries that produce fish, shellfish, and other seafood for commercial and consumer markets.',
  },
  {
    title: 'Fishermen',
    slug:  'fishermen',
    img:   fishermenImg,
    desc:  'Independent commercial fishermen and small fishing operations harvesting seafood from oceans, lakes, and rivers.',
  },
  {
    title: 'Food Aggregators',
    slug:  'food-aggregators',
    img:   foodAggregatorsImg,
    desc:  'Organizations that consolidate and resell product from multiple farms — connecting smaller producers to wholesale buyers, distributors, and institutional kitchens.',
  },
  {
    title: 'Food Cooperatives',
    slug:  'food-cooperatives',
    img:   foodCopImg,
    desc:  'Member-owned grocery stores and buying clubs that prioritize local sourcing, fair prices, and community ownership of the food supply.',
  },
  {
    title: 'Food Hubs',
    slug:  'food-hubs',
    img:   foodHubImg,
    desc:  'Aggregation and distribution centers that help small and mid-scale farms access wholesale markets, schools, hospitals, and retail buyers.',
  },
  {
    title: 'Grocery Stores',
    slug:  'grocery-stores',
    img:   groceryStoreImg,
    desc:  'Independent and regional grocery retailers committed to stocking local and regional food products alongside everyday staples.',
  },
  {
    title: 'Herb & Tea Producers',
    slug:  'herb-and-tea-producers',
    img:   herbTeaImg,
    desc:  'Growers and crafters of culinary, medicinal, and aromatic herbs, plus loose-leaf and blended tea producers working from farm to cup.',
  },
  {
    title: 'Hunger Relief Organizations',
    slug:  'hunger-relief-organizations',
    img:   hungerReliefImg,
    desc:  'Food banks, pantries, rescue programs, and community kitchens that connect surplus farm and food production with families in need.',
  },
  {
    title: 'Manufacturers',
    slug:  'manufacturers',
    img:   manfacImg,
    desc:  'Food and beverage manufacturers that transform raw agricultural ingredients into packaged products for retail, foodservice, and export.',
  },
  {
    title: 'Marinas',
    slug:  'marinas',
    img:   marinasImg,
    desc:  'Coastal and inland marinas that support commercial fishing operations, aquaculture businesses, and waterfront food enterprises.',
  },
  {
    title: 'Meat Wholesalers',
    slug:  'meat-wholesalers',
    img:   meatImg,
    desc:  'Processors and distributors that source whole animals from farms and sell cuts, carcasses, and specialty meats to restaurants and retailers.',
  },
  {
    title: 'Real Estate Agents',
    slug:  'real-estate-agents',
    img:   realEstateImg,
    desc:  'Agents and brokers who specialize in agricultural land, farm properties, rural acreage, and food-business real estate transactions.',
  },
  {
    title: 'Restaurants',
    slug:  'restaurants',
    img:   restaurantsImg,
    desc:  'Farm-to-table restaurants, local diners, and food establishments that source directly from farmers and champion regional cuisine.',
  },
  {
    title: 'Retailers',
    slug:  'retailers',
    img:   retailersImg,
    desc:  'Specialty food shops, farm stores, and retail outlets that bring locally and regionally produced food products to everyday shoppers.',
  },
  {
    title: 'Service Providers',
    slug:  'service-providers',
    img:   serviceProvidersImg,
    desc:  'Veterinarians, agronomists, equipment dealers, and other service businesses that keep farms and food enterprises running smoothly.',
  },
  {
    title: 'Transporters',
    slug:  'transporters',
    img:   transporterImg,
    desc:  'Refrigerated trucking, livestock haulers, and logistics providers that move farm product from field to processor, distributor, and end buyer.',
  },
  {
    title: 'Universities',
    slug:  'universities',
    img:   universitiesImg,
    desc:  'Agricultural colleges, land-grant universities, and extension programs that conduct research and provide education to the farming community.',
  },
  {
    title: 'Veterinarians',
    slug:  'veterinarians',
    img:   vetImg,
    desc:  'Large-animal and mixed-practice veterinarians who provide health care, herd management, and consulting services for livestock producers.',
  },
  {
    title: 'Vineyards',
    slug:  'vineyards',
    img:   vineyardsImg,
    desc:  'Grape growers and estate vineyards that cultivate wine grapes, table grapes, and specialty varietals across growing regions.',
  },
  {
    title: 'Wineries',
    slug:  'wineries',
    img:   wineriesImg,
    desc:  'Craft and commercial wineries that ferment, age, and bottle wine from grapes and other fruits, often sourcing from local vineyards.',
  },
  // "Other" is intentionally pinned to the bottom rather than sorted in.
  {
    title: 'Other',
    slug:  'others',
    img:   othersImg,
    desc:  "Food system businesses and organizations that don't fit neatly into other categories — from food trucks to community gardens and beyond.",
  },
];

const EAGER_COUNT = 4;

export default function DirectoryList() {
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
          { label: 'Home', to: '/' },
          { label: 'Directory' },
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
              Food System &amp; Beyond Directory
            </h1>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: '0 0 8px', lineHeight: 1.6 }}>
              Find what you're looking for across <strong>29 categories</strong> — from farms and food hubs to
              restaurants, fiber mills, and more.
            </p>
            <p style={{ color: '#111111', fontSize: '0.92rem', margin: 0, lineHeight: 1.6 }}>
              Search and connect with local farms, food businesses, and organizations in your area. Want to add
              your business?{' '}
              <Link to="/contact-us" style={{ color: '#3D6B34', textDecoration: 'underline' }}>Contact Us</Link>
              {' '}and we'll get you listed.
            </p>
          </div>
        </div>
      </div>

      <div className="mx-auto px-4 py-8" style={{ maxWidth: '1300px' }}>

        {/* ── Section heading ── */}
        <h2 className="text-lg font-bold text-gray-900 mb-5">Directory Categories</h2>

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
                    EXPLORE →
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
