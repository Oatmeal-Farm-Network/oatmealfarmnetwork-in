<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Delete Product Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

dim ID

	ID=Request.Form("ID" ) 
	
	
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 




	Query =  "Delete * From Products where ProductID = " +  ID + "" 
		DataConnection.Execute(Query) 

	Query =  "Delete * From ProductsAdditionalPhotos where ID = " +  ID + "" 
	DataConnection.Execute(Query) 


	Query =  "Delete * From ProductColor where ProductID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From ProductSizes where ProductID = " +  ID + "" 
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
			<br><a  class = "Links" href="AddProduct.asp#Delete"> Return to the delete an product page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
