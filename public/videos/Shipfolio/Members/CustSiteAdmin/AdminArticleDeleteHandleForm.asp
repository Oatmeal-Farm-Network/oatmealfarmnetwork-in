<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>

<BODY bgcolor = "white">

    <!--#Include file="AdminsecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include file="AdminHeader.asp"--> 


<%

dim TempArticleID

	TempArticleID=Request.Form("ArticleID" ) 
	
	Query =  "Delete * From Articles where ArticleID = " &  TempArticleID & "" 
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 
response.redirect("AdminArticleDelete.asp?Message=Your Article has successfully been deleted.")
%>
 </Body>
</HTML>
