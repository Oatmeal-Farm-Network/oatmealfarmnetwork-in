<!DOCTYPE html>
<meta charset="utf-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<%
title= "All Cattle Breeds" 

Description="Find Breed information on Abigar, Abondance, Abyssinian Shorthorned Zebu, Aceh, Achham, Adamawa, Adaptaur, Afghan, African Boran, Africangus, Afrikaner, Agerolese, Ala Tau, Alambadi, Albanian, Albanian Dwarf, Alberes, Albese, Alderney, Alentejana, Aleutian wild, Aliad Dinka, Alistana-Sanabresa, Allmogekor, Alur, American, American Angus, American Beef Friesian, American Brown Swiss, American White Park, Amerifax, Amrit Mahal, Amsterdam Island, Anatolian Black, Andalusian Black, Andalusian Blond, Andalusian Grey, Angeln, Angoni, Angus, Ankina, Ankole-Watusi, Aosta, Apulian Podolian, Aracena, Arado, Argentine Crillo, Argentine Criollo, Argentine Friesian, Armorican, Arouquesa, Arsi, Asturian Mountain, Asturian Valley, Aubrac, Aulie-Atta, Aure et Saint-Girons, Australian Braford, Australian Brangus, Australian Charbray, Australian Friesian Sahiwal, Australian Lowline, Australian Milking Zebu, Australian Shorthorn, Austrian Simmental, Austrian Yellow, Avetonou, Avilena, Avilena-Black Iberian, Aweil Dinka, Ayrshire, Azaouak, Azebuado, Azerbaijan Zebu, Azores, Baherie, Bakosi, Balancer, Baoule, Barrosa, Barzona, Batangas, Bazadais, Beef Freisian, Beefalo, Beefmaker, Beefmaster, Belgian Blue, Belgian Red, Belgian Red Pied, Belgian White-and-red, Belmont Red, Belted Galloway, Bernese, Berrenda, Betizu, Bianca Val Padana, Blaarkop, Black Angus, Black Baldy, Black Hereford, Black Pied Dairy, Blanca Cacerena, Blanco Orejinegro BON, Blonde d'Aquitaine, Blue Albion, Blue Grey, Bohus Polled, Bonsmara, Boran, Braford, Brahman, Brahmousin, Brangus, Braunvieh, Brava, British Friesian, British White, Brown Swiss, Bue Lingo, Burlina, Busa, Butana and Kenana, Cabannina, Cachena, Caldelana, Calvana, Camargue, Campbell Island, Canadian Speckle Park, Canadienne, Canaria, Canchim, Caracu, Cardena andaluza, Carinthian Blondvieh, Carora, Charbray, Charolais, Chateaubriand, Chiangus, Chianina, Chillingham, Chinese black pied, Chinese Central Plains Yellow, Chinese Northern Yellow, Cinisara, Coloursided White Back, Commercial, Corriente, Costeno con Cuernos, Crioulo Lageano, Dajal, Danish Black-Pied, Danish Jersey, Danish Red, Deep Red, Devon, Dexter, Dhanni, Doayo, Doela, Dolafe, Droughtmaster, Dulong, Dutch Belted, Dutch Friesian, Dwarf Lulu, East Anatolian Red, Eastern Finn, Eastern Red Polled, Enderby Island, English Longhorn, Ennstal Mountain Pied, Estonian Holstein, Estonian Native, Estonian Red, Evolene, Finnish, Finnish Ayrshire, Finnish Holstein-Friesian, Fjall, Fleckvieh, Florida Cracker, French Simmental, Fribourg black and white, Friesian Red and White, Fulani Sudanese, Galician Blond, Galloway, Garfagnina, Garvonesa, Gascon, Gelbray, Gelbvieh, Georgian mountain, German Angus, German Black Pied, German Red Pied, Gir, Glan, Gloucester, Gobra, Greek Shorthorn, Greek Steppe, Grey alpine, Greyman, Groningen, Groningen White-Headed, Gudali, Guernsey, Guzerat, Halikar, Hariana, Harton del Valle, Harz Red mountain, Hays Converter, Heck, Hereford, Herens, Hhybridmaster, Highland, Hinterwald, Holando-Argentino, Holstein, Horro, Hungarian Grey, Iberian, Icelandic, Illawarra, Improved Red and White, Indo-Brazilian, Irish Moiled, Israeli Holstein, Israeli Red, Istoben, Jamaica Black, Jamaica Hope, Jamaica Red, Jarmelista, Jersey, Jutland, Kalmyk, Kangayam Cow, Kankrej, Karan Swiss, Kazakh Whiteheaded, Kerry, Kholomogory, Kostroma, Krishna Valley, Kurgan, Kuri, Lampurger, Latvian Blue, Latvian Brown,  Levantina, Limiana, Limousin, Limpurger, Lincoln Red, Lineback, Lithuanian Black-and-White, Lithuanian Light Grey, Lithuanian Red, Lithuanian White-backed, Lohani, Lourdais, Luing, Madagascar Zebu, Madura, Maine Anjou, Mandalong Special, Mantequera Leonesa, Maramure Brown, Marchigiana, Maremmana, Marinhoa, Maronesa, Masai, Mashona, Menorquina, Mertolenga, Meuse-Rhine-Issel, Milking Devon, Milking Shorthorn, Minhota, Miniature, Mirandesa, Mocanita, Modenese, Modicana, Monchina, Mongolian c, Montbeliard, Morucha, Murboden, Murnau-Werdenfels, Murray Grey, N'Dama, Negra Andaluza, Nelore, Nguni, Normande, Northern Finncattle, Northern Shorthorn, Norwegian Red, Ongole, Pajuna, Palmera, Pantaneiro, Parda Alpina, Parthenais, Pasiega, Pasturina, Pembroke, Philippine Native, Pie Rouge des Plaines, Piedmontese, Pineywoods, Pinzgauer, Pirenaica, Pisana, Podolica, Polish Black-and-White, Polish Red, Polled Hereford, Polled Shorthorn, Pontremolese, Ponwar, Preta, Punganur, Pustertal Pied, Qinchaun, Queensland Miniature Boran, Ramo Grande, Randall, Rathi, Ratische Grauvieh, Razzetta d'Oropa, Red Angus, Red Brangus, Red Fulani, Red Holstein, Red Poll, Red Polled Ostland, Red Sindhi, Reggiana, Reina, Rendena, Retinta, Riggit Galloway, Ringamala, Rohjan, Romagnola, Romanian Baltata, Romanian Steppe Gray, Romosinuano, Rossa Siciliana, Russian Black Pied, RX3, Sahiwal, Salers, Salorn, Sanga, Sanhe, Santa Cruz, Santa Gertrudis, Sarda, Sardo Bruna, Sardo-Modicana,  Savoiarda, Sayaguesa, Schwyz, Selembu, Senepol, Sheko, Shetland, Shorthorn, Siboney, Sided Tronder, Simbrah, Simford, Simmental, South Devon, Spanish Fighting Bull, Speckle Park, Square Meater, Sussex, Swedish Friesian, Swedish Mountain, Swedish Red, Swedish Red Poll, Swedish Red-and-White, Symons Type, Tabapua, Tarentaise, Tasmanian Grey, Telemark, Texas Longhorn, Texon, Tharparkar, Tswana, Tudanca, Tuli, Tulim, Turkish Grey Steppe, Tux, Tyrolese Grey, Ushuaia Wild, Vaca Toposa or Vaquilla, Valdostana Pezzata Rossa, Väne, Varzese, Vaynol, Vechoor cow, Vestland Fjord, Vianesa, Vorderwald, Vosges, Wagyu, Wangus, Welsh Black, Western Finncattle, Western Fjord, Western Red Polled, White Caceres, White Fulani, White Park, Whitebred Shorthorn, Xingjiang Brown, Yanbian, and Zubron."

 image = "https://www.Livestockoftheworld.com/Cattle/Cattleheader.jpg"  %>
