<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">

<BODY >

    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
     
<%

dim ID

	ID=Request.Form("ID" ) 
	
	Query =  "Delete * From ExternalStud where ExternalStudID = " +  ID + "" 
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 

Query =  "Update FemaleData Set ExternalStudID = 0 where ExternalStudID = " &  ID & "" 
    
	
	DataConnection.Execute(Query) 


	DataConnection.Close
	Set DataConnection = Nothing 
response.Redirect("AdminOutsideStud.asp")
%>

 </Body>
</HTML>
