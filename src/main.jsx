import React, { lazy, Suspense } from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter, Routes, Route, Navigate, useSearchParams } from 'react-router-dom'
import './index.css'
import { AccountProvider } from './AccountContext';
import PWAInstallPrompt from './PWAInstallPrompt.jsx';
import "./AnimalAddWizard.css";
import AnimalEdit from "./AnimalEdit";
import MeatInventory from './MeatInventory';
import AccountLayout from './AccountLayout';
import NewsFeed from "./NewsFeed";
import ArticleDetail from "./ArticleDetail";
import MarketplaceCatalog from './MarketplaceCatalog';
import MarketplaceProduct from './MarketplaceProduct';
import MarketplaceCart from './MarketplaceCart';
import MarketplaceOrders from './MarketplaceOrders';
import OrderDetail from './OrderDetail';
import SellerOrders from './SellerOrders';
import SellerListings from './SellerListings';
import ForgotPassword from './ForgotPassword';
import ServicesDirectory from './ServicesDirectory';
import ServiceDetail from './ServiceDetail';
import EventsList from './EventsList';
import EventDetail from './EventDetail';
import EventRegister from './EventRegister';
import EventRegisterWizard from './EventRegisterWizard';
import EventRegistrationsAdmin from './EventRegistrationsAdmin';
import EventMealsAdmin from './EventMealsAdmin';
import EventCartReceipt from './EventCartReceipt';
import EventExportsHub from './EventExportsHub';
import EventMailingListAdmin from './EventMailingListAdmin';
import PromoCodesAdmin from './PromoCodesAdmin';
import WaitlistAdmin from './WaitlistAdmin';
import AbandonedCartsAdmin from './AbandonedCartsAdmin';
import EventPrintHub from './EventPrintHub';
import EventPrintNametags from './EventPrintNametags';
import EventPrintBarnCards from './EventPrintBarnCards';
import EventPrintClassSheets from './EventPrintClassSheets';
import EventsManage from './EventsManage';
import EventAdd from './EventAdd';
import EventAddDetails from './EventAddDetails';
import EventsMyRegistrations from './EventsMyRegistrations';
import FiberArtsAdmin from './FiberArtsAdmin';
import FiberArtsRegister from './FiberArtsRegister';
import FleeceAdmin from './FleeceAdmin';
import FleeceRegister from './FleeceRegister';
import SpinOffAdmin from './SpinOffAdmin';
import SpinOffRegister from './SpinOffRegister';
import HalterAdmin from './HalterAdmin';
import HalterRegister from './HalterRegister';
import AuctionAdmin from './AuctionAdmin';
import AuctionBrowse from './AuctionBrowse';
import VendorFairAdmin from './VendorFairAdmin';
import VendorFairApply from './VendorFairApply';
import DiningAdmin from './DiningAdmin';
import DiningRegister from './DiningRegister';
import FarmTourAdmin from './FarmTourAdmin';
import FarmTourRegister from './FarmTourRegister';
import SimpleEventAdmin from './SimpleEventAdmin';
import SimpleEventRegister from './SimpleEventRegister';
import ConferenceAdmin from './ConferenceAdmin';
import ConferenceRegister from './ConferenceRegister';
import CompetitionAdmin from './CompetitionAdmin';
import CompetitionRegister from './CompetitionRegister';
import JudgePortal from './JudgePortal';
import ConferenceAgenda from './ConferenceAgenda';
import CompetitionLeaderboard from './CompetitionLeaderboard';
import MyRegistrations from './MyRegistrations';
import EventCheckIn from './EventCheckIn';
import EventCertificate from './EventCertificate';
import EventBroadcast from './EventBroadcast';
import SpeakerPortal from './SpeakerPortal';
import EventAnalytics from './EventAnalytics';
import EventAdminDashboard from './EventAdminDashboard';
import EventFeaturesAdmin from './EventFeaturesAdmin';
import ScraperKnowledgeAdmin from './ScraperKnowledgeAdmin';
import EventClone from './EventClone';
import BlogList from './BlogList';
import BlogDetail from './BlogDetail';
import BlogManage from './BlogManage';
import BlogAuthors from './BlogAuthors';
import BlogAuthorDetail from './BlogAuthorDetail';


