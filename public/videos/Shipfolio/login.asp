<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/shipfolio/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

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
<body>
<!--#Include virtual="/shipfolio/Header.asp"-->

 
</head>
<body>

  <div style="max-width: 1000px; margin: 0 auto; padding: 0 15px;">
        <div class="main-content">
        <% 
          Action = Request.querystring("Action") 
          ReturnFileName = Request.querystring("ReturnFileName")
          ExistingAccount = Request.querystring("ExistingAccount")
          Fail = request.QueryString("Fail")
          ReturnEventID = Request.querystring("ReturnEventID") 
          if len(Action) > 1 then
            Session("Action") = Action
          end if
        %>
        
        <div class="page-header">
            <h1>Account Login</h1>
        </div>

       <div class="row justify-content-center">
            <div class="column col-lg-5 mb-5">
       
                <div >
                    <h2>Sign In</h2>

                    <% if ExistingAccount = "True" then %>
                        <div class="alert alert-info">
                            An account with that email already exists. Please sign in, 
                            <a href="sendpassword.asp">have your password sent to you</a>, or 
                            <a href="SetupAccount.asp?ReturnFileName=<%=ReturnFileName%>&ReturnEventID=<%=ReturnEventID%>">set up a new account</a>.
                        </div>
                    <% end if %>
                    
                    <% if Fail = "True" then %>
                        <div class="alert alert-danger">
                            The username/email or password you entered is incorrect.
                        </div>
                    <% end if %>

                    <form name="Login" method="post" action="Handlelogin.asp">
                        <div style="margin-bottom: 1rem;">
                            <label for="email" class="form-label">Username or Email</label>
                            <input type="email" id="email" name="Email" value="" class="form-control" maxlength = "36" required>
                        </div>

                        <div style="margin-bottom: 1.5rem;">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" id="password" name="password" class="form-control" maxlength = "30" required>
                                <button class="btn" type="button" onclick="togglePasswordVisibility(event)">
                                    <i class="fa fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <button type="submit" class="regsubmit2">Submit</button>
                    </form>

                    <p class="text-center" style="body"><br>
                        Forgot your password? <a href="sendpassword.asp" class = "body">Click Here.</a>
                    </p>
                </div>
            </div>

            <div class="column col-lg-4">
                <div >
                
                    <h2>First Time Signing In?</h2>
                    <p>Ready to get started? Join our website now and build your future with our AI-powered portfolio services.</p><br>
                    <a href="SetupAccount.asp" class="regsubmit2">Setup Account</a>
                </div>
            </div>
        </div>
     </div>
    </main>
    
    <script>
        function togglePasswordVisibility(event) {
            const button = event.currentTarget;
            const inputGroup = button.parentElement;
            const passwordInput = inputGroup.querySelector('input[type="password"], input[type="text"]');
            const icon = button.querySelector('i');
            
            // Toggle the type attribute
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);

            // Toggle the icon
            icon.classList.toggle('fa-eye');
            icon.classList.toggle('fa-eye-slash');
        }
    </script>



<!--#Include virtual="/shipfolio/Footer.asp"-->
</body></html>