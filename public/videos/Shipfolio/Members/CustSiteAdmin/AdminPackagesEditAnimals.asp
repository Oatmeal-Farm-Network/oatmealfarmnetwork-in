<!DOCTYPE HTML >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>

<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include virtual="/Administration/Header.asp"--> 
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




Conn.Execute(Query) 


		
		Conn.Execute(Query) 
	  rowcount= rowcount +1
	Wend

Conn.Close
	Set Conn = Nothing 
 %>

<%
     response.redirect("Packages.asp")
  %></H2>

<%

 

	

%>

 </Body>
</HTML>
