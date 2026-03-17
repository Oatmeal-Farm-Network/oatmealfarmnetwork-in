<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
If Len(CurrentPeopleID) > 0 Then 
else
CurrentPeopleID=Request.Form("CurrentPeopleID") 
End if
If len(CurrentPeopleID) > 0 Then
else
Response.Redirect("Default.asp")
End if
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
RanchHomeText = rs("RanchHomeText")
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
Logo = rs("Logo")
Header = rs("Header")
str1 = RanchHomeText
str2 = vblf
If InStr(str1,str2) > 0 Then
RanchHomeText= Replace(str1, str2 , "</br>")
End If  
str1 = RanchHomeText
str2 = vbtab
If InStr(str1,str2) > 0 Then
RanchHomeText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
end if 
rs.close
if len(BusinessID) > 0 then
else
response.Redirect("default.asp")
end if
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
<title><%=StateName %> Animals | <%= BusinessName %></title>
<meta name="description" content="<%=StateName %> Animals at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %>. Presented by Livestock of America" >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="<%=StateName %> Animals, <%=StateName %> AnimalStuds" >
<link rel="stylesheet" type="text/css" href="/style.css">
<% 
Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select * from RanchPages where PeopleID= " & CurrentPeopleID
				rs.Open sql, conn, 3, 3
				If not rs.eof Then
						Logo = rs("Logo")
						Header = rs("Header")
						MenuBackgroundColor = rs("MenuBackgroundColor")
						MenuColor = rs("MenuColor")
						MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
						TitleColor = rs("TitleColor")
						PageBackgroundColor = rs("PageBackgroundColor")
						PageTextColor = rs("PageTextColor")
						LayoutStyle = rs("LayoutStyle")
			
				End If
			rs.close
%>
<% if PageBackgroundColor= "Black" Then
TitleColor = "white"
PageTextColor = "white"
end if 
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
H3 {font: 12pt arial; color: <%=TitleColor %>}
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
dim Layout
target = request.querystring("target")
Layout = request.querystring("Layout")
if len(Layout) = 0 then
Layout=3
end if
SortOrder = request.form("SortOrder")
Sortby = "Price Asc"
if SortOrder = "Name" or len(SortOrder) < 3 then Sortby = "FullName Asc"
if SortOrder = "Price - Ascending" or len(SortOrder) < 3 then Sortby = "Price Asc"
if SortOrder = "Price - Descending" or len(SortOrder) < 3 then Sortby = "Price Desc"
if SortOrder = "Color" or len(SortOrder) < 3 then Sortby = "Color1"
if SortOrder = "DOB" or len(SortOrder) < 3 then Sortby = "DOBYear Desc, DOBMonth Desc, DOBYear Desc"
Current3 = "Herdsires"%>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
<!--#Include file="RanchPagesTabsInclude.asp"-->
<% screenwidth = screenwidth - 15 %>
<table width = "<%=screenwidth -30 %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H1><div align = "left">Stud Services</font></h1>
</td></tr>
<tr><td class = "roundedBottom" align = "left" height = "530" valign = "top">
<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" valign = "top" width = "<%=screenwidth -30 %>">
<tr><td class = "body">
<% if totalAlpacasstuds > 0 then %>
<a href = "#Alpacas" class = "body">Alpaca Studs</a> | 
<% end if %>
<% if totalcattleStuds> 0 then %>
<a href = "#cattle" class = "body">Cattle Studs</a> | 
<% end if %>
<% if totalDogsStuds > 0 then %>
<a href = "#Dogs" class = "body">Working Dog Studs</a> | 
<% end if %>
<% if totalDonkeysStuds > 0 then %>
<a href = "#Donkey" class = "body">Donkey Studs</a> | 
<% end if %>
<% if totalgoatsStuds > 0 then %>
<a href = "#Goats" class = "body">Goat Studs</a> | 
<% end if %>
<% if totalhorsesstuds > 0 then %>
<a href = "#Horses" class = "body">Horse Studs</a> | 
<% end if %>
<% if totalllamasstuds > 0 then %>
<a href = "#Horses" class = "body">Llama Studs</a> | 
<% end if %>
<% if totalllamasstuds> 0 then %>
<a href = "#Llamas" class = "body">Llama Studs</a> | 
<% end if %>
<% if totalpigsStuds > 0 then %>
<a href = "#pigs" class = "body">Pig Studs</a> | 
<% end if %>
<% if totalSheepstuds > 0 then %>
<a href = "#Sheep" class = "body">Sheep Studs</a> | 
<% end if %>

<% Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  %> 

<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "right" valign = "top">
<tr><td class = "body">View:</td><td>

<form name="Layoutform1" action="RanchAllStuds.asp?Layout=1&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST">
<input type="image" src="/images/PageLayout1.jpg" name="image" width="35" height="28" alt = "Standard"></td>
</form>
<td>
<form name="Layoutform2" action="RanchAllStuds.asp?Layout=2&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST">
<input type="image" src="/images/PageLayout2.jpg" name="image" width="35" height="28" alt = "Gallery"></form>
</td>
<td>
<form name="Layoutform3" action="RanchAllStuds.asp?Layout=3&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST">
<input type="image" src="/images/PageLayout3.jpg" name="image" width="35" height="28" alt = "List"></form></td>
<td width = "5">
</td></tr></table>

<INPUT TYPE="image" SRC="images/px.gif" HEIGHT="1" WIDTH="1" BORDER="0" ALT="Submit Form">
<% if len(Layout) < 1 then layount=2 %>
<form  action="RanchAllStuds.asp?target=<%=Target %>&Layout=<%=Layout%>&CurrentPeopleID=<%=CurrentPeopleID %>" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "300" align = "right">
<tr>
<td width="20">
&nbsp;
</td>
 <td class = "body"  align = "right">
<select size="1" name="SortOrder"  >
<% if len(SortOrder) > 1 then %>
<option name = "AID0" value= "<%=SortOrder%>" selected><%=SortOrder%></option>
<% end if %>
<option name = "AID0" value= "Name" >Name</option>
<option name = "AID0" value= "Price - Ascending" >Price - Ascending</option>
<option name = "AID0" value= "Price - Descending" >Price - Descending</option>
<option name = "AID0" value= "Color" >Color</option>
<option name = "AID0" value= "DOB" >DOB</option>
</select>
</td>
<td class = "body" valign = "bottom" width = "60">
<input type=submit value = "Sort "  class = "regsubmit2" >
</td>
</tr>
</table>
</form>
</td></tr>


<% if totalAlpacasstuds > 0 then %>
<tr><td><a name= "Alpacas"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Alpaca Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 2 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and (category = 'Experienced Male' or category = 'Inexperienced male') and  PeopleID= " & CurrentPeopleID & " and speciesID = 2 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="Alpacas"></a>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>

<% if totalcattleStuds> 0 then %>
<tr><td><a name= "Cattle"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Cattle Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 8 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 8 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="Alpacas"></a>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>

<% if totalDogsStuds > 0 then %>
<tr><td><a name= "Dogs"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Working Dog Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 4 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 4 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>

<% if totalDonkeysStuds > 0 then %>
<tr><td><a name= "Donkeys"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Donkey Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 7 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 7 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="Alpacas"></a>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>

<% if totalgoatsStuds > 0 then %>
<tr><td><a name= "Goats"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">GoatStuds</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 6 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 6 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>


<% if totalhorsesstuds > 0 then %>
<tr><td><a name= "Horses"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">HorseStuds</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 5 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 5 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>

<% if totalllamasstuds > 0 then %>
<tr><td><a name= "Llamas"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">LlamaStuds</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 4 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 4 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>

<% if totalpigsStuds > 0 then %>
<tr><td><a name= "Pigs "></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">PigStuds</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 12 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 12 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>
</td></tr></table>
<% end if%>




<% if totalSheepstuds > 0 then %>
<tr><td><a name= "Sheep"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Sheep for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 10 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 10 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>
</td></tr></table>
<% end if%>


</td></tr></table>

</td></tr></table>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>