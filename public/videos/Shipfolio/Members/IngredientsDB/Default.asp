<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/members/membersglobalvariables.asp"-->

<link rel="canonical" href="<%=currenturl %>" />

<title><%=WebSiteName %> | Ingredients</title>
<meta name="title" content="<%=WebSiteName %> | Types of Ingredients"/>
<meta name="description" content="Explore our comprehensive Knowledgebase of food Ingredients, including vegetables, fruits, herbs, and more. Learn about thousands of Ingredient Types, their characteristics, and growing requirements."/>
<meta name="keywords" content="Ingredients, food Ingredients, Ingredient Types, agriculture, gardening, vegetables, herbs, fruits, legumes, nuts, grains, mushrooms, root vegetables, tubers, leafy greens, Ingredient Knowledgebase, growing food"/>

<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<style>
/* This is your existing code for a multi-column layout on large screens */
.container {
  display: flex;
  flex-wrap: wrap;
}

.column {
  /* This can be a percentage or a specific width, e.g., 33.33% for three columns */
  flex: 1; 
  padding: 10px;
}

/* --- */

/* This is the new code for a one-column layout on medium and smaller screens */
@media (max-width: 768px) {
  .container {
    flex-direction: column;
  }
}
</style>

</head>
<body>

<% homepage = true %>

<!--#Include virtual="/members/membersHeader.asp"-->
<%
' --- Knowledgebase Connection (Assuming conn object is already available or established) ---
' Set conn = Server.CreateObject("ADODB.Connection")
' conn.Open "Your_Connection_String_Here"

Dim TotalTypes, rs, conn
Dim AlgaeTypes, BeansTypes, BulbsTypes, CormsTypes, CulinaryHerbTypes, EdibleFlowerTypes, FruitTypes, GinkgoesTypes, GrainTypes, GrassesTypes, HerbTypes, LeafyGreenTypes, LegumeTypes, MedicinalHerbTypes, MushroomTypes, NutTypes, PalmsTypes, PseudocerealTypes, RhizomesTypes, RootTypes, SpicesTypes, TubersTypes, VegetableTypes

' Initialize all Ingredient type counts to 0
AlgaeTypes = 0
BeansTypes = 0
BerriesTypes = 0
BreadTypes = 0
CandyTypes = 0
CheesesTypes = 0
ChemicalsTypes = 0
EdibleFlowerTypes = 0
FishTypes = 0
FloursTypes = 0 
FruitTypes = 0
FungiTypes = 0
GourdTypes = 0
GrainTypes = 0
HerbTypes = 0
JuiceTypes = 0
LegumeTypes = 0
MeatsTypes = 0
MelonTypes = 0
MilkTypes = 0
MullusksTypes = 0
NutTypes = 0
PastaTypes = 0
PeppersTypes = 0
PowdersTypes = 0
RicesTypes = 0
RootTypes = 0
SaltsTypes = 0
SeedsTypes = 0
SpicesTypes = 0
SugarsTypes = 0
TeasTypes = 0
TubersTypes = 0
VegetableTypes = 0
OtherTypes = 0




' --- Optimized Knowledgebase Query to get all Ingredient type counts ---
Dim sql
sql = "select count(IngredientName) as varietycount from [dbo].[IngredientsVarieties]"

      'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 ' adOpenStatic, adLockOptimistic

varietycount = rs("varietycount")
rs.close

sql = "SELECT IngredientCategoryID, COUNT(IngredientName) AS IngredientCount " & _
      "FROM Ingredients " & _
      "GROUP BY IngredientCategoryID " & _
      "ORDER BY IngredientCategoryID"

      'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 ' adOpenStatic, adLockOptimistic

TotalTypes = 0

