<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#Include virtual="/Shipfolio/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> </title>
<meta name="Title" content="Create Account - <%=WebSiteName %> ">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale.">
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="<%=WebSiteName %>">
<link rel="stylesheet" type="text/css" href="/Shipfolio/Style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body >
<!--#Include virtual="/Shipfolio/Header.asp"-->
<%
' ===============================================
' CLASSIC ASP SERVER-SIDE LOGIC
' ===============================================
Dim sPageError
Dim sCaptcha
Dim sDefaultLanguage

' 1. Check for form submission
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    
    ' Retrieve all form fields (You already have these variables)
    Dim FirstName, LastName, Language, UserName, Phone, Email, ConfirmEmail, Password, ConfirmPassword, CaptchaInput
    FirstName = Request.Form("PeopleFirstName")
    LastName = Request.Form("PeopleLastName")
    Language = Request.Form("Language")
    UserName = Request.Form("UserName")
    Phone = Request.Form("PeoplePhone")
    Email = Request.Form("PeopleEmail") ' Corrected: Use 'Email' for Request.Form("PeopleEmail")
    ConfirmEmail = Request.Form("confirm_email")
    Password = Request.Form("password")
    ConfirmPassword = Request.Form("confirm_password")
    CaptchaInput = Request.Form("captcha_input")
    sCaptcha = Session("CaptchaCode") ' Get the stored CAPTCHA from the session
    
    ' Get the hidden fields to pass forward
    Dim BusinessTypeID, Subscription
    BusinessTypeID = Request.Form("BusinessTypeID")
    Subscription = Request.Form("Subscription")
    
    ' 2. Server-side validation
    If Email <> ConfirmEmail Then
        sPageError = "Email addresses do not match."
    ElseIf Password <> ConfirmPassword Then
        sPageError = "Passwords do not match."
    ' IMPORTANT: Case-insensitive CAPTCHA check (assuming client-side JS used LCase)
    ElseIf LCase(CaptchaInput) <> LCase(sCaptcha) Then
        sPageError = "CAPTCHA code is incorrect. Please try again."
    Else
        ' 3. SUCCESS: If all validations pass, proceed to the next step
        ' NOTE: In a real app, you would add DB code here (e.g., INSERT)
        
        ' 🔑 THE FIX: Construct the URL with ALL required data (URL encoding is important for safety)
        Dim sRedirectURL
        sRedirectURL = "SetupAccountstep3.asp?" & _
            "BusinessTypeID=" & Server.URLEncode(BusinessTypeID) & "&" & _
            "Subscription=" & Server.URLEncode(Subscription) & "&" & _
            "PeopleFirstName=" & Server.URLEncode(FirstName) & "&" & _
            "PeopleLastName=" & Server.URLEncode(LastName) & "&" & _
            "Language=" & Server.URLEncode(Language) & "&" & _
            "UserName=" & Server.URLEncode(UserName) & "&" & _
            "PeoplePhone=" & Server.URLEncode(Phone) & "&" & _
            "PeopleEmail=" & Server.URLEncode(Email)
            
        Response.Redirect sRedirectURL 
    End If
    
End If
' 4. Generate and store CAPTCHA in session for server-side validation (on page load or form error)
sCaptcha = GenerateRandomString(6)
Session("CaptchaCode") = sCaptcha
sDefaultLanguage = "English (US)" ' Set default language for the dropdown

' Function to generate a random string for CAPTCHA (VBScript)
Function GenerateRandomString(iLength)
    Randomize 
    Dim sChars, sResult, i
    sChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    sResult = ""
    For i = 1 To iLength
        sResult = sResult & Mid(sChars, Int((Len(sChars) * Rnd) + 1), 1)
    Next
    GenerateRandomString = sResult
End Function

