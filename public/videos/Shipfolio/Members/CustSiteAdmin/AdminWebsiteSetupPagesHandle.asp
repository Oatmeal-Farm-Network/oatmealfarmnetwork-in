<!doctype html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body >
<% 
ShowPages= request.form("ShowPages")
PageAvailable= request.form("PageAvailable")
response.write("PageAvailables=" & PageAvailable)
PageName= request.form("PageName")
sqlp = "select * from pageLayout "

	 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sqlp, conn, 3, 3
			if not rs.eof then
			 Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
			 while Not rs.eof 
			 PageName = rs("PageName")
			str1 = ShowPages 
			str2 = PageName
			

If InStr(str1, str2) > 0 or PageName = "Home Page" Then
Query =  " UPDATE pageLayout Set "
 Query =  Query & " ShowPage = True"
 Query =  Query & " where PageName = '" & PageName & "' ;"
 DataConnection.Execute(Query) 	

  else
Query =  " UPDATE pageLayout Set "
 Query =  Query & " ShowPage = False"
 Query =  Query & " where  PageName = '" & PageName & "' ;" 
 DataConnection.Execute(Query) 
End If  
	response.write("Query=" & Query )
			
			str1 = PageAvailable 
			str2 = PageName
			

			If InStr(str1, str2) > 0 or PageName = "Home Page" Then
				Query =  " UPDATE pageLayout Set "
 Query =  Query & " PageAvailable = True"
 Query =  Query & " where PageName = '" & PageName & "' ;"
 DataConnection.Execute(Query) 	

	  else
				Query =  " UPDATE pageLayout Set "
 Query =  Query & " PageAvailable = False"
 Query =  Query & " where  PageName = '" & PageName & "' ;" 
 DataConnection.Execute(Query) 
			End If  

	response.write("Query=" & Query )
 rs.movenext
			wend 
			
	DataConnection.Close
	Set DataConnection = Nothing 
end if

response.redirect("AdminWebsitesetup.asp")
%>
 </Body>
</HTML>
