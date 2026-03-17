<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="framestyle.css" />

<SCRIPT LANGUAGE="JavaScript">
<!--    Begin
    function checkNumeric(objName, minval, maxval, comma, period, hyphen) {
        var numberfield = objName;
        if (chkNumeric(objName, minval, maxval, comma, period, hyphen) == false) {
            numberfield.select();
            numberfield.focus();
            return false;
        }
        else {
            return true;
        }
    }
    function chkNumeric(objName, minval, maxval, comma, period, hyphen) {
        // only allow 0-9 be entered, plus any values passed
        // (can be in any order, and don't have to be comma, period, or hyphen)
        // if all numbers allow commas, periods, hyphens or whatever,
        // just hard code it here and take out the passed parameters
        var checkOK = "0123456789$" + comma;
        var checkStr = objName;
        var allValid = true;
        var decPoints = 0;
        var allNum = "";

        for (i = 0; i < checkStr.value.length; i++) {
            ch = checkStr.value.charAt(i);
            for (j = 0; j < checkOK.length; j++)
                if (ch == checkOK.charAt(j))
                break;
            if (j == checkOK.length) {
                allValid = false;
                break;
            }
            if (ch != ",")
                allNum += ch;
        }
        if (!allValid) {
            alertsay = "Please enter only these values \""
            alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
            alert(alertsay);
            return (false);
        }

        // set the minimum and maximum
        var chkVal = allNum;
        var prsVal = parseInt(allNum);
        if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval)) {


        }
    }
//  End -->
</script>


</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariablesNoBackground.asp"-->
 <%
discount = 40
   '	TempMinusAccount
   
   TotalLogoAds=0
TotalBannerAds=0
TotalSkyscraperAds=0
TotalMegaAds=0
DutchAuctions = 0

   
  PayAgainstAccount = request.Form("PayAgainstAccount")
 'TotalOrder = request.Form("TotalOrder")
Complete = request.Form("Complete")
Current2="Advertising"
Current3="AlpacasHome" 
  
Query =  "Select Account From People where PeopleID=" & PeopleID 
rs.Open Query, conn, 3, 3
	if not rs.eof then 
	  CurrentAccount = rs("Account")
	end if
rs.close

dim LogoAdCheck(25)
dim BannerAdCheck(25)
dim SkyscraperAdCheck(25)
dim MegaAdCheck(25)
Updatetable="True"

if Updatetable="True" then
monthcounter =1



currentdate = dateadd("m", -1, now )

'if  PayAgainstAccount > TotalOrder then
'PayAgainstAccount = TotalOrder
'end if

if len(PayAgainstAccount)> 1 then
else
PayAgainstAccount = 0
end if

Query =  "Update People set TempMinusAccount =  " & PayAgainstAccount & " where PeopleID=" & PeopleID
Conn.Execute(Query) 

Query =  "delete * From Ads where PeopleID = " &  PeopleID & " and adWebsite = 'Livestock Of America' and AdPaidFor=False "
		Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>	
<!--#Include virtual="/Conn.asp"-->
<%


 if discount > 0 then 
    EmailPrice = formatcurrency(150 - 150*Discount/100,0) 
 else
    EmailPrice = formatcurrency(150,0) 
 end if 
Emailquantity1 = Request.Form("Emailquantity1")
EmailPrice = 99
TotalOrder = TotalOrder + (Emailquantity1 * EmailPrice)
TotalEmailOrder = Emailquantity1 * EmailPrice

 if discount > 0 then 
    EmailPrice2 = formatcurrency(99 - 99*Discount/100,0) 
 else
  EmailPrice2 = formatcurrency(99,0) 
 end if 
 
Emailquantity2 = Request.Form("Emailquantity2")
if Emailquantity2 > 0 then
Emailquantity1 = 0
TotalOrder = TotalOrder + (Emailquantity2 * EmailPrice2)
TotalEmailOrder = Emailquantity2 * EmailPrice2
end if


AccountSetup2Price  = 99
 if discount > 0 then 
    AccountSetup2Price = formatcurrency(99 - 99*Discount/100,0) 
    else
        AccountSetup2Price = formatcurrency(99,0) 
 end if 
AccountSetup2 = Request.Form("AccountSetup2")
TotalOrder = TotalOrder + (AccountSetup2 * AccountSetup2Price)
TotalAccountSetup2Order = AccountSetup2 * AccountSetup2Price




