<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/globalvariables.asp"-->
<title><%=WebSiteName %> | Emus, Turkeys, Rabbits, Alpacas, Goats, Horses, Cattle, Donkeys, Llamas, Pigs, & Sheep for Sale</title>
<meta name="title" content="<%=WebSiteName %> | Emus, Turkeys, Rabbits, Alpacas, Goats, Horses, Cattle, Donkeys, Llamas, Pigs, & Sheep for Sale"/> <meta name="description" content="Horses, Goats, Alpacas, Cattle, Donkeys, Llamas, Pigs, and Sheep for Sale plus a ranch directory, products for sale, and sales listings."/>  
<meta name="keywords" content="<%=WebSiteName %>,
livestock,
alpacas for sale,
cattle for sale,
cows for sale,
goats for sale,
horses for sale,
livestock for sale,
llamas for sale,
sheep for sale,
pigs for sale,
alpacas,
cattle,
cows,
goats,
horses,
llamas,
sheep,
pigs,
loa,
best farm buys"/>
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="Content-Language" content="en-us">
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

<% Action = Request.querystring("Action") 
ReturnFileName = Request.querystring("ReturnFileName")
ExistingAccount = Request.querystring("ExistingAccount")

if len(ReturnFileName) > 1 then
else
ReturnFileName = request.querystring("ReturnFileName")
end if 
ReturnEventID = Request.querystring("ReturnEventID") 

if len(Action) > 1 then
 Session("Action") = Action
end if
UnderConstruction = False
if UnderConstruction = True then %>
<table width = "<%=screenwidth %>"  border = "0" cellpadding = "0" cellspacing = "0"  align = "left">
  <tr>
  <td >
     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" height = "100%" >
	<tr>
	<td  align = "center" valign = "top">
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td align = "left">
		<H1><div align = "left">Sign In</div></H1>
        <br />
        <h2>Under Construction</h2>
        <b>Currently the Administrative dashboard area is down for improvements. We are sorry about any inconvenience this might cause.</b>
        
   </td>
   </tr>
   </table>     
     </td>
   </tr>
   </table>   
      </td>
   </tr>
   </table>         
<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" >
<tr><td class = "body" align = "left" height = 550 valign = top>

<H1><div align = "left">Sign In</div></H1>
<% AILogin=request.querystring("AILogin")
if AILogin="True" then %>
<center><img src = "images/AILogo.jpg" height= '90'/> <big><b>is now </b></big><img src = "images/LOALogo.jpg" height = '90'/></center>
 <% end if %>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" height = "250" align = "center" >
<tr><td class = "body" align = "center" valign = "top" width = "60%" >
<br /><br />

<% if ExistingAccount = "True" then %>	
	<table><tr><td align = "left" bgcolor = "#EEDD99" class = "body"><blockquote><br />
<b>An account with that email address is already in our system, please sign in below, <a href = "sendpassword.asp" class = "body">have your password sent to you </a> , or <a href = "SetupAccount.asp?ReturnFileName=<%=ReturnFileName%>&ReturnEventID=<%=ReturnEventID%>" class = "body">set up a new account</a>.</b></blockquote><br /></td></tr></table> 
<% end if %>	
		    
<% Fail = request.QueryString("Fail")
if Fail = "True" then %>	

<table><tr><td align = "left" bgcolor = "#EEDD99" class = "body"><blockquote><br /><h3><b>Sign In Failed</b></h3>
<b>The email / password combination that you tried failed. Please try again. The password is case sensitive so make sure that your caps lock is not turned on.</blockquote><br /></td></tr></table> 
	<% end if %>	
	<% live = True
if Live = True then %>	    
<form  name=Login method="post" action="Handlelogin.asp?screenwidth=<%=screenwidth %>" >
			
<% if mobiledevice = True then %>
<table width = "320"  align = left border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" colspan = 2>
Log into your account below:<br /><br />
</td></tr>

  <tr>
    <td class = "body2" align = "right" height = 45>Email&nbsp;</td>
  </tr>
  <tr> 
    <td align = "left"><input name="Email" Value =""  size = "25" class = "formbox" maxlength = "61"  ><br /><br /></td></tr>
   <tr><td class = "body2" align = "right" >Password&nbsp;</td>
     </tr>
  <tr> 
   <td align = "left" class = "body"><input name="password" type = password Value ="" size = "25" maxlength = "61" class = "formbox"></td>
   </tr>


<% else %>
<table width = "320"  align = center border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" colspan = 2>
Log into your account below:<br /><br />
</td></tr>
  <tr>
    <td class = "body2" align = "left" width = "150" height = 45>Email&nbsp;</td>
      </tr>
  <tr> 
    <td align = "left"><input name="Email" Value =""  size = "33" maxlength = "61" style="width: 300px;" class = "formbox"></td></tr>
   <tr><td class = "body2" align = "left" width = "150"><br />Password&nbsp;</td>
     </tr>
  <tr> 
   <td align = "left" class = "body"><input name="password" type = password Value ="" size = "33" maxlength = "61" class = "formbox"></td>
   </tr>
<% end if %>

   <tr>
        <td  class = "body2" colspan = "2" align = "center"><br />
    <input type="submit" class = "regsubmit2" value="Continue"  ><br>
    <br></form>
	Forgot your password? <a href = "sendpassword.asp?Screenwidth=<%=Screenwidth %>" class = "body">Click Here.</a><br>
	
	

</td></tr></table>
<% else %>
<table width = "<%=screenwidth %>" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
  <tr>
    <td class = "body" align = "left" width = "110">
    <h1>Under Construction</h1>
    Currently we are making improvements to Livestock Of The World. <br />We are sorry for any inconvenience.
</td></tr></table>
<% end if %>		    
</td>
<% if screenwidth > 800 then %>
<% else %>
</tr><tr>
<% end if %>
<% showfirsttime = false
if showfirsttime = True then %>
<td class = "body2" valign = "top" width = "40%" align = "center"><br /><br />
<h2><center>First Time Signing In?</h2>
If you haven't set up an account with us before <br>
please select the button below to get started: <br><br>
<form name=NewAccount method="post" action="/join/default.asp?Screenwidth=<%=Screenwidth %>">
<input type="submit" class = "regsubmit2" value="Set Up Account"  ><br></center>
</form>
</td>
<% end if %>
</tr></table>	
</td></tr></table>
<% end if %>    
<!--#Include virtual="/Footer.asp"-->
</body>
</html>