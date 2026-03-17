<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
      <% MasterDashboard= True %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

   
<% Description = "Turkeys are large birds (the eighth largest living bird species in terms of maximum mass) native originally to the Americas, but after European colonization turkeys were transported to Europe and today they are a common livestock in Europe, America, and many other part of the world. They are raised for their meat all year round but are closely associated in America as the star of the yearly Thanksgiving Dinner." 
Title = "All Turkey Breeds"
image = "TurkeyHeader.webp"
AboutLink = "AboutTurkeys.asp"

 %>
<Title><%=Title %></Title>
<meta name="title" content="<%=Title %>" />

<meta name="description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="<%=Title %>"/>
<meta name="Author" content="Oatmeal Farm Network"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %>" />
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />
<meta property="og:description" content="<%=Description %>" />

    <script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "<%=Title %>",
  "description": "<%=description %>",
  "author": {
    "@type": "Organization",
    "name": "Oatmeal Farm Network"
  },
  "image": <%=image %> }
</script>

    <style>
        /* General Body and Container Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f0f5f9; /* Light blue-grey background */
            color: #333;
        }

        .container-fluid {
            width: 100%;
        }

        .container {
            max-width: 960px; /* Or your preferred max width */
            margin: 0 auto; /* Center the container */
            padding: 0 15px; /* Some padding on the sides */
        }


        .header-section h1 {
            color: #2196f3; /* Blue text for header */
            font-size: 2.2em;
            margin: 0;
            display: inline-flex;
            align-items: center;
        }

        .header-section h1 img {
            margin-right: 10px;
        }

        .intro-section {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-top: 20px;
            margin-bottom: 30px;
            text-align: center;
        }

        .intro-section img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .intro-section p {
            font-size: 1.1em;
            line-height: 1.6;
            margin-bottom: 20px;
            text-align: left;
        }

        .intro-section .learn-more-button-container {
            text-align: right;
            margin-top: 20px;
        }

        /* Styles for the "Breeds of Livestock" / individual breed listings */
        .breeds-section-title {
            text-align: left;
            color: #333;
            margin-top: 40px;
            margin-bottom: 10px;
            font-size: 2em;
        }

        .breeds-section-description {
            text-align: left;
            margin-bottom: 30px;
            font-size: 1.1em;
        }

        /* MODIFIED: Breed Item Layout with alternating images and green background */
        .breed-item {
            display: grid;
            grid-template-columns: 200px 1fr; /* Image column width (slightly adjusted), rest for text */
            gap: 0; /* No gap between the grid items, as border acts as separator */
            background-color: #fff; /* Default background for the whole item */
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 25px; /* Space between breed items */
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            overflow: hidden; /* Ensures border-radius applies to children */
        }

        /* Alternating image and text columns */
        .breed-item:nth-child(odd) { /* Odd items: Image on left, Text on right */
            grid-template-areas: "image content";
        }

        .breed-item:nth-child(even) { /* Even items: Text on left, Image on right */
            grid-template-areas: "content image";
            /* Re-order columns for even items */
            grid-template-columns: 1fr 200px; /* Text column first, then fixed image width */
        }

        .breed-item-image {
            grid-area: image; /* Assign to grid area */
            display: flex; /* Use flexbox to center image vertically and horizontally */
            justify-content: center;
            align-items: center;
            padding: 10px; /* Padding inside the image cell */
        }

        .breed-item-image img {
            max-width: 180px; /* Keep image max width */
            height: auto;
            border-radius: 8px;
            display: block;
        }

        .breed-item-content {
            grid-area: content; /* Assign to grid area */
            background-color: #EFF3E5; /* Light green background for the text content */
            padding: 10px; /* Padding inside the green content area */
            Margin: 20px; /* Padding inside the green content area */
            border-radius: 0.50rem; /* rounded-xl */
            display: flex; /* Use flexbox for content to ensure Learn More button stays at bottom */
            flex-direction: column;
            justify-content: space-between; /* Pushes button to bottom */
        }

        .breed-item-content h3 {
            color: #3f51b5;
            margin-top: 0;
            margin-bottom: 10px;
            font-size: 1.6em;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }

        .breed-item-content p {
            line-height: 1.6;
            margin-bottom: 15px;
            flex-grow: 1; /* Allows paragraph to take up available space */
        }

        .breed-item-content .learn-more-button-container {
            text-align: right;
            margin-top: 15px; /* Adjust if flex-grow on p is too much */
        }

        .regsubmit2 { /* Styling for your "LEARN MORE" buttons */
            background-color: #819360;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .regsubmit2:hover {
            background-color: #819360;
        }

        .body {
            line-height: 1.6;
        }

        .footer-pagination {
            text-align: center;
            margin-top: 30px;
            padding-bottom: 40px;
        }
    </style>


</HEAD>
<body >
<% LSHeader = True %>
<!--#Include virtual="/members/MembersHeader.asp"-->

<% If Not rs.State = adStateClosed Then
  rs.Close
End If %>

<div class="container intro-section ">
  <div class="text-center">
    <h1><img src="<%=BreedIcon %>" alt="About <%= trim(Breed) %> <%=SpeciesNamePlural %>" height="40" />&nbsp;<%=Title %></h1>
      <img src="<%=Image%>" alt="About <%=SpeciesNamePlural %>" width =100%/>

  <p>
   <%=Description%>
  </p>

      <form method="post" action="<%=AboutLink%>">
          <input type="submit" class="regsubmit2" value="LEARN MORE&nbsp;" />
      </form>

  <a name="Breeds"></a>
  <%
  Set rs2 = Server.CreateObject("ADODB.Recordset")
  sql2 = "select Breed, BreedLookupID, BreedDescription, BreedImage, BreedVideo, BreedImageOrientation, BreedImageCaption from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
  rs2.Open sql2, conn, 3, 3

  If Not rs2.EOF Then %>


      <% While Not(rs2.EOF)
          Breed2 = rs2("Breed")
          BreedLookupID2 = rs2("BreedLookupID")
          Breeddescription = rs2("Breeddescription")
          BreedImage = rs2("BreedImage")
          Breedvideo = rs2("Breedvideo")
          BreedImageOrientation = rs2("BreedImageOrientation")
          BreedImageCaption = rs2("BreedImageCaption")
      %>
      <div class="breed-item">
          <div class="breed-item-image">
              <% If Len(BreedImage) > 1 Then %>
                  <a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>">
                      <img src="<%= BreedImage%>" alt="<%=BreedImageCaption%>" />
                  </a>
              <% End If %>
          </div>
          <div >
              <h3>&nbsp;<%= Breed2 %></h3>
              <div class="breed-item-content">

              <p>
                  <%= Left(Breeddescription, 450) %>
                  <% If Len(Breeddescription) > 450 Then %>
                      ...
                  <% End If %>
              </p>
            </div>
            
              <% If Len(Breeddescription) > 25 Then %>
                  <div >
                      <form name="breedForm_<%= BreedLookupID2 %>" method="post" action="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>">
                       <center><input type="submit" class="regsubmit2" style="text-align: center;"  value="   LEARN MORE   " /></center>
                      </form>
                      <br><br>
                      
                  </div>
                  
              <% End If %>
            </div>
      </div>
      <%
          rs2.MoveNext
      Wend %>

  <% End If

  rs2.Close
  Set rs2 = Nothing
  %>

  <br />
</div>

      </div>
<!--#Include virtual="/members/MembersFooter.asp"-->
</body>
</html>
