<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %> | Breeds of Livestock</title>
<meta name="title" content="<%=WebSiteName %> | Breeds of Livestock"/> 
<meta name="description" content="Breed descriptions."/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<% Set rs = Server.CreateObject("ADODB.Recordset")
TotalBreeds = 0
 OtherBreeds = 5

 TotalBreeds = TotalBreeds + BisonBreeds

sql = "select count(*) as BuffaloBreeds from SpeciesBreedLookupTable where SpeciesID=34"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 BuffaloBreeds = rs("BuffaloBreeds")
 TotalBreeds = TotalBreeds + BuffaloBreeds
end if
rs.close


 EmuBreeds = 1
 TotalBreeds = TotalBreeds + EmuBreeds
 LlamaBreeds = 1
 TotalBreeds = TotalBreeds + LlamaBreeds
 MuskOxBreeds = 1
 TotalBreeds = TotalBreeds + MuskOxBreeds
 OstrichBreeds = 1
 TotalBreeds = TotalBreeds + OstrichBreeds

sql = "select count(*) as  GeeseBreeds from SpeciesBreedLookupTable where SpeciesID=22"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 GeeseBreeds = rs("GeeseBreeds")
 TotalBreeds = TotalBreeds + DeerBreeds
end if
rs.close


 sql = "select count(*) as RabbitBreeds from SpeciesBreedLookupTable where SpeciesID=11"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 RabbitBreeds = rs("RabbitBreeds")
 TotalBreeds = TotalBreeds + RabbitBreeds
end if
rs.close

 sql = "select count(*) as DeerBreeds from SpeciesBreedLookupTable where SpeciesID=9"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 DeerBreeds = rs("DeerBreeds")
 TotalBreeds = TotalBreeds + DeerBreeds
end if
rs.close

sql = "select count(*) as SnailsBreeds from SpeciesBreedLookupTable where SpeciesID=33"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 SnailsBreeds = rs("SnailsBreeds")
 TotalBreeds = TotalBreeds + SnailsBreeds
end if
rs.close


sql = "select count(*) as QuailsBreeds from SpeciesBreedLookupTable where SpeciesID=31"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 QuailsBreeds = rs("QuailsBreeds")
 TotalBreeds = TotalBreeds + QuailsBreeds
end if
rs.close

sql = "select count(*) as PigeonsBreeds from SpeciesBreedLookupTable where SpeciesID=30"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 PigeonsBreeds = rs("PigeonsBreeds")
 TotalBreeds = TotalBreeds + PigeonsBreeds
end if
rs.close

sql = "select count(*) as PigBreeds from SpeciesBreedLookupTable where SpeciesID=12"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 PigBreeds = rs("PigBreeds")
 TotalBreeds = TotalBreeds + PigBreeds
end if
rs.close


sql = "select count(*) as PheasantsBreeds from SpeciesBreedLookupTable where SpeciesID=29"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 PheasantsBreeds = rs("PheasantsBreeds")
 TotalBreeds = TotalBreeds + PheasantsBreeds
end if
rs.close


sql = "select count(*) as GuineaFowlBreeds from SpeciesBreedLookupTable where SpeciesID=26"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 GuineaFowlBreeds = rs("GuineaFowlBreeds")
 TotalBreeds = TotalBreeds + GuineaFowlBreeds
end if
rs.close



sql = "select count(*) as BisonBreeds from SpeciesBreedLookupTable where SpeciesID=21"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 BisonBreeds = rs("BisonBreeds")
 TotalBreeds = TotalBreeds + BisonBreeds
end if
rs.close
sql = "select count(*) as CattleBreeds from SpeciesBreedLookupTable where SpeciesID=8"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 CattleBreeds = rs("CattleBreeds")
  TotalBreeds = TotalBreeds + CattleBreeds
end if
rs.close
sql = "select count(*) as ChickenBreeds from SpeciesBreedLookupTable where SpeciesID=8"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 ChickenBreeds = rs("ChickenBreeds")
  TotalBreeds = TotalBreeds + ChickenBreeds
