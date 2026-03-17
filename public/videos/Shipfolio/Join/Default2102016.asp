<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Join Livestock Of America</title>
<META name="description" content="Join Livestock Of America. Livestock Of America is an online marketplace for horses, cattle, dogs, donkeys, goats, chickens, turkeys, rabbits, llamas, alpacas, pigs, and sheep.">
<meta name="author" content="Livestock of America">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: infinite;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: infinite;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: infinite;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% if session("Goats") = True then
'response.redirect("GoatJoin.asp")
end if
sale = false
discount =75 'percent
AdDiscount = 0
Current = "Home" 
Current3 = "JoinLOA"
RPI = request.querystring("RPI") %>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current = "WebDesign" %>
<!--#Include virtual="/Header.asp"--> 
<% Current2 = "Testimonials" 
Current3="Join"%>
<!--#Include virtual="/AGHeader.asp"--> 
<br />
<% showWebsite = False %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  class = "body roundedtopandbottom" >
<tr><td class = 'body' colspan = 2 valign = "top">
<img src = "JoinLOAHeader.jpg" width = "100%" />

<br><a name = "memberships"></a>
<H1><div align = "left">Join Livestock Of America</div></H1>

<br /><br>
<table>
<tr><td>
<font size = 5>Gold Membership</font><font size = 3>...............................................<font size = 3><b>Free</font></b><br /><br />
5 animals listings with 1 image each, member ranch pages (includes home page, animals for sale, stud listings, products for sale, about us, & contact us pages), unlimited product & fiber listings, and classified listings.<br /><br />
<center><form action= '/setupaccount.asp?Membership=gold&RPI=<%=RPI %>' method = "post"><input type=submit value = " Join Now " class = "regsubmit2" ></form></center><br /><br />

<font size = 5>Platinum Membership</font>.........................................<font size = 3><b>$85/Year</font></b><br /><br />
Unlimited animals listings, unlimited stud listings, 8 images each, video uploads, member ranch pages (includes home page, animals for sale, stud listings, products for sale, packages, about us, & contact us pages), property listings, business listings, classifieds, packages, 4 Auctions at a time, unlimited product & fiber listings,  classified listings, and search classifieds.
<br />
<center><form action= '/setupaccount.asp?Membership=platinum&RPI=<%=RPI %>' method = "post"><input type=submit value = " Join Now " class = "regsubmit2" ></form></center>
<br /><br />


</td>
<td width = "300" class = "body roundedtopandbottom" >
<font size = 4><b>Search Classifieds</b></font></br><br>
<b>Exclusive Only to Platinum Members!</b></br><br />
Automatically display your animals right where you want them to be seen. As buyers search for the type of animals that you are selling, your animal’s classified ad will appear and make your animal stand out! For instance if you have a black suri alpaca for sale and a buyer searches for black suri alpacas your classified will be displayed prominently with a photo, name, price, stud fee (if appropriate), category, and a link to your animal. This is a great way to make your specific animals stand out right where you want them to.<br />
<br />
You don't need to anything; search classifieds are generated automatically.

</td>
</tr>
</table>


</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->