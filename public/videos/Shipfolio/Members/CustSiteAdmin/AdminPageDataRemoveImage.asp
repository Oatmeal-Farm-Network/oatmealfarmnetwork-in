<!DOCTYPE HTML>
<html>
<head>
<!-- #include virtual="/Members/MembersGlobalVariables.asp" -->
</head>
<body >

<%

'rowcount = CInt
rowcount = 1

ImageID=Request.Form("ImageID") 
PageName=Request.Form("PageName") 
PageLayoutID=Request.Form("PageLayoutID") 
 rowcount =1
ImageName = "Image" & ImageID
CaptionName = "ImageCaption" & ImageID
returnpage = Request.Form("returnpage")
PageLayout2ID = Request.Form("tempPageLayout2ID")
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


	Query =  " UPDATE Pagelayout2 Set  Image = '' , " 
	Query =  Query & " ImageCaption  = ''" 
	Query =  Query & " where PageLayout2ID = " & PageLayout2ID


Conn.Execute(Query) 

	
	if len(returnpage) > 0 then
 Response.Redirect(returnpage) 
else
Response.Redirect("AdminPageData.asp?PageLayoutID=" & PageLayoutID & "#Textblock" & ImageID)
 end if 

%>

	
 </Body>
</html>
