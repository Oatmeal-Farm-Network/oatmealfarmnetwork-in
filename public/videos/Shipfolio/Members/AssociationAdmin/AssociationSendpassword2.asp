<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%  PageName = "Home Page" %>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Member Area</title>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
</head>
<body >


<!--#Include virtual="/includefiles/Header.asp"--> 


<%

Dim email
Dim Password
Dim Name
Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	Response.redirect("AssociationSendPassword.asp?Message=Please Answer the Math Question Correctly.")
end if 
Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 


email=Request.Form("email")
If len(email) < 5 then
Response.redirect("AssociationSendPassword.asp?Message=Please Enter A Valid Email address.")
end if


 sql = "select * from Associations where lower(AssociationContactEmail) = '" & lcase(email) & "'"
 sql = "select * from associationmembers, People where associationmembers.peopleid = people.peopleid and trim(lower(PeopleEmail)) = '" & trim(lcase(email)) & "'"

  Set rs = Server.CreateObject("ADODB.Recordset")
 ' response.write("sql=" & sql)
	rs.Open sql, conn, 3, 3 
  If Not rs.eof then
  notindatabase = False
		Password  = rs("PeoplePassword")
		name  = rs("PeopleFirstName")

    rs.close
    
  

Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

	' Body Data
	strBody = strBody & "<font face= 'arial'>Dear  "
	strBody = strBody & name & ",<br><br>"
	strBody = strBody & "You indicated that you have forgotten your website password. It is provided below:<br><br>"

	strBody = strBody & "Your password: "
	strBody = strBody & "<b>" & Password & "</b></font>"



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
oMail.BCC = "contactus@livestockoftheworld.com"
oMail.To = email
oMail.From = sitename & "<livestockoftheworld@gmail.com>"
oMail.Subject = "Message from " & sitename
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing



%>



<div class="container-fluid" style="max-width: 460px;" >
   <div>
     <div>
<b>Your Password Has Been Sent To You. </b><br />
You should receive an email at <%= email%>. Please go to the <A href= "associationlogin.asp" class = "body"> <b>sign in page</b></a> and enter your email and password.<br><br>

If you don't receive an email, check your bulk mail folder or try to recover your password using a different email address. (You may have entered a different address.)<br />
</div>
</div>
</div>

<% else
notindatabase = true
Response.redirect("AssociationSendPassword.asp?Message=Your Email address is not in our database.")
end if %>

<br /><br />



<!--#Include virtual="/includefiles/Footer.asp"-->
</body>
</html>