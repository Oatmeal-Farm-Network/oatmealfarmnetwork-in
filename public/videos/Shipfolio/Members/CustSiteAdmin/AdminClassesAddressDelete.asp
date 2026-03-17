<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
 </head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>

<% Current = "admin" %>
<!--#Include file="AdminHeader.asp"-->
<% Current = "Classes"
Current3 = "Delete Addresses"  %>
<!--#Include File ="ClassesHeader.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 class ="roundedtopandbottom" width = "<%=screenwidth%>" >
<tr><td height = "560" valign = "top">

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body">
<H2>Delete a User</H2>
</td></tr></table>
<%  
dim AddressIDArray(5000) 
dim AddresstitleArray(5000) 
		
sql2 = "select * from Address where not(addressID = 420) and not(addressID = 419) and not(addressID = 419) order by AddressTitle"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   

While Not rs2.eof  
AddressIDArray(acounter) = rs2("AddressID")
AddresstitleArray(acounter) = rs2("Addresstitle")
acounter = acounter +1
rs2.movenext
Wend %>
<form action= 'AdminClassesAddressDeletehandleform.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td colspan ="30">
&nbsp;
</td>
<td class = "body">
<br>Select an address:
<select size="1" name="AddressID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddresstitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value = "Delete" class = "regsubmit2" >
</td></tr></table>
</form>
</td></tr></table>

<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>