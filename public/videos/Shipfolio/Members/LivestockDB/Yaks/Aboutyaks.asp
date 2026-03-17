<!DOCTYPE html>
<meta charset="utf-8">
<head>
<% PageName="Yaks" %>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Yak Breeds</title>
<meta name="Title" content="Yak Breeds"/>


<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Yak Breeds",
  "description": "Yaks are a long-haired cattle cousins found throughout the Himalaya region of southern Central Asia, the Tibetan Plateau and as far north as Mongolia and Russia. Most yaks are domesticated; however there is a small, vulnerable population of wild yaks.",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=BreedImage2 %>  }
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
currentbreed="Yaks"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->


<% If not rs.State = adStateClosed Then
  rs.close
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")	
%>

<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="About Yaks" height="50"/>
          About Yaks
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/members/LivestockDB/Yaks/#Breeds" class="view-breeds-link">View Yaks Breeds</a>

      <div class="floated-image">
          <img src="/images/yak.jpg" alt="Yak" />
          <% ' No caption in original, add if needed: <p class="media-caption">Your Caption</p> %>
      </div>

      <p>Yaks are a long-haired cousin of cattle. They are found throughout the Himalaya region of southern Central Asia, the Tibetan Plateau, and as far north as Mongolia and Russia. Most yaks are domesticated. However there are small populations of wild yaks in these regions.</p>
      <p>Yaks diverged from cattle millions of years ago. There is some suggestion that they may be closely related to Bison.</p>
      <p>Thousands of years ago yaks were domesticated primarily for their milk, fiber, and meat. Their dried poop is an important fuel in Tibet, and often is the only fuel available on the high treeless plateaus.</p>
      <p>Being extremely well suited to the terrain and climate of the region, yaks have been used historically as a reliable method to transport food and supplies in and out of the Himalayas. They are famous for accompanying climbers in these areas. Yaks don’t eat grain (which could be carried on long journeys). They will starve unless brought to a place where there is grass.</p>
      <p>The strength and endurance of a yak make it a useful animal for farmers. Their milk can be made into a cheese called chhurpi. (Byaslag in Mongolian.) Butter made of yak's milk is used in butter tea; as fuel for lamps; and to create sculptures for religious festivities.</p>
      <p>Yak racing, skiing, and polo have been popular events in Mongolian horse festivals.</p>
      <p>One way that yaks differ from cattle is that they don’t moo. They grunt. Contrary to popular belief they don’t stink; they have almost no odor at all.</p>
      <p>Sometimes yaks are crossbred with cattle which produce infertile males (called a dzo), or fertile females (known as dzomo), which may be crossed again with cattle. Yaks have also been bred with Bison, Gaur (Indian Bison), and Banteng cattle.</p>

      <% If Not rs.State = adStateClosed Then
          rs.Close
      End If %> <% ' Ensure previous recordset is closed before re-using 'rs' %>

      <%
      Set rs = Server.CreateObject("ADODB.Recordset") ' Re-create recordset for colors
      sql2 = "select * from SpeciesColorlookupTable where SpeciesID = " & SpeciesID & " order by SpeciesColor "
      rs.Open sql2, conn, 3, 3

      If Not rs.EOF Then %>
          <div class="colors-section">
              <h2>Yak Colors</h2>
              <p>Yaks come in the following colors:</p>
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
<!--#Include virtual="/members/membersFooter.asp"-->
</body>
</html>