<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Associations & Clubs | Create Account</title>
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->

</head>

<body >

<% Current = "CreateAccount"
Current3="Create"
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<!--#Include Virtual="/includefiles/Header.asp"-->

<div class="container-fluid">
  <h1>Create an Account for Your Association</h1>
  <p>We have two types of accounts:
<ul><li><b>Ranch accounts.</b> For individuals and ranch / farm business.</li>
<li><b>Association Accounts.</b> For Clubs, Registrars, and other types of Associations.</li></ul>
In order to set up an Association account you need to have a ranch account.<br /><br />

If you already have a ranch account on another one of our websites, you do not need to create a new one here. 
</p>

  <div class="row">
    <div class="col-sm-6" style="background-color:eee0c4">
    
    <h2>I Already Have a Ranch Account.</h2>
        <form  name=form method="post" action="SetupAssociationAccountExistingmember.asp">
        <% AssociationError = request.querystring("AssociationError")
            if AssociationError="True" then %>	<b><font color = "maroon">Your username or password do not match our records.</font></b><br />
        <% end if %>
        Log into your Ranch Account below:<br />
        <b>Email</b><br />
        <input name="PeopleEmail" Value =""  size = "33" maxlength = "61" style="width: 300px;" class = "formbox"><br />
        <b>Password</b><br />
        <input name="PeoplePassword" type = password Value ="" size = "33" maxlength = "61" class = "formbox"><br>
        <input type="submit" class = "regsubmit2" value="SETUP ASSOCIATION ACCOUNT"  ><br>
        </form>
	    Forgot your password? <a href = "AssociationSendPassword.asp?Screenwidth=<%=Screenwidth %>" class = "body">Click Here.</a><br>





</div>
    <div class="col-sm-1" ></div>
    <div class="col-sm-5" style="background-color:eee0c4">
        <h2>I DON'T Have A Member Account for My Ranch.</h2>
        <form  name=form method="post" action="SetupAssociationAccount.asp">
        Create a New Accounts for Your Business AND Your Association.<br />
        <br />
        <input type="submit" class = "regsubmit2" value="SETUP BOTH TYPES OF ACCOUNTS"  ><br>
        <br>
        </form>

    </div>
  </div>
</div>



<!--#Include Virtual="/includefiles/Footer.asp"--> </body>
</HTML>