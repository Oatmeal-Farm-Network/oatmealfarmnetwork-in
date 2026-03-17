<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Minutes</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


		<!--#Include virtual="/Administration/Header.asp"--> 
		<!--#Include virtual="/Administration/NewsHeader.asp"--> 
<%

		Dim NewsTitle2
		Dim	NewsDate2
		Dim	NewsText2

		NewsTitle2=Request.Form("NewsTitle")
		NewsDate2=Request.Form("NewsDate")
		NewsText2=Request.Form("NewsText")

str1 = NewsTitle2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1, str2 , vbCrLf)
End If  


str1 = NewsTitle2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, " ")
End If 

str1 = NewsTitle2
str2 = "'"
If InStr(str1,str2) > 0 Then
	NewsTitle2= Replace(str1,  str2, "''")
End If 


str1 = NewsText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1, str2 , vbCrLf)
End If  


str1 = NewsText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, " ")
End If 

str1 = NewsText2
str2 = "'"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "''")
End If 





		If Not session("NewsTitle") =NewsTitle2 And ( Len(NewsTitle2) > 0 Or Len(NewsDate2) > 0 Or Len(NewsText2) > 0 )  then
		session("NewsTitle") = NewsTitle2
	

		Query =  "INSERT INTO News (NewsTitle, NewsDate, NewsText)" 
		Query =  Query + " Values ('" &  NewsTitle2 & "' ,"
		Query =  Query +   " '" & NewsDate2 & "' ," 
		Query =  Query +   " '" & NewsText2 & "' )" 


'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



DataConnection.Execute(Query) 






	DataConnection.Close
	Set DataConnection = Nothing 
	%>
	<big><B>Your News Article Has Been Added</B></big>
<% end if 
%>

 <!--#Include virtual="/administration/AddNewsInclude.asp"--> 

 <!--#Include virtual="/administration/Footer.asp"--> 
</BODY>
</HTML>
