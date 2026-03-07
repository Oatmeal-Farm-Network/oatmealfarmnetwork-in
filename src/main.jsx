import React, { lazy, Suspense } from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import './index.css'
import { AccountProvider } from './AccountContext';
import "./AnimalAddWizard.css";

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
const AnimalAddWizard = lazy(() => import('./AnimalAddWizard'))
const DirectoryList = lazy(() => import('./Directory/pages/DirectoryList'))
const DirectoryDetail = lazy(() => import('./Directory/pages/DirectoryDetail'))
const BusinessProfile = lazy(() => import('./Directory/pages/BusinessProfile'))
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


ReactDOM.createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <AccountProvider>
      <Suspense fallback={<div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>Loading...</div>}>
        <Routes>
          <Route path="/accounts" element={<Accounts />} />
          <Route path="/" element={<App />} />
          <Route path="/about" element={<About />} />
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<Signup />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/account" element={<AccountHome />} />
          <Route path="/account/change-type" element={<AccountChangeType />} />
          <Route path="/animals" element={<AnimalsHome />} />
          <Route path="/animals/add" element={<AnimalAddWizard />} />
          <Route path="/saige" element={<SaigePage />} />
          <Route path="/oatsense" element={<OatSense />} />
          <Route path="/oatsense/crop-rotation" element={<CropRotation />} />
          <Route path="/oatsense/notes" element={<OatSenseNotes />} />
          <Route path="/precision-ag/fields" element={<PrecisionAgFields />} />
          <Route path="/precision-ag/add" element={<PrecisionAgAdd />} />
          <Route path="/precision-ag/analyses" element={<PrecisionAgAnalyses />} />
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
          <Route path="/marketplaces" element={<Marketplaces />} />
          <Route path="/contact-us" element={<ContactUs />} />
          <Route path="/contact-us/confirm" element={<ContactUsConfirm />} />
          <Route path="/directory" element={<DirectoryList />} />
          <Route path="/directory/:directoryType" element={<DirectoryDetail />} />
          <Route path="/profile" element={<BusinessProfile />} />
          <Route path="/accounts/new" element={<AccountNew />} />
        </Routes>
      </Suspense>
    </AccountProvider>
  </BrowserRouter>
)