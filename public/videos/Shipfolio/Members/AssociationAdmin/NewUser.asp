<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<meta name="revisit-after" content="nevers"/>

<script>
function validateForm() {
  var password = document.getElementById("Password").value;
  var confirmPassword = document.getElementById("ConfirmPassword").value;
  
  if (password !== confirmPassword) {
    alert("Password and Confirm Password do not match.");
    return false;
  }
  
  if (password.length < 8) {
    alert("Password must be at least 8 characters long.");
    return false;
  }
  
  var specialCharacterRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
  if (!specialCharacterRegex.test(password)) {
    alert("Password must contain at least one special character.");
    return false;
  }
  
  return true;
}
</script>


</head>
<body >
<% Current3 = "AssociationLogin" %>
<!--#Include virtual="/Header.asp"-->

<% 
Set rs = Server.CreateObject("ADODB.Recordset")
PeopleID=request.querystring("PeopleID")
AccessLevel=request.querystring("AccessLevel")


%>
<div class="container border" >
    <b>Set Password</b>
    <form name="form" method="post" action="NewUserHandleForm.asp?PeopleID=<%=PeopleID%>&AccessLevel=<%=AccessLevel %>" onsubmit="return validateForm();">
        <div class="container border" style="max-width: 460px; margin: auto;">

            <% changesmade = request.QueryString("changesmade")
            if changesmade = "True" then %>
            <div style="background-color: #B2D6D1; min-height: 60px;">
                <br />
                <b><FONT COLOR="#184E79">Your changes have been made.</FONT></b><br>
            </div>
            <% end if %>
Enter your new password below:<br />
            <div class="row">
                <div class="col">
                    
                    <%=HSpacer %>
                    <div class="row">
                        <div class="col">
                            Password<br />
                            <input type="password" id="Password" value="<%=Password%>" name="Password" required width="300" style="width: 300px; text-align: left" class="formbox" /><br />
                            <font color="#abacab">At least 8 characters with a special character.</font><br />
                        </div>
                    </div>

                    <%=HSpacer %>
                    <div class="row">
                        <div class="col">
                            Confirm Password<br />
                            <input type="password" id="ConfirmPassword" name="ConfirmPassword" value="<%=Password%>" required width="300" style="width: 300px; text-align: left" class="formbox" /><br />
                        </div>
                    </div>
                    <%=HSpacer %>

                    <div class="row">
                        <div class="col">
                            <center><input type="submit" value="Update" class="submitbutton" /></center>
                            <br />
                            <input name="PeopleID" type="hidden" value="<%=PeopleID%>">
                            <input name="AddressID" type="hidden" value="<%=AddressID%>">
                            <br /><br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<br /><br />






<!--#Include virtual="/Footer.asp"-->
    </Body>
</HTML>