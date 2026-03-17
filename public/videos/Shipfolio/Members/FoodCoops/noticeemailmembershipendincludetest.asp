<!--#Include virtual="/Conn.asp"--> 
<%
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")
sql = "select * from People where accesslevel > 0 and ( DateDiff('d', Now, custAIEndService )= 1 or DateDiff('d', Now, custAIEndService )= 5 or DateDiff('d', Now, custAIEndService )= 13 or DateDiff('d', Now, custAIEndService )= 28  or DateDiff('d', Now, custAIEndService ) < 0 ) and (not (PeopleID=515))"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3   
'count = 0
while not rs.eof  
'count = count + 1
subscriptionlevel= rs("subscriptionlevel") 
custAIEndService= rs("custAIEndService")  
PeopleFirstName = rs("PeopleFirstName")  
PeopleLastName = rs("PeopleLastName")
PeopleID = rs("PeopleID")
custFooterEndDate= rs("custFooterEndDate")
PeopleEmail= rs("PeopleEmail")
if DateDiff("d", Now, custAIEndService ) = 1 then
Dayusage = "Day"
else
Dayusage = "Days"
end if

if DateDiff("d", Now, custAIEndService ) < 0 and subscriptionlevel > 0 then
daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
datenownext =  monthnow & "/" & daynow & "/" & (yearnow +1 )

Query =  " UPDATE People Set custAIEndService = '" &   datenownext & "'," 
Query =  Query & " SubscriptionLevel =0," 
Query =  Query & " MaxAnimals =1," 
Query =  Query & " maxHerdsires = 1," 
Query =  Query & " MaxProducts  = 5" 
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 

strBODY="<html><head><div dir='ltr' lang='en-us' class='OutlookMessageHeader' align='left'><meta name='GENERATOR' content='MSHTML 8.00.6001.18259' />" & vbCrLf 

strBODY= strBODY & "<style type='text/css'>BODY {Background-color : #CBCCCE }BODY {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px}A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: brown; FONT-SIZE: 11px; TEXT-DECORATION: none}A:visited {COLOR: maroon}A:hover {TEXT-DECORATION: underline}P {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: maroon; FONT-SIZE: 11px; FONT-WEIGHT: normal; TEXT-DECORATION: none}H1 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: black; FONT-SIZE: 16px; FONT-WEIGHT: bold; TEXT-DECORATION: none}DIV.emailfooter {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px }DIV.emailfooter A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #ff6600; FONT-SIZE: 11px; TEXT-DECORATION: none}</style>" & vbCrLf 

strBODY= strBODY & "</head><BODY border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>"  & vbCrLf 

strBODY =  strBODY &  "<table width = 600 border='0' bgcolor = 'white' cellspacing='5' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' ><tr><td width = '600' colspan = '6'><a href = 'http://www.LivestockOfAmerica.com' ><img src = 'http://www.theandresengroup.com/massemails/NewAI.jpg' width = '600' height = '157' border = 0 alt = 'Alpacas for sale'></a></td></tr>" & vbCrLf
if SubscriptionLevel= 1 then 
membershiplevel = "Copper"
end if 
 if SubscriptionLevel= 2 then 
membershiplevel = "Silver"
end if 
 if SubscriptionLevel= 3 then 
membershiplevel = "Gold"
 end if 
 if SubscriptionLevel= 4 then 
membershiplevel = "Platinum"
 end if 

strBody = strBody & "<tr><td class = 'body' colspan = '6'>Dear " & PeopleFirstName & " " & PeopleLastName & ",</td></tr>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' colspan = '6'>Your Livestock Of America <b>" & membershiplevel & "</b> membership has expired and coverted to a limited <b>Tin</b> membership.</td></tr>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' colspan = '6'>To renew your membership:<ul><li>Sign into your account at <a href = 'http://www.LivestockOfAmerica.com/Login.asp' class = 'body' target='blank'>ttp://www.LivestockOfAmerica.com/Login.asp</a></li><li>Select the large button titled <b><i>Renew or Upgrade Your Membership</b></i></li><li>Select either the <i><b>Change</b></i> or the <i><b>Renew</b></i> button associated with the membership level that you want.</li></td></tr>" & vbCrLf


