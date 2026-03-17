<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
</head>
<BODY bgcolor = "white">
<!--#Include file="AdminGlobalVariables.asp"-->
<%
 dim ID
ID=Request.Form("ID" ) 
Query =  "Delete * From Events where EventsID = " &  ID & "" 

response.write("Query =" & Query  )
 Set DataConnection = Server.CreateObject("ADODB.Connection")
 DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close

response.redirect("EventsDelete.asp#Block" & ID )
  %>
 </Body>
</HTML>
