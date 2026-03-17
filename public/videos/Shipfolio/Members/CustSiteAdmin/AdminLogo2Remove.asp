<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
 <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->

<%
OwnerPeopleID = 667

Query =  " UPDATE SiteDesigntemp Set logo = ' '  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID 

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 

	Query =  " UPDATE SiteDesign Set logo = ' '  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID 

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 


	DataConnection.Close
	Set DataConnection = Nothing 

	Response.Redirect("AdminStandardStylesmaster.asp#images") %>


 </Body>
</HTML>