If Not rs.EOF Then
    ' Loop through the recordset to count Types for each Ingredient type
    Do While Not rs.EOF
        Select Case rs("IngredientCategoryID")
        
            Case "14"
                AlgaeTypes = rs("IngredientCount")
            Case "11"
                BeansTypes = rs("IngredientCount")
            Case "8"
                BerriesTypes = rs("IngredientCount")
            Case "34"
                BreadTypes = rs("IngredientCount")
            Case "33"
                CandyTypes = rs("IngredientCount")
            Case "35"
                CheesesTypes = rs("IngredientCount")
            Case "15"
                ChemicalsTypes = rs("IngredientCount")
            Case "13"
                EdibleFlowerTypes = rs("IngredientCount")
            Case "4"
                FishTypes = rs("IngredientCount")
            Case "5"
                FloursTypes = rs("IngredientCount")
            Case "12"
                FruitTypes = rs("IngredientCount")
            Case "22"
                FungiTypes = rs("IngredientCount")
            Case "25"
                 GourdTypes = rs("IngredientCount")
            Case "23"
                GrainTypes = rs("IngredientCount")
            Case "17"
                HerbTypes = rs("IngredientCount")
            Case "31"
                JuiceTypes = rs("IngredientCount")
            Case "19"
                LegumeTypes = rs("IngredientCount")
            Case "10"
                MeatsTypes = rs("IngredientCount")
           Case "26"
                MelonTypes = rs("IngredientCount")
           Case "20"
                MilkTypes = rs("IngredientCount")
          Case "3"
                MullusksTypes = rs("IngredientCount")
            Case "9"
                NutTypes = rs("IngredientCount")
            Case "30"
                OilTypes = rs("IngredientCount")
            Case "1"
                PastaTypes = rs("IngredientCount")
            Case "24"
                PeppersTypes= rs("IngredientCount")
            Case "32"
                PowdersTypes = rs("IngredientCount")
            Case "6"
                RicesTypes = rs("IngredientCount")
            Case "28"
                RootTypes = rs("IngredientCount")
            Case "16"
                SaltsTypes = rs("IngredientCount")
           Case "29"
                SeedsTypes = rs("IngredientCount")
            Case "2"
                SpicesTypes = rs("IngredientCount")
            Case "18"
                SugarsTypes = rs("IngredientCount")
            Case "36"
                TeasTypes = rs("IngredientCount")
            Case "21"
                TubersTypes = rs("IngredientCount")
            Case "7"
                VegetableTypes = rs("IngredientCount")   

        End Select
        TotalTypes = TotalTypes + rs("IngredientCount")
        rs.MoveNext
    Loop
End If
rs.Close
Set rs = Nothing

%>

<div class="container-fluid" align="center" style="max-width: 1200px; min-height: 67px;">
    <div class="row">
        <div class="col body" align="left">
             <h1>Ingredient Knowledgebase</h1><br />
            <section>
                <div class="overflow-hidden" style="position: relative; padding-top: 12%;">
                    <video src="Ingredients.mp4" autoplay loop muted playsinline 
                           style="position: absolute; width: 100%; height: 130%; top: -30.5%; left: 0; object-fit: cover;" 
                           alt="Oatmeal AI: Helping America's Independent Farms and Restaurants Grow"></video>
                </div>
            </section>
            There are thousands of Ingredients, we have documented <b><%= FormatNumber(varietycount, 0, False, False, True) %> varieties of <%=TotalTypes %> Ingredients</b> so far. We have the mission to list them all here.<br /><br />
            We are consistently adding more information and photos to the list. If you would like to help out with photos, descriptions, or correcting errors please <a href="/ContactUs.asp" class="body">Contact Us</a> and let us know the more people we have helping, the more complete the information.
            <h2><div align="left">Categories of Food Ingredients</div></h2>
        </div>
    </div>
    
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Algae/" class="body"><img src='Algae.webp' width="150" height="150" alt="Algae" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Algae/" class="body">Algae (<%=AlgaeTypes %> Ingredients)</a><br />
                    Algae, which includes seaweed and microalgae, are valued in cooking for their umami, briny, and earthy flavors. They add a unique taste and texture to a variety of dishes.
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Beans/" class="body"><img src='Beans.webp' width="150" height="150" alt="Beans" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Beans/" class="body">Beans (<%=BeansTypes %> Ingredients)</a><br />
                    Beans are nutrient-rich seeds and pods from plants in the pea family. They are a staple food valued for their firm yet creamy texture and mild, earthy flavor. They are used to add substance to a wide variety of dishes.
                </div>
            </div>
        </div>
    </div>
    
        
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Berries/" class="body"><img src='Berrys.webp' width="150" height="150" alt="Berries" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Berries/" class="body">Berries (<%= BerriesTypes %> Ingredients)</a><br />
                    Berries are a diverse group of small, juicy, colorful fruits typically known for their sweet, tart, or sour flavors.
                </div>
            </div>
        </div>
          <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Breads/" class="body"><img src='Breads.webp' width="150" height="150" alt="Bread" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Breads/" class="body">Breads (<%= BreadTypes %> Ingredients)</a><br />
                    Breads are staple foods made from baked dough, distinguished by their characteristic aromas and tastes, which can range from the yeasty smell and rich flavor of a brioche, to the tangy scent and sour notes of a sourdough, or the sweet, toasted aroma of a simple white loaf.

                </div>
            </div>
        </div>
  </div>
    <div class="row">


          <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Candy/" class="body"><img src='Candy.webp' width="150" height="150" alt="Candy" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Candy/" class="body">Candy (<%= CandyTypes %> Ingredients)</a><br />