end if
rs.close
sql = "select count(*) as DogBreeds from SpeciesBreedLookupTable where SpeciesID=3"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 DogBreeds = rs("DogBreeds")
   TotalBreeds = TotalBreeds + DogBreeds
end if
rs.close
sql = "select count(*) as HorseBreeds from SpeciesBreedLookupTable where SpeciesID=5"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 HorseBreeds = rs("HorseBreeds")
    TotalBreeds = TotalBreeds + HorseBreeds
end if
rs.close
sql = "select count(*) as GoatBreeds from SpeciesBreedLookupTable where SpeciesID=6"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 GoatBreeds = rs("GoatBreeds")
     TotalBreeds = TotalBreeds + GoatBreeds
end if
rs.close
sql = "select count(*) as SheepBreeds from SpeciesBreedLookupTable where SpeciesID=10"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 SheepBreeds = rs("SheepBreeds")
 TotalBreeds = TotalBreeds + SheepBreeds
end if
rs.close
sql = "select count(*) as PigsBreeds from SpeciesBreedLookupTable where SpeciesID=12"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 PigsBreeds = rs("PigsBreeds")
 TotalBreeds = TotalBreeds + PigsBreeds
end if
rs.close
sql = "select count(*) as TurkeyBreeds from SpeciesBreedLookupTable where SpeciesID=14"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 TurkeyBreeds = rs("TurkeyBreeds")
 TotalBreeds = TotalBreeds + TurkeyBreeds
end if
rs.close
sql = "select count(*) as DucksBreeds from SpeciesBreedLookupTable where SpeciesID=15"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 DucksBreeds = rs("DucksBreeds")
 TotalBreeds = TotalBreeds + DucksBreeds
end if
rs.close
sql = "select count(*) as YakBreeds from SpeciesBreedLookupTable where SpeciesID=17"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 YakBreeds = rs("YakBreeds")
  TotalBreeds = TotalBreeds + YakBreeds
end if
rs.close
sql = "select count(*) as BeeBreeds from SpeciesBreedLookupTable where SpeciesID=23"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 BeeBreeds = rs("BeeBreeds")
 TotalBreeds = TotalBreeds + BeeBreeds
end if
rs.close
sql = "select count(*) as DonkeyBreeds from SpeciesBreedLookupTable where SpeciesID=7"
rs.Open sql, conn, 3, 3
if not rs.eof then 
 DonkeyBreeds = rs("DonkeyBreeds")
 TotalBreeds = TotalBreeds + DonkeyBreeds
end if
rs.close

%>


</head>
<body >


<% homepage = true %>



<!--#Include virtual="/Header.asp"-->



<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <br /><h1>Online Livestock Database</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>


  <% ' lg+ navigation  %>
    <div class="container-fluid d-none d-lg-block" align = "center" style="max-width: 1000px; min-height: 67px; ">
    <div class = "row">
        <div class = "col body" align = left>
        <img src ="/images/LOTWHeader.jpg" width = 100% alt = "Livestock Breeds" />
