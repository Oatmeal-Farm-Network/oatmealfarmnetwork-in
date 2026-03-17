<!DOCTYPE HTML>

<%@ Language=VBScript %>

<HTML>
<HEAD>
	<title>Edit Blog Articles</title>
	<link rel="stylesheet" type="text/css" href="/administration/style.css">	
</head>
<BODY  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
 
<!--#Include file="BlogAdminSecurityInclude.asp"--> 
<!--#Include File="BlogAdminGlobalVariables.asp"--> 



<% PageName="Blog" %>

<%
rowcount = 1
ImageID=Request.Form("OrientationImageID") 
response.write("ImageID=")
response.write(ImageID)
Orientation=Request.Form("Orientation") 
 rowcount =1
ImageName = "Image" & ImageID
OrientationName = "ImageOrientation" & ImageID
PageName=Request.Form("PageName") 

str1 = ImageName
str2 = ","
If InStr(str1,str2) > 0 Then
	ImageName= Replace(str1, ",", "")
End If

str1 = OrientationName
str2 = ","
If InStr(str1,str2) > 0 Then
	OrientationName= Replace(str1, ",", "")
End If

Query =  " UPDATE blog Set " & OrientationName & "= '" & Orientation & "' "
Query =  Query & " where BlogID = " & Session("BlogID")  	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 

rowcount= rowcount +1


Response.Redirect("BlogAdminMaintenance2.asp?BlogID=" & Session("BlogID"))
%>

</Body>
</HTML>
