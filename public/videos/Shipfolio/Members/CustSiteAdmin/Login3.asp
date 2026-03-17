<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Login</title>
<META name="description" content="contact <%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacabargainhunter.com/infinityknot.ico" /> 
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="/Administration/style.css">

</head>


<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% loginpage = True %>

<!--#Include virtual="/Administration/Header2.asp"-->
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "600" height = "300">
	<tr>
	    <td class = "body"  height = "83" valign = "top" align = "center">
			<br>
			<br><h1>Login</H1>
			<form action= 'handleLogin.asp' method = "post">
				<table>
					<tr>
						<td>
							Email:<br>
							Password:<br>
						</td>
						<td>	
							<input type=text  name=UID value= "" SIZE = "30" ><br>
							<input type= password name=password value= "" SIZE = "30"><br>
						</td>
					</tr>
				</table>

			<input type=submit value = "Login"  size = "170" class = "body" >
			</form>
	    
		</td>
		<td width = "5"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "1" bgcolor = "black"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "5"><img src = "images/px.gif" height="0" width = "0"></td>

		<TD class = "body" width = "200" valign = "top">	
			<br>
			<br><h2>Register</H2>
			Not Registered with <%=WebSiteName %> Yet? <a href = "/signup.asp" class = "body">Click here</a> to get started.

<br>
			
			<br><h2>Forgot Your Password?</H2>
			<a href = "SendPassword.asp" class = "body">Click Here</a> to have your password emailed to you.
	
	  </TD>
	</tr>
</table>	



<!--#Include virtual="/Administration/Footer.asp"-->



</body>
</html>