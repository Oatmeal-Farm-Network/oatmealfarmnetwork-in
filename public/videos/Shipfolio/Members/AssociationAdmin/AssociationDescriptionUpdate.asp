<!DOCTYPE html>
<html>
<head>
<!--#Include file="AssociationGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="author" content="AndresenEvents.com">
<link rel="stylesheet" type="text/css" href="/Style.css">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<%
AssociationDescription= Request.Form("AssociationDescription")


str1 = AssociationDescription 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationDescription= Replace(str1,  str2, "''")
End If


Query =  " UPDATE Associations Set AssociationDescription = '" &  AssociationDescription & "',"
Query =  Query & " where AssociationID = " & session("AssociationID") & ";" 


response.write("Query="	& Query )
Conn.Execute(Query) 

Conn.close
Set Conn = Nothing %>
<!--#Include virtual="/includefiles/Conn.asp"-->
<%

response.write("ReturnPage=" & ReturnPage )
if len(ReturnPage) > 1 then
response.redirect(ReturnPage)
else
response.redirect("AssociationDescription.asp?AssociationID=" & AssociationID )
end if 
 %>
<br><br><br>

</Body>
</HTML>