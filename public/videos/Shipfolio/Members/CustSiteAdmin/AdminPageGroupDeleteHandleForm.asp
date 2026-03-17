<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" >

<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminHeader.asp"--> 

<%

	dim TempCategoryID

	PageGroupID=Request.Form("PageGroupID" ) 


	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 


	Query =  "Delete * From PageGroups where PageGroupID = " & PageGroupID 
	response.write(Query)
	DataConnection.Execute(Query) 


	DataConnection.Close
	Set DataConnection = Nothing 
response.redirect("AdminPagegroups.asp")
%>

</Body>
</HTML>