<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
      <% MasterDashboard= True %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<% 
AboutLink = "AboutHorses.asp"
Description = "Horses have evolved over the past 45 to 55 million years from a small multi-toed animal into the large, single-toed animal of today. Humans began to domesticate horses around 4000 BC, and their domestication is believed to have been widespread by 3000 BC. Worldwide many products are many from horses, including meat, milk, hide, hair, bone, and pharmaceuticals extracted from the urine of pregnant mares; however, in the US they are predominately used for sport and recreation.<br /><br>"
Title = "Horse Breeds"
image = "Horseheader.jpg"
letter = "r"
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

<% 
BreedlookupID = request.querystring("BreedlookupID")
if speciesID > 0 then
else
response.redirect("/default.asp")
end if
if BreedlookupID > 0 then
else
'response.redirect("BreedsHome.asp")
end if
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesAvailable where SpeciesID =" & SpeciesID 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
SpeciesName = rs2("SingularTerm") 
SpeciesNamePlural = rs2("PluralTerm") 
end if
rs2.close


sql2 = "select * from SpeciesBreedLookupTable where speciesid = " & speciesID & " Order by trim(Breed)"
'response.write("sql2=" & sql2)

rs2.Open sql2, conn, 3, 3
if rs2.eof then 
response.redirect("/" & SpeciesName & "/")
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
</head>
<body >

<% currentbreed="Bison" %>

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


<div class="container">
    <div class="text-center">
        <h1><img src="<%=BreedIcon %>" alt="About <%= trim(Breed) %> <%=SpeciesNamePlural %>" height="40" />&nbsp;Breeds of <%=SpeciesNamePlural %> - <%=letter %></h1>
<a name="Breeds"></a>
There are the following breeds of <% = SpeciesNamePlural %>:
<br />

<a NAME="Breeds"></a>
<a href = "Default.asp?Letter=A#Breeds" class = Body>A</a> |
<a href = "DefaultB.asp?Letter=B#Breeds" class = Body>B</a> |
<a href = "DefaultC.asp?Letter=C#Breeds" class = Body>C</a> |
<a href = "DefaultD.asp?Letter=D#Breeds" class = Body>D</a> |
<a href = "DefaultE.asp?Letter=E#Breeds" class = Body>E</a> |
<a href = "DefaultF.asp?Letter=F#Breeds" class = Body>F</a> |
<a href = "DefaultG.asp?Letter=G#Breeds" class = Body>G</a> |
<a href = "DefaultH.asp?Letter=H#Breeds" class = Body>H</a> |
<a href = "DefaultI.asp?Letter=I#Breeds" class = Body>I</a> |
<a href = "DefaultJ.asp?Letter=J#Breeds" class = Body>J</a> |
<a href = "DefaultK.asp?Letter=K#Breeds" class = Body>K</a> |
<a href = "DefaultL.asp?Letter=L#Breeds" class = Body>L</a> |
<a href = "DefaultM.asp?Letter=M#Breeds" class = Body>M</a> |
<a href = "DefaultN.asp?Letter=N#Breeds" class = Body>N</a> |
<a href = "DefaultO.asp?Letter=O#Breeds" class = Body>O</a> |
<a href = "DefaultP.asp?Letter=P#Breeds" class = Body>P</a> |
<a href = "DefaultQ.asp?Letter=Q#Breeds" class = Body>Q</a> |
<a href = "DefaultR.asp?Letter=R#Breeds" class = Body>R</a> |
<a href = "DefaultS.asp?Letter=S#Breeds" class = Body>S</a> |
<a href = "DefaultT.asp?Letter=T#Breeds" class = Body>T</a> |
<a href = "DefaultU.asp?Letter=U#Breeds" class = Body>U</a> |
<a href = "DefaultV.asp?Letter=V#Breeds" class = Body>V</a> |
<a href = "DefaultW.asp?Letter=W#Breeds" class = Body>W</a> |
<a href = "DefaultXYZ.asp?Letter=X#Breeds" class = Body>XYZ</a> |
<br />


  <a name="Breeds"></a>
  <%
  Set rs2 = Server.CreateObject("ADODB.Recordset")
  sql2 = "select Breed, BreedLookupID, BreedDescription, BreedImage, BreedVideo, BreedImageOrientation, BreedImageCaption from SpeciesBreedLookupTable where left((trim(LOWER(breed))), 1) = '" & Letter & "' and SpeciesID=" & speciesID & " Order by trim(Breed)"
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