if discount > 0 then 
   AuctionPrice = formatcurrency(475 - 475*Discount/100,0) 
    else
    AuctionPrice = formatcurrency(475,0) 
 end if 

DutchAuctions = Request.Form("DutchAuctions")
response.write("DutchAuctions=" & DutchAuctions )
if len(DutchAuctions) > 0 then
    TotalDutchAuctionsOrder = AuctionPrice * DutchAuctions
    TotalOrder = TotalOrder + AuctionPrice * DutchAuctions
 else
 DutchAuctions = 0
end if


while Monthcounter < 14
	LogoAdCheckcount = "LogoAdCheck(" & monthcounter & ")"
	LogoAdCheck(monthcounter)=Request.Form(LogoAdCheckcount )
	BannerAdCheckcount = "BannerAdCheck(" & monthcounter & ")"
	BannerAdCheck(monthcounter)=Request.Form(BannerAdCheckcount )
	SkyscraperAdCheckcount = "SkyscraperAdCheck(" & monthcounter & ")"
	SkyscraperAdCheck(monthcounter)=Request.Form(SkyscraperAdCheckcount )
	MegaAdCheckcount = "MegaAdCheck(" & monthcounter & ")"
	MegaAdCheck(monthcounter)=Request.Form(MegaAdCheckcount )
	Monthcounter = Monthcounter +1
Wend

monthcounter =1
while Monthcounter < 14 
currentdate = dateadd("m", 1, currentdate )

%>
<% if LogoAdCheck(monthcounter) = "on" then
TotalLogoAds = TotalLogoAds + 1 
Query =  "INSERT INTO Ads (PeopleID, adWebsite, AdLinktoAIPage, AdMonth, AdYear, AdType, AdPaidFor, AdPublish)" 
Query =  Query & " Values (" &  PeopleID & "," 
Query =  Query & " 'Livestock Of America'," 
Query =  Query & " Yes," 
Query =  Query & " '" &  Month(currentdate)  & "'," 
Query =  Query & " '" & Year(currentdate)  & "'," 
Query =  Query & " 'Logo Ad'," 
Query = Query & " False, " 
Query = Query & " False)"
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>	
<!--#Include virtual="/Conn.asp"-->
 <% end if %>

<% if BannerAdCheck(monthcounter) = "on" then
TotalBannerAds = TotalBannerAds + 1 

%>
<%  
Query =  "INSERT INTO Ads (PeopleID, adWebsite, AdLinktoAIPage, AdMonth, AdYear, AdType, AdPaidFor, AdPublish)" 
		Query =  Query & " Values (" &  PeopleID & "," 
		Query =  Query & " 'Livestock Of America'," 
		Query =  Query & " Yes," 
		Query =  Query & " '" &  Month(currentdate)  & "'," 
		Query =  Query & " '" & Year(currentdate)  & "'," 
		Query =  Query & " 'Banner Ad'," 
		Query = Query & " False, " 
		Query = Query & " False)"

Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>	
<!--#Include virtual="/Conn.asp"-->
<%

 %>
 <% end if %>
 
 <% if SkyscraperAdCheck(monthcounter) = "on" then
TotalSkyscraperAds = TotalSkyscraperAds + 1 
addads = False
if peopleID = "1016"  and addads = True then
x = 0 
while x < 60
x = x + 1
Query =  "INSERT INTO Ads (PeopleID, adWebsite, AdLinktoAIPage, AdMonth, AdYear, AdType, AdPaidFor, AdPublish)" 
		Query =  Query & " Values (" &  PeopleID & "," 
		Query =  Query & " 'Livestock Of America'," 
		Query =  Query & " Yes," 
		Query =  Query & " '" &  Month(currentdate)  & "'," 
		Query =  Query & " '" & Year(currentdate)  & "'," 
		Query =  Query & " 'Skyscraper Ad'," 
		Query = Query & " True, " 
		Query = Query & " False)"
response.Write("Query=" & Query )
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>	
<!--#Include virtual="/Conn.asp"-->

