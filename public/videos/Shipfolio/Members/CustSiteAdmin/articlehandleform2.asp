<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Articles</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 
<%
	Dim TextBlock
	TextBlock= Request.Form("TextBlock")
	Text = Request.Form("Text")
	ArticleID = Request.Form("ArticleID")
	Heading = Request.Form("Heading")
AuthorLink= Request.Form("AuthorLink")
ArticleCatID= Request.Form("ArticleCatID")
textblocknum= Request.Form("textblocknum")


	str1 = Heading
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1, "'", "''")
	End If

	str1 = Heading
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1, "'", "''")
	End If


str1 = Text
str2 = "'"
If InStr(str1,str2) > 0 Then
	Text= Replace(str1, "'", "''")
End If

str1 = Text
str2 = "'"
If InStr(str1,str2) > 0 Then
	Text= Replace(str1, "'", "''")
End If


Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath)& ";" 

	If TextBlock = "Heading" Then 
		Query =  " UPDATE Articles Set ArticleHeadline = '" & Text & "',"
		Query =  Query & " AuthorLink = '" & AuthorLink & "',"
		Query =  Query & " ArticleCatID = " & ArticleCatID & ""
		Query =  Query & " where ArticleID = " & ArticleID & ";" 
		'response.write(Query)
		
		DataConnection.Execute(Query) 

	End If 

	
If Not (TextBlock = "Heading") Then 
pageheadingName = "Pageheading" & textblocknum
ArticleTextName = "ArticleText" & textblocknum
		Query =  " UPDATE Articles Set " & pageheadingName  & " = '" & Heading& "', "
		Query =  Query & ArticleTextName & "= '" & Text & "'"
		Query =  Query & " where ArticleID = " & ArticleID & ";" 
		response.write(Query)
		
		DataConnection.Execute(Query) 
End if


	DataConnection.Close
	Set DataConnection = Nothing 
Response.Redirect("ArticleMantainance2.asp?ArticleID=" & Session("ArticleID") & "#TextBlock" & textblocknum)
%>

<!--#Include file="Footer.asp"--> 
</Body>
</HTML>
