<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "600" height = "300">
<tr>
	<td class = "body"  height = "83" valign = "top" align = "center">
			<br>
			<br><h1>Login</H1>
			<%
				live = True
			If live = True Then %>
		
			<form action= 'handleLogin.asp' method = "post">
				<table>
					<tr>
						<td align = "right">
							Email:<br>
							Password:<br>
						</td>
						<td align = "left">	
							<input type=text  name=UID value= "" SIZE = "36" ><br>
							<input type= password name=password value= "" SIZE = "26"><br>
						</td>
					</tr>
				</table>

			<input type=submit value = "Login"  size = "170" class = "body" >
			</form>
	   	 <% End If %>
			<%
	
			If live = False Then %>
	   <center>
	   <H2>Temporarily Unavailable</h2>Currently we are improving the website. The administration area will be available soon. We are sorry for any inconvenience.</center>

	      <% End if%>
		</td>
		<td width = "5"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "1" bgcolor = "black"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "5"><img src = "images/px.gif" height="0" width = "0"></td>

		<TD class = "body" width = "200" valign = "top">	
			
			
				<br><h2>Forgot Your Password?</H2>
			


			<a href = "sendpassword.asp" class = "body">Click Here</a> to have your password emailed to you.
			
	  </TD>
	</tr>
</table>	

