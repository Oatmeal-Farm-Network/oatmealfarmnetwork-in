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
<td width = "<%=centerwidth %>"  class = "body roundedtopandbottom" valign = "top"><img src ="/images/goats.jpg" width = "403" height ="422"  align = "right" alt = "Sell your  Goats"/><br>
<H1><div align = "left">Join Livestock Of America For Free</div></H1>Our goal is to offer a fast and simple way to list your goats for sale. Create a free account today and start marketing your goats. There's no commission, no credit card, no obligations.
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
<form action= '/setupaccount.asp?Membership=goldfreetrial&RPI=<%=RPI %>' method = "post"><input type=submit value = " Sign Up! " class = "regsubmit2" ></form></center>

<table  align = "center" width = "100%">
<tr><td align = "center"><img src = "/images/studs.jpg" align = 'center' width ="162" height = "48" border = "0" alt = "Stud Breedings"/></td><td class ="body" valign = "top">
<a name = "SellBreedings"></a>
<h2>Sell Your Stud Breeedings</h2>
List your stud breedings on Livestock Of America. Potential buyers can refine their search by location, breed, stud fee, and more…which makes it fast and easy for your potential customers to find your studs.
<br /><br />
</td></tr>
<tr><td align = "center"><img src = "/images/ProductsForSalegreyscale.jpg" align = 'center' width ="170" height = "170" border = "0" alt = "Products for Sale"/>
</td><td class ="body" valign = "top">
<a name = "SellProducts"></a>
<h2>Sell Your Raw Wool/Fiber & Products</h2>
We make it easy to list and sell your raw fiber/wool and finished products. Products listed on Livestock of America are seen by Animal lovers, crafters, and hobbyists all over America.
<br /><br />
</td></tr>
<tr><td align = "center" ><a href= 'Advertising.asp' target = 'blank'  align = "center"><img src = "/images/Advertisegreyscale.jpg" align = 'center' width ="170" height = "170" border = "0" alt = "Advertise"/></a></td><td class ="body" valign = "top">
<a name = "Advertise"></a>
<h2>Advertise</h2><b>It pays to advertise.</b> Get your message in front of livestock owners across North America. 
<center><a href = "/Advertising.asp" class = "body">Learn More...</a></center>
</td></tr>

<tr><td align = "center"><img src = "/images/PropertyForSalegreyscale.jpg" align = 'center' width ="170" height = "170" border = "0" alt = "Properties for Sale"/>
</td><td class ="body" valign = "top">
<a name = "SellProperties"></a>
<h2>Sell Your Properties</h2> 
Create a for sale by owner listing on LivestockOfAmerica.com. Livestock Of America markets to livestock owners across North America, which means that potential customers will find your For Sale listing while they are also checking out your animals, which results in warm lead and inspired buyers!
<br><br />
</td></tr>
<tr><td align = "center" ><img src = "/images/BusinessForSalegreyscale.jpg" align = 'center' width ="170" height = "170" border = "0" alt = "Buinsess for Sale"/>
</td><td class ="body" valign = "top">
<a name = "SellBusiness"></a>
<h2>Sell Your Business</h2>
<b>Need to go out of business?</b> You have put years into creating marketing collateral, your customer list, and creating name recognition. That has value to new people starting in your industry. Don’t just chuck it all, sell it! List your business on Livestock Of America and we will help you find potential buyers for your business.
</td></tr>
</table>



</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->