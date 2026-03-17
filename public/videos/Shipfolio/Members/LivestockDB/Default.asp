<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<Title>Harvest Hub</Title>
<meta name="robots" content="nofollow">
<% homepage = true 
Current1 = "MembersHome"
Current2="MembersHome" %> 

</head>
<body >
<!--#Include virtual="/members/MembersHeader.asp"-->



<%

' --- Hardcoded values ---
Dim EmuBreeds, LlamaBreeds, MuskOxBreeds, OstrichBreeds
EmuBreeds = 1
LlamaBreeds = 1
MuskOxBreeds = 1
OstrichBreeds = 1

' --- Optimized Database Query ---
Dim sql, BeeBreeds, BisonBreeds, BuffaloBreeds, CattleBreeds, ChickenBreeds, DeerBreeds, DogBreeds, DonkeyBreeds, DucksBreeds, GeeseBreeds, GoatBreeds, GuineaFowlBreeds, HorseBreeds, PheasantsBreeds, PigBreeds, PigeonsBreeds, QuailsBreeds, RabbitBreeds, SheepBreeds, SnailsBreeds, TurkeyBreeds, YakBreeds

' Create a single SQL statement to get all counts at once
sql = "SELECT " & _
    "COUNT(CASE WHEN SpeciesID = 23 THEN 1 END) AS BeeBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 21 THEN 1 END) AS BisonBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 34 THEN 1 END) AS BuffaloBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 8 THEN 1 END) AS CattleBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 13 THEN 1 END) AS ChickenBreeds, " & _ 
    "COUNT(CASE WHEN SpeciesID = 9 THEN 1 END) AS DeerBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 3 AND working = 1 THEN 1 END) AS DogBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 7 THEN 1 END) AS DonkeyBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 15 THEN 1 END) AS DucksBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 22 THEN 1 END) AS GeeseBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 6 THEN 1 END) AS GoatBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 26 THEN 1 END) AS GuineaFowlBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 5 THEN 1 END) AS HorseBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 29 THEN 1 END) AS PheasantsBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 12 THEN 1 END) AS PigBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 30 THEN 1 END) AS PigeonsBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 31 THEN 1 END) AS QuailsBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 11 THEN 1 END) AS RabbitBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 10 THEN 1 END) AS SheepBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 33 THEN 1 END) AS SnailsBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 14 THEN 1 END) AS TurkeyBreeds, " & _
    "COUNT(CASE WHEN SpeciesID = 17 THEN 1 END) AS YakBreeds " & _
    "FROM SpeciesBreedLookupTable"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3

If Not rs.EOF Then
    ' Assign all variables from the single database record
    BeeBreeds = rs("BeeBreeds")
    BisonBreeds = rs("BisonBreeds")
    BuffaloBreeds = rs("BuffaloBreeds")
    CattleBreeds = rs("CattleBreeds")
    ChickenBreeds = rs("ChickenBreeds")
    DeerBreeds = rs("DeerBreeds")
    DogBreeds = rs("DogBreeds")
    DonkeyBreeds = rs("DonkeyBreeds")
    DucksBreeds = rs("DucksBreeds")
    GeeseBreeds = rs("GeeseBreeds")
    GoatBreeds = rs("GoatBreeds")
    GuineaFowlBreeds = rs("GuineaFowlBreeds")
    HorseBreeds = rs("HorseBreeds")
    PheasantsBreeds = rs("PheasantsBreeds")
    PigBreeds = rs("PigBreeds")
    PigeonsBreeds = rs("PigeonsBreeds")
    QuailsBreeds = rs("QuailsBreeds")
    RabbitBreeds = rs("RabbitBreeds")
    SheepBreeds = rs("SheepBreeds")
    SnailsBreeds = rs("SnailsBreeds")
    TurkeyBreeds = rs("TurkeyBreeds")
    YakBreeds = rs("YakBreeds")
End If
rs.Close
Set rs = Nothing


TotalBreeds = BeeBreeds + BisonBreeds + BuffaloBreeds + CattleBreeds + ChickenBreeds + DeerBreeds + DogBreeds + DonkeyBreeds + DucksBreeds + GeeseBreeds + GoatBreeds + GuineaFowlBreeds + HorseBreeds + PheasantsBreeds + PigBreeds + PigeonsBreeds + QuailsBreeds + RabbitBreeds + SheepBreeds + SnailsBreeds + TurkeyBreeds + YakBreeds
TotalBreeds = TotalBreeds + EmuBreeds + LlamaBreeds + MuskOxBreeds + OstrichBreeds

