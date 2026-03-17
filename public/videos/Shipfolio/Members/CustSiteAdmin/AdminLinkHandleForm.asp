<!doctype html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The Andresen Group Content Management System</title>
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include File="AdminGlobalVariables.asp"--> 

<%
CategoryName =   request.form("CategoryName")
LinkImage =    request.form("LinkImage")
LinkText =   request.form("LinkText")
LinkID=    request.form("LinkID")
Linkdescription =    request.form("LinkDescription")
CatID =   request.form("CatID")
Link =   request.form("Link")
LinkShowOnfooter = request("LinkShowOnfooter")

str1 = LinkDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkDescription= Replace(str1, "'", "''")
End If

str1 = Link
str2 = "'"
If InStr(str1,str2) > 0 Then
	Link= Replace(str1, "'", "''")
End If

str1 = lcase(Link)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	Link= Replace(str1, "http://", "")
End If


str1 = LinkText
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkText= Replace(str1, "'", "''")
End If


	Query =  " UPDATE Links Set CatID = " & catID & ","
	Query =  Query & " link = '" & Link & "'," 
	Query = Query & " LinkShowOnfooter = " & LinkShowOnfooter & ","
	Query =  Query & " LinkText = '" & LinkText & "'," 
	Query =  Query & " linkDescription = '" & LinkDescription & "'" 
    Query =  Query & " where LinkID = " & LinkID & ";" 
response.write(Query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath)& ";" 



DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 

Response.Redirect("AdminLinkEdit.asp?LinkID=" & LinkID)
%>
</Body>
</HTML>
