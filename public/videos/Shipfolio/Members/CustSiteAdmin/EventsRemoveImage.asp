<%@ Language=VBScript %>
<!--#Include file="AdminGlobalVariables.asp"-->
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>

</head>
<BODY >
<% EventsID= Request.querystring("EventsID") 
Query =  " UPDATE Events Set EventsImage='0'  " 
Query =  Query & " where EventsID= " & EventsID & ";" 

response.write("Query=" & Query )
Conn.Execute(Query) 
Conn.Close
response.redirect("EventMantainance.asp" )
%>
</Body>
</HTML>