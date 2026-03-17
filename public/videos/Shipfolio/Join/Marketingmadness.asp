<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Marketing Madness</title>
<META name="description" content="Get the marketing you need to sell alpacas and meet your business needs.">
<meta name="author" content="Livestock Of America">
<link rel="stylesheet" type="text/css" href="/style.css">
<% showsale = True
if showsale = False then 
response.redirect("/join/")
end if
%>


<!--#Include Virtual="/GlobalVariables.asp"-->
<SCRIPT language=JavaScript src="/Join/gdsImageSwapping.js"></SCRIPT>
<SCRIPT language=JavaScript id=gdMouseOverScript>
<!--
    var gdsImageArray = new Array;
    gdsImageArray['Button7'] = new gdsObjImg('Button7', '/Join/CrazyAlpaca.jpg', '/Join/CrazyAlpacaOn.jpg', '/join/CrazyAlpacaOn.jpg');
//-->
</SCRIPT>


<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% session("Goats") = True
sale = False
discount = 0 'percent

Current = "Home" 
RPI = request.querystring("RPI") 
 %>
<% Current = "WebDesign" %>
<!--#Include virtual="/Header.asp"--> 
<% Current2 = "Testimonials" 
Current3 = "Discounts"%>
<!--#Include virtual="/AGHeader.asp"--> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" >
<tr>
<td width = "<%=centerwidth %>"  class = "body roundedtopandbottom" valign = "top">
<center>
<img src = 'http://www.LivestockOfAmerica.com/MassEmails/WebsiteUpgradeLogo.jpg' width = '510' height = '84' align = 'center' border = '0' /></a></center>
<br />

<table  border='0' cellspacing='0' cellpadding='0' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' align = 'center'  valign ='top' bgcolor = 'white' >
<tr><td><font size=2 color = black>Have a website that needs improvement? You can't maintain it yourself or it's old looking? We can help. Whether you want to improve your business or go out of business, a responsive, easy-to-maintain, and great looking website is a must.<br><br>

Since 2001, our team has been building websites for livestock breeders, and we can take your old website and transform it. Your new website will be 
<ul><li><b>Custom Built.</b> Your website will be created from professionally written, original programming code, not an online template, or canned tool. Your new website also will not be on another site, or redirected to another site in order to be seen. It is yours, with your ranch name as the address, and easily found through search engines. Another benefit of our custom-built websites, is that we built it, so we can always improve and add new features that you want.
</li>
<li><b>Responsive designed.</b> Your website will automatically adjust to any size screen on any device. So your website will look good on phones, tablets, and large monitors.</li>
<li><b>Yours and only yours.</b> You Own It! While we hope you will be one of our customers for life, if you decide at some point you want to move your site, you can, you own the website. The only drawback is that if you do move the site, the auto-update feature to Livestock of America will no longer work. </li>
<li><b>Include an easy-to-use (Content Management System).</b> We created from scratch a complete and robust CMS specifically for Livestock owners. It has everything you need, plus since we created it, we can customize it any way that you want. Even if you are a novice computer user you will be able to easily navigate and enter your website information. Plus all of your animal and product and animal information will auto-update to Livestock of America where your animals can be seen by 1.2 million livestock owners in North America.</li>
</ul>
<br />
With our website upgrade sale we will help elevate your existing graphic design and we will transfer all of your current information. If your website is a template with a generic design we will work with you to create a new design at 50% off our regular graphic design price.<br><br>

<a href= "/marketing/Examples.asp" class = "body" target = "blank">View examples of our work.</a><br />
<a href= "/marketing/Testimonials.asp" class = "body" target = "blank">View testimonials.</a><br /><br />

Sign up today - because you and your animals deserve a great website!</font></td></tr>

<tr><td><br /><font size=2 color = black><center><big><b>Only $299!</b></big><br /><br />


<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "blank">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="page_style" value="LivewstockOfAmerica">
<input type="hidden" name="business" value="ContactUs@Livestockofamerica.com">
<input type="hidden" name="item_name" value="Website Upgrade">
<input type="hidden" name="amount" value="299">
<input type="hidden" name="shipping" value="0.00">
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<input type="submit" class = "regsubmit2" border="0" Value="Sign Up Now and Transform Your Website" >
</center><br />


</td>
</tr>
</table>
</td>
</tr>
</table>
<!--#Include virtual="/Footer.asp"-->