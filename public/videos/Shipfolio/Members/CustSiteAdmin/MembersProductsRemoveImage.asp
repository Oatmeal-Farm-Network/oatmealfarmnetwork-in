<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/connloa.asp"-->
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<% Current2="Products"
Current3 = "ProductPhotos"  %>

<%
ProdID = Request.Form("ProdID")
'rowcount = CInt
rowcount = 1
ImageID=Request.Form("ImageID") 
 rowcount =1
ImageName = "ProductImage" & ImageID
CaptionName = "PhotoCaption" & ImageID

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


Query =  " UPDATE ProductsPhotos Set " & ImageName & " = ''  " 
Query =  Query & " where ID = " & ProdID & ";" 

response.write(Query)	

Connloa.Execute(Query) 

Connloa.Close
Set Connloa = Nothing 

 redirect = "membersProductPhotos.asp?ID=" & prodID & "#" & ImageID
Response.Redirect(redirect)
%>
 </Body>
</HTML>
