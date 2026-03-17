<%@LANGUAGE="VBScript"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="style.css">

</Head>
<body>	
<%
'Option Explicit 
Dim objHttp, str
Dim Item_name 
Dim  Item_number
Dim  Payment_status
Dim Payment_amount 
Dim Payment_currency
Dim Txn_id 
Dim Receiver_email 
Dim Payer_email
Dim Business
Dim address_city
Dim address_country
Dim address_country_code
Dim address_name
Dim address_state
Dim address_status
Dim address_street
Dim address_postcode
Dim first_name
Dim last_name
Dim payer_id
Dim payer_status
Dim contact_phone
Dim residence_country
Dim xDb_Conn_Str
Dim Status
Dim custom
Dim shipping
dim quantity1
dim quantity2
dim quantity3
dim quantity4
dim quantity5
dim  Item_name1
dim  Item_name2
' read post from PayPal system and add 'cmd'
str = Request.Form & "&cmd=_notify-validate"

' post back to PayPal system to validate
set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
' set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.4.0")
' set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
test = True
If test = True then
objHTTP.Open "POST", "https://www.sandbox.paypal.com/cgi-bin/webscr" , false
 objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
else
objHttp.open "POST", "https://www.paypal.com/cgi-bin/webscr", false
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"

 end if

objHttp.Send str
 
Status = "INVALID"
'test = True
' Check notification validation
if (objHttp.status <> 200 ) then
' HTTP error handling
elseif (objHttp.responseText = "VERIFIED") then
Status = "VERIFIED"
' check that Payment_status=Completed
' check that Txn_id has not been previously processed
' check that Receiver_email is your Primary PayPal email
' check that Payment_amount/Payment_currency are correct
' process payment
'assign posted variables to local variables

Item_name1 = Request.Form("Item_name1")
Item_name2 = Request.Form("Item_name2")
Item_name3 = Request.Form("Item_name3")
Item_name4 = Request.Form("Item_name4")
Item_name5 = Request.Form("Item_name5")
Item_name6 = Request.Form("Item_name6")
Item_name7 = Request.Form("Item_name7")
Item_name8 = Request.Form("Item_name8")
Item_name9 = Request.Form("Item_name9")
Item_name10 = Request.Form("Item_name10")
quantity1 = Request.Form("quantity1")
quantity2 = Request.Form("quantity2")
quantity3 = Request.Form("quantity3")
quantity4 = Request.Form("quantity4")
quantity5 = Request.Form("quantity5")
quantity6 = Request.Form("quantity6")
quantity7 = Request.Form("quantity7")
quantity8 = Request.Form("quantity8")
quantity9 = Request.Form("quantity9")
quantity10 = Request.Form("quantity10")

 Item_number = Request.Form("item_number")
 Payment_status = Request.Form("payment_status")
 Payment_amount = Request.Form("mc_gross")
 Payment_currency = Request.Form("mc_currency")
 Txn_id = Request.Form("txn_id")
 Receiver_email = Request.Form("receiver_email")
 Payer_email = Request.Form("payer_email")
Business= Request.Form("payer_business_name")
address_city= Request.Form("address_city")
address_country= Request.Form("address_country")
address_country_code= Request.Form("address_country_code")
address_name= Request.Form("address_name")
address_state= Request.Form("address_state")
address_status= Request.Form("address_status")
address_street= Request.Form("address_street")
address_postcode= Request.Form("address_postal_code")
first_name= Request.Form("first_name")
last_name= Request.Form("last_name")
payer_id= Request.Form("payer_id")
payer_status= Request.Form("payer_status")
contact_phone= Request.Form("contact_phone")
residence_country= Request.Form("residence_country")
custom= Request.Form("custom")
Invoice= Request.Form("Invoice")

elseif (objHttp.responseText = "INVALID") then
' log for manual investigation
else
' error
end if
set objHttp = nothing


AdministrationPath = "/Administration"
WebSiteName = " Camelid Quarterly"
PhysicalPath = "e:\inetpub\wwwroot\Internet-host\johnandmom\andresenevents.com\www\"
Slogan = ""
BorderColor = "#ebebeb"
Style = "Style.css"
Showsearch = True

'**************************************************************
 ' Hard Coded Variables
'**************************************************************
Slogan = ""
BorderColor = "#ebebeb"

%>
<!--#Include virtual="/Conn.asp"-->

<%
Set rs = Server.CreateObject("ADODB.Recordset")
Dim TempEventID, TempPeopleID
if test = True then
'custom = "1016"
end if
'custom = "1016"
PeopleID = custom
 'response.write("custom=" & custom & "<br>")


 'response.write("last_name=" & last_name & "<br>")
 
