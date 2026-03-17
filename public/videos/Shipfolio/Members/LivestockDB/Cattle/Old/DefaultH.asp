<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<% MasterDashboard= True
PageName="Cattle" 
LSHeader = True
currentbreed="Cattle" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->

<%
title= "Cattle Breeds - H" 
image = "https://www.OatmealFarmNetwork.com/Cattle/Cattleheader.jpg"  %>
<Title><%=Title %></Title>
<meta name="title" content="<%=Title %>" />

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


<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "<%=title %>",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  }  }
</script>


</HEAD>
<body >
<% LSHeader = True 
currentbreed="Cattle"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
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
       <H1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "40"/>&nbsp;Cattle</h1><br />
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
     <br />

<a name="Breeds"></a>
<h2>Breeds of <%=Pagename %> - H</h2>
<br />

<% Letter = Request.Querystring("Letter")
If len(Letter)<1 then
Letter = "A"
end if
tempspeciesID= SpeciesID
%>
<a NAME="Breeds"></a>
<a href = "Default.asp" class = Body>A</a>|
<a href = "DefaultB.asp" class = Body>B</a>|
<a href = "DefaultC.asp" class = Body>C</a>|
<a href = "DefaultD.asp" class = Body>D</a>|
<a href = "DefaultE.asp" class = Body>E</a>|
<a href = "DefaultF.asp" class = Body>F</a>|
<a href = "DefaultG.asp" class = Body>G</a>|
<a href = "DefaultH.asp" class = Body>H</a>|
<a href = "DefaultI.asp" class = Body>I</a>|
<a href = "DefaultJ.asp" class = Body>J</a>|
<a href = "DefaultK.asp" class = Body>K</a>|
<a href = "DefaultL.asp" class = Body>L</a>|
<a href = "DefaultM.asp" class = Body>M</a>|
<a href = "DefaultN.asp" class = Body>N</a>|
<a href = "DefaultORQ.asp" class = Body>O</a>|
<a href = "DefaultP.asp" class = Body>P</a>|
<a href = "DefaultQ.asp" class = Body>Q</a>|
<a href = "DefaultR.asp" class = Body>R</a>|
<a href = "DefaultS.asp" class = Body>S</a>|
<a href = "DefaultTUV.asp" class = Body>T,U,V</a>|
<a href = "DefaultXYZ.asp" class = Body>W,X,Y,Z</a>


<%
Set rs2 = Server.CreateObject("ADODB.Recordset")

Letter = request.querystring("Letter")
SpeciesID = request.querystring("tempspeciesID")

sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1  and SpeciesID=8 and ( left((trim(LOWER(breed))), 1) = 'h' ) Order by trim(Breed)"
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
</div></div></div>
<!--#Include virtual="/Members/membersFooter.asp"-->
</body>
</html>