<% wend
else
%>
<% 
Query =  "INSERT INTO Ads (PeopleID, adWebsite, AdLinktoAIPage, AdMonth, AdYear, AdType, AdPaidFor, AdPublish)" 
		Query =  Query & " Values (" &  PeopleID & "," 
		Query =  Query & " 'Livestock Of America'," 
		Query =  Query & " Yes," 
		Query =  Query & " '" &  Month(currentdate)  & "'," 
		Query =  Query & " '" & Year(currentdate)  & "'," 
		Query =  Query & " 'Skyscraper Ad'," 
		Query = Query & " False, " 
		Query = Query & " False)"

Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>	
<!--#Include virtual="/Conn.asp"-->
<%
end if
 %>
 <% end if %>
 
  <% if MegaAdCheck(monthcounter) = "on" then
TotalMegaAds = TotalMegaAds + 1 

%>
<%
Query =  "INSERT INTO Ads (PeopleID, adWebsite, AdLinktoAIPage, AdMonth, AdYear, AdType, AdPaidFor, AdPublish)" 
		Query =  Query & " Values (" &  PeopleID & "," 
		Query =  Query & " 'Livestock Of America'," 
		Query =  Query & " Yes," 
		Query =  Query & " '" &  Month(currentdate)  & "'," 
		Query =  Query & " '" & Year(currentdate)  & "'," 
		Query =  Query & " 'Mega Ad Combo'," 
		Query = Query & " False, " 
		Query = Query & " False)"
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>	
<!--#Include virtual="/Conn.asp"-->
<% end if %>
<% Monthcounter = Monthcounter +1
Wend
 if Complete = "Complete Order" then 

end if
end if

%>


<form  name=UpdateOrderForm method="post" action="MembersAuctionAddFrame.asp?Updatetable=True">
<table cellpadding= "0" border = 0 cellspacing = "0" width = "<%=screenwidth %>">
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "center" width = "270">
<h3>Type of Ad</h3></td>

<%

 if discount > 0 then %>
<td class = "body2" align = "center" width = "80">
<h3>Full Price</h3></td>
<td class = "body2" align = "center" width = "80">
<h3>Discount Price</h3></td>
<% else %>
<td class = "body2" align = "center">
<h3>Price</h3></td>
<% end if %>
<%
monthcounter =1
currentdate = dateadd("m", -1, now )
while Monthcounter < 14
currentdate = dateadd("m", 1, currentdate )
 %>
<td class = "body2" align = "center" width = "30">

<%= MonthName(Month(currentdate),true) %><br />
  <% = Year(currentdate) %>
</td>
<%
Monthcounter = Monthcounter + 1
wend 
 %>
<td class = "body2" align = "center" width = "90">
<h3>Total Price</h3></td>
</tr>
<% showlogoads = False
if  showlogoads =  True then%>
<tr>
<td class = "body" align = "left">

<a class="tooltip" href="#"><b>Logo Ad (180px X 50px):</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Logo Ad</em>Logo Ads are<b>180 pixels wide by 50 pixels high</b>. They appears on major pages throughout Livestock Of America and are displayed in a <b>pool of 60 ads</b>.</span></a>
</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$50/mo</strike>
<% else %>
<b>$50/mo</b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><%=formatcurrency(50 - 50*Discount/100,0) %>/mo</b>&nbsp;
</td>
<% end if %>
<%
monthcounter =1
currentdate = dateadd("m", -1, now )
while Monthcounter < 14
currentdate = dateadd("m", 1, currentdate )
 %>
<td class = "body" align = "center">
<%
  LogoAdsExisting =0 	
 
Set rs = Server.CreateObject("ADODB.Recordset")
Query =  "Select AdType from Ads  where adWebsite = 'Livestock Of America' and AdMonth= '" &  Month(currentdate)  & "' and AdYear= '" & Year(currentdate)  & "' and AdType='Logo Ad' and AdPaidFor=True" 

	rs.Open Query, conn, 3, 3
	while not rs.eof 
	 LogoAdsExisting = LogoAdsExisting + 1
	rs.movenext
	wend
%>
<% if LogoAdsExisting > 60 then %>

<img src = "images/SoldOut.jpg" border = "0" />


<% else %>

<% if LogoAdCheck(monthcounter) = "on" then %>
<input type="checkbox" name="LogoAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" checked>
<% else %>
<input type="checkbox" name="LogoAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" unchecked>
<% end if %>
<% end if %>
</td>
<%
Monthcounter = Monthcounter + 1
wend 
 %>

<td class = "body2" align = "right">
<% = formatcurrency(TotalLogoAds * (50-50*Discount/100), 2)%>
<% TotalOrder = TotalOrder + (TotalLogoAds * (50-50*Discount/100)) %>

