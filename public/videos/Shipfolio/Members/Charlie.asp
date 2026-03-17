<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
    body {
        font-family: 'Inter', sans-serif;
        margin: 0;
        padding: 0;
        display: flex; /* Enable flexbox for the body */
        flex-direction: column; /* Arrange content vertically */
        min-height: 100vh; /* Ensure body takes full viewport height */
        /* Removed overflow: hidden from body to allow scrolling */
    }
    .dashboard-section {
        background-color: #fff;
        border-radius: 1.5rem;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        border: 1px solid #E5E7EB;
        padding: 1.5rem;
        margin-bottom: 1rem; /* Add margin between sections */
    }
    .dashboard-link-card-title {
        font-size: 12pt;
        font-weight: normal;
        color: #3D6B34;
        margin: 0;
        line-height: 1.2;
        text-decoration: none;
    }

    /* Main content area that will hold the iframe */
    .main-content-area {
        flex-grow: 1; /* Allows this container to take up all available vertical space */
        display: flex;
        flex-direction: column;
        padding: 1rem; /* Padding around the main content, including the iframe */
        /* If you want scrolling for this specific area only, you could add overflow-y: auto here */
    }

    .iframe-container {
        flex-grow: 1; /* Allows the iframe container to expand */
        display: flex;
        background-color: #e0f2f7; /* Light blue background for the iframe area */
        border-radius: 1.5rem;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        overflow: hidden; /* Ensures iframe corners match container border-radius */
        height: 700px; /* Ensure a minimum height for the iframe container */
    }

    .iframe-container iframe {
        width: 100%;
        height: 100%; /* Iframe fills its parent container */
        border: none;
    }

    /* Footer specific styling (optional, based on your original) */
    .footer {
        margin-top: 1rem; /* Margin above the footer */
    }
</style>

 <%
   
agentstring = "https://multi-container-agent-app-dev.orangepond-1d33f6fb.eastus.azurecontainerapps.io//?PeopleID=" & PeopleID & "&BusinessID=" & BusinessID & "&SessionID=" & lcase(Session("SessionID")) & ""

    %>

<main class="main-content-area">
    <div class="iframe-container">
        <iframe
            src="<%=agentstring%>"
            title="Charlie"
            allow="microphone"
            loading="lazy">
        </iframe>
    </div>
</main>


<% showCharlie = False %>
<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body></html>