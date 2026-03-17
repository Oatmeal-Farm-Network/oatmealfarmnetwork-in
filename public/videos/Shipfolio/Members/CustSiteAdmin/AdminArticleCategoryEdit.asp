<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <Link rel="stylesheet" type="text/css" href="style.css">
       <!--#Include file="adminglobalvariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
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
response.Redirect("AdminArticleCategoriesSet.asp")
	
%>

 </Body>
</HTML>
