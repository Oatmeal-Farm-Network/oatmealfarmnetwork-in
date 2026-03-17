<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Delete Product Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" >

<!--#Include file="Header.asp"--> 
<!--#Include file="storeHeader.asp"--> 
<!--#Include file="globalvariables.asp"--> 

<table height = "300" align = "center">
	<tr>
		<td class = "body" align = "center" valign = "top">
        <br><br><br>
<%

dim ID

	ID=Request.Form("ID" ) 
	
	
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 





	Query =  "Delete * From sfProducts where prodID = " &  ID & "" 
	DataConnection.Execute(Query) 

		Query =  "Delete * From ProductsPhotos where ID = " &  ID & "" 
    
	

	DataConnection.Execute(Query) 


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your product listing has successfully been deleted.")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>


			<br><a  class = "Links" href="DeleteListing.asp">Click here to return to the delete Products page.</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include file="Footer.asp"--> </Body>
</HTML>