<Title><%=Title %></Title>
<meta name="title" content="<%=Title %>" />

<meta name="description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>
<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="<%=Title %>"/>
<meta name="Author" content="Livestock Of The World"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />
<meta property="og:description" content="<%=Description %>" />


</HEAD>
<body >
<% LSHeader = True 
currentbreed="Cattle"%>
<!--#Include virtual="/Header.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
   <div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <br /><H1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "40"/>&nbsp;Cattle</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>


<% If not rs.State = adStateClosed Then
  rs.close
End If %>

<div class = "container">
  <div>
   <div class = "body">
     <center><img src = "Cattleheader.jpg" width = 100% alt = "About Cattle"/></center><br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "body" align = "left" valign = "top" height = 510>
<br />
The first cattle were domesticated at least 10,000 years ago, and they are raised as for meat (beef and veal), dairy animals for milk and other dairy products, and as draft animals (pulling carts, plows and the like). Also they are raised to produce leather and their manure is used for fertilizer. Cattle were the first livestock animal to have a fully mapped genome and there is an estimated 1.3 billion cattle in the world today.
<br> 
<br>
 Cattle raised for human consumption are called "beef cattle". Within the beef cattle industry in parts of the United States, the term "beef" (plural "beeves") is still used in its archaic sense to refer to an animal of either sex. Cows of certain breeds that are kept for the milk they give are called "dairy cows" or "milking cows". Most young male offspring of dairy cows are sold for veal, and may be referred to as veal calves.
 <br> 
 <form  name=Login method="post" action="AboutCattle.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE ABOUT CATTLE"  >
