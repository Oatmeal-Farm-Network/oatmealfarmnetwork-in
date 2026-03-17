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
<body >
<!--#Include virtual="/Header.asp"-->


<% Region = request.form("Region") %>
<div class="container d-flex align-items-center justify-content-center" style="min-width: 350px;">
        <div >
                <h1>Create an Association Account</h1>


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
      <img src = "/images/960492.png" align = "left" width = 180/>  <h2>Under Construction</h2>
        Currently the Account area is down for improvements. We are sorry about the inconvenience.

<% else %>

To sign into an association account select <a href="/associationadmin/associationLogin.asp" class = body>Associations & Clubs / Sign In</a>.<br />


<% if ExistingAccount = "True" then %>	
<blockquote><br />
<b>An account with that email address is already in our system, please sign in below, <a href = "sendpassword.asp" class = "body">have your password sent to you </a> , or 
<a href = "SetupAccount.asp?ReturnFileName=<%=ReturnFileName%>&ReturnEventID=<%=ReturnEventID%>" class = "body">set up a new account</a>.</b></blockquote><br />
<% end if %>	
		    

	<% live = True
if Live = True then %>	 
<form  name=Login method="post" action="Handlelogin.asp" >
   
<div class = "row">
  <div class = "col" style="max-width:460px">

  <% Fail = request.QueryString("Fail")
if Fail = "True" then %>	

<b><font color=maroon>Sign In Failed. The email / password combination that you tried failed. Please try again.</font></b><br />
	<% end if %>	
<br />
Log into your account below:<br />
    Email&nbsp;<br />
    <input name="Email" Value =""  size = "25" class = "formbox" maxlength = "61"  ><br /><br>
    Password&nbsp;</br>
    <input name="password" type = password Value ="" size = "25" maxlength = "61" class = "formbox"></br><br>
    <center><input type="submit" class = "regsubmit2" value="Submit"  ></center><br>
    <br></form>
	Forgot your password? <a href = "sendpassword.asp?Screenwidth=<%=Screenwidth %>" class = "body">Click Here.</a><br>
	

</div></div>
<% else %>


<% end if %>		    



<% end if %>   

</div>
</div>
 
<!--#Include virtual="/Footer.asp"-->
</body>
</html>