<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<BODY>
<!--#Include file="AdminGlobalVariables.asp"--> 
<%
Dim TempNewCategory
Dim TempCategoryType
NewPageGroup=Request.Form("NewPageGroup" ) 
sql = "select * from PageGroups where PageGroupTitle = """ & NewPageGroup & """"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
If rs.eof  then
str1 = NewPageGroup
str2 = "'"
If InStr(str1,str2) > 0 Then
NewPageGroup= Replace(str1, "'", "''")
end if
rs.close
sql = "select * from PageGroups "
rs.Open sql, conn, 3, 3 
if not rs.eof then
newordercount = rs.recordcount + 1
end if
Query =  "INSERT INTO PageGroups (PageGroupTitle, PageGroupOrder)" 
Query =  Query & " Values ('" &  NewPageGroup & "', " & newordercount & ")"
response.write(Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 
End if
response.redirect("AdminPageGroups.asp")
%>
</Body>
</HTML>
