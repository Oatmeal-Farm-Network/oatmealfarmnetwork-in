<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->

<link rel="canonical" href="<%=currenturl %>" />

<title><%=WebSiteName %> | Varieties of Plants</title>
<meta name="title" content="<%=WebSiteName %> | Varieties of Plants"/>
<meta name="description" content="Explore our comprehensive database of food plants, including vegetables, fruits, herbs, and more. Learn about thousands of plant varieties, their characteristics, and growing requirements."/>
<meta name="keywords" content="plants, food plants, plant varieties, agriculture, gardening, vegetables, herbs, fruits, legumes, nuts, grains, mushrooms, root vegetables, tubers, leafy greens, plant database, growing food"/>

<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>

<% homepage = true %>

<!--#Include virtual="/Members/MembersHeader.asp"-->
<%
' --- Database Connection (Assuming conn object is already available or established) ---
' Set conn = Server.CreateObject("ADODB.Connection")
' conn.Open "Your_Connection_String_Here"

Dim TotalVarieties, rs, conn
Dim AlgaeVarieties, BerriesVarieties, BulbsVarieties, CormsVarieties, CulinaryHerbVarieties, EdibleFlowerVarieties, FruitVarieties, GinkgoesVarieties, GrainVarieties, GrassesVarieties, HerbVarieties, LeafyGreenVarieties, LegumeVarieties, MedicinalHerbVarieties, MushroomVarieties, NutVarieties, PalmsVarieties, PseudocerealVarieties, RhizomesVarieties, RootVarieties, SpicesVarieties, TubersVarieties, VegetableVarieties

' Initialize all plant type counts to 0
AlgaeVarieties = 0
BerriesVarieties = 0
BulbsVarieties = 0
CormsVarieties = 0
CulinaryHerbVarieties = 0
EdibleFlowerVarieties = 0
FruitVarieties = 0
GinkgoesVarieties = 0
GrainVarieties = 0
GrassesVarieties = 0
HerbVarieties = 0
LeafyGreenVarieties = 0
LegumeVarieties = 0
MedicinalHerbVarieties = 0
MushroomVarieties = 0
NutVarieties = 0
PalmsVarieties = 0
PseudocerealVarieties = 0
RhizomesVarieties = 0
RootVarieties = 0
SpicesVarieties = 0
TubersVarieties = 0
VegetableVarieties = 0

' --- Optimized Database Query to get all plant type counts ---
Dim sql
sql = "SELECT PT.PlantType, COUNT(PV.PlantVarietyID) AS VarietyCount " & _
      "FROM PlantVariety PV " & _
      "JOIN Plant P ON PV.PlantID = P.PlantID " & _
      "JOIN PlantTypeLookup PT ON P.PlantTypeID = PT.PlantTypeID " & _
      "WHERE PT.Edible = 'True' " & _
      "GROUP BY PT.PlantType " & _
      "ORDER BY PT.PlantType"
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 ' adOpenStatic, adLockOptimistic

TotalVarieties = 0

If Not rs.EOF Then
    ' Loop through the recordset to count varieties for each plant type
    Do While Not rs.EOF
        Select Case rs("PlantType")
            Case "Algaes"
                AlgaeVarieties = rs("VarietyCount")
            Case "Berries"
                BerriesVarieties = rs("VarietyCount")
            Case "Bulbs"
                BulbsVarieties = rs("VarietyCount")
            Case "Corms"
                CormsVarieties = rs("VarietyCount")
            Case "Culinary Herbs"
                CulinaryHerbVarieties = rs("VarietyCount")
            Case "Edible Flowers"
                EdibleFlowerVarieties = rs("VarietyCount")
            Case "Fruits"
                FruitVarieties = rs("VarietyCount")
            Case "Ginkgoes"
                GinkgoesVarieties = rs("VarietyCount")
            Case "Grains"
                GrainVarieties = rs("VarietyCount")
            Case "Grasses"
                GrassesVarieties = rs("VarietyCount")
            Case "Herbs"
                HerbVarieties = rs("VarietyCount")
            Case "Leafy Greens"
                LeafyGreenVarieties = rs("VarietyCount")
            Case "Legumes"
                LegumeVarieties = rs("VarietyCount")
            Case "Medicinal Herb"
                MedicinalHerbVarieties = rs("VarietyCount")
            Case "Mushroom"
                MushroomVarieties = rs("VarietyCount")
            Case "Nut"
                NutVarieties = rs("VarietyCount")
            Case "Palms"
                PalmsVarieties = rs("VarietyCount")
            Case "Pseudocereal"
                PseudocerealVarieties = rs("VarietyCount")
            Case "Rhizomes"
                RhizomesVarieties = rs("VarietyCount")
            Case "Root"
                RootVarieties = rs("VarietyCount")
            Case "Spices"
                SpicesVarieties = rs("VarietyCount")
            Case "Tubers"
                TubersVarieties = rs("VarietyCount")
            Case "Vegetable"
                VegetableVarieties = rs("VarietyCount")
        End Select
        TotalVarieties = TotalVarieties + rs("VarietyCount")
        rs.MoveNext
    Loop
