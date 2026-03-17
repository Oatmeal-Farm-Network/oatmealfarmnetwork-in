<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Associate PDF Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<table width = "776"  align = "center" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 	cellpadding=0 cellspacing=0 >
	<tr>
		</td>
<%

dim aID
dim PDF

	aID=Request.Form("AID") 
	PDF=Request.Form("PDF")

str1 = PDF
str2 = "'"
If InStr(str1,str2) > 0 Then
	PDF= Replace(str1, "'", "''")
End If

 

	Query =  "Insert into PDF (ID, PDF)"
	Query =  Query + " Values (" +  aID + "," 
	Query =  Query + " '" + PDF + "')" 
	


Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 

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

</td>
</tr>
	<tr >
		<td align = "right">
			<br><a href="PDFUpload.asp"> Return to the Associate PDF Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
