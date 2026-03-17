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
<meta name="author" content="Oatmeal Farm Network">

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
strSubject = "Your Oatmeal farm Network Subscription Has Been Created"
strBody = "<font face='arial'>Howdy " & PeopleFirstName & ",<br>" & vbCrLf
strBody  = strBody &  "This email's ridin' to you straight from www.OatmealFarmNetwork.com." & vbCrLf
strBody = strBody & "<br>Your brand spankin' new account with The Oatmeal Farm Network has been wrangled up and created.<br>" & vbCrLf
strBody = strBody & "<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Account Confirmation<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "We sure do appreciate you registerin' with us." & vbCrLf
strBody = strBody & "We kindly ask you to mosey on over and validate your registration, just to make sure that email address you provided is on the up and up.<br> This helps keep the no-good spam and troublemakers at bay.<br><br>To get your account goin', just give a click to this here link:" & vbCrLf
strBody = strBody & "<a href = 'https://www.OatmealFarmNetwork.com/AccountConfirmation.asp?PeopleID=" & PeopleID &"'> http://www.oatmealFarmnetwork.com/AccountConfirmation.asp</a><br><br>" & vbCrLf
strBody = strBody & "(If the link don't light a fire, you can copy and paste it in your web browser).<br><br>" & vbCrLf

strBody = strBody & "Once you're at the Account Confirmation corral, you'll need to punch in your activation code.<br>" & vbCrLf
strBody = strBody & "<br>Your activation code reads as follows:<br>" & vbCrLf
strBody = strBody & "&nbsp;&nbsp;&nbsp;&nbsp;<b>" &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you've got any questions, feel free to <a href = 'https://www.OatmealFarmNetwork.com/ContactUs.asp' >get in touch with us </a>.<br>" & vbCrLf
strBody = strBody & "Thanks for hitchin' your wagon with The Global Farmer's Market. </font>" & vbCrLf


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
 .From = "Global Farmers Market <ContactUs@GlobalFarmersMarket.world>"
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

<% smtpServer = "mail.OatmealFarmNetwork.com"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", ContactUs@GlobalfarmersMarket.world"
strFrom = "ContactUs@OatmealFarmNetwork.com"
strSubject = "Your Global Farmers' Market Membership Has Been Created"


strBody = "<table width='600'><tr><td><font face='arial'>Howdy " & PeopleFirstName & ",<br><br>" & vbCrLf
strBody  = strBody &  "We're downright pleased to let you know that your account with Global Farmer's Market has been corralled and created without a hitch.<br><br>" & vbCrLf

strBody = strBody & "As part of the registration roundup, we kindly ask you to wrangle up your email address to make sure we keep the no-good spam and troublemakers out of our services.<br><br>" & vbCrLf

strBody = strBody & "To get that account of yours up and runnin', just give a click to the link below or if you fancy, you can copy and paste it into your web browser. Once you're at the Account Confirmation corral, you'll need to punch in your activation code.<br><br>" & vbCrLf
strBody = strBody & "Activation Link: <a href = 'https://www.GlobalfarmersMarket.world/Join/USA/AccountConfirmation.asp?PeopleID=" & PeopleID & "'> https://www.GlobalfarmersMarket.world/Join/USA/AccountConfirmation.asp</a><br>" & vbCrLf

strBody = strBody & "<br>Activation Code:<b>"  &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you've got any questions, or reckon you need some help, don't be shy to holler at us. We sure do appreciate your decision to ride with Global Farmer's Market!<br>" & vbCrLf

strBody = strBody & "<tr><td><br><img src='https://www.globalFarmersMarket.world/logos/GlobalFarmersMarketLogoSM.png' alt='Global Farmers Market Logo' style='height: 90px; width: auto;'><td></tr></table>"


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
oMail.To = "livestockoftheworld@gmail.com"

oMail.From = sitename & "<contactus@oatmeal-ai.com>"
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
<!--#Include virtual="/Header.asp"-->

 <div class="container-fluid" >
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
			<li>Check your bulk mail folder / spam list to ensure you ain't blocking emails from contactus@oatmeal-ai.com.</li>
			<li>Give this page a good refresh.</li>
			<li>Take a second gander at your email inbox to be sure you've received your message.</li>
			<li>If none of that gets the job done, don't hesitate to drop us a line at <a href = "mailto:contactus@oatmeal-ai.com" class = "body">contactus@oatmeal-ai.com</a>.</li>
		</ol>
        <br />
       
</blockquote>



</div>
</div>
</div></br><br></br><br>
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>