strBody = strBody & "<tr><td class = 'body' colspan = '6' align = 'center'><br>If you have any questions, please <a href = 'http://www.LivestockOfAmerica.com/ContactUs.asp' >contact us </a> and let us know.<br>Thank you for choosing Livestock Of America!<br><br><br></td></tr>" & vbCrLf


strBody = strBody & "<tr><td colspan = '6'><table border = 0 cellpadding = 0 cellspacing = 0>"


strBODY= strBODY & "<tr><td bgcolor = 'white' colspan = '6'><a href ='http://www.theandresengroup.com'><img src = 'http://www.TheAndresenGroup.com/MailingImages/EmailByTheAndresenGroup.jpg' width = '300' height = '80' align = 'left' border = '0' /></a></td>"  & vbCrLf 


strBODY= strBODY & "<td width ='299' align = 'left'><DIV ALIGN ='right'>Follow us on <a href='https://twitter.com/LivestockOfAmer'  ><img src = 'http://www.LivestockOfAmerica.com/images/Twitter_Logo.jpg' border = '0' width = '22' height = '22' alt = 'Livestock of America on Twitter' /></a><a href = 'https://www.facebook.com/LivestockOfAmerica' ><img src = 'http://www.LivestockOfAmerica.com/images/Facebook_Logo.jpg' border = '0' width = '22' height = '22' alt = 'Livestock Of America on Facebook' /></a> </div>"  & vbCrLf 

strBODY= strBODY & "<br><br></font><CRLF><CRLF><br /></font></td></tr></table>" & vbCrLf  

strBODY= strBODY & "</td></tr></table></td></tr>"

strBODY= strBODY & "</table></BODY></HTML>"  & vbCrLf 


'response.write(strBODY)
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
if len(PeopleEmail) > 7 then     
'End remote SMTP server configuration section=
'response.write("PeopleEmail=" & PeopleEmail )     
ObjSendMail.To = PeopleEmail
'ObjSendMail.To = "statemails@LivestockOfAmerica.com"
ObjSendMail.bcc = "john@theandresengroup.com"
'ObjSendMail.To =  "webartistsbiz@gmail.com"
ObjSendMail.Subject = "Your Livestock Of America " & membershiplevel & " Membership Has Expired."
ObjSendMail.From =  "Livestock Of America <statemails@LivestockOfAmerica.com>"
ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
ObjSendMail.Send
end if
end if
if trim(custFooterEndDate) = trim(cdate(FormatDateTime(Now, 2))) or DateDiff("d", Now, custAIEndService )= -1 then
   'response.write("sent today")
else
Query =  " UPDATE People Set custFooterEndDate  = '" & cdate(FormatDateTime(Now, 2)) & "'" 'custAIEndService
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 

strBODY="<html><head><div dir='ltr' lang='en-us' class='OutlookMessageHeader' align='left'><meta name='GENERATOR' content='MSHTML 8.00.6001.18259' />" & vbCrLf 
strBODY= strBODY & "<style type='text/css'>BODY {Background-color : #CBCCCE }BODY {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px}A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: brown; FONT-SIZE: 11px; TEXT-DECORATION: none}A:visited {COLOR: maroon}A:hover {TEXT-DECORATION: underline}P {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: maroon; FONT-SIZE: 11px; FONT-WEIGHT: normal; TEXT-DECORATION: none}H1 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: black; FONT-SIZE: 16px; FONT-WEIGHT: bold; TEXT-DECORATION: none}DIV.emailfooter {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px }DIV.emailfooter A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #ff6600; FONT-SIZE: 11px; TEXT-DECORATION: none}</style>" & vbCrLf 

