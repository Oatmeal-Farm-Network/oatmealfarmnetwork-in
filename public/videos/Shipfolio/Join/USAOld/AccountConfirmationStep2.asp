<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->

<meta http-equiv="Content-Language" content="en-us">
<script>
function togglePasswordVisibility() {
  var passwordInput = document.getElementById("password");
  if (passwordInput.type === "password") {
    passwordInput.type = "text";
  } else {
    passwordInput.type = "password";
  }
}
</script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<% 
ActivationCode = Trim(Request.Form("ActivationCode"))
PeopleID = Request.Form("PeopleID ")

errorstring1=""
errorstring2=""
emailerror = False
Passworderror = False
Activationerror = False

sql = "select * from  People where ActivationCode = '" & ActivationCode & "'"
   ' response.write("sql=" & sql)

rs.Open sql, conn, 3, 3
If not rs.eof Then
	Activationerror = False
   PeopleID = rs("PeopleID")
  session("PeopleID") = PeopleID 
Else
	Activationerror = True
End if	




If Activationerror = False then
	
Query =  " UPDATE People Set accesslevel = 1" 
Query =  Query & " where ActivationCode = '" & ActivationCode & "'" 
'response.write(Query)
Conn.Execute(Query) 
Conn.close
end if	
%>
</HEAD>
<BODY align = "center">

<!--#Include virtual="/Header.asp"-->
  <div class="container-fluid" style="background-color: #CC9966;" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Activation Completion</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<br />

<% 
   session("PeopleID") = PeopleID 
PID = request.form("PID")
session("PID") = PID
FullPrice = request.form("FullPrice")


If  Activationerror = True Then 
	redirectString = "AccountConfirmation.asp?Activationerror=" & Activationerror
	'response.redirect(redirectString)
Else 	%>
     
<div class="container d-flex justify-content-center" style = "max-width:460px; min-height: 400px">
<div class ="row">
	<div class ="col-12 justify-content-left roundedtopandbottom" style = "max-width:460px; ">
	<br /><b>Your Account is Set Up and Activated!</b><br />
	
       <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
         <% If Membership = "Business" then
              Subscriptionlevel = 2
            end if
            If Membership = "Global" then
              Subscriptionlevel = 3
            end if

              
           if len(PeopleID1)> 0 then
            sql = "Update People set Subscriptionlevel = " & Subscriptionlevel & " , accesslevel = 1, PeopleStripeCustomerID= '" & StripeCustomerID & "' , StripeSubscriptionID = '" & StripeSubscriptionID & "' where PeopleID = " & PeopleID1 & ""
            '  response.write("sql=" & sql)
           Conn.Execute(sql) 
           end if%>

       <br />Your  <%=membership %> membership has been created. Now you can sign into your new account below:<br /><br />
   
           <div class ="container"  style="max-width:420px; text-align:center" >
            <div class ="row">
                <div class ="col" align ="left">

                <h3><center>Sign In</center></h3>
      <br />
                 <form  name=Login method="post" action="https://www.harvesthub.world/Handlelogin.asp" >
   
                <% Fail = request.QueryString("Fail")
                if Fail = "True" then %>	

                <b><font color=maroon>The email / password combination that you tried failed.</font></b><br />
                <% end if %>	
                    Email&nbsp;<br />
                    <input name="Email" Value ="" size = "36" class = "formbox" maxlength = "36" ><br /></br>
                    Password&nbsp;
                    </br>
                    <div class="input-group">
                      <input type="password" class="formbox" id="password" name="password" placeholder="Password" size= 30 maxlength="30">
                      <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility()">
                          <i class="fa fa-eye"></i>
                    </button>
                  </div>
                </div>
                <br />
                 <center><input type="submit" class = "roundedtopandbottomyellow" value="Submit"  ></center><br>
                </form>
	            <center>Forgot your password? <a href = "https://www.harvesthub.world/sendpassword.asp" class = "body" target="_blank">Click Here.</a></center><br>
	            </div>

      </div>
    </div>
 </div>
           </div>
 </div>
              </div>
 </div>
<br/>
<br/>	
<br/>			
<br/>	    
</div>
    </div>
    </div>
<% End if %>							
<!--#Include virtual="/Footer.asp"-->
</body>
</html>