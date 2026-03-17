<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
 </head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>

<% Current = "admin" %>
<!--#Include file="AdminHeader.asp"-->
<% Current = "Classes"
Current3 = "Delete Addresses"  %>
<!--#Include File ="ClassesHeader.asp"-->
 <table border = "0" class = "roundedtopandbottom" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>">
<tr><td class = "body" valign = "top" height = "400">
<%
AddressID=Request.Form("AddressID") 
if len(AddressID) > 0 then
Query =  "Delete * From Address where AddressID = " & AddressID & "" 

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing
else
response.redirect("AdminClassesAddressDelete.asp")
end if
%>
<center><h2>Your address has been deleted.</h2><br />
Click <a href= "AdminClassesAddressDelete.asp" class = "body">here<a> <font class = "body">to delete another address.</font>
</center></td></tr></table>	
<!--#Include file="adminFooter.asp"-->
 </Body>
</HTML>
