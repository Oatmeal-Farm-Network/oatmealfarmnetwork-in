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

<style>
  /* --- CUSTOM STYLES FOR NEOMORPHIC DARK THEME (Updated for larger form) --- */

  .form-grid {
        display: grid;
[cite_start][cite: 3] grid-template-columns: 1fr; /* Single column by default */
        gap: 1.5rem;
[cite_start][cite: 4] }

  .form-container {
        max-width: 800px; /* Max width */
[cite_start][cite: 5] /* New max width for the form container */
        margin-left: auto;
        margin-right: auto;
[cite_start][cite: 6] padding: 3rem; /* Increased padding */
        /* DARK, TRANSLUCENT BACKGROUND (The core Neomorphic/Glassy look) */
        background-color: rgba(30, 35, 78, 0.4); /* Dark purple/blue with transparency */
        backdrop-filter: blur(10px); /* Glassy blur effect */
        -webkit-backdrop-filter: blur(10px); /* Safari support */
[cite_start][cite: 7] /* bg-white */
        /* Modified shadow for softer look */
        box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
        border: 1px solid rgba(255, 255, 255, 0.1); /* Subtle light border */
[cite_start][cite: 8] /* Modified shadow for softer look */
        border-radius: 20px; /* More rounded corners */
[cite_start][cite: 9] position: relative; /* Needed for mascot positioning */
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
    .glass-input {
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
    }

    .glass-input:focus {
        border-color: #9d9ed2; /* Light blue/purple on focus */
        background-color: rgba(0, 0, 0, 0.3);
        outline: none;
[cite_start][cite: 40] }

    /* Primary CTA Button Style Override (Build my portfolio) */
    .regsubmit2 {
        /* Matches the bottom CTA button text from the image, but uses your regsubmit2 class */
        background-color: #3b82f6; /* Use a distinct blue for the final action button */
        border: 1px solid #9d9ed2;
        padding: 0.85rem 2rem;
        border-radius: 12px;
        font-size: 18px; /* Slightly larger text */
        font-weight: 600;
        transition: background-color 0.3s;
        width: 100%; /* Full width button at the bottom, matching the design */
    }

    .regsubmit2:hover {
         background-color: #1d4ed8;
    }

    /* Secondary Button Style (Upload/LinkedIn) */
    .glass-button {
        background-color: rgba(49, 51, 110, 0.8); /* Dark accent color, slightly transparent */
        color: #FFFFFF;
        border: 1px solid rgba(255, 255, 255, 0.3);
        border-radius: 12px; /* Very rounded corners */
        padding: 0.85rem 1rem;
        font-size: 1rem;
        font-weight: 600;
        text-align: center;
        width: 100%;
        cursor: pointer;
        transition: background-color 0.3s, border-color 0.3s;
    }

    .glass-button:hover {
        background-color: rgba(64, 66, 138, 0.9); /* Lighter dark accent on hover */
        border-color: #FFFFFF;
    }

    /* === NEW/UPDATED STYLE: Theme/Layout Buttons === */
    .theme-layout-button {
        /* Translucent, square-ish look from the image */
        background-color: rgba(0, 0, 0, 0.1); /* Very slight dark tint */
        color: #FFFFFF;
        border: 1px solid rgba(255, 255, 255, 0.4); /* Thicker, brighter white border */
        border-radius: 6px; /* Less rounded corners */
        padding: 0.6rem 0.75rem;
        font-size: 0.9rem;
        cursor: pointer;
        transition: background-color 0.2s, border-color 0.2s;
        text-align: center;
        white-space: nowrap;
        width: 100%; /* Important for grid alignment */
    }
    .theme-layout-button:hover, .theme-layout-button.selected {
        /* On hover/selection, a slightly darker background with a brighter border */
        background-color: rgba(64, 66, 138, 0.3);
        border-color: #FFFFFF;
    }

    .form-grid-options {
        display: grid;
        grid-template-columns: repeat(3, 1fr); /* Three uniform columns */
        gap: 0.75rem;
        margin-bottom: 1.5rem;
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
    
    /* Fix for original utility classes in light theme (make sure they don't break dark mode) */
    .text-gray-700 { color: #FFFFFF; } 
    .text-gray-500 { color: #bdbddb; } 
    
    /* CAPTCHA styles update for dark theme */
    .captcha-text {
        color: #fca5a5; 
        background-color: rgba(255, 255, 255, 0.05); 
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    .refresh-captcha {
        color: #3b82f6; 
    }
    .form-column {
        box-shadow: none;
        padding: 0; 
    }

</style>
<div class="mascot-dino">
    <img src="path/to/mascot-dino-image.png" alt="Cute Dinosaur Mascot Holding a Drink" style="width: 100%; height: 100%; object-fit: contain;">
</div>

<div class="container mx-auto mt-8 form-container">
    <h1 class="essential-header">Essential Details</h1>

    <div class="form-column"> 
        <form name="form" method="post" action="SetupAccountstep3.asp">
            <input type="hidden" name="BusinessTypeID" value="<%= Request.QueryString("BusinessTypeID") %>">
            <input type="hidden" name="Subscription" value="<%= Request.QueryString("Subscription") %>">

            <div class="form-grid form-grid-essential mb-6">
                    <div>
                    <label for="PeopleFirstName" class="body">First Name</label>
                    <input type="text" name="PeopleFirstName" id="PeopleFirstName" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" value="" required>
                </div>
          
                          <div>
                    <label for="PeopleLastName" class="body">Last Name</label>
                    <input type="text" name="PeopleLastName" id="PeopleLastName" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" value="" required>
                </div>
                
                <div>
                    <label for="Language" class="body">Language</label>
                    <input type="text" name="Language" id="Language" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" value="">
                </div>
            </div> <p class="section-header">Share your Journey</p>
            <div class="mb-6 space-y-4">
                <button type="button" class="glass-button">Upload Your Resume</button>
                <button type="button" class="glass-button">Connect with LinkedIn</button>
            </div>

            <div class="mb-6">
                <label for="Description" class="body hidden">Description</label>
                <textarea id="Description" name="Description" rows="5" placeholder="Description" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline"></textarea>
            </div>

            <hr style="border: none; border-top: 1px solid rgba(255, 255, 255, 0.1); margin: 2rem 0;">

            <p class="section-header">Theme</p>
            <div class="form-grid-options">
                <button type="button" class="theme-layout-button">Minimal & Clean</button>
                <button type="button" class="theme-layout-button">Bold & Expressive</button>
                <button type="button" class="theme-layout-button">Playful & Creative</button>
                <button type="button" class="theme-layout-button">Professional</button>
                <button type="button" class="theme-layout-button">Dark Mode</button>
                <button type="button" class="theme-layout-button">Artistic & Visual</button>
            </div>
            
            <div class="mb-6">
                <label for="ExplainTheme" class="body hidden">Explain your own theme</label>
                <textarea id="ExplainTheme" name="ExplainTheme" rows="3" placeholder="Explain your own theme" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline"></textarea>
            </div>

            <hr style="border: none; border-top: 1px solid rgba(255, 255, 255, 0.1); margin: 2rem 0;">

            <p class="section-header">Portfolio Layout</p>
            <div class="form-grid-options">
                <button type="button" class="theme-layout-button">Classic Grid</button>
                <button type="button" class="theme-layout-button">Showcase Gallery</button>
                <button type="button" class="theme-layout-button">One page scroll</button>
                <button type="button" class="theme-layout-button">Case study flow</button>
                <button type="button" class="theme-layout-button">Split Screen</button>
                <button type="button" class="theme-layout-button">Magazine Style</button>
            </div>

            <div class="mb-6">
                <label for="ExplainLayout" class="body hidden">Explain your own layout</label>
                <textarea id="ExplainLayout" name="ExplainLayout" rows="3" placeholder="Explain your own layout" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline"></textarea>
            </div>

            <hr style="border: none; border-top: 1px solid rgba(255, 255, 255, 0.1); margin: 2rem 0;">

            <p class="section-header" style="margin-top: 3rem;">Account Credentials</p>

            <div class="form-grid" style="grid-template-columns: 1fr 1fr;">
                <div class="mb-4">
                  <label for="UserName" class="body">User Name</label>
                    <input type="text" id="UserName" name="UserName" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" value="" required ">
                </div>
                
                <div class="mb-4">
        
            <label for="PeoplePhone" class="body">Phone (Optional)</label>
                    <input type="tel" name="PeoplePhone" id="PeoplePhone" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" value="">
                </div>

                <div class="mb-4">
                 
  <label for="PeopleEmail" class="body">Email</label>
                    <input type="email" id="PeopleEmail" name="PeopleEmail" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" value="" required onkeyup="checkEmailMatch();">
                </div>
                
                <div class="mb-4">
                    <label for="confirm_email" class="body">Confirm Email</label>
  
                <input type="email" id="confirm_email" name="confirm_email" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" value="" required onkeyup="checkEmailMatch();">
                    <p id="emailMatchMessage" class="text-red-500 text-xs italic mt-1 hidden">Email addresses do not match.</p>
                </div>

                <div class="mb-4">
  
                 <label for="password" class="body">Password</label>
                    <div class="password-container">
                        <input type="password" id="password" name="password" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline" required onkeyup="checkPasswordMatch();">
                   
     <span class="toggle-password" onclick="togglePasswordVisibility('password', this)">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                </div>
  
                          <div class="mb-4">
                    <label for="confirm_password" class="body">Confirm Password</label>
                    <div class="password-container">
                        <input type="password" id="confirm_password" name="confirm_password" class="glass-input appearance-none w-full leading-tight focus:outline-none focus:shadow-outline pr-10" required 
[cite_start][cite: 87] onkeyup="checkPasswordMatch();">
                        <span class="toggle-password" onclick="togglePasswordVisibility('confirm_password', this)">
                            <i class="fas fa-eye"></i>
                        </span>
                   
  </div>
                    <p id="passwordMatchMessage" class="text-red-500 text-xs italic mt-1 hidden">Passwords do not match.</p>
                </div>
            </div> <div class="mb-6 mt-4">
                <label for="captcha_input" class="body">Enter the code below:</label>
            
        <div class="flex items-center mb-2">
                        <span id="captcha_text" class="captcha-text"></span>
                        <i class="fas fa-sync-alt refresh-captcha" onclick="generateCaptcha()"></i>
                    </div>
               
     <input type="text" id="captcha_input" name="captcha_input" class="glass-input w-1/3">
                    <p id="captchaMessage" class="text-red-500 text-xs italic mt-1 hidden">CAPTCHA code is incorrect.</p>
                </div>

            <div class="flex justify-center mt-8">
                    <button type="submit" class="regsubmit2">
      
                  Build my portfolio
                    </button>
                </div>
            </form>
        </div>
    </div>


<script>
    // Javascript remains the same...
    let generatedCaptcha = '';
 function generateCaptcha() {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let captcha = '';
 for (let i = 0; i < 6; i++) {
            captcha += characters.charAt(Math.floor(Math.random() * characters.length));
 }
        generatedCaptcha = captcha;
        document.getElementById('captcha_text').textContent = captcha;
        document.getElementById('captcha_input').value = '';
        document.getElementById('captchaMessage').classList.add('hidden');
 }

    function checkEmailMatch() {
        const email = document.getElementById("PeopleEmail");
 const confirm_email = document.getElementById("confirm_email");
        const emailMatchMessage = document.getElementById("emailMatchMessage");
        if (email.value && confirm_email.value && email.value !== confirm_email.value) {
            confirm_email.setCustomValidity("Email addresses do not match");
emailMatchMessage.classList.remove('hidden');
        } else {
            confirm_email.setCustomValidity("");
            emailMatchMessage.classList.add('hidden');
 }
    }

    function checkPasswordMatch() {
        const password = document.getElementById("password");
 const confirm_password = document.getElementById("confirm_password");
        const passwordMatchMessage = document.getElementById("passwordMatchMessage");
        if (password.value && confirm_password.value && password.value !== confirm_password.value) {
            confirm_password.setCustomValidity("Passwords do not match");
 passwordMatchMessage.classList.remove('hidden');
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
        generateCaptcha();
        checkEmailMatch();
        checkPasswordMatch();
    });
 document.querySelector('form').addEventListener('submit', function(event) {
        checkEmailMatch();
        checkPasswordMatch();
        const captchaInput = document.getElementById('captcha_input').value;
        const captchaMessage = document.getElementById('captchaMessage');
        const captchaField = document.getElementById('captcha_input');
        if (captchaInput.toLowerCase() !== generatedCaptcha.toLowerCase()) {
            captchaMessage.classList.remove('hidden');
            captchaField.setCustomValidity("CAPTCHA code is incorrect.");
        } else 
 {
            captchaMessage.classList.add('hidden');
            captchaField.setCustomValidity("");
        }
        if (!this.checkValidity()) {
            event.preventDefault();
        }
    });
 </script>

<br>
</body>
</HTML>