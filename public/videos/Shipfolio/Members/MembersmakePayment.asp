<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Alpaca Infinity Advertising Administration</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />


</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
      <% 
   Current2="Advertising"
   Current3="AddAdvertising" %> 
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include virtual="/Header.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include virtual="/adminHeader.asp"-->
   <br /> 


 <%  '	TempMinusAccount
PeopleID= Request.Form("PeopleID")
Item_name1 = Request.Form("Item_name_1")
Item_name2 = Request.Form("Item_name_2")
Item_name3 = Request.Form("Item_name_3")
Item_name4 = Request.Form("Item_name_4")
Item_name5 = Request.Form("Item_name_5")
Item_name6 = Request.Form("Item_name_6")
Item_name7 = Request.Form("Item_name_7")
Item_name8 = Request.Form("Item_name_8")
Item_name9 = Request.Form("Item_name_9")
Item_name10 = Request.Form("Item_name_10")
quantity1 = Request.Form("quantity_1")
quantity2 = Request.Form("quantity_2")
quantity3 = Request.Form("quantity_3")
quantity4 = Request.Form("quantity_4")
quantity5 = Request.Form("quantity_5")
quantity6 = Request.Form("quantity_6")
quantity7 = Request.Form("quantity_7")
quantity8 = Request.Form("quantity_8")
quantity9 = Request.Form("quantity_9")
quantity10 = Request.Form("quantity_10")

Query =  "Select Account, TempMinusAccount From People where PeopleID=" & PeopleID 
rs.Open Query, conn, 3, 3
	if not rs.eof then 
	  Account = rs("Account")
	  TempMinusAccount = rs("TempMinusAccount")
	end if
rs.close



Query =  "Update People set TempMinusAccount = 0,"
Query = Query & " Account =" & Account - TempMinusAccount & " "
Query = Query & " where PeopleID=" & PeopleID 
Conn.Execute(Query) 

Query =  " UPDATE Ads Set AdPaidFor = True , " 
Query =  Query & " AdPaidDate = '" & now  & "' " 
Query =  Query & " where PeopleID = " & PeopleID & ";" 

	'response.Write("query=" & query)
	Conn.Execute(Query) 



'response.Write("quantity1=" & quantity1 )
'response.Write("Item_name1=" & Item_name1 )
if cint(quantity1) > 0 and Item_name1 = "Purple Level Dutch Auctions" then
Purplequantity = quantity1
q = 1
while q < (quantity1 + 1)
    Query =  "INSERT INTO AuctionDutch (AuctionLevel, PeopleID ) values ("
    Query =  Query &  " 'Purple'," 
     Query =  Query &  " '" & PeopleID & "')"
    Conn.Execute(Query) 
q = q + 1
wend
end if


if (quantity1 > 0 and Item_name1 = "Blue Level Dutch Auctions") then
    Bluequantity = quantity1
end if

if (quantity2 > 0 and Item_name2 = "Blue Level Dutch Auctions") then
    Bluequantity = quantity2
end if

if (quantity3 > 0 and Item_name3 = "Blue Level Dutch Auctions") then
    Bluequantity = quantity3
end if
if (quantity4 > 0 and Item_name4 = "Blue Level Dutch Auctions") then
    Bluequantity = quantity4
end if

if Bluequantity > 0 then
q = 1
while q < (Bluequantity + 1)
    Query =  "INSERT INTO AuctionDutch (AuctionLevel, PeopleID ) values ("
    Query =  Query &  " 'Blue'," 
     Query =  Query &  " '" & PeopleID & "')" 
    Conn.Execute(Query) 
q = q + 1
wend
end if


if (quantity1 > 0 and Item_name1 = "Red Level Dutch Auctions") then
    Redquantity = quantity1
end if

if (quantity2 > 0 and Item_name2 = "Red Level Dutch Auctions") then
    Redquantity = quantity2
end if

if (quantity3 > 0 and Item_name3 = "Red Level Dutch Auctions") then
    Redquantity = quantity3
end if
if (quantity4 > 0 and Item_name4 = "Red Level Dutch Auctions") then
   Redquantity = quantity4
end if