TotalBreeds = TotalBreeds + 2 + 3 + 7
%>



  <% ' lg+ navigation  %>
    <div class="container d-none d-lg-block" align = "right" style="max-width: 1400px; min-height: 67px; ">
        <h1>Livestock Database</h1>
    <div class = "row">
        <div class = "col body" align = right>
        <center><img src ="/images/DirectoryHeader.webp" width = 60% style="min-width:350px" alt = "Livestock Breeds" /></center>
<br /> <br />There are thousands of breeds of livestock, we have documented <b><%=TotalBreeds %> Breeds</b> so far. We have the mission to list them all here.<br /><br />
We are consistently adding more information and photos to the list, and we are always finding more breeds. If you would like to help out with photos, descriptions, or correcting errors please <a href = "/ContactUs.asp" class = body>Contact Us</a> and let us know the more people we have helping, the more complete the information.

<br>
<br>
<h2><div align = "left">Breeds of Livestock</div></h2>

        </div>
    </div>

     <div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
          <a href = "/Members/LivestockDB/Alpacas/" class = "body"><img src = '/images/Alpaca.webp' width = "150" height = "150" alt = "Alpaca" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Alpacas/" class = "body">Alpacas (2 Breeds)</a><br />
            Alpacas are domesticated South American camelids. They are known for their soft, warm, and luxurious fiber which is used for making clothing and other textiles. <br /><br />
        </div>
   <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/HoneyBees/" class = "body"><img src = '/breedsoflivestock/HoneyBees.webp' width = "150" height = "150" alt = "Breeds of Honey Bees" /></a>
        </div>
        <div class = "col-4 body" align = left>
             <a href ="/Members/LivestockDB/HoneyBees/" class = "body">Bees, Honey (<%=BeeBreeds %> Breeds)</a><br />
        Honey bees are well known for their ability to produce honey and they are important to humans for their role in agriculture and for the production of honey, beeswax, and other products.<br /><br />
        </div>
   </div>


     <div class = "row">
     
        <div class = "col-2 body" align = right style="Max-width:160px">
          <a href = "/Members/LivestockDB/Bison/" class = "body"><img src = '/images/Bison.webp' width = "150" height = "150" alt = "Bison" /></a><br />
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Bison/" class = "body">Bison (<%=BisonBreeds %> Breeds)</a><br />
            Bison are large, grazing mammals native to North America. Bison have a shaggy brown coat, a large head, and a hump of muscle over their shoulders.<br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
          <a href = "/Members/LivestockDB/Bison/" class = "body"><img src = '/images/Buffalo.webp' width = "150" height = "150" alt = "Buffalo" /></a><br />
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Buffalo/" class = "body">Buffalo (<%=BuffaloBreeds %> Breeds)</a><br />
             Buffalo are highly valued for their meat, hides, and dung, which is used as fuel and fertilizer.<br /><br />
        </div>
     </div>



      <div class = "row">
          <div class = "col-2 body" align = right style="Max-width:160px">
          <a href = "/Members/LivestockDB/Camels/" class = "body"><img src = '/images/Camels.webp' width = "150" height = "150" alt = "Camels" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Camels/" class = "body">Camels (3 Breeds)</a><br />
            Camels are domesticated mammals that are raised for transportation, milk, meat, and hides.
            <br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
          <a href = "/Members/LivestockDB/Cattle/" class = "body"><img src = '/images/Cattle.webp' width = "150" height = "150" alt = "Cows" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Cattle/" class = "body">Cattle (<%=CattleBreeds %> Breeds)</a><br />
            Cattle are raised for their meat, milk, and hides, and as draft animals for farming.<br /><br />
        </div>
     </div>



     <div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
            <a href = "v/Chickens/" class = "body"><img src = '/images/Chicken.webp' width = "150" height = "150" alt = "Chickens" /></a>

        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Chickens/" class = "body">Chickens (<%=ChickenBreeds %> Breeds)</a><br />
            Chickens are domesticated birds that are raised for their meat and eggs, and are one of the most commonly kept poultry species in the world. <br /><br />
         </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
          <a href = "/Members/LivestockDB/Alligators/" class = "body"><img src = '/images/Alligator.webp' width = "150" height = "150" alt = "Alligator" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Alligators/" class = "body">Crocodiles & Alligators (7 Breeds)</a><br />
            Crocodiles and alligators are large, semi-aquatic reptiles known for their powerful jaws and ancient lineage.<br /><br />
        </div>
     </div>






    <div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
            <a href = "/Members/LivestockDB/Deer/" class = "body"><img src = '/images/Deer.webp' width = "150" height = "150" alt = "Deer" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Deer/" class = "body">Deer (<%=DeerBreeds %> Breeds)</a><br />
            Deer are raised for their meat, antlers, and hides.<br /><br />
         </div>
        
          <div class = "col-2 body" align = right style="Max-width:160px">
           <a href = "/Members/LivestockDB/Dogs/" class = "body"><img src = '/images/Dogs.webp' width = "150" height = "150" alt = "Dogs" /></a>

        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Dogs/" class = "body">Dogs, Working (<%=DogBreeds %> Breeds)</a><br />
           Working dogs are intelligent and dedicated partners.<br /><br />
        </div>
     </div>



    <div class = "row">  
        <div class = "col-2 body" align = right style="Max-width:160px">
           <a href = "/Members/LivestockDB/Donkeys/" class = "body"><img src = '/images/Donkeys.webp' width = "150" height = "150" alt = "Donkey" /></a>

        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Donkeys/" class = "body">Donkeys (<%=DonkeyBreeds %> Breeds)</a><br />
           Donkeys are smaller and stockier than horses, with long ears, short manes, and a distinctive braying call.<br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
           <a href = "/Members/LivestockDB/Ducks/" class = "body"><img src = '/images/Duck.webp' width = "150" height = "150" alt = "Ducks" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Ducks/" class = "body">Ducks (<%=DucksBreeds %> Breeds)</a><br />
           Ducks are found all over the world, in both freshwater and saltwater habitats. And Duck meat is one of the most popular poultry meats worldwide.<br /><br />
        </div>
     </div>

    <div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
           <a href = "/Members/LivestockDB/Emus/" class = "body"><img src = '/images/Emu.webp' width = "150" height = "150" alt = "Emus" /></a>
           
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Emus/" class = "body">Emus (<%=EmuBreeds %> Breed)</a><br />
           Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil<br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
           <a href = "/Members/LivestockDB/Geese/" class = "body"><img src = '/images/Geese.webp' width = "150" height = "150" alt = "Geese" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Geese/" class = "body">Geese (<%=GeeseBreeds %> Breeds)</a><br />
          Geese are raised as livestock for their meat, eggs, and down feathers.<br /><br />
        </div>
   </div>


    <div class = "row">
         <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Goats/Default.asp?SpeciesID=2" class = "body"><img src = '/breedsoflivestock/Goats.webp' width = "150" height = "150" alt = "Breeds of Goats" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Goats/" class = "body">Goats (<%=GoatBreeds %> Breeds)</a><br />
        Goats are known for their ability to thrive in a variety of environments, from mountains to deserts, and are raised for their meat, milk, and hides. <br /><br />
        </div>
       <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/GuineaFowl/Default.asp?SpeciesID=2" class = "body"><img src = '/images/GuineaFowl.webp' width = "150" height = "150" alt = "Guinea Fowl" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/GuineaFowl/" class = "body">Guinea Fowl (<%=GuineaFowlBreeds %> Breeds)</a><br />
        Guinea fowl are prized for their delicious meat and flavorful eggs. <br /><br />
        </div>
    </div>


    <div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
            <a href = "/Members/LivestockDB/Horses/" class = "body"><img src = '/images/cowboy2.webp' width = "150" height = "150" alt = "Breeds of Horses" /></a>
        </div>
        <div class = "col-4 body" align = left>
             <a href ="/Members/LivestockDB/Horses/" class = "body">Horses (<%=HorseBreeds %> Breeds)</a><br />
             Horses are large, powerful animals that are known for their speed, grace, and beauty.<br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Llamas/" class = "body"><img src = '/images/Llama2.webp' width = "150" height = "150" alt = "Llamas" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Llamas/" class = "body">Llamas (1 Breed)</a><br />
            Llamas are a South American camelid that has been widely used as a pack and meat animal by South American cultures for thousands of years.<br /><br />
        </div>
     </div>

      <div class = "row">
        <div class = "col-2 body"align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/MuskOx/" class = "body"><img src = '/images/MuskOx.webp' width = "150" height = "150" alt = "MuskOx" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/MuskOx/" class = "body">Musk Ox (<%=MuskOxBreeds %> Breed)</a><br />
            The musk ox is a large, Arctic-dwelling mammal that is known for its shaggy coat and distinctive curved horns. <br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Ostriches/" class = "body"><img src = '/images/Ostrich.webp' width = "150" height = "150" alt = "Ostriches" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Ostriches/" class = "body">Ostriches (<%=OstrichBreeds %> Breed)</a><br />
            Ostriches are the largest bird in the world and are native to the savannas and deserts of Africa. They are raised for their meat, leather, feathers, and eggs. <br /><br />
        </div>
     </div>

     <div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Pheasants/" class = "body"><img src = '/images/Pheasant.webp' width = "150" height = "150" alt = "Pheasants" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Pheasants/" class = "body">Pheasants (<%=PheasantsBreeds %> Breeds)</a><br />
            Pheasants are a group of birds native to Asia and Europe, and are widely kept for hunting and as ornamental birds.<br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Pigs/" class = "body"><img src = '/breedsoflivestock/Pigs.webp' width = "150" height = "150" alt = "Breeds of Pigs" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Pigs/" class = "body">Pigs (<%=PigBreeds %> Breeds)</a><br />
            Pig are raised for their meat and are one of the most commonly farmed animals in the world.<br /><br />
        </div>
    </div>

      <div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Pigeons/" class = "body"><img src = '/images/Pigeon.webp' width = "150" height = "150" alt = "Pigeons" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Pigeons/" class = "body">Pigeons (<%=PigeonsBreeds %> Breeds)</a><br />
            Pigeons are raised as livestock for their meat, known as "squab, and are considered a delicacy in some parts of the world.<br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Quails/" class = "body"><img src = '/images/Quail.webp' width = "150" height = "150" alt = "Quails" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Quails/" class = "body">Quails (<%=QuailsBreeds %> Breeds)</a><br />
            Quails are small game birds that are prized for their delicate, rich, and gamey flavor, as well as their tender, moist meat.<br /><br />
        </div>
       </div>


      <div class = "row">
         <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Rabbits/" class = "body"><img src = '/breedsoflivestock/Rabitts.webp' width = "150" height = "150" alt = "Breeds of Rabbits" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Rabbits" class = "body">Rabbits (<%=RabbitBreeds %> Breeds)</a><br />
            Rabbits are generally small, cute animals that are kept as pets, for their fur, and for their meat. <br /><br />
        </div>
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Sheep/" class = "body"><img src = '/images/Sheepbreeds.webp' width = "150" height = "150"" alt = "Breeds of Sheep" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Sheep/" class = "body">Sheep (<%=SheepBreeds %> Breeds)</a><br />
            Sheep are raised for their wool, which is used for clothing, blankets, and other textiles, and for their meat, which is known as lamb. <br /><br />
        </div>
      </div>


