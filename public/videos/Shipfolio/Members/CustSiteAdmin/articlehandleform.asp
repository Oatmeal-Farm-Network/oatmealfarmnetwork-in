<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Articles</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 
<%
	Dim ArticleIDx
	dim ArticleHeadlinex
	dim ArticleTextx
	dim AuthorLinkx
	dim ArticleCatIDx


	dim TotalCount
	dim rowcount

	TotalCount= Request.Form("TotalCount")
	TotalCount = CInt(TotalCount)

	ArticleIDx = Request.Form("ArticleID")
	ArticleHeadlinex = Request.Form("ArticleHeadline")
	ArticleTextx = Request.Form("ArticleText")
	AuthorLinkx = Request.Form("AuthorLink")
	ArticleCatIDx = Request.Form("ArticleCatID")
		Author = Request.Form("Author")


str1 = ArticleHeadlinex
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleHeadlinex= Replace(str1, "'", "''")
End If
str1 = ArticleTextx
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleTextx= Replace(str1, "'", "''")
End If

	Query =  " UPDATE Articles Set ArticleCatID = " & ArticlecatIDx & ","
	Query =  Query + " ArticleHeadline = '" & ArticleHeadlinex & "'," 
	Query =  Query + " ArticleText = '" & ArticleTextx & "'," 
	Query =  Query + " AuthorLink = '" & AuthorLinkx & "' ," 
		Query =  Query + " Author = '" & Author & "'" 
    Query =  Query + " where ArticleID = " & ArticleIDx & ";" 
'response.write(Query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath)& ";" 



DataConnection.Execute(Query) 



IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>Your changes have successfully been made.</H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<!--#Include virtual="/administration/ArticleEditInclude.asp"-->
<!--#Include file="Footer.asp"--> 
</Body>
</HTML>
