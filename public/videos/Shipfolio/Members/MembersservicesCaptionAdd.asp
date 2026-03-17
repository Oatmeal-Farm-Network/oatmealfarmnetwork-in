<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<% ' Clean directory NEA 4/2012 %>
<HTML>
<HEAD>
 <title>Upload Photos Page</title>
<link rel="stylesheet" type="text/css" href="style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
    <!--#Include file="MembersGlobalVariables.asp"--> 

<%

dim Caption
Dim captionid

ServicesID = request.querystring("ServicesID")
'response.write (ID)

'rowcount = CInt
rowcount = 1

Caption=Request.Form("Caption") 
CaptionID=Request.Form("CaptionID") 
 rowcount =1
CaptionName = "PhotoCaption" & CaptionID
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

Query =  " UPDATE Services Set " & CaptionName & " = '" &  Caption & "' " 
	Query =  Query & " where ServicesID = " & ServicesID & ";" 

response.write("Query=" & Query )
Conn.Execute(Query) 
Conn.Close
Set DataConn = Nothing 

response.redirect("MembersServicesUploadPhotos.asp?ServicesID=" & ServicesID  & "#" & CaptionID)
%>
</Body>
</HTML>
