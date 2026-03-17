<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="MembersGlobalvariables.asp"--> 
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<%
PropID = Session("PropID")
rowcount = 1
ImageID=Request.Form("ImageID") 
rowcount =1
ImageName = "PropImage" & ImageID
CaptionName = "PropCaption" & ImageID
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

Query =  " UPDATE PropertyPhotos Set " & ImageName & " = '0' , " 
Query =  Query & CaptionName & "  = '0'" 
Query =  Query & " where PropID = " & PropID & ";" 

Conn.Execute(Query) 
 rowcount= rowcount +1
Conn.Close
Set Conn = Nothing 
response.redirect("PropertyPhotos.asp?PropID=" & PropID )
%>
 </Body>
</HTML>