<br /> <br />There are thousands of breeds of livestock, we have documented <b><%=TotalBreeds %> Breeds</b> so far. We have the mission to list them all here.<br /><br />
We are consistently adding more information and photos to the list, and we are always finding more breeds. If you would like to help out with photos, descriptions, or correcting errors please <a href = "ContactUs.asp" class = body>Contact Us</a> and let us know' the more people we have helping, the more complete the information.
<h2><div align = "left">Breeds of Livestock</div></h2>
        </div>
    </div>

     <div class = "row">
        <div class = "col-2 body" align = left>
          <a href = "/Alpacas/" class = "body"><img src = '/images/Alpaca.jpg' width = "150" height = "150" alt = "Alpaca" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Alpacas/" class = "body">Alpacas (2 Breeds)</a><br />
            Alpacas are domesticated South American camelids. They are known for their soft, warm, and luxurious fiber which is used for making clothing and other textiles. <br /><br />
        </div>
   <div class = "col-2 body" align = left>
        <a href = "/HoneyBees/" class = "body"><img src = '/breedsoflivestock/HoneyBees.jpg' width = "150" height = "150" alt = "Breeds of Honey Bees" /></a>
        </div>
        <div class = "col-4 body" align = left>
             <a href ="/HoneyBees/" class = "body">Bees, Honey (<%=BeeBreeds %> Breeds)</a><br />
        Honey bees are well known for their ability to produce honey and they are important to humans for their role in agriculture and for the production of honey, beeswax, and other products.<br /><br />
        </div>
   </div>


     <div class = "row">
     
        <div class = "col-2 body" align = left>
          <a href = "/Bison/" class = "body"><img src = '/images/Bison.jpg' width = "150" height = "150" alt = "Bison" /></a><br />
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Bison/" class = "body">Bison (<%=BisonBreeds %> Breeds)</a><br />
            Bison are large, grazing mammals native to North America. Bison have a shaggy brown coat, a large head, and a hump of muscle over their shoulders.<br /><br />
        </div>
        <div class = "col-2 body" align = left>
          <a href = "/Bison/" class = "body"><img src = '/images/Buffalo.jpg' width = "150" height = "150" alt = "Buffalo" /></a><br />
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Buffalo/" class = "body">Buffalo (<%=BuffaloBreeds %> Breeds)</a><br />
             Buffalo are highly valued for their meat, hides, and dung, which is used as fuel and fertilizer.<br /><br />
        </div>
     </div>



      <div class = "row">
          <div class = "col-2 body" align = left>
          <a href = "/Camels/" class = "body"><img src = '/images/Camels.jpg' width = "150" height = "150" alt = "Camels" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Camels/" class = "body">Camels (3 Breeds)</a><br />
            Camels are domesticated mammals that are raised for transportation, milk, meat, and hides.
            <br /><br />
        </div>
        <div class = "col-2 body" align = left>
          <a href = "/Cattle/" class = "body"><img src = '/images/Cattle.jpg' width = "150" height = "150" alt = "Cows" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Cattle/" class = "body">Cattle (<%=CattleBreeds %> Breeds)</a><br />
