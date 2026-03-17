<!DOCTYPE HTML >

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >
<!--#Include File="AdminHeader.asp"-->

<% if mobiledevice = False  then %>
   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Change Your Password</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "980">   
<table width = "720" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr>
	
		
<td class = "body" valign = "top">
<table  align = "center" height = "300">
	<tr >
		<td align = "center" class = "body" valign = "top">
<%
end if
Dim Password
Password = Request.Form("Password") 

	Query =  " UPDATE people Set PeoplePassword= '" &  Password & "' " 
    Query =  Query & " where PeopleID = 667"  

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

 %>
<div align = "center"><H2>
<%
     response.write("Your Password has Been Changed.")
  %></H2>

<%


	DataConnection.Close
	Set DataConnection = Nothing 

%>
<% if mobiledevice = False  then %>

			<br><a  class = "Links" href="default.asp"> Click here to return to the admin home page</a>
			<br>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<% end if %>
<!--#Include File="AdminFooter.asp"--> </Body>
</HTML>
