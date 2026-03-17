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
PeopleFirstName =request.querystring("PeopleFirstName")
PeopleEmail =request.querystring("PeopleEmail")
'response.write("ActivationCode=" & ActivationCode )


smtpServer = "mail.ContactUs@GlobalGrange.world"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", contactus@ContactUs@GlobalGrange.world"
strFrom = "SignUp@ContactUs@GlobalGrange.world"
strSubject = "Your Global Grange Subscription Has Been Created"
strBody = "<font face='arial'>Howdy " & PeopleFirstName & ",<br>" & vbCrLf
strBody  = strBody &  "This email's ridin' to you straight from www.GlobalGrange.world." & vbCrLf
strBody = strBody & "<br>Your brand spankin' new account with Global Grange has been wrangled up and created.<br>" & vbCrLf
strBody = strBody & "<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Account Confirmation<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "We sure do appreciate you registerin' with us." & vbCrLf
strBody = strBody & "We kindly ask you to mosey on over and validate your registration, just to make sure that email address you provided is on the up and up.<br> This helps keep the no-good spam and troublemakers at bay.<br><br>To get your account goin', just give a click to this here link:" & vbCrLf
strBody = strBody & "<a href = 'https://www.harvesthub.world/AccountConfirmation.asp'> http://www.HarvestHub.world/AccountConfirmation.asp</a><br><br>" & vbCrLf
strBody = strBody & "(If the link don't light a fire, you can copy and paste it in your web browser).<br><br>" & vbCrLf

strBody = strBody & "Once you're at the Account Confirmation corral, you'll need to punch in your activation code.<br>" & vbCrLf
strBody = strBody & "<br>Your activation code reads as follows:<br>" & vbCrLf
strBody = strBody & "&nbsp;&nbsp;&nbsp;&nbsp;<b>" &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you've got any questions, feel free to <a href = 'https://www.HarvestHub.world/ContactUs.asp' >get in touch with us </a>.<br>" & vbCrLf
strBody = strBody & "Thanks for hitchin' your wagon with The Global Grange. </font>" & vbCrLf


'response.write("strBody=" & strBody)


Dim iMsg1  
Dim iConf1  
Dim Flds1
Dim strHTML1 
dim sch : sch = "http://schemas.microsoft.com/cdo/configuration/"  
Dim iBP1 
set iMsg1 = CreateObject("CDO.Message")  
set iConf1 = CreateObject("CDO.Configuration")  
Set Flds1 = iConf1.Fields   
'Const cdoSendUsingPickup = 1
'Const cdoSendUsingPort = 2
'Const cdoAnonymous = 0 
'Const cdoBasic = 1 
'Const cdoNTLM = 2  
With Flds1  
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
test = false
if test = true then
  strTo = "Contactus@livestockoftheworld.com"
end if

  
'response.write("strTo=" & strTo ) 
With iMsg1  
 Set .Configuration = iConf1
 .To = strTo
 .Bcc = "Contactus@livestockoftheworld.com"
 .From = "Global Grange inc. <ContactUs@GlobalGrange.world>"
 'ObjSendMail.To = "andresengroup@yahoo.com"
 .Subject =  strSubject
 .HTMLBody = strBody
 '.Send
End With

' Clean up variables.  
Set iBP1 = Nothing  
Set iMsg1 = Nothing  
Set iConf1 = Nothing  
Set Flds1 = Nothing  

%>
<% session("Confirmationsent") = True %>

<% smtpServer = "mail.GlobalGrange.world"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", ContactUs@GlobalGrange.world"
strFrom = "ContactUs@GlobalGrange.world"
strSubject = "Your Global Grange Membership Has Been Created"


strBody = "<table width='600'><tr><td><font face='arial'>Howdy " & PeopleFirstName & ",<br><br>" & vbCrLf
strBody  = strBody &  "We're downright pleased to let you know that your account with Global Grange's Harvest Hub has been corralled and created without a hitch.<br><br>" & vbCrLf

strBody = strBody & "As part of the registration roundup, we kindly ask you to wrangle up your email address to make sure we keep the no-good spam and troublemakers out of our services.<br><br>" & vbCrLf

strBody = strBody & "To get that account of yours up and runnin', just give a click to the link below or if you fancy, you can copy and paste it into your web browser. Once you're at the Account Confirmation corral, you'll need to punch in your activation code.<br><br>" & vbCrLf
strBody = strBody & "Activation Link: <a href = 'https://www.harvesthub.world/Join/USA/AccountConfirmation.asp'> https://www.HarvestHub.world/Join/USA/AccountConfirmation.asp</a><br>" & vbCrLf

strBody = strBody & "<br>Activation Code:<b>"  &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you've got any questions, or reckon you need some help, don't be shy to holler at us. We sure do appreciate your decision to ride with Livestock Of America and Global Grange!<br>" & vbCrLf

strBody = strBody & "<tr><td><br><img src='https://www.globallivestocksolutions.com/logos/220pxwide/LivestockofAmerica.png' alt='LOA Logo' id='header-img' width=600px ><td></tr></table>"


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

 <div class="container-fluid" style="background-color: #CC9966;" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Account Verification</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<div class="container d-flex justify-content-center roundedtopandbottom mx-auto " style = "max-width:460px; min-height: 400px">
  <div class="row">
  <div class="col">

	<blockquote><br /><b>Verification Email</b><br />Expect an email from us in the next 1 to 5 minutes. Just follow its lead to set that account of yours in motion.</br><br>

If the email's a no-show, here's what to do:
		<ol>
			<li>Check your bulk mail folder / spam list to ensure you ain't blocking emails from ContactUs@GlobalGrange.world.</li>
			<li>Give this page a good refresh.</li>
			<li>Take a second gander at your email inbox to be sure you've received your message.</li>
			<li>If none of that gets the job done, don't hesitate to drop us a line at <a href = "mailto:ContactUs@GlobalGrange.world" class = "body">ContactUs@GlobalGrange.world</a>.</li>
		</ol>
        <br />
       <center> <img src='https://www.globallivestocksolutions.com/logos/High-res/LivestockofAmerica.png' alt='LOA Logo' id='header-img' width=340px style='max-width:340px'></center>
</blockquote>



</div>
</div>
</div></br><br></br><br>
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>