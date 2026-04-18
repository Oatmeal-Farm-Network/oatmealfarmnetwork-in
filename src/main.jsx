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
import EventClone from './EventClone';
import BlogList from './BlogList';
import BlogDetail from './BlogDetail';
import BlogManage from './BlogManage';
import BlogAuthors from './BlogAuthors';
import BlogAuthorDetail from './BlogAuthorDetail';


const App = lazy(() => import('./App.jsx'))
const About = lazy(() => import('./About.jsx'))
const Login = lazy(() => import('./login.jsx'))
const Signup = lazy(() => import('./Signup.jsx'))
const Dashboard = lazy(() => import('./Dashboard.jsx'))
const AccountHome = lazy(() => import('./AccountHome.jsx'))
const OatSense = lazy(() => import('./OatSense.jsx'))
const PrecisionAgFields = lazy(() => import('./PrecisionAgFields.jsx'))
const PrecisionAgAdd = lazy(() => import('./PrecisionAgAdd.jsx'))
const PrecisionAgAnalyses = lazy(() => import('./PrecisionAgAnalyses.jsx'))
const CropRotation = lazy(() => import('./CropRotation.jsx'))
const OatSenseNotes = lazy(() => import('./OatSenseNotes.jsx'))
const WebsiteBuilder = lazy(() => import('./WebsiteBuilder.jsx'))
const WebsitePublic = lazy(() => import('./WebsitePublic.jsx'))
const AudioSettings = lazy(() => import('./AudioSettings.jsx'))
const AccountSettings = lazy(() => import('./AccountSettings.jsx'))
const SaigePage = lazy(() => import('./SaigePage.jsx'))
const CompanionPlanting = lazy(() => import('./CompanionPlanting.jsx'))
const CropNames = lazy(() => import('./CropNames.jsx'))
const WeatherMitigation = lazy(() => import('./WeatherMitigation.jsx'))
const RegionCrops = lazy(() => import('./RegionCrops.jsx'))
const SoilChallenges = lazy(() => import('./SoilChallenges.jsx'))
const PestDetection = lazy(() => import('./PestDetection.jsx'))
const PriceForecast = lazy(() => import('./PriceForecast.jsx'))
const Subsidies = lazy(() => import('./Subsidies.jsx'))
const Insurance = lazy(() => import('./Insurance.jsx'))
const PushNotifications = lazy(() => import('./PushNotifications.jsx'))
const SaigeProfile = lazy(() => import('./SaigeProfile.jsx'))
const AnimalsHome = lazy(() => import('./AnimalsHome.jsx'))
const AnimalDelete = lazy(() => import('./AnimalDelete.jsx'))
const AnimalPackages = lazy(() => import('./AnimalPackages.jsx'))
const AccountChangeType = lazy(() => import('./AccountChangeType.jsx'))
const AnimalAddWizard = lazy(() => import('./AnimalAddWizard'))
const DirectoryList = lazy(() => import('./Directory/pages/DirectoryList'))
const DirectoryDetail = lazy(() => import('./Directory/pages/DirectoryDetail'))
const Accounts = lazy(() => import('./Accounts.jsx'))
const Knowledgebases = lazy(() => import('./Knowledgebases.jsx'))
const IngredientKnowledgebase = lazy(() => import('./IngredientKnowledgebase.jsx'))
const IngredientCategory = lazy(() => import('./IngredientCategory.jsx'))
const IngredientVarieties = lazy(() => import('./IngredientVarieties.jsx'))
const LivestockDB = lazy(() => import('./LivestockDB.jsx'))
const LivestockSpecies = lazy(() => import('./LivestockSpecies.jsx'))
const LivestockBreed = lazy(() => import('./LivestockBreed.jsx'))
const LivestockAbout = lazy(() => import('./LivestockAbout.jsx'))
const PlantKnowledgebase = lazy(() => import('./PlantKnowledgebase.jsx'))
const PlantCategory = lazy(() => import('./PlantCategory.jsx'))
const PlantVarietals = lazy(() => import('./PlantVarietals.jsx'))
const PlantVarietalDetail = lazy(() => import('./PlantVarietalDetail.jsx'))
const Marketplaces = lazy(() => import('./Marketplaces.jsx'))
const ContactUs = lazy(() => import('./ContactUs.jsx'))
const ContactUsConfirm = lazy(() => import('./ContactUsConfirm.jsx'))
const AccountNew = lazy(() => import('./AccountNew.jsx'))
const AccountProfile = lazy(() => import('./AccountProfile.jsx'))
const AccountDelete = lazy(() => import('./AccountDelete.jsx'))
const ProduceInventory = lazy(() => import('./ProduceInventory.jsx'))
const ProcessedFoodInventory = lazy(() => import('./ProcessedFoodInventory.jsx'))
const CropDetection = lazy(() => import('./CropDetection.jsx'))
const ServicesHome = lazy(() => import('./ServicesHome.jsx'))
const ServicesAdd = lazy(() => import('./ServicesAdd.jsx'))
const ServicesSuggestCategory = lazy(() => import('./ServicesSuggestCategory.jsx'))
const ServicesEdit = lazy(() => import('./ServicesEdit.jsx'))
const FarmToTableMarketplace = lazy(() => import('./FarmToTableMarketplace.jsx'))
const ProductsMarketplace = lazy(() => import('./ProductsMarketplace.jsx'))
const ProductDetail = lazy(() => import('./ProductDetail.jsx'))
const LivestockMarketplace = lazy(() => import('./LivestockMarketplace.jsx'))
const LivestockForSale = lazy(() => import('./LivestockForSale.jsx'))
const LivestockAnimalDetail = lazy(() => import('./LivestockAnimalDetail.jsx'))
const LivestockAnimalProgeny = lazy(() => import('./LivestockAnimalProgeny.jsx'))
const RanchList = lazy(() => import('./RanchList.jsx'))
const OrgProfile = lazy(() => import('./OrgProfile.jsx'))
const Accounting = lazy(() => import('./Accounting.jsx'))
const TestimonialsManage = lazy(() => import('./TestimonialsManage.jsx'))
const TestimonialsRequest = lazy(() => import('./TestimonialsRequest.jsx'))

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
          <Route path="/app/news" element={<AccountLayout pageTitle="News Feed" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'News Feed' }]}><NewsFeed /></AccountLayout>} />
          <Route path="/app/news/:id" element={<AccountLayout pageTitle="News Article" breadcrumbs={[{ label: 'Dashboard', to: '/dashboard' }, { label: 'News Feed', to: '/app/news' }, { label: 'Article' }]}><ArticleDetail /></AccountLayout>} />
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