<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add Package Name Results Page</title>
       <link rel="stylesheet" type="text/css" href="/core-styles.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim PackageName
dim Price


	ID=Request.Form("PackageName")
	ID=Request.Form("Price")
	
	
if len(PackageName) < 1 then
	response.write("<center>Your changes could not be made. Please enter a Package Name</center>")
	
else

Query =  "INSERT INTO Package (PackageName, Price)" 
	Query =  Query + " Values (" +  PackageName + " ,"
    Query =  Query +   " '" + Price + "' )" 


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
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 
end if 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "Links" href="Packages.asp"> Return to Packages Page</a>
			<br>
		</td>
	</tr>
</table>
</BODY>
</HTML>
