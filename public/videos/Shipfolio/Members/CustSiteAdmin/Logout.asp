<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Login</title>
<META name="description" content="contact <%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="/Administration/style.css">

</head>


<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% loginpage = True %>
<%
Session.Abandon
%> 


<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "600" height = "300">
	<tr>
	    <td class = "body"  height = "83" valign = "top" align = "center">
			<br>
			<br><h1>Log Out</H1>
			You have been logged out of the administration area.<br>
			Feel free to use the form below to log back in:
			<form action= 'handleLogin.asp' method = "post">
				<table>
					<tr>
						<td>
							Email:<br>
							Password:<br>
						</td>
						<td>	
							<input type=text  name=UID value= "" SIZE = "26" ><br>
							<input type= password name=password value= "" SIZE = "26"><br>
						</td>
					</tr>
				</table>

			<input type=submit value = "Login"  size = "170" class = "body" >
			</form>
	    
		</td>
		

	</tr>
</table>	







</body>
</html>