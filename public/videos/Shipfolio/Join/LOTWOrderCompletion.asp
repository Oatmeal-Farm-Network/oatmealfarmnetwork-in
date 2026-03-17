<%@LANGUAGE="VBScript"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="author" content="Livestock of The World">
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
test = False
If test = True then
set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
 objHttp.open "POST", "https://ipnpb.sandbox.paypal.com/cgi-bin/webscr", false 
 objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
else
set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
 objHttp.open "POST", "https://ipnpb.paypal.com/cgi-bin/webscr", false 
 objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
 end if
'objHttp.Send str
 
Status = "INVALID"
' Check notification validation
'if (objHttp.status <> 200 ) then
'if Status = "INVALID" then
' HTTP error handling
'elseif (objHttp.responseText = "VERIFIED") then
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

'elseif (objHttp.responseText = "INVALID") then
' log for manual investigation
'else
' error
'end if
set objHttp = nothing


AdministrationPath = "/Administration"
WebSiteName = "Livestock Of The World"
PhysicalPath = "C:\inetpub\wwwroot\ "
Slogan = ""
BorderColor = "#ebebeb"
Style = "Style.css"
Showsearch = True

'**************************************************************
 ' Hard Coded Variables
'**************************************************************
Slogan = ""
BorderColor = "#ebebeb"

'**************************************************************
 ' Define Conn Object
'**************************************************************
 DSN_Name = "LOADB2"
%>
<!--#Include virtual="/Conn.asp"-->
<%
Set rs = Server.CreateObject("ADODB.Recordset")
Dim TempEventID, TempPeopleID
if test = True then
'custom = "4723"
end if
PeopleID = custom
 

if len(Payment_amount) < 1 then
  Payment_amount = "0"
end if  
	
	
Query =  "Select Account, TempMinusAccount, ReferringPeopleID, BusinessName, peopleid From People, Business where People.BusinessId = Business.BusinessID order by PeopleID desc" 
rs.Open Query, conn, 3, 3
if not rs.eof then 
Account = rs("Account")
TempMinusAccount = rs("TempMinusAccount")
'ReferringPeopleID = rs("ReferringPeopleID")
BusinessName = rs("BusinessName")
PeopleID = rs("PeopleID")
end if
rs.close



Query =  "Update People set TempMinusAccount = 0,"
Query = Query & " custAIStartService ='" & FormatDateTime(now,2) & "', "
Query = Query & " custAIEndService ='" & FormatDateTime(DateAdd("m",18, now ),2) & "', "
Query = Query & " accesslevel= 1"
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
CustCountry = rs("CustCountry")
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



Query =  "INSERT INTO EmailList (Address, Emailbusiness, ReceiveEmails)" 
Query =  Query & " Values ('" & Peopleemail & "', '" & Business & "', 1 )" 

'response.write("Query=" & Query )
Conn.Execute(Query) 


strSubject = "Your Livestock of The World Membership has been Created"

strBody = "<font face='arial'>Dear " & PeopleFirstName & ",<br>" & vbCrLf 
strBody  = strBody &  "This e-mail has been sent to you from www.LivestockOfTheWorld.com." & vbCrLf 
strBody = strBody & "<br>Your new account with Livestock of The world has been successfully created.<br><br>" & vbCrLf 
strBody = strBody & "Thank you for registering with us.<br><br>"& vbCrLf 
strBody = strBody & "To get started go to: "& vbCrLf 
strBody = strBody & "<a href = 'https://www.livestockoftheworld.com/Login.asp?PeopleID=" & PeopleID & "'> http://www.livestockoftheworld.com/Login.asp" & PeopleID & "</a><br>"& vbCrLf 
strBody = strBody & "(If the link does not work then copy and paste the link into your web browser).<br><br>"& vbCrLf 

strBody = strBody & "If you have any questions please <a href = 'https://www.LivestockOftheWorld.com/ContactUs.asp' >contact us </a> and let us know.<br><br>" & vbCrLf 
strBody = strBody & "Thank you for joining Livestock Of The World. </font><br><BR><BR>"& vbCrLf 

strBody = strBody & "<img src='https://www.LivestockofTheWorld.com/images/LOTWLogo.jpg' width=299  align = 'left'>" & vbCrLf 


'response.write(strBody)



Dim iMsg1  
Dim iConf1  
Dim Flds1
Dim strHTML1 
dim sch1 : sch1 = "http://schemas.microsoft.com/cdo/configuration/"  
Dim iBP1 
set iMsg1 = CreateObject("CDO.Message")  
set iConf1 = CreateObject("CDO.Configuration")  
Set Flds1 = iConf1.Fields   
'Const cdoSendUsingPickup = 1
'Const cdoSendUsingPort = 2
'Const cdoAnonymous = 0 
'Const cdoBasic = 1 
'Const cdoNTLM = 2  
With Flds1  
 .Item(sch1 & "sendusing") = 2
  .Item(sch1 & "smtpserver") = "smtp.sendgrid.net"
  '.Item(sch & "smtphost") = "smtp.sendgrid.net"
 .Item(sch1 & "smtpserverport") =465
 .Item(sch1 & "smtpconnectiontimeout") = 30
 .item(sch1 & "smtpauthenticate") = 1 'basic auth
 .item(sch1 & "smtpusessl") = True
 .item(sch1 & "sendusername") = "apikey"
 .item(sch1 & "sendpassword") = "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"


 .Update
End With 
' Build HTML for message body.  
  
  if test = true then
  strTo = "Contactus@livestockoftheworld.com"
   else
    strTo = Peopleemail
  end if

  
'response.write("strTo=" & strTo ) 
With iMsg1  
 Set .Configuration = iConf1
 .To = strTo
.Bcc= "ContactUs@LivestockOfTheWorld.com"
.From =  "Livestock Of The World <ContactUs@LivestockOfTheWorld.com>"
 'ObjSendMail.To = "andresengroup@yahoo.com"
 .Subject =  strSubject
 .HTMLBody = strBody
 .Send
End With

' Clean up variables.  
Set iBP1 = Nothing  
Set iMsg1 = Nothing  
Set iConf1 = Nothing  
Set Flds1 = Nothing  




%>
</body>
</html>