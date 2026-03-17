<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<% MasterDashboard= True
PageName="Buffalo" 
LSHeader = True
currentbreed="Buffalo" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

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
<% LSHeader = True %>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 
Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="About Buffalo" height="40"/>
          About Buffalo
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/members/livestockdb/Buffalo/#Breeds" class="view-breeds-link">View Buffalo Breeds</a>

      <div class="floated-image">
          <img src="WaterBuffalo.jpg" alt="Buffalo" />
          <% ' No caption in original, but you can add <p class="media-caption">Your Caption</p> here if needed %>
      </div>

      <p>The term buffalo is used to refer to several different species of bovine animals, including the African buffalo and water Buffalo. Sometimes the term is used incorrectly to refer American Bison, Bison are not a type of Buffalo. In most cases domesticated Buffalo are Water Buffalo.</p>
      <p>Water Buffalo (also known as Asian buffalo, or domestic Asian water buffalo) are a large domestic bovid that is native to Southeast Asia. They are one of the largest domestic animals, with adult males weighing between 800-1,200 kilograms (1,765-2,646 pounds) and adult females weighing between 500-800 kilograms (1,102-1,764 pounds).</p>
      <p>Water buffalo are highly valued for their meat, hides, and dung, which is used as fuel and fertilizer. In many parts of the world, they are also used as draft animals for plowing and transportation, and their milk is used for dairy products.</p>
      <p>Water buffalo have a distinctive appearance, with long, curved horns that are set wide apart on their head, a shaggy mane of hair on the neck, and a large hump on their shoulders. They have a stocky build and a thick, shaggy coat that helps to keep them cool in their native warm climates.</p>
      <p>There are two main breeds of water buffalo: the Swamp Buffalo, which is native to the Southeast Asian region and is well-adapted to wet and marshy environments, and the River Buffalo, which is found in the Indian subcontinent and is well-suited to hot, arid regions.</p>
      <p>Water buffalo are hardy animals that can thrive in a variety of environments, and they are well-known for their strength, endurance, and ability to perform heavy labor. Despite their usefulness, however, their populations have declined in recent years due to habitat loss, over-harvesting, and disease. Conservation efforts are underway to protect and preserve this important species.</p>

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

  </div> 
</div> 
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>