</td>
</tr>
<% end if %>

<% showlbannerads = True
if  showlbannerads  =  True then%>
<tr>
<td class = "body" align = "left">

<a class="tooltip" href="#"><b>Header Ad (400px X 100px):</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Header Ad</em>Header Ads are <b>400 pixels wide by 100 pixels high</b>. They appears on major pages throughout Livestock Of America and are displayed in a <b>pool of only 40 ads</b>.</span></a>
</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$75/mo</strike>
<% else %>
<b>$75/mo</b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><%=formatcurrency(75 - 75*Discount/100,0) %>/mo</b>&nbsp;
</td>
<% end if %>
<%
monthcounter =1
currentdate = now
while Monthcounter < 14
currentdate = dateadd("m", 1, currentdate  ) 
 %>
<td class = "body" align = "center">
<%
  BannerAdsExisting =0 	
 
Set rs = Server.CreateObject("ADODB.Recordset")
Query =  "Select AdType from Ads  where not(PeopleID = 1016) and adWebsite = 'Livestock Of America' and AdMonth= '" &  Month(currentdate)  & "' and AdYear= '" & Year(currentdate)  & "' and AdType='Banner Ad' and AdPaidFor=True" 
	rs.Open Query, conn, 3, 3
	while not rs.eof 
	 BannerAdsExisting = BannerAdsExisting + 1
	rs.movenext
	wend
%>
<% if BannerAdsExisting > 100 then %>

<img src = "images/SoldOut.jpg" border = "0" />


<% else %>

<% if BannerAdCheck(monthcounter) = "on" then %>
<input type="checkbox" name="BannerAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" checked>
<% else %>
<input type="checkbox" name="BannerAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" unchecked>
<% end if %>
<% end if %>
</td>
<%
Monthcounter = Monthcounter + 1
wend 
 %>


<td class = "body2" align = "right">
<% = formatcurrency(TotalBannerAds * (75-75*Discount/100), 2)%>
<% TotalOrder = TotalOrder + (TotalBannerAds * (75-75*Discount/100)) %>

</td>
</tr>
<% end if %>
<% showSkyscrapperads = False
if  showSkyscrapperads  =  True then%>
<tr>
<td class = "body" align = "left">

<a class="tooltip" href="#"><b>Skyscraper Ad (150px X 250px):</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>skyscraper Ad</em>Grab attention with Skyscraper Ads. these ads are <b>150 pixels wide by 250 pixels high</b> and they appear prominently on major pages throughout Livestock Of America and are displayed in a <b>pool of only 35 ads!</b></span></a>
</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$95/mo</strike>
<% else %>
<b>$95/mo</b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><%=formatcurrency(95 - 95*Discount/100,0) %>/mo</b>&nbsp;
</td>
<% end if %>
<%
monthcounter =1
currentdate = now
while Monthcounter < 14
currentdate = dateadd("m", 1, currentdate )
 %>
<td class = "body" align = "center">
<%
  SkyscraperAdsExisting =0 	
 
Set rs = Server.CreateObject("ADODB.Recordset")
Query =  "Select AdType from Ads  where not(PeopleID = 1016) and adWebsite = 'Livestock Of America' and AdMonth= '" &  Month(currentdate)  & "' and AdYear= '" & Year(currentdate)  & "' and AdType='Skyscraper Ad' and AdPaidFor=True" 
	rs.Open Query, conn, 3, 3
	while not rs.eof 
	 SkyscraperAdsExisting = SkyscraperAdsExisting + 1
	rs.movenext
	wend
%>
<% if SkyscraperAdsExisting > 150 then %>

<img src = "images/SoldOut.jpg" border = "0" />


<% else %>

<% if SkyscraperAdCheck(monthcounter) = "on" then %>
<input type="checkbox" name="SkyscraperAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" checked>
<% else %>
<input type="checkbox" name="SkyscraperAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" unchecked>
<% end if %>
<% end if %>
</td>
<%
Monthcounter = Monthcounter + 1
wend 
 %>

<td class = "body2" align = "right">
<% = formatcurrency(TotalSkyscraperAds * (95-95*Discount/100), 2)%>
<% TotalOrder = TotalOrder + (TotalSkyscraperAds * (95- 95*Discount/100)) %>
</td>
</tr>
<% end if %>

