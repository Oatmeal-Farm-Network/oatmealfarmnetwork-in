
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%
dim PeopleID1, membership, Membership_price, StripePriceKey, StripeCustomerID, StripeSubscriptionID

    PeopleID1   =request.form("FinalPeopleID")
    membership   =request.form ("Finalmembership")
    Membership_price   =request.form ("FinalMembership_price")
    StripePriceKey   =request.form ("FinalStripePriceKey")
    StripeCustomerID   =request.form ("FinalStripeCustomerID")
    StripeSubscriptionID   =request.form ("FinalStripeSubscriptionID")
    PeopleFirstName  =request.form ("PeopleFirstName")
    PeopleEmail  =request.form ("PeopleEmail")
    PeoplePhone  =request.form ("PeoplePhone")
    PeopleLastName  =request.form ("PeopleLastNameD")


 %>

<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">

<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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


</head>
<body >
<% Current = "Home"
Current3="Register"
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->

    <div class="container-fluid" id="grad1" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Success</h1><br />
          </div>
        </div>
    </div>
    <div align = "center">
     <div class = "container roundedtopandbottom" >
    <div>
      <div class = "body">
         <% 'Response.write("Membership=" & Membership )
             If Membership = "Basic" then
              Subscriptionlevel = 2
            end if

             If Membership = "Business" then
              Subscriptionlevel = 3
            end if
            If Membership = "Global" then
              Subscriptionlevel = 5
            end if

              
          
             
         ErrorMessage = session("ErrorMessage")
        '     response.write("ErrorMessage=" & ErrorMessage )
         If InStr(1, Session("ErrorMessage"), "Error", 1) > 0 Then
            ' The session variable contains the word "Error"
            Response.redirect("checkout-billing.asp?Error=True&PeopleID=" & PeopleID1 & "&membership=" & membership & "&Membership_price=" & Membership_price & "&StripePriceKey=" & StripePriceKey & "&StripeCustomerID=" & StripeCustomerID & "&StripeSubscriptionID=" & StripeSubscriptionID & "&PeopleFirstName=" & PeopleFirstName & "&PeopleEmail=" & PeopleEmail & "&PeoplePhone=" & PeoplePhone & "&PeopleLastName=" & PeopleLastName)
        End If


 if len(PeopleID1)> 0 then
            sql = "Update People set Subscriptionlevel = " & Subscriptionlevel & " , accesslevel = 1, PeopleStripeCustomerID= '" & StripeCustomerID & "' , StripeSubscriptionID = '" & StripeSubscriptionID & "' where PeopleID = " & PeopleID1 & ""
              'response.write("sql=" & sql)
           Conn.Execute(sql) 
           end if
             
             
             %>
         
       <br /><b>Your  <%=membership %> membership has been created. Now you can sign into your new account below:</b><br /><br />
         <br />
           <div class ="container" style="max-width:420px; text-align:center" >
            <div class ="row">
                <div class ="col" align ="left">

                <h3>Sign In</h3><br />

                 <form  name=Login method="post" action="https://www.harvesthub.world/Handlelogin.asp" >
   
                <% Fail = request.QueryString("Fail")
                if Fail = "True" then %>	

                <b><font color=maroon>The email / password combination that you tried failed.</font></b><br />
                <% end if %>	
                    Email&nbsp;<br />
                    <input name="Email" Value ="" size = "42" class = "formbox" maxlength = "42"  ><br /></br>
                    Password&nbsp;
                    </br>
                    <div class="input-group">
                      <input type="password" class="formbox" id="password" name="password"  size= 36 maxlength="36">
                      <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility()">
                          <i class="fa fa-eye"></i>
                    </button>
                  </div>
                </div>
                <br />

                 <center> <a href = "https://www.harvesthub.world/sendpassword.asp" class = "body" target="_blank">Forgot password?</a></center><br>

                  
                 <center><input type="submit" class = "submitbutton" value="Submit"  ></center><br>
                </form>
	                 <br />   <br />
	            </div>

      </div>
    </div>
 </div>

    </div>
 </div>
    </div>
 </div>

 <% ' lg+ navigation  %>
    <div class="container-fluid" align = center style="max-width: 1000px; min-height: 600px; ">
       <div class = "row">
        <div class = "col - 6" align = "left">

 


   </div>
    </div>
    </div>
<!--#Include virtual="/Footer.asp"-->
</body></html>