strBODY= strBODY & "</head><BODY border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>"  & vbCrLf 

strBODY =  strBODY &  "<table width = 600 border='0' bgcolor = 'white' cellspacing='5' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' ><tr><td width = '600' colspan = '6'><a href = 'http://www.LivestockOfAmerica.com' ><img src = 'http://www.theandresengroup.com/massemails/NewAI.jpg' width = '600' height = '157' border = 0 alt = 'Alpacas for sale'></a></td></tr>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' colspan = '6'>Dear " & PeopleFirstName & " " & PeopleLastName & ",</td></tr>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' colspan = '6'>Your Livestock Of America membership expires in <b>" & DateDiff("d", Now, custAIEndService )  & " " & Dayusage & "</b>.</td></tr>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' colspan = '6'>To renew your membership:<ul><li>Sign into your account at <a href = 'http://www.LivestockOfAmerica.com/Login.asp' class = 'body' target='blank'>ttp://www.LivestockOfAmerica.com/Login.asp</a></li><li>Select the large button titled <b><i>Renew or Upgrade Your Membership</b></i></li><li>Select either the <i><b>Change</b></i> or the <i><b>Renew</b></i> button associated with the membership level that you want.</li></td></tr>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' colspan = '6' align = 'center'><br>If you have any questions, please <a href = 'http://www.LivestockOfAmerica.com/ContactUs.asp' >contact us </a> and let us know.<br>Thank you for choosing Livestock Of America!<br><br><br></td></tr>" & vbCrLf
strBody = strBody & "<tr><td colspan = '6'><table border = 0 cellpadding = 0 cellspacing = 0>"
strBODY= strBODY & "<tr><td bgcolor = 'white' colspan = '6'><a href ='http://www.theandresengroup.com'><img src = 'http://www.TheAndresenGroup.com/MailingImages/EmailByTheAndresenGroup.jpg' width = '300' height = '80' align = 'left' border = '0' /></a></td>"  & vbCrLf 
strBODY= strBODY & "<td width ='299' align = 'left'><DIV ALIGN ='right'>Follow us on <a href='https://twitter.com/LivestockOfAmer'  ><img src = 'http://www.LivestockOfAmerica.com/images/Twitter_Logo.jpg' border = '0' width = '22' height = '22' alt = 'Livestockon twitter' /></a><a href = 'https://www.facebook.com/LivestockOfAmerica' ><img src = 'http://www.LivestockOfAmerica.com/images/Facebook_Logo.jpg' border = '0' width = '22' height = '22' alt = 'Livestock Of America on Facebook' /></a> </div>"  & vbCrLf 
strBODY= strBODY & "<br><br></font><CRLF><CRLF><br /></font></td></tr></table>" & vbCrLf  
strBODY= strBODY & "</td></tr></table></td></tr>"
strBODY= strBODY & "</table></BODY></HTML>"  & vbCrLf 
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
if len(PeopleEmail) > 7 then     
'End remote SMTP server configuration section=
'response.write("PeopleEmail=" & PeopleEmail )     
ObjSendMail.To = PeopleEmail
'ObjSendMail.To = "statemails@LivestockOfAmerica.com"
ObjSendMail.bcc = "john@theandresengroup.com"
'ObjSendMail.To =  "webartistsbiz@gmail.com"
ObjSendMail.Subject = "Your Livestock Of America Membership Expires in " & DateDiff("d", Now, custAIEndService ) & " " & Dayusage & "."
ObjSendMail.From =  "Livestock Of America <statemails@LivestockOfAmerica.com>"
ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
ObjSendMail.Send
end if
set objCDONTSmail = Nothing
end if
rs.movenext 
wend
'rs.close


test = False
if test = True then
  todayis =4
else
todayis = weekday(now())
end if


if todayis = 4 then

Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
 
