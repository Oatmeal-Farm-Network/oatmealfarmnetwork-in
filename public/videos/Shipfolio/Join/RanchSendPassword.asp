<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!--#Include virtual="GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Send Password</title>

</head>
<body >

<!--#Include virtual="/Header.asp"-->

<div class="container d-flex align-items-center justify-content-center" style="min-width: 350px;">
 <div>
 <div>
<h1>Send Password</h1>
        
<table border = "0" bordercolor = "#DBF5F3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "320"  valign = "top">
	
<form action= '/Join/RanchSendpasswordStep2.asp?Region=<%=Region %>' method = "post">
	<tr > 
		<td  align = "left" class = "body2">
		Please fill out the form below:<br><br>
		<b>Email</b><br /> <input name="Email" size = "52" value="" class="formbox"></center>
		</td>
	</tr>
<tr>
		<td  valign = "top" align = "center" class = "body2">
	<br>
			<div align = "center">
			<input type=submit value = "Send Password" size = "110"  class = "regsubmit2"></div>
			
		</td>
</tr>
<tr>
<td><br>
</form>
</td></tr></table>
<br><br>
</div>
</div>
</div>
<!--#Include virtual="Footer.asp"-->
</Body>
</HTML>