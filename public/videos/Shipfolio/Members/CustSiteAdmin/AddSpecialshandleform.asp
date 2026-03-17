<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add Specials Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID
dim FullName
dim Price
dim Week


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 0

		
	ID=Request.Form("ID")
	week=Request.Form("Week")
	Price=Request.Form("Price")

	
if len(ID) < 1 then
	response.write("<center>Your changes could not be made. Please select an Alpaca's Name</center>")
	
else

Query =  "INSERT INTO Specials ( ID, Price, Week)" 
	Query =  Query + " Values (" +  ID + " ,"
	Query =  Query +  " '" + Price + "', " 
    Query =  Query +   " '" + Week + "' )" 


'response.write(Query)	

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
end if 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "Links" href="Specials.asp"> Return to Specials Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
