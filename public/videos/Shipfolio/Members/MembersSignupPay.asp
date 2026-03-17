<<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Alpaca Infinity Sign In</title>
<META name="description" content="Alpaca Infinity Login">
<META name="keywords" content="Alpaca Infinity Login, Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% Current = "Home" %>
<!--#Include virtual="Header.asp"--> 
<!--#Include virtual="HomeHeader.asp"--> 


/head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% Current = "Home" %>
<!--#Include virtual="Header.asp"--> 
<!--#Include virtual="HomeHeader.asp"--> 

<% membership = Request.querystring("membership") 

discount = 0
   '	TempMinusAccount
 
 test = False
  if test = True then%>
<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% else %>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% end if %>
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
    <input type="hidden" name="business" value="ContactUs@AlpacaInfinity.com">   
<input type="hidden" name="currency_code" value="US">



<% 
if PurpleDutchAuctions > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Purple Level Dutch Auctions">

 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=PurpleDutchAuctions %>">
 <% if Discount > 0 then %>
    <input type="hidden" name="amount_<%=itemcount %>" value="<%= 475-475*Discount/100 %>">
<% else %>
    <input type="hidden" name="amount_<%=itemcount %>" value="475">
<% end if %>
<% end if %>


<% 

if BlueDutchAuctions > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Blue Level Dutch Auctions">

 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=BlueDutchAuctions %>">
 <% if Discount > 0 then %>
    <input type="hidden" name="amount_<%=itemcount %>" value="<%= 355-355*Discount/100 %>">
<% else %>
    <input type="hidden" name="amount_<%=itemcount %>" value="355">
<% end if %>
<% end if %>


<% if RedDutchAuctions > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Red Level Dutch Auctions">
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=RedDutchAuctions %>">
 <% if Discount > 0 then %>
    <input type="hidden" name="amount_<%=itemcount %>" value="<%= 198-198*Discount/100 %>">
<% else %>
    <input type="hidden" name="amount_<%=itemcount %>" value="198">
<% end if %>
<% end if %>



<% if YellowDutchAuctions > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Yellow Level Dutch Auctions">

 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=YellowDutchAuctions %>">
 <% if Discount > 0 then %>
    <input type="hidden" name="amount_<%=itemcount %>" value="32">
<% else %>
    <input type="hidden" name="amount_<%=itemcount %>" value="98">
<% end if %>
<% end if %>



<% if TotalEmailOrder > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Mass Emails">
 <% if Discount > 0 then %>
<% if Emailquantity2 > 0 then %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 150-150*Discount/100 %>">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity1 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 150-150*Discount/100 %>">
<% end if %>
<% else %>
<% if Emailquantity2 > 0 then %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="140">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity1 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="140">
<% end if %>
<% end if %>

<% end if %>


<% if TotalMegaAds > 0 then 
   itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Mega Ad Combo">
 <% if Discount > 0 then %>
<input type="hidden" name="amount_<%=itemcount %>" value="<%= 355-355*Discount/100 %>">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="355">
<% end if %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%= TotalMegaAds%>"> 
<% end if %>


<% if TotalSkyscraperAds > 0 then 
   itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Skyscraper Ad">
 <% if Discount > 0 then %>
<input type="hidden" name="amount_<%=itemcount %>" value="<%= 95-95*Discount/100 %>">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="95">
<% end if %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%= TotalSkyscraperAds%>"> 
<% end if %>



<% if TotalBannerAds > 0 then 
   itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Banner Ad">
 <% if Discount > 0 then %>
<input type="hidden" name="amount_<%=itemcount %>" value="<%= 75-75*Discount/100 %>">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="75">
<% end if %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%= TotalBannerAds%>"> 
<% end if %>


<% if TotalLogoAds > 0 then 
   itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Logo Ad">
 <% if Discount > 0 then %>
<input type="hidden" name="amount_<%=itemcount %>" value="<%= 50-50*Discount/100 %>">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="50">
<% end if %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%= TotalLogoAds%>"> 
<% end if %>

<% if AccountSetupcount = "on" then 
   itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Professional Account Setup">
<% if Discount > 0 then %>
<input type="hidden" name="amount_<%=itemcount %>" value="99">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="150">
<% end if %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="1"> 
<% end if %>



<% if TotalAccountSetup2Order > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Additional Alpaca Entry">
 <% if Discount > 0 then %>
<% if AccountSetup2 > 0 then %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=AccountSetup2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 99-99*Discount/100 %>">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=AccountSetup2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 99-99*Discount/100 %>">
<% end if %>
<% else %>
<% if AccountSetup2 > 0 then %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=AccountSetup2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="99">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=AccountSetup2%>">
 <input type="hidden" name="amount_<%=itemcount %>" value="99">
<% end if %>
<% end if %>

<% end if %>

<% if WebRingcount = "on" then 
   itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="The Alpaca WebRing">
<% if Discount > 0 then %>
<input type="hidden" name="amount_<%=itemcount %>" value="<%= 62-62*Discount/100 %>">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="62">
<% end if %>
  <% end if %>


<% if Membershipcount > 0 then 
   itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value="Alpaca Infinity Membership">
<% if Discount > 0 then %>
<input type="hidden" name="amount_<%=itemcount %>" value="<%= 85-85*Discount/100 %>">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="85">
<% end if %>
  <% end if %>
  
  
<input name="custom" type="hidden" id="custom" value="<%=PeopleID %>"> 
<input type="hidden" name="return" value="http://www.AlpacaInfinity.com/Membersistration/Default.asp?FirstTime=True&PeopleID=<%=PeopleID %>">
<input type="hidden" name="cbt" value="Return to Alpaca Infinity">
<input type="hidden" name="cancel_return" value="http://www.alpacainfinity.com/AccountConfirmationStep2Return.asp?FirstTime=True&PeopleID=<%=PeopleID %>">
<input type="hidden" name="notify_url" value="http://www.theandresengroup.com/MembersAdOrderCompletion.asp">   
<input type="image" src="images/paynow.jpg" border="0" name="submit" >
 </form>


</td>
</tr>
</table>
<!--#Include virtual="/Footer.asp"-->
</BODY>
</HTML>