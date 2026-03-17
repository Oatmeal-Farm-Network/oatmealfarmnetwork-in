<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=signularanimal  %> Breeds</title>
<meta name="Title" content="<%=signularanimal  %> Breeds"/>
<meta name="Description" content="List of breeds of <%=SpeciesNamePlural  %> at Livestock of America - Livestock Classifieds."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<% response.redirect("default.asp") %>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current = "Animals" 
Current3 = "BreedSearch" %>
<!--#Include virtual="/Header.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->
<!--#Include virtual="/BreedsofLivestock/BreedsOfLivestockHeader.asp"-->
<% if screenwidth < 700 then %>
 <!--#Include virtual="/camelids/CamelidHeader.asp"--> 
<% end if %> 
<%' If rs.State = 0 Then
'else
 ' rs.close
'End If 
if screenwidth > 800 then
contentwidth = screenwidth 
else 
contentwidth = 800
end if 	
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "<%=screenwidth %>" height = "<%=screenwidth/3 %>"  >
<tr><td  align = "center" valign = "top" class = "roundedtopandbottom">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "body" align = "left" valign = "top" width = "<%=screenwidth - 300 %>" >
<h1><img src= "<%=BreedIcon %>" border = "0"  alt = "Alpacas for Sale"  width = "40"/> Breeds of <%=SpeciesNamePlural  %></h1>

<% 
'speciesID  = 2
'SpeciesName = "Alpaca"
'SpeciesNamePlural = "Alpacas"
Set rs2 = Server.CreateObject("ADODB.Recordset")

sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>
There are the following breeds of <% = SpeciesNamePlural %>:
<table cellpadding = 0 cellspacing  = 5>
<% while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") %>
<tr><td class = "body">
<h2><%=Breed2  %>&nbsp;<%=SpeciesNamePlural  %></h2>
<% if len(BreedImage) > 3 then %>
<table align = "left" width = "100" class="roundedtopandbottom" style="margin-left:12px;margin-right:12px;"><tr><td><a href = "Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" class="smallbody" ><img src = "<%= BreedImage%>" alt = "<%=BreedImageCaption%>" width = "100"/></a></td></tr><tr><td class = "body"><%=BreedImageCaption %></td></tr></table>
<% end if %>

<%=left(Breeddescription, 350) %>...
<a href = "Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" class="smallbody" >Learn More...</a><br>
</td></tr>
<%
 rs2.movenext
wend %>
</table>
<% end if 

rs2.close
%>
</td>
</tr>
</table>
</td>
<td valign = "top" width = "200" class = " body roundedtopandbottom">
<center><a href = "/advertising.asp" class = "body2" align = "center">Advertise Here</a></center><br>
<% Query =  "Select AdID, AdImage, AdLink from Ads  where AdType='Search' and AdMonth = '" & month(now) & "' and adYear='" & year(now)& "' and speciesID = 2 ORDER BY rand() limit 6"

rs.Open Query, conn, 3, 3
x = 0


while not rs.eof and x < 3
 x = x + 1
AdID = rs("AdID")
AdImage  = rs("AdImage") 
AdLink = rs("AdLink")
Link1=""
Link2 = ""
if len(AdLink) > 3 then
Link1=  AdLink
Link2= "http://" & AdLink
else
 Link2 = "/Ranches/RanchHome.asp?CurrentPeopleID=" & PeopleID
end if %>
<% If Len(AdImage) > 1 and Len(AdImage) < 131 then%>
<% If Len(Link2) > 1  then%>
 <a href = "<%=Link2 %>" target = "blank">
 <% end if %>
<img src = "<%= AdImage%>" width ="200" height = "200" border = "0">
<% If Len(Link2) > 1  then%>
 <a>
 <% end if %>
<% End If %>

<% rs.movenext
wend
set rs=nothing
  set conn = nothing %>
<br>
<center><a href = "/advertising.asp" class = "body2" align = "center">Advertise Here</a></center><br>
</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->
</body>
</html>