<!DOCTYPE HTML>
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
Dim TotalCount
dim rowcount
dim PackageName
dim Price
dim Description

	PackageName=Request.Form("PackageName")
	Price=Request.Form("Price")
	Description=Request.Form("Description")
	'response.Write("PackageName = " & PackageName & " Price = " & price & " description = " & description & "<br>")
if len(PackageName) < 1 then
	response.write("<center>Your changes could not be made. Please enter a Package Name</center>")
else
    str1 = Description
    str2 = "'"
    If InStr(str1,str2) > 0 Then
	    Description= Replace(str1, "'", "''")
    End If

    str1 = PackageName
    str2 = "'"
    If InStr(str1,str2) > 0 Then
	    PackageName= Replace(str1, "'", "''")
    End If

Query =  "INSERT INTO Package (PackageName, Description, Price)" 
	Query =  Query + " Values ('" +  PackageName + "' ,"
	Query =  Query +   " '" + Description + "',"
    Query =  Query +   " '" + Price + "' )" 


'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")



Conn.Execute(Query) 

IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 
 End If

	Conn.Close
	Set Conn = Nothing 
end if 

response.redirect("AdminPackage.asp")
%>
</BODY>
</HTML>
