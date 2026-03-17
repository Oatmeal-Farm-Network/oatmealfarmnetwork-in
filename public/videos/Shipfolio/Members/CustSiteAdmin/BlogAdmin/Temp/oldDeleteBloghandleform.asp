<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Delete Article</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY bgcolor = "white">
<!--#Include file="globalvariables.asp"--> 
<!--#Include file="Header.asp"--> 
<%

dim TempBlogID

	TempBlogID=Request.Form("BlogID" ) 
	
	Query =  "Delete * From Blog where BlogID = " &  TempBlogID & "" 
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 



	

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

response.redirect("BlogDelete.asp")
%>

 </Body>
</HTML>
