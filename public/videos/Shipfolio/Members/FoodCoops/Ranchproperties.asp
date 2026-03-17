<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("PeopleID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.querystring("custID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
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
'response.write (sql)
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
<title><%= BusinessName %> | <%=StateName %> Properties for Sale</title>
<meta name="Title" content="<%= BusinessName %> | <%=StateName %> Properties for Sale">
<meta name="description" content="<%=StateName %> Properties at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %> presented by Livestock of America - Online Animal marketplace.  " >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="<%=StateName %> Animals, <%=StateName %> Animals for Sale" >
<link rel="stylesheet" type="text/css" href="/style.css">
</head>
<BODY onload="addEvents();" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
 <% Current3 = "Properties" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
	<tr>
	<td class = "roundedtopandbottom" align = "left" >
<% aboutuswidth = "700" 
dim buttonimages(20)
dim buttontitle(20) 
Dim sSize(200)
Dim sExtraCost(200)
Dim cColor(200)
Dim Description
 Dim FoundBut(10)
%>
<a name="top"></a>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "<%=screenwidth %>" class = "roundedtopandbottom">
<tr><td class = "body" valign = "top"  align = "center"  height = "83">
<h1>Ranches for Sale</h1>
<br>
<%	SCounter = 0
If not rs.State = adStateClosed Then
rs.close
End If   	
sql = "SELECT distinct  * FROM Properties, People, PropertyPhotos WHERE Properties.peopleID = people.peopleID and Properties.propID = PropertyPhotos.propID and Propforsale = true  and properties.PeopleID = " & PeopleID & " order by propPrice DESC " 
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3  
If rs.eof then %>
<h2>Currently there no properties listed.</h2>
<% else %>
<!--#Include file="PropertiesDetailInclude.asp"--> 
<br><br>	
<% End if %>
<br><br>
<div align = "center"><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></div><br><br>
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>