<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Awards Edit Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ProductID(400)
dim ColorID(400)
dim Color(400)


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	ProductIDcount = "ProductID(" & rowcount & ")"	
	ColorIDcount = "ColorID(" & rowcount & ")"	
	Colorcount = "Color(" & rowcount & ")"
	
	ProductID(rowcount)=Request.Form(ProductIDcount) 
	ColorID(rowcount)=Request.Form(ColorIDcount) 
	Color(rowcount)=Request.Form(Colorcount) 


	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)


	Query =  " UPDATE ProductColor Set Color = '" +  Color(rowcount) + "'," 
    Query =  Query + "  ProductID = " + ProductID(rowcount) + "" 
	Query =  Query + " where ColorID = " + ColorID(rowcount) + ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



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

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  aClass = "Links" href="Colors.asp"> Return to Colors Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
