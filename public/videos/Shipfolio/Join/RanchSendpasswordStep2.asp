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
<body >

 <% Current = "Home" %>
<% Current3="Signin" %>
<!--#Include virtual="/Header.asp"-->


<% Region = request.Querystring("Region") %>
<div class="container d-flex align-items-center justify-content-center" style="min-width: 350px;">
        <div >
                <h1>Create an Association Account</h1>
<%
Dim email
Dim Password
Dim Name
Foundpassword = False
email=Request.Form("email")
if len(trim(email)) > 3 then
 sql = "select * from People where lower(trim(PeopleEmail)) = '" & lcase(trim(Email)) & "'  order by PeoplePassword ASC"
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


oMail.To = email
'oMail.BCC = "Contactus@LivestockOfTheWorld.com"
oMail.From = "Livestock Of the World <Contactus@LivestockOfTheWorld.com>"
oMail.Subject =  "Your Livestock Of The World Password"

oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
  

     
end if
end if

if Foundpassword = True then
%>


<div  >
<h2>Your password has been sent to you.</h2>



  <% Fail = request.QueryString("Fail")
if Fail = "True" then %>	

<b><font color=maroon>Sign In Failed. The email / password combination that you tried failed. Please try again.</font></b><br />
	<% end if %>	

You should receive an email at <b><%= email%></b>.<br /> Please login with your ranch account below:<br>
<form  name=Login method="post" action="Handlelogin.asp" >
    Email&nbsp;<br />
    <input name="Email" Value =""  size = "25" class = "formbox" maxlength = "61"  ><br />
    Password&nbsp;</br>
    <input name="password" type = password Value ="" size = "25" maxlength = "61" class = "formbox"></br><br>
    <div align = center><input type="submit" class = "regsubmit2" value="Submit"  ></div>
</form>


If you do not receive an email, check your bulk mail folder or try to recover your password using a different email address.
</div>
<br>

<% else %>

<blockquote>	
<h2>Email Not Found</h2>
The Email address you entered, is not currently in our system. If you think that you may have entered your email address incorrectly please use the form below to return to our sign in page, or <a href = "/Join/Default.asp" class = "body"><b> click here to set up a new account</b></a>.<br><br>


	
<form action= '/Join/RanchSendpasswordStep2.asp?Region=<%=Region %>' method = "post">

			Email Address<br />
             <input name="Email" Value =""  size = "25" class = "formbox" maxlength = "61"  ><br />

			<input type=submit value = "Send Password" size = "110" class = "regsubmit2" ></div>

<td><br><br><br>
</form>


<% End if%>	

</div>
</div>
</div>
<!--#Include virtual="Footer.asp"-->
</body>
</html>