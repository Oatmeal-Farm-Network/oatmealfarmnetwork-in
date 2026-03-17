<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>

<meta http-equiv="Content-Language" content="en-us">
<title>Account Confirmation</title>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/GlobalVariables.asp"-->
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
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" >
<% Current = "Home" %>
<!--#Include virtual="/Header.asp"-->
<center>

<br />
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
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" height="650"><tr><td  align = "center" valign = "top">
<H1><div align = "left">Set Password</div></H1>
        
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "700">
	<tr>
	    <td class = "body"  height = "420" valign = "top" align = "center">
			<br>
			<b>Please set your password below:</b><br>
			(<font color = darkgreen><b>Required field fields are indicated in green.</b></font>)<br><br>
	<% If passworderror= "True"  Or passwordlengtherror= "True" Then %>
<table border="0"  cellspacing="0" cellpadding="5" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" width = "100%" align = "center" valign = "top">
			<tr>
			<td class = "body" valign = "top" align = "center">
			There were the following errors with your information:<BR>

<% If passworderror= "True" Then %>
<font color = "red">The passwords that you entered do not match. Please re-enter your password below.</font>
<% End If %>
<%If passwordlengtherror= "True" Then %>
<font color = "red">The password that you entered was not long enough. Please enter a password that is at least 8 characters long.</font>
<% End If %>
</td></tr></table>
<BR><BR>
<% End If %>

			<form name=form action= 'AssociationAccountConfirmationStep2.asp' method = "post">
				<table>
 				<tr> 
                	<td  height="20" class = "body2" align = "right"> 
					<% If passworderror= "True" Or passwordlengtherror= "True" Then %>
					<font color = "red">Password </font>
					<% Else %>
					<font color = darkgreen><b>Password</b></font> 
					<% End If %>
			</td>
                	<td  height="20" class = "body2" align = "left">&nbsp;  
                    		<INPUT TYPE="Password" NAME="Password" size="25" class = formbox > (at least 8 characters long)
                	</td>
            	</tr>
            	<tr> 
                	<td  height="20" class = "body2" align = "right">
					<% If passworderror= "True" Or passwordlengtherror= "True" Then %>
					<font color = "red">Confirm Your Password: </font>
					<% Else %>
					<font color = darkgreen><b>Confirm Your Password</b> </font>
					<% End If %>
					 </td>
                	<td  height="20" class = "body"  align = "left">&nbsp; 
                		<INPUT TYPE="Password" NAME="Password2" size="25" class = formbox>
                	</td>
            	</tr>
				</table>
          <INPUT name="PeopleID" type="hidden" value="<%=PeopleID %>" >
         <INPUT name="AssociationID" type="hidden" value="<%=AssociationID %>" >
		<center><input type=button value="ACTIVATE ACCOUNTS" onclick="verify();" class = "regsubmit2"></center>
			</form><br>
	    
</td>
	</tr>
</table>	

</td>
	</tr>
</table>	
</center>	
<!--#Include virtual="/Footer.asp"-->
</body>
</html>