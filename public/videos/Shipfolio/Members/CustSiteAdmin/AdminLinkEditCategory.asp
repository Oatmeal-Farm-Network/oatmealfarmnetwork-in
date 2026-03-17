<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Links</title>
       <link rel="stylesheet" type="text/css" href="style.css">
       <!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<body >



<% TempCategoryType=request.form("Subject") 
	If Len(Subject) < 3 then
		TempCategoryType= Request.QueryString("Subject") 
	End If
%>

<%
   Dim Tempcategoryname
   Dim Tempcategorytype
   Dim TempcategoryID
      Dim Categorytype

	Tempcategoryname=Request.Form("categoryname" ) 
	Tempcategorytype=Request.Form("Tempcategorytype" ) 
	TempcategoryID=Request.Form("CatID" ) 
	Categorytype=Request.Form("Categorytype" ) 


	str1 = Tempcategoryname
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Tempcategoryname= Replace(str1, "'", "''")
	End If


	Query =  " UPDATE LinkCategories Set categoryname = '" & Tempcategoryname & "' " 
    Query =  Query + " where catID = " & TempcategoryID & ";" 


	'response.write(Query)

	Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 

	response.redirect("AdminLinkCategoriesSet.asp")	
%>

 </Body>
</HTML>
