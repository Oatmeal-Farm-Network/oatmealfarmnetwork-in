<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="MembersGlobalvariables.asp"--> 
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<%
BFSID = Session("BFSID")
rowcount = 1
ImageID=Request.Form("ImageID") 
rowcount =1
ImageName = "BFSImage" & ImageID
CaptionName = "BFSCaption" & ImageID
str1 = ImageName
str2 = ","
If InStr(str1,str2) > 0 Then
	ImageName= Replace(str1, ",", "")
End If

Query =  " UPDATE BusinessForSale Set " & ImageName & " = ' '  " 
Query =  Query & " where BFSID = " & BFSID & ";" 
response.write("Query =" & Query  )

Conn.Execute(Query) 
 rowcount= rowcount +1
Conn.Close
Set Conn = Nothing 
response.redirect("MembersBusinessPhotos.asp?BFSID=" & BFSID )
%>
 </Body>
</HTML>
