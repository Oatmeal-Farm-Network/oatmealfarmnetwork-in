import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import App from './App.jsx'
import About from './About.jsx'
import Login from './login.jsx'
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


ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route path="/saige" element={<SaigePage />} />
        <Route path="/oatsense/crop-rotation" element={<CropRotation />} />
        <Route path="/oatsense/notes" element={<OatSenseNotes />} />
        <Route path="/precision-ag/fields" element={<PrecisionAgFields />} />
        <Route path="/precision-ag/add" element={<PrecisionAgAdd />} />
        <Route path="/precision-ag/analyses" element={<PrecisionAgAnalyses />} />
        <Route path="/oatsense" element={<OatSense />} />
        <Route path="/account" element={<AccountHome />} />
        <Route path="/" element={<App />} />
        <Route path="/about" element={<About />} />
        <Route path="/login" element={<Login />} />
        <Route path="/dashboard" element={<Dashboard />} />
      </Routes>
    </BrowserRouter>
  </React.StrictMode>,
)