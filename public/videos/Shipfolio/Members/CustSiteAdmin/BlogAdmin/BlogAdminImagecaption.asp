<!DOCTYPE HTML>

<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Edit  Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
		

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >

<!--#Include File="BlogAdminGlobalVariables.asp"--> 
<!--#Include File="BlogAdminSecurityInclude.asp"--> 
<!--#Include File="BlogAdminHeader.asp"-->

<% 
PageName="Blog" %>



<%

'rowcount = CInt
rowcount = 1

ImageID=Request.Form("CaptionImageID") 
response.write("ImageID=")
response.write(ImageID)
Caption=Request.Form("Caption") 
 rowcount =1
ImageName = "Image" & ImageID
CaptionName = "ImageCaption" & ImageID
BlogID=Request.Form("BlogID") 
'Response.write("CaptionName=")
'Response.write(CaptionName)

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

str1 = Caption
str2 = "'"
If InStr(str1,str2) > 0 Then
	Caption= Replace(str1, "'", "''")
End If
	

	Query =  " UPDATE Blog Set " & CaptionName & " = '" & Caption & "' "
	Query =  Query + " where BlogID = " & BlogID & ";" 
	response.write(Query)
'response.write(Query)	


Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
Conn.Execute(Query) 

rowcount= rowcount +1


IF Conn.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	Conn.Close
	Set Conn = Nothing
	redirectname = "BlogAdminMaintenance2.asp?BlogID=" & BlogID

Response.Redirect(redirectname)
%>

	
 </Body>
</HTML>
