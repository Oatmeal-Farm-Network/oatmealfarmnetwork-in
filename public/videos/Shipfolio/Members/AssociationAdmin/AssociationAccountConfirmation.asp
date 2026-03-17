<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>

<meta http-equiv="Content-Language" content="en-us">
<title>Account Confirmation</title>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";

if (document.form.Password.value=="") {
themessage = themessage + " -Password \r";
}

//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.form.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>

</head>
<BODY  >
<% Current = "Home" %>
<!--#Include virtual="/includefiles/Header.asp"-->
 <div class="container-fluid" style="max-width: 600px" >
<div class="form-group">

 <%AssociationID = session("AssociationID") 
if len(AssociationID) > 0 then
else
AssociationID = request.querystring("AssociationID")
end if
if len(AssociationID) > 0 then
else
AssociationID = request.form("AssociationID")
end if


PeopleID = session("PeopleID") 
if len(PeopleID) > 0 then
else
PeopleID = request.querystring("PeopleID")
end if
if len(PeopleID) > 0 then
else
PeopleID = request.form("PeopleID")
end if



'Response.write("AssociationID=" & AssociationID )%>
<%
passwordlengtherror = request.querystring("passwordlengtherror") 
passworderror = request.querystring("passworderror") 
%>
<H1><div align = "left">Set Your Password</div></H1>
 
 <% If passworderror= "True"  Or passwordlengtherror= "True" Then %>
There were the following errors with your information:<BR>
<% If passworderror= "True" Then %>
<font color = "red">The passwords that you entered do not match. Please re-enter your password below.<br /></font>
<% End If %>
<%If passwordlengtherror= "True" Then %>
<font color = "red">The password that you entered was not long enough. Please enter a password that is at least 8 characters long.<br /></font>
<% End If %>
<BR><BR>
<% End If %>

<form name=form action= 'AssociationAccountConfirmationStep2.asp' method = "post">
					<% If passworderror= "True" Or passwordlengtherror= "True" Then %>
					<font color = "marooon">Password </font>
					<% Else %>
					Password
					<% End If %><br />
                 	<INPUT TYPE="Password" NAME="Password" width="300" style="width: 300px" placeholder = "Password must be at least 8 characters long"  class = formbox ><br />
					<% If passworderror= "True" Or passwordlengtherror= "True" Then %>
					<font color = "maroon">Confirm Your Password: </font>
					<% Else %>
					Confirm Your Password
					<% End If %><br />
                	<INPUT TYPE="Password" NAME="Password2" placeholder = "Reenter your password" width="300" style="width: 300px" class = formbox><br />
          <INPUT name="PeopleID" type="hidden" value="<%=PeopleID %>" >
         <INPUT name="AssociationID" type="hidden" value="<%=AssociationID %>" >
		<center><input type=button value="SET PASSWORD" onclick="verify();" class = "regsubmit2"></center>
			</form><br>
</div>
</div>
<!--#Include virtual="/includefiles/Footer.asp"-->
</body>
</html>