<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css"> 
 <!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
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


Query =  " UPDATE ProductsPhotos Set " & ImageName & " = '0'  " 
	Query =  Query & " where ID = " & ProdID & ";" 

response.write(Query)	


Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 

redirect = "AdminProductPhotos.asp?ID=" & prodID
Response.Redirect(redirect)

%>

 
 </Body>
</HTML>
