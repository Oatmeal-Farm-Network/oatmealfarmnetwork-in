<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
 <!--#Include file="membersGlobalVariables.asp"--> 

<% ServicesID= Request.QueryString("ServicesID") 
If Len(ServicesID) > 0 then
else
ServicesID= Request.Form("ServicesID") 
End If 


rowcount = 1

ImageID=Request.Form("ImageID") 
rowcount =1
ImageName = "Photo" & ImageID
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


Query =  " UPDATE Services Set " & ImageName & " = '' , " 
Query =  Query & CaptionName & "  = ''" 
Query =  Query & " where ServicesID = " & ServicesID & ";" 
response.write("Query=" & Query )

Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.redirect("MembersServicesUploadPhotos.asp?ServicesID=" & ServicesID & "#" & ImageID)

%>

 </Body>
</HTML>
