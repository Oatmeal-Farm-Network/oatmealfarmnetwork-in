<style>
/* --- BASE STYLES & GLOBALS --- */
body { 

    color: #ecf0f1;
}

.navbar {
    z-index: 102; 
    width: 100%; 
    margin-left: 0; 
    position: fixed;
    top: 0;
    left: 0; 
    background-color: #212529;
    transition: width 0.3s ease; 
    padding-left: 15px; 
}

/* Spacing for buttons on desktop/tablet */
.navbar-nav .nav-item {
    margin-left: 10px; 
}

/* Style the buttons inside the mobile sidebar */
.sidebar-mobile-buttons {
    padding: 10px 15px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 10px;
}
.sidebar-mobile-buttons .login-button {
    width: 100%;
    margin-bottom: 8px; 
}

/* -------------------------------------- */
/* --- 2. SIDEBAR ADJUSTMENTS (Fixed Position & Spacing) --- */
/* -------------------------------------- */

.sidebar {
  width: 250px; 
  min-height: calc(100vh - 80px); 
  height: auto;
  padding: 0; 
  box-sizing: border-box;

  /* Glassy Effect */
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 0 15px 15px 0; 
  box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);

  /* Positioning */
  position: fixed;
  top: 80px; 
  left: 0;

  /* Text & Transitions */
  color: #e0e0e0;
  transition: width 0.3s ease, margin-left 0.3s ease;
  z-index: 100; 
}

/* Sidebar Header Area (for Logo/Title and Toggle Button) */
.sidebar-header {
    display: flex;
    align-items: center;
    justify-content: space-between; 
    padding: 10px 10px 10px 25px; 
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    white-space: nowrap; 
    position: relative; 
}

.sidebar-header img {
    width: 30px; 
    height: 30px;
    margin-right: 10px;
}

.sidebar-header .nav-label {
    font-weight: bold;
    font-size: 1.2em;
    opacity: 1;
    transition: opacity 0.3s ease, width 0.3s ease;
    max-width: 150px; 
    overflow: hidden;
    text-overflow: ellipsis;
}

/* Toggle Button Styling (inside sidebar-header) */
.toggle-btn {
  background: none;
  border: none;
  color: #e0e0e0;
  cursor: pointer;
  font-size: 1.2em;
  transition: transform 0.3s ease;
  z-index: 10;
}

/* List Styling */
.sidebar ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

/* List Item Styling - Ensures the background covers the navigation text */
.sidebar li {
    display: flex;
    align-items: center;
    padding: 0; 
    margin-bottom: 5px;
    font-size: 1.1em;
    cursor: pointer;
    transition: background-color 0.3s ease, color 0.3s ease;
    white-space: nowrap; 
    position: relative; 
    background-color: transparent; 
    width: 100%; 
}

/* Anchor tag for full clickable area */
.sidebar li a {
    display: flex;
    align-items: center;
    width: 100%;
    padding: 12px 25px; /* Apply padding here for expanded state */
    color: inherit;
    text-decoration: none;
}

/* Icon Styling */
.sidebar li i {
  margin-right: 15px;
  font-size: 1.2em;
  transition: margin 0.3s ease;
  flex-shrink: 0; 
}

/* Text Label Styling */
.nav-label {
    opacity: 1;
    transition: opacity 0.3s ease;
    flex-grow: 1; 
    width: 100%; 
}

/* Hover Effect - Should now cover the full width defined by padding */
.sidebar li:hover {
  background-color: rgba(255, 255, 255, 0.2);
  color: #ffffff;
  border-radius: 8px;
}

/* Selected State */
.sidebar li.active {
  background-color: rgba(255, 255, 255, 0.25);
  color: #ffffff;
  border-left: 3px solid #00c6ff;
}

/* Added bottom padding to the content wrapper to ensure background extends beneath the list */
.nav-content {
    padding-bottom: 20px; 
}

/* --------------------------------------- */
/* --- 3. COLLAPSIBLE FEATURE STYLES (Desktop) --- */
/* --------------------------------------- */

.sidebar.collapsed {
  width: 70px; 
  /* FIX: Add padding-left to push the icons and header right by 10px */
  padding-left: 10px; 
}

