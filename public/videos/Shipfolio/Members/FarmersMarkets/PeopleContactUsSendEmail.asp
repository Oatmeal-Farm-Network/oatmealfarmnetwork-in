<!Doctype html>

<head>

<!--#Include virtual="/includefiles/globalvariables.asp"-->

<title>Contact From</title>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<!--#Include virtual="/Header.asp"-->


<!--#Include file="RanchPagesTabsInclude.asp"-->

<div class="container-fluid"  >
  <div class="row">
    <div class="col"  >

<% 
BusinessName = Request.form("BusinessName")
CurrentPeopleID=Request.form("CurrentPeopleID") 
FirstName=Request.form("FirstName") 
LastName=Request.form("LastName") 
Fieldname2=Request.form("Fieldname2") 
Fieldname0=Request.form("Fieldname0") 
Fieldname1=Request.form("Fieldname1") 

fieldX=Request.form("fieldX") 
PeopleName =Request.form("PeopleName") 
PeopleEmailaddress =Request.form("PeopleEmailaddress") 
Shoesize=Request.form("Shoesize") 
	

Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 53, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	Response.redirect("/Farms/FarmListing.asp?PeopleID=1802&BusinessID=" & CurrentPeopleID & "&Message=Please Answer the Math Question Correctly.")
end if 
Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 
	

Dim Address
Dim Name
Dim City
Dim State
Dim Zip
Dim Email
Dim Question
	'response.write("PeopleEmail =" & PeopleEmail)

str1 = Question
		str2 = vblfvblf
		If InStr(str1,str2) > 0 Then
			Question= Replace(str1, str2 , "</br>")
		End If  


		str1 = Question
		str2 = vblf
		If InStr(str1,str2) > 0 Then
			Question= Replace(str1, str2 , "</br>")
		End If  

		str1 = Question
		str2 = vbtab
		If InStr(str1,str2) > 0 Then
			Question= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
		End If  


Response.Flush

'Body Data




strBody = ""

strBody = strBody & "<html>" & vbCrLf
strBody = strBody & "<head>" & vbCrLf
strBody = strBody & "<style>" & vbCrLf
strBody = strBody & "body { font-family: Arial, sans-serif; }" & vbCrLf  ' Set body width to 340px
strBody = strBody & "a.body { font-family: Arial, sans-serif; color:maroon; text-decoration : none;}" & vbCrLf  
strBody = strBody & "#header-bar { background-color: #B2D6D1; text-align: center; }" & vbCrLf
strBody = strBody & "#header-img { max-width: 340; height: auto; }" & vbCrLf  ' Use max-width for responsive image
strBody = strBody & "</style>" & vbCrLf
strBody = strBody & "</head>" & vbCrLf
strBody = strBody & "<body>" & vbCrLf

strBody = strBody & "<table width='340'>"  


strBody = strBody & "<tr><td colspan='2'><br>This email is from your contact us form on <a href='https://www.globalfarmersmarket.world' class='body'>www.GlobalFarmersMarket.world</a>. Please use the email address below to respond - <b>do not reply directly to this email- the sending email address is not monitored.<br><br></td></tr>"

strBody = strBody & "<tr><td width=120><br><b>Contact</b><br></td></tr>"
strBody = strBody & "<tr><td>Name: </td><td>" & FirstName & " " & LastName & "</td></tr>"
strBody = strBody & "<tr><td>Email: </td><td>" & Fieldname2 & "</td></tr>"
strBody = strBody & "<tr><td>Phone: </td><td>" & Fieldname0 & "</td></tr>"

strBody = strBody & "<tr><td></td><td>" & Fieldname1 & "</td></tr>"
strBody = strBody & "<tr><td colspan='2'><br><a href='https://www.globalfarmersmarket.world' class='body'>www.LivestockOfAmerica.com</a> is part of the <a href='https://www.GlobalGrange.world' class='body'>Global Grange</a> Family of websites.<br><br></td></tr>"
strBody = strBody & "<tr><td colspan='2'> <a href='https://www.globalfarmersmarket.world' class='body'><img src='https://www.globallivestocksolutions.com/Logos/GlobalFarmersMarketLogo.jpg' alt='Global Farmers Market' id='header-img' style='max-width:340' width = 340></a></td></tr>"

strBody = strBody & "</table>" & vbCrLf
strBody = strBody & "</body>" & vbCrLf
strBody = strBody & "</html>" & vbCrLf




if len(AssociationContactEmail) > 3 then
strTo = AssociationContactEmail
else
strTo = AssociationEmailaddress
end if

strTo = AssociationEmailaddress
'response.write("strTo=" & strTo )


'strTo = "contactus@globalgrange.world"
strFrom = Email
strSubject = "Contact From Your Global Farmers Market Contact Page"

   


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
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
  
%>
		



<% Current = "CreateAccount"
Current3="Directory"
CurrentWebsite = "LivestockofTheWorld" 
session("LoggedIn") = False%>


			<Table style = "max-width: 640; background-color: white" align ="center">
				<tr>
					<td width ="330">
						<img src ="SentEmailThanks.jpeg" width ="300px" align ="left" />
					</td>
					<td  class ="body">
						<center><big><b>Your message has been sent</b><br>
						Thank you for reaching out.
					</td>
				</tr>
			</Table>

</div>
</div>
</div>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

<!--#Include virtual="/Footer.asp"-->
</body>
</html>