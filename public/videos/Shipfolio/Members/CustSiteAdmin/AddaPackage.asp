<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add Package Name Results Page</title>
     <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim PackageName
dim Price
dim Description

	PackageName=Request.Form("PackageName")
	Price=Request.Form("Price")
	Description=Request.Form("Description")
	
if len(PackageName) < 1 then
	response.write("<center>Your changes could not be made. Please enter a Package Name</center>")
	
else
str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, "'", "''")
End If

str1 = PackageName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PackageName= Replace(str1, "'", "''")
End If

str1 = Price
str2 = "'"
If InStr(str1,str2) > 0 Then
	Price= Replace(str1, "'", "''")
End If

Query =  "INSERT INTO Package (PackageName, Description, Price)" 
	Query =  Query + " Values ('" +  PackageName + "' ,"
	Query =  Query +   " '" + Description + "',"
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
