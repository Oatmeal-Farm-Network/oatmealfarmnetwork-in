<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="membersGlobalVariables.asp"-->
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<%
'rowcount = CInt
rowcount = 1

ImageID=Request.Form("OrientationImageID") 
ServicesPageLayoutID=Request.Form("ServicesPageLayoutID") 
tempPageLayout2ID=Request.Form("tempPageLayout2ID") 
response.write("PageLayoutID=")
response.write(PageLayoutID)
Orientation=Request.Form("Orientation") 
 rowcount =1
ImageName = "Image" & ImageID
returnpage= Request.Form("returnpage")
OrientationName = "ImageOrientation" & ImageID

Response.write("returnpage=")
Response.write(returnpage)

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

Query =  " UPDATE ServicePageLayout2 Set ImageOrientation = '" & Orientation & "' "
Query =  Query & " where ServicePageLayout2ID = " & tempPageLayout2ID& ";"  
response.write(Query)	
Conn.Execute(Query) 

	  rowcount= rowcount +1


	Conn.Close
	Set Conn = Nothing 
if len(returnpage) > 0 then
Response.Redirect(returnpage) 
else
Response.Redirect("MembersServicesEdit2.asp?ServicesPageLayoutID=" & ServicesPageLayoutID & "#" & ReturnTextBlock) 
 end if %>

	
 </Body>
</HTML>
