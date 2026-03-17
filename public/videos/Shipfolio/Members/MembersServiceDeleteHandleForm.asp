<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 
<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
</head>
<body >
<!--#Include file="membersHeader.asp"-->
<% Current3 = "Delete"  %>
<!--#Include File="MembersServicesJumpLinks.asp"--> 
<div class ="container roundedtopandbottom">
	<div>
		<div>

	<H1>Delete a Service</H1>
<center>
<% dim ServiceTitle
ServicesID=Request.Form("ServicesID" ) 
PageType=Request.Form("PageType" ) 
PageLayoutID=Request.Form("PageLayoutID") 
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")


Query =  "Delete From Services where ServicesID = " &  ServicesID & "" 
Conn.Execute(Query) 
%>
<H2><% response.write("The Service has successfully been deleted.") %></H2>
<%
	Conn.Close
	Set Conn = Nothing 
%>
<br><a class = "Links" href="membersServiceDelete.asp">Delete another service.</a><br />
	<br><a  class = "Links" href="MembersServicesHome.asp">Go to your list of services.</a>
<br></center><br />
</div>

		</div>
	</div>
<br />
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>