if test = True then
sql = "select * from People where PeopleID=1806"
'sql = "select * from People where PeopleID=1016 "
else
sql = "select * from People where ReceiveStatusEmails = True and (not (trim(custFooterStartDate) = '" & trim(cdate(FormatDateTime(Now, 2))) & "')) and (not (PeopleID=515))"
end if

rs.Open sql, Conn, 3, 3   
count = 0
while not rs.eof  and count  < 5
count = count + 1

custAIEndService= rs("custAIEndService")  
PeopleFirstName = rs("PeopleFirstName")  
PeopleLastName = rs("PeopleLastName")
PeopleID = rs("PeopleID")
custFooterEndDate= rs("custFooterEndDate")
custFooterStartDate= rs("custFooterStartDate")
PeopleEmail= rs("PeopleEmail")
SubscriptionLevel = rs("SubscriptionLevel")
AIPublish = rs("AIPublish")
if AIPublish = True then
  AccountStatus = "Published"
else
  AccountStatus = "Unpublished<br>Your animals, products, and pages will not be viewable until you publish your account!"
end if

dim animalnamesarray(9000)
dim animalIDarray(9000)
dim Forsalearray(9000)
dim Forstudarray(9000)
dim pricearray(9000)
dim studfeearray(9000)

dim prodNameArray(9000)
dim ProdIDarray(9000)
dim prodPricearray(9000)
dim ProdForSalearray(9000)
dim prodSalePricearray(9000)

dim PackageNamearray(9000)
dim PackageIDarray(9000)
dim PackagePricearray(9000)

TotalHitsThisWeek  = 0	
sql2 = "select * from Animals, Pricing where Animals.Id = Pricing.Id and PeopleID = " & PeopleID
'response.write("sql2=" & sql2)
rs2.Open sql2, Conn, 3, 3   
totalalpacas = rs2.recordcount - 1
i = 0
while not rs2.eof
i = i + 1
animalnamesarray(i) = rs2("FullName") 
animalIDarray(i) = rs2("ID")
Forsalearray(i) = rs2("publishforsale")
Forstudarray(i) = rs2("publishstud")
pricearray(i)= rs2("Price")
studfeearray(i)= rs2("studfee")
if studfeearray(i) = "0" then
studfeearray(i) = ""
end if
rs2.movenext
wend
rs2.close

'count = 0
sql2 = "select * from Animals where PublishForSale = True and PeopleID = " & PeopleID

rs2.Open sql2, Conn, 3, 3   
totalalpacasPublished = rs2.recordcount
rs2.close

sql2= "select * from Package where PeopleID = " & PeopleID
rs2.Open sql2, Conn, 3, 3   
totalPackages = rs2.recordcount
rs2.close

sql2 = "select * from Package where  len(trim(PackageName)) > 3 and  PeopleID = " & PeopleID
rs2.Open sql2, Conn, 3, 3   
totalPackagesPublished = rs2.recordcount 
i = 0
while not rs2.eof
i = i + 1
PackageNamearray(i)= rs2("PackageName") 
PackageIDarray(i)= rs2("PackageID") 
response.write("packagename=" & PackageNamearray(i) ) 
PackagePricearray(i)= rs2("PackagePrice") 
rs2.movenext
wend
rs2.close

sql2 = "select * from sfproducts where PeopleID = " & PeopleID
rs2.Open sql2, Conn, 3, 3   
totalProducts = rs2.recordcount
i = 0
while not rs2.eof
i = i + 1
prodNamearray(i)= rs2("ProdName") 
ProdIDarray(i)= rs2("ProdID") 
prodPricearray(i)= rs2("prodPrice") 
ProdForSalearray(i)= rs2("ProdForSale") 
prodPriceArray(i)= rs2("prodPrice") 
prodSalePricearray(i)= rs2("prodSalePrice") 
rs2.movenext
wend
rs2.close