</form>
<br />

<a name="Breeds"></a>
<h2>Breeds of <%=Pagename %></h2>
There are the following breeds of <% = SpeciesNamePlural %>:
<br />

<% Letter = Request.Querystring("Letter")
If len(Letter)<1 then
Letter = "A"
end if
tempspeciesID= SpeciesID
%>
<a NAME="Breeds"></a>
<a href = "Default.asp?Letter=A#Breeds" class = Body>A</a>|
<a href = "Default.asp?Letter=B#Breeds" class = Body>B</a>|
<a href = "Default.asp?Letter=C#Breeds" class = Body>C</a>|
<a href = "Default.asp?Letter=D#Breeds" class = Body>D</a>|
<a href = "Default.asp?Letter=E#Breeds" class = Body>E</a>|
<a href = "Default.asp?Letter=F#Breeds" class = Body>F</a>|
<a href = "Default.asp?Letter=G#Breeds" class = Body>G</a>|
<a href = "Default.asp?Letter=H#Breeds" class = Body>H</a>|
<a href = "Default.asp?Letter=I#Breeds" class = Body>I</a>|
<a href = "Default.asp?Letter=J#Breeds" class = Body>J</a>|
<a href = "Default.asp?Letter=K#Breeds" class = Body>K</a>|
<a href = "Default.asp?Letter=L#Breeds" class = Body>L</a>|
<a href = "Default.asp?Letter=M#Breeds" class = Body>M</a>|
<a href = "Default.asp?Letter=N#Breeds" class = Body>N</a>|
<a href = "Default.asp?Letter=O#Breeds" class = Body>O</a>|
<a href = "Default.asp?Letter=P#Breeds" class = Body>P</a>|
<a href = "Default.asp?Letter=Q#Breeds" class = Body>Q</a>|
<a href = "Default.asp?Letter=R#Breeds" class = Body>R</a>|
<a href = "Default.asp?Letter=S#Breeds" class = Body>S</a>|
<a href = "Default.asp?Letter=T#Breeds" class = Body>T</a>|
<a href = "Default.asp?Letter=U#Breeds" class = Body>U</a>|
<a href = "Default.asp?Letter=V#Breeds" class = Body>V</a>|
<a href = "Default.asp?Letter=W#Breeds" class = Body>W</a>|
<a href = "Default.asp?Letter=X#Breeds" class = Body>X</a>|
<a href = "Default.asp?Letter=Y#Breeds" class = Body>Y</a>|
<a href = "Default.asp?Letter=Z#Breeds" class = Body>Z</a>|

<iframe width = "100%" height = "10000"  title="<% = SpeciesNamePlural %> Breeds" src="livestockbreedinclude3.asp?Letter=<%=Letter%>&tempspeciesID=<%=tempspeciesID%>" ></iframe>





<br />




<a href = "#Top" class = "body2"><center>Top</center></a>
</td>
</tr>
</table>
</div></div></div>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>