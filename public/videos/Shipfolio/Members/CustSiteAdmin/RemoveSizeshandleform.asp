<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Remove Size Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

	dim Sizeid

	Sizeid=Request.Form("Sizeid" ) 
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 





	Query =  "Delete * From ProductSizes where Sizeid = " +  Sizeid + "" 
'response.write(Query)
	DataConnection.Execute(Query) 

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 



IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your size has successfully been removed.")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="sizes.asp"> Return to the Sizes page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
