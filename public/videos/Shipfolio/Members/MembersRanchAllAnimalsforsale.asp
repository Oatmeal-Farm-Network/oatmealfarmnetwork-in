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
if PageBackgroundColor= "Black" Then
TitleColor = "white"
PageTextColor = "white"
end if 
%>
<style>
H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 15pt arial; color: Black}
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
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
<table height = "400" width = "750"><tr><td valign = "top">      
<%
dim Layout
target = request.querystring("target")
Layout = request.querystring("Layout")
if len(Layout) = 0 then
Layout=2 
end if
SortOrder = request.form("SortOrder")
Sortby = "Price Asc"
if SortOrder = "Name" or len(SortOrder) < 3 then Sortby = "FullName Asc"
if SortOrder = "Price - Ascending" or len(SortOrder) < 3 then Sortby = "Price Asc"
if SortOrder = "Price - Descending" or len(SortOrder) < 3 then Sortby = "Price Desc"
if SortOrder = "Color" or len(SortOrder) < 3 then Sortby = "Color1"
if SortOrder = "DOB" or len(SortOrder) < 3 then Sortby = "DOBYear Desc, DOBMonth Desc, DOBYear Desc"
%>
<%Current3 = "Animals" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" width = "700"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" valign = "top">
<tr><td class = "body" valign = "top">
<% Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  %> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "750" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Animals for Sale</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
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
<% if len(Layout) < 1 then layount=1 %>
<form  action="RanchAllAnimalsforSale.asp?target=<%=Target %>&Layout=<%=Layout%>&CurrentPeopleID=<%=CurrentPeopleID %>" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "700" align = "right">
<tr>
<td width="500">
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishForSale = true  and AGBrokered = True order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishForSale = true  and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="HEMalesforsale"></a>
<h3>Huacaya Experienced Males - Herdsires</h3>
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishForSale = true and AGBrokered = true order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishForSale = true and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="HIMalesforsale"></a>
<h3>Huacaya Inexperienced Males - Jr. Herdsires & Juvenile Males</h3>
<%   
DetailType = "Sire" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
<% end if
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Female' and PublishForSale = true and AGBrokered= True" 
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Female' and PublishForSale = true  and PeopleID= " & CurrentPeopleID
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="HEFemalesforsale"></a>
<h3>Huacaya Experienced Females - Dams</h3>
<%   
DetailType = "Dam" 
if len(trim(Layout)) > 0 then
else
layount=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>

<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'huacaya' and AGBrokered = True order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="HIFemalesforsale"></a>
<h3>Huacaya Inexperienced Females - Maidens</h3>
<%   
DetailType = "Dam" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Non-Breeder' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Non-Breeder' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="HNBforsale"></a>
<h3>Non-Breeding Huacayas</h3>
<%   
DetailType = "Sire" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Experienced Male' and PublishForSale = true and breed = 'Suri' and AGBrokered= True  order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Experienced Male' and PublishForSale = true and breed = 'Suri' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="SEMalesforsale"></a>
<h3>Suri Experienced Males - Herdsires</h3>
<%   
DetailType = "Sire" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Inexperienced Male' and PublishForSale = true and breed = 'Suri' and AGBrokered= True order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Inexperienced Male' and PublishForSale = true and breed = 'Suri' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="SIMalesforsale"></a>
<h3>Suri Inexperienced Males - Jr. Herdsires & Juvenile Males</h3>
<%   
DetailType = "Sire" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Experienced Female' and PublishForSale = true and breed = 'Suri' and AGBrokered = True order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Experienced Female' and PublishForSale = true and breed = 'Suri' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="SEFemalesforsale"></a>
<h3>Suri Experienced Females - Dams</h3>
<%   
DetailType = "Dam" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'Suri' and AGBrokered= True order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and  Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'Suri' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="SIFemalesforsale"></a>
<h3>Suri Inexperienced Females - Maidens</h3>
<%   
DetailType = "Dam" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
<%
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Non-Breeder' and PublishForSale = true and breed = 'Suri' and AGBrokered= True order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Non-Breeder' and PublishForSale = true and breed = 'Suri' and PeopleID= " & CurrentPeopleID & " order by " & Sortby
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="SNBforsale"></a>
<h3>Non-Breeding Suris</h3>
<%   
DetailType = "Sire" 
if len(trim(Layout)) > 0 then
else
layount=2 
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
</table>
</td></tr>  
</table>
</td></tr></table>
</td></tr></table>
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>