<% showMegaads = False
if showMegaads =  True then%>
<tr>
<td class = "body" align = "left">

<a class="tooltip" href="#"><b>Mega Ad Combo!:</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Mega Ad Combo</em>The Mega Ad Combo is oustanding  marketing bonanza! It includes a <b>full-screen background ad image (1900 pixels by 900 pixel)</b> and will be seen on every page except farm pages that set their own background image. <b>Plus a 400 pixel x 75 pixel header ad.</b> And there is only one of these per month <b>(Pool of 1)</b>!</span></a>

</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$355/mo</strike>
<% else %>
<b>$355/mo</b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><%=formatcurrency(355 - 355*Discount/100,0) %>/mo</b>&nbsp;
</td>
<% end if %>
<%
monthcounter =1
currentdate = now
while Monthcounter < 14
currentdate = dateadd("m", 1, currentdate )
 %>
<td class = "body" align = "center">
<%
  MegaAdsExisting =0 	
 
Set rs = Server.CreateObject("ADODB.Recordset")
Query =  "Select AdType from Ads  where adWebsite = 'Livestock Of America' and AdMonth= '" &  Month(currentdate)  & "' and AdYear= '" & Year(currentdate)  & "' and AdType='Mega Ad Combo' and AdPaidFor=True" 
	rs.Open Query, conn, 3, 3
	while not rs.eof 
	 MegaAdsExisting = MegaAdsExisting + 1
	rs.movenext
	wend
%>
<% if MegaAdsExisting > 0 then %>

<img src = "images/SoldOut.jpg" border = "0" />


<% else %>

<% if MegaAdCheck(monthcounter) = "on" then %>
<input type="checkbox" name="MegaAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" checked>
<% else %>
<input type="checkbox" name="MegaAdCheck(<% =monthcounter%>)"   class = "checkbox" onChange="UpdateOrderForm.submit()" unchecked>
<% end if %>
<% end if %>
</td>
<%
Monthcounter = Monthcounter + 1
wend 
 %>
<td class = "body2" align = "right">
<% = formatcurrency(TotalMegaAds * (355-355*Discount/100), 2)%>
<% TotalOrder = TotalOrder + (TotalMegaAds * (355-355*Discount/100)) %>
</td>
</tr>
<% end if  %>
<% showaccountsetup = False
if showaccountsetup =  True then%>
<tr>
<td class = "body" align = "left">

<a class="tooltip" href="#"><b>Professional Account Setup:</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Professional Account Setup:</em>A one-time fee to setup your account for you. We will load up to 10 alpacas from any other internet site to your new Livestock Of America site, help you set up your graphics (logo, backgrounds, etc.), and you get a free logo ad that will run for 3 months. <br /></span>

</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$150 </strike>
<% else %>
<b><%=formatcurrency(150 - 150*Discount/100,0) %></b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><%=formatcurrency(150 - 150*Discount/100,0) %></b>
</td>
<% end if %>
</td>
<td class = "body" align = "left" colspan = "13">
<% 
if AccountSetupcount = "on" then %>
<input type="checkbox" name="AccountSetupCheck"   class = "checkbox" onChange="UpdateOrderForm.submit()" checked>
<% else %>
<input type="checkbox" name="AccountSetupCheck"   class = "checkbox" onChange="UpdateOrderForm.submit()" unchecked>
<% end if %>First 10 Alpacas + graphics + 3 month's logo ad.
</td>
<td class = "body2" align = "right">
<% = formatcurrency(TotalAccountSetup, 2)%>

</td>
</tr>
<% 
if AccountSetupcount = "on" then %>
<tr>
<td class = "body" align = "left"><img src = "imaghes/px.gif" width = "5" height = "1" /><b>Add Additional Alpacas:</b>

<a class="tooltip" href="#">

</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$99 </strike>
<% else %>
<b><%=formatcurrency(99 - 99*Discount/100,0) %></b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><%=formatcurrency(99 - 99*Discount/100,0) %></b>
</td>
<% end if %>
</td>
<td class = "body" align = "left" colspan = "13"><select name="AccountSetup2" onChange="UpdateOrderForm.submit()">
<% if AccountSetup2 > 0 then %>
 <option value="<%=AccountSetup2 %>" selected><%=AccountSetup2 %></option>
<% else %>
 <option value="0" selected>0</option>
