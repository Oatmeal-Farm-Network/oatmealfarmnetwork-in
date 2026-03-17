<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/includefiles/globalvariables.asp"-->

</head>
<body >

<% Current1 = "AssociationHome"
Current2="AssociationHome" %> 

<!--#Include virtual="/AssociationAdmin/AssociationMembersHeader.asp"-->
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


smtpServer = "mail.livestockofamerica.com"
strTo = "contactus@livestockofamerica.com"
strFrom = "contactus@livestockofamerica.comm"
strSubject = "Suggested Term"


strBody = "<html>"
strBody = strBody & "<head>"
strBody = strBody & "<style>"
strBody = strBody & "body { font-family: Arial, sans-serif; }"
strBody = strBody & "#header-bar { background-color: #B2D6D1; text-align: center; }"
strBody = strBody & "#header-img { max-width: 340px; height: auto; }"
strBody = strBody & "</style>"
strBody = strBody & "</head>"
strBody = strBody & "<body>"


strBody = strBody & "<table width = 340>"
    
strBody = strBody & "<tr><td colspan = 2><img src='https://www.globallivestocksolutions.com/Logos/220pxwide/HarvestHubLogo220.png' alt='Header Image' id='header-img' width=340px style='max-width:340px'><td></tr>"
strBody = strBody & "<tr><td colspan = 2><br><b>Frome The AAW Contact Form</b><br><td></tr>"
strBody = strBody & "<tr><td>Name: </td><td>" & strFName & "&nbsp;" & strLName & "<td></tr>"
strBody = strBody & "<tr><td>Business Name: </td><td>" & strBizName & "<td></tr>"
strBody = strBody & "<tr><td>Email Address: </td><td>" & strEmail & "<td></tr>"
strBody = strBody & "<tr><td>Comments: </td><td>" & strCommentText & "<td></tr></table>"

strBody = strBody & "</body>"
strBody = strBody & "</html>"


'response.write("strBody=" & strBody )


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



oMail.From = "AAW <livestockoftheworld@gmail.com>"
oMail.Subject = "AAW HH Contact Form" 
oMail.HTMLBody  = strBody
oMail.TextBody = strBody


oMail.To = "john@globalgrange.world"
 oMail.Send

Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
 %>

	<br />
	<div class="d-flex justify-content-center align-items-center ">
		<div class ="Container roundedtopandbottom" style ="max-width:320px; align-content:center" align="center">
		
			<center><big><br><b>Thank you for contacting us.</b><br><br>
			 We will get back to you soon.<br><br>
			<A href= "default.asp" class = "body">Click here to return to your Account Dashboard.</a></big></center><br><br>
	
	</div>
</div>
<!--#Include virtual="/AssociationAdmin/AssociationFooter.asp"--> 
</body>
</html>