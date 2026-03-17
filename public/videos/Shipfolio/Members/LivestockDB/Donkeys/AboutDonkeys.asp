<!DOCTYPE html>
 <!doctype html>
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="https://www.OatmealfarmNetwork.com/Donkeys/AboutDonkeys.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About Donkeys | Breeds of Donkeys</title>
<meta name="Title" content="About Donkeys | Breeds of Donkeys"/>
<meta name="Description" content="In general donkeys are quite intelligent, cautious, friendly, playful, and eager to learn. Donkeys have a notorious reputation for stubbornness, but this has been attributed to a very strong sense of self preservation. Likely based on a stronger prey instinct and a weaker connection with man, it is considerably more difficult to force or frighten a donkey into doing something it perceives to be dangerous for whatever reason. Once a person has earned their confidence they may be willing partners and very dependable in work. "> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

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

        /* Floated Image Styles */
        .floated-image {
            float: right; /* Aligns image to the right */
            width: 150px; /* Fixed width for the image */
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
            max-width: 100%; /* Image should fill its container */
            height: auto;
            display: block; /* Remove extra space below image */
            border-radius: 5px; /* Slightly rounded corners for actual image */
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
            .floated-image {
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
currentbreed="Donkeys"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->


<% If not rs.State = adStateClosed Then
  rs.close
End If 
%>
<div class="container-wrapper">

    <div class="page-header">
        <h1>
            <img src="<%=BreedIcon %>" alt="About Donkeys" height="40"/>
            About Donkeys
        </h1>
    </div>

    <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

        <a href="/Members/LivestockDB/Donkeys/#Breeds" class="view-breeds-link">View Donkey Breeds</a>

        <div class="floated-image">
            <img src="/images/Donkeys.jpg" alt="Donkeys" />
            <% ' No caption in original, but you can add <p class="media-caption">Your Caption</p> here if needed %>
        </div>

        <p>Donkeys were first domesticated around 5,000 years ago as beasts of burden and companions, most likely in Egypt or Mesopotamia. There are about 41 million donkeys in the world today; China has the most with 11 million, followed by Pakistan, Ethiopia, and Mexico.</p>
        <p>Donkeys vary considerably in size, depending on breed and management. The height at the withers ranges from 7.3 hands (31 inches or 79 cm) to 15.3 hands (63 inches or 160 cm), and they weigh from 80 to 480 kg (180 to 1,060 lb.). Working donkeys in the poorest countries have a life expectancy of 12 to 15 years; and in more prosperous countries, they may have a lifespan of 30 to 50 years.</p>
        <p>Donkeys have large ears with excellent hearing, and may help cool the donkey's blood. Donkeys can defend themselves by biting, striking with the front hooves or kicking with the hind legs.</p>
        <p>A male donkey is called a jack, a female is a jenny or jennet; a young donkey is a foal.</p>
        <p>A jennet is normally pregnant for about 12 months, though the gestation period varies from 11 to 14 months, and usually gives birth to a single foal. Births of twins are rare. About 1.7 percent of donkey pregnancies result in twins; both foals survive about 14 percent of the time.</p>
        <p>Donkeys can interbreed with other equines and are commonly interbred with horses. The hybrid between a jack and a mare (Female horse) is a mule, valued as a working and riding animal in many countries. The hybrid between a stallion (male Horse) and a jennet is a hinny, and is less common. Like other inter-species hybrids, mules and hinnies are usually sterile and are incapable of siring foals. Donkeys can also breed with zebras in which the offspring is called a Zonkey, Zebroid, Zebrass, or Zedonk.</p>
        <p>In general donkeys are quite intelligent, cautious, friendly, playful, and eager to learn. Donkeys have a notorious reputation for stubbornness, but this has been attributed to a very strong sense of self preservation. Likely based on a stronger prey instinct and a weaker connection with man, it is considerably more difficult to force or frighten a donkey into doing something it perceives to be dangerous for whatever reason. Once a person has earned their confidence they may be willing partners and very dependable in work.</p>

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