if Redquantity > 0 then
q = 1
while q < (Redquantity + 1)
    Query =  "INSERT INTO AuctionDutch (AuctionLevel, PeopleID ) values ("
    Query =  Query &  " 'Red'," 
     Query =  Query &  " '" & PeopleID & "')" 

    Conn.Execute(Query) 
q = q + 1
wend
end if


if (quantity1 > 0 and Item_name1 = "Yellow Level Dutch Auctions") then
    Yellowquantity = quantity1
end if

if (quantity2 > 0 and Item_name2 = "Yellow Level Dutch Auctions") then
    Yellowquantity = quantity2
end if

if (quantity3 > 0 and Item_name3 = "Yellow Level Dutch Auctions") then
   Yellowquantity = quantity3
end if
if (quantity4 > 0 and Item_name4 = "Yellow Level Dutch Auctions") then
    Yellowquantity = quantity4
end if

if (quantity4 > 0 and Item_name5 = "Yellow Level Dutch Auctions") then
    Yellowquantity = quantity5
end if
if Yellowquantity > 0 then
q = 1
while q < (Yellowquantity + 1)
    Query =  "INSERT INTO AuctionDutch (AuctionLevel, PeopleID ) values ("
    Query =  Query &  " 'Yellow'," 
     Query =  Query &  " '" & PeopleID & "')" 
    Conn.Execute(Query) 
q = q + 1
wend
end if

	

'response.Write("strBody=" & strBody)

strBody="<html><head><div dir='ltr' lang='en-us' class='OutlookMessageHeader' align='left'><meta name='GENERATOR' content='MSHTML 8.00.6001.18259' />" & vbCrLf 
strBody= strBody & "<style type='text/css'>BODY {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px}A {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: brown; FONT-SIZE: 11px; TEXT-DECORATION: none}A:visited {COLOR: #666666}A:hover {TEXT-DECORATION: underline}P {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #666666; FONT-SIZE: 11px; FONT-WEIGHT: normal; TEXT-DECORATION: none}H1 {FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #666666; FONT-SIZE: 14px; FONT-WEIGHT: bold; TEXT-DECORATION: none}DIV.emailfooter {FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; FONT-SIZE: 11px }DIV.emailfooter A {	FONT-STYLE: normal; FONT-FAMILY: verdana, sans-serif; COLOR: #ff6600; FONT-SIZE: 11px; TEXT-DECORATION: none}</style>" & vbCrLf 

strBody= strBody & "</head><body><table width='600' border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'left'  valign ='top'><tbody>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left' width ='120'> Item_name2</td><td align = 'left'>" & Item_name2  & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>PeopleID</td><td align = 'left'>" & Item_number  & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>Payment_status</td><td align = 'left'>" & PeopleID  & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>Payment_amount</td><td align = 'left'>" & Payment_amount  & "</td></tr>"  & vbCrLf 
 strBody= strBody & "<tr><td align = 'left'>Payment_currency</td><td align = 'left'>" & Payment_currency  & "</td></tr>"  & vbCrLf 
 strBody= strBody & "<tr><td align = 'left'>Txn_id</td><td align = 'left'>" & Txn_id  & "</td></tr>"  & vbCrLf 
 strBody= strBody & "<tr><td align = 'left'>Receiver_email</td><td align = 'left'>" & Receiver_email  & "</td></tr>"  & vbCrLf 
 strBody= strBody & "<tr><td align = 'left'>Payer_emai</td><td align = 'left'>" & Payer_email & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>Business</td><td align = 'left'>" & Business & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_city</td><td align = 'left'>" & address_city & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_country</td><td align = 'left'>" & address_country & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_country_code</td><td align = 'left'>" & address_country_code & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_name</td><td align = 'left'>" & address_name & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_state</td><td align = 'left'>" & address_state & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_status</td><td align = 'left'>" & address_status & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_street</td><td align = 'left'>" & address_street & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>address_postcode</td><td align = 'left'>" & address_postcode & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>first_name</td><td align = 'left'>" & first_name & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>last_name</td><td align = 'left'>" & last_name & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>payer_id</td><td align = 'left'>" & payer_id & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>payer_status</td><td align = 'left'>" & payer_status & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>contact_phone</td><td align = 'left'>" & contact_phone & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>residence_country</td><td align = 'left'>" & residence_country & "</td></tr>"  & vbCrLf 

