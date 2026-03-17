<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% Title= "Livestock Of U.K."
Description = "Join Livestock Of The U.K.. An online marketplace for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep."
currenturl = "https://www.LivestockOfTheWorld.com/join/U.K./"
Image = ""
 %>

<title><%=Title %></title>
<META name="description" content="<%=Description %>">
<meta name="author" content="Livestock Of The World">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="join Livestock Of U.K.." />
<meta property="og:description" content=<%=Description %> />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="550" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content=<%=Description %> />
<meta name="twitter:title" content="Livestock Of U.K." />

<link rel="canonical" href="<%=currenturl %>" />

<meta http-equiv="Content-Language" content="en-us">
<% website = request.querystring("website") %>
</head>
<body >
<!--#Include virtual="/Header.asp"--> 
<%
Dim strFName
Dim strLName
Dim strMName
Dim strBizName
Dim strAddress1
Dim strCity
Dim strState
Dim strZipcode
Dim strCountry
Dim strEmail
Dim strCommentText
Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 53, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	Response.redirect("Default.asp?Message=Please Answer the Math Question Correctly.")
end if 
Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 
strFName=Request.Form("FName")
strLName=Request.Form("LName")
strMName=Request.Form("MName")
strBizName=Request.Form("BizName")
strAddress1=Request.Form("Address1")
strCity=Request.Form("City")
strState=Request.Form("State")
strZipcode=Request.Form("Zipcode")
strCountry=Request.Form("Country")
strEmail=Request.Form("Email")
strCommentText=Request.Form("CommentText")
strPayment = Request.Form("Payment")
WebsiteAddress = Request.Form("WebsiteAddress")
Response.Flush
'Email Contact Information to The ANDRESEN<b>GROUP</b>
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer
strBody = "<font face='body'>This message was sent from the Livestock Of U.K. Interest form."
' Body Data
strBody = strBody & "<br>Please Let Me Know When Livestock Of U.K. is Available."
strBody = strBody & "<br>Contact Name: "
strBody = strBody & strFName
strBody = strBody & "&nbsp;"
strBody = strBody & strMName
strBody = strBody & "&nbsp;"
strBody = strBody & strLName
strBody = strBody & "&nbsp;"
strBody = strBody & "<br> Business Name: "
strBody = strBody & strBizName
strBody = strBody & "<br>Email Address: "
strBody = strBody & strEmail
strBody = strBody & "<br><br> Message: "
strBody = strBody & strCommentText
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
oMail.To = "contactus@livestockoftheworld.com"

oMail.From = "Livestock Of U.K. <livestockoftheworld@gmail.com>"
oMail.Subject = "Livestock Of U.K. Interest form"
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
  
 %>

	
<table border="0" cellpadding="5" height = "300" cellspacing="0" width="600" align = 'center' >
    <tr>
      <td width = "100%" class = "body">
      <br /><br />
        <center><img src ="https://www.globallivestocksolutions.com/Logos/LOUKLogo.jpg" width = 300 align = center alt = "Livestock Of The U.K." /></center>
		<center><big><br><b>Thank You For Your Interest</b><br><br>
		 We will let you know as soon as Livestock Of The U.K. is available.<br><br>
		</big></center><br><br>
		</td>
	</tr>
</table>

<!--#Include virtual="/Footer.asp"--> 
</body>
</html>