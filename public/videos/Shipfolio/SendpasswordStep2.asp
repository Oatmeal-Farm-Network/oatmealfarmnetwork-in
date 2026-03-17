<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!--#Include virtual="/shipfolio/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">

<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>
</head>
<body >
<!--#Include virtual="/shipfolio/Header.asp"-->
<div class="container-fluid"  >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Your Password Has Been Sent</h1><br />
          </div>
        </div>
    </div>
    </div>
 </div>

 <% ' lg+ navigation  %>
    <div class="container-fluid" align = center style="max-width: 1000px; min-height: 500px; ">
       <div class = "row">
        <div class = "col - 6" align = "left">

<%
Dim email
Dim Password
Dim Name
Foundpassword = False
email=Request.Form("email")
 sql = "select * from People where PeopleEmail = '" & Email & "'"
  Set rs = Server.CreateObject("ADODB.Recordset")
  'response.write(sql)
	
	rs.Open sql, conn, 3, 3 
  If Not rs.eof then
		Password  = rs("PeoplePassword")
		name  = rs("PeopleFirstName")
Foundpassword = true
    rs.close
	Set Conn = Nothing 

Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

	strTo = email


	strSubject = "Your Shipfolio Password"


	' Body Data
	strBody = strBody & "<font face='arial'>Dear  "
	strBody = strBody & name & ",<br><br>"
	strBody = strBody & "Your Shipfolio password is provided below:<br><br>"

	strBody = strBody & "Your password: "
	strBody = strBody & "<b>" & Password & "</b>"

	strBody = strBody & "<br><br><br>Thank You.<br><br>Sincerely,<br><br>Shipfolio<br><br><br>Protect Your Password<br>Never give your password to anyone, including Shipfolio representatives.<br><br><br></font>"


	

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
'oMail.To = "livestockoftheworld@gmail.com"
oMail.To = Email
oMail.From =  WebSiteName & "<john@oatmeal-ai.com>"
oMail.Subject = "Message from Shipfolio" 
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
  

bidtime = FormatDateTime(now,0)
'response.write(bidtime)

%>

	<blockquote>	
<br>
You should receive an email at <b><%= email%></b>. Please go to our <A href= "/Shipfolio/login.asp" class = "body"> log in page</a> and enter your Email and password.<br><br>

If you do not receive an email, check your spam mail folder or try to recover your password using a different email address. 
</blockquote>	

<% else %>

<blockquote>	
<h1>Email Not Found</h1>
The Email address you entered, <b><%= email%></b>, is not currently in our system. If you think that you may have entered your email address incorrectly please use the form below to return to our login page, or <a href = "SetupAccount.asp" class = "body"> click here to set up a new account.</a><br><br>


	
<form action= 'SendpasswordStep2.asp' method = "post">
<table align = "center">
	<tr > 
		<td  align = "center" class = "body2">
			E-mail Address: <input name="Email" size = "52" value="">
		</td>
	</tr>
<tr>
		<td  valign = "top" align = "center" class = "body2">
	
			<div align = "center">
			<input type=submit value = "Send Password" class="regsubmit2" size = "110"  ></div>
			
		</td>
</tr>
<tr>
<td><br><br><br>
</td>
</tr>
</table>
</form>

</blockquote>	


<% End if%>	

   </div>
    </div>
    </div>
<!--#Include virtual="/shipfolio/Footer.asp"-->
</body></html>