<% end if %>
 <option value="0" >0</option>
   <option value="1">1</option>
   <option value="2">2</option>
 <option value="3">3</option>
<option value="4">4</option>
 <option value="5">5</option>
 <option value="6">6</option>
 <option value="7">7</option>
  <option value="8">8</option>
   <option value="9">9</option>
    <option value="10">10</option>
 </select> extra sets of 10 Alpacas.
</td>
<td class = "body2" align = "right">
<% = formatcurrency(TotalAccountSetup2Order, 2)%>
</td>
</tr>
<% end if %>
<% end if %>

<% showwebring = False
if showwebring=  True then%>
<tr>
<td class = "body" align = "left">

<a class="tooltip" href="#"><b>Alpaca WebRing:</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>The Alpaca WebRing</em>The WebRing is a link that shows up on the bottom of the pages on your website and all other websites within the ring. Visitors can browse through the linked websites by clicking on next, previous, and random buttons. In addition The Alpaca WebRing comes with inclusion in special link pages and web advertising which will further bring attention to your website.<br /></span>

</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$62/year</strike>
<% else %>
<b>$62/year</b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><%=formatcurrency(62 - 62*Discount/100,0) %>/year</b>
</td>
<% end if %>
</td>
<td class = "body" align = "left" colspan = "13">
<% 
if WebRingcount = "on" then %>
<input type="checkbox" name="WebRingCheck"   class = "checkbox" onChange="UpdateOrderForm.submit()" checked>
<% else %>
<input type="checkbox" name="WebRingCheck"   class = "checkbox" onChange="UpdateOrderForm.submit()" unchecked>
<% end if %>
</td>
<td class = "body2" align = "right">
<% = formatcurrency(TotalWebRingOrder, 2)%>
</td>
</tr>
<tr>
<td class = "body" align = "left">
<a class="tooltip" href="#"><b>Mass Email:</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Mass Emails</em>Mass email marketing is a reliable way for you to connect with potential customers. Our Mass Email service include:
	   <ul><li>Graphic Design.</li>
	   <li>Email Creation.</li>
	  <li>Sending and tracking to our list of <b>over 7,000 alpaca email addresses</b>.</li> 
	  </ul><br /></span>

</td>
<% if discount > 0 then %>
<td class = "body" align = "left" colspan = "1">
</td>
<% end if %>
<% if discount > 0 then %>
<td class = "body" align = "left" colspan = "14">
<% else %>
<td class = "body" align = "left" colspan = "14">
<% end if %>
 &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
<b><% if discount > 0 then %>
<strike>$150</strike> &nbsp;<b><%=formatcurrency(150 - 150 *Discount/100,0) %></b> each 
 or <strike>$140</strike> &nbsp;<b><%=formatcurrency(140 - 140*Discount/100,0) %></b> each for 3 or more<br> &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
<% else %>
<b>$150</b> each
<% end if %>

<b>Quantity (1-2):</b> <select name="Emailquantity1" onChange="UpdateOrderForm.submit()">
<% if Emailquantity1 > 0 then %>
 <option value="<%=Emailquantity1 %>" selected><%=Emailquantity1 %></option>
<% else %>
 <option value="0" selected>0</option>
<% end if %>
 <option value="0" >0</option>
   <option value="1">1</option>
   <option value="2">2</option>
 </select> 


<b>Quantity (3 or more):</b> <select name="Emailquantity2" onChange="UpdateOrderForm.submit()">
<% if Emailquantity2 > 0 then %>
 <option value="<%=Emailquantity2 %>" selected><%=Emailquantity2 %></option>
<% else %>
 <option value="0" selected>0</option>
<% end if %>
 <option value="0" >0</option>
    <option value="3">3</option>
   <option value="4">4</option>
   <option value="5">5</option>
   <option value="6">6</option>
   <option value="7">7</option>
   <option value="8">8</option>
   <option value="9">9</option>
   <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
    <option value="13">13</option>
     <option value="14">14</option>
     <option value="15">15</option>
     <option value="16">16</option>
     <option value="17">17</option>
      <option value="18">18</option>       
 </select> 
</td>
<td class = "body2" align = "right">
<% = formatcurrency(TotalEmailOrder, 2)%>
</td>
</tr>
<% end if %>


