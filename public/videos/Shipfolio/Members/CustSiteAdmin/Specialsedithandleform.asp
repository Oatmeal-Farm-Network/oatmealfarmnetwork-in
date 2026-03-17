<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>GyuroStyle Results Page</title>
            <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID(200)
dim SpecialsID(200)
dim Price(200)
dim Week(200)
dim Pending(200)


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	SpecialsIDcount = "SpecialsID(" & rowcount & ")"	
	Pricecount = "Price(" & rowcount & ")"
	Weekcount = "Week(" & rowcount & ")"
	Pendingcount = "Pending(" & rowcount & ")"

	
	ID(rowcount)=Request.Form(IDcount) 
	SpecialsID(rowcount)=Request.Form(SpecialsIDcount) 
	Price(rowcount)=Request.Form(Pricecount) 
	Week(rowcount)=Request.Form(Weekcount )
	Pending(rowcount)=Request.Form(Pendingcount) 
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)


	Query =  " UPDATE Specials Set Price = '" +  Price(rowcount) + "', " 
	Query =  Query + " Week = '" +  Week(rowcount) + "'," 
    Query =  Query + " SalePending = " +   Pending(rowcount) + "," 
    Query =  Query + "  ID = " + ID(rowcount) + "" 
	Query =  Query + " where SpecialID = " + SpecialsID(rowcount) + ";" 

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
			<br><a  Class = "Links" href="Specials.asp"> Return to GyuroStyle Page</a>
			<br>
		</td>
	</tr>
</table>
</BODY>
</HTML>
