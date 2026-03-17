<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
      <% MasterDashboard= True
      PageName="Bison" %>
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
      color: #2196f3; /* Blue heading */
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
      width: 150px; /* Fixed width for the image */
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
currentbreed="Bison" %>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 
Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
<div class="container-wrapper">

  <div >
      <h1>
          <img src="<%=BreedIcon %>" alt="About Bison" height="40"/>
          About Bison
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/Members/LivestockDB/Bison/#Breeds" class="view-breeds-link">View Bison Breeds</a>

      <div class="floated-image">
          <img src="/images/bison.jpg" alt="Bison" />
          <% ' There was no caption for this image in the original code, but you could add one here if desired %>
      </div>

      <p>Millions of bison once thundered across America. Today, approximately 500,000 bison live across North America. Bison are large, even-toed ungulates in the genus Bison within the subfamily Bovinae. The America Bison has two subspecies, the Plains Bison and the Wood Bison. Four extinct species were the North American: Bison antiquus, B. latifrons, and B. occidentalis, as well as the B. priscus that ranged across Western Europe and Central Asia.</p>
      <p>The 2 existing species are the American bison, B. bison, found only in North America, and often referred as a "buffalo" and B. bonasus, or Wisent, is found in Europe and the Caucasus.</p>
      <p>Sometimes bison are bred with domestic cattle and produce fertile offspring called Beefalo or Zubron.</p>

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
      ' Set rs2 = Nothing ' rs2 was created but not used here, might be a leftover
      %>

  </div> <% ' End of .main-content-text %>

</div> <% ' End of .container-wrapper %>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>