<div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
        <a href = "/Members/LivestockDB/Snails/" class = "body"><img src = '/images/Snail.webp' width = "150" height = "150"  alt = "Pigeons" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Snails/" class = "body">Snails (<%=SnailsBreeds %> Breeds)</a><br />
            Snails have been eaten for over a millenia throughout history and are consumed as a delicacy in various dishes in many cultures.<br /><br />
        </div>

        <div class = "col-2 body" align = right style="Max-width:160px">
               <a href = "/Members/LivestockDB/Turkeys/" class = "body"><img src = '/images/Turkey.webp' width = "150" height = "150" alt = "Breeds of Turkey" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Turkeys/" class = "body">Turkeys (<%=TurkeyBreeds %> Breeds)</a><br />
            Turkeys are large, ground-dwelling birds that are raised for their meat, which is a staple of many traditional holiday meals, such as Thanksgiving in the United States.<br /><br />
        </div>
     </div>

<div class = "row">
        <div class = "col-2 body" align = right style="Max-width:160px">
          <a href = "/Members/LivestockDB/Yaks/" class = "body"><img src = '/images/Yak.webp' width = "150" height = "150" alt = "Breeds of Yak" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Members/LivestockDB/Yaks/" class = "body">Yaks (<%=YakBreeds %> Breeds) </a><br />
            Yaks are large, hardy animals that are well-adapted to life in the high, cold mountains of Central Asia, where they are native. <br /><br />
       </div>

     <div class = "col-2 body" align = right style="Max-width:160px">
         
        </div>
        <div class = "col-4 body" align = left>
             <br /><br />
       </div>


     </div>
