<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Products Description Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" height = "600">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ProductID(400)
dim FullName(400)
dim Comments(400)
dim CriaText(400)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	ProductIDcount = "ProductID(" & rowcount & ")"	
	FullNamecount = "Name(" & rowcount & ")"
	Commentscount = "Comments(" & rowcount & ")"
	CriaTextcount = "CriaText(" & rowcount & ")"
	
	ProductID(rowcount)=Request.Form(ProductIDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	Comments(rowcount)=Request.Form(Commentscount) 
	CriaText(rowcount)=Request.Form(CriaTextcount) 	
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = CriaText(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CriaText(rowcount)= Replace(str1, "'", "''")
End If

str1 = Comments(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Comments(rowcount)= Replace(str1, "'", "''")
End If

	Query =  " UPDATE Products Set Description = '" +  Comments(rowcount) + "' "
    Query =  Query + " where productID = " + productID(rowcount) + ";" 

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
			<br><a  class = "Links" href="ProductDescriptions.asp"> Return to the Product Description Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
