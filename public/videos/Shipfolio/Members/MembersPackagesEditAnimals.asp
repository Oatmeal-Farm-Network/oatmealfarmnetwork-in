<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>General Animal Data Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" height = "600">

<!--#Include virtual="/Membersistration/Header.asp"--> 
<%

Dim TotalCount
dim	rowcount
dim	ID(40000) 
Dim PackageID(40000)


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
    IDcount = "ID(" & rowcount & ")"
	PackageIDcount = "PackageID(" & rowcount & ")"

	ID(rowcount)=Request.Form(IDcount) 
	PackageID(rowcount)=Request.Form(PackageIDcount) 
	rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount)


if PackageID(rowcount) = "" then
	PackageID(rowcount) = "0"
end if



	Query =  " UPDATE Animals Set  PackageID = " &  PackageID(rowcount) & "," 
	  Query =  Query + " where ID = " & ID(rowcount) & ";" 

'response.write(Query)
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 


DataConnection.Execute(Query) 


		
		DataConnection.Execute(Query) 
	  rowcount= rowcount +1
	Wend

DataConnection.Close
	Set DataConnection = Nothing 
 %>

<%
     response.redirect("Packages.asp")
  %></H2>

<%

 

	

%>

 </Body>
</HTML>
