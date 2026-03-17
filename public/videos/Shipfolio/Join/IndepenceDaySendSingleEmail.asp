<%
'Body Data
strBody="<html><head><div dir='ltr' lang='en-us' class='OutlookMessageHeader' align='left'><meta name='GENERATOR' content='MSHTML 8.00.6001.18259' />" & vbCrLf 

strBody= strBody & "<style type='text/css'>body {Background-color: white }BODY {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px}A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: blue; FONT-SIZE: 11px; TEXT-DECORATION: none}A:visited {COLOR: #666666}A:hover {TEXT-DECORATION: underline}" & vbCrLf

strBody= strBody & "li {margin-top: 5px;} P {FONT-STYLE: normal; border-style: dashed; border-width: 1px; FONT-FAMILY: verdana, sans-serif; COLOR: #666666; FONT-SIZE: 11px; FONT-WEIGHT: normal; TEXT-DECORATION: none}H1 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: Black; FONT-SIZE: 15px; FONT-WEIGHT: bold; TEXT-DECORATION: none; text-align: left}" & vbCrLf 

strBody= strBody & " H2 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: Black; FONT-SIZE: 13px; FONT-WEIGHT: bold; TEXT-DECORATION: none}DIV.emailfooter {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px }DIV.emailfooter A {	FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #ff6600; FONT-SIZE: 11px; TEXT-DECORATION: none}</style>" & vbCrLf 

strBody= strBody & "</head><body border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'><table width='100%' border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'left'  valign ='top' bgcolor = 'white'><tbody><tr><td align = 'left'>"  & vbCrLf 

strBody =  strBody &  "<table width = 515 border='0' cellspacing='10' cellpadding='10' leftmargin='10' topmargin='0' marginwidth='0' marginheight='0' align = 'left'  valign ='top' bgcolor = 'white' >" & vbCrLf

strBody =  strBody &  "<tr><td bgcolor = 'white' align = 'right'><font size='1'>Sell your Animals on LOA | View online here: </font><a href='http://www.livestockofamerica.com/Join/'><font size='1' color = 'grey'>View Online</font></a><br><center><a href ='http://www.livestockofamerica.com/Join/'><img src = 'http://www.LivestockOfAmerica.com/MassEmails/IndependanceDaySaleMassEmail.jpg' width = '515' height = '942' align = 'center' border = '0' /></a></center></td></tr>" & vbCrLf



strBody = strBody  & "<tr><td><font size=2 color = black><center><big><b>30% Off a Custom Website or a Platinum Membership.</b></big><br> To learn more go to </font><a href = 'http://www.livestockofamerica.com/join/' target = blank><font size=2 color = blue>www.livestockofamerica.com/join/</font></center></a>.</blockquote></td></tr>" & vbCrLf


strBody =  strBody &  "<tr><td><table width =515 border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'left'  valign ='top' ><tr><td>" & vbCrLf


 
 
strBody= strBody & "<tr><td bgcolor = 'white'><center><a href ='http://www.LivestockOfAmerica.com'><img src = 'http://www.LivestockOfAmerica.com/MassEmails/LOALogo.jpg' height = '80' align = 'center' border = '0' /></a></center></td></tr>"  & vbCrLf 

 strBody = strBody & "<tr><td bgcolor = 'white'><DIV ALIGN ='right'>Follow us on <a href='https://twitter.com/LivestockOfAmer'  ><img src = 'http://www.LivestockOfAmerica.com/images/Twitter_Logo.jpg' border = '0' width = '22' height = '22' alt = 'The Andresen Group on twitter' /></a><a href = 'https://www.facebook.com/LivestockOfAmerica' ><img src = 'http://www.LivestockOfAmerica.com/images/Facebook_Logo.jpg' border = '0' width = '22' height = '22'  /></a></div>"  & vbCrLf

strBody= strBody & "<br><font color='black' size='1' face='Arial'>This email was sent by: </font><a href='http://www.LivestockOfAmerica.com' class = 'body' target=blank><font style='FONT-SIZE: 10px' color='#636363' size='1' face='arial'><b>Livestock Of America</b></font></a><br>"  & vbCrLf 

strBody= strBody & "<font color='black' size='1' face='Arial'>To unsubscribe please go to <br></font><a href='http://www.livestockofamerica.com/UnsubscribeEmails.asp'>www.LivestockOfAmerica.com/UnsubscribeEmails.asp</a><font color='black' size='1' face='Arial'><br> or send an email to </font><a href='mailto:ContactUS@LivestockOfAmerica.com'><font color='#6F9393' size='1' face='Arial'>ContactUs@LivestockOfAmerica.com</font></a><br /></font></p></table></td></tr></table>" & vbCrLf  

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

if len(strTo) > 1 then
For loopi=1 to Len(strTo)
    spec = Mid(strTo, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	strTo= Replace(strTo,  spec, " ")
   end if
 Next
end if
ObjSendMail.TO =  strTo
ObjSendMail.BCC=  "John@andresengroup.com"
'ObjSendMail.bcc  = "webartistsbiz@gmail.com"
'ObjSendMail.To = "andresengroup@yahoo.com"
strSubject = "Sell Your Animals - Membership & Website Design Sale " 
ObjSendMail.Subject = strSubject
ObjSendMail.From =  "Livestock Of America <marketingMadness@LivestockoftheUK.com>"
     
' we are sending a text email.. simply switch the comments around to send an html email instead 
ObjSendMail.HTMLBody = strBody 
'ObjSendMail.TextBody = strBody 
ObjSendMail.Send 
Set ObjSendMail = Nothing
%>