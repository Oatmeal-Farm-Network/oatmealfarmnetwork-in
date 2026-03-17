<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Size Edit Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ProductID(400)
dim SizeID(400)
dim Size(400)
dim ExtraCost(400)


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	ProductIDcount = "ProductID(" & rowcount & ")"	
	SizeIDcount = "SizeID(" & rowcount & ")"	
	Sizecount = "Size(" & rowcount & ")"
	ExtraCostcount = "ExtraCost(" & rowcount & ")"
	
	ProductID(rowcount)=Request.Form(ProductIDcount) 
	SizeID(rowcount)=Request.Form(SizeIDcount) 
	Size(rowcount)=Request.Form(Sizecount) 
	ExtraCost(rowcount)=Request.Form(ExtraCostcount) 


	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)


	Query =  " UPDATE ProductSizes Set Size = '" +  Size(rowcount) + "'," 
    Query =  Query + "  ProductID = " + ProductID(rowcount) + "" 
	Query =  Query + " where SizeID = " + SizeID(rowcount) + ";" 

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
			<br><a  aClass = "Links" href="Sizes.asp"> Return to Sizes Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