// Reload once if a lazy chunk 404s after a redeploy (stale index-*.js pointing at old hashes).
// Guarded by a sessionStorage timestamp so a genuinely missing chunk doesn't infinite-loop.
const lazyWithReload = (importFn) => lazy(async () => {
  try {
    return await importFn();
  } catch (err) {
    const msg = String(err?.message || err || '');
    const isChunkError = /Failed to fetch dynamically imported module|Loading chunk|Importing a module script failed|error loading dynamically imported module/i.test(msg);
    if (isChunkError) {
      const key = '__ofn_last_chunk_reload__';
      const last = parseInt(sessionStorage.getItem(key) || '0', 10);
      if (Date.now() - last > 10000) {
        sessionStorage.setItem(key, String(Date.now()));
        window.location.reload();
        return new Promise(() => {});
      }
    }
    throw err;
  }
});

const App = lazyWithReload(() => import('./App.jsx'))
const About = lazyWithReload(() => import('./About.jsx'))
const Login = lazyWithReload(() => import('./login.jsx'))
const Signup = lazyWithReload(() => import('./Signup.jsx'))
const Dashboard = lazyWithReload(() => import('./Dashboard.jsx'))
const AccountHome = lazyWithReload(() => import('./AccountHome.jsx'))
const OatSense = lazyWithReload(() => import('./OatSense.jsx'))
const PrecisionAgFields = lazyWithReload(() => import('./PrecisionAgFields.jsx'))
const PrecisionAgAdd = lazyWithReload(() => import('./PrecisionAgAdd.jsx'))
const PrecisionAgAnalyses = lazyWithReload(() => import('./PrecisionAgAnalyses.jsx'))
const CropRotation = lazyWithReload(() => import('./CropRotation.jsx'))
const OatSenseNotes = lazyWithReload(() => import('./OatSenseNotes.jsx'))
const WebsiteBuilder = lazyWithReload(() => import('./WebsiteBuilder.jsx'))
const WebsitePublic = lazyWithReload(() => import('./WebsitePublic.jsx'))
const AudioSettings = lazyWithReload(() => import('./AudioSettings.jsx'))
const AccountSettings = lazyWithReload(() => import('./AccountSettings.jsx'))
const SaigePage = lazyWithReload(() => import('./SaigePage.jsx'))
const CompanionPlanting = lazyWithReload(() => import('./CompanionPlanting.jsx'))
const CropNames = lazyWithReload(() => import('./CropNames.jsx'))
const WeatherMitigation = lazyWithReload(() => import('./WeatherMitigation.jsx'))
const RegionCrops = lazyWithReload(() => import('./RegionCrops.jsx'))
const SoilChallenges = lazyWithReload(() => import('./SoilChallenges.jsx'))
const PestDetection = lazyWithReload(() => import('./PestDetection.jsx'))
const PriceForecast = lazyWithReload(() => import('./PriceForecast.jsx'))
const Subsidies = lazyWithReload(() => import('./Subsidies.jsx'))
const Insurance = lazyWithReload(() => import('./Insurance.jsx'))
const PushNotifications = lazyWithReload(() => import('./PushNotifications.jsx'))
const SaigeProfile = lazyWithReload(() => import('./SaigeProfile.jsx'))
const AnimalsHome = lazyWithReload(() => import('./AnimalsHome.jsx'))
const AnimalDelete = lazyWithReload(() => import('./AnimalDelete.jsx'))
const AnimalPackages = lazyWithReload(() => import('./AnimalPackages.jsx'))
const AccountChangeType = lazyWithReload(() => import('./AccountChangeType.jsx'))
const AnimalAddWizard = lazyWithReload(() => import('./AnimalAddWizard'))
const DirectoryList = lazyWithReload(() => import('./Directory/pages/DirectoryList'))
const DirectoryDetail = lazyWithReload(() => import('./Directory/pages/DirectoryDetail'))
const Accounts = lazyWithReload(() => import('./Accounts.jsx'))
const Knowledgebases = lazyWithReload(() => import('./Knowledgebases.jsx'))
const IngredientKnowledgebase = lazyWithReload(() => import('./IngredientKnowledgebase.jsx'))
const IngredientCategory = lazyWithReload(() => import('./IngredientCategory.jsx'))
const IngredientVarieties = lazyWithReload(() => import('./IngredientVarieties.jsx'))
const LivestockDB = lazyWithReload(() => import('./LivestockDB.jsx'))
const LivestockSpecies = lazyWithReload(() => import('./LivestockSpecies.jsx'))
const LivestockBreed = lazyWithReload(() => import('./LivestockBreed.jsx'))
const LivestockAbout = lazyWithReload(() => import('./LivestockAbout.jsx'))
const PlantKnowledgebase = lazyWithReload(() => import('./PlantKnowledgebase.jsx'))
const PlantCategory = lazyWithReload(() => import('./PlantCategory.jsx'))
const PlantVarietals = lazyWithReload(() => import('./PlantVarietals.jsx'))
const PlantVarietalDetail = lazyWithReload(() => import('./PlantVarietalDetail.jsx'))
const Marketplaces = lazyWithReload(() => import('./Marketplaces.jsx'))
const ContactUs = lazyWithReload(() => import('./ContactUs.jsx'))
const ContactUsConfirm = lazyWithReload(() => import('./ContactUsConfirm.jsx'))
const AccountNew = lazyWithReload(() => import('./AccountNew.jsx'))
const AccountProfile = lazyWithReload(() => import('./AccountProfile.jsx'))
const AccountDelete = lazyWithReload(() => import('./AccountDelete.jsx'))
const AccountSubscription = lazyWithReload(() => import('./AccountSubscription.jsx'))
const UnifiedCart = lazyWithReload(() => import('./UnifiedCart.jsx'))
const ProduceInventory = lazyWithReload(() => import('./ProduceInventory.jsx'))
const ProcessedFoodInventory = lazyWithReload(() => import('./ProcessedFoodInventory.jsx'))
const CropDetection = lazyWithReload(() => import('./CropDetection.jsx'))
const ServicesHome = lazyWithReload(() => import('./ServicesHome.jsx'))
const ServicesAdd = lazyWithReload(() => import('./ServicesAdd.jsx'))
const ServicesSuggestCategory = lazyWithReload(() => import('./ServicesSuggestCategory.jsx'))
const ServicesEdit = lazyWithReload(() => import('./ServicesEdit.jsx'))
const FarmToTableMarketplace = lazyWithReload(() => import('./FarmToTableMarketplace.jsx'))
const ProductsMarketplace = lazyWithReload(() => import('./ProductsMarketplace.jsx'))
const ProductDetail = lazyWithReload(() => import('./ProductDetail.jsx'))
const LivestockMarketplace = lazyWithReload(() => import('./LivestockMarketplace.jsx'))
const LivestockForSale = lazyWithReload(() => import('./LivestockForSale.jsx'))
const LivestockAnimalDetail = lazyWithReload(() => import('./LivestockAnimalDetail.jsx'))
const LivestockAnimalProgeny = lazyWithReload(() => import('./LivestockAnimalProgeny.jsx'))
const RanchList = lazyWithReload(() => import('./RanchList.jsx'))
const OrgProfile = lazyWithReload(() => import('./OrgProfile.jsx'))
const Accounting = lazyWithReload(() => import('./Accounting.jsx'))
const TestimonialsManage = lazyWithReload(() => import('./TestimonialsManage.jsx'))
const TestimonialsRequest = lazyWithReload(() => import('./TestimonialsRequest.jsx'))
const ProvenanceCard = lazyWithReload(() => import('./ProvenanceCard.jsx'))
const RestaurantSavedFarms = lazyWithReload(() => import('./RestaurantSavedFarms.jsx'))
const RestaurantStandingOrders = lazyWithReload(() => import('./RestaurantStandingOrders.jsx'))
const FarmStandingOrders = lazyWithReload(() => import('./FarmStandingOrders.jsx'))
const RestaurantDigest = lazyWithReload(() => import('./RestaurantDigest.jsx'))
const SellerStripeConnect = lazyWithReload(() => import('./SellerStripeConnect.jsx'))

