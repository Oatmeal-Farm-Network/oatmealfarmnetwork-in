<!DOCTYPE html>
<meta charset="UTF-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% Description = "Find Breed information on Alpine, Altai Mountain, American Cashmere, Anatolian Black, Angora, Appenzell, Arapawa, Argentata dell'Etna, Aspromonte, Australian Cashmere, Bagot, Barbari, Beetal, Belgian Fawn, Benadir, Bhuj, Bilberry, Bionda dell'Adamello, Black Bengal, Boer, Booted, Bormina, British Alpine, Brown Shorthair, Canary Island, Caninde, Capestrina, Carpathian, Caserta, Cashmere, Chamba, Chamois Colored, Changthangi, Chappar,  Charnequeira, Chengde Polled, Chengdu Brown, Chigu, Ciavenasca, Cilentana Fulva, Ciociara Grigia, Corsica, Daera Din Panah, Damani, Damascus, Danish Landrace, Don, Duan, Dutch Landrace, Dutch Toggenburg, Erzgebirg, Fasana, Finnish Landrace, Frontalasca, Garganica, Girgentana, Goingeget, Golden Guernsey, Grigia Molisana, Grisons Striped, Hailun, Haimen, Hasi, Hejazi, Hexi Cashmere, Hongtong, Huaipi, Huaitoutala, Hungarian Improved, Icelandic, Irish, Istriana, Jamnapari, Jining Grey Jonica, Kaghani, Kalahari Red, Kalbian, Kamori, Kiko, Kinder, Kri Kri, L'Aquila, LaMancha, Lariana, Loashan, Majorera, Maltese, Massif Central, Messinese, Mini Oberhasli, Miniature Silky Fainting, Montecristo, Monticellana, Mountain, Moxoto, Murcia-Granada, Murciana, Murgese di Foggia, Myotonic (Wooden Leg), Nachi, Napoletana, Nicastrese, Nigerian Dwarf, Nigora, Norwegian, Nubian, Oberhasli, Orobica, Peacock, Pedula della Valtellina, Pezzata Rossa, Philippine, Poitou, Pomellata, Potenza, Pygmy, Pygora, Pyrenean, Qinshan, Red Boar, Red mediterranean, Repartida, Roccaverano, Rove, Russian White, Rustica, Saanen, Sable Saanen, Sahelian, Salerno, San Clemente Island, Sarda, Savanna, Screziata, Selvatica di Galite, Selvatica di Joura, Selvatica di Samotracia, Sempione, Somali, Spanish, SRD, Stiefelgeiss, Surati, Swedish Landrace, Tauernsheck, Tavolara, Tennessee Fainting, Teramo, Thuringian, Toggenburg, Uzbek Black, Valais Blackneck, Valdostana, Valfortorina, Valle dei Mocheni, Valle del Chiese, Valle di Fiemme, Vallesana, Verata, West African Dwarf, White Shorthaired, Xinjiang, Xuhai, Yemen Mountain, Zalawadi, Zhiwulin Black, and Zhongwei Goats." 
Image = "https://www.OatmealfarmNetwork.com/goats/goatheader.jpg"
%>

<Title>Goat Breeds | Goats</Title>
<meta name="title" content="Goat Breeds | Goats" />
<meta property="og:title" content="Goat Breeds | Goats" />
<meta name="description" content="<%=Description %>" />
<meta property="og:description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />

<meta name="Author" content="Livestock Of The World"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />

<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Goat Breeds | Goats",
  "description": "<%=left(Description, 160)%>",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": "<%=image %>" }
</script>

</HEAD>
<% LSHeader = True 
currentbreed="Goats"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If 

%>
<a name="Top"></a>

<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
      <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "45"/>&nbsp;Goats</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body">

     <center><img src = "Goatheader2.jpg" width = 100% alt = "About Goats"/></center><br />

The goat is one of the 12 Chinese zodiac animals. It represents introversion, creativity, shyness and being a perfectionist.  Goats were one of the first animals to be domesticated and have been used for their milk, meat, hair, and skins all over the world. There are over 100 distinct breeds of goat and there are more than 924 million live goats in the world.<br> 

 <form  name=Login method="post" action="AboutGoats.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE"  />
</form>
<br />



<a name="Breeds"></a>
<% Set rs2 = Server.CreateObject("ADODB.Recordset")

sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>
<h2>Breeds of <% = SpeciesNamePlural %></h2>

There are the following breeds of <% = SpeciesNamePlural %>:

<% while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")


BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") %>
<table width = 100%>
<tr><td bgcolor = '#888888' height = 1 colspan = 2></td></tr>
<tr><td bgcolor = "#d6ceca" height = 40 colspan = 2><h3><img src = "/images/px.gif" alt ="<%=Breed2  %> - Breeds of <%=signularanimal %>" width = 3 height = 30 /><%=Breed2  %></h3></td></tr>
<tr><td bgcolor = '#888888' height = 1 colspan = 2></td></tr>
<tr><td class = "body" valign = top width = 200><br>
<% if len(BreedImage) > 1 then%>
<a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" class = body><img src = "<%= BreedImage%>" alt = "<%=BreedImageCaption%>" width = "180" align = "left" hspace="20"/></a><br>
<% end if %>
</td>
<td class = "body">
<blockquote>
<%=left(Breeddescription, 450) %>
<%if len(Breeddescription) > 450 then %>
...
<% end if %>
<%if len(Breeddescription) > 25 then %>
<br />
<div align = right>
<form  name=Login method="post" action="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" >
<input type="submit" class = "regsubmit2" value="LEARN MORE"  >
</form>
</div>
<br>
<% end if %>
</blockquote>
 </td>
</tr></table>
<%
 rs2.movenext
wend %>

<% end if 

rs2.close
%>

<br />
  </div>
  </div>
  </div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>
