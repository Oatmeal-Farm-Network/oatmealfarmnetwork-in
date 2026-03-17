<%
'Body Data
strBody="<html><head><div dir='ltr' lang='en-us' class='OutlookMessageHeader' align='left'><meta name='GENERATOR' content='MSHTML 8.00.6001.18259' />" & vbCrLf 

strBody= strBody & "<style type='text/css'>body {	Background-color : #CBCCCE }BODY {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px}A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: brown; FONT-SIZE: 11px; TEXT-DECORATION: none}A:visited {COLOR: #666666}A:hover {TEXT-DECORATION: underline}" & vbCrLf

strBody= strBody & " P {FONT-STYLE: normal; border-style: dashed; border-width: 1px; FONT-FAMILY: verdana, sans-serif; COLOR: #666666; FONT-SIZE: 11px; FONT-WEIGHT: normal; TEXT-DECORATION: none}H1 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: Black; FONT-SIZE: 15px; FONT-WEIGHT: bold; TEXT-DECORATION: none; text-align: center}" & vbCrLf 

strBody= strBody & " H2 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: Black; FONT-SIZE: 13px; FONT-WEIGHT: bold; TEXT-DECORATION: none}DIV.emailfooter {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px }DIV.emailfooter A {	FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #ff6600; FONT-SIZE: 11px; TEXT-DECORATION: none}</style>" & vbCrLf 

strBody= strBody & "</head><body border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'><table width='100%' border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' bgcolor = '#CBCCCE'><tbody><tr><td align = 'center'>"  & vbCrLf 

strBody =  strBody &  "<table width = 640 border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' bgcolor = '#F6F7F0' >" & vbCrLf

strBody =  strBody &  "<tr><td colspan ='2' bgcolor = '#CBCCCE' align = 'right'><font size='1'>Black Friday Discounts | View online here: </font> <a href='http://www.livestockofamerica.com/Join/'><font size='1'>www.livestockofamerica.com/Join/</font></a></td></tr>"

strBody = strBody  & "<tr><td><a href =' http://www.livestockofamerica.com/Join/'><img src = 'http://www.LivestockOfAmerica.com/MassEmails/Blackfriday2015.jpg' width =640 height =629 border = 0 alt='Black Fiday Discounts.' </a><br></td></tr>" & vbCrLf


strBody =  strBody &  "<table width =640 border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' ><tr><td colspan ='2'>" & vbCrLf

 strBody = strBody & "<tr><td colspan = '2' bgcolor = 'white'><DIV ALIGN ='right'>Follow us on <a href='https://twitter.com/LivestockOfAmer'  ><img src = 'http://www.LivestockOfAmerica.com/images/Twitter_Logo.jpg' border = '0' width = '22' height = '22' alt = 'The Andresen Group on twitter' /></a><a href = 'https://www.facebook.com/LivestockOfAmerica' ><img src = 'http://www.LivestockOfAmerica.com/images/Facebook_Logo.jpg' border = '0' width = '22' height = '22' alt = 'Exit Strategy' /></a></div>"  & vbCrLf
 
 
strBody= strBody & "<tr><td colspan ='3' bgcolor = 'white'><br><table border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top'><tr><td><a href ='http://www.LivestockOfAmerica.com'><img src = 'http://www.TheAndresenGroup.com/MassEmails/LOALogo.jpg' width = '300' height = '80' align = 'left' border = '0' /></a></td><td bgcolor=black width = 1><img src='http://www.TheAndresenGroup.com/images/px.gif' width = 1 height=1></td><td bgcolor=white width = 3><img src='http://www.TheAndresenGroup.com/images/px.gif' width = 1 height=1></td>"  & vbCrLf 


strBody= strBody & "<td><font color='black' size='1' face='Arial'>This email was sent by: </font><a href='http://www.LivestockOfAmerica.com' class = 'body' target=blank><font style='FONT-SIZE: 10px' color='#636363' size='1' face='arial'><b>Livestock Of America</b></font></a><br><br>"  & vbCrLf 

strBody= strBody & "<font color='black' size='1' face='Arial'>To unsubscribe please go to <br></font><a href='http://www.livestockofamerica.com/UnsubscribeEmails.asp'>www.theandresengroup.com/UnsubscribeEmails.asp</a><font color='black' size='1' face='Arial'><br> or send an email to </font><a href='mailto:ContactUS@LivestockOfAmerica.com'><font color='#6F9393' size='1' face='Arial'>ContactUs@LivestockOfAmerica.com</font></a><CRLF>.<CRLF><br /></font></p></td></tr></tbody></table></td></tr></table>" & vbCrLf  

strBody= strBody & "</BODY></HTML>"  & vbCrLf 
'response.Write("strBody=" & strBody)


'CDONTS EMail
Set ObjSendMail = CreateObject("CDO.Message") 
 
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
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
     
'End remote SMTP server configuration section=

'ObjSendMail.To =  trim(strTo)
ObjSendMail.To=  "BlackFriday@LivestockofAmerica.com"
'ObjSendMail.To = "webartistsbiz@gmail.com"
'ObjSendMail.To = "andresengroup@yahoo.com"
strSubject = "Black Week Deals - Mass Emails, Custom Website Design, & More!"
ObjSendMail.Subject = strSubject
ObjSendMail.From =  "Livestock of America <BlackFriday@LivestockofAmerica.com>"
     
' we are sending a text email.. simply switch the comments around to send an html email instead 
ObjSendMail.HTMLBody = strBody 
'ObjSendMail.TextBody = strBody 
if len(strTo) > 5 then
ObjSendMail.Send 
end if
Set ObjSendMail = Nothing
%>