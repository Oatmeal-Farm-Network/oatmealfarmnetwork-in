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
ClassInfoID=Request.Form("ClassInfoID") 
if len(ClassInfoID) > 0 then
Query =  "Delete * From ClassInfo where ClassInfoID = " & ClassInfoID & "" 

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing
else
response.redirect("AdminClassesDelete.asp")
end if
%>
<center><h2>Your class has been deleted.</h2><br />
Click <a href= "AdminClassesDelete.asp" class = "body">here<a> <font class = "body">to delete another class.</font>
</center></td></tr></table>	
<!--#Include file="adminFooter.asp"-->
 </Body>
</HTML>
