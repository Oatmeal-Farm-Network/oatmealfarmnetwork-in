<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% 
BusinessID = Request.form("BusinessID")

'response.write(emailerror )
If emailerror = False Then
Query =  "INSERT INTO emaillist (ReceiveEmails, EmailFirstName, EmailLastName, Newsletter, Address)" 
Query =  Query & " Values (1,"
Query =  Query &   " '" & FirstName& "', '" & lastName& "', 1, "
Query =  Query &   " '" & Email  & "' )" 
'response.write("Query=" & Query )
conn.Execute(Query) 
End If 
%>

<link rel="stylesheet" href="https://www.livestockoftheworld.com/members/Membersstyle.css">
</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Pricing" %> 
<!--#Include file="MembersHeader.asp"-->



<div class="container roundedtopandbottom">
    <h1>Shopping Cart Confirmation</h1>
Your Order Has Been Placed.
  <%
  Query = "Update IngredientShoppingCart set Status='Submitted' where BuyerBusinessID = " & Session("BusinessID") 
response.write("Query=" & Query)


  Set rs = Server.CreateObject("ADODB.Recordset")
  rs.Open Query, conn, 3, 3  


%>


<br>

	
	</div>
	</div>
</div><br /><br /><br /><br /><br /><br /><br /><br />

<% 

strBody = ""

strBody = strBody & "<html>" & vbCrLf
strBody = strBody & "<head>" & vbCrLf
strBody = strBody & "<style>" & vbCrLf
strBody = strBody & "body { font-family: Arial, sans-serif; width: 340px; }" & vbCrLf  ' Set body width to 340px
strBody = strBody & "#header-bar { background-color: #B2D6D1; text-align: center; }" & vbCrLf
strBody = strBody & "#header-img { max-width: 340; height: auto; }" & vbCrLf  ' Use max-width for responsive image
strBody = strBody & "</style>" & vbCrLf
strBody = strBody & "</head>" & vbCrLf
strBody = strBody & "<body>" & vbCrLf

strBody = strBody & "<table width='340'>"  

strBody = strBody & "<tr><td colspan='2'><img src='https://www.globallivestocksolutions.com/logos/Harvest-Hub-logo.png' alt='Header Image' id='header-img' width = 340 style='max-width:340'></td></tr>"
strBody = strBody & "<tr><td colspan='2'><br><b>Thanks for subscripting to our newsletters.</b><br><br>" & vbCrLf

	strBody = strBody & "We are excited to have you join our community of passionate farmers and ranchers.<br><br>" & vbCrLf

strBody = strBody & "At Global Grange, your privacy is paramount. We'll never share your information with anyone without your permission.<br><br>" & vbCrLf

strBody = strBody & "Farming and ranching are in our blood, and we can't wait to share our news with you. Look forward to insightful articles, valuable resources, and exciting updates to help you grow your operation.<br><br>" & vbCrLf

strBody = strBody & "<b>Didn't subscribe?</b>Please let us know if you received this message in error at <a href='https://www.GlobalGrange.world/Contactus.asp' >https://www.GlobalGrange.world/Contactus.asp</a><br><br>" & vbCrLf

strBody = strBody & "Sincerely,<br>" & vbCrLf

strBody = strBody & "The Global Grange Team<br><br></td></tr>" & vbCrLf



strBody = strBody & "<tr><td></td><td>" & Fieldname1 & "</td></tr>"
strBody = strBody & "<tr><td colspan='2'><br><a href='https://www.harvesthub.world/' class='body'>www.harvesthub.world</a> is part of the <a href='https://www.GlobalGrange.world' class='body'>Global Grange</a> Family of websites.<br><br></td></tr>"
strBody = strBody & "<tr><td colspan='2'> <a href='https://www.GlobalGrange.world'><img src='https://www.globallivestocksolutions.com/Logos/GlobalGrangelogoHorizontal.png' alt='Header Image' id='header-img' style='max-width:340' width = 340></a></td></tr>"

strBody = strBody & "</table>" & vbCrLf
strBody = strBody & "</body>" & vbCrLf
strBody = strBody & "</html>" & vbCrLf

'response.write("strBody=" & strBody )


strTo = Email

strFrom = "thankyou@livestockemails.com"
strSubject = "Thanks for subscripting to our newsletters"

   


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

if len(Email) > 4 then
 oMail.ReplyTo =Email
end if
oMail.To = strTo
'oMail.To = "john@globalgrange.world"

oMail.From = sitename & "<status@livestockemails.com>"

oMail.Subject = strSubject
oMail.BCC =  "contactus@globalgrange.world"
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
'oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing %>


<div></div>

	<!--#Include file="MembersFooter.asp"-->
</body></html>