Candies are celebrated ingredients, prized for their ability to deliver a burst of pure sweetness, a dazzling splash of color, and a surprising variety of textures—from soft and chewy to crisp and crunchy. They are used to add a touch of magic and playful excitement, transforming everyday baked goods, desserts, and confections into delightful, eye-catching masterpieces.
                </div>
            </div>
        </div>
                  <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Cheeses/" class="body"><img src='Cheeses.webp' width="150" height="150" alt="Cheeses" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Cheeses/" class="body">Cheeses (<%= CheesesTypes %> Ingredients)</a><br />
                    Cheeses are diverse food products derived from milk, prized for their complex range of aromas and flavors, which can be pungent and earthy like a blue cheese, sharp and nutty like an aged cheddar, or mild, creamy, and tangy like a fresh chèvre.
                </div>
            </div>
        </div>
  </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Chemicals/" class="body"><img src='Chemicals.webp' width="150" height="150" alt="Chemicals" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Chemicals/" class="body">Chemicals (<%=ChemicalsTypes  %> Ingredients)</a><br />
                    In cooking, edible chemicals are ingredients added to food for specific purposes beyond basic nutrition. They can be naturally occurring or synthetically made.
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/EdibleFlowers/" class="body"><img src='EdibleFlowers.webp' width="150" height="150" alt="Edible Flowers" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/EdibleFlowers/" class="body">Edible Flowers (<%=EdibleFlowerTypes %> Ingredients)</a><br />
                    Edible flowers are blossoms safe for human consumption, prized for their flavor, aroma, and visual appeal in cooking. They are used to garnish, add color to, or flavor a variety of dishes.
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Fish/" class="body"><img src='Fish.webp' width="150" height="150" alt="CFish" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Fish/" class="body">Fish (<%=FishTypes %> Ingredients)</a><br />
                    Fish are a global food source, valued for their high-quality protein and omega-3 fatty acids. Their flavors range from mild to rich and oily.
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Flours/" class="body"><img src='Flours.webp' width="150" height="150" alt="Flours" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Flours/" class="body">Flours (<%=FloursTypes %> Ingredients)</a><br />
                    Flour is a powder made from grinding grains, nuts, or seeds. It is a fundamental ingredient used to add structure and substance to food.
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Fruits/" class="body"><img src='Fruit.webp' width="150" height="150" alt="Fruits" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Fruits/" class="body">Fruits (<%=FruitTypes %> Ingredients)</a><br />
                    Fruits are the sweet, fleshy, seed-bearing products of a plant. They are a food source enjoyed fresh or used in countless dishes and drinks.
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Fungi/" class="body"><img src='Fungi.webp' width="150" height="150" alt="Fungi" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Fungi/" class="body">Fungis (<%=FungiTypes %> Ingredients)</a><br />
                    Fungi, such as mushrooms and yeasts, are consumed for their unique earthy flavors and textures. They are an important food source that adds depth to many cuisines.
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Gourds/" class="body"><img src='Goards.png' width="150" height="150" alt="Gourd" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Gourds/" class="body">Gourds (<%=GourdTypes %> Ingredients)</a><br />
                    Gourds, including squashes and pumpkins, are versatile food plants used as vegetables in savory dishes or as a base for sweet recipes. They are valued for their soft texture and mild flavor.
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Grains/" class="body"><img src='Grains.webp' width="150" height="150" alt="Grains" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Grains/" class="body">Grains (<%=GrainTypes %> Ingredients)</a><br />
                    Grains are edible seeds from cereal grasses like wheat and rice. A global food staple, they provide carbohydrates and a variety of textures.
                </div>
            </div>
        </div>
 </div>
    <div class="row">

        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/CulinaryHerbs/" class="body"><img src='CulinaryHerbs.webp' width="150" height="150" alt="Culinary Herbs" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/CulinaryHerbs/" class="body">Herbs (<%=HerbTypes %> Ingredients)</a><br />
                    Culinary herbs are fresh or dried leaves valued for their distinct aromatic, earthy, sweet, or savory flavors that enhance a dish.
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Juices/" class="body"><img src='Juice.webp' width="150" height="150" alt="Juice" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Juices/" class="body">Juices (<%=JuiceTypes %> Ingredients)</a><br />
                    Juices are the liquids pressed from fruits or vegetables. They are used as beverages or as ingredients to add flavor and moisture to dishes.
                </div>
            </div>
        </div>
      </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Legumes/" class="body"><img src='Legumes.webp' width="150" height="150" alt="Legumes" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Legumes/" class="body">Legumes (<%=LegumeTypes %> Ingredients)</a><br />
                    Legumes are protein-rich seeds and pods. They are valued for their mild flavor and hearty texture, adding substance to many savory dishes.
                    </div>
            </div>
        </div>
  
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Meats/" class="body"><img src='Meats.webp' width="150" height="150" alt="Meats" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Meats/" class="body">Meats (<%=MeatsTypes %> Ingredients)</a><br />
                    Meats are protein-rich muscle tissues derived from animals. They are valued for their intense, savory umami flavor and versatile, hearty textures, providing the foundation for countless main courses.
                </div>
            </div>
        </div>
