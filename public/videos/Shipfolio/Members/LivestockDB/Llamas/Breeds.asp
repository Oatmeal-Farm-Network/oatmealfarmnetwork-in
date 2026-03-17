<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
      <% MasterDashboard= True %>
<% 
BreedLookupID=request.querystring("BreedLookupID")
SpeciesID=request.querystring("SpeciesID")
currentbreed="Alpacas"
Current3 = "AboutAlpacas"
 currentbreed2= "Alpacas" %>
<% LSHeader = True %>


<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<% 
BreedlookupID = request.querystring("BreedlookupID")
if speciesID > 0 then
else
response.redirect("/default.asp")
end if
if BreedlookupID > 0 then
else
response.redirect("BreedsHome.asp")
end if
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesAvailable where SpeciesID =" & SpeciesID 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
SpeciesName = rs2("SingularTerm") 
SpeciesNamePlural = rs2("PluralTerm") 
end if
rs2.close

sql2 = "select * from SpeciesBreedLookupTable where BreedlookupID =" & BreedlookupID  & " and speciesid = " & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if rs2.eof then 
response.redirect("/" & SpeciesNamePlural & "/")
else
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") 
BreedlookupID = rs2("BreedlookupID")
BreedlookupID2 = BreedlookupID
Breeddescription= rs2("Breeddescription")
Breeddescription2= Breeddescription 
BreedImage= rs2("BreedImage")
BreedImage2 = BreedImage
Breedvideo= rs2("Breedvideo")
Breedvideo2 = Breedvideo
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageOrientation2 = BreedImageOrientation
BreedImageCaption = rs2("BreedImageCaption")
BreedImageCaption2 = BreedImageCaption
end if
rs2.close

FUNCTION stripHTML(strHTML)
  Dim objRegExp, strOutput, tempStr
  Set objRegExp = New Regexp
  objRegExp.IgnoreCase = True
  objRegExp.Global = True
  objRegExp.Pattern = "<(.|n)+?>"
  'Replace all HTML tag matches with the empty string
  strOutput = objRegExp.Replace(strHTML, "")
  'Replace all < and > with &lt; and &gt;
  strOutput = Replace(strOutput, "<", "&lt;")
  strOutput = Replace(strOutput, ">", "&gt;")
  stripHTML = strOutput    'Return the value of strOutput
  Set objRegExp = Nothing
END FUNCTION
if len(Breeddescription) > 20 then
metadescription = stripHTML(Breeddescription)
else
metadescription = "About " & Breed & " SpeciesNamePlural "
end if
%>
<link rel="canonical" href="<%=currenturl %>?BreedLookupID=<%=BreedID %>&SpeciesID=<%=SpeciesID %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %></title>
<meta name="Title" content="About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>"/>
<meta name="description" content="<%=left(metadescription, 160)%> " />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" />
<meta property="og:description" content="<%=left(metadescription, 160)%>" />
<meta property="og:url" content="<%=currenturl %>?BreedLookupID=<%=BreedID %>&SpeciesID=<%=SpeciesID %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=BreedImage %>" />
<meta property="og:image:width" content="300" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="<%=left(metadescription, 160)%>[&hellip;]" />
<meta name="twitter:title" content="About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" />


