<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Blog</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 
<%
	Dim BlogIDx
	dim BlogHeadlinex
	dim BlogTextx
	dim AuthorLinkx
	dim BlogCatIDx


	dim TotalCount
	dim rowcount

	TotalCount= Request.Form("TotalCount")
	TotalCount = CInt(TotalCount)

	BlogIDx = Request.Form("BlogID")
	BlogHeadlinex = Request.Form("BlogHeadline")
	BlogTextx = Request.Form("BlogText")
	AuthorLinkx = Request.Form("AuthorLink")
	BlogCatIDx = Request.Form("BlogCatID")
		Author = Request.Form("Author")


str1 = BlogHeadlinex
str2 = "'"
If InStr(str1,str2) > 0 Then
	BlogHeadlinex= Replace(str1, "'", "''")
End If
str1 = BlogTextx
str2 = "'"
If InStr(str1,str2) > 0 Then
	BlogTextx= Replace(str1, "'", "''")
End If

	Query =  " UPDATE Blog Set BlogCatID = " & BlogcatIDx & ","
	Query =  Query + " BlogHeadline = '" & BlogHeadlinex & "'," 
	Query =  Query + " BlogText = '" & BlogTextx & "'," 
	Query =  Query + " AuthorLink = '" & AuthorLinkx & "' ," 
		Query =  Query + " Author = '" & Author & "'" 
    Query =  Query + " where BlogID = " & BlogIDx & ";" 
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

<!--#Include virtual="/administration/BlogEditInclude.asp"-->
<!--#Include file="Footer.asp"--> 
</Body>
</HTML>