strBody= strBody & "<tr><td align = 'left' colspan ='2'>Auctions</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'>Purple level QTY</td><td align = 'left'>" &  Purplequantity & "</td></tr>"  & vbCrLf 
 strBody= strBody & "<tr><td align = 'left'>Blue level QTY</td><td align = 'left'>" &  Bluequantity & "</td></tr>"  & vbCrLf 
 strBody= strBody & "<tr><td align = 'left'>Red level QTY</td><td align = 'left'>" &  Redquantity & "</td></tr>"  & vbCrLf 
 strBody= strBody & "<tr><td align = 'left'>Yellow level QTY</td><td align = 'left'>" &  Yellowquantity & "</td></tr>"  & vbCrLf 
  strBody= strBody & "<tr><td align = 'left'> " & Item_name1 & "</td><td align = 'left'>" &  quantity1 & "</td></tr>"  & vbCrLf 
  strBody= strBody & "<tr><td align = 'left'> " & Item_name2 & "</td><td align = 'left'>" &  quantity2 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name3 & "</td><td align = 'left'>" &  quantity3 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name4 & "</td><td align = 'left'>" &  quantity4 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name5 & "</td><td align = 'left'>" &  quantity5 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name6 & "</td><td align = 'left'>" &  quantity6 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name7 & "</td><td align = 'left'>" &  quantity7 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name8 & "</td><td align = 'left'>" &  quantity8 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name9 & "</td><td align = 'left'>" &  quantity9 & "</td></tr>"  & vbCrLf 
strBody= strBody & "<tr><td align = 'left'> " & Item_name10 & "</td><td align = 'left'>" &  quantity10 & "</td></tr>"  & vbCrLf 
 
strBody= strBody & "</td></tr></tbody></table>" & vbCrLf  

strBody= strBody & "</BODY></HTML>"  & vbCrLf 

strSubject = "Alpacas Infinity Order Completed"
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="mail.theandresengroup.com" 'your mail server
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
     
' If your server requires outgoing authentication uncomment the lines below and use a valid email address and password.
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") ="pacamail@theandresengroup.com"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") ="Jackson5"
     
ObjSendMail.Configuration.Fields.Update
     
'End remote SMTP server configuration section=
     
'ObjSendMail.To = strTo
ObjSendMail.To = "john@theandresengroup.com"
'ObjSendMail.bcc = "andresengroup@yahoo.com"
'ObjSendMail.To =  "webartistsbiz@gmail.com"
ObjSendMail.Subject = strSubject
ObjSendMail.From =  "TheAndresenGroup <pacamail@theandresengroup.com>"
     
' we are sending a text email.. simply switch the comments around to send an html email instead

ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
'response.Write(strBody)  
ObjSendMail.Send
     
Set ObjSendMail = Nothing 
	Conn.Close
	Set Conn = Nothing
%>

 <!--#Include file="AdminAdvertisingTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Purchase Completed</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "left">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "900"><tr><td class = "body" >

<center><h3><b>Your advertising purchase has been subtracted from your Advertising Account.</h3></b></center><br />
Select <a href = "advertisinghome.asp" class = "body" target="_top">Your Advertisements</a> to upload your advertising artwork. 

<br /><br /><br /><br />

<b>Graphic Design:</b> Advertising prices do not include graphic design. If you need assistance with designing your ads, <a href = "http://www.TheAndresenGroup.com" target = "blank" class = "body">The ANDRESEN<b>GROUP</b></a> will be happy to help you at a rate of $70/hour.<br /><br />

<b>Right to Refusal:</b> <a href = "http://www.TheAndresenGroup.com" target = "blank" class = "body">The ANDRESEN<b>GROUP</b></a> (the owners of Alpaca Infinity) reserve the right to refuse any advertising artwork presented for any reason including offensive language or images.<br /><br />

        </td>
</tr>
</table>

</td>
</tr>
</table>
 <!--#Include virtual="/Footer.asp"-->
</BODY>
</HTML>