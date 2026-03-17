<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>

<link rel="canonical" href="https://www.OatmealFarmNetwork.com/Chickens/AboutChickens.asp" />
<% MasterDashboard= True
PageName="Chickens" 
LSHeader = True
currentbreed="Chickens" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Breeds of Chickens | Chicken Breeds</title>
<meta name="Title" content="Breeds of Chickens | Chicken Breeds"/>
<meta name="Description" content="Most breeds of chickens can fly for short distances and some roost in trees. Chickens are omnivores. In the wild, they often scratch at the soil to search for seeds, insects and even animals as large as lizards, small snakes or young mice."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>
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
      color: black /* Blue heading */
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
      color: #007bff; /* Link color */
      text-decoration: none;
  }
  .view-breeds-link:hover {
      text-decoration: underline;
  }

  /* Floated Image Styles */
  .floated-image {
      float: right; /* Aligns image to the right */
      width: 300px; /* Fixed width for the image */
      margin: 0 0 20px 25px; /* Top, Right, Bottom, Left margins (space around the image) */
      box-sizing: border-box;
      max-width: 100%; /* Ensure it doesn't overflow on small screens */
      border-radius: 8px; /* Rounded corners for the image block */
      overflow: hidden; /* Ensures child rounded corners are respected */
      box-shadow: 0 2px 8px rgba(0,0,0,0.1); /* Subtle shadow */
      background-color: #f0f0f0; /* Light background for the image block */
      padding: 10px; /* Padding inside the image block */
  }

  .floated-image img {
      max-width: 100%; /* Image should fill its container */
      height: auto;
      display: block; /* Remove extra space below image */
      border-radius: 5px; /* Slightly rounded corners for actual image */
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
      .floated-image {
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
currentbreed="Chickens"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 


Set rs2 = Server.CreateObject("ADODB.Recordset")	
%>
<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="About Chickens" height="40"/>
          About Chickens
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/Members/LivestockDB/Chickens/#Breeds" class="view-breeds-link">View Chicken Breeds</a>

      <div class="floated-image">
          <img src="AboutChickens.jpg" alt="Chickens" />
          <% ' No caption in original, but you can add <p class="media-caption">Your Caption</p> here if needed %>
      </div>

      <p>Chickens (Gallus gallus domesticus) are domesticated birds that are raised for meat and eggs. There are over 24 billion chickens worldwide. Raising chickens is relatively inexpensive. Because of the low cost, chicken meat (also called "chicken") is one of the most common kinds of meat in the world.</p>
      <p>Most breeds of chickens can fly for short distances and some roost in trees. Chickens are omnivores. In the wild, they often scratch at the soil to search for seeds, insects and even animals as large as lizards, small snakes or young mice. Chickens may live for five to ten years, depending on their breed. The world's oldest chicken died of heart failure at the age of 16 according to Guinness World Records.</p>
      <p>Male chickens are called a rooster or a cocks (short for cockerel), female chickens are called hens, and young chicken are called a chicks. Roosters can usually be differentiated from hens by a striking plumage of long flowing tails and shiny pointed feathers on their necks (hackles) and backs (saddle.) However, in some breeds, such as the Sebright chicken, the rooster has only slightly pointed neck feathers, the same color as the hen's.</p>
      <p>Adult chickens have a fleshy crest on their heads called a comb, or cockscomb, and hanging flaps of skin either side under their beaks called wattles. Collectively, these and other fleshy protuberances on the head and throat are called caruncles. Both roosters and hens female have wattles and combs, but in most breeds they are more prominent in males. Several breeds of chickens have an extra feathering under their face, giving the appearance of a beard.</p>
      <p>Genetic studies have indicated that chickens originated in Asia. From India, the domesticated chicken was imported to Lydia in western Asia Minor, and to Greece by the fifth century BC. Chickens had been known in Egypt since the mid-15th century BC, with the "bird that gives birth every day" having come to Egypt from the land between Syria and Shinar, Babylonia. The chicken genome has changed less from their dinosaur ancestors than most birds.</p>
      <p>Overall chickens are an excellent livestock for a backyard farm, a small, ranch, or a major ranching business. They are fairly low maintenance, safe around small kids, and their eggs and meat are eggcellent…especially when they were laid on your own farm, or backyard!</p>

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
<!--#Include virtual="/Members/membersFooter.asp"-->
</body>
</html>