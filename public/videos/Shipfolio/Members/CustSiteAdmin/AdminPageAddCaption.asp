<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<!-- #include virtual="/Members/MembersGlobalVariables.asp" -->
</head>
<body >

<%

dim Caption
Dim captionid

ID = Session("AnimalID")
'response.write (ID)

'rowcount = CInt
rowcount = 1

Caption=Request.Form("Caption") 
CaptionID=Request.Form("CaptionID") 
pagename=Request.Form("pagename") 
Redirectpage=Request.Form("Redirectpage") 
returnpage= Request.Form("returnpage")
tempPageLayout2ID= Request.Form("tempPageLayout2ID")
 rowcount =1
CaptionName = "ImageCaption" & CaptionID
'Response.write("CaptionName=")
'Response.write(CaptionName)
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

Query =  " UPDATE PageLayout2 Set  ImageCaption = '" &  Caption & "' " 
Query =  Query + " where PageLayout2ID = " & tempPageLayout2ID & ";" 

Conn.Execute(Query) 

if len(returnpage) > 0 then
 Response.Redirect(returnpage) 
else
response.redirect(Redirectpage)
 end if

%>
</Body>
</html>
