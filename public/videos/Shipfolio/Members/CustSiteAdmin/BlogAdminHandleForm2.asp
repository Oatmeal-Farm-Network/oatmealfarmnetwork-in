<!DOCTYPE HTML>
<%@ Language=VBScript %>
<HTML>
<HEAD>
<title>Blog  Page</title>
 <link rel="stylesheet" type="text/css" href="style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include File="BlogAdminGlobalVariables.asp"--> 
<!--#Include virtual="/Administration/AdminHeader.asp"--> 
<% 
PageName="Blog" %>
<%
Dim TextBlock
TextBlock= Request.Form("TextBlock")
Text = Request.Form("Text")
BlogID = Request.Form("BlogID")
Heading = Request.Form("Heading")
BlogDisplay = Request.form("BlogDisplay")
AuthorLink= Request.Form("AuthorLink")
BlogCatID= Request.Form("CatID")
textblocknum= Request.Form("textblocknum")
	BlogDay = Request.Form("BlogDay")
	BlogMonth = Request.Form("BlogMonth")
	BlogYear = Request.Form("BlogYear")


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

str1 = Text
str2 = "--"
If InStr(str1,str2) > 0 Then
	Text= Replace(str1, "--", "-")
End If

 

Dim Connection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath)& ";" 

	If TextBlock = "Heading" Then 
		Query =  " UPDATE Blog Set BlogHeadline = '" & Text & "', "
		Query =  Query & " BlogDay = " & BlogDay & ", " 
		Query =  Query & "BlogMonth =  " & BlogMonth & ", " 
		Query =  Query & "BlogYear =  " & BlogYear & ", " 
         Query =  Query & "BlogDisplay =  " & BlogDisplay& " " 
        Query =  Query & "BlogcatID =  " & BlogCatID& " " 
		Query =  Query & " where BlogID = " & BlogID & ";" 
		response.write(Query)
		
		DataConnection.Execute(Query) 

	End If 

	
If Not (TextBlock = "Heading") Then 
pageheadingName = "PageHeading" & textblocknum
BlogTextName = "BlogText" & textblocknum
		Query =  " UPDATE Blog Set " & pageheadingName  & " = '" & Heading & "', "
		Query =  Query & BlogTextName & "= '" & Text & "'"
		Query =  Query & " where BlogID = " & BlogID & ";" 
		response.write(Query)
		
		DataConnection.Execute(Query) 
End if


	DataConnection.Close
	Set DataConnection = Nothing 
Response.Redirect("BlogAdminMaintenance2.asp?BlogID=" & Session("BlogID") )
%>
</Body>
</HTML>
