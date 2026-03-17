<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">

</HEAD>
<body >
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->
 
<%
Question=Request.Form("Question")
Answer=Request.Form("Answer")


if len(Question) < 1 and len(Answer) < 1 then
	response.redirect("AdminFAQ.asp#Add" )
else

str1 = Question
str2 = "'"
If InStr(str1,str2) > 0 Then
	Question= Replace(str1, "'", "''")
End If

str1 = Answer
str2 = "'"
If InStr(str1,str2) > 0 Then
	Answer = Replace(str1, "'", "''")
End If


Query =  "INSERT INTO FAQ (Question, Answer)" 
Query =  Query & " Values ('" &  Question & "' ,"
Query =  Query &   " '" & Answer & "' )" 
Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 
	
response.redirect("AdminFAQ.asp#Add" )
 End If
 
 
 %>

</BODY>
</HTML>