</div>

<% ' XS and SM navigation  %>
    <div class="container-fluid d-lg-none">
  <div class = "row">
        <div class = "col body" align = left>
        <img src ="/images/LOTWHeader.webp" width = 100% alt = "Livestock Breeds" />
<br /> <br />There are thousands of breeds of livestock, we have documented <b><%=TotalBreeds %> Breeds</b> so far. We have the mission to list them all here.<br /><br />
We are consistently adding more information and photos to the list, and we are always finding more breeds. If you would like to help out with photos, descriptions, or correcting errors please <a href = "ContactUs.asp" class = body>Contact Us</a> and let us know' the more people we have helping, the more complete the information.
<h2><div align = "left">Breeds of Livestock</div></h2>
        </div>
    </div>

      <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Members/LivestockDB/Alpacas?" class = "body"><img src = '/images/Alligator.webp' width = "150" alt = "Alligator" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Alpacas/" class = "body">Alligators (1 Breed)</a><br />
            Alligators are a relative to crocodiles and are native only to North America. They are raised for their meat and skin.<br /><br />
        </div>
   </div>


    <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Members/LivestockDB/Alpacas?" class = "body"><img src = '/images/Alpaca.webp' width = "150" alt = "Alpaca" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Alpacas/" class = "body">Alpacas (2 Breeds)</a><br />
            Alpacas are domesticated South American camelids. They are known for their soft, warm, and luxurious fiber which is used for making clothing and other textiles. <br /><br />
        </div>
   </div>
     <div class = "row">

        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/HoneyBees/" class = "body"><img src = '/breedsoflivestock/HoneyBees.webp' width = "150" alt = "Breeds of Honey Bees" /></a>
        </div>
        <div class = "col-8 body" align = left>
             <a href ="/Members/LivestockDB/HoneyBees/" class = "body">Bees, Honey (<%=BeeBreeds %> Breeds)</a><br />
        Honey bees are well known for their ability to produce honey and they are important to humans for their role in agriculture and for the production of honey, beeswax, and other products.<br /><br />
        </div>
     </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Members/LivestockDB/Bison/" class = "body"><img src = '/images/Bison.webp' width = "150" alt = "Bison" /></a><br />
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Bison/" class = "body">Bison (<%=BisonBreeds %> Breeds)</a><br />
            Bison are large, grazing mammals native to North America. Bison have a shaggy brown coat, a large head, and a hump of muscle over their shoulders.<br /><br />
        </div>
     </div>

          <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Members/LivestockDB/Bison/" class = "body"><img src = '/images/Buffalo.webp' width = "150" alt = "Buffalo" /></a><br />
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Buffalo/" class = "body">Buffalo (<%=BuffaloBreeds %> Breeds)</a><br />
             Buffalo are highly valued for their meat, hides, and dung, which is used as fuel and fertilizer.<br /><br />
        </div>
     </div>



     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Members/LivestockDB/Camels/" class = "body"><img src = '/images/Camels.webp' width = "150" alt = "Camels" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Camels/" class = "body">Camels (3 Breeds)</a><br />