<tr>
<td class = "body" align = "left"><b>Dutch Auctions:</b>
</td>
<td class = "body2" align = "right">
<% if discount > 0 then %>
<strike>$98</strike>
<% else %>
<b>$98</b>
<% end if %>
</td>
<% if discount > 0 then %>
<td class = "body2" align = "right">
<b><big>$32!</big>&nbsp;&nbsp;</b>
</td>
<% end if %>
<td class = "body" align = "left" colspan = "13">Quantity:
<select size="1" name="DutchAuctions" onChange="UpdateOrderForm.submit()">
	<% if len(YellowDutchAuctions) > 0 then %>
		<option value="<%=YellowDutchAuctions %>" selected><%=YellowDutchAuctions %></option>
		<option value="0" >0</option>
	<% else %>
		<option value="" selected>0</option>
	<% end if  %>
		<option value="1">1</option>
		<option  value="2">2</option>
		<option  value="3">3</option>
		<option  value="4">4</option>
		<option  value="5">5</option>
		<option  value="6">6</option>
		<option  value="7">7</option>
		<option  value="8">8</option>
		<option  value="9">9</option>
		<option  value="10">10</option>
		<option  value="11">11</option>
		<option  value="12">12</option>
		<option  value="13">13</option>
		<option  value="14">14</option>
</select>
</td>
<td class = "body2" align = "right">
<% = formatcurrency(TotalYellowDutchAuctionsOrder, 2)%>
</td>
</tr>







<% if discount > 0 then %>
<tr>
<td colspan = "16" align = "right" class = "body2">
<% else %>
<td colspan = "15" align = "right" class = "body2">
<%end if %>
<b>Total Order:</b></td>
<td class = "body2" align = "right"><b><% = formatcurrency(TotalOrder)%></b>
<input name="TotalOrder" value="<%=TotalOrder %>" type = "hidden" /></td>
</tr>
<% if CurrentAccount > 0 then %>
<tr>
<% if discount > 0 then %>
<td colspan = "16" align = "right" class = "body2">
<% else %>
<td colspan = "15" align = "right" class = "body2">
<%end if %>
<%
AmountDue = TotalOrder - PayAgainstAccount
if AmountDue < 1 then
AmountDue = 0
end if %>
</td>
</td>
<td></td>
</tr>
<% end if %>


<tr><% if discount > 0 then %>
<td colspan = "16" align = "right" class = "body">

<% else %>
<td colspan = "15" align = "right" class = "body2">
<%end if %>
<% if CurrentAccount > 0 then %>
Charge to Account**:</td>
<td class = "body" align = "right" nowrap>-$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='PayAgainstAccount' size=4 maxlength=6 align = "right" Value= "<%= PayAgainstAccount %>" onChange="UpdateOrderForm.submit()"></td>
</tr>
<tr><% if discount > 0 then %>
<td colspan = "16" align = "right" class = "body">

<% else %>
<td colspan = "15" align = "right" class = "body2">
<%end if %>Amount Remaining:</td>
<td class = "body" align = "right"><b><% = formatcurrency(AmountDue)%></b></td>
</tr>
<% end if %>
<tr>
<% if discount > 0 then %>
<td class = "body2" colspan = "17" align = "right" > 
<% else %>
<td class = "body2" colspan = "15" align = "right" > 
<%end if %>
 <input type="Submit" name="Submit" value=" Update Totals " Class= "regsubmit2" >
</form>
	<% if CurrentAccount > 0 then %>
	Select the update button before checking out to make sure the amounts are correct! ->
	</td>  
		<td class = "body2"  align = "right" colspan = "2"> 
<input type="image" src="images/UpdateButton.jpg" border="0" name="submit" >
<% if AmountDue < 1 and  PayAgainstAccount > 1 then %>
<form action="MembersmakePayment.asp" method="post" target="_top">

 
<input type="hidden" name="Item_name_1" value=" Level Dutch Auctions">
<input type="hidden" name="Item_name_2" value="Blue Level Dutch Auctions">
<input type="hidden" name="Item_name_3" value="Red Level Dutch Auctions">
<input type="hidden" name="Item_name_4" value="Yellow Level Dutch Auctions">
<input type="hidden" name="quantity_1" value="<%=DutchAuctions %>">
<input type="hidden" name="quantity_2" value="<%=BlueDutchAuctions %>">
<input type="hidden" name="quantity_3" value="<%=RedDutchAuctions %>">
<input type="hidden" name="quantity_4" value="<%=YellowDutchAuctions %>">
 <input type="hidden" name="PeopleID" value="<%=PeopleID %>">
 <input type="Submit" name="Submit" value=" Checkout" Class= "regsubmit2" >
   </form>
  <% end if %>
 
