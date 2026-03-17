<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Account Confirmation</title>
<META NAME="ROBOTS" CONTENT="NOODP">
<link rel="stylesheet" type="text/css" href="style.css">
<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";

if (document.form.ActivationCode.value=="") {
themessage = themessage + " -Activation Code \r";
}

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
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >

<!--#Include virtual="/Header.asp"-->
<br />
        
<%
passwordlengtherror = request.querystring("passwordlengtherror") 
passworderror = request.querystring("passworderror") 
	Activationerror = request.querystring("Activationerror") 
%>

   <br /><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "900"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Account Confirmation</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
        
        
<table  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   width = "95%"  align = "center">
  <tr>
    <td class = "body">
<br>

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "700">
	<tr>
	    <td class = "body"  height = "83" valign = "top" align = "center">
			<br>
			<b>Please enter your activation code and your new password below:</b><br>
			("*" indicates a required field)<br><br>
	<% If passworderror= "True" Or Activationerror= "True" Or passwordlengtherror= "True" Then %>
<table   border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" width = "100%"     align = "left" valign = "top">
			<tr>
					<td class = "body" valign = "top" align = "left">
						There were the following errors with your information:<BR>
							<% If Activationerror= "True" Then %>
										<font color = "red">The activation code you entered is invalid, please try re-entering your code.</font>
							<% End If %>
							
							<% If passworderror= "True" Then %>
										<font color = "red">The passwords that you entered do not match. Please re-enter your password below.</font>
							<% End If %>
							<%
						
							If passwordlengtherror= "True" Then %>
										<font color = "red">The password that you entered was not long enough. Please enter a password that is at least 8 characters long.</font>
							<% End If %>
</td></tr></table>
<BR><BR>
<% End If %>
<center>
			<form name=form action= 'AccountConfirmationStep2.asp' method = "post">
				<table>
					<tr>
						<td class = "body" align = "right">
							<% If Activationerror= "True"   Then %>
					<font color = "red">Activation Code: </font>
					<% Else %>
					Activation Code:
					<% End If %>
					
					
						</td>
						<td class = "body" align = "left">
							&nbsp;  <input type= password name=ActivationCode value= "" SIZE = "15">*
						</td>
						</tr>
						<tr> 
                	<td  height="20" class = "body" align = "right"> 
					<% If passworderror= "True" Or passwordlengtherror= "True" Then %>
					<font color = "red">Password: </font>
					<% Else %>
					Password: 
					<% End If %>
			</td>
                	<td  height="20" class = "body" align = "left">&nbsp;  
                    		<INPUT TYPE="Password" NAME="Password" size="15" >* (at least 8 characters long)
                	</td>
            	</tr>
            	<tr> 
                	<td  height="20" class = "body" align = "right">
					<% If passworderror= "True" Or passwordlengtherror= "True" Then %>
					<font color = "red">Confirm Your Password: </font>
					<% Else %>
					Confirm Your Password: 
					<% End If %>
					 </td>
                	<td  height="20" class = "body"  align = "left">&nbsp; 
                		<INPUT TYPE="Password" NAME="Password2" size="15">*
                	</td>
            	</tr>
				</table>

		<input type=button value="Activate!" onclick="verify();" class = "regsubmit2"></center>
			</form><br>
	    
</td>
	</tr>
</table>	

</td>
	</tr>
</table>
<br /><br />
<!--#Include virtual="/Footer.asp"-->



</body>
</html>