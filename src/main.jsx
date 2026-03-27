import React, { lazy, Suspense } from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import './index.css'
import { AccountProvider } from './AccountContext'
import './AnimalAddWizard.css'

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
const SaigePage = lazy(() => import('./SaigePage.jsx'))
const AnimalsHome = lazy(() => import('./AnimalsHome.jsx'))
const AccountChangeType = lazy(() => import('./AccountChangeType.jsx'))
const AnimalAddWizard = lazy(() => import('./AnimalAddWizard.jsx'))
const AnimalEdit = lazy(() => import('./AnimalEdit.jsx'))
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
const MeatInventory = lazy(() => import('./MeatInventory.jsx'))
const CropDetection = lazy(() => import('./CropDetection.jsx'))
const ServicesHome = lazy(() => import('./ServicesHome.jsx'))
const ServicesAdd = lazy(() => import('./ServicesAdd.jsx'))
const ServicesSuggestCategory = lazy(() => import('./ServicesSuggestCategory.jsx'))
const ServicesEdit = lazy(() => import('./ServicesEdit.jsx'))
const LivestockMarketplace = lazy(() => import('./LivestockMarketplace.jsx'))
const LivestockForSale = lazy(() => import('./LivestockForSale.jsx'))
const RanchList = lazy(() => import('./RanchList.jsx'))
const OrgProfile = lazy(() => import('./OrgProfile.jsx'))
const AccountLayout = lazy(() => import('./AccountLayout.jsx'))
const NewsFeed = lazy(() => import('./NewsFeed.jsx'))
const ArticleDetail = lazy(() => import('./ArticleDetail.jsx'))
const MarketplaceCatalog = lazy(() => import('./MarketplaceCatalog.jsx'))
const MarketplaceProduct = lazy(() => import('./MarketplaceProduct.jsx'))
const MarketplaceCart = lazy(() => import('./MarketplaceCart.jsx'))
const MarketplaceOrders = lazy(() => import('./MarketplaceOrders.jsx'))
const OrderDetail = lazy(() => import('./OrderDetail.jsx'))
const SellerOrders = lazy(() => import('./SellerOrders.jsx'))
const SellerListings = lazy(() => import('./SellerListings.jsx'))

ReactDOM.createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <AccountProvider>
      <Suspense fallback={<div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>Loading...</div>}>
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
          <Route path="/saige" element={<SaigePage />} />
          <Route path="/oatsense" element={<OatSense />} />
          <Route path="/oatsense/crop-rotation" element={<CropRotation />} />
          <Route path="/oatsense/notes" element={<OatSenseNotes />} />
          <Route path="/precision-ag/fields" element={<PrecisionAgFields />} />
          <Route path="/precision-ag/add" element={<PrecisionAgAdd />} />
          <Route path="/precision-ag/analyses" element={<PrecisionAgAnalyses />} />
          <Route path="/precision-ag/crop-detection" element={<CropDetection />} />
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
          <Route path="/produce/meat" element={<MeatInventory />} />
          <Route path="/services" element={<ServicesHome />} />
          <Route path="/services/add" element={<ServicesAdd />} />
          <Route path="/services/suggest-category" element={<ServicesSuggestCategory />} />
          <Route path="/services/edit" element={<ServicesEdit />} />

          <Route path="/marketplaces/farm-to-table" element={<MarketplaceCatalog />} />
          <Route path="/marketplaces/livestock/ranch/:businessId" element={<OrgProfile />} />
          <Route path="/marketplaces/livestock/ranches/:slug" element={<RanchList />} />
          <Route path="/marketplaces/livestock/studs/:slug" element={<LivestockForSale />} />
          <Route path="/marketplaces/livestock/:slug" element={<LivestockForSale />} />
          <Route path="/marketplaces/livestock" element={<LivestockMarketplace />} />
          <Route path="/marketplaces" element={<LivestockMarketplace />} />
          <Route path="/marketplace/:id" element={<MarketplaceProduct />} />
          <Route path="/cart" element={<MarketplaceCart />} />
          <Route path="/orders" element={<MarketplaceOrders />} />
          <Route path="/orders/:orderId" element={<OrderDetail />} />
          <Route path="/seller/orders" element={<SellerOrders />} />
          <Route path="/seller/listings" element={<SellerListings />} />
          <Route path="/app/news" element={<AccountLayout><NewsFeed /></AccountLayout>} />
          <Route path="/app/news/:id" element={<AccountLayout><ArticleDetail /></AccountLayout>} />
<<<<<<< HEAD

          {/* Public marketplace (anyone can browse) */}
          <Route path="/marketplace/:id" element={<MarketplaceProduct />} />

          {/* Buyer pages (login required) */}
          <Route path="/cart" element={<MarketplaceCart />} />
          <Route path="/orders" element={<MarketplaceOrders />} />
          <Route path="/orders/:orderId" element={<OrderDetail />} />

          {/* Seller pages (in AccountLayout) */}
          <Route path="/seller/orders" element={<SellerOrders />} />
          <Route path="/seller/listings" element={<SellerListings />} />

=======
          <Route path="*" element={<App />} />
>>>>>>> 07af3a7b3401d500bb12db4c7ab99b4c8c45eb18
        </Routes>
      </Suspense>
    </AccountProvider>
  </BrowserRouter>,
)