sql2 = "select * from sfproducts where ProdForSale = True and PeopleID = " & PeopleID
rs2.Open sql2, Conn, 3, 3   
totalProductsPublished = rs2.recordcount
rs2.close

if trim(custFooterStartDate) = trim(cdate(FormatDateTime(Now, 2))) then
'response.write("sent today")
else
'response.write("hello")
Query =  " UPDATE People Set custFooterStartDate  = '" & cdate(FormatDateTime(Now, 2)) & "'" 'custAIEndService
Query =  Query & " where PeopleID = " & PeopleID & ";" 

'/****************************************
'/Exceute Update
'/****************************************
Conn.Execute(Query) 


if len(SubscriptionLevel) > 0 then
else
SubscriptionLevel = 1
Query =  " UPDATE People Set SubscriptionLevel= 0" 'custAIEndService
Query =  Query & " where len(SubscriptionLevel) < 1 ;" 
Conn.Execute(Query) 
end if
strBODY="<html><head><div dir='ltr' lang='en-us' class='OutlookMessageHeader' align='left'><meta name='GENERATOR' content='MSHTML 8.00.6001.18259' />" & vbCrLf 

strBODY= strBODY & "<style type='text/css'>BODY {Background-color : #CBCCCE }BODY {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 10px}A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: brown; FONT-SIZE: 10px; TEXT-DECORATION: none}A:visited {COLOR: maroon}A:hover {TEXT-DECORATION: underline}P {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: maroon; FONT-SIZE: 10px; FONT-WEIGHT: normal; TEXT-DECORATION: none}H1 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: black; FONT-SIZE: 16px; FONT-WEIGHT: bold; TEXT-DECORATION: none}DIV.emailfooter {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px }DIV.emailfooter A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #ff6600; FONT-SIZE: 11px; TEXT-DECORATION: none}</style>" & vbCrLf 

strBODY= strBODY & "</head><BODY border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>"  & vbCrLf 

strBODY= strBODY & "<table  border='0' width = '700' bgcolor = 'white' cellspacing='5' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' ><tr><td align = 'center'><a href = 'http://www.LivestockOfAmerica.com' ><center><img src = 'http://www.livestockOfAmerica.com/images/LOALogo.jpg' width = '299' height = '90' border = 0 alt = 'Livestock for Sale' align = 'center'></center></a></td></tr><tr><td bgcolor = 'white'>" & vbCrLf

strBODY =  strBODY &  "<table  border='0' width = '700' bgcolor = 'white' cellspacing='5' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' ><tr><td colspan = '6' align = 'center'></td></tr>" & vbCrLf

if cint(SubscriptionLevel) = 0 then
   membershiplevel = "Tin"
end if
if cint(SubscriptionLevel) = 1 then
   membershiplevel = "Copper"
end if
if cint(SubscriptionLevel) = 2 then
   membershiplevel = "Silver"
end if
if cint(SubscriptionLevel) = 3 then
   membershiplevel = "Gold"
end if
if cint(SubscriptionLevel) = 4 then
   membershiplevel = "Platinum"
end if

conn.close
set conn = nothing	%>
<!--#Include virtual="/ConnStats.asp"-->
<%
strBody = strBody & "<tr><td class = 'body' colspan = '6'>Dear " & PeopleFirstName & " " & PeopleLastName & ",<br>Below is your weekly Livestock Of America statistics:</td></tr>" & vbCrLf

if DateDiff("d", Now, custAIEndService ) < 31 and SubscriptionLevel > 1 then

if DateDiff("d", Now, custAIEndService ) = 0 then
strBody = strBody & "<tr><td class = 'body' colspan = '6'><b>Your Livestock Of America  " &  membershiplevel & " membership expires today!</b></td></tr>" & vbCrLf
else
strBody = strBody & "<tr><td class = 'body' colspan = '6'><b>Your Livestock Of America " &  membershiplevel & " membership expires in " & DateDiff("d", Now, custAIEndService ) &  " " & Dayusage & ".</b></td></tr>" & vbCrLf
end if