/* When sidebar is collapsed, position the chevron correctly */
.sidebar.collapsed .sidebar-header #sidebarToggle {
    position: static; 
    margin-right: 0; 
    transform: rotate(0deg); 
    padding: 5px;
}

/* FIX: Ensure the CHEVRON is always visible and positioned correctly when expanded */
.sidebar:not(.collapsed) .sidebar-header #sidebarToggle {
    position: absolute;
    right: 5px; 
    top: 50%;
    transform: translateY(-50%) rotate(0deg);
    padding: 5px;
}

/* When collapsed, hide the logo text */
.sidebar.collapsed .sidebar-header .nav-label {
    opacity: 0;
    width: 0;
}

/* Ensure the header aligns and centers correctly when collapsed */
.sidebar.collapsed .sidebar-header {
    justify-content: center; 
    padding: 10px 0 10px 0; 
}

/* Center the image when collapsed */
.sidebar.collapsed .sidebar-header img {
    margin-right: 0; 
}

/* When collapsed, hide the navigation text */
.sidebar.collapsed .nav-label {
    opacity: 0;
    width: 0;
    overflow: hidden;
}

/* FIX: Ensure the link content is centered and icons are visible when collapsed */
/* We need to adjust the center position slightly now that the parent has padding-left: 10px */
.sidebar.collapsed .nav-content ul li a {
    padding: 12px 0; /* No horizontal padding here */
    justify-content: center;
    /* Adjust width to account for the parent's padding */
    width: calc(100% - 10px); 
}

/* FIX: Ensure the icon has no margin when collapsed, helping centering */
.sidebar.collapsed .nav-content ul li i {
    margin: 0;
}

/* Tooltip/Hover Label Creation (Desktop) */
.sidebar.collapsed .nav-content ul li:hover:after {
  content: attr(data-label);
  position: absolute; 
  /* Adjust left position due to the new 10px padding on the sidebar itself */
  left: 65px; 
  top: 50%;
  transform: translateY(-50%);
  
  /* Tooltip Styling */
  background: rgba(0, 0, 0, 0.85);
  color: #fff;
  padding: 8px 12px;
  border-radius: 4px;
  z-index: 99;
  pointer-events: none;
  opacity: 1;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}

/* --- Content Area Shifts --- */
.content-area {
    margin-left: 250px; 
    min-height: 600px;
    transition: margin-left 0.3s ease;
}

.sidebar.collapsed + .content-area {
    /* Adjust margin to account for the new sidebar width (70px) and its padding (10px) */
    margin-left: 70px; 
}

/* --------------------------------------- */
/* --- 4. MOBILE / HAMBURGER NAVIGATION LOGIC --- */
/* --------------------------------------- */

@media (max-width: 991px) { 
    /* Bootstrap Collapse Fix: Ensures the collapse is closed when not explicitly open */
    .navbar-collapse:not(.show) {
        display: none !important; 
    }
    
    /* Hide the desktop toggle button on mobile */
    .sidebar-header #sidebarToggle {
        display: none; 
    }
    
    /* Sidebar should start hidden, pulled off the screen */
    .sidebar {
        margin-left: -250px; 
        transition: margin-left 0.3s ease;
        left: 0;
        padding-left: 0; /* Ensure no padding on mobile hidden state */
    }
    
    /* When the sidebar has the 'collapsed' class, it means OPEN on mobile */
    .sidebar.collapsed {
        margin-left: 0;
        width: 250px; 
        padding: 0; 
        min-height: calc(100vh - 80px); 
        height: auto;
    }

    /* FIX: Force the text labels to be visible when the sidebar is open on mobile */
    .sidebar.collapsed .nav-label {
        opacity: 1; 
        width: auto;
        overflow: visible;
    }
    
    /* FIX: Restore desktop header style when expanded on mobile */
    .sidebar.collapsed .sidebar-header {
        justify-content: space-between;
        padding: 10px 10px 10px 25px; 
    }

    /* FIX: Restore link padding and justify when expanded on mobile */
    .sidebar.collapsed .nav-content ul li a {
        padding: 12px 25px;
        justify-content: flex-start;
        width: 100%; /* Restore full width */
    }

    /* FIX: Restore icon margin next to visible text on mobile */
    .sidebar.collapsed .nav-content ul li i {
        margin-right: 15px; 
    }

    /* Content area fills full width on mobile */
    .content-area {
        margin-left: 0 !important;
    }
    
    /* Hide desktop tooltip logic on mobile so it doesn't interfere */
    .sidebar.collapsed .nav-content ul li:hover:after {
        content: none;
    }
}
</style>


