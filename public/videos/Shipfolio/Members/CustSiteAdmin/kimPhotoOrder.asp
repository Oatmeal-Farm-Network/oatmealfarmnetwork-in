<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Photo Order Results Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<table  width = "776"  align = "center" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 	cellpadding=0 cellspacing=0 >
	<tr>
		</td>
<%
Dim TotalCount
dim rowcount
dim PID(500)
dim Order(500)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)

rowcount = 1

while (rowcount < TotalCount)
PIDcount = "PID(" & rowcount & ")"
Ordercount = "Order(" & rowcount & ")"

PID(rowcount)=Request.Form(PIDcount) 
Order(rowcount)=Request.Form(Ordercount) 

rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)
   If Len(PID(rowcount)) > 0 Then
		
 
	Query =  " UPDATE AdditionalPhotos Set PhotoOrder = '" &  Order(rowcount) + "' " 
    Query =  Query + " where PhotoID = " & PID(rowcount) & ";" 
'response.write(Query)
   Else
      Query =  " UPDATE AdditionalPhotos Set PhotoOrder = '0' " 
       Query =  Query + " where PhotoID = " & PID(rowcount) & ";"  
'response.write(Query)
 End If 
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

</td>
</tr>
	<tr >
		<td align = "right">
			<br><a  class = "body" href="adminIloveAlpacas.asp"> Return to the I love alpacas admin Page</a>
			<br>
		</td>
	</tr>
</table>
</BODY>
</HTML>
