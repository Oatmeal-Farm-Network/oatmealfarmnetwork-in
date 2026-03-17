<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Site Map | Livestock Of the World</title>
<meta name="description" content="Sitemap for Livstock Of the world. LOA provides a ranch directory, products, and classied listings for Cattle, Dogs, Donkeys, Horses, Llamas, Pigs, Emus, Yaks, Bison, Alpacas, and Sheep."/>  
<meta name="revisit-after" content="7 Days"/>
<meta name="expires" content="never"/>
<meta name="distribution" content="global"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="viewport" content="width=device-width"/>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
 <% Current = "Home" %>
<% CurrentWebsite = "LivestockoftheWorld" 
CurrentWebsiteURL = "http://www.livestockoftheworld.com/"
Current3 = "Sitemap" 

Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
%>

<!--#Include virtual="/Header.asp"--> 

 
<table width = "100%" class = "roundedtopandbottom"><tr><td class= "body" height = "500" valign = "top">
<h1>Livestock Of the World Sitemap</h1>
<a href ="Sitemap.xml" class = "body" target = "blank">Sitemap (XML format)</a>
<table width = "<%=screenwidth %>" align = "center" >
<%
 UploadPath = request.servervariables("APPL_PHYSICAL_PATH") & "Sitemap\"
 dim fs,tfile
 set fs=Server.CreateObject("Scripting.FileSystemObject")
 set tfile=fs.CreateTextFile(  UploadPath & "Sitemap.XML", True)

  txt="<?xml version=""1.0"" encoding=""UTF-8""?><urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9""  xmlns:image=""http://www.google.com/schemas/sitemap-image/1.1"" xmlns:video=""http://www.google.com/schemas/sitemap-video/1.1""> <url>" 
 %>
<Td class = "body" valign = "top" width = "33%"><h2>Main Pages</h2>
<% URL = "" & CurrentWebsiteURL & ""
URLName = "Home Page"
URLPriority = 1.0
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<changefreq>Weekly</changefreq> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url>"
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />



<% URL = "" & CurrentWebsiteURL & "/Communities/Default.asp"
URLName = "Livestock Online Communities"
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />




<% URL = "" & CurrentWebsiteURL & "/Join/Default.asp"
URLName = "Join Livestock Of the World"
URLPriority = 0.8
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />

<% URL = "" & CurrentWebsiteURL & "/Associations/?"
URLName = "Livestock Association Services"
URLPriority = 0.8
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />


<% URL = "" & CurrentWebsiteURL & "/Advertising.asp"
URLName = "Advertise"
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />


<% URL = "" & CurrentWebsiteURL & "/AboutUs.asp"
URLName = "About Livestock Of the World"
URLPriority = 0.3
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />

<% URL = "" & CurrentWebsiteURL & "/AboutUs.asp"
URLName = "Contact Livestock Of the World"
URLPriority = 0.1
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />

<% URL = "" & CurrentWebsiteURL & "/Login.asp"
URLName = "Member Sign In"
URLPriority = 0.1
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />

<% URL = "" & CurrentWebsiteURL & "/Sitemap/Sitemap.asp"
URLName = "SiteMap"
URLPriority = 0.1
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority>" & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />
<br />











<% Species = "Horses" 
SingularName = "Horse" 
speciesID= 5%>
 
 <h2>Breeds of Livestock</h2>
<% URL = "" & CurrentWebsiteURL & "/BreedsOfLivestock/Default.asp"
URLName = "Breeds of Livestock"
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> "
%>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />
<br />

<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/abouthorses.asp?SpeciesID=2"
URLName = "About Horses" 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><%=URLName%></a><br />

<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%>:</b></a><br />

<% 

sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 
 if len(BreedImage) > 3 then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
 end if 
 URL = "" & CurrentWebsiteURL & "/" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2) 
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>

<br />
 <% Species = "Goats" 
SingularName = "Goat" 
speciesID= 6%>

<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutGoats.asp?SpeciesID=2"
URLName = "About Goats" 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%>:</b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 
 if len(BreedImage) > 3 then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
 end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2) 
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>



<br />
 <% '*****************************************************************************
 'Llamas
 '***************************************************************************** %>
 <% Species = "Llamas" 
SingularName = "Llama" 
speciesID= 4 

URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<br />
<% '*****************************************************************************
'Cattle
 '***************************************************************************** %>
<% Species = "Cattle" 
SingularName = "Cattle" 
speciesID= 8 %>

<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutcattle.asp?SpeciesID=2"
URLName = "About Cattle" 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>


<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />
 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%>:</b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 
 if len(BreedImage) > 3 then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
 end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2) 
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>

</td>
<Td class = "body" valign = "top" width = "33%">

 
  <% '*****************************************************************************
'Pigs
 '***************************************************************************** %>
  <% Species = "Pigs" 
SingularName = "Pig" 
speciesID= 12 %>


<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutPigs.asp?SpeciesID=2"
URLName = "About Pigs" 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%>:</b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 
 if len(BreedImage) > 3 then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
 end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2) 
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>


