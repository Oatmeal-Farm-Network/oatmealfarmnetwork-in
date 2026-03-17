<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>SOJAA Administration Home Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">





</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include file="PNAAHeader.asp"--> 
<table height = "200" align = "center">
		<tr>
		    <td class = "body" valign = "top" align = "center">
			
			<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "700" bgcolor = "#eeeeee">
			<tr>
		<td align = "center"  colspan = "2"><img src = "images/PNAALogin.jpg"></td>
	</tr>
	<tr>
	    <td class = "body"  height = "83" valign = "top" align = "center">
		<br><br>
			<%
			live = True
			If live = True Then %>
		
			<form action= "http://www.pnaaalpacas.com/Administration/handleLogin.asp" method = "post" target = "blank">
				<table>
					<tr>
						<td>
							Email:<br>
							Password:<br>
						</td>
						<td>	
							<input type=text  name=UID SIZE = "36" value = "<%=PNAAEmail %>"><br>
							<input type= password name=password SIZE = "26" value = "<%=PNAAPassword %>"><br>
						</td>
					</tr>
				</table>

			<input type=submit value = "Login"  size = "170" class = "body" >
			</form>
	   	 <% End If %>
			
		
		</td>
		<td bgcolor = "#dedede" width = "250" height = "200" class = "body" valign = "top">
				<br><blockquote><h2>Transferring Alpacas</h2> <a href = "/administration/Transfers/default.asp" class = "body">Click here</a> to transfer your alpacas to PNAA.org.</blockquote>
				</td>

		
	</tr>
</table>	


			</td>
		</tr>
	</table>
<br><br><br>
 <!--#Include file="Footer.asp"--> 
</BODY>
</HTML>