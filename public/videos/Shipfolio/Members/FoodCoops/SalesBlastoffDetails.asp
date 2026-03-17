<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
 <!--#Include virtual="/GlobalVariables.asp"-->
 <% 
ID= Request.QueryString("ID") 
if len(ID) > 0 then
else
Response.AddHeader "Location","http://www.LivestockofAmerica.com"
end if 
sql = "select People.PeopleID, animals.FullName, animals.speciesid from People, animals where People.PeopleID= animals.PeopleID and id = " & ID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
if not rs.eof then
CurrentPeopleID = rs("PeopleID")
Name = trim(rs("FullName"))
Name = Trim(Name)
if len(Name) > 1 then
For y=1 to Len(Name)
spec = Mid(Name, y, 1)
specchar = ASC(spec)
if specchar < 32 or specchar > 126 then
Name= Replace(Name,  spec, " ")
end if
Next
end if
str1 = Name
str2 = "''"
If InStr(str1,str2) > 0 Then
Name= Replace(str1, "''", "'")
End If
CurrentanimalName = Name
SpeciesID = rs("speciesID")

if SpeciesID = 2 then
signularanimal = "Alpaca"
end if 
if SpeciesID = 3 then
signularanimal = "Dog"
end if 
if SpeciesID = 4 then
signularanimal = "Llama"
end if 
if SpeciesID = 5 then
signularanimal = "Horse"
end if 
if SpeciesID = 6 then
signularanimal = "Goat"
end if 
if SpeciesID = 7 then
signularanimal = "Donkey"
end if 
if SpeciesID = 8 then
signularanimal = "Cattle"
end if 
if SpeciesID = 9 then
signularanimal = "Bison"
end if 
if SpeciesID = 10 then 
signularanimal = "Sheep"
end if 
if SpeciesID = 11 then
signularanimal = "Rabbit"
end if 
if SpeciesID = 12 then
signularanimal = "Pig"
end if 
if SpeciesID = 13 then
signularanimal = "Chicken"
end if 
if SpeciesID = 14 then
signularanimal = "Turkey"
end if 
if SpeciesID = 15 then
signularanimal = "Duck"
end if 
else
end if 
rs.close
if len(CurrentPeopleID) > 0 then
else
response.Redirect("Default.asp")
end if
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
Logo = rs("Logo")
end if 
rs.close
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
if len(AddressState) > 1 then
sql = "SELECT * from States where StateAbbreviation =  '" & AddressState & "'"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
StateAbbreviation = rs2("StateAbbreviation")
Nicknames = rs2("Nicknames") 
end if
rs2.close
end if
 %>
<title><%=signularanimal %> For Sale - <%=Name%> at <%= BusinessName %></title>
<meta name="Title" content="<%=Name%> - <%= BusinessName %>"/>
<meta name="description" content="<%=Name%> - <%=signularanimal %> For Sale by <%=BusinessName%> . <%=BusinessName%> is a <%=StateName%> <%=signularanimal %> ranch." />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1 day"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=Category %> Animals " />
<link rel="stylesheet" type="text/css" href="/style.css">
<% 
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
MenuBackgroundColor = rs("MenuBackgroundColor")
MenuColor = rs("MenuColor")
MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
TitleColor = rs("TitleColor")
PageBackgroundColor = rs("PageBackgroundColor")
PageTextColor = rs("PageTextColor")
LayoutStyle = rs("LayoutStyle")
PageTextMouseOverColor = rs("PageTextMouseOverColor")
End If
rs.close 
%>
<style>
H1 {font: 24pt arial; color: <%=TitleColor %>}
H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 18pt arial; color: <%=TitleColor %>}
.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body:hover { color: <%=PageTextMouseOverColor%>}
.Heading {font: 10pt arial; color: <%=MenuColor %>}
A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<%Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName= rs("PeopleLastName")
rs.close
End If 
%>
<!--#Include virtual="/Ranches/DetailDBInclude.asp"--> 
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<!--#Include file="RanchHeader.asp"-->
<a name = "top"></a>
<%Current3 = "Animals" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width= "989" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left"><%=CurrentanimalName%></div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<br />
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"    width= "<%=screenwidth  %>">
<tr>
<td>
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"  >
<tr><td><table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" width= "<%=screenwidth -30 %>" border = "0"><tr><td   valign="top"  align = "left" class = "body">
<!--#Include file="GeneralStatsInclude.asp"-->
</td><td class = "body" valign = "top"  width = "300">
<table width = "300" ><tr><td align = "center" width = "300" >
<% if noimage = true then%>
<%=click%>
<% else %>
<IMG alt="main image" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" height = "250">
<% end if%>
</td></tr>
<% if len(ARIPhoto) > 1 or len(HistogramPhoto) > 1 then %>
<tr><td>
<% if len(ARIPhoto) > 1  then %>
<a href = "<%=ARIPhoto%>" class= "body" target = "_blank"><img src = "/images/ARIThumb.jpg" border = "0" height = "50"></a>
<% end if %>
<% if len(HistogramPhoto) > 1 then %>
<a href = "<%=HistogramPhoto%>" class= "body" target = "_blank"><img src = "/images/HistogramThumb.jpg" border = "0" height = "50"></a>
<% end if %>
<% if len(FiberAnalysisPhoto) > 1 then %>
<a href = "<%=FiberAnalysisPhoto%>" class= "body" target = "_blank"><img src = "/images/FiberAnalysisThumb.jpg" border = "0" height = "50"></a>
<% end if %>
</td></tr>
 <%
end if
if not rsA.eof then 
rsA.movefirst
counter = 0
counttotal = 8 %>
<tr><td width = "300" align = "center"><table>
<% While counter < counttotal and TotalPics > 1
counter = counter +1
If Len(buttonimages(counter)) > 11 then
if counter = 1 or counter = 5 then
%>
<tr>
<% end if %>
<td valign = "top" align = "center" class = "small">
<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br><% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>
</td>
<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% If Len(buttonimages(counter)) > 2 then%>
<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %>
</font>
<% End If %>
</td>
<% if counter = 4 then %>
</tr>
<% end if %>
<% end if %>
<% wend %>
<% if len(AnimalVideo) > 1  then 
str1 = AnimalVideo
str2 = "width"
If InStr(str1,str2) > 0 Then
AnimalVideo= Replace(str1, "width", "width = 400 widthx")
End If
%>
<tr><td colspan = 4>

<%=AnimalVideo %>
</td></tr>
<% end if %>

</table>
</td></tr></table>
<% end if %>
<!--#Include file="ServiceSireInclude.asp"-->
</td>
</tr></table>
<table width = "100%">
<tr><td  valign = "top"   width = "100%"   >
<!--#Include file="AwardsInclude.asp"--> 
<!--#Include file="FiberInclude.asp"--> 
<!--#Include file="AncestryInclude.asp"--> 
</td></tr></table>
<br><br>
</td></tr></table> 
</td></tr></table>
</td></tr></table>
<!--#Include file="AnimalCount.asp"--> 
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>