if len(Payment_amount) < 1 then
  Payment_amount = "0"
end if  
	
if len(PeopleID) > 0 then

Query =  "Select CQEndDate, CQStartdate,  custAIStartService, custAIEndService,   Account, TempMinusAccount, ReferringPeopleID, BusinessName, PeopleID From People, Business where People.BusinessId = Business.BusinessID and peopleid = " & PeopleID & " order by PeopleID Desc" 
else
Query =  "Select CQEndDate, CQStartdate,  custAIStartService, custAIEndService,   Account, TempMinusAccount, ReferringPeopleID, BusinessName, PeopleID From People, Business where People.BusinessId = Business.BusinessID order by PeopleID Desc" 
end if

'response.write("Query=" & Query)
rs.Open Query, conn, 3, 3
if not rs.eof then 
Account = rs("Account")
TempMinusAccount = rs("TempMinusAccount")
ReferringPeopleID = rs("ReferringPeopleID")
BusinessName = rs("BusinessName")
PeopleID = rs("PeopleID")
CQEndDate = rs("CQEndDate")
CQStartdate = rs("CQStartdate")
custAIStartService = rs("custAIStartService")
custAIEndService = rs("custAIEndService")

end if
rs.close

if len(ReferringPeopleID) > 0 then
Query =  "Select business.BusinessName, People.peopleEmail, peopleFirstname,  custAIEndService from People, Business where People.BusinessId = Business.BusinessID and  PeopleID=" & ReferringPeopleID
rs.Open Query, conn, 3, 3
	if not rs.eof then 
      ReferringBusinessName = rs("BusinessName")
      ReferringPeopleEmail = rs("peopleEmail")
      ReferringPeopleFirstName = rs("peopleFirstName")
      custAIEndService = rs("custAIEndService")
	end if
rs.close
Query =  "Update People set custAIEndService ='" &  DateAdd("m", 2, custAIEndService ) & "'"
Query = Query & " where PeopleID=" & ReferringPeopleID
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if
'response.write("CQEndDate1= " & CQEndDate )
if CQEndDate = "0000-00-00" then
CQEndDate =FormatDateTime(now, 2)
end if


if CQStartDate = "0000-00-00" then
CQStartDate =FormatDateTime(now, 2)
end if

if custAIStartService = "0000-00-00" then
custAIStartService = FormatDateTime(now, 2)
end if
if custAIEndService = "0000-00-00" then
custAIEndService = FormatDateTime(now, 2)
end if

difference = datediff("d", now, CQEndDate )
'response.write("difference= " & cint(difference) )

if cint(datediff("d", now, CQEndDate )) < 0 then
CQEndDate = FormatDateTime(DateAdd("yyyy",1, now), 2)
'response.write("CQEndDate3= " & CQEndDate & "<br>")

else
CQEndDate = FormatDateTime(DateAdd("yyyy",1, CQEndDate), 2)
end if


if len(CQStartdate) > 0 then
else
CQStartdate = FormatDateTime(now, 2)
end if

if len(custAIStartService) > 0 then
else
custAIStartService = FormatDateTime(now, 2)
end if

if datediff("d", now, custAIEndService ) < 0 then
custAIEndService = FormatDateTime(DateAdd("yyyy",1, now), 2)
else
custAIEndService = FormatDateTime(DateAdd("yyyy",1, custAIEndService), 2)
end if


Query =  "Update People set TempMinusAccount = 0,"
Query = Query & " custAIStartService ='" & custAIStartService & "', "
Query = Query & " custAIEndService= '" & custAIEndService & "', "
Query = Query & " CQEndDate ='" & CQEndDate & "', "
Query = Query & " CQStartdate ='" & CQStartdate & "', "
Query = Query & " accesslevel= 1 , "
Query = Query & " CQstatus= 'Active'"
Query = Query & " where PeopleID=" & PeopleID 
'response.write("Query=" & Query )
Conn.Execute(Query) 



For x=1 To 8 
Randomize
' select a number between 26 and 97
random_number =  Int(26 * Rnd + 97)

' take the numeric and turn it into a character
random_letter = UCase(Chr(random_number))
ActivationCode = ActivationCode & random_letter

Next
ActivationCode = day(now) & month(now) & Year(now) & ActivationCode & Left(TempLastName, 1)

'get PeopleID
sql = "SELECT * from People where  PeopleID = " & PeopleID  

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
	PeopleEmail = rs("PeopleEmail")
	PeopleFirstName = rs("PeopleFirstName")
	SubscriptionLevel = rs("SubscriptionLevel")

if SubscriptionLevel = 4 then 
    referralamount = 10
    End If
