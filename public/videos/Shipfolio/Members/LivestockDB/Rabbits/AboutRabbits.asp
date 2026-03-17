<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="https://www.OatmealFarmNetwork.com/Rabbits/AboutRabbits.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About Rabbits | Rabbit Breeds</title>
<meta name="Title" content="About Rabbits | Rabbit Breeds"/>
<meta name="Description" content="Rabbits are small cute furry critters found in several parts of the world. There are eight different groups within the rabbit family, including the European rabbit, cottontail rabbits, and the Amami rabbit."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "About Rabbits",
  "description": "Rabbits are small cute furry critters found in several parts of the world. There are eight different groups within the rabbit family, including the European rabbit, cottontail rabbits, and the Amami rabbit.",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=image %> }
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
      color: #000; /* H1 color set to BLACK as requested */
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

  /* Floated Media (Image) Styles */
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
      max-width: 100%;
      height: auto;
      display: block;
      border-radius: 5px;
  }

  .media-caption {
      font-size: 0.9em;
      color: #666;
      margin-top: 8px;
      text-align: center;
  }

  /* Main Content Paragraphs */
  .main-content-text p {
      margin-bottom: 1em;
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
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #eee;
      clear: both; /* Ensure colors section clears any previous floats */
  }

  .colors-section h2 {
      color: #4CAF50;
      font-size: 1.8em;
      margin-bottom: 15px;
      text-align: left;
  }

  .colors-section ul {
      list-style: disc;
      padding-left: 25px;
      margin-bottom: 0;
  }

  .colors-section li {
      margin-bottom: 5px;
  }

  /* Responsive Adjustments */
  @media (max-width: 768px) {
      .floated-image {
          float: none;
          margin: 20px auto;
          width: 90%;
          max-width: 350px;
      }
  }
</style>

</HEAD>
<body >
<% LSHeader = True 
currentbreed="Rabbits"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 

%>

<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="About Rabbits" height="50"/>
          About Rabbits
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/Members/LivestockDB/Rabbits/#Breeds" class="view-breeds-link">View Rabbit Breeds</a>

      <div class="floated-image">
          <img src="RabbitImage.jpg" alt="A Rabbit" />
          <% ' Original code had empty td for caption, adding one here for consistency if needed %>
          <% ' <p class="media-caption"></p> %>
      </div>

      <p>Rabbits are small cute furry critters found in several parts of the world. There are eight different groups within the rabbit family, including the European rabbit, cottontail rabbits, and the Amami rabbit (an endangered species in Japan).</p>
      <p>The only rabbit to be widely domesticated is the European rabbit, which has been extensively bred for food and as pets. Rabbits were first widely kept in ancient Rome and they were refined into a wide variety of breeds during and since the middle Ages.</p>
      <p>Domesticated rabbits have mostly been bred to be much larger than wild rabbits, although selective breeding has produced rabbits in a wide range of sizes from dwarf to giant.</p>
      <p>Rabbit fur varies widely in color and is very soft. Angora rabbits are raised for their long, soft fur, which is often spun into yarn. Other breeds are raised for the fur industry, particularly the Rex, which has a smooth, velvet-like coat.</p>
      <p>A male rabbit is called a buck and a female is called a doe. A young rabbit is called a kitten or kit.</p>

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