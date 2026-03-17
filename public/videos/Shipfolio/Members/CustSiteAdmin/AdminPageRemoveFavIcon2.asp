<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<%
OwnerPeopleID = 667
Query =  " UPDATE People Set FavIcon = ''  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID 
Conn.Execute(Query) 

Set Conn = Nothing 
Response.Redirect("AdminUpdateHeader.asp")
%>
</Body>
</HTML>