End If
rs.Close
Set rs = Nothing

%>



<div class="container-fluid " align="center" style="max-width: 1200px; min-height: 67px;">
    <div class="row">
        <div class="col body" align="left">
            <h1>Online Plant Database</h1><br />
            <section>
                <!-- The outer div acts as a frame. It has a custom aspect ratio and hides overflow. -->
                <div class="overflow-hidden" style="position: relative; padding-top: 12%;">
                    <!-- The video is positioned absolutely. It's made taller and shifted up to crop the top and bottom. -->
                    <video src="PlantDBVideo.mp4" autoplay loop muted playsinline 
                           style="position: absolute; width: 100%; height: 130%; top: -30.5%; left: 0; object-fit: cover;" 
                           alt="Oatmeal AI: Helping America's 1.9M Small Farms Grow"></video>
                </div>
            </section>
            There are thousands of varieties of plants grown for food, we have documented <b><%=TotalVarieties %> Varieties</b> so far. We have the mission to list them all here.<br /><br />
            We are consistently adding more information and photos to the list, and we are always finding more varieties. If you would like to help out with photos, descriptions, or correcting errors please <a href="/ContactUs.asp" class="body">Contact Us</a> and let us know the more people we have helping, the more complete the information.
            <h2><div align="left">Categories of Food Plants</div></h2>
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Algae/" class="body"><img src='images/Algae.webp' width="150" height="150" alt="Algae" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Algae/" class="body">Algae (<%=AlgaeVarieties %> Varieties)</a><br />
            A diverse group of aquatic organisms, including seaweeds and microalgae, used in cooking, supplements, and other products.
        </div>
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Berries/" class="body"><img src='images/Berries.webp' width="150" height="150" alt="Berries" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Berries/" class="body">Berries (<%=BerriesVarieties %> Varieties)</a><br />
            Small, fleshy fruits that grow on bushes or vines, such as blueberries and cranberries, valued for their sweet or tart flavor.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Bulbs/" class="body"><img src='images/Bulbs.webp' width="150" height="150" alt="Bulbs" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Bulbs/" class="body">Bulbs (<%=BulbsVarieties %> Varieties)</a><br />
            The underground storage organs of plants, like onions and garlic, that are a fundamental flavor base in many cuisines.
        </div>
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Corms/" class="body"><img src='images/Corms.webp' width="150" height="150" alt="Corms" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Corms/" class="body">Corms (<%=CormsVarieties %> Varieties)</a><br />
            Underground storage organs that are botanically distinct from bulbs and tubers, such as taro and water chestnuts.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/CulinaryHerbs/" class="body"><img src='images/CulinaryHerbs.webp' width="150" height="150" alt="Culinary Herbs" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/CulinaryHerbs/" class="body">Culinary Herbs (<%=CulinaryHerbVarieties %> Varieties)</a><br />
            Plants or plant parts, like parsley and basil, used specifically to enhance the flavor, aroma, and appearance of food.
        </div>
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/EdibleFlowers/" class="body"><img src='images/EdibleFlowers.webp' width="150" height="150" alt="Edible Flowers" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/EdibleFlowers/" class="body">Edible Flowers (<%=EdibleFlowerVarieties %> Varieties)</a><br />
            Flowers that are safe for human consumption, often used for their flavor, aroma, or decorative qualities in dishes.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Fruits/" class="body"><img src='images/Fruit.webp' width="150" height="150" alt="Fruits" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Fruits/" class="body">Fruits (<%=FruitVarieties %> Varieties)</a><br />
            The sweet, seed-bearing produce of a plant, ranging from crisp apples to juicy melons, enjoyed fresh or in countless dishes and drinks.
        </div>
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Ginkgoes/Varietals.asp?PlantID=273" class="body"><img src='images/Ginko.webp' width="150" height="150" alt="Ginkgoes" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Ginkgos/Varietals.asp?PlantID=273" class="body">Ginkgos (<%=GinkgoesVarieties %> Varieties)</a><br />
            Ancient and resilient trees distinguished by their unique fan-shaped leaves and edible nuts.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Grains/" class="body"><img src='images/Grains.webp' width="150" height="150" alt="Grains" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Grains/" class="body">Grains (<%=GrainVarieties %> Varieties)</a><br />
            The hard, dry seeds of cereal grasses, such as wheat, rice, and corn, that are foundational to many diets globally.
        </div>
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Grasses/" class="body"><img src='images/Grasses.webp' width="150" height="150" alt="Grasses" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Grasses/" class="body">Grasses (<%=GrassesVarieties %> Varieties)</a><br />
            A diverse and widespread group of plants including cereal crops like wheat and rice, and various forage plants.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/LeafyGreens/" class="body"><img src='images/LeafyGreens.webp' width="150" height="150" alt="Leafy Greens" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/LeafyGreens/" class="body">Leafy Greens (<%=LeafyGreenVarieties %> Varieties)</a><br />
            A variety of edible plant leaves, such as spinach and lettuce, packed with vitamins and minerals and perfect for salads or cooking.
        </div>
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Legumes/" class="body"><img src='images/Legumes.jpg' width="150" height="150" alt="Legumes" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Legumes/" class="body">Legumes (<%=LegumeVarieties %> Varieties)</a><br />
            Plants in the pea family grown for their nutrient-rich seeds and pods, including popular staples like beans, lentils, and peas.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/MedicinalHerbs/" class="body"><img src='images/MedicinalHerbs.webp' width="150" height="150" alt="Medicinal Herbs" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/MedicinalHerbs/" class="body">Medicinal Herbs (<%=MedicinalHerbVarieties %> Varieties)</a><br />
            Plants used for their therapeutic properties, often valued in traditional medicine for promoting health and wellness.
        </div>
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Mushrooms/Varietals.asp?PlantID=27" class="body"><img src='images/Mushrooms.webp' width="150" height="150" alt="Mushrooms" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Mushrooms/Varietals.asp?PlantID=27" class="body">Mushrooms (<%=MushroomVarieties %> Varieties)</a><br />
            The edible, fleshy fruiting bodies of fungi, prized for their earthy flavors and unique textures in cooking.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Nuts/" class="body"><img src='images/Nuts.webp' width="150" height="150" alt="Nuts" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Nuts/" class="body">Nuts (<%=NutVarieties %> Varieties)</a><br />
            Dry, hard-shelled seeds or fruits that are a fantastic source of protein and healthy fats, such as almonds, walnuts, and pecans.
        </div>
    
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Palms/" class="body"><img src='images/Palms.webp' width="150" height="150" alt="Palms" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Palms/" class="body">Palms (<%=PalmsVarieties %> Varieties)</a><br />
            Tropical trees with large fronds, cultivated for their delicious and useful fruits like coconuts and dates.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Pseudocereals/" class="body"><img src='images/Psuodcereals.webp' width="150" height="150" alt="Pseudocereals" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Pseudocereals/" class="body">Pseudocereals (<%=PseudocerealVarieties %> Varieties)</a><br />
            Plants, like quinoa and amaranth, whose seeds are used in the same way as grains but are not botanically from the grass family.
        </div>

        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Rhizomes/" class="body"><img src='images/Rhizomes.webp' width="150" height="150" alt="Rhizomes" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Rhizomes/" class="body">Rhizomes (<%=RhizomesVarieties %> Varieties)</a><br />
            Underground stems that grow horizontally, such as ginger and turmeric, used as spices and in traditional medicine.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/RootVegetables/" class="body"><img src='images/RootVegetables.webp' width="150" height="150" alt="Roots" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/RootVegetables/" class="body">Root Vegetables (<%=RootVarieties %> Varieties)</a><br />
            Edible plant roots that grow underground, including carrots and radishes, valued for their distinct flavors and dense nutrition.
        </div>
  
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Spices/" class="body"><img src='images/Spices.webp' width="150" height="150" alt="Spices" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Spices/" class="body">Spices (<%=SpicesVarieties %> Varieties)</a><br />
            Aromatic plant substances, derived from seeds, bark, or roots, used to add depth of flavor and aroma to dishes.
        </div>
    </div>
    <div class="row">
        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Tubers/" class="body"><img src='images/Tubers.webp' width="150" height="150" alt="Tubers" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Tubers/" class="body">Tubers (<%=TubersVarieties %> Varieties)</a><br />
            Enlarged, starchy storage organs of a plant's stem, like potatoes and yams, that serve as a crucial source of carbohydrates.
        </div>

        <div class="col-2 body" align="left" style="margin-top: 15px;">
            <a href="/Members/PlantDB/Vegetables/" class="body"><img src='images/Vegetables.webp' width="150" height="150" alt="Vegetables" /></a>
        </div>
        <div class="col-4 body" align="left">
            <a href="/Members/PlantDB/Vegetables/" class="body">Vegetables (<%=VegetableVarieties %> Varieties)</a><br />
            A wide variety of plants and plant parts, from crunchy carrots to tender asparagus, that are staples of savory meals around the world.
        </div>
    </div>
</div>
<br><br>

<!--#Include virtual="/Members/MembersFooter.asp"-->
</body></html>