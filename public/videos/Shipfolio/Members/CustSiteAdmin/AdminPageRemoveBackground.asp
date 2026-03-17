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
Query =  " UPDATE SiteDesignTemp Set PageBackgroundImage = ''  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID 

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

DataConnection.Execute(Query) 
Query =  " UPDATE SiteDesignTemp Set PageBackgroundImage = ''  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID 
DataConnection.Execute(Query) 
	DataConnection.Close
	Set DataConnection = Nothing 
	Response.Redirect("AdminStandardStylesmaster.asp#images")
%>


 </Body>
</HTML>
