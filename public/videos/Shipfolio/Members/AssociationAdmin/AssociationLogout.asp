<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Member Area</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->

</head>
<body >

<%  
Set rs = Server.CreateObject("ADODB.Recordset")%>

<% Current = "CreateAccount"
Current3="AssociationLogin"
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<!--#Include virtual="/includefiles/Header.asp"-->

<% loginpage = True 
Response.Cookies("AssociationID")=""
Response.Cookies("PeopleID")=""
Session.Abandon
%> 
<div class="container-fluid" style="max-width: 600px" >
<H1>Sign Out</H1>
<form action= 'AssociationMembersLoginHandle.asp' method = "post">
   <div class="row">
    <div class="col">
		You have signed out of the association area. Feel free to use the form below to log back in:<br>
		
		<b>Email<b><br />
		<input type=text name=UID value= "" style="max-width: 300px" class = "formbox"><br />
		<b>Password</b><br />
        <input type= password name=password value= "" style="max-width: 300px" class = "formbox"><br />
		<center><input type=submit value = "Login"  class = "regsubmit2" ></center>
		<br /><br />
    </div>
 </div></form>
</div>

<!--#Include virtual="/includefiles/Footer.asp"-->	
</body>
</html>