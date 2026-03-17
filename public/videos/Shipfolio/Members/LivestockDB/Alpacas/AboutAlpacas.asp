<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
      <% MasterDashboard= True %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

    <script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "About Alpacas",
  "description": "Alpacas are intelligent and easily trained animals, and gentle enough to be handled by children. They hum when pleased or happy and spit when they are not. 
They make very good pets and companion animals, but don't like being alone.",
  "author": {
    "@type": "Organization",
    "name": "Oatmeal farm Network"
  },
  "image": /images/ZoeandGracy.jpg"  }
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
            color: #2196f3; /* Blue heading */
            font-size: 2.5em;
            margin: 0;
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

        /* Floated Media (Image/Video) Styles */
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

        .floated-media img,
        .floated-media iframe {
            max-width: 100%;
            height: auto; /* For images */
            display: block; /* Remove extra space below image/iframe */
            border-radius: 5px; /* Slightly rounded corners for actual media */
        }
        .floated-media iframe {
             width: 100%; /* Make iframe fill its container width */
             height: 169px; /* Original height from your code */
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

        /* Associations Section (Re-used from previous example) */
        .associations-section {
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid #eee; /* Separator above associations */
        }

        .associations-section h2 {
            color: #4CAF50; /* Green heading for associations */
            font-size: 1.8em;
            margin-bottom: 25px;
            text-align: left;
        }

        .association-item {
            display: flex; /* Use flexbox for logo and details */
            align-items: flex-start; /* Align logo and text to the top */
            gap: 20px; /* Space between logo and text */
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px dashed #eee; /* Light dashed line between associations */
        }

        .association-item:last-child {
            border-bottom: none; /* No border for the last item */
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .association-logo-container {
            flex-shrink: 0; /* Don't shrink the logo container */
            width: 150px; /* Fixed width for the logo area, adjust as needed */
            text-align: center;
        }

        .association-logo-container img {
            max-width: 100%; /* Ensure logo fits its container */
            height: auto;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px; /* Internal padding for logo */
            box-sizing: border-box; /* Include padding in width */
            background-color: #fff;
        }

        .association-details {
            flex-grow: 1; /* Allow details to take up remaining space */
        }

        .association-details a {
            color: #007bff; /* Blue link color */
            text-decoration: none;
            font-weight: bold;
        }

        .association-details a:hover {
            text-decoration: underline;
        }

        .association-website {
            font-size: 1.1em;
            color: #555;
        }

        .association-description {
            margin-top: 10px;
            font-size: 0.95em;
            color: #666;
        }

        /* Facebook Like Button container */
        .fb-like-container {
            margin-top: 30px;
            margin-bottom: 30px;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .floated-media {
                float: none; /* Remove float */
                margin: 20px auto; /* Center horizontally */
                width: 90%; /* Make it wider on small screens */
                max-width: 400px; /* Max width for consistency */
            }
            .floated-media img, .floated-media iframe {
                width: 100%; /* Fill new width */
            }
             .association-item {
                flex-direction: column; /* Stack logo and details vertically */
                align-items: center; /* Center them when stacked */
                text-align: center;
            }
            .association-logo-container {
                width: 100%; /* Allow logo container to take full width */
                margin-bottom: 15px;
            }
        }
    </style>

</HEAD>

<body >
<% currentbreed="Alpacas"
Current3 = "AboutAlpacas"
 currentbreed2= "Alpacas" %>
<% LSHeader = True %>
<!--#Include virtual="/members/MembersHeader.asp"-->

<div class="container-wrapper">

  <div >
      <h1>About Alpacas</h1>
  </div>

  <a href="/Members/LivestockDB/alpacas/#Breeds" class="view-breeds-link">View Alpaca Breeds</a>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>
      <div class="floated-media float-right">
          <img src="/images/ZoeandGracy.jpg" alt="I Believe In Alpacas">
          <p class="media-caption">Alpacas are Huggable</p>
      </div>
      <p>Alpacas are a member of a family of animals known as Camelids which is comprised of Dromedary, Bactrian, Llama, Alpaca, Guanaco, and Vicuna. Originally from the Andes Mountains of South America (southern Peru, western Bolivia, Ecuador, and northern Chile), the alpaca is commonly thought to have been domesticated from the wild vicuna.</p>
      <p>Alpacas are intelligent and easily trained animals, and gentle enough to be handled by children. They hum when pleased or happy and spit when they are not. They make very good pets and companion animals, but don't like being alone. Alpacas are also easy to care for, and gentle on pastures with their hoof-padded feet.</p>
      <p>The first alpacas are thought to have been developed about six thousand years ago. Mummified remains of alpacas from about a thousand years ago have been discovered in Southern Peru. Scientists, reviewing these well-preserved findings revealed that alpacas were recognized as a national treasure in South America. Many alpaca remains were buried in the floors of houses for prosperity, and offering to their Gods. Among the Andes people, the woven fabric from the fleece of the alpaca was so soft and alluring that it was used as currency. During the 17th Century Spanish Conquest in Peru, most of the alpacas perished, but the Quecha people of the Andes (mostly Peru) were able to prevent the alpaca's total extinction. For much of the 20th century exporting alpacas was prevented.</p>
      <p>Females start breeding at 2 to 3 years old. Their offspring, called cria, are born after an average gestational period of 11.5 to 12 months. Crias birth weight can range from 10-20 pounds and a newborn cria can stand 30 minutes to 1 hour after birth. Female adults typically wean their cria between 6 to 12 months. Human intervention and separation of mother and cria at 6 months is typical.</p>

      <div class="floated-media float-left">
          <iframe src="https://www.youtube.com/embed/0" frameborder="0" allowfullscreen></iframe> <% ' Assuming this is the correct embed URL for the YouTube video. You need to replace "0" with the actual video ID %>
          <p class="media-caption">Alpaca Basics from Alpaca Association New Zealand</p>
      </div>
      <p>Alpacas come in many different colors, including white, fawn, brown, grey, and blacks. Many are a solid color but some are spotted. They are intelligent, easily trained, and are often gentle enough to be handled by children. They hum when pleased or happy and sometimes spit when they are not. Alpacas are also easy to care for, and gentle on pastures. Their fiber has an absence of wool grease or lanolin that is characteristic of sheep. Alpaca fiber also retains dyes without losing its sheen and can be blended with other natural or synthetic fibers.</p>
      <p>When it became legal to export alpacas from South America in 1983, small herds in the U.S. and other nations became established. In recognition of their superior fiber, by the 1990's Alpacas became popular and by 2005 the world-wide number of alpacas had dramatically increased. Prices for the animals also dramatically increased. However, after the economic collapse of 2008 alpaca prices dropped significantly. Today alpaca prices have stabilized and are still heavily influenced by the quality of their fiber. Alpacas retain their reputation as high quality animals. Alpaca fleece is used worldwide in a variety of finished goods and is comparable to wool without the "prickly" and bulky factors. Alpaca fiber is washed, carded, spun and can be made into yarn for knitted and woven items such as blankets, sweaters, hats, gloves, scarves, sweaters, socks, coats, etc.</p>
      <p>Alpacas come in many different colors, including white, fawn, brown, grey, and black. Many are a solid color but some are spotted. They are intelligent, easily trained, and are often gentle enough to be handled by children. They hum as a means of communication. Alpacas are also easy to care for, and gentle on pastures. Their fiber has an absence of wool grease or lanolin that is characteristic of sheep. Alpaca fiber also retains dyes without losing its sheen and can be blended with other natural or synthetic fibers.</p>
      <p>Alpacas are able to withstand cold temperatures because of their dense fleece; it can most closely be compared to cashmere. It is hypoallergenic, lightweight, strong, incredibly warm, and very soft. As their primary purpose is the production of high quality fiber, alpacas are not slaughtered to reap their product Alpacas are shorn once a year.</p>
      <p>An adult alpaca is generally between 32-39 inches tall at the shoulders and weighs between 100-185 lbs. Alpacas have a lifespan of between 18-24 years. Alpacas have two toes and toenails on each foot. They have incisor bottom teeth and unlike other herbivores have a cartilage pad instead of upper incisors. As with other Camelids, alpacas are "induced evaluators" which means that they can be bred at any time of the year. Females start breeding at 2 to 3 years old. Their offspring, called cria, are born after an average gestational period of 11.5- 12 months; twins are a rarity. A cria birth weight can range from 12-18 pounds and a newborn can stand 30 minutes to 1 hour after birth. Female adults typically wean their cria between 6– 12 months. Human intervention and separation of mother and cria at 6 months is typical.</p>
      <p>Although all alpacas are basically the same there are two groups of alpacas distinguished by their fiber type. Huacaya (wah-ky-ya) and Suri (Sir-ri)</p>
  </div> <% ' End of .main-content-text %>

  <div class="fb-like-container">
      <div class="fb-like" data-href="https://www.facebook.com/LivestockOfAmerica/" data-layout="button" data-action="like" data-size="small" data-show-faces="true" data-share="true"></div>
  </div>

  <%
  Dim sqld, rsd, count, AssociationName, Associationwebsite, AssociationDescription, AssociationLogo, AssociationID

  sqld = "select distinct AssociationName, Associationwebsite, AssociationDescription, AssociationLogo, Associations.AssociationID from SpeciesassociationLinks, associations where SpeciesassociationLinks.associationid = associations.associationid and ( BreedLookupID = 1 or BreedLookupID = 2 ) order by AssociationName"

  Set rsd = Server.CreateObject("ADODB.Recordset")
  rsd.Open sqld, conn, 3, 3

  If Not rsd.EOF Then %>
      <div class="associations-section">
          <h2>Alpaca Associations</h2> <% ' Changed from Breed/SpeciesNamePlural to "Alpaca Associations" for this specific page %>
          <%
          count = 0
          While Not rsd.EOF
              count = count + 1
              AssociationName = rsd("AssociationName")
              Associationwebsite = rsd("Associationwebsite")
              AssociationDescription = rsd("AssociationDescription")
              AssociationLogo = rsd("AssociationLogo")
              AssociationID = rsd("AssociationID")
           
          %>
          <div class="association-item">
              <% If Len(AssociationLogo) > 4 Then %>
                  <div class="association-logo-container">
                      <a href="https://<%=Associationwebsite%>" target="_blank">
                          <img src="<%=AssociationLogo%>" alt="<%=AssociationName%>" />
                      </a>
                  </div>
              <% End If %>
              <div class="association-details">
                  <p>
                      <a href="https://<%=Associationwebsite%>" target="_blank"><b><%=AssociationName%></b></a> - <a href="https://<%=Associationwebsite%>" class="association-website" target="_blank"><%=Associationwebsite%></a><br />
                      <%= currentSALDescription %><br>
                  </p>
              </div>
          </div>
          <%
              rsd.MoveNext
          Wend %>
      </div>
  <% End If

  rsd.Close
  Set rsd = Nothing
  %>

</div> <% ' End of .container-wrapper %>
<!--#Include virtual="/members/membersFooter.asp"-->
</body>
</html>