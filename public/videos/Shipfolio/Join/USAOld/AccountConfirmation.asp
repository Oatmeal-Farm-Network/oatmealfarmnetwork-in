<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
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
<body >
<!--#Include virtual="/Header.asp"-->
   <div class="container-fluid" style="background-color: #CC9966;" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Account Confirmation</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<br /> 
<%
passwordlengtherror = request.querystring("passwordlengtherror") 
passworderror = request.querystring("passworderror") 
	Activationerror = request.querystring("Activationerror") 
%>
<div class="container d-flex justify-content-center" style = "max-width:460px; min-height: 90px">
<div class ="row">
	<div class ="col-12 justify-content-left roundedtopandbottom" style = "max-width:460px; ">
	<% If passworderror= "True" Or Activationerror= "True" Or passwordlengtherror= "True" Then %>
	<% If Activationerror= "True" Then %>
		<font color = "maroon"><b>The activation code you entered is invalid, please try re-entering your code.</b></font>
	<% End If %>
							
	
<BR><BR>
<% End If %>
<left>
<form name='form' action= 'AccountConfirmationStep2.asp?peopleID=<%=PeopleID %>' method = "post">
<h3>Enter Your Activation Code below</h3><br />
<% If Activationerror= "True"   Then %>
	<font color = "maroon">* Activation Code</font><br />
<% Else %>
	<font color = "maroon">*</font> Activation Code<br />
<% End If %>
&nbsp;<input type= text name=ActivationCode value= "" SIZE = "25" required>

<input type=submit value="Activate" onclick="verify();" class = "regsubmit2">
</form><br>
</left>

	</div>
</div> 
</div>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<!--#Include virtual="/Footer.asp"-->



</body>
</html>