end if
	rs.close

Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
	Query =  Query & " WebsitesID = " &  WebsitesID & "," 
	Query =  Query & " AISubscription  = True ," 
	Query =  Query & " AESubscription  = True ," 
	Query =  Query & " PeopleTitleID  = " &  PeopleTitleID & "," 
    Query =  Query & " PeopleFirstName = '" &  PeopleFirstName & "'," 
    Query =  Query & " PeopleLastName = '" &  PeopleLastName & "'," 
    Query =  Query & " PeoplePhone = '" &  PeoplePhone & "'," 
    Query =  Query & " Peopleemail = '" &  Peopleemail & "'," 
    Query =  Query & " Peoplefax = '" &  Peoplefax & "',"
    Query =  Query & " PeopleCell = '" &  PeopleCell & "',"
    Query =  Query & " Peoplepassword = '" &  password & "'" 
    Query =  Query & " where PeopleID = " & PeopleID & ";" 
    
    
Query =  " UPDATE People Set ActivationCode='" & ActivationCode & "'" 
Query =  Query & " where PeopleID = " & PeopleID & ";" 

Conn.Execute(Query) 


Query =  "INSERT INTO RanchPages (PageBackgroundColor, ScreenBackgroundColor, AnimalListbackgroundColor, TitleColor, TitleFont,TitleSize, MenuBackgroundColor, MenuColor, MenuSize, MenuFont, MenuFontMouseOverColor, PageTextFont, PageTextColor, PageTextFontSize, PageTextHyperlinkColor, PageTextMouseOverColor, LayoutStyle,     PeopleID)" 
Query =  Query & " Values ('AntiqueWhite'," 
Query =  Query & " 'White'," 
Query =  Query & " 'White'," 
Query =  Query & " 'Black'," 
Query =  Query & "'Arial, san-serif'," 
Query =  Query & " '24',"
Query =  Query & " 'BurlyWood',"
Query =  Query & " 'Cornsilk',"
Query =  Query & " '11',"
Query =  Query & " 'Arial, san-serif',"
Query =  Query & " 'White',"
Query =  Query & " 'Arial, san-serif',"
Query =  Query & " 'Black'," 
Query =  Query & " '11',"
Query =  Query & " 'Blue',"
Query =  Query & " 'Black',"
Query =  Query & " 'Portrait',"
Query = Query & " " &  PeopleID & ")"

Conn.Execute(Query) 


Query =  "INSERT INTO RanchSiteDesign (TitleColor, TitleFont, TitleSize, TitleWeight,  PeopleID)" 
Query =  Query & " Values ('Black'," 
Query =  Query & "'Verdana, Arial, san-serif'," 
Query =  Query & " '12',"
Query =  Query & " 'Normal',"
Query = Query & " " &  PeopleID & ")"

Conn.Execute(Query) 



Query =  "INSERT INTO sfEmailLists (PeopleID, Emailtype,  EmailIsSubscribed)" 
	Query =  Query & " Values (" &  PeopleID & ","
	Query =  Query &   " 'AINews ',"
	Query =  Query &   " True )" 
	
Conn.Execute(Query) 

Set ObjSendMail = CreateObject("CDO.Message") 
smtpServer = "mail.AlpacaInfinity.com"
ObjSendMail.From =  " Camelid Quarterly <pacamail@theandresengroup.com>"
strSubject = "Your Camelid Quarterly Subscription"

strBody = "<font face='arial'>Dear " & PeopleFirstName & ",<br>" & vbCrLf 
strBody  = strBody &  " custom= " & custom & " Status=" & Status & " This e-mail has been sent to you from http://www.CamelidQuarterly.com." & vbCrLf 
strBody = strBody & "<br>Your subscription with Camelid Quarterly is now active.<br><br>" & vbCrLf 
strBody = strBody & "Thank you for signing up with us.<br>"& vbCrLf 
strBody = strBody & "If you have any questions please <a href = 'http://www.CamelidQuarterly.com/ContactUs.asp' >contact us </a> and let us know.<br><br>" & vbCrLf 
strBody = strBody & "Thank you for choosing Camelid Quarterly! </font>"& vbCrLf 

'response.write(strBody)


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
     
'End remote SMTP server configuration section==
     
'ObjSendMail.To = PeopleEmail
ObjSendMail.To= "john@andresengroup.com"
'ObjSendMail.Bcc= "admin@camelidquarterly.com"
ObjSendMail.Subject = strSubject
ObjSendMail.From =  " Camelid Quarterly <admin@camelidquarterly.com>"

ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
ObjSendMail.Send
set objCDONTSmail = Nothing

%>
</body>
</html>