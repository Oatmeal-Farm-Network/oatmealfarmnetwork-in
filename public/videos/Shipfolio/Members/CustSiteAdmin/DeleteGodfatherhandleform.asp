<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include File="AdminSecurityInclude.asp"--> 
<!--#Include File="AdminGlobalVariables.asp"--> 
<!--#Include File="AdminHeader.asp"--> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<tr><td Class = "body roundedtopandbottom" height = "600" valign = "top">
<%

dim ID

	ID=Request.Form("ID" ) 
	
	Query =  "Delete * From Godfather where ID = " +  ID + "" 
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 

Query =  "Update FemaleData Set ExternalStudID = 0 where ExternalStudID = " +  ID + "" 
    
	
	DataConnection.Execute(Query) 


	
	
IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your alpaca has successfully been deleted.")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="Godfather.asp"> Return to the Godfather Page</a>
			<br>
		</td>
	</tr>
</table>
  <!--#Include File="AdminFooter.asp"--></Body>
</HTML>
