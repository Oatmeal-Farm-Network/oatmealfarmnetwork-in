<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Send Password - <%=Sitenamelong%> Online livestock Marketplace</title>
<meta name="Title" content="Create Account - <%=Sitenamelong%> Online livestock Marketplace">
<meta name="description" content="Create your account at <%=Sitenamelong%> - Online livestock Marketplace." >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index, follow">
<meta name="robots" content="All">
<link rel="stylesheet" type="text/css" href="Style.css">

</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>
 <% Current = "Home" %>
<% Current3="Signin" %>
<!--#Include virtual="/Header.asp"-->
<% if screenwidth > 700 then %>
<!--#Include virtual="/join/JoinHeader.asp"-->
<% End if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" >
<tr><td align = "left" >
<h1>Send Password</h1>
</td></tr>
<tr><td valign = "top" height = 500 >
        
<table border = "0" bordercolor = "#DBF5F3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "320"  valign = "top">
	
<form action= 'SendpasswordStep2.asp?Screenwidth=<%=Screenwidth %>' method = "post">
	<tr > 
		<td  align = "left" class = "body2">
		Enter your email address below and select the "Send Password" button and your password will be sent to your email box.<br><br>
		<b>Email</b><br /> <input name="Email" size = "52" value="" class="formbox"></center>
		</td>
	</tr>
<tr>
		<td  valign = "top" align = "center" class = "body2">
	<br>
			<div align = "center">
			<input type=submit value = "SEND PASSWORD" size = "110"  class = "regsubmit2"></div>
			
		</td>
</tr>
<tr>
<td><br>
</form>
</td></tr></table>
<br><br>
</td></tr></table>
<!--#Include virtual="Footer.asp"-->
</Body>
</HTML>