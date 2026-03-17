<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<% MasterDashboard= True
PageName="Chickens" 
LSHeader = True
currentbreed="Chickens" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->

<% Description = "Find Breed information on Ameraucana, Ancona, Andalusian, Araucana, Asturian Painted Hen, Australorp, Barnevelder, Bianca di Saluzzo, Bionda Piemontese, Braekel (Brakel), Brahma, Buckeye, California Gray, Campine, Catalana, Chantecler, Cornish (a.k.a. Indian Game), Cubalaya, Derbyshire Redcap, Dominique, Dorking, Easter Egger, Egyptian Fayoumi, Ermellinata di Rovigo, Faverolles, French Naked Neck, Holland, Iowa Blue, Italian Naked-neck, Italian Polish, Ixworth, Java, Jersey Giant, Kraienköppe (Twentse), Lakenvelder, Leghorn, Marans, Marsh Daisy, Mericanel della Brianza, Millefiori di Lonigo, Millefiori Piemontese, Minorca, Modenese, Mugellese, Naked-neck, New Hampshire, Norfolk Grey, Norwegian Jærhøne, Orloff, Orpington, Penedesenca, Pepoi, Plymouth Rock, Polish Frizzle, Poltava, Polverara, Red Shaver, Rhode Island Red, Rhode Island White, Robusta Lionata, Robusta Maculata, Romagnola, Scots Grey, Sicilian Buttercup, Sicilian hound, Sussex, Tuffled Ghigi, Valdarnese, Valdarno, WelsuBresse, White-Faced Black Spanish, Winnebago, Wyandotte."
Title = "Chicken Breeds | Livestock Of The World"
image = "https://www.OatmealFarmNetwork.com/Chickens/ChickenBreedsHeader.jpg"
 %>

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
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />
<meta property="og:description" content="<%=Description %>" />

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": <%=title %>  ,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "mainEntity": "Global Grange"  ]  }
</script>


</head>
<body >
<% LSHeader = True 
currentbreed="Chickens" %>
<!--#Include virtual="/Members/membersHeader.asp"-->
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
       <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "40"/>&nbsp;Chickens</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container-fluid">
  <div>
   <div class = "body">

     <center><img src = "Chickenheader2.jpg" width = "100%" alt = "About Chickens"/></center><br />


<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "body" align = "left" valign = "top" height = 510>



Chickens (Gallus gallus domesticus) are domesticated birds that are raised for meat and eggs. There are over 24 billion chickens worldwide. Raising chickens is relatively inexpensive. Because of the low cost, chicken meat (also called "chicken") is one of the most common kinds of meat in the world.<br>
<br />
 <form  name=Login method="post" action="AboutChickens.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE"  >
</form>


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
<a href = "Default.asp" class = Body>A</a> |
<a href = "DefaultB.asp" class = Body>B</a> |
<a href = "DefaultC.asp" class = Body>C</a> |
<a href = "DefaultDEFG.asp" class = Body>DEFG</a> |
<a href = "DefaultHIJ.asp" class = Body>HIJ</a> |
<a href = "DefaultKL.asp" class = Body>KL</a> |
<a href = "DefaultM.asp" class = Body>M</a> |
<a href = "DefaultNOPQ.asp" class = Body>NOPQ</a> |
<a href = "DefaultR.asp" class = Body>R</a> |
<a href = "DefaultS.asp" class = Body>S</a> |
<a href = "DefaultTUVWXYZ.asp" class = Body>TUVWXYZ</a>
<br />
<%
Set rs2 = Server.CreateObject("ADODB.Recordset")

Letter = request.querystring("Letter")
SpeciesID = request.querystring("tempspeciesID")

sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1  and SpeciesID=13 and left((trim(LOWER(breed))), 1) = 'a' Order by trim(Breed)"
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

<br />
<a href = "#Top" class = "body2"><center>Top</center></a>
</td>
</tr>
</table>

</div></div></div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>