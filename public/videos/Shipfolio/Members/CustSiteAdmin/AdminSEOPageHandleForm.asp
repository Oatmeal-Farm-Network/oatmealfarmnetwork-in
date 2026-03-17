<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="AdminGlobalVariables.asp"-->
<%
Dim PageName 
Dim PageTitle
Dim PageText
Title = Request.Form("Title") 
Description = Request.Form("Description") 
rowcount = 1
PageLayoutID = Request.Form("PageLayoutID") 
ID = Request.Form("ID")  
 'response.write("title=")
'response.write(title)
Dim str1
Dim str2
str1 = Title
str2 = "'"
If InStr(str1,str2) > 0 Then
	Title= Replace(str1,  str2, "''")
End If  
str1 = Description 
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "''")
End If  
str1 = Description 
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  
str1 = Description 
str2 = vbtab
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 
str1 = Description 
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 
str1 =Description 
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;")
End If 
str1 = Description 
str2 = vbCr
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  
str1 = Description 
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  
str1 = Description 
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;")
End If 
str1 = Description 
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  
Query =  " UPDATE Pageseo Set Title = '" & Title & "' ,"
Query =  Query & " Description  = '" & Description  & "' "
Query =  Query & " where  pagelayoutid= " & PageLayoutID & ";" 
response.write("Query=" & Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 
rowcount= rowcount +1
DataConnection.Close
Set DataConnection = Nothing 
response.Redirect("AdminEditSEO.asp?PageLayoutID=" & PageLayoutID)
%></Body>
</HTML>
