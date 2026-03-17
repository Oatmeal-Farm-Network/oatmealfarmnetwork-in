<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
<body >
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
<%
OwnerPeopleID = 667

Query =  " UPDATE SiteDesignTemp Set Header = ''  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID  

'response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 


Query =  " UPDATE SiteDesignTemp Set Header = ''  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID  
DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 
Response.Redirect("AdminStandardStylesmaster.asp#images") %>
 </Body>
</HTML>
