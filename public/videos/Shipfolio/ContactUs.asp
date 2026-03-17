<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/Shipfolio/GlobalVariables.asp"-->
<title>Contact Us | Shipfolio</title>
<meta name="description" content="Have questions or inquiries for Shipfolio? Get in touch with us via phone, email, or our online contact form. Our team is here to assist you with any queries or feedback." />
<meta name="keywords" content="contact us, Shipfolio, inquiries, questions, feedback, phone, email, contact form" />
<meta name="author" content="Shipfolio" />
<meta property="og:title" content="Contact Us | Shipfolio" />
<meta property="og:description" content="Have questions or inquiries for Shipfolio? Get in touch with us via phone, email, or our online contact form. Our team is here to assist you with any queries or feedback." />
<meta property="og:type" content="website" />
<meta property="og:url" content="https://www.OatmealFarmNetwork.com/Contactus.asp" />
<meta property="og:image" content="https://www.OatmealFarmNetwork.com/images/globalgrange-contactus.jpg" />
<meta property="og:image:alt" content="Shipfolio Contact Us" />
<meta property="og:site_name" content="Shipfolio" />
<meta name="twitter:title" content="Contact Us | Shipfolio" />
<meta name="twitter:description" content="Have questions or inquiries for Shipfolio? Get in touch with us via phone, email, or our online contact form. Our team is here to assist you with any queries or feedback." />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="https://www.OatmealFarmNetwork.com/images/globalgrange-contactus.jpg" />
<meta name="twitter:image:alt" content="Shipfolio Contact Us" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</head>
<body >
<!--#Include virtual="/Shipfolio/Header.asp"-->

    <style>
        /* General Body and Font Styling */
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f3f4f6;
            color: #333;
            margin: 0;
        }



        .header-image {
            width: 100%;
            height: auto;
            display: block;
        }

        .contact-form-container {

            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            /* MOBILE-FIRST: Set a standard margin for small screens */
            margin: 1.5rem auto 2rem auto; 
            position: relative;
            z-index: 10;
        }

        h1 {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        /* Error Message */
        .error-message {
            color: #d9534f;
            font-weight: bold;
            text-align: center;
            margin-bottom: 1rem;
        }

        /* Responsive Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr; /* Single column by default */
            gap: 1.5rem;
        }

        /* Two columns on screens wider than 768px */
        @media (min-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr 1fr;
            }

            /* FIXED: Re-apply negative margin only on larger screens */
            .contact-form-container {
                margin: -60px auto 2rem auto; /* Pulls the form up over the image */
            }
        }

        /* Form Elements */
        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        /* Style for the required asterisk */
        label.required::after {
            content: ' *';
            color: maroon;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Important for padding and width */
            font-size: 1rem;
        }

        textarea {
            min-height: 150px;
            resize: vertical;
        }

        /* CAPTCHA and Submit Section */
        .captcha-section {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
            text-align: center;
        }
        
        .captcha-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap; /* Allows wrapping on small screens */
            margin-top: 1rem;
        }
        
        .captcha-container input[type="text"] {
             width: 60px;
             text-align: center;
        }



/* ADDED: Styles for the new text CAPTCHA */
.captcha-text {
    font-family: 'Courier New', Courier, monospace;
    font-size: 1.5rem;
    font-weight: bold;
    letter-spacing: 3px;
    color: #ef4444; /* Tailwind red-500 equivalent */
    background-color: #fef2f2; /* Tailwind red-50 equivalent */
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    display: inline-block;
    user-select: none; /* Prevent text selection */
    border: 1px solid #fca5a5; /* Tailwind red-300 equivalent */
}
.refresh-captcha {
    cursor: pointer;
    color: #007bff; /* Use your submit button blue color */
    font-size: 1.1rem;
}
.captcha-input {
    /* Inherit base input styles */
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 1rem;
    max-width: 250px; /* Constrain the width of the input box */
}

/* Cleanup: Remove or comment out the old CAPTCHA container styles */
.captcha-container {
    /* REMOVED: display: flex; justify-content: center; align-items: center; gap: 1rem; */
    /* REMOVED: flex-wrap: wrap; margin-top: 1rem; */
}
/* REMOVED: .captcha-container input[type="text"] { width: 60px; text-align: center; } */
    </style>
</head>
<body>

