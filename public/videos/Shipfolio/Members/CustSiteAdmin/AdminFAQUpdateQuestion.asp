<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <Link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body >

    <!--#Include file="AdminsecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include file="AdminHeader.asp"--> 
    
<%
	Dim TextBlock
	Question= Request.Form("Question")
	Answer = Request.Form("Answer")

FAQID= Request.Form("FAQID")


	str1 = Question
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Question= Replace(str1, "'", "''")
	End If

	str1 = Question
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Question= Replace(str1, "'", "''")
	End If


str1 = Answer
str2 = "'"
If InStr(str1,str2) > 0 Then
	Answer= Replace(str1, "'", "''")
End If

str1 = Answer
str2 = "'"
If InStr(str1,str2) > 0 Then
	Answer= Replace(str1, "'", "''")
End If


Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath)& ";" 


		Query =  " UPDATE FAQ Set Question = '" &Question & "', "
		Query =  Query & " Answer = '" & Answer & "'"
		Query =  Query & " where FAQID = " & FAQID & ";" 
		response.write(Query)
		
		DataConnection.Execute(Query) 



	DataConnection.Close
	Set DataConnection = Nothing 
Response.Redirect("AdminFAQ.asp#Update")
%>


</Body>
</HTML>
