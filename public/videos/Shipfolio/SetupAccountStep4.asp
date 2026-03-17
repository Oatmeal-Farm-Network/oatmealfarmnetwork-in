<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Sign up" %>
<!--#Include virtual="/Shipfolio/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> </title>
<meta name="Title" content="Create Account - <%=WebSiteName %>">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Shipfolio">

<% 
PeopleID = request.querystring("PeopleID")
ActivationCode = request.querystring("ActivationCode")
PeopleFirstName =request.querystring("PeopleFirstName")
PeopleEmail =request.querystring("PeopleEmail")
'response.write("PeopleID=" & PeopleID )


smtpServer = "mail.ContactUs@OatmealFarmNetwork.com"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", contactus@ContactUs@OatmealFarmNetwork.com"
strFrom = "SignUp@ContactUs@OatmealFarmNetwork.com"

strSubject = "Your Shipfolio Voyage is Underway!"

strBody = "<font face='arial'>Ahoy there, " & PeopleFirstName & ",<br>" & vbCrLf
strBody = strBody & "This missive is sailing to you straight from the good ship Shipfolio." & vbCrLf
strBody = strBody & "<br>Your brand new account with the Shipfolio fleet has been launched and provisioned.<br>" & vbCrLf
strBody = strBody & "<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Ship's Log Confirmation<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "We appreciate you casting anchor with us." & vbCrLf
strBody = strBody & "We kindly request you navigate to the confirmation link below to validate your registration, ensuring your provided email is shipshape and Bristol fashion.<br> This helps us steer clear of troublesome barnacles and bilge rats.<br><br>To get your account shipshape, just click the following link:" & vbCrLf
strBody = strBody & "<a href = 'https://www.OatmealFarmNetwork.com/Shipfolio/AccountConfirmation.asp?PeopleID=" & PeopleID &"'> https://www.OatmealFarmNetwork.com/Shipfolio/AccountConfirmation.asp</a><br><br>" & vbCrLf
strBody = strBody & "(If the link fails to hoist the sails, you can copy and paste it into your web browser).<br><br>" & vbCrLf

strBody = strBody & "Once you've reached the Account Confirmation harbor, you'll need to enter your activation code.<br>" & vbCrLf
strBody = strBody & "<br>Your manifest activation code reads as follows:<br>" & vbCrLf
strBody = strBody & "&nbsp;&nbsp;&nbsp;&nbsp;<b>" & ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "Should you have any queries for the First Mate, feel free to <a href = 'https://www.OatmealFarmNetwork.com/ContactUs.asp' >send us a signal </a>.<br>" & vbCrLf
strBody = strBody & "Thanks for signing on with the Shipfolio crew. </font>" & vbCrLf

'response.write("strBody=" & strBody)


Set oMail = Server.CreateObject("CDO.Message")
Set iConf = Server.CreateObject("CDO.Configuration")
Set Flds = iConf.Fields



iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.sendgrid.net"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
iConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True

iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "apikey"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "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"
iConf.Fields.Update
Set oMail.Configuration = iConf
'response.write("PeopleEmail=" & PeopleEmail)
oMail.To = PeopleEmail

oMail.From = sitename & "<john@oatmeal-ai.com>"
oMail.Subject = "Message from " & sitename
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing

%>
<% session("Confirmationsent") = True %>

<% smtpServer = "mail.OatmealFarmNetwork.com"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", ContactUs@oatmealFarmNetwork.com"
strFrom = "ContactUs@OatmealFarmNetwork.com"
strSubject = "Your Shipfolio Membership Has Been Created"


strSubject = "All Hands on Deck: Your Shipfolio Account is Ready!"

strBody = "<table width='600'><tr><td><font face='arial'>Ahoy there, " & PeopleFirstName & ",<br><br>" & vbCrLf
strBody = strBody & "We're pleased as punch to signal that your account with the Shipfolio fleet has been provisioned without a squall in sight.<br><br>" & vbCrLf

strBody = strBody & "To weigh anchor and set sail with your new account, simply follow the link below or, if you fancy, you can copy and paste it into your web browser. Once you've navigated to the Account Confirmation harbor, you'll need to punch in your unique activation code.<br><br>" & vbCrLf
strBody = strBody & "Navigation Link: <a href = 'https://www.oatmeal-AI.com/Shipfolio/Join/USA/AccountConfirmation.asp?PeopleID=" & PeopleID & "'> https://www.oatmeal-AI.com/Shipfolio/Join/USA/AccountConfirmation.asp</a><br>" & vbCrLf

strBody = strBody & "<br>Manifest Code:<b>" & ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If the charts are unclear or you need the First Mate's assistance, please <a href='https://www.OatmealFarmNetwork.com/ContactUs.asp'>send us a signal</a>. We're grateful you've decided to cast your lot with the Shipfolio crew!<br>" & vbCrLf

strBody = strBody & "<tr><td><br><img src='https://www.oatmeal-ai.com/shipfolio/images/ShipfolioLogo.png' alt='Shipfolio' style='height: 90px; width: auto;'><td></tr></table>"
'response.write("strBody=" & strBody)






Set oMail = Server.CreateObject("CDO.Message")
Set iConf = Server.CreateObject("CDO.Configuration")
Set Flds = iConf.Fields
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.sendgrid.net"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
iConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True

iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "apikey"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "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"
iConf.Fields.Update
Set oMail.Configuration = iConf
oMail.To = PeopleEmail
'response.write("PeopleEmail=" & PeopleEmail)

oMail.From = sitename & "<john@oatmeal-ai.com>"
oMail.Subject = "Message from " & sitename
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing


'If Confirmationsent = True
%>

<% Current = "Home"
Current3="Register"
session("LoggedIn") = False%>
</head>
<body >
<!--#Include virtual="/Shipfolio/Header.asp"-->

 <div class="container ">
    <div class="text-center">
        <h1 >Account Verification</h1>
    </div>

    <div class="mb-4 body">
        <blockquote><br />
            <b >Verification Email Sent</b><br />
            Expect an email from us in the next 1 to 2 minutes. Just follow its lead to set that account of yours in motion.<br><br>

            If the email's a no-show, here's what to do:
            <ol class="text-left text-sm body mt-2">
                <li class="body mb-1">Check your bulk mail folder / spam list to ensure you ain't blocking emails from <b class="font-bold">oatmeal-ai.com</b>.</li>
                <li class="body mb-1">Give this page a good refresh.</li>
                <li class="body mb-1">Take a second gander at your email inbox to be sure you've received your message.</li>
                <li class="body mb-1">If none of that gets the job done, don't hesitate to drop us a line at <a href="mailto:contactus@oatmeal-ai.com" class="body underline text-blue-500">contactus@oatmeal-ai.com</a>. </li>
            </ol>
            <br />
        </blockquote>
    </div>
</div></br><br></br><br>
<!--#Include virtual="Shipfolio/Footer.asp"--> </body>
</HTML>