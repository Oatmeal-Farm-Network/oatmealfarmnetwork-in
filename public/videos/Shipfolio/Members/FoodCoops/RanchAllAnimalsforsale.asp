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
<meta name="subject" content="<%=StateName %> Animals, <%=StateName %> Animals for Sale" >


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
Current3 = "AnimalsForSale" %>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
<!--#Include file="RanchPagesTabsInclude.asp"-->
<% 'screenwidth = screenwidth - 50%>
<table width = "<%=screenwidth  %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" >
<H1>Animals for Sale</h1>
</td></tr>
<tr><td class = "roundedBottom" align = "left" height = "530" valign = "top">



<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" valign = "top" width = "<%=screenwidth -30 %>">
<tr><td class = "body">
<% if totalAlpacas > 0 then %>
<a href = "#Alpacas" class = "body">Alpacas for Sale</a> | 
<% end if %>
<% if totalcattle > 0 then %>
<a href = "#cattle" class = "body">Cattle For Sale</a> | 
<% end if %>
<% if totalDogs > 0 then %>
<a href = "#Dogs" class = "body">Working Dogs For Sale</a> | 
<% end if %>
<% if totalDonkeys > 0 then %>
<a href = "#Donkey" class = "body">Donkeys For Sale</a> | 
<% end if %>
<% if totalgoats > 0 then %>
<a href = "#Goats" class = "body">Goats For Sale</a> | 
<% end if %>
<% if totalhorses > 0 then %>
<a href = "#Horses" class = "body">Horses For Sale</a> | 
<% end if %>
<% if totalllamas> 0 then %>
<a href = "#Horses" class = "body">Llamas For Sale</a> | 
<% end if %>
<% if totalllamas> 0 then %>
<a href = "#Llamas" class = "body">Llamas For Sale</a> | 
<% end if %>
<% if totalpigs > 0 then %>
<a href = "#pigs" class = "body">Pigs For Sale</a> | 
<% end if %>
<% if totalSheep > 0 then %>
<a href = "#Sheep" class = "body">Sheep For Sale</a> | 
<% end if %>
<% Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  %> 
<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "right" valign = "top">
<tr><td class = "body">View:</td><td>
<form name="Layoutform1" action="RanchAllAnimalsforSale.asp?Layout=1&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST">
<input type="image" src="/images/PageLayout1.jpg" name="image" width="35" height="28" alt = "Standard"></td>
</form>
<td>
<form name="Layoutform2" action="RanchAllAnimalsforSale.asp?Layout=2&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST">
<input type="image" src="/images/PageLayout2.jpg" name="image" width="35" height="28" alt = "Gallery"></form>
</td>
<td>
<form name="Layoutform3" action="RanchAllAnimalsforSale.asp?Layout=3&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST">
<input type="image" src="/images/PageLayout3.jpg" name="image" width="35" height="28" alt = "List"></form></td>
<td width = "5">
</td></tr></table>
<INPUT TYPE="image" SRC="images/px.gif" HEIGHT="1" WIDTH="1" BORDER="0" ALT="Submit Form">
<% if len(Layout) < 1 then layount=2 %>
<form  action="RanchAllAnimalsforSale.asp?target=<%=Target %>&Layout=<%=Layout%>&CurrentPeopleID=<%=CurrentPeopleID %>" method = "post">
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
<% if totalAlpacas > 0 then %>
<tr><td><a name= "Alpacas"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Alpacas for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<% 
CurrentspeciesId = 2
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>



<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment of Alpacas</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

</td></tr>

</td></tr></table>
<% end if%>

<% if totalCattle > 0 then %>
<tr><td><a name= "cattle"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Cattle for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% 
CurrentspeciesId = 8
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and (category = 'Non-Breeder' or category = 'Non-Breeders')  and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment of Cattle</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>

<% if totalDogs > 0 then %>
<tr><td><a name= "Dogs"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Working Dogs for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% 
CurrentspeciesId = 3
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>



<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

</td></tr>

</td></tr></table>
<% end if%>

<% if totalDonkeys > 0 then %>
<tr><td><a name= "Donkey"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Donkeys for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% 
CurrentspeciesId =7
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

</td></tr>

</td></tr></table>
<% end if%>

<% if totalGoats > 0 then %>
<tr><td><a name= "Goats"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Goats for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% 
CurrentspeciesId = 6
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>



<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 

'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


</td></tr>

</td></tr></table>
<% end if%>


<% if totalhorses > 0 then %>
<tr><td><a name= "Horses"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Horses for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% 
CurrentspeciesId = 5
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

</td></tr>

</td></tr></table>
<% end if%>

<% if totalllamas > 0 then %>
<tr><td><a name= "Llamas"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Llamas for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% 
CurrentspeciesId = 4
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

</td></tr>

</td></tr></table>
<% end if%>

<% if totalPigs > 0 then %>
<tr><td><a name= "Pigs "></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Pigs for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">


<% 
CurrentspeciesId = 12
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>



<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment of Pigs</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr></table>
<% end if%>


<% if totalSheep > 0 then %>
<tr><td><a name= "Sheep"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Sheep for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% 
CurrentspeciesId = 10
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Experienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><h3>Experienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Females for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Non-Breeding / Fiber / Pet Quality Animals for Sale</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Preborn Babies</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment</h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr></table>
<% end if%>


</td></tr></table>

</td></tr></table>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>