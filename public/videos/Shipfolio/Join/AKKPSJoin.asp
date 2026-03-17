<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Join Livestock Of America </title>
<META name="description" content="Join Livestock Of America. Livestock Of America is an online marketplace for horses, cattle, dogs, donkeys, goats, llamas, alpacas, pigs, and sheep.">
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% session("Goats") = True
sale = False
discount = 0 'percent

Current = "Home" 
Current3 = "JoinLOA"
RPI = request.querystring("RPI") %>
<!--#Include virtual="/Header.asp"--> 
<!--#Include virtual="/AnimalsHeader.asp"-->
<!--#Include virtual="/AboutusTabsInclude.asp"-->
<%
centerwidth = screenwidth 
tablewidth = screenwidth 
 Colwidth =(screenwidth -350)/2 %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" >
<tr>
<td width = "<%=centerwidth %>"  class = "body roundedtopandbottom" valign = "top"><img src ="Official_logo_copy_tan background.jpg" width = "403"  align = "right" alt = "Free AKKPS membership"/><br>
<H1><div align = "center">Free Livestock Of America Membership for AKKPS Members</div></H1>Our goal is to offer a fast and simple way to list your pigs for sale. 
<br><br />
<h2>Gold Membership</h2>
<ul><li>Unlimited Animal Listings</li>
<li>Unlimited Stud Listing</li>
<li>Unlimited Product Listings</li>
<li>4 Dutch Auction Listings at a Time</li>
<li>List Properties for Sale</li>
<li>List Your Business for Sale</li>
<li>Member Ranch Pages</li>
<li>1-Year Membership</li>
</ul>
<center><b>Full Price: $98 </b><br />
<big><b>Your Price: Free!</b></big>
There's no commision, no creadit card, no obligations. 
<form action= '/setupaccount.asp?Membership=goldfreetrial&RPI=<%=RPI %>' method = "post"><input type=submit value = " Sign Up! " class = "regsubmit2" ></form></center>


</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->