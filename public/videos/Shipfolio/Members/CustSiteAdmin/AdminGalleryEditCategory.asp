<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
   <!--#Include file="AdminSecurityInclude.asp"-->
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >
    


<% TempCategoryType=request.form("Subject") 
	If Len(Subject) < 3 then
		TempCategoryType= Request.QueryString("Subject") 
	End If

   Dim TempGallerycategoryname
   Dim Tempcategorytype
   Dim TempcategoryID
      Dim Categorytype


	TempGallerycategoryname=Request.Form("Gallerycategoryname" ) 
	Tempcategorytype=Request.Form("Tempcategorytype" ) 
	TempcategoryID=Request.Form("GalleryCatID" ) 
	Categorytype=Request.Form("Categorytype" ) 
	GalleryCategoryShow=Request.Form("GalleryCategoryShow" ) 
'response.write(TempGallerycategoryname) 
'response.write(Tempcategorytype) 
'response.write(TempcategoryID ) 
'response.write(Categorytype ) 

	str1 = TempGallerycategoryname
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		TempGallerycategoryname= Replace(str1, "'", "''")
	End If


	Query =  " UPDATE GalleryCategories Set Gallerycategoryname = '" & TempGallerycategoryname & "', " 
	Query =  Query & " GalleryCategoryShow= " & GalleryCategoryShow & " " 
    Query =  Query & " where GallerycatID = " & TempcategoryID & ";" 


	response.write(Query)

	Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 	
	
		response.Redirect("AdminGallerySetCategories.asp")
%>


</Body>
</HTML>
