<!doctype html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body >
<% 
PageGroupShow= request.form("PageGroupShow")
PageGroupAvailable= request.form("PageGroupAvailable")
response.write("PageGroupShow=" & PageGroupShow)
PageGrouptitle= request.form("PageGrouptitle")
sqlp = "select * from pageGroups "
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sqlp, conn, 3, 3
if not rs.eof then
while Not rs.eof 
PageGrouptitle = rs("PageGrouptitle")
str1 = PageGroupShow 
str2 = PageGrouptitle

If InStr(str1, str2) > 0 or PageGrouptitle = "Home Page" Then
Query =  " UPDATE pageGroups Set "
 Query =  Query & " PageGroupShow = True"
 Query =  Query & " where PageGrouptitle = '" & PageGrouptitle & "' ;"
Conn.Execute(Query) 	
else
Query =  " UPDATE PageGroups Set "
 Query =  Query & " PageGroupShow = False"
 Query =  Query & " where  PageGrouptitle = '" & PageGrouptitle & "' ;" 
Conn.Execute(Query) 
End If  
	response.write("Query=" & Query & "<br>")
str1 = PageGroupAvailable 
str2 = PageGrouptitle
If InStr(str1, str2) > 0 or PageGrouptitle = "Home Page" Then
Query =  " UPDATE PageGroups Set "
 Query =  Query & " PageGroupAvailable = True"
 Query =  Query & " where PageGrouptitle = '" & PageGrouptitle & "' ;"
Conn.Execute(Query) 	
else
Query =  " UPDATE PageGroups Set "
 Query =  Query & " PageGroupAvailable = False"
 Query =  Query & " where  PageGrouptitle = '" & PageGrouptitle & "' ;" 
Conn.Execute(Query) 
End If  
response.write("Query=" & Query & "<br>")
 rs.movenext
wend 
Conn.Close
end if
response.redirect("AdminWebsitesetup.asp")
%>
 </Body>
</HTML>
