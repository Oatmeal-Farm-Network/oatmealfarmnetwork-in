<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% currentpage="ungated"%>
<!--#Include virtual="/Header.asp"-->
 <div class="container-fluid" >
    <div align = center>
     <div class = "container" style="max-width: 1400px; min-height: 57px; text-align: center;">
    <div>
      <div class = "body">
       <br /> <h1>Sign Out</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
 <div class = "container" style="max-width: 1000px; min-height: 800px">

  <div>
   <div class = "body" valign = Top>

 


<%
 Session.Abandon
Session("PeopleID") = ""
Session("LoggedIn") = False
Response.Cookies("LoggedIn")= False
Response.Cookies("PeopleID")= ""

if len(PeopleID) > 0 then
response.redirect("logout.asp?screenwidth=" & screenwidth )
end if
Current = "Home" %>

<% loginpage = True %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class ="roundedtopandbottom"><tr><td align = "center">

<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"  style="max-width = "640" width = "90%"  height = "300">
	<tr>
	    <td class = "body2"   valign = "top" align = "center"><br><br>
			<b>You have been signed out of your account.</b><br>
			Feel free to use the form below to sign back in:
			<form action= 'handleLogin.asp' method = "post">
				<table>
                	<tr>
						<td class = body>
							Email<br />
							<input type=text  name=UID value= "" SIZE = "36" class = formbox><br>
						</td>
					</tr>
					<tr>
						<td class = body>
							Password<br>
							<input type= password name=password value= "" SIZE = "16" class = "formbox"><br>
						</td>
					</tr>
				</table>
                <br />
			<input type=submit value = "SIGN IN"  size = "170" class = "regsubmit2" >
			</form>
		</td>
	</tr>
</table>	
		</td>
	</tr>
</table>
	
      </div>
</div>
</div>
<!--#Include virtual="/Footer.asp"-->
</body></html>