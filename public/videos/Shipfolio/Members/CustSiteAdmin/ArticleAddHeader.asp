<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add an Article</title>
     <link rel="stylesheet" type="text/css" href="/Administration/style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

TextBlock= Request.Form("TextBlock")
	Text = Request.Form("Text")

	Heading = Request.Form("Heading")
AuthorLink= Request.Form("AuthorLink")
ArticleCatID= Request.Form("ArticleCatID")
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
	



		Query =  "INSERT INTO Articles ( ArticleCatID, AuthorLink, ArticleHeadline)" 
		Query =  Query + " Values (" &  ArticleCatID & "," 
		Query =  Query + " '" & AuthorLink & "'," 
		Query =  Query + " '" &  Heading &  "')"
		
		response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

		DataConnection.Close
		Set DataConnection = Nothing 

		
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

  sql = "select * from Articles where ArticleCatID = " & ArticleCatID & " and AuthorLink = '" & AuthorLink & "' and ArticleHeadline= '" & Heading & "' order by ArticleID DESC"
		response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
    If Not rs.eof Then
       ArticleID = rs("ArticleID")
	Session("ArticleID") =  ArticleID 
	End If
	redirectpath = "ArticleMantainance2.asp?ArticleID=" & Session("ArticleID")
	response.write(redirectpath)
Response.Redirect(redirectpath)
 %>







<% %>
</BODY>
</HTML>
