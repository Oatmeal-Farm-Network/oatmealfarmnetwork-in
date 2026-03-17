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




    <style>
 
            label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            font-size: 0.875rem;
            color: var(--text-dark);
        }

        .form-input {
            width: 100%;
            padding: 0.8rem 1rem; /* Better padding */
            border: 1px solid var(--border-color);
            border-radius: 6px; /* Slightly more rounded */
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-input::placeholder {
            color: #9ca3af; /* Placeholder text color */
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--focus-ring-color);
        }

          
        .extra-links {
            margin-top: 1.5rem;
            font-size: 0.875rem;
        }
        
        .extra-links a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500; /* Make link slightly bolder */
        }
        
        .extra-links a:hover {
            text-decoration: underline;
        }

    </style>


    <% 
      Session.Abandon
      ' ASP code to abandon the session and clear cookies
      Session("PeopleID") = ""
      Session("LoggedIn") = False
      Response.Cookies("LoggedIn")= False
      Response.Cookies("PeopleID")= ""

      if len(PeopleID) > 0 then
          response.redirect("logout.asp")
      end if
    %>
</head>
<body>
    <!--#Include virtual="/Shipfolio/Header.asp"-->
 
    <div class="content-wrapper">
        <div class="main-content body">
        <h1>Signed Out</h1>
        <p>You have been signed out of your account.<br><br>
            Feel free to sign back in below.<br><br></p>
        
        <form action="handleLogin.asp" method="post">
            <div class="body">
                <label for="email">Username or Email</label>
                <input type="text" id="email" name="UID" class="form-input" required placeholder="you@example.com"><br><br>
            </div>
            
            <div class="body">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-input" required placeholder="••••••••"><br><br>
            </div>
            
            <center><button type="submit" class="regsubmit2">Sign In</button></center>
            
            <div class="extra-links">
                <a href="sendpassword.asp">Forgot Password?</a>
            </div>
        </form>
    </div>
 </div>


<!--#Include virtual="/Shipfolio/Footer.asp"-->
</body></html>