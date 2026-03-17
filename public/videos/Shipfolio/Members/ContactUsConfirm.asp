<!DOCTYPE HTML>
<html>
<head>
<%  PageName = "Contact Us" %>
<% MasterDashboard= True %>
<!--#Include virtual="/Members/Membersglobalvariables.asp"-->
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
<meta name="author" content="Oatmeal Farm Network"/>
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
Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")

FName=Request.Form("FName")
LName=Request.Form("LName")
BizName=Request.Form("BizName")
Email=Request.Form("Email")
CommentText=Request.Form("CommentText")

'response.write("fieldX=" & fieldX )
'response.write("<br>answer=" & Mid(Question, 11, 1) )


if not(fieldX = Mid(Question, 53, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	'Response.redirect("Contactus.asp?FName=" & FName & "&LName=" & LName & "&BizName=" & BizName & "&Email=" & Email & "&CommentText=" & CommentText & "&Message=Please Answer the Math Question Correctly.")
end if 
Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 

Response.Flush
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer
strBody = "<font face='body'>This message was sent from your contact form."
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
oMail.To = "livestockoftheworld@gmail.com"

oMail.From = sitename & "<contactus@oatmeal-ai.com>"
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
<!--#Include virtual="/Members/MembersHeader.asp"-->
<div class="container-fluid " style="max-width: 1000px;">
  <div align = "center">
      <div class = "body">
       <h1>Contact Us</h1>
          </div>
        </div>
</div>


<div class="container-fluid " style="max-width: 1000px; min-height: 67px; background-color:white;">
<br />
<div class ="roundedtopandbottom nested-div mx-auto" style="max-width: 400px; min-height: 67px; ">
     <div class = "row">
        <div class = "body">
	     <center><big><br><b>Thank You</b><br><br>
		 We will get back to you soon.<br><br>
		<A href= "default.asp" class = "body">Click here to return to your dashboard.</a></big></center><br><br>
		</div>
	</div>
</div>
</div>
<!--#Include virtual="/Members/MembersFooter.asp"--> 

</body>
</html>