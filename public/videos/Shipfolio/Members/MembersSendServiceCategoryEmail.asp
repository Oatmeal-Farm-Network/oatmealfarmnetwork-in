<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include file = "MembersGlobalVariables.asp"-->
</head>
<BODY>
<%
UID=Request.Form("Fieldname8")
'response.write("UID=")
'response.write(UID)

page=Request.Form("page")
Name=Request.Form("Name")
Email=Request.Form("Email")
Categories=Request.Form("Categories")
SubCategories=Request.Form("SubCategories")

'Response.Flush


Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

smtpServer = "mail.livestockofamerica.com"
strTo = "contactus@livestockofamerica.com"
strFrom = "contactus@livestockofamerica.comm"
strSubject = "Suggested Service Categories"

strBody = "Name: " & Name & "<br>"
strBody = strBody & "Email: " & Email & "<br>"
strBody = strBody & "The following is a suggested Service categories:<br>"
strBody = strBody & "Categories: " & Categories & "<br>"
strBody = strBody & "SubCategories: " & SubCategories & "<br>"
response.write("strBody=" & strBody )

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
oMail.To = "contactus@GlobalGrange.world"

oMail.From = "Global Grange <contactus@GlobalGrange.world>"
oMail.Subject = "Message from Global Grange Inc."
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
response.redirect("MembersServicesSuggestCategory.asp?SuggestedCategory=True" )
%>
</body>
</html>