Camels are domesticated mammals that are raised for transportation, milk, meat, and hides.

<br /><br />
        </div>
     </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Members/LivestockDB/Cattle/" class = "body"><img src = '/images/Cattle.webp' width = "150" alt = "Cows" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Cattle/" class = "body">Cattle (<%=CattleBreeds %> Breeds)</a><br />
Cattle are raised for their meat, milk, and hides, and as draft animals for farming.<br /><br />
        </div>
           </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
            <a href = "/Members/LivestockDB/Chickens/" class = "body"><img src = '/images/Chicken.webp' width = "150" alt = "Chickens" /></a>

        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Chickens/" class = "body">Chickens (<%=ChickenBreeds %> Breeds)</a><br />

            Chickens are domesticated birds that are raised for their meat and eggs, and are one of the most commonly kept poultry species in the world. <br /><br />
         </div>
     </div>


    <div class = "row">
        <div class = "col-4 body" align = left>
            <a href = "/Members/LivestockDB/Deer/" class = "body"><img src = '/images/Deer.webp' width = "150" alt = "Deer" /></a>

        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Deer/" class = "body">Deer (<%=DeerBreeds %> Breeds)</a><br />
            Deer are raised for their meat, antlers, and hides.<br /><br />
         </div>
     </div>


     <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Members/LivestockDB/Donkeys/" class = "body"><img src = '/images/Donkeys.webp' width = "150" alt = "Donkey" /></a>

        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Donkeys/" class = "body">Donkeys (<%=DonkeyBreeds %> Breeds)</a><br />
           Donkeys are smaller and stockier than horses, with long ears, short manes, and a distinctive braying call.<br /><br />
        </div>
     </div>

     <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Members/LivestockDB/Dogs/" class = "body"><img src = '/images/Dogs.webp' width = "150" alt = "Donkey" /></a>

        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Dogs/" class = "body">Dogs, Working (<%=DogBreeds %> Breeds)</a><br />
           Working dogs are intelligent and dedicated partners.<br /><br />
        </div>
     </div>



      <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Members/LivestockDB/Ducks/" class = "body"><img src = '/images/Duck.webp' width = "150" alt = "Ducks" /></a>
           
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Ducks/" class = "body">Ducks (<%=DucksBreeds %> Breeds)</a><br />
           Ducks are found all over the world, in both freshwater and saltwater habitats. And Duck meat is one of the most popular poultry meats worldwide.<br /><br />
        </div>
     </div>

      <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Members/LivestockDB/Emus/" class = "body"><img src = '/images/Emu.webp' width = "150" alt = "Emus" /></a>
           
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Emus/" class = "body">Emus (<%=EmuBreeds %> Breed)</a><br />
           Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil<br /><br />
        </div>
     </div>

           <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Members/LivestockDB/Geese/" class = "body"><img src = '/images/Geese.webp' width = "150" alt = "Geese" /></a>
           
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Geese/" class = "body">Geese (<%=GeeseBreeds %> Breeds)</a><br />
          Geese are raised as livestock for their meat, eggs, and down feathers.<br /><br />
        </div>
     </div>




     <div class = "row">
           <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Goats/Default.asp" class = "body"><img src = '/breedsoflivestock/Goats.webp' width = "150" alt = "Breeds of Goats" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Goats/" class = "body">Goats (<%=GoatBreeds %> Breeds)</a><br />
        Goats are known for their ability to thrive in a variety of environments, from mountains to deserts, and are raised for their meat, milk, and hides. <br /><br />
        </div>
      </div>


     <div class = "row">
           <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/GuineaFowl/Default.asp" class = "body"><img src = '/images/GuineaFowl.webp' width = "150" alt = "Guinea Fowl" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/GuineaFowl/" class = "body">Guinea Fowl (<%=GuineaFowlBreeds %> Breeds)</a><br />
        Guinea fowl are prized for their delicious meat and flavorful eggs. <br /><br />
        </div>
      </div>




       <div class = "row">
        <div class = "col-4 body" align = left>
            <a href = "/Members/LivestockDB/Horses/" class = "body"><img src = '/images/cowboy2.webp' width = "150" alt = "Breeds of Horses" /></a>
        </div>
        <div class = "col-8 body" align = left>
             <a href ="/Members/LivestockDB/Horses/" class = "body">Horses (<%=HorseBreeds %> Breeds)</a><br />
             Horses are large, powerful animals that are known for their speed, grace, and beauty.<br /><br />
        </div>
     </div>

          <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Llamas/" class = "body"><img src = '/images/Llama2.webp' width = "150" alt = "Llamas" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Llamas/" class = "body">Llamas (1 Breed)</a><br />
            Llamas are a South American camelid that has been widely used as a pack and meat animal by South American cultures for thousands of years.<br /><br />
        </div>
       </div>

    <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/MuskOx/" class = "body"><img src = '/images/MuskOx.webp' width = "150" alt = "MuskOx" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/MuskOx/" class = "body">Musk Ox (<%=MuskOxBreeds %> Breed)</a><br />
            The musk ox is a large, Arctic-dwelling mammal that is known for its shaggy coat and distinctive curved horns. <br /><br />
        </div>
       </div>

      <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Ostriches/" class = "body"><img src = '/images/Ostrich.webp' width = "150" alt = "Ostriches" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Ostriches/" class = "body">Ostriches (<%=OstrichBreeds %> Breed)</a><br />
            Ostriches are the largest bird in the world and are native to the savannas and deserts of Africa. They are raised for their meat, leather, feathers, and eggs. <br /><br />
        </div>
       </div>

     <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Pheasants/" class = "body"><img src = '/images/Pheasant.webp' width = "150" alt = "Pheasants" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Pheasants/" class = "body">Pheasants (<%=PheasantsBreeds %> Breeds)</a><br />
            Pheasants are a group of birds native to Asia and Europe, and are widely kept for hunting and as ornamental birds.<br /><br />
        </div>
       </div>



     <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Pigs/" class = "body"><img src = '/breedsoflivestock/Pigs.webp' width = "150" alt = "Breeds of Pigs" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Pigs/" class = "body">Pigs (<%=PigBreeds %> Breeds)</a><br />
            Pig are raised for their meat and are one of the most commonly farmed animals in the world.<br /><br />
        </div>
       </div>


             <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Pigeons/" class = "body"><img src = '/images/Pigeon.webp' width = "150" alt = "Pigeons" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Pigeons/" class = "body">Pigeons (<%=PigeonsBreeds %> Breeds)</a><br />
            Pigeons are raised as livestock for their meat, known as "squab, and are considered a delicacy in some parts of the world.<br /><br />
        </div>
       </div>



      <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Quails/" class = "body"><img src = '/images/Quail.webp' width = "150" alt = "Quails" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Quails/" class = "body">Quails (<%=QuailsBreeds %> Breeds)</a><br />
            Quails are small game birds that are prized for their delicate, rich, and gamey flavor, as well as their tender, moist meat.<br /><br />
        </div>
       </div>




       <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Rabbits/" class = "body"><img src = '/breedsoflivestock/Rabitts.webp' width = "150" alt = "Breeds of Rabbits" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Rabbits/" class = "body">Rabbits (<%=RabbitBreeds %> Breeds)</a><br />
            Rabbits are generally small, cute animals that are kept as pets, for their fur, and for their meat. <br /><br />
        </div>
      </div>

       <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Snails/" class = "body"><img src = '/images/Snail.webp' width = "150" alt = "Pigeons" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Snails/" class = "body">Snails (<%=SnailsBreeds %> Breeds)</a><br />
            Snails have been eaten for over a millenia throughout history and are consumed as a delicacy in various dishes in many cultures.<br /><br />
        </div>
       </div>



     <div class = "row">

         <div class = "col-4 body" align = left>
        <a href = "/Members/LivestockDB/Sheep/" class = "body"><img src = '/images/Sheepbreeds.webp' width = "150" alt = "Breeds of Sheep" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Sheep/" class = "body">Sheep (<%=SheepBreeds %> Breeds)</a><br />
            Sheep are raised for their wool, which is used for clothing, blankets, and other textiles, and for their meat, which is known as lamb. <br /><br />
        </div>
    </div>
    <div class = "row">
        <div class = "col-4 body" align = left>
               <a href = "/Members/LivestockDB/Turkeys/" class = "body"><img src = '/images/Turkey.webp' width = "150" alt = "Breeds of Turkey" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Turkeys/" class = "body">Turkeys (<%=TurkeyBreeds %> Breeds)</a><br />
            Turkeys are large, ground-dwelling birds that are raised for their meat, which is a staple of many traditional holiday meals, such as Thanksgiving in the United States.<br /><br />
        </div>
           </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Members/LivestockDB/Yaks/" class = "body"><img src = '/images/Yak.webp' width = "150" alt = "Breeds of Yak" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Members/LivestockDB/Yaks/" class = "body">Yaks (<%=YakBreeds %> Breeds) </a><br />
            Yaks are large, hardy animals that are well-adapted to life in the high, cold mountains of Central Asia, where they are native. <br /><br />
       </div>
     </div>
</div>



<% showCharlie = True %>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body></html>