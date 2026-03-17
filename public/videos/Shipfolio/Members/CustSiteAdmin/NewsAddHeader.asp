<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add an News Article</title>
     <link rel="stylesheet" type="text/css" href="/Administration/style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

TextBlock= Request.Form("TextBlock")
	Text = Request.Form("Text")

	Heading = Request.Form("Heading")
AuthorLink= Request.Form("AuthorLink")
NewsDate= Request.Form("NewsDate")
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
	
		str1 = NewsDate
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		NewsDate= Replace(str1, "'", "''")
	End If



		Query =  "INSERT INTO News ( NewsDate, HeadlineOne)" 
		Query =  Query + " Values ('" &  NewsDate & "'," 
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

  sql = "select * from News where HeadlineOne= '" & Heading & "' order by NewsID DESC"
		response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
    If Not rs.eof Then
       NewsID = rs("NewsID")
	Session("NewsID") =  NewsID 
	End If
	redirectpath = "NewsMantainance2.asp?NewsID=" & Session("NewsID")
	response.write(redirectpath)
Response.Redirect(redirectpath)
 %>







<% %>
</BODY>
</HTML>
