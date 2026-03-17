<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >
<%
dim Caption
Dim captionid
rowcount = 1
GalleryCatID = Request.Form("GalleryCatID")
response.write("GalleryCatID=" & GalleryCatID)
Caption=Request.Form("Caption") 
ImageOrder=Request.Form("ImageOrder") 
GalleryID=Request.Form("GalleryID") 
GalleryImageLink =Request.Form("GalleryImageLink")
 rowcount =1
str1 = GalleryImageLink 
str2 = ","
If InStr(str1,str2) > 0 Then
	GalleryImageLink = Replace(str1, ",", "")
End If
str1 = GalleryImageLink 
str2 = "'"
If InStr(str1,str2) > 0 Then
	GalleryImageLink = Replace(str1, "'", "''")
End If
str1 = CaptionName
str2 = ","
If InStr(str1,str2) > 0 Then
	CaptionName= Replace(str1, ",", "")
End If
str1 = Caption
str2 = "'"
If InStr(str1,str2) > 0 Then
	Caption= Replace(str1, "'", "''")
End If
Query =  " UPDATE Gallery Set gallerycaption = '" &  Caption & "', " 
Query =  Query & " GalleryImageLink = '" &  GalleryImageLink & "'," 
Query =  Query & " ImageOrder = " &  ImageOrder & "" 
Query =  Query & " where GalleryID = " & GalleryID & ";" 

response.write("Edit Caption Query = " & Query & "<br>")	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 
	DataConnection.Close
	Set DataConnection = Nothing 

rowcount= rowcount +1
response.redirect("AdminGalleryEditImages.asp?GalleryCatID=" & GalleryCatID)
%>
</Body>
</HTML>
