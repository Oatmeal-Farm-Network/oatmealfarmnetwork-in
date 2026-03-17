<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<% Current = "Ranches"%>
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
SpeciesID = 6
CurrentspeciesId = 6
CurrentBreed = "Goats"
CurrentBreedSingular = "Goat"
CurrentFile = "RanchGoats.asp"
CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
If Len(CurrentPeopleID) > 0 Then 
else
CurrentPeopleID=Request.Form("CurrentPeopleID") 
End if

If len(CurrentPeopleID) > 0 Then
else
'Response.Redirect("Default.asp")
End if
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
end if 
rs.close
if len(BusinessID) > 0 then
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
end if

if len(addressid) > 0 then
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
end if

%>
<title><%=StateName %>&nbsp; <%=CurrentBreed%> | <%= BusinessName %></title>
<meta name="description" content="<%=StateName %> <%=CurrentBreed%> at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %>. Presented by Livestock of America" >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="<%=StateName %> <%=CurrentBreed%>" >


<%

Set rs = Server.CreateObject("ADODB.Recordset")
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


SortOrder = request.form("SortOrder")
Sortby = "Price Asc"
if SortOrder = "Name" or len(SortOrder) < 3 then Sortby = "FullName Asc"
if SortOrder = "Price - Ascending" or len(SortOrder) < 3 then Sortby = "Price Asc"
if SortOrder = "Price - Descending" or len(SortOrder) < 3 then Sortby = "Price Desc"
if SortOrder = "Color" or len(SortOrder) < 3 then Sortby = "Color1"
if SortOrder = "DOB" or len(SortOrder) < 3 then Sortby = "DOBYear Desc, DOBMonth Desc, DOBYear Desc"
Current3 = CurrentBreed %>
</header>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&CurrentPeopleID=<%=CurrentPeopleID %>&Sort=<%=Sort %>&Layout=<%=Layout %>' );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include file="RanchHeader.asp"-->
<!--#Include file="RanchPagesTabsInclude.asp"-->


<% TotalAnimals = TotalGoats
TotalStuds = TotalGoatStuds 


Layout = request.querystring("Layout")
if len(Layout) = 0 then
Layout=2
end if
If screenwidth < 800 then
layout = 1
end if
%>


<!--#Include File="RanchAnimalPagesInclude.asp"--> 

<!--#Include virtual="/Footer.asp"--> 
</body>
</html>