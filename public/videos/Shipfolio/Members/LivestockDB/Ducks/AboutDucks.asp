<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="https://www.OatmealfarmNetwork.com/Ducks/AboutDucks.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Ducks | Breeds of Livestock</title>
<meta name="Title" content="Ducks | Breeds of Livestock"/>
<meta name="Description" content="Ducks are raised for their meat, antlers, and hides."> <meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": Ducks  ,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "mainEntity": "Global Grange"  ]  }
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
        .floated-media {
            width: 300px; /* Fixed width for floated content */
            margin-bottom: 20px; /* Space below the media block */
            box-sizing: border-box;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background-color: #f0f0f0;
            padding: 10px;
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

        /* Sub-section Heading */
        .sub-section-heading {
            color: #333; /* Darker color for sub-headings */
            font-size: 2em;
            margin-top: 30px;
            margin-bottom: 15px;
            text-align: left;
            clear: both; /* Ensure sub-heading clears any previous floats */
        }

        /* Colors Section */
        .colors-section {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
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
            .floated-media {
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
currentbreed="Ducks" %>
<!--#Include virtual="/members/membersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 
Set rs2 = Server.CreateObject("ADODB.Recordset")
%>

<div class="container-wrapper">

    <div class="page-header">
        <h1>
            <img src="<%=BreedIcon %>" alt="About Ducks" height="40"/>
            About Ducks
        </h1>
    </div>

    <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

        <a href="/Members/LivestockDB/Ducks/#Breeds" class="view-breeds-link">About Duck Breeds</a>

        <div class="floated-media float-right">
            <img src="Duck.jpg" alt="Ducks" />
            <% ' No caption in original, add if needed: <p class="media-caption">Your Caption</p> %>
        </div>

        <p>Ducks belong to the Anatidae family, which also includes geese and swans. They are found all over the world, in both freshwater and saltwater habitats, and are known for their distinctive quacking vocalization. Ducks are omnivores and feed on a variety of foods, including plants, insects, and small fish.</p>
        <p>There are many different species of ducks, ranging in size from the tiny Harlequin Duck to the large Muscovy Duck. Some species of ducks are migratory, traveling long distances between their breeding and wintering grounds, while others are non-migratory and stay in the same place year-round.</p>
        <p>Ducks are social animals and are often seen in groups, or "flocks". During the breeding season, male ducks (drakes) will engage in elaborate courtship displays to attract a mate, and female ducks (hens) will lay a clutch of eggs which they incubate until hatching.</p>
        <p>In addition to their biological and ecological importance, ducks have also been domesticated for a variety of purposes, including as pets, for their meat, eggs, and feathers. They are also an important subject of study in fields such as ornithology, limnology, and ecotoxicology, as they can serve as bioindicators of the health of aquatic ecosystems.</p>

        <h2 class="sub-section-heading">Duck Meat</h2>

        <div class="floated-media float-left">
            <img src="DuckMeat.jpg" alt="Duck Meat" />
            <% ' No caption in original, add if needed: <p class="media-caption">Your Caption</p> %>
        </div>

        <p>Duck meat is type of poultry and is usually simply referred to as ‘duck’. Duck is one of the most popular poultry meats worldwide. Although duck can sometimes look red in its raw state, it is considered to be a type of white meat.</p>
        <p>Duck meat has a much stronger flavor than both chicken and turkey. The nearest comparison would be the darker parts of other poultry, but duck is still more flavorful. As is the case with many foods, the higher fat content positively contributes to the overall taste profile.</p>
        <p>Duck meat has excellent zinc and selenium content, which encourages metabolism. It also has some lean portions on it and it contains little fat as well.</p>

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
<!--#Include virtual="/Members/membersFooter.asp"-->
</body>
</html>