Cattle are raised for their meat, milk, and hides, and as draft animals for farming.<br /><br />
        </div>
     </div>



     <div class = "row">
        <div class = "col-2 body" align = left>
            <a href = "/Chickens/" class = "body"><img src = '/images/Chicken.jpg' width = "150" height = "150" alt = "Chickens" /></a>

        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Chickens/" class = "body">Chickens (<%=ChickenBreeds %> Breeds)</a><br />
            Chickens are domesticated birds that are raised for their meat and eggs, and are one of the most commonly kept poultry species in the world. <br /><br />
         </div>
        <div class = "col-2 body" align = left>
          <a href = "/Crocodiles/" class = "body"><img src = '/images/Alligator.jpg' width = "150" height = "150" alt = "Alligator" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Crocodiles/" class = "body">Crocodiles & Alligators (7 Breeds)</a><br />
            Crocodiles and alligators are large, semi-aquatic reptiles known for their powerful jaws and ancient lineage.<br /><br />
        </div>
     </div>






    <div class = "row">
        <div class = "col-2 body" align = left>
            <a href = "/Deer/" class = "body"><img src = '/images/Deer.jpg' width = "150" height = "150" alt = "Deer" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Deer/" class = "body">Deer (<%=DeerBreeds %> Breeds)</a><br />
            Deer are raised for their meat, antlers, and hides.<br /><br />
         </div>
        <div class = "col-2 body" align = left>
           <a href = "/Donkeys/" class = "body"><img src = '/images/Donkeys.jpg' width = "150" height = "150" alt = "Donkey" /></a>

        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Donkeys/" class = "body">Donkeys (<%=DonkeyBreeds %> Breeds)</a><br />
           Donkeys are smaller and stockier than horses, with long ears, short manes, and a distinctive braying call.<br /><br />
        </div>
     </div>




      <div class = "row">
        <div class = "col-2 body" align = left>
           <a href = "/Ducks/" class = "body"><img src = '/images/Duck.jpg' width = "150" height = "150" alt = "Ducks" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Ducks/" class = "body">Ducks (<%=DucksBreeds %> Breeds)</a><br />
           Ducks are found all over the world, in both freshwater and saltwater habitats. And Duck meat is one of the most popular poultry meats worldwide.<br /><br />
        </div>
        <div class = "col-2 body" align = left>
           <a href = "/Emus/" class = "body"><img src = '/images/Emu.jpg' width = "150" height = "150" alt = "Emus" /></a>
           
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Emus/" class = "body">Emus (<%=EmuBreeds %> Breed)</a><br />
           Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil<br /><br />
        </div>
     </div>



     <div class = "row">
        <div class = "col-2 body" align = left>
           <a href = "/Geese/" class = "body"><img src = '/images/Geese.jpg' width = "150" height = "150" alt = "Geese" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Geese/" class = "body">Geese (<%=GeeseBreeds %> Breeds)</a><br />
          Geese are raised as livestock for their meat, eggs, and down feathers.<br /><br />
        </div>
        <div class = "col-2 body" align = left>
        <a href = "/Goats/Default.asp?SpeciesID=2" class = "body"><img src = '/breedsoflivestock/Goats.jpg' width = "150" height = "150" alt = "Breeds of Goats" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Goats/" class = "body">Goats (<%=GoatBreeds %> Breeds)</a><br />
        Goats are known for their ability to thrive in a variety of environments, from mountains to deserts, and are raised for their meat, milk, and hides. <br /><br />
        </div>
      </div>


     <div class = "row">
           <div class = "col-2 body" align = left>
        <a href = "/GuineaFowl/Default.asp?SpeciesID=2" class = "body"><img src = '/images/GuineaFowl.jpg' width = "150" height = "150" alt = "Guinea Fowl" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/GuineaFowl/" class = "body">Guinea Fowl (<%=GuineaFowlBreeds %> Breeds)</a><br />
        Guinea fowl are prized for their delicious meat and flavorful eggs. <br /><br />
        </div>
        <div class = "col-2 body" align = left>
            <a href = "/Horses/" class = "body"><img src = '/images/cowboy2.jpg' width = "150" height = "150" alt = "Breeds of Horses" /></a>
        </div>
        <div class = "col-4 body" align = left>
             <a href ="/Horses/" class = "body">Horses (<%=HorseBreeds %> Breeds)</a><br />
             Horses are large, powerful animals that are known for their speed, grace, and beauty.<br /><br />
        </div>
     </div>

    <div class = "row">
        <div class = "col-2 body" align = left>
        <a href = "/Llamas/" class = "body"><img src = '/images/Llama2.jpg' width = "150" height = "150" alt = "Llamas" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Llamas/" class = "body">Llamas (1 Breed)</a><br />
            Llamas are a South American camelid that has been widely used as a pack and meat animal by South American cultures for thousands of years.<br /><br />
        </div>
        <div class = "col-2 body" align = left>
        <a href = "/MuskOx/" class = "body"><img src = '/images/MuskOx.jpg' width = "150" height = "150" alt = "MuskOx" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/MuskOx/" class = "body">Musk Ox (<%=MuskOxBreeds %> Breed)</a><br />
            The musk ox is a large, Arctic-dwelling mammal that is known for its shaggy coat and distinctive curved horns. <br /><br />
        </div>
       </div>



      <div class = "row">
        <div class = "col-2 body" align = left>
        <a href = "/Ostriches/" class = "body"><img src = '/images/Ostrich.jpg' width = "150" height = "150" alt = "Ostriches" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Ostriches/" class = "body">Ostriches (<%=OstrichBreeds %> Breed)</a><br />
            Ostriches are the largest bird in the world and are native to the savannas and deserts of Africa. They are raised for their meat, leather, feathers, and eggs. <br /><br />
        </div>
        <div class = "col-2 body" align = left>
        <a href = "/Pheasants/" class = "body"><img src = '/images/Pheasant.jpg' width = "150" height = "150" alt = "Pheasants" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Pheasants/" class = "body">Pheasants (<%=PheasantsBreeds %> Breeds)</a><br />
            Pheasants are a group of birds native to Asia and Europe, and are widely kept for hunting and as ornamental birds.<br /><br />
        </div>
       </div>



     <div class = "row">
        <div class = "col-2 body" align = left>
        <a href = "/Pigs/" class = "body"><img src = '/breedsoflivestock/Pigs.jpg' width = "150" height = "150" alt = "Breeds of Pigs" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Pigs/" class = "body">Pigs (<%=PigBreeds %> Breeds)</a><br />
            Pig are raised for their meat and are one of the most commonly farmed animals in the world.<br /><br />
        </div>
        <div class = "col-2 body" align = left>
        <a href = "/Pigeons/" class = "body"><img src = '/images/Pigeon.jpg' width = "150" height = "150" alt = "Pigeons" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Pigeons/" class = "body">Pigeons (<%=PigeonsBreeds %> Breeds)</a><br />
            Pigeons are raised as livestock for their meat, known as "squab, and are considered a delicacy in some parts of the world.<br /><br />
        </div>
       </div>



      <div class = "row">
        <div class = "col-2 body" align = left>
        <a href = "/Quails/" class = "body"><img src = '/images/Quail.jpg' width = "150" height = "150" alt = "Quails" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Quails/" class = "body">Quails (<%=QuailsBreeds %> Breeds)</a><br />
            Quails are small game birds that are prized for their delicate, rich, and gamey flavor, as well as their tender, moist meat.<br /><br />
        </div>
         <div class = "col-2 body" align = left>
        <a href = "/Rabbits/" class = "body"><img src = '/breedsoflivestock/Rabitts.jpg' width = "150" height = "150" alt = "Breeds of Rabbits" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Rabbits" class = "body">Rabbits (<%=RabbitBreeds %> Breeds)</a><br />
            Rabbits are generally small, cute animals that are kept as pets, for their fur, and for their meat. <br /><br />
        </div>
      </div>



       <div class = "row">
        <div class = "col-2 body" align = left>
        <a href = "/Sheep/" class = "body"><img src = '/images/Sheepbreeds.jpg' width = "150" height = "150"" alt = "Breeds of Sheep" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Sheep/" class = "body">Sheep (<%=SheepBreeds %> Breeds)</a><br />
            Sheep are raised for their wool, which is used for clothing, blankets, and other textiles, and for their meat, which is known as lamb. <br /><br />
        </div>


        <div class = "col-2 body" align = left>
        <a href = "/Snails/" class = "body"><img src = '/images/Snail.jpg' width = "150" height = "150"  alt = "Pigeons" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Snails/" class = "body">Snails (<%=SnailsBreeds %> Breeds)</a><br />
            Snails have been eaten for over a millenia throughout history and are consumed as a delicacy in various dishes in many cultures.<br /><br />
        </div>
    </div>



    <div class = "row">
        <div class = "col-2 body" align = left>
               <a href = "/Turkeys/" class = "body"><img src = '/images/Turkey.jpg' width = "150" height = "150" alt = "Breeds of Turkey" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Turkeys/" class = "body">Turkeys (<%=TurkeyBreeds %> Breeds)</a><br />
            Turkeys are large, ground-dwelling birds that are raised for their meat, which is a staple of many traditional holiday meals, such as Thanksgiving in the United States.<br /><br />
        </div>
        <div class = "col-2 body" align = left>
          <a href = "/Yaks/" class = "body"><img src = '/images/Yak.jpg' width = "150" height = "150" alt = "Breeds of Yak" /></a>
        </div>
        <div class = "col-4 body" align = left>
            <a href ="/Yaks/" class = "body">Yaks (<%=YakBreeds %> Breeds) </a><br />
            Yaks are large, hardy animals that are well-adapted to life in the high, cold mountains of Central Asia, where they are native. <br /><br />
       </div>
     </div>