<nav class="navbar navbar-dark navbar-expand-lg" id="topNavbar">
  <div class="container-fluid">
    <a class="navbar-brand" href="/shipfolio/default.asp"><img src="/shipfolio/images/ShipfolioLogo.webp" width = "50px">&nbsp;&nbsp;&nbsp;</a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse justify-content-end d-none d-lg-flex" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <button type="button" class="login-button" style="min-width: 100px" onclick="window.location.href='/Shipfolio/Regenerate.asp'">Regenerate</button>
            </li>
            <li class="nav-item">
                <button type="button" class="login-button" style="min-width: 100px" onclick="window.location.href='/Shipfolio/logout.asp'">Logout</button>
            </li>
            <li class="nav-item">
                <button type="button" class="login-button" style="min-width: 100px" onclick="window.location.href='/Shipfolio/Publish.asp'">Publish</button>
            </li>
        </ul>
    </div>
  </div>
</nav>

<div class="sidebar" id="mySidebar">
  
  <div class="sidebar-header">
   
    <span class="nav-label">&nbsp;</span>
    
    <button id="sidebarToggle" class="toggle-btn" aria-label="Toggle Sidebar">
      <i class="fas fa-chevron-left"></i>
    </button>
  </div>

  <div class="sidebar-mobile-buttons d-lg-none">
      <button type="button" class="login-button" onclick="window.location.href='/Shipfolio/Regenerate.asp'">Regenerate</button>
      <button type="button" class="login-button" onclick="window.location.href='/Shipfolio/logout.asp'">Logout</button>
      <button type="button" class="login-button" onclick="window.location.href='/Shipfolio/Publish.asp'">Publish</button>
  </div>
  
  <div class="nav-content">
    <ul>
      <li data-label="Dashboard"><a href="default.asp" class = "body"><i class="fas fa-chart-line"></i><span class="nav-label"><b>Dashboard</b></span></a></li>
      <li data-label="Theme"><a href="theme.asp" class = "body"><i class="fas fa-sun"></i><span class="nav-label">Theme</span></a></li>
      <li data-label="Font"><a href="fonts.asp" class = "body"><i class="fas fa-font"></i> <span class="nav-label"><b>Fonts</b></span></a></li>
      <li data-label="Interactions"><a href="interactions.asp" class = "body"><i class="fas fa-mouse-pointer"></i><span class="nav-label"><b>Interactions</b></span></a></li>
      <li data-label="Progress"><a href="progress.asp" class = "body"><i class="fas fa-spinner"></i><span class="nav-label"><b>Progress</b></span></a></li>
      <li data-label="Tutorial"><a href="tutorial.asp" class = "body"><i class="fas fa-video"></i><span class="nav-label"><b>Tutorial</b></span></a></li>
      <li data-label="Checker"><a href="checker.asp" class = "body"><i class="fas fa-briefcase"></i><span class="nav-label"><b>Checker</b></span></a></li>
      <li data-label="Interview"><a href="interview.asp" class = "body"><i class="fas fa-comments"></i><span class="nav-label"><b>Interview</b></span></a></li>
      <li data-label="Chat"><a href="chat.asp" class = "body"><i class="fas fa-comment-dots"></i><span class="nav-label"><b>Chat</b></span></a></li>
      <li data-label="Settings"><a href="settings.asp" class = "body"><i class="fas fa-cog"></i><span class="nav-label"><b>Settings</b></span></a></li>
      <li data-label="Help"><a href="help.asp" class = "body"><i class="fas fa-question-circle"></i><span class="nav-label"><b>Help</b></span></a></li>
    </ul>
  </div>
</div>

<div class="content-area" style="min-height: 1600px;">
  <div class="container">
    <div class="row">
