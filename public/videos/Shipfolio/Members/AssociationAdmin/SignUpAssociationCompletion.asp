<%@LANGUAGE="VBScript"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us">
<title>Livestock Of The World - Confirmation</title>
<META name="description" content="Livestock Of The World - Confirmation">
<META name="keywords" content="Sign Up for Livestock Of The World.">
<meta name="author" content="The Andresen Group">
<!--#Include virtual="/MobileWidthInclude.asp"-->
<!--#Include virtual="/conn.asp"-->
<%
AssociationID = Request.querystring("AssociationID")
For x=1 To 8 
Randomize
' select a number between 26 and 97
random_number =  Int(26 * Rnd + 97)
membership=request.form("membership")
' take the numeric and turn it into a character
random_letter = UCase(Chr(random_number))
ActivationCode = ActivationCode & random_letter

Next
ActivationCode = day(now) & month(now) & Year(now) & ActivationCode & Left(TempLastName, 1)

'get AssociationID
sql = "SELECT * from Associationmembers where AssociationID = " & AssociationID  

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 MemberName = rs("MemberFirstName")
 AssociationMemberID = rs("AssociationMemberID")
End If 
rs.close
    
Query =  " UPDATE Associations Set AssociationActivationCode='" & ActivationCode & "'" 
Query =  Query & " where AssociationID = " & AssociationID & ";" 
'response.write(" Query=" & Query ) 
Conn.Execute(Query) 

Query =  " UPDATE Associationmembers Set AssociationActivationCode='" & ActivationCode & "'" 
Query =  Query & " where  AssociationMemberID  = " &  AssociationMemberID  & ";" 
'response.write(" Query=" & Query ) 
Conn.Execute(Query) 

%>
</head>


<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% Current = "Home" %>
<!--#Include virtual="Header.asp"--> 
<% smtpServer = "mail.LivestockOfTheWorld.com"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", john@andresengroup.com"
strFrom = "SignUp@LivestockOfTheWorld.com"
strSubject = "Your Livestock Of The World Association Account has been Created"


strBody = "<font face='arial'>Dear " & MemberName & ",<br>" & vbCrLf
strBody  = strBody &  "This e-mail has been sent to you from www.LivestockOfTheWorld.com." & vbCrLf
strBody = strBody & "<br>Your new account with Livestock Of The World has been successfully created.<br>" & vbCrLf
strBody = strBody & "<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Account Confirmation<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Thank you for registering with us." & vbCrLf
strBody = strBody & "We require that you validate your registration to ensure that the e-mail address you entered was correct.<br> This protects against unwanted spam and malicious abuse.<br><br><b>To activate your account, click on the following link:<br>" & vbCrLf
strBody = strBody & "<a href = 'http://www.LivestockOfTheWorld.com/associationadmin/AssociationAccountConfirmation.asp'> http://www.LivestockOfTheWorld.com/associationadmin/AssociationAccountConfirmation.asp</a></b><br><br>" & vbCrLf
strBody = strBody & "(If the link does not work then copy and paste the link into your web browser).<br><br>" & vbCrLf

strBody = strBody & "<b>Once on the Account Confirmation page you will need to select a password and enter your activation code.</b><br>" & vbCrLf
strBody = strBody & "<br>Your activation code is:<br>" & vbCrLf
strBody = strBody & "&nbsp;&nbsp;&nbsp;&nbsp;<b>" &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you have any questions then please <a href = 'http://www.LivestockOfTheWorld.com/ContactUs.asp' >contact us </a> and let us know.<br>" & vbCrLf
strBody = strBody & "Thank you for registering with Livestock Of The World! </font>" & vbCrLf



'response.write(strBody)
Set ObjSendMail = CreateObject("CDO.Message") 
 
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")="10.0.1.24"
'your mail server
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False
'Use SSL for the connection (True or False) 
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") =60
     
' If your server requires outgoing authentication uncomment the lines below and use a valid email address and password.
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
'basic (clear-text) authentication
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername")="webartists"
'ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername")="AIAuctions@TheAndresenGroup.com"
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") ="Jackson5"
     
ObjSendMail.Configuration.Fields.Update
     
'End remote SMTP server configuration section==
     
ObjSendMail.To = strTo
ObjSendMail.Bcc = "john@theandresengroup.com"
ObjSendMail.Subject = strSubject
ObjSendMail.From =    "Livestock Of The World <signup@LivestockOfTheWorld.com>"

ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
ObjSendMail.Send
set objCDONTSmail = Nothing

%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtopandbottom body" align = "left" valign = "top" height = "650">
		<h1>Account Confirmation</h1>
       
<h2>Thank You for Signing Up with Livestock Of The World</h2>
		<blockquote><b>You will receive an e-mail from us in the next 5 minutes. Please following the direction in the <br>e-mail to activate your account.</b><br><br>

		If you don't receive an email, please:
		<ol>
			<li><b>Check your bulk mail folder / spam list to make sure that you are not blocking e-mails from the e-mail address SignUp@LivestockOfTheWorld.com .</b>
			<li>Refresh this page.
			<li>Check your e-mail in box again to verify that you have received you e-mail.
			<li>If the above does not resolve the issue then please go to our <a href = "http://www.LivestockOfTheWorld.com/ContactUs.asp" class = "body">contact us page</a> and let us know about your issue. 
		</blockquote>

		</td>
	</tr>
</table>	
<!--#Include virtual="/Footer.asp"-->

<%
'Session.Abandon
%> 
</body>
</html>