import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import App from './App.jsx'
import About from './About.jsx'
import Login from './login.jsx'
import Signup from './Signup.jsx'
import Dashboard from './Dashboard.jsx'
import './index.css'
import AccountHome from './AccountHome.jsx';
import OatSense from './OatSense.jsx';
import PrecisionAgFields from './PrecisionAgFields.jsx';
import PrecisionAgAdd from './PrecisionAgAdd.jsx';
import PrecisionAgAnalyses from './PrecisionAgAnalyses.jsx';
import CropRotation from './CropRotation.jsx';
import OatSenseNotes from './OatSenseNotes.jsx';
import SaigePage from './SaigePage.jsx';
import AnimalsHome from './AnimalsHome.jsx';
import AccountChangeType from './AccountChangeType.jsx';
import { AccountProvider } from './AccountContext';
import AnimalAddWizard from "./AnimalAddWizard";
import "./AnimalAddWizard.css";
import DirectoryList from './Directory/pages/DirectoryList';
import DirectoryDetail from './Directory/pages/DirectoryDetail';
import BusinessProfile from './Directory/pages/BusinessProfile';
import Accounts from './Accounts.jsx';
import Knowledgebases from './Knowledgebases.jsx';
import Marketplaces from './Marketplaces.jsx';
import ContactUs from './ContactUs.jsx';
import ContactUsConfirm from './ContactUsConfirm.jsx';



ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      <AccountProvider>
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
          <Route path="/marketplaces" element={<Marketplaces />} />
          <Route path="/contact-us" element={<ContactUs />} />
          <Route path="/contact-us/confirm" element={<ContactUsConfirm />} />
          <Route path="/directory" element={<DirectoryList />} />
          <Route path="/directory/:directoryType" element={<DirectoryDetail />} />
          <Route path="/profile" element={<BusinessProfile />} />
        </Routes>
      </AccountProvider>
    </BrowserRouter>
  </React.StrictMode>,
)
