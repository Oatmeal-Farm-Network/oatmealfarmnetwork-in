<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Update Password</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">



<!--#Include virtual="/Administration/Header.asp"--> 
<table width = "720" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	<!--#Include virtual="/Administration/AdminSideMenu.html"--> 
		
<td class = "body" valign = "top">
<table  align = "center" height = "300">
	<tr >
		<td align = "center" class = "body" valign = "top">
<%

Dim Password
Password = Request.Form("Password") 

	Query =  " UPDATE sfCustomers Set custPasswd = '" &  Password & "' " 
    Query =  Query + " where CustID = " & session("CustID") & ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 




 %>
<div align = "center"><H2>
<%
     response.write("Your Password has Been Changed.")
  %></H2>

<%


	DataConnection.Close
	Set DataConnection = Nothing 

%>


			<br><a  class = "Links" href="default.asp"> Click here to return to the admin home page</a>
			<br>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