</div>

<% ' XS and SM navigation  %>
    <div class="container-fluid d-lg-none">
  <div class = "row">
        <div class = "col body" align = left>
        <img src ="/images/LOTWHeader.jpg" width = 100% alt = "Livestock Breeds" />
<br /> <br />There are thousands of breeds of livestock, we have documented <b><%=TotalBreeds %> Breeds</b> so far. We have the mission to list them all here.<br /><br />
We are consistently adding more information and photos to the list, and we are always finding more breeds. If you would like to help out with photos, descriptions, or correcting errors please <a href = "ContactUs.asp" class = body>Contact Us</a> and let us know' the more people we have helping, the more complete the information.
<h2><div align = "left">Breeds of Livestock</div></h2>
        </div>
    </div>

      <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Alpacas?" class = "body"><img src = '/images/Alligator.jpg' width = "150" alt = "Alligator" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Alpacas/" class = "body">Alligators (1 Breed)</a><br />
            Alligators are a relative to crocodiles and are native only to North America. They are raised for their meat and skin.<br /><br />
        </div>
   </div>


    <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Alpacas?" class = "body"><img src = '/images/Alpaca.jpg' width = "150" alt = "Alpaca" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Alpacas/" class = "body">Alpacas (2 Breeds)</a><br />
            Alpacas are domesticated South American camelids. They are known for their soft, warm, and luxurious fiber which is used for making clothing and other textiles. <br /><br />
        </div>
   </div>
     <div class = "row">

        <div class = "col-4 body" align = left>
        <a href = "/HoneyBees/" class = "body"><img src = '/breedsoflivestock/HoneyBees.jpg' width = "150" alt = "Breeds of Honey Bees" /></a>
        </div>
        <div class = "col-8 body" align = left>
             <a href ="/HoneyBees/" class = "body">Bees, Honey (<%=BeeBreeds %> Breeds)</a><br />
        Honey bees are well known for their ability to produce honey and they are important to humans for their role in agriculture and for the production of honey, beeswax, and other products.<br /><br />
        </div>
     </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Bison/" class = "body"><img src = '/images/Bison.jpg' width = "150" alt = "Bison" /></a><br />
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Bison/" class = "body">Bison (<%=BisonBreeds %> Breeds)</a><br />
            Bison are large, grazing mammals native to North America. Bison have a shaggy brown coat, a large head, and a hump of muscle over their shoulders.<br /><br />
        </div>
     </div>

          <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Bison/" class = "body"><img src = '/images/Buffalo.jpg' width = "150" alt = "Buffalo" /></a><br />
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Buffalo/" class = "body">Buffalo (<%=BuffaloBreeds %> Breeds)</a><br />
             Buffalo are highly valued for their meat, hides, and dung, which is used as fuel and fertilizer.<br /><br />
        </div>
     </div>



     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Camels/" class = "body"><img src = '/images/Camels.jpg' width = "150" alt = "Camels" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Camels/" class = "body">Camels (3 Breeds)</a><br />