strBody = strBody & "<tr><td class = 'body' colspan = '6'>To renew your membership:<ul><li>Sign into your account at <a href = 'http://www.LivestockOfAmerica.com/Login.asp' class = 'body' target='blank'><font size = '2'>http://www.LivestockOfAmerica.com/Login.asp</font></a></li><li>Select the large button titled <b><i>Renew or Upgrade Your Membership</b></i></li><li>Select either the <i><b>Change</b></i> or the <i><b>Renew</b></i> button associated with the membership level that you want.</li></td></tr>" & vbCrLf
end if

strBody = strBody & "<tr><td class = 'body' width = '115' align = 'right' colspan = '2'>Membership Level:</td><td class = 'body' colspan = '4'><b>" & membershiplevel & "</b></td></tr>" & vbCrLf

strBody = strBody & "<tr><td class = 'body' align = 'left' valign = 'top' colspan = '6'>You do not currently have any animals listed.</td></tr>" & vbCrLf
'Animals
if totalalpacas < 1  then
strBody = strBody & "<tr><td class = 'body' align = 'right' valign = 'top'>Status:</td><td class = 'body' colspan = '5'><b>" & AccountStatus & "</b></td></tr>" & vbCrLf
else
strBody = strBody & "<tr><td class = 'body' align = 'center' width = '300'><b>Animal</b></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><b>Published<br> for Sale</center></b></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><b>Price</b></center></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><b>Published<br>Stud</b></center></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><b>Stud Fee</b></center></td>" & vbCrLf
strBody = strBody & "<td class = 'body' width='150'><center><b>Hits in Last Week</b></center></td></tr>" & vbCrLf

 For i = 0 to totalalpacas 

sql3 = "select animalID from StatsanimalsLastWeek where animalID = " & animalIDarray(i) 
'response.write("sql3=" & sql3) 
	rs3.Open sql3, connStats, 3, 3   	
	If Not rs3.eof then			
	'response.write(rs3.recordcount)
		TotalHitsThisWeek =  TotalHitsThisWeek + rs3.recordcount
	Else
		'response.write("0")									
	End If 
rs3.close
if order = "odd" then
order = even
strBody = strBody & "<tr bgcolor = '#eeeeee'>"& vbCrLf
else
order = odd
strBody = strBody & "<tr>"& vbCrLf
end if
strBody = strBody & "<td class = 'body' align = 'left'><a href='http://www.livestockofamerica.com/Ranches/details.asp?ID=" & animalIDarray(i) & "&CurrentPeopleID=" & PeopleID & "' class=  'body' target='blank'><font size = '2'>" & animalnamesarray(i) & "</font></a></td>" & vbCrLf
if  Forsalearray(i) = True then
strBody = strBody & "<td class = 'body'><div align = 'center'>Yes</div></td>" & vbCrLf
else
strBody = strBody & "<td class = 'body'><div align = 'center'>No</div></td>" & vbCrLf
end if
strBody = strBody & "<td class = 'body'><div align = 'right'>" & formatcurrency(pricearray(i), 0) & "</div></td>" & vbCrLf
if Forstudarray(i) = True then
strBody = strBody & "<td class = 'body'><div align = 'center'>Yes</div></td>" & vbCrLf
else
strBody = strBody & "<td class = 'body'><div align = 'center'>No</div></td>" & vbCrLf
end if
strBody = strBody & "<td class = 'body'><div align = 'right'>" 
if len(studfeearray(i)) > 0 then
strBody = strBody & formatcurrency(studfeearray(i), 2)
end if
 strBody = strBody & "</div></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><div align = 'right'>" & TotalHitsThisWeek & "<img src = 'http://www.livestockofamerica.com/images/px.gif' width= '30' height = '1'></div></td> </tr>" & vbCrLf

