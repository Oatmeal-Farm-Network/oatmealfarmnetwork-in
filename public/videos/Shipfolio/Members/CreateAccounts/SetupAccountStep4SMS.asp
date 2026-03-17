<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplace</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplace">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Global Grange inc.">

<% 
PeopleID = request.form("PeopleID")
ActivationCode = request.querystring("ActivationCode")
'response.write("ActivationCode=" & ActivationCode )


smtpServer = "mail.ContactUs@GlobalGrange.world"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", contactus@ContactUs@GlobalGrange.world"
strFrom = "SignUp@ContactUs@GlobalGrange.world"
strSubject = "Your Global Grange Subscription Has Been Created"
strBody = "<font face='arial'>Dear " & PeopleFirstName & ",<br>" & vbCrLf
strBody  = strBody &  "This email has been sent to you from www.GlobalGrange.world." & vbCrLf
strBody = strBody & "<br>Your new account with Global Grange has been successfully created.<br>" & vbCrLf
strBody = strBody & "<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Account Confirmation<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Thank you for registering with us." & vbCrLf
strBody = strBody & "We require that you validate your registration to ensure that the email address you entered was correct.<br> This protects against unwanted spam and malicious abuse.<br><br>To activate your account, simply click on the following link:" & vbCrLf
strBody = strBody & "<a href = 'https://www.ContactUs@GlobalGrange.world/AccountConfirmation.asp'> http://www.ContactUs@GlobalGrange.world/AccountConfirmation.asp</a><br><br>" & vbCrLf
strBody = strBody & "(If the link does not work then copy and paste the link into your web browser).<br><br>" & vbCrLf

strBody = strBody & "Once on the Account Confirmation page you will need to enter your activation code.<br>" & vbCrLf
strBody = strBody & "<br>Your activation code is:<br>" & vbCrLf
strBody = strBody & "&nbsp;&nbsp;&nbsp;&nbsp;<b>" &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you have any questions, please <a href = 'https://www.ContactUs@GlobalGrange.world/ContactUs.asp' >contact us </a> and let us know.<br>" & vbCrLf
strBody = strBody & "Thank you for signing up with with The Global Grange. </font>" & vbCrLf

'response.write("strBody=" & strBody)


%>
<% session("Confirmationsent") = True %>

<% smtpServer = "mail.GlobalGrange.world"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", ContactUs@GlobalGrange.world"
strFrom = "ContactUs@GlobalGrange.world"
strSubject = "Your Global Grange Membership Has Been Created"


strBody = "<font face='arial'>Dear " & PeopleFirstName & ",<br><br>" & vbCrLf
strBody  = strBody &  "We are pleased to inform you that your account with Global Grange has been successfully created.<br><br>" & vbCrLf

strBody = strBody & "As a part of our registration process, we request that you validate your email address to ensure that there is no spam or malicious use of our services.<br><br>" & vbCrLf


strBody = strBody & "To activate your account, please click on the link provided below or copy and paste it into your web browser. Once you are on the Account Confirmation page, you will need to enter your activation code.<br><br>" & vbCrLf
strBody = strBody & "Activation Link: <a href = 'https://www.GlobalGrange.world/Join/USA/AccountConfirmation.asp'> https://www.GlobalGrange.world/Join/USA/AccountConfirmation.asp</a><br>" & vbCrLf

strBody = strBody & "<br>Activation Code:"  &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you have any questions or concerns, please don't hesitate to reach out to us. We appreciate your decision to register with Global Grange!<br>" & vbCrLf

'response.write("strBody=" & strBody)


Dim iMsg2  
Dim iConf2  
Dim Flds2  
Dim strHTML2  
'Const cdoSendUsingPickup = 1
'Const cdoSendUsingPort = 2
'Const cdoAnonymous = 0 
'Const cdoBasic = 1 
'Const cdoNTLM = 2  
set iMsg2 = CreateObject("CDO.Message")  
set iConf2 = CreateObject("CDO.Configuration")  
Set Flds2 = iConf2.Fields  
'dim sch : 

sch = "http://schemas.microsoft.com/cdo/configuration/"  
With Flds2  
 .Item(sch & "sendusing") = 2
  .Item(sch & "smtpserver") = "smtp.sendgrid.net"
  '.Item(sch & "smtphost") = "smtp.sendgrid.net"
 .Item(sch & "smtpserverport") =465
 .Item(sch & "smtpconnectiontimeout") = 30
 .item(sch & "smtpauthenticate") = 1 'basic auth
 .item(sch & "smtpusessl") = True
 .item(sch & "sendusername") = "apikey"
 .item(sch & "sendpassword") = "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"


 .Update
End With  
' Build HTML for message body.  
     

Dim iBP  
With iMsg2  
 Set .Configuration = iConf2
 .From = "mail@theandresengroup.com"
 .To = PeopleEmail
 .bcc = "contactus@livestockoftheworld.com"
 .Subject =  "Global Grange inc. Account Confirmation" 
 .HTMLBody = cstr(strBody)
 .Send
End With  
' Clean up variables.  
Set iBP = Nothing  
Set iMsg2 = Nothing  
Set iConf2 = Nothing  
Set Flds2 = Nothing  
%>
<%
'If Confirmationsent = True
%>

<% Current = "Home"
Current3="Register"
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->

<div class="container-fluid" id="grad1" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Email Verification</h1><br />
          </div>
        </div>
    </div>
    </div>
 </div>
    <br />
<div class="container d-flex justify-content-center roundedtopandbottom mx-auto " style = "max-width:460px; min-height: 400px">
  <div class="row">
  <div class="col">
    
		<blockquote><br>You will receive an email from us in the next 5 minutes. Please following the direction in the email to activate your account.</br><br>

		If you don't receive an email, please:
		<ol>
			<li>Check your bulk mail folder / spam list to make sure that you are not blocking e-mails from the e-mail address ContactUs@GlobalGrange.world.</li>
			<li>Refresh this page.</li>
			<li>Check your e-mail inbox again to verify that you have received you email.</li>
			<li>If the above does not resolve the issue please email us at <a href = "mailto:ContactUs@GlobalGrange.world" class = "body">ContactUs@GlobalGrange.world</a>.</li>
		</ol>
		</blockquote>


</div>
</div>
</div></br><br></br><br>
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>