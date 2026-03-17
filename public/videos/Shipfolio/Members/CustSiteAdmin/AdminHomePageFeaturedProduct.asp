<!DOCTYPE HTML >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The Andresen Group Content Management System</title>
		<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body >
<%


dim ID

	ID=Request.Form("ID")
If Len(ID) < 0 Then
  ID = 0
End if
Query =  " UPDATE People Set FeaturedProduct = " & ID & " " 
Query =  Query + " where peopleID = 667;" 


response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 

response.redirect("AdminHomePage.asp#TextBlock3")
%>
</BODY>
</HTML>
