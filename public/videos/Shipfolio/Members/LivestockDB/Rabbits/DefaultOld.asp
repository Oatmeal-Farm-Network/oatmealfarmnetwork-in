<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<meta charset="utf-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% Description = "Find Breed information on Alaska, Altex, American Blue, American Fuzzy Lop, American Sable, American White, Argente Bleu, Argente Brun, Argente Clair, Argente Crème, Argente de Champagne, Argente Noir, Argente St Hubert, Baladi, Bauscat, Beige, Belgian Hare, Beveren, Blanc de Bouscat, Blanc de Hotot, Blanc de Popielno, Blanc de Termonde, Blue of Ham, Blue of Sint-Niklaas, Bourbonnais Grey, Brazilian, Britannia Petite, British Giant, Brown Chestnut of Lorraine, Caldes, Californian, Carmagnola Grey, Cashmere Lop, Chaudry, Checkered Giant, Chinchilla (American), Chinchilla (Giant), Chinchilla (Giganta), Chinchilla (Standard), Cinnamon, Continental Giant, Criollo, Cuban Brown, Czech Albin, Czech Red rabbit, Czech Spot, Deilenaar, Dutch, Dutch (Tri-Coloured), Dwarf Hotot, Dwarf Lop (Mini Lop), Elfin, Enderby Island, English Angora, English Lop, English Spot, Fauve de Bourgogne, Fee de Marbourg (Marburger), Flemish Giant, Florida White, French Angora, French Lop, Gabali, German Angora, German Lop, Giant Angora, Giant Papillon, Giza White, Golden Glavcot, Gotland, Grey Pearl of Halle, Güzelcaml, Harlequin, Havana, Himalayan, Hulstlander, Hungarian Giant, Jersey Wooly, Kabyle, Lilac, Lionhead, Liptov Baldspotted, Meissner Lop, Mini Lion Lop, Miniature Lop (Holland Lop), Netherland Dwarf, New Zealand, New Zealand Red, Orestad, Palomino, Pani, Pannon White, Perlfee, Plush Lop (Mini), Plush Lop (Standard), Pointed Beveren, Polish, Rex (Astrex), Rex (Mini), Rex (Opossum), Rex (Standard), Rhinelander, Sachsengold, Sallander, San Juan, Satin, Satin (Mini), Satin Angora, Siamese Sable, Siberian, Silver, Silver Fox, Silver Marten, Smoke Pearl, Spanish Giant, Squirrel, Sussex, Swiss Fox, Tadla, Tan, Teddywidder, Thrianta, Thuringer, Vienna, Wheaten, Wheaten Lynx, and Zemmouri Rabbits."
Title = "All Rabbit Breeds"
image = "/livestockdb/Rabbits/RabbitHeader.webp"
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
  "headline": <%=Title %>,
  "description": <%=Description %>,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=image %> }
</script>
</HEAD>
<body >
<% currentbreed="Rabbits"
LSHeader = True %>
 <!--#Include virtual="/Members/membersHeader.asp"-->

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
       <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "40"/>&nbsp;Rabbits</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body">
   <center><img src = "<%=image%>" width = 100% alt = "Rabbit Breeds"/></center><br />

<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "100%">
<tr><td class = "body" align = "left" valign = "top">
Rabbits are small cute furry critters found in several parts of the world. There are eight different groups within the rabbit family, including the European rabbit, cottontail rabbits, and the Amami rabbit (an endangered species in Japan).
The only rabbit to be widely domesticated is the European rabbit, which has been extensively bred for food and as pets. Rabbits were first widely kept in ancient Rome and they were refined into a wide variety of breeds during and since the middle Ages.<br /><br />

Domesticated rabbits have mostly been bred to be much larger than wild rabbits, although selective breeding has produced rabbits in a wide range of sizes from dwarf to giant. 

<br> 

 <form  name=Login method="post" action="AboutRabbits.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE"  />
</form>
<br>
<br />

<a name="Breeds"></a>
<h2>Breeds of <%=Pagename %></h2>

There are the following breeds of <% = SpeciesNamePlural %>:
<br />

<% Letter = "A"
tempspeciesID= SpeciesID
%>
<!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "B" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "C" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "D" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "E" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "F" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "G" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "H" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "I" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "J" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "K" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "L" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "M" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "N" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "O" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "P" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "Q" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "R" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "S" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "T" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "U" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "V" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "W" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "X" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "Y" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->
<% Letter = "Z" %><!--#Include virtual="/BreedsofLivestock/livestockbreedinclude.asp"-->

<a href = "#Top" class = "body2"><center>Top</center></a>
</td>
</tr>
</table>
</div>
</div>
</div>
 <!--#Include virtual="/Members/membersFooter.asp"-->
</body>
</html>