<br /> 
<% '*****************************************************************************
'Dogs
 '***************************************************************************** %>
  <% Species = "Dogs" 
SingularName = "Dog" 
speciesID=  3%>


<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutDogs.asp?SpeciesID=2"
URLName = "About Working Dogs" 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%>:</b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 
 if len(BreedImage) > 3 then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
 end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2)
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>

<br>
<% '*****************************************************************************
'Sheep
 '***************************************************************************** %>
  <% Species = "Sheep" 
SingularName = "Sheep" 
speciesID=  10%>
<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutSheep.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />


 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%>:</b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 
 if len(BreedImage) > 3 then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
 end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2)
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>
</Td>
<td width = "34%" valign = "top" class = "body">
<br>
 <% '*****************************************************************************
'Donkeys
 '***************************************************************************** %>
  <% Species = "Donkeys" 
SingularName = "Donkey" 
speciesID= 7 %>

<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutDonkeys.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />
 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%>:</b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 
 if len(BreedImage) > 3 then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
 end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2) 
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>




<% Species = "Alpacas"
SpeciesNamePlural = "Alpacas"
speciesID= 2
SpeciesName = Species 
%>
<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutalpacas.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = trim(rs2("Breed")) 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 

str1 = BreedImage
ImageOK = False
str2 = ".jpg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".jpeg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".gif"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".png"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If


 if len(BreedImage) > 3 and ImageOK = True then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = Breed2 
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>





<% Species = "Bison"
SpeciesNamePlural = "Bison"
speciesID= 9
SpeciesName = Species 
%>


<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutbison.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = trim(rs2("Breed")) 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 

str1 = BreedImage
ImageOK = False
str2 = ".jpg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".jpeg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".gif"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".png"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If


 if len(BreedImage) > 3 and ImageOK = True then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2) 
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>



<% Species = "Chickens"
SpeciesNamePlural = "Chickens"
speciesID= 13
SpeciesName = Species 
%>
<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutchickens.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 

str1 = BreedImage
ImageOK = False
str2 = ".jpg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".jpeg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".gif"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".png"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If


 if len(BreedImage) > 3 and ImageOK = True then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2)
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>





<% Species = "Emus"
SpeciesNamePlural = "Emus"
speciesID= 19
SpeciesName = Species 
%>
<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutEmus.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 

str1 = BreedImage
ImageOK = False
str2 = ".jpg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".jpeg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".gif"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".png"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If


 if len(BreedImage) > 3 and ImageOK = True then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2)
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>



<% Species = "Rabbits"
SpeciesNamePlural = "Rabbits"
speciesID= 11
SpeciesName = Species 
%>
<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutRabbits.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 

str1 = BreedImage
ImageOK = False
str2 = ".jpg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".jpeg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".gif"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".png"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If


 if len(BreedImage) > 3 and ImageOK = True then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2)
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>




<% Species = "Turkeys"
SpeciesNamePlural = "Turkeys"
speciesID= 14
SpeciesName = Species 
%>
<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutTurkeys.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 

str1 = BreedImage
ImageOK = False
str2 = ".jpg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".jpeg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".gif"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".png"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If


 if len(BreedImage) > 3 and ImageOK = True then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2)
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>


<% Species = "Yaks"
SpeciesNamePlural = "Yaks"
speciesID= 17
SpeciesName = Species 
%>


<% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/aboutyaks.asp?SpeciesID=2"
URLName = "About " & Species 
URLPriority = 0.7
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

 <% URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/default.asp?SpeciesID=2"
URLName = "Breeds of " & Species 
URLPriority = 0.9
txt= txt & "<url> "
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" ><b><%=URLName%></b></a><br />

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
 while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") 

str1 = BreedImage
ImageOK = False
str2 = ".jpg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".jpeg"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".gif"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If
str2 = ".png"
If InStr(lcase(str1),str2) > 0 Then
ImageOK = True
End If


 if len(BreedImage) > 3 and ImageOK = True then 
'txt= txt & " <image:image> "
'txt= txt & " <image:loc>" & BreedImage & "</image:loc> "
'txt= txt & " </image:image> "
end if 
 URL = "" & CurrentWebsiteURL & "" & lcase(Species) & "/Breeds.asp?BreedLookupID=" & BreedLookupID2 & "&amp;SpeciesID=" & SpeciesID
URLName = trim(Breed2)
URLPriority = 0.5
txt= txt & "<url>"
txt= txt & "<loc>" & URL & "</loc> "
txt= txt & "<priority> " & URLPriority & "</priority> "
txt= txt & "</url> " %>
<a href = "<%=URL%>" Class = "body" >&nbsp;<%=URLName%></a><br />
<%
 rs2.movenext
wend 
end if 
rs2.close
%>



</td>
</tr>
</table>



<% txt= txt & " </urlset> "
 tfile.WriteLine(txt)
 tfile.close
 set tfile=nothing
 set fs=nothing
 %> 
 </td></tr></table>
 <!--#Include virtual="/Footer.asp"-->
</body></html>