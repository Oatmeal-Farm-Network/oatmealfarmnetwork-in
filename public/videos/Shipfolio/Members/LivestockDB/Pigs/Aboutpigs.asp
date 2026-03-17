<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="AboutPigs2.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About Pigs | Pig Breeds</title>
<meta name="Title" content="About Pigs | Pig Breeds"/>
<meta name="Description" content="Pigs are intelligent animals. With around 1 billion individuals alive at any time, the domesticated pig is one of the most numerous large mammals on the planet."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>
<link rel="stylesheet" type="text/css" href="/includefiles/style.css" />

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "About Pigs",
  "description": "Pigs are intelligent animals. With around 1 billion individuals alive at any time, the domesticated pig is one of the most numerous large mammals on the planet.",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=image %>  }
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
<% currentbreed="Pigs"
LSHeader = True %>
 <!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 
	
%>

  
<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="About Pigs" height="50"/>
          About Pigs
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/Members/LivestockDB/Pigs/#Breeds" class="view-breeds-link">View Pig Breeds</a>

      <div class="floated-image">
          <img src="AboutPigs2.jpg" alt="A Pig" />

      </div>

      <p>Pigs are omnivores and are intelligent animals. With around 1 billion individuals alive at any time, the domesticated pig is one of the most numerous large mammals on the planet. The meat of pigs is widely eaten by people across the world.</p>
      <p>A typical pig has a large head with a long snout. The snout is used to dig into the soil to find food. Pigs have a tremendous sense of smell. The large round disk of cartilage at the tip of the snout is connected to muscle that gives it extra flexibility and strength for rooting in the ground.</p>
      <p>Pigs have four hoofed toes on each trotter (foot), with the two larger central toes. Adult pigs a total of 44 teeth. The rear teeth are adapted for crushing. In the male the teeth form tusks, which grow continuously and are sharpened by constantly being ground against each other.</p>
      <p>Pigs are intelligent, curious, and insightful animals that are widely accepted as being smarter than dogs, and even some primates. Winston Churchill famously said that “Dogs look up to man. Cats look down to man. Pigs look us straight in the eye and see an equal.” There are numerous stories of pigs that have saved the lives of humans. For example, a pet pig called Pru pulled her owner out of a muddy bog, and another, Priscilla, saved a young boy from drowning.</p>
      <p>Pigs are also social animals. They form close bonds with other individuals and love close contact and lying down together. Pigs are also peaceful animals. They rarely show aggression except when a mother (sow) with her young offspring is provoked or threatened.</p>
      <p>Contrary to what most people think, Pigs are very clean. They keep their toilet area far away from where they lie down and eat. Even newborn piglets will leave the nest to go to the toilet within hours of birth.</p>
      <p>Pigs are omnivores, which means that they consume both plants and animals. In the wild, they are foraging animals, primarily eating leaves, grasses, roots, fruits and flowers. Domestic pigs are fed mostly corn and soybean meal with a mixture of vitamins and minerals added to the diet. Because pigs are omnivores they make excellent pasture raised animals. Traditionally they were raised on dairy farms and called "mortgage lifters" due to their ability to use the excess milk as well as whey from cheese and butter making combined with pasture. Older pigs will consume three to five gallons of water per day.</p>
      <p>Domesticated pigs, called swine, are raised commercially for meat (generally called pork, hams, or bacon), as well as for leather. Pork is one of the most popular forms of meat for human consumption, accounting for 38% of worldwide meat production. Their bristly hairs are also used for brushes. Some breeds of pig, such as the Asian pot-bellied pig and Kune Kunes, are kept as pets.</p>
      <p>Adult males are called boars (or sometimes "hogs") and the females are sows. Young swine are called piglets or pigs. Pigs that are allowed to forage may be watched by swineherds. Because of their foraging abilities and excellent sense of smell, they are used to find truffles in many European countries.</p>

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