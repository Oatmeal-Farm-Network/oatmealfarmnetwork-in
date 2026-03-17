<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<% MasterDashboard= True %>
<!--#Include file="membersGlobalVariables.asp"-->
</head>
</head>
<body >

	<% MasterDashboard= True 
	BladeSection = "users"
	pagename = "password" %> 
<!--#Include file="MembersHeader.asp"-->

<br />
<div class ="container roundedtopandbottom">
<div>
  <div>
	<H1>Reset Your Password</H1>
<br />
<table  align = "center" width ="460">
	<tr >
		<td align = "center" class = "body" valign = "top">
<%
message = "?message="
Dim Password
Password = Request.Form("LeftShoe") 
Password2 = Request.Form("RightShoe") 
if not Password=Password2 then
message = message & "<li>Your passwords do not match.</li>"
end if

if len(Password) < 9 then
message = message & "<li>Your passwords are too short.</li>"
end if


if len(message) > 12 then
  'response.redirect("MembersPasswordChange.asp" & message)
end if


PeopleID= Request.Form("PeopleID") 
if len(Password) > 0 and len(PeopleID) > 0 then
	Query =  " UPDATE People Set PeoplePassword = '" &  Password & "' " 
    Query =  Query & " where PeopleID = " & PeopleID & ";" 
'response.write(Query)	
Conn.Execute(Query) 
end if
 %>
<div align = "center">
<%
     response.write("Your Password has Been Changed.")
  %>



			<br>
			<br>
		</td>
	</tr>
</table>
<br />
</div>
</div>
</div>

<!--#Include file="membersFooter.asp"--> </Body>
</HTML>
