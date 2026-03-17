<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="MembersGlobalvariables.asp"--> 
<%
dim Caption
Dim captionid
PropID = request.form("PropID")
response.write ("PropID=" & PropID)
'rowcount = CInt
rowcount = 1
Caption=Request.Form("Caption") 
CaptionID=Request.Form("CaptionID") 
 rowcount =1
CaptionName = "PropCaption" & CaptionID
'Response.write("CaptionName=")
'Response.write(CaptionName)
str1 = CaptionName
str2 = ","
If InStr(str1,str2) > 0 Then
	CaptionName= Replace(str1, ",", "")
End If

Query =  " UPDATE PropertyPhotos Set " & CaptionName & " = '" &  Caption & "' " 
Query =  Query & " where PropID = " & PropID & ";" 
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.redirect("PropertyPhotos.asp?PropID=" & PropID )
%>
 </Body>
</HTML>