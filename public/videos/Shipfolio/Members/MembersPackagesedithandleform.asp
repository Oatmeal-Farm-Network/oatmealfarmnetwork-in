<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Packages Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">

<!--#Include virtual="/Membersistration/Header.asp"--> 
<%
dim PackageID(200)
dim PackageName(200)
dim PackagePrice(200)
dim Description(200)
Dim TotalCount
dim rowcount

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	PackageIDcount = "PackageID(" & rowcount & ")"	
	PackageNamecount = "PackageName(" & rowcount & ")"
	PackagePricecount = "PackagePrice(" & rowcount & ")"
	Descriptioncount = "Description(" & rowcount & ")"


	PackageID(rowcount)=Request.Form(PackageIDcount) 
	PackageName(rowcount)=Request.Form(PackageNamecount) 
	PackagePrice(rowcount)=Request.Form(PackagePricecount )
	Description(rowcount)=Request.Form(Descriptioncount )
	rowcount = rowcount +1



Wend

 rowcount =1




while (rowcount < TotalCount)

str1 = Description(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description(rowcount)= Replace(str1, "'", "''")
End If


str1 = PackageName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	PackageName(rowcount)= Replace(str1, "'", "''")
End If


	Query =  " UPDATE Package Set PackageName = '" +  PackageName(rowcount) + "', " 
    Query =  Query + "  Price = '" + PackagePrice(rowcount) + "', " 
	Query =  Query + "  Description = '" + Description(rowcount) + "' " 
	Query =  Query + " where PackageID = " + PackageID(rowcount) + ";" 

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
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

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