' --- Language Options for Dropdown ---
Function GetLanguageOptions()
    Dim sOptions, aLanguages, LangPair, LangName, LangValue
    ' List of languages (Name, Value - often the ISO code)
    aLanguages = Array( _
        "English (US)|en_US", "Spanish|es", "French|fr", "German|de", "Chinese (Simplified)|zh_CN", _
        "Japanese|ja", "Russian|ru", "Portuguese|pt", "Arabic|ar", "Hindi|hi")
        
    sOptions = ""
    For Each LangPair In aLanguages
        LangName = Split(LangPair, "|")(0)
        LangValue = Split(LangPair, "|")(1)
        
        sOptions = sOptions & "<option value=""" & LangValue & """ "
        ' Set English (US) as default selected
        If LangName = sDefaultLanguage Then
            sOptions = sOptions & "selected"
        End If
        sOptions = sOptions & ">" & LangName & "</option>" & VbCrLf
    Next
    GetLanguageOptions = sOptions
End Function
%>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <style>
        /* --- CUSTOM STYLES FOR NEOMORPHIC DARK THEME (Updated for larger form) --- */

        .form-grid {
            display: grid;
            grid-template-columns: 1fr; /* Single column by default */
            gap: 1.5rem;
        }

        .form-container {
            max-width: 800px; /* Max width */
            margin-left: auto;
            margin-right: auto;
            padding: 3rem; /* Increased padding */
            /* DARK, TRANSLUCENT BACKGROUND (The core Neomorphic/Glassy look) */
            background-color: rgba(30, 35, 78, 0.4); /* Dark purple/blue with transparency */
            backdrop-filter: blur(10px); /* Glassy blur effect */
            -webkit-backdrop-filter: blur(10px); /* Safari support */
            /* Modified shadow for softer look */
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.1); /* Subtle light border */
            border-radius: 20px; /* More rounded corners */
            position: relative; /* Needed for mascot positioning */
            margin-bottom: 2rem;
        }

        @media (min-width: 768px) {
            .form-grid-essential {
                grid-template-columns: repeat(3, 1fr); /* Three columns for essential details */
            }
            .form-grid-options {
                grid-template-columns: repeat(3, 1fr); /* Three columns for theme/layout */
            }
        }
        
        /* Input Field Overrides for Dark/Glassy look */
        .glass-input, .glass-select { /* Added .glass-select */
            /* Input background: Darker, more transparent */
            background-color: rgba(0, 0, 0, 0.2); 
            color: #FFFFFF; /* White text */
            border: 1px solid rgba(255, 255, 255, 0.2); /* Light translucent border */
            border-radius: 12px; /* Very rounded corners for fields and buttons */
            padding: 0.85rem 1rem; /* Slightly more vertical padding */
            font-size: 1rem;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.4); /* Inner shadow for depth */
            transition: border-color 0.3s, background-color 0.3s;
            box-sizing: border-box; /* Ensure padding doesn't affect width */
            -webkit-appearance: none; /* Remove default browser styling for select */
            -moz-appearance: none;
            appearance: none;
            cursor: pointer;
        }
        .glass-select option {
            background-color: #1e234e; /* Dark background for dropdown options */
            color: #FFFFFF;
        }

        .glass-input:focus, .glass-select:focus {
            border-color: #9d9ed2; /* Light blue/purple on focus */
            background-color: rgba(0, 0, 0, 0.3);
            outline: none;
        }
        /* Password container for eye icon */
        .password-container {
            position: relative;
        }
        .password-container .glass-input {
            padding-right: 2.5rem; /* Make space for the icon */
        }
        .toggle-password {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: rgba(255, 255, 255, 0.6);
            z-index: 10;
        }


        /* Primary CTA Button Style Override (Build my portfolio) */
        .regsubmit2 {
            background-color: #3b82f6; /* Use a distinct blue for the final action button */
            border: 1px solid #9d9ed2;
            padding: 0.85rem 2rem;
            border-radius: 12px;
            font-size: 18px; /* Slightly larger text */
            font-weight: 600;
            transition: background-color 0.3s;
            width: 100%; /* Full width button at the bottom, matching the design */
            color: #FFFFFF; /* Ensure text is white */
            cursor: pointer;
        }

        .regsubmit2:hover {
            background-color: #1d4ed8;
        }

        /* Header styling (matching the image) */
        .essential-header {
            font-size: 2.25rem; /* text-4xl */
            font-weight: 700;
            color: #FFFFFF;
            margin-bottom: 2rem;
            text-align: left;
        }

        /* Label color override (make them white) */
        .body {
            color: #FFFFFF;
        }
        /* Section Headers */
        .section-header {
            font-size: 1.25rem;
            font-weight: 500;
            color: #FFFFFF;
            margin-bottom: 1rem;
            margin-top: 1.5rem;
        }

        /* Positioning for the mascot */
        .mascot-dino {
            position: absolute;
            top: -50px;
            right: 15%; 
            width: 150px;
            height: 150px;
            z-index: 10;
        }
        
        /* Utility classes (tailwind-like, for simplicity) */
        .text-red-500 { color: #f87171; }
        .text-xs { font-size: 0.75rem; }
        .italic { font-style: italic; }
        .mt-1 { margin-top: 0.25rem; }
        .mb-6 { margin-bottom: 1.5rem; }
        .mt-4 { margin-top: 1rem; }
        .mt-8 { margin-top: 2rem; }
        .mb-4 { margin-bottom: 1rem; }
        .w-full { width: 100%; }
        .w-1\/3 { width: 33.333333%; }
        .flex { display: flex; }
        .items-center { align-items: center; }
        .justify-center { justify-content: center; }
        .hidden { display: none !important; }

        /* CAPTCHA styles update for dark theme */
        .captcha-text {
            color: #fca5a5; 
            background-color: rgba(255, 255, 255, 0.05); 
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 1.25rem;
            letter-spacing: 0.2em;
            text-align: center;
            user-select: none;
        }
        .refresh-captcha {
            color: #3b82f6; 
            margin-left: 0.75rem;
            cursor: pointer;
            font-size: 1.25rem;
        }
        .form-column {
            box-shadow: none;
            padding: 0; 
        }

    </style>
</head>
<body style="background-color: #1a1a2e;"> 


    <div class="container mx-auto mt-8 form-container">
        <h1 class="essential-header">Setup Account</h1>

        <div class="form-column"> 
            
            <% ' Display server-side errors if any %>
            <% If sPageError <> "" Then %>
                <div style="background-color: #dc2626; color: #FFFFFF; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem;">
                    <strong>Error:</strong> <%= sPageError %>
                </div>
            <% End If %>
            
            <form name="form" method="post" action="SetupAccount.asp">
                <input type="hidden" name="BusinessTypeID" value="<%= Request.QueryString("BusinessTypeID") %>">
                <input type="hidden" name="Subscription" value="<%= Request.QueryString("Subscription") %>">

                <div class="form-grid form-grid-essential mb-6">
                    <div>
                        <label for="PeopleFirstName" class="body">First Name</label>
                        <input type="text" name="PeopleFirstName" id="PeopleFirstName" class="glass-input w-full" value="<%= Request.Form("PeopleFirstName") %>" required>
                    </div>
                    
                    <div>
                        <label for="PeopleLastName" class="body">Last Name</label>
                        <input type="text" name="PeopleLastName" id="PeopleLastName" class="glass-input w-full" value="<%= Request.Form("PeopleLastName") %>" required>
                    </div>
                    
                    <div>
                        <label for="Language" class="body">Language</label>
                        <select name="Language" id="Language" class="glass-select w-full" required>
                            <%= GetLanguageOptions() %>
                        </select>
                    </div>
                </div> 

                <hr style="border: none; border-top: 1px solid rgba(255, 255, 255, 0.1); margin: 2rem 0;">

                <p class="section-header" style="margin-top: 3rem;">Account Credentials</p>

                <div class="form-grid" style="grid-template-columns: 1fr 1fr;">
                    <div class="mb-4">
                        <label for="UserName" class="body">User Name</label>
                        <input type="text" id="UserName" name="UserName" class="glass-input w-full" value="<%= Request.Form("UserName") %>" required>
                    </div>
                    
                    <div class="mb-4">
                        <label for="PeoplePhone" class="body">Phone (Optional)</label>
                        <input type="tel" name="PeoplePhone" id="PeoplePhone" class="glass-input w-full" value="<%= Request.Form("PeoplePhone") %>">
                    </div>

                    <div class="mb-4">
                        <label for="PeopleEmail" class="body">Email</label>
                        <input type="email" id="PeopleEmail" name="PeopleEmail" class="glass-input w-full" value="<%= Request.Form("PeopleEmail") %>" required onkeyup="checkEmailMatch();">
                    </div>
                    
                    <div class="mb-4">
                        <label for="confirm_email" class="body">Confirm Email</label>
                        <input type="email" id="confirm_email" name="confirm_email" class="glass-input w-full" value="<%= Request.Form("confirm_email") %>" required onkeyup="checkEmailMatch();">
                        <p id="emailMatchMessage" class="text-red-500 text-xs italic mt-1 hidden">Email addresses do not match.</p>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="body">Password</label>
                        <div class="password-container">
                            <input type="password" id="password" name="password" class="glass-input w-full" required onkeyup="checkPasswordMatch();">
                            <span class="toggle-password" onclick="togglePasswordVisibility('password', this)">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="confirm_password" class="body">Confirm Password</label>
                        <div class="password-container">
                            <input type="password" id="confirm_password" name="confirm_password" class="glass-input w-full" required onkeyup="checkPasswordMatch();">
                            <span class="toggle-password" onclick="togglePasswordVisibility('confirm_password', this)">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                        <p id="passwordMatchMessage" class="text-red-500 text-xs italic mt-1 hidden">Passwords do not match.</p>
                    </div>
                </div> 

                <div class="mb-6 mt-4">
                    <label for="captcha_input" class="body">Enter the code below:</label>
                    
                    <div class="flex items-center mb-2">
                        <span id="captcha_text" class="captcha-text"><%= Session("CaptchaCode") %></span>
                        <i class="fas fa-sync-alt refresh-captcha" onclick="window.location.reload();"></i> 
                    </div>
                    
                    <input type="text" id="captcha_input" name="captcha_input" class="glass-input w-1/3" required>
                    <p id="captchaMessage" class="text-red-500 text-xs italic mt-1 hidden">CAPTCHA code is incorrect.</p>
                </div>

                <div class=" justify-center mt-8">
                    <center><button type="submit" class="login-button">
                        Next
                    </button></center>
                </div>
            </form>
        </div>
    </div>

    <script>
        // ===============================================
        // JAVASCRIPT CLIENT-SIDE LOGIC
        // ===============================================

        // 1. FIX: Modified checkEmailMatch to only show error if both fields have content and don't match.
        function checkEmailMatch() {
            const email = document.getElementById("PeopleEmail");
            const confirm_email = document.getElementById("confirm_email");
            const emailMatchMessage = document.getElementById("emailMatchMessage");

            // Only perform check if both fields have values
            if (email.value.length > 0 && confirm_email.value.length > 0) {
                if (email.value !== confirm_email.value) {
                    confirm_email.setCustomValidity("Email addresses do not match");
                    emailMatchMessage.classList.remove('hidden');
                } else {
                    confirm_email.setCustomValidity("");
                    emailMatchMessage.classList.add('hidden');
                }
            } else {
                // Remove error message if one or both are empty
                confirm_email.setCustomValidity("");
                emailMatchMessage.classList.add('hidden');
            }
        }

        function checkPasswordMatch() {
            const password = document.getElementById("password");
            const confirm_password = document.getElementById("confirm_password");
            const passwordMatchMessage = document.getElementById("passwordMatchMessage");

            if (password.value.length > 0 && confirm_password.value.length > 0) {
                if (password.value !== confirm_password.value) {
                    confirm_password.setCustomValidity("Passwords do not match");
                    passwordMatchMessage.classList.remove('hidden');
                } else {
                    confirm_password.setCustomValidity("");
                    passwordMatchMessage.classList.add('hidden');
                }
            } else {
                confirm_password.setCustomValidity("");
                passwordMatchMessage.classList.add('hidden');
            }
        }

        function togglePasswordVisibility(fieldId, iconElement) {
            const passwordField = document.getElementById(fieldId);
            const icon = iconElement.querySelector('i');
            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                passwordField.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            // Re-run checks on load to apply any necessary custom validity 
            // if the form was submitted with errors and values were preserved
            checkEmailMatch();
            checkPasswordMatch();
        });

        // The client-side CAPTCHA logic has been removed from the submit listener
        // because the server now validates the CAPTCHA against the Session variable.
        // The checkEmailMatch and checkPasswordMatch functions are still called 
        // on submit to ensure the latest client-side validation state is correct.
        document.querySelector('form').addEventListener('submit', function(event) {
            checkEmailMatch();
            checkPasswordMatch();

            // Client-side CAPTCHA logic is now for UX only, but since server-side 
            // CAPTCHA is required, we rely on the server validation now. 
            // We ensure custom validities are set for the other fields before submitting.
            if (!this.checkValidity()) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>
