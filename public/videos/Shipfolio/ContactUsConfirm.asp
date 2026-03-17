<!DOCTYPE HTML>
<html>
<head>
<%  PageName = "Contact Us" %>
<!--#Include Virtual="/shipfolio/GlobalVariables.asp"-->
<title>Contact <%=WebSiteName %></title>
<link rel="canonical" href="<%=currenturl %>" />
<meta name="Title" content="Contact <%=WebSiteName %>"/>
<meta name="description" content="Contact <%=WebSiteName %>. <%=WebSiteName %> " />
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="index,follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="Contact <%=WebSiteName %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<%
Dim FName
Dim LName
Dim MName
Dim BizName
Dim Address1
Dim City
Dim State
Dim Zipcode
Dim Country
Dim Email
Dim CommentText
Shoesize =request.form("Shoesize")

FName=Request.Form("FName")
LName=Request.Form("LName")
BizName=Request.Form("BizName")
Email=Request.Form("Email")
CommentText=Request.Form("CommentText")

Response.Flush
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer
strBody = "<font face='body'>This message was sent from the Shipfolio contact form."
' Body Data
strBody = strBody & "<br>Contact Name: "
strBody = strBody & FName
strBody = strBody & "&nbsp;"
strBody = strBody & MName
strBody = strBody & "&nbsp;"
strBody = strBody & LName
strBody = strBody & "&nbsp;"
strBody = strBody & "<br> Business Name: "
strBody = strBody & BizName
strBody = strBody & "<br>Email Address: "
strBody = strBody & Email
strBody = strBody & "<br><br> Message: "
strBody = strBody & CommentText
strBody = strBody & "<br></font>"


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
oMail.BCC = "john@oatmeal-ai.com"
'oMail.To = "john@oatmeal-ai.com"
oMail.To="navuwork23@gmail.com"
oMail.From = sitename & "<john@oatmeal-ai.com>"
oMail.Subject = "Message from " & sitename
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
%>
</head>
<body  >
<!--#Include Virtual="/shipfolio/Header.asp"-->
<div class="container-fluid " style="max-width: 1300px;">
  <div align = "center">
      <div class = "body">
       <h1>Contact Us</h1>
          </div>
        </div>
</div>


<div class="container-fluid " style="max-width: 1300px; min-height: 67px; ">
<br />
<div class =" nested-div mx-auto" style="max-width: 400px; min-height: 67px; ">
     <div class = "row">
        <div class = "body">
	     <center><big><br><b>Thank You</b><br><br>
		 We will get back to you soon.<br><br>
		<A href= "default.asp" class = "body">Click here to return to our home page.</a></big></center><br><br>
		</div>
	</div>
</div>

<br />
<!--#Include Virtual="/shipfolio/Footer.asp"--> 
</div>
</body>
</html>