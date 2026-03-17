<!DOCTYPE html>
<meta charset="UTF-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% Description = "Horse breed information on Abaco Barb, Akhal-Teke, American Cream Draft, American Paint Horse, American Quarter Horse, American Saddlebred, Andalusian, Appaloosa Horse, Appendix Quarter Horse, Arabian, Barb, Belgian, Budenny, Camargue, Canadian Horse, Caspian, Chincoteague/Assateague, Cleveland Bay, Clydesdale, Connemara Pony, Curly Horse, Dales Pony, Danish Warmblood, Dartmoor Pony, Drum Horse, Dutch Warmblood, Exmoor, Fell Pony, Florida Cracker, Friesian, Gotland-Russ Pony, Gypsy Horses, Hackney, Haflinger, Hanoverian, Highland Pony, Icelandic Horse, Irish Draught Horse, Kathiawari, Kerry Bog Pony, Knabstrupper, Lipizzan, Lippitt Morgan, Lusitano, Mangalarga Marchador, Marsh Tacky, Marwari, Miniature Horse, Missouri Fox Trotter, Morab, Morgan, Mountain Pleasure Horse, Mule, Mustang, National Show Horse, New Forest Pony, Newfoundland Pony, Nokota, Norman Cob, Norwegian Fjord, Oldenburg, Orlov Trotter, Paint Horse, Paso Fino, Percheron, Peruvian Horse, Pinto, Pony of the Americas, Przewalski Horse, Quarter Horse, Racking Horse, Ranger, Rocky Mountain Horse, Saddlebred, Selle Francais, Shagya Arabian, Shetland Pony, Shire, Spanish Mustang, Spotted Saddle Horse, Standardbred, Suffolk Punch, Swedish Warmblood, Tennessee Walking Horse, Thoroughbred, Trakehner, Welsh Pony and Coband Westphalian Horses." 
Image = "https://www.OatmealFarmNetwork.com/Horses/horsebreedsheader.jpg"
%>

<Title><%=Title%></Title>
<meta name="title" content="><%=Title%>" />
<meta property="og:title" content="><%=Title%>" />
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
  "headline": "<%=Title %>",
  "description": "<%=Description %>" ,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": "<%=image %>"  }
</script>


</HEAD>
<body >
<% LSHeader = True 
currentbreed="Horses"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")	
%>
<a name="Top"></a>
      
<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>"  Height = "40"/> &nbsp;Horses</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body">
<center><img src = "horseheader.jpg" width = "100%" alt = "Breeds of Horses" title = "Horse Breeds" /></center>

Horses have evolved over the past 45 to 55 million years from a small multi-toed animal into the large, single-toed animal of today. Humans began to domesticate horses around 4000 BC, and their domestication is believed to have been widespread by 3000 BC. Worldwide many products are many from horses, including meat, milk, hide, hair, bone, and pharmaceuticals extracted from the urine of pregnant mares; however, in the US they are predominately used for sport and recreation.<br />
<form  name=Login method="post" action="AboutHorses.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE"  />
</form>
<br />
<a name="Breeds"></a>
<h2>Breeds of <%=Pagename %></h2>
There are the following breeds of <% = SpeciesNamePlural %>:
<br />

<a NAME="Breeds"></a>
<a href = "Default.asp?Letter=A#Breeds" class = Body>A</a> |
<a href = "DefaultB.asp?Letter=B#Breeds" class = Body>B</a> |
<a href = "DefaultC.asp?Letter=C#Breeds" class = Body>C</a> |
<a href = "DefaultD.asp?Letter=D#Breeds" class = Body>D</a> |
<a href = "DefaultE.asp?Letter=E#Breeds" class = Body>E</a> |
<a href = "DefaultF.asp?Letter=F#Breeds" class = Body>F</a> |
<a href = "DefaultG.asp?Letter=G#Breeds" class = Body>G</a> |
<a href = "DefaultH.asp?Letter=H#Breeds" class = Body>H</a> |
<a href = "DefaultI.asp?Letter=I#Breeds" class = Body>I</a> |
<a href = "DefaultJ.asp?Letter=J#Breeds" class = Body>J</a> |
<a href = "DefaultK.asp?Letter=K#Breeds" class = Body>K</a> |
<a href = "DefaultL.asp?Letter=L#Breeds" class = Body>L</a> |
<a href = "DefaultM.asp?Letter=M#Breeds" class = Body>M</a> |
<a href = "DefaultN.asp?Letter=N#Breeds" class = Body>N</a> |
<a href = "DefaultO.asp?Letter=O#Breeds" class = Body>O</a> |
<a href = "DefaultP.asp?Letter=P#Breeds" class = Body>P</a> |
<a href = "DefaultQ.asp?Letter=Q#Breeds" class = Body>Q</a> |
<a href = "DefaultR.asp?Letter=R#Breeds" class = Body>R</a> |
<a href = "DefaultS.asp?Letter=S#Breeds" class = Body>S</a> |
<a href = "DefaultT.asp?Letter=T#Breeds" class = Body>T</a> |
<a href = "DefaultU.asp?Letter=U#Breeds" class = Body>U</a> |
<a href = "DefaultV.asp?Letter=V#Breeds" class = Body>V</a> |
<a href = "DefaultW.asp?Letter=W#Breeds" class = Body>W</a> |
<a href = "DefaultXYZ.asp?Letter=X#Breeds" class = Body>XYZ</a> |
<br />

