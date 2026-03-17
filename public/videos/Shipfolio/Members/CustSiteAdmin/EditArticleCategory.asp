<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Articles</title>
       <Link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="globalvariables.asp"--> 
<!--#Include File="Header.asp"--> 


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

	Tempcategoryname=Request.Form("ArticleCategoryName" ) 
	Tempcategorytype=Request.Form("Tempcategorytype" ) 
	TempcategoryID=Request.Form("ArticleCatID" ) 
	Categorytype=Request.Form("ArticleCategorytype" ) 
	
'response.write(Tempcategoryname) 
'response.write(Tempcategorytype) 
'response.write(TempcategoryID ) 
'response.write(Categorytype ) 

	str1 = Tempcategoryname
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Tempcategoryname= Replace(str1, "'", "''")
	End If


	Query =  " UPDATE ArticleCategories Set articlecategoryname = '" & Tempcategoryname & "' " 
    Query =  Query + " where ArticlecatID = " & TempcategoryID & ";" 


	'response.write(Query)

	Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 

	
%>


<!--#Include file="ArticleCategoriesInclude.asp"-->
<!--#Include file="Footer.asp"--> </Body>
</HTML>
