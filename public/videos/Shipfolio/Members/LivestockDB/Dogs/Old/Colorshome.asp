<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<!--#Include file="AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=signularanimal  %> Colors </title>
<meta name="Title" content="<%=signularanimal %> Colors"/>
<meta name="Description" content="Alpacas come in many colors. We list them all here. "> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock of The World"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>

 <% Current = "Home" %>
<% Current3 = "ContactUs"%>

<!--#Include virtual="/Header.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If 
if screenwidth > 800 then
contentwidth = screenwidth 
else 
contentwidth = 800
end if 	
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "<%=screenwidth %>" height = "<%=screenwidth/3 %>">
<tr><td class = "roundedtopandbottom" align = "center" valign = "top">
<table>
<tr><td valign = "top">    
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtopandbottom body" align = "left" valign = "top" height = 510 width = "<%=screenwidth - 220 %>">
<% 
speciesID  = 2
SpeciesName = "Alpaca"
SpeciesNamePlural = "Alpacas"
Set rs2 = Server.CreateObject("ADODB.Recordset")
 sql2 = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
if not rs2.eof then %>
<h1><img src= "/AlpacaIcon.png" border = "0"  alt = "Alpaca Sales"  width = "40"/> <% = SpeciesName %> Colors </h1>
 <% = SpeciesNamePlural %> come in the following colors. Select the links below to view <% = SpeciesName %> in each color:
 <ul>
<%while not rs2.eof	 %>
<li ><a href = "Colors.asp?ColorSort=<%=rs2("SpeciesColor")%>&SpeciesID=<%=SpeciesID %>" class = "body"><%=rs2("SpeciesColor")%></a></li>
<% rs2.movenext
wend %>
</ul>
<% end if
rs2.close


%>
<br /><br />

<td class = "body" valign = "top">&nbsp;
</td>
</tr>
</table>
</td>
<td valign = "top" width = "200" class = " body roundedtopandbottom">
<center><a href = "/advertising.asp" class = "body2" align = "center">Advertise Here</a></center><br>
<% Query =  "Select AdID, AdImage, AdLink from Ads  where AdType='Search' and AdMonth = '" & month(now) & "' and adYear='" & year(now)& "' and speciesID = 2 ORDER BY rand() limit 6"

rs.Open Query, conn, 3, 3
x = 0


while not rs.eof and x < 13
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