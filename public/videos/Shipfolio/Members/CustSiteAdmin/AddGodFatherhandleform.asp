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
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td align = "left">
	<tr>
		<td Class = "body"colspan = "2">
			<H1>Edit Godfather Sale Information</H1>
<%

Dim TotalCount
dim rowcount
dim ID
dim FullName(40000)
dim Price(40000)
dim EndDate(40000)


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 0

	
	Pricecount = "Price(" & rowcount & ")"
	EndDatecount = "EndDate(" & rowcount & ")"
		
	ID=Request.Form("ID")
	Price(rowcount)=Request.Form(Pricecount) 
	EndDate(rowcount)=Request.Form(EndDatecount )
	
if len(ID) < 2 then
	response.write("<center>Your changes could not be made. Please select an Alpaca's Name</center>")
	
else

Query =  "INSERT INTO Godfather ( ID, EndDate)" 
	Query =  Query + " Values (" +  ID + ", "
    Query =  Query +   " '" + EndDate(rowcount) + "' )" 


'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



DataConnection.Execute(Query) 



IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 
end if 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "body" href="Godfather.asp"> Return to Godfather Page</a>
			<br>
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>
<br /><br />
  <!--#Include File="AdminFooter.asp"--></Body>
</HTML>
