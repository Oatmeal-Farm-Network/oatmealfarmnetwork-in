<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=Sitenamelong%> Online Livestock Marketplace</title>
<meta name="Title" content="Create Account - <%=Sitenamelong%> Online Livestock Marketplace">
<meta name="description" content="Create your account at <%=Sitenamelong%> - Online Alpaca Marketplace." >
<meta name="rating" content="Safe for kids">
<meta name="author" content="Livestock Of The World" >
<meta name="revisit-after" content="never">
<meta name="author" content="The Andresen group">
<link rel="stylesheet" type="text/css" href="Style.css">
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>
 <% Current = "Home" %>
<% Current3="Signin" %>
<!--#Include virtual="/Header.asp"-->
<% if screenwidth > 700 then %>
<!--#Include virtual="/join/JoinHeader.asp"-->
<% End if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "320"><tr><td align = "left" >
		<h1>Password</h1>
        </td></tr>
        <tr><td >
<table border = "0" bordercolor = "#DBF5F3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "640" height = "300"  valign = "top">
	<tr >
		<td align = "left" class = "body" valign = "top">
<%
Dim email
Dim Password
Dim Name
Foundpassword = False
email=Request.Form("email")
if len(trim(email)) > 3 then
 sql = "select * from People where lcase(trim(PeopleEmail)) = '" & lcase(trim(Email)) & "'  order by PeoplePassword ASC"
  Set rs = Server.CreateObject("ADODB.Recordset")
  'response.write(sql)
	
rs.Open sql, conn, 3, 3 
  If Not rs.eof then
		Password  = trim(rs("PeoplePassword"))
        Password2  = trim(rs("PeoplePassword2"))
        if len(Password) > 1 then
        else
        Password = Password2
        end if

		name  = rs("PeopleFirstName")
Foundpassword = true
    rs.close
end if
	Set Conn = Nothing 

Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer


if len(Password) > 1 then
' Body Data
strBody = strBody & "<font face='arial'>Dear  " & vbCrLf
strBody = strBody & name & ",<br><br>" & vbCrLf
strBody = strBody & "You indicated that you have forgotten your " & Sitenamelong & " password. It is provided below:<br><br>" & vbCrLf
strBody = strBody & "Your password: " & vbCrLf
strBody = strBody & "<b>" & Password & "</b>" & vbCrLf
strBody = strBody & "<br><br>If you did not request this email, please contact us at 541.879.1877.<br><br>Thank You.<br><br>Sincerely,<br><br>" & Sitenamelong &  " <br><br><br>-------------------------------------------------------------------------------------------------------------------------------<br>Protect Your Password<br><br>NEVER give your password to anyone, including " & Sitenamelong & " representatives. <br><br>" & vbCrLf
 strBody = strBody & "-------------------------------------------------------------------------------------------------------------------------------<br><br></font>" & vbCrLf


'response.write("strBody=" & strBody )
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="mail.theandresengroup.com" 'your mail server
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
     
' If your server requires outgoing authentication uncomment the lines below and use a valid email address and password.
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") ="pacamail@theandresengroup.com"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") ="Jackson5"
     
ObjSendMail.Configuration.Fields.Update
     
   
ObjSendMail.To =  email
'ObjSendMail.BCC =  "john@theandresengroup.com"
'ObjSendMail.bcc = "webartistsbiz@gmail.com"
'ObjSendMail.bcc = "andresengroup@yahoo.com"
strSubject = "Your Livestock Of The World Password"
ObjSendMail.Subject = strSubject
ObjSendMail.From =  " Livestock Of the World <pacamail@theandresengroup.com>"
     
' we are sending a text email.. simply switch the comments around to send an html email instead 
ObjSendMail.HTMLBody = strBody 
'ObjSendMail.TextBody = strBody 
if len(email) > 3 then
ObjSendMail.Send 
end if
Set ObjSendMail = Nothing
end if

end if

if Foundpassword = True then
%>

<blockquote>	
<h2>Your password has been sent to you.</h2>
<br>
You should receive an email at <b><%= email%></b>. Please go to our <A href= "SetupAssociationAccountStep1.asp" class = "body"><b>sign in page</b></a> and enter your e-mail and password.<br><br>

If you do not receive an email, check your bulk mail folder or try to recover your password using a different email address. (You may have registered for your account using a different address.)
</blockquote>	

<% else %>

<blockquote>	
<h1>Email Not Found</h1>
The email address you entered
<% if len(email) > 3 then %>
, <b><%= email%></b>, 
<% end if %>is not currently in our system. If you think that you may have entered your email address incorrectly please use the form below to return to our sign in page, or <a href = "SetupAssociationAccount.asp" class = "body"> click here to set up a new account.</a><br><br>


	
<form action= 'SendpasswordStep2.asp' method = "post">
<table align = "center" width = <%=screenwidth %>>
	<tr > 
		<td  align = "center" class = "body2">
			E-mail Address: <input name="Email" size = "52" value="">
		</td>
	</tr>
<tr>
		<td  valign = "top" align = "center" class = "body2">
	
			<div align = "center">
			<input type=submit value = "Send Password" size = "110" class = "regsubmit2" ></div>
			
		</td>
</tr>
<tr>
<td><br><br><br>
</td>
</tr>
</table>
</form>

</blockquote>	
</td>
</tr>
</table>

<% End if%>	
</td>
</tr>
</table>
</td>
</tr>
</table>
<!--#Include virtual="Footer.asp"-->
</body>
</html>