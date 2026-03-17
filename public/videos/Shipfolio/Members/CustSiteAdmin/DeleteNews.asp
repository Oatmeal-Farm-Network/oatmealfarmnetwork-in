<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Delete News Article Handle Form</title>
     <link rel="stylesheet" type="text/css" href="/Administration/style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<%
Dim Issue
Dim IssueDate
Dim IssueTitle
Dim Headline
Dim Text
Dim ArticleImage

Issue =Request.Form("Issue" ) 


	
		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

	Query =  "Delete * From Blog where Issue = " + Issue + "" 
	DataConnection.Execute(Query) 

		

 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>


<a href = "MaintainNews.asp" class = "link">Click here to return to the Maintain News Page</a></div>
</BODY>
</HTML>
