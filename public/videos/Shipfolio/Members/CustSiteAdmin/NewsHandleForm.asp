<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit News</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 
<%
	Dim NewsIDx
	dim NewsHeadlinex
	dim NewsTextx
	dim AuthorLinkx
	dim NewsCatIDx


	dim TotalCount
	dim rowcount

	TotalCount= Request.Form("TotalCount")
	TotalCount = CInt(TotalCount)

	NewsIDx = Request.Form("NewsID")
	NewsHeadlinex = Request.Form("NewsHeadline")
	NewsTextx = Request.Form("NewsText")
	AuthorLinkx = Request.Form("AuthorLink")
	NewsCatIDx = Request.Form("NewsCatID")
		Author = Request.Form("Author")


str1 = NewsHeadlinex
str2 = "'"
If InStr(str1,str2) > 0 Then
	NewsHeadlinex= Replace(str1, "'", "''")
End If
str1 = NewsTextx
str2 = "'"
If InStr(str1,str2) > 0 Then
	NewsTextx= Replace(str1, "'", "''")
End If

	Query =  " UPDATE News Set NewsCatID = " & NewscatIDx & ","
	Query =  Query + " NewsHeadline = '" & NewsHeadlinex & "'," 
	Query =  Query + " NewsText = '" & NewsTextx & "'," 
	Query =  Query + " AuthorLink = '" & AuthorLinkx & "' ," 
		Query =  Query + " Author = '" & Author & "'" 
    Query =  Query + " where NewsID = " & NewsIDx & ";" 
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

<!--#Include virtual="/administration/NewsEditInclude.asp"-->
<!--#Include file="Footer.asp"--> 
</Body>
</HTML>
