<!DOCTYPE HTML >
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminHeader.asp"--> 
 
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



Conn.Execute(Query) 

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

	Conn.Close
	Set Conn = Nothing 
response.redirect("AdminPackage.asp")
%>

</BODY>
</HTML>
