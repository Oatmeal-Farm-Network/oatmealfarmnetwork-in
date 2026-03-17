<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>Pricing Page</title>
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include virtual="/members/Conn.asp"-->

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
	Response.redirect("Contactus.asp?Message=Please Answer the Math Question Correctly.")
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
strBody = "<font face='body'>This message was sent from your contact form."
' Body Data
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

oMail.From = "GlobalGrange.world <GlobalGrange.world>"
oMail.Subject = "Message from GlobalGrange.world"
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
  
 %>
 </head>
 <body>
 <!--#Include file="MembersHeader.asp"-->
	<br />
	<div class ="container roundedtopandbottom">
<table border="0" cellpadding="5" height = "300" cellspacing="0" width="600" align = 'center' >
    <tr>
      <td width = "100%" class = "body">
		<center><big><br><b>Thank You</b><br><br>
		 We will get back to you soon.<br><br>
		<A href= "default.asp" class = "body">Click here to return to your Account Dashboard.</a></big></center><br><br>
		</td>
	</tr>
</table>
	</div>

<!--#Include file="membersFooter.asp"-->
</body>
</html>