<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Login Authentication</title>
     <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
  
<%


	
	UID=Request.Form("UID") 
	password=Request.Form("password") 

	if password = "R12391"  and UID = "Alpacas" then
	    Session("access")=True
		Response.Redirect("default.asp")
	else Session("access")=False
	end if


%>


<table  align = "center" border="0" cellpadding="2" cellspacing="2" height = "400" width = "778"  > 
	<tr >
		<td align = "center"><br><br>
			<br><a  class = "Links" href="Login.asp"> Your username or password was incorrect.<br>Please click to return to the login page and try again.</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
