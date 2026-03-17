<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<% MasterDashboard= True
PageName="Working Dog" 
LSHeader = True
currentbreed="Working Dog" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Working Dog Breeds",
  "description": "Working Dog were first domesticated at least 10,000 years ago, and they are raised as for meat, milk and other dairy products, and as draft animals.",
  "author": {
    "@type": "Organization",
    "name": "Oatmeal Farm Network"
  },
  "image": "/images/Dogs.jpg" }
</script>

<style>
  /* General Body and Container Styles */
  body {
      font-family: Arial, sans-serif;
      margin: 0;
      background-color: #f8f8f8; /* Light background */
      color: #333;
      line-height: 1.6;
      font-size: 1em; /* Base font size */
  }

  .container-wrapper {
      max-width: 960px; /* Max width for central content */
      margin: 30px auto; /* Center the container with some top/bottom margin */
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  }

  /* Header for the Page */
  .page-header {
      text-align: center;
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 2px solid #ddd;
  }

  .page-header h1 {
      color: black; /* Blue heading */
      font-size: 2.5em;
      margin: 0;
      display: inline-flex; /* Align icon and text */
      align-items: center;
  }

  .page-header h1 img {
      margin-right: 15px;
      vertical-align: middle;
  }

  /* View Breeds Link */
  .view-breeds-link {
      display: block; /* Make it a block to take full width */
      text-align: left; /* Align to left */
      margin-bottom: 20px;
      font-size: 1.1em;
      font-weight: bold;
      color: black; /* Link color */
      text-decoration: none;
  }
  .view-breeds-link:hover {
      text-decoration: underline;
  }

  /* Floated Media (Image) Styles */
  .floated-media {
      width: 200px; /* Fixed width for floated content */
      margin-bottom: 20px; /* Space below the media block */
      box-sizing: border-box; /* Include padding/border in width */
      border-radius: 8px; /* Rounded corners for the media block */
      overflow: hidden; /* Ensures child rounded corners are respected */
      box-shadow: 0 2px 8px rgba(0,0,0,0.1); /* Subtle shadow */
      background-color: #f0f0f0; /* Light background for the media block */
      padding: 10px; /* Padding inside the media block */
  }

  .floated-media.float-right {
      float: right;
      margin-left: 25px; /* Space between media and text on its left */
  }

  .floated-media.float-left {
      float: left;
      margin-right: 25px; /* Space between media and text on its right */
  }

  .floated-media img {
      max-width: 100%; /* Image should fill its container */
      height: auto;
      display: block; /* Remove extra space below image */
      border-radius: 5px; /* Slightly rounded corners for actual media */
  }

  .media-caption {
      font-size: 0.9em;
      color: #666;
      margin-top: 8px;
      text-align: center;
  }

  /* Main Content Paragraphs */
  .main-content-text p {
      margin-bottom: 1em; /* Space between paragraphs */
      text-align: justify; /* Justify text for a cleaner block look */
  }

  /* Clearfix to ensure content below floats properly */
  .clearfix::after {
      content: "";
      display: table;
      clear: both;
  }

  /* Colors Section */
  .colors-section {
      margin-top: 30px; /* Space above colors section */
      padding-top: 20px;
      border-top: 1px solid #eee; /* Separator above colors */
  }

  .colors-section h2 {
      color: #4CAF50; /* Green heading for colors */
      font-size: 1.8em;
      margin-bottom: 15px;
      text-align: left;
  }

  .colors-section ul {
      list-style: disc; /* Bullet points */
      padding-left: 25px; /* Indent list items */
      margin-bottom: 0;
  }

  .colors-section li {
      margin-bottom: 5px;
  }

  /* Responsive Adjustments */
  @media (max-width: 768px) {
      .floated-media {
          float: none; /* Remove float */
          margin: 20px auto; /* Center horizontally */
          width: 90%; /* Make it wider on small screens */
          max-width: 350px; /* Max width for consistency */
      }
  }