Camels are domesticated mammals that are raised for transportation, milk, meat, and hides.

<br /><br />
        </div>
     </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Cattle/" class = "body"><img src = '/images/Cattle.jpg' width = "150" alt = "Cows" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Cattle/" class = "body">Cattle (<%=CattleBreeds %> Breeds)</a><br />
Cattle are raised for their meat, milk, and hides, and as draft animals for farming.<br /><br />
        </div>
           </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
            <a href = "/Chickens/" class = "body"><img src = '/images/Chicken.jpg' width = "150" alt = "Chickens" /></a>

        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Chickens/" class = "body">Chickens (<%=ChickenBreeds %> Breeds)</a><br />

            Chickens are domesticated birds that are raised for their meat and eggs, and are one of the most commonly kept poultry species in the world. <br /><br />
         </div>
     </div>


    <div class = "row">
        <div class = "col-4 body" align = left>
            <a href = "/Deer/" class = "body"><img src = '/images/Deer.jpg' width = "150" alt = "Deer" /></a>

        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Deer/" class = "body">Deer (<%=DeerBreeds %> Breeds)</a><br />
            Deer are raised for their meat, antlers, and hides.<br /><br />
         </div>
     </div>


     <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Donkeys/" class = "body"><img src = '/images/Donkeys.jpg' width = "150" alt = "Donkey" /></a>

        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Donkeys/" class = "body">Donkeys (<%=DonkeyBreeds %> Breeds)</a><br />
           Donkeys are smaller and stockier than horses, with long ears, short manes, and a distinctive braying call.<br /><br />
        </div>
     </div>


      <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Ducks/" class = "body"><img src = '/images/Duck.jpg' width = "150" alt = "Ducks" /></a>
           
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Ducks/" class = "body">Ducks (<%=DucksBreeds %> Breeds)</a><br />
           Ducks are found all over the world, in both freshwater and saltwater habitats. And Duck meat is one of the most popular poultry meats worldwide.<br /><br />
        </div>
     </div>

      <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Emus/" class = "body"><img src = '/images/Emu.jpg' width = "150" alt = "Emus" /></a>
           
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Emus/" class = "body">Emus (<%=EmuBreeds %> Breed)</a><br />
           Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil<br /><br />
        </div>
     </div>

           <div class = "row">
        <div class = "col-4 body" align = left>
           <a href = "/Geese/" class = "body"><img src = '/images/Geese.jpg' width = "150" alt = "Geese" /></a>
           
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Geese/" class = "body">Geese (<%=GeeseBreeds %> Breeds)</a><br />
          Geese are raised as livestock for their meat, eggs, and down feathers.<br /><br />
        </div>
     </div>




     <div class = "row">
           <div class = "col-4 body" align = left>
        <a href = "/Goats/Default.asp" class = "body"><img src = '/breedsoflivestock/Goats.jpg' width = "150" alt = "Breeds of Goats" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Goats/" class = "body">Goats (<%=GoatBreeds %> Breeds)</a><br />
        Goats are known for their ability to thrive in a variety of environments, from mountains to deserts, and are raised for their meat, milk, and hides. <br /><br />
        </div>
      </div>


     <div class = "row">
           <div class = "col-4 body" align = left>
        <a href = "/GuineaFowl/Default.asp" class = "body"><img src = '/images/GuineaFowl.jpg' width = "150" alt = "Guinea Fowl" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/GuineaFowl/" class = "body">Guinea Fowl (<%=GuineaFowlBreeds %> Breeds)</a><br />
        Guinea fowl are prized for their delicious meat and flavorful eggs. <br /><br />
        </div>
      </div>




       <div class = "row">
        <div class = "col-4 body" align = left>
            <a href = "/Horses/" class = "body"><img src = '/images/cowboy2.jpg' width = "150" alt = "Breeds of Horses" /></a>
        </div>
        <div class = "col-8 body" align = left>
             <a href ="/Horses/" class = "body">Horses (<%=HorseBreeds %> Breeds)</a><br />
             Horses are large, powerful animals that are known for their speed, grace, and beauty.<br /><br />
        </div>
     </div>

          <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Llamas/" class = "body"><img src = '/images/Llama2.jpg' width = "150" alt = "Llamas" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Llamas/" class = "body">Llamas (1 Breed)</a><br />
            Llamas are a South American camelid that has been widely used as a pack and meat animal by South American cultures for thousands of years.<br /><br />
        </div>
       </div>

    <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/MuskOx/" class = "body"><img src = '/images/MuskOx.jpg' width = "150" alt = "MuskOx" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/MuskOx/" class = "body">Musk Ox (<%=MuskOxBreeds %> Breed)</a><br />
            The musk ox is a large, Arctic-dwelling mammal that is known for its shaggy coat and distinctive curved horns. <br /><br />
        </div>
       </div>

      <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Ostriches/" class = "body"><img src = '/images/Ostrich.jpg' width = "150" alt = "Ostriches" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Ostriches/" class = "body">Ostriches (<%=OstrichBreeds %> Breed)</a><br />
            Ostriches are the largest bird in the world and are native to the savannas and deserts of Africa. They are raised for their meat, leather, feathers, and eggs. <br /><br />
        </div>
       </div>

     <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Pheasants/" class = "body"><img src = '/images/Pheasant.jpg' width = "150" alt = "Pheasants" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Pheasants/" class = "body">Pheasants (<%=PheasantsBreeds %> Breeds)</a><br />
            Pheasants are a group of birds native to Asia and Europe, and are widely kept for hunting and as ornamental birds.<br /><br />
        </div>
       </div>



     <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Pigs/" class = "body"><img src = '/breedsoflivestock/Pigs.jpg' width = "150" alt = "Breeds of Pigs" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Pigs/" class = "body">Pigs (<%=PigBreeds %> Breeds)</a><br />
            Pig are raised for their meat and are one of the most commonly farmed animals in the world.<br /><br />
        </div>
       </div>


             <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Pigeons/" class = "body"><img src = '/images/Pigeon.jpg' width = "150" alt = "Pigeons" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Pigeons/" class = "body">Pigeons (<%=PigeonsBreeds %> Breeds)</a><br />
            Pigeons are raised as livestock for their meat, known as "squab, and are considered a delicacy in some parts of the world.<br /><br />
        </div>
       </div>



      <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Quails/" class = "body"><img src = '/images/Quail.jpg' width = "150" alt = "Quails" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Quails/" class = "body">Quails (<%=QuailsBreeds %> Breeds)</a><br />
            Quails are small game birds that are prized for their delicate, rich, and gamey flavor, as well as their tender, moist meat.<br /><br />
        </div>
       </div>




       <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Rabbits/" class = "body"><img src = '/breedsoflivestock/Rabitts.jpg' width = "150" alt = "Breeds of Rabbits" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Rabbits" class = "body">Rabbits (<%=RabbitBreeds %> Breeds)</a><br />
            Rabbits are generally small, cute animals that are kept as pets, for their fur, and for their meat. <br /><br />
        </div>
      </div>

       <div class = "row">
        <div class = "col-4 body" align = left>
        <a href = "/Snails/" class = "body"><img src = '/images/Snail.jpg' width = "150" alt = "Pigeons" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Snails/" class = "body">Snails (<%=SnailsBreeds %> Breeds)</a><br />
            Snails have been eaten for over a millenia throughout history and are consumed as a delicacy in various dishes in many cultures.<br /><br />
        </div>
       </div>



     <div class = "row">

         <div class = "col-4 body" align = left>
        <a href = "/Sheep/" class = "body"><img src = '/images/Sheepbreeds.jpg' width = "150" alt = "Breeds of Sheep" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Sheep/" class = "body">Sheep (<%=SheepBreeds %> Breeds)</a><br />
            Sheep are raised for their wool, which is used for clothing, blankets, and other textiles, and for their meat, which is known as lamb. <br /><br />
        </div>
    </div>
    <div class = "row">
        <div class = "col-4 body" align = left>
               <a href = "/Turkeys/" class = "body"><img src = '/images/Turkey.jpg' width = "150" alt = "Breeds of Turkey" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Turkeys/" class = "body">Turkeys (<%=TurkeyBreeds %> Breeds)</a><br />
            Turkeys are large, ground-dwelling birds that are raised for their meat, which is a staple of many traditional holiday meals, such as Thanksgiving in the United States.<br /><br />
        </div>
           </div>
     <div class = "row">
        <div class = "col-4 body" align = left>
          <a href = "/Yaks/" class = "body"><img src = '/images/Yak.jpg' width = "150" alt = "Breeds of Yak" /></a>
        </div>
        <div class = "col-8 body" align = left>
            <a href ="/Yaks/" class = "body">Yaks (<%=YakBreeds %> Breeds) </a><br />
            Yaks are large, hardy animals that are well-adapted to life in the high, cold mountains of Central Asia, where they are native. <br /><br />
       </div>
     </div>
</div>




<!--#Include virtual="/Footer.asp"-->
</body></html>