<%
Set rs2 = Server.CreateObject("ADODB.Recordset")

Letter = request.querystring("Letter")
SpeciesID = request.querystring("tempspeciesID")

sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1  and SpeciesID=5 and left((trim(LOWER(breed))), 1) = 'a' Order by trim(Breed)"
'response.write("sql2=" & sql2 )

rs2.Open sql2, conn, 3, 3
if rs2.eof then %>
<a NAME="<%=Letter %>"></a>
<table cellpadding = 0 cellspacing  = 5 width = 100%>
<tr><td class="body">There are no <%=signularanimal %> breeds that start with the letter <%=Letter %>.</td></tr>
</table>

<% else %>
<br />
<a NAME="<%=Letter %>"></a>
<table cellpadding = 0 cellspacing  = 0 width = 100%>

<% while not(rs2.eof) 
Breed2 = rs2("Breed") & " "
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")

str1 =Breeddescription
str2 = "rn P"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 



str1 =Breeddescription
str2 = "\r"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "\n"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "rnrn"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "rn("
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "rnA"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 


str1 =Breeddescription
str2 = "rnB"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = ",rn"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 


str1 =Breeddescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , "''")
End If 

BreedImage= rs2("BreedImage")
str1 =BreedImage
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BreedImage= Replace(str1, str2 , "https://")
End If 

Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") %>
<tr><td bgcolor = '#888888' height = 1></td></tr>
<tr><td bgcolor = "#d6ceca" height = 40><h3><img src = "/images/px.gif" alt ="About <%=Breed2  %> <%=SpeciesNamePlural %>" width = 3 height = 30 /><%=Breed2  %></h3></td></tr>
<tr><td bgcolor = '#888888' height = 1></td></tr>
<tr><td class = "body" height = 200 valign = top>

<br>
<% if len(BreedImage) > 4 then%>
<a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" target = "_blank"><img src = "<%= BreedImage%>" alt = "<%=BreedImageCaption%>" title = "<%=BreedImageCaption%>" width = "250" align = "left" hspace="20" border = 0/></a>
<% else %>
<a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" target = "_blank"><img src = "/images/MissingLivestockImage.jpg" alt = "<%=BreedImageCaption%>" title = "" width = "250" align = "left" hspace="20" border = 0/></a>
<% end if %>

<%=left(Breeddescription, 750) %>
<%if len(Breeddescription) > 750 then %>
...
<% end if %>
<%if len(Breeddescription) > 25 then %>
<br />
<br /><br />

<table width = 100%>
<tr><td></td>
<td width = 30%>
<form name=Login method="post" target = "_top" action="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" >
<input type="submit" class = "regsubmit2" value="LEARN MORE"  >
</form>
</td>
</tr>
</table>
<br>
<% end if %>


</td></tr>
<tr><td height = 21><img src = "/images/px.gif" title = alt ="<%=Breed2  %> - <%=SpeciesNamePlural %> Breeds" alt ="<%=Breed2  %> - <%=SpeciesNamePlural %> Breeds" /></td></tr>
<%
 rs2.movenext
wend %>
</table>
<% end if 
rs2.close %>

<br />



<a href = "#Top" class = "body2"><center>Top</center></a>
</td>
</tr>
</table>
</div>
</div>
</div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>