<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "<%=trim(Breed) %> &nbsp;<%=SpeciesNamePlural  %>",
  "description": "<%=metadescription %>",
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
  }

  .container-wrapper {
      max-width: 960px; /* Max width for central content */
      margin: 30px auto; /* Center the container with some top/bottom margin */
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  }

  /* Header for the Breed Detail Page */
  .breed-detail-header {
      text-align: center;
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 2px solid #ddd;
  }

  .breed-detail-header h1 {
      color: #2196f3; /* Blue heading */
      font-size: 2.5em;
      margin: 0;
      display: inline-flex; /* Align icon and text */
      align-items: center;
  }

  .breed-detail-header h1 img {
      margin-right: 15px;
      vertical-align: middle;
  }

  /* Main Breed Content Section */
  .breed-content-section {
      /* No flexbox properties directly on this container when floating */
      /* We'll handle layout with float on the image and natural text flow */
      margin-bottom: 40px;
      overflow: hidden; /* Clear floats within this container */
  }

  .breed-main-image {
      float: right; /* Aligns image and caption to the right */
      width: 300px; /* Fixed width for the image container */
      margin: 0 0 20px 25px; /* Top, Right, Bottom, Left margins (space around the image) */
      box-sizing: border-box;
      max-width: 100%; /* Ensure it doesn't overflow on small screens */
  }

  /* Responsive adjustments for image positioning - float is problematic on small screens */
  @media (max-width: 768px) {
      .breed-main-image {
          float: none; /* Remove float on small screens */
          margin: 20px auto; /* Center image block */
          display: block; /* Ensure it behaves as a block element for centering */
      }
      .breed-description-text {
          /* No specific width needed here, it will take full width */
      }
  }


  .breed-main-image img {
      max-width: 100%; /* Image should fill its container */
      height: auto;
      border-radius: 5px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      display: block; /* Remove extra space below image */
  }

  .breed-image-caption {
      font-size: 0.9em;
      color: #666;
      margin-top: 8px;
      text-align: center;
  }

  .breed-description-text {
      /* Text will naturally flow around the floated image */
  }

  .breed-description-text p {
      margin-top: 0; /* Remove default paragraph top margin */
  }

  .no-description-message {
      font-style: italic;
      color: #888;
      padding: 15px;
      border: 1px dashed #ccc;
      border-radius: 5px;
      background-color: #f9f9f9;
  }

  /* Associations Section */
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

  /* Utility classes (from your original code) */
  .body { /* Used for general body text styles if needed */
      font-size: 1em; /* Example, adjust as needed */
      line-height: 1.6;
  }
</style>

</HEAD>
<body >

<% LSHeader = True 
currentbreed="Cattle"
%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<!--#Include virtual="/Members/BreedsofLivestock/AnimalsVariablesInclude.asp"-->

<div class="container-wrapper">

  <div >
      <h1>
          <img src="<%=BreedIcon %>" alt="About <%= Trim(Breed) %> <%=SpeciesNamePlural %>" height="40"/>
          About <%= Trim(Breed) %>&nbsp;<%=SpeciesNamePlural %>
      </h1>
  </div>

  <div class="breed-content-section">
      <% If Len(BreedImage2) > 1 Then %>
          <% ' Removed the dynamic alignment class and directly float it right %>
          <div class="breed-main-image">
              <img src="<%= BreedImage%>" alt="<%=BreedImageCaption%>" />
              <% If Len(BreedImageCaption) > 1 Then %>
                  <p class="breed-image-caption"><%=BreedImageCaption %></p>
              <% End If %>
          </div>
      <% End If %>

      <div class="breed-description-text">
          <% If Len(Trim(Breeddescription2)) > 12 Then %>
              <%= Trim(Breeddescription2) %>
          <% Else %>
              <p class="no-description-message">Sorry, we do not have a description of <%= Trim(Breed2) %>&nbsp;<%=SpeciesNamePlural %>. But if you have one that you would like to submit please <a href="/contactus.asp">contact us </a>and let us know!</p>
          <% End If %>
      </div>
  </div>

  <%
  Dim sqld, rsd, count, AssociationName, Associationwebsite, AssociationDescription, AssociationLogo, AssociationID

  sqld = "select SpeciesassociationLinks.*, associations.* from SpeciesassociationLinks INNER JOIN associations ON SpeciesassociationLinks.associationid = associations.associationid and BreedLookupID = " & BreedLookupID & " order by AssociationName"
  Set rsd = Server.CreateObject("ADODB.Recordset")
  rsd.Open sqld, conn, 3, 3

  If Not rsd.EOF Then %>
      <div class="associations-section">
          <h2><%= Trim(Breed) %>&nbsp;<%=SpeciesNamePlural %> Associations</h2>
          <%
          count = 0
          While Not rsd.EOF
              count = count + 1
              AssociationName = rsd("AssociationName")
              Associationwebsite = rsd("Associationwebsite")
              AssociationDescription = rsd("AssociationDescription")
              AssociationLogo = rsd("AssociationLogo")
              AssociationID = rsd("AssociationID")
              Dim currentSALDescription : currentSALDescription = rsd("SALDescription")
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

</div>

<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>