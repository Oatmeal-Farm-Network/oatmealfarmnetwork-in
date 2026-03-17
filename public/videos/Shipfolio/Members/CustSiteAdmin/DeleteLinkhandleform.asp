<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Delete Link</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

dim ID

	ID=Request.Form("ID" ) 
	
	Query =  "Delete * From Links where LinkID = " +  ID + "" 
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 

	Query =  "Delete * From ProductsPhotos where ID = " &  ID & "" 
    
	response.write(query)
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 


	
	
IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your Link has successfully been deleted.")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<!--#Include file="LinkMaintenanceInclude.asp"-->

<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
