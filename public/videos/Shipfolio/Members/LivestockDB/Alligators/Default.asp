<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
      <% MasterDashboard= True
      PageName="crocodiles" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<% Description = "Alligators are a relative to crocodiles and are native only to North America. They are raised for their meat and skin, which is used to make leather products such as shoes, handbags, and belts."
Title = "About Alligators & Alligators Breeds"
image = "AlligatorHeader.jpg"
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



</HEAD>
<body >
<% LSHeader = True %>
<!--#Include virtual="/members/MembersHeader.asp"-->


    <style>
        /* Consistent styles from previous pages */
        body { font-family: Arial, sans-serif; margin: 0; background-color: #f0f5f9; color: #333; }
        .container-fluid { width: 100%; }
        .container { max-width: 960px; margin: 0 auto; padding: 0 15px; }

        .page-header { padding: 20px 0; background-color: #fff; border-bottom: 1px solid #ddd; }
        .page-header h1 { color: black; font-size: 2.2em; margin: 0; display: inline-flex; align-items: center; }
        .page-header h1 img { margin-right: 10px; }
        
        /* Article container for a clean look */
        .article-container {
            background-color: #ffffff;
            padding: 20px 30px 40px 30px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .article-container .main-article-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 0 auto 25px auto;
            display: block;
        }

        .article-body { line-height: 1.7; font-size: 1.1em; }
        .article-body h2 { color: #3f51b5; font-size: 1.8em; margin-top: 40px; border-bottom: 2px solid #eee; padding-bottom: 5px; }
        .article-body h3 { color: #333; font-size: 1.5em; margin-top: 30px; }
        .article-body p { margin-bottom: 1.5em; }
        
        /* NEW: Style for floating image within article */
        .article-image-right {
            float: right;
            width: 300px;
            margin: 0 0 15px 25px;
            border-radius: 8px;
        }

        /* Reusing the breed-item style for consistency */
        .breed-item {
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 0;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 25px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        .breed-item:nth-child(odd) { grid-template-areas: "image content"; }
        .breed-item:nth-child(even) { grid-template-areas: "content image"; grid-template-columns: 1fr 200px; }

        .breed-item-image { grid-area: image; display: flex; justify-content: center; align-items: center; padding: 10px; }
        .breed-item-image img { max-width: 180px; height: auto; border-radius: 8px; display: block; }

        .breed-item-content-wrapper {
             grid-area: content;
             background-color: #EFF3E5; /* Light green background */
             padding: 20px;
             display: flex;
             flex-direction: column;
             justify-content: space-between;
        }
        .breed-item-content h3 { color: #3f51b5; margin: 0 0 10px 0; font-size: 1.6em; border-bottom: 1px solid #ddd; padding-bottom: 5px; }
        .breed-item-content p { line-height: 1.6; flex-grow: 1; margin-bottom: 15px; }
        .breed-item-content .learn-more-button-container { text-align: right; margin-top: auto; }

        .regsubmit2 { background-color: #819360; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 1em; text-decoration: none; display: inline-block; }
        .regsubmit2:hover { background-color: #6a7a50; }
        .clearfix::after { content: ""; clear: both; display: table; }
    </style>
</head>
<body>

<% LSHeader = True %>


<div class="container">
    <div class="article-container">
        <h1><img src="<%=BreedIcon %>" alt="<%=SpeciesNamePlural %>" height="40" /> Crocodiles & Alligators</h1>
        <img src="<%=image %>" class="main-article-image" alt="About Alligators"/>
        <div class="article-body clearfix">
            <p>Alligators are a relative to crocodiles and are native only to North America. They are raised for their meat and skin, which is used to make leather products such as shoes, handbags, and belts. Alligators are a regulated species in the United States, and alligator farming is strictly controlled by the government to ensure sustainable populations. Alligator farms are common in southern states such as Louisiana, Florida, and Texas, where alligators are bred and raised in captivity. The meat of farmed alligators is considered a delicacy in some cultures, and the demand for alligator leather products continues to grow globally.</p>

            <p>Alligators, like other crocodilians, are large animals with powerful tails that are used both in defense and in swimming. Their eyes, ears, and nostrils are placed on top of their long heads and project slightly above the water when the reptiles float at the surface, as they often do. Alligators can be differentiated from true crocodiles by the form of their jaw and teeth. Alligators possess a broad U-shaped snout and have an “overbite”; that is, all the teeth of the lower jaw fit within (are lingual to) the teeth of the upper jaw. The large fourth tooth on each side of the alligator’s lower jaw fits into a socket in the upper jaw. Usually, no lower teeth are visible when the mouth is closed. In contrast, true crocodiles have a narrow V-shaped snout, and the large fourth tooth on each side of the lower jaw projects outside the snout when the mouth is closed.</p>
            
            <p>Alligators are carnivorous and live along the edges of permanent bodies of water, such as lakes, swamps, and rivers. They commonly dig burrows in which they rest and avoid weather extremes. The average lifespan of alligators is about 50 years in the wild. However, there have been reports of some specimens living beyond 70 years of age in captivity.</p>
            
            <p>They are black with yellow banding when they are young and are generally brownish as adults. Their maximum length is about 5.8 meters (19 feet), but most often they range from about 1.8 to 3.7 meters (6 to 12 feet) long.</p>
            
            <p>Adult alligators feed mainly on fish, small mammals, and birds but may sometimes take prey as large as deer or cattle. Members of both sexes hiss, and the males also give loud roars that carry over considerable distances. During the breeding season, the female builds a mound nest of detritus and vegetation in which she buries about 20 to 70 hard-shelled eggs. She guards the eggs and may at this time be dangerous.</p>
            
            <p>Alligators have a reputation of being ferocious and deadly but they usually avoid humans.</p>

            <h3>Alligator Meat</h3>
            <img src="AlligatorMeat.jpg" width="300" alt="Alligator Meat" class="article-image-right"/>
            <p>The meat and eggs of alligators are used in various cuisines of the Southern United States. Alligator meat is high in protein and low in fat, and has a mild flavor and firm texture. It tastes like quail, with a mildly fishy flavor, and is often chewy, depending on preparation.</p>
            
            <p>In the United States, farmed gator meat is available for consumer purchase in specialty food stores, some grocery stores, and can also be mail ordered. Some U.S. companies process and market alligator meat derived only from the tail of alligators.</p>
            
            <p>A 100-gram (3+1⁄2-ounce) reference serving of alligator meat provides 600 kilojoules (143 kilocalories) of food energy, 29 grams of protein, 3 percent fat and 65 milligrams of cholesterol. It also contains a significant amount of phosphorus, potassium, vitamin B12, niacin and monounsaturated fatty acids.</p>
            
            <p>Various methods of preparation and cooking exist, including tenderization, marination, deep frying, stewing, roasting, smoking and sauteing. Alligator meat is used in dishes such as gumbo, and is used in traditional Louisiana Creole cuisine. Cuts from the animal used include meat from the animal's tail and backbone, which have been described as "the choicest cuts".</p>
        </div>
    </div>

    <% 
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
    rs2.Open sql2, conn, 3, 3
    if not rs2.eof then 
    %>
    <h2 class="page-header" style="text-align:left; font-size: 2em; color:#333;">Breeds of Alligators</h2>
    <p>There are the following breeds of <%= SpeciesNamePlural %>:</p>

    <% 
    while not(rs2.eof) 
        Breed2 = rs2("Breed") 
        BreedLookupID2 = rs2("BreedLookupID") 
        Breeddescription = rs2("Breeddescription")
        BreedImage = rs2("BreedImage")
        BreedImageCaption = rs2("BreedImageCaption")
    %>
    <div class="breed-item">
        <div class="breed-item-image">
             <% if len(BreedImage) > 1 then %>
            <a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>">
                <img src="<%= BreedImage%>" alt="<%=BreedImageCaption%>"/>
            </a>
            <% end if %>
        </div>
        <div class="breed-item-content-wrapper">
            <div class="breed-item-content">
                <h3><%=Breed2 %></h3>
                <p>
                    <%=left(Breeddescription, 450) %>
                    <% if len(Breeddescription) > 450 then %>...<% end if %>
                </p>
                <% if len(Breeddescription) > 25 then %>
                <div class="learn-more-button-container">
                    <a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" class="regsubmit2">LEARN MORE</a>
                </div>
                <% end if %>
            </div>
        </div>
    </div>
    <%
        rs2.movenext
    wend 
    %>
    <% 
    end if 
    rs2.close
    set rs2 = nothing
    %>
</div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>