</style>
</HEAD>
<body >
<% LSHeader = True 
currentbreed="Working Dog"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="Working Dog Breeds" height="50"/>
          About Working Dog 
      </h1>
  </div>

  <div class="main-content-text clearfix"> 

      <a href="Default.asp" class="view-breeds-link">View Working Dog Breeds</a>

      <div class="floated-media float-right">
          <img src="/images/Dogs.jpg" alt="Dog" width = "200px" />
      </div>

      <br />

      Throughout the annals of human history, man and dog have forged a bond that spans millennia. From the pastoral fields to the bustling streets, these loyal canines have etched an indelible mark on our shared existence.<br /><br />
  
  In ancient Egypt, dogs were entrusted with vital roles in hunting, herding, and safeguarding. Hellenic and Roman civilizations followed suit, employing these noble creatures in a myriad of tasks, from guarding livestock and property to waging war.<br /><br />
  
  The Middle Ages witnessed a pivotal shift, as working dogs assumed an indispensable role in the agricultural tapestry. They labored tirelessly to gather livestock, plow the earth, and transport goods. Their keen senses also proved invaluable in hunting and safeguarding, further cementing their place in our world.<br /><br />
  
  The Industrial Revolution ushered in a new era of specialized working dogs. Bloodhounds tracked criminals with unerring determination, while St. Bernards undertook heroic Alpine rescues. German shepherds stood sentinel as guardians of law and order, their steadfast loyalty and courage unmatched.<br /><br />
  
  World War I and II saw working dogs on both sides of the conflict demonstrate valor beyond compare. They served as messengers, scouts, and guardians, their bond with their human companions unbreakable. German shepherds traversed treacherous battlefields with fleetness of foot and clarity of mind, delivering messages that bridged the divide. Belgian Malinois unearthed hidden dangers in the form of mines and explosives with their keen noses.<br /><br />
  
  In the modern era, working dogs continue to play a vital role in our society, their tireless devotion spanning a vast array of vocations. From therapy and education to law enforcement and the military, these steadfast companions offer solace, enlightenment, protection, and emotional succor.<br /><br />
  
  A rich diversity of working dog breeds, each with its own unique proficiencies, emerges from the tapestry of history. Vigilant herders—border collies, German shepherds, and Australian kelpies—steadfastly watch over and guide our flocks. Guardians—Rottweilers, Doberman pinschers, and their ilk—stand resolute in their charge to protect both life and property. Stalwart police forces led by German shepherds, Belgian Malinois, and Labrador retrievers valiantly uphold the mantle of law and order. Military endeavors are bolstered by the indomitable spirit of German shepherds, Belgian Malinois, and Labrador retrievers, discerning foes and locating the lost. In the heart of the wilderness, search and rescue missions are embarked upon by German shepherds, Labrador retrievers, and golden retrievers, unyielding in their pursuit of those in need. Medical assistance dogs—guiding lights for the sightless and vigilant sentinels for the hearing impaired— bestow independence and dignity upon those they serve.<br /><br />
  
  Working dogs are more than mere adjuncts to our lives; they are steadfast companions who offer both protection and emotional succor. They are the sentinels that keep us safe, the emissaries that bridge the divide, and the steadfast beacons that guide us through life's labyrinth.<br /><br />
  
  Let us be ever grateful for the profound contributions these remarkable creatures make to our collective existence.<br /><br />
  



      <% If Not rs.State = adStateClosed Then
          rs.Close
      End If %> <% ' Ensure previous recordset is closed before re-using 'rs' %>

      <%
      Set rs = Server.CreateObject("ADODB.Recordset") ' Re-create recordset for colors
      sql2 = "select * from SpeciesColorlookupTable where SpeciesID = " & SpeciesID & " order by SpeciesColor "
      rs.Open sql2, conn, 3, 3

      If Not rs.EOF Then %>
          <div class="colors-section">
              <h2><%= SpeciesName %> Colors</h2>
              <p><%= SpeciesNamePlural %> come in the following colors:</p>
              <ul>
                  <% While Not rs.EOF %>
                      <li><%=rs("SpeciesColor")%></li>
                  <%
                      rs.MoveNext
                  Wend %>
              </ul>
          </div>
      <% End If

      rs.Close
      Set rs = Nothing ' Clear recordset object
      %>

  </div> <% ' End of .main-content-text %>

</div> <% ' End of .container-wrapper %>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>