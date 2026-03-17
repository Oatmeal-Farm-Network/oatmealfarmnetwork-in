<!DOCTYPE HTML >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>The Andresen Group Content Management System</title>
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
	<!--#Include file="AdminGlobalVariables.asp"--> 
<%

dim ID
    ID=Request.Form("ID")
	'response.write("ID = " & ID & "<br>")
If Len(ID) < 0 Then
  ID = 0
End if
Query =  " UPDATE People Set FeaturedHerdsire = " & ID & " " 
Query =  Query + " where peopleID = 695;" 

'response.write("Query = " & Query & "<br>")	

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 

response.redirect("AdminHomePage.asp#TextBlock4")
%>
</BODY>
</HTML>