</div>
<div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Melons/" class="body"><img src='Melons.webp' width="150" height="150" alt="Melons" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Melons/" class="body">Melons (<%=MelonTypes %> Ingredients)</a><br />
                    Melons are large, fleshy fruits from the gourd family. They are valued for their high water content and refreshing sweet flavor, primarily serving as light desserts, appetizers, or beverages.
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Milks/" class="body"><img src='Milks.webp' width="150" height="150" alt="Milk" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Milks/" class="body">Milks (<%=MilkTypes %> Ingredients)</a><br />
                    Milks are liquid ingredients used in cooking and baking to add richness, moisture, and a creamy texture to a wide range of dishes.
                </div>
            </div>
        </div>
        </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Mullusks/" class="body"><img src='Mullusks.webp' width="150" height="150" alt="Mollusks and Crustaceans" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Mullusks/" class="body">Mollusks and Crustaceans (<%= MullusksTypes %> Ingredients)</a><br />
                    Mollusks and crustaceans are types of seafood prized for their delicate, briny, and sweet flavors, and varied textures in many cuisines.
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Nuts/" class="body"><img src='Nuts.webp' width="150" height="150" alt="Nuts" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Nuts/" class="body">Nuts (<%=NutTypes %> Ingredients)</a><br />
                    Nuts are the dry, hard-shelled seeds or fruits of plants. They are a global food source providing protein and healthy fats, and are prized for their flavor and texture.
                </div>
            </div>
        </div>
