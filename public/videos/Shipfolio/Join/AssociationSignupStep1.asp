<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<title>Create an Association Account</title>

<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="Content-Language" content="en-us">
<% Region = Request.Form("Region")

'response.write("Region=" & Region )
if len(Region) < 2 or Region="Country / Region" then
   response.redirect("/Join/Default.asp?Message=Please choose a Country/Region.")  
end if
%>

</head>
<body >
<!--#Include virtual="/Header.asp"-->


<% Region = request.form("Region") %>
<div class="container d-flex align-items-center justify-content-center" style="min-width: 350px;">
        <div >
                <h1>Create an Association Account</h1>

 We have two types of accounts:
 <ul><li><b>Farm accounts.</b> For individuals and ranches, fishermen, and farms.</li>
<li><b>Association Accounts.</b> For clubs, registrars, and other types of Associations.</li>
</ul>
In order to set up an Association account you need to have a farm account.<br /><br />


   
<div class = "row">
  <div class = "col" style="max-width:460px">
  
<%' Login with existing Ranch Account to Create Association Account %>
<div class = "roundedtopandbottom" >
  <% Fail = request.QueryString("Fail")
if Fail = "True" then %>	

<b><font color=maroon>Sign In Failed. The email / password combination that you tried failed. Please try again.</font></b><br />
	<% end if %>	

<h2>Have a Farm Account?</h2>
If you already have a Farm account, login below:
<form  name=Login method="post" action="SetupAssociationAccountExistingmember.asp?Region=<%=Region %>" >
Log into your ranch account below:<br /><br />
    Email&nbsp;<br />
    <input name="Email" Value =""  size = "30" class = "formbox" maxlength = "61"  ><br />
    Password&nbsp;</br>
    <input name="password" type = password Value ="" size = "30" maxlength = "61" class = "formbox"></br><br>
    <div align = center><input type="submit" class = "regsubmit2" value="Submit"  ></div>
</form>
</div>
<br>
<%' Forgot Ranch Account Password %> 
<div class = "roundedtopandbottom" >
	<h2>Forgot your Farm Account Password?</h2> 
   
	<form action= '/Join/RanchSendpasswordStep2.asp?Region=<%=Region %>' method = "post">
		Please fill out the form below:<br><br>
		Email<br> 
            <input name="Email" Value =""  size = "30" class = "formbox" maxlength = "61"  ><br />
            <div align = center><input type="submit" class = "regsubmit2" value="Send Password"  ></div>		
<br>
</form>
</div>
<br />

<div>
</div>
</div>
 
<!--#Include virtual="/Footer.asp"-->
</body>
</html>