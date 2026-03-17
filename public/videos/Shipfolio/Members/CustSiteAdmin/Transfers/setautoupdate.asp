<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
 </head>
<BODY >
<% Transfer = True %>
<!--#Include virtual="/Conn.asp"--> 
<%	
AutoTransfer = request.form("AutoTransfer")
SendingPage = request.Form("SendingPage")
Query =  " UPDATE AutoTransfers Set AutoTransfer = " & AutoTransfer  & " where ReceivingwebsiteName = 'Livestock Of America'" 

response.write(Query)	
Conn.Execute(Query) 
Conn.Close
response.redirect(SendingPage)
%>
</Body>
</HTML>