</div>
<div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Oils/" class="body"><img src='Oils.webp' width="150" height="150" alt="Oil" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Oils/" class="body">Oils (<%=OilTypes %> Ingredients)</a><br />
                    Oils are liquid fats used for cooking, adding moisture, and providing rich flavor to a variety of dishes.
                </div>
            </div>
        </div>
 
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Pastas/" class="body"><img src='Pasta.webp' width="150" height="150" alt="Pasta" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Pastas/" class="body">Pastas (<%=PastaTypes %> Ingredients)</a><br />
                    Pasta is a food made from a flour-based dough that is cooked by boiling and used as a base for many dishes.
                </div>
            </div>
        </div>
       </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Peppers/" class="body"><img src='Peppers.webp' width="150" height="150" alt="Peppers" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Peppers/" class="body">Peppers (<%=PeppersTypes %> Ingredients)</a><br />
                    Peppers are versatile fruits with flavors ranging from sweet to fiery hot, adding crisp texture and color to a variety of dishes.
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Powders/" class="body"><img src='Powder.webp' width="150" height="150" alt="Powder" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Powders/" class="body">Powders (<%=PowdersTypes %> Ingredients)</a><br />
                    Powders are finely ground, dry ingredients used to add flavor, color, or a thickened consistency to a wide range of dishes and beverages.
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Rices/" class="body"><img src='Rices.webp' width="150" height="150" alt="Rices" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Rices/" class="body">Rices (<%=RicesTypes %> Ingredients)</a><br />
                    Rices are the starchy grains harvested from the Oryza sativa plant. They are valued for their ability to take on any flavor they are cooked with and for their varying textures—from fluffy and separate to sticky and creamy—serving as the staple foundation for meals worldwide.
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/RootVegetables/" class="body"><img src='RootVegetables.webp' width="150" height="150" alt="Vegetables" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/RootVegetables/" class="body">Root Vegetables (<%=VegetableTypes %> Ingredients)</a><br />
                    Root vegetables are a diverse group of plants grown underground, valued for their starchy texture, earthy flavor, and rich nutrients. They are culinary staples worldwide.
                </div>
            </div>
        </div>
</div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Salts/" class="body"><img src='Salts.webp' width="150" height="150" alt="Salts" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Salts/" class="body">Salts (<%=SaltsTypes %> Ingredients)</a><br />
                    Salts enhance and balance flavors, from a simple sprinkle to complex blends, elevating any dish with their essential savory touch.
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Seeds/" class="body"><img src='Seeds.webp' width="150" height="150" alt="Seeds" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Seeds/" class="body">Seeds (<%=SeedsTypes %> Ingredients)</a><br />
                    Seeds are the hard, dry, edible parts of certain plants, used as a tasty ingredient.
                </div>
            </div>
        </div>
            </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Spices/" class="body"><img src='Spices.webp' width="150" height="150" alt="Spices" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Spices/" class="body">Spices (<%=SpicesTypes %> Ingredients)</a><br />
                    Spices are aromatic plant substances that ignite dishes with their bold flavors and aroma, derived from seeds, bark, or roots.
                </div>
            </div>
        </div>
  
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Sugars/" class="body"><img src='Sugars.webp' width="150" height="150" alt="Sugars" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Sugars/" class="body">Sugars (<%=SugarsTypes %> Ingredients)</a><br />
                    Crystals of pure joy, sugars elevate food and drink with irresistible sweetness, moisture, and satisfying structure. 
                </div>
            </div>
        </div>
          </div>
    <div class="row">
   <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Teas/" class="body"><img src='Teas.webp' width="150" height="150" alt="Teas" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Teas/" class="body">Teas (<%=TeasTypes %> Ingredients)</a><br />
                    Teas are aromatic beverages prepared by infusing the cured leaves of the Camellia sinensis plant, such as green or black tea, or from other herbs and fruits, and are widely consumed for their diverse flavors and stimulating or soothing properties.
                  </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Tubers/" class="body"><img src='Tubers.webp' width="150" height="150" alt="Tubers" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Tubers/" class="body">Tubers (<%=TubersTypes %> Ingredients)</a><br />
                    Tubers are enlarged, starchy storage organs of a plant's stem, like potatoes and yams, that are a crucial source of carbohydrates.
                </div>
            </div>
        </div>
            </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                    <a href="/members/IngredientsDB/Vegetables/" class="body"><img src='Vegetables.webp' width="150" height="150" alt="Vegetables" /></a>
                </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                    <a href="/members/IngredientsDB/Vegetables/" class="body">Vegetables (<%=VegetableTypes %> Ingredients)</a><br />
                    Vegetables are the leaves, stems, roots, flowers, or fruits of edible plants. They are valued for their vibrant colors, wide range of textures (from crisp to tender), and earthy, subtly savory flavors, forming the essential core of most balanced dishes.
                </div>
            </div>
        </div>
         <div class="col-12 col-md-6 col-lg-6 d-md-block">
            <div class="row">
                <div class="col-12 col-md-4 body" align="center" style="margin-top: 15px;">
                 </div>
                <div class="col-12 col-md-8 body" align="left"><br>
                  </div>
            </div>
        </div>
    </div>
</div>
<br><br>

<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>