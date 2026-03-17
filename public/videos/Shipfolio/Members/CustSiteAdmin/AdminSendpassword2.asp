<!DOCTYPE html >
<html>
<head>
<!--#Include file="Adminglobalvariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The Andresen Group Content Management System</title>

</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% loginpage = True %>
<table width = "<%=pagewidth %>" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" align = "center">
<tr><td><table width = "100%" align = "center" border="0" cellspacing="0" cellpadding="0" >
<tr><td class = "body" height = "80">
<% if mobiledevice = True and SmallMobile = False then %>
<a href = "default.asp"><center><img src =  "/administration/images/HeraCMSLogo.jpg" alt = "Content Management System" height = "211" width = "423" border = "0"></center></a>
<% else %>
<a href = "default.asp"><img src =  "/administration/images/HeraCMSLogo.jpg" alt = "Content Management System" height = "141" width = "282" border = "0"></a>
<% end if %>
<td>
</tr>
</table></td></tr>
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Password</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%">  
<%
Dim email
Dim Password
Dim Name
Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	Response.redirect("AdminSendPassword.asp?Message=Please Answer the Math Question Correctly.")
end if 
Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 


email=Request.Form("email")
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath ) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from People where PeopleEmail = '" & email & "'"
  Set rs = Server.CreateObject("ADODB.Recordset")

	rs.Open sql, conn, 3, 3 
  If Not rs.eof then
		Password  = rs("PeoplePassword")
		name  = rs("PeopleFirstName")
		BusinessID = rs("BusinessID")
    rs.close
    
     sql = "select * from Business where BusinessID = " & BusinessID
    ' response.Write("sql=" & sql)
  Set rs = Server.CreateObject("ADODB.Recordset")

	rs.Open sql, conn, 3, 3 
  If Not rs.eof then
		BusinessName  = rs("BusinessName")
 end if
    rs.close
	Set Conn = Nothing 

Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer



	smtpServer = "mail.TheAndresengroup.com"
	strFrom = email
	strTo = email


	strSubject = "Your Website Password"


	' Body Data
	strBody = strBody & "<font face= 'arial'>Dear  "
	strBody = strBody & name & ",<br><br>"
	strBody = strBody & "You indicated that you have forgotten your website password. It is provided below:<br><br>"

	strBody = strBody & "Your password: "
	strBody = strBody & "<b>" & Password & "</b></font>"



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
     
'End remote SMTP server configuration section=
     
ObjSendMail.To = email
ObjSendMail.bcc = "john@theandresengroup.com"
'ObjSendMail.To = "webartistsbiz@gmail.com"
ObjSendMail.Subject = strSubject
ObjSendMail.From =  BusinessName & "<pacamail@theandresengroup.com>"
     
' we are sending a text email.. simply switch the comments around to send an html email instead

ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
'response.Write(strBody)  
ObjSendMail.Send
     
Set ObjSendMail = Nothing 

end if
%>

<blockquote><br /><br />	
<b>Your Password Has Been Sent To You. </b>
You should receive an email at <%= email%>. Please go to the <A href= "Adminlogin.asp" class = "body"> log in page</a> and enter your e-mail and password.<br><br>

If you don't receive an email, check your bulk mail folder or try to recover your password using a different email address. (You may have entered a different address.)<br />
</blockquote>	
</td>
</tr>
</table>


</body>
</html>