next
end if
'products
if totalproducts > 1 then
strBody = strBody & "<tr><td class = 'body' align = 'center' colspan = '6'><br></td>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' align = 'center' colspan = '2'><b>Product</b></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><b>Published<br> for Sale</center></b></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><b>Price</b></center></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><b>Discount<br>Price</b></center></td>" & vbCrLf
strBody = strBody & "<td class = 'body'><center><center><b>Hits in Last Week</b></center></center></td>" & vbCrLf
strBody = strBody & "<td class = 'body' width='150'></td></tr>" & vbCrLf

For i = 0 to totalproducts 
sql3 = "select ProdID from StatsProductsLastWeek where ProdID = " & ProdIDarray(i) 

	rs3.Open sql3, connStats, 3, 3   	
	If Not rs3.eof then			
		'response.write(rs3.recordcount)
		TotalHitsThisWeek =  TotalHitsThisWeek + rs3.recordcount
	Else
		'response.write("0")									
	End If 
rs3.close

strBody = strBody & "<tr><td class = 'body' align = 'left' colspan = '2'><a href='http://www.livestockofamerica.com/Ranches/ProductDetails.asp?prodid=" & prodIDarray(i) & "&CurrentPeopleID=" & PeopleID & "' class=  'body' target='blank'><font size = '2'>" & prodNamearray(i) & "</font></a></td>" & vbCrLf
if ProdForSalearray(i)  = True then
strBody = strBody & "<td class = 'body'><div align = 'center'>Yes</div></td>" & vbCrLf
else
strBody = strBody & "<td class = 'body'><div align = 'center'>No</div></td>" & vbCrLf
end if
strBody = strBody & "<td class = 'body'><div align = 'right'>" & formatcurrency(prodPricearray(i),0) & "</div></td>" & vbCrLf

if len(prodSalePricearray(i) ) > 0 then
strBody = strBody & "<td class = 'body'><div align = 'center'>" & formatcurrency(prodSalePricearray(i),0) & "</div></td>" & vbCrLf
else
strBody = strBody & "<td class = 'body'><div align = 'center'> </div></td>" & vbCrLf
end if
strBody = strBody & "<td class = 'body'><div align = 'right'>" & TotalHitsThisWeek & "<img src = 'http://www.livestockofamerica.com/images/px.gif' width= '40' height = '1'></div></td></tr>" & vbCrLf

next
end if



'packages
response.write("totalpackages =" & totalpackages   )
if totalpackages > 0 then
strBody = strBody & "<tr><td class = 'body' align = 'center' colspan = '6'><br></td>" & vbCrLf
strBody = strBody & "<tr><td class = 'body' align = 'center' colspan = '2'><b>Package Name</b></td>" & vbCrLf
strBody = strBody & "<td class = 'body' colspan = '2'><center><b>Price</b></center></td>" & vbCrLf
strBody = strBody & "<td class = 'body' colspan = '2'><center><b>Hits This Week</b></center></td></tr>" & vbCrLf
strBody = strBody & "<tr><td colspan ='6'>huh</td></tr>" & vbCrLf
For i = 0 to (totalpackages+1) 
if len(PackageIDarray(i) ) > 0 then
sql3 = "select PackageID from StatspackageLastWeek where PackageID = " & PackageIDarray(i) 
strBody = strBody & "<tr><td colspan ='6'>sql3=" & sql3 & "</td></tr>" & vbCrLf
	rs3.Open sql3, connStats, 3, 3   	
	If Not rs3.eof then			
		'response.write(rs3.recordcount)
		TotalHitsThisWeek =  TotalHitsThisWeek + rs3.recordcount
	Else
		'response.write("0")									
	End If 
rs3.close

