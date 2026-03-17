<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="https://www.oatmealFarmNetwork.com/Turkeys/AboutTurkeys.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About Turkeys | Turkey Breeds | Breeds of Livestock</title>
<meta name="Title" content="Turkeys Breeds | Breeds of Livestock"/>
<meta name="Description" content="Turkeys are large birds (the eighth largest living bird species in terms of maximum mass) native originally to the Americas, but after European colonization turkeys were transported to Europe and today they are a common livestock in Europe, America, and many other part of the world . They are raised for their meat all year round but are closely associated in America as the star of the yearly Thanksgiving Dinner."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": <%=Breed %>,
  "description": <%=metadescription %>,
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
currentbreed="Turkeys"%>
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
          <img src="<%=BreedIcon %>" alt="About Turkeys" width="40"/>
          About Turkeys
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/members/livestockDB/Turkeys/#Breeds" class="view-breeds-link">View Turkey Breeds</a>

      <div class="floated-image">
          <img src="Turkey.jpg" alt="Turkeys" />
          <% ' No caption in original, add if needed: <p class="media-caption">Your Caption</p> %>
      </div>

      <p>Turkeys are large birds (the eighth largest living bird species in terms of maximum mass) native originally to the Americas, but after European colonization turkeys were transported to Europe and today they are a common livestock in Europe, America, and many other part of the world. They are raised for their meat all year round but are closely associated in America as the star of the yearly Thanksgiving Dinner.</p>
      <p>Female domesticated turkeys are referred to as hens, and the chicks may be called poults or turkeylings. In the United States, the males are referred to as toms, while in Europe, males are stags. Male Turkeys are more colorful than female turkeys and have a distinctive fleshy wattle or protuberance that hangs from the top of the beak (called a snood).</p>
      <p>One species turkey, Meleagris gallopavo (commonly known as the domestic turkey or wild turkey), is native to the forests of North America. The other living species is Meleagris ocellata or the ocellated turkey, is native to the forests of the Yucatán Peninsula. Domestic Turkeys are larger than wild turkeys because domesticated turkeys are selectively bred to grow larger for their meat.</p>
      <p>Domestic turkeys were first domesticated by Native Americans around 800BC for their feathers, which were used in ceremonies and to make robes and blankets. Turkeys were first used for meat around AD 1100. The Aztecs associated the turkey with their trickster god Tezcatlipoca, perhaps because of its perceived humorous behavior.</p>
      <p>Domestic Turkeys were taken to Europe by the Spanish. Many distinct breeds were developed in Europe (e.g. Spanish Black, Royal Palm). In the early 20th century, many advances were made in the breeding of turkeys, resulting in breeds such as the Beltsville Small White.</p>
      <p>Turkeys were often misidentified with an unrelated species of bird that was imported to Europe through the country of Turkey.</p>
      <p>William Strickland, a 16th-century English navigator, is generally credited with introducing the turkey into England. The domestic turkey was sent from England to Jamestown, Virginia in 1608.</p>
      <p>Prior to the late 19th century, turkey was something of a luxury in the UK, with goose or beef a more common Christmas dinner among the working classes.</p>
      <p>Turkey production in the UK was centered in East Anglia, using two breeds, the Norfolk Black and the Norfolk Bronze (also known as Cambridge Bronze). These would be driven as flocks, after shoeing, down to markets in London from the 17th century onwards - the breeds having arrived in the early 16th century via Spain.</p>

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