function RequireAuth({ children }) {
  const token = localStorage.getItem('access_token');
  return token ? children : <Navigate to="/login" replace />;
}

// Redirect legacy ASP URL: /livestockmarketplace/Animals/Details.asp?ID=xxx
function LegacyAnimalRedirect() {
  const [params] = useSearchParams();
  const id = params.get('ID') || params.get('id');
  return <Navigate to={id ? `/marketplaces/livestock/animal/${id}` : '/marketplaces/livestock'} replace />;
}

// Legacy alias: /account/events → /events/manage (preserve query string)
function AccountEventsRedirect() {
  const [params] = useSearchParams();
  const qs = params.toString();
  return <Navigate to={`/events/manage${qs ? `?${qs}` : ''}`} replace />;
}

// Custom domains (not OFN or localhost) get the full public site renderer for every path.
const OFN_HOSTS = ['oatmealfarmnetwork.com', 'www.oatmealfarmnetwork.com', 'localhost', '127.0.0.1'];
const isCustomDomain = !OFN_HOSTS.some(
  h => window.location.hostname === h || window.location.hostname.endsWith(`.${h}`)
);

ReactDOM.createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <AccountProvider>
      <PWAInstallPrompt />
      <Suspense fallback={<div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>Loading...</div>}>
        {/* On a custom domain every path renders the public site — no OFN chrome, no auth routes */}
        {isCustomDomain ? (
          <Routes>
            <Route path="*" element={<WebsitePublic />} />
          </Routes>
        ) : (
        <Routes>
          <Route path="/" element={<App />} />
          <Route path="/about" element={<About />} />
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<Signup />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/account" element={<AccountHome />} />
          <Route path="/account/change-type" element={<AccountChangeType />} />
          <Route path="/account/profile" element={<AccountProfile />} />
          <Route path="/account/delete" element={<AccountDelete />} />
          <Route path="/account/subscription" element={<RequireAuth><AccountSubscription /></RequireAuth>} />
          <Route path="/cart" element={<RequireAuth><UnifiedCart /></RequireAuth>} />
          <Route path="/accounts" element={<Accounts />} />
          <Route path="/accounts/new" element={<AccountNew />} />
          <Route path="/animals" element={<AnimalsHome />} />
          <Route path="/animals/add" element={<AnimalAddWizard />} />
          <Route path="/animals/edit" element={<AnimalEdit />} />
          <Route path="/animals/delete" element={<AnimalDelete />} />
          <Route path="/animals/packages" element={<AnimalPackages />} />
          <Route path="/saige" element={<SaigePage />} />
          <Route path="/saige/companion-planting" element={<CompanionPlanting />} />
          <Route path="/saige/crop-names" element={<CropNames />} />
          <Route path="/saige/weather-mitigation" element={<WeatherMitigation />} />
          <Route path="/saige/region-crops" element={<RegionCrops />} />
          <Route path="/saige/soil-challenges" element={<SoilChallenges />} />
          <Route path="/saige/pest-detection" element={<PestDetection />} />
          <Route path="/saige/price-forecast" element={<PriceForecast />} />
          <Route path="/saige/subsidies" element={<Subsidies />} />
          <Route path="/saige/insurance" element={<Insurance />} />
          <Route path="/saige/push" element={<PushNotifications />} />
          <Route path="/saige/profile" element={<SaigeProfile />} />
          <Route path="/oatsense" element={<OatSense />} />
          <Route path="/oatsense/crop-rotation" element={<CropRotation />} />
          <Route path="/oatsense/notes" element={<OatSenseNotes />} />
          <Route path="/precision-ag/fields" element={<PrecisionAgFields />} />
          <Route path="/precision-ag/add" element={<PrecisionAgAdd />} />
          <Route path="/precision-ag/analyses" element={<PrecisionAgAnalyses />} />
          <Route path="/precision-ag/crop-detection" element={<CropDetection />} />
          <Route path="/website/builder" element={<RequireAuth><WebsiteBuilder /></RequireAuth>} />
          <Route path="/account/audio-settings" element={<AudioSettings />} />
          <Route path="/account/settings" element={<RequireAuth><AccountSettings /></RequireAuth>} />
          <Route path="/sites/:slug" element={<WebsitePublic />} />
          <Route path="/knowledgebases" element={<Knowledgebases />} />
          <Route path="/plant-knowledgebase" element={<PlantKnowledgebase />} />
          <Route path="/plant-knowledgebase/varietals/:plantId" element={<PlantVarietals />} />
          <Route path="/plant-knowledgebase/varietal-detail/:varietyId" element={<PlantVarietalDetail />} />
          <Route path="/plant-knowledgebase/:category" element={<PlantCategory />} />
          <Route path="/livestock" element={<LivestockDB />} />
          <Route path="/livestock/:species/about" element={<LivestockAbout />} />
          <Route path="/livestock/:species/breed/:breedId" element={<LivestockBreed />} />
          <Route path="/livestock/:species" element={<LivestockSpecies />} />
          <Route path="/ingredient-knowledgebase" element={<IngredientKnowledgebase />} />
          <Route path="/ingredient-knowledgebase/:category/varieties/:ingredientId" element={<IngredientVarieties />} />
          <Route path="/ingredient-knowledgebase/:category" element={<IngredientCategory />} />
          <Route path="/directory" element={<DirectoryList />} />
          <Route path="/directory/:directoryType" element={<DirectoryDetail />} />
          <Route path="/profile" element={<OrgProfile />} />
          <Route path="/contact-us" element={<ContactUs />} />
          <Route path="/contact-us/confirm" element={<ContactUsConfirm />} />
          <Route path="/produce/inventory" element={<ProduceInventory />} />
          <Route path="/produce/processed-food" element={<ProcessedFoodInventory />} />
          <Route path="/services" element={<ServicesHome />} />
          <Route path="/services/add" element={<ServicesAdd />} />
          <Route path="/services/suggest-category" element={<ServicesSuggestCategory />} />
          <Route path="/services/edit" element={<ServicesEdit />} />
          <Route path="/services/public/:servicesId" element={<ServiceDetail />} />
          <Route path="/services/directory/:categoryId" element={<ServicesDirectory />} />
          <Route path="/services/directory" element={<ServicesDirectory />} />

          {/* Events routes — specific before generic */}
          <Route path="/account/events" element={<AccountEventsRedirect />} />
          <Route path="/events/manage" element={<EventsManage />} />
          <Route path="/events/add" element={<EventAdd />} />
          <Route path="/events/add/details" element={<EventAddDetails />} />
          <Route path="/events/my-registrations" element={<EventsMyRegistrations />} />
          <Route path="/events/:eventId/admin/fiber-arts" element={<FiberArtsAdmin />} />
          <Route path="/events/:eventId/register/fiber-arts" element={<FiberArtsRegister />} />
          <Route path="/events/:eventId/admin/fleece" element={<FleeceAdmin />} />
          <Route path="/events/:eventId/register/fleece" element={<FleeceRegister />} />
          <Route path="/events/:eventId/admin/spinoff" element={<SpinOffAdmin />} />
          <Route path="/events/:eventId/register/spinoff" element={<SpinOffRegister />} />
          <Route path="/events/:eventId/admin/halter" element={<HalterAdmin />} />
          <Route path="/events/:eventId/register/halter" element={<HalterRegister />} />
          <Route path="/events/:eventId/admin/auction" element={<AuctionAdmin />} />
          <Route path="/events/:eventId/auction" element={<AuctionBrowse />} />
          <Route path="/events/:eventId/admin/vendor-fair" element={<VendorFairAdmin />} />
          <Route path="/events/:eventId/vendor-apply" element={<VendorFairApply />} />
          <Route path="/events/:eventId/admin/dining" element={<DiningAdmin />} />
          <Route path="/events/:eventId/dining" element={<DiningRegister />} />
          <Route path="/events/:eventId/admin/tour" element={<FarmTourAdmin />} />
          <Route path="/events/:eventId/tour" element={<FarmTourRegister />} />
          <Route path="/events/:eventId/admin/simple" element={<SimpleEventAdmin />} />
          <Route path="/events/:eventId/rsvp" element={<SimpleEventRegister />} />
          <Route path="/events/:eventId/admin/conference" element={<ConferenceAdmin />} />
          <Route path="/events/:eventId/conference" element={<ConferenceRegister />} />
          <Route path="/events/:eventId/admin/competition" element={<CompetitionAdmin />} />
          <Route path="/events/:eventId/compete" element={<CompetitionRegister />} />
          <Route path="/events/:eventId/agenda" element={<ConferenceAgenda />} />
          <Route path="/events/:eventId/leaderboard" element={<CompetitionLeaderboard />} />
          <Route path="/judge/:accessCode" element={<JudgePortal />} />
          <Route path="/my-registrations" element={<MyRegistrations />} />
          <Route path="/events/:eventId/checkin" element={<EventCheckIn />} />
          <Route path="/events/:eventId/certificate" element={<EventCertificate />} />
          <Route path="/events/:eventId/broadcast" element={<EventBroadcast />} />
          <Route path="/events/:eventId/analytics" element={<EventAnalytics />} />
          <Route path="/events/analytics" element={<EventAnalytics />} />
          <Route path="/events/:eventId/dashboard" element={<EventAdminDashboard />} />
          <Route path="/admin/events/features" element={<EventFeaturesAdmin />} />
          <Route path="/admin/scraper-knowledge" element={<RequireAuth><ScraperKnowledgeAdmin /></RequireAuth>} />
          <Route path="/events/:eventId/clone" element={<EventClone />} />
          <Route path="/speaker/:accessCode" element={<SpeakerPortal />} />
          <Route path="/events/:eventId/register/wizard" element={<EventRegisterWizard />} />
          <Route path="/events/:eventId/admin/registrations" element={<EventRegistrationsAdmin />} />
          <Route path="/events/:eventId/admin/meals" element={<EventMealsAdmin />} />
          <Route path="/events/:eventId/admin/exports" element={<EventExportsHub />} />
          <Route path="/events/:eventId/admin/mailing-list" element={<EventMailingListAdmin />} />
          <Route path="/events/:eventId/admin/promo-codes" element={<PromoCodesAdmin />} />
          <Route path="/events/:eventId/admin/waitlist" element={<WaitlistAdmin />} />
          <Route path="/events/:eventId/admin/abandoned-carts" element={<AbandonedCartsAdmin />} />
          <Route path="/events/:eventId/admin/print" element={<EventPrintHub />} />
          <Route path="/events/:eventId/admin/print/nametags" element={<EventPrintNametags />} />
          <Route path="/events/:eventId/admin/print/barn-cards" element={<EventPrintBarnCards />} />
          <Route path="/events/:eventId/admin/print/class-sheets" element={<EventPrintClassSheets />} />
          <Route path="/events/cart/:cartId/receipt" element={<EventCartReceipt />} />
          <Route path="/events/:eventId/register" element={<EventRegister />} />
          <Route path="/events/:eventId" element={<EventDetail />} />
          <Route path="/events" element={<EventsList />} />

          <Route path="/testimonials/manage" element={<TestimonialsManage />} />
          <Route path="/testimonials/request" element={<TestimonialsRequest />} />

          {/* "Sourced From" provenance card — printable for menus, table tents, social */}
          <Route path="/provenance/:businessId" element={<ProvenanceCard />} />

          {/* Restaurant buyer's saved-farm list */}
          <Route path="/restaurant/farms" element={<RequireAuth><RestaurantSavedFarms /></RequireAuth>} />
          <Route path="/restaurant/standing-orders" element={<RequireAuth><RestaurantStandingOrders /></RequireAuth>} />
          <Route path="/farm/standing-orders" element={<RequireAuth><FarmStandingOrders /></RequireAuth>} />
          <Route path="/restaurant/digest" element={<RequireAuth><RestaurantDigest /></RequireAuth>} />
          <Route path="/account/stripe-connect" element={<RequireAuth><SellerStripeConnect /></RequireAuth>} />

          <Route path="/forgot-password" element={<ForgotPassword />} />

          {/* Marketplace routes — specific before generic */}
          <Route path="/marketplaces/farm-to-table" element={<FarmToTableMarketplace />} />
          <Route path="/marketplaces/livestock/animal/:id/progeny" element={<LivestockAnimalProgeny />} />
          <Route path="/marketplaces/livestock/animal/:id" element={<LivestockAnimalDetail />} />
          <Route path="/marketplaces/livestock/ranch/:businessId" element={<OrgProfile />} />
          <Route path="/marketplaces/livestock/ranches/:slug" element={<RanchList />} />
          <Route path="/marketplaces/livestock/studs/:slug" element={<LivestockForSale />} />
          <Route path="/marketplaces/livestock/:slug" element={<LivestockForSale />} />
          <Route path="/marketplaces/livestock" element={<LivestockMarketplace />} />
          <Route path="/marketplaces" element={<LivestockMarketplace />} />
          {/* Legacy ASP redirect */}
          <Route path="/livestockmarketplace/Animals/Details.asp" element={<LegacyAnimalRedirect />} />
          <Route path="/produce/meat" element={<MeatInventory />} />
          <Route path="/app/news" element={<AccountLayout allowAnonymous pageTitle="News Feed" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'News Feed' }]}><NewsFeed /></AccountLayout>} />
          <Route path="/app/news/:id" element={<AccountLayout allowAnonymous pageTitle="News Article" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'News Feed', to: '/app/news' }, { label: 'Article' }]}><ArticleDetail /></AccountLayout>} />
          <Route path="/blog/authors/manage" element={<BlogAuthors />} />
          <Route path="/blog/authors/:authorId" element={<BlogAuthorDetail />} />
          <Route path="/blog/manage" element={<BlogManage />} />
          <Route path="/blog/:postId" element={<BlogDetail />} />
          <Route path="/blog" element={<BlogList />} />

          {/* Public marketplace (anyone can browse) */}
          <Route path="/marketplace/products/:id" element={<ProductDetail />} />
          <Route path="/marketplace/products" element={<ProductsMarketplace />} />
          <Route path="/marketplace/:id" element={<MarketplaceProduct />} />

          {/* Buyer pages (login required) */}
          <Route path="/cart" element={<MarketplaceCart />} />
          <Route path="/orders" element={<MarketplaceOrders />} />
          <Route path="/orders/:orderId" element={<OrderDetail />} />

          {/* Seller pages (in AccountLayout) */}
          <Route path="/seller/orders" element={<SellerOrders />} />
          <Route path="/seller/listings" element={<SellerListings />} />

          {/* Accounting */}
          <Route path="/accounting" element={<RequireAuth><Accounting /></RequireAuth>} />

        </Routes>
        )} {/* end isCustomDomain ternary */}
      </Suspense>
    </AccountProvider>
  </BrowserRouter>
)