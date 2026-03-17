<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Remove Image</title>
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >

<!--#Include file="MembersGlobalVariables.asp"--> 

<%
'rowcount = CInt
rowcount = 1

ImageID=Request.Form("ImageID") 
 rowcount =1
ImageName = "RanchHomeImage" & ImageID
CaptionName = "RanchHomeImageCaption" & ImageID

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


Query =  " UPDATE People Set " & ImageName & " = '0'  " 
	Query =  Query & " where PeopleId = " & session("PeopleId")

'response.write(Query)	

conn.Execute(Query) 
rowcount= rowcount +1

conn.Close
Set conn = Nothing 
Response.Redirect("membersRanchHomeAdmin.asp")
%>

	
 </Body>
</HTML>
