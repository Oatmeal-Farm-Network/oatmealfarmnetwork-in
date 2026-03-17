<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="adminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<%

	dim TempattrID

	TempattrID=Request.Form("attrID" ) 

	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	

	Query =  "Delete * From sfattributes where attrID = " & TempattrID
	'response.write(Query)
	Conn.Execute(Query) 

	Conn.Close
	Set Conn = Nothing 
	response.Redirect("AdminProductsAttributesSet.asp")
%>
</Body>
</HTML>