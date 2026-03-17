<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminHeader.asp"--> <br />
    <% 
   Current2="Packages"
   Current3="PackageDelete" %> 


<!--#Include file="AdminPackagesTabsInclude.asp"-->
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Delete a Package</div></H1>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" width = "100%">
<%

dim PackageID

	PackageID=Request.Form("PackageID" ) 
	
	Query =  "Delete * From Package where PackageID = " +  PackageID + "" 
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	

	Conn.Execute(Query) 


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your package has successfully been deleted.")
  %></H2>
</div>
<%

 End If

	Conn.Close
	Set Conn = Nothing 

%>

<table width = "100%" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="AdminPackagesHome.asp">Go to the List of Packages Page</a>
			<br><br>
			<br>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<br><br>
<!--#Include file="adminFooter.asp"--> 
</BODY>
</HTML>