<%
    ' --- ASP Logic (no change needed here) ---
    Dim Message, FName, LName, BizName, Email, CommentText, MIMage, random_number

    Message = request.querystring("Message")
    FName=Request.querystring("FName")
    LName=Request.querystring("LName")
    BizName=Request.querystring("BizName")
    Email=Request.querystring("Email")
    CommentText=Request.querystring("CommentText")

    randomize
    random_number=int(rnd*10)
    Select Case random_number
        Case 0: MIMage = "/images/X987045.jpg"
        Case 1: MIMage = "/images/X583198.jpg"
        Case 2: MIMage = "/images/X949256.jpg"
        Case 3: MIMage = "/images/X096367.jpg"
        Case 4: MIMage = "/images/X583198.jpg"
        Case 5: MIMage = "/images/X912578.jpg"
        Case 6: MIMage = "/images/X234697.jpg"
        Case 7: MIMage = "/images/X781736.jpg"
        Case 8: MIMage = "/images/X987834.jpg"
        Case 9: MIMage = "/images/X983999.jpg"
    End Select
%>

    <div class="container">

        <div class="contact-form-container">
            <h1>Contact Us</h1>

            <form name="ContactUsForm" action="ContactUsConfirm.asp" method="POST">
                <input name="_subjectField" type="hidden" value="name">
                <input name="_subject" type="hidden" value=":&nbsp;Contact&nbsp;Us">
                <input name="_replyToField" type="hidden" value="email">
                <input name="_requiredFields" type="hidden" value="FName,LName,Email,CommentText">
                
                <% if len(Message) > 1 then %>
                    <p class="error-message"><%= Message %></p>
                <% end if %>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="fname" class="body">First Name</label>
                        <input type="text" id="fname" name="FName" value="<%= FName %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="lname" class="body">Last Name</label>
                        <input type="text" id="lname" name="LName" value="<%= LName %>" required>
                    </div>
                   
                    <div class="form-group">
                        <label for="bizname" class="body">Business Name (optional)</label>
                        <input type="text" id="bizname" name="BizName" value="<%= BizName %>">
                    </div>

                    <div class="form-group">
                        <label for="email" class="body">Email</label>
                        <input type="text" id="email" name="Email" value="<%= Email %>" required>
                    </div>
                </div>

                <div class="form-group" style="margin-top: 1.5rem;">
                    <label for="comments" class="body">Comments & Questions (optional)</label>
                    <textarea id="comments" name="CommentText" required><%= CommentText %></textarea>
                </div>
                
<div class="form-group" style="margin-top: 1.5rem;">
    <label for="captcha_input" class="body required">Enter the code below</label>
    <div style="display: flex; align-items: center; margin-bottom: 0.5rem;">
        <span id="captcha_text" class="captcha-text"></span>
        <i class="fas fa-sync-alt refresh-captcha" onclick="generateCaptcha()" style="margin-left: 0.5rem;"></i>
    </div>
    <input type="text" id="captcha_input" name="captcha_input" class="captcha-input" required autocomplete="off">
    <p id="captchaMessage" style="color: #d9534f; font-size: 0.875rem; font-style: italic; margin-top: 0.25rem; display: none;">CAPTCHA code is incorrect.</p>
</div>
                
                <div class="honeypot-field">
                    <label for="shoesize">Shoesize</label>
                    <input type="text" id="shoesize" name="Shoesize" tabindex="-1" autocomplete="off">
                </div>
                <br>
                <center>
                <button type="submit" class="regsubmit2" style="min-width: 150px">Submit</button></center>
            </form>
        </div>
    </div>



<br />
<!--#Include virtual="/Shipfolio/Footer.asp"-->

<script>
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
        document.getElementById('captchaMessage').style.display = 'none';
        document.getElementById('captcha_input').setCustomValidity(''); // Reset validation message
    }

    document.addEventListener('DOMContentLoaded', function() {
        generateCaptcha();
    });

    document.querySelector('form[name="ContactUsForm"]').addEventListener('submit', function(event) {
        const captchaInput = document.getElementById('captcha_input').value;
        const captchaMessage = document.getElementById('captchaMessage');
        const captchaField = document.getElementById('captcha_input');

        if (captchaInput.toLowerCase() !== generatedCaptcha.toLowerCase()) {
            captchaMessage.style.display = 'block';
            captchaField.setCustomValidity("CAPTCHA code is incorrect.");
            event.preventDefault(); // Stop form submission
        } else {
            captchaMessage.style.display = 'none';
            captchaField.setCustomValidity(""); // Allow submission
        }

        // Check overall form validity
        if (!this.checkValidity()) {
            event.preventDefault();
        }
    });
</script>
</div>
</body>
</html>