<!DOCTYPE HTML>

<HTML>
<HEAD>
 	<title>Remove Image</title>
	<link rel="stylesheet" type="text/css" href="/administration/style.css">

</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >

<!--#Include File="BlogAdminGlobalVariables.asp"--> 
<!--#Include File="BlogAdminSecurityInclude.asp"--> 
<!--#Include virtual="/Administration/AdminHeader.asp"-->

<%
rowcount = 1

ImageID=Request.Form("ImageID") 
 rowcount =1
ImageName = "BlogImage" & ImageID
CaptionName = "ImageCaption" & ImageID

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

Query =  " UPDATE Blog Set " & ImageName & " = '0' , " 
Query =  Query & CaptionName & "  = '0'" 
Query =  Query & " where BlogID = " & Session("BlogID") 

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 

Response.Redirect("BlogAdminMaintenance2.asp?BlogID=" & Session("BlogID"))
%>

	
 </Body>
</HTML>
