<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<BODY>
<!--#Include file ="ReportsGlobalVariables.asp"--> 
<%
Query =  " UPDATE Events Set EventsImage = '' " 
Query =  Query & " where EventsID = " & EventsID & ";" 

Conn.Execute(Query) 

rowcount= rowcount +1

Conn.Close
Set Conn = Nothing 
Response.Redirect("EventMantainance.asp")
%>
</Body>
</HTML>