<% end if %>

<% if CurrentAccount < 1 then 
AmountDue = TotalOrder
 end if %>
<% itemcount = 0
 %>

 <%
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
if DutchAuctions > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value=" Level Dutch Auctions">

 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=DutchAuctions %>">
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
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 98.75-98.75*Discount/100 %>">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity1 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 123.75-123.75*Discount/100 %>">
<% end if %>
<% else %>
<% if Emailquantity2 > 0 then %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="79">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity1 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="99">
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
<input type="hidden" name="amount_<%=itemcount %>" value="79">
<% else %>
<input type="hidden" name="amount_<%=itemcount %>" value="99">
<% end if %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="1"> 
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





<% if CurrentAccount < 1 then 
AmountDue = TotalOrder
 end if %>
<% itemcount = 0
 %>
 
 <%
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
if DutchAuctions > 0 then 
 itemcount = itemcount + 1 %>
<input type="hidden" name="item_name_<%=itemcount %>" value=" Level Dutch Auctions">

 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=DutchAuctions %>">
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
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 99-99*Discount/100 %>">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity1 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 150-150*Discount/100 %>">
<% end if %>
<% else %>
<% if Emailquantity2 > 0 then %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="99">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=Emailquantity1 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="150">
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
<input type="hidden" name="amount_<%=itemcount %>" value="<%= 150-150*Discount/100 %>">
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
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 140-140*Discount/100 %>">
<% else %> 
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=AccountSetup2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="<%= 140-140*Discount/100 %>">
<% end if %>
<% else %>
<% if AccountSetup2 > 0 then %>
 <input type="hidden" name="quantity_<%=itemcount %>" value="<%=AccountSetup2 %>">
 <input type="hidden" name="amount_<%=itemcount %>" value="140">
<% else %> 
 <input type="hidden name="quantity_<%=itemcount %>" value="<%=AccountSetup2%>">
 <input type="hidden" name="amount_<%=itemcount %>" value="140">
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
 <input type="Submit" name="Submit" value=" Checkout " Class= "regsubmit2" >
   </form>
  <% end if %>

     <input name="custom" type="hidden" id="custom" value="<%=PeopleID %>"> 
    <input type="hidden" name="return" value="http://www.AlpacaInfinity.com/Membersistration/MembersAdvertisingAdd.asp?PeopleID=<%=PeopleID %>">
<input type="hidden" name="cbt" value="Return to Livestock Of America">
<input type="hidden" name="cancel_return" value="http://www.alpacainfinity.com/Membersistration/MembersAdvertisingAdd.asp?PeopleID=<%=PeopleID %>">
<input type="hidden" name="notify_url" value="http://www.theandresengroup.com/MembersAdOrderCompletion.asp">   
<input type="image" src="images/paynow.jpg" border="0" name="submit" >
 </form>


	</td>
	</tr>
<tr>
<% if discount > 0 then %>
<td colspan = "17" align = "left" class = "body">
<% else %>
<td colspan = "16" align = "left" class = "body">
<%end if %>

<b>Graphic Design:</b> Advertising prices include 1 hour of graphic design. If you need further assistance with designing your ads, <a href = "http://www.TheAndresenGroup.com" target = "blank" class = "body">The ANDRESEN<b>GROUP</b></a> will be happy to help you at a rate of $75/hour.<br />
<b>Right to Refusal:</b> <a href = "http://www.TheAndresenGroup.com" target = "blank" class = "body">The ANDRESEN<b>GROUP</b></a> (the owners of Livestock Of America) reserve the right to refuse any advertising artwork presented for any reason including offensive language or images.<br /><br />
<% if CurrentAccount > 0 then %>
<b>* Advertising Account:</b> Sometimes you may receive credit (as a result of an Livestock Of America promotion) that can be used for advertising with Livestock Of America. This credit goes into your advertising account. <b>Funds in your Advertising Account may only be used for advertising with Livestock Of America and may not be withdrawn. Advertising Account funds are non transferable.</b><br /><br />

<b>** Negative Advertising Account Not Allowed:</b> You may not have a negative balance on your Advertising Account.
<% end if %>

</td>
</tr>
</table>
</BODY>
</HTML>