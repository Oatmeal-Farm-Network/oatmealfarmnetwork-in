<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Login</title>

<link rel="stylesheet" type="text/css" href="/Administration/style.css">

</head>


<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% loginpage = True %>

<br><br><br><br>
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
						<td>
							Email:<br>
							Password:<br>
						</td>
						<td>	
							<input type=text  name=UID value= "" SIZE = "36" ><br>
							<input type= password name=password value= "" SIZE = "36"><br>
						</td>
					</tr>
				</table>

			<input type=submit value = "Login"  size = "170" class = "body" >
			</form>
	   	 <% End If %>
			<%
		
			If live = False Then %>
	   <center>Currently we are improving the website. The administration area will be available soon. We are sorry for any inconvenience.</center>

	      <% End if%>
		</td>
		
	</tr>
</table>	







</body>
</html>