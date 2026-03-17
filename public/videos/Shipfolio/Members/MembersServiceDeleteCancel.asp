<!DOCTYPE HTML>

<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 

<% ServicesID = request.querystring("ServicesID")
if len(ServicesID) > 0 then
else
ServicesID = request.form("ServicesID")
end if	 %>

</head>
<body >

<% Current1="Services"
Current2 = "DeleteService"%> 
<!--#Include file="membersHeader.asp"--> 
<% Current3 = "Delete"  %>
<!--#Include File="MembersServicesJumpLinks.asp"--> 
<div width = "100%" class = "roundedtopandbottom" align = "center">
<div class ="row">
	<div class ="col" >
<h3>Delete Service</h3>
<center>Your service deletion has been aborted.<br><br></center>
		<br /><br /><br /><br /><br /><br />
	</div>
	</div>
</div>
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>