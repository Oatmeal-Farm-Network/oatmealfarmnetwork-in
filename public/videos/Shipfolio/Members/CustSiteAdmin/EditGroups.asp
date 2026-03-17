<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Edit Group Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim GroupID(300)
dim GroupName(300)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1
'response.write(TotalCount)
while (rowcount < TotalCount)
	GroupIDcount = "GroupID(" & rowcount & ")"	
	GroupNamecount = "GroupName(" & rowcount & ")"	
	
	GroupID(rowcount)=Request.Form(GroupIDcount) 
	GroupName(rowcount)=Request.Form(GroupNamecount) 
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

	Query =  " UPDATE Groups Set GroupName = '" +  GroupName(rowcount) + "' " 
	Query =  Query + " where GroupID = " + GroupID(rowcount) + ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 



DataConnection.Execute(Query) 

	  rowcount= rowcount +1
	Wend

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

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "body" href="Groups.asp"> Return to Groups Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
