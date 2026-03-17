<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Specials Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim Special
dim Active

Special= Request.Form("Special")
Active= Request.Form("Active")


	Query =  " UPDATE SpecialsLookupTable Set Active = " &  Active & " " 
	Query =  Query & " where Special = '" & Special & "';" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath) & ";" 

DataConnection.Execute(Query) 



IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" height = "400" align = "center">
	<tr >
		<td align = "right" valign = "top">
			<%
			'response.write(special)
			
			If special = "GyroStyle" Then %>
				<br><a  class = "Links" href="Specials.asp"> Return to GyuroStyle Sale Admin Page</a>
			<% End If
					If special = "Auction" Then %>
					<br><a  class = "Links" href="auctions.asp"> Return to the Auctions Admin Page</a>
			<% End If
			      If special = "GodFather" Then %>
				<br><a  class = "Links" href="GodFather.asp"> Return to Godfather Sale Admin Page</a>
			<% End If 
			 If special = "IRS" Then %>
				<br><a  class = "Links" href="IRSAdmin.asp"> Return to IRS Sale Admin Page</a>
			<% End If %>

			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
