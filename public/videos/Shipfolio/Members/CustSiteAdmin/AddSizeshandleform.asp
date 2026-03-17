<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add Sizes Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%


Dim TotalCount
dim rowcount
dim ProductID
dim SizeID(400)
dim Size(400)
dim ExtraCost(400)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 0

	
	Sizecount = "Size(" & rowcount & ")"
	Placingcount = "Placing(" & rowcount & ")"
	ExtraCostcount = "ExtraCost(" & rowcount & ")"
		
	ProductID=Request.Form("ProductID")
	'response.write(ProductID)
	Size(rowcount)=Request.Form(Sizecount) 
	ExtraCost(rowcount)=Request.Form(ExtraCostcount)



if len(ProductID) < 1 then
	response.write("<center>Your changes could not be made. Please select an Product's Name</center>")
	
else



Query =  "INSERT INTO ProductSizes( ProductID, Size)" 
	Query =  Query + " Values (" +  ProductID + ", "
	Query =  Query +  " '" +  Size(rowcount)  + "' )" 


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
			<br><a  aClass = "Links" href="Sizes.asp"> Return to the Product Sizes Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