strBody = strBody & "<tr><td class = 'body' align = 'left' colspan = '2'><a href='http://www.livestockofamerica.com/ranches/RanchPackageDetails.asp?packageid=" & PackageIDarray(i) & "&CurrentPeopleID=" & PeopleID & "' class=  'body' target='blank'><font size = '2'>" & PackageNamearray(i) & "</font></a></td>" & vbCrLf
strBody = strBody & "<td class = 'body' colspan = '2'><div align = 'right'>" & formatcurrency(PackagePricearray(i),0) & "<img src = 'http://www.livestockofamerica.com/images/px.gif' width= '20' height = '1'></div></td>" & vbCrLf
strBody = strBody & "<td class = 'body' colspan = '2'><div align = 'right'>" & TotalHitsThisWeek & "<img src = 'http://www.livestockofamerica.com/images/px.gif' width= '100' height = '1'></div></td>" & vbCrLf
strBody = strBody & "<td class = 'body'>" &  "</td> </tr>" & vbCrLf
end if
next
end if

strBody = strBody & "<tr><td colspan = '6'><br><br>To log into your account go to <a href = 'http://www.LivestockOfAmerica.com/Login.asp' class = 'body' target='blank'><font size = '1'>http://www.LivestockOfAmerica.com/Login.asp</font></a><br><br>" & vbCrLf


strBody = strBody & "<tr><td colspan = '6'><table border = 0 cellpadding = 0 cellspacing = 0>" & vbCrLf


strBODY= strBODY & "<tr><td bgcolor = 'white' colspan = '6'><a href ='http://www.theandresengroup.com'><img src = 'http://www.LivestockOfAmerica.com/Images/LOALogo.jpg' width = '299' height = '90' align = 'left' border = '0' /></a></td>"  & vbCrLf 

strBODY= strBODY & "<td align = 'left' class = 'body'><DIV ALIGN ='right'>Follow us on <a href='https://twitter.com/LivestockOfAmer  ><img src = 'http://www.LivestockOfAmerica.com/images/Twitter_Logo.jpg' border = '0' width = '22' height = '22' alt = 'Livestock Of America on twitter' /></a><a href = 'https://www.facebook.com/LivestockOfAmerica' ><img src = 'http://www.LivestockOfAmerica.com/images/Facebook_Logo.jpg' border = '0' width = '22' height = '22' alt = 'Livestock Of America on Facebook' /></a> </div>"  & vbCrLf 
strBODY= strBODY & "<br>To insure you receive account notifications, please add Statistics@LivestockOfAmerica.com to your email contacts/preferred senders list." & vbCrLf   
strBODY= strBODY & "<br><br><a href = 'http://www.LivestockOfAmerica.com/UnsubscribeStatusEmails.asp' class = 'body'><font size ='2'>Click here</font></a> to unsubscribe from our status emails." & vbCrLf   
strBODY= strBODY & "<br><br></font><CRLF><CRLF><br /></font></td></tr></table>" & vbCrLf  
strBODY= strBODY & "</td></tr></table></td></tr>"
strBODY= strBODY & "</table></td></tr></table></BODY></HTML>"  & vbCrLf 
response.write(strBODY)
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
if len(PeopleEmail) > 7 then     
'End remote SMTP server configuration section=
'response.write("PeopleEmail=" & PeopleEmail )     
if test = true then
ObjSendMail.To = "Statistics@LivestockOfAmerica.com"
else
'ObjSendMail.To = PeopleEmail
ObjSendMail.To = "Statistics@LivestockOfAmerica.com"
end if
'ObjSendMail.bcc = "john@theandresengroup.com"
'ObjSendMail.To =  "webartistsbiz@gmail.com"
ObjSendMail.Subject = "Weekly Statistics"
ObjSendMail.From =  "Livestock Of America <Statistics@LivestockOfAmerica.com>"


ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody


ObjSendMail.Send
end if
set objCDONTSmail = Nothing

end if
rs.movenext 
wend
rs.close
end if

set Conn = Nothing %>