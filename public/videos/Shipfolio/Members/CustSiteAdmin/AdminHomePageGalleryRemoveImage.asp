<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >

<%
rowcount = 1

GalleryID=Request.Form("GalleryID")
GalleryCatID = Request.Form("GalleryCatID") 
'response.write("GalleryCatID=" & GalleryCatID)
 rowcount =1

str1 = ImageName
str2 = ","
If InStr(str1,str2) > 0 Then
	ImageName= Replace(str1, ",", "")
End If

str1 = CaptionName
str2 = ","
If InStr(str1,str2) > 0 Then
	CaptionName= Replace(str1, ",", "")
End If

Query =  "Delete * From Gallery where GalleryID = " &  GalleryID & "" 
'response.write("Query = " & Query)	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 
	DataConnection.Close
	Set DataConnection = Nothing 

rowcount= rowcount +1

response.redirect("AdminHomePage.asp" )
%>

 </Body>
</HTML>
