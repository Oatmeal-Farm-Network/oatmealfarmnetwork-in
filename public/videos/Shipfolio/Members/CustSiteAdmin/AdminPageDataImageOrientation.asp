<!DOCTYPE HTML>
<html>
<head>
</head>
<body >

<!-- #include virtual="/Members/MembersGlobalVariables.asp" -->
<%

'rowcount = CInt
rowcount = 1

ImageID=Request.Form("OrientationImageID") 
PageLayoutID=Request.Form("PageLayoutID") 
tempPageLayout2ID=Request.Form("tempPageLayout2ID") 
Orientation=Request.Form("Orientation") 
 rowcount =1
ImageName = "Image" & ImageID
returnpage= Request.Form("returnpage")
OrientationName = "ImageOrientation" & ImageID


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

	Query =  " UPDATE PageLayout2 Set ImageOrientation = '" & Orientation & "' "
    Query =  Query & " where PageLayout2ID = " & tempPageLayout2ID& ";"  
	response.write(Query)	

response.write(Query)	

Conn.Execute(Query) 


 
if len(returnpage) > 0 then
Response.Redirect(returnpage) 
else
Response.Redirect("AdminPageData.asp?PageLayoutID=" & PageLayoutID & "#" & ReturnTextBlock) 
 end if %>

	
 </body>
</html>
