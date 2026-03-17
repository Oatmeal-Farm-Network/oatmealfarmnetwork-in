<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<% MasterDashboard= True
PageName="Cattle" 
LSHeader = True
currentbreed="Cattle" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Cattle Breeds",
  "description": "Cattle were first domesticated at least 10,000 years ago, and they are raised as for meat, milk and other dairy products, and as draft animals.",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": "https://www.OatmealFarmNetwork.com/images/Cow.jpg" }
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
      color: #007bff; /* Link color */
      text-decoration: none;
  }
  .view-breeds-link:hover {
      text-decoration: underline;
  }

  /* Floated Media (Image) Styles */
  .floated-media {
      width: 300px; /* Fixed width for floated content */
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
currentbreed="Cattle"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="Cattle Breeds" height="50"/>
          About Cattle (Cows)
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/Members/LIvestockDB/Cattle/#Breeds" class="view-breeds-link">View Cattle Breeds</a>

      <div class="floated-media float-right">
          <img src="/images/Cow.jpg" alt="Cows" />
          <% ' No caption in original HTML, but you can add it here if needed %>
          <% ' <p class="media-caption">Cows</p> %>
      </div>

      <p>The first cattle were domesticated at least 10,000 years ago, and they are raised as for meat (beef and veal), dairy animals for milk and other dairy products, and as draft animals (pulling carts, plows and the like). Also they are raised to produce leather and their manure is used for fertilizer. Cattle were the first livestock animal to have a fully mapped genome and there is an estimated 1.3 billion cattle in the world today.</p>
      <p>Cattle raised for human consumption are called "beef cattle". Within the beef cattle industry in parts of the United States, the term "beef" (plural "beeves") is still used in its archaic sense to refer to an animal of either sex. Cows of certain breeds that are kept for the milk they give are called "dairy cows" or "milking cows". Most young male offspring of dairy cows are sold for veal, and may be referred to as veal calves.</p>
      <p>Cattle have cloven hooves and most breeds have horns, which can range greatly in size. Careful genetic selection has allowed polled (hornless) cattle to become widespread.</p>
      <p>Cattle are ruminants, meaning their digestive system is highly specialized to allow the use of poorly digestible plants as food. Cattle have one stomach with four compartments, the rumen, reticulum, omasum, and abomasum, with the rumen being the largest compartment. Cattle are known for regurgitating and re-chewing their food, known as "cud" chewing. The reticulum, the smallest compartment, is known as the "honeycomb". Cattle sometimes consume metal objects which are deposited in the reticulum and irritation from the metal objects causes”hardware disease”. The omasum's main function is to absorb water and nutrients from the digestible feed. The omasum is known as the "many plies". The abomasum is like the human stomach; this is why it is known as the "true stomach". The cud is then reswallowed and further digested by specialized microorganisms in the rumen. These microbes are primarily responsible for decomposing cellulose and other carbohydrates into volatile fatty acids cattle use as their primary metabolic fuel. The microbes inside the rumen also synthesize amino acids. As these microbes reproduce in the rumen, older generations die and their cells continue on through the digestive tract. These cells are then partially digested in the small intestines, allowing cattle to gain a high-quality protein source. These features allow cattle to thrive on grasses and other vegetation.</p>
      <p>The gestation period for a cow is about nine months long. A newborn calf's size can vary among breeds, but a typical calf typically weighs 25 to 45 kg (55 to 99 lb). Adult size and weight vary significantly among breeds and sex. The world record for the heaviest bull was 1,740 kg (3,840 lb), a Chianina cow named Donetto, when he was exhibited at the Arezzo show in 1955. The heaviest steer was eight-year-old ‘Old Ben’, a Shorthorn/Hereford cross weighing in at 2,140 kg (4,720 lb) in 1910. Steers are generally killed before reaching 750 kg (1,650 lb). Breeding stock may be allowed a longer lifespan, occasionally living as long as 25 years. The oldest recorded cow, Big Bertha, died at the age of 48 in 1993.</p>

      <div class="floated-media float-right">
          <img src="/images/bullfighting.jpg" alt="Bulls can't see red." />
          <p class="media-caption">A common misconception about cattle (particularly bulls) is that they are enraged by the color red. This is incorrect, as cattle are red-green color-blind. The myth arose from the use of red capes in the sport of bullfighting.</p>
      </div>

      <p>The term "dogies" is used to describe orphaned calves in the context of ranch work in the American West, as in "Keep them dogies moving". In some places, a cow kept to provide milk for one family is called a "house cow".</p>
      <p>In the April 24, 2009, edition of the journal Science, a team of researchers led by the National Institutes of Health and the US Department of Agriculture reported having mapped the genome. Cattle have about 22,000 genes, and 80% of their genes are shared with humans, and they share about 1000 genes with dogs and rodents, but are not found in humans.</p>

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