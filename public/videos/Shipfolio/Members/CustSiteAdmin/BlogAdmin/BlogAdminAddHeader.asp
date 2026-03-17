<!DOCTYPE HTML>

<%@ Language=VBScript %>

<HTML>
<HEAD>
	<title>Blog Page</title>
	<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >

<!--#Include File="BlogAdminGlobalVariables.asp"--> 
<!--#Include File="BlogAdminSecurityInclude.asp"--> 
<!--#Include virtual="/Administration/AdminHeader.asp"--> 
<!--#Include File="BlogAdminHeader.asp"--> 

<%PageName="Blog" %>
    
<%
	TextBlock= Request.Form("TextBlock")
	Text = Request.Form("Text")
	BlogDay = Request.Form("BlogDay")
	BlogMonth = Request.Form("BlogMonth")
	BlogYear = Request.Form("BlogYear")
	Heading = Request.Form("Heading")
	AuthorLink= Request.Form("AuthorLink")
	BlogCatID= Request.Form("BlogCatID")
	
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
	
	'conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	'"Data Source=" & server.mappath(databasepath) & ";" & _
	'"User Id=;Password=;" '& _

	Set rs = Server.CreateObject("ADODB.Recordset")
	Query =  "INSERT INTO Blog ( BlogCatID, AuthorLink, BlogDay, BlogMonth, BlogYear, BlogHeadline)" 
	Query =  Query & " Values (" &  BlogCatID & "," 
	Query =  Query & " '" & AuthorLink & "'," 
	Query =  Query & " " & BlogDay & "," 
	Query =  Query & " " & BlogMonth & "," 
	Query =  Query & " " & BlogYear & "," 
	Query =  Query + " '" &  Heading &  "')"
	
	response.write("BlogAddHeader Query = " & Query & "<br>")

	Dim Conn, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set Conn = Server.CreateObject("ADODB.Connection")
	response.write("BlogAddHeader DatabasePath = " & DatabasePath & "<br>")

	Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
	Conn.Execute(Query) 

    'Conn.close
    'set Conn = Nothing
    
  	sql = "select * from Blog where BlogCatID = " & BlogCatID & " and BlogHeadline= '" & Heading & "' order by BlogID DESC"
	response.write("BlogAddHeader sql = " & sql & "<br>")
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
    If Not rs.eof Then
       BlogID = rs("BlogID")
	Session("BlogID") =  BlogID 
	End If
	
	redirectpath = "BlogAdminMaintenance2.asp?BlogID=" & BlogID
	response.write("BlogID=" & BlogID)
	Response.Redirect(redirectpath)
%>
<!--#Include File="BlogAdminFooter.asp"--> 
</BODY>
</HTML>
